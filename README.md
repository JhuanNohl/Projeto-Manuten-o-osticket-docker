# osTicket ZKTeco — Ambiente Docker (migração do XAMPP)

Migração do osTicket **v1.17.8** (que rodava no XAMPP) para **Docker Compose**,
com containers separados para aplicação (PHP 8.2 + Apache) e banco (MariaDB 10.6),
**preservando todos os dados e customizações**. O projeto está em produção interna
(chamados reais sendo abertos) e agora versionado em **Git**.

> ⚠️ **O ambiente XAMPP original NÃO foi tocado.** Tudo aqui foi feito a partir de
> *cópias*. Se algo desse errado, o XAMPP legado continuaria funcionando como estava.

---

## 1. Resumo do ambiente detectado

| Item | Valor |
|---|---|
| osTicket | v1.17.8 (fortemente customizado — ver `CUSTOMIZACOES_OSTICKET.md`) |
| PHP | 8.2 (igual ao XAMPP original) |
| Banco | MariaDB 10.6 (XAMPP usava 10.4) |
| Nome do banco | `zkteco_manutencao` |
| Usuário / prefixo | `osticket` / `ost_` |
| Charset / collation | `utf8` / `utf8_general_ci` |
| Anexos | **armazenados no banco** (backend `D`) → o dump `.sql` já contém tudo |
| Nome do projeto Docker Compose | `osticket-zkteco` (fixo — ver seção 3) |
| Acesso local | http://localhost:8080 |

> **Como confirmar o nome do banco** (caso mude no futuro): abra
> `app/include/ost-config.php` e veja `DBNAME`, `DBUSER`, `TABLE_PREFIX`.

---

## 2. Estrutura do projeto

```
<raiz-do-projeto>\
├─ app\               # Aplicação osTicket + TODAS as customizações
├─ db\
│  ├─ init\           # Dump .sql — restaurado AUTOMATICAMENTE só no 1º "up" (volume vazio)
│  ├─ migrations\     # Alterações de schema aplicadas manualmente após o dump inicial
│  └─ backups\        # Backups pontuais (pré-mudança) gerados durante o desenvolvimento
├─ backups\           # Backups gerados pelos scripts (datados)
├─ docker\            # Dockerfile + configs de Apache e PHP (assadas na imagem)
├─ scripts\           # Atalhos .bat para Windows
├─ docker-compose.yml
├─ .env               # Senhas/variáveis reais (NÃO versionar)
├─ .env.example       # Modelo sem senhas
├─ CUSTOMIZACOES_OSTICKET.md  # Log detalhado de TODA customização feita no core
└─ README.md          # Este guia
```

