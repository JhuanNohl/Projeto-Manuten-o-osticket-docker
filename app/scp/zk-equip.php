<?php
/*********************************************************************
    scp/zk-equip.php  —  ZKTeco / salvar progresso dos equipamentos

    CUSTOMIZAÇÃO ZKTeco (não faz parte do core). Recebe o POST do painel
    do agente (zk_equipment_staff_panel) e atualiza status / laudo / nota
    interna de cada equipamento, gravando eventos (timeline) e uma
    nota-resumo no chamado.

    Segurança: require('staff.inc.php') garante login do agente E valida
    CSRF automaticamente para POST. Ainda checamos checkStaffPerm no ticket.
**********************************************************************/
require('staff.inc.php');   // define $thisstaff, $ost; valida CSRF em POST

$tid    = isset($_POST['tid']) ? (int) $_POST['tid'] : 0;
$ticket = $tid ? Ticket::lookup($tid) : null;

if (!$ticket || !$thisstaff || !$thisstaff->isStaff() || !$ticket->checkStaffPerm($thisstaff)) {
    Http::response(403, __('Access Denied'));
    exit;
}

if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    Http::redirect(ROOT_PATH.'scp/tickets.php?id='.$tid);
    exit;
}

// Ação isolada "Anexar Nota Fiscal" — ícone de anexo rápido no painel,
// só aparece quando o chamado ainda não tem NF nenhuma. Form próprio,
// só com tid + o arquivo (sem os arrays de status/laudo/nota).
if (!empty($_FILES['zk_ticket_nf'])) {
    if (zk_save_ticket_nf($tid)) {
        try {
            $ticket->logNote(__('Nota Fiscal anexada'),
                __('O agente anexou uma Nota Fiscal ao chamado.'), $thisstaff);
        } catch (Exception $e) { /* não bloqueia o upload */ }
    }
    Http::redirect(ROOT_PATH.'scp/tickets.php?id='.$tid);
    exit;
}

// Ação isolada "Verificar XML" — o agente também pode disparar a
// verificação (form próprio no painel, só com tid + esta flag, sem os
// arrays de status/laudo/nota do form principal).
if (!empty($_POST['zk_ticket_nf_verify'])) {
    if (zk_verify_ticket_nf($tid)) {
        $errList = zk_ticket_nf_error_list($tid);
        try {
            $note = $errList
                ? sprintf(__("XML da Nota Fiscal verificado — %d erro(s) encontrado(s):\n%s"), count($errList), implode("\n", $errList))
                : __('XML da Nota Fiscal verificado — sem erros.');
            $ticket->logNote(__('Nota Fiscal verificada'), $note, $thisstaff);
        } catch (Exception $e) { /* não bloqueia a verificação */ }
    }
    Http::redirect(ROOT_PATH.'scp/tickets.php?id='.$tid);
    exit;
}

$valid      = zk_equip_statuses();
$validPend  = zk_equip_pendencias();
$statuses   = (isset($_POST['status'])    && is_array($_POST['status']))    ? $_POST['status']    : array();
$pendencias = (isset($_POST['pendencia']) && is_array($_POST['pendencia'])) ? $_POST['pendencia'] : array();
$laudos     = (isset($_POST['laudo'])     && is_array($_POST['laudo']))     ? $_POST['laudo']     : array();
$notas      = (isset($_POST['nota'])      && is_array($_POST['nota']))      ? $_POST['nota']      : array();

$sid       = (int) $thisstaff->getId();
$saved     = 0;          // quantas linhas salvas
$mudancas  = array();    // linhas HTML da resposta consolidada ao cliente

foreach ($statuses as $id => $newStatus) {
    $id = (int) $id;
    if ($id <= 0 || !isset($valid[$newStatus]))
        continue;

    // Carrega o item garantindo que pertence a ESTE ticket (status e
    // laudo atuais servem pra detectar o que de fato mudou).
    $res = db_query('SELECT id, status, laudo, modelo, numero_serie FROM '.zk_equip_table()
                   .' WHERE id='.db_input($id).' AND ticket_id='.db_input($tid));
    if (!$res || !($cur = db_fetch_array($res)))
        continue;

    $oldStatus = $cur['status'];
    $oldLaudo  = trim((string) $cur['laudo']);
    $laudo = isset($laudos[$id]) ? trim((string) $laudos[$id]) : '';
    $nota  = isset($notas[$id])  ? trim((string) $notas[$id])  : '';
    $rotulo = trim((string) $cur['modelo'])
        .($cur['numero_serie'] !== '' ? ' (S/N '.trim((string) $cur['numero_serie']).')' : '');

    // Pendência: '' (nenhuma) é um valor válido — só ignora se vier um
    // valor desconhecido/inválido (mantém o que já estava gravado).
    $newPend = isset($pendencias[$id]) ? (string) $pendencias[$id] : null;
    $pendSql = '';
    if ($newPend !== null && ($newPend === '' || isset($validPend[$newPend])))
        $pendSql = ', pendencia='.db_input($newPend);

    db_query('UPDATE '.zk_equip_table().' SET '
            .'  status='.db_input($newStatus)
            . $pendSql
            .', laudo='.db_input(mb_substr($laudo, 0, 4000))
            .', nota_interna='.db_input(mb_substr($nota, 0, 4000))
            .', staff_id='.db_input($sid)
            .', updated=NOW()'
            .' WHERE id='.db_input($id).' AND ticket_id='.db_input($tid));
    $saved++;

    if ($oldStatus !== $newStatus) {
        db_query('INSERT INTO '.zk_equip_event_table().' SET '
                .'  equipment_id='.db_input($id)
                .', ticket_id='.db_input($tid)
                .', from_status='.db_input($oldStatus)
                .', to_status='.db_input($newStatus)
                .', staff_id='.db_input($sid)
                .', created=NOW()');
        $mudancas[] = '<b>'.Format::htmlchars($rotulo).'</b>: status atualizado para <b>'
            .Format::htmlchars(zk_equip_status_label($newStatus)).'</b>';
    }

    // Laudo técnico alterado -> entra na história com o texto completo
    // (é a informação que o cliente mais espera).
    if ($laudo !== $oldLaudo && $laudo !== '') {
        $mudancas[] = '<b>'.Format::htmlchars($rotulo).'</b> — laudo técnico:<br />'
            .'<em>'.nl2br(Format::htmlchars($laudo)).'</em>';
    }
}

// UMA resposta consolidada na thread (história visível pro cliente no
// cartão Mensagens) — o postReply dispara o e-mail com o template da
// marca sozinho. Sem mudanças reais, nada é postado (salvar nota
// interna ou re-salvar igual não notifica ninguém).
if ($mudancas)
    zk_equip_notify_changes($ticket, $mudancas);

// Todos os equipamentos concluídos (ou cancelados) -> chamado vira
// "Resolvido" automaticamente. Antes disso o progresso do chamado
// chegava a 100% mas o status ficava parado na etapa anterior (ex.:
// "Enviado"), já que nada aqui tocava no status do TICKET, só dos
// equipamentos. zk_ticket_set_status_resolvido() é idempotente e não
// faz nada se já tiver algum equipamento pendente ou o chamado já
// estiver fechado — troca de status dispara o e-mail ao cliente sozinha
// (gancho já existente no fim de Ticket::setStatus()).
if ($saved)
    zk_ticket_set_status_resolvido($ticket);

Http::redirect(ROOT_PATH.'scp/tickets.php?id='.$tid);
