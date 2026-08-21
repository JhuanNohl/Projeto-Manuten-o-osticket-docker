<?php
if($nav && ($tabs=$nav->getTabs()) && is_array($tabs)){
    foreach($tabs as $name =>$tab) {
        if (!empty($tab['hidden']))
            continue;
        if ($tab['href'][0] != '/')
            $tab['href'] = ROOT_PATH . 'scp/' . $tab['href'];
        echo sprintf('<li class="%s %s"><a href="%s">%s</a>',
            isset($tab['active']) ? 'active':'inactive',
            @$tab['class'] ?: '',
            $tab['href'],$tab['desc']);
        if(!isset($tab['active']) && ($subnav=$nav->getSubMenu($name))){
            echo "<ul>\n";
            foreach($subnav as $k => $item) {
                if (isset($item['id']) && !($id=$item['id']))
                    $id="nav$k";
                if ($item['href'][0] != '/')
                    $item['href'] = ROOT_PATH . 'scp/' . $item['href'];

                echo sprintf(
                    '<li><a class="%s" href="%s" title="%s" id="%s">%s</a></li>',
                    $item['iconclass'],
                    $item['href'], $item['title'] ?? null,
                    $id ?? null, $item['desc']);
            }
            echo "\n</ul>\n";
        }
        echo "\n</li>\n";

        // ZK: badge "Início" (2026-08-21) — ao lado de Visão geral/Manutenções.
        // Com os chips de fila (Etapas Operacionais/Finalizados) removidos do
        // submenu de Manutenções, este é o atalho de volta pra fila padrão —
        // diferente de só clicar em "Manutenções", que herda a última fila/
        // busca guardada na sessão (ver $_SESSION[$queue_key] em tickets.php).
        if ($name === 'tickets') {
            global $thisstaff, $cfg;
            $home_qid = $thisstaff->getDefaultTicketQueueId() ?: $cfg->getDefaultTicketQueueId();
            echo sprintf(
                '<li class="zk-nav-home"><a href="%sscp/tickets.php?id=%d" title="%s"><i class="glyphicon glyphicon-home"></i></a></li>',
                ROOT_PATH, $home_qid, __('Início das Manutenções'));
        }
    }
} ?>