- **app/** — o código que você edita/customiza. Em desenvolvimento ele é
  "montado" ao vivo dentro do container (bind-mount).
- **db/init/** — qualquer `.sql` aqui é executado **na primeira vez** que o banco
  sobe (volume vazio). É assim que os dados entram no Docker. **Este arquivo é
  ignorado pelo Git** (contém dados reais de clientes) — ver seção 3.2.
- **db/migrations/** — mudanças de schema feitas à mão depois do dump inicial
  (ex.: novos menus, banner de login). Ainda não são aplicadas automaticamente
  (ver seção 13 — proposta).
- **backups/** e **db/backups/** — dumps pontuais; nenhum dos dois é versionado.
- **docker/** — receita da imagem (extensões PHP, vhost, php.ini).
- **CUSTOMIZACOES_OSTICKET.md** — histórico item a item de toda mudança feita
  no core do osTicket, essencial antes de qualquer upgrade de versão.
- Não há pasta de *uploads* separada porque **os anexos ficam no banco**.

---

## 3. Controle de versão (Git) e nome do projeto Docker

O projeto foi movido para um repositório Git. Duas coisas mudaram de
comportamento por causa disso e vale entender:

### 3.1 Nome do projeto Docker Compose agora é fixo

Por padrão, o Docker Compose deriva o "nome do projeto" (usado para nomear o
volume do banco e a rede interna) a partir do **nome da pasta**. Isso é um
problema para um repositório Git, porque qualquer pessoa pode clonar em uma
pasta com nome diferente — e o Compose criaria um volume **novo e vazio**,
"perdendo" o banco de dados (que continuaria existindo, só que órfão, sob o
nome do projeto antigo).

Por isso o `docker-compose.yml` agora tem:
```yaml
name: osticket-zkteco
```
Isso fixa o nome do projeto (e, portanto, do volume `osticket-zkteco_db_data`
e da rede `osticket-zkteco_osticket-net`) **independente de onde ou com que
nome a pasta for clonada/renomeada**. Os nomes dos containers (`osticket-app`,
`osticket-db`) já eram fixos via `container_name` e não são afetados por isso.

> Esse ajuste foi necessário justamente ao renomear a pasta do projeto para
> publicá-lo no Git (o projeto antigo, sem nome fixo, havia gerado o volume
> `new-projetomanuteno-osticket-docker_db_data`). Os dados foram migrados por
> cópia direta de arquivos para o volume novo `osticket-zkteco_db_data`; o
> volume antigo já foi removido após a confirmação de que tudo estava
> funcionando corretamente.

### 3.2 O que é ignorado pelo Git — e a lacuna que isso cria

O `.gitignore` deixa de fora `.env`, `/backups/` e `/db/init/*.sql` de
propósito (contêm senhas ou dados reais de clientes). Isso é correto para
segurança, mas tem uma consequência: **um clone novo do repositório não vem
com nenhum dump em `db/init/`**, então o banco sobe com o schema vazio na
primeira vez.

Até que isso seja automatizado (ver seção 13), para preparar um ambiente novo
a partir do zero:
1. Copie `.env.example` para `.env` e defina senhas fortes.
2. Obtenha um dump (`.sql`) de uma instância existente (seção 6 — Backup) e
   coloque-o em `db/init/` **antes** do primeiro `docker compose up`.
3. Suba o ambiente normalmente (seção 4).

---

## 4. Pré-requisitos (uma vez só)

1. **Docker Desktop + WSL2** (Windows 10/11):
   - Instale o **WSL2**: abra o **PowerShell como Administrador** e rode:
     ```powershell
     wsl --install
     ```
     Reinicie o Windows se pedir.
   - Baixe e instale o **Docker Desktop**: https://www.docker.com/products/docker-desktop/
   - Em *Settings → General*, deixe marcado **"Use the WSL 2 based engine"**.
   - Abra o Docker Desktop e espere o ícone ficar verde ("Engine running").
2. Confirme no **PowerShell**:
   ```powershell
   docker --version
   docker compose version
   ```

> 💡 **Desempenho (opcional):** bind-mount de pastas do Windows (`C:\...`) para
> dentro do WSL2 é mais lento. Para dev pesado, você pode mover o projeto para
> dentro do WSL2 (ex.: `\\wsl$\Ubuntu\home\voce\osticket-docker`).

---

## 5. Subir o ambiente (primeira vez)

> Execute no **PowerShell** ou **CMD**, dentro da raiz do projeto (onde está
> o `docker-compose.yml`). (Ou dê **duplo-clique** em `scripts\iniciar_osticket.bat`.)

```powershell
docker compose up -d --build
```

O que acontece automaticamente:
1. A imagem `app` é construída (PHP 8.2 + Apache + extensões). *(demora só na 1ª vez)*
2. O banco sobe e, por estar **vazio**, importa o que houver em `db\init\*.sql`
   (ver seção 3.2 se for um clone novo do repositório).
3. O `app` conecta no banco pelo host `db` (rede interna do Docker, nome fixo
   `osticket-zkteco_osticket-net`).

Acompanhe a restauração/subida:
```powershell
docker compose logs -f
```
Quando aparecer o banco "ready for connections" e o Apache no ar, acesse:

- **Portal do cliente:** http://localhost:8080
- **Painel da equipe:** http://localhost:8080/scp/

> A primeira importação do banco pode levar alguns segundos. Se o `app` reiniciar
> enquanto o banco ainda inicializa, é normal — o `depends_on: healthy` faz ele
> esperar; aguarde e recarregue.

---

## 6. Comandos úteis

> Todos no **PowerShell/CMD**, dentro da raiz do projeto.

| Ação | Comando | Atalho .bat |
|---|---|---|
| Subir | `docker compose up -d` | `scripts\iniciar_osticket.bat` |
| Parar (mantém dados) | `docker compose stop` | `scripts\parar_osticket.bat` |
| Reiniciar | `docker compose restart` | — |
| Derrubar (remove containers, mantém volume/dados) | `docker compose down` | — |
| Ver logs ao vivo | `docker compose logs -f` | `scripts\logs_osticket.bat` |
| Status | `docker compose ps` | — |
| Reconstruir imagem | `docker compose build --no-cache` | — |
| Abrir shell no app | `docker compose exec app bash` | — |
| Abrir o MySQL/MariaDB | `docker compose exec db mariadb -u root -p"$env:DB_ROOT_PASSWORD" zkteco_manutencao` | — |
| Backup do banco | veja seção 7 | `scripts\backup_osticket.bat` |
| Restaurar backup | veja seção 7 | `scripts\restaurar_backup.bat` |

Acessar o banco (alternativa simples, dentro do container):
```powershell
docker compose exec db bash
# dentro do container:
mariadb -u osticket -p zkteco_manutencao      # senha do .env (DB_PASSWORD)
```

---

## 7. Backup e restauração

### Backup (recomendado: rodar antes de qualquer mudança grande)
- **Fácil:** duplo-clique em `scripts\backup_osticket.bat` → gera
  `backups\backup_AAAAMMDD_HHMMSS.sql`.
- **Manual (PowerShell):**
  ```powershell
  docker compose exec -T db sh -c 'exec mariadb-dump -u root -p"$MARIADB_ROOT_PASSWORD" --single-transaction --hex-blob --default-character-set=utf8 "$MARIADB_DATABASE"' > backups\backup_manual.sql
  ```
  `--hex-blob` preserva os anexos (que estão no banco).

### Restauração
- **Fácil:** `scripts\restaurar_backup.bat` (pede o caminho e confirma).
- **Manual (PowerShell):**
  ```powershell
  docker compose exec -T db sh -c 'exec mariadb -u root -p"$MARIADB_ROOT_PASSWORD" "$MARIADB_DATABASE"' < backups\backup_AAAAMMDD_HHMMSS.sql
  ```

### Reimportar o dump inicial do zero
A pasta `db/init` só roda com o **volume vazio**. Para recomeçar limpo
(⚠️ apaga o banco do container):
```powershell
docker compose down -v        # -v remove o volume db_data
docker compose up -d          # importa de novo o db\init\*.sql
```

---

## 8. Backup completo do XAMPP (referência histórica)

O XAMPP original não é mais usado no dia a dia, mas se precisar de um snapshot
arquivado da instalação original (pré-Docker), rode no **PowerShell**:
```powershell
# Dump do banco direto do XAMPP:
& "C:\xampp\mysql\bin\mysqldump.exe" -u osticket -p123456 --single-transaction --hex-blob --default-character-set=utf8 zkteco_manutencao > backups\xampp_db_snapshot.sql

# Zip da pasta da aplicação do XAMPP:
Compress-Archive -Path "C:\xampp\htdocs\osTicket\upload\*" -DestinationPath "backups\xampp_upload_snapshot.zip" -Force
```

---

## 9. Checklist de validação

- [ ] `docker compose ps` mostra `osticket-app` e `osticket-db` como *Up* (db *healthy*).
- [ ] http://localhost:8080 abre o portal do cliente (tema ZKTeco, verde/grafite).
- [ ] http://localhost:8080/scp/ abre o login da equipe; login funciona.
- [ ] Lista de chamados aparece; abrir um chamado existente funciona.
- [ ] Anexos abrem/baixam (ex.: a Nota Fiscal XML do chamado).
- [ ] Acentos em português corretos (ç, ã, õ) nas telas e nos e-mails.
- [ ] Customizações visuais presentes (CSS ZKTeco, pop-ups, cabeçalho do chamado).
- [ ] Fluxo de equipamentos (abertura → NF → envio → confirmação) funciona ponta a ponta.
- [ ] E-mail (se configurado): teste SMTP em *Admin → Emails*; e a busca IMAP/POP.
- [ ] `docker compose logs` sem erros de PHP/Apache/banco.

> **URL do helpdesk (opcional):** o osTicket guarda a URL base no banco (usada em
> **links de e-mail**). Como agora a raiz é `http://localhost:8080/`, se quiser
> ajustar: *Painel Admin → Configurações → Sistema → Helpdesk URL*. No dia da
> produção, troque para o domínio real (ex.: `https://suporte.zkteco.com.br/`).

---

## 10. Segurança das senhas (importante)

- As senhas iniciais no `.env` **repetem as do XAMPP** só para a migração ter
  funcionado de imediato. **Antes de expor publicamente, troque todas** por
  senhas fortes:
  1. Edite `.env` (novos `DB_PASSWORD` e `DB_ROOT_PASSWORD`).
  2. A `DBPASS` do osTicket vem do `.env` (via `OST_DBPASS`) — não precisa mexer
     no `ost-config.php`.
  3. Recrie o banco com a nova senha:
     `docker compose down -v && docker compose up -d`
     (ele reimporta o `db/init` já com a senha nova).
- O `.env` está no `.gitignore` — **nunca** comite senhas.
- O `include/ost-config.php` **não tem senha fixa** (lê do ambiente).

---

## 11. Caminho para PRODUÇÃO (suporte.zkteco.com.br)

Recomendação: subdomínio **`suporte.zkteco.com.br`** dedicado (isola o helpdesk
do site institucional).

1. **Imagem autocontida (sem bind-mount):** no `docker-compose.yml` de produção,
   **comente** o volume `./app:/var/www/html`. Assim o código roda do que foi
   `COPY`-ado na imagem (mais seguro e reproduzível). Faça o build e versione a
   imagem: `docker compose build`.
2. **HTTPS/SSL:** coloque um **proxy reverso** na frente (Nginx, Traefik ou
   Caddy) terminando TLS com **Let's Encrypt**. Exemplo de bloco Nginx:
   ```nginx
   server {
     server_name suporte.zkteco.com.br;
     location / { proxy_pass http://127.0.0.1:8080;
       proxy_set_header Host $host;
       proxy_set_header X-Real-IP $remote_addr;
       proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
       proxy_set_header X-Forwarded-Proto $scheme;
     }
     # (bloco 443 com certificado do certbot)
   }
   ```
   (Traefik/Caddy fazem o certificado automaticamente — mais simples.)

   **Alternativa usada no piloto público:** colocar o domínio atrás do
   **Cloudflare** (proxy laranja ligado) em vez de um reverso próprio — o
   Cloudflare já termina o TLS na borda (modo SSL/TLS **"Full"** ou
   **"Full (strict)"**, nunca "Flexible" com HTTPS forçado, senão vira loop
   de redirecionamento) e ainda entrega o Turnstile (item 8) e o WAF/anti-DDoS
   gratuitos. Nesse caso o container continua recebendo HTTP puro na porta
   8080 (como hoje), mas com os cabeçalhos `X-Forwarded-Proto`/`X-Forwarded-For`
   do Cloudflare — é exatamente para isso que servem `TRUSTED_PROXIES` e o
   `force_https` do item 8.
3. **Helpdesk URL:** ajuste para `https://suporte.zkteco.com.br/` no painel admin.
4. **Ambientes separados:** use arquivos `.env` diferentes e, se quiser, arquivos
   compose por ambiente:
   - `docker compose --env-file .env.dev up -d`
   - `docker compose -f docker-compose.yml -f docker-compose.prod.yml up -d`
   Sugestão de fluxo: **dev** (sua máquina) → **homologação** (VM/servidor de
   testes, dados fictícios) → **produção**.
5. **Cron (importante em produção):** o osTicket precisa de tarefas periódicas
   (buscar e-mails, SLA, etc.). O "autocron" roda em acessos de página, mas o
   ideal é um cron real. Ex.: no host, a cada 5 min:
   ```
   */5 * * * * docker compose -f /caminho/docker-compose.yml exec -T app php /var/www/html/api/cron.php
   ```
6. **Backups automáticos:** agende o `backup_osticket.bat` (Agendador de Tarefas
   do Windows) ou um cron no servidor, e leve os `.sql` para fora da máquina.
7. **Boas práticas:** senhas fortes; remover `setup/` (já removido nesta cópia);
   manter Docker/imagens atualizados; **testar upgrades sempre em homologação**.
8. **CAPTCHA (Cloudflare Turnstile) + IP real atrás de proxy:**
   1. Crie um widget em <https://dash.cloudflare.com/> → **Turnstile** → *Add
      Widget* e copie a **Site Key** e a **Secret Key**.
   2. No `.env` de produção, preencha `TURNSTILE_SITE_KEY`/`TURNSTILE_SECRET_KEY`
      (vazio = CAPTCHA desligado — é assim que o dev local continua livre).
   3. Preencha `TRUSTED_PROXIES` com os ranges oficiais de IP do Cloudflare
      (IPv4 + IPv6, lista em <https://www.cloudflare.com/ips/>) — sem isso, o
      IP do visitante nos logs/rate-limit vira o IP do próprio Cloudflare.
   4. `docker compose up -d --build` (o Dockerfile passou a instalar a
      extensão `curl`, usada para validar o token do Turnstile).
   5. Em *Painel Admin → Configurações → Sistema*, marque **"Force HTTPS"**
      (`force_https`) — o core já detecta HTTPS via `X-Forwarded-Proto`, sem
      precisar de certificado dentro do container.
9. **SQL Injection:** o código customizado (`zk_equipment.php` e módulos
   ligados a ele) foi auditado — todo valor dinâmico passa por `db_input()`
   antes de qualquer `db_query()`. Ao adicionar SQL novo no projeto, siga o
   mesmo padrão (nunca concatenar `$_POST`/`$_GET` direto na query).

---

## 12. Atualizar o osTicket com segurança

1. **Backup** primeiro (`backup_osticket.bat`) e snapshot da pasta `app/`.
2. Baixe a nova versão do osTicket e **reaplique as customizações** por cima
   (elas estão documentadas em `CUSTOMIZACOES_OSTICKET.md`). Não sobrescreva
   cegamente — muitas mudanças são em arquivos core.
3. Suba com a pasta `setup/` temporariamente presente (o osTicket roda o
   assistente de upgrade do banco) **em homologação** antes de produção.
4. Valide pelo checklist (seção 9).

---

## 13. Estado atual e próximos passos (proposta)

**Onde o projeto está hoje:**
- Ambiente Docker estável, em uso real (chamados de produção sendo criados).
- Customização extensa sobre o core do osTicket (módulo próprio de múltiplos
  equipamentos por chamado, validação de Nota Fiscal XML, fluxo de
  envio/confirmação, portal do cliente redesenhado) — tudo documentado em
  `CUSTOMIZACOES_OSTICKET.md`.
- Projeto agora versionado em Git, com nome de projeto Docker fixo
  (`osticket-zkteco`) para não depender mais do nome/local da pasta.

**Lacunas conhecidas / proposta de próximos passos:**
1. **Onboarding de ambiente novo:** hoje um clone novo do repositório não traz
   um dump inicial (ver seção 3.2). Proposta: gerar um dump anonimizado (sem
   dados reais de clientes) para versionar em `db/init/`, ou documentar um
   processo de restauração a partir de um backup seguro (ex.: cofre de
   segredos da equipe).
2. **Migrations não automatizadas:** os arquivos em `db/migrations/` são
   aplicados manualmente. Proposta: adotar uma ferramenta simples de migração
   (ou um script que aplique tudo que ainda não foi marcado como aplicado) para
   evitar depender de memória/checklist manual.
3. **Testes do lado da equipe (staff/scp):** várias customizações no
   `CUSTOMIZACOES_OSTICKET.md` estão marcadas como testadas só do lado do
   cliente. Falta validação funcional completa do painel do agente.
4. **CI básico:** sem testes automatizados hoje. Um primeiro passo de baixo
   custo seria um workflow que só valida `docker compose config` e faz o build
   da imagem a cada push, pegando erros de sintaxe/Dockerfile cedo.
5. **Produção formal:** seção 11 já descreve o caminho (imagem autocontida,
   proxy reverso/TLS, cron real); ainda não foi executado — está em plano, não
   em produção externa.

---

## 14. Solução de problemas

| Sintoma | O que verificar |
|---|---|
| `app` reinicia em loop no início | Banco ainda inicializando; veja `docker compose logs db`. Aguarde o *healthy*. |
| "Unable to connect to database" | `.env` bateu com `OST_DB*`? Banco *healthy*? `docker compose logs db`. |
| Banco não importou o dump | O volume não estava vazio. Rode `docker compose down -v` e suba de novo. |
| Acentos errados | Confirme `--character-set-server=utf8` no compose e o dump em `utf8`. |
| Página em branco / erro PHP | `docker compose logs app` e `docker compose exec app tail -f /var/log/apache2/error.log`. |
| Porta 8080 ocupada | Troque `APP_PORT` no `.env` (ex.: 8090) e `docker compose up -d`. |
| Alterou CSS e não vê mudança | Cache do navegador (Ctrl+F5) e o cache-buster `?zk...` (ver `CUSTOMIZACOES_OSTICKET.md`). |
| Renomeei a pasta e o `docker compose ps` não mostra os containers antigos | Normal — o nome do projeto agora é fixo (`osticket-zkteco`, seção 3.1), então os containers/volume corretos continuam sendo usados independente da pasta. |

---

### Referência rápida de arquivos
- `docker-compose.yml` — orquestra `app` + `db`; define o nome fixo do projeto (`name: osticket-zkteco`).
- `docker/Dockerfile` — imagem PHP 8.2 + extensões do osTicket.
- `.env` — senhas/porta (não versionar) · `.env.example` — modelo.
- `db/init/*.sql` — dump inicial (restauração automática; ignorado pelo Git).
- `db/migrations/*.sql` — alterações de schema aplicadas manualmente após o dump inicial.
- `app/include/ost-config.php` — credenciais via `getenv()` (host `db`).
- `CUSTOMIZACOES_OSTICKET.md` — log completo de customizações do core.
