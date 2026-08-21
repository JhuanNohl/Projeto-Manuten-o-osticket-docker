<?php
/*********************************************************************
    zk-equip-edit.php  —  ZKTeco / edição de equipamentos pelo cliente

    CUSTOMIZAÇÃO ZKTeco (não faz parte do core do osTicket). Ponto de
    entrada independente (não altera tickets.php nem open.php) que
    reaproveita a mesma grade de equipamentos usada na abertura do
    chamado, agora pré-preenchida com os itens já cadastrados, para o
    cliente corrigir uma informação, anexar uma foto esquecida ou
    adicionar um equipamento que faltou.

    Documentado em: OneDrive .../Manutenção/V3/CUSTOMIZACOES_OSTICKET.md
**********************************************************************/
require('client.inc.php');

if (!is_object($thisclient) || !$thisclient->isValid())
    Http::redirect('login.php');

$tid    = isset($_REQUEST['id']) ? (int) $_REQUEST['id'] : 0;
$ticket = $tid ? Ticket::lookup($tid) : null;

if (!$ticket || !zk_equip_client_can_edit($ticket)) {
    Http::redirect('tickets.php'.($tid ? '?id='.$tid : ''));
    exit;
}

$msg = $errors = null;
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    // "Confirmar envio" — o cliente declara que o produto foi despachado.
    // Vem do MESMO form do envio (botão com name próprio), então salva
    // eventuais ajustes de transportadora/rastreio primeiro e confirma em
    // seguida — por isso este bloco vem ANTES do zk_envio_save simples.
    if (!empty($_POST['zk_envio_confirm'])) {
        $err = zk_save_ticket_envio($tid,
            isset($_POST['zk_transportadora']) ? $_POST['zk_transportadora'] : '',
            isset($_POST['zk_rastreio']) ? $_POST['zk_rastreio'] : '');
        if ($err === null && zk_confirm_ticket_envio($tid) === null) {
            try {
                $ticket->logNote(__('Envio do produto confirmado'),
                    __('O solicitante confirmou que o produto foi enviado: ')
                        .zk_ticket_envio_resumo($tid),
                    (string) $thisclient->getName());
            } catch (Throwable $e) { /* não bloqueia a confirmação */ }
        }
        Http::redirect('tickets.php?id='.$ticket->getId());
        exit;
    }

    // Ação isolada "Envio do produto" — transportadora + rastreio, vindos
    // da barra de envio no painel do chamado. Form próprio, mesmo padrão
    // das ações de NF abaixo.
    if (!empty($_POST['zk_envio_save'])) {
        $before = zk_ticket_envio($tid);
        $err = zk_save_ticket_envio($tid,
            isset($_POST['zk_transportadora']) ? $_POST['zk_transportadora'] : '',
            isset($_POST['zk_rastreio']) ? $_POST['zk_rastreio'] : '');
        if ($err === null && $before != zk_ticket_envio($tid)) {
            try {
                $ticket->logNote(__('Envio do produto informado'),
                    __('O solicitante informou o envio do produto: ')
                        .zk_ticket_envio_resumo($tid),
                    (string) $thisclient->getName());
            } catch (Throwable $e) { /* não bloqueia o salvamento */ }
        }
        Http::redirect('tickets.php?id='.$ticket->getId());
        exit;
    }

    // Ação isolada "Apagar Nota Fiscal" — form próprio, separado do form
    // grande de equipamentos, pra não misturar com edição de linhas.
    if (!empty($_POST['zk_ticket_nf_delete'])) {
        if (zk_delete_ticket_nf($tid)) {
            try {
                $ticket->logNote(__('Nota Fiscal removida'),
                    __('O solicitante removeu a Nota Fiscal anexada ao chamado.'),
                    (string) $thisclient->getName());
            } catch (Throwable $e) { /* não bloqueia a remoção */ }
        }
        // zk_back_ticket=1: ação veio da lixeira no PAINEL do chamado —
        // volta pra lá (a tela de editar equipamentos segue voltando pra si).
        Http::redirect((!empty($_POST['zk_back_ticket'])
            ? 'tickets.php?id=' : 'zk-equip-edit.php?id=').$ticket->getId());
        exit;
    }

    // Declaração de Conteúdo (cliente final sem NF) — anexar, vindo do
    // guia do painel do chamado. O upload substitui a anterior; a
    // pendência ressincroniza sozinha (zk_save_ticket_dc).
    if (!empty($_FILES['zk_ticket_dc']['name'])) {
        if (zk_save_ticket_dc($tid)) {
            try {
                $ticket->logNote(__('Declaração de Conteúdo anexada'),
                    __('O solicitante anexou a Declaração de Conteúdo (cliente final, sem Nota Fiscal) — o envio deste chamado é obrigatoriamente pelos CORREIOS.'),
                    (string) $thisclient->getName());
            } catch (Throwable $e) { /* não bloqueia o anexo */ }
        }
        Http::redirect('tickets.php?id='.$ticket->getId());
        exit;
    }

    // ... e remover (lixeira na barra da Declaração, no painel).
    if (!empty($_POST['zk_ticket_dc_delete'])) {
        if (zk_delete_ticket_dc($tid)) {
            try {
                $ticket->logNote(__('Declaração de Conteúdo removida'),
                    __('O solicitante removeu a Declaração de Conteúdo do chamado.'),
                    (string) $thisclient->getName());
            } catch (Throwable $e) { /* não bloqueia a remoção */ }
        }
        Http::redirect('tickets.php?id='.$ticket->getId());
        exit;
    }

    // Ação isolada "Verificar XML" — também form próprio (pode vir tanto
    // desta tela quanto do painel de visualização do chamado). Depois de
    // verificar, volta pra tela do chamado (é lá que a Pendência/erros
    // resultantes aparecem, junto com o resto do contexto do chamado).
    if (!empty($_POST['zk_ticket_nf_verify'])) {
        if (zk_verify_ticket_nf($tid)) {
            $errList = zk_ticket_nf_error_list($tid);
            try {
                $note = $errList
                    ? sprintf(__("XML da Nota Fiscal verificado — %d erro(s) encontrado(s):\n%s"), count($errList), implode("\n", $errList))
                    : __('XML da Nota Fiscal verificado — sem erros.');
                $ticket->logNote(__('Nota Fiscal verificada'), $note, (string) $thisclient->getName());
            } catch (Throwable $e) { /* não bloqueia a verificação */ }
        }
        Http::redirect('tickets.php?id='.$ticket->getId());
        exit;
    }

    list($updated, $created, $changes) = zk_equip_client_process_edit($ticket);
    if ($updated || $created) {
        $parts = array();
        if ($changes)  $parts[] = implode("\n\n", $changes);
        if ($created)  $parts[] = sprintf(__('%d equipamento(s) adicionado(s)'), $created);
        if (!$parts)   $parts[] = sprintf(__('%d atualizado(s)'), $updated);
        try {
            $ticket->logNote(__('Equipamentos editados pelo solicitante'),
                implode("\n\n", $parts), (string) $thisclient->getName());
        } catch (Throwable $e) { /* não bloqueia o salvamento */ }
    }
    Http::redirect('tickets.php?id='.$ticket->getId());
    exit;
}

$nav->setActiveNav('tickets');
require(CLIENTINC_DIR.'header.inc.php');
require(CLIENTINC_DIR.'zk-equip-edit.inc.php');
require(CLIENTINC_DIR.'footer.inc.php');
