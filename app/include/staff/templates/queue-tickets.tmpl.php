<?php
// Calling convention (assumed global scope):
// $tickets - <QuerySet> with all columns and annotations necessary to
//      render the full page


// Impose visibility constraints
// ------------------------------------------------------------
//filter if limited visibility or if unlimited visibility and in a queue
$ignoreVisibility = $queue->ignoreVisibilityConstraints($thisstaff);
if (!$ignoreVisibility || //limited visibility
   ($ignoreVisibility && ($queue->isAQueue() || $queue->isASubQueue())) //unlimited visibility + not a search
)
    $tickets->filter($thisstaff->getTicketsVisibility());

// do not show children tickets unless agent is doing a search
if ($queue->isAQueue() || $queue->isASubQueue())
    $tickets->filter(Q::any(
            array('ticket_pid' => null, 'flags__hasbit' => TICKET::FLAG_LINKED)));

// Make sure the cdata materialized view is available
TicketForm::ensureDynamicDataView();

// Identify columns of output
$columns = $queue->getColumns();

// Figure out REFRESH url — which might not be accurate after posting a
// response
// Remove some variables from query string.
$qsFilter = ['id'];
if (isset($_REQUEST['a']) && ($_REQUEST['a'] !== 'search'))
    $qsFilter[] = 'a';
$refresh_url = Http::refresh_url($qsFilter);

// Establish the selected or default sorting mechanism
if (isset($_GET['sort']) && is_numeric($_GET['sort'])) {
    $sort = $_SESSION['sort'][$queue->getId()] = array(
        'col' => (int) $_GET['sort'],
        'dir' => (int) $_GET['dir'],
    );
}
elseif (isset($_GET['sort'])
    // Drop the leading `qs-`
    && (strpos($_GET['sort'], 'qs-') === 0)
    && ($sort_id = substr($_GET['sort'], 3))
    && is_numeric($sort_id)
    && ($sort = QueueSort::lookup($sort_id))
) {
    $sort = $_SESSION['sort'][$queue->getId()] = array(
        'queuesort' => $sort,
        'dir' => (int) $_GET['dir'],
    );
}
elseif (isset($_SESSION['sort'][$queue->getId()])) {
    $sort = $_SESSION['sort'][$queue->getId()];
}
elseif ($queue_sort = $queue->getDefaultSort()) {
    $sort = $_SESSION['sort'][$queue->getId()] = array(
        'queuesort' => $queue_sort,
        'dir' => (int) $_GET['dir'] ?? 0,
    );
}

// Handle current sorting preferences

$sorted = false;
foreach ($columns as $C) {
    // Sort by this column ?
    if (isset($sort['col']) && $sort['col'] == $C->id) {
        $tickets = $C->applySort($tickets, $sort['dir']);
        $sorted = true;
    }
}

// Apply queue sort if it's not already sorted by a column
if (!$sorted) {
    // Apply queue sort-dropdown selected preference
    if (isset($sort['queuesort']))
        $sort['queuesort']->applySort($tickets, $sort['dir']);
    else // otherwise sort by created DESC
        $tickets->order_by('-created');
}

// Apply pagination

$page = (isset($_GET['p']) && is_numeric($_GET['p']))?$_GET['p']:1;
$pageNav = new Pagenate(PHP_INT_MAX, $page, PAGE_LIMIT);
$tickets = $pageNav->paginateSimple($tickets);

if (isset($tickets->extra['tables'])) {
    // Creative twist here. Create a new query copying the query criteria, sort, limit,
    // and offset. Then join this new query to the $tickets query and clear the
    // criteria, sort, limit, and offset from the outer query.
    $criteria = clone $tickets;
    $criteria->limit(500);
    $criteria->annotations = $criteria->related = $criteria->aggregated =
        $criteria->annotations = $criteria->ordering = [];
    $tickets->constraints = $tickets->extra = [];
    $criteria->extra(array('select' => array('relevance' => 'Z1.relevance')));
    $tickets = $tickets->filter(['ticket_id__in' =>
            $criteria->values_flat('ticket_id')]);
    $tickets->order_by(new SqlCode('relevance'), QuerySet::DESC);
    # Index hint should be used on the $criteria query only
    $tickets->clearOption(QuerySet::OPT_INDEX_HINT);
}

$tickets->distinct('ticket_id');
$Q = $queue->getBasicQuery();

