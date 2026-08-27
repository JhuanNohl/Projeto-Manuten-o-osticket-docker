<?php
if(!defined('OSTCLIENTINC') || !$thisclient || !$ticket || !$ticket->checkUserAccess($thisclient)) die('Access Denied!');

$info=($_POST && $errors)?Format::htmlchars($_POST):array();

$type = array('type' => 'viewed');
Signal::send('object.view', $ticket, $type);

$dept = $ticket->getDept();

if ($ticket->isClosed() && !$ticket->isReopenable())
    $warn = sprintf(__('%s is marked as closed and cannot be reopened.'), __('This ticket'));

//Making sure we don't leak out internal dept names
if(!$dept || !$dept->isPublic())
    $dept = $cfg->getDefaultDept();

if ($thisclient && $thisclient->isGuest()
    && $cfg->isClientRegistrationEnabled()) { ?>

<div id="msg_info">
    <i class="icon-compass icon-2x pull-left"></i>
    <strong><?php echo __('Looking for your other tickets?'); ?></strong><br />
    <a href="<?php echo ROOT_PATH; ?>login.php?e=<?php
        echo urlencode($thisclient->getEmail());
    ?>" style="text-decoration:underline"><?php echo __('Sign In'); ?></a>
    <?php echo sprintf(__('or %s register for an account %s for the best experience on our help desk.'),
        '<a href="account.php?do=create" style="text-decoration:underline">','</a>'); ?>
    </div>

<?php } ?>

<?php /* ZK-TICKETINFO:BEGIN — cabeçalho + cartões de informações do chamado
   (substitui as tabelas .infoTable/.custom-data do core por cartões;
   estilos .zk-ti-* em assets/default/css/theme.css, camada ZKTeco). */
$__st = $ticket->getStatus();
$__stateColors = array(
    'open'     => '#7AC143',
    'resolved' => '#649E37',
    'closed'   => '#9aa0a6',
    'archived' => '#9aa0a6',
    'deleted'  => '#c0392b',
);
$__stState = $__st ? $__st->getState() : '';
$__stColor = isset($__stateColors[$__stState]) ? $__stateColors[$__stState] : '#474B4F';
?>
<div id="ticketInfo" class="zk-ti">
    <div class="zk-ti-head">
        <h1>
            <a href="tickets.php?id=<?php echo $ticket->getId(); ?>" title="<?php echo __('Reload'); ?>"><i class="refresh icon-refresh"></i></a>
            <b>
            <?php $subject_field = TicketForm::getInstance()->getField('subject');
                echo $subject_field->display($ticket->getSubject()); ?>
            </b>
            <small>#<?php echo $ticket->getNumber(); ?></small>
        </h1>
