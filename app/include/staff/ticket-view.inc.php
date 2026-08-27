<?php
//Note that ticket obj is initiated in tickets.php.
if(!defined('OSTSCPINC') || !$thisstaff || !is_object($ticket) || !$ticket->getId()) die('Invalid path');

//Make sure the staff is allowed to access the page.
if(!@$thisstaff->isStaff() || !$ticket->checkStaffPerm($thisstaff)) die('Access Denied');

//Re-use the post info on error...savekeyboards.org (Why keyboard? -> some people care about objects than users!!)
$info=($_POST && $errors)?Format::input($_POST):array();

$type = array('type' => 'viewed');
Signal::send('object.view', $ticket, $type);

//Get the goodies.
$dept     = $ticket->getDept();  //Dept
$role     = $ticket->getRole($thisstaff);
$staff    = $ticket->getStaff(); //Assigned or closed by..
$user     = $ticket->getOwner(); //Ticket User (EndUser)
$team     = $ticket->getTeam();  //Assigned team.
$sla      = $ticket->getSLA();
$lock     = $ticket->getLock();  //Ticket lock obj
$children = $ticket->getChildren();
$thread = $ticket->getThread();
if (!$lock && $cfg->getTicketLockMode() == Lock::MODE_ON_VIEW)
    $lock = $ticket->acquireLock($thisstaff->getId());
$mylock = ($lock && $lock->getStaffId() == $thisstaff->getId()) ? $lock : null;
$id    = $ticket->getId();    //Ticket ID.
$isManager = $dept->isManager($thisstaff); //Check if Agent is Manager
$canRelease = ($isManager || $role->hasPerm(Ticket::PERM_RELEASE)); //Check if Agent can release tickets
$blockReply = $ticket->isChild() && $ticket->getMergeType() != 'visual';
$canMarkAnswered = ($isManager || $role->hasPerm(Ticket::PERM_MARKANSWERED)); //Check if Agent can mark as answered/unanswered

//Useful warnings and errors the user might want to know!
if ($ticket->isClosed() && !$ticket->isReopenable())
    $warn = sprintf(
            __('Current ticket status (%s) does not allow the end user to reply.'),
            $ticket->getStatus());
elseif ($blockReply)
    $warn = __('Child Tickets do not allow the end user or agent to reply.');
elseif ($ticket->isAssigned()
        && (($staff && $staff->getId()!=$thisstaff->getId())
            || ($team && !$team->hasMember($thisstaff))
        ))
    $warn.= sprintf('&nbsp;&nbsp;<span class="Icon assignedTicket">%s</span>',
            sprintf(__('Ticket is assigned to %s'),
                implode('/', $ticket->getAssignees())
                ));

if (!$errors['err']) {

    if ($lock && $lock->getStaffId()!=$thisstaff->getId())
        $errors['err'] = sprintf(__('%s is currently locked by %s'),
                __('This ticket'),
                $lock->getStaffName());
    elseif (($emailBanned=Banlist::isBanned($ticket->getEmail())))
        $errors['err'] = __('Email is in banlist! Must be removed before any reply/response');
    elseif (!Validator::is_valid_email($ticket->getEmail()))
        $errors['err'] = __('EndUser email address is not valid! Consider updating it before responding');
}

$unbannable=($emailBanned) ? BanList::includes($ticket->getEmail()) : false;

// ZK: o aviso de atraso virou um card dedicado (.zk-overdue-card) renderizado
// no topo — não entra mais no banner genérico $warn/#msg_warning.

