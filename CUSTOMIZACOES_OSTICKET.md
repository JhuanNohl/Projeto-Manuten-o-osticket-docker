# Customizações do osTicket — ZKTeco do Brasil

> **Objetivo deste arquivo:** documentar TODA customização feita em cima do código-fonte "vanilla" do osTicket instalado em `C:\xampp\htdocs\osTicket\upload`, para que ao migrar para uma versão mais nova/estável do osTicket seja possível reaplicar (ou adaptar) cada mudança sem precisar redescobrir o que foi feito.
>
> Este arquivo fica fora da pasta do projeto (que pode ser reinstalada/apagada) justamente para não se perder. Na pasta do projeto há apenas um aviso apontando para cá.

- **Instalação atual (uso):** Docker Compose em `C:\osticket-docker` (app em `app/`) — migrado do XAMPP `C:\xampp\htdocs\osTicket\upload` em 2026-07-07 (ver Registro detalhado). O XAMPP legado permanece intacto como referência.
- **Versão base do osTicket:** v1.17.8
- **Ambiente:** Docker — PHP 8.2 + Apache, MariaDB 10.6 (antes: XAMPP/Windows, MariaDB 10.4). Edições de customização são feitas no app do Docker (`C:\osticket-docker\app`).
- **Responsável:** Juliano Torres / TI Financeiro ZKTeco Brasil
- **Última atualização deste documento:** 2026-07-13

---

## Como usar este documento

1. Antes de alterar qualquer arquivo do core do osTicket, registre aqui a customização (mesmo que pequena).
2. Cada entrada deve conter: **data, arquivo(s) alterado(s), motivo, o que foi mudado (trecho/diff), e como reaplicar na versão nova**.
3. Prefira, quando possível, customizações via **plugins** (`include/plugins`) ou **hooks/signals** do osTicket em vez de editar o core diretamente — isso facilita muito upgrades futuros. Quando não for possível, deixe isso explícito no registro.
4. Ao migrar de versão, percorra este arquivo item por item e marque o status: `[ ] pendente` / `[x] reaplicado` / `[-] não se aplica mais`.

---

## Índice de customizações

| Data | Arquivo(s) | Resumo | Status na versão atual |
|------|-----------|--------|-------------------------|
| 2026-07-01 | `assets/default/images/logo.png` | Logo ZKTeco no cabeçalho do portal do cliente | [x] aplicado |
| 2026-07-01 | `assets/default/css/theme.css` | Paleta de cores ZKTeco (verde/cinza) no portal do cliente | [x] aplicado |
| 2026-07-01 | Banco de dados (`ost_config`, `ost_form_entry_values`) | Nome do sistema e nome da empresa alterados para "ZKTeco do Brasil" | [x] aplicado |
| 2026-07-01 | Banco de dados (`ost_content`, id=1 "Landing") | Texto da página inicial do cliente traduzido para PT-BR | [-] substituído pela reinstalação (ver evento abaixo) |
| 2026-07-01 | `include/client/footer.inc.php` | Removido link/selo "Powered by osTicket" do rodapé do cliente | [x] aplicado (sobreviveu à reinstalação, é arquivo) |
| 2026-07-01 | **Reinstalação completa** + configuração de SMTP/IMAP (Tencent Exmail) | Banco recriado do zero; e-mail do sistema funcionando | [x] aplicado |
| 2026-07-01 | Banco (`ost_help_topic`) | Tópicos de ajuda reduzidos a um só: "Solicitação de Manutenção" | [x] aplicado |
| 2026-07-01 | `images/favicon.png` + `oscar-favicon-*` | Favicon oficial ZKTeco (aba do navegador) | [x] aplicado |
| 2026-07-01 | `assets/default/css/theme.css` (**reescrito**) + `include/client/open.inc.php` | **Redesign completo** do portal do cliente ("documento contínuo" ZKTeco) | [x] aplicado |
| 2026-07-01 | Banco (`ost_form`, `ost_form_field`, `ost_help_topic_form`, `ost_config`) | Formulário "Dados do Equipamento" (Modelo/Nº Série obrigatórios etc.) + tópico padrão | [x] aplicado |
| 2026-07-01 | `include/client/open.inc.php` + `theme.css` | Seletor de "Tópico de Ajuda" ocultado (tópico único) + enxugada de espaçamento | [x] aplicado |
| 2026-07-01 | Banco (`ost_form_field`, `ost_help_topic_form`) | Form enxuto + reordenado + campo de **Fotos** (até 2, com câmera no celular) | [x] aplicado |
| 2026-07-01 | **MÓDULO NOVO** `include/zk_equipment.php` + `scp/zk-equip.php` + tabelas `ost_zk_equipment*` + 3 mini-edits de core | **Múltiplos equipamentos por chamado** com progresso individual (cliente cadastra em massa, agente evolui item-a-item, cliente acompanha) | [x] aplicado (aguardando teste) |
| 2026-07-01 | `include/client/open.inc.php`, `include/zk_equipment.php`, `theme.css`, banco (`ost_zk_equipment_file`) | Fotos por equipamento na grade + remoção dos anexos gerais e do botão de reset | [x] aplicado |
| 2026-07-01 | `include/client/view.inc.php`, `assets/default/css/theme.css`, banco | Remoção do ticket de teste #355124, ocultação de anexos antigos e layout horizontal total | [x] aplicado |
| 2026-07-01 | `include/client/open.inc.php`, `include/zk_equipment.php`, banco (`ost_form*`) | Correção de falha de criação quando JSON da grade não vinha + acentos de formulários | [x] aplicado |
| 2026-07-01 | `include/client/open.inc.php` | Correção definitiva do erro "Não foi possível criar um chamado" (assunto/mensagem ocultos gerados a tempo, via hidden inputs no submit) | [x] aplicado e testado |
| 2026-07-01 | **NOVO** `zk-equip-edit.php` + `include/client/zk-equip-edit.inc.php` + `include/zk_equipment.php` + `include/client/view.inc.php` | Tela do cliente para **editar equipamentos** de um chamado já aberto (corrigir dado, anexar foto esquecida, adicionar item que faltou) | [x] aplicado e testado |
| 2026-07-01 | `include/zk_equipment.php`, `include/client/open.inc.php`, `include/client/zk-equip-edit.inc.php` | Miniaturas de foto, altura de linha padronizada e limite de 32 caracteres (com contador) no "Resumo do problema" | [x] aplicado e testado |
| 2026-07-01 | `include/client/tickets.inc.php` (core), `include/zk_equipment.php` | Tela "Chamados" (lista) redesenhada no padrão ZKTeco + removido filtro de Tópico de Ajuda + busca inteligente (inclui campos dos equipamentos) | [x] aplicado e testado |
| 2026-07-01 | `assets/default/css/theme.css` | Correção do "cartão flutuando" em páginas com pouco conteúdo (rodapé sempre grudado embaixo da viewport) | [x] aplicado e testado |
| 2026-07-01 | `assets/default/css/theme.css` | Cores/bordas antigas (azul/cinza de fábrica) da tabela `#ticketTable` neutralizadas — tela "Chamados" agora usa a paleta ZKTeco de fato | [x] aplicado e testado |
| 2026-07-01 | `theme.css`, `include/client/tickets.inc.php`, `include/client/view.inc.php`, `include/client/zk-equip-edit.inc.php`, `include/client/open.inc.php`, `include/zk_equipment.php` | Botões fora do padrão (`#zkEditForm`/`#reply`/`.action-button`) estilizados; linha da lista de chamados 100% clicável; contador de caracteres reposicionado; removidos "Imprimir" e "Recomeçar formulário" | [x] aplicado e testado |
| 2026-07-01 | `include/client/open.inc.php`, `include/client/zk-equip-edit.inc.php`, `include/zk_equipment.php`, banco (`ost_zk_equipment` — coluna `obs_cliente` removida) | Contador movido para a linha do cabeçalho; campos **Detalhamento** e **Observação** mesclados em um único campo "Detalhamento/Observação" (com contador, limite 200); Resumo e Detalhamento com largura igual na grade | [x] aplicado e testado |
| 2026-07-01 | `assets/default/css/theme.css` | Login e "Verificar Status do Ticket": cartão pequeno e centralizado (estilo Gmail/WordPress), só nessas 2 telas | [x] aplicado e testado |
| 2026-07-01 | `include/client/register.inc.php` (core), `include/client/view.inc.php`, `include/staff/ticket-view.inc.php` (core), `include/zk_equipment.php`, `theme.css`, banco (`ost_form_field`) | Tela de registro de conta no padrão ZKTeco; removidos Fuso Horário e Ramal; telefone virou "Telefone/WhatsApp" com máscara BR e link direto pro WhatsApp (cliente e agente) | [x] aplicado e testado (agente não visualmente testado — sem credencial de staff) |
| 2026-07-01 | `include/client/register.inc.php`, `theme.css` | Registro de conta: "Informações de Contato" e "Senha de acesso" lado a lado (2 colunas), botões sobem automaticamente | [x] aplicado e testado |
| 2026-07-01 | `include/client/profile.inc.php` (core) | Tela "Gerenciar Perfil" no mesmo padrão do registro de conta (2 colunas, sem Fuso Horário/Ramal/Recomeçar Formulário, telefone com máscara) | [x] aplicado e testado |
| 2026-07-02 | `login.php`, `include/client/login.inc.php` (core), `index.php` (core), `include/class.nav.php` (core), `include/client/header.inc.php` (core), `assets/default/css/theme.css`, banco (`ost_content` novo registro `banner-client`, `ost_config.helpdesk_title`) | Tela de login vira a única porta de entrada do portal (sem menu de navegação, sem link de agente, texto de boas-vindas reduzido, botão "Criar minha conta" em destaque); "Página Principal" removida do menu; nome do sistema ("Central de Manutenção") exibido ao lado da logo no cabeçalho | [x] aplicado e testado |
| 2026-07-02 | `account.php` (core) | Menu removido também na tela de "Criar conta" (mesmo tratamento do login); perfil de cliente já logado continua com o menu normal | [x] aplicado e testado |
| 2026-07-02 | `view.php` (core), `include/class.nav.php` (core), banco (`ost_config.clients_only=1`) | Login passa a ser **exigido de verdade** (não só escondido da tela) para abrir/acompanhar chamado — acesso direto a `open.php`/`view.php` sem login sempre cai na tela de entrada; "Verificar Status do Ticket" removida por completo | [x] aplicado e testado |
| 2026-07-02 | `assets/default/css/theme.css` | Correção: card do comentário/thread do chamado estourava a largura da página (conflito entre `width:100%` forçado e a margem de 60px que o core usa pro avatar) | [x] aplicado e testado |
| 2026-07-02 | `include/client/open.inc.php`, `include/zk_equipment.php` | Removida a importação em lote (colar do Excel/CSV) de equipamentos na abertura de chamado | [x] aplicado e testado |
| 2026-07-02 | `include/zk_equipment.php` | Foto do equipamento abre em pop-up (lightbox) na própria página em vez de nova aba do navegador | [x] aplicado e testado |
| 2026-07-02 | `assets/default/css/theme.css` | Pop-up nativo "Por favor, aguarde!" (`#loading`) recolorido para a paleta ZKTeco (borda e título verdes) | [x] aplicado e testado |
| 2026-07-02 | `include/client/open.inc.php`, `include/zk_equipment.php` | Todos os campos + pelo menos 1 foto passam a ser obrigatórios na abertura de chamado (client-side e server-side); corrigido também um travamento do pop-up "aguarde" quando a validação bloqueia o envio | [x] aplicado — pendente confirmar manualmente o caminho de sucesso com foto real |
| 2026-07-02 | Banco de dados (via `Ticket::delete()`, não SQL direto) | Os 5 chamados de teste existentes foram apagados para reiniciar os testes com a nova regra de campos obrigatórios (backup completo feito antes) | [x] concluído |
| 2026-07-02 | `include/zk_equipment.php` | Status inicial do equipamento renomeado de "Recebido" para "Aguardando" (mesma chave interna `recebido`, só o rótulo mudou) | [x] aplicado e testado |
| 2026-07-02 | Banco de dados (`ost_ticket_status`, id=1) | Status inicial do CHAMADO renomeado de "Aberto" para "Solicitado" | [x] aplicado e testado |
| 2026-07-02 | `include/zk_equipment.php`, `scp/zk-equip.php`, `include/client/tickets.inc.php`, `include/client/open.inc.php`, `include/client/zk-equip-edit.inc.php`, banco (`ost_zk_equipment.pendencia`, nova tabela `ost_zk_ticket_file`) | Campo "Pendência" por equipamento (editável pelo agente, visível no chamado e na listagem de Chamados) + Nota Fiscal (XML) como 1 anexo por CHAMADO (abrir, editar e baixar) | [x] aplicado e testado (fluxo do cliente) |
| 2026-07-02 | `include/zk_equipment.php`, `zk-equip-edit.php`, `include/client/zk-equip-edit.inc.php` | Botão para apagar a Nota Fiscal anexada; corrigido bug real onde "trocar" só acumulava (agora substitui de verdade) | [x] aplicado e testado |
| 2026-07-02 | `include/zk_equipment.php`, `zk-equip-edit.php`, `scp/zk-equip.php`, `include/client/zk-equip-edit.inc.php`, banco (`ost_zk_ticket_file.errors`) | Botão "Verificar XML" + 3 estados automáticos de Pendência (sem NF / não verificada / com erro) — valida destinatário, CFOP (5915/6915) e ausência de imposto destacado | [x] aplicado e testado (4 estados confirmados) |
| 2026-07-02 | `include/zk_equipment.php` | Correção: falso positivo de espaçamento (2 espaços) na comparação do destinatário — normalização de espaços aplicada a todos os 15 campos | [x] aplicado e testado com XML real de fornecedor |
| 2026-07-02 | `include/zk_equipment.php`, `scp/zk-equip.php` | Ícone de anexar Nota Fiscal direto no painel do chamado (cliente e agente), quando ainda não há nenhuma anexada | [x] aplicado e testado (cliente) |
| 2026-07-02 | `include/zk_equipment.php`, `zk-equip-edit.php` | Edição de equipamento pelo cliente passa a atualizar também o Assunto do chamado (título/listagem) e gera nota de histórico detalhada por campo alterado | [x] aplicado e testado |
| 2026-07-02 | `include/zk_equipment.php`, `include/class.thread.php` (core) | Card do post inicial auto-gerado ("Solicitação de manutenção com N equipamento(s)…") deixa de aparecer na thread do chamado (cliente e agente) — redundante com a grade de equipamentos; posts posteriores do cliente continuam aparecendo | [x] aplicado e testado (cliente) |
| 2026-07-02 | `include/zk_equipment.php`, `zk-equip-edit.php`, banco (nova tabela `ost_zk_ticket_envio`) | **Envio do produto**: campos Transportadora (CORREIOS / O PRÓPRIO / OUTRA) + Rastreio (só CORREIOS, obrigatório) por chamado; nasce vazio e gera a pendência automática "Envio do produto não informado" (depois da NF resolvida) | [x] aplicado e testado (cliente) |
| 2026-07-02 | `include/zk_equipment.php`, `include/client/zk-equip-edit.inc.php` | Envio do produto **só aparece com o XML da NF validado** (tela + server-side); botão de dica (?) com os dados pra emitir a NF (destinatário, CFOP, sem impostos, **Complemento**); Complemento (`xCpl`) **removido da validação** do XML | [x] aplicado e testado (cliente) |
| 2026-07-02 | `include/zk_equipment.php` | Correção: anexar NF pelo painel do chamado disparava o pop-up "Sair do site?" do navegador (aviso de alterações não salvas do core) — campos instantâneos marcados com `nowarn` + submit via jQuery | [x] aplicado e testado (cliente) |
| 2026-07-02 | `include/zk_equipment.php`, `zk-equip-edit.php`, banco (`ost_zk_ticket_envio.confirmado`) | Botão **"Confirmar envio"** + pendência **"Aguardando confirmação do envio"** (3º degrau da cascata): depois de NF validada e envio informado, o cliente confirma que despachou; confirmação trava os dados do envio e limpa a pendência | [x] aplicado e testado (lógica via CLI + botão confirmado ao vivo pelo usuário) |
| 2026-07-02 | `include/zk_equipment.php`, `include/client/view.inc.php` (core), `tickets.php` (core) | **Trava total do chamado depois do "Confirmar envio"**: produto em trânsito → cliente não altera mais NADA (equipamentos, NF/XML, envio) — some o botão Editar, somem as ações de NF, e o servidor bloqueia todas as rotas de edição; posts/respostas continuam liberados. Tela do agente (validar/solicitar/alterar) fica pro futuro | [x] aplicado e testado (lógica via CLI) |
| 2026-07-02 | `include/zk_equipment.php`, banco (`ost_ticket_status` — novo status "Enviado") | Ao confirmar o envio, o **status do chamado muda de "Solicitado" para "Enviado"** automaticamente (novo status, state=open, entre Solicitado e Resolvido) | [x] aplicado e testado |
| 2026-07-03 | `include/client/view.inc.php` (core), `assets/default/css/theme.css`, `include/client/header.inc.php` (core) | Tela do chamado: "Informações básicas" e "Informações do Usuário" **redesenhadas como cartões** ZKTeco (status vira selo colorido, rótulos sem quebra de linha, formulários extras também em cartão) + cache-buster próprio do `theme.css` | [x] aplicado e testado |
| 2026-07-03 | `include/client/view.inc.php` (core), `include/zk_equipment.php`, `assets/default/css/theme.css` | Tela do chamado 100% em cartões: painel **Equipamentos** vira cartão (só no cliente), thread vira cartão **"Mensagens"** e o formulário de resposta vira cartão **"Postar uma resposta"** | [x] aplicado e testado |
| 2026-07-03 | `include/zk_equipment.php`, `assets/default/css/theme.css` | **Nota Fiscal sai do cabeçalho** do cartão Equipamentos e vira **barra própria** (mesmo estilo da barra "Envio do produto"), com link, ações e dica — só no painel do cliente | [x] aplicado e testado |
| 2026-07-03 | `include/client/tickets.inc.php` (core), `assets/default/css/theme.css` | Lista de **Chamados vira cartão** (mesmo padrão da tela do chamado) + **status como selo colorido** na tabela (verde aberto / cinza fechado) | [x] aplicado e testado |
| 2026-07-03 | `include/zk_equipment.php`, `include/client/open.inc.php`, `include/client/tickets.inc.php`, banco (`ost_form_field` id=20 — length 50→70) | **Assunto automático inteligente para N equipamentos** ("Manutenção — 10 equipamentos: 4× SpeedFace M4, 3× MB360 +2 modelos", fonte única PHP+JS) + **sub-linha de equipamentos na listagem** ("N equipamentos · X concluídos") + ícone do nº do chamado trocado pro Font Awesome (`icon-ticket` verde) | [x] aplicado e testado |
| 2026-07-03 | `include/client/footer.inc.php` (core), `assets/default/css/theme.css` | Pop-up "Por favor, aguarde!" **sem o subtexto "vai levar um segundo!"** (promessa falsa em envios com fotos/NF); caixa encolhe e centraliza o título ao lado do spinner | [x] aplicado e testado |
| 2026-07-03 | `assets/default/css/theme.css`, `include/client/tickets.inc.php` (core) | Listagem: coluna **Assunto fluida** (ocupa todo o espaço restante da tela; o "…" só corta quando realmente não couber — antes era um teto fixo de 420px) + tooltip com o assunto completo | [x] aplicado e testado |
| 2026-07-03 | `include/zk_equipment.php`, `zk-equip-edit.php` | **Lixeira da Nota Fiscal no painel do chamado**: apaga o XML errado direto da barra da NF (com confirmação) e volta pro chamado, onde o clipe de anexar a NF correta já aparece | [x] aplicado |
| 2026-07-03 | `include/zk_equipment.php` | Erros da NF em **tabela comparativa** (Campo \| Está na NF \| Deveria estar) com nomes amigáveis dos campos ("Razão social" em vez de "xNome") — nos 3 lugares (painel do cliente, do agente e tela de editar) | [x] aplicado e testado |
| 2026-07-03 | `include/zk_equipment.php` | Validação do XML: **telefone removido das regras** (formatação de DDD gerava falso positivo) e comparação do destinatário passa a **ignorar pontuação** ("S.A" = "S.A.", CNPJ/CEP com máscara aceitos) | [x] aplicado e testado |
| 2026-07-03 | `include/zk_equipment.php`, `include/client/zk-equip-edit.inc.php` | **Verificação automática do XML no upload**: anexou, já valida — sem erro vira selo verde "XML validado" (botão Verificar some; lixeira fica pra trocar); com erro mostra tabela de erros + pendência + botões | [x] aplicado |
| 2026-07-03 | `assets/default/css/theme.css` | Listagem: coluna **Pendência alargada (230px)** e Departamento reduzido (120px) — o badge "Envio do produto não informado" estourava a borda da página; Assunto (fluido) encolhe pra compensar; badge quebra em 2 linhas se ainda faltar espaço | [x] aplicado |
| 2026-07-03 | `include/client/login.inc.php` (core), `assets/default/css/theme.css` | **Tela de login redesenhada em "split hero"**: painel de marca à esquerda (gradiente grafite→verde, anéis de biometria, proposta de valor com 4 features) + cartão de login elevado à direita (ícones nos campos, micro-interações) — primeira impressão premium pro cliente final | [x] aplicado e testado (desktop) |
| 2026-07-03 | `assets/default/css/theme.css` | **Polimento v2 das páginas logadas**: fundo do conteúdo cinza-suave com brilho verde (cartões "flutuam"), cartões com raio 12px e sombra em camadas, formulários (Abrir Ticket/Perfil/Registro/Editar) viram cartão, botões verdes com gradiente+elevação (família do "Entrar"), barra de progresso com gradiente | [x] aplicado |
| 2026-07-03 | `include/client/register.inc.php` (core), `assets/default/css/theme.css` | **Registro de conta no mesmo "split hero" do login**: painel de marca com passo a passo numerado (1 Crie a conta, 2 Abra o chamado, 3 Envie o produto) + cartão do formulário à direita; "Cancelar" volta pro login | [x] aplicado e testado |
| 2026-07-03 | `include/client/open.inc.php` | **NF removida da tela de abertura**: o cliente primeiro cadastra equipamentos/problema/fotos; o XML entra depois, pelo painel do chamado (clipe + verificação automática) — pendência "Sem nota fiscal" guia o fluxo | [x] aplicado e testado |
| 2026-07-03 | `include/zk_equipment.php` | **Guia de próximos passos no painel do chamado** (achado de teste com usuário real: clipe e select de envio pequenos demais): banner grande com o passo atual — 1 anexar NF (botão grande), 2 informar/confirmar envio (campos grandes), "tudo certo" após confirmar; barras de NF/Envio viram só informação | [x] aplicado e testado |
| 2026-07-03 | `include/zk_equipment.php` | **Correção de bug: `zk_ticket_envio` não era limpa ao apagar um ticket** — hook de exclusão esquecia a tabela de envio (transportadora/rastreio), deixando linhas órfãs | [x] aplicado e testado |
| 2026-07-03 | `assets/default/css/theme.css` | Hero (login/registro): **texto ancorado no topo com recuo fixo** em vez de centralizado — a posição ficava diferente entre telas (altura do cartão ao lado variava) e o texto "pulava" ao navegar; agora idêntico (validado por medição: Y=132/166 nas duas) | [x] aplicado e testado |
| 2026-07-03 | banco (`ost_email_template`, 6 templates do grupo padrão) | **E-mails ao cliente redesenhados com a marca ZKTeco**: cabeçalho grafite + filete verde, resposta em bloco destacado, botão "Acompanhar meu chamado", rodapé com instrução de resposta — reply, autoresp (com dica da NF), autoreply, notice, activity.notice e message.autoresp | [x] aplicado e testado (preview) |
| 2026-07-03 | `include/zk_equipment.php`, `zk-equip-edit.php`, banco (e-mail autoresp) | **Cliente final sem NF — Declaração de Conteúdo (kind='dc')**: no passo 1 do guia, link "Sou cliente final e não emito Nota Fiscal" revela anexo da Declaração (PDF/foto); com ela, o envio trava em **CORREIOS + rastreio obrigatório** (UI e server-side); badge "Cliente final" pro agente | [x] aplicado e testado (CLI 14/14) |
| 2026-07-03 | `scp/css/zkteco-scp.css` (NOVO), `include/staff/login.header.php` (core), `include/staff/header.inc.php` (core) | **Identidade ZKTeco no Painel da Equipe (SCP)**: login com fundo grafite→verde + anéis, cartão branco com a logo e botão verde; painel logado com logo ZKTeco, nav grafite/aba ativa verde, links e botões primários verdes | [x] aplicado e testado |
| 2026-07-03 | `scp/css/zkteco-scp.css` | **SCP modernizado no nível do portal do cliente**: fundo suave com brilho verde, conteúdo em cartão (raio 12 + sombra), container 960→1280px, filas como chips, tabelas limpas (sem zebra azul/amarela), abas com sublinhado verde, campos com focus verde, banners/diálogos/ficha do chamado na paleta | [x] aplicado e testado |
| 2026-07-03 | `include/zk_equipment.php` | **BUG CRÍTICO corrigido — arquivos compartilhados (dedup do osTicket)**: lixeira da NF/Declaração apagava o `ost_file` sem contar referências (matou as fotos de 2 tickets); + **blindagem `ft='Z'`** contra o `deleteOrphans()` do cron, que apagaria TODAS as fotos/NFs do módulo após 24h | [x] aplicado e testado (CLI 7/7) |
| 2026-07-03 | `scp/css/zkteco-scp.css` | **SCP v3 — largura total e fim do cinza**: app de ponta a ponta (container 960px morto de vez), cartão de conteúdo **estica até o rodapé** (cadeia de flex body→container→pjax→content), header flex com logo (largura explícita — o flex a encolhia a 0), busca das filas em dupla input+botão moderna, linha vertical fantasma do plugin de overflow eliminada | [x] aplicado e testado |
| 2026-07-03 | `scp/css/zkteco-scp.css` | **Fila de chamados com paridade visual do cliente**: ícone do ticket em FA verde (PNG morto via `::before`), **prioridade vira pílula** mantendo a cor do banco (célula pintada morta), assunto flui sem truncate de 300px, linhas respiradas, título da fila grafite+verde, busca maior | [x] aplicado e testado |
| 2026-07-03 | `include/zk_equipment.php`, `include/client/tickets.inc.php`, `include/client/view.inc.php`, banco (`ost_ticket_status` — novo status "Recebido") | **Atribuição = chegada do produto**: ao atribuir o chamado a um agente, o status muda automaticamente de "Enviado" para **"Recebido"** (novo status, state=open, entre Enviado e Resolvido); no cliente, o status vira "Recebido — *abra para ver o status por item*" (lista + tela do chamado) e o banner do guia muda pra "Produto recebido na ZKTeco" | [x] aplicado e testado (CLI 5/5 + visual) |
| 2026-07-04 | `include/zk_equipment.php`, `include/class.ticket.php` (core, patch demarcado), `scp/zk-equip.php` | **Notificações ao cliente**: toda **troca de status** do chamado dispara e-mail (layout ZKTeco, gancho no fim de `setStatus`); mudanças de **status/laudo dos equipamentos** viram **resposta na thread** (cartão Mensagens) + e-mail via template `ticket.reply` | [x] aplicado e testado (CLI + banco) |
| 2026-07-06 | Banco de dados (`ost_queue_columns`) | **Coluna "Status" nas filas do agente (SCP)**: a lista de chamados do agente não exibia o status; a fila "Aberto" mistura Solicitado/Enviado/Recebido sem distinção. Adicionada a coluna Status (catálogo `ost_queue_column` id=6, `status__id`) na 2ª posição (após o Número) em **todas as 14 filas** — agora o agente vê "Solicitado/Enviado/Recebido/Resolvido/Encerrado" igual ao cliente | [x] aplicado |
| 2026-07-06 | `include/staff/templates/thread-entries.tmpl.php` (core) | **Fim do auto-scroll ao abrir o chamado (agente)**: o osTicket, com a thread ordenada por `id` (crescente), rolava a página automaticamente até a última entrada — caindo direto no form "Publicar Resposta". `autoScroll` fixado em `false`: o chamado agora abre no topo | [x] aplicado |
| 2026-07-06 | `include/zk_equipment.php`, `scp/css/zkteco-scp.css`, `include/staff/header.inc.php` (cache-buster) | **Painel de equipamentos do agente com a cara do cliente + fim da coluna Pendência**: (1) painel do agente vira **cartão** ZKTeco e a **Nota Fiscal** sai do cabeçalho espremido e vira **barra própria** (irmã da de Envio) com selo verde **"XML validado"** — igual ao cliente; (2) **removida a coluna "Pendência"** da tabela editável do agente (pendência é conceito do cliente e é gerenciada automaticamente por `zk_sync_equip_pendencia`) | [x] aplicado e testado (visual) |
| 2026-07-06 | `include/staff/ticket-view.inc.php` (core, 3 mini-edits demarcados), `scp/css/zkteco-scp.css`, `include/staff/header.inc.php` (cache-buster) | **Fichas do topo do chamado lado a lado (agente)**: as 2 primeiras tabelas `.ticket_info` (Status/Usuário e Atribuição/Tópico) ficavam empilhadas com muito espaço vazio à direita. Envolvidas num flex `.zk-info-cols` → viram **2 colunas**, ganhando altura de tela. A ficha `.custom-data` ("Detalhes do chamado") fica fora do wrap e segue full-width | [x] aplicado e testado (visual) |
| 2026-07-06 | `include/staff/ticket-view.inc.php` (core), `include/ajax.tickets.php` (core) | **"Detalhes do chamado" some quando vazio + fim do "—Esvaziar—"**: (1) a seção de formulário dinâmico do chamado (ex.: só o campo órfão "Observações", nunca preenchido) **não é mais renderizada quando todos os campos visíveis estão vazios** (com salvaguarda: não some se houver campo obrigatório p/ fechar); (2) o placeholder de campo vazio `—Empty—`, que o pacote pt-BR traduzia **errado** como "Esvaziar", agora vira **"Vazio"** via `str_replace('Esvaziar','Vazio', __('Empty'))` (seguro por locale) | [x] aplicado e testado (visual — seção some) |
| 2026-07-06 | `scp/css/zkteco-scp.css`, `include/staff/header.inc.php` (cache-buster) | **Pop-ups e caixa "Carregando" do agente reestilizados**: o overlay de loading (`#loading`) era uma caixa cinza texturizada com texto laranja e os diálogos (`.dialog`/`#popup`) tinham a faixa de título "flutuando" com folga. Agora: overlay mais suave, "Carregando" vira **cartão branco com spinner verde**, dialog vira **cartão branco arredondado** com **cabeçalho grafite flush** + filete verde + botão fechar branco. Vale para **todos os pop-ups** do SCP (CSS global). ⚠️ Corrigido bug: `display:flex` no `#loading` travava a caixa "Carregando" para sempre — removido (ver detalhe) | [x] aplicado e testado (DOM: `#loading`=none, overflow-x=0) |
| 2026-07-06 | `scp/css/zkteco-scp.css`, `include/staff/header.inc.php` (cache-buster `?zk20260706g`) | **CONTEÚDO dos pop-ups modernizado (todos os dialogs do SCP)**: abas com ícone verde na ativa, tabela `custom-info` ("Informações de contato") com seção de filete verde e linhas suaves (fim do pontilhado preto), avatar arredondado, links verdes, campos de formulário com padrão ZK + focus verde (dialogs vivem **fora** de `#content` e estavam crus), botões maiores (8px 18px, radius 6), hr suave + hr redundante sob o título oculto, previews de hover (`.tip_content`) em cartão, e **botões destrutivos `red button` em vermelho sólido** (herdavam o gradiente VERDE do submit — "Excluir" verde!) | [x] aplicado e testado (DOM em 2 dialogs + medição de cascade) |
| 2026-07-07 | `include/staff/templates/user.tmpl.php` (core), `scp/css/zkteco-scp.css`, `include/staff/header.inc.php` (`?zk20260707a`) | **Pop-up de usuário reestruturado** (rodada 3, layout): identidade num flex `.zk-user-head` (avatar quadrado arredondado \| nome/email/org \| botão "Alterar Usuário"), abas com underline verde, ícones de ação alinhados ao título | [x] aplicado e testado (DOM + screenshot) |
| 2026-07-07 | `scp/css/zkteco-scp.css` (`?zk20260707b`) | **Pop-ups "Atualizar campo"**: `<select>` com texto cortado corrigido (`height:auto;min-height:34px`) + **datepicker jQuery UI** (`#ui-datepicker-div`) tematizado grafite/verde | [x] aplicado e testado (⚠ token "7:i am" do timepicker é bug do core, pendente à parte) |
| 2026-07-07 | `include/staff/ticket-view.inc.php` (core, reversível via `if(false)`) | **Cabeçalho do chamado enxugado (agente)**: campos Prioridade, Telefone/WhatsApp, Tópico de ajuda, Origem e Departamento ocultados (dados seguem no pop-up do usuário) | [x] aplicado e testado |
| 2026-07-07 | Banco (`ost_ticket_status`, novo id=8) | **Novo status de chamado "Em manutenção"** (state=open, mode=1, sort=4, entre Recebido e Resolvido) — 100% data-driven, aparece nos 3 seletores | [x] aplicado (falta confirmar troca real) |
| 2026-07-07 | `scp/css/zkteco-scp.css` (`?zk20260707c`) | **Botões "Recomeçar Formulário" (`type=reset`) ocultados globalmente** no SCP via CSS (evita editar ~60 templates) | [x] aplicado e testado |
| 2026-07-07 | `include/client/tickets.inc.php`, `assets/default/css/theme.css` (`?zk20260707a`) | **Área do cliente: coluna Status alargada** (100→150) + `white-space:nowrap` (badge "Em manutenção" quebrava em 2 linhas) | [x] aplicado e testado |
| 2026-07-07 | `scp/tickets.php` (core), `include/staff/templates/queue-tickets.tmpl.php` (core), `scp/css/zkteco-scp.css` (`?zk20260707d`) | **Filtro AVANÇADO INLINE na fila** (substitui o popup "Pesquisa Avançada"), reusa 100% o backend ad-hoc nativo; + correções (filtro vazio volta à fila padrão; coluna Status nos resultados) | [x] aplicado e testado (E2E; ⚠ 1 print final pendente) |
| 2026-07-07 | **Ambiente Docker** `C:\osticket-docker` (app/, db/init dump, docker/, docker-compose.yml, .env, README) | **Migração do XAMPP para Docker Compose** (dev + base p/ produção); imagem PHP 8.2+Apache autocontida (`install-php-extensions` p/ imap no bookworm); subiu e validado (77 tabelas, `:8080` HTTP 200, skin ZKTeco) | [x] migração concluída e funcionando |
| 2026-07-07 | `app/include/staff/ticket-view.inc.php` (Docker), `docker/php-osticket.ini` | **Pós-migração**: Telefone/WhatsApp clicável de volta ao cabeçalho do agente (`if($__phone)`); OPcache `revalidate_freq=0` p/ edições `.php` refletirem no bind-mount do Windows (voltar p/ 2+ em produção) | [x] aplicado e testado |
| 2026-07-07 | `scp/css/zkteco-scp.css`, `include/staff/header.inc.php` (`?zk20260707f`) | **Thread do chamado redesenhada (timeline de cartões) — agente**: cartões brancos com faixa de acento lateral por tipo (verde=resposta \| azul=mensagem \| âmbar=nota), header/anexos/abas na paleta, biquinhos removidos; + **eventos de sistema ("criado por", "alterou o estado") ocultos** e conector pontilhado removido (só CSS, reversível) | [x] aplicado e testado |
| 2026-07-07 | `include/zk_equipment.php`, `include/client/tickets.inc.php`, `assets/default/css/theme.css` (`?zk20260707b`) | **Progresso PONDERADO dos equipamentos**: cada etapa do ciclo ganha peso 0-100% (Aguardando 0 · Em análise 25 · Aguardando peça 45 · Em reparo 70 · finais 100) e o progresso do chamado vira a **média dos itens**. Barra do chamado com `%` + contagem (cliente e agente), **mini-barra por equipamento** na grade do agente (ao vivo no `<select>`) e nova **coluna "Progresso"** na listagem do cliente | [x] aplicado e testado (php -l + cálculo no banco) |
| 2026-07-07 | `assets/default/css/theme.css` (`?zk20260707c`), `include/client/header.inc.php` (cache-buster) | **Thread do cliente com o conceito do agente**: a thread "Mensagens" vira **timeline de cartões** (faixa de acento lateral: verde=equipe / azul=cliente, cabeçalho achatado, biquinhos removidos, anexos em verde) e os **eventos de sistema ("criado por", "alterou o estado…") ficam ocultos** + conector pontilhado removido. Só CSS, classes do core (`#content .thread-entry`, `#ticketThread`) | [x] aplicado e testado (CSS servido) |
| 2026-07-13 | Banco (`ost_config.default_smtp_id` = `2`) | **Correção do envio de e-mail no Docker**: cliente parou de receber e-mails após a migração XAMPP→Docker. Sem `default_smtp_id`, o osTicket caía no transporte **Sendmail** (`mail()` do PHP), que **não existe no container** (sem MTA). Apontar a conta SMTP existente (Tencent Exmail, `ssl://smtp.exmail.qq.com:465`) como SMTP padrão fez todo envio sem SMTP próprio (ex.: alertas de `alerts@zkteco.com`) usar o relay SMTP. | [x] aplicado e testado (envio real com Message-ID) |
| 2026-07-13 | Banco (`ost_department`, `ost_config.default_dept_id`, `ost_staff`, `ost_staff_dept_access`, `ost_email`) | **Sistema exclusivo de MANUTENÇÃO — remoção dos departamentos Suporte e Vendas**: excluídos os departamentos `Suporte`(1) e `Vendas`(2), sobrando só `Manutenção`(3). Antes da exclusão, tudo que os referenciava foi reapontado para Manutenção (dept padrão, dept primário do agente, roteamento dos e-mails `alerts@`/`noreply@`, acessos do agente). Backup do banco em `db/backups/`. Código não mudou (client-side já é 100% data-driven pelo tópico único). | [x] aplicado e testado |
| 2026-07-13 | Banco (`ost_email`, `ost_config.alert_email_id`) | **E-mails do sistema consolidados em `juliano.torres@zkteco.com`**: removidos os endereços **inexistentes** `alerts@zkteco.com`(id 2) e `noreply@zkteco.com`(id 3); `alert_email_id` reapontado de 2→1. Sobra só o `email_id=1` (juliano.torres@zkteco.com), que é o padrão, o de alertas e o remetente do dept Manutenção. `admin_email` (juliano.zkteco@gmail.com) **mantido** de propósito (recebedor de alertas de admin — apontá-lo para a caixa com IMAP ativo geraria loop e-mail→ticket). Backup em `db/backups/`. | [x] aplicado e testado |
| 2026-07-13 | `include/zk_equipment.php` (função `zk_equip_notify_changes`) | **BUG: cliente não recebia e-mail nas atualizações de equipamento (status/laudo)**. `Ticket::postReply` era chamado sem `reply-to`, então `getRecipients(null)` retornava `null` e o guard de envio (`$email && $recipients && ...`) falhava — a resposta era gravada na thread **sem enviar e-mail** (nenhum erro no log). Correção: passar `'reply-to' => 'all'` no `$vars` (dono + colaboradores). | [x] aplicado e testado (envio real, sem erro) |
| 2026-07-13 | `include/zk_equipment.php` (painel do agente: HTML + JS + CSS) | **Removida a barra de filtro/ação em massa dos equipamentos** (painel do agente). Sumiram: campo "Filtrar por modelo/série…", "Com selecionados: [status] + Aplicar" e a coluna de checkbox (que só servia à seleção em massa), além do JS (`.zk-check-all`, `.zk-bulk-apply`, `.zk-search`) e do CSS órfão (`.zk-bulkbar`, `.zk-bulk-group`, `.zk-bulk-status`, `.zk-c-chk`). O agente altera status/laudo linha a linha. Mantidos `.zk-toolbar`/`.zk-search` (ainda usados no painel do cliente) e a mini-barra de progresso. | [x] aplicado e testado (php -l) |
| 2026-07-13 | `include/staff/ticket-view.inc.php` (core, reversível via `if(false)`) | **Barra de ações do chamado enxugada (agente): só Imprimir + Engrenagem**. Ocultados os ícones Responder (↩), Nota (📄), Status/bandeira (🏳), Atribuir/Usuário (👤), Encaminhar (↗) e Editar (✎). Responder/Nota seguem disponíveis nas abas `#reply`/`#note` abaixo. Mantidos Imprimir (🖨) e Engrenagem/More (⚙) com seus dropdowns. | [x] aplicado e testado (php -l) |
| 2026-07-13 | `include/staff/templates/thread-entry.tmpl.php` (core, reversível via `if(false)`) | **Menu ▾ de cada entrada da thread (agente) oculto** ("Criar Chamado"/"Criar Tarefa") — o chamado é sempre criado pelo cliente. Desativado o bloco `$entry->hasActions()`. | [x] aplicado e testado (php -l) |
| 2026-07-13 | `include/staff/templates/thread-entries.tmpl.php` + `include/client/templates/thread-entries.tmpl.php` (JS) · `scp/css/zkteco-scp.css` (`?zk20260713a`) + `assets/default/css/theme.css` (`?zk20260713a`) | **Histórico da thread recolhido (agente + cliente)**: mostra só a **mensagem mais recente**; um botão "Ver histórico — N anteriores" expande/oculta as demais (eventos de sistema não contam, já eram ocultos). JS idempotente que roda a cada render (inclusive pós-pjax). | [x] aplicado e testado (php -l + CSS servido) |
| 2026-07-13 | `include/staff/ticket-view.inc.php` (core) | **Aviso "Marcado em atraso!" movido para o TOPO** (agente). O `#msg_warning` (`$warn`: atraso, atribuição, status que impede resposta) era exibido no fim, antes do form de resposta; agora aparece logo abaixo do assunto, pro agente ver de imediato. A reflexão de erro de formulário foi mantida onde estava. | [x] aplicado e testado (php -l) |
| 2026-07-13 | `include/zk_equipment.php` (painel do agente: HTML + JS) | **Filtro inteligente de equipamentos reintroduzido no painel do agente** (o mesmo do cliente). Campo "Buscar por modelo ou nº de série…" (`.zk-search` em `.zk-toolbar`) + JS `keyup` escopado a `#zk-staff-panel` que oculta linhas `tbody tr.zk-row` cujo texto não casa (busca em modelo, nº série, problema, status, laudo, nota). NÃO traz de volta a ação em massa/checkbox (removidas antes). | [x] aplicado e testado (php -l) |
| 2026-07-13 | `include/staff/ticket-view.inc.php` (core, reversível via `if(false)`) | **Aba "Publicar Nota Interna" removida** (agente). Desativados a aba (`#post-note-tab`) e o formulário (`#note`, `a=postnote`) em `#response-tabs`. Sobra só "Publicar Resposta". | [x] aplicado e testado (php -l) |
| 2026-07-13 | `include/staff/ticket-view.inc.php` (core) + `scp/css/zkteco-scp.css` (`?zk20260713b`) | **Card de ATRASO redesenhado** (agente). Texto trocado de "Marcado em atraso!" → **"ATRASADO!"**; virou card dedicado `.zk-overdue-card` (gradiente vermelho suave, filete lateral, ícone circular vermelho **pulsante**, título uppercase, subtítulo com a data de vencimento). Saiu do banner amarelo genérico `$warn`. | [x] aplicado e testado (php -l + CSS servido) |
| 2026-07-13 | `include/client/tickets.inc.php` (core) + `assets/default/css/theme.css` (`?zk20260713b`) | **Listagem do cliente: coluna "Departamento" → "Prazo (SLA)"**. Removida a coluna Departamento (sistema é só de manutenção); no lugar, a data de vencimento (`duedate` ?: `est_duedate`) com selo vermelho **"Atrasado"** quando o chamado está aberto e vencido (`isoverdue`). Campos `duedate`/`est_duedate`/`isoverdue` adicionados ao `values()` da query. | [x] aplicado e testado (php -l + CSS servido) |
| 2026-07-13 | `include/ajax.tickets.php` (core) + `include/staff/ticket-view.inc.php` (core, JS) | **Card ATRASADO atualiza na hora ao salvar a Data de Vencimento**. Antes a flag `isoverdue` só era recalculada pelo cron/monitor de SLA → o card persistia até dar F5. Agora: (servidor) ao editar `duedate` recalcula na hora via `markOverdue()`/`clearOverdue()`; (client) `MutationObserver` no `#field_duedate` recarrega a view ao salvar. | [x] aplicado e testado (php -l) |

---

## Identidade visual ZKTeco — paleta de referência

| Papel | Cor | Hex |
|---|---|---|
| Primária (links, títulos, botões) | Verde ZKTeco | `#7AC143` |
| Secundária (texto de destaque, rodapé) | Cinza-chumbo | `#474B4F` |
| Realce (hover, estados ativos) | Verde escuro | `#649E37` |
| Texto padrão | Cinza texto | `#555555` |

> Guardar essa paleta aqui evita ter que "readivinhar" as cores da marca ao recriar o tema em uma instalação nova.

---

## Registro detalhado

#### 2026-07-01 — Logo ZKTeco no portal do cliente

- **Arquivo(s) alterado(s):** `assets/default/images/logo.png` (arquivo substituído)
- **Backup do original:** `assets/default/images/logo.png.original-backup` (mantido na mesma pasta, não é lido pelo osTicket, serve só de referência)
- **Tipo:** assets do tema (pasta oficial de customização do osTicket, fora do "core")
- **Motivo/contexto:** aplicar a identidade visual da ZKTeco do Brasil na página pública de abertura/consulta de chamados.
- **O que foi feito:** o arquivo `logo.png` da pasta de assets do tema padrão (`assets/default/`) foi substituído pela logo oficial ZKTeco (versão com fundo branco/cinza, arquivo de origem: `ZKTeco_logo-assinatura_cinza.png.png`, informado pelo usuário).
- **Como funciona:** `logo.php` (raiz do projeto) primeiro tenta servir uma logo configurada via **Admin Panel → Settings → Pages → Client Logo** (guardada no banco); se não houver nenhuma configurada lá (é o caso atual), ele cai no fallback e serve o arquivo estático `assets/default/images/logo.png`. Por isso a troca do arquivo já é suficiente sem mexer no banco.
- **Dependências/impactos:** nenhum. Não altera código PHP.
- **Como reaplicar em versão nova:** copiar o arquivo `logo.png` (ou subir novo se a marca mudar) para a mesma pasta `assets/default/images/` na nova instalação. Se preferir a forma "oficial" (sem depender de fallback), pode também subir a logo via **Admin Panel → Settings → Pages → Client Logo** — mais resiliente a upgrades pois fica no banco.
- **Pendências:** favicon do navegador (`images/favicon.png`, `images/oscar-favicon-16x16.png`, `images/oscar-favicon-32x32.png`) ainda não foi trocado — está com o ícone padrão do osTicket (Oscar). Trocar depois com um recorte quadrado da logo.
- **Status:** aplicado.

---

#### 2026-07-01 — Paleta de cores ZKTeco no tema do cliente

- **Arquivo(s) alterado(s):** `assets/default/css/theme.css`
- **Backup do original:** `assets/default/css/theme.css.original-backup`
- **Tipo:** assets do tema (arquivo carregado via `include/client/header.inc.php`, separado do CSS "core" `css/osticket.css`)
- **Motivo/contexto:** substituir a paleta azul/genérica padrão do osTicket pelas cores oficiais ZKTeco.
- **O que foi feito (resumo dos trechos alterados):**
  ```diff
  /* Texto padrão do corpo */
  - color: #000;
  + color: #555555;

  /* Links */
  - a, .link { color: #0072bc; }
  - a:hover, .link:hover { border-bottom: 1px dotted #0072bc; }
  + a, .link { color: #7AC143; }
  + a:hover, .link:hover { border-bottom: 1px dotted #649E37; }

  /* Título principal (h1) */
  - h1 { color: #00AEEF; }
  + h1 { color: #7AC143; }

  /* Subtítulos (h2, .subject) */
  - h2, .subject { color: black; }
  + h2, .subject { color: #474B4F; }

  /* Botão azul padrão -> vira botão principal ZKTeco */
  - .blue.button, .blue.button:visited { background-color: #00AEEF; }
  - .blue.button:hover { background-color: #0299d2; }
  + .blue.button, .blue.button:visited { background-color: #7AC143; }
  + .blue.button:hover { background-color: #649E37; }

  /* Cabeçalho: faixa verde no topo */
  #header {
  +  border-top: 4px solid #7AC143;
  }

  /* Menu de navegação (hover/ativo) */
  - #nav li a.active, #nav li a:hover { background-color: #dbefff; }
  - #nav li a:hover { color: #0054a6; }
  + #nav li a.active, #nav li a:hover { background-color: #e8f4dd; }
  + #nav li a:hover { color: #649E37; }

  /* Ícone de categoria em destaque (base de conhecimento) */
  - .featured-category i { color: rgba(0,174,239, 0.8); }
  + .featured-category i { color: rgba(122,193,67, 0.85); }

  /* Rodapé */
  - #footer, #footer a { color: #333; }
  + #footer, #footer a { color: #474B4F; }

  /* Cabeçalho da tabela de tickets */
  - #ticketTable th { background: #e1f2ff; }
  + #ticketTable th { background: #eef6e6; }

  /* Tabela de informações (ex.: detalhes do ticket) */
  - .infoTable { background: #F4FAFF; }
  + .infoTable { background: #F2F8ED; }
  ```
- **Dependências/impactos:** puramente visual (CSS), não afeta lógica/PHP. `theme.min.css` (versão minificada) **não** é usada pelo cabeçalho atual (`header.inc.php` carrega `theme.css` sem minificação) — não precisou ser regerado.
- **Como reaplicar em versão nova:** copiar o arquivo inteiro `assets/default/css/theme.css` customizado para a nova instalação (mais simples), OU reaplicar cada trecho do diff acima em cima do `theme.css` novo da versão atualizada, caso o osTicket novo já tenha mudado esse arquivo de base.
- **Status:** aplicado.

---

#### 2026-07-01 — Nome do sistema e da empresa

- **Onde foi alterado:** banco de dados MySQL (`zkteco_manutencao`), não são arquivos de código.
  - Tabela `ost_config`, chave `helpdesk_title` (namespace `core`): `ZKTeco_Manutencao` → `ZKTeco do Brasil`
  - Tabela `ost_form_entry_values` (campo "Company Name" do formulário de empresa, `object_type='C'`): `ZKTeco_Manutencao` → `ZKTeco do Brasil`
- **Tipo:** configuração via banco (equivalente ao que seria feito manualmente em **Admin Panel → Settings → Company**).
- **Motivo/contexto:** o título do sistema (aba do navegador, cabeçalho) e o nome da empresa (usado no rodapé — "Copyright © 2026 ZKTeco do Brasil") precisavam refletir a marca.
- **Como reaplicar em versão nova:** **não precisa mexer em banco/SQL na versão nova.** Basta configurar pela tela normal: **Admin Panel (SCP) → Settings → Company → Helpdesk Title / Company Name**. Isso é dado de configuração, migra junto se o banco for reaproveitado; se for banco novo, é só preencher esses dois campos na tela.
- **Status:** aplicado.

---

#### 2026-07-01 — Tradução do texto de boas-vindas da página inicial (cliente)

- **Onde foi alterado:** banco de dados MySQL (`zkteco_manutencao`), tabela `ost_content`, registro `id=1` (`type='landing'`, nome interno "Landing"). Não é um arquivo de código nem um arquivo de idioma.
- **Motivo/contexto:** o texto padrão de instalação vem em inglês ("Welcome to the Support Center..."); pedido para traduzir para português.
- **O que foi feito:**
  ```diff
  - <h1>Welcome to the Support Center</h1>
  - <p> In order to streamline support requests and better serve you, we utilize a
  -  support ticket system. Every support request is assigned a unique ticket number
  -  which you can use to track the progress and responses online. For your reference
  -  we provide complete archives and history of all your support requests. A valid
  -  email address is required to submit a ticket. </p>
  + <h1>Bem-vindo à Central de Suporte ZKTeco</h1>
  + <p> Para agilizar o atendimento e servir você melhor, utilizamos um sistema de
  +  tickets de suporte. Cada solicitação recebe um número único de ticket que pode
  +  ser usado para acompanhar o andamento e as respostas online. Para sua referência,
  +  disponibilizamos o arquivo e o histórico completo de todas as suas solicitações
  +  de suporte. É necessário um endereço de e-mail válido para enviar um ticket. </p>
  ```
- **Como reaplicar em versão nova:** **não precisa mexer em SQL na versão nova.** Esse conteúdo é editável pela tela: **Admin Panel (SCP) → Manage → Pages → "Landing Page"** (ou "Landing" / página inicial). Basta colar o texto em português acima.
- **Outras páginas de conteúdo que ainda estão em inglês (padrão de instalação), candidatas a tradução futura, mesma tabela `ost_content`:** "Thank You" (id=2, pós-abertura de ticket), "Offline" (id=3, sistema fora do ar), "Sign in to %{company.name}" (id=9, banner de login do cliente). Ainda não traduzidas — ficou fora do escopo desta rodada.
- **Status:** aplicado (apenas a página inicial).

---

#### 2026-07-01 — Remoção do "Powered by osTicket" no rodapé do cliente

- **Arquivo(s) alterado(s):** `include/client/footer.inc.php`
- **Backup do original:** `include/client/footer.inc.php.original-backup`
- **Tipo:** core (arquivo de template PHP do portal do cliente — **este é o único item até agora que mexe em arquivo do "core"**, os demais usam a pasta de assets do tema ou configurações via banco).
- **Motivo/contexto:** pedido para tirar o selo "Powered by osTicket" da tela do cliente.
- **Base legal:** osTicket é distribuído sob **GPLv2**. A licença exige preservar avisos de copyright/licença nos arquivos de **código-fonte** quando redistribuídos, mas não obriga exibir a marca "powered by" na interface para uso interno da empresa. Remoção é segura neste contexto (uso interno, não redistribuição do software).
- **O que foi feito:**
  ```diff
    <p>Copyright &copy; 2026 ZKTeco do Brasil - All rights reserved.</p>
  -  <a id="poweredBy" href="https://osticket.com" target="_blank">Helpdesk software - powered by osTicket</a>
    </div>
  ```
- **Dependências/impactos:** a regra CSS `#footer #poweredBy` em `assets/default/css/theme.css` ficou "órfã" (não quebra nada, só não é mais usada) — pode ser limpa depois, sem urgência.
- **Como reaplicar em versão nova:** localizar `include/client/footer.inc.php` na versão nova e remover a mesma linha `<a id="poweredBy" ...>`. Como é edição de core, **confirmar se a estrutura do arquivo mudou** entre versões antes de aplicar o diff cegamente.
- **Status:** aplicado.

---

#### 2026-07-01 — Reinstalação completa + configuração de e-mail (SMTP/IMAP) funcionando

- **Contexto/motivo:** o e-mail de ativação de contas de cliente não estava sendo enviado. Diagnóstico completo (ver histórico de mensagens desta sessão para detalhes passo a passo):
  1. O PHP local (XAMPP) tentava enviar e-mail via `mail()`/Sendmail local, que **sempre falha** para domínios externos (`553 We do not relay non-local mail, sorry`) — XAMPP não tem um servidor de e-mail real configurado.
  2. Configuramos SMTP real da ZKTeco (**Tencent Exmail**), mas o servidor recusou o envio com o erro `mail from address must be same as authorization user` — o Exmail **exige que o remetente (From) seja exatamente igual à conta autenticada no SMTP**.
  3. Isso gerou um conflito: o e-mail de sistema (`suporte.brasil@zkteco.com`) não podia ser autenticado com a conta pessoal do Juliano (`juliano.torres@zkteco.com`), e o osTicket **não deixa** usar o mesmo e-mail como conta de sistema E como login de agente/admin ao mesmo tempo ("Email in use by an agent").
  4. Decisão: reinstalar o osTicket do zero, dessa vez usando **e-mails diferentes** para o login de administrador e para o e-mail de sistema — eliminando o conflito.
- **Backup do banco antigo (pré-reinstalação):** [`backups/zkteco_manutencao_backup_2026-07-01.sql`](./backups/zkteco_manutencao_backup_2026-07-01.sql) — dump completo do banco `zkteco_manutencao` antes de apagar, caso precise recuperar algo (usuários de teste, tickets de teste etc.). Gerado com `mysqldump`.
- **O que foi feito na reinstalação:**
  - Banco `zkteco_manutencao` apagado e recriado vazio (`DROP DATABASE` + `CREATE DATABASE ... CHARACTER SET utf8mb4`).
  - `include/ost-config.php` removido temporariamente (guardado como `include/ost-config.php.pre-reinstall-backup`) para permitir rodar `setup/install.php` de novo — esse arquivo sempre marca a instalação como "OSTINSTALLED=TRUE", então precisa sair do caminho para o instalador rodar.
  - Instalador rodado via navegador em `http://localhost/osticket/upload/setup/install.php`.
  - **Login de administrador/agente:** `julianotorres` / `juliano.zkteco@gmail.com` (conta pessoal do Gmail, usada só para logar no painel).
  - **E-mail padrão do sistema ("Support"):** `juliano.torres@zkteco.com` — **diferente** do login acima, exatamente para não colidir com a regra do osTicket.
  - **Nome do Helpdesk / Empresa:** `ZKTeco - Manutenção` (definido durante o instalador — se quiser trocar para "ZKTeco do Brasil" de novo, é só em **Admin Panel → Configurações → Empresa**).
- **Configuração de e-mail que funcionou (Tencent Exmail):**
  - **Remote Mailbox (IMAP, recebimento):** Host `imap.exmail.qq.com`, Porta `993`, Protocolo `IMAP`, Pasta `INBOX`, Autenticação Basic com usuário `juliano.torres@zkteco.com`.
  - **Outgoing (SMTP, envio):** Host `ssl://smtp.exmail.qq.com` (o prefixo `ssl://` é necessário porque a porta 465 é "não padrão" para o osTicket detectar sozinho), Porta `465`, Autenticação **Basic Authentication (Legacy)** com usuário/senha `juliano.torres@zkteco.com`.
  - **Confirmado funcionando:** e-mail de ativação de conta de cliente chegou corretamente na caixa de entrada, com remetente "Support" e sem nenhum erro em `ost_syslog`.
- **Pegadinhas de UI encontradas nessa tela (Admin Panel → E-mails → e-mail → Outgoing/Remote Mailbox), para não perder tempo de novo:**
  1. **Ordem de salvamento importa:** preencher Host/Porta/Protocolo e clicar em **Salvar Alterações** primeiro, ANTES de abrir o popup de "Configuração" da autenticação — se abrir o popup antes, ele reclama "PROTOCOL Obrigatório" mesmo com os campos preenchidos na tela (fica em loop).
  2. Porta não-padrão (ex.: `465` para SMTP) precisa do prefixo de esquema no campo Host: `ssl://smtp.exmail.qq.com` (ou `tls://` para STARTTLS). Sem isso, a detecção automática de criptografia pode falhar.
  3. Depois de configurar a autenticação, é preciso lembrar de marcar **Status: Habilitado** e salvar de novo — o formulário deixa salvar host/credenciais com o e-mail ainda desabilitado, o que não ativa o envio (e não dá nenhum aviso claro disso).
  4. **A senha da autenticação SMTP é uma credencial separada da senha do Remote Mailbox (IMAP)**, mesmo sendo a mesma conta de e-mail — precisa configurar (e digitar a senha) nas duas abas.
- **Como reaplicar em versão nova:** essa configuração de e-mail é 100% feita pela tela do Admin Panel (não envolve arquivo nem SQL direto), então basta repetir os passos acima em **Admin Panel → E-mails** na instalação nova, usando os mesmos hosts/portas do Exmail.
- **Pendência real, fora do controle do osTicket:** se um dia quiserem voltar a usar `suporte.brasil@zkteco.com` como remetente oficial (em vez do e-mail pessoal do Juliano), será necessário um de dois caminhos com o administrador do domínio Exmail:
  - (a) conceder permissão de **"enviar como" (send-as/delegação)** de `suporte.brasil@zkteco.com` para a conta usada na autenticação; ou
  - (b) obter a senha real da caixa `suporte.brasil@zkteco.com` e autenticar diretamente com ela (From = usuário autenticado, sem necessidade de delegação).
- **Status:** aplicado e testado com sucesso (e-mail de ativação recebido).

---

#### 2026-07-01 — Simplificação dos Tópicos de Ajuda (Help Topics)

- **Onde foi alterado:** banco de dados, tabela `ost_help_topic` (equivalente a **Admin Panel → Gerenciar → Tópicos de Ajuda**).
- **Motivo/contexto:** o sistema é dedicado **exclusivamente a manutenção de equipamentos ZKTeco**. Os tópicos padrão de instalação ("Questões gerais", "Relate um problema", "Relate um problema / Problema de acesso", "Resposta") não fazem sentido para esse uso e confundiam o cliente na abertura de chamado.
- **O que foi feito:**
  - Tópico `id=1` ("Questões gerais") **renomeado** para **"Solicitação de Manutenção"** e vinculado ao departamento **"Manutenção"** (`dept_id=3`) — reaproveitado em vez de criado do zero para não quebrar o ticket de teste `#148501` que já usava esse `topic_id`.
  - Tópicos `id=2` ("Resposta"), `id=10` ("Relate um problema") e `id=11` ("Problema de acesso", subtópico do anterior) **excluídos**.
  - Resultado: cliente vê **um único tópico obrigatório** ao abrir chamado: "Solicitação de Manutenção".
- **Como reaplicar em versão nova:** **não precisa de SQL.** Pela tela: **Admin Panel → Gerenciar → Tópicos de Ajuda** → editar/excluir os tópicos padrão e deixar só o(s) relevante(s) para manutenção. Mais simples ainda: no próprio instalador, ao rodar `setup/install.php`, dá pra já pular a criação dos tópicos padrão de exemplo, se essa opção existir na versão nova.
- **Se no futuro quiser separar por tipo de manutenção** (ex.: Corretiva, Preventiva, Instalação/Configuração), é só criar novos tópicos em **Gerenciar → Tópicos de Ajuda** apontando pro departamento "Manutenção" — ficou registrado aqui como ideia descartada nesta rodada (optou-se por um único tópico simples).
- **Status:** aplicado.

---

#### 2026-07-01 — Favicon ZKTeco (ícone da aba do navegador)

- **Arquivo(s) alterado(s):** `images/oscar-favicon-32x32.png`, `images/oscar-favicon-16x16.png`, `images/favicon.png` (pasta `images/` na raiz do projeto, usada tanto pelo portal do cliente quanto pelo painel da equipe/SCP).
- **Backup dos originais:** mesmos nomes com sufixo `.original-backup` na mesma pasta.
- **Tipo:** arquivo estático (não é core PHP, sem risco de quebrar em upgrade — só precisa copiar os arquivos de novo).
- **Motivo/contexto:** trocar o ícone padrão do osTicket (o "Oscar", mascote do projeto) pelo favicon oficial da ZKTeco.
- **O que foi feito:** baixado diretamente de `https://www.zkteco.com.br/` (arquivos `cropped-Favicon-ZK_..._-32x32.png` e `..._-192x192.png`, referenciados no `<head>` do site oficial) e usado para substituir os três arquivos acima. Como não há ferramenta de redimensionamento de imagem disponível no ambiente (sem ImageMagick/GD), o arquivo de 32x32 foi reaproveitado também para o slot de 16x16 — o navegador redimensiona sem problema perceptível nesse tamanho de ícone.
- **Como reaplicar em versão nova:** copiar os 3 arquivos (`oscar-favicon-32x32.png`, `oscar-favicon-16x16.png`, `favicon.png`) para a pasta `images/` da instalação nova. Se quiser qualidade melhor no 16x16, gerar um recorte próprio em 16x16 com um editor de imagem, em vez de reaproveitar o de 32x32.
- **Status:** aplicado (portal do cliente e painel da equipe).

---

#### 2026-07-01 — Redesenho do layout geral do portal do cliente (largura, cabeçalho, formulários)

- **Arquivo(s) alterado(s):** `assets/default/css/theme.css` (mesmo arquivo de tema, só CSS — nenhum arquivo PHP/core tocado).
- **Motivo/contexto:** o layout padrão do osTicket é uma caixa fixa e estreita de **840px** centralizada, com sombra ao redor — visual datado ("amador"). Pedido para modernizar e aproveitar melhor o espaço da tela.
- **O que foi feito:**
  - **Container principal:** trocado de largura fixa `840px` para `width:100%; max-width:1200px` — se adapta à tela, mas sem esticar o texto por um monitor ultrawide inteiro (ruim para leitura).
  - **Cabeçalho e menu de navegação:** agora se estendem **de ponta a ponta da janela do navegador** (técnica de CSS "full-bleed" com `100vw` + margens negativas), mesmo com o conteúdo central limitado a 1200px — dá a sensação de um site atual em vez de uma caixinha centralizada antiga.
  - **Menu de navegação:** fundo escuro (`#474B4F`, cor secundária ZKTeco) com links claros e destaque verde (`#7AC143`) no hover/ativo, em vez do cinza claro padrão do osTicket.
  - **Conteúdo e rodapé:** espaçamento lateral proporcional à tela (`5vw`) em vez de margem fixa de 20px.
  - **Página inicial (`index.php`):** a coluna de conteúdo principal (`.main-content`, antes fixa em 565px) virou fluida (`width:auto` com `margin-right:260px` para não invadir a barra lateral), evitando um vão vazio grande à direita com o container mais largo.
  - **Formulário "Abrir Novo Ticket" e Login (`#ticketForm`, `#clientLogin`):** a tabela HTML nativa do osTicket (herdada do core, não alterada) foi reestilizada via CSS para parecer um formulário moderno: linhas espaçadas, rótulos (Email/Cliente) em negrito na cor secundária, campos de texto/select com borda arredondada e destaque verde ao focar, botões em formato "pill" com a cor primária ZKTeco.
- **Dependências/impactos:** só visual. Não muda nenhum arquivo PHP/core — o HTML da tabela do formulário continua sendo gerado pelo `include/client/open.inc.php` original do osTicket, só a aparência mudou via CSS.
- **Como reaplicar em versão nova:** copiar o `assets/default/css/theme.css` inteiro (mais simples) ou reaplicar os blocos de código acima (procurar por `#container`, `#header`, `#nav`, `.main-content` e o bloco final comentado `/* ZKTeco — formulários do cliente */`) em cima do `theme.css` da versão nova.
- **Status:** aplicado — pendente de conferência visual do usuário.

**Revisão 2 (mesmo dia):** a primeira versão deixava o cabeçalho/menu de ponta a ponta, mas o conteúdo ficava numa "caixa branca" menor flutuando sobre um fundo cinza — ficou com uma quebra visual estranha ("caixa boiando"). Corrigido para: página inteira branca e de ponta a ponta.

**⚠️ SUPERSEDIDO pela Revisão 3 abaixo.** As revisões 1 e 2 foram reprovadas pelo usuário ("amador", "feio", espaçamento ruim dos campos, desconexão cabeçalho/corpo). Todo o `theme.css` foi **reescrito do zero** — ver a entrada "Redesign completo (Revisão 3)". Os blocos de CSS descritos nas revisões 1 e 2 **não existem mais** no arquivo atual; não tente reaplicá-los.

---

#### 2026-07-01 — Redesign completo do portal do cliente (Revisão 3 — versão definitiva)

- **Arquivo(s) alterado(s):**
  - `assets/default/css/theme.css` — **reescrito**: restaurada a base pristina do osTicket e anexada UMA camada oficial "ZKTeco" ao final (bloco delimitado por `/* CAMADA OFICIAL ZKTeco */` … `/* ===== FIM DA CAMADA ZKTECO ===== */`).
  - `include/client/open.inc.php` — bloco read-only do solicitante, título/subtítulo e alinhamento dos botões.
- **Backups:**
  - `assets/default/css/theme.css.original-backup` — base pristina do osTicket (antes de qualquer edição).
  - `assets/default/css/theme.css.pre-redesign-backup` — estado das revisões 1/2 (reprovadas), por segurança.
  - `include/client/open.inc.php.original-backup`.
- **Por que reescrever:** as revisões 1 e 2 (edições incrementais) foram reprovadas ("amador/feio", espaçamento ruim dos campos, "falha/desconexão entre cabeçalho e corpo"). Optou-se por refazer do zero.
- **Como a solução foi escolhida (processo):** rodou-se um **painel de design** (orquestração multi-agente): 3 direções de layout independentes foram geradas e depois julgadas de forma adversarial por 3 juízes (critérios: coesão/modernidade, qualidade de espaçamento, adequação ao propósito, implementabilidade no HTML real de tabela do osTicket, e aderência à marca). Venceu por unanimidade a direção **"Ficha corporativa densa" (estética de ferramenta de TI)**, por ser a única que neutraliza TODAS as regras reais do core que causavam os problemas.
- **Conceito visual final:** cabeçalho + navegação + corpo + rodapé formam **um "documento" contínuo** — uma faixa branca central de largura `--zk-col` (1100px) com bordas laterais contínuas, sobre um fundo cinza muito claro (`#f5f7f4`). Não há mais "caixa flutuando" (sem sombra/cantos arredondados soltos). Barra verde ZKTeco no topo, menu grafite (`#474B4F`) com aba ativa/hover verde e filete verde inferior, títulos com filete verde à esquerda.
- **Como o problema do espaçamento foi resolvido (o ponto central):**
  - A causa era o `<table width="800">` do osTicket, onde as linhas read-only (Email/Cliente) usavam 2 colunas (rótulo ~170px | valor) → vão horizontal enorme; enquanto os campos do formulário usam `colspan=2` (full-width). Inconsistência = visual quebrado.
  - Solução CSS: `#ticketForm > table`, `tbody`, `tr` e `td` recebem `display:block` + `width:auto !important` (escopado **apenas** em `#ticketForm > table`), transformando a tabela numa pilha vertical full-width uniforme. Também anula `table-layout:fixed`, o `textarea{width:600px}` do core, o `float:left` dos campos, etc.
  - As linhas "Email:/Cliente:" foram substituídas em `open.inc.php` por uma **ficha `<dl class="zk-client-meta">`** (dt/dd) que o CSS renderiza como **Grid de 2 colunas** (`max-content 1fr`, gap fixo 8px/16px) — rótulo estreito + valor colado, **sem vão**.
- **Edições em `open.inc.php` (core do cliente):**
  1. Bloco read-only (cliente logado) trocado pelas 3 `<tr>` antigas por uma única `<tr><td colspan="2">` com o `<dl class="zk-client-meta">` (Solicitante + Email). O e-mail agora passa por `Format::htmlchars()` (antes era impresso sem escape — pequena melhoria de segurança).
  2. Título/subtítulo: `Open a New Ticket` → `Abrir Novo Chamado de Manutenção`; subtítulo reescrito para o contexto de manutenção ZKTeco.
  3. Removido o `style="text-align:center"` inline da barra de botões (agora alinhados à esquerda pelo CSS).
- **Escopo/efeitos colaterais (verificado):** todas as regras de formulário estão escopadas em `#ticketForm`/`#clientLogin`; as tabelas de listagem (`#ticketTable`), a thread (`#ticketThread`, `.thread-entry`) e a base de conhecimento (`#kb`,`#faq`) **não** são achatadas (o `display:block` é restrito a `#ticketForm > table`, filho direto). `#content #ticketTable/.thread-entry/#ticketThread` recebem `max-width:none` para não ficarem estreitos. Login (`#clientLogin`) teve o `display:table-row/table-cell` inline neutralizado. `select2` recebe `width:100%`. Ícones PNG do menu foram removidos de propósito (visual denso/limpo) — para trazê-los de volta, não sobrescrever `background-image` em `#nav li a.home/.new/.tickets`.
- **Como reaplicar em versão nova:** copiar o `theme.css` inteiro (mais simples), OU: partir do `theme.css` novo do osTicket e colar o bloco delimitado `/* CAMADA OFICIAL ZKTeco */ … /* FIM DA CAMADA ZKTECO */` ao final dele. Reaplicar as 3 edições de `open.inc.php` (conferir antes se a estrutura do arquivo mudou na versão nova). A camada usa CSS variables (`:root{--zk-*}`) — para ajustar largura/cores no futuro, basta editar esses tokens no topo do bloco (ex.: `--zk-col` para a largura da faixa).
- **Status:** aplicado — pendente de conferência visual do usuário (Revisão 3).

---

#### 2026-07-01 — Formulário "Dados do Equipamento" na abertura do chamado

- **Onde foi alterado:** banco de dados (formulários dinâmicos do osTicket). **Nenhum arquivo de código** — é 100% configuração, equivalente a fazer por **Admin Panel → Gerenciar → Formulários** e **→ Tópicos de Ajuda**.
- **Motivo/contexto:** ao abrir uma solicitação de manutenção, o cliente precisava informar no mínimo **Modelo** e **Número de Série** do equipamento (pedido do usuário; hoje esses dados chegam por um formulário RMA à parte no site).
- **O que foi criado:**
  - Novo formulário customizado `ost_form` id=7, `type='G'`, título **"Dados do Equipamento"** (o título vira o cabeçalho da seção na tela; as instruções aparecem abaixo).
  - Campos (`ost_form_field`, form_id=7):
    | Campo | name | Tipo | Obrigatório? |
    |---|---|---|---|
    | Modelo do equipamento | `equip_modelo` | text | **Sim** |
    | Número de série | `equip_serie` | text | **Sim** |
    | Nº da nota fiscal / pedido | `equip_nf` | text | Não |
    | Equipamentos adicionais | `equip_adicionais` | memo | Não |
    | Observações | `equip_obs` | memo | Não |
  - Associação ao tópico: `ost_help_topic_form` liga o form 7 ao tópico `topic_id=1` ("Solicitação de Manutenção") com `sort=2` (aparece depois de Resumo/Detalhes/Prioridade).
  - `ost_config.default_help_topic = 1`: define o tópico de manutenção como **padrão**, então os campos do equipamento já aparecem assim que a página de abertura carrega (sem precisar escolher o tópico primeiro — como só há um, faz sentido).
- **A descrição do defeito** reutiliza o campo nativo "Detalhes do Problema" (mensagem do ticket) — não foi criado um campo de defeito separado para evitar duplicidade. Cada chamado = um equipamento; para vários, usar o campo "Equipamentos adicionais".
- **Detalhe técnico (flags):** os `flags` dos campos seguem as constantes do osTicket (`include/class.dynamic_forms.php`): **Opcional = 13057** (`ENABLED|CLIENT_VIEW|CLIENT_EDIT|AGENT_VIEW|AGENT_EDIT`) e **Obrigatório = 30465** (o anterior + `CLIENT_REQUIRED|AGENT_REQUIRED`). Guardar isso aqui poupa ter que redescobrir os bitmasks se um dia for preciso criar campos via SQL de novo.
- **Como reaplicar em versão nova:** **preferir a interface** — **Admin Panel → Gerenciar → Formulários → Adicionar Formulário** ("Dados do Equipamento") com os campos acima (marcando Modelo e Nº de Série como "Obrigatório"), depois **Tópicos de Ajuda → Solicitação de Manutenção → aba Formulários** e adicionar o novo formulário; e em **Configurações → Tickets** definir o **Tópico de Ajuda Padrão** = Solicitação de Manutenção. Alternativa (banco): o script SQL usado está versionado em `backups/` — reexecutar ajustando os IDs. Como é config em banco, se o banco for reaproveitado no upgrade, **migra sozinho** (nada a refazer).
- **Ampliação futura (estilo RMA completo):** para capturar também dados de coleta/envio (Razão Social/Nome, CNPJ/CPF, telefone, endereço completo), basta adicionar mais campos ao mesmo formulário (ou usar os formulários nativos de Usuário/Organização do osTicket para os dados cadastrais). Ficou como opção — nesta rodada foi feito o conjunto focado em equipamento.
- **Status:** aplicado — pendente de conferência visual do usuário (abrir chamado e ver os campos).

---

#### 2026-07-01 — Ocultar seletor de "Tópico de Ajuda" (sistema de tópico único)

- **Arquivo(s) alterado(s):** `include/client/open.inc.php` (core do cliente) + pequeno ajuste em `assets/default/css/theme.css`.
- **Motivo/contexto:** como o sistema tem um único tópico ("Solicitação de Manutenção"), o dropdown "Tópico de Ajuda" era redundante e poluía a tela.
- **O que foi feito (inteligente/à prova de futuro):** o bloco do seletor em `open.inc.php` foi envolvido em uma condição: **se houver mais de um tópico público**, o `<select>` normal aparece; **se houver apenas um**, o tópico é enviado por um `<input type="hidden" name="topicId">` (linha oculta) e o seletor some. Ou seja, se um dia criarem novos tópicos em **Admin → Gerenciar → Tópicos de Ajuda**, o seletor **reaparece automaticamente** — não precisa reverter nada.
- **Depende de:** o tópico padrão (`ost_config.default_help_topic = 1`, já configurado) — é ele que preenche o `topicId` oculto e faz os campos do formulário (Detalhes + Dados do Equipamento) já renderizarem no carregamento da página.
- **Enxugada de layout (CSS):** espaçamento das divisórias de seção do formulário reduzido (`#ticketForm hr` margin 20/14 → 16/12) e altura mínima do editor de texto (redactor) reduzida para 130px, deixando o formulário mais compacto.
- **Backup:** `include/client/open.inc.php.original-backup` (já existente da edição anterior — contém o arquivo 100% original de fábrica).
- **Como reaplicar em versão nova:** reaplicar o bloco condicional em `open.inc.php` (conferir se a estrutura do seletor mudou na versão nova). A enxugada de CSS já faz parte da camada ZKTeco do `theme.css`. Alternativa sem editar core: dá para apenas ocultar o seletor via CSS (`#ticketForm select#topicId, ...{display:none}`), mas a versão em PHP é mais limpa e robusta (garante o envio do `topicId`).
- **Status:** aplicado — pendente de conferência visual do usuário.

---

#### 2026-07-01 — Enxugada do formulário + reordenação + campo de Fotos (com câmera)

- **Onde foi alterado:** banco (`ost_form_field`, `ost_help_topic_form`). Sem código.
- **Motivo/contexto:** o usuário quis deixar o formulário mais enxuto e reordenado, e adicionar upload de fotos (com opção de câmera).
- **Estrutura FINAL do formulário de abertura (ordem):**
  1. **Seção "Dados do Equipamento"** (form 7): `Modelo do equipamento`* · `Número de série`* · `Fotos do equipamento / defeito` (até 2 imagens).
  2. **Seção "Detalhes do Chamado"** (form 2): `Resumo do Problema`* · `Detalhes do Problema` (editor) · `Observações`.
  (`*` = obrigatório. O campo `Nível de prioridade` do form 2 continua oculto para o cliente.)
- **O que mudou nesta rodada:**
  - **Removidos** os campos `Nº da nota fiscal / pedido` (`equip_nf`) e `Equipamentos adicionais` (`equip_adicionais`). *(A nota fiscal será adicionada no futuro, conforme pedido.)*
  - **Observações** saiu da seção de equipamento e virou um campo `memo` no form 2 (id 42, `observacoes`), aparecendo por último, depois do detalhamento.
  - **Reordenação das seções** via `ost_help_topic_form.sort`: equipamento (form 7) = sort 1; detalhes (form 2) = sort 2. (O osTicket ordena as seções por esse `sort` — model `TopicFormModel`.)
  - **Campo de Fotos** (`equip_fotos`, id 41, tipo **`files`**): configuração `{"size":8388608,"mimetypes":{"image":"Images"},"extensions":"","max":2}` → aceita **somente imagens**, **até 2 arquivos**, **8 MB** cada (limites do servidor: PHP 40M, osTicket 32M).
    - **Câmera:** o osTicket renderiza o `<input type=file>` com `accept="image/..."` (deriva do `mimetypes=image`). Em **celular**, isso faz o sistema oferecer **"Tirar foto" (câmera) ou escolher da galeria** automaticamente — que é exatamente "upload OU câmera". Em **desktop** não há captura por webcam nativa (limitação do navegador, não do osTicket): no PC é upload de arquivo. Não foi usado `capture=camera` de propósito, para não forçar só a câmera e continuar permitindo o upload.
- **Como reaplicar em versão nova (via interface, recomendado):**
  - **Admin → Gerenciar → Formulários → "Dados do Equipamento"**: manter só Modelo e Número de série (obrigatórios) e adicionar um campo tipo **"File Upload"** ("Fotos..."), em *Restrict by File Type* marcar **Images**, *Maximum Files* = **2**, *Maximum File Size* = 8MB.
  - No formulário **"Detalhes do chamado"** adicionar um campo **memo** "Observações".
  - Em **Tópicos de Ajuda → Solicitação de Manutenção → aba Formulários**: arrastar para a ordem *Dados do Equipamento* (em cima) e *Detalhes do chamado* (embaixo).
  - Script SQL versionado: `backups/reform_equip_form_2026-07-01.sql`.
- **Status:** aplicado — pendente de conferência visual do usuário.

---

#### 2026-07-01 — Múltiplos equipamentos por chamado, com progresso individual (FEATURE GRANDE)

> **Este é o item mais complexo do projeto.** A arquitetura foi escolhida por um painel de design (3 propostas + 3 juízes): venceu por unanimidade o **módulo custom com tabela própria** (em vez de usar as "Tasks" nativas, que custam 1 thread por item — inviável para 100 equipamentos, e o cliente não vê Tasks).

**O que faz:** um mesmo chamado pode ter N equipamentos (modelo, nº de série, descrição, observação), cada um com **status individual**. O cliente cadastra em massa; o agente evolui item a item; o cliente acompanha o progresso de cada um no mesmo chamado.

**Arquivos e componentes (arquitetura):**

1. **Tabelas próprias (imunes a upgrade)** — SQL em `backups/zk_equip_tables_2026-07-01.sql`:
   - `ost_zk_equipment` — 1 linha por equipamento (ticket_id, seq, modelo, numero_serie, descricao, obs_cliente, status, laudo [visível ao cliente], nota_interna [só agente], staff_id, created, updated).
   - `ost_zk_equipment_event` — histórico/timeline de mudança de status por item.
2. **Módulo `include/zk_equipment.php`** (NOVO, arquivo nosso — cópia em `backups/zk_equipment.php.bak`). Contém: ciclo de status (fonte única), CSS embutido (`zk_equip_styles()` — embutido porque o SCP do agente **não** carrega o `theme.css`), handler de persistência na criação, consultas (`zk_equip_list/stats/events`), e os dois renderizadores de painel (cliente read-only e agente editável). Também conecta os signals.
3. **Endpoint `scp/zk-equip.php`** (NOVO, cópia em `backups/zk-equip.php.bak`) — recebe o POST do painel do agente, atualiza status/laudo/nota, grava eventos e (opcional) uma nota-resumo no chamado. Segurança: `require('staff.inc.php')` garante login + **CSRF automático**; ainda checa `checkStaffPerm`.

**Ciclo de status (chave → rótulo, cor):** `recebido`→Recebido (cinza) · `em_analise`→Em análise (grafite) · `aguardando_peca`→Aguardando peça (âmbar) · `em_reparo`→Em reparo (azul) · `reparado`→Reparado (verde) · `substituido`→Substituído RMA (verde) · `sem_reparo`→Sem reparo/Inviável (vermelho) · `enviado`→Enviado ao cliente (verde). "Concluído" (para a barra de progresso) = estados reparado/substituido/sem_reparo/enviado.

**Integração (ganchos verificados no código real):**
- **Persistência na criação:** `Signal::connect('ticket.created', ...)` lê o campo oculto `zk_equipments_json` do POST e insere as linhas (revalida modelo+série no servidor). Sem editar `open.php`.
- **Housekeeping:** `Signal::connect('model.deleted', ..., 'Ticket')` limpa os itens ao excluir o chamado (não há FK física).
- **Carregamento do módulo:** 1 linha (marcada `/* ZK-EQUIP:BEGIN/END */`, com `@file_exists`) no **fim de `main.inc.php`** (não no bootstrap — lá `TABLE_PREFIX` e a classe `Signal` ainda não existem; descoberto em teste).
- **Painel do agente:** 1 linha guardada (`function_exists('zk_equipment_staff_panel')`) em `include/staff/ticket-view.inc.php`, logo após o `<div class="clear"></div>` que fecha os dados do ticket (antes das abas Thread/Tasks).
- **Painel do cliente:** 1 linha guardada (`function_exists('zk_equipment_client_panel')`) em `include/client/view.inc.php`, após a tabela de custom-data (antes da thread).
- **Grade de cadastro:** bloco marcado em `include/client/open.inc.php` (arquivo nosso), antes do `#dynamic-form`.

**UX de cadastro (cliente) — escala para 100+:**
- Grade dinâmica (adicionar/remover linha, +10 linhas, contador).
- **Importação em massa:** colar direto do Excel (TSV) OU importar CSV (parse no navegador, sem upload extra) → preenche a grade. Detecta cabeçalho; ignora linhas vazias; avisa linhas sem nº de série.
- Enviado como **um único campo oculto JSON** (`zk_equipments_json`) — evita o limite `max_input_vars` do PHP com centenas de campos (recomendação dos juízes).
- Validação: cada linha precisa de Modelo **e** Nº de série; ao menos 1 equipamento.

**UX do agente (SCP):** painel "Equipamentos (N)" com barra de progresso, busca/filtro, tabela editável (status por linha, laudo visível ao cliente, nota interna), **ação em massa** (marcar selecionados com um status via JS) e um único **Salvar** (POST para `scp/zk-equip.php`). Sem AJAX (mais robusto). Mudanças geram eventos (timeline) e, se marcado, uma nota-resumo.

**UX do cliente:** painel read-only "Equipamentos (N)" com barra de progresso + chips por status, tabela (modelo, série, status colorido, laudo, atualizado) e busca. **Nunca** mostra a nota interna do agente.

**Segurança:** `checkStaffPerm`/`checkUserAccess` nos dois lados; CSRF no endpoint; `Format::htmlchars` em tudo que vem do cliente; endpoint valida que o item pertence ao ticket informado.

**Upgrade-safety / reaplicação:** tabelas e os 2 arquivos novos (`include/zk_equipment.php`, `scp/zk-equip.php`) são imunes a upgrade. Os 3 pontos de core (main.inc.php, staff/ticket-view.inc.php, client/view.inc.php) têm marcadores `/* ZK-EQUIP:BEGIN/END */` e guardas — após um upgrade, procurar por `ZK-EQUIP` e reinserir as 3 linhas se sumirem. `open.inc.php` já é arquivo nosso.

**Pendências desta feature (próximas rodadas):**
- Notificar o CLIENTE por e-mail no resumo (hoje a nota-resumo é interna; usar `Ticket::postReply` para e-mail — avaliar para não gerar spam).
- Timeline visual por item (os eventos já são gravados em `ost_zk_equipment_event`; falta expor num popover).
- Paginação server-side no painel do agente acima de ~200 itens (hoje filtro/busca é client-side; ok até algumas centenas).
- Dados de teste inseridos no chamado #355124 para conferência — remover quando quiser (`DELETE FROM ost_zk_equipment WHERE ticket_id=2;`).

**Status:** implementado; site sobe sem erros; PHP lint OK em todos os arquivos. **Aguardando teste funcional do usuário** (criar chamado com a grade; evoluir status no SCP; acompanhar como cliente).

**Revisão 2 (2026-07-01) — tudo por equipamento + design largo:** a pedido do usuário, o **resumo do problema** e o **detalhamento** passaram a ser POR EQUIPAMENTO (não mais campos genéricos do chamado). Mudanças:
- **Novas colunas** em `ost_zk_equipment`: `resumo` (VARCHAR 255) e `detalhamento` (TEXT). A grade do cliente agora tem: Modelo*, Nº Série*, **Resumo***, **Detalhamento**, Observação (o antigo `descricao` foi aposentado da UI).
- **Campos genéricos removidos:** o formulário nativo "Detalhes do chamado" (form 2, subject+message) foi **desassociado do tópico** (`DELETE FROM ost_help_topic_form WHERE topic_id=1 AND form_id=2`), então some da tela de abertura.
- **Título/descrição automáticos:** como o osTicket ainda exige subject/message, um novo handler `Signal::connect('ticket.create.before', ...)` **gera automaticamente** o assunto (ex.: "Solicitação de manutenção — N equipamentos") e a descrição (lista HTML dos equipamentos com resumo/detalhamento/obs) a partir da grade. Assim o chamado tem título e o thread inicial legível para o agente, sem campos genéricos na tela.
- **Design largo:** a grade e os painéis agora usam largura total (`#ticketForm{max-width:100% !important}`, `.zk-panel{max-width:none}`), com colunas dimensionadas e textareas para detalhamento/observação. Detalhamento é a coluna flexível.
- **Painéis (agente e cliente)** atualizados para exibir Equipamento (modelo + S/N), **Problema relatado** (resumo + detalhamento + obs), Status, Laudo.
- **FOTOS:** ainda a nível de chamado (form 7 "Fotos e Anexos"), como ponte. **Fotos por equipamento é o próximo passo** — exige upload por linha + armazenamento próprio + endpoint de servir, e esbarra no limite `max_file_uploads` do PHP (~20/envio) para o caso de 100 itens; será feito com mecanismo dedicado e testado.
- SQL da migração desta revisão (colunas + desassociação): aplicado; ver também `backups/` (dump geral).

**Revisão 3 (2026-07-01) — fotos por equipamento + retirada dos anexos gerais:** a pedido do usuário, a grade de abertura passou a ter **dois controles de imagem por linha**:
- **Arquivos alterados:** `include/client/open.inc.php`, `include/zk_equipment.php`, `assets/default/css/theme.css`; banco `ost_zk_equipment_file` + `ost_help_topic_form`.
- **UX de abertura:** nova coluna **Fotos** em cada equipamento, com dois botões compactos: anexar arquivo (`icon-paperclip`) e tirar foto (`icon-camera`, `accept="image/*" capture="environment"`). Em desktop funciona como seletor de arquivo; em celular oferece câmera quando suportado pelo navegador.
- **Persistência:** cada linha recebe um `photo_key` no JSON (`zk_equipments_json`). No `ticket.created`, após inserir o equipamento em `ost_zk_equipment`, o módulo lê `$_FILES['zk_equip_photo'][photo_key][1|2]`, valida MIME `image/*`, usa `AttachmentFile::upload()` do próprio osTicket e grava o vínculo na nova tabela `ost_zk_equipment_file` (`ticket_id`, `equipment_id`, `file_id`, `slot`, `created`).
- **Visualização:** painéis do cliente e do agente agora mostram os links das fotos junto ao "Problema relatado" do equipamento. Os links usam `AttachmentFile::getDownloadUrl()` e reaproveitam `file.php`.
- **Removido:** o formulário geral **"Fotos e Anexos"** (form 7) foi desassociado do tópico (`DELETE FROM ost_help_topic_form WHERE topic_id=1 AND form_id=7`), então não aparece mais como bloco geral do ticket. O botão **Recomeçar formulário** também foi removido do rodapé da abertura.
- **Design:** largura principal do portal ampliada em `theme.css` (`--zk-col:1280px`, `--zk-form:100%`) para acomodar a grade larga com fotos sem apertar as colunas.
- **Tabela criada:**
  ```sql
  CREATE TABLE ost_zk_equipment_file (
    id INT(11) UNSIGNED NOT NULL AUTO_INCREMENT,
    ticket_id INT(11) UNSIGNED NOT NULL,
    equipment_id INT(11) UNSIGNED NOT NULL,
    file_id INT(11) NOT NULL,
    slot TINYINT(1) UNSIGNED NOT NULL DEFAULT 1,
    created DATETIME NOT NULL,
    PRIMARY KEY (id),
    KEY ticket_id (ticket_id),
    KEY equipment_id (equipment_id),
    KEY file_id (file_id),
    KEY equipment_slot (equipment_id, slot)
  ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
  ```
- **Validação feita:** `php -l include/zk_equipment.php` e `php -l include/client/open.inc.php` OK; `open.php` respondeu HTTP 200. Navegador interno do Codex não estava disponível para screenshot automatizado nesta rodada.

**Revisão 4 (2026-07-01) — limpeza do ticket antigo, acentos e largura total:** após teste visual do usuário:
- **Ticket removido:** o chamado de teste **#355124** (`ticket_id=2`) foi excluído por `Ticket::delete()`. A remoção limpou `ost_zk_equipment`, `ost_zk_equipment_file` e o valor antigo `equip_fotos` que aparecia como **Fotos e Anexos**.
- **Compatibilidade com tickets antigos:** `include/client/view.inc.php` agora ignora respostas do campo antigo `equip_fotos`, para que anexos gerais antigos não reapareçam na visualização do cliente.
- **Acentos:** os textos corrompidos eram dados de teste já gravados no banco (`n?o`, `substitu?do`, etc.). Após remover o ticket de teste, validação no banco retornou zero campos com `?` em `ost_zk_equipment` e em `ost_ticket__cdata.subject`. O HTML atual de abertura renderiza corretamente `Manutenção`, `Nº de série` e `Observação`.
- **Layout horizontal total:** `assets/default/css/theme.css` passou a usar `--zk-col:none`, `#container`/`#footer` com `width:calc(100% - 32px)` e regras específicas para `#ticketInfo`, `.zk-panel`, `.zk-table-wrap` e `.thread-entry`, permitindo uso quase total da largura em desktop. No mobile, `#ticketInfo` empilha as colunas e tabelas largas ganham rolagem horizontal controlada.
- **Validação feita:** `php -l include/client/view.inc.php`, `php -l include/client/open.inc.php`, `php -l include/zk_equipment.php` OK; `tickets.php` respondeu HTTP 200; #355124 não aparece mais; `Fotos e Anexos` não aparece mais.

**Revisão 5 (2026-07-01) — correção de erro ao criar chamado:** após tentativa real de criação pelo usuário:
- **Causa provável:** a criação dependia do JavaScript preencher o hidden `zk_equipments_json`. Se esse hidden viesse vazio por qualquer falha no submit, o servidor não recebia os campos da grade, porque os inputs visuais não tinham `name`. O osTicket então rejeitava o chamado por faltar assunto/mensagem automáticos, exibindo só a mensagem genérica.
- **Correção:** `include/client/open.inc.php` agora envia também arrays normais por linha: `zk_modelo[]`, `zk_serie[]`, `zk_resumo[]`, `zk_detalhamento[]`, `zk_obs[]` e `zk_photo_key[]`. O JSON continua existindo, mas não é mais ponto único de falha.
- **Backend robusto:** `include/zk_equipment.php` ganhou `zk_equip_request_rows()`, que lê primeiro `zk_equipments_json` e, se ele vier vazio/inválido, reconstrói os equipamentos a partir dos arrays normais. A mesma função alimenta tanto `ticket.create.before` quanto `ticket.created`.
- **Preservação em erro:** quando o formulário volta com erro, a grade passa a ser repovoada com os dados postados (`initialRows`) em vez de voltar em branco.
- **Acentos de configuração:** corrigidos textos de formulário no banco (`Informações de contato`, `Informação da Empresa`, `Informações da Organização`, `Nível de prioridade`, `Observações` e hints de fotos).
- **Validação feita:** `php -l include/client/open.inc.php` e `php -l include/zk_equipment.php` OK; `open.php` renderiza os novos `name=""` de fallback; criação direta com JSON vazio e arrays preenchidos criou ticket sem erros e o ticket de teste foi removido em seguida.

**Revisão 6 (2026-07-01) — causa raiz real do erro "Não foi possível criar um chamado" (diagnosticada e corrigida com teste ao vivo):**

- **Arquivo(s) alterado(s):** `include/client/open.inc.php` (só este; `open.php` e `include/class.ticket.php` do core **não** foram tocados — só usados para depurar com `error_log()` temporário, já revertido).
- **Sintoma:** ao preencher todos os campos visíveis da grade e enviar, o osTicket voltava com o banner genérico "Não foi possível criar um chamado. Corrija os erros acima e tente novamente." — sem indicar **qual** campo estava errado, porque os campos reais com erro (`subject`/`message`) não são mais renderizados na tela (Revisão 2 os removeu da UI).
- **Causa raiz (achada com `error_log()` temporário em 3 pontos: `open.php`, `class.ticket.php` e `zk_equipment.php`):**
  1. `open.php` (core, INTOCADO) faz uma "espiada" no campo `message` do formulário **antes** de chamar `Ticket::create()`: `$tform = TicketForm::objects()->one()->getForm($vars); $messageField = $tform->getField('message');`. Nesse momento, `$vars` ainda **não** tem `subject`/`message` preenchidos (o preenchimento automático só acontece dentro do `Ticket::create()`, via `Signal::connect('ticket.create.before', ...)` de `zk_equip_fill_ticket_vars()`).
  2. O osTicket reutiliza a mesma instância de formulário (`TicketForm::objects()->one()`, cacheada por request). Quando `Ticket::create()` roda depois e monta **sua própria** instância/entry para validar, ela acaba herdando esse vínculo "congelado" com o snapshot antigo (vazio) de `$vars` em vez do `$vars` já preenchido pelo hook.
  3. Resultado: mesmo com `zk_equip_fill_ticket_vars()` preenchendo `$vars['subject']`/`$vars['message']` corretamente (confirmado nos logs de depuração), a validação interna do osTicket lia os campos como **vazios** e rejeitava o chamado por "Resumo do Problema é um campo obrigatório" / "Detalhes do Problema é um campo obrigatório" — erros invisíveis, porque a tela não tem mais linha para esses campos.
- **Correção aplicada (sem tocar em nenhum arquivo do core):** o assunto e a mensagem agora são gerados **no JavaScript**, no momento do submit, e enviados em dois `<input type="hidden" name="subject">` / `name="message">` que já fazem parte do `$_POST` desde o início da requisição — eliminando de vez a dependência de timing do hook do lado servidor.
  ```diff
    <div id="zk-equip">
      <input type="hidden" name="zk_equipments_json" id="zk_equipments_json" value="">
  +   <input type="hidden" name="subject" id="zk_auto_subject" value="">
  +   <input type="hidden" name="message" id="zk_auto_message" value="">
  ```
  E no handler de submit, antes de `$('#zk_equipments_json').val(...)`, chama `fillAutoSubjectMessage(arr)` — mesma regra de geração de assunto/mensagem que já existia em `zk_equip_fill_ticket_vars()` (PHP), agora replicada em JS. A função PHP **foi mantida** como rede de segurança (idempotente — só age se os campos vierem vazios), mas na prática deixa de ser o caminho principal.
- **Como reaplicar em versão nova:** reaplicar o bloco dos 2 hidden inputs + a função `fillAutoSubjectMessage()`/chamada no submit em `open.inc.php` (arquivo já é nosso). Nenhuma dependência de core.
- **Validação feita:** reproduzido o erro no navegador real (login como cliente, preenchimento completo, erro confirmado), diagnosticado com `error_log()` temporário (removido depois), corrigido, e testado de novo criando o chamado #245662 com sucesso.
- **Status:** aplicado e testado.

**Revisão 7 (2026-07-01) — edição de equipamentos pelo cliente (tela "Editar" no padrão da abertura):**

- **Motivo/contexto:** ao clicar em "Editar" num chamado já aberto, o cliente caía na tela padrão e genérica do osTicket (`tickets.php?a=edit`, template `edit.inc.php` = lista de campos dinâmicos), que não tem nenhuma relação com a grade de equipamentos usada na abertura — não dava pra corrigir um dado errado nem anexar uma foto esquecida.
- **Decisão de arquitetura:** em vez de adaptar o fluxo `a=edit` do `tickets.php` (core), foi criado um **endpoint próprio e independente**, seguindo o mesmo padrão já usado em `scp/zk-equip.php` (endpoint dedicado fora do core) — **zero linhas alteradas em `tickets.php` ou `open.php`**.
- **Arquivos novos:**
  - **`zk-equip-edit.php`** (raiz do projeto) — controlador: `require('client.inc.php')`, valida dono do chamado + permissão de edição (`zk_equip_client_can_edit()`), processa o POST (`zk_equip_client_process_edit()`) e redireciona de volta para `tickets.php?id=`.
  - **`include/client/zk-equip-edit.inc.php`** — template: mesma grade/CSS/JS da abertura (`open.inc.php`), porém pré-preenchida com os equipamentos já cadastrados do chamado (via `zk_equip_list()`), mostrando também as fotos já anexadas de cada item.
- **Funções novas em `include/zk_equipment.php`:**
  - `zk_equip_client_can_edit($ticket)` — mesma regra de permissão já usada no botão "Editar" nativo (`hasClientEditableFields()` + dono do chamado).
  - `zk_equip_client_process_edit($ticket)` — lê `zk_equip_request_rows()`; linhas com `id` existente são **atualizadas** (`UPDATE`, preservando `status`/`laudo`/`nota_interna`, que são exclusivos do agente); linhas sem `id` são **inseridas** como novo equipamento (mesma lógica de `zk_equip_on_ticket_created`, com `seq` continuando a sequência); fotos novas são **anexadas** (nunca substituem as existentes) via `zk_equip_save_uploaded_photos()` (já existente).
- **Edição em `include/client/view.inc.php`:** o link "Editar" agora aponta para `zk-equip-edit.php?id=` quando o chamado tem equipamentos cadastrados (`zk_equip_count() > 0`); senão, cai no comportamento padrão do osTicket (`tickets.php?a=edit`) — fallback seguro para chamados fora do fluxo de equipamentos.
  ```diff
  - <a class="action-button" href="tickets.php?a=edit&id=...">
  + <a class="action-button" href="<?php echo $__edit_url; ?>">
  ```
- **Comportamento importante (intencional):** remover uma linha na tela de edição **não apaga** o equipamento do banco — apenas o tira da lista visível (com uma confirmação avisando isso), para não perder acidentalmente status/laudo que o agente já tenha preenchido. Exclusão real continua sendo decisão só do time interno (direto no banco, se um dia for necessário).
- **Bug encontrado e corrigido durante o teste:** `Ticket::logNote()` estava sendo chamado com `$thisclient->getName()` (um objeto `UsersName`, sem `getId()`), causando `PHP Fatal error: Call to undefined method UsersName::getId()` dentro de `postNote()`. Corrigido para passar `(string) $thisclient->getName()` — o parâmetro `$poster` de `logNote()`/`postNote()` aceita `Staff`/objeto com `getId()` **ou** uma string simples (vira o nome exibido no evento).
- **Como reaplicar em versão nova:** copiar os 2 arquivos novos + as funções novas do `zk_equipment.php` + a edição de `view.inc.php`. Nenhuma dependência de estrutura interna do `tickets.php`/`open.php` do core — só usa `client.inc.php`, `Ticket::lookup()` e `csrf_token()`, que são estáveis entre versões.
- **Validação feita:** testado ao vivo (login como cliente) — corrigir o "Resumo do problema" de um item existente (salvou e refletiu na tela do chamado), e adicionar um equipamento novo esquecido (K40) direto na tela de edição (criado com sucesso, contagem "Equipamentos (2)" atualizada). Upload real de foto na tela de edição **não foi testado nesta rodada** (só o botão/estrutura, que reaproveita o mesmo mecanismo já testado na abertura).
- **Status:** aplicado e testado (exceto upload de foto na edição, pendente de teste).

**Revisão 8 (2026-07-01) — miniaturas de foto, altura de card padronizada e limite de caracteres testado no "Resumo do problema":**

- **Arquivo(s) alterado(s):** `include/zk_equipment.php` (CSS embutido + markup dos painéis cliente/agente), `include/client/open.inc.php` e `include/client/zk-equip-edit.inc.php` (campo Resumo + contador).
- **Motivo/contexto:** pedido do usuário para (1) mostrar a foto anexada como **miniatura** de verdade (em vez de um link com nome de arquivo), (2) impedir que o texto de "Problema relatado" quebre linha (a coluna tinha espaço horizontal sobrando), (3) padronizar a **altura do card/linha** pelo tamanho da miniatura, e (4) limitar o campo "Resumo do problema" a um tamanho que sempre caiba sem gerar rolagem, com um **contador ao vivo** (`X/limite`) enquanto o usuário digita.
- **Miniaturas:** `zk_equip_photo_links_html()` passou a renderizar um `<img>` real (56×56px, `object-fit:cover`, dentro de um link clicável para o arquivo original em tamanho cheio) em vez do ícone + nome do arquivo.
  ```diff
  - <a class="zk-photo-link ..."><i class="icon-camera"></i><span class="zk-photo-name">nome.png</span></a>
  + <a class="zk-photo-thumb ..."><img src="..." alt="nome.png" loading="lazy"></a>
  ```
- **Altura padronizada:** nova classe `.zk-issue-row` (flex, `height:56px` — mesma medida da miniatura) envolvendo o texto (resumo/detalhamento/observação) e as miniaturas na célula "Problema relatado", aplicada **igualmente** no painel do cliente (`zk_equipment_client_panel`) e no do agente (`zk_equipment_staff_panel`) — mesmo padrão nos dois lugares, conforme pedido. Cada linha de texto usa `white-space:nowrap; text-overflow:ellipsis` (nunca quebra, trunca com "..." e mostra o texto completo via `title` ao passar o mouse).
- **Limite de caracteres — testado, não estimado:** em vez de "chutar" um número, foi usado `canvas.measureText()` **no navegador real**, com a fonte/tamanho/largura exatos do campo `.zk-resumo` do formulário, testando várias frases reais em português (ex.: "Leitor biometrico nao reconhece digitais dos usuarios..."). Resultado: **32 caracteres** é o maior valor que sempre cabe no campo sem gerar rolagem interna nessa largura de coluna (18% da grade). Testado também digitando de verdade (não só via script) — o navegador trava em exatamente 32 caracteres, todos visíveis.
  - `maxlength="32"` aplicado ao campo `zk_resumo[]` (era `255`) em `open.inc.php` e `zk-equip-edit.inc.php`.
  - Contador `<span class="zk-resumo-count">0/32</span>` ao lado do campo, atualizado via `input` event; fica laranja (`zk-count-warn`) a partir de 80% do limite e vermelho (`zk-count-max`) ao atingir 32/32.
- **Se a largura da coluna mudar no futuro:** o limite de 32 foi calibrado para a largura **atual** de `.zk-c-resumo` (18% da grade). Se essa largura mudar, refazer o teste com `canvas.measureText()` (script usado documentado no histórico desta sessão) e ajustar a constante `RESUMO_LIMIT` (JS, em ambos os arquivos) — é o único lugar que precisa mudar.
- **Como reaplicar em versão nova:** copiar o bloco de CSS novo (`.zk-photo-thumb`, `.zk-issue-row`, `.zk-issue-text`, `.zk-resumo-count`) e o `zk_equip_photo_links_html()` atualizado em `zk_equipment.php`; reaplicar `RESUMO_LIMIT` + contador nos dois arquivos de grade.
- **Validação feita:** testado ao vivo — chamado com foto real mostrando miniatura corretamente (imagem carregada, `object-fit:cover`), duas linhas de equipamento (uma com foto, uma sem) com **exatamente a mesma altura de linha** (73px, medido via JS no navegador), e digitação real confirmando o limite de 32 caracteres sem rolagem.
- **Status:** aplicado e testado.

---

#### 2026-07-01 — Tela "Chamados" (lista) no padrão ZKTeco + busca inteligente

- **Arquivo(s) alterado(s):**
  - `include/client/tickets.inc.php` — **arquivo do core**, reescrito (era 100% original de fábrica até esta rodada; primeira vez que este arquivo específico é tocado).
  - `include/zk_equipment.php` — nova função `zk_equip_matching_ticket_ids()` + CSS novo.
- **Backup do original:** recomendado gerar `include/client/tickets.inc.php.original-backup` antes do próximo upgrade (não existia edição prévia deste arquivo, então não havia backup ainda).
- **Motivo/contexto:** a tela "Chamados" (listagem) ainda estava 100% no visual de fábrica do osTicket (caixa "well" cinza, tabela larga sem estilo), destoando das demais telas do portal (abertura, visualização, edição) já no padrão ZKTeco. Também tinha um filtro **"Tópico de Ajuda"** sem utilidade (o sistema só tem um tópico) e a busca não encontrava chamados pelo conteúdo dos equipamentos (modelo, nº de série, resumo etc. — dados que ficam numa tabela própria, fora do índice de busca nativo do osTicket).
- **O que foi feito:**
  1. **Removido o filtro "Tópico de Ajuda":** settings/filtro/`<select>` de `topic_id` eliminados por completo (não é mais lido de `$_REQUEST`, não filtra mais `$basic_filter`, não aparece mais no HTML).
  2. **Visual no padrão ZKTeco:** a tela passou a usar as mesmas classes já usadas nas outras telas (`zk_equip_styles()` é chamada aqui também — CSS compartilhado, guard estático evita duplicar): `.zk-panel`/`.zk-panel-title` para o cabeçalho, `.zk-toolbar`/`.zk-search` para a busca, `.zk-table`/`.zk-table-wrap` para a tabela, e os estados "Aberto/Encerrado" viraram "chips" arredondados (`.zk-state`, `.zk-state-active`) em vez de links de texto simples. Célula de Assunto/Departamento ganhou `.zk-issue-line` (uma linha só, com "..." se não couber) para não quebrar o layout com assuntos longos.
  3. **Busca inteligente — combina fontes em vez de escolher uma só:** o código original fazia **OU** (a) prefixo do número do chamado (se a busca fosse só números) **OU** (b) busca de texto completo via engine nativo (`$ost->searcher`, só ativa com 3+ caracteres) — nunca as duas, e nunca cobria os campos dos equipamentos. Agora:
     - Sempre tenta as 3 fontes: número do chamado (prefixo), texto completo nativo (assunto + mensagens da thread, quando a busca tem 3+ caracteres) e os campos do equipamento (`modelo`, `numero_serie`, `resumo`, `detalhamento`, `obs_cliente`, `laudo` — nova função `zk_equip_matching_ticket_ids()`, com `LIKE '%...%'` escapado via `db_real_escape()`).
     - Os 3 conjuntos de `ticket_id` são **unidos** (`->union(...)`, mesmo padrão já usado no código original para juntar critérios de visibilidade) antes de filtrar a listagem — ou seja, o chamado aparece se bater em **qualquer uma** das fontes, não só na primeira que "ganhasse" antes.
     - Corrige também um caso específico: buscar por um **número de série puramente numérico** (ex.: "998877") antes só tentava casar com o número do chamado (quase nunca bate) e **ignorava silenciosamente** o conteúdo — agora encontra corretamente pelo equipamento.
     - `nota_interna` (uso exclusivo do agente) foi **propositalmente excluída** da busca do cliente.
  ```diff
  - if (is_numeric($q)) {
  -     $tickets->filter(array('number__startswith'=>$q));
  - } elseif (strlen($q) > 2) {
  -     $tickets = $ost->searcher->find($q, $tickets, true, ['boolean' => false]);
  - }
  + $matchSets = array();
  + if (is_numeric($q)) $matchSets[] = Ticket::objects()->filter(array('number__startswith'=>$q))->values_flat('ticket_id');
  + if (strlen($q) > 2) $matchSets[] = $ost->searcher->find($q, Ticket::objects(), false, ['boolean'=>false])->values_flat('ticket_id');
  + if ($eqIds = zk_equip_matching_ticket_ids($q)) $matchSets[] = Ticket::objects()->filter(array('ticket_id__in'=>$eqIds))->values_flat('ticket_id');
  + // une os $matchSets com ->union() e filtra $tickets por ticket_id__in
  ```
- **Dependências/impactos:** a nova função `zk_equip_matching_ticket_ids()` faz uma query direta em `ost_zk_equipment` (sem índice full-text — usa `LIKE '%...%'`, aceitável no volume atual; se crescer muito, considerar um índice `FULLTEXT` nas colunas de texto). O restante da lógica de visibilidade/paginação/ordenação do arquivo original **não foi alterado**.
- **Como reaplicar em versão nova:** como este é o primeiro toque em `tickets.inc.php`, ao migrar: pegar o `tickets.inc.php` novo da versão atualizada e **reaplicar manualmente** as 3 mudanças acima (remover bloco de `topic_id`, trocar o HTML pelo padrão `.zk-panel`/`.zk-table`, e trocar o bloco de busca pela versão com `union()`) — não copiar o arquivo inteiro cegamente, pois o arquivo novo pode ter mudanças de core que precisam ser preservadas. A função `zk_equip_matching_ticket_ids()` e o CSS novo em `zk_equipment.php` são independentes de core, migram sozinhos.
- **Validação feita:** testado ao vivo — visual conferido (sem o dropdown de tópico, chips de estado, tabela no padrão), busca por **número de série puro** ("998877", do equipamento K40) encontrou corretamente o chamado #245662 mesmo não sendo o número do chamado, busca por trecho do **resumo** ("jeito nenhum") também encontrou o chamado certo, e "Limpar busca e ordenação" voltou a listagem completa. Nenhum erro novo no log do Apache/PHP.
- **Status:** aplicado e testado.

---

#### 2026-07-01 — Correção do "cartão flutuando" em páginas com pouco conteúdo

- **Arquivo(s) alterado(s):** `assets/default/css/theme.css` (camada oficial ZKTeco).
- **Motivo/contexto:** logo após redesenhar a tela "Chamados" (lista), o usuário observou que ela "ainda tá com a cara antiga, fora do padrão das outras" mesmo já usando as mesmas classes (`zk-panel`, `zk-table` etc.) das telas aprovadas. Investigando: **não era um problema da tela em si**, e sim um bug estrutural do layout geral que só fica visível em páginas **curtas**.
- **Causa raiz:** o `#container` (a faixa branca "documento", com bordas laterais `border-left`/`border-right` que dão a moldura contínua) não tem altura mínima — sua altura é só a soma do conteúdo. Quando a página é longa (ex.: visualização de um chamado com vários equipamentos + thread), o conteúdo já ultrapassa a altura da tela e a faixa branca parece contínua. Quando a página é curta (ex.: lista de chamados com só 2 linhas), a faixa branca termina bem no meio da tela, o rodapé vem logo em seguida (colado, sem gap), mas sobra uma área cinza enorme abaixo de tudo até o fim da janela — dando exatamente a sensação de "cartão pequeno flutuando num mar cinza" que já tinha sido identificada e reprovada durante o redesign original (ver "Revisão 2" do redesign, mesma causa-raiz, mas dessa vez em uma tela com pouco conteúdo em vez de um bug de CSS).
- **O que foi feito:** técnica clássica de "rodapé fixo" (sticky footer) via Flexbox — faz a página **sempre preencher no mínimo a altura da janela**, então o rodapé nunca fica "solto" longe do conteúdo, não importa quão curta seja a página. Páginas longas continuam se comportando exatamente como antes (o flex só "estica" quando sobra espaço).
  ```diff
    body{ background:var(--zk-bg-soft); }
  +
  + html, body{ height:100%; }
  + body{ display:flex; flex-direction:column; min-height:100vh; }
  + #container{ flex:1 0 auto; }
  + #footer{ flex-shrink:0; }
  ```
- **Por que é seguro:** `#overlay`/`#loading` (spinners) são `position:fixed`, então não são afetados pelo novo layout flex do `body` (elementos com posicionamento fixo/absoluto saem do fluxo do flexbox). `#header`/`#nav` continuam dentro de `#container`, inalterados.
- **Dependência de cache do navegador (achado durante o teste):** o `theme.css` é carregado com uma query string **fixa** (`?a1114e5`, embutida em `include/client/header.inc.php`, igual em todos os assets) em vez de um hash baseado no conteúdo do arquivo — então o navegador pode continuar servindo uma cópia em cache mesmo depois do arquivo mudar no servidor. **Sempre que uma mudança de CSS não aparecer**, fazer um hard-refresh (Ctrl+F5) antes de suspeitar de bug. Isso não é uma customização nossa, é assim que o osTicket já versiona os assets — só ficou registrado aqui porque consumiu tempo de diagnóstico nesta rodada.
- **Como reaplicar em versão nova:** copiar o bloco de 4 regras acima para o `theme.css` novo (mesma seção, logo após `body{ background:var(--zk-bg-soft); }`).
- **Validação feita:** testado ao vivo (com bypass manual do cache do navegador) nas duas situações — tela "Chamados" curta (agora preenche a janela inteira, rodapé sempre no fim) e tela de visualização de chamado longa (sem nenhuma mudança perceptível, como esperado).
- **Status:** aplicado e testado.

---

#### 2026-07-01 — Cores de fábrica (azul/cinza) ainda vazando na tabela de Chamados

- **Arquivo(s) alterado(s):** `assets/default/css/theme.css` (camada oficial ZKTeco).
- **Motivo/contexto:** mesmo depois de estilizar a tela "Chamados" com as classes `.zk-table`/`.zk-panel`, o usuário reportou que a tabela continuava "totalmente fora do padrão de cores, feia" — cabeçalho azul claro (`#e1f2ff`), barra cinza no título da tabela, bordas pesadas cinza-escuro em volta de cada célula.
- **Causa raiz:** especificidade de CSS, não um erro de classe. A tabela usa `id="ticketTable"` (mantido de propósito, é o id nativo do osTicket) **e** `class="zk-table"`. O core do osTicket já define `#ticketTable th`, `#ticketTable caption`, `#ticketTable td` etc. usando **seletor por ID** (herdados na "base pristina" restaurada na Revisão 3 do redesign). Um seletor por ID sempre vence um seletor por classe (`.zk-table th`), **não importa a ordem** das regras no arquivo nem o fato do CSS ZKTeco vir depois — por isso a cor de fábrica continuava aparecendo por baixo do nosso `.zk-table`.
- **O que foi feito:** adicionado um bloco de overrides usando o **mesmo seletor por ID** (`#ticketTable ...`), para brigar em pé de igualdade e vencer pela ordem (a camada ZKTeco é sempre a última do arquivo). Sem usar `!important` em nenhum lugar.
  ```diff
  + #ticketTable{ border:0; background:transparent; }
  + #ticketTable caption{ padding:0 0 8px; color:#9aa0a6; background:transparent; border:0; font-weight:400; font-size:12px; }
  + #ticketTable th{ height:auto; background:#f5f7f4; color:#474B4F; border:0; border-bottom:1px solid #e3e6e2; padding:8px 10px; font-size:12px; font-weight:600; }
  + #ticketTable th a{ color:#474B4F; }
  + #ticketTable th a:hover{ color:#649E37; }
  + #ticketTable td{ padding:8px 10px; border:0; border-bottom:1px solid #f0f2ef; background:transparent; }
  + #ticketTable tr.alt td{ background:transparent; }
  + #ticketTable tbody tr:hover td{ background:#fafcf8; }
  + #ticketTable tbody a.Icon{ color:#474B4F; font-weight:600; }
  + #ticketTable tbody a.Icon:hover{ color:#649E37; }
  ```
- **Lição para futuras telas:** ao reaproveitar um `id` nativo do osTicket junto com uma classe `.zk-*` nova, **checar se aquele ID já tem regras de cor/borda no core** (`grep -n "#idDoElemento" assets/default/css/theme.css`) — se tiver, sobrescrever usando o **mesmo seletor de ID** (não só a classe nova), senão a regra do core sempre ganha independente de onde o CSS novo for colocado no arquivo.
- **Como reaplicar em versão nova:** copiar o bloco acima para o `theme.css` novo, na mesma seção (perto de `.zk-table-wrap{width:100%;}`).
- **Validação feita:** conferido via `getComputedStyle()` no navegador (não só visualmente) que a cor de texto real da tabela é `#474B4F`/`#555` (paleta ZKTeco) e não mais o azul/cinza de fábrica; comparado visualmente com o padrão das outras telas.
- **Status:** aplicado e testado.

---

#### 2026-07-01 — Ajustes finos de usabilidade e padronização de botões (retorno de teste do usuário)

- **Arquivo(s) alterado(s):** `assets/default/css/theme.css`, `include/client/tickets.inc.php`, `include/client/view.inc.php`, `include/client/zk-equip-edit.inc.php`, `include/client/open.inc.php`, `include/zk_equipment.php`.
- **Motivo/contexto:** depois de usar as telas novas, o usuário reportou 4 problemas pontuais com screenshots.
- **1) Botões sem estilo na tela de edição de equipamentos ("Salvar alterações"/"Cancelar" apareciam como botões brutos do navegador):** causa — as regras de botão do tema (`#ticketForm input[type=submit]...`) são escopadas pelo **id do formulário**, e `zk-equip-edit.inc.php` usa `id="zkEditForm"` (não é o `#ticketForm` nativo), então nenhuma regra batia. Corrigido estendendo os seletores de botão do tema para incluir `#zkEditForm` (e, na mesma limpeza, `#reply` — ver item 4). Nenhuma duplicação de CSS: são as mesmas regras, só com mais um seletor no `,`.
- **2) Contador de caracteres do "Resumo do problema" desalinhando a linha da grade:** o contador (`0/32`) ficava **abaixo** do campo, empurrando aquela célula para baixo e destoando da altura das células vizinhas (Detalhamento, Observação etc., sem contador). Movido para **acima** do campo (em `open.inc.php` e `zk-equip-edit.inc.php`, na função `rowHtml()` de cada arquivo — span antes do input, não depois) — mesma resposta em ambas as telas.
- **3) Linha da lista de "Chamados" só clicável no número do chamado:** adicionado `data-href` em cada `<tr>` + um pequeno handler de clique (`include/client/tickets.inc.php`) que navega para o chamado ao clicar em qualquer lugar da linha, exceto quando o clique é em um link (`<a>`) — preserva o comportamento nativo de abrir em nova aba com Ctrl/clique do meio no número do chamado. Cursor vira "mãozinha" (`cursor:pointer`) na linha inteira via CSS.
- **4) Botões "Imprimir" e "Recomeçar formulário" fora do padrão visual (aproveitado para removê-los, a pedido do usuário):**
  - `include/client/view.inc.php`: removido o link **"Imprimir"** do cabeçalho do chamado (ficou só "Editar", agora estilizado — ver abaixo) e removido o botão **"Recomeçar formulário"** (`<input type=reset>`) do formulário de resposta (`#reply`), mantendo só "Publicar Resposta" e "Cancelar".
  - **`.action-button`** (usado pelo link "Editar") não tinha NENHUM CSS próprio (herdava link de texto cru do core) — criado estilo de botão secundário (borda cinza, fundo branco, hover) em `theme.css`.
  - O formulário `#reply` (postar resposta) também não tinha nenhuma regra de botão própria (mesmo problema do item 1) — resolvido no mesmo bloco de CSS compartilhado `#ticketForm`/`#zkEditForm`/`#reply`.
- **Como reaplicar em versão nova:** ao criar qualquer formulário/tela nova fora do `#ticketForm` nativo, sempre conferir se os seletores de botão do tema precisam ser estendidos (mesmo alerta já registrado na entrada anterior sobre `#ticketTable`) — o padrão do projeto é usar **ids específicos por formulário** encadeados no mesmo seletor CSS (`#ticketForm X, #zkEditForm X, #reply X { ... }`), evitando duplicar as regras.
- **Validação feita:** testado ao vivo — botões "Salvar alterações"/"Cancelar" (edição de equipamentos), "Publicar Resposta"/"Cancelar" (resposta) e "Editar" (cabeçalho do chamado) todos com o mesmo visual (verde primário / contorno cinza secundário); contador "0/32" alinhado no topo do campo sem desalinhar a linha; clique em qualquer parte da linha da lista de chamados abre o chamado corretamente; "Imprimir" e "Recomeçar formulário" não aparecem mais.
- **Status:** aplicado e testado.

---

#### 2026-07-01 — Contador na linha do cabeçalho + fusão de Detalhamento/Observação em um único campo

- **Arquivo(s) alterado(s):** `include/client/open.inc.php`, `include/client/zk-equip-edit.inc.php`, `include/zk_equipment.php`; banco (`ost_zk_equipment`).
- **Motivo/contexto:** feedback visual do usuário sobre a grade de equipamentos: (1) o contador de caracteres do "Resumo" — colocado acima do campo na rodada anterior — ainda destoava, melhor ficar **na mesma linha do cabeçalho da coluna**; (2) os campos "Detalhamento" e "Observação" eram redundantes na prática (o cliente preenchia as duas ou uma virava lixo) — pedido para virar **um único campo** "Detalhamento/Observação", também com contador; (3) dividir a largura igualmente entre Resumo e Detalhamento.
- **1) Contador na linha do cabeçalho:** em vez de um `<span>` dentro de cada célula de dados (que ainda ocupava uma linha extra), o contador agora fica **dentro do próprio `<th>`** do cabeçalho (`Resumo do problema * <span id="zk-resumo-head-count">0/32</span>`), como um indicador único e compartilhado por toda a coluna. Passa a refletir o campo que está em foco/edição no momento (evento `input`+`focus` delegado em `.zk-resumo`/`.zk-detal`, atualiza o `<span>` do cabeçalho correspondente). Isso elimina de vez qualquer disputa de altura entre células da mesma linha — o cabeçalho não faz parte do cálculo de altura das linhas de dados.
- **2) Fusão Detalhamento + Observação → "Detalhamento/Observação":**
  - **Banco:** o conteúdo da antiga coluna `obs_cliente` foi **migrado** para `detalhamento` (concatenado com quebra de linha, só quando havia texto) antes de a coluna ser removida — nenhum dado dos 2 chamados de teste existentes foi perdido. Depois: `ALTER TABLE ost_zk_equipment DROP COLUMN obs_cliente;`.
  - **Grade de cadastro/edição:** as colunas "Detalhamento" e "Observação" (2 `<th>`/2 `<textarea>`) viraram uma só, "Detalhamento/Observação" (`zk_detalhamento[]`), com `maxlength="200"` e contador no cabeçalho (`0/200`) no mesmo padrão do Resumo.
  - **Todo o backend ajustado** para não depender mais de `obs`/`obs_cliente`: `zk_equip_on_ticket_created()`, `zk_equip_client_process_edit()` (INSERT/UPDATE), `zk_equip_fill_ticket_vars()` (mensagem automática do chamado), `zk_equip_matching_ticket_ids()` (busca inteligente), e os painéis de exibição (cliente e agente) — a linha "Obs.:"/"Obs. cliente:" separada foi removida, o conteúdo mesclado aparece só na linha "Detalhamento".
  - **Importação em massa (colar do Excel/CSV):** continua aceitando o layout antigo de 5 colunas (Detalhamento e Observação separadas) por compatibilidade — as duas últimas colunas são simplesmente concatenadas ao importar. O texto de ajuda foi atualizado para o novo layout de 4 colunas.
- **3) Larguras iguais:** `.zk-c-resumo` e `.zk-c-detal` (a coluna mesclada) agora usam a mesma largura (`24%` cada) na grade de cadastro/edição.
- **Como reaplicar em versão nova:** reaplicar as edições de `open.inc.php`/`zk-equip-edit.inc.php` (cabeçalho + JS) e as mudanças de `zk_equipment.php` (funções + CSS). A migração de banco (`UPDATE` + `DROP COLUMN`) só é necessária se a instalação nova já tiver dados na coluna `obs_cliente` antiga — senão a tabela já nasce sem essa coluna.
- **Validação feita:** testado ao vivo de ponta a ponta — digitação real mostrando o contador atualizar na linha do cabeçalho (`12/32`, `42/200`); criação de um chamado novo (#456286) com Resumo + Detalhamento/Observação mesclados, exibidos corretamente em uma única linha no painel (sem mais "Obs.:" separado); tela de edição também mostrando o campo já mesclado e os contadores no cabeçalho.
- **Status:** aplicado e testado.

---

#### 2026-07-01 — Login e "Verificar Status do Ticket": cartão pequeno e centralizado

- **Arquivo(s) alterado(s):** `assets/default/css/theme.css` (camada oficial ZKTeco). **Nenhum arquivo PHP tocado.**
- **Motivo/contexto:** as telas de login (`login.php`) e "Verificar Status do Ticket" (`view.php`) usavam a caixa de formulário **esticada por toda a largura da página** — o usuário pediu para essas duas telas (só elas) seguirem o padrão moderno de login pequeno e centralizado (Gmail, WordPress).
- **Como foi escopado sem tocar em PHP:** as únicas duas páginas do sistema que renderizam um elemento com `id="clientLogin"` são exatamente `include/client/login.inc.php` (login) e `include/client/accesslink.inc.php` ("Verificar Status do Ticket") — nenhuma outra tela usa esse id. Isso permitiu usar o seletor moderno **`:has()`** para restringir a mudança a essas duas telas via CSS puro, sem precisar de uma classe nova no PHP:
  ```diff
  + #content:has(#clientLogin) > h1,
  + #content:has(#clientLogin) > p{
  +   text-align:center;
  +   max-width:380px;
  +   margin-left:auto;
  +   margin-right:auto;
  + }
  + #clientLogin{
  +   max-width:380px;
  +   margin:18px auto 0;
  + }
  ```
  A segunda regra (`#clientLogin{ max-width:380px; margin:18px auto 0; }`) sobrescreve a regra antiga (`max-width:var(--zk-form)` = 100%, mais acima no arquivo) por vir depois no CSS — mesma especificidade, ganha a última declarada.
- **Compatibilidade do `:has()`:** suportado por navegadores modernos (Chrome/Edge 105+, Safari 15.4+, Firefox 121+). Como o ambiente de uso é sempre um navegador atual, não há necessidade de fallback — mas registrar aqui caso um dia precise suportar um navegador muito antigo (nesse caso, a alternativa seria adicionar uma classe explícita `zk-centered-form` no `<form>` de cada um dos 2 arquivos PHP).
- **Dependências/impactos:** nenhuma outra tela foi afetada (confirmado visualmente na página inicial `index.php`, que não tem `#clientLogin`). O restante do conteúdo de cada tela (bloco "Sou um atendente" / "Criar conta" dentro do próprio formulário) já ficava empilhado abaixo do card graças a uma regra anterior (`#clientLogin > div > div[style*="table-cell"]`) — com o card mais estreito agora, esse bloco também fica dentro dos mesmos 380px, mantendo a coerência visual.
- **Como reaplicar em versão nova:** copiar o bloco de CSS acima para o `theme.css` novo, na mesma seção (`LOGIN DO CLIENTE`).
- **Validação feita:** testado ao vivo nas duas telas (login e verificar status) — cartão centralizado e estreito, texto do título/descrição centralizado acima dele; conferido que a página inicial (`index.php`) e as demais telas do portal permanecem no layout de largura total, sem nenhuma mudança.
- **Status:** aplicado e testado.

---

#### 2026-07-01 — Registro de conta no padrão ZKTeco + Telefone/WhatsApp com máscara e link direto

- **Arquivo(s) alterado(s):** `include/client/register.inc.php` (core), `include/client/view.inc.php`, `include/staff/ticket-view.inc.php` (core), `include/zk_equipment.php`, `assets/default/css/theme.css`; banco (`ost_form_field`, campo id=3).
- **Motivo/contexto:** a tela "Registro de conta" (`account.php?do=create`) ainda estava 100% no visual de fábrica (tabela de 2 colunas, sem espaçamento, botões crus); pedido para: colocar no padrão das outras telas, remover Fuso Horário e Ramal, transformar o campo Telefone em "Telefone/WhatsApp" com máscara brasileira, e — depois de criado o cadastro — mostrar o telefone como link direto do WhatsApp na tela do agente (e, por extensão, também na do cliente).
- **1) Padronização visual (reaproveitando o CSS do `#ticketForm`, sem duplicar):** o `<form>` de `register.inc.php` passou a usar `id="ticketForm"` **mesmo não sendo o form de abertura de chamado** — como nenhuma outra página usa esse id ao mesmo tempo, e não há nenhum JS no projeto amarrado a `#ticketForm`, isso faz a tela herdar de graça TODO o estilo "ficha" já validado (labels, inputs, botões, espaçamento) sem copiar/colar dezenas de regras CSS. Documentado aqui porque é uma decisão pragmática, não o uso "correto" semântico do id — se um dia isso incomodar, a alternativa é duplicar os seletores `#ticketForm` para um novo `#accountForm` no CSS.
- **Bug encontrado e corrigido (specificity):** mesmo com o id certo, os campos apareciam cortados/sobrepostos — causa: a tabela tinha `class="padded"`, e o CORE já tem uma regra de fábrica `table.padded tr > td, table.padded tr > th { height:20px; }` que nunca tinha sido neutralizada (nenhuma outra tela usava essa classe junto de `#ticketForm`). Como nossa regra de `#ticketForm > table td` nunca definia `height`, a regra de 20px do core ficava livre pra cortar campos com label+input juntos (mais alto que 20px). Corrigido em 2 frentes: removida a classe `padded` da tabela (não fazia falta) **e** adicionado `height:auto !important` na regra `#ticketForm > table td` do tema, para essa pegadinha não se repetir em uma tela futura que reaproveite `#ticketForm`.
- **2) Removido "Fuso Horário":** bloco inteiro (`<tr>` + script de auto-detecção `jstz.min.js`) removido de `register.inc.php`. Sem uso real no dia a dia do cliente.
- **3) Removido "Ramal":** campo de extensão do telefone é uma opção de configuração nativa do tipo de campo `phone` do osTicket (`configuration.ext`, default `true`). Desabilitado via banco: `UPDATE ost_form_field SET configuration='{"ext":false}' WHERE id=3` (campo "phone" do formulário "Informações de contato", `form_id=1`) — efeito colateral **desejado**: também some do Ramal em qualquer outro lugar que use esse mesmo campo (perfil do cliente, etc.), consistente com a decisão de tratá-lo só como WhatsApp.
- **4) Campo renomeado + máscara brasileira:** label do mesmo campo (id=3) alterado no banco para **"Telefone/WhatsApp"**. Máscara aplicada via JS (`register.inc.php`, delegado em `#ticketForm input[type=tel]`, evento `input`): formata progressivamente para `(DD) D DDDD-DDDD` conforme o usuário digita (ex.: `(31) 9 9791-0742`), e também reformata o valor já salvo ao carregar a página (perfil existente). Sem dependência de biblioteca externa — função pura de ~10 linhas.
- **5) Link direto pro WhatsApp:** nova função `zk_whatsapp_url($phone)` em `include/zk_equipment.php` — limpa tudo que não é dígito e prefixa `55` (Brasil) se o número tiver até 11 dígitos, retornando uma URL `https://wa.me/55DDDDDDDDDDD`. Usada em dois pontos:
  - **Cliente** (`include/client/view.inc.php`, box "Informações do Usuário"): a linha "Telefone/WhatsApp:" agora é um link (`target="_blank"`, ícone de telefone) em vez de texto puro.
  - **Agente** (`include/staff/ticket-view.inc.php`): **não existia nenhuma linha de telefone** no painel do agente até esta mudança (o telefone tem a flag `FLAG_EXT_STORED`, que já é excluída do loop genérico de "custom data" tanto no lado do cliente quanto do agente — por isso nunca aparecia ali). Adicionada uma nova linha "Telefone/WhatsApp:" logo abaixo do "Email:", no mesmo padrão visual da linha de e-mail existente, com o mesmo link clicável — poupa o agente de copiar/formatar o número manualmente para abrir uma conversa.
- **Como reaplicar em versão nova:** reaplicar as 3 edições de `register.inc.php` (id do form, remoção do bloco de fuso horário, máscara JS) e a nova linha de telefone em `ticket-view.inc.php` (conferir se a estrutura da linha "Email:" mudou antes de colar a mesma sequência). A função `zk_whatsapp_url()` e a config do campo `ext:false`/label no banco não dependem de arquivo de core.
- **Validação feita:** testado ao vivo — tela de registro com layout limpo (sem fuso horário/ramal, botões no padrão), máscara formatando em tempo real digitando do zero (`31997654321` → `(31) 9 9765-4321`) e também reformatando um valor já salvo ao carregar a página; link do WhatsApp confirmado no lado do **cliente** (`href="https://wa.me/5531997910742"`, verificado via JS no navegador). **Lado do agente não testado visualmente** nesta rodada — sem credencial de staff disponível; o código usa a mesma função já validada no cliente, então o resultado esperado é o mesmo.
- **Status:** aplicado — pendente apenas de conferência visual do lado do agente (SCP) pelo usuário.

---

#### 2026-07-01 — Registro de conta: layout em 2 colunas (Contato | Senha)

- **Arquivo(s) alterado(s):** `include/client/register.inc.php`, `assets/default/css/theme.css`.
- **Motivo/contexto:** depois da padronização visual, a rodada anterior deixou "Informações de Contato" e "Senha de acesso" empilhados um embaixo do outro, com metade da largura da tela sobrando ao lado — usabilidade ruim e desperdício de espaço. Pedido para colocar as duas seções lado a lado (aproveitando o espaço vazio à direita) e, por consequência, os botões sobem automaticamente (o formulário fica bem mais curto).
- **O que foi feito:** as duas seções passaram a ficar cada uma dentro de uma `<table>` própria, envolvidas por `<div class="zk-account-col">` dentro de um wrapper `<div class="zk-account-grid">` (Flexbox, `gap`, `flex-wrap:wrap`). Em telas largas ficam lado a lado; em telas estreitas (celular) empilham automaticamente sem precisar de media query dedicada — é o comportamento natural do `flex-wrap`.
  - O cabeçalho "Access Credentials" (que antes usava um `<h3>` cru, fora do padrão) agora usa a mesma classe `.form-header` já usada em "Informações de Contato" (gerada pelo `$cf->render()`) — os dois títulos de seção ficam visualmente idênticos.
  - Os campos de senha foram reescritos no mesmo padrão `<label>Texto <input></label>` usado pelos campos de contato (antes eram `<td>Label:</td><td>Input</td>` em 2 colunas), por consistência visual entre as duas colunas.
- **Ajuste de CSS necessário:** como as regras que "achatam" a tabela em uma ficha vertical (`#ticketForm > table td{display:block;...}` etc.) usavam o combinador de **filho direto** (`>`), elas paravam de funcionar assim que a tabela passou a ficar aninhada dentro de `.zk-account-col` (um nível a mais de profundidade). Toda regra relevante ganhou uma variante companion `#ticketForm .zk-account-col table ...` ao lado da original `#ticketForm > table ...`, sem remover a original (que continua servindo outras telas, como a abertura de chamado).
- **Como reaplicar em versão nova:** copiar a estrutura de `register.inc.php` (wrapper `.zk-account-grid` com 2 `.zk-account-col`) e as regras de CSS companion listadas acima.
- **Validação feita:** testado ao vivo — layout em 2 colunas lado a lado, botões "Registrar"/"Cancelar" bem mais acima na página (formulário compacto), sem nenhuma quebra visual nos campos.
- **Status:** aplicado e testado.

**Correção (mesmo dia) — cabeçalhos das 2 colunas desalinhados:** o usuário reportou que "Senha de acesso" ficava ~30px mais alto que "Informações de Contato", quebrando o alinhamento visual entre as colunas.
  - **Causa:** a coluna "Informações de Contato" é gerada pelo `$cf->render()` do core, que sempre emite um `<hr>` logo antes do cabeçalho da seção. Esse `<hr>` já era escondido de propósito por uma regra existente (`#ticketForm > table tbody:first-child hr{display:none}`), mas essa regra usa combinador de **filho direto** — quando a tabela passou a ficar dentro de `.zk-account-col` (a mudança desta mesma rodada), ela deixou de bater, e o `<hr>` voltou a aparecer **só na coluna esquerda**, empurrando o cabeçalho dela para baixo. A coluna direita ("Senha de acesso"), por ser HTML escrito à mão sem esse `<hr>`, não tinha o mesmo problema — daí o desalinhamento entre as duas.
  - **Correção:** adicionada a mesma variante companion que faltava: `#ticketForm .zk-account-col table tbody:first-child hr{ display:none; margin:0; }`.
  - **Validação:** conferido via JS no navegador que as duas seções (`.form-header`) ficam exatamente na mesma coordenada vertical (`top: 234.49px` nos dois casos) depois da correção.

---

#### 2026-07-01 — Tela "Gerenciar Perfil" (`profile.php`) no mesmo padrão do registro de conta

- **Arquivo(s) alterado(s):** `include/client/profile.inc.php` (core, **primeira vez que este arquivo é tocado** — não existia backup prévio).
- **Motivo/contexto:** o usuário notou que `profile.php` (editar perfil de uma conta já existente) ainda estava 100% no visual de fábrica — pergunta certeira: "isso já não tinha sido resolvido?" Resposta: não, é um **arquivo diferente** de `account.php?do=create`. Os dois têm praticamente o mesmo formulário (dados de contato + senha), mas são dois arquivos de template separados no core do osTicket (`register.inc.php` para criar conta, `profile.inc.php` para editar uma já existente) — corrigir um não corrige o outro.
- **O que foi feito:** replicado exatamente o mesmo tratamento já validado em `register.inc.php`:
  - `id="ticketForm"` no `<form>` (herda todo o CSS "ficha" já existente).
  - Removida a classe `padded` da tabela.
  - Layout em **2 colunas** (`.zk-account-grid`/`.zk-account-col`): "Informações de Contato" à esquerda; "Senha de Acesso" (Senha Atual/Nova Senha/Confirmar) à direita — e, se o sistema tiver idiomas secundários configurados (`$cfg->getSecondaryLanguages()`), uma 3ª coluna "Preferências" com o seletor de idioma (hoje não é o caso nesta instalação, mas o código já fica pronto caso configurem no futuro).
  - Removido o bloco de **Fuso Horário** por completo (mesma decisão do registro de conta — sem uso real no dia a dia).
  - Removido o botão **"Recomeçar Formulário"** (`<input type=reset>`), mantendo só "Atualizar"/"Cancelar".
  - Máscara de telefone brasileira (`(DD) D DDDD-DDDD`) — mesmo script inline de `register.inc.php`, duplicado aqui porque o projeto ainda não tem um mecanismo de "JS compartilhado entre páginas do cliente" — **oportunidade de refatoração futura**: extrair esse script (12 linhas) para um arquivo `js/zk-phone-mask.js` incluído nas duas páginas, em vez de manter 2 cópias idênticas.
  - Rótulo/Ramal do campo telefone: nenhuma mudança necessária aqui — já são globais (o campo `phone`, form_id=1, é o mesmo em toda a instalação; a config `ext:false` e o label "Telefone/WhatsApp" definidos na rodada anterior já valem para esta tela também).
- **Como reaplicar em versão nova:** mesma receita de `register.inc.php` — usar aquela entrada como referência e aplicar a mesma estrutura aqui, adaptando para o loop `$user->getForms()` (em vez do `$cf` único do registro) e o campo extra de "Senha Atual" (só existe aqui, não no registro).
- **Validação feita:** testado ao vivo — layout idêntico ao do registro de conta, telefone já cadastrado aparece formatado corretamente ao carregar a página, nenhum erro no log.
- **Status:** aplicado e testado.

**Correção (mesmo dia) — colunas de senha desalinhadas com a de contato:** o usuário reportou (nesta tela e, ao investigar, também no registro de conta) que as linhas de "Nova Senha"/"Confirmar a Nova Senha" ficavam mais espaçadas que as de "Nome completo"/"Telefone" ao lado, com o desalinhamento crescendo linha a linha.
  - **Causa:** cada campo de senha tinha um `<span class="error">&nbsp;...</span>` **sempre presente** (mesmo sem erro nenhum) logo depois do `<label>`. Esse `&nbsp;` sozinho já é conteúdo visível e ocupa uma linha própria (o `<label>` é `display:block`, então o span vem depois, em uma nova linha) — cerca de 14px extras **em toda linha de senha**, que iam se acumulando visualmente comparado às linhas de contato (que só mostram esse espaço quando existe erro de verdade).
  - **Correção:** o `<span class="error">` passou a ser condicional — só é impresso quando `$errors[...]` realmente tem uma mensagem — nos dois arquivos (`register.inc.php` e `profile.inc.php`, incluindo o campo de idioma em `profile.inc.php`).
  - **Validação:** conferido via JS no navegador que as linhas das duas colunas alinham (diferença residual de 2-5px, imperceptível) nas duas telas.

---

#### 2026-07-02 — Tela de login vira a porta de entrada única do portal do cliente

- **Arquivo(s) alterado(s):**
  - `login.php` (core)
  - `include/client/login.inc.php` (core)
  - `index.php` (core)
  - `include/class.nav.php` (core)
  - `assets/default/css/theme.css`
  - Banco (`ost_content`): novo registro `type='banner-client'`, id=15.
- **Backups:** `login.php.original-backup`, `include/client/login.inc.php.original-backup`, `index.php.original-backup`, `include/class.nav.php.original-backup` (primeira vez que estes 4 arquivos são tocados — nenhum tinha backup prévio).
- **Motivo/contexto:** pedido do usuário para simplificar a "porta de entrada" do portal. Antes, a tela de login mostrava um menu completo (Página Principal / Abrir Novo Ticket / Verificar Status do Ticket), um texto de boas-vindas longo (herdado do texto padrão de instalação), um link discreto "Sou um atendente — Identifique-se aqui" (expondo o link de login da equipe/agentes ao público) e um link de "Criar uma conta" pouco visível. Decisão de negócio: **o cliente precisa logar (ou criar conta) antes de abrir ou acompanhar um chamado** — não deve mais existir um caminho de "página inicial" separada, nem promover abertura de chamado anônima/sem login na tela de entrada.
- **O que foi feito:**
  1. **`login.php`** — o bloco morto `if (!$nav) { $nav = new UserNav(); ... }` (nunca executava de fato, pois `client.inc.php` sempre populava `$nav` antes) foi substituído por `$nav = false;` incondicional. Isso remove completamente a `<ul id="nav">` e também o texto "Convidado | Entrar" do canto superior direito (ambos controlados pela mesma variável `$nav` em `include/client/header.inc.php`).
  2. **`include/client/login.inc.php`**:
     - Removido o bloco `<div><b>Sou um atendente</b> — <a href=".../scp/">sign in here</a></div>` — o link de login da equipe (`scp/`) não fica mais público nesta tela (o agente usa um link direto, fora da tela do cliente).
     - O link de texto "Not yet registered? Create an account" virou um **botão de destaque** (`<div class="zk-create-account-box"><p class="zk-create-account-hint">Ainda não tem uma conta?</p><a class="zk-create-account-btn">Criar minha conta</a></div>`), do mesmo tamanho visual do botão "Entrar", mas em cinza-grafite (`--zk-graphite`) para diferenciar hierarquia (login = ação primária/verde, criar conta = ação secundária/grafite, mas igualmente clicável e óbvia).
     - Removido o parágrafo final "If this is your first time contacting us... please open a new ticket" (não faz mais sentido incentivar abertura de chamado sem login nesta tela).
  3. **Banco (`ost_content`)** — criado um novo registro `type='banner-client'` (id=15, nome "Bem-vindo à Central de Suporte ZKTeco", corpo "Abra e acompanhe seus chamados de manutenção de equipamentos ZKTeco. Faça login ou crie sua conta para começar."). Esse tipo de página é lido nativamente por `login.inc.php` via `Page::lookupByType('banner-client')` — **por isso não foi preciso hardcodar o texto no PHP**: o título (`<h1>`) e corpo (`<p>`) da tela de login agora vêm desse registro e podem ser editados a qualquer momento por **Admin Panel → Gerenciar → Páginas**, sem tocar em código. Antes desse registro, o osTicket usava o texto padrão de fábrica em inglês (traduzido via pacote de idioma) — "To better serve you, we encourage our clients to register...".
  4. **`include/class.nav.php`** (classe `UserNav::getNavLinks()`) — removida a linha `$navs['home'] = [...index.php...]`. Efeito: o menu do portal do cliente (renderizado em `include/client/header.inc.php`) **nunca mais mostra "Página Principal"**, em nenhuma tela (logado ou não). Depois de logado, o menu passa a ter só **"Abrir Novo Ticket"** e **"Chamados (N)"**.
  5. **`index.php`** — não faz mais sentido como "página inicial" separada (não há mais link "Página Principal" apontando pra cá, e o conteúdo de boas-vindas se mudou para a tela de login). O arquivo foi reduzido a um **redirecionamento**: cliente logado (e não-guest) → `tickets.php`; caso contrário → `login.php`. Mantido como arquivo (em vez de apagado) só para não quebrar links/favoritos antigos para `index.php`.
  6. **`assets/default/css/theme.css`** — adicionadas as regras `.zk-create-account-box`, `.zk-create-account-hint` e `.zk-create-account-btn` (botão full-width, fundo grafite, texto branco, mesmo padding/raio do botão "Entrar").
- **Dependências/impactos:**
  - `view.php` (tela de "Verificar Status do Ticket" via link mágico de e-mail) **não foi alterada** — continua funcionando normalmente para quem chega por um link de e-mail já existente; só não é mais **divulgada** como opção na tela de login/menu.
  - `account.php?do=create` (registro de conta) **não foi alterado** — continua com o menu padrão (sem "Página Principal", mas ainda com "Abrir Novo Ticket"/"Verificar Status", pois é uma tela de cadastro, fora do escopo pedido nesta rodada).
  - **Não foi mexido** na configuração nativa "Registration Required" / `clients_only` (Admin Panel → Configurações → Usuários → "Exigir registro e login para criar chamados"). Ela está **desligada** hoje — ou seja, tecnicamente `open.php` ainda aceita a criação de chamado por convidado se alguém acessar a URL diretamente (o que só deixou de acontecer **pela tela de login**, que agora não linka mais pra lá). Se a intenção for bloquear isso de verdade no backend (não só escondido da UI), é só marcar aquele checkbox — o próprio `open.php` (linhas 71-82) já teria toda a lógica pronta pra redirecionar convidados para o login. Ficou como decisão em aberto para o usuário (mudança de regra de negócio, não só visual).
- **Como reaplicar em versão nova:**
  - Reaplicar os 4 blocos de código acima (`login.php`, `login.inc.php`, `index.php`, `class.nav.php`) conferindo antes se a estrutura desses arquivos mudou na versão nova.
  - Colar o bloco `.zk-create-account-*` no final da camada ZKTeco do `theme.css` (ou copiar o arquivo inteiro).
  - O registro `banner-client` em `ost_content` **migra sozinho** se o banco for reaproveitado; se for banco novo, recriar via **Admin Panel → Gerenciar → Páginas → Adicionar Página** (tipo "Banner (Cliente)"/`banner-client`) com o mesmo texto.
- **Validação feita:** testado ao vivo no navegador — tela de login sem menu, sem link de agente, com botão "Criar minha conta" em destaque e texto de boas-vindas reduzido (screenshot conferido); `account.php?do=create` continua funcionando; `index.php` redireciona corretamente.
- **Status:** aplicado e testado (pendência: decidir se ativa `clients_only` para reforçar a exigência de login também no backend — ver item de dependências acima).

**Correção (mesmo dia) — título redundante:** o usuário apontou que o título "Bem-vindo à Central de Suporte ZKTeco" repetia o nome que já aparece no cabeçalho da página (ex.: "CENTRAL DE MANUTENÇÃO"/nome do helpdesk configurado). Ajustado via banco (`ost_content`, registro `banner-client` id=15): campo `name` trocado de "Bem-vindo à Central de Suporte ZKTeco" para apenas **"Bem-vindo"**. O corpo do texto (parágrafo explicativo) não mudou. Como é conteúdo de banco (Admin Panel → Gerenciar → Páginas), não foi necessário tocar em nenhum arquivo PHP.

**Ajuste (mesmo dia) — nome do sistema visível ao lado da logo:** o usuário mostrou que a logo sozinha (sem nenhum texto ao lado) não deixava claro qual sistema é esse — pediu um título "CENTRAL DE MANUTENÇÃO" junto da logo, no cabeçalho.
- **Arquivo(s) alterado(s):** `include/client/header.inc.php` (core, primeira vez tocado — backup `include/client/header.inc.php.original-backup` criado) + `assets/default/css/theme.css`. Banco (`ost_config`): `helpdesk_title` trocado de "ZKTeco - Manutenção" para **"Central de Manutenção"**.
- **O que foi feito:** adicionado `<h1 id="site-title"><?php echo Format::htmlchars($title); ?></h1>` logo depois do `<a id="logo">` em `header.inc.php` — reaproveita a mesma variável `$title` que já era usada só no `<title>` da aba do navegador (`$cfg->getTitle()`), agora também exibida visivelmente no cabeçalho. Como o texto vem do `helpdesk_title` (configurável em **Admin Panel → Configurações → Empresa**), o valor foi atualizado no banco para refletir o nome pedido — isso muda o cabeçalho **e** o título da aba do navegador ao mesmo tempo (mesma fonte, sem duplicar configuração). CSS novo (`#header #site-title`) posiciona o texto ao lado da logo, com uma linha divisória fina, negrito, maiúsculas, na cor grafite ZKTeco (`--zk-graphite`) — e some em telas pequenas (`<=768px`) para não brigar de espaço com a logo no celular.
- **Dependências/impactos:** o texto aparece em **todas** as páginas do portal do cliente (login, tickets, abrir chamado, perfil etc.), pois `header.inc.php` é compartilhado. O rodapé continua mostrando "ZKTeco - Manutenção" no copyright porque usa o campo separado "Nome da Empresa" (`ost_form_entry_values`), não o `helpdesk_title` — os dois podem ficar com nomes diferentes sem problema (um é o nome do sistema/portal, o outro é a razão social exibida no rodapé).
- **Como reaplicar em versão nova:** reaplicar o `<h1 id="site-title">` em `header.inc.php` (conferir se a estrutura do bloco do logo mudou) + colar a regra `#header #site-title` no `theme.css`. O valor de `helpdesk_title` é config pura, refaz-se pela tela normal (**Admin Panel → Configurações → Empresa → Nome do Sistema**).
- **Validação feita:** testado ao vivo — "CENTRAL DE MANUTENÇÃO" aparece ao lado da logo na tela de login, alinhado verticalmente, com a mesma linha verde do topo intacta.
- **Status:** aplicado e testado.

**Ajuste (mesmo dia) — centralizar título e limpar a divisória cabeçalho/corpo:** o usuário pediu duas coisas: (1) centralizar "CENTRAL DE MANUTENÇÃO" no cabeçalho (antes ficava colado à direita da logo, à esquerda da faixa); (2) a linha que separa cabeçalho do corpo na tela de login estava "amadora".
- **Arquivo(s) alterado(s):** só `assets/default/css/theme.css` (nenhum PHP tocado nesta rodada).
- **Centralização do título:** `#header #site-title` trocou de `display:inline-block` (colado à logo) para `position:absolute; top:50%; left:50%; transform:translate(-50%,-50%);` — como `#header` já é `position:relative`, o título fica centralizado na faixa inteira, sem disputar espaço com a logo (esquerda) nem com o bloco de sessão/idiomas (direita). `pointer-events:none` evita que ele "roube" cliques da área do cabeçalho. Breakpoint de esconder em telas pequenas ajustado de `768px` para `900px` (título centralizado precisa de mais espaço livre nas laterais do que o antigo, colado à logo).
- **Divisória cabeçalho→corpo:** a causa da aparência "amadora" era que, nas telas sem menu (`$nav=false`, ex.: login), o core do osTicket imprime um `<hr>` cru sem nenhum CSS de reset — o navegador aplica o estilo padrão dele (um "sulco 3D" com borda inset), que destoa completamente do resto do layout flat/moderno. Corrigido com `#container > hr{ height:1px; border:0; margin:0; background:var(--zk-line); }` — vira um traço fino de 1px na mesma cor de linha usada em todo o resto do tema, coerente com a "faixa contínua" do design. Seletor escopado (`#container > hr`, filho direto) para não afetar nenhum outro `<hr>` da aplicação (ex.: dentro de formulários).
- **Como reaplicar em versão nova:** copiar as duas regras (`#header #site-title` atualizada e `#container > hr`) para a camada ZKTeco do `theme.css` novo.
- **Validação feita:** testado ao vivo — título centralizado na tela de login; conferido também em `account.php` (tela com menu, que usa `#nav` em vez do `<hr>`) para garantir que a centralização não colide com o menu nem com o bloco de sessão no canto superior direito.
- **Status:** aplicado e testado.

**Ajuste (mesmo dia) — remover o menu também na tela de "Criar conta":** o usuário notou que `account.php?do=create` (registro de novo cliente) ainda mostrava o menu escuro (Abrir Novo Ticket / Verificar Status do Ticket) — inconsistente com a tela de login, que já não tem mais menu algum. Pedido: mesmo visual/tratamento da tela inicial.
- **Arquivo(s) alterado(s):** `account.php` (core, primeira vez tocado — backup `account.php.original-backup` criado).
- **O que foi feito:** antes do `include(CLIENTINC_DIR.'header.inc.php')`, adicionado `if (in_array($inc, array('register.inc.php', 'register.confirm.inc.php'))) $nav = false;`. Ou seja, **só** as duas telas do fluxo de "ainda não tenho conta" (formulário de registro e a tela de confirmação "verifique seu e-mail" logo depois de enviar) ficam sem menu — herdam automaticamente o mesmo tratamento visual do login (sem `#nav`, com o `<hr>` fino já estilizado, título centralizado). **Não afeta** `profile.inc.php` (cliente já logado editando o próprio perfil) nem `register.confirmed.inc.php` (conta já confirmada) — essas continuam com o menu normal de cliente autenticado ("Abrir Novo Ticket"/"Chamados"), porque nesses casos a pessoa já tem conta e está navegando dentro do portal, não mais na "porta de entrada".
- **Dependências/impactos:** nenhum — é reaproveitamento 100% do CSS/lógica de `$nav=false` já criada para o login (`#container > hr`, `#header #site-title` centralizado). O formulário de registro em si (2 colunas, largura, etc.) não foi alterado — só o cabeçalho/menu acima dele.
- **Como reaplicar em versão nova:** reaplicar a condição de `$nav = false` em `account.php` antes do include do header, conferindo se os nomes dos templates (`register.inc.php`/`register.confirm.inc.php`) continuam os mesmos na versão nova.
- **Validação feita:** testado ao vivo, deslogado — `account.php?do=create` sem menu, com a mesma divisória fina e título centralizado do login. Testado também logado (perfil de `julianotorres@gmail.com`) para confirmar que `profile.inc.php` continua mostrando o menu normalmente.
- **Status:** aplicado e testado.

---

#### 2026-07-02 — Login obrigatório de verdade (backend) para abrir/acompanhar chamado + remoção de "Verificar Status do Ticket"

- **Motivo/contexto:** o usuário descobriu, testando, que ainda dava pra chegar em `open.php` e `view.php` diretamente pela URL **mesmo sem estar logado** — as mudanças anteriores (tela de login sem menu, "Página Principal" removida) eram só de navegação/visual, não impediam o acesso direto por link. Pedido explícito: (1) bloquear esse acesso de verdade; (2) remover "Verificar Status do Ticket" por completo — não serve pra esse uso, já que login vai ser sempre exigido; (3) "Abrir Novo Ticket" só pode aparecer depois de logado; (4) se o cliente conseguir de algum jeito o link de uma página que exige login mas não estiver autenticado, **sempre** tem que cair na tela de login.
- **Arquivo(s) alterado(s):**
  - Banco (`ost_config`): novo registro `clients_only = '1'` (namespace `core`) — não existia essa linha antes (o padrão de fábrica é `false`/desligado). Esse é o **mesmo checkbox nativo** do osTicket em **Admin Panel → Configurações → Usuários → "Registro Obrigatório" ("Exigir registro e login para criar chamados")** — só que setado direto via banco por já ter sido diagnosticado nesta conversa que a UI ainda não tinha sido usada para isso. Essa é a peça que faltava: com ela desligada, `open.php` (que **já tinha** toda a lógica pronta no core, linhas 20-25 e 71-82, checando `$cfg->isClientLoginRequired()`) nunca chegava a barrar ninguém.
  - `view.php` (core, primeira vez tocado — backup `view.php.original-backup` criado).
  - `include/class.nav.php` (`UserNav::getNavLinks()`).
- **O que foi feito:**
  1. **`clients_only=1` no banco** — com isso, `open.php` passa a redirecionar de verdade quem não está logado (ou é convidado) para `login.php` (via `secure.inc.php` → `clientLoginPage()`, que também guarda a URL de destino em `$_SESSION['_client']['auth']['dest']` — depois do login, o cliente cai automaticamente de volta em `open.php`, não precisa navegar de novo). Cobre tanto acesso direto (GET) quanto tentativa de enviar o formulário (POST) por alguém sem sessão.
  2. **`view.php`** — o trecho final que sempre montava e mostrava um formulário manual de "Verificar Status do Ticket" (e-mail + número do chamado) foi substituído por um redirecionamento simples: cliente já autenticado (não-convidado) → `tickets.php`; qualquer outro caso (sem login, ou convidado) → `login.php`. **Importante:** a parte de cima do arquivo (que processa o link mágico de acesso vindo por e-mail — `$_GET['auth']`/`$_GET['t']`, usado nas notificações de ticket) **não foi tocada** — continua funcionando normalmente para quem chega por um link já emitido; só o formulário manual de busca (para quem chega sem nenhum token) deixou de existir.
  3. **`include/class.nav.php`** — `getNavLinks()` reescrito: **"Abrir Novo Ticket" só aparece se houver um `$user` válido e não-convidado** (antes aparecia pra qualquer um, bastava o registro de conta não estar desabilitado). O ramo `else { $navs['status'] = ... }` (que criava o link "Verificar Status do Ticket" → `view.php` pra quem não estava logado) foi **removido por completo** — sem login, o menu não tem absolutamente nenhum item (o que é coerente: sem login, o cliente já está sendo redirecionado pra tela de entrada de qualquer forma, não faz sentido mostrar itens de menu que ele nunca vai conseguir usar).
- **Dependências/impactos:**
  - `include/client/accesslink.inc.php` (o formulário de "informe e-mail + nº do chamado") fica **órfão** — ainda existe como arquivo (não foi apagado) e ainda é tecnicamente alcançável via `login.php` se alguém enviar um POST manual com `lticket` preenchido, mas não há mais nenhum link/botão na interface que leve até ele. Deixado como está (sem apagar o arquivo) por segurança — remover de vez fica pra uma limpeza futura, se quiserem.
  - `include/client/templates/sidebar.tmpl.php` (usado pela antiga página inicial `index.php`) também ficou órfão desde a mudança anterior (`index.php` virou redirect); não tinha uso nesta rodada.
  - Não afeta o link mágico de acesso via e-mail (token `auth`/`t`) que as notificações de ticket usam — só a busca manual.
- **Como reaplicar em versão nova:**
  - `clients_only=1` é config pura: marcar o checkbox **"Registro Obrigatório"** em **Admin Panel → Configurações → Usuários** na instalação nova (não precisa de SQL se for feito pela tela).
  - Reaplicar os blocos de `view.php` e `class.nav.php` acima, conferindo se a estrutura desses arquivos mudou.
- **Validação feita:** testado ao vivo, deslogado — `view.php` redireciona para `login.php`; `open.php` também redireciona (mostra a tela de login sem trocar a URL da barra de endereço, graças ao `secure.inc.php`); menu de `account.php?do=create` (deslogado) não mostra mais nenhum item de "abrir ticket"/"verificar status".
- **Status:** aplicado e testado.

---

#### 2026-07-02 — Correção: card do comentário (thread) estourando a largura da página

- **Arquivo(s) alterado(s):** `assets/default/css/theme.css`.
- **Motivo/contexto:** o usuário reportou, na tela de um chamado (`tickets.php?id=7`), que o card do comentário/thread ("Fulano postou..." com o corpo da mensagem) ultrapassava a largura da página e não era responsivo — a caixa ficava visivelmente mais larga que a tabela de "Equipamentos" acima e o campo "Postar uma resposta" abaixo.
- **Causa raiz:** o core do osTicket, quando a entrada de thread tem avatar, usa um truque de layout com margens opostas: `.thread-entry.avatar{ margin-left:60px; }` no balão e `.thread-entry > .avatar{ margin-left:-60px; width:48px; }` na miniatura — a miniatura "sai" para a esquerda no vão aberto pela margem do balão. Uma customização anterior (registro "Layout geral do portal do cliente") tinha forçado `.thread-entry{ width:100% !important; }` para o balão não ficar estreito. O problema: **margem não entra na conta do `width:100%`** — então o balão ficava com `100% + 60px` de largura (100% da largura do container + a margem de 60px "por fora"), estourando o container à direita nesse tanto.
- **O que foi feito:**
  ```diff
    .thread-entry{
  -   width:100% !important;
  +   width:auto !important;
      max-width:none !important;
      box-sizing:border-box;
    }
  ```
  Com `width:auto`, o navegador calcula sozinho a largura correta: **largura do container menos as margens** (60px de um lado ou do outro, dependendo se é `.avatar` ou `.avatar.response`) — exatamente o comportamento nativo do CSS para blocos em fluxo normal, sem os 60px "de graça" que o `100%` estava adicionando por cima.
- **Dependências/impactos:** nenhum — `.thread-entry .thread-body{ width:auto !important; }` (linha logo abaixo) já usava `auto` desde antes; agora as duas regras são consistentes. Não afeta a versão "sem avatar" (sem `margin-left`/`margin-right`), que já ficava correta com `width:auto` (equivale a 100% quando não há margem).
- **Como reaplicar em versão nova:** trocar `width:100% !important` por `width:auto !important` na regra `.thread-entry` do `theme.css` novo (ou copiar o arquivo inteiro).
- **Validação feita:** testado ao vivo no chamado real `#456286` (`tickets.php?id=7`) — o card do comentário agora alinha exatamente com a tabela de equipamentos e a caixa "Postar uma resposta", sem estourar a largura da página.
- **Status:** aplicado e testado.

---

#### 2026-07-02 — Remoção da importação em lote (colar do Excel/CSV) na abertura de chamado

- **Arquivo(s) alterado(s):** `include/client/open.inc.php`, `include/zk_equipment.php`.
- **Motivo/contexto:** pedido do usuário para remover o recurso "Importar vários de uma vez (colar do Excel ou CSV)" da tela de abertura de chamado — não é mais necessário para o fluxo atual.
- **O que foi feito:**
  - Removido o bloco HTML `<details class="zk-import">...</details>` (o "sanfona" com a área de colar/anexar CSV) de `open.inc.php`.
  - Removidas as funções JS que só existiam para esse recurso: `looksLikeHeader()`, `parseDelimited()`, `parseCsvLine()`, `importText()`, e os handlers de evento `#zk-paste-go` (clique), `#zk-paste` (colar) e `#zk-csv` (seleção de arquivo).
  - Removido o CSS órfão correspondente em `include/zk_equipment.php` (`.zk-import`, `.zk-import-body`, `.zk-import-hint`, `#zk-paste`, `.zk-import-actions`, `.zk-import-msg`, `.zk-file-label`).
  - **Não foi tocado** o restante da grade de equipamentos: `addRows()`/`addEmpty()` (usadas por "+ Adicionar equipamento" e "+ 10 linhas"), a serialização no submit (`collect()`) e a geração automática de Assunto/Mensagem continuam exatamente como estavam — o recurso removido era só uma forma alternativa (colar/CSV) de preencher a mesma grade, não uma dependência dela.
- **Dependências/impactos:** nenhum. Testado ao vivo: a grade de equipamentos, os botões "+ Adicionar equipamento"/"+ 10 linhas"/"Limpar" e a submissão do chamado continuam funcionando normalmente, sem erros no console do navegador.
- **Como reaplicar em versão nova:** remover os mesmos trechos (bloco `<details class="zk-import">`, as 4 funções JS, os 3 handlers de evento, e as regras CSS `.zk-import*`/`#zk-paste`/`.zk-file-label`) do `open.inc.php`/`zk_equipment.php` novos.
- **Validação feita:** testado ao vivo — seção de importação não aparece mais; "+ Adicionar equipamento" continua criando novas linhas normalmente; sem erros no console.
- **Status:** aplicado e testado.

---

#### 2026-07-02 — Foto do equipamento abre em pop-up (lightbox) em vez de nova aba

- **Arquivo(s) alterado(s):** `include/zk_equipment.php` (função `zk_equip_styles()`).
- **Motivo/contexto:** ao clicar na miniatura da foto do equipamento (tabela "Equipamentos" do chamado), o link (`<a class="zk-photo-thumb" target="_blank">`) abria a imagem em **nova aba do navegador**. Pedido para abrir em pop-up (lightbox) na própria página.
- **O que foi feito:** como `zk_equip_styles()` já é a função que imprime o CSS compartilhado dos painéis de equipamento (cliente e agente) **uma única vez por página** (guardada por `static $done`), foi o lugar natural pra acrescentar, no mesmo bloco:
  - CSS de um overlay `.zk-lightbox` (fundo escurecido, tela cheia, `z-index` alto) com a imagem centralizada (`max-width`/`max-height` responsivos) e um botão "×" de fechar.
  - O HTML do próprio overlay (`<div id="zk-lightbox">`), impresso uma vez.
  - Um pequeno script jQuery que: intercepta o clique em qualquer `a.zk-photo-thumb` (`preventDefault()` — não deixa mais abrir nova aba), coloca o `href` da foto como `src` da imagem do pop-up e mostra o overlay (`fadeIn`); fecha ao clicar fora da imagem (no fundo escurecido) ou no "×"; fecha também com a tecla **Esc**.
  - O atributo `target="_blank"` do link **não foi removido** — fica como fallback (ex.: clique com o botão direito → "abrir em nova aba" continua funcionando; e se por algum motivo o JS não carregar, o link ainda funciona da forma antiga em vez de ficar morto).
- **Dependências/impactos:** como a função é compartilhada, o pop-up funciona automaticamente em **qualquer tela que renderize fotos de equipamento** — chamado do cliente (`view.inc.php`), tela de editar equipamentos (`zk-equip-edit.inc.php`) e o painel do agente (`ticket-view.inc.php`, quando implementado/testado do lado da equipe) — sem precisar duplicar o código em cada uma.
- **Como reaplicar em versão nova:** copiar o bloco de CSS+HTML+JS acrescentado ao final de `zk_equip_styles()` em `zk_equipment.php` novo.
- **Validação feita:** testado ao vivo no chamado real `#279676` — clique na foto abre o pop-up com a imagem grande sobre fundo escurecido (sem abrir nova aba); clique fora da imagem fecha o pop-up corretamente.
- **Status:** aplicado e testado (fechar com Esc não foi testado manualmente no navegador, mas é o mesmo padrão simples de handler — baixo risco).

---

#### 2026-07-02 — Pop-up "Por favor, aguarde!" na paleta ZKTeco

- **Arquivo(s) alterado(s):** `assets/default/css/theme.css`.
- **Motivo/contexto:** o pop-up nativo do osTicket que aparece durante ações assíncronas (`#loading`, com o título "Por favor, aguarde!") usa cores genéricas de fábrica — borda azul (`#2a67ac`) e título laranja (`#d80`) — destoando da identidade ZKTeco.
- **O que foi feito:** adicionadas duas regras novas (`#loading` e `#loading h4`) trocando a borda para verde ZKTeco (`--zk-green`) e a cor do título para o verde escuro (`--zk-green-dk`), além de arredondar os cantos (`border-radius:8px`) e trocar a sombra pesada padrão por uma mais suave (`box-shadow` leve), consistente com o resto dos cards do tema (login, formulários etc.).
- **Dependências/impactos:** só CSS, nenhum arquivo PHP tocado — o markup do pop-up (`include/client/footer.inc.php`) não muda. **Não foi alterado** o ícone giratório (spinner GIF, `FhHRx-Spinner.gif`), que continua na cor original (avermelhado) — é uma imagem estática, recolorir exigiria trocar o arquivo de imagem ou aplicar um filtro CSS que também afetaria o texto; ficou fora do escopo desta rodada (o pedido era sobre "as cores" do pop-up em geral, atendido pela borda/título).
- **Como reaplicar em versão nova:** copiar as duas regras `#loading`/`#loading h4` para a camada ZKTeco do `theme.css` novo.
- **Validação feita:** testado ao vivo (pop-up forçado a aparecer via console para inspeção, já que ele normalmente só pisca rápido durante o carregamento/envio de formulário) — borda e título aparecem em verde.
- **Status:** aplicado e testado.

---

#### 2026-07-02 — Todos os campos + pelo menos 1 foto obrigatórios na abertura de chamado

- **Arquivo(s) alterado(s):** `include/client/open.inc.php`, `include/zk_equipment.php`.
- **Motivo/contexto:** pedido do usuário: "Para abertura do ticket será obrigatório ter pelo menos uma foto, todos os campos também precisam ser obrigatórios." Antes, só **Modelo** e **Nº de Série** eram exigidos (e de forma "tudo ou nada" — só bloqueava se um estivesse preenchido e o outro não); **Resumo do problema** tinha asterisco visual mas **não era validado de verdade**; **Detalhamento/Observação** e **Fotos** eram totalmente opcionais, sem nenhuma checagem em lugar nenhum (nem cliente, nem servidor).
- **O que foi feito (client-side, `open.inc.php`):**
  - Cabeçalho da grade: adicionado `<span class="required">*</span>` em "Detalhamento/Observação" e "Fotos" (antes só Modelo/Série/Resumo tinham o asterisco).
  - Texto de instrução acima da grade atualizado para "Todos os campos e pelo menos 1 foto são obrigatórios."
  - Validação do submit (`#ticketForm`) reescrita: agora, toda linha "iniciada" (isto é, com **qualquer** campo preenchido ou foto anexada) precisa ter **Modelo, Série, Resumo E Detalhamento/Observação preenchidos, mais pelo menos 1 das 2 fotos anexada** (detecção de foto via a classe `zk-has-file`, já aplicada pelo próprio JS existente quando um arquivo é selecionado). Linhas 100% em branco (sobra do botão "+10 linhas") continuam sendo ignoradas silenciosamente, sem forçar o usuário a apagá-las.
  - CSS (`zk_equipment.php`): a classe `.zk-invalid` (que já pintava a borda de Modelo/Série de vermelho) agora também pinta Resumo, Detalhamento/Observação e os botões de foto sem arquivo — o usuário vê exatamente quais campos faltam na linha destacada.
- **Bug colateral encontrado e corrigido (importante):** o osTicket tem um handler JS **global** (`js/osticket.js`, bind em `$(document).ready`) que, em **qualquer** submit de **qualquer** formulário do site, sempre desabilita e esconde o botão de envio e mostra o pop-up "Por favor, aguarde!" — **mesmo quando a nossa validação bloqueia o envio com `preventDefault()`**, porque `preventDefault()` não impede outros handlers de rodarem no mesmo evento, só impede a ação padrão do navegador (o envio de fato). Como a regra antiga (Modelo/Série "tudo ou nada") raramente disparava na prática, esse travamento passava despercebido; com a validação agora bem mais abrangente, o usuário ficaria facilmente com a tela travada no "aguarde" e sem o botão. Corrigido com uma função `undoNativeSubmitLock()` chamada nos dois pontos de bloqueio, que via `setTimeout(fn, 0)` (executa só depois que todos os handlers de submit já rodaram) esconde o pop-up de novo e remove/reexibe o botão de envio.
- **O que foi feito (server-side, `zk_equipment.php`, defesa em profundidade):**
  - Nova função `zk_equip_photo_present($photoKey)` — verifica (sem salvar) se existe pelo menos 1 arquivo de imagem válido enviado para os 2 slots de foto daquela linha (mesma checagem de erro/`tmp_name` já usada em `zk_equip_save_uploaded_photos()`).
  - Dentro de `zk_equip_on_ticket_created()` (persistência ao criar o chamado): a condição que decidia se uma linha era salva mudou de `if ($modelo === '' && $serie === '') continue;` (aceitava se **qualquer um** dos dois estivesse preenchido) para `if ($modelo === '' || $serie === '' || $resumo === '' || $detal === '' || !zk_equip_photo_present($photoKey)) continue;` — agora **todos** os campos de texto precisam estar preenchidos **e** precisa haver pelo menos 1 foto válida, senão a linha inteira é descartada silenciosamente (mesmo padrão de "ignora linha inválida" já usado antes, só que com critério mais rígido).
  - **Não foi alterado** `zk_equip_fill_ticket_vars()` (o fallback que gera Assunto/Mensagem automáticos quando o JS não roda) — continua com a regra antiga (modelo OU série), porque essa função só serve pra gerar um texto de exibição razoável, não é o portão de validação real.
  - **Escopo desta rodada:** só a tela de **abertura** de chamado (`open.inc.php` / `zk_equip_on_ticket_created`), conforme pedido. A tela de **editar equipamentos de um chamado já aberto** (`zk-equip-edit.inc.php` / `zk_equip_client_process_edit()`) **não foi tocada** — continua aceitando linhas com só Modelo OU Série preenchidos, sem exigir foto. Ficou como decisão em aberto: se quiser a mesma regra lá também, é só pedir.
- **Dependências/impactos:** nenhum quebrado — testado que `+ Adicionar equipamento`/`+10 linhas`/`Limpar` continuam funcionando, e que uma linha 100% vazia não trava o formulário.
- **Como reaplicar em versão nova:** reaplicar os 2 blocos de validação client-side (`open.inc.php`), a função `undoNativeSubmitLock()`, a nova função `zk_equip_photo_present()` e a condição atualizada em `zk_equip_on_ticket_created()` (`zk_equipment.php`), conferindo a estrutura desses arquivos na versão nova.
- **Validação feita:** testado ao vivo — grade vazia bloqueia com mensagem "Adicione ao menos um equipamento..."; linha com Modelo+Série mas sem Resumo/Detalhamento/Foto bloqueia com as 4 células destacadas em vermelho e a mensagem certa; em ambos os casos o pop-up "aguarde" e o botão "Criar Chamado" voltam ao normal (sem travar). **Caminho de sucesso confirmado** posteriormente pelo próprio usuário: chamado real `#563163` ("SpeedFace M4", com todos os campos preenchidos e 1 foto anexada) foi criado normalmente — fluxo completo (client-side + server-side) funcionando ponta a ponta.
- **Status:** aplicado e testado (bloqueio de dados incompletos e caminho de sucesso completo, ambos confirmados).

**Correção (mesmo dia) — botão "Criar Chamado" pulava para o topo da página ao bloquear o envio:** o usuário reportou (com print antes/depois) que, ao tentar enviar com campos faltando, o botão "Criar Chamado" reaparecia no **topo da página** (acima até do bloco "Solicitante"), em vez de ficar embaixo da grade onde sempre esteve.
- **Causa:** o `undoNativeSubmitLock()` criado na correção anterior só *mostrava de novo* (`.show()`) o botão original escondido pelo handler global do `osticket.js` — mas esse handler, além de esconder o botão, também o **move** para o topo do formulário via `form.prepend($(this))` (para colocar o clone desabilitado "no lugar" do botão real durante o envio). Como o `undoNativeSubmitLock()` não devolvia o botão pra posição original, ele voltava visível, porém preso lá no topo (onde tinha sido movido).
- **Correção:** `undoNativeSubmitLock()` agora usa o próprio clone desabilitado como "marcador" da posição original (ele foi inserido bem ali, com `insertBefore`, antes do botão real ser movido) — move o botão real de volta pra logo antes do clone (`$real.insertBefore($clone.first())`) e só depois remove o clone e mostra o botão real. Resultado: o botão volta exatamente pro lugar de sempre (embaixo da grade/mensagem de erro).
- **Validação feita:** testado ao vivo, repetindo o mesmo cenário do print do usuário (Modelo/Série/Resumo preenchidos, Detalhamento e Foto faltando) — o botão "Criar Chamado" permanece no lugar correto após o bloqueio.
- **Status:** aplicado e testado.

---

#### 2026-07-02 — Status inicial do equipamento renomeado de "Recebido" para "Aguardando"

- **Arquivo(s) alterado(s):** `include/zk_equipment.php` (função `zk_equip_statuses()`, linha do status `recebido`).
- **Motivo/contexto:** pedido do usuário: todo equipamento de um chamado aberto pelo cliente deve nascer com o status **"Aguardando"** (esperando o agente olhar/manipular), em vez de "Recebido". A manipulação de status pelo agente (avançar para "Em análise", "Aguardando peça", "Reparado" etc.) é um trabalho futuro, ainda não feito nesta sessão.
- **O que foi feito:** troca de **apenas o rótulo (label)** exibido — a chave interna do status continua `recebido` (usada no banco, em filtros, na lógica de "concluído"/`done`), só o texto mostrado ao cliente e ao agente mudou de "Recebido" para "Aguardando":
  ```diff
  - 'recebido' => array('label' => 'Recebido',   'color' => '#9aa0a6', 'done' => false),
  + 'recebido' => array('label' => 'Aguardando', 'color' => '#9aa0a6', 'done' => false),
  ```
  Por ser só uma troca de texto associada à mesma chave (`zk_equip_default_status()` continua retornando `'recebido'`), **nenhuma migração de banco foi necessária** — os chamados já existentes com esse status passam a exibir "Aguardando" automaticamente em qualquer lugar que use `zk_equip_statuses()`/`zk_equip_status_label()` (chip da lista, filtro, tabela do cliente, painel do agente).
- **Não confundir com** o status já existente `aguardando_peca` ("Aguardando peça") — são conceitos diferentes: `recebido`/"Aguardando" é o estado inicial genérico (chamado acabou de chegar, ninguém mexeu ainda); `aguardando_peca` é um estado específico que o agente escolhe depois, quando está esperando uma peça chegar para continuar o reparo.
- **Dependências/impactos:** nenhum — cor (`#9aa0a6`, cinza) e comportamento (`done: false`) mantidos, só o texto mudou.
- **Como reaplicar em versão nova:** trocar o `label` da entrada `recebido` em `zk_equip_statuses()` no `zk_equipment.php` novo.
- **Validação feita:** testado ao vivo no chamado real `#563163` — chip "Aguardando" aparece tanto no filtro (`Aguardando 1`) quanto na coluna Status da tabela de equipamentos.
- **Status:** aplicado e testado.

---

#### 2026-07-02 — Status inicial do CHAMADO (ticket) renomeado de "Aberto" para "Solicitado"

- **Onde foi alterado:** banco de dados, tabela `ost_ticket_status`, registro `id=1` (`state='open'`, o status nativo que todo chamado novo recebe automaticamente). **Não é código** — é o mesmo dado que a tela **Admin Panel → Gerenciar → Status** edita.
- **Motivo/contexto:** diferente do "Aguardando" da rodada anterior (que é o status de cada **equipamento** dentro do chamado, campo próprio do módulo ZK-EQUIP), este é o status nativo do **chamado como um todo** (o que aparece na lista "Chamados", coluna "Status", e também na tela de detalhe do chamado em "Status do Chamado"). Pedido do usuário: todo chamado aberto pelo cliente deve nascer com o status **"Solicitado"** em vez de "Aberto" — a etapa de o agente capturar o chamado e mudar esse status fica para uma implementação futura.
- **O que foi feito:**
  ```diff
  - id=1, name='Aberto',  state='open'
  + id=1, name='Solicitado', state='open'
  ```
  Só o `name` mudou; o `state` continua `open` (é essa coluna, não o nome, que o osTicket usa internamente pra saber se o chamado está ativo/aberto) — nenhum comportamento do sistema muda, só o texto exibido.
- **Dependências/impactos:** o **chip/aba de filtro** no canto superior direito da lista de chamados (ex.: "Aberto (1)") **não muda** — esse texto vem de uma tradução fixa da palavra "Open" (a aba/fila, não o nome do status individual), é um elemento de UI diferente do nome do status gravado no banco. Só a coluna "Status" de cada chamado (e o "Status do Chamado" na tela de detalhe) reflete o `name` de `ost_ticket_status`, então só esses lugares passam a mostrar "Solicitado". Se o usuário também quiser trocar o texto da aba/filtro, é uma mudança à parte (edição de core, não config).
- **Como reaplicar em versão nova:** **não precisa de SQL.** Pela tela: **Admin Panel → Gerenciar → Status → editar o status "Aberto" (o que tem "Estado" = Aberto/open) → renomear para "Solicitado"**.
- **Validação feita:** testado ao vivo — chamado real `#563163` mostra "Solicitado" na coluna Status da lista de Chamados.
- **Status:** aplicado e testado.

---

#### 2026-07-02 — Campo "Pendência" por equipamento + Nota Fiscal (XML) — 1 anexo por CHAMADO

- **Arquivo(s) alterado(s):** `include/zk_equipment.php`, `scp/zk-equip.php`, `include/client/tickets.inc.php`, `include/client/open.inc.php`, `include/client/zk-equip-edit.inc.php`. Banco: `ost_zk_equipment` (nova coluna `pendencia`), nova tabela `ost_zk_ticket_file`.
- **Motivo/contexto:** pedido do usuário, em duas partes:
  1. Um campo **"Pendência"** por equipamento, com valores pré-definidos (de imediato: "Ausência de NF" e "Aguardando rastreio de envio"), visível **dentro do chamado** e **na listagem de Chamados**.
  2. Permitir anexar a **Nota Fiscal** (opcional, não bloqueia a criação), aceitando **apenas arquivo XML** (deixado explícito). A rotina que vai **automaticamente mudar a pendência** a partir da validação do XML fica para uma etapa futura.
- **Correção de rumo no meio da implementação:** a primeira versão implementou a NF **por equipamento** (um ícone em cada linha da grade, ao lado das fotos). O usuário corrigiu: **a Nota Fiscal é do CHAMADO inteiro, não de um equipamento específico** (um chamado pode ter vários itens, mas normalmente só uma NF/coleta) — e pediu também que a edição de um chamado já aberto permita anexar, e que a tela do chamado já aberto tenha um link pra baixar o XML. A implementação foi **refeita** com esse desenho; os detalhes abaixo já refletem a versão final (por chamado), não a tentativa por equipamento (revertida).
- **1) Campo "Pendência" — banco:** nova coluna `ost_zk_equipment.pendencia` (`VARCHAR(32) NOT NULL DEFAULT ''`) — `''` = sem pendência. Segue o mesmo padrão já usado para `status` (fonte única de valores em uma função PHP, chave curta gravada no banco, rótulo/cor centralizados):
  ```php
  function zk_equip_pendencias() {
      return array(
          'ausencia_nf'         => array('label' => 'Ausência de NF',               'color' => '#c0392b'),
          'aguardando_rastreio' => array('label' => 'Aguardando rastreio de envio', 'color' => '#d99a00'),
      );
  }
  ```
  Novos valores podem ser adicionados só editando essa função (nenhuma migração de banco necessária) — igual já funciona para os status.
- **1) Onde a Pendência aparece/é editada:**
  - **Painel do cliente** (dentro do chamado, `zk_equipment_client_panel()`): nova coluna "Pendência" **somente leitura**, com um selo colorido (mesmo estilo do selo de Status) ou "—" quando não há pendência.
  - **Painel do agente** (`zk_equipment_staff_panel()`, tela do chamado no SCP): nova coluna "Pendência" **editável**, um `<select>` por linha (opção "— nenhuma —" + as pendências cadastradas), salvo junto com Status/Laudo/Nota ao clicar "Salvar progresso". Processado em `scp/zk-equip.php` (lê `$_POST['pendencia'][id]`, valida contra a lista de pendências válidas — ou vazio — e grava; um valor desconhecido não altera o que já estava salvo).
  - **Listagem de "Chamados"** (`include/client/tickets.inc.php`): nova coluna "Pendência" — mostra um selo para cada pendência distinta entre os equipamentos daquele chamado, ou "—" se nenhum tiver. Implementado com **uma única consulta** para todos os chamados da página (`zk_equip_pendencias_for_tickets()`), evitando 1 consulta por linha da tabela.
- **2) Nota Fiscal (XML) do chamado — banco:** nova tabela `ost_zk_ticket_file` (`ticket_id`, `file_id`, `kind` default `'nf'`, `created`) — deliberadamente **separada** da tabela de fotos por equipamento (`ost_zk_equipment_file`), já que agora não tem relação com um item específico. (A tentativa anterior de guardar a NF na tabela de fotos, com uma coluna `kind`, foi revertida — essa coluna foi removida de `ost_zk_equipment_file`.)
- **2) Onde a NF aparece — um só lugar visível em cada tela, no topo do bloco de Equipamentos** (não mais um ícone por linha):
  - **Abertura do chamado** (`open.inc.php`): um botão único "Anexar Nota Fiscal (XML) — opcional" logo acima da grade (não é mais um ícone dentro de cada linha). Ao escolher um arquivo, o botão fica azul e mostra o nome do arquivo ao lado.
  - **Editar equipamentos de um chamado já aberto** (`zk-equip-edit.inc.php`) — atendendo ao pedido "o ticket editado tem que permitir anexar": mesmo botão único, mais uma linha abaixo mostrando o estado atual ("Nota Fiscal — nome-do-arquivo.xml" ou "não anexada"). Processado por `zk_equip_client_process_edit()`, que agora também chama a função de salvar a NF.
  - **Chamado já aberto/visualização** (painéis do cliente e do agente, `zk_equipment_client_panel()`/`zk_equipment_staff_panel()`) — atendendo ao pedido "com o ticket aberto, tem que ser possível clicar para baixar o XML": um link **"Nota Fiscal — nome-do-arquivo.xml"** aparece no cabeçalho do painel "Equipamentos", ao lado do título (ou "Nota Fiscal: não anexada" em cinza, se não tiver nenhuma) — clicável, baixa o arquivo diretamente.
- **Explicitação do "apenas XML"** em 3 camadas, em todas as 3 telas acima: (a) atributo `accept=".xml,..."` no input; (b) tooltip "Nota Fiscal — apenas arquivo XML (opcional)"; (c) validação client-side no `change` — nome de arquivo que não termina em `.xml` é rejeitado na hora, com a mensagem "A Nota Fiscal precisa ser um arquivo .xml."
- **2) O que foi feito (server-side, `zk_equipment.php`):** `zk_ticket_files()`/`zk_ticket_nf_html()` (consulta e renderização do link/aviso), `zk_uploaded_ticket_nf()`/`zk_save_ticket_nf($ticket_id)` (validação e gravação — mesma checagem rigorosa de extensão `.xml` + MIME real via `fileinfo` da versão anterior, só que operando em `$_FILES['zk_ticket_nf']` direto, sem indexação por linha/`photoKey`). Chamada em 2 pontos: `zk_equip_on_ticket_created()` (criação) e `zk_equip_client_process_edit()` (edição). `zk_equip_on_ticket_deleted()` (limpeza ao apagar um chamado) atualizada para também apagar a linha correspondente em `ost_zk_ticket_file` — evita registro órfão.
- **Dependências/impactos:** nenhum quebrado. `zk_equip_photo_links_html()` voltou a ser exatamente como era antes desta rodada (sem filtro de `kind`, já que fotos são a única coisa que sobrou em `ost_zk_equipment_file`).
- **Pendência real para o futuro (avisado pelo próprio usuário):** a rotina que valida o conteúdo do XML da NF e muda a Pendência automaticamente **não foi implementada agora** — é trabalho futuro combinado.
- **Como reaplicar em versão nova:** reaplicar os blocos de código nos 5 arquivos listados + criar a tabela `ost_zk_ticket_file` + adicionar a coluna `ost_zk_equipment.pendencia`.
- **Validação feita — testado ao vivo de ponta a ponta:** aberto um chamado real (`#783165`) anexando uma NF em XML válido — botão ficou azul, chamado criado, arquivo salvo em `ost_zk_ticket_file`/`ost_file`; conferido que o link "Nota Fiscal — teste-nf.xml" aparece no painel do cliente e permite baixar o arquivo correto (um `503` isolado apareceu na primeira tentativa de clique — não se repetiu nas tentativas seguintes com a mesma URL, tudo indica instabilidade pontual do ambiente XAMPP local, não um bug do código); conferido também que a tela de "Editar Equipamentos" mostra o mesmo botão e o link do arquivo já anexado. Coluna "Pendência" aparece corretamente (vazia/"—") nos painéis e na listagem. **Não testado:** o painel do agente (SCP) definindo uma Pendência — segue sem credencial de staff disponível nesta conversa.
- **Status:** aplicado e testado (fluxo do cliente ponta a ponta); pendente apenas validar manualmente a edição de Pendência no painel do agente.

**Correção (mesmo dia) — alinhamento do estado da NF na tela de editar:** o usuário reportou (com print) que, na tela "Editar Equipamentos", o link "Nota Fiscal — nome-do-arquivo.xml" (mostrando o que já estava anexado) aparecia **embaixo** do botão "Anexar/trocar Nota Fiscal (XML)", desalinhado — pediu pra ficar "alinhado certinho" (o desenho pedido era o link na mesma linha do botão, não empilhado).
- **Arquivo(s) alterado(s):** `include/client/zk-equip-edit.inc.php`, `include/zk_equipment.php`.
- **O que foi feito:**
  - O bloco `.zk-ticket-nf-current` (que mostra o link/estado da NF já anexada) foi movido pra **dentro** de `.zk-ticket-nf-row` (o mesmo container flex do botão) — agora os dois ficam lado a lado, na mesma linha, alinhados verticalmente ao centro.
  - **Nome de arquivo truncado com reticências:** a chave de acesso de uma NF-e tem 44 dígitos (nomes de arquivo do tipo `31260608057340...189571128564591-nfe.xml`, bem compridos) — sem limite, esse texto esticava a linha toda. O nome do arquivo passou a ficar num `<span class="zk-nf-text">` à parte dentro do link (`zk_ticket_nf_html()`), com `overflow:hidden; text-overflow:ellipsis; white-space:nowrap` e uma largura máxima (`max-width:360px` no container `.zk-ticket-nf-current`) — trunca visualmente, mas o nome completo continua no `title` (tooltip ao passar o mouse) e no link em si (baixa o arquivo certo).
- **Dependências/impactos:** essa mesma classe `.zk-nf-text`/regra de truncamento vale também para o link de NF mostrado no cabeçalho dos painéis (cliente/agente) do chamado já aberto — mesmo benefício ali, apesar de não ter sido o ponto reportado.
- **Como reaplicar em versão nova:** reaplicar a reorganização do HTML em `zk-equip-edit.inc.php` (mover `.zk-ticket-nf-current` pra dentro de `.zk-ticket-nf-row`) e as regras CSS de truncamento (`.zk-nf-text`) em `zk_equipment.php`.
- **Validação feita:** testado ao vivo no chamado real `#563163` — botão e link da NF agora ficam na mesma linha, nome do arquivo truncado com "..." (confirmado via inspeção que o texto realmente excede a largura disponível e é cortado, não só cabendo por coincidência).
- **Status:** aplicado e testado.

---

#### 2026-07-02 — Botão para apagar a Nota Fiscal + "trocar" agora troca de verdade

- **Arquivo(s) alterado(s):** `include/zk_equipment.php`, `zk-equip-edit.php`, `include/client/zk-equip-edit.inc.php`.
- **Motivo/contexto:** pedido do usuário — às vezes o cliente precisa trocar a NF porque emitiu errada ou anexou o arquivo errado; faltava um jeito de **apagar** a NF já anexada.
- **Bug real encontrado no caminho (achado testando com o chamado real `#563163`):** o botão já dizia "Anexar/**trocar**" desde a rodada anterior, mas o código só **acumulava** — cada novo upload virava um novo registro em `ost_zk_ticket_file`, sem nunca remover o anterior. No chamado de teste isso já tinha acontecido de verdade: havia **duas** notas fiscais diferentes anexadas ao mesmo chamado, listadas uma embaixo da outra. Corrigido nesta mesma rodada (abaixo).
- **O que foi feito:**
  - Nova função `zk_delete_ticket_nf($ticket_id)` (`zk_equipment.php`) — apaga **de verdade**: remove o vínculo em `ost_zk_ticket_file` **e** o anexo em si via `AttachmentFile::delete()` (libera o armazenamento, não é só desvincular — evita lixo órfão no banco).
  - `zk_save_ticket_nf()` corrigida para **trocar de fato**: depois que o novo arquivo já foi validado e salvo com sucesso, chama `zk_delete_ticket_nf()` pra remover o(s) anterior(es) — nessa ordem específica (salva o novo primeiro, só depois apaga o velho) pra nunca ficar sem NF nenhuma se o novo upload falhar por algum motivo.
  - **Botão "×" de apagar**, na tela "Editar Equipamentos" (`zk-equip-edit.inc.php`), só aparece quando já existe uma NF anexada — ao lado do link "Nota Fiscal — nome-do-arquivo.xml", com confirmação (`confirm()`) antes de apagar.
  - **Desafio técnico resolvido:** o botão de apagar precisa disparar um POST próprio, mas HTML não permite `<form>` dentro de outro `<form>` (e o botão fica visualmente dentro do form grande de editar equipamentos, `#zkEditForm`). Solução: um **segundo `<form>` escondido** (`#zkTicketNfDeleteForm`), como *sibling* do form principal (não aninhado — HTML válido), com o token CSRF e os campos `id`/`zk_ticket_nf_delete=1` já prontos; o botão "×" só dispara `.submit()` nesse form via JS depois do `confirm()`. Continua sendo um POST de verdade com recarregamento de página — sem AJAX, mesmo estilo do resto do módulo.
  - `zk-equip-edit.php` (controller) ganhou um bloco isolado no topo do tratamento de POST: se vier `zk_ticket_nf_delete=1`, só apaga a NF, registra uma nota no chamado ("Nota Fiscal removida") e redireciona de volta pra própria tela de edição (pra o cliente já ver o resultado e poder anexar a correta na sequência) — sem nem tocar na lógica de salvar equipamentos.
- **Dependências/impactos:** nenhum quebrado. O botão de apagar só existe na tela de **edição** (onde faz sentido uma ação destrutiva do cliente) — não foi adicionado nos painéis somente-leitura (visualização do chamado).
- **Como reaplicar em versão nova:** reaplicar `zk_delete_ticket_nf()` e a correção em `zk_save_ticket_nf()` (`zk_equipment.php`), o bloco de tratamento de POST em `zk-equip-edit.php`, e o botão + form escondido + handler JS em `zk-equip-edit.inc.php`.
- **Validação feita — testado ao vivo de ponta a ponta no chamado real `#563163`:** (1) o chamado já tinha 2 NFs acumuladas de testes anteriores — apagadas com o novo botão, confirmado no banco que ambos os vínculos **e** os arquivos físicos sumiram; (2) anexada uma NF nova (`primeira.xml`) — salva corretamente, só 1 registro; (3) anexada uma segunda (`segunda.xml`) por cima — confirmado que a primeira foi **removida automaticamente** (registro e arquivo) e só a segunda ficou, comprovando que "trocar" agora troca de verdade; (4) apagada a NF de teste no final pra não deixar lixo no chamado real do usuário.
- **Status:** aplicado e testado.

---

#### 2026-07-02 — Verificação automática do XML da NF + 3 estados de Pendência

- **Arquivo(s) alterado(s):** `include/zk_equipment.php`, `zk-equip-edit.php`, `scp/zk-equip.php`, `include/client/zk-equip-edit.inc.php`. Banco: nova coluna `ost_zk_ticket_file.errors`.
- **Motivo/contexto:** implementação da rotina que tinha ficado combinada como "trabalho futuro" nas rodadas anteriores — o usuário pediu a parte de Pendência relacionada à Nota Fiscal, com 3 estados específicos, mais um botão para validar o XML contra regras fixas de negócio (destinatário, ausência de imposto destacado, CFOP).
- **1) Os 3 estados de Pendência (substituem a antiga "Ausência de NF" genérica):**
  ```php
  function zk_equip_pendencias() {
      return array(
          'sem_nf'              => array('label' => 'Sem nota fiscal',                 'color' => '#c0392b'),
          'nf_nao_verificada'   => array('label' => 'Nota anexada, mas não verificada', 'color' => '#d99a00'),
          'nf_com_erro'         => array('label' => 'Nota fiscal com erro',            'color' => '#c0392b'),
          'aguardando_rastreio' => array('label' => 'Aguardando rastreio de envio',    'color' => '#d99a00'),
      );
  }
  ```
  As 3 primeiras são **"managed"** (`zk_equip_pendencias_nf_managed()`) — mantidas automaticamente pelo sistema a partir do estado da NF, nunca escolhidas manualmente pelo agente no `<select>`. `aguardando_rastreio` continua sendo escolha manual do agente, como antes.
- **2) Sincronização automática (`zk_sync_equip_pendencia_from_nf($ticket_id)`):** a NF é do CHAMADO, mas a Pendência é por EQUIPAMENTO — então a função aplica o mesmo estado a **todos** os equipamentos do chamado, mas só nos que já estão numa pendência "managed" (vazia ou uma das 3 de NF) — nunca sobrescreve uma escolha manual do agente (ex.: não vai apagar "Aguardando rastreio de envio" só porque a NF mudou de estado). Chamada automaticamente em 4 pontos: criação do chamado, edição de equipamentos, upload de nova NF (`zk_save_ticket_nf`) e remoção de NF (`zk_delete_ticket_nf`) — o usuário não precisa fazer nada manualmente pra essas 3 primeiras transições, só a verificação do XML em si é que precisa do botão.
- **3) Botão "Verificar XML"** — aparece ao lado do link da Nota Fiscal (sempre que há uma anexada) em **3 lugares**: painel do cliente (chamado aberto), painel do agente (SCP) e tela de editar equipamentos. Ao clicar, dispara um POST isolado (mesmo padrão do botão de apagar — form escondido fora do form principal, evita `<form>` aninhado) para `zk-equip-edit.php` (cliente) ou `scp/zk-equip.php` (agente), que chama `zk_verify_ticket_nf($ticket_id)`.
- **4) O que a verificação checa (`zk_validate_nfe_xml()`), regras fixas passadas pelo usuário:**
  - **Destinatário (`<dest>`)** precisa bater exatamente com os dados oficiais da ZKTeco do Brasil (CNPJ, razão social, endereço completo, IE etc. — 15 campos conferidos um a um). Cada campo errado ou ausente vira uma mensagem de erro específica, com o valor esperado e o valor encontrado.
  - **CFOP** (`<det>/<prod>/<CFOP>`) só pode ser **5915 ou 6915** (remessa/retorno de mercadoria para conserto — por isso a regra de "sem imposto destacado" faz sentido: é uma operação isenta, não uma venda).
  - **Sem imposto destacado:** varre o XML procurando as tags de valor de imposto do padrão NF-e (`vICMS`, `vICMSST`, `vIPI`, `vPIS`, `vCOFINS`, `vFCP` etc. — lista em `zk_nfe_tags_imposto()`) em qualquer lugar dentro de `<imposto>`; qualquer valor maior que zero é erro.
  - Implementação: `simplexml_load_string()` depois de remover o namespace default do XML (`xmlns="..."`, comum em NF-e) via regex, pra poder usar XPath (`//dest`, `//det/prod/CFOP`, `//imposto//vICMS` etc.) sem precisar registrar prefixo de namespace. XML corrompido/ilegível também vira erro (`libxml_use_internal_errors`).
- **5) Onde o resultado fica guardado:** nova coluna `ost_zk_ticket_file.errors` (TEXT, nullable) — usada como uma máquina de 3 estados **num único campo**: `NULL` = ainda não verificada; `''` (string vazia) = verificada e sem erro; qualquer outra coisa = verificada com erro (uma mensagem por linha). `zk_ticket_nf_error_list()`/`zk_ticket_nf_errors_html()` leem isso pra montar a lista de erros exibida numa caixa vermelha (`.zk-nf-errors-box`) nos 3 painéis, sempre que a pendência é "Nota fiscal com erro".
- **6) Leitura do conteúdo do arquivo:** `AttachmentFile::getData()` (API nativa do osTicket, já usada internamente em `class.mailparse.php`/`class.export.php`) — retorna a string completa do arquivo já salvo, direto pro `simplexml_load_string()`.
- **Dependências/impactos:** nenhum quebrado. A nota-resumo registrada no chamado (`logNote`) ao verificar já inclui a lista de erros (útil pro histórico/auditoria, não só a tela atual).
- **Como reaplicar em versão nova:** reaplicar os blocos de `zk_equipment.php` (pendências, sync, validação, verificação), os blocos de tratamento de POST em `zk-equip-edit.php` e `scp/zk-equip.php`, o botão em `zk-equip-edit.inc.php`, e a coluna `ost_zk_ticket_file.errors` (com `DEFAULT NULL`, não quebra dados existentes).
- **Validação feita — testado ao vivo, os 4 estados possíveis, no chamado real `#563163`:**
  1. **Sem NF** → anexado um XML deliberadamente errado (destinatário trocado, CFOP 5102, imposto de R$150 destacado) → badge "Nota anexada, mas não verificada" apareceu certo antes de verificar.
  2. Clicado "Verificar XML" → badge virou **"Nota fiscal com erro"** (vermelho) e a caixa de erros listou **cada** divergência de destinatário campo a campo (valor esperado vs. encontrado), o CFOP errado e o imposto destacado — tudo certinho.
  3. Trocada por um XML **100% correto** (destinatário exato, CFOP 5915, imposto zerado) → verificado → pendência **limpa** (sem badge), sem erros.
  4. Apagada a NF → pendência virou **"Sem nota fiscal"**, confirmado também na coluna nova da listagem de "Chamados".
  - Confirmado no banco (`ost_zk_ticket_file.errors`) que os 3 estados (`NULL`/`''`/erros) batem exatamente com o que a tela mostra em cada passo.
- **Status:** aplicado e testado — os 4 estados confirmados de ponta a ponta.

**Correção (mesmo dia) — falso positivo de espaçamento no Destinatário:** o usuário testou com um XML **real** de um fornecedor (Embratecc) e a verificação acusou erro no campo "Complemento" (`enderDest.xCpl`) mesmo os dois valores parecendo **idênticos** na tela ("Galpao 01 Area 01" vs "Galpao 01 Area 01").
- **Causa raiz (achada com um script de depuração temporário que dumpou os bytes crus do XML):** o valor real no XML tinha **dois espaços** entre "01" e "Area" (`Galpao 01␣␣Area 01`, confirmado em hexadecimal: `20 20`, dois espaços ASCII comuns — nada de caractere especial/encoding), enquanto o valor esperado tinha só um espaço. Visualmente invisível (navegador colapsa espaços múltiplos ao exibir), mas `strcasecmp()` compara byte a byte e não perdoa isso.
- **O que foi feito:** nova função `zk_nfe_normalize_ws($s)` — colapsa espaços múltiplos/tabs em um só, tira espaço das pontas e ignora maiúsculas/minúsculas — usada na comparação de **todos** os 15 campos do destinatário (não só o Complemento, a pedido do usuário: "checa as inconsistências no geral"). Continua pegando de verdade qualquer nome/endereço realmente diferente — só para de reclamar de espaçamento inconsistente, algo comum em campos de texto livre preenchidos à mão por fornecedores diferentes.
- **Validação feita:** reverificado o mesmo XML real da Embratecc depois da correção — **0 erros**, pendência limpa automaticamente. Script de depuração temporário (`_zk_dump_nf.php`) removido do servidor depois de usado.
- **Status:** aplicado e testado com XML real de fornecedor.

---

#### 2026-07-02 — Ícone de anexar Nota Fiscal direto no painel (quando não há nenhuma)

- **Arquivo(s) alterado(s):** `include/zk_equipment.php`, `scp/zk-equip.php`.
- **Motivo/contexto:** o usuário apontou (com print) que, quando o chamado não tem NF, o painel só mostrava o texto "Nota Fiscal: não anexada" sem nenhuma ação possível ali — o cliente precisava sair da tela do chamado e ir até "Editar Equipamentos" só pra anexar. Pedido: um ícone ali mesmo, pra melhorar a usabilidade.
- **O que foi feito:** adicionado um botão circular pequeno (ícone de clipe, `icon-paperclip`) ao lado do texto "Nota Fiscal: não anexada", nos painéis do **cliente** e do **agente** — só aparece quando **não há** NF anexada (quando já tem, o espaço é ocupado pelo botão "Verificar XML" existente). Ao escolher o arquivo, o upload é **automático** (sem precisar de um botão "salvar" separado) — dispara o mesmo `submit()` de um form isolado, igual ao padrão já usado pros botões de apagar/verificar.
- **Descoberta que simplificou a implementação:** não foi preciso criar nenhuma rota/flag nova no lado do cliente — o controller `zk-equip-edit.php` já processa qualquer POST (sem `zk_ticket_nf_delete`/`zk_ticket_nf_verify`) chamando `zk_equip_client_process_edit()`, que **já salva a NF mesmo sem nenhum equipamento no payload** (o loop de linhas simplesmente não roda se vier vazio, mas o salvamento da NF acontece de qualquer forma, incondicional). Ou seja, um form mínimo (`id` + CSRF + o arquivo) já basta — os equipamentos existentes ficam **intocados**. Do lado do **agente**, como `scp/zk-equip.php` não tinha esse mesmo comportamento de fallback, foi adicionado um bloco isolado novo (igual ao de "Verificar XML") que detecta `$_FILES['zk_ticket_nf']` e chama `zk_save_ticket_nf()` diretamente.
- **Dependências/impactos:** nenhum quebrado — confirmado que o equipamento existente do chamado de teste não foi alterado/duplicado pelo upload rápido (o form não manda `zk_equipments_json`).
- **Como reaplicar em versão nova:** reaplicar o botão+form+JS nos dois painéis (`zk_equipment_client_panel()`/`zk_equipment_staff_panel()`) em `zk_equipment.php`, e o bloco de detecção de `$_FILES['zk_ticket_nf']` em `scp/zk-equip.php`.
- **Validação feita:** testado ao vivo no chamado real — clicado no ícone, escolhido um XML, upload automático, pendência virou "Nota anexada, mas não verificada" e o botão "Verificar XML" apareceu no lugar do ícone; equipamento existente conferido intacto (mesmos dados de antes). NF de teste removida ao final.
- **Status:** aplicado e testado (cliente); implementado por consistência também no painel do agente, mas sem credencial de staff pra testar ao vivo nesta conversa.

---

#### 2026-07-02 — Edição de equipamento pelo cliente agora atualiza o Assunto do chamado + nota de histórico detalhada

- **Arquivo(s) alterado(s):** `include/zk_equipment.php`, `zk-equip-edit.php`.
- **Motivo/contexto:** o usuário apontou (com print, setas ligando o título do chamado, a linha do equipamento na grade e o post original da thread) que, ao editar um equipamento em "Editar Equipamentos", a alteração só era salva no item — o **Assunto** do chamado (mostrado no cabeçalho da tela e na listagem "Chamados") continuava com o dado antigo, ficando inconsistente com o equipamento já corrigido. Pedido: "seria importante alterar geral para manter tudo com a mesma informação". De caminho, a nota de histórico gravada na thread também era só genérica ("N atualizado(s)"), sem dizer o quê mudou.
- **O que foi feito:**
  1. Nova função `zk_equip_refresh_subject($ticket)` em `zk_equipment.php`: regera o Assunto a partir dos equipamentos atuais do chamado, com a **mesma regra** já usada na abertura (`zk_equip_fill_ticket_vars`) — 1 equipamento: `"Manutenção — {Modelo} (S/N {Série})"`; vários: `"Solicitação de manutenção — N equipamentos"` (limite de 50 caracteres). É chamada ao final de `zk_equip_client_process_edit()` sempre que algo foi atualizado ou criado.
  2. `zk_equip_client_process_edit()` passou a montar também um array `$changes` com uma descrição pronta por equipamento alterado (ex.: `Modelo: "SpeedFace M4" → "SpeedFace M5"`, um por campo que realmente mudou: Modelo, Nº de Série, Resumo, Detalhamento/Observação) — o retorno da função virou `array($updated, $created, $changes)` (era só `array($updated, $created)`).
  3. `zk-equip-edit.php` foi atualizado para o novo retorno de 3 posições e agora monta a nota de histórico usando `$changes` (o "antes → depois" de cada campo) em vez do texto genérico; só cai de volta pro texto genérico se não houver detalhamento nenhum (caso defensivo).
- **Detalhe técnico importante (como o Assunto é gravado):** o Assunto do chamado não é uma coluna do ticket — é resposta de um campo dinâmico (`DynamicFormEntryAnswer`). `zk_equip_refresh_subject()` localiza a entry do ticket (`DynamicFormEntry::forTicket()`), pega a resposta do campo `subject` (`$entry->getAnswer('subject')`) e chama `->setValue()` + `->save()` **direto nessa resposta** — em vez de `$entry->save()` (que percorreria `getClean()`/`to_database()` de *todos* os campos da entry, pensado pra um fluxo vindo de `$_POST`, não pra essa atualização pontual). O `save()` da resposta já dispara sozinho o Signal (`model.updated`) que sincroniza a tabela `ost_ticket__cdata` (usada pela listagem "Chamados"/busca) — não precisou de nenhum passo manual de reindexação. Se o objeto `$ticket` já tinha lido o Assunto antigo antes (cache em memória), a função força `$ticket->loadDynamicData(true)` pra refletir o valor novo no mesmo request.
- **Dependências/impactos:** nenhum — a função só mexe na resposta do campo `subject`, nenhum outro campo do formulário é tocado. Painel do agente (`scp/zk-equip.php`) não foi alterado — ele só edita status/pendência/laudo/nota interna, campos que não entram no Assunto, então não precisa desse tratamento.
- **Validação feita:** testado ao vivo no chamado real #563163 (ticket_id=10) via script PHP: (1) o chamado já estava com o Assunto desatualizado de um teste anterior (mostrava "S/N 5454545" enquanto o equipamento já tinha `numero_serie=CHR7252200105`) — confirmando o próprio bug relatado; chamar `zk_equip_refresh_subject()` sozinho corrigiu isso na hora, com o `ost_ticket__cdata` sincronizado automaticamente. (2) Simulado o POST completo de edição (JSON da grade) alterando Modelo/Resumo/Detalhamento de um equipamento existente: `$changes` voltou com o "antes → depois" de cada campo alterado, e o Assunto do chamado atualizou junto (conferido tanto no mesmo objeto PHP quanto num `Ticket::lookup()` novo). Dados de teste revertidos ao final para não deixar o chamado real alterado. `php -l` sem erros nos dois arquivos.
- **Status:** aplicado e testado.

---

#### 2026-07-02 — Chamados de teste apagados para reiniciar os testes

- **O que foi feito:** os 5 chamados de teste existentes no banco (`#456286` TesteMerge, `#279676` Ptouch, e outros 3) foram apagados a pedido do usuário, para começar os testes da nova regra de campos/foto obrigatórios com a base limpa.
- **Como foi feito (importante para não perder dados por engano no futuro):**
  1. **Backup completo do banco** feito antes de qualquer exclusão: `mysqldump` de `zkteco_manutencao` salvo em `backups/zkteco_manutencao_backup_2026-07-02_pre-ticket-purge.sql` (nesta mesma pasta de documentação) — permite restaurar os 5 chamados de teste se precisar no futuro.
  2. A exclusão **não** foi feita com `DELETE` direto via SQL (isso deixaria dados órfãos pra trás — anexos, thread, formulário dinâmico, e principalmente as tabelas próprias `ost_zk_equipment*`, que só são limpas por um listener de sinal do próprio código). Em vez disso, foi criado um script temporário (`_zk_purge_tickets.php`, na raiz do projeto) que usava a própria API do osTicket (`Ticket::lookup($id)->delete()`) para cada chamado — isso já dispara toda a limpeza nativa (thread, anexos, `ost_form_entry*`) **e** o listener customizado `zk_equip_on_ticket_deleted()` (conectado ao sinal `model.deleted` da classe `Ticket`, em `zk_equipment.php`), que por sua vez limpa `ost_zk_equipment`, `ost_zk_equipment_event` e `ost_zk_equipment_file` — ou seja, exclusão 100% limpa, sem sobra em nenhuma tabela.
  3. **O script temporário foi apagado logo em seguida** (não é um arquivo permanente do projeto) — deixar um script desses acessível publicamente no servidor seria um risco sério (qualquer um que soubesse a URL apagaria todos os chamados).
- **Resultado:** banco de dados com **0 chamados** — confirmado ao vivo (`Chamados (0)` no menu do cliente).
- **Como reaplicar/repetir no futuro:** não recomendado apagar chamados em produção. Se precisar limpar uma base de teste de novo, repetir o mesmo processo (backup com `mysqldump` primeiro, depois um script temporário usando `Ticket::lookup()->delete()`, nunca `DELETE` SQL direto nas tabelas) e sempre remover o script depois de usar.
- **Status:** concluído.

---

#### 2026-07-02 — Card do post inicial auto-gerado ocultado da thread do chamado

- **Arquivo(s) alterado(s):** `include/zk_equipment.php` (função nova), `include/class.thread.php` (core, mini-edit de 5 linhas marcado `/* ZK-EQUIP */` em `Thread::render()`).
- **Tipo:** core (1 mini-edit) + módulo customizado.
- **Motivo/contexto:** ao criar um chamado, o osTicket sempre posta a "mensagem inicial" como primeiro card da thread. Como os campos genéricos de assunto/mensagem foram removidos da tela de abertura, esse texto é gerado automaticamente pela customização (`zk_equip_fill_ticket_vars`, lista "Solicitação de manutenção com N equipamento(s)…") só para satisfazer a exigência do osTicket — e o card ficou **redundante** com a grade de Equipamentos, que já mostra tudo (modelo, série, resumo, detalhamento, status). Pedido do usuário: impedir que esse card apareça; a thread deve servir só para posts intencionais (ex.: cliente fazendo uma pergunta).
- **O que foi feito:**
  1. Nova função `zk_thread_hide_auto_original($thread)` em `zk_equipment.php`: retorna `true` só quando a thread é de um **chamado** (`object_type = 'T'`, nunca tarefa) **e** o chamado tem pelo menos 1 equipamento na grade (`zk_equip_count() > 0`).
  2. Em `Thread::render()` (`class.thread.php`, logo após `$entries = $this->getEntries()`): se a função acima existir e retornar `true`, a query exclui as entradas com o bit `ThreadEntry::FLAG_ORIGINAL_MESSAGE` (`$entries->exclude(array('flags__hasbit' => ThreadEntry::FLAG_ORIGINAL_MESSAGE))`). Como `render()` é o ponto único que alimenta os templates de thread do **cliente e do agente**, um único edit cobre as duas telas.
- **Por que ocultar na renderização em vez de não criar a mensagem:** três motivos descobertos investigando o core:
  1. `ThreadEntry::create()` transforma corpo vazio em `'-'` e cria a entrada mesmo assim — "esvaziar a mensagem" só trocaria o card por um card com um traço.
  2. O e-mail de confirmação de novo chamado (autoresponse) usa `%{message}` — a mensagem gerada (lista de equipamentos) **continua alimentando esse e-mail**, o que é útil pro cliente. Apagar/impedir a entrada deixaria o e-mail vazio.
  3. Apagar a entrada depois de criada arriscaria órfãos/cascatas de anexos e quebraria `%{ticket.thread.original}` em templates de e-mail futuros. Ocultar na renderização é reversível e não toca em dado nenhum.
- **Por que o filtro é seguro/preciso:** o osTicket marca exatamente essa entrada com `FLAG_ORIGINAL_MESSAGE` na criação do ticket (`class.ticket.php`, `Ticket::create()`); posts que o cliente fizer depois não carregam esse flag e continuam aparecendo. Tarefas também usam esse flag pra descrição (`class.task.php`) — por isso a checagem de `object_type = 'T'`. E chamados criados **sem** equipamentos (se um dia existirem) não são afetados, porque `zk_equip_count()` é 0 — nesse caso a mensagem original pode ser conteúdo real digitado pelo usuário e continua visível. `sortEntries()` foi conferido: é plano (não aninha respostas por `pid`), então ocultar a original não esconde respostas do agente.
- **Dependências/impactos:** a entrada continua existindo no banco (histórico, API, export/print em PDF ainda a incluem — só as telas web deixam de mostrá-la). A linha de evento "Criado por Fulano em [data]" continua aparecendo na thread (é um evento, não o card, e é informativa).
- **Como reaplicar em versão nova:** recriar `zk_thread_hide_auto_original()` em `zk_equipment.php` e reaplicar o bloco `/* ZK-EQUIP */` em `Thread::render()` (`class.thread.php`), logo após o `$entries = $this->getEntries()` — conferir se o método ainda existe com esse nome e se `FLAG_ORIGINAL_MESSAGE` ainda é `0x0001`.
- **Validação feita:** `php -l` limpo nos dois arquivos; conferido no banco que a entrada 16 do chamado real #563163 tem o bit 1 (`flags & 1 = 1`) e que o chamado tem 1 equipamento; página recarregada ao vivo no navegador — o card sumiu, sobrando o evento "Criado por…" e o formulário "Postar uma resposta" funcionando normalmente.
- **Status:** aplicado e testado (cliente); o mesmo filtro vale pro painel do agente, mas sem credencial de staff pra conferir visualmente nesta conversa.

---

#### 2026-07-02 — Envio do produto (Transportadora + Rastreio) com pendência automática

- **Arquivo(s) alterado(s):** `include/zk_equipment.php`, `zk-equip-edit.php`; banco: nova tabela `ost_zk_ticket_envio`.
- **Tipo:** módulo customizado + banco de dados (nenhum arquivo do core tocado nesta mudança).
- **Motivo/contexto:** depois que a NF está resolvida, o cliente precisa despachar o equipamento e informar **como** — pedido do usuário: lista suspensa Transportadora (CORREIOS / O PRÓPRIO / OUTRA), sempre **vazia na criação do chamado**; se CORREIOS, aparece o campo Rastreio e ele é **obrigatório**; se O PRÓPRIO ou OUTRA, o rastreio não aparece nem se aplica. E, assim como a pendência de NF, o "envio não informado" precisa aparecer como pendência pro cliente saber que tem algo a resolver.
- **Banco (rodar em instalação nova):**
  ```sql
  CREATE TABLE ost_zk_ticket_envio (
    ticket_id INT UNSIGNED NOT NULL PRIMARY KEY,
    transportadora VARCHAR(16) NOT NULL DEFAULT '',
    rastreio VARCHAR(64) NOT NULL DEFAULT '',
    updated DATETIME NOT NULL
  ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
  ```
  Por CHAMADO (como a NF), não por equipamento — 1 linha por ticket (`INSERT ... ON DUPLICATE KEY UPDATE`). Sem linha = "não informado" (por isso todo chamado novo nasce vazio, sem precisar de nenhum gancho na criação).
- **O que foi feito (`zk_equipment.php`):**
  1. Bloco novo "ENVIO DO PRODUTO": `zk_ticket_envio_table()`, `zk_envio_transportadoras()` (chaves `correios`/`o_proprio`/`outra` com rótulos CORREIOS/O PRÓPRIO/OUTRA), `zk_ticket_envio()` (estado atual), `zk_save_ticket_envio()` (valida server-side: transportadora obrigatória; CORREIOS exige rastreio, que é gravado em MAIÚSCULAS; nas demais o rastreio é descartado), `zk_ticket_envio_pendencia()` e `zk_ticket_envio_resumo()` ("CORREIOS — Rastreio: XY…", usado no painel do agente e nas notas).
  2. Nova pendência **`envio_nao_informado`** ("Envio do produto não informado", âmbar) em `zk_equip_pendencias()`, incluída na lista de pendências **gerenciadas automaticamente**.
  3. A sincronização automática foi **renomeada** de `zk_sync_equip_pendencia_from_nf()` para `zk_sync_equip_pendencia()` (agora cobre NF **e** envio) — a derivação ficou em cascata com **prioridade pra NF**: primeiro resolve NF (sem_nf → nf_nao_verificada → nf_com_erro); só quando a NF está ok é que o envio pendente vira a pendência (`envio_nao_informado`); com os dois resolvidos, pendência limpa. Um passo de cada vez pro cliente, sem disputa pelo campo único de pendência. Continua nunca sobrescrevendo pendência manual do agente (ex.: `aguardando_rastreio`).
  4. **Painel do cliente:** barra "Envio do produto" (ícone de caminhão) entre o cabeçalho e a barra de progresso — select + campo Rastreio (só visível com CORREIOS, via JS) + botão Salvar. JS valida antes de enviar (transportadora obrigatória; rastreio obrigatório se CORREIOS). Se o cliente não pode mais editar o chamado (`zk_equip_client_can_edit()` falso, ex.: fechado), a barra vira texto somente-leitura.
  5. **Painel do agente:** mesma barra, somente-leitura ("Envio do produto: CORREIOS — Rastreio: …" ou "não informado pelo solicitante") — o agente precisa ver o rastreio, mas quem informa é o cliente.
  6. CSS `.zk-envio-bar`/`.zk-envio-form`/`.zk-envio-save` em `zk_equip_styles()` (paleta ZKTeco; rastreio com `text-transform:uppercase`).
- **O que foi feito (`zk-equip-edit.php`):** nova ação isolada `zk_envio_save` (mesmo padrão dos forms isolados de NF): chama `zk_save_ticket_envio()` e, se algo mudou de verdade, grava nota de histórico "Envio do produto informado" com o resumo (transportadora + rastreio). Redireciona de volta pro chamado.
- **Selo na listagem "Chamados":** nenhum código novo — `zk_equip_pendencias_for_tickets()` já lê pendências distintas por ticket, então o selo "Envio do produto não informado" aparece na coluna Pendência automaticamente.
- **Dependências/impactos:** o rename do sync foi atualizado em todos os 5 pontos de chamada (criação, upload de NF, remoção de NF, verificação de XML, edição de equipamentos) + o novo (salvar envio) — tudo dentro de `zk_equipment.php`/controllers próprios, nada no core. O select de Pendência do agente ganha a opção nova automaticamente (mesma fonte `zk_equip_pendencias()`).
- **Como reaplicar em versão nova:** criar a tabela (SQL acima) e reaplicar os blocos de `zk_equipment.php` (funções de envio, pendência nova, sync renomeado, barras nos 2 painéis, CSS) e a ação `zk_envio_save` em `zk-equip-edit.php`.
- **Validação feita:**
  - Server-side via script PHP CLI no chamado real #563163: os 3 erros de validação retornam certos; O PRÓPRIO grava sem rastreio e limpa a pendência; CORREIOS grava rastreio em maiúsculas; sync com NF ok + envio vazio marca `envio_nao_informado`; NF pendente tem prioridade.
  - No navegador (cliente): barra aparece com select vazio; badge âmbar "Envio do produto não informado" na coluna Pendência; ao escolher CORREIOS o campo Rastreio aparece; salvou "nb987654321br" → voltou como "NB987654321BR" e a pendência limpou; ao trocar pra O PRÓPRIO o rastreio some; nota "Envio do produto informado: CORREIOS — Rastreio: NB987654321BR" confirmada no banco; selo confirmado também na listagem "Chamados".
  - Dados de teste revertidos ao final (chamado voltou pro estado "envio não informado", nota de teste removida) pro usuário poder testar o fluxo do zero.
- **Status:** aplicado e testado (cliente); painel do agente implementado, mas sem credencial de staff pra conferir visualmente nesta conversa.

---

#### 2026-07-02 — Envio só com NF validada + dica (?) de emissão da NF + Complemento fora da validação

- **Arquivo(s) alterado(s):** `include/zk_equipment.php`, `include/client/zk-equip-edit.inc.php`.
- **Tipo:** módulo customizado (nenhum arquivo do core tocado).
- **Motivo/contexto:** pedido do usuário em 3 partes: (1) a barra "Envio do produto" não pode aparecer antes do XML da NF estar validado — senão o cliente despacha o produto sem NF; (2) um ícone de dica pro cliente saber os dados importantes pra **emitir** a NF (destinatário, CFOP, sem impostos — basicamente as regras que o botão "Verificar XML" confere); (3) o campo **Complemento** do endereço sai da regra de validação (texto livre, cada fornecedor digita de um jeito — já tinha dado falso positivo antes), mas o cliente ainda precisa saber dele pra pôr na NF — então ele entra na dica. O valor do Complemento foi extraído do próprio XML anexado ao chamado de teste ("Galpao 01 Area 01", normalizado do "Galpao 01␣␣Area 01" com espaço duplo do arquivo).
- **O que foi feito:**
  1. **Gate do Envio (tela):** a barra "Envio do produto" (cliente **e** agente) agora só renderiza quando `zk_ticket_nf_pendencia() === ''` (NF anexada, verificada e sem erro). Exceção deliberada: se o envio **já** foi informado (ex.: NF trocada depois), a barra continua visível — é informação, não convite pra despachar.
  2. **Gate do Envio (server-side):** `zk_save_ticket_envio()` recusa o salvamento com NF pendente ("A Nota Fiscal precisa estar validada antes de informar o envio.") — esconder o form é UX, a regra de verdade fica no servidor.
  3. **`enderDest.xCpl` removido** de `zk_nfe_destinatario_esperado()` (não é mais comparado na verificação do XML). O valor esperado mudou de lugar: nova função `zk_nfe_complemento_endereco()` ('Galpao 01 Area 01'), usada só pela dica.
  4. **Dica (?):** nova função `zk_nf_dica_html()` — botão circular "?" ao lado da área de NF que abre um balão com: Destinatário (razão social, CNPJ formatado, IE + "contribuinte do ICMS", endereço com **Complemento**, bairro/cidade/UF/CEP, telefone), CFOP (5915 remetente de MG / 6915 outro estado — remessa para conserto) e Impostos (nenhum destacado, operação isenta). O conteúdo é montado a partir das **mesmas funções** que a validação usa (`zk_nfe_destinatario_esperado()`, `zk_nfe_cfops_permitidos()`) — se a regra mudar, a dica muda junto, sem divergir. JS vanilla delegado (1 handler por página, abre/fecha no clique, fecha ao clicar fora); CSS `.zk-nf-dica-*` na paleta ZKTeco.
  5. O botão (?) aparece em **3 lugares**: painel do cliente, painel do agente e tela "Editar Equipamentos" (onde a NF é anexada).
- **Dependências/impactos:** a cascata de pendências continua a mesma (NF primeiro, envio depois) — o gate visual só reforça a ordem que a pendência já contava. NFs **já verificadas** não são re-avaliadas automaticamente (o resultado gravado em `errors` permanece); a remoção do xCpl vale a partir da próxima verificação.
- **Como reaplicar em versão nova:** reaplicar os blocos em `zk_equipment.php` (destinatário sem xCpl + `zk_nfe_complemento_endereco()`, guard em `zk_save_ticket_envio()`, `zk_nf_dica_html()`, gates de visibilidade nos 2 painéis, CSS) e o `zk_nf_dica_html()` na tela de editar (`zk-equip-edit.inc.php`).
- **Validação feita (chamado real #563163):**
  - Com NF validada: barra de envio visível; (?) abre o balão com todos os dados (Complemento incluso) e fecha ao clicar fora.
  - NF colocada em "não verificada" (via banco + sync): barra de envio **sumiu** dos painéis; badge virou "Nota anexada, mas não verificada"; `zk_save_ticket_envio()` via CLI recusou com a mensagem certa e nada foi gravado.
  - Clicado "Verificar XML" na tela (fluxo real): XML validado **sem erros com a regra nova (sem xCpl)**, barra de envio reapareceu, pendência voltou a "Envio do produto não informado" — ciclo completo confirmado no banco (`errors=''`).
- **Status:** aplicado e testado (cliente); dica também presente no painel do agente, sem conferência visual de staff nesta conversa.

---

#### 2026-07-02 — Correção: pop-up "Sair do site?" ao anexar a NF pelo painel do chamado

- **Arquivo(s) alterado(s):** `include/zk_equipment.php` (só os painéis; nenhum core tocado).
- **Motivo/contexto:** o usuário reportou (com print) que toda vez que anexava uma NF pelo ícone de clipe no painel do chamado, o navegador abria o pop-up nativo "Sair do site? É possível que as alterações feitas não sejam salvas" — assustador e sem sentido ali, já que anexar é exatamente o que ele estava tentando fazer.
- **Causa raiz (em `js/osticket.js` do core, linhas 24–47):** o osTicket marca QUALQUER `:input` alterado como "alteração não salva" e arma um aviso `beforeunload` global. Ele desarma esse aviso quando um form é enviado — mas só se o envio passar pelo handler jQuery (`$('form').submit(...)`). O nosso anexo rápido enviava o form via `.submit()` **nativo** do DOM (que NÃO dispara handlers jQuery), então: escolher o arquivo armava o aviso, o envio não desarmava, e o navegador perguntava se podia "sair".
- **O que foi feito (2 camadas, nas 2 pontas):**
  1. `class="nowarn"` nos campos de ação imediata — o próprio core exclui `.nowarn` da marcação de "não salvo" (`form :input:not(.nowarn)`). Aplicado no input de arquivo do anexo rápido (painéis do cliente e do agente) e nos 2 campos da barra de envio (transportadora/rastreio), que também armavam o aviso à toa.
  2. Envio do form do anexo rápido trocado de `.submit()` nativo para `$('#...').trigger('submit')` (jQuery) — passa pelo handler global do core que desarma o `beforeunload`, cobrindo até o caso da página já estar "suja" por outro motivo (ex.: resposta digitada e não enviada).
- **Fora do escopo de propósito:** a tela "Editar Equipamentos" também usa `.submit()` nativo nos botões de apagar/verificar NF, mas LÁ o aviso é legítimo — protege edições reais da grade que seriam perdidas no redirect — então foi mantida como está.
- **Validação feita:** anexo de NF simulado ao vivo no painel do cliente (arquivo injetado no input + evento `change` real): o form enviou **sem nenhum pop-up**, página recarregou já com a NF anexada e pendência "Nota anexada, mas não verificada". NF de teste removida ao final (chamado voltou a "Sem nota fiscal").
- **Status:** aplicado e testado (cliente).

---

#### 2026-07-02 — Botão "Confirmar envio" + pendência "Aguardando confirmação do envio"

- **Arquivo(s) alterado(s):** `include/zk_equipment.php`, `zk-equip-edit.php`; banco: `ALTER TABLE ost_zk_ticket_envio ADD COLUMN confirmado DATETIME NULL DEFAULT NULL;`
- **Tipo:** módulo customizado + banco (nenhum core tocado).
- **Motivo/contexto:** pedido do usuário — informar a transportadora não significa que o produto FOI despachado. Depois de XML validado e tipo de envio escolhido, entra mais uma pendência, "Aguardando confirmação do envio", e um botão "Confirmar envio"; ao confirmar, a ZKTeco sabe que o produto está a caminho e fica no aguardo da chegada.
- **A cascata de pendências automáticas ficou com 3 degraus** (sempre um passo de cada vez, nunca sobrescrevendo pendência manual do agente):
  1. NF: `sem_nf` → `nf_nao_verificada` → `nf_com_erro` (até validar);
  2. `envio_nao_informado` (NF ok, transportadora não escolhida);
  3. **`envio_nao_confirmado`** ("Aguardando confirmação do envio" — NF ok, envio informado, falta o clique de confirmação);
  4. tudo resolvido → pendência limpa.
- **O que foi feito:**
  1. Coluna `confirmado` (DATETIME NULL) em `ost_zk_ticket_envio` — NULL = não confirmado; preenchida com a data/hora do clique.
  2. `zk_ticket_envio_pendencia()` ganhou o degrau novo; `zk_ticket_envio()` retorna `confirmado`; `zk_ticket_envio_resumo($tid, true)` anexa "envio confirmado em X" / "aguardando confirmação do envio" (usado no painel do agente e nas notas).
  3. Nova `zk_confirm_ticket_envio()`: valida NF ok + envio informado + ainda não confirmado; grava `confirmado=NOW()` e sincroniza a pendência.
  4. **Trava pós-confirmação:** `zk_save_ticket_envio()` recusa alterações depois de confirmado ("os dados não podem mais ser alterados") — o registro do que foi despachado fica imutável pro cliente; ajuste posterior só via agente/banco.
  5. **Painel do cliente:** o botão "Confirmar envio" (verde escuro, ícone ✓) aparece no MESMO form da barra de envio, mas só depois do tipo de envio já salvo. O clique salva eventuais ajustes de transportadora/rastreio E confirma numa tacada só (em `zk-equip-edit.php`, o bloco `zk_envio_confirm` roda antes do `zk_envio_save` e faz save→confirm em sequência). JS pede confirmação ("Confirmar que o produto já foi enviado? Depois de confirmado, os dados não poderão mais ser alterados") — detecta qual botão disparou o submit via `e.originalEvent.submitter`. Depois de confirmado, a barra vira somente-leitura: resumo + "✓ Envio confirmado em dd/mm/aa hh:mm" em verde.
  6. **Painel do agente:** o resumo do envio agora inclui o estado da confirmação (aguardando / confirmado em X).
  7. Nota de histórico "Envio do produto confirmado" gravada na confirmação.
- **Dependências/impactos:** o selo novo aparece na listagem "Chamados" automaticamente (mesma fonte de pendências). Registros de envio existentes ganham `confirmado=NULL` → contam como "aguardando confirmação" na próxima sincronização (correto: ninguém confirmou ainda).
- **Como reaplicar em versão nova:** rodar o ALTER TABLE acima e reaplicar os blocos de `zk_equipment.php` (pendência nova + managed, funções de envio com `confirmado`, barra do cliente com o botão + JS, resumo do agente) e o bloco `zk_envio_confirm` em `zk-equip-edit.php`.
- **Validação feita (CLI, chamado real #563163):** com envio informado e não confirmado, sync marca `envio_nao_confirmado` e o resumo diz "aguardando confirmação do envio"; editar transportadora/rastreio ainda funciona antes de confirmar; confirmar limpa a pendência e o resumo vira "envio confirmado em 07/02/26 19:45"; depois de confirmado, salvar E reconfirmar são recusados com as mensagens certas. **Teste visual do botão ficou pendente** — a sessão do portal expirou no meio do teste (tela de login; sem inserir credenciais por política). O chamado ficou preparado: NF validada + envio "O PRÓPRIO" aguardando confirmação — é só logar e clicar em "Confirmar envio".
- **Obs. de teste:** durante o teste CLI, uma chamada de `zk_confirm_ticket_envio()` confirmou sem querer o envio real do chamado (o usuário tinha informado "O PRÓPRIO" minutos antes) — revertido imediatamente (`confirmado=NULL` + sync).
- **Status:** aplicado; lógica testada via CLI; **botão confirmado funcionando ao vivo** — o próprio usuário clicou "Confirmar envio" na UI às 20:00 (nota "Envio do produto confirmado" gravada no histórico).

---

#### 2026-07-02 — Trava total do chamado pro cliente depois do "Confirmar envio"

- **Arquivo(s) alterado(s):** `include/zk_equipment.php`, `include/client/view.inc.php` (core, mini-edit), `tickets.php` (core, 2 mini-edits) — todos marcados `ZK-EQUIP`.
- **Motivo/contexto:** pedido do usuário — depois de confirmar o envio, o produto está **em trânsito**: o cliente não pode mais alterar NADA do chamado (nem equipamentos, nem o XML da NF, nem o envio). Validação/solicitação/alteração a partir daí será papel do agente, numa tela a ser trabalhada no futuro.
- **O que foi feito:**
  1. Nova função-fonte única `zk_ticket_locked_for_client($ticket_id)` — `true` quando `ost_zk_ticket_envio.confirmado` está preenchido.
  2. `zk_equip_client_can_edit()` passou a incluir `!zk_ticket_locked_for_client(...)` — como TODO o fluxo de edição do cliente passa por esse gate (entrada do `zk-equip-edit.php`, que também processa NF anexar/trocar/apagar/verificar e envio salvar/confirmar, e o include da tela), **uma linha travou o caminho principal inteiro**, tela e server-side juntos.
  3. `include/client/view.inc.php`: botão **Editar** some com o chamado travado.
  4. `tickets.php` (rota padrão de edição do core, que continua existindo por fora da grade ZK): bloqueados o GET `?a=edit` (não abre mais a tela de campos dinâmicos) e o POST `a=edit` (não salva; "Access Denied") quando travado.
  5. Painel do cliente: as ações de NF ("Verificar XML" / clipe de anexar) e o botão de dica (?) agora só renderizam quando `zk_equip_client_can_edit()` — com o chamado travado sobra o link de download da NF, a barra de envio confirmada (somente leitura, "✓ Envio confirmado em ...") e a grade como consulta.
  6. **Continua liberado de propósito:** postar resposta/pergunta na thread (é conversa, não dado do chamado) e baixar a NF.
- **Guardas server-side em camadas (já existiam, reforçadas pelo gate):** `zk_save_ticket_envio()` e `zk_confirm_ticket_envio()` recusam alterações pós-confirmação por conta própria, mesmo se chamadas por outro caminho.
- **Como reaplicar em versão nova:** recriar `zk_ticket_locked_for_client()` + a linha no `zk_equip_client_can_edit()` em `zk_equipment.php`, o condicional do botão Editar em `view.inc.php`, os 2 bloqueios (GET/POST `a=edit`) em `tickets.php` e o condicional `$podeEditar` nas ações de NF do painel do cliente. Todos os pontos têm `function_exists()` de guarda — se o módulo ZK não carregar, o core volta ao comportamento padrão.
- **Validação feita (CLI, chamado real #563163):** com envio confirmado → `locked=true`, salvar envio e reconfirmar recusados; desfazendo a confirmação → `locked=false` e pendência volta a "Aguardando confirmação do envio". Visual conferido indiretamente: o usuário confirmou o envio ao vivo na UI minutos antes (nota no histórico às 20:00:22).
- **Obs. de teste (transparência):** durante os testes CLI, a confirmação REAL que o usuário tinha acabado de fazer na UI foi desfeita sem querer por um passo de "cleanup" do script — restaurada em seguida com o timestamp exato da nota de histórico (20:00:22). O chamado ficou como o usuário deixou: envio O PRÓPRIO confirmado, pendência limpa, chamado travado.
- **Status:** aplicado e testado (lógica via CLI); conferência visual das telas travadas pendente de login do usuário.

---

#### 2026-07-02 — Status do chamado muda para "Enviado" ao confirmar o envio

- **Arquivo(s) alterado(s):** `include/zk_equipment.php`; banco: novo registro em `ost_ticket_status`.
- **Tipo:** módulo customizado + banco (nenhum core tocado).
- **Motivo/contexto:** pedido do usuário (com print da listagem "Chamados" mostrando Status "Solicitado") — depois que o cliente confirma o envio, o status do CHAMADO deve refletir isso: sai de "Solicitado" e vira "Enviado".
- **Banco (rodar em instalação nova):**
  ```sql
  UPDATE ost_ticket_status SET sort=sort+1 WHERE sort>=2;
  INSERT INTO ost_ticket_status
    SET name='Enviado', state='open', mode=3, flags=0, sort=2,
        properties='{"description":"Produto enviado pelo cliente - aguardando chegada na ZKTeco."}',
        created=NOW(), updated=NOW();
  ```
  `state='open'` — o chamado continua aberto (aparece na aba "Aberto" da listagem); só o rótulo do estágio muda. `sort=2` posiciona entre "Solicitado" e "Resolvido" (os demais foram re-numerados).
- **O que foi feito:**
  1. Nova função `zk_ticket_set_status_enviado($ticket_id)`: localiza o status **por nome** ("Enviado", via `TicketStatus::lookup(array('name'=>...))` — não depende de id fixo entre instalações) e aplica com `Ticket::setStatus()` (API nativa: registra o evento na timeline e sincroniza a listagem/`__cdata` sozinha). Idempotente — se o chamado já está "Enviado", não faz nada.
  2. Chamada ao final de `zk_confirm_ticket_envio()` (depois de gravar a confirmação e sincronizar a pendência), dentro de try/catch — se o status não existir no banco, a confirmação do envio continua valendo (o status é o reflexo, não o registro).
- **Nota sobre permissões:** `Ticket::setStatus()` só faz checagem de papel quando há `$thisstaff` (agente logado); no fluxo do cliente/CLI passa direto, e transição open→open não exige permissão de fechar — verificado no código do core antes de usar.
- **Dependências/impactos:** fluxos existentes intactos — chamado novo continua nascendo "Solicitado" (status padrão do sistema); "Enviado" é `state=open`, então continua contando na aba "Aberto" e nas buscas de chamados abertos. Agente pode mudar o status manualmente como sempre.
- **Como reaplicar em versão nova:** rodar o SQL acima e reaplicar as 2 funções/chamada em `zk_equipment.php`. Conferir que o nome "Enviado" não colide com outro status existente.
- **Validação feita (CLI, chamado real #563163, que o usuário já tinha confirmado via UI):** `zk_ticket_set_status_enviado(10)` → status foi de "Solicitado" pra "Enviado" (state open), segunda chamada retornou true sem efeito (idempotente), `ost_ticket.status_id=6` confirmado no banco — a listagem "Chamados" passa a exibir "Enviado".
- **Status:** aplicado e testado.

---

#### 2026-07-03 — Tela do chamado: informações do ticket/usuário em cartões (padrão ZKTeco)

- **Arquivo(s) alterado(s):** `include/client/view.inc.php` (core), `assets/default/css/theme.css`
- **Backup do original:** `include/client/view.inc.php.pre-ticket-cards-backup` e `assets/default/css/theme.css.pre-ticket-cards-backup` (estado imediatamente anterior a esta mudança, já com as customizações ZK-EQUIP)
- **Tipo:** core (template do cliente) + CSS do tema
- **Motivo/contexto:** o topo da tela do chamado ("Informações básicas sobre o ticket" / "Informações do Usuário") ainda usava as tabelas `.infoTable` do layout de fábrica do osTicket — visual datado e com quebra de linha nos rótulos ("Status do Chamado:", "Data de Criação:") mesmo havendo espaço. Pedido: modernizar para o cliente, no mesmo padrão dos painéis ZK já existentes.
- **O que foi feito:**
  1. **`view.inc.php`** — bloco demarcado `ZK-TICKETINFO:BEGIN/END` substitui a `<table id="ticketInfo">` inteira (título + 2 `.infoTable` + `.custom-data`) por `<div id="ticketInfo" class="zk-ti">`:
     - `.zk-ti-head`: flex com o `h1` (assunto + nº) à esquerda e o botão **Editar** à direita (mesma lógica/condições de antes, incluindo a trava ZK-EQUIP pós-"Confirmar envio" e o desvio pra `zk-equip-edit.php`).
     - `.zk-ti-grid`: 2 cartões lado a lado — "Informações básicas" (ícone `icon-file-text`) e "Informações do Usuário" (ícone `icon-user`). Cada linha é `.zk-ti-row` com rótulo fixo de 150px (`white-space:nowrap` — fim da quebra de linha) e valor.
     - **Status do chamado virou selo colorido** (`.zk-ti-status`), cor pelo *state* do status: open=`#7AC143`, resolved=`#649E37`, closed/archived=`#9aa0a6`, deleted=`#c0392b`, fallback `#474B4F`. Como "Solicitado" e "Enviado" são ambos state=open, ambos aparecem verdes.
     - Link do WhatsApp no telefone mantido intacto (lógica ZK-EQUIP com `zk_whatsapp_url`).
     - Formulários extras (Custom Data, mesmo loop PHP de antes) também renderizam como cartão (`.zk-ti-card.zk-ti-extra`, ícone `icon-list-alt`) em vez de `table.custom-data`.
  2. **`theme.css`** — na camada ZKTeco:
     - Removidas as regras antigas que forçavam largura/empilhamento da `<table id="ticketInfo">` (bloco "usar a largura disponível" e o trecho correspondente do `@media 768px`) — o markup de tabela não existe mais.
     - Novo bloco `.zk-ti-*`: cartões brancos com borda `#e3e6e2`, raio 8px e sombra leve; cabeçalho do cartão cinza-claro `#f5f7f4` com filete verde à esquerda (mesma assinatura visual do `.zk-panel-title`); `h1` sem o pontilhado antigo do core; responsivo: os 2 cartões empilham em 1 coluna abaixo de 768px.
- **Dependências/impactos:** nenhuma mudança de dados/PHP de negócio — só apresentação. O id `#ticketInfo` foi mantido no wrapper (regras genéricas como `#content #ticketInfo{max-width:none}` continuam valendo). As classes core `.infoTable`/`.custom-data` deixam de ser usadas nesta tela (as regras do core que sobraram no CSS ficam inertes). O painel de equipamentos (`zk_equipment_client_panel`) e a thread não foram tocados.
- **Como reaplicar em versão nova:** recriar o bloco `ZK-TICKETINFO` no `view.inc.php` novo (conferir antes se o core mudou os campos exibidos) e copiar o bloco `.zk-ti-*` do `theme.css`. Depende das variáveis CSS `--zk-green`/`--zk-graphite`/`--zk-green-dk` da camada ZKTeco.
- **Cache do CSS (lição aprendida):** na primeira visualização o layout apareceu "cru" (divs sem estilo) porque o navegador seguia com o `theme.css` antigo em cache — o link em `include/client/header.inc.php` usava o cache-buster fixo `?a1114e5` do core. Solução definitiva: o `theme.css` ganhou **cache-buster próprio** (`?zk20260703a`) nesse arquivo. **Sempre que mexer no `theme.css`, incrementar esse sufixo** (ex.: `zk20260703b`) pra não depender de Ctrl+F5 de cada cliente.
- **Validação feita:** `php -l` sem erros; página respondendo HTTP 200; confirmação visual via navegador (screenshot): cartões lado a lado, selo verde "Enviado", rótulos sem quebra, link WhatsApp e painel de equipamentos intactos.
- **Status:** aplicado e testado.

---

#### 2026-07-03 — Tela do chamado 100% em cartões (Equipamentos, Mensagens, Postar uma resposta)

- **Arquivo(s) alterado(s):** `include/client/view.inc.php` (core), `include/zk_equipment.php`, `assets/default/css/theme.css`, `include/client/header.inc.php` (cache-buster `?zk20260703b`)
- **Tipo:** core (template do cliente) + módulo ZK + CSS do tema
- **Motivo/contexto:** o usuário aprovou o conceito de cartões dos blocos de informações e pediu para estender à tela inteira: painel de Equipamentos e a troca de mensagens (que vai crescer conforme o chamado evolui) com a mesma divisão clara de tópicos.
- **O que foi feito:**
  1. **Painel "Equipamentos" vira cartão (só no cliente):** em `zk_equipment.php`, o título do painel do CLIENTE ganhou o ícone `icon-wrench` (o do agente ficou intacto). Todo o resto é CSS em `theme.css`, escopado em `.zk-panel.zk-client`: fundo branco, borda/raio/sombra iguais aos `.zk-ti-card`, cabeçalho cinza-claro com filete verde (o `.zk-panel-head`, que já continha o título e o link/ações da Nota Fiscal), e respiro lateral de 16px para os filhos diretos (barra de envio, erros de NF, progresso, busca e tabela). O painel do AGENTE (SCP) não muda — não carrega `theme.css`, e o seletor `.zk-client` garante.
  2. **Thread vira cartão "Mensagens"** (`view.inc.php`, bloco ZK-TICKETINFO): o `$ticket->getThread()->render(...)` foi envolvido por `.zk-ti-card.zk-ti-thread` com título "Mensagens" (ícone `icon-comments`) e corpo `.zk-ti-card-body`. Os eventos do sistema ("Criado por…", "SYSTEM alterou o estado…") e as respostas futuras aparecem dentro do cartão.
  3. **Formulário de resposta vira cartão "Postar uma resposta"** (`view.inc.php`): o `<h2>` interno foi substituído pelo título do cartão (ícone `icon-pencil`); o form `#reply` inteiro (editor de texto, anexos, botões) ficou dentro do corpo do cartão. O cartão só é renderizado quando o form seria renderizado (chamado aberto/reabrível e não bloqueado por merge) — sem cartão vazio.
  4. **`theme.css`:** novas classes `.zk-ti-card-body`, `.zk-ti-thread`, `.zk-ti-reply` + bloco `.zk-panel.zk-client`; `#content .zk-ti-card` adicionado à lista de exceções de `max-width` (cartões de nível raiz usam a largura toda, como o painel de equipamentos).
- **Dependências/impactos:** nenhuma lógica alterada — só apresentação/envelopamento. O `<br>` solto entre painel e thread foi removido. Painel do agente, validações de NF, barra de envio e JS da busca continuam como estavam.
- **Como reaplicar em versão nova:** reaplicar os 2 envelopes de cartão no `view.inc.php` novo (thread e form de resposta), o ícone no título do painel cliente em `zk_equipment.php` e os blocos CSS citados no `theme.css`. Lembrar de **incrementar o cache-buster** do `theme.css` no `header.inc.php`.
- **Validação feita:** `php -l` sem erros nos 2 PHPs; confirmação visual via navegador (screenshots): 4 cartões consistentes (Informações, Equipamentos com NF no cabeçalho, Mensagens com timeline, Postar uma resposta com editor e botão verde "Publicar Resposta").
- **Status:** aplicado e testado.

---

#### 2026-07-03 — Nota Fiscal em barra própria no cartão Equipamentos (cliente)

- **Arquivo(s) alterado(s):** `include/zk_equipment.php`, `assets/default/css/theme.css`, `include/client/header.inc.php` (cache-buster `?zk20260703c`)
- **Tipo:** módulo ZK + CSS do tema
- **Motivo/contexto:** com o painel de Equipamentos virando cartão, o bloco da Nota Fiscal (link do XML + ações) ficou "solto" no canto direito do cabeçalho cinza — visualmente feio e desalinhado.
- **O que foi feito:**
  1. **`zk_equipment.php`** (só em `zk_equipment_client_panel`): o `<div class="zk-ticket-nf-status">` saiu de dentro do `.zk-panel-head` e virou irmão dele, logo abaixo, com a classe adicional `zk-nf-bar`. O cabeçalho ficou só com o título "🔧 Equipamentos (N)". Todo o conteúdo (link do XML, botão "Verificar XML", anexo rápido, dica "?") foi junto, sem mudança de lógica. **O painel do agente (SCP) não mudou** — lá a NF continua no head.
  2. **`theme.css`**: `.zk-panel.zk-client > .zk-nf-bar` com o mesmo visual da barra "Envio do produto" (`#fafcf8`, borda `#e3e6e2`, raio 6px, flex com gap) — as duas barras ficam empilhadas e consistentes no topo do corpo do cartão; link da NF em verde escuro com reticências se o nome for longo.
- **Ordem visual resultante no cartão:** cabeçalho → barra Nota Fiscal → (erros da NF, se houver) → barra Envio do produto → progresso → busca → tabela.
- **Dependências/impactos:** a regra antiga `.zk-panel-head .zk-ticket-nf-status` (no CSS embutido do módulo) fica inerte no cliente e segue valendo no agente. JS do anexo rápido intacto (ids preservados).
- **Como reaplicar em versão nova:** repetir a movimentação do div no painel do CLIENTE em `zk_equipment.php` e copiar o bloco `.zk-nf-bar` do `theme.css`. Incrementar o cache-buster.
- **Validação feita:** `php -l` sem erros; conferência manual do balanceamento dos divs; visual confirmado pelo usuário ("ficou muito bom").
- **Status:** aplicado e testado.

---

#### 2026-07-03 — Lista de Chamados em cartão + status colorido

- **Arquivo(s) alterado(s):** `include/client/tickets.inc.php` (core), `assets/default/css/theme.css`, `include/client/header.inc.php` (cache-buster `?zk20260703d`)
- **Tipo:** core (template do cliente) + CSS do tema
- **Motivo/contexto:** depois da tela do chamado virar cartões, a listagem "Chamados" ficou visualmente defasada (painel solto, status em texto puro).
- **O que foi feito:**
  1. **`theme.css`**: o painel da listagem (`.zk-panel.zk-tickets`, que já existia no markup) entrou nos mesmos seletores de cartão do painel de Equipamentos (`.zk-panel.zk-client`) — fundo branco, borda, raio 8px, sombra leve e cabeçalho cinza com filete verde (título "Chamados" + chips Aberto/Fechado à direita). Respiro interno de 16px para busca, tabela e paginação.
  2. **`tickets.inc.php`**: a célula de Status deixou de imprimir texto puro e passou a usar o **selo colorido `.zk-ti-status`** (mesma classe e paleta da tela do chamado, cor pelo `status__state`: open verde `#7AC143`, resolved verde-escuro, closed/archived cinza, deleted vermelho).
- **Dependências/impactos:** só apresentação; busca inteligente, ordenação, chips de estado, linha clicável e pendências por equipamento continuam como estavam. Depende das classes `.zk-ti-status` (entrada "cartões" de 2026-07-03) e `.zk-panel` (módulo ZK).
- **Como reaplicar em versão nova:** copiar os seletores `.zk-panel.zk-tickets` do `theme.css` e o trecho do selo de status no `tickets.inc.php` (a listagem inteira já é customizada — ver entrada de 2026-07-01 "Tela Chamados redesenhada"). Incrementar o cache-buster.
- **Validação feita:** `php -l` sem erros; visual confirmado via navegador (screenshot): cartão com cabeçalho, chip "Aberto (1)", selo verde "Enviado" na linha, paginação dentro do cartão.
- **Status:** aplicado e testado.

---

#### 2026-07-03 — Assunto inteligente para N equipamentos + sub-linha na listagem + ícone do chamado

- **Arquivo(s) alterado(s):** `include/zk_equipment.php`, `include/client/open.inc.php`, `include/client/tickets.inc.php` (core), `assets/default/css/theme.css`, `include/client/header.inc.php` (cache-buster `?zk20260703e`), banco (`ost_form_field` id=20)
- **Tipo:** módulo ZK + core (templates do cliente) + CSS + banco
- **Motivo/contexto:** o assunto de chamado com vários equipamentos era genérico ("Solicitação de manutenção — N equipamentos") e o de 1 equipamento ficava travado a modelo+S/N — com 10 equipamentos o título não dizia nada. O ícone do nº do chamado na listagem era o PNG de "origem" (web/email) do core, feio e sem significado pro cliente.
- **O que foi feito:**
  1. **Fonte única do assunto** — nova função `zk_equip_subject_text($items, $limit = 70)` em `zk_equipment.php`:
     - 1 item → `Manutenção — Modelo (S/N X)` (como antes);
     - N itens → `Manutenção — N equipamentos: 4× ModeloA, ModeloB` — **agrupa por modelo na ordem de cadastro**, com contagem (`4×`) quando repete; o que não couber em 70 chars vira `+K modelos`; se nem o 1º modelo couber, cai no formato simples `Manutenção — N equipamentos`.
     - Usada nos 2 pontos do servidor: `zk_equip_fill_ticket_vars` (criação, signal `ticket.create.before`) e `zk_equip_refresh_subject` (regeração pós-edição). O **JS de `open.inc.php`** (`fillAutoSubjectMessage`) espelha o mesmo algoritmo (constante `LIMIT = 70`).
     - Exemplos validados por teste CLI: `Manutenção — 3 equipamentos: 3× SpeedFace M4` (44 ch); `Manutenção — 10 equipamentos: 6× SpeedFace M4, 4× MB360` (55 ch); `Manutenção — 10 equipamentos: 4× SpeedFace M4, 3× MB360 +2 modelos` (66 ch); modelos muito compridos → fallback simples.
  2. **Limite do campo subject: 50 → 70** — `ost_form_field` id=20 ("Resumo do Problema", form core do ticket), `configuration` de `{"size":40,"length":50}` para `{"size":40,"length":70}` (update via script PHP com credenciais do `ost-config.php`, sem SQL manual).
  3. **Sub-linha de equipamentos na listagem** (`tickets.inc.php`): abaixo do assunto, `🔧 N equipamentos · X concluídos` (cinza); quando todos concluídos vira **verde com ✓** (`.zk-equip-done`). Alimentada pela nova função `zk_equip_counts_for_tickets($ids)` — **1 consulta agregada por página** (`COUNT(*)` + `SUM(status IN (concluídos))`, statuses "done" vindos de `zk_equip_statuses()`), sem N+1, no mesmo padrão da `zk_equip_pendencias_for_tickets`.
  4. **Ícone do nº do chamado**: `<a class="Icon webTicket">` (PNG por origem) → `<a class="zk-ticket-num"><i class="icon-ticket"></i> nº</a>` — ícone de bilhete do Font Awesome 3.2.1 (já carregado pelo tema) em verde ZKTeco, número em grafite.
- **Dependências/impactos:** chamados EXISTENTES mantêm o assunto atual até a próxima edição de equipamentos (aí `zk_equip_refresh_subject` regenera no novo formato — o formato de 1 equipamento é idêntico ao antigo). E-mails usam o mesmo subject (70 chars é seguro). A regra antiga "Solicitação de manutenção — N equipamentos" deixa de existir para chamados novos.
- **Como reaplicar em versão nova:** copiar `zk_equip_subject_text` + `zk_equip_counts_for_tickets` junto com o módulo; reaplicar o JS em `open.inc.php`, a sub-linha/ícone em `tickets.inc.php` e o CSS (`.zk-ticket-num`, `.zk-equip-done`); rodar o update do `length` do campo subject (id pode variar — buscar por `name='subject'`).
- **Validação feita:** `php -l` nos 3 PHPs; teste CLI da função com 6 cenários (1 equip, repetidos, 2 modelos, 4 modelos com corte, modelos compridos, sem modelo); visual confirmado no navegador (ícone verde + sub-linha "1 equipamento · 0 concluídos" no chamado real). Depois, confirmado em produção com chamado novo #239283 de 5 equipamentos (assunto novo + sub-linha + pendência "Sem nota fiscal" na listagem).
- **Status:** aplicado e testado.

---

#### 2026-07-03 — Pop-up "Por favor, aguarde!" sem o subtexto "vai levar um segundo!"

- **Arquivo(s) alterado(s):** `include/client/footer.inc.php` (core), `assets/default/css/theme.css`, `include/client/header.inc.php` (cache-buster `?zk20260703f`)
- **Tipo:** core (template do cliente) + CSS do tema
- **Motivo/contexto:** o pop-up de carregamento do core mostra "Por favor aguarde... vai levar um segundo!" — em envios reais (fotos + NF) costuma demorar bem mais que 1 segundo; a promessa era falsa. Pedido: deixar só "Por favor, aguarde!".
- **O que foi feito:** removido o `<p>` do `#loading` no `footer.inc.php` (fica só o `<h4>`; o spinner é background do próprio `#loading`, não some). No `theme.css`, o bloco ZK do `#loading` ganhou `height:auto` (o core fixa 100px — só com o título sobrava um vazio) e padding vertical que centraliza o título ao lado do spinner.
- **Dependências/impactos:** o pop-up é global do portal do cliente (submits de formulário via osticket.js). O painel do agente tem seu próprio footer (`include/staff/footer.inc.php`) e não foi alterado.
- **Como reaplicar em versão nova:** remover o `<p>` do `#loading` no `footer.inc.php` novo e reaplicar o bloco `#loading` do `theme.css`.
- **Validação feita:** `php -l` sem erros; pop-up forçado via JS no navegador (screenshot): caixa compacta, só título + spinner.
- **Status:** aplicado e testado.

---

#### 2026-07-03 — Listagem: coluna Assunto fluida (sem teto fixo de 420px)

- **Arquivo(s) alterado(s):** `assets/default/css/theme.css`, `include/client/tickets.inc.php` (core), `include/client/header.inc.php` (cache-buster `?zk20260703g`)
- **Tipo:** CSS do tema + core (template do cliente)
- **Motivo/contexto:** o assunto novo multi-equipamento aparecia cortado com "…" na listagem mesmo com MUITO espaço sobrando na tela — o CSS embutido do módulo (`zk_equip_styles`, regra `#ticketTable .zk-issue-line`) fixa `max-width:420px`.
- **O que foi feito:**
  1. **`theme.css`**: `#ticketTable` da listagem passa a `table-layout:fixed; width:100%` (1ª coluna fixa em 150px; Data/Status/Departamento/Pendência mantêm os widths do markup) e a coluna **Assunto herda TODO o espaço restante**. `.zk-issue-line` da listagem ganha `max-width:none` — o corte com "…" continua existindo, mas agora só quando o texto de fato não cabe na janela atual (monitor menor, janela redimensionada), sem quebra de linha. Seletor `.zk-panel.zk-tickets #ticketTable ...` mais específico de propósito: o CSS do módulo é inline no `<body>` (carrega DEPOIS do theme.css), então especificidade era a única forma de vencer.
  2. **`tickets.inc.php`**: o div do assunto ganhou `title` com o texto completo (tooltip no hover quando estiver cortado); removido um atributo `href` inválido que existia nesses divs.
- **Dependências/impactos:** só a tabela da LISTAGEM (`.zk-panel.zk-tickets`) — a regra dos 420px continua valendo pras tabelas de equipamentos (lá o corte curto é proposital, com tooltip). Nada muda no assunto armazenado (teto de 70 chars do campo).
- **Como reaplicar em versão nova:** copiar o bloco "coluna Assunto fluida" do `theme.css` e o `title` no div do assunto do `tickets.inc.php`.
- **Validação feita:** `php -l` sem erros; visual no navegador: assunto de 70 chars ("Manutenção — 6 equipamentos: SpeedFace V5L, SpeedFace V4L +4 modelos") exibido por inteiro, colunas alinhadas.
- **Status:** aplicado e testado.

---

#### 2026-07-03 — Lixeira da Nota Fiscal no painel do chamado (cliente)

- **Arquivo(s) alterado(s):** `include/zk_equipment.php`, `zk-equip-edit.php`
- **Tipo:** módulo ZK
- **Motivo/contexto:** quando o XML anexado vem errado (verificação aponta erros), o cliente precisava ir até a tela "Editar equipamentos" pra remover a NF. Pedido: excluir direto do painel do chamado, ao lado do "Verificar XML".
- **O que foi feito:**
  1. **`zk_equipment.php`** (painel do CLIENTE, barra da NF): novo form isolado com botão-lixeira (`.zk-nf-del-btn`, círculo de 22px com `icon-trash`, vermelho no hover — mesma linguagem do "×" da tela de editar), com `confirm()` antes de enviar. Aparece **só quando há NF anexada e o chamado ainda é editável** (some após o "Confirmar envio", junto com as demais ações). Usa a MESMA rota já existente `zk_ticket_nf_delete` de `zk-equip-edit.php` (mantém o log "Nota Fiscal removida" na timeline e a ressincronização automática da pendência pra "Sem nota fiscal"). CSS no bloco embutido do módulo (`zk_equip_styles`) — sem mexer no theme.css, logo **sem bump de cache-buster**.
  2. **`zk-equip-edit.php`**: a ação de apagar ganhou o hidden `zk_back_ticket=1` — quando vem do painel, o redirect volta pra `tickets.php?id=` (antes voltava sempre pra tela de editar). Sem o hidden, o comportamento antigo continua igual (a tela de editar volta pra si mesma).
  - Depois de apagar, a barra da NF renderiza automaticamente o **clipe de anexar** (estado "sem NF"), então o fluxo "apagou → anexou a correta" acontece sem sair do chamado.
- **Dependências/impactos:** nenhuma rota nova — só um hidden a mais na existente; o painel do AGENTE não foi alterado.
- **Como reaplicar em versão nova:** reaplicar o form da lixeira no painel cliente, o CSS `.zk-nf-del-btn` no `zk_equip_styles` e o desvio `zk_back_ticket` no `zk-equip-edit.php`.
- **Validação feita:** `php -l` nos 2 arquivos; visual confirmado no navegador (lixeira na barra, entre "Verificar XML" e a dica "?"). Exclusão de fato não executada no teste (apagaria o XML real do chamado do usuário) — rota é a mesma já testada da tela de editar.
- **Status:** aplicado — fluxo de exclusão a confirmar pelo usuário.

---

#### 2026-07-03 — Erros da NF em tabela comparativa (Campo | Está na NF | Deveria estar)

- **Arquivo(s) alterado(s):** `include/zk_equipment.php`
- **Tipo:** módulo ZK (sem theme.css — CSS no bloco embutido `zk_equip_styles`, logo sem bump de cache-buster)
- **Motivo/contexto:** os erros da verificação do XML apareciam como frases corridas (`Destinatário: "enderDest.xLgr" está "ROD MG010 N", deveria ser "Rua Maria Martins".`) — difícil de bater o olho e corrigir a nota, ainda mais com 10 erros.
- **O que foi feito:**
  1. Nova função `zk_nfe_campo_label($path)` — traduz o caminho técnico do campo pra nome amigável ("xNome" → "Razão social", "enderDest.cMun" → "Cód. do município (IBGE)", etc.; caminho desconhecido volta cru).
  2. `zk_ticket_nf_errors_html()` reescrita: **parseia as frases armazenadas** (padrões fixos dos `sprintf` de `zk_validate_nfe_xml` — destinatário divergente, campo ausente, CFOP inválido e imposto destacado) e renderiza **tabela comparativa de 3 colunas**: Campo (negrito) | ✕ Está na NF (vermelho) | ✓ Deveria estar (verde). O que não casar com nenhum padrão cai na lista simples de antes, abaixo da tabela — nada se perde. Campo ausente mostra "*ausente no XML*" em itálico na coluna do meio.
  3. **O formato ARMAZENADO não mudou** (frases em `ost_zk_ticket_file.errors`, também usadas nos logs da timeline) — só a exibição. Vale automaticamente nos 3 pontos que chamam a função: painel do cliente, painel do agente (SCP) e tela "Editar equipamentos".
  4. CSS da tabela no `zk_equip_styles` (fundo branco dentro da caixa rosa, cabeçalho rosado, wrapper `overflow-x:auto` pra telas estreitas).
- **Atenção ao reaplicar/alterar:** se as MENSAGENS dos `sprintf` em `zk_validate_nfe_xml` mudarem, os regex de parse em `zk_ticket_nf_errors_html` precisam mudar JUNTO (senão os erros só caem na lista simples — degrada bonito, mas degrada).
- **Validação feita:** `php -l`; teste CLI com as funções reais extraídas do módulo + os 10 erros reais do chamado #239283: 9 viraram linhas da tabela (incluindo CFOP, imposto e campo ausente) e 1 (XML corrompido, sem padrão) caiu na lista simples, como projetado.
- **Status:** aplicado e testado (visual no navegador pendente — sessão do cliente expirou; recarregar a página do chamado já mostra a tabela). Visual confirmado pelo usuário em seguida.

---

#### 2026-07-03 — Validação do XML: telefone fora das regras + pontuação ignorada na comparação

- **Arquivo(s) alterado(s):** `include/zk_equipment.php`
- **Tipo:** módulo ZK (regra de negócio da validação da NF)
- **Motivo/contexto:** dois falsos positivos apontados pelo usuário na NF real do chamado #239283: (1) Razão social "ZKTECO DO BRASIL S.A" acusada só porque faltou o **ponto final** do "S.A."; (2) Telefone "03130553530" acusado por causa do **zero à esquerda no DDD** — formatação, não erro. Decisão: telefone NÃO entra na regra de validação do XML.
- **O que foi feito:**
  1. **`enderDest.fone` removido de `zk_nfe_destinatario_esperado()`** (mesmo tratamento do Complemento em 2026-07-02): não é mais validado, mas segue exibido na dica "(?)" via nova função `zk_nfe_telefone()` (a dica formatava o fone a partir do mapa — foi apontada pra função nova).
  2. **Nova `zk_nfe_normalize_cmp()`**: a comparação dos campos do destinatário, além de espaçamento/caixa (`zk_nfe_normalize_ws`), agora ignora a pontuação `.` `,` `/` `-` — "S.A" ≡ "S.A.", e CNPJ/CEP com máscara ("08.057.340/0001-60") também passam. Dígitos e letras não são tocados: conteúdo realmente divergente (rua, número, cidade…) continua sendo acusado.
- **Dependências/impactos:** a dica "(?)" continua mostrando o telefone. Erros já GRAVADOS no banco não mudam sozinhos — clicar **"Verificar XML"** re-valida e as duas linhas falso-positivas somem. A tabela comparativa (entrada anterior) não precisa de ajuste.
- **Como reaplicar em versão nova:** faz parte do módulo `zk_equipment.php` — copiar junto.
- **Validação feita:** `php -l`; teste CLI com XML sintético (funções reais extraídas do módulo): xNome sem ponto final aceito, fone com 0 no DDD ignorado, bairro propositalmente errado continuou acusado — exatamente 1 erro retornado.
- **Status:** aplicado e testado.

---

#### 2026-07-03 — Verificação automática do XML no upload + selo "XML validado"

- **Arquivo(s) alterado(s):** `include/zk_equipment.php`, `include/client/zk-equip-edit.inc.php`
- **Tipo:** módulo ZK + template do cliente (CSS no bloco embutido do módulo — sem bump de cache-buster)
- **Motivo/contexto:** o cliente anexava o XML e ainda precisava clicar em "Verificar XML" — passo manual desnecessário; a pendência "Nota anexada, mas não verificada" existia só por causa desse intervalo.
- **O que foi feito:**
  1. **`zk_save_ticket_nf()` agora chama `zk_verify_ticket_nf()` logo após gravar** a NF nova — como é o ponto ÚNICO de gravação, a verificação automática vale pra TODOS os fluxos: criação do chamado, clipe rápido do painel, tela "Editar equipamentos" e painel do agente (scp). A pendência "nf_nao_verificada" deixa de existir na prática (o enum fica, pra NFs antigas).
  2. **Painel do chamado (cliente)** — barra da NF, três estados:
     - NF validada sem erro → **selo verde "XML validado"** (com tooltip do que foi conferido); botão "Verificar XML" some; **lixeira continua** pra trocar o XML se precisar;
     - NF com erro (ou antiga não verificada) → tabela de erros + pendência + botões "Verificar XML" e lixeira, como antes;
     - Sem NF → clipe de anexar (inalterado).
     O selo aparece também pro chamado travado pós-"Confirmar envio" (informativo); as AÇÕES continuam sumindo com a trava.
  3. **Tela "Editar equipamentos"**: mesma lógica (selo quando validada, botão Verificar só quando há pendência, "×" de apagar sempre que há NF).
  4. CSS `.zk-nf-valid` (pílula verde) no `zk_equip_styles`.
- **Dependências/impactos:** o botão "Verificar XML" continua existindo pro estado com erro (re-verificação manual, útil se as REGRAS mudarem depois do upload — ex.: correção de falso positivo como a do telefone). A verificação automática não gera nota na timeline (a manual continua gerando).
- **Como reaplicar em versão nova:** faz parte do módulo + reaplicar o trecho da NF no `zk-equip-edit.inc.php`.
- **Validação feita:** `php -l` nos 2 arquivos; painel conferido no navegador no estado "sem NF" (clipe, sem selo/botões — correto). Ciclo completo upload→auto-verificação a confirmar pelo usuário com o XML corrigido real.
- **Status:** aplicado — aguardando teste do usuário com XML real.

---

#### 2026-07-03 — Listagem: Pendência alargada / Assunto reduzido (badge estourava a página)

- **Arquivo(s) alterado(s):** `assets/default/css/theme.css`, `include/client/header.inc.php` (cache-buster `?zk20260703h`)
- **Tipo:** CSS do tema
- **Motivo/contexto:** com a tabela em `table-layout:fixed` (entrada "coluna Assunto fluida"), a coluna Pendência ficou presa nos 160px do markup — o badge mais comprido ("Envio do produto não informado", `white-space:nowrap`) vazava pra fora do cartão e criava barra de rolagem horizontal na página.
- **O que foi feito:** no bloco `.zk-panel.zk-tickets #ticketTable` do `theme.css`: coluna 5 (Departamento) reduzida a **120px**, coluna 6 (Pendência) alargada a **230px** — como o Assunto é a coluna fluida, ele encolhe pra compensar (era o pedido). Backup extra: `.zk-badge-pend` dentro da listagem perdeu o `nowrap` (herda `white-space:normal`) e pode quebrar em 2 linhas se a janela ficar estreita demais, em vez de estourar a página.
- **Dependências/impactos:** só a listagem de Chamados; os badges nas tabelas de equipamentos seguem `nowrap` (lá o wrapper tem scroll próprio).
- **Como reaplicar em versão nova:** junto com o bloco `.zk-panel.zk-tickets` do `theme.css`.
- **Validação feita:** `css` puro (larguras determinísticas em layout fixo); confirmação visual pendente do usuário (sessão do navegador de teste expirada no momento).
- **Status:** aplicado — confirmar visual com F5.

---

#### 2026-07-03 — Tela de login em "split hero" (tela de apresentação do portal)

- **Arquivo(s) alterado(s):** `include/client/login.inc.php` (core), `assets/default/css/theme.css`, `include/client/header.inc.php` (cache-buster `?zk20260703k`)
- **Backup do original:** `include/client/login.inc.php.pre-hero-backup`
- **Tipo:** core (template do cliente) + CSS do tema
- **Motivo/contexto:** a tela de login é a primeira impressão do cliente final — estava correta mas genérica (cartão centralizado). Pedido: "o cliente tem que ser surpreendido positivamente com um bom layout".
- **O que foi feito (conceito "split hero", padrão SaaS premium):**
  1. **`login.inc.php` reescrito** (bloco ZK-LOGIN): grid de 2 colunas `.zk-login`.
     - **Esquerda `.zk-login-hero`** — painel de marca: gradiente grafite→verde ZKTeco com brilho radial verde, **anéis concêntricos** (repeating-radial-gradient, eco de digital/biometria) e **grade de pontos** com máscara; kicker "ZKTECO DO BRASIL", headline com destaque verde ("Manutenção dos seus equipamentos, *do chamado ao reparo*."), subtítulo, **4 features com ícones FA em chips verdes** (multi-equipamentos+fotos, NF validada na hora, despacho/status por equipamento, mensagens+e-mail) e linha de confiança (escudo + slogan). Sem nenhum asset externo — tudo CSS puro.
     - **Direita `.zk-login-side`** — cartão elevado `.zk-login-card` (raio 16px, sombra profunda): título/corpo vindos do banner-client do banco ($title/$body), **inputs com ícone dentro** (user/lock) e focus ring verde, botão "Entrar" com gradiente + hover lift, link "Esqueci minha senha" (condicional $suggest_pwreset), divisor "ainda não tem uma conta?" e botão outline "Criar minha conta" (inverte pra grafite no hover).
     - **Preservado:** POST `luser`/`lpasswd`, `csrf_token()`, `$errors['login']` (agora caixinha vermelha, só renderiza se houver), loop de external auth, CTA condicional de registro.
  2. **`theme.css`** — novo bloco "LOGIN — SPLIT HERO": cadeia de flex `#container:has(.zk-login)` → `#content` → `.zk-login` pra o hero preencher EXATAMENTE a altura útil entre header e rodapé (o body já esticava o `#container`, mas `#content` não acompanhava — sobrava faixa branca); `#content` zera o padding nesta página (hero full-bleed) e os banners `#msg_*` ganham margem própria. **O bloco antigo `#clientLogin` foi mantido** — ainda estiliza a página "Verificar Status" (`accesslink.inc.php`, modo registro-desabilitado).
  3. **Responsivo:** ≤920px vira 1 coluna com o **cartão de login PRIMEIRO** (quem chega no celular quer entrar) e o hero como faixa abaixo com features em 2 colunas; ≤560px features em 1 coluna.
- **Dependências/impactos:** nenhum JS referencia `#clientLogin` (verificado); páginas de registro/accesslink intactas. Usa `:has()` (Chrome/Edge/Firefox modernos — já era usado no tema).
- **Como reaplicar em versão nova:** recriar o bloco ZK-LOGIN no `login.inc.php` novo (conferir se o core mudou os names do form) e copiar o bloco "LOGIN — SPLIT HERO" do `theme.css`.
- **Validação feita:** `php -l`; visual confirmado no navegador em desktop (1920px): hero flush com header/rodapé (gap 0px medido via JS), gradiente/anéis/features renderizando, cartão com ícones e estados corretos. Mobile não testado ao vivo (janela maximizada ignorou resize) — media queries simples, conferir no celular.
- **Nota de processo:** tentativa de rodar painel multi-agente de design (workflow) abortada por limite de sessão do plano — design feito diretamente.
- **Status:** aplicado e testado (desktop).

---

#### 2026-07-03 — Polimento v2: páginas logadas no nível da tela de login

- **Arquivo(s) alterado(s):** `assets/default/css/theme.css`, `include/client/header.inc.php` (cache-buster `?zk20260703l`)
- **Tipo:** CSS do tema (100% aditivo — nenhum template alterado)
- **Motivo/contexto:** depois do login em "split hero" aprovado, o usuário pediu a mesma polida nas páginas logadas do cliente.
- **O que foi feito (bloco "POLIMENTO v2" no fim da camada ZKTeco):**
  1. **Fundo do conteúdo** (`#content:not(:has(.zk-login))`): cinza-suave `--zk-bg-soft` com brilho radial verde discreto no canto — os cartões brancos passam a "flutuar" sobre o fundo (mesma lógica do lado do cartão no login). O login fica de fora (hero pinta os fundos próprios).
  2. **Header** ganha sombra sutil (profundidade sobre o conteúdo).
  3. **Cartões** (`.zk-ti-card`, `.zk-panel.zk-client`, `.zk-panel.zk-tickets`): raio 8→12px, borda mais suave e **sombra em camadas** (mesma família do cartão de login).
  4. **Formulários de página inteira viram cartão**: `#ticketForm` (usado por **Abrir Novo Ticket, Perfil e Registro** — mesmo id nos 3 templates) e `#zkEditForm` (Editar equipamentos): fundo branco, borda, raio 12px, sombra e padding interno.
  5. **Botões verdes principais** (submits de #ticketForm/#zkEditForm/#reply e `.zk-btn`): gradiente verde + sombra colorida + **elevação no hover** (translateY -1px) — mesma família do botão "Entrar" do login.
  6. **Barra de progresso** do painel de equipamentos: gradiente verde.
- **Dependências/impactos:** só apresentação; páginas de conteúdo livre (landing/FAQ) ficam com o fundo suave — texto continua legível. Painel do agente intacto (não carrega theme.css).
- **Como reaplicar em versão nova:** copiar o bloco "POLIMENTO v2" do `theme.css`.
- **Validação feita:** balanceamento de chaves do CSS (492/492), bloco servido pelo Apache com o cache-buster novo; conferência visual das telas logadas pendente do usuário (sessão do navegador de teste expirou).
- **Status:** aplicado — confirmar visual com F5.

---

#### 2026-07-03 — Registro de conta no "split hero" (mesma apresentação do login)

- **Arquivo(s) alterado(s):** `include/client/register.inc.php` (core), `assets/default/css/theme.css`, `include/client/header.inc.php` (cache-buster `?zk20260703m`)
- **Backup do original:** `include/client/register.inc.php.pre-hero-backup`
- **Tipo:** core (template do cliente) + CSS do tema
- **Motivo/contexto:** a tela "Registro de conta" (destino do CTA "Criar minha conta" do login) estava simples/padrão antigo — quebrava a experiência premium recém-criada no login.
- **O que foi feito:**
  1. **`register.inc.php`** (bloco ZK-SIGNUP): página envolvida em `.zk-login.zk-signup` — **reusa as classes/CSS do hero do login** (gradiente, anéis, kicker, headline com destaque verde). Diferença: em vez das 4 features, o painel mostra o **passo a passo numerado** de como o portal funciona (1 Crie a conta — e-mail/nome/WhatsApp; 2 Abra o chamado — equipamentos/fotos/NF; 3 Envie o produto — e acompanhe o reparo), com chips verdes numerados (`.zk-signup-steps`). Linha de confiança: "Seus dados são usados somente para o atendimento dos chamados". À direita, cartão `.zk-login-card.zk-signup-card` com h1 + descrição + o `#ticketForm` original INTACTO (UserForm dinâmico, senha, máscara de WhatsApp, csrf).
  2. **Botão "Cancelar" agora volta pro `login.php`** (antes ia pra index.php — o usuário veio do login, faz mais sentido voltar pra lá).
  3. **`theme.css`**: `.zk-signup .zk-login-card{max-width:560px}` (formulário precisa de mais largura que o login); `#ticketForm` dentro do signup tem o cartão do POLIMENTO v2 neutralizado (evita cartão-dentro-de-cartão); os 2 blocos do formulário (Contato | Senha) empilham sozinhos no cartão estreito (flex-wrap já existente); `hr` do form estilizado como divisor fino.
- **Dependências/impactos:** formulário dinâmico (UserForm), validações e máscara de telefone intactos; a mesma tela serve o fluxo de auto-registro via auth externa (`$info['backend']`) — markup desse ramo não foi tocado.
- **Como reaplicar em versão nova:** recriar o envelope ZK-SIGNUP no `register.inc.php` novo + copiar o bloco `.zk-signup` do `theme.css` (depende do bloco "LOGIN — SPLIT HERO").
- **Validação feita:** `php -l`; visual confirmado no navegador (desktop): hero com passos numerados, cartão com campos empilhados, botão "Registrar" com gradiente verde.
- **Status:** aplicado e testado (desktop).

---

#### 2026-07-03 — Nota Fiscal removida da tela de abertura de chamado

- **Arquivo(s) alterado(s):** `include/client/open.inc.php`
- **Tipo:** template do cliente (customização ZK existente)
- **Motivo/contexto:** decisão de fluxo do usuário — na abertura, o cliente deve focar no essencial (equipamentos, problema, fotos); o XML da NF entra num segundo momento, depois do chamado criado.
- **O que foi feito:** removidos o botão "Anexar Nota Fiscal (XML) — opcional" (div `.zk-ticket-nf` acima da grade) e o handler JS de validação `.xml` correspondente. Comentário no lugar aponta pro fluxo novo.
- **Como o fluxo fica:** chamado nasce com pendência **"Sem nota fiscal"** (já era o comportamento do `zk_sync_equip_pendencia` quando não vem NF); no painel do chamado, a barra da NF mostra o **clipe de anexar**, e o upload **verifica o XML automaticamente** (entrada anterior) — validou, vira selo verde; deu erro, mostra a tabela comparativa.
- **Dependências/impactos:** o servidor (`zk_equip_on_ticket_created` → `zk_save_ticket_nf`) continua aceitando NF no POST de criação sem erro — apenas ninguém envia mais por ali. A tela "Editar equipamentos" mantém o anexo de NF (é pós-criação). Nada a fazer no banco.
- **Como reaplicar em versão nova:** ao recriar a tela de abertura, simplesmente não incluir o bloco da NF.
- **Validação feita:** `php -l`; visual confirmado no navegador — botão sumiu, grade e demais elementos intactos.
- **Status:** aplicado e testado.

---

#### 2026-07-03 — Guia de próximos passos no painel do chamado (usabilidade)

- **Arquivo(s) alterado(s):** `include/zk_equipment.php` (markup do painel do cliente + CSS embutido — sem cache-buster)
- **Tipo:** módulo ZK
- **Motivo/contexto:** **teste com usuário real**: depois de criar o chamado, ele não achou onde anexar o XML (clipe de 22px na barra da NF) e depois teve dificuldade com o envio ("tava pequeno" — select discreto na barra). Problema clássico de affordance: as duas ações obrigatórias do fluxo estavam visualmente no mesmo nível de coisas secundárias.
- **O que foi feito — banner "GUIA DE PRÓXIMOS PASSOS" no topo do cartão Equipamentos**, sempre mostrando SÓ o passo atual, em tamanho grande:
  1. **Passo 1 — Anexar NF** (chip verde "1"): título "Próximo passo: anexar a Nota Fiscal de remessa (XML)", explicação do porquê, **botão grande verde "📎 Anexar Nota Fiscal (XML)"** (mesmo form/id `zkNfQuickUploadForm` de antes — JS intacto), dica "(?)" ao lado e trilha "Passo 1 de 3 · depois: informar o envio → acompanhar o reparo". Variações: **NF com erro** → guia âmbar "anexe o XML corrigido" (o upload substitui o anterior); **NF não verificada** (legado) → botão grande "Verificar XML agora".
  2. **Passo 2 — Envio** (chip "2", só com NF validada): "informe como o produto será enviado" com **select/rastreio/botões GRANDES** (mesmo form/id `zkEnvioForm` — o form saiu da barra e mora aqui); com transportadora salva, o título vira "Falta só confirmar o envio".
  3. **Concluído** (após confirmar): faixa verde "✔ Tudo certo por aqui — produto a caminho da ZKTeco" + aviso de que recebe e-mail a cada atualização.
  - **Barras de NF/Envio viraram só INFORMAÇÃO**: a da NF só aparece quando há arquivo (nome + selo "XML validado" + Verificar (se erro) + lixeira + dica); a do envio só quando confirmado (resumo + data) ou informado-mas-travado. A "Nota Fiscal: não anexada" com clipe minúsculo deixou de existir.
  - Responsivo: no mobile o guia empilha e o botão de anexar vira largura total.
- **Dependências/impactos:** nenhuma rota/JS novo — os forms mudaram de LUGAR mantendo ids (`zkNfQuickUploadForm/Input`, `zkEnvioForm/Transp/Rastreio`), então os handlers existentes continuam valendo; cada id renderiza no máximo 1 vez por página. Painel do agente intacto.
- **Como reaplicar em versão nova:** faz parte do módulo `zk_equipment.php` (bloco GUIA + CSS `.zk-guide*` no `zk_equip_styles`).
- **Validação feita:** `php -l`; visual no navegador: chamado #14 (sem NF) → guia passo 1 com botão grande; chamado #12 (confirmado no teste do usuário) → faixa "Tudo certo", NF validada e envio como informação. Estados intermediários (passo 2 e NF com erro) validados por leitura de código — mesmos ramos exercitados no fluxo real do teste.
- **Status:** aplicado e testado.

---

#### 2026-07-03 — Correção: `zk_ticket_envio` ficava órfã ao apagar um ticket

- **Arquivo(s) alterado(s):** `include/zk_equipment.php`
- **Tipo:** bugfix no módulo ZK (integridade de dados)
- **Motivo/contexto:** a pedido do usuário, apaguei via CLI (API `Ticket::delete()`) TODOS os 5 tickets de teste do ambiente (limpeza de ambiente, não produção). Ao conferir se as tabelas customizadas ficaram limpas (rotina de sanidade pós-exclusão em massa), `ost_zk_equipment`, `ost_zk_equipment_event`, `ost_zk_equipment_file` e `ost_zk_ticket_file` zeraram certinho, mas **`ost_zk_ticket_envio` (transportadora/rastreio/confirmação) ficou com 5 linhas órfãs** — o hook `zk_equip_on_ticket_deleted` (conectado a `model.deleted` do `Ticket`) nunca limpava essa tabela. Bug pré-existente, passou despercebido até agora porque ninguém tinha apagado um ticket com envio informado.
- **O que foi feito:**
  1. Adicionada a linha que faltava em `zk_equip_on_ticket_deleted()`: `DELETE FROM zk_ticket_envio WHERE ticket_id=...`.
  2. Limpeza pontual (script CLI) das 5 linhas órfãs que já existiam na tabela — nenhum ticket ativo foi afetado (todos os 5 tickets aos quais elas pertenciam já tinham sido apagados).
- **Dependências/impactos:** nenhum — só fecha um vazamento de dados órfãos. Não afeta tickets existentes/ativos.
- **Como reaplicar em versão nova:** garantir que `zk_equip_on_ticket_deleted()` tenha as 5 linhas de `DELETE` (equip, equip_event, equip_file, ticket_file, ticket_envio).
- **Validação feita:** contagem das 5 tabelas customizadas após a exclusão em massa (via script CLI) confirmou 0 linhas em todas após a correção + limpeza manual.
- **Status:** aplicado e testado.

---

#### 2026-07-03 — Hero: texto na mesma posição em todas as telas (login/registro)

- **Arquivo(s) alterado(s):** `assets/default/css/theme.css`, `include/client/header.inc.php` (cache-buster `?zk20260703n`)
- **Tipo:** CSS do tema
- **Motivo/contexto:** o conteúdo do painel de marca (`.zk-login-hero-inner`) era **centralizado verticalmente** — como a altura do hero acompanha o cartão ao lado (o de registro é bem mais alto que o de login), o kicker/headline apareciam em alturas diferentes em cada tela e o texto "pulava" ao navegar entre login ↔ criar conta.
- **O que foi feito:** `justify-content:center` → `flex-start` com **recuo superior fixo** `padding-top:clamp(44px, 9vh, 110px)` — a posição passa a depender só da viewport (igual nas duas telas), calibrada pra reproduzir o visual aprovado do login.
- **Como reaplicar em versão nova:** parte do bloco "LOGIN — SPLIT HERO" do `theme.css`.
- **Validação feita:** medição via JS no navegador: kicker Y=132px e headline Y=166px **idênticos** nas duas páginas; visual conferido por screenshot.
- **Status:** aplicado e testado.

---

#### 2026-07-03 — E-mails ao cliente com a identidade ZKTeco (6 templates)

- **Onde:** banco de dados — `ost_email_template`, grupo padrão (tpl_id=1). Nenhum arquivo PHP alterado.
- **Backup do original:** `V3/backups/email-templates-pre-redesign-20260703.json` (os 19 templates do grupo, na íntegra). Script que aplica o redesign: `V3/backups/email-templates-apply-redesign-20260703.php`.
- **Motivo/contexto:** o e-mail que o cliente recebia (ex.: resposta do agente) era o template cru do osTicket — "Prezado(a) Fulano" + texto + rodapé em itálico, sem marca nenhuma. Pedido: "melhora bem isso".
- **O que foi feito — layout único ZKTeco aplicado aos 6 templates voltados ao CLIENTE** (HTML de e-mail: tabelas + CSS inline, compatível com Gmail/Outlook; sem imagens externas — a marca é tipográfica "ZK**Teco**" com "Teco" verde):
  - **Estrutura comum:** fundo cinza-claro, cartão central 600px com cabeçalho grafite (marca + "CENTRAL DE MANUTENÇÃO"), filete verde 4px, corpo branco, caixa de referência com "Chamado #nº" + **botão verde "Acompanhar meu chamado"** (link `%{recipient.ticket_link}` na forma URL-encoded `%%7B...%7D`, a mesma já usada e comprovada nos templates antigos), bloco de assinatura (`%{company.name}` + `%{signature}`) e rodapé com a instrução "para responder, basta responder a este e-mail".
  - **`ticket.reply` (id 6)** — resposta do agente: "Olá, Fulano! A equipe técnica respondeu ao seu chamado:" + resposta em **bloco citado com filete verde**.
  - **`ticket.autoresp` (id 1)** — confirmação de abertura: assunto novo "Recebemos seu chamado [#nº] — assunto" + **caixinha verde "Próximo passo: anexe a NF (XML)"** (amarra com o guia do portal).
  - **`message.autoresp` (id 3)** — assunto novo "Sua mensagem foi recebida [#nº]" + texto curto.
  - **`ticket.notice` (id 4)** — chamado criado pela equipe: tópico/assunto + mensagem citada.
  - **`ticket.activity.notice` (id 7)** — nova mensagem p/ participantes: "%{poster.name} registrou..." + citação.
  - **`ticket.autoreply` (id 2)** — resposta automática com citação.
  - Assuntos de threading ("Re: %{ticket.subject}") **mantidos** onde já existiam — não quebra o agrupamento do Gmail.
- **Dependências/impactos:** só apresentação dos e-mails; variáveis `%{...}` preservadas (verificação automática pós-gravação: todas presentes). Templates de ALERTA para agentes (staff) não foram tocados. Editável depois via Admin Panel → Emails → Templates (que também é onde reverter usando o JSON de backup).
- **Como reaplicar em versão nova:** rodar `email-templates-apply-redesign-20260703.php` (ajustar caminho/tpl_id se mudar) OU colar os corpos via Admin Panel a partir do próprio script.
- **Validação feita:** UPDATE confirmado nos 6 (1 linha cada); checagem automática de variáveis essenciais (recipient.name.first, ticket.number, signature, company.name, ticket_link) = OK nos 6; preview renderizado no navegador com valores reais (screenshot) — cabeçalho, citação, botão e rodapé corretos.
- **Status:** aplicado e testado (preview) — conferir o primeiro e-mail real no Gmail. Confirmado pelo usuário ("Deu certo o e-mail").

---

#### 2026-07-03 — Cliente final sem NF: Declaração de Conteúdo + envio só pelos CORREIOS

- **Arquivo(s) alterado(s):** `include/zk_equipment.php`, `zk-equip-edit.php`, banco (texto do e-mail `ticket.autoresp`)
- **Tipo:** módulo ZK (regra de negócio + UI) — sem mudança de schema (reusa `ost_zk_ticket_file` com novo `kind='dc'`)
- **Motivo/contexto:** clientes FINAIS (pessoa física) não emitem NF-e, mas enviam produtos pra ZKTeco. Os Correios aceitam a **Declaração de Conteúdo** (formulário próprio deles) no lugar da NF — e são o ÚNICO meio de transportar equipamento sem Nota. Regra pedida: cliente escolhe que é cliente final → anexa a Declaração → envio só pode ser CORREIOS com rastreio → confirma o envio.
- **O que foi feito:**
  1. **Novo tipo de documento `kind='dc'`** na `ost_zk_ticket_file` + funções espelhadas nas da NF: `zk_ticket_dc_mode()` (tem DC e NÃO tem NF), `zk_ticket_dc_html()`, `zk_save_ticket_dc()` (aceita **PDF/JPG/PNG**, checagem de extensão + MIME, 1 por chamado — a nova substitui), `zk_delete_ticket_dc()`.
  2. **`zk_ticket_nf_pendencia()`**: sem NF mas COM Declaração → retorna `''` (documentação ok) — isso destrava o passo 2 do guia e limpa a pendência "Sem nota fiscal" automaticamente (via `zk_sync_equip_pendencia`, sem mudanças lá).
  3. **`zk_save_ticket_envio()`** — reforço server-side: em `dc_mode`, transportadora ≠ correios → erro "Com Declaração de Conteúdo (cliente final), o envio deve ser obrigatoriamente pelos CORREIOS." (rastreio obrigatório já era regra dos correios).
  4. **Guia do painel (passo 1, estado sem NF)**: abaixo do botão de anexar NF, link **"👤 Sou cliente final e não emito Nota Fiscal"** (separado por linha tracejada) que expande explicação + **botão grafite "Anexar Declaração de Conteúdo"** (upload direto, mesmo padrão do da NF: escolheu → enviou). JS: toggle + validação de extensão.
  5. **Guia passo 2 em `dc_mode`**: select renderiza **só CORREIOS** (pré-selecionado, sem opção vazia), campo de rastreio já visível, texto orienta a levar a declaração dentro do pacote; trilha mostra "Declaração de Conteúdo ✓". Fluxo salvar → confirmar idêntico ao da NF.
  6. **Barra informativa da Declaração** (abaixo da barra da NF): nome do arquivo (download) + badge "Cliente final" + lixeira (enquanto editável). **Painel do agente (SCP)**: cabeçalho mostra o link da Declaração + badge "Cliente final".
  7. **Rotas em `zk-equip-edit.php`**: upload (`$_FILES['zk_ticket_dc']`) e remoção (`zk_ticket_dc_delete`), ambas com nota na timeline ("Declaração de Conteúdo anexada/removida") e retorno pro chamado.
  8. **E-mail de abertura** (`ticket.autoresp`): caixinha "Próximo passo" ganhou a linha "Cliente final sem NF? Anexe a Declaração de Conteúdo — nesse caso o envio é pelos CORREIOS."
- **Precedência:** se uma NF for anexada depois da Declaração, `dc_mode` desliga e as regras de NF voltam a valer (a Declaração continua visível como anexo). Hook de exclusão de ticket já limpa `kind='dc'` (deleta por ticket_id, sem filtro de kind).
- **Como reaplicar em versão nova:** faz parte do módulo + rotas no `zk-equip-edit.php`; nada de schema novo.
- **Validação feita:** `php -l` nos 2 arquivos; visual no navegador (chamado #16: link do cliente final + painel expandido + botão grafite); **teste CLI de ponta a ponta com 14 asserções, todas OK** — pendência limpa com DC, `o_proprio`/`outra` bloqueados com a mensagem certa, correios sem rastreio bloqueado, correios+rastreio salvo (maiúsculas), NF posterior desliga o dc_mode, e estado do chamado #16 100% restaurado ao fim.
- **Status:** aplicado e testado (CLI) — falta o teste de ponta a ponta do usuário com upload real.

---

#### 2026-07-03 — Identidade ZKTeco no Painel da Equipe (SCP): login + painel logado

- **Arquivo(s) alterado(s):** `scp/css/zkteco-scp.css` (**NOVO** — toda a skin mora aqui), `include/staff/login.header.php` (core: +1 link CSS e título "Central de Manutenção :: Agent Login"), `include/staff/header.inc.php` (core: +1 link CSS)
- **Tipo:** CSS novo + 2 linhas de link nos headers do staff — o `login.css`/`scp.css` do core NÃO foram tocados (a skin carrega depois e sobrepõe)
- **Motivo/contexto:** o SCP estava com o visual padrão osTicket (azul/laranja/foto de fundo genérica) — era a última pendência da identidade visual (anotada desde 2026-07-01, agora riscada).
- **O que foi feito (`zkteco-scp.css`, 2 seções):**
  1. **LOGIN** (escopo `#loginBody`): fundo gradiente grafite→verde com **anéis de biometria** (mesma linguagem do hero do portal do cliente), backdrop/blur padrão ocultos; cartão branco elevado (raio 16px) com a **logo ZKTeco** (CSS `background` apontando pro MESMO arquivo do portal, `assets/default/images/logo.png` — a `<img>` do `logo.php?login` fica oculta) + kicker "CENTRAL DE MANUTENÇÃO · PAINEL DA EQUIPE"; inputs com focus ring verde (era laranja); botão "Iniciar Sessão" verde full-width com hover lift; "Powered by osTicket" oculto (uso interno); copyright transparente sobre o gradiente.
  2. **PAINEL LOGADO**: links globais azul→verde escuro `#4c7727`; header branco com **filete verde** embaixo e logo ZKTeco (mesmo truque de CSS); **nav principal grafite `#474B4F` com aba ativa VERDE** (texto branco) e hover suave — espelho do menu do portal do cliente; dropdowns do menu continuam claros (especificidade do core preservada); botões primários (submit/.primary) com gradiente verde; `.green.button` alinhado à paleta; ordenação de colunas de tabelas (asc/desc) de azul pra verde-claro.
- **Cache-buster próprio:** `zkteco-scp.css?zk20260703a` nos 2 headers — **incrementar a cada mudança na skin** (mesma regra do theme.css do cliente).
- **Dependências/impactos:** funcionalidade zero-touch (só CSS + título). Depende do arquivo de logo do cliente (`assets/default/images/logo.png`). Painel de ADMIN (mesmo header.inc.php do staff) herda a skin automaticamente.
- **Como reaplicar em versão nova:** copiar `scp/css/zkteco-scp.css` e re-adicionar os 2 `<link>` nos headers do staff.
- **Validação feita:** `php -l` nos 2 headers; login conferido por screenshot (via fetch sem cookies renderizado como preview — a sessão de agente ativa do usuário redirecionava o login.php); painel logado conferido ao vivo (lista de chamados + tela do chamado #145206: logo, nav grafite/verde, links, botão "Verificar XML" verdes). **Não digitei credenciais em nenhum momento** (regra de segurança — a sessão já estava ativa no navegador do usuário).
- **Status:** aplicado e testado.

---

#### 2026-07-03 — SCP modernizado no nível do portal do cliente (seção "MODERNIZAÇÃO v2" da skin)

- **Arquivo(s) alterado(s):** `scp/css/zkteco-scp.css` (só a skin — core intocado), `include/staff/header.inc.php` e `login.header.php` (bump do cache-buster até `?zk20260703e`)
- **Tipo:** CSS (skin sobreposta ao scp.css)
- **Motivo/contexto:** o pedido subiu de "paleta" pra "igual o layout bonito e moderno do lado do cliente, altere tudo que for preciso".
- **O que foi feito (seção "MODERNIZAÇÃO v2" no fim da skin):**
  1. **Moldura**: fundo cinza-suave com brilho radial verde (mesmo do portal); `#container` de 960px fixos → fluido até **1280px**; bordas laterais anos-2000 removidas; **`#content` inteiro vira cartão** (branco, raio 12, sombra em camadas); rodapé discreto.
  2. **Filas (sub-nav)**: itens viram **chips brancos arredondados** (hover verde, ativo preenchido verde-claro), ícones .gif originais preservados.
  3. **Tabelas de listagem (`table.list`)**: cartão branco com cantos arredondados (border-collapse:separate + raio nos cantos th/td), cabeçalho cinza-claro grafite, **zebra azul/amarela do core removida** (hover suave `#fafcf8`, seleção verde-claro), `width:100%`.
  4. **Abas (`ul.tabs`, exceto .vertical)**: viram **sublinhado verde** moderno (sem caixinhas 3D), hover verde.
  5. **Botões neutros** (action-button/button/reset): pílulas brancas com contorno, hover grafite — a família do portal; primários já eram verdes (v1).
  6. **Formulários**: inputs/selects/textareas com borda `#cfd5cc`, raio 7 e **focus ring verde**; `select{height:auto}` (o height fixo do core cortava o texto com o padding novo).
  7. **Banners** (notice/warning/error/info): cantos 8px na paleta do portal.
  8. **Diálogos**: raio 12, sombra profunda, título grafite com filete verde.
  9. **Ficha do chamado (`.ticket_info`)**: azul `#F4FAFF` do core → cinza-esverdeado `#f7f9f6` com borda e raio 10; `width:100%` via CSS (o template fixa `width=940` por atributo — CSS vence).
- **Dependências/impactos:** zero mudança funcional; abas verticais (`ul.tabs.vertical`, usadas em configurações) excluídas do restyle de propósito; cores de prioridade nas filas (vindas do banco) preservadas; painel Admin herda tudo.
- **Como reaplicar em versão nova:** copiar `scp/css/zkteco-scp.css` + os 2 `<link>`; conferir se os seletores estruturais do scp.css novo não mudaram (#sub_nav, table.list, ul.tabs, .ticket_info).
- **Validação feita:** ao vivo no navegador (sessão do usuário): fila de chamados (chips, tabela-cartão, largura total), tela do chamado #145206 (ficha sem azul, largura total, abas de resposta com sublinhado verde, selects sem corte), painel de equipamentos coeso.
- **Status:** aplicado e testado.
- **v3 (mesma data, feedback "cinza, feio e sem logo"):** três causas encontradas por inspeção ao vivo no DOM: (1) o `<a id="logo">` dentro do header flex **encolhia a largura 0** (a `<img>` interna está oculta e o logo é background) → largura explícita 250px; (2) o cartão de conteúdo baixinho deixava um "mar" de fundo vazio → **cadeia de flex** `body→#container→#pjax-container→#content` estica o cartão até o rodapé (mesma técnica do portal do cliente) + fundo clareado `#f4f6f2` com brilho verde; (3) uma **linha vertical fantasma** era o `div.jb-overflowmenu-container` (helper do plugin de overflow das filas, 1px de largura com borda cinza) → borda zerada. Extras: `#container` full-width definitivo (nav grafite de ponta a ponta, recuo lateral 26px), header flex com bem-vindo/links limpos à direita, itens do nav como pílulas (raio 6), busca das filas (`.attached.input`) virou dupla input+botão verde com focus ring. Cache-buster em `?zk20260703h`.
- **v4 (mesma data, "foca na página de chamados"):** paridade com a lista do cliente, por inspeção do markup real da fila: ícone do ticket (`span.Icon.webTicket/emailTicket/...`, PNG do core) morto e substituído por **ícone FA `\f145` verde via `::before`**; a célula de **Prioridade** (`div` interno com `background-color` inline vindo da cor da prioridade no banco) reformatada como **pílula arredondada** que PRESERVA a cor configurada; `span.truncate` do assunto liberado do `max-width:300px` inline (flui na coluna); linhas com padding 11px; título da fila ("⟳ Aberto") grafite com ícone verde; busca maior (340px, padding 10px). Cache-buster `?zk20260703i`.

---

#### 2026-07-03 — BUG CRÍTICO: fotos sumiram (arquivos deduplicados) + bomba-relógio do cron

- **Arquivo(s) alterado(s):** `include/zk_equipment.php`
- **Tipo:** bugfix de integridade de dados no módulo ZK
- **Sintoma:** as fotos de equipamento dos chamados #723065 e #145206 sumiram do cliente E do SCP ao mesmo tempo.
- **Causa-raiz (2 bugs):**
  1. **Dedup + exclusão bruta:** o osTicket **deduplica `ost_file` por hash+tamanho** (`AttachmentFile::create`, sem filtro de tipo) — o MESMO `file_id` pode ser foto de equipamento, NF/Declaração e anexo de thread, inclusive de OUTROS tickets. As lixeiras de NF/Declaração faziam `AttachmentFile->delete()` direto: no teste do usuário, o mesmo arquivo de imagem era foto dos 2 tickets e foi anexado/removido como documento → o delete matou o arquivo compartilhado (file_id=27) e as fotos morreram junto.
  2. **Bomba-relógio (latente):** `AttachmentFile::deleteOrphans()` (cron diário do core) apaga arquivos `ft='T'` **sem vínculo em `ost_attachment`** com >24h — TODOS os arquivos do módulo (fotos, NF, DC) vivem só nas tabelas ZK, invisíveis pro core → o cron apagaria tudo silenciosamente após 1 dia.
- **Correção:**
  1. **`zk_file_refcount($fid)`** — conta referências em `ost_attachment` + `ost_zk_ticket_file` + `ost_zk_equipment_file`; **`zk_file_delete_if_unused($fid)`** — só apaga o `AttachmentFile` com contagem zero. Aplicado nas lixeiras de NF e DC e no hook de exclusão de ticket (que agora também coleta os file_ids antes de apagar os vínculos e limpa os que ficarem órfãos — antes deixava os arquivos pra sempre).
  2. **`zk_file_shield($F)`** — todo upload do módulo vira **`ft='Z'`** (fora do `ft='T'` que o `deleteOrphans` varre). Migração executada: arquivos ZK vivos atualizados (`T`→`Z`).
  3. Limpeza dos 2 vínculos mortos (apontavam pro arquivo destruído).
- **Perda de dados:** o conteúdo do arquivo 27 é **irrecuperável** (chunks apagados) — as fotos dos chamados de teste #723065/#145206 precisam ser reanexadas via "Editar equipamentos".
- **Como reaplicar em versão nova:** faz parte do módulo; rodar a blindagem (`UPDATE ost_file SET ft='Z'` para os ids referenciados nas tabelas ZK) após restaurar dados. Conferir se o `deleteOrphans` do core continua filtrando só `ft='T'`.
- **Validação feita:** teste CLI com 7 asserções, todas OK — arquivo compartilhado entre DC e foto sobrevive à lixeira da DC (refcount 2→1), morre só quando a última referência sai; blindagem `ft='Z'` confirmada; estado do ticket 16 restaurado. Validação extra em seguida: exclusão dos 2 tickets de teste zerou TODAS as tabelas ZK **e** os arquivos blindados (`ft='Z'` = 0) — o hook novo limpa os arquivos que ficam sem referência, como projetado.
- **Status:** aplicado e testado.

---

#### 2026-07-03 — Atribuição = chegada: status "Recebido" automático + dica "status por item"

- **Arquivo(s) alterado(s):** `include/zk_equipment.php`, `include/client/tickets.inc.php` (core), `include/client/view.inc.php` (core), `assets/default/css/theme.css` (classe `.zk-ti-status-hint`, cache-buster `?zk20260703o`), banco (`ost_ticket_status`)
- **Tipo:** módulo ZK (regra de negócio) + templates do cliente + banco
- **Motivo/contexto:** regra de fluxo do usuário — quando o produto CHEGA na ZKTeco, o chamado é atribuído a um agente; nesse momento o status deve virar "Recebido", e o cliente deve ser orientado a abrir o chamado pra ver o status POR EQUIPAMENTO (daí em diante o acompanhamento fino é por item).
- **O que foi feito:**
  1. **Novo status "Recebido"** (`ost_ticket_status`, state=open, sort=3 — ciclo: Solicitado → Enviado → **Recebido** → Resolvido...; demais re-numerados; properties espelhadas do "Enviado" com descrição própria). Criado via script CLI.
  2. **Gancho de atribuição SEM patch no core:** `assign()`/`assignToStaff()`/`claim()` disparam `Signal 'object.edited'` com `type='assigned'` — `zk_ticket_on_assigned()` conecta nesse sinal (classe Ticket) e faz a transição **somente `Enviado` → `Recebido`** (atribuir um chamado ainda "Solicitado" não mexe: o produto nem foi despachado; reatribuições não regridem nada). Atribuição a EQUIPE não dispara (o gatilho é agente, como pedido).
  3. `zk_ticket_set_status_enviado` refatorada sobre a nova genérica `zk_ticket_set_status_by_name($ticket, $nome)` (lookup por nome + `Ticket::setStatus()`, idempotente).
  4. **Cliente — lista** (`tickets.inc.php`): com status "Recebido" e equipamentos no chamado, a pílula ganha a sub-linha "*abra para ver o status por item*". **Cliente — tela do chamado** (`view.inc.php`): ao lado da pílula, "*acompanhe o status por item na tabela de equipamentos abaixo*" (`.zk-ti-status-hint`, itálico discreto).
  5. **Banner do guia** no painel de equipamentos: com envio confirmado E status "Recebido", muda de "produto a caminho da ZKTeco" para "**Produto recebido na ZKTeco — atendimento em andamento**".
- **Como reaplicar em versão nova:** rodar o script de criação do status (ou SQL equivalente), copiar o gancho/funções do módulo e os trechos dos 2 templates; conferir se `assignToStaff`/`assign` do core novo ainda disparam o Signal `object.edited` com `type='assigned'`.
- **Validação feita:** teste CLI real com 5 asserções (desatribuir → `assignToStaff()` → status virou "Recebido" na hora; reatribuição idempotente; guarda só age em "Enviado"); visual confirmado no navegador: lista do cliente ("Recebido" + sub-linha), tela do chamado (pílula + dica) e banner "Produto recebido na ZKTeco".
- **Status:** aplicado e testado.

---

#### 2026-07-04 — Notificações ao cliente: toda troca de status + mudança de status/laudo dos equipamentos

- **Arquivo(s) alterado(s):** `include/zk_equipment.php` (funções de notificação), `include/class.ticket.php` (**core** — patch demarcado `ZK-EQUIP` no fim de `setStatus()`), `scp/zk-equip.php` (grava mudanças + dispara notificação)
- **Tipo:** módulo ZK + patch no core (1 gancho) + template do agente
- **Motivo/contexto:** pedido — "a cada troca de status notifica via e-mail o cliente; a mudança do laudo também cria uma história e vai notificando o cliente".
- **O que foi feito:**
  1. **Troca de status do chamado → e-mail direto:** patch demarcado no fim de `Ticket::setStatus()` (depois do save, só quando `$hadStatus` — pula o status inicial da criação) chama `zk_notify_status_change()`. Só age em chamados COM equipamentos; monta e-mail com o **mesmo layout HTML dos templates redesenhados** (`zk_mail_zkteco()` — cabeçalho grafite, filete verde, pílula de status colorida, botão "Acompanhar meu chamado", link com auth token) e envia via `$dept->getEmail()->send()`. Texto de apoio por etapa do ciclo (Solicitado/Enviado/Recebido/Resolvido/Encerrado). É reflexo: try/catch, nunca bloqueia a troca. Vale pra QUALQUER origem da troca (agente no SCP, automação de atribuição, CLI).
  2. **Status/laudo dos equipamentos → "história" + e-mail:** `scp/zk-equip.php` agora compara status **e laudo** antigos vs. novos por item e monta uma lista de mudanças (status: "Modelo (S/N): status → X"; laudo: rótulo + texto completo do laudo). Ao final, **UMA** `zk_equip_notify_changes()` faz `$ticket->postReply()` com todas as mudanças — isso registra uma **resposta (type=R) na thread** (aparece no cartão "Mensagens" do cliente) E dispara o e-mail pelo template `ticket.reply` do banco. Sem mudança real, nada é postado.
  3. Removido o antigo checkbox "Registrar nota-resumo" do painel do agente (a regra virou sempre-notificar) — vira aviso informativo com ícone de envelope. A antiga nota-resumo (type=N, interna, não ia pro cliente) deixou de existir.
- **Dependências/impactos:** o `postReply` marca o chamado como respondido e move na fila — comportamento esperado (é uma resposta de verdade ao cliente). O patch no core é a 2ª modificação em `class.ticket.php` (a 1ª foi a trava pós-envio) — ambas demarcadas `ZK-EQUIP:BEGIN/END`.
- **Como reaplicar em versão nova:** reaplicar o bloco `ZK-EQUIP` no fim de `setStatus()`; as funções `zk_notify_*`/`zk_mail_zkteco`/`zk_equip_notify_changes` vêm com o módulo; reaplicar o loop de comparação em `scp/zk-equip.php`.
- **Validação feita:** teste CLI real no chamado #889540 (id 18): (1) status Recebido→Enviado→Recebido = 2 e-mails "Status atualizado" disparados; (2) equipamento → "Em análise" com laudo = `postReply` criou a resposta **entry #93 type=R** na thread (confirmado no banco) + e-mail `Re:`. O "thread não cresceu" do teste foi falso-negativo (cache de objeto do osTicket na mesma requisição — em processo novo `getNumEntries()`=7). Laudo/status de teste do equipamento **restaurados** (laudo vazio, status "recebido") após validar.
- **Status:** aplicado e testado — conferir os e-mails reais no Gmail (`julianotorres@gmail.com`).

---

#### 2026-07-04 — DIAGNÓSTICO: lentidão ao "Publicar Resposta" (envio de e-mail) — pendência de produção

- **Sintoma reportado:** ao publicar uma resposta como cliente, o pop-up "Por favor, aguarde!" fica muitos segundos até finalizar.
- **Causa raiz (medida, não do nosso código):**
  - **Nenhuma conta SMTP configurada** no osTicket: `ost_config.default_smtp_id` = vazio; a tabela `ost_email` desta instalação **não tem** os campos de SMTP preenchidos (host/porta/user/pass). Sem SMTP, o osTicket cai no transporte de fallback (`mail()` do PHP).
  - No XAMPP/Windows, `php.ini [mail function]` = `SMTP=localhost`, `smtp_port=25` e **não há nada escutando na :25** → cada tentativa espera o *timeout de conexão*. Medições: `mail()` cru retorna `false` em ~2s; o `Mailer` do osTicket leva **~7s por envio** e ainda assim retorna um message-id (gera o id antes de tentar entregar).
  - **Efeito multiplicado:** um "responder" do cliente dispara VÁRIOS envios síncronos numa requisição só (autorresposta ao cliente via `autoRespONNewMessage` + alerta ao(s) agente(s) via `alert*ONNewMessage`, em `Ticket::onMessage`) → 2-3 × ~7s = 14-21s travando a tela. É **comportamento nativo do osTicket** (envio síncrono), agravado pela ausência de SMTP e pela :25 morta.
  - **NÃO é do código de notificação nosso:** numa resposta a chamado ABERTO o gancho de `setStatus` (patch ZK) nem dispara (status não muda); as notificações de equipamento saem só pelo painel do agente.
- **Decisão do usuário (2026-07-04):** manter o e-mail/SMTP da ZKTeco como está e tratar a lentidão como ambiental — "quando subir pro site (sem XAMPP) não deve ser problema". Correto na parte de latência: em Linux com MTA local (Postfix/sendmail), o `mail()` entrega para a fila local em ms, então o travamento some.
- **⚠️ PENDÊNCIA / CHECKLIST DE PRODUÇÃO:**
  1. **Se quiser enviar autenticado pelo SMTP da ZKTeco** (melhor entregabilidade, evita spam): cadastrar a conta SMTP em **Admin Panel → Settings → Emails → (e-mail) → aba SMTP** (host, porta, usuário, senha ZKTeco). Sem isso, o envio hoje NÃO usa o SMTP da ZKTeco — usa o fallback do servidor.
  2. **Se confiar no MTA local do servidor** (`mail()` → Postfix): garantir que o servidor de produção tenha um MTA local ativo; aí é rápido, mas sai "do servidor", não autenticado pela ZKTeco.
  3. Rodar o **cron do osTicket** em produção (tarefas/limpezas).
  4. Reconferir tempo de "Publicar Resposta" em produção — deve ser ~instantâneo com MTA local ou SMTP keep-alive.
- **Nada alterado no código** por esta análise (a pedido do usuário). Registrado só como diagnóstico + pendência.
- **Status:** diagnosticado; ação adiada para a migração de produção (decisão do usuário).

---

#### 2026-07-06 — Coluna "Status" nas filas do agente (SCP)

- **Motivo/contexto:** na tela do cliente o status do chamado aparece (Solicitado → Enviado → Recebido → Resolvido/Encerrado), mas na **lista de chamados do agente** (SCP, `scp/tickets.php`) nenhuma fila mostrava o status. Como a fila "Aberto" filtra por `status__state = open`, ela hoje mistura **Solicitado, Enviado e Recebido** na mesma lista sem distinção — o agente não conseguia ver, na tela inicial, quais chamados o cliente já despachou (só deve "pegar" o chamado depois de Enviado).
- **O que foi feito:** as filas do agente são configuráveis por colunas (não é código; a associação fica no banco). A coluna **"Status"** já existia no catálogo `ost_queue_column` (id=6, `primary = status__id`), mas não estava atribuída a nenhuma fila. Foi adicionada a **todas as 14 filas** (Aberto/sub-filas, Meus Chamados, Encerrado e sub-filas), na **2ª posição** (logo após "Número do Chamado"), largura 110.
- **Renderização:** `status__id` é um campo padrão/suportado do osTicket — a coluna mostra o **nome localizado do status** (ex.: "Solicitado", "Enviado", "Recebido"), a mesma coluna "Status" que aparece no seletor de colunas do Admin → Filas.
- **Alterações no banco (`ost_queue_columns` — tabela de associação fila↔coluna):**
  ```sql
  -- 1) abre espaço no sort 2 de todas as filas (empurra as colunas seguintes)
  UPDATE ost_queue_columns SET sort = sort + 1 WHERE staff_id = 0 AND sort >= 2;
  -- 2) insere a coluna Status (column_id=6) no sort 2 de cada fila
  INSERT INTO ost_queue_columns (queue_id, column_id, staff_id, bits, sort, heading, width)
  SELECT DISTINCT queue_id, 6, 0, 0, 2, 'Status', 110
  FROM ost_queue_columns
  WHERE staff_id = 0 AND column_id <> 6;
  ```
- **Como reverter:** `DELETE FROM ost_queue_columns WHERE column_id = 6 AND staff_id = 0;` (e opcionalmente reajustar os `sort`). Backup da tabela salvo em `backup_queue_columns.sql` durante a aplicação.
- **Como reaplicar em versão nova / reinstalação:** rodar o SQL acima (conferir antes se `ost_queue_column` id=6 continua sendo `status__id` e se os `queue_id` das filas correspondem; se os agentes personalizarem colunas, essas cópias têm `staff_id` próprio e não são tocadas). Alternativa sem SQL: **Admin Panel → Gerenciar → Filas de Chamados → (fila) → Colunas → adicionar "Status"**.
- **Observação:** é uma coluna de texto nativa (mostra o nome do status). Se no futuro quiser o status como **selo colorido** igual ao cliente, dá para usar o campo `conditions` da coluna (JSON de critério→CSS por status) — ficou como melhoria opcional.
- **Status:** aplicado (pendente conferência visual do usuário no painel do agente).

---

#### 2026-07-06 — Fim do auto-scroll ao abrir o chamado (painel do agente)

- **Motivo/contexto:** ao abrir qualquer chamado no SCP (`scp/tickets.php?id=...`), a página descia sozinha até o final, caindo direto no formulário "Publicar Resposta". Comportamento padrão do osTicket, indesejado — o agente quer abrir o chamado e começar lendo do topo.
- **Causa:** em `include/staff/templates/thread-entries.tmpl.php`, o `$.thread.onLoad()` recebia `autoScroll: true` quando a thread estava ordenada por `id` (ordem cronológica crescente). Com `autoScroll:true`, o `thread.js` (`scrollTo` → última `.thread-entry` visível) animava a rolagem até a última mensagem, no rodapé.
- **O que foi feito:** o valor passou a ser fixo `autoScroll: false` (era `<?php echo $sort == 'id' ? 'true' : 'false'; ?>`). Comentário `// ZK:` deixado no ponto exato.
- **Como reaplicar em versão nova:** reabrir `include/staff/templates/thread-entries.tmpl.php`, achar a chamada `$.thread.onLoad(container, {autoScroll: ...})` e fixar em `false`. (Alternativa sem editar core: setar `$.thread.options.autoScroll = false` num JS próprio carregado no SCP.)
- **Status:** aplicado (pendente conferência visual do usuário).

---

#### 2026-07-06 — Painel de equipamentos do agente com a cara do cliente + fim da coluna Pendência

- **Motivo/contexto:** pedido do usuário — deixar a tela do agente (`zk_equipment_staff_panel`) visualmente igual à do cliente (`zk_equipment_client_panel`), e **remover a coluna "Pendência"** da tabela editável do agente (pendência é orientação do lado do cliente, e é sincronizada automaticamente).
- **A tela não pode ser 100% idêntica:** a do agente é **editável** (dropdown de Status, Laudo, Nota interna, seleção em massa, "Salvar progresso"); a do cliente é somente-leitura com selos. O que foi feito é **paridade visual de layout**, mantendo os controles do agente.
- **Mudança 1 — Nota Fiscal vira barra própria (igual ao cliente):** no agente a NF ficava espremida no cabeçalho do painel, junto do botão "Verificar XML". Passou a ser uma **barra `.zk-nf-bar`** logo abaixo do cabeçalho (irmã da barra "Envio do produto"), com o arquivo, o selo verde **"XML validado"** (quando `zk_ticket_nf_pendencia === ''`), e as ações do agente (Verificar XML / anexar / dica / Declaração de Conteúdo). O cabeçalho agora leva só o título com ícone de chave.
- **Mudança 2 — painel do agente vira "cartão":** o visual de cartão do cliente mora em `theme.css` (que o SCP **não** carrega). Recriado em `scp/css/zkteco-scp.css`, escopado em **`.zk-panel.zk-staff`**: fundo branco, borda, sombra leve, cabeçalho cinza com faixa verde à esquerda, respiro lateral de 16px no conteúdo (o `<form>` que envolve barra de ações + tabela recebe a margem como filho direto) e a barra `.zk-nf-bar` com a mesma cara da `.zk-envio-bar`. O visual base de badges/barras já vinha do `<style>` inline de `zk_equip_styles()` (comum aos dois lados). **Cache-buster** do `zkteco-scp.css` incrementado em `include/staff/header.inc.php` (`?zk20260703i` → `?zk20260706a`).
- **Mudança 3 — coluna "Pendência" removida no agente:** removidos o `<th>`, o `<td>` com o `<select name="pendencia[...]">`, a busca `$pd = zk_equip_pendencias()` e a variável `$pendKey`, e a referência `.zk-pend-sel` no JS do painel. **Backend seguro:** `scp/zk-equip.php` só grava `pendencia` se o campo vier no POST (`$newPend = isset($pendencias[$id]) ? ... : null;` → sem POST, coluna intocada); a pendência segue sendo gerenciada por `zk_sync_equip_pendencia()`. A coluna Pendência **continua** no painel do cliente.
- **Verificado no navegador** (chamado #105968, agente Juliano): cartão + barra NF com "XML validado" + barra de Envio + tabela sem Pendência, tudo renderizando certo.
- **Como reaplicar em versão nova:** reaplicar os 3 blocos em `zk_equipment_staff_panel()` (`include/zk_equipment.php`), o bloco `.zk-panel.zk-staff` no fim de `scp/css/zkteco-scp.css` e bumpar o cache-buster no header do SCP.
- **Status:** aplicado e testado (visual).

---

#### 2026-07-06 — Fichas do topo do chamado lado a lado (painel do agente)

- **Motivo/contexto:** pedido do usuário — na tela de ver chamado (agente), o cabeçalho de informações eram **duas tabelas `.ticket_info` empilhadas** (1ª: Status/Prioridade/Departamento/Data de Criação + Usuário/Email/Telefone/Origem; 2ª: Atribuído a/SLA/Vencimento + Tópico/Última Mensagem/Última Resposta). Sobrava muito **espaço vazio à direita** e as duas empilhadas gastavam altura de tela à toa. Objetivo: colocá-las **lado a lado**.
- **Por que não foi só CSS global:** a classe `.ticket_info` é usada em **várias telas** (`org-view`, `user-view`, `ticket-preview`, `task-view/preview`, além do `ticket-view`). Um `.ticket_info{width:49%}` global quebraria todas. Solução: **escopar** com um wrapper só na tela de ver chamado.
- **O que foi feito — 3 mini-edits demarcados (`// ZK:`) em `include/staff/ticket-view.inc.php`:**
  1. Antes da 1ª tabela `.ticket_info`: abre `<div class="zk-info-cols">`.
  2. Entre as duas tabelas: **removido o `<br>`** que forçava a quebra.
  3. Depois da 2ª tabela (antes do `<br>` que precede o "Detalhes do chamado"): fecha `</div>`.
  A 3ª tabela (`.ticket_info.custom-data` = "Detalhes do chamado") fica **fora** do wrapper e continua full-width.
- **CSS (`scp/css/zkteco-scp.css`):** `.zk-info-cols{ display:flex; gap:16px; align-items:stretch; }` e `.zk-info-cols > .ticket_info{ flex:1 1 0; width:auto; min-width:0; margin:0; }` (o `flex:1 1 0` neutraliza o `width="940"` fixo do HTML e o `width:100%` do CSS base, dividindo em 2 colunas iguais). Media query `max-width:900px` volta a empilhar. **Cache-buster** do `zkteco-scp.css` incrementado (`?zk20260706a` → `?zk20260706b`).
- **Verificado no navegador** (chamado #105968): as 2 fichas dividem a largura, mantêm fundo/borda arredondada, conteúdo legível, e o topo do chamado passou a ocupar ~metade da altura anterior.
- **Como reaplicar em versão nova:** reabrir `include/staff/ticket-view.inc.php`, localizar as 2 primeiras tabelas `.ticket_info` (as que **não** são `.custom-data`), envolvê-las no `<div class="zk-info-cols">` e tirar o `<br>` entre elas; conferir o bloco `.zk-info-cols` no `zkteco-scp.css` e bumpar o cache-buster.
- **Status:** aplicado e testado (visual).

---

#### 2026-07-06 — "Detalhes do chamado" some quando vazio + correção do "—Esvaziar—"

- **O que é o bloco "Detalhes do chamado" (estudo):** é a tabela nativa `.ticket_info.custom-data` de `include/staff/ticket-view.inc.php`, que renderiza os **formulários dinâmicos** do ticket (`DynamicFormEntry::forTicket`). Ela exclui os campos já mostrados noutros lugares (`subject`→título, `message`→thread, `priority`→ficha do topo). No form 2 ("Detalhes do chamado", tipo T) só sobra o campo **"Observações"** (`ost_form_field` id 42, tipo `memo`), **adicionado por este projeto** em 2026-07-01. Esse campo ficou **órfão**: o formulário de abertura do cliente é o módulo de equipamentos (que tem o seu próprio "Detalhamento/Observação" por item), então o "Observações" do ticket **nunca é coletado** (banco: `ost_form_entry_values` field 42 = 2 respostas, 0 preenchidas). Resultado: aparecia sempre vazio na tela do agente.
- **O que é o "—Esvaziar—" (estudo):** não é valor nem botão — é o placeholder de **campo vazio**, `'—' . __('Empty') . '—'`. O termo inglês é "Empty" (vazio), mas o pacote **pt-BR do osTicket traduz errado como "Esvaziar"** (verbo). Confirmado: a string "Esvaziar" existe dentro de `include/i18n/pt_BR.phar`.
- **Correção 1 — esconder a seção vazia (`ticket-view.inc.php`):** no laço que monta `$displayed`, passamos a calcular `$hasContent` (algum campo visível tem valor?) e `$hasRequired` (algum é obrigatório p/ fechar?). Se `!$hasContent && !$hasRequired`, faz `continue` (não renderiza a seção). Salvaguarda: se houver campo **obrigatório p/ fechar** vazio, a seção continua aparecendo (o agente precisa preenchê-lo). A seção **reaparece sozinha** se algum campo for preenchido.
- **Correção 2 — tradução "Esvaziar"→"Vazio" (seguro por locale):** o catálogo de mensagens é lido do `.phar` **antes** de pasta e é compilado (`.mo.php`) — sobrescrever globalmente exigiria reempacotar o phar (`phar.readonly=Off` + reassinar; frágil, evitado). Em vez disso, nos pontos que exibem campo vazio do chamado trocamos `__('Empty')` por **`str_replace('Esvaziar', 'Vazio', __('Empty'))`**: em pt-BR vira "Vazio"; em inglês continua "Empty"; se o pacote for corrigido um dia, o `str_replace` vira no-op. Pontos ajustados: `ticket-view.inc.php` (campo dinâmico vazio + Data de Vencimento vazia) e `ajax.tickets.php` (3 respostas de edição inline — arquivo, textarea e valor genérico). **Nota:** `include/ajax.tasks.php` e `templates/task-view.tmpl.php` têm o mesmo `__('Empty')` (telas de **Tarefas**) — não mexidos nesta rodada; se aparecer "Esvaziar" em Tarefas, replicar o mesmo `str_replace`.
- **Verificado no navegador** (chamado #105968): a seção "Detalhes do chamado" (que só tinha o "Observações" vazio) **sumiu** — a tela vai direto das fichas do topo para "Equipamentos".
- **Sem CSS novo** → sem cache-buster.
- **Status:** aplicado e testado (visual).

---

#### 2026-07-06 — Pop-ups e caixa "Carregando" do agente reestilizados

- **Motivo/contexto:** ao clicar em qualquer hiperlink que abre modal no SCP (ex.: prévia do usuário no chamado), aparecia primeiro uma **caixa "Carregando ..." feia** (retângulo cinza `#555` com textura, texto laranja `#d80`, borda cinza) e depois um **pop-up** com a faixa de título "flutuando" (folga em volta). Pedido: melhorar em todo o lado do agente.
- **Diagnóstico:** o visual vem do core `scp/css/scp.css` — `#loading` (linhas ~2708), `#overlay` (~2695) e `.dialog`/`#popup` (~2227+). Uma sessão anterior já tinha começado a estilizar `.dialog h3` (fundo grafite), mas como o `.dialog` tem `padding:1em`, a faixa de título ficava com folga nas bordas.
- **O que foi feito (CSS global do SCP, `scp/css/zkteco-scp.css` — vale p/ TODOS os pop-ups):**
  - `#overlay`: fundo `#1b1e20` opacidade `.45` (era preto 50%).
  - `#loading`/`#upgrading`: vira **cartão branco** (`background-image:none` mata a textura), `border-radius:14px`, sombra suave, layout flex; **spinner verde** (`#7AC143`) e texto grafite (`#474B4F`) no lugar do laranja.
  - `.dialog`: cartão branco, `border-radius:12px`, borda `#e3e6e2`, sombra suave.
  - `.dialog h3`/`h3.drag-handle`: faixa grafite **flush** via `margin:-1em -1em .9em` (cancela o `padding:1em` do core e cola a faixa nas bordas), `border-radius:11px 11px 0 0`, filete verde à esquerda.
  - `.dialog a.close`: **X branco** posicionado no canto do cabeçalho.
  - `#popup-loading`: spinner interno verde.
  - **Cache-buster** incrementado (`?zk20260706b` → ... → `?zk20260706e`).
- **Nota sobre centralização:** o `scp.js` centraliza `#loading` e `.dialog` dinamicamente via `outerWidth()`/`outerHeight()` — mexer no visual/largura **não quebra** o posicionamento.
- **⚠️ BUG introduzido e corrigido (mesma data):** a 1ª versão pôs `display:flex` no `#loading`. Isso **sobrescreveu o `display:none` padrão do core** (o `scp.js` mostra/esconde a caixa com `show()/hide()`; ele só a esconde após navegação **pjax**). Num carregamento normal de página a caixa nascia visível e **nada a escondia** → ficava travada em "Carregando ..." para sempre. **Correção:** remover qualquer `display` do `#loading` (deixar o core/JS controlarem) e fazer o alinhamento ícone+texto com `vertical-align:middle` (ícone `float:none`, `display:inline-block` no `h1`) em vez de flex. **Lição:** nunca definir `display` em elementos que o JS do core alterna via `show()/hide()`.
- **Ajuste fino:** o `.dialog` do core usa `padding:1em`; como o `1em` do `.dialog` (~14px) difere do `1em` do `h3` (16px), a faixa do cabeçalho ultrapassava ~2px. Fixado `.dialog{padding:16px}` + `h3{margin:-16px -16px 14px}` para casar exatamente (medido: `overflow-x = 0`).
- **Verificado no navegador** (via medição no DOM, pois o screenshot da ferramenta estava com erro): com o dialog aberto → `#loading` computa `display:none`, `#popup` abre com cabeçalho grafite `#474B4F` flush (`margin-top:-16px`, filete verde), X branco, e **sem overflow horizontal**.
- **Status:** aplicado e testado.

---

#### 2026-07-06 — CONTEÚDO dos pop-ups do agente modernizado (rodada 2 — miolo dos dialogs)

- **Motivo/contexto:** a moldura dos pop-ups já tinha sido tratada (cabeçalho grafite etc.), mas o **miolo** continuava horroroso (feedback do usuário com print do pop-up de usuário): abas estilo "pasta de arquivo" azul, tabela de contato com **linhas pontilhadas pretas**, avatar quadrado, links azuis, inputs crus, botões minúsculos (22px).
- **Levantamento (workflow com 3 leitores paralelos — markup dos templates, CSS core, CSS ZK):** existem **3 famílias de pop-up** no SCP: (1) dialogs AJAX (`#popup` + ~51 templates em `include/staff/templates/*.tmpl.php`, anatomia: `h3.drag-handle` + `a.close` + `hr` + banners `#msg_*` + form + `hr` + `p.full-width` com botões); (2) previews de hover (`.tip_content`, ticket/task-preview); (3) dialogs estáticos (`#alert` no footer, `#confirm-action` repetido em ~25 páginas). **Lacuna-chave:** os campos de formulário ZK eram escopados em `#content`, mas os dialogs vivem **fora** de `#content` (footer.inc.php) → inputs de pop-up estavam com o visual cru do core.
- **O que foi feito** (bloco novo no **fim** de `scp/css/zkteco-scp.css` — fim do arquivo vence empates de especificidade):
  - `hr` redundante logo sob o título **oculto** (`h3 + b + hr` etc. — a faixa grafite já é o separador); demais `hr` viram linha sólida suave `#eef1ed` (fim do gradiente).
  - **Links** dentro do dialog: azul core → verde `#649E37`; `a.action-button` explícito em grafite.
  - **Abas**: cores re-assertadas (ativa grafite, inativa cinza) + **ícone verde na aba ativa**.
  - **`table.custom-info`**: seção (`th`) com filete verde à esquerda + borda sólida suave; células com linha `#f0f2ef`; rótulos (1ª coluna) em cinza 600. `.dialog th`/`.tip_box th` genéricos: fim do fundo `#eee` com borda pontilhada. `.dialog .table td` branco (`!important` para vencer o `!important` do core).
  - **Avatar** (`img.avatar`) e placeholder (`i.icon-4x.icon-border`): cantos 14px, borda `#e3e6e2`, fundo suave.
  - **`.floating-options`/`.quicknote` `a.action:hover`**: laranja core → verde (global).
  - **Campos**: `input`/`select`/`textarea` dentro de `.dialog` com o padrão ZK (borda `#cfd5cc`, radius 7, focus ring verde); `input.search-input` (lookups) maior (10px 12px, radius 8).
  - **Botões** no dialog: `padding:8px 18px`, radius 6 (o core usava 22px de altura); primário mantém gradiente verde global, neutros mantêm pílula branca.
  - **Botões destrutivos** (`input[type=submit].red.button` — "Excluir" etc. em 7 templates): herdavam o **gradiente verde** do submit ZK! Agora **vermelho sólido `#c0392b`** (hover `#a5281b`), global.
  - **Previews de hover** (`.tip_content`): borda `#666` + sombra dura → cartão ZK (borda `#e3e6e2`, radius 10, sombra suave).
  - `#popup-loading h1` ("Carregando" interno) em grafite 600.
- **🐛 Bug de cascade encontrado e corrigido na verificação:** a regra de links `.dialog a:not(.action-button):not(.close):not(.action)` soma **(0,4,1)** de especificidade (cada `:not()` conta!) e **vencia a aba ativa** (0,3,3) — pintando-a de verde. Corrigido com **`:where()`** (especificidade ZERO nas exclusões): `.dialog a:where(:not(...)...)` fica em (0,1,1) — empata com o `.dialog a` do core (vence por ordem) e perde para abas/botões, como deve. **Lição:** exclusões em seletores de "cor padrão" devem ir em `:where()`.
- **Verificação (medição DOM em 2 dialogs reais — user e change-user):** aba ativa `#474B4F` + ícone `#7AC143`, inativa `#6b716c`; custom-info th com filete verde/borda sólida; td `#f0f2ef`; rótulo cinza 600; avatar radius 14; action-button grafite; search-input radius 8/padding 10-12; submit gradiente verde radius 6 padding 8-18; cancel pílula branca; 1º hr `display:none`; overflow-x = 0 nos dois.
- **Como reaplicar em versão nova:** reaplicar o bloco "CONTEÚDO dos pop-ups" no fim do `zkteco-scp.css` e bumpar o cache-buster. Conferir se `footer.inc.php` ainda renderiza os dialogs fora de `#content` (se moverem para dentro, as regras de campo duplicam sem dano).
- **Status:** aplicado e testado (DOM; screenshot da ferramenta indisponível por bug do plugin — conferência estética final com o usuário).

---

#### 2026-07-07 — Pop-up de usuário: cabeçalho de identidade reestruturado (rodada 3 — layout, não só CSS)

- **Motivo/contexto:** mesmo após as rodadas 1 e 2 (moldura + miolo), o usuário ainda achava o pop-up do usuário (`#tickets/{id}/user`) feio. Diagnóstico ao vivo (medição no DOM via navegador): o problema não era mais cor/borda e sim o **layout com floats antigo** do `user.tmpl.php` — avatar `pull-left` (imagem cinza 87×82 sem recorte) com nome/e-mail **colados no topo**, botão "Alterar Usuário" `pull-right` **desalinhado verticalmente**, e os ícones editar/gerenciar (`.floating-options`, `position:absolute`) **flutuando num vão vazio** entre as abas e o título da seção. As rodadas anteriores foram só CSS; esta mexe na **estrutura**.
- **Arquivos alterados:**
  - `include/staff/templates/user.tmpl.php` (core template): o bloco de identidade foi reorganizado num container **flex** `.zk-user-head` com 3 filhos — `.avatar` | `.zk-user-id` (nome `.zk-user-name` + e-mail `.faded` + org `.zk-user-org`) | botão `.change-user`. Removidos os `pull-left`/`pull-right` e os `style` inline de margem. **A atribuição `$org = $user->getOrganization()` foi preservada dentro do bloco** (é usada mais abaixo para decidir a aba "Organização").
  - `scp/css/zkteco-scp.css` (fim do arquivo): novo bloco "POP-UP DE USUÁRIO". `.zk-user-head` = flex, `align-items:center`, `gap:14px`, filete `#eef1ed` embaixo. Avatar `58×58`, `object-fit:cover`, `border-radius:12px` (recorta o gravatar retangular num quadrado arredondado). Botão `.change-user` `align-self:center`. `.floating-options` reancorada em `top:10px;right:0` da aba (fica **alinhada ao título** "Informações de contato" em vez de flutuar) e os ícones viraram botões `26×26` com hover verde. Também reescritas as **abas** do dialog: de "abas de pasta" azuis para **barra com underline contínuo** (`ul.tabs` flex + `border-bottom`; aba ativa com `border-bottom:2px #7AC143`). E a "nova nota" (aba Notas) virou **bloco tracejado clicável** verde.
  - `include/staff/header.inc.php`: cache-buster `?zk20260706g` → `?zk20260707a`.
- **Verificação (medição DOM no navegador, chamado #105968):** `overflow-x = 0`; `.zk-user-head` `align-items:center`, avatar `58×58` radius `12px` `object-fit:cover`; botão centralizado (midY 230 vs cabeçalho 238); ícones de ação alinhados ao título da seção (midY 349 vs th 348). Aba Notas com bloco tracejado verde OK. Screenshots conferidos.
- **Lição:** quando 2 rodadas de CSS não resolvem um "está feio", o gargalo pode ser o **markup** (floats/ordem dos elementos), não o estilo — vale medir o DOM ao vivo e, se preciso, reestruturar o template em flex.
- **Status:** aplicado e testado (DOM + screenshot) — conferência estética final com o usuário.

---

#### 2026-07-07 — Pop-ups de "Atualizar campo": `<select>` cortado + calendário (datepicker) tematizado

- **Motivo/contexto:** o usuário mostrou vários pop-ups de atualização rápida de campo (Nível de prioridade, Transferir departamento, Plano de SLA, Tópico de ajuda, Data de Vencimento) com defeitos. Dois problemas de raiz:
  1. **`<select>` com o texto CORTADO** em TODOS eles. Diagnóstico (medição DOM): o core aplica `height:24px` no select e, com `box-sizing:border-box` + o `padding:6px` vertical dos campos ZK, sobravam só ~10px de área útil para um texto de 13px → o texto encostava/ultrapassava a borda inferior.
  2. **Calendário laranja** no "Atualizar Data de Vencimento": é o **jQuery UI datepicker** (`#ui-datepicker-div`, anexado ao `<body>`, FORA de `.dialog`), que vinha com o tema laranja padrão (`header #f6a828`, dias azuis, hoje amarelo, botões azuis) — destoa totalmente do grafite/verde ZK.
- **Arquivo alterado:** `scp/css/zkteco-scp.css` (só CSS) + cache-buster.
  - **Fix do select:** `.dialog select{ height:auto; min-height:34px; padding:6px 10px; min-width:200px; line-height:1.3; box-sizing:border-box; }` — solta a altura fixa do core e garante área para o texto. `min-width:200px` para os selects de campo não ficarem minúsculos.
  - **Tema do datepicker (bloco novo no fim do arquivo):** `#ui-datepicker-div` vira cartão branco (radius 10, borda `#e3e6e2`, sombra ZK); header grafite `#474B4F` com setas brancas (`filter:brightness(0) invert(1)`); dias grafite com hover verde suave; **hoje** com contorno verde (`box-shadow:inset 0 0 0 1px #cfe6b3`); **selecionado** preenchido verde `#7AC143`; rodapé "Now/Done" (Now = pílula neutra, Done = gradiente verde); Time/Hour estilizados. **Cuidado:** NÃO pôr `padding` no `.ui-datepicker-group` (estoura a largura e empilha os 2 meses) — espaçar via `margin` na `table` interna.
  - **Cache-buster:** `?zk20260707a` → `?zk20260707b`.
- **Verificação (navegador, chamado #105968):** select do SLA/prioridade agora 34px de altura, texto inteiro; datepicker com header grafite (`rgb(71,75,79)`), 2 meses lado a lado, "hoje"=7 com contorno verde, "Done" verde. Screenshots conferidos.
- **⚠️ Pendência conhecida (NÃO é CSS):** no campo de hora do datepicker, o texto aparece como **"7:i am"** — o `i` é o token PHP de minutos (`g:i a`) sendo passado LITERALMENTE ao jQuery UI timepicker addon (que usa outros tokens). É um descasamento de formato do **core osTicket**, não visual. Corrigir exige mexer na init JS do campo datetime (arriscado/amplo) — deixado para uma rodada dedicada se incomodar.
- **Status:** aplicado e testado (DOM + screenshot).

---

#### 2026-07-07 — Cabeçalho do chamado: 3 campos removidos (Prioridade, Telefone/WhatsApp, Tópico de ajuda)

- **Motivo/contexto:** o usuário marcou (traço vermelho) 3 campos no bloco de fichas do topo do chamado e pediu para removê-los. Leitura literal dos 3 traços = 1 campo cada. (Departamento e Origem NÃO foram removidos — ficaram como estavam; o usuário foi avisado que é trivial tirá-los também se quiser.)
- **Arquivo alterado:** `include/staff/ticket-view.inc.php` (core template). **Remoção reversível** — não apaguei código, envolvi cada `<tr>` num `if (false)` com nota ZK:
  - **Prioridade:** `<tr>` do `__('Priority')` (col. esq. da 1ª ficha) envolto em `<?php if (false) { /* ZK... */ ?> ... <?php } ?>`.
  - **Telefone/WhatsApp:** era o bloco ZK condicional `if ($__phone)`; trocado para `if (false && $__phone)`. **O número continua no pop-up do usuário** (aba Usuário → Informações de contato), então não se perde acesso.
  - **Tópico de ajuda:** `<tr>` do `__('Help Topic')` (col. dir. da 2ª ficha) envolto em `if (false)`.
  - **Origem (Source):** (adicionado logo depois, a pedido) `<tr>` do `__('Source')` (col. meio) envolto em `if (false)`.
  - **Departamento:** (adicionado a pedido — "sempre é Manutenção, só polui a visão") `<tr>` do `__('Department')` (col. esq.) envolto em `if (false)`.
- **Como reverter/reaplicar:** trocar `if (false)` por `if (true)` (ou remover o wrapper) no campo desejado; no Telefone, tirar o `false &&`.
- **Sem CSS novo** → sem cache-buster.
- **Verificação:** `php -l` OK; navegador (chamado #105968): cabeçalho mostra Status/Departamento/Data de Criação | Usuário/Email/Origem | Atribuído a/SLA/Vencimento + Última Mensagem/Resposta. Os 3 campos sumiram, layout intacto.
- **Status:** aplicado e testado (visual). Confirmado com o usuário: também removidos **Origem** e **Departamento** ("sempre é Manutenção, só polui a visão"). Cabeçalho final: Status/Data de Criação | Usuário/Email | Atribuído a/SLA/Vencimento + Última Mensagem/Resposta.

---

#### 2026-07-07 — Novo status de chamado "Em manutenção"

- **Motivo/contexto:** o usuário pediu um novo status de chamado "Em manutenção", funcional igual aos existentes.
- **Mecânica (estudo — status é 100% orientado a banco):** os status de chamado vivem na tabela **`ost_ticket_status`** e são consultados em toda parte via `TicketStatusList::getStatuses(array('states'=>[...]))` filtrando por **`state`** (open/closed/archived/deleted) e por `isEnabled()` (flag `mode & 0x01`). Onde aparecem (tudo data-driven, **nenhuma** exige código novo): dropdown do topo do chamado (`include/staff/templates/status-options.tmpl.php` — open→ação "reopen", closed→"close", exclui o atual), seletor de status da **Resposta** e da **Nota** (`ticket-view.inc.php` ~1147 e ~1238), lista do admin (Painel Admin → Gerenciar → Status de Chamado), filas/filtros/busca e a coluna de status da listagem.
- **Colunas de `ost_ticket_status`:** `id`(auto), `name`(UNIQUE), `state`(open/closed/archived/deleted), `mode`(flags: `0x01`=ENABLED, `0x02`=INTERNAL — impede exclusão/renomear/trocar state), `flags`, `sort`, `properties`(TEXT JSON — p/ status **open** basta `{"description":"..."}`; allowreopen/reopenstatus só valem p/ **closed**), `created`, `updated`. Status existentes: Solicitado(1,open,mode3), Enviado(6,open,mode3), Recebido(7,open,mode1), Resolvido(2,closed,mode1), Encerrado(3,closed,mode3), Arquivados(4), Deletado(5).
- **O que foi feito (INSERT no banco, espelhando "Recebido"):**
  ```sql
  UPDATE ost_ticket_status SET sort = sort + 1 WHERE sort >= 4;  -- abre espaço após Recebido
  INSERT INTO ost_ticket_status (name,state,mode,flags,sort,properties,created,updated)
  VALUES ('Em manutenção','open',1,0,4,'{"description":"Equipamento(s) em manutenção na ZKTeco."}',NOW(),NOW());
  ```
  Resultado: **id 8**, state=open, ENABLED (mode=1, NÃO internal → gerenciável/removível no admin), sort=4. Ordem: Solicitado, Enviado, Recebido, **Em manutenção**, Resolvido, Encerrado, Arquivados, Deletado. Acentos gravados com `SET NAMES utf8mb4` (sem mojibake).
- **Verificação (navegador, chamado #105968):** "Em manutenção" aparece nos 3 seletores — dropdown do topo (`Solicitado, Enviado, Em manutenção, Resolvido, Encerrado`), Resposta e Nota. Como usa o mesmo caminho de código dos outros open statuses, `Ticket::setStatus()` funciona igual. **Não** acionei a troca real no teste porque o gancho ZK em `Ticket::setStatus` **dispara e-mail ao cliente a cada mudança de status** (evitar e-mail de teste).
- **Automação (opcional, NÃO feito):** existe o helper `zk_ticket_set_status_by_name($ticket_id,$name)` em `include/zk_equipment.php` (usado no ciclo Solicitado→Enviado). Se um dia quiser que o sistema mude para "Em manutenção" automaticamente (ex.: quando o 1º equipamento sai de "Aguardando"), é só chamar `zk_ticket_set_status_by_name($tid,'Em manutenção')` no ponto certo.
- **Sem arquivo de código alterado** (mudança só no banco) → sem cache-buster.
- **Status:** aplicado e verificado (aparece e é selecionável nos 3 pontos). Falta o usuário confirmar a troca real num chamado.

---

#### 2026-07-07 — Botões "Recomeçar Formulário" (reset) ocultados globalmente

- **Motivo/contexto:** o usuário considera o botão de reset ("Recomeçar Formulário" — tradução pt-BR de `__('Reset')`) um conceito obsoleto e pediu para removê-lo de **todos** os dialogs/formulários do painel de equipe.
- **Abordagem:** havia ~60 ocorrências de `<input type="reset">`/`<button type="reset">` espalhadas em `include/staff/*.inc.php` e `include/staff/templates/*.tmpl.php`. Editar arquivo a arquivo seria frágil e quebraria em upgrade. Como o reset só limpa o form (sem função de negócio), a solução é **CSS global**.
- **Arquivo alterado:** `scp/css/zkteco-scp.css` (bloco no fim) — `input[type=reset], button[type=reset]{ display:none !important; }`. Cobre todos, atuais e futuros; escopo = painel de equipe (o CSS não carrega no cliente). Cache-buster `?zk20260707b` → `?zk20260707c`.
- **Reversível:** remover o bloco de CSS.
- **Verificação (navegador):** dialog "Transferir" agora mostra só **Cancelar** e **Transferir** (o reset sumiu; no DOM continua mas `display:none`).
- **Nota lateral (não tratado):** no dialog Transferir o texto "Maintain referral access to current department" está em inglês — string sem tradução, fica para uma rodada de i18n se incomodar.
- **Status:** aplicado e testado (visual).

---

#### 2026-07-07 — Área do cliente: coluna Status alargada (badge "Em manutenção" quebrava linha)

- **Motivo/contexto:** na lista de chamados do cliente (`tickets.php`), o novo status "Em manutenção" (badge/pílula `.zk-ti-status`) **quebrava em 2 linhas** — a coluna Status era estreita (`width="100"`) e a tabela é `table-layout:fixed`.
- **Arquivos alterados:**
  - `include/client/tickets.inc.php` (~linha 199): `<th width="100">` → `width="150"` na coluna Status. (Como a tabela é fixed, a largura da coluna vem do atributo do `<th>`; a coluna Assunto, sem width, absorve o espaço.)
  - `assets/default/css/theme.css` (`.zk-ti-status`): adicionado `white-space:nowrap` (garante 1 linha mesmo se o texto crescer). Cache-buster do theme `?zk20260703o` → `?zk20260707a`.
- **Verificação (navegador, cliente):** "Em manutenção" agora em uma linha só; layout da lista intacto.
- **Status:** aplicado e testado (visual).

---

#### 2026-07-07 — Filtro AVANÇADO INLINE na fila de chamados (substitui o popup "Pesquisa Avançada")

- **Motivo/contexto:** o usuário achou o popup modal de "Pesquisa Avançada de Chamados" um conceito antigo e pediu um filtro avançado inline moderno que contemple os mesmos critérios, eliminando a tela.
- **Mecânica (estudo):** a busca de chamados é 100% orientada por **critérios ad-hoc**. `scp/tickets.php` já monta `$_SESSION['advsearch'][$key] = [[nome,método,valor],...]` a partir de GET (era usado só pela busca simples) e define `$queue_id="adhoc,$key"`; daí `AdhocSearch::load()` → `CustomQueue::mangleQuerySet()` aplica os critérios chamando `$field->getSearchQ($method,$value,$name)` e a fila renderiza normalmente. **Formatos de valor por tipo de campo:** ChoiceField (status, depto, tópico, sla, staff) → método `includes`, valor `[id=>id]` (usa `array_keys`); DatetimeField (created, duedate) → `between` `['left'=>de,'right'=>até]` / `after` / `before`; palavra-chave → `[':keywords', null, termo]` (full-text via `$ost->searcher`).
- **Abordagem (reusa TODO o backend nativo — nenhuma query nova):**
  1. `scp/tickets.php`: novo bloco `elseif ($_GET['a']==='zksearch')` que traduz os parâmetros `zk_*` da barra em critérios (mapa `zk_status→status__id`, `zk_state→status__state`, `zk_dept→dept_id`, `zk_assignee→staff_id`, `zk_topic→topic_id`, `zk_sla→sla_id`, `zk_created_from/to→created`, `zk_due_from/to→duedate`, `zk_q→:keywords`), grava em `$_SESSION['advsearch']['zkadv']` e faz `$queue_id='adhoc,zkadv'`.
  2. `include/staff/templates/queue-tickets.tmpl.php`: o link `[avançado]` (que abria `$.dialog('ajax.php/tickets/search')`) foi **substituído** por um toggle `.zk-advfilter-toggle` que expande o painel `#zk-advfilter`. O painel é um form GET (pjax, igual à busca simples) com dropdowns populados por `TicketStatusList::getStatuses`, `Dept::getDepartments`, `Topic::getHelpTopics`, `Staff::getStaffMembers`, `SLA::getSLAs(['nameOnly'=>true])` + 4 inputs `type=date` + palavra-chave. Repopula os campos a partir dos `$_GET['zk_*']` (estado persistente) e reabre sozinho quando há filtro ativo; mostra "Limpar filtros" (→ `tickets.php`).
  3. `scp/css/zkteco-scp.css`: bloco "FILTRO AVANÇADO INLINE" — cartão branco com borda verde à esquerda, grid responsivo (`repeat(auto-fill,minmax(200px,1fr))`), palavra-chave em largura total, botão "Filtrar" verde. Cache-buster `?zk20260707c` → `?zk20260707d`.
- **Verificação (navegador):** `php -l` OK nos 2 PHP. Testado por GET direto e por submit real (pjax): Status="Em manutenção" (id 8) → 1 resultado (105968); Status "Recebido" → 0; intervalo de datas amplo → 2 chamados, restrito → filtra; palavra-chave "Manutenção" → 2. Painel permanece aberto e com seleção após aplicar; "Limpar filtros" aparece. As abas de fila (Aberto/Meus Chamados/Encerrado) continuam intactas (não passam `a=zksearch`).
- **Nota (pré-existente do osTicket, NÃO regressão):** buscas ad-hoc mostram contagem **estimada** ("Mostrando 1-25 de cerca 500") e paginação com páginas vazias — é o `getCount()` aproximado nativo; o popup antigo tinha o mesmo. Tratar à parte se incomodar.
- **Multi-seleção (não feito):** os dropdowns são de valor único (1 status, 1 depto...). O método `includes` já suporta vários; dá pra evoluir para multi-select depois.
- **Reverter:** remover o bloco `zksearch` de `tickets.php`, o painel/toggle do template e o bloco CSS; restaurar o link `[avançado]`.
- **Status:** aplicado e testado (backend + E2E via navegador).

**Ajustes (mesmo dia, feedback do usuário):**
- **Bug "filtro não exibe nada":** ao aplicar o filtro **sem** nenhum critério (tudo "Qualquer"), `$criteria` ficava vazio e a página caía numa busca ad-hoc vazia/obsoleta (mostrava nada). **Corrigido** em `scp/tickets.php`: no `else` do `zksearch`, faz `unset($_SESSION['advsearch']['zkadv'])` e `$queue_id = $thisstaff->getDefaultTicketQueueId() ?: $cfg->getDefaultTicketQueueId()` → filtro vazio volta à fila padrão ("Aberto") com resultados. **Verificado** no navegador.
- **Coluna "Status" sumia nos resultados:** buscas ad-hoc caem nas "colunas padrão de último recurso" de `CustomQueue::getColumns()` (Número, Criado, Assunto, De, Prioridade, Designado — **sem** Status). **Corrigido** em `scp/tickets.php` (após resolver `$queue`): se a fila for ad-hoc (`strpos(getId(),'adhoc')===0`), faz `$queue->set('columns_id', <fila padrão do agente>)` **antes** do `getQuery()` — assim `getColumns()` (linha ~668, checa `columns_id` primeiro) devolve as colunas da fila padrão (com Status) e o `getQuery()` (linha ~926, itera `getColumns()` p/ anotar) inclui o dado do Status. Aplica a TODAS as buscas ad-hoc (inclui a busca simples), dando paridade com as filas. **Sem save()** — só em memória.
- ⚠️ **Verificação final pendente:** a sessão do agente **expirou** durante o teste (SCP redirecionou ao login) e não posso autenticar (regra de segurança). A correção do filtro-vazio foi confirmada ao vivo; a do dado da coluna Status ficou logicamente garantida (getQuery usa getColumns) mas falta o print final — reconferir ao reabrir logado.

---

#### 2026-07-07 — Ambiente Docker criado (migração do XAMPP) — `C:\osticket-docker`

- **Motivo/contexto:** migrar o osTicket do XAMPP para Docker Compose (dev + base p/ produção em `suporte.zkteco.com.br`), preservando dados e customizações. **O XAMPP NÃO foi alterado** — tudo por cópia.
- **Ambiente detectado:** osTicket v1.17.8; PHP 8.2 (usado igual no Docker); MariaDB 10.4 (Docker usa 10.6); banco `zkteco_manutencao` / user `osticket` / prefixo `ost_` / charset `utf8_general_ci`; **anexos no banco** (backend `D`, dump `--hex-blob` já leva tudo).
- **O que foi criado em `C:\osticket-docker\`:** `app/` (cópia de `upload/`, sem `setup/` e `.claude`), `db/init/01-zkteco_manutencao.sql` (dump p/ restauração automática no 1º up), `backups/` (backup datado), `docker/` (Dockerfile PHP8.2+Apache+extensões, vhost, php.ini), `docker-compose.yml` (serviços `app`+`db`, volume `db_data`, `restart: unless-stopped`, porta 8080, `.env`), `.env`/`.env.example`, `.gitignore`, 5 `.bat` (iniciar/parar/backup/logs/restaurar) e `README.md` (guia completo pt-BR: instalação Docker, migração, comandos, checklist, produção/HTTPS/proxy, cron, upgrade).
- **Ponto-chave:** as customizações estão em **arquivos core + banco**, então NÃO se usa imagem osTicket de prateleira — a imagem carrega a árvore `app/` inteira. Dev = bind-mount `./app`; Prod = imagem autocontida (Dockerfile já faz `COPY app/`).
- **`ost-config.php` (da cópia):** credenciais agora via `getenv()` (`OST_DBHOST=db`, etc., vindas do `.env`) — **sem senha fixa no arquivo**. O do XAMPP continua `localhost/123456`.
- **⚠️ Ajuste no Dockerfile (build real):** a extensão **imap** exige `libc-client-dev`, **removido no Debian 12 (bookworm)** — base do `php:8.2-apache`. O `apt-get` falhava (exit 100). **Solução:** trocar o bloco de extensões pelo instalador **`install-php-extensions` (mlocati)**, que resolve as libs do imap/gd/intl no bookworm sozinho. (Outro detalhe: rodar `docker` fora do PATH do Docker Desktop dá erro `docker-credential-desktop not found` no pull — resolver adicionando `C:\Program Files\Docker\Docker\resources\bin` ao PATH, ou rodar pelo terminal do Docker/PowerShell normal.)
- **✅ SUBIU E VALIDADO (2026-07-07):** Docker Desktop v4.81 instalado (WSL2). `docker compose up -d --build` OK → `osticket-app` em `:8080`, `osticket-db` (mariadb:10.6) **healthy**. Banco restaurado automaticamente (**77 tabelas**, status "Em manutenção" id 8 presente). `http://localhost:8080/scp/login.php` = **HTTP 200** com a skin ZKTeco (logo, "Central de Manutenção", verde/grafite, acentos corretos). Login com as credenciais atuais (mesmo banco). Guia completo: **`C:\osticket-docker\README.md`**.
- **Status:** **migração concluída e funcionando no Docker.** Falta só o usuário conferir por dentro (login, anexos, e-mail) pelo checklist do README.

##### Ajustes pós-migração (no app do Docker, `C:\osticket-docker\app`)
- **2026-07-07 — Telefone/WhatsApp de volta ao cabeçalho do agente (clicável):** o usuário pediu, na solução Docker, o telefone do cliente no cabeçalho do chamado igual à tela do cliente, clicável abrindo o WhatsApp. Em `app/include/staff/ticket-view.inc.php` (linha ~459) o bloco tinha sido desativado (`if (false && $__phone)`); reativado para `if ($__phone)`. O markup já existente monta `<a target="_blank" href="zk_whatsapp_url($__phone)">` com ícone de telefone. **Editado no app do Docker** (não no XAMPP legado). Verificado ao vivo (`:8080/scp/tickets.php?id=20`): link `https://wa.me/5531997910742`, abre em nova aba.
- **⚠️ OPcache + bind-mount no Windows:** edições em arquivos `.php` NÃO refletiam (o OPcache do container servia o bytecode antigo, pois o mtime via bind-mount do Docker Desktop nem sempre muda). **Correção:** `docker/php-osticket.ini` → `opcache.revalidate_freq=0` (+ `validate_timestamps=1`) e **rebuild** (`docker compose up -d --build`). Agora edições em `.php` refletem a cada request. **Em produção, voltar `revalidate_freq` para 2+.** Alternativa rápida quando um .php não atualizar: `docker compose restart app`. (CSS/JS/templates não são opcached → refletem na hora, respeitando o cache-buster do navegador.)

---

#### 2026-07-07 — Thread do chamado redesenhada (timeline de cartões) + eventos de sistema ocultos (painel do agente)

- **Motivo/contexto:** o usuário apontou que a thread ("Conteúdo do Chamado") do painel do agente tinha um visual **antigo e poluído** — barras coloridas azul/laranja/creme no topo de cada entrada, caixas de borda dura, balões com "biquinho" apontando pro avatar e os eventos de sistema com ícone de lápis solto e recortes brancos ligados por uma linha pontilhada. Feito no app do Docker (`C:\osticket-docker\app`).
- **Mecânica (estudo):** a thread é renderizada por `include/staff/templates/thread-entry.tmpl.php` (classes `.thread-entry` + `.message`/`.response`/`.note`/`.system`, com `.header` e `.thread-body`) e os eventos por `thread-event.tmpl.php` (`.thread-event` > `.type-icon` + `.description`). O visual padrão vem do **core** `scp/css/scp.css` (`.thread-entry` ~1513+; `.thread-event`/`.type-icon` ~3480+; conector `#thread-items::before` ~3461, `border-left:2px dotted`). A skin ZKTeco **não tocava a thread** até aqui. Redesenho **100% CSS** — a marcação PHP fica intacta (seguro em upgrade, reversível).
- **Arquivos alterados:**
  - `scp/css/zkteco-scp.css` (2 blocos novos no fim, cada um demarcado por comentário):
    1. **"THREAD DO CHAMADO — timeline de cartões":** `.thread-entry` vira **cartão branco** (borda `#e6e9e4`, radius 12, sombra em camadas); o `::before` do tema é reaproveitado como **faixa de acento lateral 4px** por tipo — resposta do agente = verde `#7AC143`, mensagem do cliente = azul-acinzentado `#9fb2c9`, nota interna = âmbar `#e8b64a` (com fundo creme `#fffdf5`); `.header` achatado (fundo/borda/**biquinhos** `::before/::after` removidos, nome em grafite, data suave, assunto como chip-pílula); `.thread-body` sem borda; **avatares circulares** (`border-radius:50%`, sem `overflow:hidden` no cartão para não recortar o avatar no gutter negativo); anexos em bloco verde-claro; abas `#response-tabs` com underline verde.
    2. **"Eventos de sistema: OCULTOS":** `.thread-event{ display:none }` + `#thread-items::before{ display:none }` (o conector pontilhado da timeline, que sem os eventos perde a função). Escolha do usuário entre esconder tudo / compactar / esconder só "criado por" → optou por **esconder todos**. O histórico de mudança de status **continua registrado no log do chamado** — só não aparece mais no fluxo da conversa.
  - `include/staff/header.inc.php`: cache-buster `?zk20260707d` → `?zk20260707e` (redesenho da thread) → `?zk20260707f` (ocultar eventos).
- **Reverter:** remover os 2 blocos no fim do `zkteco-scp.css` (voltando ao visual padrão do core) e/ou apenas o 2º bloco (para trazer os eventos de volta).
- **Verificação:** `curl http://localhost:8080/scp/css/zkteco-scp.css` confirma os blocos servidos pelo container (bind-mount ao vivo); confirmação visual pelo usuário ao recarregar (Ctrl+F5).
- **Status:** aplicado; confirmação estética final com o usuário. Só CSS do SCP → não afeta o portal do cliente.

---

#### 2026-07-07 — Progresso PONDERADO dos equipamentos (barra do chamado + mini-barra por item + coluna na listagem)

- **Motivo/contexto:** o progresso era **binário** (`done/total` — só status com `done:true` contavam), então 1 equipamento pulava de 0% a 100% e N itens andavam aos blocos (25/50/75). O usuário pediu uma "boa evolução/progresso" na tela do agente e uma **coluna Progresso** na listagem do cliente. Feito no app do Docker (`C:\osticket-docker\app`).
- **Conceito (proposto e aceito — "aceito sugestões"):** progresso **ponderado por etapa** — cada status do ciclo ganha um **peso 0-100%** e o progresso do chamado é a **média dos equipamentos**. Pesos escolhidos: Aguardando 0 · Em análise 25 · Aguardando peça 45 · Em reparo 70 · Reparado/Substituído/Sem reparo/Enviado 100. **Fonte única** em `zk_equip_statuses()` — trocar os números reflete nos 3 lados de uma vez.
- **Arquivos alterados:**
  - `include/zk_equipment.php`:
    - `zk_equip_statuses()`: +chave `weight` por etapa; novos helpers `zk_equip_status_weight($key)` e `zk_equip_progress_from_counts($counts,$total)` (média ponderada).
    - `zk_equip_stats()`: passa a devolver `pct` (ponderado) além de `counts/total/done`.
    - `zk_equip_counts_for_tickets()` (listagem, 1 consulta p/ a página toda): +`AVG(CASE status WHEN <chave> THEN <peso> ... ELSE 0 END)` → `pct` por ticket, **sem query extra**.
    - `zk_equip_progress_html()` (barra compartilhada cliente+agente): headline vira **`<pct>% concluído`** (verde, `.zk-progress-big`) + apoio "X de N equipamentos finalizados"; a barra usa o pct ponderado.
    - Grade editável do agente: **mini-barra `.zk-eqp-mini`** por equipamento na célula de Status (largura = peso da etapa, cor do status). JS `ZK_W` (mapa etapa→{peso,cor}) + `zkUpdateMini()` atualiza ao vivo no `change` do `<select>`; o "Aplicar em massa" passou a disparar `change` (antes só setava `.val`). Estilos `.zk-eqp-mini`/`.zk-progress-big` no bloco inline `zk_equip_styles()`.
  - `include/client/tickets.inc.php`: nova coluna **"Progresso"** (`<th width="140">` entre Assunto e Departamento) com barra + `%` (`.zk-lp`), lendo `pct` do `$zk_count_map`; `colspan` do "sem resultados" 6→7.
  - `assets/default/css/theme.css`: estilos `.zk-lp/.zk-lp-bar/.zk-lp-pct` (barra da coluna, gradiente verde `--zk-green-dk`→`--zk-green`). Cache-buster `?zk20260707a` → `?zk20260707b`.
- **Verificação:** `php -l` OK nos 2 arquivos (dentro do container); a expressão `AVG(CASE...)` conferida no banco (ticket com 1× `reparado`=100%; 4× `recebido`=0%; 1× `recebido`=0% — os 50%/10% do mockup eram ilustrativos, com dados reais o valor sobe conforme o agente evolui os itens); `.zk-lp-bar` servido pelo container. **Pendente:** conferência visual logado (mini-barra ao vivo + coluna) pelo usuário.
- **Reverter:** remover a chave `weight` + helpers e voltar o `pct` para binário; tirar a coluna Progresso (th/td + colspan 7→6) e os blocos CSS `.zk-lp*`/`.zk-eqp-mini`.
- **Status:** aplicado e testado (lógica); pendente confirmação visual final.

---

#### 2026-07-07 — Thread do cliente redesenhada (mesmo conceito do agente: cartões + eventos ocultos)

- **Motivo/contexto:** depois de limpar a thread do **agente** (timeline de cartões + eventos de sistema ocultos), o usuário pediu o mesmo na **tela do cliente** — a thread "Mensagens" (`tickets.php?id=N`) ainda mostrava os eventos com ícone de lápis ("Criado por", "alterou o estado para Enviado/Recebido/Em manutenção…") e a linha pontilhada, exatamente a poluição já removida no agente.
- **Mecânica:** o cliente usa as **mesmas classes do core** (`.thread-entry` + `.message`/`.response`, `.thread-event` > `.type-icon`), mas o container é **`#ticketThread`** (não `#thread-items`) e o estilo vem do **`theme.css`** (não do `scp.css`/`zkteco-scp.css` do agente). Templates: `include/client/templates/thread-entry.tmpl.php` e `thread-event.tmpl.php` (intactos — mudança **100% CSS**).
- **Arquivo alterado:** `assets/default/css/theme.css` (bloco novo no fim, antes de "FIM DA CAMADA ZKTECO"):
  - **Eventos ocultos:** `#ticketThread .thread-event{ display:none }` + `#ticketThread::before{ display:none }` (conector pontilhado). Os posts reais (ex.: "Atualização dos seus equipamentos: V5L status atualizado para Em análise") **continuam** — são `response`, não `event`.
  - **Cartões:** `#content .thread-entry` vira cartão branco (borda/radius/sombra); `::before` reaproveitado como **faixa de acento lateral 4px** — `response` (equipe)=verde `--zk-green`, `message` (cliente)=azul `#9fb2c9`; header achatado (fundo/borda/biquinhos removidos via `!important`), assunto vira chip, corpo sem borda, avatares circulares, anexos em bloco verde-claro. Prefixo `#content` para vencer a cascata do core sem depender da ordem; `width:auto` do core (anti-overflow do avatar) preservado.
  - Cache-buster do theme `?zk20260707b` → `?zk20260707c` em `include/client/header.inc.php`.
- **Reverter:** remover o bloco no fim do `theme.css`.
- **Verificação:** `curl` confirma o bloco servido pelo container; confirmação visual pelo usuário ao recarregar (Ctrl+F5).
- **Status:** aplicado; confirmação estética final com o usuário.

---

#### 2026-07-13 — Correção do envio de e-mail pós-migração (SMTP padrão no Docker)

- **Motivo/contexto:** depois da migração do XAMPP para Docker (2026-07-07), o sistema **parou de enviar e-mail** — o cliente não recebia mais notificações (novos tickets, respostas, alertas). O log interno do osTicket (`ost_syslog`) registrava, a cada tentativa de envio, o erro **"Erro no serviço de envio de e-mail: Unable to email via Sendmail — Unable to send mail: Unknown error"**. Notavelmente, **nunca** aparecia "Unable to email via SMTP", o que indicava que o SMTP sequer estava sendo tentado.
- **Tipo:** banco de dados / config.
- **Diagnóstico (mecânica):** em `include/class.mailer.php` (construtor da classe `\osTicket\Mail\Mailer`, ~linha 30, e método `send()`, ~linha 582), o osTicket monta a lista de contas SMTP a tentar nesta ordem: (1) a conta SMTP **do próprio e-mail remetente**, se ativa; (2) o **MTA padrão do sistema** = `$cfg->getDefaultMTA()` → `SmtpAccount::lookup(default_smtp_id)`; (3) só se `$email` for nulo, cai no e-mail padrão. Se a lista fica vazia, ou todas as contas falham, ele usa o transporte **Sendmail** (função `mail()` do PHP). No container Docker **não há MTA/sendmail instalado** (ver `docker/Dockerfile`, base `php:8.2-apache`, e `docker/php-osticket.ini` sem `sendmail_path`) — diferente do XAMPP, onde o `mail()` funcionava. Como `ost_config.default_smtp_id` estava **vazio** e os alertas ao cliente saem de `alerts@zkteco.com` (`email_id=2`), que **não tem conta SMTP própria** (só `juliano.torres@zkteco.com`, `email_id=1`, possui a conta SMTP `ost_email_account.id=2`), a lista ficava vazia → Sendmail inexistente → falha.
- **O que foi feito:** definido `ost_config.default_smtp_id = 2` (namespace `core`), apontando a conta SMTP existente (Tencent Exmail `ssl://smtp.exmail.qq.com:465`, ativa) como **SMTP padrão do sistema**. Comando executado no container do banco:
  ```sql
  UPDATE ost_config SET value='2'
   WHERE `key`='default_smtp_id' AND namespace='core';
  ```
  Equivalente pela interface: **Painel Admin → Configurações → E-mails → "SMTP Padrão / Default SMTP Email"** → conta `juliano.torres@zkteco.com`. (Fazer pela UI é preferível porque **regrava a senha do SMTP**, que é criptografada com o `SECRET_SALT` de `include/ost-config.php` — se o salt mudar numa migração, a senha antiga não descriptografa.)
- **Dependências/impactos:** nenhuma alteração de código-fonte — só um registro em `ost_config` (persiste no volume `db_data`, sobrevive a reinícios). Depende de a conta SMTP `ost_email_account.id=2` continuar ativa e com credenciais válidas.
- **Verificação:**
  1. Conectividade de rede do container app até o SMTP: `stream_socket_client("ssl://smtp.exmail.qq.com:465")` conectou em ~1,2 s e recebeu o banner `220 smtp.qq.com Esmtp QQ QMail Server`.
  2. Envio real pelo motor do osTicket: script temporário que carrega `main.inc.php` e chama `(new \osTicket\Mail\Mailer($cfg->getDefaultEmail()))->send(...)` retornou um **Message-ID** (não `false`) → SMTP autenticou e enviou; confirma também que a senha/`SECRET_SALT` estão íntegros. Script removido após o teste.
  3. `ost_syslog` sem nenhum novo erro de e-mail após o teste.
- **Como reaplicar em versão nova:** conferir `SELECT value FROM ost_config WHERE \`key\`='default_smtp_id'`; se vazio e o ambiente não tiver MTA (caso do Docker), apontar para o `id` de uma conta SMTP ativa em `ost_email_account`. Alternativa (se quiser manter o `mail()`): instalar um MTA/relay (ex.: `msmtp`) na imagem e configurar `sendmail_path` no php.ini — desnecessário aqui, pois a conta SMTP já resolve.
- **Status:** aplicado e testado (envio real confirmado).

---

#### 2026-07-13 — Sistema exclusivo de Manutenção: remoção dos departamentos Suporte e Vendas

- **Motivo/contexto:** decisão de negócio — este osTicket é **exclusivo para manutenção**. Havia 3 departamentos herdados da instalação (`Suporte`=1, `Vendas`=2, `Manutenção`=3); pedido de remover tudo que não fosse Manutenção (departamentos e "rotas de suporte").
- **Tipo:** banco de dados.
- **Levantamento (o que amarrava Suporte/Vendas):** varredura de todas as colunas `dept_id` do schema (`information_schema`) + grep no código. Achados: `ost_config.default_dept_id=1`; `ost_staff.dept_id=1` (agente Juliano); `ost_email.dept_id=1` para `alerts@` e `noreply@`; `ost_staff_dept_access` com acesso ao dept 2; `ost_thread_event` (2 linhas de histórico do ticket de teste #1 referenciando dept 1). **Nenhuma** referência hardcoded a "Suporte/Vendas/Support/Sales" nas customizações (`include/zk_equipment.php`, `include/client/*`, etc.) — o lado do cliente é 100% data-driven pelo **tópico único** "Solicitação de Manutenção" (→ dept 3); o cliente nunca escolhe departamento. Sem sub-departamentos (`pid`) e **sem chaves estrangeiras** apontando para `ost_department`. Todos os 4 tickets reais já estavam no dept 3.
- **O que foi feito (transação única):**
  ```sql
  START TRANSACTION;
  UPDATE ost_config SET value='3' WHERE namespace='core' AND `key`='default_dept_id';
  UPDATE ost_staff  SET dept_id=3 WHERE dept_id=1;                 -- agente -> Manutenção
  UPDATE ost_email  SET dept_id=3 WHERE dept_id IN (1,2);          -- alerts@/noreply@ -> Manutenção
  DELETE FROM ost_staff_dept_access WHERE dept_id IN (1,2);         -- tira acesso a Suporte/Vendas
  INSERT INTO ost_staff_dept_access (staff_id,dept_id,role_id)
    SELECT 1,3,1 FROM DUAL
    WHERE NOT EXISTS (SELECT 1 FROM ost_staff_dept_access WHERE staff_id=1 AND dept_id=3);
  DELETE FROM ost_department WHERE id IN (1,2);                     -- exclui Suporte e Vendas
  COMMIT;
  ```
  Eventos históricos em `ost_thread_event` (ticket de teste #1) referenciando o dept 1 foram **mantidos** — log imutável; é o comportamento padrão do osTicket ao excluir um departamento.
- **Segurança/reversão:** backup completo do banco **antes** da mudança em `db/backups/pre-remove-depts_20260713_1330.sql` (`mysqldump --single-transaction`). Reverter = restaurar esse dump ou recriar os 2 departamentos e desfazer os `UPDATE` (mas não há motivo — nenhum ticket/rota depende deles).
- **Dependências/impactos:** nenhuma alteração de código. Efeito prático: no painel do agente os seletores de departamento (transferir chamado, criar ticket, filtros) agora mostram **só Manutenção**; e-mails do sistema roteiam para Manutenção.
- **Verificação:** `Dept::getDepartments()` retorna só `[3=Manutenção]`; `default_dept_id=3`; ticket #19 e Tópico #1 resolvem para "Manutenção"; `/login.php` e `/scp/login.php` respondem 200 sem erro fatal.
- **Como reaplicar em versão nova:** conferir os departamentos existentes; reapontar `default_dept_id`, `ost_staff.dept_id`, `ost_email.dept_id` e acessos para o dept de Manutenção **antes** de excluir os demais; validar que nenhum tópico de ajuda aponta para os departamentos removidos.
- **Status:** aplicado e testado.

---

#### 2026-07-13 — E-mails do sistema consolidados em juliano.torres@zkteco.com (remoção de alerts@ e noreply@)

- **Motivo/contexto:** os endereços `alerts@zkteco.com` e `noreply@zkteco.com`, herdados da instalação, **não existem** de fato no domínio — usá-los como identidade do sistema só gera confusão/entregas ruins. Pedido: usar somente `juliano.torres@zkteco.com` (que já é o `email_id=1`, com a conta SMTP/IMAP funcionando).
- **Tipo:** banco de dados.
- **Levantamento:** e-mails do sistema em `ost_email` = `1` juliano.torres@zkteco.com, `2` alerts@zkteco.com, `3` noreply@zkteco.com. Config: `default_email_id=1` (já OK), `alert_email_id=2` (→ precisa virar 1). Varredura das colunas `*email_id*` do schema: nada de produção aponta para 2/3 exceto os próprios registros (o `ost_user.default_email_id=2` é **falso positivo** — referencia `ost_user_email.id`, e-mail de um cliente, não `ost_email`). Os departamentos já haviam sido reapontados para o dept Manutenção na entrada anterior; o dept usa `email_id=0` (= e-mail padrão do sistema).
- **O que foi feito (transação única):**
  ```sql
  START TRANSACTION;
  UPDATE ost_config SET value='1' WHERE namespace='core' AND `key`='alert_email_id'; -- alertas -> id 1
  DELETE FROM ost_email WHERE email_id IN (2,3);                                       -- remove alerts@/noreply@
  COMMIT;
  ```
- **`admin_email` mantido (decisão):** `ost_config.admin_email` = `juliano.zkteco@gmail.com` **não** foi alterado. É o *destinatário* de alertas de administração (não uma identidade de envio). Apontá-lo para `juliano.torres@zkteco.com` é arriscado porque essa caixa tem **IMAP de coleta ativo** no osTicket (`ost_email_account` id 1, mailbox) — alertas enviados para ela seriam **buscados de volta como novos tickets** (loop). Mantido separado de propósito.
- **Segurança/reversão:** backup completo antes em `db/backups/pre-consolidate-emails_20260713_1345.sql`. Reverter = restaurar o dump (recria os 2 e-mails e o `alert_email_id=2`).
- **Dependências/impactos:** nenhuma alteração de código. Todo envio do sistema (respostas, autoresposta, alertas) passa a ter identidade única `juliano.torres@zkteco.com` — coerente com a conta SMTP autenticada (evita também qualquer risco de spoofing).
- **Verificação:** `$cfg->getDefaultEmail()` e `$cfg->getAlertEmail()` retornam `juliano.torres@zkteco.com`; `Email::objects()` lista só o id 1; dept Manutenção resolve para esse e-mail; `/login.php` e `/scp/login.php` 200 sem erro.
- **Como reaplicar em versão nova:** manter um único registro em `ost_email` (o principal, com SMTP); apontar `default_email_id` e `alert_email_id` para ele; não reintroduzir endereços inexistentes; manter `admin_email` num endereço **sem** coleta IMAP.
- **Status:** aplicado e testado.

---

#### 2026-07-13 — BUG corrigido: cliente não recebia e-mail nas atualizações de equipamento (faltava `reply-to`)

- **Motivo/contexto:** ao salvar progresso no painel do agente (mudança de **status** e/ou **laudo** dos equipamentos), a UI promete "o cliente é notificado por e-mail", mas o cliente **não recebia nada**. Não havia erro no log — a resposta aparecia normalmente na thread ("Atualização dos seus equipamentos: …"), só o e-mail não saía. (Sintoma reportado no chamado #105968: V4L → "Aguardando peça", laudo "Falta tela".)
- **Tipo:** core-flow / correção em customização (`include/zk_equipment.php`).
- **Causa raiz (mecânica):** a função `zk_equip_notify_changes()` chamava `$ticket->postReply(array('response'=>$html), $err, true, false)` **sem** a chave `reply-to`. Em `Ticket::postReply` (`include/class.ticket.php:3371`), a primeira coisa é `$recipients = $this->getRecipients($vars['reply-to'], $vars['ccs'])`. Com `reply-to` ausente, `$who` é `null`; em `getRecipients()` (`:960`) o `switch(strtolower($who))` não casa `user/all/collabs` e cai no **`default: return null`**. Mais abaixo, o envio só ocorre dentro do guard `if ($email && $recipients && ($tpl=$dept->getTemplate()) && ($msg=$tpl->getReplyMsgTemplate()))` (`:3442`). Com `$recipients === null`, o bloco é pulado: a resposta é persistida (`addResponse`) mas **`$email->send()` nunca é chamado** → nenhum e-mail e nenhum erro. (Confirmado que os demais fatores estavam OK: dept Manutenção usa o template padrão `id=1`, que tem `ticket.reply`; e-mail do dept = `juliano.torres@zkteco.com`.)
- **O que foi feito:** em `include/zk_equipment.php`, na `zk_equip_notify_changes()`:
  ```diff
  -        $vars = array('response' => $html);
  +        // 'reply-to' => 'all' é OBRIGATÓRIO: sem ele, getRecipients(null)
  +        // retorna null e postReply grava a thread SEM enviar e-mail.
  +        $vars = array('response' => $html, 'reply-to' => 'all');
  ```
  `'all'` = dono do chamado + colaboradores ativos (mesmo comportamento de uma resposta normal do agente). O fallback para nota interna (quando `postReply` falha) foi mantido.
- **Dependências/impactos:** afeta **toda** notificação de evolução/laudo por equipamento (é o caminho único dessas mudanças, via `zk_equip_notify_changes`). O e-mail de **troca de status do CHAMADO** (`zk_notify_status_change`, que usa `$email->send()` direto) não dependia disso e já funcionava.
- **Verificação:** `php -l` OK; em runtime `Ticket::lookup(19)->getRecipients('all')` passou a retornar 1 destinatário (o dono `julianotorres@gmail.com`); chamada real de `zk_equip_notify_changes()` retornou `true` e **enviou o e-mail** (sem nenhum `Error` em `ost_syslog`).
- **Como reaplicar em versão nova:** garantir que qualquer chamada programática a `Ticket::postReply()` inclua `reply-to` (`'all'` ou `'user'`) no `$vars` — caso contrário `getRecipients()` devolve `null` e o e-mail é silenciosamente suprimido. Vale para qualquer automação futura que poste respostas.
- **Status:** aplicado e testado (envio real confirmado).

---

#### 2026-07-13 — Removida a barra de filtro/ação em massa dos equipamentos (painel do agente)

- **Motivo/contexto:** o usuário pediu para remover a barra acima da tabela de equipamentos no painel do agente (`scp/tickets.php?id=N`) — "não faz muito sentido isso mais". A barra tinha o filtro **"Filtrar por modelo/série…"** e a ação em massa **"Com selecionados: [status] + Aplicar"**. Com poucos equipamentos por chamado, deixou de agregar. Confirmado com o usuário remover a **barra inteira** (filtro + ação em massa).
- **Tipo:** CSS-JS / HTML (customização em `include/zk_equipment.php`).
- **Mecânica:** existem **dois** painéis de equipamentos na mesma função: o do **cliente** (`.zk-panel.zk-client`, read-only, tem seu próprio `.zk-search`) e o do **agente** (`#zk-staff-panel`, editável). A mudança foi **só no painel do agente**. A coluna de checkbox (`.zk-c-chk`/`.zk-check`/`.zk-check-all`) existia **exclusivamente** para selecionar linhas da ação em massa — sem ela, virou peso morto e também saiu.
- **O que foi feito (em `include/zk_equipment.php`):**
  - **HTML:** removido o `<div class="zk-bulkbar">` inteiro (input `.zk-search` + `<span class="zk-bulk-group">` com o `<select class="zk-bulk-status">` e o botão `.zk-bulk-apply`); removidos o `<th class="zk-c-chk">` (com o `.zk-check-all`) do cabeçalho e o `<td class="zk-c-chk">` (com o `.zk-check`) de cada linha. O `<thead>` do agente passou de 7 para **6 colunas** (#, Equipamento, Problema relatado, Status, Laudo, Nota interna) — casando com o `<tbody>`.
  - **JS:** removidos os handlers `.zk-check-all` (change), `.zk-bulk-apply` (click) e `.zk-search` (keyup) do bloco do `#zk-staff-panel`. **Mantidos** `ZK_W`/`zkUpdateMini()` (mini-barra de progresso ao vivo no `<select>`), o handler `.zk-status-sel` (change) e o upload de NF.
  - **CSS:** removidas as regras órfãs `.zk-bulkbar`, `.zk-bulk-group`, `.zk-bulk-status` e `.zk-table .zk-c-chk`; a regra compartilhada `.zk-toolbar, .zk-bulkbar {…}` virou só `.zk-toolbar {…}`. **Preservados** `.zk-toolbar` e `.zk-search`, ainda usados pelo painel do cliente.
- **Dependências/impactos:** nenhum efeito no painel do cliente. Estilos são inline (`zk_equip_styles()`), então **não** precisa de cache-buster.
- **Verificação:** `php -l` OK; grep confirma **zero** referências remanescentes a `zk-bulk*`/`zk-check`/`zk-c-chk`/"Filtrar por modelo"/"Com selecionados"; cabeçalho do agente com 6 `<th>`.
- **Reverter:** restaurar o `<div class="zk-bulkbar">`, a coluna de checkbox (th + td), os 3 handlers JS e as regras CSS removidas (ver git/backup do arquivo).
- **Status:** aplicado e testado.

---

#### 2026-07-13 — Barra de ações do chamado enxugada (agente): manter só Imprimir e Engrenagem

- **Motivo/contexto:** o usuário pediu para, na barra superior do chamado (painel do agente, `scp/tickets.php?id=N`), **manter apenas os ícones de Imprimir e Engrenagem** — removendo os demais atalhos, num sistema já dedicado só a manutenção.
- **Tipo:** core (reversível via `if(false)`), em `include/staff/ticket-view.inc.php`.
- **Mecânica:** a barra fica em `<div class="sticky bar"> > .content > .pull-right.flush-right` (~linha 71). Todos os botões são `.action-button pull-right` (flutuam à direita, ordem visual inversa à do DOM). Ícones existentes: Engrenagem/More (`#action-dropdown-more`), Editar (`icon-edit`), Imprimir (`#action-dropdown-print`), Encaminhar (`#ticket-transfer`), Atribuir (`#action-dropdown-assign`, `icon-user`), Responder (`#post-reply`, `icon-mail-reply`), Nota (`#post-note`, `icon-file-text`) e o seletor de Status/bandeira (`TicketStatus::status_options()`).
- **O que foi feito (todos os blocos indesejados desativados com `if (false)` + comentário `ZK:`, deixando o código original intacto e trivialmente reversível):**
  - **Editar:** `if ($role->hasPerm(Ticket::PERM_EDIT))` → `if (false …)` no bloco do `<a … &a=edit>` (só essa ocorrência da barra; as de Manage Forms/Change Owner no dropdown ⚙ foram preservadas).
  - **Encaminhar:** `if ($role->hasPerm(Ticket::PERM_TRANSFER))` → `if (false …)`.
  - **Atribuir/Usuário:** `if ($ticket->isOpen() && $role->hasPerm(Ticket::PERM_ASSIGN))` → `if (false …)` (oculta o botão **e** o `#action-dropdown-assign`).
  - **Responder:** `if ($role->hasPerm(Ticket::PERM_REPLY))` → `if (false && …)` só no atalho `#post-reply` da barra (a **aba** `#reply` permanece).
  - **Nota:** o `<a href="#post-note">` (que era incondicional) envolvido em `<?php if (false) { ?> … <?php } ?>`.
  - **Status/bandeira:** `echo TicketStatus::status_options();` → `if (false) echo TicketStatus::status_options();`.
- **Preservado:** Imprimir (`#action-dropdown-print`) e Engrenagem/More (`#action-dropdown-more`) com seus dropdowns; o rótulo PARENT/CHILD; e **toda a capacidade de responder/anotar**, que vive nas abas `#reply`/`#note` (`#response-tabs`, ~linha 838) — independentes dos atalhos removidos.
- **Impacto em JS:** o handler `$('a.post-response').click(...)` (~linha 1419) apenas ativava a aba correspondente ao clicar no atalho; sem os botões ele não casa com nada (no-op). Sem erros.
- **Verificação:** `php -l` OK; grep confirma que os atalhos ficaram sob `if(false)`; abas de resposta/nota intactas. `opcache.revalidate_freq=0` → reflete no reload (Ctrl+F5), sem cache-buster (é template server-side).
- **Reverter:** trocar cada `if (false …)`/`if (false && …)` de volta pela condição original (ou remover os wrappers `if(false){…}` de Nota e Status).
- **Status:** aplicado e testado.

---

#### 2026-07-13 — Menu ▾ da entrada da thread oculto (Criar Chamado/Criar Tarefa) + histórico da thread recolhido

- **Motivo/contexto:** dois pedidos: (1) remover o menu ▾ que aparece em cada entrada da thread do agente com "Criar Chamado"/"Criar Tarefa" — o chamado é sempre criado pelo cliente; (2) deixar a thread mais limpa: mostrar só a mensagem mais recente e permitir expandir o histórico, tanto no agente quanto no cliente.
- **Tipo:** core (templates de thread, reversível) + JS/CSS (camada ZK).
- **(1) Menu ▾ da entrada (só agente):** em `include/staff/templates/thread-entry.tmpl.php` o bloco que renderiza o dropdown vem de `if ($entry->hasActions())` (ações `getActions()` → "Create Ticket"/"Create Task" de `class.thread_actions.php`). Trocado por `if (false /* ZK */ && $entry->hasActions())` — some o ▾ de todas as entradas. (O template do **cliente** não tem esse menu.)
- **(2) Histórico recolhido (agente + cliente):**
  - **Mecânica:** em ambos os lados cada mensagem é renderizada dentro de `<div id="thread-entry-{id}">` (filho direto do container: `#thread-items` no agente, `#{htmlId}`=`#ticketThread` no cliente). Os **eventos de sistema** são emitidos fora desses wrappers (e já estavam ocultos por CSS), então não entram na conta.
  - **JS (idempotente, roda a cada render inclusive pós-pjax):** função `window.zkThreadCollapse(parent)` que pega `parent.children('[id^="thread-entry-"]')`, mantém a **última** (mais recente) visível, esconde as anteriores (classe `.zk-hist`, `display:none`) e insere no topo um botão `.zk-thread-toggle` "Ver histórico — N anteriores" que alterna a visibilidade. Guardas: `<2` entradas não faz nada; não duplica se já houver `.zk-thread-toggle`. Adicionada no fim de `include/staff/templates/thread-entries.tmpl.php` (chama com `#thread-items`) e de `include/client/templates/thread-entries.tmpl.php` (chama com `#{htmlId}`).
  - **CSS:** regra `.zk-thread-toggle` (pílula verde clicável) em `scp/css/zkteco-scp.css` (agente) e `assets/default/css/theme.css` (cliente, usando `var(--zk-green-dk)`/`var(--zk-border)`). Cache-busters bumpados para `?zk20260713a` nos respectivos headers.
- **Dependências/impactos:** os templates `thread-entries.tmpl.php` são compartilhados por outros threads (ex.: tarefas); o efeito de recolher se aplica a qualquer thread renderizada com ≥2 entradas — comportamento desejado (limpeza), sem perda de dados. Só apresentação.
- **Verificação:** `php -l` OK nos 5 arquivos; CSS `.zk-thread-toggle` confirmado servido pelo container no agente (`/scp/css/zkteco-scp.css?zk20260713a`) e no cliente (`/assets/default/css/theme.css?zk20260713a`). Confirmação visual pelo usuário ao recarregar (Ctrl+F5).
- **Reverter:** (1) voltar `if (false && $entry->hasActions())` para `if ($entry->hasActions())`; (2) remover os 2 blocos `<script>` ZK dos `thread-entries.tmpl.php` e as regras `.zk-thread-toggle` das 2 folhas.
- **Status:** aplicado; confirmação estética final com o usuário.

---

#### 2026-07-13 — Aviso "Marcado em atraso!" movido para o topo (agente)

- **Motivo/contexto:** o banner de aviso do chamado (ex.: **"Marcado em atraso!"**) era renderizado **no fim** da página, logo antes do formulário de resposta — o agente mal via. Pedido: colocar no topo.
- **Tipo:** core (`include/staff/ticket-view.inc.php`).
- **Mecânica:** a string `$warn` é montada no início do arquivo (linhas ~33-64) e reúne vários avisos: status fechado que impede resposta do cliente, chamado atribuído a outro agente/equipe, e `if ($ticket->isOverdue()) $warn .= '… Marked overdue! …'`. Era exibida num `<div id="msg_warning">` num bloco no fim (`elseif($warn)`) que dividia espaço com a reflexão de erro de formulário para a aba de resposta.
- **O que foi feito:**
  - **Exibição movida para o topo:** logo após o `<div class="clear tixTitle …"><h3>assunto</h3></div>`, inserido `<?php if ($warn && !($errors['err'] && isset($_POST['a']))) { ?><div id="msg_warning"><?php echo $warn; ?></div><?php } ?>`. A guarda replica o comportamento original (não mostra o aviso quando há erro de formulário sendo refletido). `$warn` já está 100% montado nesse ponto.
  - **Bloco do fim:** mantida **apenas** a reflexão de erro (`if ($errors['err'] && isset($_POST['a'])) { $errors[$_POST['a']] = $errors['err']; }`); removido o `elseif($warn){ <div id=msg_warning> }`.
- **Dependências/impactos:** o CSS do banner (`#msg_warning`, amarelo) já existe em `scp/css/zkteco-scp.css` — nada a mudar no estilo, sem cache-buster (template server-side). O `<span id="msg_warning">` do diálogo de confirmação "marcar em atraso" (~linha 1358) é pré-existente e sem relação; a duplicação de id já existia antes (era 837 + 1351). Único JS que cita `#msg_warning` é um `fadeOut` no diálogo de user-lookup (outra tela) — sem impacto.
- **Verificação:** `php -l` OK; `id="msg_warning"` de exibição agora aparece no topo (após o assunto). Confirmação visual pelo usuário ao recarregar.
- **Reverter:** remover o bloco do topo e recolocar `elseif($warn){ <div id="msg_warning">… }` no bloco do fim.
- **Status:** aplicado; confirmação visual final com o usuário.

---

#### 2026-07-13 — Filtro inteligente de equipamentos reintroduzido no painel do agente (igual ao do cliente)

- **Motivo/contexto:** o campo de busca de equipamentos tinha sido removido do painel do agente junto com a barra de ação em massa (entrada anterior). O usuário notou que o **mesmo filtro existe no painel do cliente e é bom**, e pediu para trazê-lo de volta ao agente — só o filtro, sem a ação em massa.
- **Tipo:** HTML + JS (customização em `include/zk_equipment.php`).
- **O que foi feito (espelhando o painel do cliente):**
  - **HTML:** entre o `<input type=hidden name=tid>` e o `.zk-table-wrap` do `#zk-staff-panel`, inserido `<div class="zk-toolbar"><input type="text" class="zk-search" placeholder="Buscar por modelo ou nº de série..."></div>` — idêntico ao do cliente.
  - **JS:** no bloco do `#zk-staff-panel`, adicionado o handler `keyup` (mesmo do cliente): filtra `$p.find('tbody tr.zk-row')` por `indexOf` do texto da linha em minúsculas — "inteligente" porque busca em **qualquer** coluna (modelo, nº série, problema relatado, status, laudo, nota interna).
- **Dependências/impactos:** o handler é escopado a `#zk-staff-panel`, sem conflito com o filtro do cliente (`.zk-panel.zk-client`). As classes CSS `.zk-toolbar`/`.zk-search` já existiam (foram preservadas quando a barra saiu). **Não** reintroduz checkbox nem "Com selecionados/Aplicar".
- **Verificação:** `php -l` OK; confirmado que as linhas do agente têm `.zk-row` (tabela `.zk-table.zk-edit`) e que o CSS `.zk-search`/`.zk-toolbar` está presente. Sem cache-buster (JS inline + CSS existente; `opcache.revalidate_freq=0`).
- **Reverter:** remover o `<div class="zk-toolbar">` do `#zk-staff-panel` e o handler `.zk-search` do bloco JS do agente.
- **Status:** aplicado e testado.

---

#### 2026-07-13 — Aba "Publicar Nota Interna" removida (agente)

- **Motivo/contexto:** o usuário pediu para remover a aba **"Publicar Nota Interna"** da área de resposta do chamado (agente). O fluxo de manutenção usa a nota interna por equipamento na grade; a nota interna geral do chamado não é usada.
- **Tipo:** core (`include/staff/ticket-view.inc.php`), reversível via `if(false)`.
- **Mecânica:** em `#response-tabs` (~linha 850) há duas abas — "Post Reply" (`#post-reply-tab`, form `#reply`, `a=reply`) e "Post Internal Note" (`#post-note-tab`, form `#note`, `a=postnote`). Ambas guardadas por `if (!($blockReply))`.
- **O que foi feito:** desativados, com `if (false /* ZK */ && !($blockReply))`, **dois** blocos: (1) o `<li>` da aba `#post-note-tab` (~linha 858) e (2) o `<form id="note">` (~linha 1192). Assim some tanto o botão da aba quanto o formulário no DOM. A aba "Publicar Resposta" (com `class="active"`) permanece como única e ativa.
- **Dependências/impactos:** nenhuma no fluxo de resposta ao cliente. O atalho de nota no topo (`#post-note`) já havia sido ocultado antes; agora o `#note` também não é renderizado. Sem impacto de JS (as abas restantes funcionam; seletores ausentes são no-op).
- **Verificação:** `php -l` OK; aba e form confirmados sob `if(false)`. Sem cache-buster (template server-side, `opcache.revalidate_freq=0`).
- **Reverter:** trocar os dois `if (false && !($blockReply))` de volta por `if (!($blockReply))`.
- **Status:** aplicado e testado.

---

#### 2026-07-13 — Card de ATRASO redesenhado (texto "ATRASADO!" + visual moderno/chamativo)

- **Motivo/contexto:** o aviso de atraso era o texto "Marcado em atraso!" dentro do banner amarelo genérico (`#msg_warning`). Pedido: trocar para **"ATRASADO!"** e deixar o card mais chamativo e moderno.
- **Tipo:** core (`include/staff/ticket-view.inc.php`) + CSS (`scp/css/zkteco-scp.css`).
- **O que foi feito:**
  - **Saiu do `$warn`:** removida a linha `if($ticket->isOverdue()) $warn.='… Marked overdue! …'` (~linha 63) — o atraso não é mais um `<span>` no banner amarelo genérico (que segue cuidando de atribuição/status).
  - **Card dedicado no topo:** logo após o assunto, quando `$ticket->isOverdue()`, renderiza `<div class="zk-overdue-card">` com ícone `icon-warning-sign` num círculo, título **"ATRASADO!"** (`__('ATRASADO!')`) e subtítulo com a data de vencimento (`Format::datetime($ticket->getEstDueDate())`): "Este chamado passou do prazo de atendimento — vencia em %s.".
  - **CSS moderno:** `.zk-overdue-card` = gradiente vermelho-claro (`#fff5f5→#ffe7e7`), borda + filete lateral `#e0402f`, cantos arredondados e sombra; `.zk-overdue-ico` = círculo vermelho com **animação de pulso** (`@keyframes zkOverduePulse`, box-shadow expandindo); `.zk-overdue-title` uppercase bold `#c0392b`; `.zk-overdue-sub` menor. Cache-buster `?zk20260713a` → `?zk20260713b`.
- **Dependências/impactos:** só apresentação. Não afeta a lógica de SLA/overdue nem os demais avisos. `icon-warning-sign` é do font-icon já usado no SCP.
- **Verificação:** `php -l` OK; CSS servido pelo container confirmado (contém `.zk-overdue-card` e `zkOverduePulse` em `?zk20260713b`); "Marked overdue" removido do `$warn`.
- **Reverter:** remover o bloco `.zk-overdue-card` do topo e o CSS; recolocar a linha `if($ticket->isOverdue()) $warn.=…` (com o texto desejado).
- **Status:** aplicado; confirmação visual final com o usuário.

---

#### 2026-07-13 — Listagem do cliente: coluna "Departamento" trocada por "Prazo (SLA)"

- **Motivo/contexto:** na lista de chamados do cliente (`tickets.php`), a coluna **Departamento** mostrava sempre "Manutenção" (sistema é exclusivo de manutenção) — sem valor. Pedido: remover e colocar o **tempo de SLA**.
- **Tipo:** core (`include/client/tickets.inc.php`) + CSS (`assets/default/css/theme.css`).
- **O que foi feito:**
  - **Query:** adicionados `duedate`, `est_duedate`, `isoverdue` ao `$tickets->values(...)` (para não carregar cada `Ticket` objeto por linha).
  - **Cabeçalho:** o `<th>` "Department" (com link de sort) virou um rótulo simples **"Prazo (SLA)"**.
  - **Célula:** removida a montagem de `$dept`; a célula agora mostra o **vencimento** = `duedate` (manual) `?:` `est_duedate` (calculado pelo SLA, grace de 18h), via `Format::date()`, com ícone de relógio. Selo vermelho **"Atrasado"** (`.zk-sla-tag-late`) quando `status__state='open'` **e** `isoverdue` — usa a flag autoritativa do osTicket (evita comparar datas com fuso na mão). Sem vencimento → "—".
  - **CSS:** `.zk-sla`/`.zk-sla-date`/`.zk-sla-late`/`.zk-sla-tag-late` em `theme.css`; cache-buster `?zk20260713a` → `?zk20260713b`.
- **Dependências/impactos:** o número de colunas (7) não mudou — `colspan` do "sem resultados" segue válido. O mapa de sort ainda tem `'dept'` (inofensivo). `$defaultDept` ficou sem uso (inofensivo).
- **Verificação:** `php -l` OK; grep confirma que não há mais `$dept` referenciado; CSS `.zk-sla-tag-late` servido em `?zk20260713b`.
- **Reverter:** recolocar o `<th>` de Department e a célula `<td>$dept</td>` (com a montagem de `$dept`); remover os 3 campos do `values()` e o CSS `.zk-sla*`.
- **Status:** aplicado; confirmação visual final com o usuário.

---

#### 2026-07-13 — Card ATRASADO reage na hora ao salvar a Data de Vencimento (fim do F5 manual)

- **Motivo/contexto:** ao mudar a Data de Vencimento e salvar, o card "ATRASADO!" não aparecia/sumia — só depois de recarregar o navegador. Causa: `Ticket::isOverdue()` só lê a flag `ost_ticket.isoverdue` (`return $this->ht['isoverdue'];`), e essa flag era atualizada **apenas pelo cron/monitor de SLA**, não no momento do save. Além disso, o edit da data é **inline via ajax** (`#tickets/{id}/field/duedate/edit`), que atualiza só o campo — o card (renderizado no servidor) não.
- **Tipo:** core (`include/ajax.tickets.php` + `include/staff/ticket-view.inc.php`).
- **O que foi feito (dois lados):**
  - **Servidor** (`ajax.tickets.php::editField`): logo após `updateField()` bem-sucedido, quando `$fid === 'duedate'`, recalcula o atraso na hora: `$due = getDueDate() ?: getEstDueDate()`; se o chamado está **aberto e vencido** (`Misc::db2gmtime($due) < Misc::gmtime()`) → `markOverdue(false)` (o `false` não dispara e-mail de alerta); senão → `clearOverdue(true)`. Assim a flag `isoverdue` fica correta imediatamente.
  - **Client** (`ticket-view.inc.php`): `MutationObserver` no `#field_duedate` — quando o valor do campo troca (após o save inline), `disconnect()` + `window.location.reload()`. A view recarrega e o card reflete a flag já recalculada. Sem loop (desconecta antes; no reload o campo não muda).
- **Dependências/impactos:** vale para a edição inline da Data de Vencimento no painel do agente. Não altera a lógica de SLA/cron (que continua funcionando como rede de segurança).
- **Verificação:** `php -l` OK nos 2 arquivos; métodos `getDueDate`/`getEstDueDate`/`markOverdue`/`clearOverdue`/`isOpen` confirmados; sem cache-buster (template + JS inline).
- **Reverter:** remover o bloco `if ($fid === 'duedate' …)` do `editField` e o `<script>` do `MutationObserver` no ticket-view.
- **Status:** aplicado; confirmação final com o usuário.

---

#### 2026-08-17 — Design system Carbon (IBM) + novo ciclo de 11 status de manutenção

- **Arquivo(s) alterado(s):** `include/zk_equipment.php` (array de status + CSS embutido `.zk-badge` + 2 atributos inline), `include/client/tickets.inc.php` (1 atributo inline, badge de pendência), `assets/default/css/theme.css` (tokens `:root`), `scp/css/zkteco-scp.css` (novo bloco `:root`, antes inexistente), `include/client/header.inc.php` + `include/staff/header.inc.php` + `include/staff/login.header.php` (cache-buster).
- **Tipo:** módulo próprio (`zk_equipment.php`, imune a upgrade) + skin CSS (`theme.css`/`zkteco-scp.css`) + core tocado só no cache-buster (`header.inc.php`/`login.header.php`) + core reescrito (`tickets.inc.php`, já tocado antes).
- **Motivo/contexto:** pedido do usuário para adotar uma linguagem visual inspirada no **Carbon Design System (IBM)** ("ar mais técnico/industrial"), usando as 4 cores de marca (`#7AC143` primária, `#474B4F` secundária, `#649E37` realce, `#555555` texto), com as **tags de status** baseadas num print de referência (11 estados, cores Gray/Cyan/Blue/Purple/Yellow/Green/Red).
- **Ciclo de status substituído** (era 8 chaves, agora 11 — fonte única em `zk_equip_statuses()`, `zk_equipment.php`):
  ```diff
  - 'recebido'        => Aguardando            (peso 0,   cinza)
  - 'em_analise'      => Em análise            (peso 25,  grafite)
  - 'aguardando_peca' => Aguardando peça       (peso 45,  laranja)
  - 'em_reparo'       => Em reparo             (peso 70,  azul)
  - 'reparado'        => Reparado              (peso 100, verde, done)
  - 'substituido'     => Substituído (RMA)     (peso 100, verde, done)
  - 'sem_reparo'      => Sem reparo / Inviável (peso 100, vermelho, done)
  - 'enviado'         => Enviado ao cliente    (peso 100, verde, done)
  + 'aguardando_envio'   => Aguardando envio   (peso 0,   tag cinza)
  + 'em_transporte'      => Em transporte      (peso 10,  tag ciano)
  + 'recebido'           => Recebido           (peso 20,  tag azul)      -- MESMA CHAVE, significado mudou
  + 'em_diagnostico'     => Em diagnóstico     (peso 35,  tag roxo)
  + 'aguardando_cliente' => Aguardando cliente (peso 40,  tag amarelo)
  + 'aguardando_peca'    => Aguardando peça    (peso 45,  tag amarelo)   -- chave igual, cor mudou
  + 'em_manutencao'      => Em manutenção      (peso 65,  tag roxo)
  + 'em_testes'          => Em testes          (peso 85,  tag ciano)
  + 'concluido'          => Concluído          (peso 100, tag verde, done)
  + 'bloqueado'          => Bloqueado          (peso 50,  tag vermelho)
  + 'cancelado'          => Cancelado          (peso 100, tag cinza, done)
  ```
  `zk_equip_default_status()`: `'recebido'` → `'aguardando_envio'` (equipamento nasce "aguardando o cliente enviar", não mais "recebido" — mais fiel ao fluxo real).
- **Cor por token, não hex fixo:** cada status guarda `'color' => 'var(--zk-tag-x)'` em vez de hex literal — funciona nos 3 consumos existentes (atributo `style` inline, `<div>` da barra de progresso, mapa JS `ZK_W`), e centraliza o tom real no CSS. Novos tokens em `:root` (theme.css **e** zkteco-scp.css, que não tinha `:root` nenhum até agora):
  ```css
  --zk-tag-gray:var(--zk-graphite); --zk-tag-green:var(--zk-green-dk);
  --zk-tag-blue:#0043ce; --zk-tag-cyan:#007d79; --zk-tag-purple:#6929c4;
  --zk-tag-yellow:#8a6d00; --zk-tag-red:#da1e28;
  ```
  2 cores reaproveitam a marca (cinza=grafite, verde=realce — mesmo precedente do array antigo); as outras 5 são o "palette de suporte" que a marca sozinha não cobre (mesmo princípio do Carbon: cor de marca + cores de status separadas).
- **Tag `.zk-badge` redesenhada (estilo Carbon "pill" clara):** trocou preenchimento sólido (fundo colorido + texto branco) por fundo clarinho + texto colorido + borda fina, tudo derivado de **uma única variável** `--badge-c` via `color-mix()` (sem fallback de navegador antigo — mesma política já usada neste projeto para `:has()`, ambiente é sempre navegador atual). Precisou trocar o atributo inline de `style="background:..."` para `style="--badge-c:..."` em **3 lugares** (não só no badge de status): `zk_equipment.php` (badge de status + badge de pendência, mesma classe `.zk-badge`) e `tickets.inc.php` (badge de pendência na lista de chamados) — os 3 usam a mesma classe/contrato agora.
- **Tokens adicionais:** `--zk-radius:0px` (Carbon é reto, exceto tags que ficam em pílula) aplicado a `.blue.button`/`.green.button`/`.sidebar .content` (client) — aplicação pontual/representativa, não em todo botão/painel (ex.: o botão-CTA com gradiente do "guia de próximos passos" foi mantido como está, pois reto + gradiente/sombra conflita visualmente). `:focus-visible{outline:2px solid var(--zk-green-dk)}` genérico nos dois lados.
- **Fonte:** decidido **não** importar IBM Plex Sans via Google Fonts — `theme.css:1301` já documenta uma decisão anterior de "sem CDN/fontes externas"; manter `--zk-stack` (system font stack) evita reverter essa decisão em silêncio.
- **`#ticketTable th` / `.infoTable`:** avaliados e **não alterados** — já estão neutros hoje (a entrada de 2026-07-01 que registra fundo verde-claro ficou desatualizada por uma reforma posterior; não há "verde" pra reverter).
- **Migração de dados (após backup `backups/backup_pre_status_redesign_*.sql`):**
  ```sql
  -- ost_zk_equipment.status (5 linhas 'recebido', 1 'reparado' na migração real)
  UPDATE ost_zk_equipment SET status='aguardando_envio' WHERE status='recebido';
  UPDATE ost_zk_equipment SET status='concluido'        WHERE status='reparado';
  UPDATE ost_zk_equipment SET status='concluido'        WHERE status='substituido';
  UPDATE ost_zk_equipment SET status='cancelado'        WHERE status='sem_reparo';
  UPDATE ost_zk_equipment SET status='concluido'        WHERE status='enviado';
  -- ost_zk_equipment_event (histórico from_status/to_status) — mesmo mapeamento,
  -- incluindo 'em_analise'->'em_diagnostico' e 'em_reparo'->'em_manutencao'
  -- (achados no histórico embora não estivessem nos dados "atuais"); tabela sem
  -- leitor ativo no código hoje, migrada por integridade/defensivo mesmo assim.
  ALTER TABLE ost_zk_equipment ALTER COLUMN status SET DEFAULT 'aguardando_envio';
  ```
- **Cache-buster:** `theme.css`/`zkteco-scp.css` de `?zk20260713b`/`?zk20260703b` → `?zk20260817a` nos 3 pontos de carregamento.
- **Dependências/impactos:** `ost_ticket_status` (status de TICKET, tabela core, separado) **não foi tocado** — alguns nomes coincidem ("Recebido", "Em manutenção") mas são sistemas diferentes. `zk_equip_pendencias()` (flags administrativas tipo "Sem nota fiscal") manteve chaves/labels/cores inalteradas, só herdou o novo visual de `.zk-badge`.
- **Como reaplicar em versão nova:** copiar `zk_equip_statuses()`/`zk_equip_default_status()` inteiros, o bloco `:root` de tokens (os dois arquivos CSS) e o CSS `.zk-badge` novo; reaplicar a troca de atributo `background:`→`--badge-c:` nos 3 pontos; rodar a migração SQL se houver dados antigos com as chaves descontinuadas.
- **Verificação feita:** `php -l` OK em todos os arquivos tocados; `SELECT status, COUNT(*) FROM ost_zk_equipment/…_event GROUP BY …` confirmou zero chaves antigas restantes; login real como cliente (`julianotorres@gmail.com`) e como equipe (`manutencao.teste`) no chamado #105968 confirmando os 11 status no `<select>` do agente, a tag nova renderizada (`--badge-c:var(--zk-tag-gray)`, condizente com "Aguardando envio" pós-migração) e o mapa JS `ZK_W` com as 11 chaves/pesos/cores corretos.
- **Status:** aplicado e testado (via requisições HTTP autenticadas; validação visual num navegador real ainda recomendada antes de considerar 100% concluído).

---

## Pendências / próximos passos para a página do cliente

- [ ] Trocar favicon (`images/favicon.png`, `images/oscar-favicon-16x16.png`, `images/oscar-favicon-32x32.png`) por versão ZKTeco.
- [ ] Avaliar personalizar textos da página inicial (`include/client/open.inc.php`, landing page) e da Central de Ajuda/FAQ.
- [ ] Confirmar visualmente no navegador (pendente — sem acesso a browser automatizado no momento deste registro) e ajustar contraste/tons se necessário.
- [x] ~~Repetir o mesmo processo de identidade visual no Painel da Equipe (`scp/`), que usa tema próprio em `scp/css/`.~~ **Feito em 2026-07-03** — skin `scp/css/zkteco-scp.css` (ver entrada no Registro detalhado).

---

### [Modelo de entrada — copiar para cada nova customização]

#### AAAA-MM-DD — Título curto da mudança

- **Arquivo(s) alterado(s):** `caminho/relativo/ao/arquivo.php`
- **Tipo:** core / plugin / config / banco de dados / template (.tpl) / CSS-JS
- **Motivo/contexto:** por que a mudança foi necessária (regra de negócio, bug, pedido de área, etc.)
- **O que foi feito:**
  ```diff
  - código antigo
  + código novo
  ```
- **Dependências/impactos:** outros arquivos ou tabelas afetados
- **Como reaplicar em versão nova:** passo a passo ou observação (ex.: "verificar se a função X ainda existe com a mesma assinatura")
- **Status:** pendente de reaplicação na próxima versão

---

## Histórico de versões do osTicket já usadas

| Versão osTicket | Data da instalação/upgrade | Observações |
|---|---|---|
| _(preencher)_ | | |

---

## Notas gerais / pendências

- (vazio por enquanto)
