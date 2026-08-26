-- ============================================================================
--  006-scroll-confirmado-termo.sql
--  Sinal adicional na prova de aceite do Termo de Garantia e Política de
--  Manutenção: registra se o cliente efetivamente rolou o termo completo
--  até o fim dentro do modal antes de aceitar (não é um controle de
--  segurança — é só reforço da evidência, já que o valor vem de um campo
--  oculto controlado por JavaScript no navegador do cliente).
--  Ver app/include/client/register.inc.php (modal) e app/account.php.
--
--  IMPORTANTE: este arquivo é só o registro/versionamento da mudança. O
--  banco (volume db_data) já existe e é populado apenas no PRIMEIRO boot
--  a partir de db/init/*.sql — este script precisa ser aplicado manualmente
--  contra o container vivo, ex.:
--    docker exec -i osticket-db mariadb -uroot -p"<DB_ROOT_PASSWORD>" \
--      zkteco_manutencao < db/migrations/006-scroll-confirmado-termo.sql
-- ============================================================================

ALTER TABLE ost_zk_terms_acceptance
  ADD COLUMN scrolled_confirmed tinyint(1) NOT NULL DEFAULT 0 AFTER documents;