<?php if ($ticket->hasClientEditableFields()
        // Only ticket owners can edit the ticket details (and other forms)
        && $thisclient->getId() == $ticket->getUserId()
        /* ZK-EQUIP: depois do "Confirmar envio" o chamado trava pro
           cliente (produto em trânsito) — sem botão Editar. */
        && (!function_exists('zk_ticket_locked_for_client')
            || !zk_ticket_locked_for_client($ticket->getId()))) {
            /* ZK-EQUIP: quando o chamado tem equipamentos cadastrados,
               editar deve abrir a mesma grade usada na abertura, não a
               tela padrão de campos dinâmicos do osTicket. */
            $__edit_url = (function_exists('zk_equip_count') && zk_equip_count($ticket->getId()))
                ? 'zk-equip-edit.php?id='.$ticket->getId()
                : 'tickets.php?a=edit&id='.$ticket->getId();
            ?>
        <a class="action-button" href="<?php echo $__edit_url; ?>"><i class="icon-edit"></i> <?php echo __('Edit'); ?></a>
<?php } ?>
    </div>
    <div class="zk-ti-grid">
        <div class="zk-ti-card">
            <div class="zk-ti-card-title">
                <i class="icon-file-text"></i> <?php echo __('Basic Ticket Information'); ?>
            </div>
            <div class="zk-ti-rows">
                <div class="zk-ti-row">
                    <span class="zk-ti-label"><?php echo __('Ticket Status');?></span>
                    <span class="zk-ti-value">
                        <span class="zk-ti-status" style="background:<?php echo $__stColor; ?>"><?php
                            echo $__st ? $__st->getLocalName() : ''; ?></span>
                        <?php /* ZK: "Recebido" = produto na ZKTeco; o detalhe
                           passa a ser por equipamento, na tabela abaixo. */
                        if ($__st && !strcasecmp((string) $__st->getName(), 'Recebido')
                                && function_exists('zk_equip_count') && zk_equip_count($ticket->getId())) { ?>
                        <span class="zk-ti-status-hint"><?php
                            echo __('acompanhe o status por item na tabela de equipamentos abaixo'); ?></span>
                        <?php } ?>
                    </span>
                </div>
                <div class="zk-ti-row">
                    <span class="zk-ti-label"><?php echo __('Department');?></span>
                    <span class="zk-ti-value"><?php echo Format::htmlchars($dept instanceof Dept ? $dept->getName() : ''); ?></span>
                </div>
                <div class="zk-ti-row">
                    <span class="zk-ti-label"><?php echo __('Create Date');?></span>
                    <span class="zk-ti-value"><?php echo Format::datetime($ticket->getCreateDate()); ?></span>
                </div>
            </div>
        </div>
        <div class="zk-ti-card">
            <div class="zk-ti-card-title">
                <i class="icon-user"></i> <?php echo __('User Information'); ?>
            </div>
            <div class="zk-ti-rows">
                <div class="zk-ti-row">
                    <span class="zk-ti-label"><?php echo __('Name');?></span>
                    <span class="zk-ti-value"><?php echo mb_convert_case(Format::htmlchars($ticket->getName()), MB_CASE_TITLE); ?></span>
                </div>
                <div class="zk-ti-row">
                    <span class="zk-ti-label"><?php echo __('Email');?></span>
                    <span class="zk-ti-value"><?php echo Format::htmlchars($ticket->getEmail()); ?></span>
                </div>
                <div class="zk-ti-row">
                    <span class="zk-ti-label"><?php echo __('Telefone');?></span>
                    <span class="zk-ti-value"><?php
                    /* ZK-EQUIP: número vira link direto pro WhatsApp (conveniência
                       tanto pro cliente reconferir quanto, no espelho desta mesma
                       lógica no painel do agente, pra abrir o chat sem digitar). */
                    $__phone = $ticket->getPhoneNumber();
                    if ($__phone && function_exists('zk_whatsapp_url')) {
                        echo '<a class="no-pjax" target="_blank" href="'
                            . Format::htmlchars(zk_whatsapp_url($__phone)) . '">'
                            . '<i class="icon-phone"></i> ' . Format::htmlchars($__phone) . '</a>';
                    } else {
                        echo Format::htmlchars($__phone);
                    } ?></span>
                </div>
            </div>
        </div>
    </div>
<!-- Custom Data -->
<?php
$sections = $forms = array();
foreach (DynamicFormEntry::forTicket($ticket->getId()) as $i=>$form) {
    // Skip core fields shown earlier in the ticket view
    $answers = $form->getAnswers()->exclude(Q::any(array(
        'field__flags__hasbit' => DynamicFormField::FLAG_EXT_STORED,
        'field__name__in' => array('subject', 'priority'),
        Q::not(array('field__flags__hasbit' => DynamicFormField::FLAG_CLIENT_VIEW)),
    )));
    // Skip display of forms without any answers
    foreach ($answers as $j=>$a) {
        if ($a->getField() && $a->getField()->get('name') == 'equip_fotos')
            continue;
        if ($v = $a->display())
            $sections[$i][$j] = array($v, $a);
    }
    // Set form titles
    $forms[$i] = $form->getTitle();
}
foreach ($sections as $i=>$answers) {
    ?>
    <div class="zk-ti-card zk-ti-extra">
        <div class="zk-ti-card-title">
            <i class="icon-list-alt"></i> <?php echo $forms[$i]; ?>
        </div>
        <div class="zk-ti-rows">
<?php foreach ($answers as $A) {
    list($v, $a) = $A; ?>
            <div class="zk-ti-row">
                <span class="zk-ti-label"><?php echo $a->getField()->get('label'); ?></span>
                <span class="zk-ti-value"><?php echo $v; ?></span>
            </div>
<?php } ?>
        </div>
    </div>
    <?php
} ?>
</div>
<?php /* ZK-TICKETINFO:END */ ?>
<?php /* ZK-EQUIP:BEGIN — painel read-only de equipamentos (ZKTeco) */
if (function_exists('zk_equipment_client_panel')) zk_equipment_client_panel($ticket);
/* ZK-EQUIP:END */ ?>
<?php /* ZK-TICKETINFO: thread do chamado dentro de um cartão "Mensagens" —
   é a conversa cliente↔equipe, que cresce conforme o chamado evolui. */ ?>
