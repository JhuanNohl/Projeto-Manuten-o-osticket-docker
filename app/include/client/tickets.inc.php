<?php
if(!defined('OSTCLIENTINC') || !is_object($thisclient) || !$thisclient->isValid()) die('Access Denied');

$settings = &$_SESSION['client:Q'];

// Unpack search, filter, and sort requests
if (isset($_REQUEST['clear']))
    $settings = array();
if (isset($_REQUEST['keywords'])) {
    $settings['keywords'] = $_REQUEST['keywords'];
}
if (isset($_REQUEST['status'])) {
    $settings['status'] = $_REQUEST['status'];
}

$org_tickets = $thisclient->canSeeOrgTickets();
if ($settings['keywords']) {
    // Don't show stat counts for searches
    $openTickets = $closedTickets = -1;
}
else {
    $openTickets = $thisclient->getNumOpenTickets($org_tickets);
    $closedTickets = $thisclient->getNumClosedTickets($org_tickets);
}

$tickets = Ticket::objects();

$qs = array();
$status=null;

$sortOptions=array('id'=>'number', 'subject'=>'cdata__subject',
                    'status'=>'status__name', 'dept'=>'dept__name','date'=>'created');
$orderWays=array('DESC'=>'-','ASC'=>'');
//Sorting options...
$order_by=$order=null;
$sort=($_REQUEST['sort'] && $sortOptions[strtolower($_REQUEST['sort'])])?strtolower($_REQUEST['sort']):'date';
if($sort && $sortOptions[$sort])
    $order_by =$sortOptions[$sort];

$order_by=$order_by ?: $sortOptions['date'];
if ($_REQUEST['order'] && !is_null($orderWays[strtoupper($_REQUEST['order'])]))
    $order = $orderWays[strtoupper($_REQUEST['order'])];
else
    $order = $orderWays['DESC'];

$x=$sort.'_sort';
$$x=' class="'.strtolower($_REQUEST['order'] ?: 'desc').'" ';

$basic_filter = Ticket::objects();

if ($settings['status'])
    $status = strtolower($settings['status']);
    switch ($status) {
    default:
        $status = 'open';
    case 'open':
    case 'closed':
		$results_type = ($status == 'closed') ? __('Closed Tickets') : __('Open Tickets');
        $basic_filter->filter(array('status__state' => $status));
        break;
}

// Add visibility constraints — use a union query to use multiple indexes,
// use UNION without "ALL" (false as second parameter to union()) to imply
// unique values
$visibility = $basic_filter->copy()
    ->values_flat('ticket_id')
    ->filter(array('user_id' => $thisclient->getId()));

// Add visibility of Tickets where the User is a Collaborator if enabled
if ($cfg->collaboratorTicketsVisibility())
    $visibility = $visibility
    ->union($basic_filter->copy()
        ->values_flat('ticket_id')
        ->filter(array('thread__collaborators__user_id' => $thisclient->getId()))
    , false);

if ($thisclient->canSeeOrgTickets()) {
    $visibility = $visibility->union(
        $basic_filter->copy()->values_flat('ticket_id')
            ->filter(array('user__org_id' => $thisclient->getOrgId()))
    , false);
}

// ZK-EQUIP: busca inteligente. Em vez de escolher UMA estratégia (nº do
// chamado OU texto completo), combina todas as fontes relevantes — nº do
// chamado, texto completo (assunto + mensagens da thread, via engine nativo
// do osTicket) e os campos dos equipamentos (modelo, nº de série, resumo,
// detalhamento, observação, laudo — tabela própria, fora do índice nativo)
// — e une os resultados, para achar o chamado por qualquer conteúdo.
if ($settings['keywords']) {
    $q = trim($settings['keywords']);
    $matchSets = array();

    if (is_numeric($q)) {
        $matchSets[] = Ticket::objects()
            ->filter(array('number__startswith' => $q))
            ->values_flat('ticket_id');
    }
    if (strlen($q) > 2) {
        $matchSets[] = $ost->searcher
            ->find($q, Ticket::objects(), false, array('boolean' => false))
            ->values_flat('ticket_id');
    }
    if (function_exists('zk_equip_matching_ticket_ids')
            && ($eqIds = zk_equip_matching_ticket_ids($q))) {
        $matchSets[] = Ticket::objects()
            ->filter(array('ticket_id__in' => $eqIds))
            ->values_flat('ticket_id');
    }

    if ($matchSets) {
        $matched = array_shift($matchSets);
        foreach ($matchSets as $s)
            $matched = $matched->union($s, false);
        $tickets->filter(array('ticket_id__in' => $matched));
    }
    else {
        // Nenhuma fonte bateu (ex.: 1-2 letras sem equipamento correspondente)
        $tickets->filter(array('ticket_id' => 0));
    }
}

