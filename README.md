# Central de Manutenção ZKTeco

Portal de atendimento e RMA baseado no **osTicket 1.17.8**, adaptado para acompanhar equipamentos enviados à manutenção e incorporar atendimentos do sistema anterior. Atende clientes pelo portal público e a equipe pelo painel de agentes, com cadastro, documentos, fotos, andamento dos equipamentos e notificações por e-mail.

Este documento descreve o código disponível em **18/09/2026**. O cadastro pela equipe, a migração, a troca obrigatória da senha inicial e o recebimento dos e-mails de atribuição e de acesso foram confirmados pelo responsável em produção. O encaminhamento automático e a consolidação de departamentos são uma atualização posterior: **publicar o código e aplicar a consolidação no banco são etapas separadas**.

## Funcionalidades e fluxos

### Abertura e acompanhamento pelo cliente

O cliente cadastra seus dados, acessa seus chamados e abre um RMA com um ou vários equipamentos. Cada equipamento contém modelo, número de série, falha apresentada, observação, solicitação de garantia e fotos. Na abertura, são exigidas pelo menos uma e no máximo cinco fotos por equipamento; o servidor verifica o conteúdo dos arquivos.

O RMA recebe Nota Fiscal em XML ou Declaração de Conteúdo em PDF, JPG, JPEG ou PNG. Os dois documentos podem coexistir. Anexar o XML e verificar seus dados são etapas distintas: o painel possui verificação da nota e apresenta as inconsistências encontradas, conforme as regras configuradas no projeto.

O fluxo do cliente mantém transportadora, rastreio e confirmação de envio. Após o recebimento na fábrica, o portal reconhece essa etapa e restringe a edição dos dados do equipamento conforme o andamento do chamado.

| Recurso | Operação |
|---|---|
| Andamento por equipamento | Aguardando envio, em transporte, recebido, em diagnóstico, aguardando cliente/peça, em manutenção, em testes, concluído, bloqueado ou cancelado. |
| Progresso do RMA | Calculado a partir das etapas dos equipamentos; o progresso de cada item compõe o total. |
| Garantia | O cliente solicita análise; a equipe registra aprovação ou recusa. |
| Documentação | Anexos, verificação do XML e indicação das pendências documentais. |
| Comunicação | Respostas, anexos e histórico do chamado; notificações de alterações relevantes por e-mail. |
| Consulta | Acesso aos chamados do próprio cliente e visualização do laudo disponibilizado pela equipe. |

### Abertura e manutenção pelo agente

Em **Manutenções → Novo RMA**, o agente pesquisa um cliente existente ou cadastra um cliente no próprio formulário. O cadastro utiliza os campos ativos, incluindo CPF/CNPJ, e informa erros de validação. A abertura associa o chamado ao cliente selecionado e utiliza o mesmo componente de equipamentos, fotos e documentos do portal do cliente.

A equipe pode atualizar status, garantia, laudo visível ao cliente e nota interna dos equipamentos. Também pode adicionar fotos pelo celular usando o QR Code disponibilizado no chamado. As alterações de acompanhamento ficam registradas no histórico.

O formulário do agente foi simplificado: assunto e conteúdo inicial são gerados a partir dos equipamentos; os campos redundantes de resposta inicial, assinatura e cópias foram retirados. **A abertura pelo agente não solicita envio do produto.** Essa mudança não remove o envio no formulário do cliente.

### Migração de equipamentos que já estão na fábrica

O agente marca **Migração do sistema antigo** quando o equipamento já estava em atendimento antes do novo portal. Nesse caso:

1. Seleciona ou cadastra o cliente e informa os equipamentos, fotos e documentos disponíveis.
2. Quando faltar documentação, marca explicitamente a pendência de migração; o sistema registra uma nota interna. Um arquivo inválido continua sendo recusado mesmo com essa opção marcada.
3. O equipamento inicia como **Recebido**, e o chamado assume esse status quando ele está configurado. Não é necessário inventar despacho, transportadora ou rastreio.
4. Se o cliente ainda não possuir conta de acesso, o sistema cria uma conta confirmada com senha provisória **`zkteco1234`** e exige a troca no primeiro acesso. O cliente não precisa confirmar o cadastro para começar a usar a conta.
5. O cliente recebe o aviso de atribuição do atendimento e o aviso de criação da conta, com endereço do portal, e-mail de login, senha provisória e orientação para trocá-la.