?>
<div>
    <div id="msg_notice" style="display: none;"><span id="msg-txt"><?php echo $msg ?: ''; ?></span></div>
    <div class="sticky bar">
       <div class="content">
        <div class="pull-right flush-right">
            <?php
            if ($thisstaff->hasPerm(Email::PERM_BANLIST)
                    || $role->hasPerm(Ticket::PERM_EDIT)
                    || ($dept && $dept->isManager($thisstaff))) { ?>
            <span class="action-button pull-right" data-placement="bottom" data-dropdown="#action-dropdown-more" data-toggle="tooltip" title="<?php echo __('More');?>">
                <i class="icon-caret-down pull-right"></i>
                <span ><i class="icon-cog"></i></span>
            </span>
            <?php
            }

            if (false /* ZK: botão Editar oculto na barra (só Imprimir+Engrenagem) */) { ?>
                <a class="action-button pull-right" data-placement="bottom" data-toggle="tooltip" title="<?php echo __('Edit'); ?>" href="tickets.php?id=<?php echo $ticket->getId(); ?>&a=edit"><i class="icon-edit"></i></a>
            <?php
            } ?>
            <span class="action-button pull-right" data-placement="bottom" data-dropdown="#action-dropdown-print" data-toggle="tooltip" title="<?php echo __('Print'); ?>">
                <i class="icon-caret-down pull-right"></i>
                <a id="ticket-print" aria-label="<?php echo __('Print'); ?>" href="tickets.php?id=<?php echo $ticket->getId(); ?>&a=print"><i class="icon-print"></i></a>
            </span>
            <div id="action-dropdown-print" class="action-dropdown anchor-right">
              <ul>
                 <li title="PDF File"><a class="no-pjax" target="_blank" href="tickets.php?id=<?php echo $ticket->getId(); ?>&a=print&notes=0&events=0"><i
                 class="icon-file-text-alt"></i> <?php echo __('Ticket Thread'); ?></a>
                 <li title="PDF File"><a class="no-pjax" target="_blank" href="tickets.php?id=<?php echo $ticket->getId(); ?>&a=print&notes=1&events=0"><i
                 class="icon-file-text-alt"></i> <?php echo __('Thread + Internal Notes'); ?></a>
                 <li title="PDF File"><a class="no-pjax" target="_blank" href="tickets.php?id=<?php echo $ticket->getId(); ?>&a=print&notes=1&events=1"><i
                 class="icon-file-text-alt"></i> <?php echo __('Thread + Internal Notes + Events'); ?></a>
                 <?php if (extension_loaded('zip')) { ?>
                 <li title="ZIP Archive"><a class="no-pjax" target="_blank" href="tickets.php?id=<?php echo $ticket->getId(); ?>&a=zip&notes=1"><i
                 class="icon-folder-close-alt"></i> <?php echo __('Thread + Internal Notes + Attachments'); ?></a>
                 <li title="ZIP Archive"><a class="no-pjax" target="_blank" href="tickets.php?id=<?php echo $ticket->getId(); ?>&a=zip&notes=1&tasks=1"><i
                 class="icon-folder-close-alt"></i> <?php echo __('Thread + Internal Notes + Attachments + Tasks'); ?></a>
                 <?php } ?>
              </ul>
            </div>
            <?php
            // Transfer
            if (false /* ZK: botão Encaminhar oculto na barra */) {?>
            <a class="action-button pull-right ticket-action" id="ticket-transfer" data-placement="bottom" data-toggle="tooltip" title="<?php echo __('Transfer'); ?>"
                data-redirect="tickets.php"
                href="#tickets/<?php echo $ticket->getId(); ?>/transfer"><i class="icon-share"></i></a>
            <?php
            } ?>

            <?php
            // Assign
            if (false /* ZK: botão Atribuir/Usuário oculto na barra */) {?>
            <span class="action-button pull-right"
                data-dropdown="#action-dropdown-assign"
                data-placement="bottom"
                data-toggle="tooltip"
                title=" <?php echo $ticket->isAssigned() ? __('Assign') : __('Reassign'); ?>"
                >
                <i class="icon-caret-down pull-right"></i>
                <a class="ticket-action" id="ticket-assign"
                    data-redirect="tickets.php"
                    href="#tickets/<?php echo $ticket->getId(); ?>/assign"><i class="icon-user"></i></a>
            </span>
            <div id="action-dropdown-assign" class="action-dropdown anchor-right">
              <ul>
                <?php
                // Agent can claim team assigned ticket
                if (!$ticket->getStaff()
                        && (!$dept->assignMembersOnly()
                            || $dept->isMember($thisstaff))
                        ) { ?>
                 <li><a class="no-pjax ticket-action"
                    data-redirect="tickets.php?id=<?php echo
                    $ticket->getId(); ?>"
                    href="#tickets/<?php echo $ticket->getId(); ?>/claim"><i
                    class="icon-chevron-sign-down"></i> <?php echo __('Claim'); ?></a>
                <?php
                } ?>
                 <li><a class="no-pjax ticket-action"
                    data-redirect="tickets.php"
                    href="#tickets/<?php echo $ticket->getId(); ?>/assign/agents"><i
                    class="icon-user"></i> <?php echo __('Agent'); ?></a>
                 <li><a class="no-pjax ticket-action"
                    data-redirect="tickets.php"
                    href="#tickets/<?php echo $ticket->getId(); ?>/assign/teams"><i
                    class="icon-group"></i> <?php echo __('Team'); ?></a>
              </ul>
            </div>
            <?php
            } ?>
            <div id="action-dropdown-more" class="action-dropdown anchor-right">
              <ul>
                <?php
                 if ($role->hasPerm(Ticket::PERM_EDIT)) { ?>
                    <li><a class="change-user" href="#tickets/<?php
                    echo $ticket->getId(); ?>/change-user"
                    onclick="javascript:
                        saveDraft();"
                    ><i class="icon-user"></i> <?php
                    echo __('Change Owner'); ?></a></li>
                <?php
                 }

                 if ($role->hasPerm(Ticket::PERM_MERGE) && !$ticket->isChild()) { ?>
                     <li><a href="#ajax.php/tickets/<?php echo $ticket->getId();
                         ?>/merge" onclick="javascript:
                         $.dialog($(this).attr('href').substr(1), 201);
                         return false"
                         ><i class="icon-code-fork"></i> <?php echo __('Merge Tickets'); ?></a></li>
                 <?php
                  }

                 if ($role->hasPerm(Ticket::PERM_LINK) && $ticket->getMergeType() == 'visual') { ?>
                     <li><a href="#ajax.php/tickets/<?php echo $ticket->getId();
                         ?>/link" onclick="javascript:
                         $.dialog($(this).attr('href').substr(1), 201);
                         return false"
                         ><i class="icon-link"></i> <?php echo __('Link Tickets'); ?></a></li>
                 <?php
                 }

                 if ($ticket->isAssigned() && $canRelease) { ?>
                        <li><a href="#tickets/<?php echo $ticket->getId();
                            ?>/release" class="ticket-action"
                             data-redirect="tickets.php?id=<?php echo $ticket->getId(); ?>" >
                               <i class="icon-unlock"></i> <?php echo __('Release (unassign) Ticket'); ?></a></li>
                 <?php
                 }
                 if($ticket->isOpen() && $isManager) {
                    if(!$ticket->isOverdue()) { ?>
                        <li><a class="confirm-action" id="ticket-overdue" href="#overdue"><i class="icon-bell"></i> <?php
                            echo __('Mark as Overdue'); ?></a></li>
                    <?php
                    }
                 }
                 if($ticket->isOpen() && $canMarkAnswered) {
                    if($ticket->isAnswered()) { ?>
                    <li><a href="#tickets/<?php echo $ticket->getId();
                        ?>/mark/unanswered" class="ticket-action"
                            data-redirect="tickets.php?id=<?php echo $ticket->getId(); ?>">
                            <i class="icon-circle-arrow-left"></i> <?php
                            echo __('Mark as Unanswered'); ?></a></li>
                    <?php
                    } else { ?>
                    <li><a href="#tickets/<?php echo $ticket->getId();
                        ?>/mark/answered" class="ticket-action"
                            data-redirect="tickets.php?id=<?php echo $ticket->getId(); ?>">
                            <i class="icon-circle-arrow-right"></i> <?php
                            echo __('Mark as Answered'); ?></a></li>
                    <?php
                    }
                } ?>

                <?php
                if ($role->hasPerm(Ticket::PERM_REFER)) { ?>
                <li><a href="#tickets/<?php echo $ticket->getId();
                    ?>/referrals" class="ticket-action"
                     data-redirect="tickets.php?id=<?php echo $ticket->getId(); ?>" >
                       <i class="icon-exchange"></i> <?php echo __('Manage Referrals'); ?></a></li>
                <?php
                } ?>
                <?php
                if ($role->hasPerm(Ticket::PERM_EDIT)) { ?>
                <li><a href="#ajax.php/tickets/<?php echo $ticket->getId();
                    ?>/forms/manage" onclick="javascript:
                    $.dialog($(this).attr('href').substr(1), 201);
                    return false"
                    ><i class="icon-paste"></i> <?php echo __('Manage Forms'); ?></a></li>
                <?php
                }

                if ($role->hasPerm(Ticket::PERM_REPLY) && $thread && $ticket->getId() == $thread->getObjectId()) {
                    ?>
                <li>

                    <?php
                    $recipients = __(' Manage Collaborators');

                    echo sprintf('<a class="collaborators manage-collaborators"
                            href="#thread/%d/collaborators/1"><i class="icon-group"></i>%s</a>',
                            $ticket->getThreadId(),
                            $recipients);
                   ?>
                </li>
                <?php
                } ?>


<?php           if ($thisstaff->hasPerm(Email::PERM_BANLIST)) {
                     if(!$emailBanned) {?>
                        <li><a class="confirm-action" id="ticket-banemail"
                            href="#banemail"><i class="icon-ban-circle"></i> <?php echo sprintf(
                                Format::htmlchars(__('Ban Email <%s>')),
                                $ticket->getEmail()); ?></a></li>
                <?php
                     } elseif($unbannable) { ?>
                        <li><a  class="confirm-action" id="ticket-banemail"
                            href="#unbanemail"><i class="icon-undo"></i> <?php echo sprintf(
                                Format::htmlchars(__('Unban Email <%s>')),
                                $ticket->getEmail()); ?></a></li>
                    <?php
                     }
                  }
                  Signal::send('ticket.view.more', $ticket, $extras);
                  if ($role->hasPerm(Ticket::PERM_DELETE)) {
                     ?>
                    <li class="danger"><a class="ticket-action" href="#tickets/<?php
                    echo $ticket->getId(); ?>/status/delete"
                    data-redirect="tickets.php"><i class="icon-trash"></i> <?php
                    echo __('Delete Ticket'); ?></a></li>
                <?php
                 }
                ?>
              </ul>
            </div>
                <?php
                if (count($children) != 0)
                    echo sprintf('<span style="font-weight: 700; line-height: 26px;">%s</span>', __('PARENT'));
                elseif ($ticket->isChild())
                    echo sprintf('<span style="font-weight: 700; line-height: 26px;">%s</span>', __('CHILD'));
                // ZK: atalhos Responder/Nota e o seletor de status (bandeira) ocultos
                // na barra — resposta/nota seguem disponíveis nas abas #reply/#note
                // logo abaixo. Manter só Imprimir + Engrenagem no topo.
                if (false && $role->hasPerm(Ticket::PERM_REPLY)) { ?>
                <a href="#post-reply" class="post-response action-button"
                data-placement="bottom" data-toggle="tooltip"
                title="<?php echo __('Post Reply'); ?>"><i class="icon-mail-reply"></i></a>
                <?php
                } ?>
                <?php if (false /* ZK: nota oculta na barra */) { ?>
                <a href="#post-note" id="post-note" class="post-response action-button"
                data-placement="bottom" data-toggle="tooltip"
                title="<?php echo __('Post Internal Note'); ?>"><i class="icon-file-text"></i></a>
                <?php } ?>
                <?php // Status change options (bandeira) — ZK: oculto
                if (false) echo TicketStatus::status_options();
                ?>
           </div>
        <div class="flush-left">
             <h2><a href="tickets.php?id=<?php echo $ticket->getId(); ?>"
             title="<?php echo __('Reload'); ?>"><i class="icon-refresh"></i>
             <?php echo sprintf(__('Ticket #%s'), $ticket->getNumber()); ?></a>
            </h2>
        </div>
    </div>
  </div>
</div>
<div class="clear tixTitle has_bottom_border">
    <h3>
    <?php $subject_field = TicketForm::getInstance()->getField('subject');
        echo $subject_field ? $subject_field->display($ticket->getSubject())
            : Format::htmlchars($ticket->getSubject()); ?>
    </h3>