<div class="zk-ti-card zk-ti-thread">
    <div class="zk-ti-card-title">
        <i class="icon-comments"></i> <?php echo __('Mensagens'); ?>
    </div>
    <div class="zk-ti-card-body">
  <?php
    $email = $thisclient->getUserName();
    $clientId = TicketUser::lookupByEmail($email)->getId();

    $ticket->getThread()->render(array('M', 'R', 'user_id' => $clientId), array(
                    'mode' => Thread::MODE_CLIENT,
                    'html-id' => 'ticketThread')
                );
if ($blockReply = $ticket->isChild() && $ticket->getMergeType() != 'visual')
    $warn = sprintf(__('This Ticket is Merged into another Ticket. Please go to the %s%d%s to reply.'),
        '<a href="tickets.php?id=', $ticket->getPid(), '" style="text-decoration:underline">Parent</a>');
  ?>
    </div>
</div>

<div class="clear" style="padding-bottom:10px;"></div>
<?php if($errors['err']) { ?>
    <div id="msg_error"><?php echo $errors['err']; ?></div>
<?php }elseif($msg) { ?>
    <div id="msg_notice"><?php echo $msg; ?></div>
<?php }elseif($warn) { ?>
    <div id="msg_warning"><?php echo $warn; ?></div>
<?php }
if ((!$ticket->isClosed() || $ticket->isReopenable()) && !$blockReply) { ?>
<?php /* ZK-TICKETINFO: formulário de resposta também em cartão, no mesmo
   padrão visual dos demais blocos da tela. */ ?>
<div class="zk-ti-card zk-ti-reply">
    <div class="zk-ti-card-title">
        <i class="icon-pencil"></i> <?php echo __('Post a Reply'); ?>
    </div>
    <div class="zk-ti-card-body">
<form id="reply" action="tickets.php?id=<?php echo $ticket->getId();
?>#reply" name="reply" method="post" enctype="multipart/form-data">
    <?php csrf_token(); ?>
    <input type="hidden" name="id" value="<?php echo $ticket->getId(); ?>">
    <input type="hidden" name="a" value="reply">
    <div>
        <p><em><?php
         echo __('To best assist you, we request that you be specific and detailed'); ?></em>
        <font class="error">*&nbsp;<?php echo $errors['message']; ?></font>
        </p>
        <textarea name="<?php echo $messageField->getFormName(); ?>" id="message" cols="50" rows="9" wrap="soft"
            class="<?php if ($cfg->isRichTextEnabled()) echo 'richtext';
                ?> zk-basic-editor draft" <?php
list($draft, $attrs) = Draft::getDraftAndDataAttrs('ticket.client', $ticket->getId(), $info['message']);
echo $attrs; ?>><?php echo $draft ?: $info['message'];
            ?></textarea>
    <?php
    if ($messageField->isAttachmentsEnabled()) {
        print $attachments->render(array('client'=>true));
    } ?>
    </div>
<?php
  if ($ticket->isClosed() && $ticket->isReopenable()) { ?>
    <div class="warning-banner">
        <?php echo __('Ticket will be reopened on message post'); ?>
    </div>
<?php } ?>
    <p class="buttons">
        <input type="submit" value="<?php echo __('Post Reply');?>">
        <input type="button" value="<?php echo __('Cancel');?>" onClick="history.go(-1)">
    </p>
</form>
    </div>
</div>
<?php
} ?>
<script type="text/javascript">
<?php
// Hover support for all inline images
$urls = array();
foreach (AttachmentFile::objects()->filter(array(
    'attachments__thread_entry__thread__id' => $ticket->getThreadId(),
    'attachments__inline' => true,
)) as $file) {
    $urls[strtolower($file->getKey())] = array(
        'download_url' => $file->getDownloadUrl(['type' => 'H']),
        'filename' => $file->name,
    );
} ?>
showImagesInline(<?php echo JsonDataEncoder::encode($urls); ?>);
</script>