Uma conta já existente mantém sua senha. A senha provisória só aparece no aviso quando ainda é válida e a troca continua obrigatória. O procedimento não redefine a senha de quem já concluiu essa troca.

Se o envio do aviso falhar, o sistema preserva a conta e o chamado, mostra **RMA criado com pendências** e registra a falha no log. Não é necessário criar outro RMA para corrigir uma notificação.

### Encaminhamento automático para Manutenção

O grupo **Opções de encaminhamento (opcional)** deixa de ser exibido na abertura pelo agente. As definições são aplicadas no servidor:

| Informação | Regra |
|---|---|
| Departamento | **Manutenção**. |
| Plano de SLA | SLA padrão ativo configurado no sistema; a consolidação define como padrão o único SLA ativo existente. |
| Atribuído a | Agente autenticado que está abrindo o RMA. Cada agente recebe os chamados que ele próprio abre. |
| Origem do chamado | Mantida internamente como telefone para compatibilidade com o cadastro do osTicket; sem seleção no formulário. |
| Tópico de ajuda | Tópico padrão ativo, utilizado internamente. |
| Data de vencimento manual | Não solicitada; o prazo é calculado pelo SLA. |

Departamento e SLA também são aplicados aos novos chamados após as regras de filtragem, evitando que configurações antigas desviem o atendimento para outro setor. A atribuição ao agente conectado é específica da abertura pela equipe; não atribui um agente fictício ao cliente que abre seu próprio chamado.

O agente deve estar disponível e possuir as permissões de criação e atribuição em Manutenção. Configurações ausentes ou permissões insuficientes são informadas na abertura. As rotinas de cadastro, migração e envio dos e-mails permanecem separadas desse encaminhamento.

A remoção dos departamentos antigos exige a execução do utilitário de consolidação no banco. Apenas reconstruir a imagem não remove registros existentes.

## Alterações relevantes realizadas

| Área | Problema corrigido ou melhoria |
|---|---|
| Cadastro do cliente | Campo de nascimento desativado ainda era validado como obrigatório, bloqueando a criação pelo agente. A validação agora considera os campos ativos; CPF/CNPJ continua obrigatório quando configurado. |
| Formulário do RMA | Componente compartilhado entre cliente e equipe, com vários equipamentos, fotos, NF e declaração; retirada dos campos redundantes do agente. |
| Migração interna | Conta com troca obrigatória de senha, equipamento recebido, exceção documental explícita e ausência de exigência de envio pelo agente. |
| Aviso de acesso | E-mail apresenta o login, a senha inicial válida e o link do portal; falhas de envio são distinguidas de falhas na criação da conta. |
| SMTP | Após erro de conexão ou envio, a sessão defeituosa é descartada. A próxima notificação abre uma conexão nova, evitando a sequência de falhas `Cannot issue HELO to existing session`. Isso não repete automaticamente uma mensagem que o provedor recusou. |
| Editor e rascunhos | Corrigidos o CSRF do upload de imagens, a associação ao rascunho e a exibição das imagens inline. Preservado o ajuste de largura do editor do agente. |
| Arquivos e persistência | NF e declaração preservadas juntas; substituição de documento cria o novo vínculo antes de retirar o anterior. Falhas parciais são informadas com o número do RMA já criado. |
| Encaminhamento | Departamento Manutenção, SLA padrão e agente responsável definidos automaticamente na abertura pela equipe. |
| Controle de versão | Recuperação da versão validada em Git e separação da alteração de encaminhamento em uma branch própria. |

O diagnóstico, os arquivos envolvidos e os resultados detalhados dos testes anteriores estão em [Revisão de RMA, cadastro, migração e editor](docs/revisao-rma-agente-2026-09-17.md).

## Arquitetura e organização