if ($Q->constraints) {
    if (count($Q->constraints) > 1) {
        foreach ($Q->constraints as $value) {
            if (!$value->constraints)
                $empty = true;
        }
    }
}

if (($Q->extra && isset($Q->extra['tables'])) || !$Q->constraints || $empty) {
    $skipCount = true;
    $count = '-';
}

$count = $count ?? $queue->getCount($thisstaff);
$pageNav->setTotal($count, true);
$pageNav->setURL('tickets.php', $args);
?>

<!-- SEARCH FORM START -->
<div id='basic_search'>
  <div class="pull-right" style="height:25px">
    <span class="valign-helper"></span>
    <?php
    require 'queue-quickfilter.tmpl.php';
    if ($queue->getSortOptions())
        require 'queue-sort.tmpl.php';
    ?>
  </div>
    <?php
    // ZK: filtro ativo (busca simples OU filtro avançado) — usado pro botão
    // "Limpar filtro" abaixo, que agora fica sempre visível na barra de
    // busca em vez de só dentro do painel avançado (que precisa estar
    // aberto pra aparecer). Também corrige o link que já existia lá
    // dentro: ele apontava pra "tickets.php" sem id, então "limpar" jogava
    // pra fila padrão em vez de voltar pra fila atual (ex.: Finalizados).
    $zk_search_a = $_GET['a'] ?? '';
    $zk_filter_active = ($zk_search_a === 'zksearch')
        || ($zk_search_a === 'search' && trim($_GET['query'] ?? '') !== '');
    $zk_clear_url = 'tickets.php?id=' . $queue->getId();
    ?>
    <?php /* ZK: form da busca + link "Filtro avançado" lado a lado
       (.zk-search-row) — antes o link vinha DEPOIS do </form>, e como
       <form> é um elemento de bloco, o link (inline) sempre quebrava pra
       uma segunda linha embaixo da busca. */ ?>
    <div class="zk-search-row">
    <form action="tickets.php" method="get" onsubmit="javascript:
  $.pjax({
    url:$(this).attr('action') + '?' + $(this).serialize(),
    container:'#pjax-container',
    timeout: 2000
  });
return false;">
    <input type="hidden" name="a" value="search">
    <input type="hidden" name="search-type" value=""/>
    <div class="attached input">
      <input type="text" class="basic-search" data-url="ajax.php/tickets/lookup" name="query"
        autofocus size="30" value="<?php echo Format::htmlchars($_REQUEST['query'] ?? null, true); ?>"
        autocomplete="off" autocorrect="off" autocapitalize="off">
      <button type="submit" class="attached button"><i class="icon-search"></i>
      </button>
    </div>
    </form>
    <a href="#" class="zk-advfilter-toggle<?php echo ($zk_search_a === 'zksearch') ? ' active open' : ''; ?>"
        onclick="$('#zk-advfilter').toggle(150);$(this).toggleClass('open');return false;"
        ><i class="icon-sliders"></i> <?php echo __('Filtro avançado'); ?>
        <i class="icon-chevron-down zk-advfilter-caret"></i></a>
    <?php if ($zk_filter_active) { ?>
    <a href="<?php echo $zk_clear_url; ?>" class="zk-clear-filter"
        onclick="javascript:$.pjax({url:'<?php echo $zk_clear_url; ?>',container:'#pjax-container',timeout:2000});return false;"
        ><i class="icon-remove"></i> <?php echo __('Limpar filtro'); ?></a>
    <?php } ?>
    </div>
</div>
<!-- SEARCH FORM END -->

<?php /* ============ ZK: FILTRO AVANÇADO INLINE ============
   Painel que substitui o popup "Pesquisa Avançada". GET (pjax) -> zksearch. */
