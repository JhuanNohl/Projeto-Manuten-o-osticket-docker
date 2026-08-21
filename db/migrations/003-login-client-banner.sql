-- ============================================================================
--  003-login-client-banner.sql
--  Enxuga o texto do cartão de login do cliente (tabela ost_content,
--  registro type='banner-client', id=15) — o parágrafo era longo e
--  redundante com o título "Bem-vindo" acima e o botão "Criar minha
--  conta" abaixo. Ver app/include/client/login.inc.php.
--
--  IMPORTANTE: este arquivo é só o registro/versionamento da mudança. O
--  banco (volume db_data) já existe e é populado apenas no PRIMEIRO boot
--  a partir de db/init/*.sql — este script precisa ser aplicado manualmente
--  contra o container vivo, ex.:
--    docker exec -i osticket-db mariadb -uroot -p"<DB_ROOT_PASSWORD>" \
--      zkteco_manutencao < db/migrations/003-login-client-banner.sql
-- ============================================================================

UPDATE ost_content
   SET body='Acesse sua conta ou crie uma nova para continuar.',
       updated=NOW()
 WHERE type='banner-client';
