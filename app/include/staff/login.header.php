<?php
defined('OSTSCPINC') or die('Invalid path');
header("Content-Security-Policy: frame-ancestors ".$cfg->getAllowIframes()."; script-src 'self' 'unsafe-inline'; object-src 'none'");
?>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
<head>
    <meta http-equiv="content-type" content="text/html; charset=utf-8" />
    <meta http-equiv="refresh" content="7200" />
    <title>Central de Manutenção :: <?php echo __('Agent Login'); ?></title>
    <link rel="stylesheet" href="css/login.css" type="text/css" />
    <?php /* ZK: skin ZKTeco por cima do login.css — incrementar o
       cache-buster a cada mudança (mesma regra do theme.css do cliente).
       ATENÇÃO: existe uma 2ª referência a zkteco-scp.css em
       include/staff/header.inc.php (painel logado) — bumpar as DUAS juntas,
       senão uma delas fica servindo CSS antigo do cache do navegador. */ ?>
    <link rel="stylesheet" href="css/zkteco-scp.css?zk20260821b" type="text/css" />
    <link type="text/css" rel="stylesheet" href="<?php echo ROOT_PATH; ?>css/font-awesome.min.css?a1114e5"/>
    <meta name="robots" content="noindex" />
    <meta http-equiv="cache-control" content="no-cache" />
    <meta http-equiv="pragma" content="no-cache" />
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="icon" type="image/png" href="<?php echo ROOT_PATH ?>images/oscar-favicon-32x32.png" sizes="32x32" />
    <link rel="icon" type="image/png" href="<?php echo ROOT_PATH ?>images/oscar-favicon-16x16.png" sizes="16x16" />
    <script type="text/javascript" src="<?php echo ROOT_PATH; ?>js/jquery-3.7.0.min.js?a1114e5"></script>
    <script type="text/javascript">
        $(document).ready(function() {
            $("input:not(.dp):visible:enabled:first").focus();
         });
    </script>
</head>
<body id="loginBody">

