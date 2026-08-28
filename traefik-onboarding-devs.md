# Como publicar sua aplicação através do Traefik

Este servidor usa o **Traefik** como proxy reverso único. Ele é o único serviço
que ocupa as portas **80** e **443** do host. Nenhuma outra aplicação deve
publicar essas portas diretamente — o Traefik é quem recebe o tráfego externo
e encaminha para o container certo, já cuidando de HTTPS automaticamente.

Se sua aplicação precisa ser acessada via `https://algumacoisa.zkteco.com.br`,
siga este guia.

## O que o Traefik já faz por você

- Emite e renova certificado SSL automaticamente via Let's Encrypt (sem
  precisar de certbot, sem configurar nginx com certificado manual)
- Redireciona HTTP → HTTPS automaticamente
- Aplica rate limiting básico contra flood (`rate-limit@file`)
- Roteia por hostname (`Host()`), então múltiplas aplicações dividem as
  mesmas portas 80/443 sem conflito

## Passo a passo

### 1. Não publique portas no host

No seu `docker-compose.yml`, **remova** qualquer `ports:` que mapeie pra 80,
443, ou qualquer porta que você queira expor publicamente. Sua aplicação deve
apenas `expose` a porta internamente (opcional, o Traefik nem precisa disso)
ou simplesmente escutar na porta configurada sem publicar no host.

```yaml
# ERRADO — não faça isso
ports:
  - "8080:8080"

# CERTO — deixe o Traefik cuidar do acesso externo
# (sem ports: nenhum, ou apenas 'expose' se quiser documentar a porta)
```

### 2. Conecte o container à rede `traefik-public`

Essa rede já existe no host (`docker network ls` pra confirmar). Adicione ela
ao seu serviço:

```yaml
services:
  minha-app:
    # ... resto da config ...
    networks:
      - traefik-public
      - default   # mantenha 'default' se sua app precisa falar com outros
                   # containers do mesmo compose (banco, redis, etc.)

networks:
  traefik-public:
    external: true
```

### 3. Adicione as labels do Traefik

```yaml
    labels:
      - "traefik.enable=true"
      - "traefik.http.routers.minha-app.rule=Host(`minha-app.zkteco.com.br`)"
      - "traefik.http.routers.minha-app.entrypoints=websecure"
      - "traefik.http.routers.minha-app.tls.certresolver=le"
      - "traefik.http.routers.minha-app.middlewares=rate-limit@file"
      - "traefik.http.services.minha-app.loadbalancer.server.port=PORTA_INTERNA_DA_SUA_APP"
```

Troque:
- `minha-app` (nos três lugares) pelo nome único do seu serviço — use algo
  que não colida com outros já existentes (`license`, `unms`, etc.)
- `minha-app.zkteco.com.br` pelo subdomínio que sua aplicação vai usar
- `PORTA_INTERNA_DA_SUA_APP` pela porta que sua aplicação escuta **dentro**
  do container (não a porta que você usaria no host)

### 4. Crie o registro DNS

Se o subdomínio ainda não existir, peça pro time de infra criar o registro A
apontando pro IP externo do servidor (ou confirme se o coringa `*.zkteco.com.br`
já cobre, o que normalmente já resolve sozinho).

### 5. Suba sua stack

```bash
docker compose up -d
```

Não precisa reiniciar o Traefik — ele detecta containers novos automaticamente
através das labels, assim que você sobe o container.

### 6. Valide

```bash
curl -sI https://minha-app.zkteco.com.br
```

Se vier `200`, `301`/`302` da sua aplicação, funcionou. O certificado deve
aparecer válido (emitido por Let's Encrypt) — confere com:

```bash
curl -vI https://minha-app.zkteco.com.br 2>&1 | grep -i issuer
```

## Casos especiais

### Minha aplicação já fala HTTPS internamente (certificado próprio)

Se seu container já serve HTTPS com certificado autoassinado, adicione:

```yaml
      - "traefik.http.services.minha-app.loadbalancer.server.scheme=https"
      - "traefik.http.services.minha-app.loadbalancer.serverstransport=minha-app-insecure@file"
```

E peça pro time de infra adicionar o `serversTransport` correspondente no
arquivo dinâmico do Traefik (`/docker-files/traefik/dynamic/security.yml`):

```yaml
http:
  serversTransports:
    minha-app-insecure:
      insecureSkipVerify: true
```

(Isso **não** pode ser feito só com labels Docker — é uma limitação conhecida
do Traefik. Precisa passar pelo arquivo dinâmico.)

### Preciso restringir acesso por IP (ex: aplicação interna/administrativa)

Adicione um middleware de allowlist:

```yaml
      - "traefik.http.routers.minha-app.middlewares=rate-limit@file,minha-app-ipwhitelist"
      - "traefik.http.middlewares.minha-app-ipwhitelist.ipallowlist.sourcerange=192.168.12.0/24,172.16.0.0/16"
```

⚠️ Cuidado com IPs de clientes que não são estáticos (links de operadora,
4G, etc.) — se o IP mudar, o acesso quebra até alguém atualizar a lista
manualmente. Prefira restringir por rede interna sempre que possível.

### Preciso de autenticação básica (usuário/senha) na frente da aplicação

```bash
htpasswd -nb usuario "SUA_SENHA"
```

Copia o hash gerado (ex: `usuario:$apr1$xyz...`) e usa na label, **duplicando
todos os `$` para `$$`** (o Docker Compose interpreta `$` como variável):

```yaml
      - "traefik.http.routers.minha-app.middlewares=rate-limit@file,minha-app-auth"
      - "traefik.http.middlewares.minha-app-auth.basicauth.users=usuario:$$apr1$$xyz..."
```

## Erros comuns

| Sintoma | Causa provável |
|---|---|
| `404 page not found` | Container sem label `traefik.enable=true`, ou não está na rede `traefik-public` |
| `502 Bad Gateway` | Porta interna errada no `loadbalancer.server.port`, ou app ainda não subiu |
| `503 Service Unavailable` | App crashou ou não está respondendo na porta configurada |
| Certificado não emite | Nome de domínio não resolve pro IP do servidor via DNS, ou já existe outro router usando o mesmo `Host()` |
| App já tinha `ports: 80:80` ou `443:443` | Remove — vai conflitar com o Traefik e impedir ele de subir |

## Dúvidas

Fale com o time de infraestrutura antes de:
- Criar `serversTransport` novo (precisa editar arquivo compartilhado)
- Expor o dashboard do Traefik pra qualquer coisa
- Mudar entrypoints, certresolver, ou qualquer config estática do Traefik em si
