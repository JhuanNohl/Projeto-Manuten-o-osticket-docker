<?php
if(!defined('OSTCLIENTINC')) die('Access Denied!');
$info=array();
if($thisclient && $thisclient->isValid()) {
    $info=array('name'=>$thisclient->getName(),
                'email'=>$thisclient->getEmail(),
                'phone'=>$thisclient->getPhoneNumber());
}

$info=($_POST && $errors)?Format::htmlchars($_POST):$info;

$form = null;
if (!$info['topicId']) {
    if (array_key_exists('topicId',$_GET) && preg_match('/^\d+$/',$_GET['topicId']) && Topic::lookup($_GET['topicId']))
        $info['topicId'] = intval($_GET['topicId']);
    else
        $info['topicId'] = $cfg->getDefaultTopicId();
}

$forms = array();
if ($info['topicId'] && ($topic=Topic::lookup($info['topicId']))) {
    foreach ($topic->getForms() as $F) {
        if (!$F->hasAnyVisibleFields())
            continue;
        if ($_POST) {
            $F = $F->instanciate();
            $F->isValidForClient();
        }
        $forms[] = $F->getForm();
    }
}

?>
<h1><?php echo __('Abrir Novo Chamado de Manutenção');?></h1>
<p><?php echo __('Preencha os campos abaixo para registrar uma solicitação de manutenção de equipamento ZKTeco.');?></p>
<form id="ticketForm" method="post" action="open.php" enctype="multipart/form-data">
  <?php csrf_token(); ?>
  <input type="hidden" name="a" value="open">
  <table width="800" cellpadding="1" cellspacing="0" border="0">
    <tbody>
<?php
        if (!$thisclient) {
            $uform = UserForm::getUserForm()->getForm($_POST);
            if ($_POST) $uform->isValid();
            $uform->render(array('staff' => false, 'mode' => 'create'));
        }
        else { ?>
            <tr><td colspan="2">
            <?php /* ZKTeco: ficha do solicitante em uma única célula
                     colspan=2 (mantém a tabela válida). O CSS .zk-client-meta
                     faz o Grid 2 colunas alinhado com gap fixo, eliminando o
                     vão horizontal das antigas linhas "rótulo 170px | valor". */ ?>
            <dl class="zk-client-meta">
                <dt><?php echo __('Solicitante'); ?></dt>
                <dd><?php echo Format::htmlchars($thisclient->getName()); ?></dd>
                <dt><?php echo __('Email'); ?></dt>
                <dd><?php echo Format::htmlchars($thisclient->getEmail()); ?></dd>
            </dl>
            </td></tr>
        <?php } ?>
    </tbody>
    <tbody>
