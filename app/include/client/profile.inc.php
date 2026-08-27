<h1><?php echo __('Manage Your Profile Information'); ?></h1>
<p><?php echo __(
'Use the forms below to update the information we have on file for your account'
); ?>
</p>
<form action="profile.php" method="post" id="ticketForm">
  <?php csrf_token(); ?>
<?php /* ZK-EQUIP: 2 colunas lado a lado (Contato | Senha), mesmo padrão
         usado no registro de conta (account.php?do=create). */ ?>
<div class="zk-account-grid">
  <div class="zk-account-col">
    <table>
    <tbody>
<?php
foreach ($user->getForms() as $f) {
    $f->render(['staff' => false]);
}
?>
    </tbody>
    </table>
  </div>
<?php if ($acct = $thisclient->getAccount()) {
    $info=$acct->getInfo();
    $info=Format::htmlchars(($errors && $_POST)?$_POST:$info);
    if ($acct->isPasswdResetEnabled()) { ?>
  <div class="zk-account-col">
    <table>
    <tbody>
<tr>
    <td colspan="2">
        <div class="form-header"><b><?php echo __('Access Credentials'); ?></b></div>
    </td>
</tr>
<?php if (!isset($_SESSION['_client']['reset-token'])) { ?>
<tr>
    <td width="180">
        <label><?php echo __('Current Password'); ?>
        <input type="password" name="cpasswd" maxlength="128" value="<?php echo $info['cpasswd']; ?>"></label>
        <?php if ($errors['cpasswd']) { ?><span class="error">&nbsp;<?php echo $errors['cpasswd']; ?></span><?php } ?>
    </td>
</tr>
<?php } ?>
<tr>
    <td width="180">
        <label><?php echo __('New Password'); ?>
        <input type="password" name="passwd1" maxlength="128" value="<?php echo $info['passwd1']; ?>"></label>
        <?php if ($errors['passwd1']) { ?><span class="error">&nbsp;<?php echo $errors['passwd1']; ?></span><?php } ?>
    </td>
</tr>
<tr>
    <td width="180">
        <label><?php echo __('Confirm New Password'); ?>
        <input type="password" name="passwd2" maxlength="128" value="<?php echo $info['passwd2']; ?>"></label>
        <?php if ($errors['passwd2']) { ?><span class="error">&nbsp;<?php echo $errors['passwd2']; ?></span><?php } ?>
    </td>
</tr>
    </tbody>
    </table>
  </div>
<?php }
      if ($cfg->getSecondaryLanguages()) { ?>
  <div class="zk-account-col">
    <table>
    <tbody>
<tr>
    <td colspan="2">
        <div class="form-header"><b><?php echo __('Preferences'); ?></b></div>
    </td>
</tr>
<tr>
    <td width="180">
        <label><?php echo __('Preferred Language'); ?>
        <select name="lang">
                <option value="">&mdash; <?php echo __('Use Browser Preference'); ?> &mdash;</option>
<?php
    $langs = Internationalization::getConfiguredSystemLanguages();
    foreach($langs as $l) {
        $selected = ($info['lang'] == $l['code']) ? 'selected="selected"' : ''; ?>
                <option value="<?php echo $l['code']; ?>" <?php echo $selected;
                    ?>><?php echo Internationalization::getLanguageDescription($l['code']); ?></option>
<?php } ?>
        </select></label>
        <?php if ($errors['lang']) { ?><span class="error">&nbsp;<?php echo $errors['lang']; ?></span><?php } ?>
    </td>
</tr>
    </tbody>
    </table>
  </div>
<?php }
} ?>
</div>
<hr>
<p class="buttons">
    <input type="submit" value="<?php echo __('Update'); ?>"/>
    <input type="button" value="<?php echo __('Cancel'); ?>" onclick="javascript:
        window.location.href='index.php';"/>
</p>
</form>
<?php /* ZK-EQUIP: máscara de telefone/WhatsApp brasileiro — (DD) D DDDD-DDDD
         (mesma função usada em register.inc.php) */ ?>
<script type="text/javascript">
(function($){
  function maskPhoneBR(v){
    var d = (v || '').replace(/\D/g, '').substring(0, 11);
    if (d.length > 7)
      return '(' + d.substring(0,2) + ') ' + d.substring(2,3) + ' ' + d.substring(3,7) + '-' + d.substring(7);
    if (d.length > 3)
      return '(' + d.substring(0,2) + ') ' + d.substring(2,3) + ' ' + d.substring(3);
    if (d.length > 2)
      return '(' + d.substring(0,2) + ') ' + d.substring(2);
    if (d.length > 0)
      return '(' + d;
    return '';
  }
  $(function(){
    $('#ticketForm input[type=tel]').on('input', function(){
      var pos = this.selectionStart, before = this.value.length;
      this.value = maskPhoneBR(this.value);
      var after = this.value.length;
      this.setSelectionRange(pos + (after - before), pos + (after - before));
    }).each(function(){ this.value = maskPhoneBR(this.value); });
  });
})(jQuery);
</script>
<?php /* ZK-EQUIP: máscara de CPF/CNPJ — campo "CPF ou CNPJ" do formulário
         de Usuário (ost_form_field); mesma função usada em register.inc.php,
         mirando a classe "zk-doc-field" configurada no próprio campo (nome/id
         do input dinâmico é hash por sessão, não dá pra mirar por eles) */ ?>
