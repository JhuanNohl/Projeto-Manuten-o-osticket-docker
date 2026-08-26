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
<?php /* ZK-SEC: CAPTCHA Cloudflare Turnstile — sem chaves configuradas
         (TURNSTILE_SITE_KEY/_SECRET_KEY vazias), render() não desenha nada. */
echo Turnstile::render(); ?>
<?php /* ZK-TERMS: aceite obrigatório do Termo de Garantia e Política de
         Manutenção no primeiro acesso (criação de conta) — evita
         contestação posterior em caso de desistência do procedimento.
         Validado também no servidor em account.php.
         (1) Resumo sempre visível com garantia/valores/armazenagem —
             pedido explícito do cliente pra evidenciar isso ANTES do
             aceite, sem precisar abrir o termo completo.
         (2) O link do termo abre um modal com o texto integral; o botão
             de aceite dentro do modal só habilita depois que o usuário
             rola até o fim — só então o checkbox principal é liberado
             (fica desabilitado por JS até lá). Sem JS, cai no fallback:
             checkbox comum + link abre o termo em nova aba. */ ?>
<div class="zk-terms-highlights">
    <h4><?php echo __('Antes de continuar, veja os principais pontos do procedimento'); ?></h4>
    <ul>
        <li><strong><?php echo __('Garantia:'); ?></strong> <?php echo __('12 meses de hardware (a partir da nota fiscal de compra) e 3 meses sobre o serviço após o reparo. Não cobre cabos, fontes, cartões/acessórios, nem equipamentos comprados fora do Brasil.'); ?></li>
        <li><strong><?php echo __('Reparo fora da garantia:'); ?></strong> <?php echo __('peças, mão de obra e frete são cobrados conforme orçamento — só executado após sua aprovação.'); ?></li>
        <li><strong><?php echo __('Orçamento não aprovado ou equipamento sem defeito:'); ?></strong> <?php echo __('taxa de R$ 90,00 por equipamento pela avaliação/laudo técnico.'); ?></li>
        <li><strong><?php echo __('Armazenagem:'); ?></strong> <?php echo __('retirada em até 5 dias úteis após o aviso de disponibilidade; depois disso, R$ 1,00/dia por equipamento não retirado.'); ?></li>
        <li><strong><?php echo __('Frete:'); ?></strong> <?php echo __('envio e devolução são de responsabilidade do cliente; não recebemos remessas com frete a cobrar.'); ?></li>
    </ul>
</div>
<div class="zk-terms-box<?php if ($errors['zk_terms']) { ?> zk-terms-error<?php } ?>">
    <label class="zk-terms-label">
        <input type="checkbox" name="zk_terms_accept" id="zkTermsCheckbox" value="1" required
            <?php if ($info['zk_terms_accept']) { ?>checked<?php } ?>>
        <span><?php echo __('Li e concordo com as normas e o procedimento de manutenção descritos no'); ?>
        <a href="assets/documents/termo-manutencao-zkteco.php" target="_blank" rel="noopener" class="zk-terms-link"><?php echo __('Termo de Garantia e Política de Manutenção — ZKTeco do Brasil'); ?></a>.</span>
    </label>
    <input type="hidden" name="zk_terms_scrolled" id="zkTermsScrolledFlag" value="<?php echo $info['zk_terms_scrolled'] ? '1' : '0'; ?>">
    <?php if ($errors['zk_terms']) { ?><span class="error"><?php echo $errors['zk_terms']; ?></span><?php } ?>
</div>
<div class="zk-terms-modal-overlay" id="zkTermsOverlay" hidden>
    <div class="zk-terms-modal" role="dialog" aria-modal="true" aria-labelledby="zkTermsModalTitle">
        <div class="zk-terms-modal-header">
            <h3 id="zkTermsModalTitle"><?php echo __('Termo de Garantia e Política de Manutenção'); ?></h3>
            <button type="button" class="zk-terms-modal-close" id="zkTermsClose" aria-label="<?php echo __('Fechar'); ?>">&times;</button>
        </div>
        <div class="zk-terms-modal-body" id="zkTermsScrollArea">
            <div class="zk-doc">
<?php require CLIENTINC_DIR . 'zk-termo-manutencao-content.inc.php'; ?>
            </div>
        </div>
        <div class="zk-terms-modal-footer">
            <p class="zk-terms-modal-hint" id="zkTermsHint"><?php echo __('Role até o final do termo para habilitar o aceite.'); ?></p>
            <button type="button" class="zk-terms-modal-accept" id="zkTermsAccept" disabled><?php echo __('Li e concordo com o termo'); ?></button>
        </div>
    </div>
</div>
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
<?php /* ZK-TERMS: modal de leitura obrigatória — sem isto (JS desligado),
   o checkbox permanece um checkbox comum e o link abre o termo em nova
   aba (fallback abaixo, via atributo href normal). */ ?>
<script type="text/javascript">
(function($){
  $(function(){
    var $checkbox = $('#zkTermsCheckbox');
    var $overlay = $('#zkTermsOverlay');
    var $scrollArea = $('#zkTermsScrollArea');
    var $acceptBtn = $('#zkTermsAccept');
    var $hint = $('#zkTermsHint');
    var $scrolledFlag = $('#zkTermsScrolledFlag');
    var hintDefault = $hint.text();
    var hintConfirmed = '<?php echo Format::htmlchars(__('Você leu até o final. Clique para confirmar.')); ?>';

    // Só força o fluxo do modal se ainda não havia sido aceito antes
    // (reenvio do form por outro erro de validação não reabre o modal).
    if (!$checkbox.is(':checked'))
        $checkbox.prop('disabled', true);

    function checkScrollNeeded(){
        var el = $scrollArea.get(0);
        if (el.scrollHeight <= el.clientHeight + 4) {
            $acceptBtn.prop('disabled', false);
            $hint.text(hintConfirmed);
        }
    }

    function openModal(){
        $overlay.prop('hidden', false);
        $acceptBtn.prop('disabled', true);
        $hint.text(hintDefault);
        $scrollArea.scrollTop(0);
        $('body').css('overflow', 'hidden');
        setTimeout(checkScrollNeeded, 50);
    }
    function closeModal(){
        $overlay.prop('hidden', true);
        $('body').css('overflow', '');
    }

    $('.zk-terms-link').on('click', function(e){
        e.preventDefault();
        e.stopPropagation();
        openModal();
    });
    $('#zkTermsClose').on('click', closeModal);
    $overlay.on('click', function(e){
        if (e.target === this) closeModal();
    });
    $(document).on('keydown', function(e){
        if (e.key === 'Escape' && !$overlay.prop('hidden')) closeModal();
    });

    $scrollArea.on('scroll', function(){
        var el = this;
        if (el.scrollTop + el.clientHeight >= el.scrollHeight - 16) {
            $acceptBtn.prop('disabled', false);
            $hint.text(hintConfirmed);
        }
    });

    $acceptBtn.on('click', function(){
        $scrolledFlag.val('1');
        $checkbox.prop('disabled', false).prop('checked', true);
        closeModal();
    });
  });
})(jQuery);
</script>