| Componente | Configuração do projeto |
|---|---|
| Aplicação | osTicket 1.17.8 customizado, PHP 8.2 e Apache. |
| Banco | MariaDB 10.6; prefixo de tabelas `ost_`. |
| Containers | `osticket-app` e `osticket-db`. |
| Projeto Compose | `osticket-zkteco`, com nome fixo independente da pasta. |
| Volume persistente | `db_data`, normalmente identificado como `osticket-zkteco_db_data`. |
| Publicação | Traefik compartilhado, rede externa `traefik-public`, HTTPS e roteamento pelo domínio do `.env`. |
| Código no container | Copiado de `app/` para a imagem durante o build; o Compose atual não utiliza bind mount da aplicação. |
| Anexos | Backend de banco do osTicket no ambiente atual, com vínculos próprios do módulo de equipamentos. |

```text
app/                         Aplicação e customizações
  include/zk_equipment.php   Equipamentos, documentos, fotos, migração e notificações
  include/zk_rma_routing.php Encaminhamento automático
  scp/                      Painel da equipe
db/init/                    Dump inicial; importado somente com volume vazio
db/migrations/              Alterações de banco aplicadas manualmente
docker/                     Dockerfile e configurações PHP/Apache
scripts/                    Utilitários operacionais e testes isolados
docs/                       Revisões e procedimentos
docker-compose.yml          Serviços e publicação via Traefik
.env.example                Modelo de configuração, sem credenciais reais
README.md                   Funcionalidades e operação atual
```

O `.env`, os dumps iniciais, os backups e os logs ficam fora do Git. Um clone do repositório **não contém os dados do portal**. O Git recupera código e documentação; o backup do banco recupera chamados, contas, configurações e anexos.

## Operação Docker

Os comandos abaixo são para **Bash na sessão SSH do servidor**, dentro da pasta do projeto. O Compose atual já contém a configuração de produção; não depende de um arquivo `docker-compose.prod.yml` separado.

### Preparação de uma instalação nova

1. Disponibilizar Docker Engine e Docker Compose, a rede externa `traefik-public` e o Traefik utilizado pelo servidor.
2. Copiar `.env.example` para `.env`, preenchendo banco, credenciais, domínio e proxies confiáveis. Manter o `.env` restrito à administração.
3. Providenciar um dump autorizado e colocá-lo em `db/init/` **antes da primeira inicialização de um volume vazio**. O projeto não inclui um banco demonstrativo pronto para uso.
4. Conferir quais migrations de `db/migrations/` já estão no dump. Elas não são aplicadas automaticamente em bancos existentes e não devem ser reaplicadas indiscriminadamente.
5. Executar `sudo docker compose up -d --build` e conferir `sudo docker compose ps`.

O portal do cliente fica na raiz do domínio configurado; o painel da equipe, em `/scp/`. Ajustar a **URL do helpdesk** no painel administrativo para que os links dos e-mails usem o endereço correto. O Compose atual não publica `localhost:8080`; uma instalação local sem Traefik precisa de configuração própria de portas/rede.

SMTP é configurado no painel do osTicket. CAPTCHA Turnstile depende das chaves previstas no `.env`; sem essas chaves, permanece desativado. A configuração de proxies confiáveis deve corresponder à infraestrutura real. O guia complementar de publicação está em [Traefik: onboarding](traefik-onboarding-devs.md).

### Publicar alterações da aplicação

```bash
cd /docker-files/centralmanutencao
sudo docker compose build app
sudo docker compose up -d --no-deps app
sudo docker compose ps
sudo docker compose logs --tail=100 app
```

Editar os arquivos no compartilhamento não atualiza um container já construído. O build incorpora o código; o `up` recria a aplicação usando a imagem atual. Um simples `restart` não incorpora os arquivos novos.

Para pausar sem remover dados, usar `sudo docker compose stop app`; para retomar, `sudo docker compose start app`. As tarefas periódicas do osTicket podem ser executadas pelo agendador do servidor com `docker exec osticket-app php /var/www/html/api/cron.php`; conferir a configuração existente antes de criar agendamento duplicado.

### Consolidar departamentos existentes

O utilitário [zk-consolidar-manutencao.php](scripts/zk-consolidar-manutencao.php) possui **prévia sem persistência** e aplicação explícita com `--apply`. Ele exige um departamento Manutenção identificável e exatamente um SLA ativo. Redireciona vínculos e configurações dos demais departamentos antes de removê-los, preservando chamados, anexos, contas e senhas.

Executar primeiro a prévia, após copiar o script para o container:

```bash
sudo docker cp scripts/zk-consolidar-manutencao.php osticket-app:/tmp/zk-consolidar-manutencao.php
sudo docker exec osticket-app php /tmp/zk-consolidar-manutencao.php
```

