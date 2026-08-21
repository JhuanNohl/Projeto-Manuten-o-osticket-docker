<?php
if(!defined('OSTCLIENTINC')) die('Access Denied');

$email=Format::input($_POST['luser']?:$_GET['e']);
$passwd=Format::input($_POST['lpasswd']?:$_GET['t']);

$content = Page::lookupByType('banner-client');

if ($content) {
    list($title, $body) = $ost->replaceTemplateVariables(
        array($content->getLocalName(), $content->getLocalBody()));
} else {
    $title = __('Sign In');
    $body = __('To better serve you, we encourage our clients to register for an account and verify the email address we have on record.');
}

/* ZK-LOGIN: tela de apresentação em "split hero" — painel de marca à
   esquerda (proposta de valor) + cartão de login à direita. Estilos
   .zk-login-* no theme.css (camada ZKTeco). A antiga #clientLogin
   continua existindo para accesslink.inc.php (Verificar Status). */
?>
<div class="zk-login">
  <section class="zk-login-hero">
    <div class="zk-login-hero-inner">
      <span class="zk-login-hero-sub"><h2>ZKTECO DO BRASIL</h2></span>
      <p class="zk-login-kicker"><?php
        echo __('Portal oficial de manutenção da ZKTeco do Brasil!'); ?></p>
      <ul class="zk-login-feats">
        <li><i class="icon-wrench"></i>
            <span><?php echo __('Vários equipamentos em um só chamado;'); ?></span></li>
        <li><i class="icon-file-text"></i>
            <span><?php echo __('Nota Fiscal (XML) validada automaticamente na hora do anexo;'); ?></span></li>
        <li><i class="icon-truck"></i>
            <span><?php echo __('Informe o despacho e siga o status de cada equipamento;'); ?></span></li>
        <li><i class="icon-comments"></i>
            <span><?php echo __('Converse com a equipe técnica e receba atualizações por e-mail.'); ?></span></li>
      </ul>
      <p class="zk-login-trust"><i class="icon-shield"></i>
         <?php echo __('Acesso restrito e seguro!'); ?></p>
    </div>
  </section>
  <section class="zk-login-side">
    <div class="zk-login-card">
      <h1><?php echo Format::display($title); ?></h1>
      <p class="zk-login-card-sub"><?php echo Format::display($body); ?></p>
      <form action="login.php" method="post" id="zkLoginForm">
        <?php csrf_token(); ?>
        <?php if ($errors['login']) { ?>
        <strong class="zk-login-err"><?php echo Format::htmlchars($errors['login']); ?></strong>
        <?php } ?>
        <div class="zk-login-field">
          <i class="icon-user"></i>
          <input id="username" placeholder="<?php echo __('Email or Username'); ?>"
                 aria-label="<?php echo __('Email or Username'); ?>"
                 type="text" name="luser" value="<?php echo $email; ?>" class="nowarn">
        </div>
        <div class="zk-login-field">
          <i class="icon-lock"></i>
          <input id="passwd" placeholder="<?php echo __('Password'); ?>"
                 aria-label="<?php echo __('Password'); ?>"
                 type="password" name="lpasswd" maxlength="128" value="<?php echo $passwd; ?>" class="nowarn">
        </div>
        <input class="zk-login-submit" type="submit" value="<?php echo __('Sign In'); ?>">
        <?php if ($suggest_pwreset) { ?>
        <a class="zk-login-forgot" href="pwreset.php"><i class="glyphicon glyphicon-lock"></i> <?php echo __('Forgot My Password'); ?></a>
        <?php } ?>
      </form>
<?php
$ext_bks = array();
foreach (UserAuthenticationBackend::allRegistered() as $bk)
    if ($bk instanceof ExternalAuthentication)
        $ext_bks[] = $bk;

if (count($ext_bks)) {
    foreach ($ext_bks as $bk) { ?>
      <div class="external-auth"><?php $bk->renderExternalLink(); ?></div><?php
    }
}
if ($cfg && $cfg->isClientRegistrationEnabled()) { ?>
      <div class="zk-login-divider"><span><?php echo __('ainda não tem uma conta?'); ?></span></div>
      <a class="zk-create-account-btn" href="account.php?do=create"><i class="glyphicon glyphicon-plus"></i> <?php echo __('Criar minha conta'); ?></a>
<?php } ?>
    </div>
  </section>
</div>