</div>
<?php /* ZK: card de ATRASO dedicado (chamativo) no topo — só quando vencido. */
if ($ticket->isOverdue()) {
    $__due = Format::datetime($ticket->getEstDueDate()); ?>
    <div class="zk-overdue-card" role="alert">
        <span class="zk-overdue-ico"><i class="icon-warning-sign"></i></span>
        <div class="zk-overdue-txt">
            <span class="zk-overdue-title"><?php echo __('ATRASADO!'); ?></span>
            <span class="zk-overdue-sub"><?php
                echo $__due
                    ? sprintf(__('Este chamado passou do prazo de atendimento — vencia em %s.'), $__due)
                    : __('Este chamado passou do prazo de atendimento.'); ?></span>
        </div>
    </div>
<?php } ?>
<?php /* ZK: demais avisos do chamado (atribuição, status que impede resposta)
         exibidos no TOPO, logo abaixo do assunto. Guarda original: não mostra
         quando há erro de formulário sendo refletido. */
if ($warn && !($errors['err'] && isset($_POST['a']))) { ?>
    <div id="msg_warning"><?php echo $warn; ?></div>
<?php } ?>
<script type="text/javascript">
/* ZK: quando a "Data de Vencimento" é salva (edit inline via ajax), o card
   ATRASADO/aviso não re-renderiza sozinho. O servidor já recalcula a flag
   isoverdue; aqui recarregamos a view ao detectar a troca do #field_duedate,
   para o card aparecer/sumir na hora (sem F5 manual). */
$(function(){
  var el = document.getElementById('field_duedate');
  if (!el || !window.MutationObserver) return;
  var obs = new MutationObserver(function(){
    obs.disconnect();
    window.location.reload();
  });
  obs.observe(el, {childList:true, subtree:true, characterData:true});
});
</script>
<?php /* ZK: as 2 fichas do topo (Status/Usuário e Atribuição/Tópico) ficam
         lado a lado num flex (.zk-info-cols em zkteco-scp.css) — ganha altura
         de tela. A ficha .custom-data ("Detalhes do chamado") fica fora. */ ?>
<div class="zk-info-cols">
<table class="ticket_info" cellspacing="0" cellpadding="0" width="940" border="0">
    <tr>
        <td width="50%">
            <table border="0" cellspacing="0" cellpadding="4" width="100%">
                <tr>
                    <th width="100"><?php echo __('Status');?>:</th>
                    <?php
                         if ($role->hasPerm(Ticket::PERM_CLOSE)) {?>
                         <td>
                          <a class="tickets-action" data-dropdown="#action-dropdown-statuses" data-placement="bottom" data-toggle="tooltip" title="<?php echo __('Change Status'); ?>"
                              data-redirect="tickets.php?id=<?php echo $ticket->getId(); ?>"
                              href="#statuses"
                              onclick="javascript:
                                  saveDraft();"
                              >
                              <?php echo $ticket->getStatus(); ?>
                          </a>
                        </td>
                      <?php } else { ?>
                          <td><?php echo ($S = $ticket->getStatus()) ? $S->display() : ''; ?></td>
                      <?php } ?>
                </tr>
                <?php if (false) { /* ZK: Prioridade removida do cabeçalho a pedido (2026-07-07) */ ?>
                <tr>
                    <th><?php echo __('Priority');?>:</th>
                      <?php
                      if ($role->hasPerm(Ticket::PERM_EDIT)
                        && ($pf = $ticket->getPriorityField())) { ?>
                           <td>
                             <a class="inline-edit" data-placement="bottom" data-toggle="tooltip" title="<?php echo __('Update'); ?>"
                                 href="#tickets/<?php echo $ticket->getId();?>/field/<?php echo $pf->getId();?>/edit">
                                 <span id="field_<?php echo $pf->getId(); ?>"><?php echo $pf->getAnswer()->display(); ?></span>
                             </a>
                           </td>
                      <?php } else { ?>
                           <td><?php echo $ticket->getPriority(); ?></td>
                      <?php } ?>
                </tr>
                <?php } /* ZK: fim Prioridade removida */ ?>
                <?php if (false) { /* ZK: Departamento removido do cabeçalho a pedido — sempre é Manutenção (2026-07-07) */ ?>
                <tr>
                    <th><?php echo __('Department');?>:</th>
                    <?php
                    if ($role->hasPerm(Ticket::PERM_TRANSFER)) {?>
                      <td>
                          <a class="ticket-action" data-placement="bottom" data-toggle="tooltip" title="<?php echo __('Transfer'); ?>"
                            data-redirect="tickets.php?id=<?php echo $ticket->getId(); ?>"
                            href="#tickets/<?php echo $ticket->getId(); ?>/transfer"
                            onclick="javascript:
                                saveDraft();"
                            ><?php echo Format::htmlchars($ticket->getDeptName()); ?>
                        </a>
                      </td>
                    <?php
                  }else {?>
                    <td><?php echo Format::htmlchars($ticket->getDeptName()); ?></td>
                  <?php } ?>
                </tr>
                <?php } /* ZK: fim Departamento removido */ ?>
                <tr>
                    <th><?php echo __('Create Date');?>:</th>
                    <td><?php echo Format::datetime($ticket->getCreateDate()); ?></td>
                </tr>
            </table>
        </td>
        <td width="50%" style="vertical-align:top">
            <table border="0" cellspacing="0" cellpadding="4" width="100%">
                <tr>
                    <th width="100"><?php echo __('User'); ?>:</th>
                    <td><a href="#tickets/<?php echo $ticket->getId(); ?>/user"
                        onclick="javascript:
                            saveDraft();
                            $.userLookup('ajax.php/tickets/<?php echo $ticket->getId(); ?>/user',
                                    function (user) {
                                        $('#user-'+user.id+'-name').text(user.name);
                                        $('#user-'+user.id+'-email').text(user.email);
                                        $('#user-'+user.id+'-phone').text(user.phone);
                                        $('select#emailreply option[value=1]').text(user.name+' <'+user.email+'>');
                                    });
                            return false;
                            "><i class="icon-user"></i> <span id="user-<?php echo $ticket->getOwnerId(); ?>-name"
                            ><?php echo Format::htmlchars($ticket->getName());
                        ?></span></a>
                        <?php
                        if ($user) { ?>
                            <a href="tickets.php?<?php echo Http::build_query(array(
                                'status'=>'open', 'a'=>'search', 'uid'=> $user->getId()
                            )); ?>" title="<?php echo __('Related Tickets'); ?>"
                            data-dropdown="#action-dropdown-stats">
                            (<b><?php echo $user->getNumTickets(); ?></b>)
                            </a>
                            <div id="action-dropdown-stats" class="action-dropdown anchor-right">
                                <ul>
                                    <?php
                                    if(($open=$user->getNumOpenTickets()))
                                        echo sprintf('<li><a href="tickets.php?a=search&status=open&uid=%s"><i class="icon-folder-open-alt icon-fixed-width"></i> %s</a></li>',
                                                $user->getId(), sprintf(_N('%d Open Ticket', '%d Open Tickets', $open), $open));

                                    if(($closed=$user->getNumClosedTickets()))
                                        echo sprintf('<li><a href="tickets.php?a=search&status=closed&uid=%d"><i
                                                class="icon-folder-close-alt icon-fixed-width"></i> %s</a></li>',
                                                $user->getId(), sprintf(_N('%d Closed Ticket', '%d Closed Tickets', $closed), $closed));
                                    ?>
                                    <li><a href="tickets.php?a=search&uid=<?php echo $ticket->getOwnerId(); ?>"><i class="icon-double-angle-right icon-fixed-width"></i> <?php echo __('All Tickets'); ?></a></li>
