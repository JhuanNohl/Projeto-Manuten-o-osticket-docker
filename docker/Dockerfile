# ============================================================================
#  osTicket ZKTeco — imagem PHP 8.2 + Apache (igual à versão do XAMPP atual)
#  osTicket v1.17.8 · PHP 8.2 · extensões exigidas pelo osTicket
#
#  Contexto de build = raiz do projeto (definido no docker-compose.yml).
#  - DEV: o docker-compose faz bind-mount de ./app por cima de /var/www/html.
#  - PROD: esta imagem já COPIA ./app (remova o bind-mount do compose).
#
#  As extensões são instaladas via "install-php-extensions" (mlocati), que
#  resolve sozinho as libs de sistema — inclusive o imap no Debian 12
#  (bookworm), onde o antigo libc-client-dev não existe mais.
# ============================================================================
FROM php:8.2-apache

# Instalador de extensões (trata dependências de sistema automaticamente)
ADD https://github.com/mlocati/docker-php-extension-installer/releases/latest/download/install-php-extensions /usr/local/bin/
RUN chmod +x /usr/local/bin/install-php-extensions \
    && install-php-extensions \
        mysqli pdo_mysql gd imap intl zip opcache gettext exif mbstring apcu curl

# Apache: rewrite/expires/headers
RUN a2enmod rewrite expires headers

# Configurações (PHP + vhost) — assadas na imagem (não vêm do bind-mount)
COPY docker/php-osticket.ini    /usr/local/etc/php/conf.d/zz-osticket.ini
COPY docker/apache-osticket.conf /etc/apache2/sites-available/000-default.conf

# Aplicação (para PROD). Em DEV o bind-mount de ./app sobrepõe isto.
COPY --chown=www-data:www-data app/ /var/www/html/

# ost-config.php somente-leitura (recomendação de segurança do osTicket)
RUN chown -R www-data:www-data /var/www/html \
    && if [ -f /var/www/html/include/ost-config.php ]; then \
         chmod 0644 /var/www/html/include/ost-config.php; \
       fi

EXPOSE 80