$tickets->distinct('ticket_id');

TicketForm::ensureDynamicDataView();

$total=$visibility->count();
$page=($_GET['p'] && is_numeric($_GET['p']))?$_GET['p']:1;
$pageNav=new Pagenate($total, $page, PAGE_LIMIT);
$qstr = '&amp;'. Http::build_query($qs);
$qs += array('sort' => $_REQUEST['sort'], 'order' => $_REQUEST['order']);
$pageNav->setURL('tickets.php', $qs);
$tickets->filter(array('ticket_id__in' => $visibility));
$pageNav->paginate($tickets);

$showing =$total ? $pageNav->showing() : "";
if(!$results_type)
{
	$results_type=ucfirst($status).' '.__('Tickets');
}
$showing.=($status)?(' '.$results_type):' '.__('All Tickets');
if($search)
    $showing=__('Search Results').": $showing";

$negorder=$order=='-'?'ASC':'DESC'; //Negate the sorting

$tickets->order_by($order.$order_by);
$tickets->values(
    'ticket_id', 'number', 'created', 'isanswered', 'source', 'status_id',
    'status__state', 'status__name', 'cdata__subject', 'dept_id',
    'dept__name', 'dept__ispublic', 'user__default_email__address', 'user_id',
    'duedate', 'est_duedate', 'isoverdue' // ZK: prazo de SLA na listagem
);

if (function_exists('zk_equip_styles')) zk_equip_styles();
?>
<div class="zk-panel zk-tickets">
  <div class="zk-panel-head">
    <h3 class="zk-panel-title">
      <a href="<?php echo Http::refresh_url(); ?>" title="<?php echo __('Reload'); ?>"><i class="refresh icon-refresh"></i></a>
      <?php echo __('Tickets'); ?>
    </h3>
    <div class="zk-tickets-states">
<?php if ($openTickets) { ?>
    <a class="zk-state <?php if ($status == 'open') echo 'zk-state-active'; ?>"
        href="?<?php echo Http::build_query(array('a' => 'search', 'status' => 'open')); ?>">
    <i class="icon-file-alt"></i> <?php echo __('Open'); if ($openTickets > 0) echo sprintf(' (%d)', $openTickets); ?>
    </a>
<?php }
if ($closedTickets) { ?>
    <a class="zk-state <?php if ($status == 'closed') echo 'zk-state-active'; ?>"
        href="?<?php echo Http::build_query(array('a' => 'search', 'status' => 'closed')); ?>">
    <i class="icon-file-text"></i> <?php echo __('Closed'); if ($closedTickets > 0) echo sprintf(' (%d)', $closedTickets); ?>
    </a>
<?php } ?>
    </div>
  </div>

  <form action="tickets.php" method="get" id="ticketSearchForm" class="zk-toolbar">
    <input type="hidden" name="a" value="search">
    <input type="text" name="keywords" class="zk-search" placeholder="<?php echo __('Buscar por qualquer conteúdo do chamado (assunto, mensagens, modelo, nº de série, resumo...)'); ?>" value="<?php echo Format::htmlchars($settings['keywords']); ?>">
    <button type="submit" class="button zk-btn"><?php echo __('Buscar'); ?></button>