$zk_on = ($zk_search_a === 'zksearch');
$zk_g  = function ($k) { return Format::htmlchars($_GET[$k] ?? '', true); };
$zk_sel = function ($k, $v) { return (($_GET[$k] ?? '') == $v) ? ' selected' : ''; };
$zk_statuses = TicketStatusList::getStatuses(array('states' => array('open', 'closed')));
$zk_depts    = Dept::getDepartments();
$zk_topics   = Topic::getHelpTopics();
$zk_agents   = Staff::getStaffMembers();
$zk_slas     = SLA::getSLAs(array('nameOnly' => true));
$zk_states   = array('open' => __('Open'), 'closed' => __('Closed'));
?>
<div id="zk-advfilter" class="zk-advfilter"<?php echo $zk_on ? '' : ' style="display:none"'; ?>>
  <form action="tickets.php" method="get" onsubmit="javascript:
    $.pjax({url:$(this).attr('action')+'?'+$(this).serialize(),container:'#pjax-container',timeout:2000});
    return false;">
    <input type="hidden" name="a" value="zksearch">
    <div class="zk-advfilter-grid">
      <label class="zk-advfilter-field zk-advfilter-kw">
        <span><?php echo __('Palavra-chave'); ?></span>
        <input type="text" name="zk_q" value="<?php echo $zk_g('zk_q'); ?>"
            placeholder="<?php echo __('Assunto, mensagem, nº de série...'); ?>"
            autocomplete="off">
      </label>
      <label class="zk-advfilter-field">
        <span><?php echo __('Status'); ?></span>
        <select name="zk_status">
          <option value="">— <?php echo __('Qualquer'); ?> —</option>
<?php /* ZK: "Encerrado" fora do filtro (2026-08-21) — "Resolvido" já é o
   status final de encerramento/conclusão neste fluxo; manter os dois
   só duplicava a opção e confundia o colaborador. O status em si
   continua existindo (tickets antigos não são afetados). */
foreach ($zk_statuses as $s) { if (!$s->isEnabled() || $s->getName() === 'Encerrado') continue;
        echo sprintf('<option value="%d"%s>%s</option>', $s->getId(),
                $zk_sel('zk_status', $s->getId()), Format::htmlchars(__($s->getName()))); } ?>
        </select>
      </label>
      <label class="zk-advfilter-field">
        <span><?php echo __('Estado'); ?></span>
        <select name="zk_state">
          <option value="">— <?php echo __('Qualquer'); ?> —</option>
<?php foreach ($zk_states as $k => $v)
        echo sprintf('<option value="%s"%s>%s</option>', $k, $zk_sel('zk_state', $k), Format::htmlchars($v)); ?>
        </select>
      </label>
      <label class="zk-advfilter-field">
        <span><?php echo __('Departamento'); ?></span>
        <select name="zk_dept">
          <option value="">— <?php echo __('Qualquer'); ?> —</option>
<?php foreach ($zk_depts as $id => $n)
        echo sprintf('<option value="%d"%s>%s</option>', $id, $zk_sel('zk_dept', $id), Format::htmlchars($n)); ?>
        </select>
      </label>
      <label class="zk-advfilter-field">
        <span><?php echo __('Designado'); ?></span>
        <select name="zk_assignee">
          <option value="">— <?php echo __('Qualquer'); ?> —</option>
<?php foreach ($zk_agents as $id => $n)
        echo sprintf('<option value="%d"%s>%s</option>', $id, $zk_sel('zk_assignee', $id), Format::htmlchars((string) $n)); ?>
        </select>
      </label>
      <label class="zk-advfilter-field">
        <span><?php echo __('Tópico de ajuda'); ?></span>
        <select name="zk_topic">
          <option value="">— <?php echo __('Qualquer'); ?> —</option>
<?php foreach ($zk_topics as $id => $n)
        echo sprintf('<option value="%d"%s>%s</option>', $id, $zk_sel('zk_topic', $id), Format::htmlchars($n)); ?>
        </select>
      </label>
      <label class="zk-advfilter-field">
        <span><?php echo __('Plano de SLA'); ?></span>
        <select name="zk_sla">
          <option value="">— <?php echo __('Qualquer'); ?> —</option>