A aplicação deve ocorrer com backup recente e sem gravações concorrentes da aplicação ou de tarefas agendadas. O script usa transação e cancela a operação quando encontra uma estrutura que não pode consolidar com segurança. A publicação do código **não executa esse script automaticamente**. O procedimento final de aplicação deve seguir o documento específico de consolidação entregue com esta alteração.

### Backup do banco

O backup deve incluir os anexos armazenados no banco. Para gerar um arquivo datado:

```bash
mkdir -p backups
backup_file="backups/backup_$(date +%Y%m%d_%H%M%S).sql"
sudo docker exec osticket-db sh -c 'exec mariadb-dump -uroot -p"$MARIADB_ROOT_PASSWORD" --single-transaction --hex-blob --default-character-set=utf8 "$MARIADB_DATABASE"' > "$backup_file"
test -s "$backup_file" && ls -lh "$backup_file"
```

Confirmar que o comando terminou sem erro e manter uma cópia fora do servidor. Arquivo não vazio, sozinho, não comprova um backup restaurável; validar a restauração em ambiente isolado.

### Restaurar um backup

Restaurar substitui dados do banco selecionado. Usar o arquivo conferido e manter a aplicação e os agendamentos parados durante a importação:

```bash
sudo docker compose stop app
sudo docker exec -i osticket-db sh -c 'exec mariadb -uroot -p"$MARIADB_ROOT_PASSWORD" "$MARIADB_DATABASE"' < backups/ARQUIVO_CONFERIDO.sql
# Após confirmar que a importação terminou sem erro:
sudo docker compose start app
```

Esses exemplos usam redirecionamento do Bash; não são comandos de restauração para Windows PowerShell. Não remover o volume para atualizar a aplicação, trocar credenciais ou importar um backup. As variáveis de inicialização do MariaDB não alteram automaticamente a senha de um usuário que já existe no banco.

### Limpar imagens órfãs e cache de build

```bash
sudo docker system df
sudo docker image prune -f
sudo docker builder prune -af
sudo docker system df
```

`image prune` remove imagens sem tag e sem uso; `builder prune` limpa o cache de construção não utilizado. Os comandos preservam containers e volumes, mas o próximo build pode demorar mais. Antes da limpeza, manter identificada a imagem que será usada em eventual reversão. **Não usar `docker compose down -v` nem `docker volume prune` para essa manutenção**, pois o banco depende do volume persistente.

## E-mails e diagnóstico

O painel de **Eventos do Sistema** reúne o resumo `ZK-MIGRACAO` e os erros do serviço de e-mail. Os títulos podem estar traduzidos; ao consultar o banco, um filtro somente por `Mailer` pode ocultar registros. Um erro antigo permanece no histórico mesmo após a correção; conferir data/hora e novas tentativas.

| Situação | Verificação |
|---|---|
| RMA criado com pendência de aviso | A conta e o chamado já existem. Conferir remetente, SMTP e registros do mesmo horário. |
| `Bad address syntax` | Conferir os endereços usados no envio recusado; corrigir a sessão SMTP não torna válido um endereço incorreto. |
| `Cannot issue HELO to existing session` | Conferir se a imagem publicada contém a correção em `app/include/class.mail.php`. |
| Mudança de código não aparece | Conferir branch, rebuild, recriação do container e cache do navegador. |
| Falha de banco | Conferir saúde do serviço `db`, credenciais e logs; preservar o volume existente. |
| Foto ou documento não foi salvo | Conferir o aviso do RMA e os eventos `ZK-RMA`; revisar o chamado existente antes de abrir outro. |

Para reenviar o aviso de acesso de uma conta ainda com senha provisória válida, usar o utilitário CLI abaixo. Substituir `NUMERO_RMA` pelo número exibido no portal. A primeira execução mostra a prévia; apenas a segunda solicita envio:

```bash
sudo docker cp scripts/zk-migration-mail-retry.php osticket-app:/tmp/zk-migration-mail-retry.php
sudo docker exec osticket-app php /tmp/zk-migration-mail-retry.php NUMERO_RMA
sudo docker exec osticket-app php /tmp/zk-migration-mail-retry.php NUMERO_RMA --send
```