<?php if ($settings['keywords'] || $_REQUEST['sort']) { ?>
    <a href="?clear" class="zk-clear-link"><i class="icon-remove-circle"></i> <?php echo __('Limpar busca e ordenação'); ?></a>
<?php } ?>
  </form>

  <div class="zk-table-wrap">
  <table class="zk-table" id="ticketTable">
    <caption><?php echo $showing; ?></caption>
    <thead>
        <tr>
            <th nowrap>
                <a href="tickets.php?sort=ID&order=<?php echo $negorder; ?><?php echo $qstr; ?>" title="<?php echo sprintf('%s %s', __('Sort By'), __('Ticket ID')); ?>"><?php echo __('Ticket #');?>&nbsp;<i class="icon-sort"></i></a>
            </th>
            <th width="120">
                <a href="tickets.php?sort=date&order=<?php echo $negorder; ?><?php echo $qstr; ?>" title="<?php echo sprintf('%s %s', __('Sort By'), __('Date')); ?>"><?php echo __('Create Date');?>&nbsp;<i class="icon-sort"></i></a>
            </th>
            <th width="150"><?php /* ZK: 100->150 — cabia só status curto; "Em manutenção" quebrava linha */ ?>
                <a href="tickets.php?sort=status&order=<?php echo $negorder; ?><?php echo $qstr; ?>" title="<?php echo sprintf('%s %s', __('Sort By'), __('Status')); ?>"><?php echo __('Status');?>&nbsp;<i class="icon-sort"></i></a>
            </th>
            <th>
                <a href="tickets.php?sort=subject&order=<?php echo $negorder; ?><?php echo $qstr; ?>" title="<?php echo sprintf('%s %s', __('Sort By'), __('Subject')); ?>"><?php echo __('Subject');?>&nbsp;<i class="icon-sort"></i></a>
            </th>
            <th width="140"><?php echo __('Progresso'); ?></th>
            <th width="160"><?php /* ZK: coluna "Departamento" trocada por "Prazo (SLA)" — sistema é só de manutenção, dept era sempre o mesmo. */ echo __('Prazo (SLA)'); ?></th>
            <th width="160"><?php echo __('Pendência'); ?></th>
        </tr>
    </thead>
    <tbody>
    <?php
     $subject_field = TicketForm::objects()->one()->getField('subject');
     $defaultDept=Dept::getDefaultDeptName(); //Default public dept.
     // ZK-EQUIP: pendências e contagens de equipamentos de todos os tickets
     // desta página, em 2 consultas (em vez de 1-2 consultas por linha).
     $zk_pend_map = array();
     $zk_count_map = array();
     $zk_ticket_rows = array();
     if ($tickets->exists(true)) {
         foreach ($tickets as $T) $zk_ticket_rows[] = $T;
         if ($zk_ticket_rows) {
             $zk_ids = array();
             foreach ($zk_ticket_rows as $T) $zk_ids[] = $T['ticket_id'];
             if (function_exists('zk_equip_pendencias_for_tickets'))
                 $zk_pend_map = zk_equip_pendencias_for_tickets($zk_ids);
             if (function_exists('zk_equip_counts_for_tickets'))
                 $zk_count_map = zk_equip_counts_for_tickets($zk_ids);
         }
     }
     if ($zk_ticket_rows) {
         foreach ($zk_ticket_rows as $T) {
            $subject = $subject_field->display(
                $subject_field->to_php($T['cdata__subject']) ?: $T['cdata__subject']
            );
            $status = TicketStatus::getLocalById($T['status_id'], 'value', $T['status__name']);
            if (false) // XXX: Reimplement attachment count support
                $subject.='  &nbsp;&nbsp;<span class="Icon file"></span>';

            $ticketNumber=$T['number'];
            if($T['isanswered'] && !strcasecmp($T['status__state'], 'open')) {
                $subject="<b>$subject</b>";
                $ticketNumber="<b>$ticketNumber</b>";
            }
            $thisclient->getId() != $T['user_id'] ? $isCollab = true : $isCollab = false;
            ?>
            <tr id="<?php echo $T['ticket_id']; ?>" class="zk-row zk-row-link" data-href="tickets.php?id=<?php echo $T['ticket_id']; ?>">
                <td>
                <?php /* ZK: ícone de "ticket" do Font Awesome no lugar do
                         PNG por origem (webTicket/emailTicket) do core */ ?>
                <a class="zk-ticket-num" title="<?php echo $T['user__default_email__address']; ?>"
                    href="tickets.php?id=<?php echo $T['ticket_id']; ?>"><i class="icon-ticket"></i> <?php echo $ticketNumber; ?></a>
                </td>
                <td><?php echo Format::date($T['created']); ?></td>
                <td><?php
                    /* ZK: status como selo colorido — mesma paleta e classe
                       (.zk-ti-status) da tela do chamado */
                    $__stColors = array('open'=>'#7AC143','resolved'=>'#649E37',
                        'closed'=>'#9aa0a6','archived'=>'#9aa0a6','deleted'=>'#c0392b');
                    $__stc = strtolower((string) $T['status__state']);
                    echo '<span class="zk-ti-status" style="background:'
                        .(isset($__stColors[$__stc]) ? $__stColors[$__stc] : '#474B4F').'">'
                        .$status.'</span>';
                    /* "Recebido" = produto na ZKTeco: daqui em diante o
                       acompanhamento fino é POR EQUIPAMENTO — aponta o
                       caminho pro cliente. */
                    if (!strcasecmp((string) $T['status__name'], 'Recebido')
                            && !empty($zk_count_map[$T['ticket_id']])) {
                        echo '<div class="zk-sub zk-muted" style="margin-top:4px">'
                            .__('abra para ver o status por item').'</div>';
                    }
                ?></td>
                <td>
                  <?php /* ZK: title = tooltip com o assunto completo quando
                           a coluna precisar cortar com "…" */
                    $__subjFull = Format::htmlchars((string) $T['cdata__subject']);
                  if ($isCollab) {?>
                    <div class="zk-issue-line" title="<?php echo $__subjFull; ?>"><i class="icon-group"></i> <?php echo $subject; ?></div>
                  <?php } else {?>
                    <div class="zk-issue-line" title="<?php echo $__subjFull; ?>"><?php echo $subject; ?></div>
                    <?php } ?>
                <?php /* ZK: sub-linha com o resumo dos equipamentos do
                         chamado (total + concluídos) — o assunto vira o
                         "título" e esta linha dá a dimensão real. */
                if (!empty($zk_count_map[$T['ticket_id']])) {
                    $__zc = $zk_count_map[$T['ticket_id']];
                    $__done = ($__zc['done'] >= $__zc['total'] && $__zc['total'] > 0); ?>
                    <div class="zk-sub <?php echo $__done ? 'zk-equip-done' : 'zk-muted'; ?>">
                        <i class="<?php echo $__done ? 'icon-ok-sign' : 'icon-wrench'; ?>"></i>
                        <?php echo $__zc['total'].' '.($__zc['total'] == 1 ? 'equipamento' : 'equipamentos'); ?>
                        &middot; <?php echo $__zc['done'].' '.($__zc['done'] == 1 ? 'concluído' : 'concluídos'); ?>
                    </div>
                <?php } ?>
                </td>
                <td>
                <?php /* ZK: coluna Progresso — % ponderado dos equipamentos
                         (média das etapas; ver zk_equip_statuses). */
                if (!empty($zk_count_map[$T['ticket_id']])) {
                    $__zp = (int) $zk_count_map[$T['ticket_id']]['pct'];
                    echo '<div class="zk-lp"><span class="zk-lp-bar"><span style="width:'.$__zp.'%"></span></span>'
                       . '<span class="zk-lp-pct">'.$__zp.'%</span></div>';
                } else {
                    echo '<span class="zk-muted">—</span>';
                }
                ?>
                </td>
                <td><?php
                /* ZK: Prazo (SLA) — data de vencimento (duedate manual ou
                   est_duedate calculado pelo SLA). Selo "Atrasado" (vermelho)
                   quando o chamado está aberto e vencido (flag isoverdue). */
                $__due = $T['duedate'] ?: $T['est_duedate'];
                $__open = !strcasecmp((string) $T['status__state'], 'open');
                if (!$__due) {
                    echo '<span class="zk-muted">—</span>';
                } else {
                    $__late = ($__open && $T['isoverdue']);
                    echo '<div class="zk-sla'.($__late ? ' zk-sla-late' : '').'">'
                       . '<span class="zk-sla-date"><i class="icon-time"></i> '.Format::date($__due).'</span>';
                    if ($__late)
                        echo '<span class="zk-sla-tag zk-sla-tag-late">'.__('Atrasado').'</span>';
                    echo '</div>';
                }
                ?></td>
                <td>
                <?php
                if (!empty($zk_pend_map[$T['ticket_id']]) && function_exists('zk_equip_pendencia_label')) {
                    foreach (array_keys($zk_pend_map[$T['ticket_id']]) as $pendKey) {
                        echo '<span class="zk-badge zk-badge-pend" style="--badge-c:'.zk_equip_pendencia_color($pendKey).'">'
                            .Format::htmlchars(zk_equip_pendencia_label($pendKey)).'</span> ';
                    }
                } else {
                    echo '<span class="zk-muted">—</span>';
                }
                ?>
                </td>
            </tr>
        <?php
        }

     } else {
         echo '<tr><td colspan="7">'.__('Your query did not match any records').'</td></tr>';
     }
    ?>
    </tbody>
  </table>
  </div>
<?php
if ($total) {
    echo '<div class="zk-pagination">&nbsp;'.__('Page').':'.$pageNav->getPageLinks().'&nbsp;</div>';
}
?>
</div>
<script type="text/javascript">
(function($){
  $(function(){
    // ZK-EQUIP: linha inteira clicável (melhor usabilidade que só o número).
    $('#ticketTable tbody tr.zk-row-link').on('click', function(e){
      if ($(e.target).closest('a').length) return; // preserva o link/ícone nativo (ctrl/meio-clique etc.)
      var href = $(this).data('href');
      if (href) window.location.href = href;
    });
  });
})(jQuery);
</script>
