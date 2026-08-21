-- ============================================================================
--  002-menu-manutencoes.sql
--  Reestrutura as filas de "Chamados" (tabela ost_queue) para o novo menu
--  de 3 abas (Visão geral | Manutenções | Clientes).
--
--  IMPORTANTE: este arquivo é só o registro/versionamento da mudança. O
--  banco (volume db_data) já existe e é populado apenas no PRIMEIRO boot
--  a partir de db/init/*.sql — este script precisa ser aplicado manualmente
--  contra o container vivo, ex.:
--    docker exec -i osticket-db mariadb -uroot -p"<DB_ROOT_PASSWORD>" \
--      zkteco_manutencao < db/migrations/002-menu-manutencoes.sql
-- ============================================================================

-- "Aberto" (id 1, raiz) passa a agrupar as etapas operacionais
UPDATE ost_queue SET title='Etapas Operacionais', updated=NOW() WHERE id=1;

-- Filhos antigos (Aberto/Respondidos/Atrasado) filtravam por resposta, não
-- por etapa — substituídos pelos status operacionais já cadastrados em
-- ost_ticket_status (Solicitado=1, Enviado=6, Recebido=7, Em manutenção=8)
DELETE FROM ost_queue WHERE id IN (2,3,4);

INSERT INTO ost_queue
  (parent_id, columns_id, sort_id, flags, staff_id, sort, title, config, filter, root, path, created, updated)
VALUES
  (1, NULL, NULL, 43, 0, 1, 'Solicitado',    '{"criteria":[["status__id","includes",{"1":"Solicitado"}]],"conditions":[]}',    NULL, 'T', '/', NOW(), NOW()),
  (1, NULL, NULL, 43, 0, 2, 'Enviado',       '{"criteria":[["status__id","includes",{"6":"Enviado"}]],"conditions":[]}',       NULL, 'T', '/', NOW(), NOW()),
  (1, NULL, NULL, 43, 0, 3, 'Recebido',      '{"criteria":[["status__id","includes",{"7":"Recebido"}]],"conditions":[]}',      NULL, 'T', '/', NOW(), NOW()),
  (1, NULL, NULL, 43, 0, 4, 'Em manutenção', '{"criteria":[["status__id","includes",{"8":"Em manutenção"}]],"conditions":[]}', NULL, 'T', '/', NOW(), NOW());

-- "Meus Chamados" (id 5) deixa de ser fila de topo e passa a ser mais um
-- filtro dentro de "Etapas Operacionais" (herda o "aberto" do pai — ver
-- Queue::getCriteria($include_parent=true) em include/class.queue.php)
UPDATE ost_queue
   SET title='Responsável: Eu',
       parent_id=1,
       sort=5,
       config='{"criteria":[["assignee","includes",{"M":"Me"}]],"conditions":[]}',
       updated=NOW()
 WHERE id=5;

-- Filhos antigos de "Meus Chamados" ficam redundantes com a simplificação
DELETE FROM ost_queue WHERE id IN (6,7);

-- "Encerrado" (id 8, raiz) só troca o rótulo — filhos (períodos) intactos
UPDATE ost_queue SET title='Finalizados', updated=NOW() WHERE id=8;
