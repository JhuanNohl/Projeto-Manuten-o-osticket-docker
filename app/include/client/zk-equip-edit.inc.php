<?php
if(!defined('OSTCLIENTINC') || !$thisclient || !$ticket || !zk_equip_client_can_edit($ticket)) die('Access Denied!');

$items = zk_equip_list($ticket->getId());
$files = zk_equip_files($ticket->getId());
$zk_ticket_nf_files = function_exists('zk_ticket_files') ? zk_ticket_files($ticket->getId(), 'nf') : array();
?>
<h1><?php echo sprintf(__('Editar Equipamentos — Chamado #%s'), $ticket->getNumber()); ?></h1>
<p><?php echo __('Corrija uma informação, anexe uma foto esquecida ou adicione um equipamento que faltou.'); ?></p>

<?php if (function_exists('zk_equip_styles')) zk_equip_styles(); ?>

<form id="zkEditForm" method="post" action="<?php echo ROOT_PATH; ?>zk-equip-edit.php" enctype="multipart/form-data">
  <?php csrf_token(); ?>
  <input type="hidden" name="id" value="<?php echo (int) $ticket->getId(); ?>">
  <div id="zk-equip">
    <input type="hidden" name="zk_equipments_json" id="zk_equipments_json" value="">

    <?php /* ZK-EQUIP: Nota Fiscal é do chamado inteiro, não de um
             equipamento — mostra o que já está anexado e permite
             anexar/trocar aqui também. */ ?>
    <div class="zk-ticket-nf">
      <div class="zk-ticket-nf-row">
        <label class="zk-ticket-nf-upload" id="zk-ticket-nf-label" title="<?php echo __('Nota Fiscal — apenas arquivo XML (opcional)'); ?>">
          <i class="icon-file-text-alt"></i>
          <span><?php echo __('Anexar/trocar Nota Fiscal (XML)'); ?></span>
          <input type="file" id="zk-ticket-nf-input" name="zk_ticket_nf" accept=".xml,text/xml,application/xml">
        </label>
        <span id="zk-ticket-nf-name" class="zk-ticket-nf-name"></span>
        <div class="zk-ticket-nf-current"><?php echo zk_ticket_nf_html($ticket->getId()); ?></div>
        <?php /* Upload já verifica o XML automaticamente: validado sem
                 erro -> selo verde (sem botão "Verificar"); com erro ou
                 NF antiga não verificada -> botão continua disponível. */
        $__nfPend = zk_ticket_nf_pendencia($ticket->getId());
        if ($zk_ticket_nf_files && $__nfPend === '') { ?>
        <span class="zk-nf-valid" title="<?php echo __('XML verificado automaticamente — destinatário, CFOP e impostos OK'); ?>">
          <i class="icon-ok-sign"></i> <?php echo __('XML validado'); ?>
        </span>
        <?php }
        if ($zk_ticket_nf_files) { if ($__nfPend !== '') { ?>
        <button type="button" class="zk-nf-verify-btn" id="zk-ticket-nf-verify-btn" title="<?php echo __('Verificar XML da Nota Fiscal'); ?>">
          <i class="icon-refresh"></i> <?php echo __('Verificar XML'); ?>
        </button>
        <?php } ?>
        <button type="button" class="zk-ticket-nf-del" id="zk-ticket-nf-del-btn" title="<?php echo __('Apagar Nota Fiscal'); ?>">&times;</button>
        <?php } ?>
        <?php echo zk_nf_dica_html(); ?>
      </div>
      <?php $__zk_nf_errors = zk_ticket_nf_errors_html($ticket->getId()); if ($__zk_nf_errors) { ?>
      <div class="zk-nf-errors-box">
        <b><?php echo __('Erros encontrados na Nota Fiscal:'); ?></b>
        <?php echo $__zk_nf_errors; ?>
      </div>
      <?php } ?>
    </div>

    <div class="zk-grid-wrap">
      <table class="zk-grid" id="zk-grid">
        <thead>
          <tr>
            <th class="zk-c-num">#</th>
            <th class="zk-c-modelo"><?php echo __('Modelo'); ?> <span class="required">*</span></th>
            <th class="zk-c-serie"><?php echo __('Nº de Série'); ?> <span class="required">*</span></th>
            <th class="zk-c-resumo"><?php echo __('Falha Apresentada'); ?> <span class="required">*</span> <span id="zk-resumo-head-count" class="zk-th-count">0/32</span></th>
            <th class="zk-c-detal"><?php echo __('Observação'); ?> <span id="zk-detal-head-count" class="zk-th-count">0/200</span></th>
            <th><?php echo __('Fotos já anexadas'); ?></th>
            <th class="zk-c-photos"><?php echo __('Adicionar foto'); ?></th>
            <th class="zk-c-del"></th>
          </tr>
        </thead>
        <tbody id="zk-grid-body"></tbody>
      </table>
    </div>

    <div class="zk-grid-actions">
      <button type="button" class="button zk-btn" id="zk-add-1">+ <?php echo __('Adicionar equipamento'); ?></button>
      <span id="zk-count" class="zk-count">0 <?php echo __('equipamentos'); ?></span>
    </div>
    <div id="zk-grid-error" class="error" style="display:none"></div>
    <?php /* ZK-EQUIP: pré-visualização das fotos recém-selecionadas (ainda
             não salvas) — mesma lógica do open.inc.php. */ ?>
    <div id="zk-photo-previews-wrap" class="zk-photo-previews-wrap" style="display:none">
      <div class="zk-photo-previews-head"><?php echo __('Pré-visualização das fotos novas'); ?></div>
      <div id="zk-photo-previews" class="zk-photo-previews"></div>
    </div>
  </div>

  <hr/>
  <p class="buttons">
        <input type="submit" value="<?php echo __('Salvar alterações'); ?>">
        <input type="button" name="cancel" value="<?php echo __('Cancelar'); ?>" onclick="javascript:
            window.location.href='tickets.php?id=<?php echo (int) $ticket->getId(); ?>';">
  </p>