<?php   if ($thisstaff->hasPerm(User::PERM_DIRECTORY)) { ?>
                                    <li><a href="users.php?id=<?php echo
                                    $user->getId(); ?>"><i class="icon-user
                                    icon-fixed-width"></i> <?php echo __('Manage User'); ?></a></li>
<?php   } ?>
                                </ul>
                            </div>
                            <?php
                            if ($role->hasPerm(Ticket::PERM_EDIT) && $thread && $ticket->getId() == $thread->getObjectId()) {
                                if ($thread) {
                                    $numCollaborators = $thread->getNumCollaborators();
                                    if ($thread->getNumCollaborators())
                                        $recipients = sprintf(__('%d'),
                                                $numCollaborators);
                                } else
                                  $recipients = 0;

                             echo sprintf('<span><a class="manage-collaborators preview"
                                    href="#thread/%d/collaborators/1"><span id="t%d-recipients"><i class="icon-group"></i> (%s)</span></a></span>',
                                    $ticket->getThreadId(),
                                    $ticket->getThreadId(),
                                    $recipients);
                             }?>
<?php                   } # end if ($user) ?>
                    </td>
                </tr>
                <tr>
                    <th><?php echo __('Email'); ?>:</th>
                    <td>
                        <span id="user-<?php echo $ticket->getOwnerId(); ?>-email"><?php echo $ticket->getEmail(); ?></span>
                    </td>
                </tr>
<?php   /* ZK-EQUIP: telefone do solicitante como link direto pro WhatsApp —
           poupa o agente de copiar/formatar o número manualmente. */
        $__phone = $ticket->getPhoneNumber();
        if ($__phone) { /* ZK: Telefone/WhatsApp de volta ao cabeçalho como link clicável do WhatsApp (Docker, 2026-07-07) */ ?>
                <tr>
                    <th><?php echo __('Telefone'); ?>:</th>
                    <td>
                        <?php if (function_exists('zk_whatsapp_url')) { ?>
                        <a class="no-pjax" target="_blank" href="<?php echo Format::htmlchars(zk_whatsapp_url($__phone)); ?>"
                            title="<?php echo __('Abrir conversa no WhatsApp'); ?>">
                            <i class="icon-phone"></i> <?php echo Format::htmlchars($__phone); ?>
                        </a>
                        <?php } else { echo Format::htmlchars($__phone); } ?>
                    </td>
                </tr>
<?php   } ?>
<?php   if ($user->getOrganization()) { ?>
                <tr>
                    <th><?php echo __('Organization'); ?>:</th>
                    <td><i class="icon-building"></i>
                    <?php echo Format::htmlchars($user->getOrganization()->getName()); ?>
                        <a href="tickets.php?<?php echo Http::build_query(array(
                            'status'=>'open', 'a'=>'search', 'orgid'=> $user->getOrgId()
                        )); ?>" title="<?php echo __('Related Tickets'); ?>"
                        data-dropdown="#action-dropdown-org-stats">
                        (<b><?php echo $user->getNumOrganizationTickets(); ?></b>)
                        </a>
                            <div id="action-dropdown-org-stats" class="action-dropdown anchor-right">
                                <ul>
<?php   if ($open = $user->getNumOpenOrganizationTickets()) { ?>
                                    <li><a href="tickets.php?<?php echo Http::build_query(array(
                                        'a' => 'search', 'status' => 'open', 'orgid' => $user->getOrgId()
                                    )); ?>"><i class="icon-folder-open-alt icon-fixed-width"></i>
                                    <?php echo sprintf(_N('%d Open Ticket', '%d Open Tickets', $open), $open); ?>
                                    </a></li>
<?php   }
        if ($closed = $user->getNumClosedOrganizationTickets()) { ?>
                                    <li><a href="tickets.php?<?php echo Http::build_query(array(
                                        'a' => 'search', 'status' => 'closed', 'orgid' => $user->getOrgId()
                                    )); ?>"><i class="icon-folder-close-alt icon-fixed-width"></i>
                                    <?php echo sprintf(_N('%d Closed Ticket', '%d Closed Tickets', $closed), $closed); ?>
                                    </a></li>
                                    <li><a href="tickets.php?<?php echo Http::build_query(array(
                                        'a' => 'search', 'orgid' => $user->getOrgId()
                                    )); ?>"><i class="icon-double-angle-right icon-fixed-width"></i> <?php echo __('All Tickets'); ?></a></li>
<?php   }
        if ($thisstaff->hasPerm(User::PERM_DIRECTORY)) { ?>
                                    <li><a href="orgs.php?id=<?php echo $user->getOrgId(); ?>"><i
                                        class="icon-building icon-fixed-width"></i> <?php
                                        echo __('Manage Organization'); ?></a></li>
<?php   } ?>
                                </ul>
                            </div>
                        </td>
                    </tr>
<?php   } # end if (user->org) ?>
                <?php if (false) { /* ZK: Origem removida do cabeçalho a pedido (2026-07-07) */ ?>
                <tr>
                  <th><?php echo __('Source'); ?>:</th>
                  <td>
                  <?php
                         if ($role->hasPerm(Ticket::PERM_EDIT)) {
                             $source = $ticket->getField('source');?>
                    <a class="inline-edit" data-placement="bottom" data-toggle="tooltip" title="<?php echo __('Update'); ?>"
                        href="#tickets/<?php echo $ticket->getId(); ?>/field/source/edit">
                        <span id="field_source">
                        <?php echo Format::htmlchars($ticket->getSource());
                        ?></span>
                    </a>
                      <?php
                         } else {
                            echo Format::htmlchars($ticket->getSource());
                        }

                    if (!strcasecmp($ticket->getSource(), 'Web') && $ticket->getIP())
                        echo '&nbsp;&nbsp; <span class="faded">('.Format::htmlchars($ticket->getIP()).')</span>';
                    ?>
                 </td>
                </tr>
                <?php } /* ZK: fim Origem removida */ ?>
            </table>
        </td>
    </tr>
