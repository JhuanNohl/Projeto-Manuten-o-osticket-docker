<?php
/*********************************************************************
    index.php

    Helpdesk landing page. Please customize it to fit your needs.

    Peter Rotich <peter@osticket.com>
    Copyright (c)  2006-2013 osTicket
    http://www.osticket.com

    Released under the GNU General Public License WITHOUT ANY WARRANTY.
    See LICENSE.TXT for details.

    vim: expandtab sw=4 ts=4 sts=4:
**********************************************************************/
require('client.inc.php');

// Não há mais "página inicial" separada no portal do cliente: a tela de
// login (com o texto de boas-vindas) é a porta de entrada única. Este
// arquivo continua existindo só para não quebrar links/favoritos antigos
// para index.php — ele apenas redireciona para o lugar certo.
if ($thisclient && is_object($thisclient) && $thisclient->isValid() && !$thisclient->isGuest())
    Http::redirect('tickets.php');
else
    Http::redirect('login.php');