<?php
    /* ZKTeco: sistema de tópico único (manutenção). Quando há apenas UM
       tópico público, o seletor "Tópico de Ajuda" é redundante — o tópico
       é enviado por um campo oculto. Se no futuro forem criados mais
       tópicos, o seletor volta a aparecer automaticamente. */
    $__topics = Topic::getPublicHelpTopics();
    if ($__topics && count($__topics) > 1) { ?>
    <tr><td colspan="2"><hr />
        <div class="form-header" style="margin-bottom:0.5em">
        <b><?php echo __('Help Topic'); ?></b>
        </div>
    </td></tr>
    <tr>
        <td colspan="2">
            <select id="topicId" name="topicId" onchange="javascript:
                    var data = $(':input[name]', '#dynamic-form').serialize();
                    $.ajax(
                      'ajax.php/form/help-topic/' + this.value,
                      {
                        data: data,
                        dataType: 'json',
                        success: function(json) {
                          $('#dynamic-form').empty().append(json.html);
                          $(document.head).append(json.media);
                        }
                      });">
                <option value="" selected="selected">&mdash; <?php echo __('Select a Help Topic');?> &mdash;</option>
                <?php
                foreach($__topics as $id =>$name) {
                    echo sprintf('<option value="%d" %s>%s</option>',
                            $id, ($info['topicId']==$id)?'selected="selected"':'', $name);
                } ?>
            </select>
            <font class="error">*&nbsp;<?php echo $errors['topicId']; ?></font>
        </td>
    </tr>
<?php } else {
        $__only = ($info['topicId']) ?: ($__topics ? key($__topics) : 0); ?>
    <tr style="display:none"><td colspan="2">
        <input type="hidden" id="topicId" name="topicId" value="<?php echo (int) $__only; ?>">
        <font class="error"><?php echo $errors['topicId']; ?></font>
    </td></tr>
<?php } ?>
    </tbody>
    <?php /* ZK-EQUIP:BEGIN — grade de múltiplos equipamentos (ZKTeco) */ ?>
    <tbody>
    <tr><td colspan="2">
      <hr/>
      <div class="form-header" style="margin-bottom:0.5em"><b><?php echo __('Equipamentos'); ?></b>
        <div><?php echo __('Adicione os equipamentos deste chamado. Todos os campos e pelo menos 1 foto são obrigatórios.'); ?></div>
      </div>

      <?php if (function_exists('zk_equip_styles')) zk_equip_styles(); ?>
      <div id="zk-equip">
        <input type="hidden" name="zk_equipments_json" id="zk_equipments_json" value="">
        <?php /* ZK-EQUIP: os campos padrão de Assunto/Mensagem do osTicket foram
                 removidos da tela (redundantes com a grade de equipamentos). São
                 gerados no client-side (abaixo) e enviados aqui para já chegarem
                 preenchidos no $_POST antes do open.php tocar no formulário —
                 preencher via signal 'ticket.create.before' chega tarde demais
                 (o campo já foi vinculado à fonte de dados anterior, vazia). */ ?>
        <input type="hidden" name="subject" id="zk_auto_subject" value="">
        <input type="hidden" name="message" id="zk_auto_message" value="">

        <?php /* ZK-EQUIP: a Nota Fiscal NÃO é anexada na abertura — o foco
                 aqui é cadastrar os equipamentos (modelo, problema, fotos).
                 O XML entra DEPOIS, pelo painel do chamado (clipe na barra
                 da NF, com verificação automática no upload). A pendência
                 "Sem nota fiscal" nasce junto com o chamado e guia o
                 cliente até anexar. */ ?>
        <div class="zk-grid-wrap">
          <table class="zk-grid" id="zk-grid">
            <thead>
              <tr>
                <th class="zk-c-num">#</th>
                <th class="zk-c-modelo"><?php echo __('Modelo'); ?> <span class="required">*</span></th>
                <th class="zk-c-serie"><?php echo __('Nº de Série'); ?> <span class="required">*</span></th>
                <th class="zk-c-resumo"><?php echo __('Falha Apresentada'); ?> <span class="required">*</span> <span id="zk-resumo-head-count" class="zk-th-count">0/32</span></th>
                <th class="zk-c-detal"><?php echo __('Observação'); ?> <span class="required">*</span> <span id="zk-detal-head-count" class="zk-th-count">0/200</span></th>
                <th class="zk-c-garantia"><?php echo __('Garantia'); ?></th>
                <th class="zk-c-photos"><?php echo __('Fotos'); ?> <span class="required">*</span></th>
                <th class="zk-c-del"></th>
              </tr>
            </thead>
            <tbody id="zk-grid-body"></tbody>
          </table>
        </div>

        <div class="zk-grid-actions">
          <button type="button" class="button zk-btn" id="zk-add-1">+ <?php echo __('Adicionar Equipamento'); ?></button>
          <button type="button" class="button zk-btn" id="zk-add-10"><?php echo __('+ 10 Equipamentos'); ?></button>
          <button type="button" class="button zk-btn" id="zk-clear"><?php echo __('Remover Tudo'); ?></button>
          <span id="zk-count" class="zk-count">0 <?php echo __('equipamentos'); ?></span>
        </div>
        <div id="zk-grid-error" class="error" style="display:none"></div>
        <?php /* ZK-EQUIP: pré-visualização das fotos anexadas — abaixo da
                 grade (nunca dentro da célula estreita "Fotos"), pra caber
                 uma miniatura legível de cada foto antes do envio. */ ?>
        <div id="zk-photo-previews-wrap" class="zk-photo-previews-wrap" style="display:none">
          <div class="zk-photo-previews-head"><?php echo __('Pré-visualização das fotos'); ?></div>
          <div id="zk-photo-previews" class="zk-photo-previews"></div>
        </div>
      </div>
    </td></tr>
    </tbody>
    <?php /* ZK-EQUIP:END */ ?>
    <tbody id="dynamic-form">
        <?php
        $options = array('mode' => 'create');
        foreach ($forms as $form) {
            include(CLIENTINC_DIR . 'templates/dynamic-form.tmpl.php');
        } ?>
    </tbody>
    <tbody>
    <?php
    // ZK-SEC: CAPTCHA Cloudflare Turnstile no lugar do CAPTCHA de imagem
    // legado do core (class.captcha.php/captcha.php, sem uso a partir daqui).
    if (Turnstile::isConfigured() && (!$thisclient || !$thisclient->isValid())) {
        if($_POST && $errors && !$errors['captcha'])
            $errors['captcha']=__('Please re-enter the text again');
        ?>
    <tr class="captchaRow">
        <td class="required"><?php echo __('CAPTCHA Text');?>:</td>
        <td>
            <?php echo Turnstile::render(); ?>
            <font class="error">*&nbsp;<?php echo $errors['captcha']; ?></font>
        </td>
    </tr>
    <?php
    } ?>
    <tr><td colspan=2>&nbsp;</td></tr>
    </tbody>
  </table>