</table>
<?php /* ZK: <br> removido — as fichas agora dividem a linha (flex) */ ?>
<table class="ticket_info" cellspacing="0" cellpadding="0" width="940" border="0">
    <tr>
        <td width="50%">
            <table cellspacing="0" cellpadding="4" width="100%" border="0">
                <?php
                if($ticket->isOpen()) { ?>
                <tr>
                    <th width="100"><?php echo __('Assigned To');?>:</th>
                    <?php
                    if ($role->hasPerm(Ticket::PERM_ASSIGN)) {?>
                    <td>
                        <a class="inline-edit" data-placement="bottom" data-toggle="tooltip" title="<?php echo __('Update'); ?>"
                            href="#tickets/<?php echo $ticket->getId(); ?>/assign">
                            <span id="field_assign">
                                <?php if($ticket->isAssigned())
                                        echo Format::htmlchars(implode('/', $ticket->getAssignees()));
                                      else
                                        echo '<span class="faded">&mdash; '.__('Unassigned').' &mdash;</span>';
                        ?></span>
                        </a>
                    </td>
                    <?php
                    } else { ?>
                    <td>
                      <?php
                      if($ticket->isAssigned())
                          echo Format::htmlchars(implode('/', $ticket->getAssignees()));
                      else
                          echo '<span class="faded">&mdash; '.__('Unassigned').' &mdash;</span>';
                      ?>
                    </td>
                    <?php
                    } ?>
                </tr>
                <?php
                } else { ?>
                <tr>
                    <th width="100"><?php echo __('Closed By');?>:</th>
                    <td>
                        <?php
                        if(($staff = $ticket->getStaff()))
                            echo Format::htmlchars($staff->getName());
                        else
                            echo '<span class="faded">&mdash; '.__('Unknown').' &mdash;</span>';
                        ?>
                    </td>
                </tr>
                <?php
                } ?>
                <tr>
                    <th><?php echo __('SLA Plan');?>:</th>
                    <td>
                    <?php
                         if ($role->hasPerm(Ticket::PERM_EDIT)) {
                             $slaField = $ticket->getField('sla'); ?>
                          <a class="inline-edit" data-placement="bottom" data-toggle="tooltip" title="<?php echo __('Update'); ?>"
                          href="#tickets/<?php echo $ticket->getId(); ?>/field/sla/edit">
                          <span id="field_sla"><?php echo $sla ?: __('None'); ?></span>
                      </a>
                      <?php } else { ?>
                        <span id="field_sla"><?php echo $sla ?: __('None'); ?></span>
                      <?php } ?>
                    </td>
                </tr>
                <?php
                if($ticket->isOpen()){ ?>
                <tr>
                    <th><?php echo __('Due Date');?>:</th>
                    <?php
                         if ($role->hasPerm(Ticket::PERM_EDIT)) {
                             $duedate = $ticket->getField('duedate'); ?>
                           <td>
                      <a class="inline-edit" data-placement="bottom" data-toggle="tooltip"
                          title="<?php echo __('Update'); ?>"
                          href="#tickets/<?php echo $ticket->getId();
                           ?>/field/duedate/edit">
                           <?php $due_date = Format::datetime($ticket->getEstDueDate()); ?>
                           <span id="field_duedate" <?php if (!$due_date) echo 'class="faded"'; ?>>
                               <?php echo $due_date ?: '&mdash;'.str_replace('Esvaziar', 'Vazio', __('Empty')).'&mdash;'; /* ZK: "Esvaziar"->"Vazio" */ ?>
                           </span>
                      </a>
                           </td>
                      <?php } else { ?>
                           <td><?php echo Format::datetime($ticket->getEstDueDate()); ?></td>
                      <?php } ?>
                </tr>
                <?php
                }else { ?>
                <tr>
                    <th><?php echo __('Close Date');?>:</th>
                    <td><?php echo Format::datetime($ticket->getCloseDate()); ?></td>
                </tr>
                <?php
                }
                ?>
            </table>
        </td>
        <td width="50%">
            <table cellspacing="0" cellpadding="4" width="100%" border="0">
                <?php if (false) { /* ZK: Tópico de ajuda removido do cabeçalho a pedido (2026-07-07) */ ?>
                <tr>
                    <th width="100"><?php echo __('Help Topic');?>:</th>
                      <?php
                           if ($role->hasPerm(Ticket::PERM_EDIT)) {
                               $topic = $ticket->getField('topic'); ?>
                             <td>
                        <a class="inline-edit" data-placement="bottom"
                            data-toggle="tooltip" title="<?php echo __('Update'); ?>"
                            href="#tickets/<?php echo $ticket->getId(); ?>/field/topic/edit">
                            <span id="field_topic">
                                <?php echo $ticket->getHelpTopic() ?: __('None'); ?>
                            </span>
                        </a>
                      </td>
                        <?php } else { ?>
                             <td><?php echo Format::htmlchars($ticket->getHelpTopic()); ?></td>
                        <?php } ?>
                </tr>
                <?php } /* ZK: fim Tópico de ajuda removido */ ?>
                <tr>
                    <th nowrap><?php echo __('Last Message');?>:</th>
                    <td><?php echo Format::datetime($ticket->getLastMsgDate()); ?></td>
                </tr>
                <tr>
                    <th nowrap><?php echo __('Last Response');?>:</th>
                    <td><?php echo Format::datetime($ticket->getLastRespDate()); ?></td>
                </tr>
            </table>
        </td>
    </tr>
</table>
</div><?php /* /.zk-info-cols */ ?>
<br>
<?php
foreach (DynamicFormEntry::forTicket($ticket->getId()) as $form) {
    $form->addMissingFields();
    //Find fields to exclude if disabled by help topic
    $disabled = Ticket::getMissingRequiredFields($ticket, true);

    // Skip core fields shown earlier in the ticket view
    // TODO: Rewrite getAnswers() so that one could write
    //       ->getAnswers()->filter(not(array('field__name__in'=>
    //           array('email', ...))));
    $answers = $form->getAnswers()->exclude(Q::any(array(
        'field__flags__hasbit' => DynamicFormField::FLAG_EXT_STORED,
        'field__name__in' => array('subject', 'priority'),
        'field__id__in' => $disabled,
    )));
    $displayed = array();
    $hasContent = false;   // ZK: algum campo visível tem valor?
    $hasRequired = false;  // ZK: algum campo é obrigatório p/ fechar?
    foreach($answers as $a) {
        $f = $a->getField();
        if (!$f->isVisibleToStaff())
            continue;
        $displayed[] = $a;
        if (Format::striptags($a->display()) !== '')
            $hasContent = true;
        if ($f->isRequiredForClose())
            $hasRequired = true;
    }
    if (count($displayed) == 0)
        continue;
    // ZK: se a seção inteira está vazia e não tem campo obrigatório p/ fechar,
    // não renderiza — evita ocupar a tela com "—Vazio—" (ex.: o campo
    // "Observações" do form do ticket, que este projeto não coleta). Volta a
    // aparecer sozinha assim que qualquer campo for preenchido.
    if (!$hasContent && !$hasRequired)
        continue;
    ?>
    <table class="ticket_info custom-data" cellspacing="0" cellpadding="0" width="940" border="0">
    <thead>
        <th colspan="2"><?php echo Format::htmlchars($form->getTitle()); ?></th>
    </thead>
    <tbody>
<?php
    foreach ($displayed as $a) {
        $id =  $a->getLocal('id');
        $label = $a->getLocal('label');
        $field = $a->getField();
        $config = $field->getConfiguration();
        $html = isset($config['html']) ? $config['html'] : false;
        $v = $html ? Format::striptags($a->display()) : $a->display();
        $class = (Format::striptags($v)) ? '' : 'class="faded"';
        $clean = (Format::striptags($v))
                ? ($html ? Format::striptags($v) : $v)
                : '&mdash;' . str_replace('Esvaziar', 'Vazio', __('Empty')) . '&mdash;'; // ZK: corrige tradução pt-BR "Esvaziar"->"Vazio"
        $isFile = ($field instanceof FileUploadField);
        $url = "#tickets/".$ticket->getId()."/field/".$id;
?>
        <tr>
            <td width="200"><?php echo Format::htmlchars($label); ?>:</td>
            <td id="<?php echo sprintf('inline-answer-%s', $field->getId()); ?>">
            <?php if ($role->hasPerm(Ticket::PERM_EDIT)
                    && $field->isEditableToStaff()) {
                    $isEmpty = strpos($v, 'Empty') || ($v == '');
                    if ($isFile && !$isEmpty) {
                        echo sprintf('<span id="field_%s" %s >%s</span><br>', $id,
                            $class,
                            $clean);
                    }
                    $title = ($html && !$isEmpty) ? __('View Content') : __('Update');
                    $href = $url.(($html && !$isEmpty) ? '/view' : '/edit');
                         ?>
                  <a class="inline-edit" data-placement="bottom" data-toggle="tooltip" title="<?php echo $title; ?>"
                      href="<?php echo $href; ?>">
                  <?php
                    if ($isFile && !$isEmpty) {
                      echo "<i class=\"icon-edit\"></i>";
                    } elseif (strlen($v) > 200) {
                      $clean = Format::truncate($v, 200);
                      echo sprintf('<span id="field_%s" %s >%s</span>', $id, $class, $clean);
                      echo "<br><i class=\"icon-edit\"></i>";
                    } else
                        echo sprintf('<span id="field_%s" %s >%s</span>', $id, $class, $clean);

                    $a = $field->getAnswer();
                    $hint = ($field->isRequiredForClose() && $a && !$a->getValue() && get_class($field) != 'BooleanField') ?
                        sprintf('<i class="icon-warning-sign help-tip warning field-label" data-title="%s" data-content="%s"
                        /></i>', __('Required to close ticket'),
                        __('Data is required in this field in order to close the related ticket')) : '';
                    echo $hint;
                  ?>
              </a>
            <?php
            } else {
                echo $clean;
            } ?>
            </td>
        </tr>
<?php } ?>
    </tbody>
    </table>
<?php } ?>
<div class="clear"></div>

<?php /* ZK-EQUIP:BEGIN — painel editável de equipamentos (ZKTeco) */
if (function_exists('zk_equipment_staff_panel')) zk_equipment_staff_panel($ticket);
/* ZK-EQUIP:END */ ?>

