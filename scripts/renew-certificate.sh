#!/usr/bin/env bash
# ============================================================================
#  Renovação MANUAL do certificado Let's Encrypt (DNS-01).
#
#  O certificado dura 90 dias. Como o desafio é manual (sem porta 80 e sem
#  API de DNS configurada), a renovação não é automática — rode este script
#  quando o certbot avisar que está perto de vencer (ele avisa por e-mail,
#  no CERTBOT_EMAIL do .env), ou agende um lembrete pra rodar a cada ~60 dias.
#
#  Uso (terminal interativo — o certbot pausa esperando você criar o
#  registro TXT no DNS):
#    chmod +x scripts/renew-certificate.sh
#    ./scripts/renew-certificate.sh
# ============================================================================
set -euo pipefail
cd "$(dirname "$0")/.."

if [ ! -f .env ]; then
  echo "Erro: .env não encontrado na raiz do projeto." >&2
  exit 1
fi

# shellcheck disable=SC1091
set -a; source .env; set +a

if [ -z "${DOMAIN:-}" ]; then
  echo "Erro: defina DOMAIN no .env" >&2
  exit 1
fi

COMPOSE="docker compose -f docker-compose.yml -f docker-compose.prod.yml"

echo "### Renovando certificado de $DOMAIN via DNS-01 (registro TXT novo) ###"
echo "    O certbot vai pedir para atualizar o registro _acme-challenge.$DOMAIN"
echo "    com um novo valor — apague o antigo (se ainda existir) e crie o novo."
echo ""

$COMPOSE run --rm certbot renew \
    --cert-name "$DOMAIN" \
    --manual --preferred-challenges dns \
    --manual-public-ip-logging-ok

echo "### Recarregando o Nginx com o certificado renovado ..."
$COMPOSE exec nginx nginx -s reload

echo "### Pronto! Certificado de $DOMAIN renovado."
