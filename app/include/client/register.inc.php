<?php
$info = $_POST;
if (!isset($info['timezone']))
    $info += array(
        'backend' => null,
    );
if (isset($user) && $user instanceof ClientCreateRequest) {
    $bk = $user->getBackend();
    $info = array_merge($info, array(
        'backend' => $bk->getBkId(),
        'username' => $user->getUsername(),
    ));
}
$info = Format::htmlchars(($errors && $_POST)?$_POST:$info);

?>
<?php /* ZK-SIGNUP: mesma apresentação "split hero" do login — painel de
   marca à esquerda (passo a passo de como funciona) + cartão do
   formulário à direita. Reusa as classes .zk-login-* do theme.css. */ ?>
<div class="zk-login zk-signup">
  <section class="zk-login-hero">
    <div class="zk-login-hero-inner">
      <span class="zk-login-kicker">ZKTeco do Brasil</span>
      <h2><?php echo __('Crie sua conta e abra seu'); ?>
          <em><?php echo __('primeiro chamado'); ?></em>
          <?php echo __('em minutos.'); ?></h2>
      <p class="zk-login-hero-sub"><?php
        echo __('Pedimos só o básico para identificar você e manter contato durante o reparo dos seus equipamentos.'); ?></p>
      <ul class="zk-login-feats zk-signup-steps">
        <li><i>1</i>
            <span><b><?php echo __('Crie a conta'); ?></b> — <?php echo __('e-mail, nome e telefone/WhatsApp'); ?></span></li>
        <li><i>2</i>
            <span><b><?php echo __('Abra o chamado'); ?></b> — <?php echo __('equipamentos, fotos do problema e Nota Fiscal'); ?></span></li>
        <li><i>3</i>
            <span><b><?php echo __('Envie o produto'); ?></b> — <?php echo __('e acompanhe cada etapa do reparo por aqui'); ?></span></li>
      </ul>
      <p class="zk-login-trust"><i class="icon-shield"></i>
         <?php echo __('Seus dados são usados somente para o atendimento dos chamados'); ?></p>
    </div>
  </section>
  <section class="zk-login-side">
    <div class="zk-login-card zk-signup-card">
      <h1><?php echo __('Account Registration'); ?></h1>
      <p class="zk-login-card-sub"><?php echo __(
      'Use the forms below to create or update the information we have on file for your account'
      ); ?></p>
<form action="account.php" method="post" id="ticketForm">
  <?php csrf_token(); ?>
  <input type="hidden" name="do" value="<?php echo Format::htmlchars($_REQUEST['do']
    ?: ($info['backend'] ? 'import' :'create')); ?>" />
<?php /* ZK-EQUIP: 2 colunas lado a lado (Contato | Senha) — melhor
         aproveitamento do espaço e menos rolagem que empilhar tudo. */ ?>
<div class="zk-account-grid">
  <div class="zk-account-col">
    <table>
    <tbody>
<?php
    $cf = $user_form ?: UserForm::getInstance();
    $cf->render(array('staff' => false, 'mode' => 'create'));
?>
    </tbody>
    </table>
  </div>
  <div class="zk-account-col">
    <table>
    <tbody>
<tr>
    <td colspan="2">
        <div class="form-header"><b><?php echo __('Access Credentials'); ?></b></div>
    </td>
</tr>
<?php if ($info['backend']) { ?>
<tr>
    <td width="180">
        <?php echo __('Login With'); ?>:
    </td>
    <td>
        <input type="hidden" name="backend" value="<?php echo $info['backend']; ?>"/>
        <input type="hidden" name="username" value="<?php echo $info['username']; ?>"/>
<?php foreach (UserAuthenticationBackend::allRegistered() as $bk) {
    if ($bk->getBkId() == $info['backend']) {
        echo $bk->getName();
        break;
    }
} ?>
    </td>
</tr>
<?php } else { ?>
<tr>
    <td width="180">
        <label><?php echo __('Create a Password'); ?>
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
<?php } ?>
    </tbody>
    </table>
  </div>
</div>
<hr>
<p class="buttons">
    <input type="submit" value="<?php echo __('Register'); ?>"/>
    <input type="button" value="<?php echo __('Cancel'); ?>" onclick="javascript:
        window.location.href='login.php';"/>
</p>
</form>
    </div>
  </section>
</div>
<?php /* ZK-EQUIP: máscara de telefone/WhatsApp brasileiro — (DD) D DDDD-DDDD */ ?>
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
