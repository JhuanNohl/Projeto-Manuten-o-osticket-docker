#!/usr/bin/env bash
# ============================================================================
#  Emissão INICIAL do certificado Let's Encrypt via desafio DNS-01 MANUAL
#  (rodar UMA VEZ, no servidor Linux de produção, antes do primeiro
#  "docker compose ... up -d" com o docker-compose.prod.yml).
#
#  Por quê DNS-01 e não HTTP-01: este servidor já tem outras coisas nas
#  portas 80/443, então não dá pra usar o desafio HTTP-01 (que exige a porta
#  80 aberta). O DNS-01 não depende de porta nenhuma — só que exige criar um
#  registro TXT no DNS do domínio, manualmente, quando o certbot pedir.
#
#  Uso (PRECISA ser rodado num terminal interativo, o certbot vai pausar
#  esperando você confirmar que criou o registro TXT):
#    chmod +x scripts/init-letsencrypt.sh
#    ./scripts/init-letsencrypt.sh
#
#  Lê DOMAIN e CERTBOT_EMAIL do .env. Requer Docker + Docker Compose no host.
# ============================================================================
set -euo pipefail
cd "$(dirname "$0")/.."

if [ ! -f .env ]; then
  echo "Erro: .env não encontrado na raiz do projeto. Copie .env.example para .env e preencha DOMAIN/CERTBOT_EMAIL." >&2
  exit 1
fi

# shellcheck disable=SC1091
set -a; source .env; set +a

if [ -z "${DOMAIN:-}" ]; then
  echo "Erro: defina DOMAIN=centralmanutencao.zkteco.com.br no .env" >&2
  exit 1
fi
if [ -z "${CERTBOT_EMAIL:-}" ]; then
  echo "Erro: defina CERTBOT_EMAIL=seu-email@dominio no .env (usado para avisos de expiração do Let's Encrypt)" >&2
  exit 1
fi

COMPOSE="docker compose -f docker-compose.yml -f docker-compose.prod.yml"
DATA_PATH="./certbot"
RSA_KEY_SIZE=4096
STAGING=${STAGING:-0}   # STAGING=1 ./scripts/init-letsencrypt.sh -> usa o ambiente de teste (sem limite de rate)

if [ -d "$DATA_PATH/conf/live/$DOMAIN" ]; then
  read -r -p "Já existe certificado para $DOMAIN em $DATA_PATH/conf/live/$DOMAIN. Sobrescrever? (s/N) " decision
  if [ "$decision" != "s" ] && [ "$decision" != "S" ]; then
    exit 0
  fi
fi

echo "### Baixando TLS params recomendados (options-ssl-nginx.conf / ssl-dhparams.pem) ..."
mkdir -p "$DATA_PATH/conf"
if [ ! -e "$DATA_PATH/conf/options-ssl-nginx.conf" ] || [ ! -e "$DATA_PATH/conf/ssl-dhparams.pem" ]; then
  curl -fsSL -o "$DATA_PATH/conf/options-ssl-nginx.conf" https://raw.githubusercontent.com/certbot/certbot/main/certbot/src/certbot/_internal/plugins/nginx/tls_configs/options-ssl-nginx.conf
  curl -fsSL -o "$DATA_PATH/conf/ssl-dhparams.pem" https://raw.githubusercontent.com/certbot/certbot/main/certbot/src/certbot/ssl-dhparams.pem
fi

STAGING_ARG=""
if [ "$STAGING" != "0" ]; then
  STAGING_ARG="--staging"
  echo "### Modo STAGING (certificado de teste, não confiável pelo navegador) ###"
fi

echo ""
echo "### Solicitando certificado ao Let's Encrypt para $DOMAIN via DNS-01 ###"
echo "    O certbot vai mostrar um valor para criar como registro TXT em:"
echo "      _acme-challenge.$DOMAIN"
echo "    Crie o registro no painel de DNS do domínio, espere propagar"
echo "    (pode levar alguns minutos) e só então confirme no prompt do certbot."
echo ""

# --manual precisa de terminal interativo (o certbot pausa esperando você
# confirmar o registro TXT) — por isso NÃO usamos --rm aqui com "-T"/pipe.
$COMPOSE run --rm certbot certonly \
    --manual --preferred-challenges dns \
    --manual-public-ip-logging-ok \
    $STAGING_ARG \
    --email "$CERTBOT_EMAIL" \
    -d "$DOMAIN" \
    --rsa-key-size "$RSA_KEY_SIZE" \
    --agree-tos

echo ""
echo "### Certificado emitido. Subindo o Nginx (porta 4040) ..."
$COMPOSE up -d nginx

echo "### Pronto! https://$DOMAIN:4040"
echo ""
echo "IMPORTANTE: este método é MANUAL — a renovação (a cada ~60-90 dias)"
echo "exige repetir o passo do registro TXT. Rode scripts/renew-certificate.sh"
echo "quando o certbot avisar que está perto de vencer (ou agende um lembrete)."
