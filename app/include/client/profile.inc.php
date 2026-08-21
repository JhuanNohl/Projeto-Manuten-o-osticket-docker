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