</form>

<?php /* ZK-EQUIP: form isolado só pra apagar a NF — fora do #zkEditForm
         de propósito (HTML não permite <form> aninhado). Fica escondido;
         o botão "×" acima só dispara o submit dele via JS. */ ?>
<form id="zkTicketNfDeleteForm" method="post" action="<?php echo ROOT_PATH; ?>zk-equip-edit.php" style="display:none">
  <?php csrf_token(); ?>
  <input type="hidden" name="id" value="<?php echo (int) $ticket->getId(); ?>">
  <input type="hidden" name="zk_ticket_nf_delete" value="1">
</form>

<?php /* Mesma lógica do form de apagar, agora pra disparar a verificação
         do XML — também isolado do #zkEditForm. */ ?>
<form id="zkTicketNfVerifyForm" method="post" action="<?php echo ROOT_PATH; ?>zk-equip-edit.php" style="display:none">
  <?php csrf_token(); ?>
  <input type="hidden" name="id" value="<?php echo (int) $ticket->getId(); ?>">
  <input type="hidden" name="zk_ticket_nf_verify" value="1">
</form>

<script type="text/javascript">
(function($){
  $(function(){
    var $body  = $('#zk-grid-body');
    var $count = $('#zk-count');
    var $err   = $('#zk-grid-error');
    // ZK-EQUIP: mesmos limites testados na abertura do chamado (open.inc.php)
    var RESUMO_LIMIT = 32;
    var DETAL_LIMIT = 200;
    // Total (fotos já salvas + novas nesta sessão) por equipamento — mesmo
    // limite validado no server-side (ZK_EQUIP_MAX_PHOTOS, zk_equipment.php).
    var MAX_PHOTOS = 5;
    var rowFiles = {}; // photoKey -> array de File acumulados (ver open.inc.php)
    var nextPhotoKey = 1;

    // Apagar Nota Fiscal: confirma e envia o form isolado (fora do
    // #zkEditForm, já que HTML não permite <form> aninhado).
    $('#zk-ticket-nf-del-btn').on('click', function(){
      if (confirm('<?php echo __('Remover a Nota Fiscal anexada a este chamado?'); ?>'))
        document.getElementById('zkTicketNfDeleteForm').submit();
    });

    // Verificar/Validar XML: mesmo esquema do botão de apagar, form isolado.
    $('#zk-ticket-nf-verify-btn').on('click', function(){
      document.getElementById('zkTicketNfVerifyForm').submit();
    });

    var initialRows = <?php
        $__rows = array();
        foreach ($items as $it) {
            $eid = (int) $it['id'];
            $existingPhotos = isset($files[$eid]) ? $files[$eid] : array();
            $__rows[] = array(
                'id'            => $eid,
                'modelo'        => $it['modelo'],
                'serie'         => $it['numero_serie'],
                'resumo'        => $it['resumo'],
                'detalhamento'  => $it['detalhamento'],
                'photo_key'     => 'e'.$eid,
                'photos_html'   => zk_equip_photo_links_html($existingPhotos) ?: '<span class="zk-muted">'.__('Nenhuma').'</span>',
                'existing_photo_count' => count($existingPhotos),
            );
        }
        echo JsonDataEncoder::encode($__rows);
    ?>;

    function rowHtml(d){
      d = d || {};
      var id = d.id || 0;
      var photoKey = d.photo_key || ('n' + (nextPhotoKey++));
      var existing = d.existing_photo_count || 0;
      var room = Math.max(0, MAX_PHOTOS - existing);
      function v(x){ return (x==null?'':(''+x)).replace(/"/g,'&quot;'); }
      function t(x){ return (x==null?'':(''+x)).replace(/</g,'&lt;'); }
      return '<tr class="zk-grow" data-photo-key="'+photoKey+'" data-equip-id="'+id+'" data-existing-photos="'+existing+'">'
        + '<td class="zk-c-num"></td>'
        + '<td class="zk-c-modelo"><input type="text" name="zk_modelo[]" class="zk-modelo" value="'+v(d.modelo)+'" maxlength="120">'
        + '<input type="hidden" name="zk_id[]" class="zk-id" value="'+v(id)+'">'
        + '<input type="hidden" name="zk_photo_key[]" value="'+photoKey+'"></td>'
        + '<td class="zk-c-serie"><input type="text" name="zk_serie[]" class="zk-serie" value="'+v(d.serie)+'" maxlength="120"></td>'
        + '<td class="zk-c-resumo"><input type="text" name="zk_resumo[]" class="zk-resumo" value="'+v(d.resumo)+'" maxlength="'+RESUMO_LIMIT+'"></td>'
        + '<td class="zk-c-detal"><textarea name="zk_detalhamento[]" class="zk-detal" rows="1" maxlength="'+DETAL_LIMIT+'">'+t(d.detalhamento)+'</textarea></td>'
        + '<td>'+(d.photos_html || '<span class="zk-muted">'+'<?php echo __("Será salvo ao adicionar"); ?>'+'</span>')+'</td>'
        + '<td class="zk-c-photos"><div class="zk-photo-pair">'
        + (room > 0
            ? '<label class="zk-photo-btn" title="Anexar foto(s) — até '+room+'"><i class="icon-paperclip"></i><input type="file" name="zk_equip_photo['+photoKey+'][]" accept="image/*" multiple class="zk-photo-input"></label>'
            : '<span class="zk-photo-btn zk-photo-btn-disabled" title="'+'<?php echo __("Limite de fotos atingido para este equipamento"); ?>'+'"><i class="icon-paperclip"></i></span>')
        + '</div><div class="zk-photo-count">'+(room > 0 ? ('novas: 0/'+room) : '')+'</div></td>'
        + '<td class="zk-c-del"><a href="#" class="zk-del" title="Remover">&times;</a></td>'
        + '</tr>';
    }
    function renumber(){
      $body.find('tr.zk-grow').each(function(i){ $(this).find('.zk-c-num').text(i+1); });
      var n = $body.find('tr.zk-grow').length;
      $count.text(n + ' ' + (n===1 ? 'equipamento' : 'equipamentos'));
    }

    // ZK-EQUIP: acumulador de fotos por equipamento (ver open.inc.php —
    // mesma lógica: o <input> nativo substitui a FileList inteira a cada
    // seleção, então quem acumula é rowFiles e reconstruímos a FileList do
    // input via DataTransfer depois de cada mudança).
    function syncInputFiles(inputEl, files){
      var dt = new DataTransfer();
      for (var i = 0; i < files.length; i++) dt.items.add(files[i]);
      inputEl.files = dt.files;
    }
    function roomFor($row){
      var existing = parseInt($row.data('existing-photos'), 10) || 0;
      return Math.max(0, MAX_PHOTOS - existing);
    }
    function updatePhotoCount($row, key){
      var room = roomFor($row);
      var n = (rowFiles[key] || []).length;
      $row.find('.zk-photo-count').text(room > 0 ? ('novas: ' + n + '/' + room) : '');
    }

    // Pré-visualização das fotos NOVAS (as já salvas aparecem na coluna
    // "Fotos já anexadas", renderizada no servidor). Reconstrói a galeria
    // inteira a partir de rowFiles a cada chamada.
    var $previewsWrap = $('#zk-photo-previews-wrap');
    var $previews = $('#zk-photo-previews');
    var previewUrls = {}; // photoKey -> [url, ...]
    function renderPreviews(){
      var html = '';
      var seen = {};
      $body.find('tr.zk-grow').each(function(i){
        var $r = $(this);
        var key = $r.data('photo-key');
        var files = rowFiles[key] || [];
        if (!files.length) return;
        seen[key] = true;
        if (previewUrls[key])
          previewUrls[key].forEach(function(u){ URL.revokeObjectURL(u); });
        previewUrls[key] = files.map(function(f){ return URL.createObjectURL(f); });

        var modelo = $.trim($r.find('.zk-modelo').val() || '');
        var label = 'Equipamento ' + (i + 1) + (modelo ? ' — ' + modelo : '');
        files.forEach(function(file, idx){
          html += '<div class="zk-photo-preview" data-photo-key="' + key + '" data-file-index="' + idx + '">'
            + '<img src="' + previewUrls[key][idx] + '" alt="">'
            + '<div class="zk-photo-preview-meta">'
            +   '<span class="zk-photo-preview-label">' + escapeHtml(label) + '</span>'
            +   '<span class="zk-photo-preview-name">' + escapeHtml(file.name) + '</span>'
            + '</div>'
            + '<a href="#" class="zk-photo-preview-del" title="Remover foto">&times;</a>'
            + '</div>';
        });
      });
      for (var k in previewUrls) {
        if (!seen[k]) {
          previewUrls[k].forEach(function(u){ URL.revokeObjectURL(u); });
          delete previewUrls[k];
        }
      }
      $previews.html(html);
      $previewsWrap.toggle(!!html);
    }
    function escapeHtml(x){
      return (x==null?'':(''+x)).replace(/&/g,'&amp;').replace(/</g,'&lt;').replace(/>/g,'&gt;');
    }
    // ZK-EQUIP: contador na MESMA LINHA do cabeçalho da coluna.
    function updateHeadCount($input, headSel, limit){
      var $out = $(headSel);
      var len = ($input.val() || '').length;
      $out.text(len + '/' + limit);
      $out.toggleClass('zk-count-max', len >= limit);
      $out.toggleClass('zk-count-warn', !$out.hasClass('zk-count-max') && len >= limit * 0.8);
    }
    function addRows(list){
      var html = '';
      for (var i=0; i<list.length; i++) html += rowHtml(list[i]);
      $body.append(html);
      renumber();
    }

    $('#zk-add-1').on('click', function(){ addRows([{}]); });
    $body.on('click', '.zk-del', function(e){
      e.preventDefault();
      var $row = $(this).closest('tr');
      if ($row.find('.zk-id').val() && $row.find('.zk-id').val() !== '0') {
        if (!confirm('<?php echo __("Remover este equipamento apenas desta lista? O item existente não será excluído do chamado."); ?>')) return;
      }
      delete rowFiles[$row.data('photo-key')];
      $row.remove();
      renumber();
      renderPreviews();
    });
    $body.on('input', 'input,textarea', function(){
      $(this).closest('tr').removeClass('zk-invalid');
      $err.hide();
    });
    $body.on('input', '.zk-modelo', function(){ renderPreviews(); });
    $body.on('input focus', '.zk-resumo', function(){ updateHeadCount($(this), '#zk-resumo-head-count', RESUMO_LIMIT); });
    $body.on('input focus', '.zk-detal', function(){ updateHeadCount($(this), '#zk-detal-head-count', DETAL_LIMIT); });
    $body.on('change', '.zk-photo-input', function(){
      var $input = $(this);
      var $row = $input.closest('tr');
      var key = $row.data('photo-key');
      var room = roomFor($row);
      var newFiles = Array.prototype.slice.call(this.files || []);
      var current = rowFiles[key] || [];
      var avail = Math.max(0, room - current.length);
      var accepted = newFiles.slice(0, avail);
      var rejected = newFiles.length - accepted.length;
      rowFiles[key] = current.concat(accepted);
      syncInputFiles(this, rowFiles[key]);
      $input.closest('.zk-photo-btn').toggleClass('zk-has-file', rowFiles[key].length > 0);
      updatePhotoCount($row, key);
      if (rejected > 0)
        $err.text('Máximo de ' + MAX_PHOTOS + ' fotos por equipamento — ' + rejected + ' foto(s) não adicionada(s).').show();
      renderPreviews();
    });
    $previews.on('click', '.zk-photo-preview-del', function(e){
      e.preventDefault();
      var $card = $(this).closest('.zk-photo-preview');
      var key = $card.data('photo-key');
      var idx = $card.data('file-index');
      var $row = $body.find('tr.zk-grow[data-photo-key="' + key + '"]');
      var $input = $row.find('.zk-photo-input');
      var files = rowFiles[key] || [];
      files.splice(idx, 1);
      rowFiles[key] = files;
      syncInputFiles($input[0], files);
      $input.closest('.zk-photo-btn').toggleClass('zk-has-file', files.length > 0);
      updatePhotoCount($row, key);
      renderPreviews();
    });

    // Nota Fiscal do chamado (campo único, fora da grade): só aceita .xml.
    $('#zk-ticket-nf-input').on('change', function(){
      var $input = $(this);
      var $label = $('#zk-ticket-nf-label');
      var $name  = $('#zk-ticket-nf-name');
      var file = this.files && this.files[0];
      var ok = !!file && /\.xml$/i.test(file.name);
      if (file && !ok) {
        $input.val('');
        $err.text('A Nota Fiscal precisa ser um arquivo .xml.').show();
      }
      $label.toggleClass('zk-has-file', ok);
      $name.text(ok ? file.name : '');
    });

    function collect(){
      var arr=[];
      $body.find('tr.zk-grow').each(function(){
        var $r=$(this);
        var o={
          id:           $.trim($r.find('.zk-id').val()||'0'),
          modelo:       $.trim($r.find('.zk-modelo').val()||''),
          serie:        $.trim($r.find('.zk-serie').val()||''),
          resumo:       $.trim($r.find('.zk-resumo').val()||''),
          detalhamento: $.trim($r.find('.zk-detal').val()||''),
          photo_key:    $r.data('photo-key') || ''
        };
        if (o.modelo!=='' || o.serie!=='') arr.push(o);
      });
      return arr;
    }

    $('#zkEditForm').on('submit', function(e){
      var arr=collect();
      var bad=false;
      $body.find('tr.zk-grow').each(function(){
        var $r=$(this);
        var m=$.trim($r.find('.zk-modelo').val()||''), s=$.trim($r.find('.zk-serie').val()||'');
        if ((m==='') !== (s==='')) { $r.addClass('zk-invalid'); bad=true; }
      });
      if (bad){
        e.preventDefault();
        $err.text('Cada equipamento precisa de Modelo E Nº de série (linhas destacadas).').show();
        return false;
      }
      if (arr.length===0){
        e.preventDefault();
        $err.text('Mantenha ao menos um equipamento (Modelo e Nº de série).').show();
        return false;
      }
      $('#zk_equipments_json').val(JSON.stringify(arr));
    });

    if (initialRows && initialRows.length)
      addRows(initialRows);
    else
      addRows([{}]);
  });
})(jQuery);
</script>
