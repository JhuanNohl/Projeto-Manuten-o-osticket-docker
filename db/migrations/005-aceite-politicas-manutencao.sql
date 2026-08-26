-- ============================================================================
--  005-aceite-politicas-manutencao.sql
--  Registro de aceite das Políticas de Manutenção no primeiro acesso
--  (criação de conta do cliente). Guarda uma prova auditável (quem, quando,
--  de qual IP/user-agent e quais documentos) para evitar contestação
--  posterior em caso de desistência do procedimento de manutenção.
--  Ver app/account.php (criação da conta) e
--  app/include/client/register.inc.php (checkbox obrigatório).
--
--  IMPORTANTE: este arquivo é só o registro/versionamento da mudança. O
--  banco (volume db_data) já existe e é populado apenas no PRIMEIRO boot
--  a partir de db/init/*.sql — este script precisa ser aplicado manualmente
--  contra o container vivo, ex.:
--    docker exec -i osticket-db mariadb -uroot -p"<DB_ROOT_PASSWORD>" \
--      zkteco_manutencao < db/migrations/005-aceite-politicas-manutencao.sql
-- ============================================================================

CREATE TABLE IF NOT EXISTS `ost_zk_terms_acceptance` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned NOT NULL,
  `email` varchar(255) NOT NULL,
  `documents` varchar(255) NOT NULL,
  `ip_address` varchar(45) NOT NULL,
  `user_agent` varchar(255) NOT NULL,
  `accepted_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