<?php
$tcount = $ticket->getThreadEntries($types) ? $ticket->getThreadEntries($types)->count() : 0;
?>
<ul  class="tabs clean threads" id="ticket_tabs" >
    <li class="active"><a id="ticket-thread-tab" href="#ticket_thread"><?php
        echo sprintf(__('Ticket Thread (%d)'), $tcount); ?></a></li>
    <li><a id="ticket-tasks-tab" href="#tasks"
            data-url="<?php
        echo sprintf('#tickets/%d/tasks', $ticket->getId()); ?>"><?php
        echo __('Tasks');
        if ($ticket->getNumTasks())
            echo sprintf('&nbsp;(<span id="ticket-tasks-count">%d</span>)', $ticket->getNumTasks());
        ?></a></li>
    <?php
    if ((count($children) != 0 || $ticket->isChild())) { ?>
    <li><a href="#relations" id="ticket-relations-tab"
        data-url="<?php
        echo sprintf('#tickets/%d/relations', $ticket->getId()); ?>"
        ><?php echo __('Related Tickets');
        if (count($children))
            echo sprintf('&nbsp;(<span id="ticket-relations-count">%d</span>)', count($children));
        elseif ($ticket->isChild())
            echo sprintf('&nbsp;(<span id="ticket-relations-count">%d</span>)', 1);
        ?></a></li>
    <?php
    }
    ?>

</ul>

<div id="ticket_tabs_container">
<div id="ticket_thread" class="tab_content">

<?php
    // Render ticket thread
    if ($thread)
        $thread->render(
                array('M', 'R', 'N'),
                array(
                    'html-id'   => 'ticketThread',
                    'mode'      => Thread::MODE_STAFF,
                    'sort'      => $thisstaff->thread_view_order
                    )
                );
?>
<div class="clear"></div>
<?php
if ($errors['err'] && isset($_POST['a'])) {
    // Reflect errors back to the tab.
    $errors[$_POST['a']] = $errors['err'];
}
// ZK: o aviso ($warn / "Marcado em atraso!") foi movido para o topo (após o
// assunto). Não é mais exibido aqui no fim.
?>