<script type="text/javascript">
(function($){
  function maskCpfCnpjBR(v){
    var d = (v || '').replace(/\D/g, '').substring(0, 14);
    if (d.length > 11)
      return d.substring(0,2) + '.' + d.substring(2,5) + '.' + d.substring(5,8)
        + '/' + d.substring(8,12) + (d.length > 12 ? '-' + d.substring(12) : '');
    if (d.length > 9)
      return d.substring(0,3) + '.' + d.substring(3,6) + '.' + d.substring(6,9) + '-' + d.substring(9);
    if (d.length > 6)
      return d.substring(0,3) + '.' + d.substring(3,6) + '.' + d.substring(6);
    if (d.length > 3)
      return d.substring(0,3) + '.' + d.substring(3);
    return d;
  }
  $(function(){
    $('#ticketForm .zk-doc-field').on('input', function(){
      var pos = this.selectionStart, before = this.value.length;
      this.value = maskCpfCnpjBR(this.value);
      var after = this.value.length;
      this.setSelectionRange(pos + (after - before), pos + (after - before));
    }).each(function(){ this.value = maskCpfCnpjBR(this.value); });
  });
})(jQuery);
</script>
<?php /* ZK-DATEPICKER: reskin do calendário (jQuery UI datepicker) do
         campo "Data de Nascimento" pro padrão verde/branco ZKTeco —
         mesma lógica de register.inc.php (CSS em theme.css, #ui-datepicker-div
         e .zk-dp-*); só acrescenta opções no widget já iniciado pelo core
         (class.forms.php), mirando a classe fixa "dp" (nome/id são hash
         por sessão) */ ?>
<script type="text/javascript">
(function($){
  var DIAS = ['dom','seg','ter','qua','qui','sex','sáb'];
  var MESES = ['jan','fev','mar','abr','mai','jun','jul','ago','set','out','nov','dez'];

  function zkDpRefreshHero($inp){
    var $div = $('#ui-datepicker-div');
    var $hero = $div.find('.zk-dp-hero');
    if (!$hero.length)
      $hero = $('<div class="zk-dp-hero"><small></small><strong></strong></div>').prependTo($div);
    var d = $inp.datepicker('getDate') || new Date();
    var dia = DIAS[d.getDay()];
    dia = dia.charAt(0).toUpperCase() + dia.slice(1);
    $hero.find('small').text(d.getFullYear());
    $hero.find('strong').text(dia + ', ' + d.getDate() + ' de ' + MESES[d.getMonth()]);
  }

  function zkDpEnsureButtons($inp){
    var $pane = $('#ui-datepicker-div .ui-datepicker-buttonpane');
    if (!$pane.length || $pane.find('.zk-dp-buttons').length) return;
    var origVal = $inp.data('zk-dp-orig');
    var $btns = $(
      '<div class="zk-dp-buttons">' +
        '<button type="button" class="zk-dp-clear">Limpar</button>' +
        '<button type="button" class="zk-dp-cancel">Cancelar</button>' +
        '<button type="button" class="zk-dp-ok">Definir</button>' +
      '</div>'
    );
    $btns.find('.zk-dp-clear').on('click', function(){
      $inp.val('').trigger('change'); $.datepicker._hideDatepicker();
    });
    $btns.find('.zk-dp-cancel').on('click', function(){
      $inp.val(origVal || '').trigger('change'); $.datepicker._hideDatepicker();
    });
    $btns.find('.zk-dp-ok').on('click', function(){ $.datepicker._hideDatepicker(); });
    $pane.append($btns);
  }

  $(function(){
    var $dp = $('#ticketForm input.dp');
    if (!$dp.length || !$dp.datepicker) return;
    $dp.datepicker('option', {
      numberOfMonths: 1,
      beforeShow: function(input){
        var $inp = $(input);
        $inp.data('zk-dp-orig', $inp.val());
        setTimeout(function(){ zkDpRefreshHero($inp); zkDpEnsureButtons($inp); }, 0);
      },
      onChangeMonthYear: function(){
        setTimeout(function(){ zkDpRefreshHero($dp); zkDpEnsureButtons($dp); }, 0);
      },
      onSelect: function(){ zkDpRefreshHero($dp); }
    });
  });
})(jQuery);
</script>
