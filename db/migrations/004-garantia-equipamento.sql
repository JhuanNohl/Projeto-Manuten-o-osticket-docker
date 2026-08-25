-- ============================================================================
--  004-garantia-equipamento.sql
--  Novo campo "Garantia" por equipamento (ost_zk_equipment). O cliente
--  declara na abertura do chamado se está solicitando garantia ou não; se
--  solicitar, nasce como "em_analise" até o setor de manutenção receber o
--  equipamento, confirmar o Nº de Série e aprovar/recusar.
--  Ver app/include/zk_equipment.php (zk_equip_garantias() e afins).
--
--  IMPORTANTE: este arquivo é só o registro/versionamento da mudança. O
--  banco (volume db_data) já existe e é populado apenas no PRIMEIRO boot
--  a partir de db/init/*.sql — este script precisa ser aplicado manualmente
--  contra o container vivo, ex.:
--    docker exec -i osticket-db mariadb -uroot -p"<DB_ROOT_PASSWORD>" \
--      zkteco_manutencao < db/migrations/004-garantia-equipamento.sql
-- ============================================================================

ALTER TABLE ost_zk_equipment
  ADD COLUMN garantia varchar(32) NOT NULL DEFAULT 'nao_solicitada' AFTER pendencia,
  ADD KEY garantia (garantia);