<div class="sticky bar stop actions" id="response_options"
>
    <ul class="tabs" id="response-tabs">
        <?php
        if ($role->hasPerm(Ticket::PERM_REPLY) && !($blockReply)) { ?>
        <li class="active <?php
            echo isset($errors['reply']) ? 'error' : ''; ?>"><a
            href="#reply" id="post-reply-tab"><?php echo __('Post Reply');?></a></li>
        <?php
        }
        if (false /* ZK: aba "Publicar Nota Interna" oculta no painel do agente */ && !($blockReply)) { ?>
        <li><a href="#note" <?php
            echo isset($errors['postnote']) ?  'class="error"' : ''; ?>
            id="post-note-tab"><?php echo __('Post Internal Note');?></a></li>
        <?php
        } ?>
    </ul>
    <?php
    if ($role->hasPerm(Ticket::PERM_REPLY) && !($blockReply)) {
        // ZK: $replyTo/$emailReply removidos (2026-08-20) — só alimentavam
        // o seletor "Responder a", que não existe mais (reply-to é fixo
        // em "all", via input hidden mais abaixo).
        ?>
    <form id="reply" class="tab_content spellcheck exclusive save"
        data-lock-object-id="ticket/<?php echo $ticket->getId(); ?>"
        data-lock-id="<?php echo $mylock ? $mylock->getId() : ''; ?>"
        action="tickets.php?id=<?php
        echo $ticket->getId(); ?>#reply" name="reply" method="post" enctype="multipart/form-data">
        <?php csrf_token(); ?>
        <input type="hidden" name="id" value="<?php echo $ticket->getId(); ?>">
        <input type="hidden" name="msgId" value="<?php echo $msgId; ?>">
        <input type="hidden" name="a" value="reply">
        <input type="hidden" name="lockCode" value="<?php echo $mylock ? $mylock->getCode() : ''; ?>">
        <?php /* ZK: "Responder a" removido do formulário — sempre envia
           para todos os destinatários ativos (dono do chamado + Cc). */ ?>
        <input type="hidden" name="reply-to" value="all">
        <table style="width:100%" border="0" cellspacing="0" cellpadding="3">
            <?php
            if ($errors['reply']) {?>
            <tr><td width="120">&nbsp;</td><td class="error"><?php echo $errors['reply']; ?>&nbsp;</td></tr>
            <?php
            }?>
           <tbody id="to_sec">
           <tr>
               <td width="120">
                   <label><strong><?php echo __('From'); ?>:</strong></label>
               </td>
               <td>
                   <select id="from_email_id" name="from_email_id">
                     <?php
                     // Department email (default).
                     if (($e=$dept->getEmail())) {
                        echo sprintf('<option value="%s" selected="selected">%s</option>',
                                 $e->getId(),
                                 Format::htmlchars($e->getAddress()));
                     }
                     $staffDepts = $thisstaff->getDepts();
                     if (in_array($cfg->getDefaultDeptId(), $staffDepts))
                         $staffDepts[] = 0;
                     // Optional SMTP addreses user can send email via
                     if (($emails = Email::getAddresses(array('smtp' => true,
                                 'depts' => $staffDepts), false)) && count($emails)) {
                         $emailId = $_POST['from_email_id'] ?: 0;
                         foreach ($emails as $e) {
                             if ($dept->getEmail()->getId() == $e->getId())
                                 continue;
                             echo sprintf('<option value="%s" %s>%s</option>',
                                     $e->getId(),
                                      $e->getId() == $emailId ?
                                      'selected="selected"' : '',
                                      Format::htmlchars($e->getAddress()));
                         }
                     }
                     ?>
                   </select>
               </td>
           </tr>
            </tbody>
            <tbody id="recipients">
             <tr id="user-row">
                <td width="120">
                    <label><strong><?php echo __('Recipients'); ?>:</strong></label>
                </td>
                <td><a href="#tickets/<?php echo $ticket->getId(); ?>/user"
                    onclick="javascript:
                        $.userLookup('ajax.php/tickets/<?php echo $ticket->getId(); ?>/user',
                                function (user) {
                                    window.location = 'tickets.php?id='<?php $ticket->getId(); ?>
                                });
                        return false;
                        "><span ><?php
                            echo Format::htmlchars($ticket->getOwner()->getEmail()->getAddress());
                    ?></span></a>
                </td>
              </tr>
              <?php /* ZK: gerenciador completo de colaboradores (buscar
                 usuário existente, ativar/desativar) substituído por um
                 campo simples de Cc — cada resposta define seu próprio Cc
                 (ver app/scp/tickets.php, case 'reply'). */ ?>
              <tr>
                <td width="120">
                    <label><?php echo __('Cc'); ?>:</label>
                </td>
                <td>
                    <input type="text" id="cc_emails" name="cc_emails"
                        value="<?php echo Format::htmlchars($_POST['cc_emails'] ?? '', true); ?>"
                        placeholder="<?php echo __('E-mails em cópia, separados por vírgula'); ?>"
                        autocomplete="off">
                    <span class="error">&nbsp;&nbsp;<?php echo $errors['cc_emails']; ?></span>
                </td>
              </tr>
            </tbody>
            <tbody id="resp_sec">
            <tr><td colspan="2">&nbsp;</td></tr>
            <tr>
                <td colspan="2">
                <?php
                // ZK: campo "Resposta pronta" (canned response) removido do
                // formulário — o editor abaixo ocupa a linha inteira.
                if ($errors['response'])
                    echo sprintf('<div class="error">%s</div>',
                            $errors['response']);

                    $signature = '';
                    switch ($thisstaff->getDefaultSignatureType()) {
                    case 'dept':
                        if ($dept && $dept->canAppendSignature())
                           $signature = $dept->getSignature();
                       break;
                    case 'mine':
                        $signature = $thisstaff->getSignature();
                        break;
                    } ?>
                    <input type="hidden" name="draft_id" value=""/>
                    <br/>
                    <textarea name="response" id="response" cols="50"
                        data-signature-field="signature" data-dept-id="<?php echo $dept->getId(); ?>"
                        data-signature="<?php
                            echo Format::htmlchars(Format::viewableImages($signature)); ?>"
                        placeholder="<?php echo __(
                        'Start writing your response here'
                        ); ?>"
                        rows="9" wrap="soft"
                        class="<?php if ($cfg->isRichTextEnabled()) echo 'richtext';
                            ?> zk-basic-editor draft draft-delete fullscreen" <?php
    list($draft, $attrs) = Draft::getDraftAndDataAttrs('ticket.response', $ticket->getId(), $info['response']);
    echo $attrs; ?>><?php echo ThreadEntryBody::clean($_POST ? $info['response'] : $draft);
                    ?></textarea>
                <div id="reply_form_attachments" class="attachments">
                <?php
                    print $response_form->getField('attachments')->render();
                ?>
                </div>
                </td>
            </tr>
            <tr>
                <td width="120">
                    <label for="signature" class="left"><?php echo __('Signature');?>:</label>
                </td>
                <td>
                    <?php
                    $info['signature']=$info['signature']?$info['signature']:$thisstaff->getDefaultSignatureType();
                    ?>
                    <label><input type="radio" name="signature" value="none" checked="checked"> <?php echo __('None');?></label>
                    <?php
                    if($thisstaff->getSignature()) {?>
                    <label><input type="radio" name="signature" value="mine"
                        <?php echo ($info['signature']=='mine')?'checked="checked"':''; ?>> <?php echo __('My Signature');?></label>
                    <?php
                    } ?>
                    <?php
                    if($dept && $dept->canAppendSignature()) { ?>
                    <label><input type="radio" name="signature" value="dept"
                        <?php echo ($info['signature']=='dept')?'checked="checked"':''; ?>>
                        <?php echo sprintf(__('Department Signature (%s)'), Format::htmlchars($dept->getName())); ?></label>
                    <?php
                    } ?>
                </td>
            </tr>
            <tr>
                <td width="120" style="vertical-align:top">
                    <label><strong><?php echo __('Ticket Status');?>:</strong></label>
                </td>
                <td>
                    <?php
                    $outstanding = false;
                    if ($role->hasPerm(Ticket::PERM_CLOSE)
                            && is_string($warning=$ticket->isCloseable())) {
                        $outstanding =  true;
                        echo sprintf('<div class="warning-banner">%s</div>', $warning);
                    } ?>
                    <select name="reply_status_id">
                    <?php
                    $statusId = $info['reply_status_id'] ?: $ticket->getStatusId();
                    $states = array('open');
                    if ($role->hasPerm(Ticket::PERM_CLOSE) && !$outstanding)
                        $states = array_merge($states, array('closed'));

                    foreach (TicketStatusList::getStatuses(
                                array('states' => $states)) as $s) {
                        if (!$s->isEnabled()) continue;
                        $selected = ($statusId == $s->getId());
                        echo sprintf('<option value="%d" %s>%s%s</option>',
                                $s->getId(),
                                $selected
                                 ? 'selected="selected"' : '',
                                __($s->getName()),
                                $selected
                                ? (' ('.__('current').')') : ''
                                );
                    }
                    ?>
                    </select>
                </td>
            </tr>
         </tbody>
        </table>
        <p  style="text-align:center;">
            <input class="save pending" type="submit" value="<?php echo __('Post Reply');?>">
            <input class="" type="reset" value="<?php echo __('Reset');?>">
        </p>
    </form>
    <?php
    }
    if (false /* ZK: form de "Nota Interna" não renderizado (aba removida) */ && !($blockReply)) {
    ?>
    <form id="note" class="hidden tab_content spellcheck exclusive save"
        data-lock-object-id="ticket/<?php echo $ticket->getId(); ?>"
        data-lock-id="<?php echo $mylock ? $mylock->getId() : ''; ?>"
        action="tickets.php?id=<?php echo $ticket->getId(); ?>#note"
        name="note" method="post" enctype="multipart/form-data">
        <?php csrf_token(); ?>
        <input type="hidden" name="id" value="<?php echo $ticket->getId(); ?>">
        <input type="hidden" name="locktime" value="<?php echo $cfg->getLockTime() * 60; ?>">
        <input type="hidden" name="a" value="postnote">
        <input type="hidden" name="lockCode" value="<?php echo $mylock ? $mylock->getCode() : ''; ?>">
        <table width="100%" border="0" cellspacing="0" cellpadding="3">
            <?php
            if($errors['postnote']) {?>
            <tr>
                <td width="120">&nbsp;</td>
                <td class="error"><?php echo $errors['postnote']; ?></td>
            </tr>
            <?php
            } ?>
            <tr>
                <td width="120" style="vertical-align:top">
                    <label><strong><?php echo __('Internal Note'); ?>:</strong><span class='error'>&nbsp;*</span></label>
                </td>
                <td>
                    <div>
                        <div class="faded" style="padding-left:0.15em"><?php
                        echo __('Note title - summary of the note (optional)'); ?></div>
                        <input type="text" name="title" id="title" size="60" value="<?php echo $info['title']; ?>" >
                        <br/>
                        <span class="error">&nbsp;<?php echo $errors['title']; ?></span>
                    </div>
                </td></tr>
                <tr><td colspan="2">
                    <div class="error"><?php echo $errors['note']; ?></div>
                    <textarea name="note" id="internal_note" cols="80"
                        placeholder="<?php echo __('Note details'); ?>"
                        rows="9" wrap="soft"
                        class="<?php if ($cfg->isRichTextEnabled()) echo 'richtext';
                            ?> draft draft-delete fullscreen" <?php
    list($draft, $attrs) = Draft::getDraftAndDataAttrs('ticket.note', $ticket->getId(), $info['note']);
    echo $attrs; ?>><?php echo ThreadEntryBody::clean($_POST ? $info['note'] : $draft);
                        ?></textarea>
                <div class="attachments">
                <?php
                    print $note_form->getField('attachments')->render();
                ?>
                </div>
                </td>
            </tr>
            <tr><td colspan="2">&nbsp;</td></tr>
            <tr>
                <td width="120">
                    <label><?php echo __('Ticket Status');?>:</label>
                </td>
                <td>
                    <div class="faded"></div>
                    <select name="note_status_id">
                        <?php
                        $statusId = $info['note_status_id'] ?: $ticket->getStatusId();
                        $states = array('open');
                        if ($ticket->isCloseable() === true
                                && $role->hasPerm(Ticket::PERM_CLOSE))
                            $states = array_merge($states, array('closed'));
                        foreach (TicketStatusList::getStatuses(
                                    array('states' => $states)) as $s) {
                            if (!$s->isEnabled()) continue;
                            $selected = $statusId == $s->getId();
                            echo sprintf('<option value="%d" %s>%s%s</option>',
                                    $s->getId(),
                                    $selected ? 'selected="selected"' : '',
                                    __($s->getName()),
                                    $selected ? (' ('.__('current').')') : ''
                                    );
                        }
                        ?>
                    </select>
                    &nbsp;<span class='error'>*&nbsp;<?php echo $errors['note_status_id']; ?></span>
                </td>
            </tr>
        </table>

       <p style="text-align:center;">
           <input class="save pending" type="submit" value="<?php echo __('Post Note');?>">
           <input class="" type="reset" value="<?php echo __('Reset');?>">
       </p>
   </form>
   <?php } ?>
 </div>
 </div>
</div>
<div style="display:none;" class="dialog" id="print-options">
    <h3><?php echo __('Ticket Print Options');?></h3>
    <a class="close" href=""><i class="icon-remove-circle"></i></a>
    <hr/>
    <form action="tickets.php?id=<?php echo $ticket->getId(); ?>"
        method="post" id="print-form" name="print-form" target="_blank">
        <?php csrf_token(); ?>
        <input type="hidden" name="a" value="print">
        <input type="hidden" name="id" value="<?php echo $ticket->getId(); ?>">
        <fieldset class="notes">
            <label class="fixed-size" for="notes"><?php echo __('Print Notes');?>:</label>
            <label class="inline checkbox">
            <input type="checkbox" id="notes" name="notes" value="1"> <?php echo __('Print <b>Internal</b> Notes/Comments');?>
            </label>
        </fieldset>
        <fieldset class="events">
            <label class="fixed-size" for="events"><?php echo __('Print Events');?>:</label>
            <label class="inline checkbox">
            <input type="checkbox" id="events" name="events" value="1"> <?php echo __('Print Thread Events');?>
            </label>
        </fieldset>
        <fieldset>
            <label class="fixed-size" for="psize"><?php echo __('Paper Size');?>:</label>
            <select id="psize" name="psize">
                <option value="">&mdash; <?php echo __('Select Print Paper Size');?> &mdash;</option>
                <?php
                  $psize =$_SESSION['PAPER_SIZE']?$_SESSION['PAPER_SIZE']:$thisstaff->getDefaultPaperSize();
                  foreach(Export::$paper_sizes as $v) {
                      echo sprintf('<option value="%s" %s>%s</option>',
                                $v,($psize==$v)?'selected="selected"':'', __($v));
                  }
                ?>
            </select>
        </fieldset>
        <hr style="margin-top:3em"/>
        <p class="full-width">
            <span class="buttons pull-left">
                <input type="reset" value="<?php echo __('Reset');?>">
                <input type="button" value="<?php echo __('Cancel');?>" class="close">
            </span>
            <span class="buttons pull-right">
                <input type="submit" value="<?php echo __('Print');?>">
            </span>
         </p>
    </form>
    <div class="clear"></div>