<hr/>
  <p class="buttons">
        <input type="submit" value="<?php echo __('Create Ticket');?>">
        <input type="button" name="cancel" value="<?php echo __('Cancel'); ?>" onclick="javascript:
            $('.richtext').each(function() {
                var redactor = $(this).data('redactor');
                if (redactor && redactor.opts.draftDelete)
                    redactor.plugin.draft.deleteDraft();
            });
            window.location.href='index.php';">
  </p>
</form>

<?php /* ZK-EQUIP:BEGIN — JS da grade de equipamentos (ZKTeco) */ ?>
<script type="text/javascript">
(function($){
  $(function(){
    var $body  = $('#zk-grid-body');
    var $count = $('#zk-count');
    var $err   = $('#zk-grid-error');
    var LIMIT  = 1000;
    // ZK-EQUIP: limite testado para o campo Resumo caber sem rolagem
    // interna no input (medido com canvas em várias frases reais).
    var RESUMO_LIMIT = 32;
    // Detalhamento/Observação (campo único, textarea com quebra de linha —
    // menos crítico que o Resumo, mas ainda limitado para não crescer sem controle).
    var DETAL_LIMIT = 200;
    // ZK-EQUIP: nº máximo de fotos por equipamento (mesmo limite validado
    // no server-side, ver ZK_EQUIP_MAX_PHOTOS em zk_equipment.php).
    var MAX_PHOTOS = 5;
    // photoKey -> array de File acumulados (o <input> nativo substitui a
    // FileList inteira a cada seleção — quem acumula é este objeto; depois
    // de cada mudança, reconstruímos a FileList do input via DataTransfer
    // pra ela refletir o total, e é isso que realmente vai no submit).
    var rowFiles = {};
    var nextPhotoKey = 1;
    var initialRows = <?php
      $zk_initial_rows = ($_POST && function_exists('zk_equip_request_rows'))
          ? zk_equip_request_rows() : array();
      echo JsonDataEncoder::encode($zk_initial_rows ?: array());
    ?>;

    function rowHtml(d){
      d = d || {};
      var photoKey = d.photo_key || ('r' + (nextPhotoKey++));
      function v(x){ return (x==null?'':(''+x)).replace(/"/g,'&quot;'); }
      function t(x){ return (x==null?'':(''+x)).replace(/</g,'&lt;'); }
      return '<tr class="zk-grow" data-photo-key="'+photoKey+'">'
        + '<td class="zk-c-num"></td>'
        + '<td class="zk-c-modelo"><input type="text" name="zk_modelo[]" class="zk-modelo" value="'+v(d.modelo)+'" maxlength="120"><input type="hidden" name="zk_photo_key[]" value="'+photoKey+'"></td>'
        + '<td class="zk-c-serie"><input type="text" name="zk_serie[]" class="zk-serie" value="'+v(d.serie)+'" maxlength="120"></td>'
        + '<td class="zk-c-resumo"><input type="text" name="zk_resumo[]" class="zk-resumo" value="'+v(d.resumo)+'" maxlength="'+RESUMO_LIMIT+'"></td>'
        + '<td class="zk-c-detal"><textarea name="zk_detalhamento[]" class="zk-detal" rows="1" maxlength="'+DETAL_LIMIT+'">'+t(d.detalhamento)+'</textarea></td>'
        + '<td class="zk-c-garantia"><select name="zk_garantia[]" class="zk-garantia">'
        + '<option value="nao"'+(d.garantia==='sim'?'':' selected')+'>'+'<?php echo __('Não possuo garantia'); ?>'+'</option>'
        + '<option value="sim"'+(d.garantia==='sim'?' selected':'')+'>'+'<?php echo __('Solicitar garantia'); ?>'+'</option>'
        + '</select></td>'
        + '<td class="zk-c-photos"><div class="zk-photo-pair">'
        + '<label class="zk-photo-btn" title="Anexar foto(s) — até '+MAX_PHOTOS+'"><i class="icon-paperclip"></i><input type="file" name="zk_equip_photo['+photoKey+'][]" accept="image/*" multiple class="zk-photo-input"></label>'
        + '</div><div class="zk-photo-count">0/'+MAX_PHOTOS+'</div></td>'
        + '<td class="zk-c-del"><a href="#" class="zk-del" title="Remover">&times;</a></td>'
        + '</tr>';
    }
    function renumber(){
      $body.find('tr.zk-grow').each(function(i){ $(this).find('.zk-c-num').text(i+1); });
      var n = $body.find('tr.zk-grow').length;
      $count.text(n + ' ' + (n===1 ? 'equipamento' : 'equipamentos'));
    }

    // ZK-EQUIP: acumulador de fotos por equipamento — o <input type=file>
    // nativo SUBSTITUI a FileList inteira a cada seleção; pra permitir
    // adicionar em vários cliques (até MAX_PHOTOS), quem acumula é
    // rowFiles[photoKey] e, depois de cada mudança, reconstruímos a
    // FileList do input via DataTransfer pra ela refletir o total (é o que
    // realmente vai no submit).
    function syncInputFiles(inputEl, files){
      var dt = new DataTransfer();
      for (var i = 0; i < files.length; i++) dt.items.add(files[i]);
      inputEl.files = dt.files;
    }
    function updatePhotoCount($row, key){
      var n = (rowFiles[key] || []).length;
      $row.find('.zk-photo-count').text(n + '/' + MAX_PHOTOS);
    }

    // Pré-visualização das fotos (abaixo da grade, nunca na célula estreita
    // "Fotos"). Reconstrói a galeria inteira a partir de rowFiles a cada
    // chamada — a lista costuma ter poucos itens, então recriar as object
    // URLs sempre é mais simples do que tentar reaproveitar por índice
    // (que muda quando uma foto do meio é removida).
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
    // ZK-EQUIP: contador na MESMA LINHA do cabeçalho da coluna (não mais
    // uma linha extra dentro da célula) — reflete o campo em foco/edição.
    function updateHeadCount($input, headSel, limit){
      var $out = $(headSel);
      var len = ($input.val() || '').length;
      $out.text(len + '/' + limit);
      $out.toggleClass('zk-count-max', len >= limit);
      $out.toggleClass('zk-count-warn', !$out.hasClass('zk-count-max') && len >= limit * 0.8);
    }
    function addRows(list){
      var html = '';
      for (var i=0; i<list.length; i++){
        if ($body.find('tr.zk-grow').length + (html.match(/zk-grow/g)||[]).length >= LIMIT) break;
        html += rowHtml(list[i]);
      }
      $body.append(html);
      renumber();
    }
    function addEmpty(n){
      var arr=[]; for (var i=0;i<n;i++) arr.push({}); addRows(arr);
    }

    // ---- Serialização no submit ----
    function collect(){
      var arr=[];
      $body.find('tr.zk-grow').each(function(){
        var $r=$(this);
        var o={
          modelo:       $.trim($r.find('.zk-modelo').val()||''),
          serie:        $.trim($r.find('.zk-serie').val()||''),
          resumo:       $.trim($r.find('.zk-resumo').val()||''),
          detalhamento: $.trim($r.find('.zk-detal').val()||''),
          garantia:     $r.find('.zk-garantia').val()||'nao',
          photo_key:    $r.data('photo-key') || ''
        };
        if (o.modelo!=='' || o.serie!=='') arr.push(o);
      });
      return arr;
    }

    // ---- Eventos ----
    $('#zk-add-1').on('click', function(){ addEmpty(1); });
    $('#zk-add-10').on('click', function(){ addEmpty(10); });
    $('#zk-clear').on('click', function(){
      $body.find('tr.zk-grow').each(function(){ delete rowFiles[$(this).data('photo-key')]; });
      $body.empty();
      renumber();
      renderPreviews();
    });
    $body.on('click', '.zk-del', function(e){
      e.preventDefault();
      var $row = $(this).closest('tr');
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
      var newFiles = Array.prototype.slice.call(this.files || []);
      var current = rowFiles[key] || [];
      var room = Math.max(0, MAX_PHOTOS - current.length);
      var accepted = newFiles.slice(0, room);
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

    // (NF na abertura foi removida — o XML entra depois, pelo painel do
    // chamado, com verificação automática. Ver zk_save_ticket_nf.)

    // ZK-EQUIP: gera Assunto/Mensagem a partir dos equipamentos (mesma regra
    // usada como fallback no servidor, em zk_equip_fill_ticket_vars()).
    function escapeHtml(x){
      return (x==null?'':(''+x)).replace(/&/g,'&amp;').replace(/</g,'&lt;').replace(/>/g,'&gt;');
    }
    function fillAutoSubjectMessage(arr){
      var n = arr.length;
      var LIMIT = 70; // casa com o length do campo subject e com zk_equip_subject_text()
      var subj;
      if (n === 1) {
        subj = 'Manutenção — ' + arr[0].modelo + (arr[0].serie ? ' (S/N ' + arr[0].serie + ')' : '');
        subj = subj.substring(0, LIMIT);
      } else {
        // agrupa por modelo preservando a ordem; conta repetidos ("4× Modelo")
        var order = [], counts = {};
        for (var j = 0; j < arr.length; j++) {
          var m = (arr[j].modelo || '').replace(/^\s+|\s+$/g, '');
          if (!m) continue;
          if (!counts.hasOwnProperty(m)) { counts[m] = 0; order.push(m); }
          counts[m]++;
        }
        var parts = [];
        for (var p = 0; p < order.length; p++)
          parts.push((counts[order[p]] > 1 ? counts[order[p]] + '× ' : '') + order[p]);
        var prefix = 'Manutenção — ' + n + ' equipamentos: ';
        subj = 'Manutenção — ' + n + ' equipamentos';
        // tira modelos do fim até caber; excedente vira "+K modelos"
        for (var k = parts.length; k >= 1; k--) {
          var rest = parts.length - k;
          var cand = prefix + parts.slice(0, k).join(', ')
                   + (rest ? ' +' + rest + ' modelo' + (rest > 1 ? 's' : '') : '');
          if (cand.length <= LIMIT) { subj = cand; break; }
        }
      }
      $('#zk_auto_subject').val(subj);

      var html = '<p>Solicitação de manutenção com <b>' + n + '</b> equipamento(s):</p><ol>';
      for (var i = 0; i < arr.length; i++) {
        var r = arr[i];
        html += '<li><b>' + escapeHtml(r.modelo) + '</b>' + (r.serie ? ' — S/N ' + escapeHtml(r.serie) : '');
        if (r.resumo)       html += '<br><i>Resumo:</i> ' + escapeHtml(r.resumo);
        if (r.detalhamento) html += '<br><i>Detalhamento/Observação:</i> ' + escapeHtml(r.detalhamento);
        html += '</li>';
      }
      html += '</ol>';
      $('#zk_auto_message').val(html);
    }

    // O osticket.js tem um handler global de "submit" (bind em $(document).ready,
    // roda DEPOIS do nosso porque o nosso é inline e já foi registrado durante o
    // parse da página) que, em TODO submit, faz 3 coisas com o botão de envio:
    // 1) clona ele (desabilitado) no lugar original, 2) esconde o botão real,
    // 3) MOVE o botão real (escondido) pro TOPO do form (`form.prepend(...)`) —
    // e mostra o pop-up "Por favor, aguarde!". Isso acontece mesmo quando a
    // NOSSA validação bloqueia o submit com preventDefault(), porque isso não
    // impede os outros handlers do mesmo evento de rodar. Sem desfazer isso,
    // toda vez que faltasse um campo o botão reaparecia (via .show()) mas LÁ
    // NO TOPO do formulário, fora do lugar — foi exatamente o bug reportado.
    // Correção: o clone desabilitado marca a posição ORIGINAL do botão (foi
    // inserido ali antes do botão real ser movido) — então movemos o botão
    // real de volta pra ali (insertBefore o clone) antes de remover o clone.
    // Só dá pra fazer isso depois que o handler deles já rodou, daí o
    // setTimeout(fn, 0) (fila de tasks seguinte).
    function undoNativeSubmitLock(){
      setTimeout(function(){
        $('#overlay, #loading').hide();
        var $clone = $('#ticketForm input[type=submit]:disabled');
        var $real  = $('#ticketForm input[type=submit]:hidden');
        if ($clone.length && $real.length)
          $real.insertBefore($clone.first());
        $clone.remove();
        $real.show();
      }, 0);
    }

    // Valida e serializa antes de enviar o form
    $('#ticketForm').on('submit', function(e){
      var arr=collect();
      // Toda linha "iniciada" (algum campo preenchido ou foto anexada)
      // precisa ter TODOS os campos preenchidos e pelo menos 1 foto.
      // Linhas 100% em branco (ex.: sobra do "+10 linhas") são ignoradas.
      var bad=false;
      $body.find('tr.zk-grow').each(function(){
        var $r=$(this);
        var m=$.trim($r.find('.zk-modelo').val()||'');
        var s=$.trim($r.find('.zk-serie').val()||'');
        var res=$.trim($r.find('.zk-resumo').val()||'');
        var det=$.trim($r.find('.zk-detal').val()||'');
        var hasPhoto=$r.find('.zk-photo-btn.zk-has-file').length>0;
        var started=(m!=='' || s!=='' || res!=='' || det!=='' || hasPhoto);
        if (!started) return;
        if (m==='' || s==='' || res==='' || det==='' || !hasPhoto) {
          $r.addClass('zk-invalid');
          bad=true;
        }
      });
      if (bad){
        e.preventDefault();
        $err.text('Preencha todos os campos e anexe pelo menos 1 foto em cada equipamento (linhas destacadas).').show();
        undoNativeSubmitLock();
        return false;
      }
      if (arr.length===0){
        e.preventDefault();
        $err.text('Adicione ao menos um equipamento (todos os campos e 1 foto são obrigatórios).').show();
        undoNativeSubmitLock();
        return false;
      }
      $('#zk_equipments_json').val(JSON.stringify(arr));
      fillAutoSubjectMessage(arr);
    });

    // Começa com 1 linha
    if (initialRows && initialRows.length)
      addRows(initialRows);
    else
      addEmpty(1);
  });
})(jQuery);
</script>
<?php /* ZK-EQUIP:END */ ?>
