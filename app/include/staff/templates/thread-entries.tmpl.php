<?php
$sort = 'id';
if ($options['sort'] && !strcasecmp($options['sort'], 'DESC'))
    $sort = '-id';

$cmp = function ($a, $b) use ($sort) {
    return ($sort == 'id')
        ? ($a < $b) : $a > $b;
};

$events = $events->order_by($sort);
$eventCount = count($events);
$events = new IteratorIterator($events->getIterator());
$events->rewind();
$event = $events->current();
$htmlId = $options['html-id'] ?: ('thread-'.$this->getId());

$thread_attachments = array();
foreach (Attachment::objects()->filter(array(
    'thread_entry__thread__id' => $this->getId(),
))->select_related('thread_entry', 'file') as $att) {
    $thread_attachments[$att->object_id][] = $att;
}

$tid = $this->getObJectId();
if ($this->getObjectType() == 'T')
    $ticket = Ticket::lookup($tid);
?>
<div id="<?php echo $htmlId; ?>">
    <div id="thread-items" data-thread-id="<?php echo $this->getId(); ?>">
    <?php
    if ($entries->exists(true)) {
        $buckets = ThreadEntry::sortEntries($entries, $ticket);
        // TODO: Consider adding a date boundary to indicate significant
        //       changes in dates between thread items.
        foreach ($buckets as $entry) {
            $entry = ThreadEntry::lookup($entry->id);
            $extra = $entry->getMergeData();
            if ($entry->hasFlag(ThreadEntry::FLAG_CHILD) && $extra) {
                if (!is_array($extra))
                    $extra = json_decode($extra, true);
                if (!$thread = Thread::objects()->filter(array('id'=>$extra['thread']))->values_flat('extra'))
                    continue;
                foreach ($thread as $t)
                    $threadExtra = $t[0];
                $threadExtra = json_decode($threadExtra, true);
                $number = $threadExtra['number'];
            } else
                $number = null;

            // Emit all events prior to this entry
            while ($event && $cmp($event->timestamp, $entry->created)) {
                $event->render(ThreadEvent::MODE_STAFF);
                $events->next();
                $event = $events->current();
            }
            ?><div id="thread-entry-<?php echo $entry->getId(); ?>"><?php
            include STAFFINC_DIR . 'templates/thread-entry.tmpl.php';
            ?></div><?php
        }
    }

    // Emit all other events
    while ($event) {
        $event->render(ThreadEvent::MODE_STAFF);
        $events->next();
        $event = $events->current();
    }
    // This should never happen
    if (count($entries) + $eventCount == 0) {
        echo '<p><em>'.__('No entries have been posted to this thread.').'</em></p>';
    }
    ?>
    </div>
</div>
<script type="text/javascript">
    $(function() {
        var container = '<?php echo $htmlId; ?>';

        // Set inline image urls.
        <?php
        $urls = array();
        foreach ($thread_attachments as $eid=>$atts) {
            foreach ($atts as $A) {
                if (!$A->inline)
                    continue;
                $urls[strtolower($A->file->getKey())] = array(
                    'download_url' => $A->file->getDownloadUrl(['id' =>
                        $A->getId()]),
                    'filename' => $A->getFilename(),
                );
            }
        }
        ?>
        $('#'+container).data('imageUrls', <?php echo JsonDataEncoder::encode($urls); ?>);
        // Trigger thread processing.
        if ($.thread)
            $.thread.onLoad(container,
                    {autoScroll: false}); // ZK: não rolar automático ao abrir o chamado (padrão osTicket descia até o form de resposta)
    });
</script>
<script type="text/javascript">
/* ZK: recolher histórico da thread (agente) — mostra só a mensagem mais recente;
   um botão "Ver histórico" expande/oculta as anteriores, deixando a tela limpa.
   Roda a cada render (inclusive pós-pjax); idempotente. Eventos de sistema não
   entram (ficam fora de [id^=thread-entry-] e já estão ocultos por CSS). */
(function($){
  if (!$) return;
  window.zkThreadCollapse = window.zkThreadCollapse || function(parent){
    var $c = $(parent);
    if (!$c.length) return;
    var $entries = $c.children('[id^="thread-entry-"]');
    if ($entries.length < 2 || $c.children('.zk-thread-toggle').length) return; // <2 nada a recolher / já feito
    var $older = $entries.slice(0, -1).addClass('zk-hist').hide();
    var n = $older.length;
    var $bar = $('<div class="zk-thread-toggle" role="button" tabindex="0"><i class="icon-caret-down"></i> <span></span></div>');
    function paint(open){
      $bar.find('span').text(open
        ? '<?php echo __('Ocultar histórico'); ?>'
        : '<?php echo __('Ver histórico'); ?> — ' + n + (n>1 ? ' <?php echo __('mensagens anteriores'); ?>' : ' <?php echo __('mensagem anterior'); ?>'));
      $bar.find('i').attr('class', open ? 'icon-caret-up' : 'icon-caret-down');
    }
    paint(false);
    $bar.on('click', function(){ var open = $older.first().is(':hidden'); $older.toggle(open); paint(open); });
    $c.prepend($bar);
  };
  $(function(){ window.zkThreadCollapse(document.getElementById('thread-items')); });
})(window.jQuery);
</script>
