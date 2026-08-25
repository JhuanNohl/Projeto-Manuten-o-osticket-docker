<?php
/*********************************************************************
    class.turnstile.php

    CUSTOMIZAÇÃO ZKTeco (não faz parte do core). CAPTCHA Cloudflare
    Turnstile — substitui o CAPTCHA de imagem legado (class.captcha.php)
    nos formulários públicos (criação de conta e abertura de chamado).

    Chaves lidas de TURNSTILE_SITE_KEY / TURNSTILE_SECRET_KEY
    (include/ost-config.php, via .env). Enquanto vazias, isConfigured()
    retorna false: render() não desenha nada e verify() não bloqueia
    ninguém (mesmo espírito do isCaptchaEnabled() do core, que também só
    exige o campo quando os pré-requisitos estão presentes).
**********************************************************************/
if (!defined('INCLUDE_DIR')) die('Access Denied');

class Turnstile {

    static function isConfigured() {
        return defined('TURNSTILE_SITE_KEY') && TURNSTILE_SITE_KEY !== ''
            && defined('TURNSTILE_SECRET_KEY') && TURNSTILE_SECRET_KEY !== '';
    }

    static function render() {
        if (!self::isConfigured())
            return '';

        return '<div class="cf-turnstile" data-sitekey="'
             . Format::htmlchars(TURNSTILE_SITE_KEY) . '"></div>'
             . '<script src="https://challenges.cloudflare.com/turnstile/v0/api.js" async defer></script>';
    }

    /**
     * Verifica o token do widget (campo cf-turnstile-response, injetado
     * automaticamente pelo Turnstile no <form> que contém o widget) contra
     * a API da Cloudflare.
     *
     * Fail-CLOSED: qualquer chave ausente, erro de rede/cURL ou resposta
     * inesperada da Cloudflare é tratado como falha (bloqueia o envio) —
     * ao contrário de isConfigured()==false, que já é checado antes e
     * dispensa a chamada por completo.
     */
    static function verify($token, $remoteip = null) {
        if (!self::isConfigured())
            return true;
        if (!$token || !is_string($token))
            return false;
        if (!function_exists('curl_init'))
            return false;

        $ch = curl_init('https://challenges.cloudflare.com/turnstile/v0/siteverify');
        curl_setopt_array($ch, array(
            CURLOPT_POST           => true,
            CURLOPT_POSTFIELDS     => http_build_query(array(
                'secret'   => TURNSTILE_SECRET_KEY,
                'response' => $token,
                'remoteip' => $remoteip ?: $_SERVER['REMOTE_ADDR'],
            )),
            CURLOPT_RETURNTRANSFER => true,
            CURLOPT_CONNECTTIMEOUT => 5,
            CURLOPT_TIMEOUT        => 8,
            CURLOPT_SSL_VERIFYPEER => true,
        ));
        $res = curl_exec($ch);
        $err = curl_errno($ch);
        curl_close($ch);

        if ($err || !$res)
            return false;

        $data = json_decode($res, true);
        return is_array($data) && !empty($data['success']);
    }
}
?>