<?php foreach ($zk_slas as $id => $n)
        echo sprintf('<option value="%d"%s>%s</option>', $id, $zk_sel('zk_sla', $id), Format::htmlchars($n)); ?>
        </select>
      </label>
      <label class="zk-advfilter-field">
        <span><?php echo __('Criado de'); ?></span>
        <input type="date" name="zk_created_from" value="<?php echo $zk_g('zk_created_from'); ?>">
      </label>
      <label class="zk-advfilter-field">
        <span><?php echo __('Criado até'); ?></span>
        <input type="date" name="zk_created_to" value="<?php echo $zk_g('zk_created_to'); ?>">
      </label>
      <label class="zk-advfilter-field">
        <span><?php echo __('Vence de'); ?></span>
        <input type="date" name="zk_due_from" value="<?php echo $zk_g('zk_due_from'); ?>">
      </label>
      <label class="zk-advfilter-field">
        <span><?php echo __('Vence até'); ?></span>
        <input type="date" name="zk_due_to" value="<?php echo $zk_g('zk_due_to'); ?>">
      </label>
    </div>
    <div class="zk-advfilter-actions">
      <a class="zk-advfilter-clear" href="<?php echo $zk_clear_url; ?>"
        onclick="javascript:$.pjax({url:'<?php echo $zk_clear_url; ?>',container:'#pjax-container',timeout:2000});return false;"
        ><i class="icon-remove"></i> <?php echo __('Limpar filtro'); ?></a>
      <button type="submit" class="zk-advfilter-apply"><i class="icon-search"></i> <?php echo __('Filtrar'); ?></button>
    </div>
  </form>
</div>
<!-- ZK ADVFILTER END -->

<div class="clear"></div>
<div style="margin-bottom:20px; padding-top:5px;">
    <div class="sticky bar opaque">
        <div class="content">
            <div class="pull-left flush-left">
                <h2><a href="<?php echo $refresh_url; ?>"
                    title="<?php echo __('Refresh'); ?>"><i class="icon-refresh"></i> <?php echo
                    $queue->getName(); ?></a>
                    <?php
                    if (($crit=$queue->getSupplementalCriteria()))
                        echo sprintf('<i class="icon-filter"
                                data-placement="bottom" data-toggle="tooltip"
                                title="%s"></i>&nbsp;',
                                Format::htmlchars($queue->describeCriteria($crit)));
                    ?>
                </h2>
            </div>
            <div class="configureQ">
                <i class="icon-cog"></i>
                <div class="noclick-dropdown anchor-left">
                    <ul>
                        <li>
                            <a class="no-pjax" href="#"
                              data-dialog="ajax.php/tickets/search/<?php echo
                              urlencode($queue->getId()); ?>"><i
                            class="icon-fixed-width icon-pencil"></i>
                            <?php echo __('Edit'); ?></a>
                        </li>
                        <li>
                            <a class="no-pjax" href="#"
                              data-dialog="ajax.php/tickets/search/create?pid=<?php
                              echo $queue->getId(); ?>"><i
                            class="icon-fixed-width icon-plus-sign"></i>
                            <?php echo __('Add Sub Queue'); ?></a>
                        </li>
<?php

if ($queue->id > 0 && $queue->isOwner($thisstaff)) { ?>
                        <li class="danger">
                            <a class="no-pjax confirm-action" href="#"
                                data-dialog="ajax.php/queue/<?php
                                echo $queue->id; ?>/delete"><i
                            class="icon-fixed-width icon-trash"></i>
                            <?php echo __('Delete'); ?></a>
                        </li>
<?php } ?>
                    </ul>
                </div>
            </div>

          <div class="pull-right flush-right zk-bulkbar" id="zk-bulkbar">
            <a href="#" class="zk-bulkbar-clear" id="zk-bulkbar-clear"
                title="<?php echo __('Clear selection'); ?>"><i class="icon-remove"></i></a>
            <span class="zk-bulkbar-count" id="zk-bulkbar-count"></span>
            <?php
            // TODO: Respect queue root and corresponding actions
            if ($count) {
                Ticket::agentActions($thisstaff, array('status' => $status ?? null));
            }?>
            </div>
        </div>
    </div>
</div>
<div class="clear"></div>

<form action="?" method="POST" name='tickets' id="tickets">
<?php csrf_token(); ?>
 <input type="hidden" name="a" value="mass_process" >
 <input type="hidden" name="do" id="action" value="" >

<table class="list queue tickets" border="0" cellspacing="1" cellpadding="2" width="940">
  <thead>
    <tr>
<?php
$canManageTickets = $thisstaff->canManageTickets();
if ($canManageTickets) { ?>
        <th style="width:32px" class="zk-ckb-col">
          <input type="checkbox" id="zk-select-all"
              aria-label="<?php echo __('Select All'); ?>">
        </th>
<?php
}