O utilitário não cria conta ou RMA e não redefine senha. Se a senha já tiver sido trocada, a conta estiver bloqueada ou não estiver confirmada, ele recusa o reenvio das credenciais iniciais. A aceitação pelo transporte deve ser acompanhada da conferência de recebimento pelo cliente.

## Validação e limites conhecidos

Na recuperação da versão validada foram aprovadas verificações de sintaxe, cadastro, senha provisória, renderização, **18 cenários HTTP de RMA**, **23 verificações de e-mail** e **31 verificações SMTP** em ambiente isolado. Os testes cobrem documentos, fotos, vínculo ao proprietário, falhas de persistência, conteúdo das credenciais e recuperação após recusas SMTP. Nenhum e-mail externo foi enviado por esses testes. O responsável confirmou posteriormente o recebimento real dos dois avisos em produção.

Os scripts de revisão estão em `scripts/zk-rma-review.php`, `scripts/zk-rma-http-review.php`, `scripts/zk-rma-http-runner.php`, `scripts/zk-migration-mail-review.php` e `scripts/zk-migration-smtp-review.php`. Eles usam fixtures e proteções de ambiente; **não são endpoints de produção e não devem ser copiados para a pasta pública da aplicação**. A revisão específica de encaminhamento usa `scripts/zk-rma-routing-review.php`.

A alteração de encaminhamento e o utilitário de consolidação ainda precisam concluir a validação de integração desta entrega. Os resultados anteriores listados acima referem-se à versão recuperada; não comprovam a execução da nova consolidação no banco de produção.

Após publicar uma alteração, conferir no navegador:

1. Abertura por dois agentes diferentes, verificando Manutenção, SLA padrão e responsável correspondente.
2. Cliente existente e cliente novo pelo modal, com documentos e fotos.
3. Migração com equipamento recebido, login provisório, troca de senha e recebimento dos dois avisos.
4. Preservação do envio no portal do cliente e ausência desse grupo na abertura pelo agente.
5. Resposta com imagem, rascunho, anexos e consulta posterior do mesmo RMA.
6. Logs da aplicação e do portal, considerando somente os novos registros da validação.

Não existe uma transação única envolvendo cadastro, ticket, equipamentos, arquivos e notificações. Uma falha pode deixar o chamado criado com pendências; os avisos e logs permitem identificar e corrigir esse estado. A consolidação de departamentos possui sua própria transação, independente da abertura de RMA. As migrations de banco continuam manuais, e os testes isolados não substituem a homologação de navegador, proxy e provedor de e-mail.

## Controle de versão e continuidade do trabalho

O projeto já possui repositório Git local. O ponto de recuperação do fluxo validado é a branch **`recovery/rma-validado-20260917`**, commit **`44767e2`**. A alteração de encaminhamento foi separada em **`feat/rma-encaminhamento-manutencao`**.

As orientações para futuras alterações e atuação de agentes de IA estão em [AGENTS.md](AGENTS.md), incluindo preservação do fluxo validado, controle de versão e cuidados com o banco de produção.

Antes de editar, inclusive com outro agente de IA:

```bash
git status --short
git branch --show-current
git log -5 --oneline
git diff --stat
```

Preservar alterações não commitadas de outros trabalhos. Criar uma branch para cada mudança, conferir o diff e registrar somente os arquivos relacionados após a validação. Não usar `git add .` sem revisar os arquivos, nem `reset --hard` ou substituição completa da pasta para corrigir um ponto específico.

```bash
git switch -c feat/descricao-da-alteracao
git diff
git add CAMINHO_DO_ARQUIVO_REVISADO
git commit -m "Descreve a mudança e seu efeito"
```

Para desfazer uma alteração já registrada, avaliar `git revert COMMIT_DA_ALTERACAO`, preservando o histórico. Uma reversão de código exige novo build e **não reverte alterações já aplicadas ao banco**. A consolidação de departamentos, por exemplo, deve ter seu próprio backup anterior.

O Git local oferece pontos de recuperação, mas não impede que outra ferramenta modifique arquivos e não substitui cópia externa do repositório e dos backups. Mudanças no core do osTicket devem ser revisadas antes de qualquer atualização da versão original; sobrescrever `app/` com uma distribuição limpa elimina as customizações.