</div>
<div style="display:none;" class="dialog" id="confirm-action">
    <h3><?php echo __('Please Confirm');?></h3>
    <a class="close" href=""><i class="icon-remove-circle"></i></a>
    <hr/>
    <p class="confirm-action" style="display:none;" id="claim-confirm">
        <?php echo sprintf(__('Are you sure you want to <b>claim</b> (self assign) %s?'), __('this ticket'));?>
    </p>
    <p class="confirm-action" style="display:none;" id="answered-confirm">
        <?php echo __('Are you sure you want to flag the ticket as <b>answered</b>?');?>
    </p>
    <p class="confirm-action" style="display:none;" id="unanswered-confirm">
        <?php echo __('Are you sure you want to flag the ticket as <b>unanswered</b>?');?>
    </p>
    <p class="confirm-action" style="display:none;" id="overdue-confirm">
        <?php echo __('Are you sure you want to flag the ticket as <font color="red"><b>overdue</b></font>?');?>
    </p>
    <p class="confirm-action" style="display:none;" id="banemail-confirm">
        <?php echo sprintf(__('Are you sure you want to <b>ban</b> %s?'), $ticket->getEmail());?> <br><br>
        <?php echo __('New tickets from the email address will be automatically rejected.');?>
    </p>
    <p class="confirm-action" style="display:none;" id="unbanemail-confirm">
        <?php echo sprintf(__('Are you sure you want to <b>remove</b> %s from ban list?'), $ticket->getEmail()); ?>
    </p>
    <p class="confirm-action" style="display:none;" id="release-confirm">
        <?php echo sprintf(__('Are you sure you want to <b>unassign</b> ticket from <b>%s</b>?'), $ticket->getAssigned()); ?>
    </p>
    <p class="confirm-action" style="display:none;" id="changeuser-confirm">
        <span id="msg_warning" style="display:block;vertical-align:top">
        <?php echo sprintf(Format::htmlchars(__('%s <%s> will no longer have access to the ticket')),
            '<b>'.Format::htmlchars($ticket->getName()).'</b>', Format::htmlchars($ticket->getEmail())); ?>
        </span>
        <?php echo sprintf(__('Are you sure you want to <b>change</b> ticket owner to %s?'),
            '<b><span id="newuser">this guy</span></b>'); ?>
    </p>
    <p class="confirm-action" style="display:none;" id="delete-confirm">
        <font color="red"><strong><?php echo sprintf(
            __('Are you sure you want to DELETE %s?'), __('this ticket'));?></strong></font>
        <br><br><?php echo __('Deleted data CANNOT be recovered, including any associated attachments.');?>
    </p>
    <div><?php echo __('Please confirm to continue.');?></div>
    <form action="tickets.php?id=<?php echo $ticket->getId(); ?>" method="post" id="confirm-form" name="confirm-form">
        <?php csrf_token(); ?>
        <input type="hidden" name="id" value="<?php echo $ticket->getId(); ?>">
        <input type="hidden" name="a" value="process">
        <input type="hidden" name="do" id="action" value="">
        <hr style="margin-top:1em"/>
        <p class="full-width">
            <span class="buttons pull-left">
                <input type="button" value="<?php echo __('Cancel');?>" class="close">
            </span>
            <span class="buttons pull-right">
                <input type="submit" value="<?php echo __('OK');?>">
            </span>
         </p>
    </form>
    <div class="clear"></div>
</div>
<script type="text/javascript">
$(function() {
    $(document).on('click', 'a.change-user', function(e) {
        e.preventDefault();
        var tid = <?php echo $ticket->getOwnerId(); ?>;
        var cid = <?php echo $ticket->getOwnerId(); ?>;
        var url = 'ajax.php/'+$(this).attr('href').substr(1);
        $.userLookup(url, function(user) {
            if(cid!=user.id
                    && $('.dialog#confirm-action #changeuser-confirm').length) {
                $('#newuser').html(user.name +' &lt;'+user.email+'&gt;');
                $('.dialog#confirm-action #action').val('changeuser');
                $('#confirm-form').append('<input type=hidden name=user_id value='+user.id+' />');
                $('#overlay').show();
                $('.dialog#confirm-action .confirm-action').hide();
                $('.dialog#confirm-action p#changeuser-confirm')
                .show()
                .parent('div').show().trigger('click');
            }
        });
    });

    $(document).on('click', 'a.manage-collaborators', function(e) {
        e.preventDefault();
        var url = 'ajax.php/'+$(this).attr('href').substr(1);
        $.dialog(url, 201, function (xhr) {
           var resp = $.parseJSON(xhr.responseText);
           if (resp.user && !resp.users)
              resp.users.push(resp.user);
            // TODO: Process resp.users
           $('.tip_box').remove();
        }, {
            onshow: function() { $('#user-search').focus(); }
        });
        return false;
     });

    // Post Reply or Note action buttons.
    $('a.post-response').click(function (e) {
        var $r = $('ul.tabs > li > a'+$(this).attr('href')+'-tab');
        if ($r.length) {
            // Make sure ticket thread tab is visiable.
            var $t = $('ul#ticket_tabs > li > a#ticket-thread-tab');
            if ($t.length && !$t.hasClass('active'))
                $t.trigger('click');
            // Make the target response tab active.
            if (!$r.hasClass('active'))
                $r.trigger('click');

            // Scroll to the response section.
            var $stop = $(document).height();
            var $s = $('div#response_options');
            if ($s.length)
                $stop = $s.offset().top-125

            $('html, body').animate({scrollTop: $stop}, 'fast');
        }

        return false;
    });

  $('#show_ccs').click(function() {
    var show = $('#arrow-icon');
    var collabs = $('a#managecollabs');
    $('#ccs').slideToggle('fast', function(){
        if ($(this).is(":hidden")) {
            collabs.hide();
            show.removeClass('icon-caret-down').addClass('icon-caret-right');
        } else {
            collabs.show();
            show.removeClass('icon-caret-right').addClass('icon-caret-down');
        }
    });
    return false;
   });

  $('.collaborators.noclick').click(function() {
    $('#show_ccs').trigger('click');
   });

  $('#collabselection').select2({
    width: '350px',
    allowClear: true,
    sorter: function(data) {
        return data.filter(function (item) {
                return !item.selected;
                });
    },
    templateResult: function(e) {
        var $e = $(
        '<span><i class="icon-user"></i> ' + e.text + '</span>'
        );
        return $e;
    }
   }).on("select2:unselecting", function(e) {
        if (!confirm(__("Are you sure you want to DISABLE the collaborator?")))
            e.preventDefault();
   }).on("select2:selecting", function(e) {
        if (!confirm(__("Are you sure you want to ENABLE the collaborator?")))
             e.preventDefault();
   }).on('change', function(e) {
    var id = e.currentTarget.id;
    var count = $('li.select2-selection__choice').length;
    var total = $('#' + id +' option').length;
    $('.' + id + '__count').html(count);
    $('.' + id + '__total').html(total);
    $('.' + id + '__total').parent().toggle((total));
   }).on('select2:opening select2:closing', function(e) {
    $(this).parent().find('.select2-search__field').prop('disabled', true);
   });
});
function saveDraft() {
    redactor = $('#response').redactor('plugin.draft');
    if (redactor.opts.draftId)
        $('#response').redactor('plugin.draft.saveDraft');
}
</script>