foreach ($columns as $C) {
    $heading = Format::htmlchars($C->getLocalHeading());
    if ($C->isSortable()) {
        $args = $_GET;
        $dir = $sort['col'] != $C->id ?: ($sort['dir'] ? 'desc' : 'asc');
        $args['dir'] = $sort['col'] != $C->id ?: (int) !$sort['dir'];
        $args['sort'] = $C->id;
        $heading = sprintf('<a href="?%s" class="%s">%s</a>',
            Http::build_query($args), $dir, $heading);
    }
    echo sprintf('<th width="%s" data-id="%d">%s</th>',
        $C->getWidth(), $C->id, $heading);
}
?>
    </tr>
  </thead>
  <tbody>
<?php
foreach ($tickets as $T) {
    echo '<tr>';
    if ($canManageTickets) { ?>
        <td><input type="checkbox" class="ckb" name="tids[]"
            value="<?php echo $T['ticket_id']; ?>" /></td>
<?php
    }
    foreach ($columns as $C) {
        list($contents, $styles) = $C->render($T);
        if ($style = $styles ? 'style="'.$styles.'"' : '') {
            echo "<td $style><div $style>$contents</div></td>";
        }
        else {
            echo "<td>$contents</td>";
        }
    }
    echo '</tr>';
}
?>
  </tbody>
  <tfoot>
    <tr>
      <td colspan="<?php echo count($columns)+1; ?>">
        <?php if ($count && $canManageTickets) { ?>
        <?php /* ZK: escondido via CSS (.zk-legacy-select) — o checkbox
           "selecionar tudo" no cabeçalho da tabela já cobre Todos/Nenhum
           (ver script no fim deste arquivo). Os links continuam no DOM
           porque aquele script dispara clique neles (#selectAll/#selectNone)
           em vez de duplicar a lógica; removê-los quebraria a seleção. */ ?>
        <span class="zk-legacy-select">
        <?php echo __('Select');?>:&nbsp;
        <a id="selectAll" href="#ckb"><?php echo __('All');?></a>&nbsp;&nbsp;
        <a id="selectNone" href="#ckb"><?php echo __('None');?></a>&nbsp;&nbsp;
        <a id="selectToggle" href="#ckb"><?php echo __('Toggle');?></a>&nbsp;&nbsp;
        </span>
        <?php }else{
            echo '<i>';
            echo $ferror?Format::htmlchars($ferror):__('Query returned 0 results.');
            echo '</i>';
        } ?>
      </td>
    </tr>
  </tfoot>
</table>

<?php
    if ($count > 0 || $skipCount) { //if we actually had any tickets returned.
?>  <div>
      <span class="faded pull-right"><?php echo $pageNav->showing(); ?></span>
<?php
        echo __('Page').':'.$pageNav->getPageLinks().'&nbsp;';
        ?>
        <a href="#tickets/export/<?php echo $queue->getId(); ?>"
        id="queue-export" class="no-pjax export"
            ><?php echo __('Export'); ?></a>
        <i class="help-tip icon-question-sign" href="#export"></i>
    </div>
<?php
    } ?>
</form>

<?php /* ZK: comportamento estilo Gmail — a barra de ações em massa
   (Ticket::agentActions) e o checkbox "selecionar tudo" do cabeçalho só
   fazem sentido quando existe seleção; o resto do JS/CSS (#selectAll,
   #selectNone, .ckb) já é do core (scp.js), aqui só reaproveitamos. */
if ($canManageTickets) { ?>
<script type="text/javascript">
$(function() {
    var $form = $('#tickets'),
        $bulkbar = $('#zk-bulkbar'),
        $hdrCkb = $('#zk-select-all');

    function zkRefreshBulkbar() {
        var $boxes = $('.ckb', $form),
            total = $boxes.length,
            checked = $boxes.filter(':checked').length;

        $bulkbar.toggleClass('zk-bulkbar-active', checked > 0);
        $('#zk-bulkbar-count').text(checked > 0 ? checked : '');
        $hdrCkb
            .prop('checked', total > 0 && checked === total)
            .prop('indeterminate', checked > 0 && checked < total);
    }

    $form.on('change', '.ckb', zkRefreshBulkbar);

    $hdrCkb.on('change', function() {
        $('#' + (this.checked ? 'selectAll' : 'selectNone')).trigger('click');
    });

    $('#zk-bulkbar-clear').on('click', function(e) {
        e.preventDefault();
        $('#selectNone').trigger('click');
    });

    zkRefreshBulkbar();
});
</script>
<?php } ?>
