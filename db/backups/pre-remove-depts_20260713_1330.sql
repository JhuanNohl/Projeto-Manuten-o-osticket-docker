/*M!999999\- enable the sandbox mode */ 
-- MariaDB dump 10.19  Distrib 10.6.27-MariaDB, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: zkteco_manutencao
-- ------------------------------------------------------
-- Server version	10.6.27-MariaDB-ubu2204

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `ost__search`
--

DROP TABLE IF EXISTS `ost__search`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `ost__search` (
  `object_type` varchar(8) NOT NULL,
  `object_id` int(11) unsigned NOT NULL,
  `title` text DEFAULT NULL,
  `content` text DEFAULT NULL,
  PRIMARY KEY (`object_type`,`object_id`),
  FULLTEXT KEY `search` (`title`,`content`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ost__search`
--

LOCK TABLES `ost__search` WRITE;
/*!40000 ALTER TABLE `ost__search` DISABLE KEYS */;
INSERT INTO `ost__search` VALUES ('H',87,'ManutenÃ§Ã£o â€” v5l (S/N 1234)','SolicitaÃ§Ã£o de manutenÃ§Ã£o com 1 equipamento(s): v5l â€” S/N 1234 Resumo: test Detalhamento/ObservaÃ§Ã£o: tetes'),('H',90,'Nota Fiscal verificada','XML da Nota Fiscal verificado â€” sem erros.'),('H',93,'','AtualizaÃ§Ã£o dos seus equipamentos: v5l (S/N 1234) : status atualizado para Em anÃ¡lise v5l (S/N 1234) â€” laudo tÃ©cnico: Equipamento em anÃ¡lise no laboratÃ³rio. Identificado desgaste no conector do touch â€” aguardando teste de bancada para confirmar a troca. VocÃª pode acompanhar todos os detalhes abrindo o chamado no portal.'),('H',94,'','Entendido, estou no aguardo'),('H',95,'','AtualizaÃ§Ã£o dos seus equipamentos: v5l (S/N 1234) â€” laudo tÃ©cnico: Checando tela e sensor VocÃª pode acompanhar todos os detalhes abrindo o chamado no portal.'),('H',96,'','Entendido, estou no aguardo'),('H',97,'','AtualizaÃ§Ã£o dos seus equipamentos: v5l (S/N 1234) : status atualizado para Em reparo VocÃª pode acompanhar todos os detalhes abrindo o chamado no portal.'),('H',98,'','Entendido, estou no aguardo'),('H',99,'Status Alterado','ManutenÃ§Ã£o finalizada'),('H',100,'','AtualizaÃ§Ã£o dos seus equipamentos: v5l (S/N 1234) : status atualizado para Reparado VocÃª pode acompanhar todos os detalhes abrindo o chamado no portal.'),('H',101,'ManutenÃ§Ã£o â€” 4 equipamentos: V5L, V4L, Proma, Proface','SolicitaÃ§Ã£o de manutenÃ§Ã£o com 4 equipamento(s): V5L â€” S/N 4444 Resumo: teste Detalhamento/ObservaÃ§Ã£o: teste V4L â€” S/N 3333 Resumo: teste Detalhamento/ObservaÃ§Ã£o: teste Proma â€” S/N 5555 Resumo: teste Detalhamento/ObservaÃ§Ã£o: teste Proface â€” S/N 8888 Resumo: teste Detalhamento/ObservaÃ§Ã£o: teste'),('H',104,'Status Alterado','Inicada a anÃ¡lise'),('H',105,'Status Alterado','recebido'),('H',106,'Status Alterado','Iniciado'),('H',107,'ManutenÃ§Ã£o â€” V5L (S/N 872347376)','SolicitaÃ§Ã£o de manutenÃ§Ã£o com 1 equipamento(s): V5L â€” S/N 872347376 Resumo: NÃ£o liga Detalhamento/ObservaÃ§Ã£o: Caiu um raio'),('H',110,'Status Alterado','teste'),('H',111,'','AtualizaÃ§Ã£o dos seus equipamentos: V5L (S/N 4444) : status atualizado para Em anÃ¡lise VocÃª pode acompanhar todos os detalhes abrindo o chamado no portal.'),('H',112,'','AtualizaÃ§Ã£o dos seus equipamentos: V4L (S/N 3333) : status atualizado para Em anÃ¡lise VocÃª pode acompanhar todos os detalhes abrindo o chamado no portal.'),('H',113,'','AtualizaÃ§Ã£o dos seus equipamentos: Proma (S/N 5555) : status atualizado para Em anÃ¡lise Proma (S/N 5555) â€” laudo tÃ©cnico: Aguardando peÃ§a VocÃª pode acompanhar todos os detalhes abrindo o chamado no portal.'),('H',114,'','AtualizaÃ§Ã£o dos seus equipamentos: Proma (S/N 5555) : status atualizado para Aguardando peÃ§a Proma (S/N 5555) â€” laudo tÃ©cnico: Aguardando display Proface (S/N 8888) : status atualizado para Em anÃ¡lise Proface (S/N 8888) â€” laudo tÃ©cnico: Iniciando testes VocÃª pode acompanhar todos os detalhes abrindo o chamado no portal.'),('H',115,'ManutenÃ§Ã£o â€” V3L Lite (S/N 24234234)','SolicitaÃ§Ã£o de manutenÃ§Ã£o com 1 equipamento(s): V3L Lite â€” S/N 24234234 Resumo: teste Detalhamento/ObservaÃ§Ã£o: teste'),('H',116,'','AtualizaÃ§Ã£o dos seus equipamentos: Proma (S/N 5555) : status atualizado para Em reparo VocÃª pode acompanhar todos os detalhes abrindo o chamado no portal.'),('O',1,'osTicket',''),('T',18,'889540 ManutenÃ§Ã£o â€” v5l (S/N 1234)','ManutenÃ§Ã£o â€” v5l (S/N 1234)'),('T',19,'105968 ManutenÃ§Ã£o â€” 4 equipamentos: V5L, V4L, Proma, Proface','ManutenÃ§Ã£o â€” 4 equipamentos: V5L, V4L, Proma, Proface'),('T',20,'552884 ManutenÃ§Ã£o â€” V5L (S/N 872347376)','ManutenÃ§Ã£o â€” V5L (S/N 872347376)'),('T',21,'479206 ManutenÃ§Ã£o â€” V3L Lite (S/N 24234234)','ManutenÃ§Ã£o â€” V3L Lite (S/N 24234234)'),('U',1,'Atendimento osTicket','support@osticket.com'),('U',2,'Juliano Torres Rezende','31997910742 julianotorres@gmail.com'),('U',3,'Cliente Teste','11999999999 teste@example.com\nteste@example.com'),('U',4,'OTAVIO PRADO DA SILVA','31996270810 otaviopradosilva@gmail.com\notaviopradosilva@gmail.com');
/*!40000 ALTER TABLE `ost__search` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ost_api_key`
--

DROP TABLE IF EXISTS `ost_api_key`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `ost_api_key` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `isactive` tinyint(1) NOT NULL DEFAULT 1,
  `ipaddr` varchar(64) NOT NULL,
  `apikey` varchar(255) NOT NULL,
  `can_create_tickets` tinyint(1) unsigned NOT NULL DEFAULT 1,
  `can_exec_cron` tinyint(1) unsigned NOT NULL DEFAULT 1,
  `notes` text DEFAULT NULL,
  `updated` datetime NOT NULL,
  `created` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `apikey` (`apikey`),
  KEY `ipaddr` (`ipaddr`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ost_api_key`
--

LOCK TABLES `ost_api_key` WRITE;
/*!40000 ALTER TABLE `ost_api_key` DISABLE KEYS */;
/*!40000 ALTER TABLE `ost_api_key` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ost_attachment`
--

DROP TABLE IF EXISTS `ost_attachment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `ost_attachment` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `object_id` int(11) unsigned NOT NULL,
  `type` char(1) NOT NULL,
  `file_id` int(11) unsigned NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `inline` tinyint(1) unsigned NOT NULL DEFAULT 0,
  `lang` varchar(16) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `file-type` (`object_id`,`file_id`,`type`),
  UNIQUE KEY `file_object` (`file_id`,`object_id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ost_attachment`
--

LOCK TABLES `ost_attachment` WRITE;
/*!40000 ALTER TABLE `ost_attachment` DISABLE KEYS */;
INSERT INTO `ost_attachment` VALUES (1,1,'C',2,NULL,0,NULL),(2,8,'T',1,NULL,1,NULL),(3,9,'T',1,NULL,1,NULL),(4,10,'T',1,NULL,1,NULL),(5,11,'T',1,NULL,1,NULL),(6,12,'T',1,NULL,1,NULL),(7,13,'T',1,NULL,1,NULL),(8,14,'T',1,NULL,1,NULL),(9,16,'T',1,NULL,1,NULL),(10,17,'T',1,NULL,1,NULL),(11,18,'T',1,NULL,1,NULL),(12,19,'T',1,NULL,1,NULL),(15,3490486498,'E',3,NULL,0,NULL);
/*!40000 ALTER TABLE `ost_attachment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ost_canned_response`
--

DROP TABLE IF EXISTS `ost_canned_response`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `ost_canned_response` (
  `canned_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `dept_id` int(10) unsigned NOT NULL DEFAULT 0,
  `isenabled` tinyint(1) unsigned NOT NULL DEFAULT 1,
  `title` varchar(255) NOT NULL DEFAULT '',
  `response` text NOT NULL,
  `lang` varchar(16) NOT NULL DEFAULT 'en_US',
  `notes` text DEFAULT NULL,
  `created` datetime NOT NULL,
  `updated` datetime NOT NULL,
  PRIMARY KEY (`canned_id`),
  UNIQUE KEY `title` (`title`),
  KEY `dept_id` (`dept_id`),
  KEY `active` (`isenabled`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ost_canned_response`
--

LOCK TABLES `ost_canned_response` WRITE;
/*!40000 ALTER TABLE `ost_canned_response` DISABLE KEYS */;
INSERT INTO `ost_canned_response` VALUES (1,0,1,'O que Ã© o osTicket (exemplo)?','osTicket Ã© um sistema de chamados de cÃ³digo aberto amplamente utilizado, uma alternativa atraente aos caros e complexos sistemas de suporte. Simples, leve, confiÃ¡vel, aberto, baseado na web, fÃ¡cil de configurar e usar.','en_US',NULL,'2026-07-01 10:26:33','2026-07-01 10:26:33'),(2,0,1,'Exemplo (com variÃ¡veis)','OlÃ¡ %{ticket.name.first},\n<br>\n<br>\nSeu ticket #%{ticket.number} criado em %{ticket.create_date} estÃ¡ com o departamento:\n%{ticket.dept.name}.','en_US',NULL,'2026-07-01 10:26:33','2026-07-01 10:26:33');
/*!40000 ALTER TABLE `ost_canned_response` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ost_config`
--

DROP TABLE IF EXISTS `ost_config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `ost_config` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `namespace` varchar(64) NOT NULL,
  `key` varchar(64) NOT NULL,
  `value` text NOT NULL,
  `updated` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `namespace` (`namespace`,`key`)
) ENGINE=InnoDB AUTO_INCREMENT=109 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ost_config`
--

LOCK TABLES `ost_config` WRITE;
/*!40000 ALTER TABLE `ost_config` DISABLE KEYS */;
INSERT INTO `ost_config` VALUES (1,'core','admin_email','juliano.zkteco@gmail.com','2026-07-01 13:26:33'),(2,'core','helpdesk_url','http://localhost/osticket/upload/','2026-07-01 13:26:33'),(3,'core','helpdesk_title','Central de ManutenÃ§Ã£o','2026-07-01 13:26:33'),(4,'core','schema_signature','83a22ba22b1a6a624fcb1da03882ac1b','2026-07-01 13:26:33'),(5,'schedule.1','configuration','{\"holidays\":[4]}','2026-07-01 13:26:32'),(6,'core','time_format','H:mm','2026-07-01 13:26:33'),(7,'core','date_format','MM/dd/y','2026-07-01 13:26:33'),(8,'core','datetime_format','MM/dd/y H:mm','2026-07-01 13:26:33'),(9,'core','daydatetime_format','cccc, dd MMMM y H:mm','2026-07-01 13:26:33'),(10,'core','default_priority_id','2','2026-07-01 13:26:33'),(11,'core','enable_daylight_saving','','2026-07-01 13:26:33'),(12,'core','reply_separator','-- resposta acima desta linha --','2026-07-01 13:26:33'),(13,'core','isonline','1','2026-07-01 13:26:33'),(14,'core','staff_ip_binding','','2026-07-01 13:26:33'),(15,'core','staff_max_logins','4','2026-07-01 13:26:33'),(16,'core','staff_login_timeout','2','2026-07-01 13:26:33'),(17,'core','staff_session_timeout','30','2026-07-01 13:26:33'),(18,'core','passwd_reset_period','','2026-07-01 13:26:33'),(19,'core','client_max_logins','4','2026-07-01 13:26:33'),(20,'core','client_login_timeout','2','2026-07-01 13:26:33'),(21,'core','client_session_timeout','30','2026-07-01 13:26:33'),(22,'core','max_page_size','25','2026-07-01 13:26:33'),(23,'core','max_open_tickets','','2026-07-01 13:26:33'),(24,'core','autolock_minutes','3','2026-07-01 13:26:33'),(25,'core','default_smtp_id','2','2026-07-01 13:26:33'),(26,'core','use_email_priority','','2026-07-01 13:26:33'),(27,'core','enable_kb','','2026-07-01 13:26:33'),(28,'core','enable_premade','1','2026-07-01 13:26:33'),(29,'core','enable_captcha','','2026-07-01 13:26:33'),(30,'core','enable_auto_cron','','2026-07-01 13:26:33'),(31,'core','enable_mail_polling','','2026-07-01 13:26:33'),(32,'core','send_sys_errors','1','2026-07-01 13:26:33'),(33,'core','send_sql_errors','1','2026-07-01 13:26:33'),(34,'core','send_login_errors','1','2026-07-01 13:26:33'),(35,'core','save_email_headers','1','2026-07-01 13:26:33'),(36,'core','strip_quoted_reply','1','2026-07-01 13:26:33'),(37,'core','ticket_autoresponder','','2026-07-01 13:26:33'),(38,'core','message_autoresponder','','2026-07-01 13:26:33'),(39,'core','ticket_notice_active','1','2026-07-01 13:26:33'),(40,'core','ticket_alert_active','1','2026-07-01 13:26:33'),(41,'core','ticket_alert_admin','1','2026-07-01 13:26:33'),(42,'core','ticket_alert_dept_manager','1','2026-07-01 13:26:33'),(43,'core','ticket_alert_dept_members','','2026-07-01 13:26:33'),(44,'core','message_alert_active','1','2026-07-01 13:26:33'),(45,'core','message_alert_laststaff','1','2026-07-01 13:26:33'),(46,'core','message_alert_assigned','1','2026-07-01 13:26:33'),(47,'core','message_alert_dept_manager','','2026-07-01 13:26:33'),(48,'core','note_alert_active','','2026-07-01 13:26:33'),(49,'core','note_alert_laststaff','1','2026-07-01 13:26:33'),(50,'core','note_alert_assigned','1','2026-07-01 13:26:33'),(51,'core','note_alert_dept_manager','','2026-07-01 13:26:33'),(52,'core','transfer_alert_active','','2026-07-01 13:26:33'),(53,'core','transfer_alert_assigned','','2026-07-01 13:26:33'),(54,'core','transfer_alert_dept_manager','1','2026-07-01 13:26:33'),(55,'core','transfer_alert_dept_members','','2026-07-01 13:26:33'),(56,'core','overdue_alert_active','1','2026-07-01 13:26:33'),(57,'core','overdue_alert_assigned','1','2026-07-01 13:26:33'),(58,'core','overdue_alert_dept_manager','1','2026-07-01 13:26:33'),(59,'core','overdue_alert_dept_members','','2026-07-01 13:26:33'),(60,'core','assigned_alert_active','1','2026-07-01 13:26:33'),(61,'core','assigned_alert_staff','1','2026-07-01 13:26:33'),(62,'core','assigned_alert_team_lead','','2026-07-01 13:26:33'),(63,'core','assigned_alert_team_members','','2026-07-01 13:26:33'),(64,'core','auto_claim_tickets','1','2026-07-01 13:26:33'),(65,'core','auto_refer_closed','1','2026-07-01 13:26:33'),(66,'core','collaborator_ticket_visibility','1','2026-07-01 13:26:33'),(67,'core','require_topic_to_close','','2026-07-01 13:26:33'),(68,'core','show_related_tickets','1','2026-07-01 13:26:33'),(69,'core','show_assigned_tickets','1','2026-07-01 13:26:33'),(70,'core','show_answered_tickets','','2026-07-01 13:26:33'),(71,'core','hide_staff_name','','2026-07-01 13:26:33'),(72,'core','disable_agent_collabs','','2026-07-01 13:26:33'),(73,'core','overlimit_notice_active','','2026-07-01 13:26:33'),(74,'core','email_attachments','1','2026-07-01 13:26:33'),(75,'core','ticket_number_format','######','2026-07-01 13:26:33'),(76,'core','ticket_sequence_id','','2026-07-01 13:26:33'),(77,'core','queue_bucket_counts','','2026-07-01 13:26:33'),(78,'core','allow_external_images','','2026-07-01 13:26:33'),(79,'core','task_number_format','#','2026-07-01 13:26:33'),(80,'core','task_sequence_id','2','2026-07-01 13:26:33'),(81,'core','log_level','2','2026-07-01 13:26:33'),(82,'core','log_graceperiod','12','2026-07-01 13:26:33'),(83,'core','client_registration','public','2026-07-01 13:26:33'),(84,'core','default_ticket_queue','1','2026-07-01 13:26:33'),(85,'core','embedded_domain_whitelist','youtube.com, dailymotion.com, vimeo.com, player.vimeo.com, web.microsoftstream.com','2026-07-01 13:26:33'),(86,'core','max_file_size','33554432','2026-07-01 13:26:33'),(87,'core','landing_page_id','1','2026-07-01 13:26:33'),(88,'core','thank-you_page_id','2','2026-07-01 13:26:33'),(89,'core','offline_page_id','3','2026-07-01 13:26:33'),(90,'core','system_language','pt_BR','2026-07-01 13:26:33'),(91,'mysqlsearch','reindex','0','2026-07-01 13:30:05'),(92,'core','default_email_id','1','2026-07-01 13:26:33'),(93,'core','alert_email_id','2','2026-07-01 13:26:33'),(94,'core','default_dept_id','1','2026-07-01 13:26:33'),(95,'core','default_sla_id','1','2026-07-01 13:26:33'),(96,'core','schedule_id','1','2026-07-01 13:26:33'),(97,'core','default_template_id','1','2026-07-01 13:26:33'),(98,'core','default_timezone','America/Argentina/Buenos_Aires','2026-07-01 13:26:33'),(99,'email.1.account.0','username','juliano.torres@zkteco.com','2026-07-01 13:28:07'),(100,'email.1.account.0','passwd','$2$JDEkfHqGDshMf5Pb5yTHRyicfWJXPpNY+6FHINcGZF9wSNg=','2026-07-01 13:28:07'),(101,'email.1.account.1','username','juliano.torres@zkteco.com','2026-07-01 13:28:30'),(102,'email.1.account.1','passwd','$2$JDEkyUbpXGtyGupJCtqB/neXk50ZRq4/6cJd1JmccaP1qGI=','2026-07-13 13:06:13'),(103,'email.1.account.2','username','juliano.torres@zkteco.com','2026-07-01 13:29:39'),(104,'email.1.account.2','passwd','$2$JDEkE3JNRATydZHIMuwVIMEwddeFOBa6oWv4nKteMUUGrX0=','2026-07-13 13:06:29'),(106,'core','default_help_topic','1','2026-07-01 14:12:35'),(107,'core','clients_only','1','2026-07-02 11:19:33');
/*!40000 ALTER TABLE `ost_config` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ost_content`
--

DROP TABLE IF EXISTS `ost_content`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `ost_content` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `isactive` tinyint(1) unsigned NOT NULL DEFAULT 0,
  `type` varchar(32) NOT NULL DEFAULT 'other',
  `name` varchar(255) NOT NULL,
  `body` text NOT NULL,
  `notes` text DEFAULT NULL,
  `created` datetime NOT NULL,
  `updated` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ost_content`
--

LOCK TABLES `ost_content` WRITE;
/*!40000 ALTER TABLE `ost_content` DISABLE KEYS */;
INSERT INTO `ost_content` VALUES (1,1,'landing','Pagina Inicial','<h1>Bem Vindo ao Sistema de Suporte</h1> <p> Com o objetivo de centralizarmos todos nossos pedidos de atendimento e melhor servir, utilizamos um sistema de ticket. Cada ticket recebe um nÃºmero Ãºnico, que pode ser utilizado para acompanhar o progresso e suas respostas. Para seu acompanhamento, provemos o histÃ³rico de todos os tickets do nosso sistema suporte. Para abrir um ticket, Ã© necessÃ¡rio um endereÃ§o de e-mail vÃ¡lido. </p>','A pÃ¡gina inicial refere-se ao conteÃºdo da exibiÃ§Ã£o inicial do Portal do Cliente. O modelo modifica o conteÃºdo visto acima dos links <strong>Abrir um novo Chamado</strong> e <strong>Verificar Status do Chamado</strong>.','2026-07-01 10:26:33','2026-07-01 10:26:33'),(2,1,'thank-you','Obrigado','<div>%{ticket.name},\n<br>\n<br>\nObrigado por nos contatar.\n<br>\n<br>\nUm chamado foi criado e um atendente irÃ¡ respondÃª-lo se necessÃ¡rio.</p>\n<br>\n<br>\nEquipe de Suporte\n</div>','Este modelo define o conteÃºdo mostrado na pÃ¡gina Obrigado apÃ³s um Cliente criar um novo chamado no Portal do Cliente.','2026-07-01 10:26:33','2026-07-01 10:26:33'),(3,1,'offline','Desligado','<div><h1>\n<span style=\"font-size: medium\">Sistema de Suporte Desligado</span>\n</h1>\n<p>Obrigado por tentar nos contatar.</p>\n<p>Nosso sistema de atendimento estÃ¡ desligado nesse momento, favor checar novamente em breve.</p>\n</div>','A pÃ¡gina Offline aparece no Portal do Cliente quando o sistema de suporte estÃ¡ offline.','2026-07-01 10:26:33','2026-07-01 10:26:33'),(4,1,'registration-staff','Bem-vindo ao osTicket','<h3><strong> OlÃ¡ %{recipient.name.first},</strong></h3> <div>Uma conta foi criada no nosso help desk %{url}. <br /> <br /> Por favor, siga o link abaixo para confirmar sua conta.<br /> <br />  <a href=\"%{link}\">%{link}</a><br /> <br /> <em style=\"font-size: small\"> Sistema de Suporte <br />%{company.name}</em></div>','Este modelo define o e-mail inicial (opcional) enviado aos agentes quando Ã© criada uma conta em seu nome.','2026-07-01 10:26:33','2026-07-01 10:26:33'),(5,1,'pwreset-staff','osTicket Equipe de RedefiniÃ§Ã£o de Senha','<h3><strong>OlÃ¡ %{staff.name.first},</strong></h3> <div> Uma requisiÃ§Ã£o para redefinir sua senha foi enviada em seu nome ao suporte em %{url}. <br /> <br /> Se vocÃª acha que isso foi um equivoco, apague ou ignore esse e-mail. Sua conta ainda Ã© segura e ninguÃ©m tem acesso a ela. A conta nÃ£o estÃ¡ bloqueada e sua senha nÃ£o foi alterada. AlguÃ©m pode apenas por engano ter digitado seu endereÃ§o de e-mail. <br /> <br /> Siga o link abaixo para acessar o sistema de atendimento e trocar sua senha. <br /> <br/> <a href=\"%{link}\">%{link}</a> <br /> <br /> <em style=\"font-size: small\">Sistema de Suporte</em> <br /> <img src=\"cid:b56944cb4722cc5cda9d1e23a3ea7fbc\" alt=\"Powered by osTicket\" width=\"126\" height=\"19\" style=\"width: 126px\" /> </div>','Este modelo define o e-mail que serÃ¡ enviado para os usuÃ¡rios que selecionarem o link <strong>Esqueci minha senha</strong> na pÃ¡gina de Controle do Painel do usuÃ¡rio.','2026-07-01 10:26:33','2026-07-01 10:26:33'),(6,1,'banner-staff','AutenticaÃ§Ã£o NecessÃ¡ria','','EstÃ¡ Ã© a mensagem inicial e do banner mostrado na pÃ¡gina de acesso da equipe. O primeiro campo de entrada refere-se ao texto formatado em vermelho que aparece na parte superior. O Ãºltimo texto Ã© para o conteÃºdo do banner que deve servir como um aviso de isenÃ§Ã£o.','2026-07-01 10:26:33','2026-07-01 10:26:33'),(7,1,'registration-client','Bem-vindo a %{company.name}','<h3><strong> OlÃ¡ %{recipient.name.first},</strong></h3> <div>Uma conta foi criada no nosso help desk %{url}. <br /> <br /> Por favor, siga o link abaixo para confirmar sua conta.<br /> <br />  <a href=\"%{link}\">%{link}</a><br /> <br /> <em style=\"font-size: small\"> Sistema de Suporte <br />%{company.name}</em></div>','Este modelo define o e-mail enviado aos clientes quando sua conta Ã© criada no Portal do Cliente ou por um agente em seu nome. Este e-mail serve como uma verificaÃ§Ã£o de endereÃ§o de e-mail. Por favor, use %{link} no e-mail.','2026-07-01 10:26:33','2026-07-01 10:26:33'),(8,1,'pwreset-client','%{company.name} Acesso ao Help Desk','<h3><strong>OlÃ¡ %{user.name.first},</strong></h3> <div> Uma requisiÃ§Ã£o para redefinir sua senha foi enviada em seu nome ao sistema de suporte em %{url}. <br /> <br /> Se vocÃª acha que isso foi um equivoco, apague ou ignore esse e-mail. Sua conta ainda Ã© segura e ninguÃ©m tem acesso a ela. A conta nÃ£o estÃ¡ bloqueada e sua senha nÃ£o foi alterada. AlguÃ©m pode apenas por engano ter digitado seu endereÃ§o de e-mail. <br /> <br /> Siga o link abaixo para acessar o sistema de atendimento e trocar sua senha. <br /> <br/> <a href=\"%{link}\">%{link}</a> <br /> <br /> <em style=\"font-size: small\">Sistema de Suporte</em> <br /> <br /> %{company.name}</em> </div>','Este modelo define o e-mail enviado aos clientes que selecionarem o link <strong>Esqueci minha senha</strong> na pÃ¡gina de acesso do cliente.','2026-07-01 10:26:33','2026-07-01 10:26:33'),(10,1,'registration-confirm','Registro de Conta','<div><strong>Obrigado por se registrar.</strong><br/> <br /> Um e-mail foi encaminhado para seu endereÃ§o. Por favor siga o link no e-mail para confirmar sua conta e ter acesso aos seus tickets.</div>','Este modelo define a pÃ¡gina mostrada aos clientes apÃ³s completar o formulÃ¡rio de inscriÃ§Ã£o. O modelo deve mencionar que o sistema estÃ¡ lhe enviando um link de confirmaÃ§Ã£o por e-mail e qual Ã© o prÃ³ximo passo para registro.','2026-07-01 10:26:33','2026-07-01 10:26:33'),(11,1,'registration-thanks','Conta Confirmada!','<div><strong>Obrigado por se registrar.</strong><br /> <br /> VocÃª jÃ¡ confirmou o seu endereÃ§o de e-mail e sua conta foi ativada com Ãªxito. VocÃª pode abrir um novo ticket ou gerenciar os tickets existentes.<br /> <br /> <em>Sistema de Suporte</em><br /> %{company.name}</div>','Este modelo define o conteÃºdo exibido depois que o clientes Ã© registrado com Ãªxito, confirmando sua conta. Esta pÃ¡gina deve informar ao usuÃ¡rio que o registro estÃ¡ completo e que o cliente pode agora enviar um ticket ou acessar os tickets existentes.','2026-07-01 10:26:33','2026-07-01 10:26:33'),(12,1,'access-link','Link de acesso ao Ticket [%{ticket.number}]','<h3><strong>OlÃ¡ %{recipient.name.first},</strong></h3> <div>Uma solicitaÃ§Ã£o de link de acesso para o ticket #%{ticket.number} foi enviada em seu nome pelo endereÃ§o %{url}.<br /> <br /> Acesse o link abaixo para verificar o status do ticket #%{ticket.number}.<br /> <br /> <a href=\"%{recipient.ticket_link}\">%{recipient.ticket_link}</a><br /> <br /> Se vocÃª <strong>nÃ£o</strong> realizou a solicitaÃ§Ã£o, por favor delete e desconsidere esse e-mail. Sua conta permanece segura e o acesso ao ticket nÃ£o foi concedido. Seu endereÃ§o de e-mail pode ter sido fornecido por engano.<br /> <br /> --<br />%{company.name} </div>','Este modelo define a notificaÃ§Ã£o que Ã© enviada aos clientes alertando-os de que um link de acesso foi enviado para o seu e-mail. O e-mail contÃ©m um link para acessar as informaÃ§Ãµes.','2026-07-01 10:26:33','2026-07-01 10:26:33'),(13,1,'email2fa-staff','AutenticaÃ§Ã£o de dois fatores do osTicket','<h3><strong>Oi %{staff.name.first},</strong></h3> <div> VocÃª acabou de entrar no helpdesk em %{url}.<br /> <br /> Use o cÃ³digo de verificaÃ§Ã£o abaixo para terminar de entrar no helpdesk.<br /> <br /> %{otp}<br /> <br /> <em style=\"font-size: small\">Seu Sistema de Suporte ao Cliente amigÃ¡vel</em> <br /> <img src=\"cid:b56944cb4722cc5cda9d1e23a3ea7fbc\" alt=\"Powered by osTicket\" width=\"126\" height=\"19\" style=\"width: 126px\" /> </div>','Este modelo define o e-mail enviado para a equipe que usa o e-mail para autenticaÃ§Ã£o de dois fatores','2026-07-01 10:26:33','2026-07-01 10:26:33'),(15,1,'banner-client','Bem-vindo','Abra e acompanhe seus chamados de manutenÃ§Ã£o de equipamentos ZKTeco. FaÃ§a login ou crie sua conta para comeÃ§ar.','Texto reduzido de boas-vindas da tela de login do cliente (substitui o texto padrÃ£o de instalaÃ§Ã£o do osTicket).','2026-07-02 07:54:31','2026-07-02 08:03:54');
/*!40000 ALTER TABLE `ost_content` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ost_department`
--

DROP TABLE IF EXISTS `ost_department`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `ost_department` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `pid` int(11) unsigned DEFAULT NULL,
  `tpl_id` int(10) unsigned NOT NULL DEFAULT 0,
  `sla_id` int(10) unsigned NOT NULL DEFAULT 0,
  `schedule_id` int(10) unsigned NOT NULL DEFAULT 0,
  `email_id` int(10) unsigned NOT NULL DEFAULT 0,
  `autoresp_email_id` int(10) unsigned NOT NULL DEFAULT 0,
  `manager_id` int(10) unsigned NOT NULL DEFAULT 0,
  `flags` int(10) unsigned NOT NULL DEFAULT 0,
  `name` varchar(128) NOT NULL DEFAULT '',
  `signature` text NOT NULL,
  `ispublic` tinyint(1) unsigned NOT NULL DEFAULT 1,
  `group_membership` tinyint(1) NOT NULL DEFAULT 0,
  `ticket_auto_response` tinyint(1) NOT NULL DEFAULT 1,
  `message_auto_response` tinyint(1) NOT NULL DEFAULT 0,
  `path` varchar(128) NOT NULL DEFAULT '/',
  `updated` datetime NOT NULL,
  `created` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`,`pid`),
  KEY `manager_id` (`manager_id`),
  KEY `autoresp_email_id` (`autoresp_email_id`),
  KEY `tpl_id` (`tpl_id`),
  KEY `flags` (`flags`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ost_department`
--

LOCK TABLES `ost_department` WRITE;
/*!40000 ALTER TABLE `ost_department` DISABLE KEYS */;
INSERT INTO `ost_department` VALUES (1,NULL,0,0,0,0,0,0,4,'Suporte','Departamento de Suporte',1,1,1,1,'/1/','2026-07-01 10:26:32','2026-07-01 10:26:32'),(2,NULL,0,1,0,0,0,0,4,'Vendas','Vendas e RetenÃ§Ã£o de Clientes',1,1,1,1,'/2/','2026-07-01 10:26:32','2026-07-01 10:26:32'),(3,NULL,0,0,0,0,0,0,4,'ManutenÃ§Ã£o','Departamento de ManutenÃ§Ã£o',1,0,1,1,'/3/','2026-07-01 10:26:32','2026-07-01 10:26:32');
/*!40000 ALTER TABLE `ost_department` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ost_draft`
--

DROP TABLE IF EXISTS `ost_draft`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `ost_draft` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `staff_id` int(11) unsigned NOT NULL,
  `namespace` varchar(32) NOT NULL DEFAULT '',
  `body` text NOT NULL,
  `extra` text DEFAULT NULL,
  `created` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `staff_id` (`staff_id`),
  KEY `namespace` (`namespace`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ost_draft`
--

LOCK TABLES `ost_draft` WRITE;
/*!40000 ALTER TABLE `ost_draft` DISABLE KEYS */;
/*!40000 ALTER TABLE `ost_draft` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ost_email`
--

DROP TABLE IF EXISTS `ost_email`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `ost_email` (
  `email_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `noautoresp` tinyint(1) unsigned NOT NULL DEFAULT 0,
  `priority_id` int(11) unsigned NOT NULL DEFAULT 2,
  `dept_id` int(11) unsigned NOT NULL DEFAULT 0,
  `topic_id` int(11) unsigned NOT NULL DEFAULT 0,
  `email` varchar(255) NOT NULL DEFAULT '',
  `name` varchar(255) NOT NULL DEFAULT '',
  `notes` text DEFAULT NULL,
  `created` datetime NOT NULL,
  `updated` datetime NOT NULL,
  PRIMARY KEY (`email_id`),
  UNIQUE KEY `email` (`email`),
  KEY `priority_id` (`priority_id`),
  KEY `dept_id` (`dept_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ost_email`
--

LOCK TABLES `ost_email` WRITE;
/*!40000 ALTER TABLE `ost_email` DISABLE KEYS */;
INSERT INTO `ost_email` VALUES (1,0,2,3,1,'juliano.torres@zkteco.com','ZKTeco - ManutenÃ§Ã£o',NULL,'2026-07-01 10:26:33','2026-07-01 11:22:32'),(2,0,2,1,0,'alerts@zkteco.com','osTicket Alerts',NULL,'2026-07-01 10:26:33','2026-07-01 10:26:33'),(3,0,2,1,0,'noreply@zkteco.com','',NULL,'2026-07-01 10:26:33','2026-07-01 10:26:33');
/*!40000 ALTER TABLE `ost_email` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ost_email_account`
--

DROP TABLE IF EXISTS `ost_email_account`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `ost_email_account` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `email_id` int(11) unsigned NOT NULL,
  `type` enum('mailbox','smtp') NOT NULL DEFAULT 'mailbox',
  `auth_bk` varchar(128) NOT NULL,
  `auth_id` varchar(16) DEFAULT NULL,
  `active` tinyint(1) unsigned NOT NULL DEFAULT 0,
  `host` varchar(128) NOT NULL DEFAULT '',
  `port` int(11) NOT NULL,
  `folder` varchar(255) DEFAULT NULL,
  `protocol` enum('IMAP','POP','SMTP','OTHER') NOT NULL DEFAULT 'OTHER',
  `encryption` enum('NONE','AUTO','SSL') NOT NULL DEFAULT 'AUTO',
  `fetchfreq` tinyint(3) unsigned NOT NULL DEFAULT 5,
  `fetchmax` tinyint(4) unsigned DEFAULT 30,
  `postfetch` enum('archive','delete','nothing') NOT NULL DEFAULT 'nothing',
  `archivefolder` varchar(255) DEFAULT NULL,
  `allow_spoofing` tinyint(1) unsigned DEFAULT 0,
  `num_errors` int(11) unsigned NOT NULL DEFAULT 0,
  `last_error_msg` tinytext DEFAULT NULL,
  `last_error` datetime DEFAULT NULL,
  `last_activity` datetime DEFAULT NULL,
  `created` datetime NOT NULL,
  `updated` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`),
  KEY `email_id` (`email_id`),
  KEY `type` (`type`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ost_email_account`
--

LOCK TABLES `ost_email_account` WRITE;
/*!40000 ALTER TABLE `ost_email_account` DISABLE KEYS */;
INSERT INTO `ost_email_account` VALUES (1,1,'mailbox','basic',NULL,1,'imap.exmail.qq.com',993,'INBOX','IMAP','AUTO',1,1,'nothing',NULL,0,0,NULL,'2026-07-01 10:29:52',NULL,'2026-07-01 10:28:07','2026-07-01 10:30:01'),(2,1,'smtp','basic',NULL,1,'ssl://smtp.exmail.qq.com',465,NULL,'SMTP','AUTO',5,30,'nothing',NULL,0,0,NULL,NULL,NULL,'2026-07-01 10:28:35','2026-07-01 10:29:26');
/*!40000 ALTER TABLE `ost_email_account` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ost_email_template`
--

DROP TABLE IF EXISTS `ost_email_template`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `ost_email_template` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `tpl_id` int(11) unsigned NOT NULL,
  `code_name` varchar(32) NOT NULL,
  `subject` varchar(255) NOT NULL DEFAULT '',
  `body` text NOT NULL,
  `notes` text DEFAULT NULL,
  `created` datetime NOT NULL,
  `updated` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `template_lookup` (`tpl_id`,`code_name`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ost_email_template`
--

LOCK TABLES `ost_email_template` WRITE;
/*!40000 ALTER TABLE `ost_email_template` DISABLE KEYS */;
INSERT INTO `ost_email_template` VALUES (1,1,'ticket.autoresp','Recebemos seu chamado [#%{ticket.number}] â€” %{ticket.subject}','<div style=\"margin:0;padding:26px 8px;background-color:#eff1ed;\">\n<table role=\"presentation\" align=\"center\" width=\"100%\" cellpadding=\"0\" cellspacing=\"0\" border=\"0\" style=\"max-width:600px;margin:0 auto;\">\n  <tr><td style=\"background-color:#474B4F;border-radius:10px 10px 0 0;padding:20px 30px;font-family:Arial,Helvetica,sans-serif;\">\n    <span style=\"font-size:21px;font-weight:bold;color:#ffffff;letter-spacing:.5px;\">ZK<span style=\"color:#7AC143;\">Teco</span></span>\n    <span style=\"display:block;font-size:11px;color:#b9bfba;letter-spacing:2px;text-transform:uppercase;padding-top:4px;\">Central de Manuten&ccedil;&atilde;o</span>\n  </td></tr>\n  <tr><td style=\"height:4px;background-color:#7AC143;font-size:0;line-height:0;\">&nbsp;</td></tr>\n  <tr><td style=\"background-color:#ffffff;padding:30px 30px 22px;font-family:Arial,Helvetica,sans-serif;font-size:14px;line-height:1.6;color:#474B4F;\">\n<p style=\"margin:0 0 6px;font-size:16px;\"><b>Ol&aacute;, %{recipient.name.first}!</b></p><p style=\"margin:0 0 10px;\">Sua solicita&ccedil;&atilde;o de manuten&ccedil;&atilde;o foi registrada com sucesso sob o n&uacute;mero <b>#%{ticket.number}</b>. Nossa equipe j&aacute; foi avisada e voc&ecirc; recebe todas as atualiza&ccedil;&otilde;es por aqui.</p><div style=\"background-color:#f2f8ec;border:1px solid #cfe6b8;border-radius:8px;padding:12px 18px;margin:14px 0 4px;font-size:13px;color:#4c6b33;\"><b>Pr&oacute;ximo passo:</b> acesse o chamado e anexe a <b>Nota Fiscal de remessa (XML)</b> &mdash; ela &eacute; obrigat&oacute;ria para o produto viajar at&eacute; a ZKTeco e a verifica&ccedil;&atilde;o &eacute; autom&aacute;tica. <br /><b>Cliente final sem NF?</b> Anexe a <b>Declara&ccedil;&atilde;o de Conte&uacute;do</b> &mdash; nesse caso o envio &eacute; pelos CORREIOS.</div>\n  </td></tr>\n  <tr><td style=\"background-color:#ffffff;padding:0 30px 28px;font-family:Arial,Helvetica,sans-serif;\">\n    <table role=\"presentation\" width=\"100%\" cellpadding=\"0\" cellspacing=\"0\" border=\"0\" style=\"background-color:#f5f7f4;border:1px solid #e3e6e2;border-radius:8px;\">\n      <tr>\n        <td style=\"padding:14px 20px;font-size:13px;color:#6b716c;font-family:Arial,Helvetica,sans-serif;\">\n          Chamado <b style=\"color:#474B4F;\">#%{ticket.number}</b>\n        </td>\n        <td align=\"right\" style=\"padding:10px 14px;\">\n          <a href=\"%%7Brecipient.ticket_link%7D\" style=\"display:inline-block;background-color:#7AC143;color:#ffffff;text-decoration:none;font-weight:bold;font-size:13px;padding:11px 22px;border-radius:7px;font-family:Arial,Helvetica,sans-serif;\">Acompanhar meu chamado</a>\n        </td>\n      </tr>\n    </table>\n  </td></tr>\n  <tr><td style=\"background-color:#ffffff;border-radius:0 0 10px 10px;border-top:1px solid #eef1ed;padding:18px 30px 24px;font-family:Arial,Helvetica,sans-serif;font-size:13px;line-height:1.5;color:#7b817c;\">\n    Equipe %{company.name}<br />\n    %{signature}\n  </td></tr>\n  <tr><td style=\"padding:18px 10px 6px;text-align:center;font-family:Arial,Helvetica,sans-serif;font-size:11.5px;color:#9aa09b;line-height:1.6;\">\n    Para responder, basta <b style=\"color:#8a8f8a;\">responder a este e-mail</b> &mdash; sua mensagem entra direto no chamado.<br />\n    Portal oficial de manuten&ccedil;&atilde;o &middot; Pioneira em solu&ccedil;&otilde;es de seguran&ccedil;a biom&eacute;trica\n  </td></tr>\n</table>\n</div>',NULL,'2026-07-01 10:26:33','2026-07-03 21:56:07'),(2,1,'ticket.autoreply','Re: %{ticket.subject}','<div style=\"margin:0;padding:26px 8px;background-color:#eff1ed;\">\n<table role=\"presentation\" align=\"center\" width=\"100%\" cellpadding=\"0\" cellspacing=\"0\" border=\"0\" style=\"max-width:600px;margin:0 auto;\">\n  <tr><td style=\"background-color:#474B4F;border-radius:10px 10px 0 0;padding:20px 30px;font-family:Arial,Helvetica,sans-serif;\">\n    <span style=\"font-size:21px;font-weight:bold;color:#ffffff;letter-spacing:.5px;\">ZK<span style=\"color:#7AC143;\">Teco</span></span>\n    <span style=\"display:block;font-size:11px;color:#b9bfba;letter-spacing:2px;text-transform:uppercase;padding-top:4px;\">Central de Manuten&ccedil;&atilde;o</span>\n  </td></tr>\n  <tr><td style=\"height:4px;background-color:#7AC143;font-size:0;line-height:0;\">&nbsp;</td></tr>\n  <tr><td style=\"background-color:#ffffff;padding:30px 30px 22px;font-family:Arial,Helvetica,sans-serif;font-size:14px;line-height:1.6;color:#474B4F;\">\n<p style=\"margin:0 0 6px;font-size:16px;\"><b>Ol&aacute;, %{recipient.name.first}!</b></p><p style=\"margin:0 0 10px;\">Seu chamado <b>#%{ticket.number}</b> (%{ticket.subject}) foi registrado com a seguinte resposta autom&aacute;tica:</p><div style=\"border-left:3px solid #7AC143;background-color:#fafcf8;padding:12px 18px;margin:16px 0;border-radius:0 8px 8px 0;\">%{response}</div>\n  </td></tr>\n  <tr><td style=\"background-color:#ffffff;padding:0 30px 28px;font-family:Arial,Helvetica,sans-serif;\">\n    <table role=\"presentation\" width=\"100%\" cellpadding=\"0\" cellspacing=\"0\" border=\"0\" style=\"background-color:#f5f7f4;border:1px solid #e3e6e2;border-radius:8px;\">\n      <tr>\n        <td style=\"padding:14px 20px;font-size:13px;color:#6b716c;font-family:Arial,Helvetica,sans-serif;\">\n          Chamado <b style=\"color:#474B4F;\">#%{ticket.number}</b>\n        </td>\n        <td align=\"right\" style=\"padding:10px 14px;\">\n          <a href=\"%%7Brecipient.ticket_link%7D\" style=\"display:inline-block;background-color:#7AC143;color:#ffffff;text-decoration:none;font-weight:bold;font-size:13px;padding:11px 22px;border-radius:7px;font-family:Arial,Helvetica,sans-serif;\">Acompanhar meu chamado</a>\n        </td>\n      </tr>\n    </table>\n  </td></tr>\n  <tr><td style=\"background-color:#ffffff;border-radius:0 0 10px 10px;border-top:1px solid #eef1ed;padding:18px 30px 24px;font-family:Arial,Helvetica,sans-serif;font-size:13px;line-height:1.5;color:#7b817c;\">\n    Equipe %{company.name}<br />\n    %{signature}\n  </td></tr>\n  <tr><td style=\"padding:18px 10px 6px;text-align:center;font-family:Arial,Helvetica,sans-serif;font-size:11.5px;color:#9aa09b;line-height:1.6;\">\n    Para responder, basta <b style=\"color:#8a8f8a;\">responder a este e-mail</b> &mdash; sua mensagem entra direto no chamado.<br />\n    Portal oficial de manuten&ccedil;&atilde;o &middot; Pioneira em solu&ccedil;&otilde;es de seguran&ccedil;a biom&eacute;trica\n  </td></tr>\n</table>\n</div>',NULL,'2026-07-01 10:26:33','2026-07-03 21:37:38'),(3,1,'message.autoresp','Sua mensagem foi recebida [#%{ticket.number}]','<div style=\"margin:0;padding:26px 8px;background-color:#eff1ed;\">\n<table role=\"presentation\" align=\"center\" width=\"100%\" cellpadding=\"0\" cellspacing=\"0\" border=\"0\" style=\"max-width:600px;margin:0 auto;\">\n  <tr><td style=\"background-color:#474B4F;border-radius:10px 10px 0 0;padding:20px 30px;font-family:Arial,Helvetica,sans-serif;\">\n    <span style=\"font-size:21px;font-weight:bold;color:#ffffff;letter-spacing:.5px;\">ZK<span style=\"color:#7AC143;\">Teco</span></span>\n    <span style=\"display:block;font-size:11px;color:#b9bfba;letter-spacing:2px;text-transform:uppercase;padding-top:4px;\">Central de Manuten&ccedil;&atilde;o</span>\n  </td></tr>\n  <tr><td style=\"height:4px;background-color:#7AC143;font-size:0;line-height:0;\">&nbsp;</td></tr>\n  <tr><td style=\"background-color:#ffffff;padding:30px 30px 22px;font-family:Arial,Helvetica,sans-serif;font-size:14px;line-height:1.6;color:#474B4F;\">\n<p style=\"margin:0 0 6px;font-size:16px;\"><b>Ol&aacute;, %{recipient.name.first}!</b></p><p style=\"margin:0;\">Recebemos a sua mensagem no chamado <b>#%{ticket.number}</b> &mdash; a equipe t&eacute;cnica j&aacute; foi notificada e responde em breve.</p>\n  </td></tr>\n  <tr><td style=\"background-color:#ffffff;padding:0 30px 28px;font-family:Arial,Helvetica,sans-serif;\">\n    <table role=\"presentation\" width=\"100%\" cellpadding=\"0\" cellspacing=\"0\" border=\"0\" style=\"background-color:#f5f7f4;border:1px solid #e3e6e2;border-radius:8px;\">\n      <tr>\n        <td style=\"padding:14px 20px;font-size:13px;color:#6b716c;font-family:Arial,Helvetica,sans-serif;\">\n          Chamado <b style=\"color:#474B4F;\">#%{ticket.number}</b>\n        </td>\n        <td align=\"right\" style=\"padding:10px 14px;\">\n          <a href=\"%%7Brecipient.ticket_link%7D\" style=\"display:inline-block;background-color:#7AC143;color:#ffffff;text-decoration:none;font-weight:bold;font-size:13px;padding:11px 22px;border-radius:7px;font-family:Arial,Helvetica,sans-serif;\">Acompanhar meu chamado</a>\n        </td>\n      </tr>\n    </table>\n  </td></tr>\n  <tr><td style=\"background-color:#ffffff;border-radius:0 0 10px 10px;border-top:1px solid #eef1ed;padding:18px 30px 24px;font-family:Arial,Helvetica,sans-serif;font-size:13px;line-height:1.5;color:#7b817c;\">\n    Equipe %{company.name}<br />\n    %{signature}\n  </td></tr>\n  <tr><td style=\"padding:18px 10px 6px;text-align:center;font-family:Arial,Helvetica,sans-serif;font-size:11.5px;color:#9aa09b;line-height:1.6;\">\n    Para responder, basta <b style=\"color:#8a8f8a;\">responder a este e-mail</b> &mdash; sua mensagem entra direto no chamado.<br />\n    Portal oficial de manuten&ccedil;&atilde;o &middot; Pioneira em solu&ccedil;&otilde;es de seguran&ccedil;a biom&eacute;trica\n  </td></tr>\n</table>\n</div>',NULL,'2026-07-01 10:26:33','2026-07-03 21:37:38'),(4,1,'ticket.notice','%{ticket.subject} [#%{ticket.number}]','<div style=\"margin:0;padding:26px 8px;background-color:#eff1ed;\">\n<table role=\"presentation\" align=\"center\" width=\"100%\" cellpadding=\"0\" cellspacing=\"0\" border=\"0\" style=\"max-width:600px;margin:0 auto;\">\n  <tr><td style=\"background-color:#474B4F;border-radius:10px 10px 0 0;padding:20px 30px;font-family:Arial,Helvetica,sans-serif;\">\n    <span style=\"font-size:21px;font-weight:bold;color:#ffffff;letter-spacing:.5px;\">ZK<span style=\"color:#7AC143;\">Teco</span></span>\n    <span style=\"display:block;font-size:11px;color:#b9bfba;letter-spacing:2px;text-transform:uppercase;padding-top:4px;\">Central de Manuten&ccedil;&atilde;o</span>\n  </td></tr>\n  <tr><td style=\"height:4px;background-color:#7AC143;font-size:0;line-height:0;\">&nbsp;</td></tr>\n  <tr><td style=\"background-color:#ffffff;padding:30px 30px 22px;font-family:Arial,Helvetica,sans-serif;font-size:14px;line-height:1.6;color:#474B4F;\">\n<p style=\"margin:0 0 6px;font-size:16px;\"><b>Ol&aacute;, %{recipient.name.first}!</b></p><p style=\"margin:0 0 10px;\">Nossa equipe criou um chamado em seu nome com os detalhes abaixo:</p><p style=\"margin:0 0 4px;font-size:13px;color:#6b716c;\">T&oacute;pico: <b style=\"color:#474B4F;\">%{ticket.topic.name}</b><br />Assunto: <b style=\"color:#474B4F;\">%{ticket.subject}</b></p><div style=\"border-left:3px solid #7AC143;background-color:#fafcf8;padding:12px 18px;margin:16px 0;border-radius:0 8px 8px 0;\">%{message} %{response}</div><p style=\"margin:0;font-size:13px;color:#6b716c;\">Se necess&aacute;rio, um representante entrar&aacute; em contato com voc&ecirc;.</p>\n  </td></tr>\n  <tr><td style=\"background-color:#ffffff;padding:0 30px 28px;font-family:Arial,Helvetica,sans-serif;\">\n    <table role=\"presentation\" width=\"100%\" cellpadding=\"0\" cellspacing=\"0\" border=\"0\" style=\"background-color:#f5f7f4;border:1px solid #e3e6e2;border-radius:8px;\">\n      <tr>\n        <td style=\"padding:14px 20px;font-size:13px;color:#6b716c;font-family:Arial,Helvetica,sans-serif;\">\n          Chamado <b style=\"color:#474B4F;\">#%{ticket.number}</b>\n        </td>\n        <td align=\"right\" style=\"padding:10px 14px;\">\n          <a href=\"%%7Brecipient.ticket_link%7D\" style=\"display:inline-block;background-color:#7AC143;color:#ffffff;text-decoration:none;font-weight:bold;font-size:13px;padding:11px 22px;border-radius:7px;font-family:Arial,Helvetica,sans-serif;\">Acompanhar meu chamado</a>\n        </td>\n      </tr>\n    </table>\n  </td></tr>\n  <tr><td style=\"background-color:#ffffff;border-radius:0 0 10px 10px;border-top:1px solid #eef1ed;padding:18px 30px 24px;font-family:Arial,Helvetica,sans-serif;font-size:13px;line-height:1.5;color:#7b817c;\">\n    Equipe %{company.name}<br />\n    %{signature}\n  </td></tr>\n  <tr><td style=\"padding:18px 10px 6px;text-align:center;font-family:Arial,Helvetica,sans-serif;font-size:11.5px;color:#9aa09b;line-height:1.6;\">\n    Para responder, basta <b style=\"color:#8a8f8a;\">responder a este e-mail</b> &mdash; sua mensagem entra direto no chamado.<br />\n    Portal oficial de manuten&ccedil;&atilde;o &middot; Pioneira em solu&ccedil;&otilde;es de seguran&ccedil;a biom&eacute;trica\n  </td></tr>\n</table>\n</div>',NULL,'2026-07-01 10:26:33','2026-07-03 21:37:38'),(5,1,'ticket.overlimit','Limite de Chamados Abertos AlcanÃ§ado','<h3><strong>Prezado(a) %{ticket.name.first},</strong></h3> VocÃª atingiu o nÃºmero de tickets abertos permitido. Para poder abrir um novo Ticket Ã© preciso que feche um dos tickets pedentes. Para atualizar ou adicionar comentÃ¡rios a um ticket em aberto, <a>href=\"%{url}/tickets.php?e=%{ticket.email}\"&gt;acesse nosso helpdesk</a>. <br /> <br /> Obrigado, <br /> Sistema de Suporte ao Cliente',NULL,'2026-07-01 10:26:33','2026-07-01 10:26:33'),(6,1,'ticket.reply','Re: %{ticket.subject}','<div style=\"margin:0;padding:26px 8px;background-color:#eff1ed;\">\n<table role=\"presentation\" align=\"center\" width=\"100%\" cellpadding=\"0\" cellspacing=\"0\" border=\"0\" style=\"max-width:600px;margin:0 auto;\">\n  <tr><td style=\"background-color:#474B4F;border-radius:10px 10px 0 0;padding:20px 30px;font-family:Arial,Helvetica,sans-serif;\">\n    <span style=\"font-size:21px;font-weight:bold;color:#ffffff;letter-spacing:.5px;\">ZK<span style=\"color:#7AC143;\">Teco</span></span>\n    <span style=\"display:block;font-size:11px;color:#b9bfba;letter-spacing:2px;text-transform:uppercase;padding-top:4px;\">Central de Manuten&ccedil;&atilde;o</span>\n  </td></tr>\n  <tr><td style=\"height:4px;background-color:#7AC143;font-size:0;line-height:0;\">&nbsp;</td></tr>\n  <tr><td style=\"background-color:#ffffff;padding:30px 30px 22px;font-family:Arial,Helvetica,sans-serif;font-size:14px;line-height:1.6;color:#474B4F;\">\n<p style=\"margin:0 0 6px;font-size:16px;\"><b>Ol&aacute;, %{recipient.name.first}!</b></p><p style=\"margin:0 0 4px;\">A equipe t&eacute;cnica respondeu ao seu chamado:</p><div style=\"border-left:3px solid #7AC143;background-color:#fafcf8;padding:12px 18px;margin:16px 0;border-radius:0 8px 8px 0;\">%{response}</div>\n  </td></tr>\n  <tr><td style=\"background-color:#ffffff;padding:0 30px 28px;font-family:Arial,Helvetica,sans-serif;\">\n    <table role=\"presentation\" width=\"100%\" cellpadding=\"0\" cellspacing=\"0\" border=\"0\" style=\"background-color:#f5f7f4;border:1px solid #e3e6e2;border-radius:8px;\">\n      <tr>\n        <td style=\"padding:14px 20px;font-size:13px;color:#6b716c;font-family:Arial,Helvetica,sans-serif;\">\n          Chamado <b style=\"color:#474B4F;\">#%{ticket.number}</b>\n        </td>\n        <td align=\"right\" style=\"padding:10px 14px;\">\n          <a href=\"%%7Brecipient.ticket_link%7D\" style=\"display:inline-block;background-color:#7AC143;color:#ffffff;text-decoration:none;font-weight:bold;font-size:13px;padding:11px 22px;border-radius:7px;font-family:Arial,Helvetica,sans-serif;\">Acompanhar meu chamado</a>\n        </td>\n      </tr>\n    </table>\n  </td></tr>\n  <tr><td style=\"background-color:#ffffff;border-radius:0 0 10px 10px;border-top:1px solid #eef1ed;padding:18px 30px 24px;font-family:Arial,Helvetica,sans-serif;font-size:13px;line-height:1.5;color:#7b817c;\">\n    Equipe %{company.name}<br />\n    %{signature}\n  </td></tr>\n  <tr><td style=\"padding:18px 10px 6px;text-align:center;font-family:Arial,Helvetica,sans-serif;font-size:11.5px;color:#9aa09b;line-height:1.6;\">\n    Para responder, basta <b style=\"color:#8a8f8a;\">responder a este e-mail</b> &mdash; sua mensagem entra direto no chamado.<br />\n    Portal oficial de manuten&ccedil;&atilde;o &middot; Pioneira em solu&ccedil;&otilde;es de seguran&ccedil;a biom&eacute;trica\n  </td></tr>\n</table>\n</div>',NULL,'2026-07-01 10:26:33','2026-07-03 21:37:38'),(7,1,'ticket.activity.notice','Re: %{ticket.subject}','<div style=\"margin:0;padding:26px 8px;background-color:#eff1ed;\">\n<table role=\"presentation\" align=\"center\" width=\"100%\" cellpadding=\"0\" cellspacing=\"0\" border=\"0\" style=\"max-width:600px;margin:0 auto;\">\n  <tr><td style=\"background-color:#474B4F;border-radius:10px 10px 0 0;padding:20px 30px;font-family:Arial,Helvetica,sans-serif;\">\n    <span style=\"font-size:21px;font-weight:bold;color:#ffffff;letter-spacing:.5px;\">ZK<span style=\"color:#7AC143;\">Teco</span></span>\n    <span style=\"display:block;font-size:11px;color:#b9bfba;letter-spacing:2px;text-transform:uppercase;padding-top:4px;\">Central de Manuten&ccedil;&atilde;o</span>\n  </td></tr>\n  <tr><td style=\"height:4px;background-color:#7AC143;font-size:0;line-height:0;\">&nbsp;</td></tr>\n  <tr><td style=\"background-color:#ffffff;padding:30px 30px 22px;font-family:Arial,Helvetica,sans-serif;font-size:14px;line-height:1.6;color:#474B4F;\">\n<p style=\"margin:0 0 6px;font-size:16px;\"><b>Ol&aacute;, %{recipient.name.first}!</b></p><p style=\"margin:0 0 4px;\"><b>%{poster.name}</b> registrou uma nova mensagem em um chamado do qual voc&ecirc; participa:</p><div style=\"border-left:3px solid #7AC143;background-color:#fafcf8;padding:12px 18px;margin:16px 0;border-radius:0 8px 8px 0;\">%{message}</div>\n  </td></tr>\n  <tr><td style=\"background-color:#ffffff;padding:0 30px 28px;font-family:Arial,Helvetica,sans-serif;\">\n    <table role=\"presentation\" width=\"100%\" cellpadding=\"0\" cellspacing=\"0\" border=\"0\" style=\"background-color:#f5f7f4;border:1px solid #e3e6e2;border-radius:8px;\">\n      <tr>\n        <td style=\"padding:14px 20px;font-size:13px;color:#6b716c;font-family:Arial,Helvetica,sans-serif;\">\n          Chamado <b style=\"color:#474B4F;\">#%{ticket.number}</b>\n        </td>\n        <td align=\"right\" style=\"padding:10px 14px;\">\n          <a href=\"%%7Brecipient.ticket_link%7D\" style=\"display:inline-block;background-color:#7AC143;color:#ffffff;text-decoration:none;font-weight:bold;font-size:13px;padding:11px 22px;border-radius:7px;font-family:Arial,Helvetica,sans-serif;\">Acompanhar meu chamado</a>\n        </td>\n      </tr>\n    </table>\n  </td></tr>\n  <tr><td style=\"background-color:#ffffff;border-radius:0 0 10px 10px;border-top:1px solid #eef1ed;padding:18px 30px 24px;font-family:Arial,Helvetica,sans-serif;font-size:13px;line-height:1.5;color:#7b817c;\">\n    Equipe %{company.name}<br />\n    %{signature}\n  </td></tr>\n  <tr><td style=\"padding:18px 10px 6px;text-align:center;font-family:Arial,Helvetica,sans-serif;font-size:11.5px;color:#9aa09b;line-height:1.6;\">\n    Para responder, basta <b style=\"color:#8a8f8a;\">responder a este e-mail</b> &mdash; sua mensagem entra direto no chamado.<br />\n    Portal oficial de manuten&ccedil;&atilde;o &middot; Pioneira em solu&ccedil;&otilde;es de seguran&ccedil;a biom&eacute;trica\n  </td></tr>\n</table>\n</div>',NULL,'2026-07-01 10:26:33','2026-07-03 21:37:38'),(8,1,'ticket.alert','Alerta de Novo Chamado','<h2>OlÃ¡ %{recipient.name},</h2> Novo ticket #%{ticket.number} criado <br /> <br /> <table><tbody><tr><td><strong>De</strong>: </td> <td>%{ticket.name} &lt;%{ticket.email}&gt; </td> </tr> <tr><td><strong>Departamento</strong>: </td> <td>%{ticket.dept.name} </td> </tr> </tbody> </table> <br /> %{message} <br /> <br /> <hr /> <div>Para visualizar ou responder ao ticket, por favor <a href=\"%%7Bticket.staff_link%7D\">faÃ§a login</a> no sistema de suporte ao cliente</div> <em style=\"font-size:small\">No sistema de suporte ao cliente</em> <br /> <a href=\"https://osticket.com/\"><img width=\"126\" height=\"19\" style=\"width:126px\" alt=\"Powered By osTicket\" src=\"cid:b56944cb4722cc5cda9d1e23a3ea7fbc\" /></a>',NULL,'2026-07-01 10:26:33','2026-07-01 10:26:33'),(9,1,'message.alert','Alerta de nova mensagem','<h3><strong>Hi %{recipient.name},</strong></h3> Nova mensagem anexada ao ticket <a href=\"%%7Bticket.staff_link%7D\">#%{ticket.number}</a> <br /> <br /> <table><tbody><tr><td><strong>De</strong>: </td> <td>%{poster.name} &lt;%{ticket.email}&gt; </td> </tr> <tr><td><strong>Departamento</strong>: </td> <td>%{ticket.dept.name} </td> </tr> </tbody> </table> <br /> %{message} <br /> <br /> <hr /> <div>Para ver ou responder o ticket, favor <a href=\"%%7Bticket.staff_link%7D\"><span style=\"color:rgb(84, 141, 212)\">logar-se</span></a> no sistema de suporte</div> <em style=\"color:rgb(127,127,127);font-size:small\">Seu Sistema de Suporte ao Cliente AmigÃ¡vel</em><br /> <img src=\"cid:b56944cb4722cc5cda9d1e23a3ea7fbc\" alt=\"Movido a osTicket\" width=\"126\" height=\"19\" style=\"width:126px\" />',NULL,'2026-07-01 10:26:33','2026-07-01 10:26:33'),(10,1,'note.alert','Novo alerta interno de atividade','<h3><strong>Hi %{recipient.name},</strong></h3> Um agente registrou atividade no ticket <a href=\"%%7Bticket.staff_link%7D\">#%{ticket.number}</a> <br /> <br /> <table><tbody><tr><td><strong>De</strong>: </td> <td>%{note.poster} </td> </tr> <tr><td><strong>TÃ­tulo</strong>: </td> <td>%{note.title} </td> </tr> </tbody> </table> <br /> %{note.message} <br /> <br /> <hr /> Para ver/responder ao ticket, favor <a href=\"%%7Bticket.staff_link%7D\">logar-se</a> no sistema de suporte <br /> <br /> <em style=\"font-size:small\">Seu Sistema de Suporte ao Cliente AmigÃ¡vel</em> <br /> <img src=\"cid:b56944cb4722cc5cda9d1e23a3ea7fbc\" alt=\"Movido a osTicket\" width=\"126\" height=\"19\" style=\"width:126px\" />',NULL,'2026-07-01 10:26:33','2026-07-01 10:26:33'),(11,1,'assigned.alert','Chamado atribuÃ­do a vocÃª','<h3><strong>OlÃ¡ %{assignee.name.first},</strong></h3> O chamado <a href=\"%%7Bticket.staff_link%7D\">#%{ticket.number}</a> foi designado para vocÃª por %{assigner.name.short} <br /> <br /> <table><tbody><tr><td><strong>De</strong>: </td> <td>%{ticket.name} &lt;%{ticket.email}&gt; </td> </tr> <tr><td><strong>Assunto</strong>: </td> <td>%{ticket.subject} </td> </tr> </tbody> </table> <br /> %{comments} <br /> <br /> <hr /> <div>Para ver / responder ao chamado, favor <a href=\"%%7Bticket.staff_link%7D\"><span style=\"color:rgb(84, 141, 212)\">acessar</span></a> o sistema de atendimento</div> <em style=\"font-size:small\">Seu amigo, Sistema de Atendimento</em> <br /> <img src=\"cid:b56944cb4722cc5cda9d1e23a3ea7fbc\" alt=\"Powered by osTicket\" width=\"126\" height=\"19\" style=\"width:126px\" />',NULL,'2026-07-01 10:26:33','2026-07-01 10:26:33'),(12,1,'transfer.alert','Chamado #%{ticket.number} transferido para - %{ticket.dept.name}','<h3>OlÃ¡ %{recipient.name},</h3> O Ticket <a href=\"%%7Bticket.staff_link%7D\">#%{ticket.number}</a> foi transferido para o departamento %{ticket.dept.name} ,por <strong>%{staff.name.short}</strong> <br /> <br /> <blockquote>%{comments} </blockquote> <hr /> <div>Para visualizar ou responder ao ticket, por favor <a href=\"%%7Bticket.staff_link%7D\">Entre</a> no sistema de ticket de suporte. </div> <em style=\"font-size:small\">Seu Sistema de Suporte ao Cliente amigÃ¡vel </em> <br /> <a href=\"https://osticket.com/\"><img width=\"126\" height=\"19\" alt=\"Desenvolvido por osTicket\" style=\"width:126px\" src=\"cid:b56944cb4722cc5cda9d1e23a3ea7fbc\" /></a>',NULL,'2026-07-01 10:26:33','2026-07-01 10:26:33'),(13,1,'ticket.overdue','Alerta de Chamados Atrasados','<h3><strong>OlÃ¡ %{recipient}</strong>,</h3> Um chamado, <a href=\"%%7Bticket.staff_link%7D\">#%{ticket.number}</a> estÃ¡ atrasado. <br /> <br /> NÃ³s devemos todos trabalhar para garantir que todos os chamados sejam gerenciados a tempo. <br /> <br /> Assinado,<br /> %{ticket.dept.manager.name} <hr /> <div>Para ver ou responder a esse chamado, favor <a href=\"%%7Bticket.staff_link%7D\"><span style=\"color:rgb(84, 141, 212)\">acessar</span></a> ao sistema de atendimento. VocÃª estÃ¡ recebendo esse aviso pois o chamado foi designado diretamente a vocÃª , a sua equipe ou departamento.</div> <em style=\"font-size:small\">Seu amigo, <span style=\"font-size:smaller\">(embora com paciÃªncia limitada)</span> Sistema de Atendimento</em><br /> <img src=\"cid:b56944cb4722cc5cda9d1e23a3ea7fbc\" height=\"19\" alt=\"Powered by osTicket\" width=\"126\" style=\"width:126px\" />',NULL,'2026-07-01 10:26:33','2026-07-01 10:26:33'),(14,1,'task.alert','Alerta de Nova Tarefa','<h2>Hi %{recipient.name},</h2> New task <a href=\"%%7Btask.staff_link%7D\">#%{task.number}</a> created <br /> <br /> <table><tbody><tr><td><strong>Department</strong>: </td> <td>%{task.dept.name} </td> </tr> </tbody> </table> <br /> %{task.description} <br /> <br /> <hr /> <div>To view or respond to the task, please <a href=\"%%7Btask.staff_link%7D\">login</a> to the support system</div> <em style=\"font-size:small\">Your friendly Customer Support System</em> <br /> <a href=\"https://osticket.com/\"><img width=\"126\" height=\"19\" style=\"width:126px\" alt=\"Powered By osTicket\" src=\"cid:b56944cb4722cc5cda9d1e23a3ea7fbc\" /></a>',NULL,'2026-07-01 10:26:33','2026-07-01 10:26:33'),(15,1,'task.activity.notice','Re:%{task.title} [#%{task.number}]','<h3><strong>Prezado(a) %{recipient.name.first},</strong></h3> <div><em>%{poster.name}</em> adicionou uma mensagem a tarefa que vocÃª participa. </div> <br /> %{message} <br /> <br /> <hr /> <div style=\"color:rgb(127, 127, 127);font-size:small;text-align:center\"><em>VocÃª estÃ¡ recebendo este e-mail por ser um colaborador do tarefa #%{task.number}. Para participar, simplesmente responda a este email.</em> </div>',NULL,'2026-07-01 10:26:33','2026-07-01 10:26:33'),(16,1,'task.activity.alert','AlteraÃ§Ãµes na Tarefa [#%{task.number}] - %{activity.title}','<h3><strong>OlÃ¡%{recipient.name},</strong></h3> Tarefa <a href=\"%%7Btask.staff_link%7D\">#%{task.number}</a> atualizada: %{activity.description} <br /> <br /> %{message} <br /> <br /> <hr /> <div>Para ver ou responder ao chamado, favor <a href=\"%%7Btask.staff_link%7D\"><span style=\"color:rgb(84, 141, 212)\">acessar</span></a> ao sistema de atendimento</div> <em style=\"color:rgb(127,127,127);font-size:small\">Seu amigo, sistema de atendimento</em><br /> <img src=\"cid:b56944cb4722cc5cda9d1e23a3ea7fbc\" alt=\"Powered by osTicket\" width=\"126\" height=\"19\" style=\"width:126px\" />',NULL,'2026-07-01 10:26:33','2026-07-01 10:26:33'),(17,1,'task.assignment.alert','Tarefa atribuÃ­da Ã  vocÃª','<h3><strong>OlÃ¡ %{assignee.name.first},</strong></h3> A tarefa <a href=\"%%7Btask.staff_link%7D\">#%{task.number}</a> foi designado para vocÃª por %{assigner.name.short} <br /> <br /> %{comments} <br /> <br /> <hr /> <div>Para ver / responder a esta tarefa, favor <a href=\"%%7Btask.staff_link%7D\"><span style=\"color:rgb(84, 141, 212)\">acessar</span></a> o sistema de atendimento</div> <em style=\"font-size:small\">Seu amigo, Sistema de Atendimento</em> <br /> <img src=\"cid:b56944cb4722cc5cda9d1e23a3ea7fbc\" alt=\"Powered by osTicket\" width=\"126\" height=\"19\" style=\"width:126px\" />',NULL,'2026-07-01 10:26:33','2026-07-01 10:26:33'),(18,1,'task.transfer.alert','Tarefa #%{task.number} transferida - %{task.dept.name}','<h3>OlÃ¡ %{recipient.name},</h3> Tarefa <a href=\"%%7Btask.staff_link%7D\">#%{task.number}</a> foi transferida para o %{task.dept.name} departamento por <strong>%{staff.name.short}</strong> <br /> <br /> <blockquote>%{comments} </blockquote> <hr /> <div>Para visualizar ou responder na tarefa, favor <a href=\"%%7Btask.staff_link%7D\">logar-se</a> no sistema de suporte. </div> <em style=\"font-size:small\">Seu AmigÃ¡vel Sistema de Suporte ao Consumidor</em> <br /> <a href=\"https://osticket.com/\"><img width=\"126\" height=\"19\" alt=\"Powered By osTicket\" style=\"width:126px\" src=\"cid:b56944cb4722cc5cda9d1e23a3ea7fbc\" /></a>',NULL,'2026-07-01 10:26:33','2026-07-01 10:26:33'),(19,1,'task.overdue.alert','Alerta de tempo de Tarefa','<h3><strong>Hi %{recipient.name}</strong>,</h3> Uma tarefa, <a href=\"%%7Btask.staff_link%7D\">#%{task.number}</a> estÃ¡ muito atrasada. <br /> <br /> Devemos nos empenhar em garantir que todas as tarefas estÃ£o sendo abordadas em tempo hÃ¡bil. <br /> <br /> Signed,<br /> %{task.dept.manager.name} <hr /> <div>Para ver ou responder nesta tarefa, favor <a href=\"%%7Btask.staff_link%7D\"><span style=\"color:rgb(84, 141, 212)\">logar-se</span></a> no sistema de suporte. VocÃª estÃ¡ recebendo notificaÃ§Ã£o pois esta tarefa estÃ¡ atribuÃ­da diretamente Ã  vocÃª ou para uma equipe ou departamente do qual Ã© membro.</div> <em style=\"font-size:small\">Seu Sistema de Suporte ao Cliente <span style=\"font-size:smaller\">(apesar da pouca paciÃªncia)</span> AmigÃ¡vel</em><br /> <img src=\"cid:b56944cb4722cc5cda9d1e23a3ea7fbc\" height=\"19\" alt=\"Movido a osTicket\" width=\"126\" style=\"width:126px\" />',NULL,'2026-07-01 10:26:33','2026-07-01 10:26:33');
/*!40000 ALTER TABLE `ost_email_template` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ost_email_template_group`
--

DROP TABLE IF EXISTS `ost_email_template_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `ost_email_template_group` (
  `tpl_id` int(11) NOT NULL AUTO_INCREMENT,
  `isactive` tinyint(1) unsigned NOT NULL DEFAULT 0,
  `name` varchar(32) NOT NULL DEFAULT '',
  `lang` varchar(16) NOT NULL DEFAULT 'en_US',
  `notes` text DEFAULT NULL,
  `created` datetime NOT NULL,
  `updated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`tpl_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ost_email_template_group`
--

LOCK TABLES `ost_email_template_group` WRITE;
/*!40000 ALTER TABLE `ost_email_template_group` DISABLE KEYS */;
INSERT INTO `ost_email_template_group` VALUES (1,1,'Modelo PadrÃ£o do osTicket (HTML)','pt_BR','Modelos PadrÃ£o do osTicket','2026-07-01 10:26:33','2026-07-01 13:26:33');
/*!40000 ALTER TABLE `ost_email_template_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ost_event`
--

DROP TABLE IF EXISTS `ost_event`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `ost_event` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(60) NOT NULL,
  `description` varchar(60) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ost_event`
--

LOCK TABLES `ost_event` WRITE;
/*!40000 ALTER TABLE `ost_event` DISABLE KEYS */;
INSERT INTO `ost_event` VALUES (1,'created',NULL),(2,'closed',NULL),(3,'reopened',NULL),(4,'assigned',NULL),(5,'released',NULL),(6,'transferred',NULL),(7,'referred',NULL),(8,'overdue',NULL),(9,'edited',NULL),(10,'viewed',NULL),(11,'error',NULL),(12,'collab',NULL),(13,'resent',NULL),(14,'deleted',NULL),(15,'merged',NULL),(16,'unlinked',NULL),(17,'linked',NULL),(18,'login',NULL),(19,'logout',NULL),(20,'message',NULL),(21,'note',NULL);
/*!40000 ALTER TABLE `ost_event` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ost_faq`
--

DROP TABLE IF EXISTS `ost_faq`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `ost_faq` (
  `faq_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `category_id` int(10) unsigned NOT NULL DEFAULT 0,
  `ispublished` tinyint(1) unsigned NOT NULL DEFAULT 0,
  `question` varchar(255) NOT NULL,
  `answer` text NOT NULL,
  `keywords` tinytext DEFAULT NULL,
  `notes` text DEFAULT NULL,
  `created` datetime NOT NULL,
  `updated` datetime NOT NULL,
  PRIMARY KEY (`faq_id`),
  UNIQUE KEY `question` (`question`),
  KEY `category_id` (`category_id`),
  KEY `ispublished` (`ispublished`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ost_faq`
--

LOCK TABLES `ost_faq` WRITE;
/*!40000 ALTER TABLE `ost_faq` DISABLE KEYS */;
/*!40000 ALTER TABLE `ost_faq` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ost_faq_category`
--

DROP TABLE IF EXISTS `ost_faq_category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `ost_faq_category` (
  `category_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `category_pid` int(10) unsigned DEFAULT NULL,
  `ispublic` tinyint(1) unsigned NOT NULL DEFAULT 0,
  `name` varchar(125) DEFAULT NULL,
  `description` text NOT NULL,
  `notes` tinytext NOT NULL,
  `created` datetime NOT NULL,
  `updated` datetime NOT NULL,
  PRIMARY KEY (`category_id`),
  KEY `ispublic` (`ispublic`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ost_faq_category`
--

LOCK TABLES `ost_faq_category` WRITE;
/*!40000 ALTER TABLE `ost_faq_category` DISABLE KEYS */;
/*!40000 ALTER TABLE `ost_faq_category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ost_faq_topic`
--

DROP TABLE IF EXISTS `ost_faq_topic`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `ost_faq_topic` (
  `faq_id` int(10) unsigned NOT NULL,
  `topic_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`faq_id`,`topic_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ost_faq_topic`
--

LOCK TABLES `ost_faq_topic` WRITE;
/*!40000 ALTER TABLE `ost_faq_topic` DISABLE KEYS */;
/*!40000 ALTER TABLE `ost_faq_topic` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ost_file`
--

DROP TABLE IF EXISTS `ost_file`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `ost_file` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `ft` char(1) NOT NULL DEFAULT 'T',
  `bk` char(1) NOT NULL DEFAULT 'D',
  `type` varchar(255) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '',
  `size` bigint(20) unsigned NOT NULL DEFAULT 0,
  `key` varchar(86) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
  `signature` varchar(86) CHARACTER SET ascii COLLATE ascii_bin NOT NULL,
  `name` varchar(255) NOT NULL DEFAULT '',
  `attrs` varchar(255) DEFAULT NULL,
  `created` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `ft` (`ft`),
  KEY `key` (`key`),
  KEY `signature` (`signature`),
  KEY `type` (`type`),
  KEY `created` (`created`),
  KEY `size` (`size`)
) ENGINE=InnoDB AUTO_INCREMENT=44 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ost_file`
--

LOCK TABLES `ost_file` WRITE;
/*!40000 ALTER TABLE `ost_file` DISABLE KEYS */;
INSERT INTO `ost_file` VALUES (1,'T','D','image/png',9452,'b56944cb4722cc5cda9d1e23a3ea7fbc','gjMyblHhAxCQvzLfPBW3EjMUY1AmQQmz','powered-by-osticket.png',NULL,'2026-07-01 10:26:32'),(2,'T','D','text/plain',30,'5Ks2wB0UQnsSYJg0E7WJAwxSnBfGog2M','B0UQnsSYJg0E7WJA5TTYqZAEmjOk93Vy','osTicket.txt',NULL,'2026-07-01 10:26:33'),(3,'T','D','image/png',43206,'cSEylC50PFSgJr0hu19C1gnv4Crv1_bo','C50PFSgJr0hu19C1fGdT08KSD-SsDHgU','Imagem2.png',NULL,'2026-07-01 14:14:20'),(22,'Z','D','image/jpeg',3579,'mUSZw3dFJxNdD9GfAiWxRid-W-5e1Gys','3dFJxNdD9GfAiWxR68lGp52hO8jReG6j','V5L.jpg',NULL,'2026-07-03 09:49:38'),(23,'Z','D','image/jpeg',3407,'xMieJ-CGU7V52oh4aN5T_ZxlGj-Avb0o','-CGU7V52oh4aN5T_CK1Rt3Plx6ZWMOlk','V4L.jpg',NULL,'2026-07-03 09:49:38'),(26,'Z','D','image/jpeg',9647,'9GcvfsUd23LTl79db6waHsaVKU69jz9Q','sUd23LTl79db6waHwCla640SgO1nAQ81','Proface x.jpg',NULL,'2026-07-03 09:49:38'),(40,'Z','D','image/jpeg',3695,'-lIiqBqSN3AiPHRoLwAyt2H4Gx6qGzTw','BqSN3AiPHRoLwAytSjGoM-lVPCBR6Ibd','Proma.jpg',NULL,'2026-07-03 22:59:14'),(41,'Z','D','text/plain',5524,'HxLZYr4Mpx9LNjoG5z8meF7Xh2OobbSQ','r4Mpx9LNjoG5z8me072TPP4sphfavBMK','embratecc-remessa para conserto.xml',NULL,'2026-07-03 23:01:44'),(43,'Z','D','image/jpeg',31764,'m2hEpZHtIR014Z3ynlbqLJhblujoiHds','ZHtIR014Z3ynlbqLK_LQTjBMvHb7c-9P','V3L Lite.jpg',NULL,'2026-07-13 13:26:56');
/*!40000 ALTER TABLE `ost_file` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ost_file_chunk`
--

DROP TABLE IF EXISTS `ost_file_chunk`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `ost_file_chunk` (
  `file_id` int(11) NOT NULL,
  `chunk_id` int(11) NOT NULL,
  `filedata` longblob NOT NULL,
  PRIMARY KEY (`file_id`,`chunk_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ost_file_chunk`
--

LOCK TABLES `ost_file_chunk` WRITE;
/*!40000 ALTER TABLE `ost_file_chunk` DISABLE KEYS */;
INSERT INTO `ost_file_chunk` VALUES (1,0,'‰PNG\r\n\Z\n\0\0\0\rIHDR\0\0\0Ú\0\0\0(\0\0\0˜GäÉ\0\0\nCiCCPICC profile\0\0xÚSwX“÷>ß÷eVBØğ±—l\0\"#¬ÈY¢’\0a„@Å…ˆ\nVœHUÄ‚Õ\nHˆâ (¸gAŠˆZ‹U\\8îÜ§µ}zïííû×û¼çœçüÎyÏ€&‘æ¢j\09R…<:ØOHÄÉ½€Hà æËÂgÅ\0\0ğyx~t°?ü¯o\0\0pÕ.$ÇáÿƒºP&W\0 ‘\0à\"çR\0È.TÈ\0È\0°S³d\n\0”\0\0ly|B\"\0ª\r\0ìôI>\0Ø©“Ü\0Ø¢©\0\0™(G$@»\0`UR,ÀÂ\0 ¬@\".À®€Y¶2G€½\0vX@`\0€™B,Ì\0 8\0CÍ L 0Ò¿à©_p…¸H\0ÀË•Í—KÒ3¸•Ğ\Zwòğàâ!âÂl±Ba)f	ä\"œ—›#HçLÎ\0\0\ZùÑÁş8?çæäáæfçlïôÅ¢şkğo\">!ñßş¼Œ\0NÏïÚ_ååÖpÇ°u¿k©[\0ÚV\0hßù]3Û	 Z\nĞzù‹y8ü@¡PÈ<\ní%b¡½0ã‹>ÿ3áoà‹~öü@şÛzğ\0qš@™­À£ƒıqanv®RçËB1n÷ç#şÇ…ı)Ñâ4±\\,ŠñX‰¸P\"MÇy¹R‘D!É•âé2ñ–ı	“w\r\0¬†OÀN¶µËlÀ~î‹XÒv\0@~ó-Œ\Z‘\0g42y÷\0\0“¿ù@+\0Í—¤ã\0\0¼è\\¨”LÆ\0\0D *°AÁ¬ÀœÁ¼ÀaD@$À<Bä€\n¡–ATÀ:Øµ°\Z šá´Á18\rçà\\ëp`Â¼†	AÈa!:ˆbØ\"Î™\"aH4’€¤ éˆQ\"ÅÈr¤©Bj‘]H#ò-r9\\@úÛÈ 2ŠüŠ¼G1”²QÔu@¹¨\ZŠÆ sÑt4]€–¢kÑ\Z´=€¶¢§ÑKèut\0}Šc€Ñ1fŒÙa\\Œ‡E`‰X\Z&ÇcåX5V5cX7vÀaï$‹€ì^„Âl‚GXLXC¨%ì#´ºW	ƒ„1Â\'\"“¨O´%zùÄxb:±XF¬&î!!%^\'_“H$É’äN\n!%2IIkHÛH-¤S¤>ÒiœL&ëmÉŞä²€¬ —‘·O’ûÉÃä·:ÅˆâL	¢$R¤”J5e?å¥Ÿ2B™ ªQÍ©Ôªˆ:ŸZIm vP/S‡©4uš%Í›CË¤-£ÕĞšigi÷h/étº	İƒE—Ğ—Òkèéçéƒôw\r†\rƒÇHb(k{§·/™L¦Ó—™ÈT0×2™g˜˜oUX*ö*|‘Ê•:•V•~•çªTUsU?ÕyªT«U«^V}¦FU³Pã©	Ô«Õ©U»©6®ÎRwRPÏQ_£¾_ı‚úc\r²†…F †H£Tc·Æ!Æ2eñXBÖrVë,k˜Mb[²ùìLvûv/{LSCsªf¬f‘fæqÍÆ±àğ9ÙœJÎ!Î\rÎ{--?-±Öj­f­~­7ÚzÚ¾ÚbírííëÚïup@,õ:m:÷u	º6ºQº…ºÛuÏê>Ócëyé	õÊõéİÑGõmô£õêïÖïÑ7046l18cğÌcèk˜i¸Ñğ„á¨Ëhº‘Äh£ÑI£\'¸&î‡gã5x>f¬ob¬4ŞeÜk<abi2Û¤Ä¤Åä¾)Í”kšfºÑ´ÓtÌÌÈ,Ü¬Ø¬Éì9Õœka¾Ù¼Ûü…¥EœÅJ‹6‹Ç–Ú–|Ë–M–÷¬˜V>VyVõV×¬IÖ\\ë,ëmÖWlPW››:›Ë¶¨­›­Äv›mßâ)Ò)õSnÚ1ìüì\nìšìí9öaö%ömöÏÌÖ;t;|rtuÌvlp¼ë¤á4Ã©Ä©ÃéWgg¡só5¦KË—v—Sm§Š§nŸzË•å\ZîºÒµÓõ£›»›Ü­ÙmÔİÌ=Å}«ûM.›É]Ã=ïAôğ÷XâqÌã§›§Âóç/^v^Y^û½O³œ&Ö0mÈÛÄ[à½Ë{`:>=eúÎé>Æ>ŸzŸ‡¾¦¾\"ß=¾#~Ö~™~üû;úËıø¿áyòñN`Áå½\Z³k™¥5»/>B	\rYr“oÀòùc3Üg,šÑÊZú0Ì&LÖ†Ïß~o¦ùLéÌ¶ˆàGlˆ¸i™ù})*2ª.êQ´Stqt÷,Ö¬äYûg½ñ©Œ¹;Ûj¶rvg¬jlRlcì›¸€¸ª¸x‡øEñ—t$	í‰äÄØÄ=‰ãsçlš3œäšT–tc®åÜ¢¹æéÎËw<Y5Y|8…˜—²?åƒ BP/Oå§nMò„›…OE¾¢¢Q±·¸J<’æV•ö8İ;}Cúh†OFuÆ3	OR+y‘’¹#óMVDÖŞ¬ÏÙqÙ-9”œ”œ£R\ri–´+×0·(·Of++“\räyæmÊ“‡Ê÷ä#ùsóÛl…LÑ£´R®PL/¨+x[[x¸H½HZÔ3ßfşêù#‚|½°P¸°³Ø¸xYñà\"¿E»#‹Sw.1]RºdxiğÒ}ËhË²–ıPâXRUòjyÜòRƒÒ¥¥C+‚W4•©”ÉËn®ôZ¹ca•dUïj—Õ[V*•_¬p¬¨®ø°F¸æâWN_Õ|õymÚÚŞJ·ÊíëHë¤ën¬÷Y¿¯J½jAÕĞ†ğ\r­ñå_mJŞt¡zjõÍ´ÍÊÍ5a5í[Ì¶¬Ûò¡6£öz]ËVı­«·¾Ù&ÚÖ¿İw{óƒ;Şï”ì¼µ+xWk½E}õnÒî‚İ\Zbº¿æ~İ¸GwOÅ{¥{öEïëjtolÜ¯¿¿²	mR6H:på›€oÚ›íšwµpZ*ÂAåÁ\'ß¦|{ãPè¡ÎÃÜÃÍß™·õëHy+Ò:¿u¬-£m =¡½ïèŒ£^G¾·ÿ~ï1ãcuÇ5W (=ñùä‚“ã§d§N?=Ô™Üy÷Lü™k]Q]½gCÏ?tîL·_÷ÉóŞç]ğ¼pô\"÷bÛ%·K­=®=G~pıáH¯[oëe÷ËíW<®tôMë;ÑïÓújÀÕs×ø×.]Ÿy½ïÆì·n&İ¸%ºõøvöíw\nîLÜ]zx¯ü¾Úıêúê´ş±eÀmàø`À`ÏÃYï	‡ş”ÿÓ‡áÒGÌGÕ#F#\r\Z½òdÎ“á§²§ÏÊ~Vÿyës«çßıâûKÏXüØğù‹Ï¿®y©órï«©¯:Ç#Ç¼Îy=ñ¦ü­ÎÛ}ï¸ïºßÇ½™(ü@şPóÑúcÇ§ĞO÷>ç|şü/÷„óû€9%\0\0\0tEXtSoftware\0Adobe ImageReadyqÉe<\0\0(iTXtXML:com.adobe.xmp\0\0\0\0\0<?xpacket begin=\"ï»¿\" id=\"W5M0MpCehiHzreSzNTczkc9d\"?> <x:xmpmeta xmlns:x=\"adobe:ns:meta/\" x:xmptk=\"Adobe XMP Core 5.6-c014 79.156797, 2014/08/20-09:53:02        \"> <rdf:RDF xmlns:rdf=\"http://www.w3.org/1999/02/22-rdf-syntax-ns#\"> <rdf:Description rdf:about=\"\" xmlns:xmp=\"http://ns.adobe.com/xap/1.0/\" xmlns:xmpMM=\"http://ns.adobe.com/xap/1.0/mm/\" xmlns:stRef=\"http://ns.adobe.com/xap/1.0/sType/ResourceRef#\" xmp:CreatorTool=\"Adobe Photoshop CC 2014 (Macintosh)\" xmpMM:InstanceID=\"xmp.iid:6E2C95DEA67311E4BDCDDF91FAF94DA5\" xmpMM:DocumentID=\"xmp.did:6E2C95DFA67311E4BDCDDF91FAF94DA5\"> <xmpMM:DerivedFrom stRef:instanceID=\"xmp.iid:CFA74E4FA67111E4BDCDDF91FAF94DA5\" stRef:documentID=\"xmp.did:CFA74E50A67111E4BDCDDF91FAF94DA5\"/> </rdf:Description> </rdf:RDF> </x:xmpmeta> <?xpacket end=\"r\"?>‹şöÊ\0\0IDATxÚì]	œSÕÕ?/{2Édf€aq]67ĞÏ­(*¨-\nöó³¶.õ+ÖÖ…º nµJÁ­öS‹R´Õ:VDT¤,eÑ2¨l‚ ¬‚ì‹3ÌÂL’—÷İ›üosæN’ÉPqÌùı$“—÷î»÷üÏùŸsï»1†NY96¤ÚtÒØîïS±/QÄı]k~K¡“…îz›Ğí>ƒ%4ß¤Ò5ºú­<²Ù,²ÍclmYóÎÊ’„\'ôÇB¯hô·£BóLZ¸ŞM?›¤°\0]s™GÖ>¾×âZ(4W¨]h\r\"Ò¾&F4™]ş¶?JKD$úF>Yd-}QŠZY eå»)­„*t€ĞÓ„¶êà$»‰\r	=(t•ĞéBg	=Á¹íø_‚´¢Ñ”Q\0mÆVí+³SvaŠD›WÇgöıB¯ú¿B»eøŞB¯ºLèH¡Ò›#tó»BÇ	ımFW’\0;tÈ _Ùì@–ÍÑš¿x„Ş.t!¿[Î!#à\\¡÷ã|ÉäWˆ’:÷Ø\rG³ I³·9é‰Ò*Ê6ËÈ­ùJk¡S…şAèqGÀN¼\09¤›EBïM¹~-4?í™Õ~ã I‹}Ô&·yåeYêØüå¡o\níu„Ï{.r»½Bk¸Öiv?Š—úLG·´Ñ”µjÈ-+ß‘Qæ•£\02%>ä|™Êï(^Í›’ß\nêXèÆr³æTÒÏRÇæ-’*öÿ–®-ãÑR¡Ë…V±¿ËBIË:GÊTÌ#şÉ5iş\ZE\"Fó”lD;æ\\_äp¾ısjÊdñ‘“õB\"t‡ĞB)ô2äwßÄïÏŠ»÷`”æ­ôĞ¤•^š¶ÑMnA!æ<¬YË>†¼¥’í§ö\n«ktõMæJw%ù»œ<.ÿİÂÃB¿U\\GñBI?ç¦“]\0ÌoÆĞôå^ıô¥ºeF&.÷‘×a‘Ça5ï±Íš÷±#Ò£o>¤=L^«Ñş]FÚßJ…N\0ƒG¹ùã…¾V‡\Zú¢!q#!Å–ÛéÀ6=Xê§9›\\T2Èï²¨{«™cÑæ³,Ğ)zak³l´ú@1õÏß{¡„^£ıMF”¡_bÕæ(7ı9¡£­‘+\'J«Ö{hñ—nê¡[\\ôhiµóGc41\'\'±Mëû1¶³Ï>;káÇL›¿ŒŞÜİ‹ú·Ø$Ü|Æ~ğ,Š—İ•”xß ¶lÚâ(4W.Ó\ZAjÕˆÂrâãsrÉWµÉMĞW”rİ\"zµh«>²í;™§Y”çªŠE,0ŞŒ\\¾\\1ïbïº¯å\"á\'„¾‘ÁxËüêuĞLYÌÈ£x9ß)´ù^[\0›PôXVç‚NXá¥Í»T(\"Y¶‰u‹ßWevŠİˆRUØC55AòØC™ĞGY6?‘½ÿ@è«Ú1k„VS|‚9ÈIîXÊè£Ä*rDÊ\"€öL¡ƒ„Î=*@4é«=NÊwZj‰9¾%pÉöÊ%aíñ~ĞyBe–•˜øíµ´¢¢\r•ììKÃ;HTëoè+ƒ)¾QÉ_Å¸t¡Ôë‰cIìUÈ±B\"”VÚªÈVg>LÊvW¦Sâ1›|òX»¶îpÑ°Éy´í Zx£rR­Å\'·# °)ıÅWšHª[ ÔöÊº±	İ(#ò=B2ŠûC¡Û²@ËJL,H$Ëİµ(ñŸN)2š©°\'¿›ä˜®\ZµÔ/*Ïğ\'rZŸKDÜûV((ßÕg	Œ²Å›{€ÆP“]aYÇ ¹jßŠ=B³\n\"4~n€VnwR÷¶‘XFñUÿrQsÎJdäÜ\Zz¾ô7\"ày¡7e©cVŠ¸ªéı½İèäàê%”BşT`Ë…SòOĞ;]NNy±XŞz7â¶s´Ñ}óôä‡~j/¨ß¬\rnª´·ÒFÃz×ĞÈ*ˆÄf–Û‰æ´Œ5)×ÜEè¡EK|ôÖj·4Èù4\rI.òÂ–”x¶ÍÛÄ.ŒjÀ6ˆ¨GJG_÷†Ó˜‘Zz1`NxãPŠã<8¦^şÈ$6“vÔhUYõ\nìG¶äójrŞ¬/^ïD¥‹¤aİSš£ÛšImÂ·Lœ•\Zû^ fZË†A36ºck å{,\Z9 RÜ±@WµQ% °Zädó·×ãWmö†o–\'rKŠÇJöŠöU0Ã7YŞ§D~&*¯ØòÑÿ•‡1~ÿé…&=PH:	ïÇeÖ°È~¹|Ôd4ÅŸ:æÒ‡âë\nÛã˜{ÔÅ£TÇ¹+h²,ó‹ˆÖ9wwªÍzäüX\0¯¿ıÒå-‡K€ÌN/RÛğÍÏÌÌ\rİ3-H…h+Ÿapymv+ÒÊgÉ§¥7·òE#ó¶:éê’*¹ò€ÛêZ;xù×ÎwÉ*‰¯Kq¨8WàQ€Ì€È¶<ğ{X&Ò£”xPTRÏ;PÄ‘ ü#œ—›š²%Â·\'íÈH/¼d–¢&Añy©ø?™• ²åLjÈ‡6á=\"²9¡t9\Z_¨»2I$Ûõ\0éKí,Ú-\"Ùh²ùg.İşv°°8ß¼Éa‹=¨Ù]MV*D-z²c0:òz7yßÉ£GÏ¯(/y=¿|Ò§^[¹Óº¶caäq>ÑºQj‹ĞÇ)¾bD—¯ÙkyƒŸJ@ãıÖc˜å¤K–·¡ £leh\rK„ÑÅ)¨ãAxnıvF8\r“J¶Bww*%Gl^Í–Ì‹*ùDûLVÜş†ª —)QÓxÀæ1×NTñ7oæÑ.ß|Îe§S¢Vì>^„ÑÈüèB/‘\ZÒ½ÇÍqSEŞöÅ>;-Şî41út¯ö¡¦iDÅç“8U”}\'Ñ\"ôOBÏz–#ñœÍÅŞw¢ø–v8;¹„ìIºF>È:Ô¹³ã°€âO4Dåå³r—‚ÖáŒÆSİmò.¦øF!%¦8äŠ›I¬‚y\"úº“†§‹á„eÛ*HàNEÃf£t5ÅçK#Á®L’›BâçÅEÁ3ãÙ6P• Ëı$ŠV72öã;ÜèP\"1úÃ“È¹ ùàòÄ¡Ú¹ƒÔ\\y¨Õ ä(ªrÿ\"ªW²>•ƒªİzúSñ}‹ê|?AŸÈ6N£øŠyÎ‹p9H«’\0¢­ŠÄ6Â1‹6Ê§PÔZ}iÍ\"§²R7Å%’ŞOŞèÄûíÑ‹kCU!j/@61à²z	Ê\'ó‰[„~¥åw×£ú7V\0q_®+ö}ê˜o^e4\"6¶‰½Â¨ôs„ş¶ô!Å×\\râÊkJN­Tò—$@“Q÷Nª¿®SÉù ¥éæÌ$yZ(_õ:ë{éÀäW,”¤\r·/ƒ¹u¹\ZsÖx†çÑ°qhèØæ‚ç«Ğ.ŸŞ}	Š‹ìg(¾b[\ZÖsğL7ãüRF¡ä+¯%¡(ÁßGÃ8\"ğ4¤rê)Ú5VÂ‚6IÙFõ\r:ï XR>9±ÚQ;G)Ú´ïï¦øÀ^–ÓLÈ°RÆ#‹ÌÓ.cà/Â õÀ5/dÔIzf9¹,ç›æ}Og+>{8¾²¾xqï*êîÀk¹‚^ßZ`5¢Êr¹uÀÜuúºÊ ¾è\"’IÍE[uT‹\\µ\nÑqŒÈßfåº-éÏµâÍº/I4%8´{0Æ7\"W+k «¼T…ŒGa_édC:¶ö¨2ÙÆá¸ßv\0İYìóµÈ-»£ß{À¶ú0ÇŸNì6VıñÂàû!1ıšyˆš\0@LF™yè@:ö:xæ:¬/+EŸÃ®u.^f=0	²WÈV\"b…¦KĞ5¬3G í„ht¸#À+Áõ>?÷àÇ½=‚ö˜0}0Ît É¼×´u\rşVˆ¶Ê9¬)ŒftÑ¼~;¼WŸ9XtÈtÆŠ#)\n6Exı9r¢óá8¸¼ë_K€Ì¥gè‘—æDûŠœì¬š¿+	È¸¼\nìáZ­ôşušï-@ßGğİLÊò©¢İM\ZÈÂ`Òñ^Nñ\r‚^F¥È«	ÇİÈŞÏ` #¸ÎbLåFDÚ~”xÖ@7Ÿ„Ó:ÉÛş!lò1Àl\Z—•\'ş9@p)‹báPbNæUP®óq¬â¬÷ñşt€è8’\"–\'ª\r\\&!Âª²·ã&OGG×‚bŞnf`]Ê0çèN=m?‘ÏkõÂëÛXïF$?µ±2übP\n±ÁØ•p¶0˜ë{õEAoh¿Œ|®êdùYë·E,ÇqjQe˜0×íT`ÒËK|4bf.äDÉf‹õ‡ŒÚo³èNÔDøÃªÒı=l,uÙ1¹\\£¤•vßU‹‹¼îP°šwÀB®G_û)1§\0»NŸo©°¡–¥CØçÄÆç&ÒûØç—Í<Pq~ÿ6ª®²cmZ˜Àæb>Æ	”\\£U†ñ£ÿ‚\' øyø>!Ü¶F¾äG´,ÍGä²ÊMOÉf ÊuQçìÀÕàınxª©ˆŠªHğrL<Ü4Š?f/å qR¦ƒêJÊ¿É¤%e\"£‰È2s!Ö§Œ!¨¯\'ó~Ëëp\r#Jeå¹+R=uËúm£^J¾‚U’|¨²ÊFïop“C¼öú(h_oI3™Ì]puB4û+®q.¢ÖC—¶I[ÙIM›gTm(‹üFò‡Fœg/\"êX–·®Aÿğ]™¯\03#°¨)IÎ5ã­rØ¬ÀcÓ¨}ÊªãGÚû…@©@Q¾|\0ºÂE(ˆN‘åw”ØÌ¥şuDÎK\0–şhÔ*äYªC¥.ƒ1ÛàUrX4<y¢ÅÌ;²Èù_B¿@‡D1p~mxŞVËŞ¯è»g´5Zeò+xĞãàH¶Ì\'ÃP\rDé¾¬Ÿë€lw­ŸúöPÍÌdùxì>]h÷ü­B‹°›ÕG¼¾ÔG¯­ğR·Âˆ|ÈÒ`ıœéQìêvğ¢ÛÓ ÀB¿†C,Eî¶ˆROøg*µ÷/6òû9 pª8!Ä­Œæì”¯ q\"BZ45xH2Å¢-G: ™I83%©¾Õ$ñ‚|™‹aYÛ\0<Ü´¤Z½ÈW³›Ø0ì&ªÑæÏaTnÍàU¹ØÃ¢ÓZtš¦epª\ZØÔi#E¿™ŒF¨6Îıé*Ûí\\çóo¾­&H\'	=Ğc6¹m\"Ä¶6¨WéÆÜJVQSq*ê²¨b§“¦,óQ› ©d¶±{Î4Òğ{r²±Êu!Æ²è×F¡n£¦-èµ’Ì–7a®íL­¸‘ƒê7i@ã{PLé–®%$Â(Ğô\'qû°c¶€Ãw`”`@ùˆ5	´eöÀ°Ôã\Z—²Èò9ÀfÕ£¡š—V%õ®¯¢“M(–Ã«úqÎağúês¾ß÷Q€è¨w^Ë“wÒ\nRZ0Ç²‹EÍOàtn`Å‡Åè—¸eY=Şm.ù÷’\'2_ªıCN`Æ®Š(!–kÇûMĞÄû4u›º%¼4)±H¦[øĞ/ª;õı}\\Œş8›*äXüŒÔ=Mwh\r\Zt\nÑ\\\'\"Ü\nÆ„ìZ~M3µ-9Ù8ÚR8‰¤g†_@uWNÀæ4º²ê“šÏ¹›5b5ËóT^RcSVh§bà>b\0#äØ5:¡,ûwÌcT§¨Pma×ù¢ú¼\'¦ şE	e0ÃXÔBI‹Fx\\y¾•ÀUìõ\"­8¡rãõ[ü„EŞr:!5ˆdIA–Çhí\'Z4Wt°¶¶¯gÎ4é†²övä<ÇQı]ˆ-ôÿ\\âØA(5`m,¯	çšŒÂ‰’V¨\ZúXd¯Ñ*¦çPbõ<¦B%+û#c.V* éíP”˜,VÕ™y(:Œ\0°F#\"|Fu7†™Áªl+\0(¿–´ïÅ€ôbóŸ²‚Ì`xÚ—PRı7Õ*)ù.^U(è\\ÎœŠ÷;†¶è„«PĞ™\0ƒy—\ZÀ™êÇñèü\0ˆjËì8™§ı\ZÇĞó“ŞİyÙd…Qæe©Ÿ®Zó	ÆEOÀ·ıÛhÂu)ˆĞĞîµ´h»3¶!›[SUÄ\'¨á_Œˆqü¢õÇ(.ı”RO¯BÑbòºW›Ñ¶hï¯Ô‹G\rÈN«ÖÀ)Îîé|V¦FühÿÁ&D]îôêE4 ky6hwâõ =ßàÄ?D©½\'›³¹•uüb-áTsû˜G•²”y­yˆ¬`8—¢ßÇ<…\na+VÂ\rh÷2	óxš«1×Ñ–MA¼y—)lŞk$¸ü³¬H‘Ãy™7üıt\r¢•jËHô/6-ÓJÀu&<}\"¢QÄ•n@{³jğK\Zµ.`-N±BÚ†éšÓ«hµM/^•‚\\ß€1vSÃ/GJP”!½6#¢½£9¶:Cbı±öğ€æDÄRİ_Ì9ø†C\r‹şSU]SE4;¼òĞBªo¯\"¢(ùø÷Px)\'ŒåÌµpÊ²Ô	ŞÓœ{ˆPï4	şå0,@:ÑL•\\jÕ_ğùgù08‚0îc‹\"!Üë,x77®ñ\Z\nğdû\"~hàƒç“çºùŞ~P•9I¸ı,FSçÔ;km@F2?\n%û5z|:ú¸5hĞDíÛCØtGÂTET“å}-şËqzç{\n¥ûiIî³Q¿3ş#æÌdtş-Æ!ÙDWDÒ#w#e&°š\ZñÀQNDûw•€İ”jíq²¢Ô{p¤£k›§£+Ü{gZÇ«rĞ¥l«Á\"ülm$lÛp$I?€1»`<ÉøË:$“êìBiæb–B“c]šÎİ€k8q°vC”d’W“èxUŞ\'¹y¿À¡¬ ğQ’é.ˆ=o…3µV…˜ %–ş|Fõ×=ŠVÊ+­$‹E\'^9Oõ7KíÏLõƒè½²Z…äÈ«³IÎ4xø‡a°ÏÂA•á>ÎÄgĞ·³³¾\0`_c:\ZÁ˜\rF´(Dä~@3Ñ·3)±¾S:¸ß _?ğµ€“\\¨M)è´î8Ö~x/ÆïÁÆF!ÕPnép/Ø½åØ%h[pİ‹Xes,Ú¾Ä‘¢\nieLÓ˜ÉD÷JKKrÖu”A˜)JÀw\"öd´±şò¥x^¶ÌâWÈû\npÓÉæ$¹Æ\0D÷(¢-‹]]¢Ó:†hk¹çi„üd3ş¿ªñ+ğî;ØßUnş4\nKÉ¶P(PÇhıë×\n;^»Æ²”,]|„X¾Ë«±Tw	VÆŞv\0¼uª¿à¾bS(ÁÕÙ–Z?=g`x’ÚÑ¡5ÀMY9\Z’ƒ\\Sl3¨e:Y	jæBn©v¡J5—sûzÒSĞÆ.\'ÔÒ%›jhÌœ€\0Z=_ğ\Z¢ó¥˜öh`oe[šâºË)ñ#ñ2§i°ìŸMÉ7×™bV÷õ«„N@tòSı_]ŠëıÿwfHuÍ™He¦ãmĞéÿÛHk ZµDÛ½øî\'(˜ƒŠ¹NT»ç|_;ç\"´ëVJLÉ”i¾ñòË/÷BhŒ ‘³¸8â\"©Æ/á!wÂûšìÀëÊF5åüvT!+QÁ­/A“FOÒ˜Òê4›CŸ\Zp0jC•\nJÌ\'6¸£Qš~Ô7vD3/ØB5¨ªÕ@ÛZ pÉãËş_€\0³à¯˜s]Jı\0\0\0\0IEND®B`‚'),(2,0,'Anexos prontos sÃ£o o mÃ¡ximo!'),(3,0,'‰PNG\r\n\Z\n\0\0\0\rIHDR\0\0\0²\0\0\0†\0\0\0yaĞÓ\0\0\0sRGB\0®Îé\0\0\0gAMA\0\0±üa\0\0\0	pHYs\0\0Ã\0\0ÃÇo¨d\0\0¨[IDATx^íıWpÉ–¦Bk\r\0HBÔ A	Pk­µÖZk­µÖÔ*3™âˆª<¢ªûÎ\\³yÇkcÖSİÕİóÒ}çVÕé#ª¬ïšÿóØ@&2OÍÌKÙÙfËByxx„¾üw±£ì/¿¿üş\rüşò_~ÿ&~ù/¿¿¿€ü—ß¿‰ß_@şËïßÄï/ ÿå÷oâ÷ÿòû7ñkòŸşô\'ûÃş û½ış÷¿·ÿñ?~oÿôO¿³ü‡´ø?şÁşÙ?hıÿ1bÿô:şö»ßı“ìwö»ÿñ;û\'­³/0ö³˜?}¿ÿıÿ°?şñöÇ?ıQ¦¥Öÿ ãº¿ûİÿâÓ’mÒÃñ?)ìŸ\"a]x¥õ÷¿ÿhlÿñ„ùhl»khéÿñ:öÇ?Ù?ë~Ãaÿ‰÷O„i¶?ı°éü?şéŸunKûçÖòŸ[ÅİlìÇBáİÒïomÃù}¤»eÚ#ûuM®İÒ\"û›Ïù)ÖVzşæÅgŒı­…÷iéŸeëûú—ş—µÁ¯È÷ïßµ={vÙöí[mãÆõ6şB8 Ñ:–Xjr¾¥$å[—Î•Ö»wë×¿‡\r\\m£ÆÔÚÄÉCmÊ´n9tx?«ÔÍú¨¶Aƒ{ZÃĞ\ZÒĞ×jû×Xee¹uíÚÉjúö°9ó¦ØÅËÇìöİ³võÆQ;yf—í?¸İæÍŸcC‡Yï^µÖ¿v°=Î–.]hç.²;÷OÚÕ›íüÅ½vüÔÛ¾c³-˜¿È¦N™m“\'Í´ÚÖm›íÂ¥\n{Ú®İ:f—¯·‹—NÚ‰GmëÖí¶zÕ&[¾l£íÜ~ĞÎœ8bW/³wÏÛı;§íúÕ#våâa»tîˆ?¼ÏölÛi›7í¶í»NÚÎ=§lëc¶CË=ûÏÙşCìÀá‹vàÈ%;|ô²8uÕÎœ¾l.^±[·oØ½7ìî½Kv÷îEgwn]°»7.Ùõ+ìüÙvéâ-»yó‰=|øÒ<znO>°Ç÷nØã‡WíÁƒ«vÿŞM»}ó®İ»ıØn^{è–O7ÙógOìùÓ»öìñM{üàš=ºİ=¸¥ğ·ìiÓ#{ûö}ñÅöáÃ{÷ö•½yùÔŞ¼xb/›îÚË§w¬éÑm]ó¶İpÛî=º¯ç¯¸ï?±;÷kı‘İÕú½MJ{°}çŞ»}ï¡İyxÏî=~`·hùäİòĞèz,o‰İ}ô@KíòXa—¶ï?~dŸ=µGÏš´®ıozìÎ}ĞôĞ>{lwß·J?ñ>~Şd_4ÙÃ§íÙÛçöòËWöüıK{ûá½}©{úêËoì«÷ßØ÷¿üM„Úà×ä›7¯Û¶m[Ä+V¬°	ã\'XuUOËLogñ±–—iU•=mÚ´©6mÆ›>s¸Í]8Ş,b³çŒ·1ãêmôØA6vü`>²ÎAŒ\rŞßFŒb½ût³ü‚,Y†Õî%àØ³—7ìòµ¶÷ÀZ[²l– hÅÅ],99ÕRS3,;\'Çúõëi§Îî·§//ÛÅ«{íğ±¶yÛr›6}‚ÕÔô±ÜÜv–••cùù¹Ö«wµíÚ»Ş5]°sşÌ¹}¶ÿÀV[¹z‰M˜0ŞJŠË¬° ³U”w³!õılËÆ%öàŞ»yı˜\0Ûc\'o³[WÚ‚9Ó¬Mo«¬èaİz°Ş}¬O¿«0Â\rkC†·ú†qÎ7³¡#&¨ĞM°IS&Ùâ¥óm×MvõÚI=SÔk\'ìÂùÃ*8ûlû–µ¶xÑB›;w¡-_±ÎvíÚo\'Oœ´[×/©0	ô«\'íÊÂŸ²cGÙ¾İmË¦¶kû^¥ïŒ]¿vÁŞ»¬°çdçø»zõŒ?ÒNŸ9fgÏÒ5oX“`ijz`Ïô·­éá5{x÷’İºq^áÏÙùgìÔ¹Ó²‹vşÒM»på–¿|ÓÎiıÌ…kzÎ·íòõ»Áş+×íò­[²›vşšİ`û†]¹}ËÙ…ë¬ß¶kwîÈîÚU-/ßÔ±[·íúİ{vóş»õà‘;vEñîêÛîÜkwVûÎ]½ââ¿õàİ|pß®ß¿c^<µ¦w¯ì¥ ~ÿİ×öå7ßØ‡¯¾µ¯¾øÖ~ııo#Ô¿ _¾|ÑÖ®]m‹-°3¦YCcƒw-±ä”t‹J²Ø˜ëVİC^s–-Z2Ã–¯šaë7-°[–ØŠU³mæì16cÖh›=wœÍˆ¬³oöÜ	\n?Ó¦N#OİÃúô-·‘£ûÛ‘ã[UZ/ÙñÓmÍt›<^\'p{8Ï]Ô¥“••wµşuİå7Øûz7öÚö=‹má’I*8\r6pP?kß¾ÀÚ	b\nIYyGA¾Ì¾ıå»u÷˜í9°FÏ¶I“GXã°A–×.ÇÒÓ3,3#Ã:uÌ²Y3GØ7_?²GÏÚáCëlÛÖE6kÆ(=r€uÈµ´4¨ÌlKËÊ³´LmgåZFN;Y~°/#ÇíËÔ¾¬œ\\ËËÏ¶òÊÎ6~bƒİº£ró”8¹ÓØdëWÏµSGZ¯å–“—m:vPzKmÂ¤1‚ô°İ¾qÊNŸÚil´M›–Û¼¹3­qğ+/­°êÊJ«Tk3gN°Ë—È#:g·=½Ûöíßhë×/Ñ=VÍ×Ç©·	ÇÚÊUóíÆõªqÎÙõËGUÓ°c‡·«ğl´ÅËØ˜‰ãlôÄ©6aú›<k±Mš¹ÈÙäÙ‹mú‚6{ñj›µp¥Í\\´Òæ¯\\˜\nß‚UëmÑê¶hÍF[²n³[.]¿Å–mÜb+6mµ5ªÉÖíØcëwî¬ï¶ÍûÚ†İûÜş»Ø¦=móŞC¶eÿa·½zëN…İ¥sö»ó6ìŞkÛµƒgÏÙÅ{wífÓ»ÿü¹½ıâ+Õ8_Û_ÿÕ÷jƒ_Ï=­êy3Ê\Z\Z[ÿşı¬¨¨“%&&YTT¬EGÇY—.]lÜø‘6Ñ[±zº­İ0ÏV¯›k«ÖÎÑöL[²|ªlšÔT[¶rº`Ÿ©å:Ï–¯œcóN²ù\'êø$[·i@[i¶Ì±å«\'»}sçO°é3Æ*SFÙÔéãÜ:cã–ùvòì&;xl•mÜ:Ë–®œbM¶Ys&\nš6fìP=FRdÜ ¥g–ªÍ’mëÎ….Ş™³GÛ,¨ûè¾°Ş6XÒgîÜQöèÑy{úô¢íÛ»Ry–Í˜>Ì¦M&pzZ^åVİ³RVeU=*­²{¹•U—:+©,¶b´âÊR-K­´¼ØÊ«:Ës—Kj5Ú³Wíq“¤Ç‘M¶QÏié¢q6gÖëÛ¯ÌòÓ­P©°C–ÒÔİnİ<iïßİ¶£G7Ø†MsUğ§Ø”É#­F5Lnv†åd§Z»¼T¥»J²dŸ½zqÎ£à-°ÕkäXO¶:øÌ¬d®dËUØºvîìkz|ÖÎœÜfö­¶ë¨¶ç\nuNa¥æµ·´‚ËèPféíK-İ-eZfv,·¬N–]Te¹]»[^qOË/ímùå}¬ ¬µ+é¥eå—õ¶ÂòŞÖ¡º·u”uêVc{ö³®’‡{öµ.Z–õ«—\r²’>ƒ¬¼o£UÖ³ÊşÃ¬Û€‘V]7Bû\Z¬¤÷+í£‚Ûwˆ•ÕÊú7X÷ÆQ6pÒT6c–Í^¹ÊÎ_¿nï¾üÒ~õë_G¨\r~-@>~üˆMQÕX£*µGnª¦{8o/£œQ}\ZÓ(Xg:XWê!®\\3ÛÖ¬Ÿç`^¹fÖç»åŠÕÁ± LpŒõUkgj9]ÀÍ”M·Uë¦Úš\r3´œåÎYª¸—­Ğy«ç+“Ø:Å·fÃL<Û¶ì˜#ğgÊæÚ–mKmıÆÅ¶qórÛ(¶fıB[·q<òÛ±w‘íŞ¿Ô¼aó\\™âÙ¨ê\\…iùÊ¹ªA”^¥eİ†Ù’+ìø‰Í¶gï\nÅ¹Ğ6oQ-³i¾ ­ôÌ±%J¶xù,[°dš³EK¥É—L—¬b{¦Í^0Óæ.˜nóOµEz.ÇÙ»ìÆ­#òÈ[ÕöXaÛ·Î“NŸ§g7ÑfÍcSõŒ9£T»L°3g¶Iãµ³ç¶Ù¶‹t_óäeÚœ9H–z6¬¿\Z5ÀfÌi§No±×¯ÎÚ•«ÛmçÎùºÿ9¶^eúÌÑ6`PoÕR}]-6~R­]¼¸Mìš9µÙvèŞÖ¯SX=³‘£-=\'Ãâ²,6·‹ÅÉbs:[l^W‹ÉÑz^`¬ÇätµèÜ‹É-Ö¾R‹‘Å¶+Ó¶_êX^‰%´/±¸…o§xò»X¼Öã‹e]İv\\AW‹Ë/Õş\n-Ë\\\\,ÙN(¬tæÖİv¹%t¬°äâ–RÚÍ2Êª¬¬n <ø~{ùî­ıúoÚĞÈì·¡C¬\\Ş¥¢¼Ìª»UX;UÅ±±1Í gf¥©ñVgsçM´9ó\'Ê+N‘÷ cå…#Æöü…“mŞ‚ ^vş¢‰ÎÊÓ æ/\Z¯°“léŠ)òØ²USåe§i}–´²\0Q¼Å²•À4KM²•k§É¦:ï½jÍ[«Â³V™½aÓ¹Hd+Pë6Îw^~ãÖ¹’>sœ‡^/07l ›ûeèF`™o›äé7É«mŞÀ‹l³¤ÅÖí‹ĞÛw.±»–Ûöİ«e«Tˆ–Û¶İ+mçŞ5¶{ßZÛ{p½\nË:m¯“ÜÙ`»ömR\r³ÁöZk‡¯·#\'6ØIÉ¦S§·©!(;µQÒa“\Z¶[œœ:t|£LaÎn•¾İ¬0›ô&57Ùñ“›e[ìè±­väÈ5(·i}›”ô8~»¼ò&»|e‹;§øNo–m·£Ç·ÛCÛìÂ:²MÒm­]R˜;wöÚ•Ë;¤»·KŠl·C‡·JË¶ÌvY“U`QYËèdQÙ]\"Ù—Y¤%Ûe--·ÜY4Ë¬TëÅÚ×µÙ¢±¼bgÍûot^…Ö±HÚÉ«T¨´èvU[Piq‚:¶S7‹ïÚÓŠ{Yj¹äfÿ¶qŸj£÷ù·¿ŠPüZ€¼{÷N0 ¿ôigëÜ¹“\Z]-OZ...¶ä¤äD×h›¨ªúLiáYªşgu¿©ÓGËFIó\r³q\ZUå•±lˆ,õ\0‡ÛÄ)Ú?iˆ[N>Â¦ÎaÓäiğ(3gçXñÍR#rÆ¬1Š¤ÖÑÛc$dsÆ©°Ğ°’w_­j{ùl?ÍÙ¢¥’7+&»‚±xÙdyÍ	**(Ëg¸·p‰/›æ4şŠÕ*<+¦»í%:†,ZÊ¹+&ê¸\nÌÚéª\r¨q¨Mfj\ZaAÄª°,²ª6m_i›¶É£ïXf;÷ÿ\"g»÷.Scsµ:¸ÎIF<¸Â^eû¬¶=‡VÚ^ÙÃ«íÈÑ5ªúvÿ2¼ÑNÙ*07Ùé³;övyõí‚}·]¼t@\ZyÀçÏo–Çİ®Fó.»¢óÕëGµ<&;n×n·ë7Ø­ÛûíîıvÿŞ!{üğ¤=kºhwï³­;ÖX…´z\\n{på}›×Ø¬}µ…e·6Á*ïı‰qØäÅ£r)!ËĞŞsŒ<rŒ<rL§j‹È1’0‰å½¬¨Ÿ@–G~ıÅ;ûõoş:BmğkòÎÛ­¶¶¯tqGyâ<g99€×rBb¬\0/²ûYıàş®\ZTß×Ö×6¨FÕZ/5:z~bìw\ZUË¾ıº[MßîÖ¯¶‡õ­ínµu=Ü1âªØà!µjpÖÙà†ş®6|\r1È†l#G\r‘Vn“§Œ±)SÇº%ÉSÇÈF« \r—N¥õ‘®ğP0(lS¦Ô>\nÎ(Iñ®PLSãc ÙsÇ«+Óñ…#lŞ¢1ª=¨QÆ+ü8Š‰‚}Š\nˆj¢¥“];`…$Õ\ZU×ë7ËäÕ7Q…o-ï?ËéİM’5[TlŞ8Û6nœ©ı3m­lõFÎ¥­1Ù6lœ%=ËÖ¬™ªÚ`íÜ½DµÃ|-—¹\Zbëö%j¤	üıkÕp\\c÷¯ôËí€–«8ºŞÛ±ÍÎŸ·V¡8}z£“Ç¿|q§]»²Ï.]>dg/¶ó¦XN1Pò $ƒ–±ùxY Şˆ±-OÚÂ>Já?ZÉçMR¢…}r^™EëšQ’Ş8¶½\n˜ôy\\—n+ˆcÊzYBEo+ªl;³÷_}ñã \r¼–e™–‘%?jä„„8ëÔ©ƒõêÕCÖİª«Õê†)·nİ+­{*ë¦õêê2«¨,q½Xe•äŠ¬ªªÜ**Ê¬¤D\r¥â.V,ïßEV\\ÒÅJËŠe]$mŠ]øJO•:§ººÒzöì¡¸»;ıŞ§Oo:\nM_«Xÿº`›eİ€\ZWĞê×Éj­qè\0W† «“Fäº\nGŒªs=%#FÖ«±ØhcÇS[4Ø¸‰mœ4æøÉƒTs46Û¤©ªATHÔ œ<m˜MŸ5JĞO°…Ë¤ï×H{KW/[9U SLP-0É–I3¯X:ÃÖ\0½jˆ%Ë$±–·KU0d—Œ³Õ«¦ÙzyüUZ®V-°NĞ¯—¡á×oT- i´I…a“\nËÙö-K¤¹ÛíKm×îåÒùËmg+Û­Æ+\rX ?rHµ5ƒìø‰mvûŞyÛ¼s­\Zc5–Ø±Ú:TZRÇ*K–Œ“7Œ-\0êÀb´Sˆ—üh±íUı+¼·Øöìû)¦¸[í‹Óµ½Å+-‰E•–R\\a)’	U5WÙ×’d¥ƒ†ÛşSçì«_Ùßşº^‹;w8i€œéúq“S-:ú£´ˆä‚©‡uïŞ]`ª%_YîH«ª*¢\0”%%jÑĞb-ËÊJ¬´T­ı²2\\j]ºKÂKÂtU|‚¹K×Èv‘Ö;G@ïêâ(++·®]J­D7‡—[i	¢R€W«É´¬ªªrV]]¥ôUöÖ·ooyÿ>ôƒjU“Ô8Ï_?¤Ÿ<}\r\Z¬Z\"Ò@\Z<DPèúÀ‡¬±¡#zhÙGÛµ-lÄè®\0Œ]\'ğëmÂä¡6MŞ|Ö<yxyó™sGğ¡’JòôÃlÚôá6]µÀŒ©’R’T“§±IÓÛ¤ƒmúì¡ª	†Ùlˆù’Nsç©&Pm°`ÑX[´X¶d¼³%òşKU,FÉV.“G_5ËÖÒĞ^+O®v€ƒ^m‚u›BlÏs5Ám~ëBÛ½s±<ø*;#¹òèéUÛy`³uíÓO «¡Õ¡Â’:	æ\"Ù^\0cò XL¬°¥9¯Ùá£±İ:L.WÈÂçÅé¼x5êš­“ÒÑ¹ÜRK+,µ²‡%v«±xÁœXÙÇ*FÙ¡3çíı»÷ö7ßÿˆG4°ÎŠäq³³2,-5Í-&:Ú¢# £—;vhoÕ¦²¢BÂ\nA\\!ØHYz·\\Fö•——Gr‰3h×œ.h@¦{¯¸˜ó#|ee•ßµ«®QZ)/ÄQZÊ±J7Äİºus…¬wI–¾’3ı·V’ÔÏ‹§TßOÖKr¨§Õ\rì¡eoÒØOy ƒtØˆ~Ö8¼·Œ~-lØˆZgÌÜ@Ğ$AŠ—2-`gÈ{O“ü‘g3n€¼ı\0§åXl‚Ö\'\r°	Sé<A-°\'NlS¦4ØT3eúIŸ†F›9g˜Í˜=Lm‚’=#Õ†Í\ZasıI£…‹[¼t¢k4£éW®	tşyÿÕ«åİõªÕSm£¤Îé÷SçvØ£gWl×ÁMY \0	¬%p±hIƒh×8Ó’õÅxÀ#ÿi˜æp­ÌyûQxs w,µDåqrywKªêã N­ìmİ†´]ÇNØã¦\'öóï¾PüZ6öví°Æ!õò~E–#œ–bI‰ñûäØ˜k_ØN WX•¼0½\Zh= %%yÀX8@cÛ{fÎ`ÆwĞEòÎ´-O.ˆš°>~¿Î±ÒRÉ\nj‚J·/ğÄÕddOŸ\ZÜ]Ä =PàÊ#Ë+2À­¼xd`nÖWpö—Çíï m&µ:<\0×/	ÀŒ`\ZƒD¨®<¬dÇÄÉ\rÒà4jià¶1ãòxàä€7±^û›0™oCd)O=M}¦\nƒ\nÁÄ)ƒmâÔÁÚÔ‚Y Ï˜¶æ\n\n†íÙòà³çv\rZz€V¬¦Ë`•\Z³Ë\'«!<URE\rİãmÕºÉ¶KÉÓvÚÃ§—lëµÖ¥WorL{Á(‹ÒzT¡L€9=«ÆX´\ZhæšúGÌ‚6ÎEºÄâ9OŞ©ÌK»[Š@NÄé•=­zÈ0Û¸wŸİ¼wÇ¾ıö›µÁ¯È{÷ì¶áÃ\ZUmwuÙƒ#¯Üd ®Haoëacİ{Hà6ï)Ùxaø8N<œë=±/ìóñsáıiƒomm­ÕÔÔâ^Ö¯_\Z—4*i|Ö:È\rƒœ2ËÆa\'Céò²#ÑĞuÚÄ@hgö\r×±áÎSc46©±ÉP|ƒ=X fĞ+3nBĞCÃ’æŸĞØd.\nû\'N”³hXÒğÑÜ<\Z¡ôäL˜LØFÉ“Q®s®Ì-¥ÇgÍ‘Œ™;Öm3(´p1] SmÙ\núß€BjÌ“ìĞrmĞW¿bõ$[³aªí?¼ÊÎ_Ùo÷Ÿ\\Èk¬¸·4¨à.PÃL\0E©zwKyÎ(AçzrXÒãğÑ>hkk}NØ|sØb\nt¼C©%w³´ê\ZK©èii€Ü0Üv>bO=³ïÕ†´Ø³{—\rÚà@Æ#g¤§ZrR‚%ÄÇ:¯Ìq±1Ö¡}AÄ#K*È3zpYbB`ëÙ³§3€f T¼.çÆÃ„å8š}\\ÌI†Ş½#°ö“lè/ùĞ×A<tèPgƒÕÛ!ƒÕ bÃ†Ñr°\Zzõn}ô˜áÎFŒl´Q£‡Ùø	£lÂÄ‘nTpÌØa:6TPFÈ¸	‚OF˜	“F	¬Ñ6iò˜È9Ã$fü×[2uÚX9Æ-§NzQèA™>s‚äÀ$›=gŠôï4Éƒ)¶|åyÊEnâÔ´éã~\\`ÓÆi›®L™–3g¡g¨Á8GÚx–4ò[¾\"èj\\¶b‚^½f¡­ŠØÊÕÜ`aV1˜´jK/K?¯Y?İ6m›gÇNo²‹×Øƒ¦‹¶uïÚÈåÈxd@Æ+·òÈ?¢·ÖÇÌüyaïì-:_ÇÛ[¢@NïÖW ÷²\\3f¼»qË>|û­ıæ·mŒìíÜ±Í†äzrs²Z€ŒWæDz-:¶·nÕ’\n=@h,ñƒ\rrp\r6Lp\rqÛõõõVWWç\00@U¾öfÄˆÒãlÒ¤InßÀjt\rx£G»ó±±cÇÚøñãM›6Íá§L™bsæÌ±¹sçÚìÙ³Í;ÛæÏŸÓlÌª[´h¾-\\8ÏÈj}ÉÒE¶lÙb5ÚR­³d[¾|I`+–ØŠ•KmÕªå‚c¹­Y³ÒV®\\Ö|îòKËrÙ2gk×­t¶~Ã*Û°qmŞ¼Ş¶lİ±õ¶yËzÛ³w‡íÛ¿Ó¶nÛèŒ}›6¯sËÍ[Öjß:vËÖu¶{ÏVÛ»o»íÜµYËvğĞ;pp·[>²ÏŞ«õİnß®İ[uîzÛ¸y<±Ò#ĞW­-“W^;Ã¶í\\dGOn²“ÒÈxämû$-zF¤^ØK‹Ï€†ösö9XÛ2Ş‚\\XlI%İ-«G­ÓÇieİ­qÚ,»÷ì¥ıü¿´ßü¦\r·nÙì\Z{hä¼Üìf×{e¶;u´îİhìÉKô¼€6}út²ĞÖ­[gÛ·o·}ûô rvàÀÛ»wo‹uüèÑ£vêÔ);}ú´?ŞN<iÇ³ãÇ»ıGqvâÄ	·%á°³gÏºå…œ]ºtÉ._¾¬å7	êÚµ+vıúU»zõr³±å¥KíÊöæš,?µ7®ËnØ­[7Ü’f·nİ’İÔúÍÈñëvûöm»sç;¬4¶ïİ»k<ha÷ïßkaİ·»÷nÙÍ[×Ü”ĞÛwn:{ğğ55=²\'Míñ“‡ÖôTëL§|p×…»pá¬Ïì¸:¸Ïvêµkå©WÍ¶«f¸¡û½VÙ£ìŞ£ó¶M¹s÷d\ZYÑ\"õŸ²ƒOËÏûC>7l^ZÄ–XJiOËîVki¹´Ú&-ZnMoŞÙW_°_ıªî·\rë×Ù€ºZ+)îÒÜØk\rrJr¢½gnÎ+P§jsíŞ½ÛAuíÚ5—‘êA759{üøñÚ“\'O\\–ØÓ§Oí™4K¿ÿŞ½{v÷®2Kp\0‘Ÿó	Cø–öTç7µ°&µt[×hmŸÆõy{şüy+{!{Ù¦½xñÊ^¾|­¥·W­Œ0ÄóÜ=zäîö mÏİqgºŞ«WÁ9#Ï\'pîÜy»­vıêE;rx·mÚ´L²#¦ß¹w¥=µÍ=»*¼Î:÷èé±ˆ@ìÍ,ËkdŸ°”Ÿÿc ÇV¸‚¯ô¤—õ¶Ìª~–ZŞÓÚuïkË·í¶7_k_}õµıº-W­\\a}kz;PÃÒ\"rZj²äD±õîÕÃ\Z»s\0˜	X­¡`	láıŞ|¦a>,ë~?ûˆ3ñõë×Ø„ıa¨‚sÃ¾®·Öa~È~,n\0û!pÌ\0»¥qîs÷<ñôØıû÷]æZ<Â°|ıúµƒ™ğ<cÓ¹sç\\mÔO=´ûwoÚÑ#»mã¦¥¶aÓ\"7„~âÌN{öê–<òz+ê.C ã›{27‡âÇ=òçìsaÃö¹p±å– t$*=9K §•÷²5mûñ3öşÛŸ	ä¯ì×İÈK—,²İ«ö ±×Ç4ö<ÈƒëÚŠåKU5_rPxXyØáuÌƒÓÚÂÇ8cŸ‡…ıŞ#Õ7UºªXer8ÜçÌy­ö_k?û?ôÕ«7-ìSh?æ…K?˜ûâ‚Úk±øÍ›7ÎXg?çñ¼®^½ê$Ö½Ûw¬éñC~ÕNŸ9h»ö¬•N^aÇOï²\'/®Û–İŒìI#\Z\'-:\näåŸ€•ÛÀ²0Äm™÷à¾»­uñº~SHËûXNu­€îi]ú\r¶ƒ®Ù»on_2ó¯ÿ*BmğkòÂó\\·ZaA»È€Hr³\'‰r}É©)IÒÅ%6sÆ4;yâ˜ªøûÍ˜Í’mhk Š‡‡ÅƒLf0^™ÌõŞ)|é¬tŞ6¼h8o/^pıöüù§™}/^„Í_ >Ú«W\06ö}´ \\ìÀ»?Òçãs|ìö9öêÕËf{ı\Z }|Á½>Õs$øİdOŸ<–y\"‰rÙÚbÛwIZœÜáFö6î\\å\Z{‰‘QµØN‚™^‹È‚*ğÆŸÊo!”®e\0¤•ùÑÁÖ²ß)Á¾0È	ª!’”lryo<Ä¿j_|÷û iñ›¶¤Å¼¹sœ·Ío—ë¼qJR¢ÅÇÆXŒ\0b,E wïVíôôÛ7›!~*]úİ‚y¦‡ï\0‰ÀĞ¼1¿O„ g1U\'×àöLËçÀUë\\q8ÎëÏ¹\n›ŒuèKâ4¯‡–ÍæîAaÂûdf_^8ÓuiŸ`àl‚î¥–sà9ø‚óÂF|OŸÒf \rÀı¿~ÄEÚ°\0d™@fûÍÛ`ùRûˆãùS\n½âºÿ†›Ş¹eû2¼İ<»n›¶­v9©¨Â»TZ|Q¥Åj>\\78’/MZÆÉK~Îb8.ÍÛ9ÇÅŸXœ{‹U<ÈÒÀ…@ŒŒP!bDÏƒÎ1];Q9»×YzEuè=È¶=cï¾ù™óÈ¿ù¾\rÌëMôHxS“’,!:Öb‰Šv\")ÉÉjÖ¹¯İêA‡­‰KÁùu†ŸDù}ÏbxŸ·Ê$ì®Zò7oß²Ò|á0ş8K¿ıÜet 3=Ğ¾ZöÛŞ|xŒë±$>ÒÅ:Ç}â÷éõÛa{	¤2âñæ·}ü~ğ¯ŞÈCGŒpşZ.‘ÂæÍHïÉß¼}c¯eşšá¸||²—¯(¸ØçÕÏ;b;÷¬´§w(\r·mó¶\rÖµW_K-®²äÎ«C‰%ttíeAg\\$‹,:¿³Å29>d„c\"}ûb­XíK((¶DÛÂ{Ø\r4æ$a0j–,Ø/Øeihänu–ZÖ×r«ëlÍ£jìI#øÊ~óë6D¦Nìôq^^ef¤Yj äô´4×ß{áâE2™Â²\\=Ôğ1KÂ°ßÁ>¿Ä8F?jÇ~Ÿù>^ö§3íTïáñrÜÎÛ+^YøšÛ-â”ùıa }xæ!óûü¹,=|oŞ½uĞùs¼y¯ì›‡ØïG£‹ı5ˆçíûwÍ7®¸^áµ%W^<$ËÕ«gmßÁõvöÂ^¥å®mÙ¶Éê\ZÇX{y¼¤Ü®“ŞŞYtZ¡E…Œí˜YlfgqY-!»È-ã²Øniñ9›-Îo£tµ8I,^^:¾dInğ6\nÛ	òÈñªÒÊúX¦\0N)íkYılÉÖ}öê«ïìKüë_ı2Bmğkò¤I¬}a¾ëCƒŒGö ggf¹ÁúD¬A6°–d^@ö?R•	À>œ‡‘õ0\\~?æ÷N\\l³d›sˆÏ­ëIøhj¿dŸO?ß/ƒ8[zd¿ô÷Ñ2ìÇ4ùõğ6`ù}œƒ±Ï{O–ìãøëHãÍ§p=¼ìgÉ†–u_0°’¯$7œ÷ò…éÜû®»~Ï]Ü§û¸mÛ¶o±Æá¬¨¸%¦\nĞ„<‹Ilg1ñZzKĞ¶öÇj=lÑ±9²l‹‰Ëµ8–E%fj)9-k§õ‹JU!Ñ5£Ò:XtFG‹Jïà¶ã²ŠäÙ·\Zé’xä¤Ò\ZK/«±Y«6Ûó÷_ÛW_eßÿ‹µÁ¯%ÈÇ»†=™™Ÿ¹ ]¾ûT€Ó«È\nÁDæ†\rÀîÜ»k×n\\·ë7o8Yàá½÷à¾İøÀ„—½}÷Nó>Îã|±İìÑµõ·nÚ•kWİ’m2ßgİƒıDR‚†á•+Wì¢j\ZŠ.­‚8\Z®!¥s1Î!>Ì§ô\"iHaØÏ57ÜFÚ9LÄKâğû871Ç¸?ËÕë×Ü’x8†nö‚´Ò_îö¹‰Â¹×æ<¶}ZÜhgg‚ûå;{­ø4İ±ã§vØés»u¯7mı†µV]ÕÏÒ3$bml®Å\'ä[\\|;‹‹ËS#?°ØÁÚÚ6.:Gëy–×Nçç\næl‹¼a‹IÊiaQI\0Ÿ¯¥`–E\'Ëã\'h¶Uˆâ3Š,¹@2D\rÏ,¥-»û@K.éã@¸pµ5½ùÂ>|ııêWmhä‰B Ë#§%&Yb³F\Z{];w±­[·º.0àx¬\'c0™¿}ç›6cº³¹óçÙşƒ\\†íŞ»GÃ”£ÇÙ];íØ‰ãnàç/^pÛ@ãA8uæ´Í™7×Æg³Õ(=qê¤ïÂ¥‹ì04ç.œ·yóæ¹!í‘#GÚ¢E‹\\—”ïŞîİ{vÛå«W\\z)tûìÄ©Bpç¶mÚ²Ù¥{Ñ’Åjíté¥àmŞºÅ¦NŸf“§N±ÅK—ØÉÓ§šáæ¾Š{ nÒv‰‘CÁJÚ<tÜß’eKmüÄ	6r4óç¹0Î£\n¸7¯ïKw##¤ô\r³\rÄŒb2rºqó&w\r\nÈ™sgmÕšÕ¶V\rp®\0.o,zO$=tşã\'wìØÉmvæü¥ñ–^/ \ZOî O,¨d– õø|y\\<o`1Û‹X,Kö»cí,:F \näàıì¨D@VüIX#ˆce¬G©%ªP¥¶/—f¯²ìêZËé1ÈRJúZFy_3g©=zùÖ>|ûıæ7môZŒ7¶YZde¦[FrŠ%ÇÅ[¼¼2kåeå¶{×n7òÀLÆa@D†‘)ÓgÎ°ú!Ìc\rCmÊ´©”e+–»ŒÌ‹º=xøƒ‚f`$ß¸¢­Û·YßÚ~Ö¯­ÕÖõ·…‹§®€œÇu	K:¶ïØá&1©ˆy“\'Ov\0x}¼gÏ=f´+\\„?{şœM˜4ÑV¯]ã Ş%È‡\rµ!\r6¸aˆSç\Z\0&\rƒ×;›¿p+8¤ˆ\0‹8ŸB»gß^WPI›™{é? Îzôêiİ{öp0·“òºxOÒIƒšy(6lpµ	Ï|ÕªUÁ¼]{åêUÎ9ğ,xÖ¤™{ ¿”ƒN–ÈxæÀ#«`HZ<yÏV¬ZfíŠ*¤u‹,&³SPÕ\'Sík™\"°\0lãA1ç=e‹xÔ&É é2\'%œ›Â¹ğÄÄ“\"½¢kê\Z	òÈ)t¿u©²Ìª¾ädiäôò\Z={‰=Ö½|ıÍ×öÛ¶A–ğÈíÔØËÎÌ°Ì”TÉ‹DKŒ,>Áª+«Ü<	0 c!É°‹—/;0ÉH a‰g½û÷Ù(A4F…fÄ¨‘îÏ‡—9}öŒË<2q\' oÛ±İybÂ?€€âøÉ-Ânİ¶ÕyáƒÚáÃ‡¦a\n¾mÛ¶¹t+V­t…eçî]Ö»¦»îÅË—lÖœÙ.~ÒÀ1@ÆÛáaIçÅOm²aÓFçU©}H;÷ê=2\0³#ÒÈ¤“4S˜yb\n8ØÁiĞ‘Îµk×º,p‰´lÙ2Û´i“­Y·ÖÅAÜ,¹>ûpÔ(h|/-\0ù‹3ç/íW:ïÚòUË­ ¼§ùW¢Ê,:¿ÔYğÎ]±¹Fy‰4«³Eç¨AÈğ²–­-F\r>×øY¬\Z…Ñ4[˜4qz§FAÂ¢¥—W²<2]‚ôZdD\Z{i¥½òRü^ÒâGz->2ò\"I^Ù™ î^İÍöïÛï´³Àa*ŒÌÁË‘éxYªÃIS&[Q—Îf4/Ÿ·`¾ƒ‹B@Uí½,°á¥\rĞ×oÜà@cÀ!2 á¹¦eHDZÑšÀ;wºÙzå…ñhTËå•Î»P‰´…‡ëp<`EJpŸœw¤–!?2÷ƒQ ñœÄt\\ÃëÜ×yÁÀÏ’%KÜì?fóq/L†Ú²e‹İÕ1ô9ÏŠxXú6	Û8úÃéµøäíù€ÒyÇ–JZäWõr/yb1«-º¨Ê¢;UÓ91Fúõ“—äí‘UX®m&À4×?,øã[X±\Zn¥-^‰.Váü÷4â†Q½„N’%=,½ªÖRÊúZjI¯féµø³@Îp9²<rUİ9‹\0ì\r8É`)ÚïƒW#88K—/s(“êhÙïããøº\rë­O_^;\Zæ$ü9mğàÁ6kÖ,›?¾›eGãÈÔ(Ÿ8i’+t@ŠGd4;Pú†qr$@’6\nû9¤ àá©}:HïŒô }H\n4Ş”ZÆÃ ¼tĞú™„ô1‚9-Ô&H\néäº,y^qS3¼}÷FävñÊA5ÒoÛ’KÈ\0Ü±,ÊƒÄdÁÚA^»c¥[F3ù3ä-}­­ô‹.”÷/Œ9	9^Æì7<2ıÈ)Å=mÌÜeöäõ?ò¸±£]c¯…F¼	ÒÆX|\\œUUV6Kt½>S12­ˆ×DÃúŒ%³ğ\\À\rĞhÃå+W8È9î3†ÆzÔƒéãäêî|ı¨—+È\0ÃË?y²ÙÛ–Ì^y\n&à/]ºÔy8/-˜6ºPÒ\0Oö%}€GÚ©ê‹´Q‹\02ºïÌ=p-F1–@mÈ¤—ÂDÁİ¡¸&Gq÷ãÎÑ’‚Œ>æ~Xz9pC„F)5úxÌ˜1Î+\Z5ÊÖ¯_ï¦¯nŞ¼Ù={z=x&œËscI ¿ÈÁèŸ\Z{j ¡»›Şµ§wÙ¥«¬[¶dùk_ÕÇâ‹º[B—ß¹»³¸¢n[Tm±|W¢S•àª´ÄU–$KlÏ*ÜğrØ˜ìƒ§ş¬	àÀäÙ;^Áú)È’0Z2•4Va%-2¤‹ÑÈéòÊÅ½lÜ¼åöôÍ—Èm}À{äæ^‹ääfièÅK\'óÜ.eÎ#ø$@Ş9\ZUµ­^£ª“XÊlô€ğÀ­Kƒ	ì«i2˜Æ×Ê•+íÖíÛæ†¬xCh“4àT5é1Y´x±«r÷+³·©UB #è?f{×®]Î³¤ĞáÉÈ|Âà™ñn€±Jé™?Íš=Ë³^ª’«V¯vi\0|&ÑP\\(X\ndz._¹â\n0CäÀJ	vDÄ5Êôl˜ÖºEŞ{/=]Ïzİ#†ô™1k¦ğh9vÔµ#fIF0“ç€üáE^\\˜9s¦íß¿ßyhâ§° ‹)„Ôl8`nù-¬eÄ#?}vÏNİ%|@ô†Î[b+z[RûjK*¬r€&óI\0Õ;ÃÄÌBKŒ)K–%IK\'0\'\"dÈˆ8>‹å­°«³ØBÉ†öÅ	P:\\œŠÛ™àÀ±í³ÂFu(è%È5–Û³>yüü•öøõ{ûâÃ—öëŸâ‘s\"¯9¥$ª¡\'IËèc¥åe®úuı¼Õ¬—edÜilÑmÄ>tê’eKœ~ÃS‘‰xã™ÈW«À|JˆÄ# ±¤ P¥®QáÀ³2Ÿ·C€Šı¡C‡š½- /:˜à{W||\0MÏFc\nPèÕ $4©Ê‰“°ÄÇu(Lîß¸q£›YF¡ />u\nÁ|LÚ·TÃrâæ<€öéCVà•¹gj÷#÷Nƒ™ÛM\ZxÛ…‹	&¸åÄ‰İ3 ±‡çFÛS³Q{\02í¼:ûKxä0ÈL.jÈ\'å‘/\\>à<òâ¥‹‚^‹z-ÔØÊTÃ+ë¨ÆW{‹É(p›Qhqj¸…†\\Øb‹ÍŒX¶öËb²;HûÊr§,.¯Èâó:[b^K’%K³#‹Êë$˜¥•yÍ© ÷µ¼ƒ-µ¼Ÿe”ÕØ¤E«]¯Åû/ßÛ÷ß·1²7N¹ ?Ïyd7©^Ş8^Ø¿A•”–ÚNì$9€ÄÀÀx AÓRåóĞiœ 3Éªe$æ”\0%, —ó²2ç‘ÚÔ©S›½¯;ÑF£˜ğºèJÎÅk{]IZ¨®‰Ãâ >`ç]B Á{S(ˆhyÛm½cÇWhOïÇH#o®\05€BF8 `ÒŠ„ñô!¹PxM\Z”xaú¡‘*ìç9\\S¡?sæŒ-V­C\\Œ òé¹àzÜ×\n9ä	ŞoÎ3ÅË/ré¦€~ËĞõ[FßÊ¿×’î·»vì$\ZùëµX¸x¾eãéK\rFÖ¢’ó-*¥Ösƒî3×…FÿoV+Şa	˜Â&bœ›§x0Å•ÖÎ¢Ó,*=ß¢{t£yT :XB†\0gT/-r¼]géãRKéRmYjèµëÈLå¬±)KÖ¹‘/¾’Gnk@dì˜Qdÿõç@æÅPªÓ¶@ªş>}ú¸wñx÷.-ô$ŸÄ‘‰lãğJd6âuéOõ ãå€Œ®(4/ïû\nŸ*˜¾b®@€gÄÓÒ #4šå#}Ä…‡b\0D`:\0äÚ€É|^ßBŸR­“6º¿xGw\r‰»±±ÑÍ(\"ú•sêëyùuˆëi &\"-„#R¸W¼1}áë¹¾j\r:ÜÊÉkSø(8x|4.i&mÄEM×·__\'Íxvxa$dúëq8FöŞòÅú ß±£\'¶K#TÍpGí„yÖNÕ|t#kôé\n¦DAç†‘aäè¤,‹IÊlaÑ	--Ë–)¼€ÌÑIy)®˜TA*‹JÃTpd±²ø4yn†«¹¦,&§“$G™¥ñ¾^u­åõbÉ¥5N#O]ºÎ½ûÊ>|ıÁş¦­—O™™omÌ·&Ğ»<,4rk12€ŒÀ+Ós°F’âÌÙ3®[ˆ~Sz¨biP5ˆí›ªï	À\nïEñ€ÀAœNªšG‚\0 \0ã\riÔQíŒ}\\	^§pPSxïŒÇRö!%ğêxC<=Z\Z)ã÷ãaI‰B„~Fº (\0¤…tPH¸é1]²!…×`À¦@C’¶ú™)¤‹{ ^?¢Gš¹û—.[ê</İ}8\0¤\0{YA#õÕ›—nZgd4ò™óûÜ_]<uÏìu)éa	)İœŠØÄ|‹€±XRÖ­Ë²X\Z—ØÚÒ[abãu^|›{Ë\r\n–$ˆåé£`IÁãë1²øÉ–”öî8Ş;†IHjø¥t®rCÔí2Ò‚~äË7Ø‹/¾v½ßş¶ï‘ÑÈ€œ\'}üñã,aÈäU?2˜Ä½šzÆ‹ßxc6-|ZÚs-zÂ¯‡ÙƒÂ­‡°Øôş(?§‚cTÉÀË>À`Ÿu¯›‡Úµ¥/<¬.ÇÙ¦°dì\'ù“Îğ9Ü7Æ:çp\r¶o(èZî£ß—mÌl7ò§%çatùÒÎµØ_ià¹qN\0ík\'ÏÑyuÙk\'+‚IC€L/^>”¬8l·ïÖ9ÿ2«¬VCJ\Z9QŞ8AÀÅ\'µ³yÆDAŸ”+Ë–eX|bš§¹e|bª³ØødA›bqZÆÄ§ºID±qÄn‘›HÔ\ndÅ*ˆå…ñÄq9–šÀøé\\@ÎïÚ<×Ó\"ÒbÆŠù›@Z´ÕØdßıÈôÇ©‘™¦x‘<<ğ™Œ·áÁ;`CëasŞG¦ùŒ?ş¹m2>¼í×[ŸóCF¸ÖæÁ\n×ùÜş6…t€‡ÑğÃ€Î/±WÎõıFÌuŸ}Î8ieÌ†ûhxã ¿Õòù‹ûvúÜÕ€G”o7mÙò%Ö½×\0KÏì,xó*ğæ}9Y \' qbrº[Æ%¦8˜câ’´Ô~ÅŸ\"İ›.İ›¦47ú7F:ØÃà™:–Sä¦~&Ëâ™ı&Ğƒ9¹§Æfba‰%dæZä÷i°´ŠZK/ícÓGşFùË¶û‘[ƒôZÄ	æXyæX×sÑ\Zd7«:20\0/˜LôàúL\r Vx™Î¹\0ÎeÛ/?‚ñÑ<¼¬³ôë6?Ö–îÇŒxÿU¶\\è×\Z|CİÂZ@û9ûägÏïÛñS;%?:W¯Yiıê\Z,#G\r,Á› \r¯FZ‚ NLÍÓz,K€Ê#\'	âÈ2N^‹‰O±è¸d‹ŠMR˜lKÉíjÉíJ-9¯Ôr‹-^–Wbñ²¸üÀb\nºZB{I‡öe–QXf‰×ÉŠÈ±Ù$-JœGÎíQg…ı†YfÕ\0ç‘§Ë#?—´&Öÿˆ´ƒÌ\"Iñ¼î$˜e±±±Ÿ€Ì_Oµ†ÁWÙ¾ê¥Ú¦UNõ×ì}#^ÙwIáÙ™·á€‡ŠmßãÀ¾ÏÂ±páaéÏõaÂ ¶eáxè¼ÏzÈŸbp[[k[C»ÙŞIû†ì§€Üôô<³Ó®ß:¦ë1¼¾Úz÷­·4@VuŸV`q©íd‚X+8crlr¦Å!/\"ËXiâY´¼p”9-Ï’°ëæu¦R‹Õ6æ=šşäKCËâå•£ÑÍ*HNZ¨±— L?r^ÏÖ¾v¸9³¼¯Í\\¹É½ÿ`˜4Ô–F3zd3È¼xšÆÈ^b²›,”@Ã/>Ş}\nkûÎíöğÉ#§‘[Kàbº³èCÛU+œ®7Zæd¼³ƒ9â‘ª`œ¿pŞ5jÂ…ˆiÅ£ƒ?°Q`è‰ğ=èeÌƒO¸pœ¤1¼îm6|¿VØ<èR¿İ–y	Ñ\Zà°}NZ„a~Íl6¶[L|~¬s^ËICÁ€Èn»qû¸ù[º|±•Tô²dªóÌö—1yÆt5ôR³d™j”Ñk! S²-F`G\'fÊ{fHËâR²¤F†\n‚©Ã½ëXnÑ²¨N¥Õ±Ä¢°ğÈ(én¹|À[…È7\0iìÅæJ¯ëü$Aßs µ—Gfd/»²Öæ¬Ùj/ò·ß}kÿîo¤×Â÷#/Ÿ\nâydieŒ/×;¼C™Æ‘“È€à—@D·}±¬Óu4¨~â\rFÄhœ&H\Z<[¶nu£gì§ÑC|\Z0€Àğ¯KûÉƒ‡Ñ¨£‡‚¼?_#Â8Ÿ°áôá¹9‡ípóáü9~¿Ï:×¢ĞRX}šØ‡q\r>¿tç:üJÏ ıJËİ{÷Õf3æŸ¹	Alc7Õ`åT3CFô\'hm\ZÎ4øš@3Àlz-^~Aï<ò[ÁûPy]»É„¨[¶xÉ|ëØµÒ’T\'1’ÖÎb°ô<Yn\02;b]q	9^c±òÊ9.C\0pïòÉ£&Éå¡yu‰÷ü¢ÛËt¬ÀÎ,ëiíªúZ¢\ZvîÕ*AL—_\\®\n•ÎOê\\i½ê­Cmäªş6wİv{ùå7öÍwßÙ¿ÿwmüÏ™î7z-¢N–´HHHp\0{ã#…€é3óÌ’mºÀè;¥ÿ˜î\"-øœŸ£Aw£kxYÀºpñ‚.0q‚ëc¥+\noO‹+ºûèø\'ó~å|†\'fô‹‚Co]gqs}®Koi£`ùÏsáéé&ó0Î£šÀ÷|pÜß•%ñ2ĞA¿.}ÜôøšBDÄÅué*<{öœÑ…»m;wîÖõÏªÖÚ£8Ã,dô‚®uÃõ	Ó¯Ì¨\'İuûìw#©l3L_íü¥®Ëc0…v\0c=ğÖ¯íİ;ú’_â/ìİÛ÷*\0ò^=ÓãªîØÊ•‹­si¥óÈ	Œä¥Xt¦<c†ôª,&UàzˆSyÃCR#‘î8Y\\†ôqz3È±xr†©nJqwëØ{ûK³´ìÎ–¢FÓ:£óTX:–ZœôofYoË¯êg‰:‡>å\0d5.s;Z²<vryäŞõÒÈCÕØëï@\'_}ù­}óí7ö¿üû¿‰Pü>™™oä¤Ï€ŒGş1ihhp“Û™ü`|Bvçî€G? ¬X¾Ü}u¾¼\"˜JÉ06ıG/}®d$Ó*™$4mæ7¸à×$NDøğ!£yH\Z8$í¾_®M!c\04ºÈèoæC‹¤—şeÒIÍÂà	×â™%ûGŸ6}Ê@KËu/\\“¾fb(Ôô©Ó\'\rÄÀ;kÖÅÏ0ô|¥{”Ò3\\é[¡°WlÃÆn¢=%ÌÊcÊ\'@ó‚CØhfüñ\"\0áx6Œ’2ºG§v{óî›ıÖ\Zä—/ŸÚ™sìÆSöêí}Œ5VVİËRè=È-ÇåtpG·r¼@krª@–¶Î“wÍ/¶ÌŠ\Z«\Z<Úòºt³¤”B…Ï•É±¨¬BylÁ.¹‘%ªj-)r´Y°§öÔ.ÕÖNÒ\"¿İoı,KÒbşúîåÓo¾ûF¹\rG\n@f@iÈèb\ZyŞĞÈ¾\n÷d`Á{ã­ğÎœÇ¨s^æ$@AK3Ÿ\0ğ{öîå˜‡FRøg¤ ³ë°>½{»ÀÁ#s=ÀN€¡ 2ÄËµY2xdŒ¼ùÏÒ2ò‡geà‚4ùo-h}}½«I€“ûõã­£`Ğ„akj	î‡¸Õ`öáıZ^µjÒ9×6nÜ¬´]´%K–éÜnpß½sß*î»wº	Ef\n/“ƒ\0˜AfÓ>zÄI-àÅƒ³Îl@ÀGª½ûâ½{;ä­¤Å\' Ÿ?(|Ê^¼¾ë¾ÜÙ½wËh×U\Z7ğÈ±Ùòÿ\Z%IÜÛĞ9Y¸sß!–Îä¢ä‹‰Í–É²(Å>\rœLOFk;•Yj×nä Y K^x¿–GnSZ\02\r=rBB¼›(Í ˆŒ~d¾kdæÌœ¼&\04p0§Ìf¾\0ŒÇÃ£áµ€¯ÈÌ/ªPF½È@<ÃÚÌfI•ËŒ0â:ß¸£ú&ÎÕ«W»‘? ¡À \rˆŸğ@KíÀ`xŒÑ8\né>Âr\rF9F<Hß+Ì¬ã‘GìCàÍ¹…Š¡m†±ñÆGG{]İ@›4iŠÒ}Mà“C†4ª&©Wšç)_Ú|ê õ“©üËÈÓNÑÆhfF÷˜z\nğÌµÀ8‡Ï ->ù•dÜ¥#vëîËyä5u–]Pj‰ÒÈÑÌuÈ,øQi÷‰´@Sà£-H‹½Xz¡@NÈqA¦×İr@NÿÔ#§HZ´ë5È\nj\Z]?rfE?I‹öúÃÏœGşwÛÈ£Fp »¹È€,oìööc cd /<CÚÀAÕÏy@Pd8ÀÍ˜1ÃUûh×µëÖº)d ã‰Ä’YsEîÿÿŠ$ 2^˜ÂÀ\\äŞ’=<uçÎX@	ìx_j¶Y2\Z°6Ÿ^ïa}ÍÃı±ô\ZùÂ}p¿hn2…‹BF\ZĞÑÔ„\'Lcã0yÿu’)OÌ\0ê>}úÊƒ÷Wí4[é½ç¦†=¼”‹wešçÀp>Ï©Á~äó™´O¯m #-\\÷[ä·ùÕ+Õ–WÛİçÈ6­²êı,C^™åæAşó<rD#ó–‡<rZiOkß£ÎRyK„aïx&ÉøsJf·9ûXauÄ#;Ux\" \'	öd\Z{}[û~Ã-£ªN·Û›o~.¿µ¿ù›6z-Fáz,\0™~ddEkÉh´-ìÁÅÂ ã‘”‰áü\'Ú €êgá‰ÙÏüÎAR\02—b›ŒCRx­ÈK–Äg§qÅõ\0š4ÑÀb^r\0°Ù¦f\0*Ş¨Æë-’pÑ{SÀGr ‰I\r6â\\`ô÷Ç:™ó)@Ê’yÈ®TBæF¼1ç\09RâÈ‘cÚ~¥í»ª-«`­UáŞ¤=Ë.]¼¢ÙK;zò˜óÂôV0™Á<dÒ‚Yt<#¦ÅÒ?O·áğâœóö½¤Å€|ñÊQ»}ï¬\Z…wlıFÜ«ŸeÓÿ«ÆX<S.¥c£2ñO\09Êt¿r¼ Æ#ó9Øö=X2bIl÷d¤E{&Ï—ª±×K½¾Í=ï‘ãr;X¢`§¹ ÷`ëP;Â2«¸ÆŞœÕ[í KZ´ùòéOÙ{dßĞ\"#Y¶öÈP\ZyÀÁD\Z`Ãû#Ğ§xk&ËÌ’ã]>´2¼Ó=ñPdäxAÂ9È áú€ ¾×Ùpx\\f¤1KÍíp	‡T\0D¼ª÷¦œ‡^F£‰ñîôªøŞ@É½#e@Ì9Ü÷Í}RëpœÚOaÀ»oİºMÛç´ıºdàF;Oœ8ÙÎœ>ç@>vò¸“	ôÒĞ+A\rÅ´O\Z{H3çƒÌ Û\rÌ3b ÊK‹pc‘€|÷®óê­[¿ÂúÖÕ[QioKå¿§³Ú[´¼ftf;g±i9+˜±ÖÒ¢%È4ö\" ·ÿäØx5ôøæ »î·rË(íeyt¿	d^J\rœ¤!½…5CÜ€HzeË¡×bív{÷í/íÛŸ}gÓÖ_ø9¼¹Ç‚‘¶@FZà™03K¶©^ÉP2HñÂx,2x\0ê\0ğ|€.å5&2×*ª*İTEt²—xœ††!NËây‘€Åõ\0	y‚W¤áa©Ú™j®M:€‹‚@ƒñœ„¥÷t¡ëÛëwÎã¾¸–×ÈÜá( \\û ^îOZ(ô¢xø÷íCR]µ7oŞ©p<p ×ÖÖ9Lcî7ú™‘Uş=?úÑ—wüh?\0,Póªow£§ñÈxi\ZÆÀt¿½¼ô#Ë3¿fö ÒâşÃ‹ÆÈŞú\r+­v`£u•VMÏïêz-b²Uıâ‘³\Zß¥ ë-Óââ3¥‘#²\"&Å™×È±…%’½¬PÒ\"™?kOT<^#«Ğk‘PTiÙ’ùÙ÷ZD19Y\'§½%JZ¤v­¶ö5\räÔ2Õ\ZyáúööÛ_8iñÛ¶@ní‘>iì¡O}¯Ebï‘Ù¦7†çó‘Œ\Z@¼ûğvxC¼Ó\"GFğ¤U&:‘Œ¢Q³yËfıµ\\H¸×ÂC“€L@çZ„Ç‹##¼§EvàÉYg?ç\'\rP`¤!‡4¢]íû­ic‰.§°àÙ¹ïM¼<ñSK&ìî]¾•×ä<2Ë\'¤·nW»\\/ddïŞÃûN3Ğşõ8øÈ±£®¿çäßDR 38\'ñ{eoßµ’¯Ÿ)ü	»ÿè‚ÂİUãqõ ¯WÜÓ’sx3¤½éÿ¯¹ƒt³dC»nı­cÏA–Ôª×ÂI4r×*ëØ·Ñ:ôá¦qÒı¶hÓ{óõÏİu›s->2]nÀìş) ³ŸA2pPØÇy€G¦{¯ÎÆ\0È¿-¸m<\rÊŸXâÀãi`Û7Ôï=5é`Û‡÷÷à%ŠOz–°€çÆÃ¯¯ì¯Kşşı>¯«Ùïë¼¢ÿÆŒ=}Ê~\ZƒôOóq–`ˆš¯!ü¨—ƒ,ı?ğrœ‘¼ğ²e¯…<s¤×âÒâr ‘ùöÛ–m¬ß€kWTåDâ³:¸î7±¼rlš‡X^c˜úÿk¦S…uè5ÈJú5ZR43 §F@Îé`	…´è¨ãëFºiœÙ‚yÑ¦İöúÃwöÕ×_·=³5ÈII‰n@‰á.5ªq@!ÓZƒŒ‘‰~›ãŞ±?|.æÃ{øXufÙ¹áíPxÎg6Œ4øøÙö×g;|^8|xa¼±ÍqŒ4yP	ëã\nïóa¼÷f=ˆ›‚\0Äáù¯,øXwğ™,@v“‡\"ÃÍ¬0ËÄ9Æ> åc…>¬‡ß¯3±¡éf_>nî~kzv[\Zyµõ¯n…Åİ-QŞ8AU\0gä\nä\\yJÁ›–)ˆ3dÁ›!±LªOÈ¾×\"°Øt›‡´PC®²ÆºÖ6Zš¼m G¤E´¼= 3º×±÷@+¯f)¥Áµ“’\'LñTƒ0¥¤›@j]Œ¶œ[Ñß–mÚko¿ù…}øîû¾­¯q²ï~äää$yåÄ £7ÑÈx\"ŸÉA&}4ö‡3šõ0ş˜Ïd–@æÏgÛŸÃ¶ã—>\\8l\0E`ì÷ióç„ÍƒéÃ:€dáxÃÛÇÇ~£‹e8.¿î\'üøğ>NìíÛ·n›	>¼k÷Úi\\ís ²±ˆñº~?a\0œ}†Ò‚xñÆÌ³ø²äKWÙƒÇ—T`J#¯³Ú!j©ñ›ÑÎs\n-A\Z9Nc1é9]\0§	d,YÀ&y3İëMQÎ3k_F¡Åd†¨³«úY© M¤ñIùÒÈòÈ€,ÙÓAÊN¥VĞ£¿u­©·dşÁ	“ãs;[<Ò¢¤Ú:É#wÈY¹\Z|K7ïuİo~ö­ıº­Ùo#Gkå‘ƒ!êÏì{-<laóû½$ƒ½X8ŒßæXxxæ!hÇ±°ù}ş¸ŸIÆ6ñsŒ}><Ççã›ãÃ…·Ãie8Ã×Æüuyf~›ôûÂKXwipWi‹@ê·Ãëá}ôÖÌaƒ^‹\'våú	{ÔtÅ¿¸gËV,³Êµ–Ù¡T\0Ë[¦pş¿d\'-~dydœ[ÕÇ:vïïºßœGÇìWYQíP<Ê²Êúä:[¶eŸ½şúgäßşm½Ã‡º^@f@Ä{ãÖs-<ÈŞëùûÑhR\Z=¾qECXWzmÊ1\Z_^ÿ’¹2M8Â c9×‡ñ`a³Í:iá<®AÍì\'Ÿ¿^8Ï™OKî†,Xô5ûH?îğ¤{Gk#ÉKZhèÒóAŸ:qp}[æ•øÉ@pĞØeˆ6ÚøâåKn@„¶š%ú°½ñm‹ùÕc»|í¸=yÆ;’÷ÈõÃÆZ~q7Käõıd–ó“@i2_¤OèXáş÷ÃƒÌëS±!cù\"¾¤En¥@îQ\'%G2xù5Ï½ô\nÈ	*XÉ’]·Îu£œ´(¨®³•Ûù[5öş¦\rùêÙkd2î‡@öp’ytaÑ­Å óüäŸqô6Ğ·K8ºã0††ÁÃµèm`ç3ÌL÷\0\0¸có€‡¸=p>Şx¦ƒ%İƒ\\×§ãÜÏ™;|\r\n2éd$Ñ¿eÍ}ólØÇü\nÂÒ0%Í£GÿàJ·…‰º!ù\Zé¡‡…Ş›ùæ»L††Z‚èj£ß˜	BtÇ1·‚n8\ZÅÌ¤‹’A“ ¡|ô»¥G~\'G>nMÏ¯;W®Zaã§Î¶¢ŠŞòÈ…ÄÎ+ÿù9^ \'ñÆG§Ê ·öÈqJ\\_r»n}­sŸAjìÉCóy\0^HM-°\\Tnéå=­ë ‘Ö¹ÿHË(«µÂnmõÎÃöşge_~ûÁ¾o«±Ù÷#‡{-Xg\"oì‘qæ°#uÕbÀC÷\Zı­tƒ‘‘„Ãs1”ÑåE¿+Nß3ı¯@Š1Áà	á\0\009£`×CFñƒœÔLT\"\r\\€¹×aĞïì½8ç{°‰ÏßÛK\n*Ï¸ˆƒBK<@Ì ÷Éµy<Â*Àã‘IiaŸÊ³`É—ğ¶€L·Ş™oX0(ä?¤È¨£øîJ>ÀÒK‹À#ÓõöQZ¼zİ¤‚pÊ¾¸áŞß[¶|©õ©â42 £ã³òeAƒ/r,>Ì\"q	é/x?Qk;³½¥t(w çvëoåƒFYzäØ¸¬ ×ÂI‹®_Tf…=ë¬ÛàÑ–\"/ŸÙ±ä$œ¤ô¤•ö°’úÑVV?Î²ÔĞ+ì6ÈÖí:êú‘ßñÎ^[ıÈ^Z¸¿&KIr8ÜÌº—xÉ0¸an¼!C¾ŞáùxÎ¥\n&ã€PÙÆs2ø€÷¦‹€´ô÷†°ôß²m2\ZŞ’	AÄÔxG\0cø˜óyAÚ€™ı¤‰Áıq EH3á9îÆ¸ % \"Hñ1`C¡%÷Í:1È	ÒÎu¸7îc„¡vqÃÜt9>yì</İ@Í§Ä€\Z¸‘L ÂS3\nÊ@03ÊzXV¼“g~÷–‹¯´ÎŒ¸&»yû´óÈ/_=t£ªWËRUD·W<b¨±›‘˜`Ô±)‚˜×ä‘é~‹xã(yg@æ];¤Eaïzë9l¢ejf¿¹^>-\'`¹s¹õ­·š“ÜG½ã³:YŒ F+3÷SËzXyÃX«\Z:ù#È»9iñö«/¤‘¡6øı GNMNt ûŒõ°´ø!ÙGß+Ş†¼+†>$Âp°À» Ğ¡[ÉT³¤`‚€—¿&ñ\0Uwk9¯\rÌ¤“ëâÑ‰—ãœ˜ÀL\ZğŒ>\r¤cxH<-£Ô\0Èu8ÆuÂá(hFF\nëë•A55NFP€ù<_ğ8ôS\0¨9¸göSøvš—¾bô1 3ÂËLãäƒàhgö3Ò‡œ`/M¸f™L/F3È_8oİ•’GäE‹\nd5öÚ—X2Ÿ³Ê”F•Gö\Z9.3;0Á\'˜\nÈñòÊyÒ¾İ\ZÆ©Ya‰É’,ô#\'ÉÃä˜jÊ#w­k´şc§[šÂrÇ2r•\nC÷áÓ,³üÏy˜ª\'¼1CÔü1$R¢5ÈˆøÆ·µyùÚx~~0y@9c‰wâ@á|âfN•ÍùÄÇ6Ç[…}d\0eŒç|ÂøëpØÑ¨T÷>®Mº\0¯\Z‘n ôçq\rÖ©-(¨\\¯\n˜xcÎáŞI;5\0RIÁuŸ\0èÜ/×CÜ–GT<°{ıKºı‹æË›€ÌÔNF>™Ö	ì4ô<ğÄhäW­<òNZÜºsÖ¿º¥‚r×–«±W[?L Øyä?ä@ZD@–1 Â	o^÷:«¬GZH3·¹C±“e‡[ÿ1Ó,ÜBZğwg%–ZÚİº˜l=GÍ°ìŠº=Èüuk1?×‚Ìöµ6 <fQ¥S…Sm’±xA2Q3¼ˆˆóˆ¨üèó3¨®Ñ–„ña¹Ì{xak¹–×â\"\0ô@r\Zx^2ñsÌ05éã|®Å~>éä96î ™•G£•™w\\0)DÄ·F†÷†¤ ¨5¸?&N!#ĞÅTû¼Ãl7†î™Â9wÁ<·ï1û¿ƒÀsÓ[á% ÓàsK¼rØ#¿mr“êŸ½¼iü‡ÈƒûlÂ´¹–šßÙu¿yã²>J‹˜ücY†GN”&“‡m×c€UKà‘[K‹˜]-AÒ¢¤n¨õ1ÑRyãšuJz-òºX|a±¥–ts ÷\Z=3òÑŸòĞ¡ƒ%+Òrª¥$\'X¼@iˆeIqğ¦€øLÿœ2\r=@\0HàÂ\0€óğLxi2Ïæá(àB G\0PpÌCˆnEcúár±™^‰°GFwSx|úˆ@I\r6`òÇHŸ·ğ}úkch}æePã\0*ïÎ}ù‚Ê>$½646)4èq\níæH4-Îgm§\nî±’RóæÏsŸ¯¥q7Y}˜\Z·+¥ùŸ8îfò$LãdXütÇ!K‚‹7ùµ F^d-ùêã’×tÎ;}æ„Í¿ÌÒÕÀŠOWC/C\r=Y‚€Æâä™c#£{èäÏ‚ÌÈ^œ	d&ñŸÖíªû[÷Ác,#ŸÆ$ƒ™^I‹ÄÎ•Öµ¶Áz\rôläh¾4$¯OZ$uğÈ•CÇY‘Ó,»²¿ë~[¿7ò—ùoÚ\0¹±±^ §Ê+§YzZ’%ÅÆßFŠvÿ|ÊçeËKƒ^\0ÁƒúLû\0mKK}€æ½ëÀMÏ³ÒX,^LErP2—.9fšáÕïEa\"~¼=/û¸°(8\0ë_ƒâ\ZxAâÁ{ò\ZúİK•0¬l{ó`ûm\núÙ€4¡@Ñ˜£°Â‰”A’`yQÏÌ~d™{£@’fÂ\"?xÔ¤ûgrû¸Éú\rëİ¼mz2èzCŠ0Éˆù(^Z8ì¦rò—nùúÍòã§—å‘oÚ–­­qøxKÏíb‰éÒ¸Ò¨‰ôf,!=ÏâÜ¤¡HÜçú‘™õ,†ŸË,yİXÍàñ–Ù®Äâøø,I\nyd÷ïªEÖµfˆõ4Ú2&1]\Z™´HZ0¨’ÀìUô²êá­Ï¸–SÕ×\nºõµûØë¯¿³w|2«­:ÄAŒ¥¥%ZJ|ğ—‰1\0-ÓúOĞŒd²ˆı><ÇY:ëu4^ïÉyş\Z€F×R„ã\0LX\0J?ñb€7Ä\0™0\n\r^€0d^X|šü=pm¤\0à\0-Ç02éâ<3ÉàkŒãÀÉï\rØ„÷µëÈöûøIÇ(ÄÅuØGÜ“óèQğ€ô3#+Â£y~ıí{éãÈïµ|õú‘]»yÜ=‘œyrÃfÏ™i%=ÈIÌ)ÙÈ		òÂ²hAÌgfc³;Xl\'iä¢J+ê1Èú5L°¬v’\r­@c\Zg\'I‹¾\rÖ§^^;%9Â ëxFeoqİ”y–[İÏ:ôì/|Ø^}øÆŞıÁ~İÖ\"añÈ©‰‚9!Ñ}•“ÿáC-?2Ûd™‡wÅËøÀ|8Âp>Çñ84šğNxXß×Ê5||ÀÂuñjxVÎ\"#^</\r-Ö…ğ@K×@Çâõ\0‰0>íœOœÔÔ\n2®G8¿‡™u/gØfé‡¨}8âõaˆß[ëó½q~ë8°ğ|\rş0‡ái?DİÚ>ç‘ùå«ÇvóÎ){ÔtÉî?¼b&µüöÅ–’ÕÉŒGNBëşÈñ?\0r w®².}†XİğÉ–Åä´9¡S©{©¢n˜ÕhYj&µòÈIòØé*`5ãgÚ i­]÷şVÔgmpù[ÌÈ^ mD#G¤Eª@NH Æ+c?dÌC\n@x*¼û|¦øLÄG\\€‡béÁ\"Ó|®ƒöä8ŞŒsãã	ñûğ>M¤Âám~ëÂÀ6µ\05£ox~¼3á‰ÛÃæÏ\'>á{Ä|z|:|x¿Ïo»ª_qz`ı5¼±0îÜÈ\\‹0¼Ş#3i£×‚¹Èdw®¤Åí{gì±@¾qëœM›>Ùª{Ô:œœ‰\'Vƒ/Uú8½İzäx/-ĞÉ@´$À#×4\nä)ŸõÈñ9©s…Ua	SPşYÓÊ{Zí¤9Ö0k©@®³½ØæƒÇíí7?³÷_É#·%-¼FÆRS>J´2‘ôw’–lm@LCèñ†xY_=†ÍƒLKŞƒçÁb›ıÄE†ûŒ¯³lmœ†Èˆ0<ásı~Ò‚±MZI3^›Ú ux®ÁºË_Óï¯ûëÆŸ‡…A%|Ø<ìb¿î–x½W`ßSÈ\nÖùÒ0Ó8İ»×İ\'eŸ½”\\zpÙV¬\\jsæ/·Å=œxd@ÆâÓrÕÀScO¼èÔt5ÈÒŒï¾Å&¤G\Z{‘iœZç]?¾\"Ä¤ù’¾CmÀˆ©–™WªğjÄ9³]¯ß}K(*·*\\?rªóÚ­¥E\"#{yÀÔù6lîrËëVkí%-¶>iï¾£×âË¶‡¨éµÈÉN·ÌŒKKItIƒÏÿó) W–Wäà¿2|ÆûŒÁÈ(öáÁğhô©2@ÀÀÕ}8#É¶i±ÓxãöùãxM\ZBH>¼ôq‘éd2°°ƒ±ßÃÕ–ùpáğ¨ğş¶âm½>Æşpó÷>æ÷ûucoñŞ-È~=Ş˜k™~¿e@äŒİ±/ïÚšµ+mÁ’ÕVTÚG Ë[\n¤„tˆoŒ1ÙƒÌÇcã2\0;ˆƒÆ—€\\V;ÜêGÏp:yñT Ç·ëdqÀ.Ïİ}È1Iú·C¥®İI&	¾ÄYî¤\ZyğŒEîm’¢>mÛ‘SöÅÏi_|óÁ~ù×mü©zäÔd<²t±\Zyd÷¯N/ÈZŸ±ŞØGÑ™TÍhMºÕ8y€6ÆÛ–F#o\nà9æÓeE\r@ã™BÆs\r®M\\È?ŒŞÏ><)ñy@~ÌÂÀµeş>ıvë8<xş˜ëÓÇqîÛ?;Âø‚è×ÃKöã•ıq×K­G K‹¶@~ıZÏşşY…½-irÏV®Zfõ£-¯C…9!ò5Î\0â?dIz-¢ÛÒNÒ¿ıGØĞ	s,§°Â}±Şœ(‰\"c¢ğ=Æ óR­@FZ¤”v·^c§[Ãì¥–ß£Î:×²íGOd&\r}mßÿª\rì¥Ezz’¥$ÅKû?U§û­¬¬Üuy1Ÿ±ŞÈ ºß€˜.)<1İO\0	à4Ø\0›ÛtI1\"FCŒeô»Ò£@wİfô·R(¸.ú–øÉL`§›ºÒèÃ%=H\ZzLˆƒ4öyÚ2Âü¹æA¤ö Fñ€\"Kè3¦RÈHíMš[tÙÑ¥FxÂĞ÷Ì94b‰à‰Ÿc¾Áú>…a „Áú’GÖñ—¯ŸxÅ^Ş¶ÅKX×²î–š]äz,°ø´|Á‹¤dEkiáAmí‘™÷ñ:á‘‡Ùà1Gv_®GZĞ tÒ‚‘\në=t¼`Ÿ-\\eÉaùÈ·<vrqµõQcÏI5ö:õĞ,-¾Pc¯m93Ò“ÈÈŠ 9ÊbœE[iI©ëÅÓ‘9dBb¿‘ÀÀ€EO™˜ü¡#ğ²A^òFºÇ˜—À6\r-f’ñ†u}}½T@fp\r®EÆ3zH·İwÄ‡¦ 0à@—µÃ0°?da@ÿ#=¤…Ş\r\nµ÷B!İ‹~Ş?ºI/é¦°S\0éááçĞgÌó%M€N§Às-\na¦¨°óªIµ%ÄŸY™ÆŞÍ;L\Zºj]³…‹ç[yU×kAEÿéÑ\nä˜dyãÏ€ü‰´ÈùØıVÚo¨\r9Íu­ñ?\"Ş#ÇE¤ER—J«>Ñ†ŒiÙ4ö>‘eîU§š	³¬qÎ2§‘;öª³-‡NØ»o&i![¿|ú‡ßÿ>²\Z€Œ¬ ë-9‰?RÇ#{E[q×b×?ûHÚ{ŸÏŒà3UŒ|1çŒB^\0$ó€”ÌÇk‘¡2‘6Â\"¯çã¹éWP¼­¿€àéYO¼d8p/ğ·†¯-ß‹_[ëpH \n*…Š\ZˆZ©„¾§«QI\n÷T¯I?8Ï‚û%{¤ĞSI?µ]~¬S+4µ qq­]Š‹ù^b8xíGS£ÏMãüòÛwOƒO_ğ¿.WlñÒ…Ö8b¼åwªV#O\ZYÒÈßBd÷ON,3\\CO\0r´9M k_N{‹ë\\n‰]ª¬¼H#\'©ç4r\ZrE]Ş¶k•@Ô{\"Ëà@ÖõøÊP…›Ü{Ìt¨İoH4òûŸıÂ¾úöûuëiœÿÏÿğìOü£ÛğÒœš’`	QG n4TRbë7È#3Yå¹ô¨ª¶p&c\0€ihhpŞƒÌÂË2ÿÀL>***rû\0>^\Z|hb¼\ZÕ0 à¥¤JT€æ\Z€Ä°x;à êÆ£QÕ³éÁ>Îá(ˆœKL?ììï/lì\'ş3º¤0¶Æ3#›€0ñ¬€IµO3—{öa\0û¤À2qS€yF<âÅAğ‡ğ</®ï¼î\'È²ó‘Ÿ¸¹€|ÿá5÷}Sg/²Nå}Ü¤Ÿ87L€›’GËbéqHÈqß§ˆ‰“DˆÉ´x†¥tt|ª¼- ZlQ© ­¶Š:ÉÁá“-³]©Å%äÈkLù]7æ}¼>#\0yªÆæ¿öbø‹2şúy=«²u6ÑjÆÎ°œŠ\Z7	ÇÑSöåÏ~i_}óı¦u÷Ûşğûç?ıÉm|d$Ekùô)sf›^<—ÖúÔk2™‚7Ä+z]Œl\0,f†UTT¸)¡xd¼(ğ‘1Š\0Ê6 ™ˆjâÇ\0ÑÍÄA¦SPşå|@  øáŞÏ6Ÿ~ªu®‰.¯—>ß‡¡g¹/(™ÚéÀ=ûQHÀäyÄOAÃ[£ïŸçøtûqOÜúç@¡òç\0=Ï‰kR(h¢§Û™‘=@æ#?|tÃ–¯Xn£&ZvÇ\n÷†G`âØä ÇHğßyä8gZGVdYlÎÈI]+å‘‡ZmãDKÏ-şäÄ.jÈI6ô6Á\rˆ¤µ+v \'0•3“OßFÎ®ªq˜¬ae_ëÜ{`\0òw™‘6û‘>J‹”dAğÈ\'\r1±øÖo\\ïÆõŸÈ#ÓØğ`yÃ£áAÈ$2 È\0\Z_4äĞ¯L/-ØÆ†%=#„ÃûÌ{d´#™NæSõ:û¸.Õ8U<ëk\ràá¸\nÀ\0$\0™¿.ÇYgIã=O-Cz‘\\¡tdÏ‹š‰ÚÂkhÒË6#%€‘ÂG\\^à>¹…”{Ä{s=\Z”<)ñqŸbz6>\ZıÏ²×ïd_¸åë·jp>¼ho¿x`Ï^Üsÿ×W?œwöºË#wpÙ}µŞ}™>Û\r~`1j¨E»ÿÜà²8I…Xyä@# Çdç[L\'É7j\'<bŠ›GÁ÷EÅÿ„\Z×®‹ëCÆ#÷hg5\rã-5·«¥å[aI/Ka>3SJ%-rrı4IŸYKÈEÒÈ;œv ùáƒıö§ˆxœïş0’?Tç˜hÏ\"|TÉÜH,‚Ïh@@ã¢‡ñ\0Afle¥Ä¾43NµJ&áµÈ@dˆŸÓ‹ædŞÑƒŒG#~?úæ=2…mÍuñT\ZSxI4,éÒ¶Œx½?çQ³øŞ†¸<È¤½O£–¡êBîÃß÷àÜ ’nî‹g¼´\'xF^ßkC-Â5ğÂ¾wON{€uµ\r×dàı1üú\rÿkxÙ¾ø öÍ3&ö/Èc¬CyoKÈ1©‚85ï£øÏt®Œ7å£„î3XŒêá•ÑÍòÈ1ä]¥“«”FQ‡=23Û:	äâjë5\\YÒ‘ËkÜŸéÄE4rfEo4u5ÎVc¯ªŸ@`»Ÿ1¤Åä¶f¿5Ô;ìANILpCÓ„ğ¯Nñ		î½uŸº¹°-!ÆÈ`2Y€·H\Z(dšÑ{Z4%pRm\0 ’™èM<\ZëT«È`å|ÖŠk\0ûÈ`` S€Xğ˜TÑ­¡ıœ‘v–Äï×YzOÌ6×õ0cxF ÃÃr@¨¬“ÏI#´Ğ«‚Tá9â©9”ÔXxu	µÏ@½÷&…‹?—™<<ám‚ü&÷]rùñ“[ÊÇu6°q´tínñé…jpñ½·\0d7§Æû÷&¾ÉÆ4ÍŒö’,™¡lŞzNˆü—Ó:sÛ;/ë†Ÿ¥Óù[229\0™O ?úVãxô4Kgö[f\'KÊél1Š;¾°kĞØ+ëédÅàé‹Ü³Îvä¯\0ù«¯~d\Z§¤Ùì¥&ZjdBâåy«ºL^”—!™†Şç42æu&xñ\"xUŒışEL_Uâ•0hÄQİ%>>ñ™L¶ı:™Í:q\'ë<Î	€†Íïó÷\0Ğ_pZÇ>Ï	ÀhfÒˆN8\n\'÷ÅıàáÂ;ûF0²…BHM‚‡EÎàÑ¹&€²äçq-…MM\"Mmyd>^ˆ´xıêùá“Ëä\'M·lÏŞ=nb=™/ÖÇÊ#G`ç±ˆşÏ¤7¡Ä’ä1s»T[ûâ–(ğİŸ©;4ö¢;Ê#•¹áçA£©4²“ü‡ÀOÈ¾2”@÷›@¨0©’qiÁç\0¢<r¥¥—ö°Sæ[½,GÑ=ûÛ®cgì‹oŞ¶Fş—ş«T’Ì|£Áç¤Eœ\Z~­AvÉÜ°ñpyè@Ğì#C¼ÆqáY²xXúğÃ|Ü,}x¿M8Ç€+¯_aÂÑÛxw ¤Fğq´>ã0ûûeé!Û¾@`8\n0`†°ìç|ÂsÄé¯åïÏoaÙÄ?d\'-_qÒâşƒ`^óˆqS-«c¹kèrğÏÿãRœÅñ)-A˜¬FaÇªZ«ì3ÄRø[±$yZ<²Ì}ü°°³›T-i1„‘vÌµh	2ß´HŒxäòÚüÉd|zğ9€(@æÛÈå½l¨dEãÌ%®×ÂIüşÛŸÙ×ß|k¿şu«î·ù—±ÿ×ı¯öwÿá?Ø€ş}[hä”ÉŠùI$ãÃæ3ÌCá×[ïÇüz8ÃÂÇ|øp¦úğaã8û}8–ş<ëak@°$$‡z/ğŠ?t_“c¬û{dûññø{õÇ	–öñc€êyx}<ŸÊŠÏƒŒG¾}÷¬@~d^·ÕkVÙè‰3-“¿SC/š÷êRøãšÌcä‘£ó%r§ƒ¬× Q–!Í÷Ú›åşVÌ¿ç52}ÄŸ€Ü©L WY¿1Sm ¤\r½Ö \'	äœê¾6|î\nÊì·ê~Ö¥fP³GşægßÙo~ÓÊ#ÿ?ş·ÿÍ\\_òŸşdCtg¤\'=Lc¡éØ˜KD#ÿıöF†y 9Î2(Æ:\0ùã~cİ‡ÁØç3”ı>³ıºÒo³üœùóÂFÜ¤\rYBc	@5fõém}Oé$ûÂá<xĞqÌßÇÙ‡µN·—m<7 ÿ)ù<òûçÈOšn»÷\0éµHËïj	Yjì%ç¶”d¾Ğ)ØùVûn¬Ç 1–.™áà£kNŸWäŞfø¹jàH×k‘–#Mü ÷#<jª“­AFZävëgCf,v=ùİ‚\Z{ï¿‘Gæ¯Zÿ‡Èÿûÿßíÿü?ÿO·áAöİo¾×ÂƒÌwà~ª´À<¬ŞüñÏùı\0ùu2)âµ2ç¹d(KŸñŸ3üsÖ:¬O‹O#U?š}JuÎ±Ï×ú\\Ÿ¾Ï­¶õõÃÛN5K õÛaxıı³Ä>™pA÷[ -Ô~xrÅ¾üš?¡¼m6n°ª^u–˜İÑid<,óf3²›GQn1íË­}÷ÖsÈx÷†4]jçQtRC®¤Èé’\rŸ•N#O¶º‘S>+-è~ó ÓsQ ‹û¶ı§/ÚÛ¯¿µ·ï¿°_ÿ¦´4Ôä´dËäí¤8KŠ±¸èÈûz2\Z|´¶×¬]c²û×ÓÏŒìùLaİg.KÌì¡õæ£–s€­\nH4i4zÏÈq2/|=ol³ßkË|Cë÷±îÓÈ¶¿¿ÖaXú0lû},=Œ~Nox›ãş\\Ö}øÖòÂC\r¸Ş+û0Á§juÎk‹€Ì|äGM×ò{üä¶\Z¢ë¬º÷\0KÊ.’¤È·˜Ä\\‹“Å\nÎh$ƒ~N^c’7ä­fØdË*¬°ØøY“ËÇWºä2ë6x”\rƒ´ˆ4ö\\¯E®@î\"¬Æ@í7fZscİ_ø6KyäêZ§‘O_ì<ryİP;rşš½şê[{óş½ıõ_·5iH9S¼,Áœ–$},ˆã¢‚™oŠ •+ÊÊ]W‘k¬=ÈM?2K¶ÉØ0°>\\xİo2\r+¼/­}\Z[´äÑ«L6¢ë\n°	ï¯á¯×–ùpaó×÷aX÷é§	#¼ÇÃ\0Ê¯‡ão³NP¶Ãébéaõû0«ßïÁÅÂá}¸ğòÅ¥íõAìE˜î)€Ÿ^·/?4©FejuïSïæ:Ä¥¢ø<9+ÁŸ-H%1\"]kñ9òØôñÊ+ôhµò¤¹91.Ïb¢>ÛbòÚ[TûÎ–({6Œ¶†q3,ÏÌÒA\\ÒŞñí$?äµé~4i\r7ËìÅ§zÛë:Lã¬´¬Š¾6lî*6{¥û¤lYÿ¡vôÂM÷Ï§_~øÚşúû6>+ÛˆGÈ™¼æ”\'ƒ)œ~˜šn¸êÊ*×¥D«ÏåuaØ|&údéÍg’7¿Ÿ¸èZbh–yo3ĞÀ„£üü|KMMµ””7¼MwUY-ãjËÂiğFÚÂÇÂÍÃì·[/1\nsëÂéx=d,ÙG¸pšü1Ìïóç†a~›cf¿ßcÙì•™£,ì–¯ŞÉ8ùÉUûêë§vÿÁ\r[¹jµuë=ÈÍ>‹O.À‚-.Ç\rAG#ø®[|ºÅ#=\nË$-Ê¬ —<òğI–Ã›‚>6\Z	Â\nr!“‚J­ÇQ6dìt÷\nU,²‚ubÈ[ ÇªAÈ0u}äT—ªs“ÛY3ğ\n‹-¡c¹¥•ô²ÆYËÈ¹µ’\rvèÜ5{óåwªQ¾±_ıº­‘=<² ö91æ£Gf@îVUmÖ­w^ÓCÎ@Ÿş¡‡÷…·Ã`}¢ô£âu;vìhÆ÷™ÃßŸcsô ø8ıuX¶eşúŞÂiF–„ãèƒfğ‚ÁÒÇ~–„c%#~ÖĞ»A!ü¡k`®p˜ğ±°…!Å€ÓïÃìÃ~”Äğá}\\×ı<2ë>F#óçíL\ZZeİ{×[R¦@–GF*Äf÷ÑA,rœ\Z‚q‘¯tªUÍ8f†åæ—;£pŒôåÊ«~ä8¾W‘ñÈƒ7DÔ(¬Óqúš}¯EØ#Ó;’ZÜÓê§/‘´XÒòÁ³Wíí‡ŸÉ#ÿÙ K#·¹²¢ÒÖ®Yë´«÷Z­Í?èp†a–}¨ŒZ1ªÇÜã0ÀÌíğ•ü×\0\ZæüÖ×kËÓÚ|ş8\r;j†ÖıŸàx½NXÂø43jÈU>SÀ¾Ö×_›s‘L\0qœ}<Cú”YR˜©å|Mç¡¥`‘ßoìãX¶	KÜ„ó™ã¯^q+ÕØ{(üÅWtÃ]±ÕÊÇ5CšAÈ	€›iÑn.ED#33.\"-ºÔ\r·ú	³>9O0JZ8%-†ŒeŠæ§ 3„´8a¦\r\Z=]=…a@$r|‡2Ë,¯‘F^iõÓ[^e­û¿‘Cg¯Ùû¯¡ômßßFciÈØOÙg.4láe›p`–œŒÌÌììlKNNvŸèÂëÒ;âAÇoHfù¸Ã×ûsŒs}ènºÙø÷SÒDÁ¢-à$İÀÄ¨\Zµÿ¦êÿbís ûg¨+S(˜kÁ$öq=â¢ `Ì	¡»ù(µ&]€¤}ÔVÈ.ös-d£¦gø›ÚAÀ\r€4öšA–‡~÷ÔI‹÷ùÖíK¶N5kšÁä8>må4rÅd¾ä@Vƒ·?â]c¯Ì:ü>Ã&ZV®<§×È’!xäèAc¯gãX§‘3Û¡‘#ë2= N)ífC¦Î·†ñ³,%\'²¤E´\Z{üÒ\"·º¿˜·ÚMYdíªê¬´v˜8sÅ¾øö—öşËmkä†Aœ7ätŞÙ*éd÷µ!–qñV­Lfˆµ-½ùL\rô>0§€Ee%ìuÕCİ\ZdÂò¿yd¢Ó_ã_k\0\n¨H¼0“|\0ƒáf\Z›ó 3tÎÛLbbòØ€½5Èş^YnXÖÙt<ÇI“&9ïÎ}1G›6\0Çıü&]8KÎe´ïÍ¹l8şn^x ­€L¯Åë×Ÿ‚ŒG~ÿU“İ¸uÑ6lÜä\Z{ä¤ ÓØsÒÂOdyI<rÇ¾C¬wãxËÌ•Öõ™ÉDhä’jÌõlñÈí™4M.È%İ¬qº\Zğç¸IC®û-r¢®“Ø©Â5ö\Zf.·şæZ^U<ÔöŸºd_~÷Wä_·%-ZƒÌw-xİ‰O`©IÉ®±GFû¡TÔçŒeI8ÏÅD &Ñxóğb~oœ®F||‹ı€“ñTµ\\¸Âğü¹|¤É¼¼1€ø{#í\\ƒ%Pâ±y€ÉP48¸­ÅDæSà‰	ŠXÇ\04ëÌ¹à•.&±ÍÜjFñÎ¤‡ar\n5\0…ˆ™¶JÚéïöoPÓ½vz¸5È´xğˆ!ê&»#i±iÓ«î5ÈÕØ‹ã«™häÈÑ­@N7ä\"iä~#§4{ä– ¹Ï°ñÎ#g \091‰…/w a…´öç@öİo#æ­±“H#÷syß©ËöÅ7òÈ|×âÏ9]091jION‘G®n²ÏèÏ™IFÈ<\ZØéÓ/½!-0°_bègºß\0ˆ¸[_ëÏ1ŒÆ#º8ĞÉ¤ÙÀE-BÊèÑ£ğxG¯¡??‡˜’‰×fq$@}ÜÈ \\&W\'Ó[¹W`§À‘N¤/LXjâå¸/4Ôvÿò¬%ÈoŞ>uİoôZÜ¹{ÕÖJZ”wïï&¶\Z¹İç=²ÓÈÈ]·A’€œĞä@Z$WXß‘­Q\Z8 ÌÉ@Ztq\r=Dú«±×Ääæ‰õA.µÔ®İ,¿Ç@9\rš*iQ=ÀÊœG¾lï¾ş¹½ÿğuÛ½!ƒêÄtÁ¥%%XZB¢“³àÒSR­{u7[³z{À\0ŠùŒÄÒ‡ÁSÔ××;OìÁâœœçÙ¦1‡GfÉvk˜©z·mÛæ2•øı5üúŸk>}Ht/^ˆˆßÇ$\0ÇŒ4æ]P;tèàæe©×Ç­ãÆ\0í”ÔÔ*è]âåúô•ÓÕ„\\Ÿ‚\nÈ2‚´°G€„@r\0²Ÿê‰5ñpÓØÃ#»\r×ıöÊŞ¾Óı>¿i¾QCûîe[±b••TÖ$5öR%9[$«Ec/†	E%nˆº¤~”\rºÀ²óJ-!Vzšî7Prä‘ÕØ‹Wc¯—42½i¹-6)/²¼}~ =©?İM\Zb\Z§ëµ \\z@.±”ÎUN#Ÿ»Êê§.–FÈı‡ÙşÓ—íÍW?ScïûÕ¯~Ä#r³Fvs-İ‹qCÕ©))®úÅ#ãaÕãyĞa#Ãü:…7£_˜F8Y2Æ6ÖÚûuö3|ü€@¦ıkÍÇƒ—Dî 5É>†ëP™ìŸ——çÂ†ßĞn¯?†Ş—n<2×Âó/áğÆh`æ³Î3¥ -•×eÿ½û÷ÜYH\r;€_²t‰šnB<.÷ÀÈ\'ûĞíÄxd<³$Ed¤Åc7²×¤ÆŞeyöVR^c‰i,!E^71_:9G¦|\nõ#ÇIZøî·’A#­qÊ<²ëGôZà‘£:J&Èã:‘ü¤\Z{ÑŠ¤æ9ÌÈïõ\rQ¼Eæ@{ä2K.ª²ìÊ~6jÁ\Z:{…å	êRIšƒg¯äïÜ€H›ÒìDèµà»¾¡Ç§\0’åğJ«²›Ì¤!†©•Ñaó\0cd\nº˜·A¼Œ\0Loè^z\0²²ô@\"ğ†c\0Ÿ™™éÀAÒx¸XzCôSóH#ŞŒÆ£‡È¼÷à†¥ZçÕ%ªvªrÿÚá\05lœCƒhi„Ñ@Åğú¼4àß#DJà]éÙpÏzõLù³›á#GØÖm[İ§c>ä¶\'Ndûÿ&…öF\ná(x6@ÜŞ#-<Èì&Ö_v#{·î —òâ© æ;Æ±’¼ıáCğÈÑjÇH^$dwlÜôÔHc/2Üydæ#WZÏÆ	nös-bgX#3×\"©sµ\rš8WÌ€HGyä¬Õ¾Ü½³—©t^¸ÆÍ€Ëåûjìğ¹«öæÃ·Á|ä¶æZx3RÔĞK\Zy~Ò#{ô\ZTVVº¿Çâ?£5©EÏÃdº7à SXâ±Ğn¾o8ìmYæææ:O×¾½„¶[á\0™FVsfG®†²5H?fa˜)H\0$€\0¶/ˆ¾AG\rÄK¢ôX\0\"šjŸô`¾@aÄË>Óu†Ç[Ò;Á[!Œ\\z	ƒ ¡‰Là\\ş4’Wüùuş¦lÀ 6tø0÷¯M#Ft±pO²Náóo¡PÑĞ\\3èµğ\"Ìµx¯mí‹ô##-<Èe},)U\0©±‡GvoKÓË\0Ì1’ñ–˜-éA?rÇ\nëÌ‹¥£rNĞkKØ`@$Zú6Q² gÃD0|ª¥e1²—/H%-ä‘“Úw•GVc®K7(ëFL³Ôyä´NòÈ…-­œØ¾Â’Gve³h­9_:¿û=zñº™7D~õ«6ºß<È¬ˆÈ½1P¡_ÉHş”å§€ŒÑçË§\0­ÅCp—.jÍ~¦ï˜0ì§ƒ8ğ‚Äé¯ãaÄ>k[æ!f	PTõ(ÒtÈàòqs]<0\r>jÀ¡¦Á£z‹ù81¶I3^˜€å¼(á8T¢áGá¿ª_èZşï€yíúuî¿CøG§ã\'O¸šğ¹ã èÚ£v@ê…Íß/ú^‹fiñ¶ÉM\Zúğís»~ó¼\nÙ+-û1_Pf	*­X½ºÑÓ>2Ş¶KµõÈ|35K\Z¹ÈôZ¤–ö´ÁSÈ#Ëkç)Şô¢ w@f>2™‰C…=XåÀavüò\rò»/¿ÈmL\Zj\rrë´\0TkÿÈ4’¨ÃpzdæOà­ÙCŒQ «iäóÿ— @‘^â2ú’ñş®æ‘çr/„£‘†à9`t—!;<˜d–~\rcd\ZOìùpÄÛ¼OŞØƒìÿÙ‰7ÖyŞ~?‚üŞü3ùxèäÈ<æ—oeÚ÷Jaò×ßäléÒåòÈ5?ê‘²ƒ!êxyd4ò€±3r×OA–·MîÚÍzä¦q¦d¶9,\rRÒÃM˜kı†N¶ˆ™ïĞI´ëÑßÌTNf¿UÔ\rÈ7Èoß¿oÛ#3²G÷0§& ñÆÄ^µ²ò#ÈÁ|äOAæ!ûÌg8×ËßÈk×®ûS/7üş0ÄŞ˜sÑ¦è@âó×`İ^úuª×™ú©®uš]‹ç¬¯¯w\Z”}şº@ÑÁHİpÀNÏ…#œŒı€Úúz#¼‡o‹´à¹z˜ı’ı°ŞKÆ>¾*„‰Äÿ\"ø\0â³¤‘¯8|‹î·µë­Bú31åÇA€\\6x´9#;²Â»iœ9Uö15˜G‘ı©´àåÔÔÒ6xò¼\0äìÏƒ\\Ø{ \Z{«İ—†x‹šiœäw_|a¿ş1}Er|¬Å.2`á‘é´G#û‰õî‹C2\"ä3G¢ÛĞÁN¼,^8éğŞùs0–ÏĞå½ñ¯¿FØ|\Zš¡Ğ¶?æ24´ß§“u_âaé]@J\0®?æÛxW´4a½Şe¿Ûúzaák³ôésa5òo.ŸÄâÃŞb×h#…ÕyİÈ:Ë\0nî;òŒ¿–).rĞØ»}çŠ$ÉZÜ×Ğ#½xFö\"s-J2Ò\"C9)¾œ[ğ×c|iÓ$jGÏpoQ§dCÔI\nƒG.`®héaCåië†O³¤,Á\rÈ)Y½ÄÂrKQcÑÇ¼€š_]k’\'¯Ş<òïíûïÿ*BmğkòĞ!ƒœG@æKœÁ„zr‚OñÈØS™Ï,2ĞÈ,ŒI8aiPÑà¡”––Ö¼ı:Æ1†‹)h?âô\0ûka,„ƒ!²ŸŒ\r‡õa|x³ä˜Ë6é¯s]¶}Üáı>,Köûëzóğr#, ±~õ×õÕìáõ\0³d¿9ÿG€ƒıt½½zEZdòÈ/_÷£ÈÄú§vóÖ¥Hc¯Æ’Óä	}Ïës,\Z˜›Aæ5ı2‹—·Ä#rº¼m½L¬çã-yİ÷‘ñÈ}†M¶ş’´ğCÔt¿ÑÏÌ¤!æZ,È‚]Ò£ë»^L¯E^÷ÚàU\'…+è^ç<òÉ«·ìÍWhä/r\ZyXC½å¤§8¯L¯\ZÙ5öğš‚Œv\\¡êÔü,d\")\ZûğTô40§8éBcBƒ	‚à[wÉqÂÂB×¨òlˆ—ø‰è×ı6i |ø8û	xv¶Ãz§ã¤ßŸëÃù°ÄKXöû°á%€ù4²/„ad¯ïÓB<O´öR‚?¼á¯|=ÄNÊs^Œx=Ô\\Ë5ğè¥ˆhäıÈz†‘‘yÉ’e®ûí_rV‹g@$&32²¹¸‡õ2Áú5NŒH‹– ÓØK.îæºßúc@¤Ì3:Ë#‡A®vß~ã›Xa:+íßà¤ÅÛH¯Å\'oQG–î7¼q°åf¤:¯ÌÈ^Ù} EpÅÉcRÕÓÀá›a<\\¼1ß€1â=(ûÉ0à§Ÿ˜	7xYú=¸aˆñÊô0rÅhÚ“FX8~Œm\ZOÌöbİg$×_€üÇY8$Œ\n2:æ{KF€O;û0`£¡Êõ9æÁÅ|:Ïµè{Hó‰“ë²î÷‘Vdƒ$ôŒ ±éöã¡»û±ÒË—5‘<[şg¿éu<yaöãµ}üà2Ùo»{r^;HGĞØÓòµã³NZ\\£±·l¹•´ÕkâEâ2CÒ¢~”õ5ÕÒämãc6šÏĞôZĞØëÕ8INşøòi+r«7[°+#„¾×\"­½@.³¤Î•îÛoH‹†™KÜ;{euvâÊ-{ûõwîKCm¾³7bèËËL³lyåôäà»É‰|ô;Y0k]\0¶\0Y™î72ĞĞŒ€ÂİBÈ2ŠA<,Cº€êeŞ/Í<d\Z€xiÂÒ·J¦“±Œx%Àxhˆ—¾i€ ë	ˆ<`,ñâÌ]\0ÒÄ~º¹èo¥Ÿ}à³íÏ\\\Z–â¦\0pot™qmâ&,`²ä×§ĞñO!\0LîÁ‡#nÂ1é‡çÃjèaÆ@_:|äˆû›^z*¹zıZó­³ÎŸB¿pŞ¥€Iƒ+Œìq7¦ë\rñÜ@yQUÒâñÓköæı»rë­úÉÒÂÏG.<*ä‘s›=²kìE@î\'}\\?j†û@‹ûÒ\"©íš\'\rÑØ«?ËúÊk§(L|º×ÈÕØCZŒ]¼Î}û\riQ9`˜ºvÇŞósI#DÚÙîşÂ7İ2ÓS--%I\'X|\\¬ fpœ¥¦¦½+–Ùİ{‚¡IŞøI0¤K&ÑÚg.àév£+OÌè^ÈÏµ Û† `2!‡W›\0 ˜)Øxh\0ó×@§#Qˆ›uÀ\"¼‘™!q´8@’>Â0Ÿ‚®3@ã\Z\\›A\nz\'€\0c˜Ñ8 §k¸€„BÈ@àù¹@\nP~”\Z‚¸¸¶¯UÂ ãyéåà|öQsQ@(d°¸“Æ›¨ÂÆ÷)@J_<ıÕ|Ü{’ÓA‰›ûàqŸôkÓáœ@{«x)¢ë>{F-£6Á«‡öàñeµúuİçœD,e@D 1L—”/Ë@ä4‹Ï°¸lFíºXbÓ0ÊŸa©|âJŞ;šIø\në¾kA?r×jë¯Æ#{Ìl‹aö½´<‹wq”ZjYwiß¹Ö{øKä{pYE]Àg¨V(,vh)è9ÀÆ-Y4öä‘+·37îÚW?ÿ+7²÷ëÖú,İÿ¢ÎÊL·@N•¼11TùLğ‰–GN¤åä{ù\Z¹)Ğ®\0ÃÖôD0)İ7æ€Q(zğx]ºñh\0â5\0hñFtµ?“e8‡8Øç‡¦™¾HA¡fà:xq1ÈTàx ñ~d.Ş’ø”ÀÃ@2_‚´\"wPÀC’F@a?…ˆ\0!v&õcş(L!\r@ÇùÄÍˆá¸7_À¨Y˜kü¤×àT\n\n\0Øé7r\n sï</úºéúc0„gÊ³á¦\0úÂçÊ›/¤½µ|ú”\ZDZıÍãæOf]»qVñ¬q“†’2ùë…nr}¼Àd7ß\"6İø/½xyÛ¨Nòœ]Ê­zˆ@7Ã’³ïãÅ2¤m	9ü?H™ô­<òˆiîö˜4Í¿5%«±9¶¨ØÒòài€<ŞâòÔĞËìàz5¢3-™~æ®U–ß£¿Ùë?qåUöµêú‘vñîû ¿şö[û›¶¾ıö9Ø[Š¼tuµ\Z{xä»T¥A×š)Áä<.£c\0YPPà¼0‡şd€Á“â¡iĞ1¥“LR2	™–Æ›Ó6Y\"%d6‡\0NAÁƒãé<È\n`h,’.`\0.â¤`ãq1R†Ÿ©€€\0HĞÉş=B\Z©Ljà£ºfÉ½100r/pxt`¥°<sˆ›t2‚‚‡´ ­Ü#Ï‹´\0%i\'.ŒBI|@Mz	Gz‘mÔ‚<W\niğhœR`h[p­çöú-XL¬h×os½O%jT…AfÚ% 3ç¢déß(ú€Õ˜ëÑ0Ö\ZÆÏ¶5ä˜G­_t|®%ÊCÇu,wÃÏ}‡Ouß>NÎ¦×dfÇ¥•õ°ÁSç	ä‰–Èª™*(©ÒçY-M²\"]ÁÂ>ƒlüÒ\r6pò<yäZ«3Õî½üÂ¾üÙ/íÃ×ß´İØªj-3ƒ=M±y_@§?Y#oš*øz*ƒVêáß\\ü;é#—x;¤ÏĞÈ`âáâ©ğ®\0‹§\n &SĞª|±“óñJÌúb–ØÏMFr¼¾¾ŞÁÎq\0Ã;Š¹òª—ŒÆ;ŞĞ\0oN<Œ6š‚I\rƒw>ÿæúšù\r\0À^Phğè6öq\rjÀ#MÀEzˆ“ûaá(\Zöqm¯¯9—Gãg„Íu\0™øx<sµÂ9™§ÏèId\ZüÕï{òìš}ıİol‰M×ò^–(İWãyİ)²ÓÈ9F \'Ğ#Á„ yÜ\rã¬‘·ŸéZ‹€—k	’¼eÜ¥»ûî½­AN`ˆš¿ç-éaC&Ïµš¡,9Oûğî’|3E×Hëô##-ø\"\'ıÈÃg,´¦/¾µ÷‘şY „8ÖÉ@îÛ—WV©º¾©Œ Ûé¡™jÏ†\'ÁhÔ±íAÆ“âqMÇÈÕ!\r(¼Z—jH|èLäÕ< ˆ\0—°ã-ÉP –H	Ò@ÕK†“Ñ€\\€Œ÷DVQ{ mıK¥\0\r´4&i”¡—ñvxh46@²‡‘mÂy)HÒ@Ú)`À¤(j)¾ÕAaBà¥¹?<8÷NÀ:Ï† Ï„ø	GíEXî)Äıs<1÷L¡qµåÓ\0ä/‚®8ş‹úQSğ¥¡7Ï»Ùµ¢·%\n$ş¡Ÿÿñ@ÓFKÓ†ANÌ-r½ÄöåÖgğx:z¶¥fÈ“&äd5øâi–43_›ï*%+jéGÎéú	Èü‡^fIO2i@Vz-tn”\Z{1Òé)ºFŠ¼rki1qñ\Z{úåw®±G÷[›ÿêÔ0dp3ÈÉILÖ	\0ºÇİ»WËË-vùñcŞø}äªJªlFë\nd\"™EcêœF¯‹Æ»>™C¦\"™€WÇóRİâå€\ro,À	`ÄA¼x@Ãc‘¹\0Ìy,Ùæ|ª^ EBp\r<`\0 QcàÑH70R¨ğ˜4\n2Á×¤°0îÑ\Zô.qã	ñ ¬sO\\ËJ@F†>Î¥@ğ-dÒOzx>\04!íÜ+çû¸)ò,(ÄƒôàùòÜ(4hpâ\"mäËã¦‡è`2Ò3òıGí«ošœG^®\Z ‹@WÕ›Ş^ ñä\0dÿÉØh¾ká>Pb	‚¹oÃ9a¥f—XlR{Wc¡ê,I\ryäÜoÄT7iˆWıchÄ%+¾5$;;¯!Ÿc=³$æZdÈ#Gú‘“Ê-MòŒ´pY½)ËÖÙ3æ\"|¹Í‘Æş‹:ĞÈŞ#û>^,)‰~ä2yÉizˆ—´äÅcçíx¸@Mõ,€ÊÃ&É\\@¡\n¦\Ze?çá=¨~É0Af’¾jÆˆ›0„õIxâ÷`±$^ßÇì»ì\0„u¼ûF\\\0È6q.Õ8ç°øH; R(|º}ãÀJâ\'>-ìcéuì\'­„ç:¤…ğãÚœïÏe?aÙ‡ùãşšñ²gÄµ€œ´q.m˜îh›s¨Ô†xùÀıóé‡oŸÚ­Û$e–;ã\0YÕzlº@–VåÃŞ®§!>C fHÃºIC±¹]­ß°)6fÊRKÎ*V8igyå¨ø<‹•Œˆ¤€\\;jº\rˆ€§Â\\ä(ş›¤ È¢å•‹ª¬Vò¤‡¼{¬$Jtz\'I¬Z!¡@²´Kµå÷ìï¤™}6ß¼şÒ}“î·6û‘‡8ÃÒ€½GNLLP5ÜUŞv´ª·SzH<8^Í	`â!û‡Ïƒößg„ßGo>¿Ÿu2$>|ÌÛd\Zaı±p\\\\Ó‡ñçc­ãòû}8¿¸ü1/Æ=bdŒã>Lø8ûˆÇ‡õ0ûsXºş]í÷Û¬ûsÂçùøü¹ásühëX\ná¥K+®ó@û__zòTèú1iÌ\'vS /W\rÈ4¶Z€xX‚@–Åğµúü2‹‘÷¬0ÖŒ˜)/ŞU°ÒÄB--\ZFÈıC »÷ñRòÈ1…¹C©Åuª²*UƒÆY´<yT\Z=ƒ,í+TºY{5ö&­Ø4ö¤‘{o7›^5ƒÜæÄz<²—ôZ´öÈ‰‰ñÒ•Uå7ÈÛîWæ?Pæ0yp<¬ûÌo\rë>æÃùŒòÇ1Ÿaa 1àoşû1Âø8üµ° ¾q¶>ß§Å§‡cì\"Oë´ùıaĞ>ŞïgÛ‡‡pÎ‡f–~İïÇ8|ÀË#AÎ;+¯ÙÃÈxä»÷¯ØÅ+‡%-ø®ÅE\'-:«±G#‹Áşç.š}{2ÿ­—-ÏÛ®Äbsvq+(ïoñ9%|\Zy%»Yİ˜Á|dyğ’èT@Î·X%c:UZ^–SQkQ*\0Qhd58Yc>²\nCÇšz2Ò‚!jú‘Ïß~(iñÄíµ<rvV†ådgº~cï±TÁİ­[¥´4SÕÂ¾ÅèUP¹LŒd\næ35° ğĞÉ(¿í—„c@ÀãÏõ™İÔ„÷€2œËµYzÂÇqLöPÕ®p}|tKyÜ¶®ëâQËpŒm®ëÓÃÒŸß|^hÛ…“q®ó¶/¨ÖÃç²N¼ş<¶=˜NÏ¾ø¬›Ö9ÎkK¯^1o#qlÖøöí;N![nŞ¼nŞÑu‚	û,¹|í¨}óóçvëÎE[¶|™Uô”Gî ˜Ñ¨4¸ä‘éÓ¾¤Léeºßj¾\0,,·xiØ„ü\nKÌ¯”–¼ÈĞ@¬ıÑÕP+înÇÍ¶òÊîU²\nG–äI‡.n†\\”ÂEw¬tñE·+U!(uqDIVà­;W;ÌÈ^¿q3­À½!ÒhûN_°/ö÷}ä_·õ¯NÃ‡5XnN†µ/Ì³\n,MÙÏ…\0è¬¬të×¯\Z>mÊÔ	vôø=À;æ¡ôs\"¨¥Lk@`°§‘L$s\\G}d.óÓ§zĞOÙ§ğ@ô„F`(Ã_Ğ•¤ígx éå?19{äFñ¾@H<òP’=Í0Ë+àÅYTA|Odta=¢@ }„%œHğ°NúèÚzöô¥;şğ!µ’âÒ}s-=uöÊ=íîƒÚááCäÏ&\0›¡ègÏõ,ÜÓ&Áùüâ¬/uŞK=¯×¬¶\nÆsIˆgo]˜/ßçè^<dş	ß¸¸- oØ½û7ìaÓ{ú<hìİ»wÛ.\\”Æ¿~Â~öËWvçş5[¸d‰u*ínñ|6–ª?]^S »ÿA$e	ä,‹É–×dÑß±›€¬¶xYL¡`,¨´(-£$	¢:–ºoVœ4Çú™&à%7ğæéŠ/»@\nü\"…“GÈÑ‚6†e¡ö¹ó+,F\r=†°»ô«·‰jìÕNœ¥†ß\0+4ØÖíßcÏß½¶o¿ùÚş¶­!ê#\Z,¯]–—Yqq‘ed¤[LLd-Ûd[ÿº>Ö0t€\rYoËVÌ±3gÛí;ü%ì-ÙMApW™ÈÑÉd&°¤@ ³^æòrÏüó\0vŠ2ÛûL™Õ$=¸OŸäç’0®€ \'d6°µÊ)£>¤®`¼Ç‘B kç9kpÏ‰ˆôIäûiOT³4×yÄ¶€|B\ZÖsAõÌ*<>mîM•Â§ãOŸH>dâÑ5tŒyÚOTH>}­å[í×Ré¤p=|ğL ¿R¡‰ÄùT\rµÇjÜéY¼xúÎ^>ıRÏLáu?_(ÎJ¿îïùsÉgïìyÓ—JÓWÚdİ§qİ;wî»F÷åËgìÎ=5p©aú„†à]5œO©|@ ·ŸÿÕ[»zã¢;ÎÚñ/K¼ÊÄ_÷ò?Ô‚™uşİ‰9ÑÉ¹¹H\r¹J‹íÔÍâ;÷°¸¢î°Z^50·ŞIw.·ŒÊ^Ö0{¡õ›0İ}y3ª\ZrY•ÛŞºTX\\ç*‹-ªv#‹VÃ‹Q/ZŞ<®¬§eUõ¶Ê6sÍ6ë=nºåöékÅu¶`Ûr;ıŒ}ñæ…ı»¿j£×bä¨aVP˜keå]­´¬«<p¶ÅDó®]´ÅI/wìT¹NÖÏÆbkÖ-v%À§J>Ru¦Œ¡ó©`}.X‘\\Ğº ~õZí¥tëy°§|0Ü{\\wzJ†½qàñVÃ³w&]lMöBa^*îçü™â~¢Œş¸P½€lz|Wë¡Lğ?{è\nÃ3ï®#Xğ‚Mxf€|$€ğ±ÀÇwN *şûè~ŠG\n÷-À_èXS½2òtºÇ—/•f\n•¼÷#yÙ‡òŠô«?Q#§<®)ÈëXÓÓû®À<ú’ª=(¾§ÏU«=¹¥õº?=+íçu¦&¥ù‘ÒÿDq=×µ^P¨0¿Táx%ˆİ³}ñPÇ¸æ#\'-N«~éÊ^Aüôª ¾l—•?\'ï¶3§vÚÙó»íÍ»¶çÀ+ëVciü‰cV\'×ı›VèŒn8×ÿË›|Åã¼!\"ıš Ê2^`\'„MûS$	r*úØ ‰s¬ÇĞ	£¸£r¤}‚Îîä¾²™TÔÍ’T µÄâeqµì¢š¡kK.ëc™Òí½FL°yÛZÏ‰3-«¦¯uiìo3ÖÏ³#gèŞ	äVëùÛÿ×£Fw°VU—Ye•„}³›r¬{wnÀÀZÒ0À†hÃFô·QcÚ¤)Ãå™çJfìµë7Î+sn)Ã†ƒù@º&{©Lx)ïóBÛ/åaŸ=½) nÉ³Ü‘İ•İ¼d¤@“§\"Ã^—/î˜ëZŞ–İW·d7ÇméE¼»<¢«^UšîÙAÿúÙ\r{Õ$Sü¯U\0^(î§ÏøV`3Ş[q?Ó1…{Şt]×½)Pn*Í¼GXÂ©ĞvÁô’ô5)Œ®ıì‰Â7)íOîhyß./OÉ{ògŒO•ÎgÄ«ğ/uŞ³Ç7T[n5¾toÏKCS°ŸİVx¦€^Ux…U:^)Ïtşs=§§*èOd7¿Ğó|¥gôJ÷ùâñm…¿¦k_SØk*Pò¼÷ïÈ_tS4/_;a§Nn·G7Ú‰#›íâ™véÂVÛ¿©íÜ³ÒÆLo¹í+-Q¶˜l—!ÏI7F/BšàK–\'M)Ôz{WƒP0:Ëêh1ÒÍ1¹òÔ‹Íébñ¹¥–,™Ñ¡z å–ÔX\\v±Å¡£3Ô˜Kë¬õKÈ“În§Â±XiíXÉ“¸öU²jŞS½Ö©ÿp0k…ujo©½úZ‡ú¾6uİ|;rá°½yóÌşı¯‚Æç·ÈS¦N´2yâ½º	æ\néeé¥Øg]»Û²eKmÅÊE¶tÙ<[±j­^7Ï-™jÓg±%ËfÙ–m«m×îMvâäA»xé”]»~Ñnß½n÷¥Ïn_¿f7¯\\°[×û½KòP—´<gwn²Û7OÚƒ»ìî­‹võâ9Ùe»vQrù´İ¿{Z€œQ†_°÷äiî²wÉk]µ[7®¨asİ®^¹f×®\\´›×NÙ£»\'ìáí#öúÉ{ñğ‚=¾sÆš^¶{jÜ\\Rš.\\<mç/U{QûNÛ“‡ØI{ô@¦õ‡ÎÙ½»íì™£ò`ÇìÒùvåÂ»sã„=Ñ±\'ÎØıÛÇí¡Òu_i¿{ãŒ>qÈ?f§NWÜ\'Ôà:©¸OÚãû\'ìéw÷¨ì¸İ»yÚÎ:bçN¶3ÇO)ş#víê»yã ôí!»{û¨ÏnÙ»qıÒpĞNäŸNOiı¸ÒrØn)üíËíÎ•vóÒN»s}ÂëyŸ?d‡î±mÛ·¨–\\nËWÌ²5+&Ù–5Sm÷æY¶oç,Û¹u’­Z=Ê\Z†÷´üE––#Ïš£=ÙôèL Æ‹\n>5ËL³Ô|à·°\"«Æ]N™%\nÖ¸ìR-+,¥ Êí‹É,¶XQ´?&[Û‹f™[n1\n#¨ãÛËcwím‰•µ–Òsˆ%÷li5¬ı ~6mıB;yí¤½{ÿÒ~ÙkùşÏÿi¿æYŸ>½¬¦†?=/³ŒôKˆK·Ø˜$+êÔÅ/^(P·Úöl×\r¶c×\Z[¿q±Í?ÉfÎg«Ö,²µë—ØÆM+mËÖu¶s×fÛ`—íß·Ë–/Z`“Ç´¹3\'(ãwÙcAqùÂ^Û½s‰mŞ0Ïöí^i»·¯±	£†ÛğÁCldCƒM3Ä¶o] ¸Èëœ¶Ó\'7Û¾]Klïö¹ÊĞc¶xÁ>t”l¤\ZÑhæt[íÅ£#öH™{ëü;q`]¿xÈ¶o^nƒëûXıàşVß0È&Lm‡ö­²ONÈc´«—¶Ùñ£kíúÕCvøĞf\"P? ¯\rØËF\ríe;7/>§°gíÆ•=vêØ:]k·?µ]×ïk}kk¬¶®FµUmÙ²ÈŞ?./|\\iŸİ½²ÕßÚ+¯¸G÷4Ôêjjl`m?ÑPk{v.•´9!ÏzJğ”XcW.­Ôlş¼	V×_UõÀ6dP­îoœİ¼¼ÇŞ?W:¶»W7Û£;;ÜuÖ®£ûëgÔZ¯šî6N²ïøÁöôî!{vï=¸¹]é^g·nï²YóF[N~GKÍ’6Íª°è\\•S*Ht–t-}Ä,fT:àj)£ƒ±ÎqÁí‹Ö2VĞÆ¦€e=®]…¶¿ÂF±;.xó\0XûµŒn§ğjHFã™Õ˜ŒïÒÃbËj,¾j @b©½ë¬‹òlŞÖ•væÖY{ÿåkûMäåSÏ¯ûŸ=ŒßÛmÒ¤‰n`„É4ÙYÿ1©\'¯œ—›¯‡Tg“&³)SÆÙä)£mÚŒ±6cÖx›<u¤Ÿ8Ì,œaÍ²iÓÇëAt6uÚD›0~ŒõêVmòr¬¶O• 9fïßÜ³cG6Úê•SmÁÜQ¶|É$[»r¶³Œ¤dËMO³N…ô¿úÅC»~mŸm\\?Ç–.eóf¶-ëYMÏî–’e™éÙ–—“acGÕJZœ³¯^Ÿ·ã{—Û¶µ3mù‚ñvp÷\Z›?{¼¥$1_$ÁÒ2R¬wŸjy×³öı/Ø¥s›lÓ†©¶jÅD;zxƒmİ¼Ô².3-Ñr2b­´sšªç\rö›¿~j÷n´]ÛæÙºUSlç–²…Öµ(Û’’/_MÊU^nÿëÿå½5=8jÇ,²ƒò†—O­³ógv[]7#)Á²SS¬s‡,İÓ,û_ÿ¯oì»ïnÙùsmïî©vøàtIš3znCto)–™eíÕŸ9y¨ıì«[öï~%½-ĞÏ[l×/­·ï¯Ø¢ùã•Gé–™™aÙ¹ÖĞXc_½¹bÿ÷ÿÛWöõ›ËöèÖ{r¯}ıá†­Û¸Àr:ZJf¹Åf\n®<A\'‹É•ÌÈ-vÑNnb–âJ‹ÊSC-¿»À×º¼yTnU°Ì.\0Ïğù:—|’¦jGcÓùùÑ[(ˆeÑ„a¿Ö£Ú—ºî»è\"I\r5üâŠ{ZbE¥J¦döèg]ëØª}›íÊı«Òø¯ì{5ö\0ØóÅÿëaì¼pá¼»gb\r“gºwïc‹Ê¬}a‘uêX™eUe=zVI~TZŸ¾ÕÖ¯5\0åÅûu—Wêiıj{	’n.LµäIu·J+/+µ.:ZI—\"3rˆ`¸hïŞÜWµzÔÈûíÙ¹Ê6¬[`ËÏ²Š’®–\'mŞ±°ĞªÊ;ÛéS;ìë¯ïÙ‡şA´Ì6¬™k«%ojT{PÀòÛµ·òm¡<Ø÷¿F}pÜNZoû¶/³õªbwm[i³gŒ³œìËÌNµü‚\\1²Á~şİs{ûêªªø-¶}ÛWP¶nYbKÏ°üüLËâµ¯ôxëÙ­ƒ¤Ïûğå½ ìÖy¶rùd[¹lª-[4ÉŠ:f[\né––`»æÛùóí¯ÿê…]¹¸Óì^l›×M³›fÛŞ]«­OÏrKOJ”%é³lß¾Õö·ûÚ®ª îÙ³LŞ|ŠíØ6ÉÎœŞlÃ‡«zMI²Äìœt[¹t†ıûß¾¶gÕx;´ZµÓ\\Û³c¦İ¸º×fÌ`®w²›F@ÿÿè1õö‹oÚw_Ş²3ÒÉw-ui9ªZgÚŒ‘òÈ…–œAC¯XU?’ «Å2_Bò!Vò!.¢›cµ-­%	´Ñ‚Ù­gÉ\08KbÈ\ZwùÀ,Ë“üÈSA(ĞzØt,FË˜€öEj½½dG\'ykñæ^‡¢®¤¥—õuÿKİ¹¶¯­ÚµÑ®İ¿noŞ¾ÖóıŞìùúÃş`Ø?ÿó?ÛÍ›·Üdæ lÛ¶İÖ­İ`+W®’¤Xjóç´eËùb[ºt‘-[¾ØV­Zn+V,ÑúB-»}Ë–-¶%KeK¹	8óæÎ³ù¨ZœoË´×ÍvûÖ%µÜoØí;ììÙÃN:¸[0mD‹lÑ‚%òĞ+T]®®=¦ØU»wÿ¢\Z2§íœ´â©ã‡lÿînÑ\\Å;ÁBéö…’ÛíõË›’-jìHO—Æ<¡Fèş}ÛlÃŞÜ˜j3gMÓ9smó–’+w¥Ÿ¥±/S¸]vìè.Û½{£mŞ¼ZµÌ$7ÓmÚÔ	¶fÕBUõ¬éñUéñÃ\n»İöí]/ WK-³)“ÇØø	cmâ¤±JËt»\"­şD\r½+\n{ñüÀm¶ïFÛ¾}•Í™=ÉFD\nTÍ6ŞŸØ­û»lW$i.\\<¨g±CµÂ:ÿü3$U†ÚÆ¡6Z\rñ}{7Ûï¨½n×ıİm$İ¦¶ËBP7Pµæ 2d°­\\5_\rÄ«®qéŒÂ”†Öù»v®¶…‹gÚ@…é^3Äªú±Ê>õ²ÁVŞk•tëo«j¬˜ee_ëRÕ×:W÷·NİX§êVYv¨ìoå}­°¼Ÿµ¯¨Õzå•õu³ÜÒjË)®\n¬Dë!Ë+ífù„+ínÙÅÕ–Õ¥Ò2»VY–Ö³Ëº[–·«èaùå=¬]iok_ÕßŠzÔZÿ‘#lûÁ]vûá÷ŞâÏ¿û¥Øóõ»ßıÎ06˜Å„¦#2Aæø1Şô=\"¸¥eÌì:rä¨ƒı¨–Çöe\"Ğ7ˆó;®ıÇŞaArâ”¶åENñÚÎ9eôA|ÕnÜ¼l§Ï€Nœ<©ëQ\\Gş¬2ô²¿pÁnŞº¬°ö’À¸,Õ;uŞN8#NÙ‰Ó§ìÔ95à.q_a¿zõŒ<ıY€Óvê”\ZlgO(nÒJ¼Çİd¦K—.»şÖëW®ªxÕ.œSÃKä¤\Z_ÇO–é>Ôx;vü´›·p™è•óªÎ+~5ÔÆ‰ôè~AJa9ªkĞ½œ°ËWÎº÷á®),Ësç•¾“*|§Û±{íì95\nOÒ¹\'u½ãøŒİRƒôú­3vá’ìÜYâ“éÙU>Ó=»pF^û¼İ¹sYGÜË—ìÒe54Ï(\'öëY³ıû•W‡NÈ›ŸÑ³;a·ï·Òá¢?-§qê¬®­<=vÀvªİ²mÏ>Û¼sŸmØºÇ6nÛk›¶ïµµ›vÚêÛmãöİn}íæ¶~ËN[·y‡¶·ÛšÛ´Ü¡0ÛlÙš¶rİ·¾|İ&[¼j½-\\¹V¶Æ­Z+[÷©­Ø`‹Wl´…ËÖÛ¼%kmÎ¢U6sÁ\n›¥åœ¥klÖ’Õ6wù*›»d™-X¾ÁÖmSZéÙ1äşğ¶=zúĞ\r}÷Í/ì÷¿ÿ½c‹ú‡øÃØ`x“k‡rËÃ‡h¹WÕo$ïsû>jö’q¶O°aGÎ=â =rø„< ÈŸ”×ƒ¨Êl2çÂ¥svî\"™|VqÖsP‰=pè€íÙ»WçáEe}¢ç)yV\0]È×íøáó.Ì’£§„`9y^\0\\<£‚ÂóÜApÜ;j¶Ã* ®“\'ı9eê™sòØŠïì]ë”Ò\'ØO¨€?,ˆuÒ{äøÅsAR…ç¬ VÜgÏ©Ë»Ä‡ğ|ğ¢gÈçÎËû]V:UxÎ(\rçT\0NªÕıD\'N´Ó:ÿ´®}Z×>uFqª–9¯ZçÂehÎÓuÎU!ì§/œ³SçÏkyŞ.ÓC#pIi¸\0˜¯ÙIò¬îéô1W¨Ï½¢{»ªMÇOÚÅÇí¼\nŞÙ3—ÔÀ¾bgNjI:T°?hGN©ÀÊR¡:zì´®yÖ9©g¥kë¹°RÁ8©gy\\öØÑÃZÇ9á´˜ƒ}THNOÛÇôÌW!•Ğs>q\ng£x½é9;ª}Gô\\©süœŒ®yğ”çÁkûˆÎ?rü„½pİî=ziM/ŞÙ“çÏµd`‹>ıöÅÛöOÿôO],ê¿ı·ÿfØÿïÿİşşïÿŞşãüŸ±¿ûÌ¾Àşîï>·ÿ?µ²ÿhÿé?ı§ö÷¡õˆùp÷w\\‹}¤EËaÿ¾y¿ÿCq`\nÏ±iú˜®pø NWÄšã„Ñsù{ññÖ|ŒkîŞÜ’8‚sƒı‘8]øVÏGöé}ı}‹{k>¿…±p¡¸İ9Á~Np2–l‡I‹ûna‘´»ûm½î·>çÌÅJS‹íáşşïÿ³ı—ÿò_dÿÕ-ÿóùÏÎü>˜\røıoöÿTödx\0\0\0\0IEND®B`‚'),(22,0,'ÿØÿà\0JFIF\0\0\0\0\0\0ÿÛ\0„\0	\r\r( %!1!&)7.5.383-7(/.+\n\n\n\r\r+%---++-++-.-+-----+87-/+-+++++++-++----+-7++-7+-++7ÿÀ\0\0á\0á\"\0ÿÄ\0\0\0\0\0\0\0\0\0\0\0\0\0\0ÿÄ\0O\0\0\n\0\0\0\0\0!15as³\"AQt”±²Ò%4RTUq“Ñ#$3Br„‘¡Ó2bc’ÂáğCD‚ÁÃÿÄ\0\0\0\0\0\0\0\0\0\0\0\0\0\0ÿÄ\0\Z\0\0\0\0\0\0\0\0\0\0\0\0!1ÿÚ\0\0\0?\0œ@\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0›H_S¡NUjÉBœSm¿£8_Áÿ\0é#é«­)¢´uL»ZÒ¸­^	ã¶F=uMãõ[ÕÏĞ€úªp·£iV”ñ±¸Q«5Ÿ´ âş¦t|.èßWÍëÿ\0LŞ-(BŒ)Æ0„RQ„Œb–ä’Ø‘ìøİÑ¿\Z¯›Ööã{FüjŞo[Ø7ğøŞÑ¿\Z·›ÖöãwGxëy½o`ßÀ\ZãwGøëy½oéœ®ôøŞo_úfı‘¬€ĞŸz9,·Y~Õ\n°YñkN*+ëx6İ¦è]ÒUmæ§™_­îÊñxšØü\rŸtğÓO\r==©¢;ĞÖ³ì†µu©m^Î×iÊtå:“„ãø\"åÏåŒ&\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0AaojR¼°©F¥J5cJãV¥ºsYíiâQi­›	Ü€xÈü&Ë£¯é¦kİnùÆ÷Îë{Cºİ!ó÷ÖöŒ03İnùÆ÷Îë{Cºİ!óïÖöŒ1ëBªsçîú@Êw[¤>q½óºŞÑÏuºCçß;­íSÚu–¢6ìÛôgo×Ÿä€ÊwY¤>p½óºŞĞ]•éœ/|î·´arv@f{ª¿ùÂ÷Îë{D…À]ıjúR¬ëÖ«^jÙEN½IU’ŠuS“oös‘)(ñ}å*¾N½p,h\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0ñøU—E[ÓLŸˆŒ‡Â¬ú\ZŞ˜œW«:fÇ\r&êÏ\r¬¤ûTğÚğí,ßk«‡ùz9ÊÃvùÂÃÊŞ¼8şÄ)Ğ.4ã=dÕjJ:òm:9Ì6b)ø\ZÛ·nóë¡(¨¥)BrÛ™($·¼,%àX_P»#%Ô×§ıßòÿ\0±Î½?îÿ\0—ı€¥G)—>âQp’ƒ„fÓQ”£²/Ç»Àcoh×’©Úî)Qn£OVœd£-hº“ïé½­k$¶­«b{@¨ˆ”8¿?|êù:õÑ­p©ËWû¿MÛ¿Edâÿ\0Êu<Ÿıh \0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0Wî2ó»>†¯¦+ïÿ\0…Ùô5}0Ià·–¬:gÕÈ³edà·–¬:gÕÈ³Kş}U6rq%nu±œ‚’àã;6=‡! W,4·çÅàç|Ç`háK–¯ºXuP6N/ü©?&~²5Î%5zöl­\rûWè l\\\0KßióÛMìØ¿·Èæè²@\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0}ãğ»>†¯¦‚+÷…Ùô5}0Hà·–¬:gÕÈ³Eeà·–¬:gÕÈ²õ¦ã	I,¸ÂRKÆÒÊEU6qˆ9ºjpu\"³*jiÎ+Æãœ¤\'qÊ0”á\Z“şÄ%4§/Ù‹yQÚÙS§¢ôMì#}+Û\ZÕ.]º´î«(×Œç¾JJm4öw«Ä’¤˜nÛİ4*Õ§¤ÔŞ«\ZpŒ¢ãúG\Z8×Ö¦°œšxyÆë1%œk¬êåk$›V²Oshø©ÊáÜÅÆT%£ªjy“¸•ËT²»ÇMÃo&BXR£¦o£Fš§ØYÔ’{ê’­[2míËÂl²¼¤²ZI­:‘M?Ú{GXİ˜İƒMì›@ÙÕ¹µµVvÑ©wV­{ªÑ·¦ªûš\'Q)¥¬¥Rr„\\³œJFå¤’I$’I%„’Ü’ğ +G\n|µ}ÒÃª°ñåiy,ıx\Z÷\n|µ}ÒÃª°q~üKÈêu”ÈtYP\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0¿q‘ø]ŸCWÓÀ•ÿ\0ŒÂ¬º\Z¾˜£ğ[ËV3êäY´VNyjÃ¦}\\‹6ŠªlÖìûP•û¢´ì­nÅµ”¡\nurÜ¨–´á&ã»f×ƒµ×bÒ’¹§JòµK¹Õz¥NmJ§é»UI,ÓSÛ•‡†Ş1“îZs&Ô›m8Çc(¸¬%«ù¼,o~ÑßğLuã>ÙSZ:˜yİXê¬÷¸İŸ¡ÊXÆ³7æŒp¯\n­R6Ôí#m=¥8µ«W/n²ŠQú<&2Ï±šÔî½Õ-#Z¥YF•:ªVÔ\"«Q§\'%MêÇ½]ô¶Çi™µ³P”¥–Ü³½%¾¤çàß¶m,îIsçÎZ29n3©IÉ·%JJ\nMÉÉåc~×·8\'¢S½…ãœµ¡i;hÓÂÕÄêªyßõ#\"cŠÛ•qpŸI›p·mK?~wX¬Ü)òÕ÷Kª€Y~GW¬¦`8Så«î–Tÿ\0şY~G[¬¦stYp\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0ã%ğ«.†·­ 2_\n²èkz`Áo-XtÏ«‘fŠÍÁo-XtÏ«‘fQUMœ˜ûËšñ)Ñí”Ôsœá·†õVİıä–íõióŸxE%ı|eÚË9Øµšxk+õqÍµø6ã+>Ö×Ue=IĞpíŠzÑ{·l^?ù´û@€\0¬ü)òÕ÷KªÁÅÿ\0–_‘Öë)šÿ\0\n|µ}ÒÃªŸàûóû¥o^™ÍÑeÀ\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0ŒŸÂlz\ZŞ´	ø€8É|*Ë¢­é€\Z?¼µaÓ>®E™+/¼µaÓ>®EšEU6À~ìx‚).AÂy9†u–wnİ·›Ãs¹ÖK)­«cÚ·®tgáS–¯ºXuP3œ?~W“Uõ `¸RÏá›ìïí°çÿ\0¥;À\"÷æ>MWÖÍÑfÀ\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0Œ’üêË¢­é?ùÍ“ÿ\0ºêşğ4nyjÃ¦}\\‹4V^yjÃ¦}\\‹4yÊªlâRI6ö(¦Ûñ$²Ï(]E¶’Ro\rk%Œã?J;Õ[\ZÆ²i¦¼iìhñ¥B9Ì„“ï¶ÊZÙÃk¾~-»ö\ZÎ>–x×¸Œ1¬ÿ\0´¶wğïÚ’ñ¯èÉÄàıoüg(ú¯h!Û\'jyÕğâq–ü}|ç}ÏvıíìIãÇõ,š+?\nœµ}ÒÃªà–W’Võ `¸Tå«î–T÷şYıÒ·­šÖ`\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0€¸É|\"Çö.?ùéñ’_–±İ¸ôR¶¹9Æ¥)ÎH¼Ætäá8¿\Z’ÚŒ’ì¢ın¿¼Kšê¯´b\0~êoş_yçU}£î¡¥ôŒ¢¥øFígjüê³ÿ\0Q­ÿ\0±ÍjxJRT{ÜÊpÃs„s˜J/tŸ‡ÂlFÈÅ½#¤7~»Ï”WûÎ³ÒšA\'ï•æçÿ\0sYzdm}ĞßCHFÚ•íJ4j\\ö—Jƒïc=ğ×rqO/sÚl¼5SÅ\ZZR]º¢NRrÿ\0¥ÎWL³Póì¦ÿ\0å÷uWÚÔßü¾óÎªûF!‚\Zõ¹¸IÊ¥YÎ­I<Êu$ç9=Ùr{Y#q~åŸÜëzğ#RIà–?t­ëÓÌ\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0?ùK\'Óz´Éàƒ8ÆÓr–^kú´ÀƒÁïîIüWü‡¸çñšÀİ»®é½xïVøÏ‹5 ²jäŸÅşhÚ;¾ùJ}²2¢éÊ³µµ™FYÖÃø¾#kô|WõghËò‘©ˆÎ[[L“¸Nªç£ì%\'™JzÍóÊŞ-¯âÚ4qM\\Â¼b£TSíršmìK\ZÉ.›ì«²ÈŞP¡ERT•Ú}¹TÖïqUÅìd±°zû–œû–œÚò$/ü°ü’·YLıÍ?ŠÉ#€*n:aåcó:ØûJ@Y@\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0)á×AÔ«FÕ(¹ªŸmQYjœÒÌñÌáóI½É’±ÖpMa¬¯Æ¢9×-Ï`Ú6¤œçco)ÉåÊT`Û|í­§—âûEü‚Ûìa÷\Z+±±ö.í#J´®gjêNQ§NÕ:Òt£úÕõ©Åüm[Üv´–%>÷£>Amö0ûW`Z3ä6ÿ\0c¸ÁiÛË4ìéÓ	F¼œjÓ›­\ZİµÆowkÔÔšQğk)f[ğ•¡G¾q«—ß8ÅBK/nì/‡ÃÍ¶Íw	£~Coö0û{†Ñß\"·û(}ÆgwSç»ª±¬5‹QÜ>ù·ØSöGpú7ä6ßaOÙ5JªæJ¼h\Z²ºô¢ão\Z2¥NRXUe)EÉÇÆ–ªYİ™s2U`ú54Õ¶SÊ}¦q¡F0ŠŒ\"£¹ =\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0ÿÙ'),(23,0,'ÿØÿà\0JFIF\0\0\0\0\0\0ÿÛ\0„\0	( \Z%!1!&)+...383,7(-.+\n\n\n\r\r-+++-7--+88+7++-4-+-+8--7+7-0457877-7,++775-.7.7-48ÿÀ\0\0á\0á\"\0ÿÄ\0\0\0\0\0\0\0\0\0\0\0\0\0\0ÿÄ\0M\0\n\0\0\0\0\0!1AQaqr³\"$5RSÑÒ#Tst‘’“234bc”¡¢£±²ğ%CUƒDÁñÿÄ\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0ÿÄ\0\Z\0\0\0\0\0\0\0\0\0\0\0\0!QÿÚ\0\0\0?\0¼@\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\01âkÆœe9ÉF1W”¤ì’çl€„TÖ¾‰MÅbe+;^+É>©(Y}]ék>¬.\'Ø.Q7#ßWFùøÕ1À÷ÓÑÜø—Õ„Ä{#Ü‡­,6/èÁâ=“ç¾–ÌÆ~§_Ù\'\0ƒûèà½7õ:şÉñëKèq¿ªVõu\\áMÕÃÍÊ1“„Ô“Œ¡5¾2‹Î/¡©\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0…k’£ˆÆ´íàÁ}«¿ØÚ&¤]>GÆõSïé[pDG^	=˜4ÛÙß³·e×kx_è¿½«í6ˆÒ¡(T„œe8ÉoL™GYÏI»§ê5Qe.`½ñ*ûG%Á ıúÑ[-bã=*ûº~£’Ö/Òÿ\0Ÿ²LU’¸+ƒôíÔökƒO@¾Ôıejµ‹ô¿Ã§ìœ×q~—÷)û#“ÿ\0má=~¹zÈ—´=*Té-½¤ãv÷[5~¼şƒ§\\:Åz_Ü§ìf“ÓUqR©7&²W²It%’Mª‡ğÚK¦TëâR¿^H±ÊÛT¯á´]è²E\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0ƒë§ÈøŞª}ı2pAõÓä|oU>ş˜}7’êFh3^åÔŒÑ4ı†ãggnÛíÌºoc»á/e„²’Ùv‹kiI8É´šk–êÖşÜw\r]ÂJQŞ¹÷4òi†”Óqã$Şë¹JRnÛ®ß\"¾à2h|\Z«&›v‚WK{mäºLÙÒxKeÆöm¦›½¯“æ:Ü.T¥µf­$÷5ôrô™ñ˜ùUjé%Ù+òïmò²‚‘’5Ó2EOõDşHõĞî‹,¬µ<şHõĞî‹4•@\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0ƒë§ÈøŞª}ı2pAõÓä|oU>ş˜N*)%•óŞ÷¼Şób,ØàÖ±8jU¥\n“Œf í)G•Eó–Õ^è÷oÆ«»xU\Z¶v»ğ·ršES£))Õ§:pR’¼ë;S‚Y·>Œ·rîå\'¥€´ï\"åî]‰Qp“¥FRRÄñr´IÎÛ	ÛÀŠmÙŞA_hû_Ü¸ßÁRücå“[?…¿+Û™®£yjÇGy•¾údÕA0ØŠTâêá(IS§9ºtèÆU*Ô•Fá{­•l&¹Ş{£K`éRpT±\n¶ÒnVQ[¬Ìy´×&Ï3Lµ¬´›[ï¦q¯«­Ên­¹;U¨İ’¾IocEB¤dƒ,Ü/4}Gháñ6J\r·VJÒšOfÍŞé5w»“‘®`¨R\"„jRÚq©\'\'´ªÎ»ì¢ê$ú›ün’ë¡İyWjgñºK®‡tZ$ª\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0#]HÆöi÷ÔÉ¹×7’1½˜wĞà_åØÚøz{ºÏ@q²ó¥ö™çŞ¿Àü½?æ_Ëûë7¬œl¼é}¦|ãgçKí3ˆ*9ñÒó¥ö™ó—/­œ\Z>É×–KnYîğeg­	¿uQ»oÅÖ÷úZ…“nR³Ö‹ñª?7{P‹¶¥¿¤{T{¢Ò*½I¿Hö¨÷HµÖ€\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0„ë›ÉŞÌ;Øb®o$c{0ï`7Àwãø—èy÷€şPÀü¼ïåÅVØü>.{óöÏí±¶kKaëN¥*UéT/ÆBMÃ=—tºUºò2aqôªÊ¤iÕ§7I¥QSœeÅ¹^ÊVÜòS\"Ú20Kƒ¼M­ÄTQ· ÷sú8ÅJı6å;-EG¥#(¥î,£’nNE–ò£·Çc©Qİj´éÇÎ©8Å_™_{è8é\r%G:õ©ÒŒ£*³QNV½“|§MÃZqz3ìå±A¸Ê¤[”wgá-¤ş¦v\ZcFU«S\r:UaNxwRKŒ¤êßn—}…8îRçå@n`qtêÂ5hÔ…HNû3§%(ÊÒqvk}škè+}j?\Z£óx÷ÕIßô”±I¨)Æ¥ZSâÛpœ©U•78_=—³~ÙØ€ëYøİ›G¾ªJ±ÜjGğônt‹TªuøZG·KºE¬f´\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\'\\¾HÆöcŞÀ›sy#Ù{\0)¿óËÀô\Z<õÀWşa€ùx„–çÕÎ×íY£lÖBá¨ÎuiP„\'RûRŠ{¥-©(¦íå›Q²o3ƒ˜J3U)aá	Æö”\\î®œ^÷ÌÚ9ûµ­Ç»çç“{6ËsµŸ]¿:WÌğõ/\'Æ^ûVW¨–v²²–KJÉ¬Û*>i-C¢«ÒEì©me{_s\\Ëê5êğs	(B›ÃÃf–×g$à¦ï4¦ÒMïW³6½Ï7RIŞ.2R•ÖÌbíkİ©6·x[ŒRÃbşBß|©Ç£%lí¾ùçĞŞ\np:pŒ!£Á$£È’*ıl?£óh÷ÕK;		¨Ú¤Ôİ÷¤–V[Òé»êkšî¯ÖÓñº6}T‹Ö£…¤{t»¤ZåM¨¯ÂÒ=º=Ùl™­\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0×7’1˜÷°&ä\\şHÆvaŞÀ\nW€¾QÀ|¼Cwà/”p/Ñ	f†…l%g)J8˜¶¶bé§²­š½ó{ViåeuËs||°ØœíŠK,¾›Ïÿ\0{ù×‚v\0\0*mn¿¡óh÷ÕK]Ë›ÿ\0ˆ©µ½ùe›G¾ªJ±İê!øZG·G»-²£Ô;ğ´jv[†k@\0€\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0AõÑäŒgfì	Á×G’1Pï`\'Ào(àWéàz)sà,­¤p\rüb¢Í³\\”¾îXš¶óWHJVŠ\\eœZø%QçËw×Ö¹O¸¨4Ô’ÚğvââÒØWÊYÛjÿ\0X)\\äé³…²—J|ÿ\0újÿ\0Y¯‚ƒRÍ[\'şHórÊ¤—ì4×7ĞTšß—Pù¬{ê¥³RÙ~k¿/3EI®/Ë(|Ú=õPG{¨W‘íÒîËt¨u¿Hö©C-ã5 \0@\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0 ÚêòF/ªô	É×_’1}TûèFğ7\nxüJ“Œ!N´e9M¥Eom½È½ôuíÿ\0PÂåúz~³Î\'ÔÍ£Ñ¯†Z?“Háüôıgğ¿G7´ô†ö·å÷_¬ó²fzpImJù»F1ÉÊÛÛm;.MÎîüÁ/OB®hï÷\'GŒRõŸgÃ-şã„ıb—¬óô©§t£(J)½™;İ%wl“NÙôÿ\0<	„½øa£ù4†§Æ)núÊÇZzN†#Ft+S«áã*SŒÒ—Uì·¾Í;t¢s’a¬[zß¤{T¡–ùOê~‘íQş†\\j€\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0×g’1ñ÷Ğ\'D#\\ôe-‹QM´ ì¹£R2oèIç*uZ¾Qwó¡4sX—æÓûª~£YMs£’kœÛ9/ó[4óæ§õYiË*sJüMö’v·„çrÙ^[ÿ\07¥\ZJ]&HT³º“Mnqvk© —‹vŒ£u8©lQVÚ“W“ÍÆ9e{»Y_,Ì4ªÙ[f/µßÖc©]Ë9NR¶í©7n«œv8úÚXÌ§öuï–ÌTRh×Lú¤æ-ïğÿ\0¿Hö¨ÿ\0L‹„§¿Ãêò„¹é¤ùŒs_µ	šĞ\0 \0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0*ÒRN2I©+4ùQÌ­«&äğp»wvm,ù’ÉıêôOÅÛŸ¬ší1	z©Ñ?ıùúÏõ\Z\'â¿Ä©ë&àm1÷¦Ñ?{SÖ|÷¥Ñ?—ßUö‰ÈLA}é4OÅ§÷õ½£ç½ˆø´şş·´NÀÑ×h-	‡ÁÓTpô” ¹/[ş÷¾s±\0€\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0ÿÙ'),(26,0,'ÿØÿà\0JFIF\0\0\0\0\0\0ÿÛ\0„\0	\r\r\r\r\r\r\r\r\r\r\r( \Z%!1!%)+...#383,7(-:+\n\n\n\r\Z7%5-77+++++8++77-7--718--++8-++7+08++7++++87+.7+2++.ÿÀ\0ôô\"\0ÿÄ\0\0\0\0\0\0\0\0\0\0\0\0\0\0ÿÄ\0L\0	\0\0\0r46\"1235st‚²³!AQq±Rbƒ$BSa‘’Â#Ec¢¡%&CDu„”ÁÑÿÄ\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0ÿÄ\0\Z\0\0\0\0\0\0\0\0\0\0\0\01!ÿÚ\0\0\0?\0Ş \0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0.{X˜¹Q•\\qcWLõWru|\r\\‹—ğ¡é6Y\Z:º•µ\rIıĞ¢,’—k9j²£”æ½&™ÕZIQ4Ê«#õUÎÍÆtSŞ½ş‘à¥Îñì	¹jZ‡9â¤¢¹\0éè4ºÅŸ£¬bøÚ¿Ü}ñÛó\'ÿ\0¢œ¬yèÊ™ãö±îoÉ@ê´¯¤w%C?‹°=Ù#Ìz/ÉNX‚Şµ`èm\n†ü¥RáO¦¶ì\nŠ–ƒ—2#Àé h\Z{Õ·â÷ÂïœEÚ÷ëSh³âvW¹ n€jº{ß§^Î†T.0^Åˆş’	ØÃOxú77-b³;¸Á¥ú??2ÖƒËõş†+^Ï›¡­ùejÿ\0ö}l•LZ¸ ‚1@€\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0ó›¢vW%/³tNÊâÆ }fÒ¹Tæk{®ê?/ÊtÍ™µ.U9ŞëÚËòœ\\ıIhÏQU]\nJ+c‰æğ7\nĞÒÌ˜MKÓàèÑÆº¹§¬ï,ôÍ¡\Z™´ZÁ¨éìjEü”ioïtVn[%È÷°ÊÑ	À£¨º\Z“˜•1å˜À´òï]£}¦‚wMKÈı~–#}*îœ±¢6u”k*G©ì%¡	@+ÖR¤züO0Ğ“½9§´Vd=LŒù9Z|@‚ŸLmênÔ¨O\Z—H/+Hâå¬Ggae@l:{Ù·ÒÅNâçğÔ\'OfF¹^¦©#7L½@í¢Î•¹\\\\à½-—¤áãù°Ğ˜’ŠGÁ§z7?6ÓbfEiq§Ò£¡´é×óæh\"wanzüÕsŠñ/fdVÔ±ÔÁ/E3•È§±ÊÑUÏ2g\'ÉOº\r!µ©úBvü¤P:lëi<–œ«˜Ù÷s¦®Ò&¾\näFÔÄ˜ö;\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0ç7Dì®,j_\'è]•Å@úlÍ©r©ÌÖ÷_Tx<§LY›W…Ng·ºş£Áåj\\‡TVw˜ı3hÆjÛêšŞó¦mÔˆöBJQIÄ ¦?¦Û§h÷I|¥ıTÇôÛtíé(Ó!æz8 *¦¸ô<JÑ@ôBø4f©,ëªú<ÏV7Å‰µe;©fÕ_zb‡ˆIôÇA;ãG{ŠbÔ_{O•QZªŠ˜*#‘ˆ¡SO$=bİ…—ŠSÉ$©g\r#Ì½Ñ2DÁìk³&±aĞÏ³û³L‰-ÓØ–\\ı=™JìĞ´¶ÔhNOÏ±iü¬ò™P­%yZKaDÊ›) {ø7Åû7-ĞoŒ}ŒÆ}{›™/o€]ùÇØÌú\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0ç?@ü®,j_\'è]•ÅŒ¢ÌÚ¼*s=¿×õ)ÓfÕáS™­î½¨ğy@Ì.ŸIiìzéií¤qTê«$^jLÓvÁ*=¨¬Tr/\"µuRÄöŠªxzŞÌ¯VÕÈõ\'\\åØ4†Ùƒ¡µjÙòÅÂ7Òhy-ºŸõ€éyéõ\\tÚ!^³.êwD£ø­4üW‘¥Lÿ\0RGç‰…ªŞÒ‹ZßVÿ\0‰Õ«ÚÏkXˆŒbxZÅX”€B´)B +E2j-0-K:f5bd¼#$ıtılX m¡Xµ³£•0F¦ª1BXëb’®\neTFºˆ¿‡î˜İd­šªGµ0G9Ê‡ÎTI4ÖyÜïÕêH\0¬ˆzGÊy•°’ĞÎ³û³L^ïeGèmŸİÚ†LŠd(Ä…P0‹İÜ¹{x\r{téc1ŸŞöåËÛÀkûŸßHû€ß \0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0<çè]•ÅŒ¾OĞ?+‹M™µxTæM ëêŸÊò9fíK•NcÒ¿©ü¯L€§¤*¸OŠŠçV’-ª}s\Z­JîWÇÂÿ\0à°ÍI£U/V¾’î×tx,,ç5®s“š5â1:-tcD\'…²-•@¬‘pkÑ­W2è‡ÎÅrY‘fgÏ ßºí—’\n†äO’[¢Ñÿ\0uEk<mwö¤±$Ü¹Ë9zf¡3D×—7ûu<p«\nŒûµ¡µi™Óä}Ói9$£ÊUBL½÷e¥Lä£‰ù\'iòK ZU-‹*äV¸l”/è¦‘CÏ±+?„*ãã–Ê´¡é¬ê–fÍşĞ>2¢]ÙÏc›™ªÓÏY¿´*BŒI0Ğİ<¯Ñˆ]\n@•ê¸¤n]WFïÂã3‚ø©¥±¦L’¡§QJ‘@İÑŞİˆ½%%[>i‰ö2ô´eü³Ô34&‡E±/\'N(íê6RÙZË=²Ë+ç÷Ò>Æc3{ ßX»€ßÀ\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0<§è•ÅŒ¾ÏĞ?+‹ôÙ›W…NdÒ¿©ü¯Lé»3jğ©ÌšE¼?•énR’J@Ü—?Júİ«•5ùñoÍd3_ğG¦H­á\\åcâå‡VVêñWıç˜uÊH©£UõŞ›\r„“»ğk~½Ô-íŠ®×’G+Ñ]¯k•¾ımWû1Q5“X´5LE§{ª$sµ¢Mfµ¸ë9ªºÈÖ»ì•û¨O¿t–\n:µH­:»µuuÚØZÖ£÷µµ½§Á›ZÈ5¢bÇQö)ñlˆïóš×#ÕßÓµ=¥ë‡ü#‡O‚h±iík•jRT‹RMV¾^¬n³x&ó—œ|T¾IRÌU0ò*áÙñPªÁO\nÏˆá÷\" F»~òŠ|P:ËñR	üäG|ÓXù¥³è&é¨iİš»ûO¨j—Flº[!§ÆıÑyylJtË‹L„¨FK·ÑGòYîfIŞZgĞ\rûzS%dÌ¨zbØR}i\rˆ†1`Ù6ÛÖ{z™ÒÄ÷pGÒ$.Öö¬bS]æ‹¾y!§·äûDhìa×Ò\Z­Ştv<ì¶*ç¨¥z;í¬nz#±ÜÕl­o3UÎö)¢ĞJY¥hg=¾±v3˜*)œÜîúÇØÌTt\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0)úåqc/³ô.ÊâÂÓfm~9—H·‚§òü§MY›_…NeÒ-àªü¿Lj”•)H–å÷n£¾»Óa°M{rûµQß]é°Ø(‚	\0\0A\0µºrcíPPèš÷¢¯*è\0H#ˆ#—â¤£İ÷”£|+ùQÊV’¿ïDríÃ?â*û SN¼ñDæ;ÊsÒÓ.¿+¼§4¨6¿áÃşFus{ëa1‚¢™ÕÎo¬}„Àt\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0)úåqb/³ôÊâÄÕfm^9H·‚«òı3¦ìÍ¯Â§1éğU~_”r”¥ nk–İºøïM¦Á5íËîÜıõŞ›\r€`„\0H ‚\0\0RùQDTå+)\\1_pG#“_`,héØò¤@œI)ÄzFÕUäÊ’·<çz£0Fk\"®\nz1¸507Dì®9¥N”“¢vWÖ(g—9¾±ö3&us{ëc0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0Ê~ù\\X‹ôıò¸±ôÙ»_…Ç0éğU~_”éÛ3kğ©Ì:E¼^(Õ •)qÜäI.ŒÏß]é°ØiŠ!¯î_vj;ë½6\nÿ\0æ*`z”•\0\0\0\0\0 \nŠ@\0¨j¢ò)KŒnT\0\0\0\0\0¨€ônÊãš”—£vWÖ™ÍÍo¤}„¦gW3¾Œì&€\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0òŸ ~W2ùQĞ?+‹\ZôY›_…NaÒ-àªù³Êtõ™µøTæ\r\"Ş\n¿›< [T…\n@å÷f~úïM†ÁC_\\¶ìÏß]é°Ø\0\n€\0\0\0\0\0\0\0\0A\rÄ\nüX\0TR\0¦^ß\'Ôt»ùù8æ•åP%îæwÑ„Æ†ys[êÎÂ`:\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0•G@ü®,Eö~ù\\X€úlÍ¯Âã—´ƒ¯êó3Êu\r™µø\\rí¿×õy™åŞ¥$©Hªåw^~úïM†Á5õÊn¼ıõŞ›\r„\0¨\0ESá·**©,z‰lø8jˆâs¢‹w	!¤´®ÛÓ)Ñ«mı¦–%^#‹K¸\rö~ï¤|º@é^®rÂìUİ£Š4æÌ¶-K±Øé;dW$Ëùz®#ÁHÀÔ_ÿ\0!x~ëUßü÷;ytÃGª¢†¾Ù¨YfLY5N•Ào€[ôv\nÊK\n–;NE}K!jLå]g,™‹€ª.%X)ƒŞn–Ï`RÅOfmu	¿9ĞÂaõ.XÔh¾Ğ›#e‘œ:Ë,yØà7@1íÒ4Ò[\r&z#gx)ÚŸ´ø·æY/K*ì¹b¡±v¹‘ªç¢k>6»šüJLğ\Zv±4óDYemcä‰U©#7Ú#ùJÓiX¬å‘\rU:`’·ÚßÙÉÍrRÍ.\0»˜ï“gw9~gL»š¿#™_Ï_›€”S=¹õga)€¡°._}İå\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0ò¨è•Åˆ¾ÔtÊâÄÓfm‰•Ç-ÛÛÁW™S©,Í±2¸å«{¯êóGåáR•%J@İ·\'ºÓ÷×zl6¯nOu§ï®ôØl \0šÒü:¦ƒ¼Ëé›(Ö·ßÕVy—Ó\'»­È³ûz23»½È³»z20<§š:x$îFÇ]#×àÖ·YÆ«Ğ(dÒİ5ªµk“à\\bo¤™MëW­‡JÔ\\Tøé¿¹Âê¨R‹C w¾¥òÔ¯• eçÁdZ´VÍ\"ÍgN’Å®èõ°Vñš}å¾Äÿ\0ûı‰À}Ÿ^Nƒ†Öã«í|-{æŠ9}­†x#Ã²\\Û’ÄÙØæJ˜¶Ds\\Ÿ»ŠãRQñ/ºNó/ü©¼ŞrjkzÒ[ö…\'àô¦Õ&ÎÂÕ¾I\\şHfSò£ÕiåvŞÛÆ¯^ùëhOö+Óÿ\0Põ­‘¤”¯ÑêØ^˜£é¥ş¦·Y¦rµk-‹Wº*†È6™õj¢QL«ÈËåq¬î;£´»pIÆÔBP¤©\nˆ^jüdw=ß76¼ÕùÆş‘s8	C`Ü®ù§w”×Èg÷+¾mîòĞ\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0<ª:åqbRûQĞ?+‹ôÙ›beqËVöğUæo”ê[7kğ¸å›{x*ó7ÊÀ¤\0İ—\'ºÓ÷×zl6¯nKugï®ôØl \0\0Š¦µ¿« ïúfS§6E£mXi\rP‘J“Ç&²Ê±q[­úÍ5Ô÷e¥•[M¡O&z‡¼+bİÒ*è=Ø;Ôqšzít²n¤,k}ÉQ!¸B5uøÏ„|}¼¦y¢°ğ\Z1@Ï…›Ljñô6ÑÒšºwĞÔSÆØa|j’ªóœã3¡…i¨¢pUŠã_ZĞ=†È²h¬jNÍ\"‰^é5qWqœ}ä¨4ãşï^u5kú)	×Ò”Úv…£OgÙrÕË\"pQEÂ£ÿ\0Uÿ\0wWæ[tÇF)´¢ÌH§zÇ,k­ß³w÷5MxË±ÒYU°UZ¥#?İ|­L±}—/Fùj«ëeìS´sµŞxZM½Ôš£‹CÛ\"¿ı¹Û‡œÙV‘KaÙqRĞ¢£#÷¯:G~³œ[4ÏDéô¦‰¨¯àj!èfó#ˆKëßM­&Y:/W+ÕÏ…ĞÅøä{uZc·9@´º7,Ê›MG³³af£»^yãm±k1iâäF=ò»À×{\Zm\n:h(©c†•ˆÈ¢kccSÜÖ‚½ÊˆBJˆ^EùÇ\'HìÎ:uyæ7ô®Ìï0†Â¹MóNï)¯PØw)¾Iİå~€\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0ò¨è•Å‰KíO@üú%è³6ÄÊã–mî¿«Ìß)ÔÖfØ™\\rÅ»×Õy›åá(%Hw\\êÏßdôØl3^\\êOßdôØl0 \0€Io®©«¦©‰Q!Xd¨‚\r_oºîÕÅ®äö|>ŞEŸiUUO»bHªÛRè=‹­íVëıìZìO­Z¹h¨±–	jV¥+Ú¼pZŞÆµÎN_Ÿ\"8ğ-n´ß-ƒE:5$)‘ˆ¼f¤’ÈÖxššÇÉYiUSYµ’²8ßK4°«ø\rfÔIª×EÅÖâc¬Ü@¿x?†lU\r†N*½QWG÷µıRÓö‹B¦É§’\ZŞY•±7ZæI­#µ_ÆæµXİp/¥\'ÍiW²‚=g±ïElª˜{ÜÆëa™O&ZÔ¯\\ån+‚*¢êüÜîF·[Ùíî ·EmS=ÎGë55ÚÖcµ•º¬v³›«Ån´­=jÒI\"1r«‚\"1«\'”´’Ù±¤¯{^Ø˜øš×«¸µík±wá>Êj¨jqàUWj®)«†°åD! Jò)ÌRôÎÌï1Ó§2MÓ?3¼ÀR†Ã¹]ñNí)¯l;”ßı¼ oÀ\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0Uò¸±)}¨è•Åˆ¢ÌÛ+W·:ú¯3|§SÙ›beqÊöç^Õfo”€‚T€7}Èn¤ıúOM†Ä5åÇîœıúOM†Ã\0A -³Ò×¾×d}:ÅEÑÚÌs¸¯wœí_b ¦ŠÊ¨¤™ª“ÆæÓ¶t¦Ebû8Wk›Æãa«‡°¦šÌ­‚ËlQJåcÜ¨ç@¯oÎw5Ïç#œ^\0ÉlJE£Háj2V²&²mDt©Á9®b»ïq˜ÒŸğÊ¤§‘Œ´eY×€G5úü^#u¸¸5¸\'µK¨ÛUdG-ÃJô§×lq¾FÆ’H[ÅÕs¹]‹OVÑ«’f\\´ïtˆ­bDÕÿ\0-Ìjj·šÔk°óVR2­\"Gª§4s&ı_vSáÀ¥U1W#Xèİ®Æ¹Ïkœ÷s¿UÉ®îBî@ÆYD^\Z¢IäÁ\\¸7ö_w²iJX´é\nFT%l˜#Şo55µqş<¥Ìi[™ìD|Ó;÷ª·šØÚÆ§7î·æ}”ËLÙUØkK4“9\ZºÍMoqô€$P	9nùİæ:`æyºwçw˜\nPØw)½ËİdúšñØw)½Ëİdú¾€\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0yTôÈï¡bRûS³¿#¾……@ú,Í±2¸åko¯j³7ÊuM™¶&W­nuíVvğ©I% oİ9ûô›\rˆk»İ9ûô›\r†€\0\0\0\0\0•Õ´¨ÜV¦,5$“tèÙÅzå@>ŒIÄğ¨©†–’wj±]qüOsZßù9§¶\n\0©F»qDÖLW‘1å°\0\0%\n¥\n	9šm¢NÒO1ÓHs$ûD™äóJä÷µİÖO©®ĞØw)½Ëİ¥}€\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0ò©Ùß‘ßBÂ¥ú§f“#¼¥…@ú,Í±2¸åKs¯jóSfm‰•Ç*Û}{Wœˆ¥J”€7Çî”½úOM†Ã5åÇn”½úOM†Ã\0\0\0 	\0$Àj¬ºÕª™M\"±•N³Ûƒyhêf|¯vDÖaŸ\0²°§ÒZ/–©Ó¥CŞ•\rWÄ½Í’Ö±ìV¹ÎV;›ÈÄCÑ(§Zl*¬ê™dJŞ»î×C­.¯ÆÁíMh—0atÚ=S*Â¶/æ:ÏL^ıl)ÛÂğ­ş—5âUeØ5WS:ª«bHµô}GKÅsÇÕV¹¾Æ– \0\n‘\0”*B	@*C˜gÚ$Îÿ\01ÓèsFÕ/i\'˜Cb\\÷/v—êk¤6%Èïk»¬ŸP7à\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0*ùô,*_ªzäwĞ°¨ÖfØ™\\rµµ×µyÎ©³6ÄÊã•-¼ªÎÆ¤ \rãqÛ£/~—Óa°Í}qÛ£/~—Óa°À¤‚² ‚H\\Q@˜ª©P € \0‚0* \np%€\n‚P\n‘]©ÚåídóD‡.Õmrö²yœ(¦Æ¹\rîwu“êk„6-Èo‚÷i@ßÀ\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0<ª¶wäwĞ°©~©Ù¤Èï)`P=ìÍ±2¸åKc®ê³Wfm‰•Ç*[wUœŒ€ \réq»£/~—Óa°õi¯î7teïÒúl6¢(‹Š  ¨H*)\0\n€€\0\0\0 \0•ä\\\ncGaÆö¨*ë®µÚO\n‰\"5QqRYXåTNP=šrÅN×/k\'™ÇT0åj½²^ÚO3€„6%ÈoŠ÷iMt†Ä¸ıò^í(\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0Æ§f“#¼¥…KõNÍ&GyK€÷³6ÔÊã•-»ªÎuU—¶¦W©kõÕWjÊ@ \rçqÛ£/~—Óa±MuqÛ£/~—Óa±@\0\0’ !U“ÍñğÃ¤LQIP\0RT\0\0\0’ *…HG¸ò©‰ò±‹‡´©¼¨r½VÙ/m\'™ÇSÅîöâr½fÙ/lÿ\03€¡\r‹qÛâ½Ö_©®Ø÷¾+İeúĞ \0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0<jvi2;ÊXd;;ò;ècÊ½—¶¦W§kuÕWju]—¶¦W§jõÍWhÊA$¼n;u¥ï²yXlc]\\~èËß¥ôØlTP\0¨¤Œ=…±Ìj£ˆ…£Ór¢@	‡“fGJæá† U@\0\0\0\0\0\'¸…< ©i­Çÿ\0¨´ñ¤Xàª¸©Ëu»tİ´¾£¦ã`ºœ¾ã–«¶é»i}Gâ†Æ¸İó^í)®Mq›æ½ÚP:\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0NÍ&GyLuLŠ§f“#¼¦8à>‹+mL®9NÔëŠĞê»+nL®9RÔëzĞ˜€@Òã·B^ı/¦Ãaa‡!¯n;t%ïÒúl6?½	EÄ	bH\0\0Ha‡ $)O\nœ*3Û‰Q\Z©*˜¯Ä\nÁCÖ&/sZŸ]SÎ*ºYeÔ†¦\'¿u[\"9Ú¹B½Êq\0TÅù©éR	UQø¯»÷QäÈQ“¹øªëô1}¨rÍ~ß?m/¨ã©ãç!ËÛ|ı¼¾£€ğ6=Æo¢÷Y~¦¸65Åï‹»¤ŸP:\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0NË&GyLmÆIS²É‘ŞS\ZP>‹+nL®9RÓëjœçUÙ[reqÊv—[Tgç \07•Çî„½ú_M†ÃÅS”×·º÷é}6\Z¿Ì`5¾ }ÊI\n˜„_r€UF¦.TDø©ğOlĞÅ?öˆ±En»–V¶67ú¸Î<mâ–Õı!‘¹±SG&£]5¦Õzñ½œÖtóÃ‹[O$HåÕL\"Fó¸¿r%üDYˆeŠ¢ºµìrbjë5O9ä{ˆÄå<l®‚^õWë¼ûP¨S‰(8„1\n´UEBµr*Ø2TH«í—€cš÷f{¢‰îcú£ìÌÃŸŒ~VÍM[$ª¬´–6/#\\äñ;ièßÕÓVÔMødVµŸÒÖ Q$ `…HA(¤iÆC•í°¨íåõu<|äùœ±hu…Go/¨à¯\rq›æ½Ö_©®\rq{è½ÚP:\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0VË.GyLeLš§e“#¼¦0 }6NÜ™d9NÒëjŒî:²ÊÛ|.9NÑëZŒîæ\0¼î?t%ïÒúl6!¯.?t%ïÒúq›\0*r(*\0|•)<é\"TM‘œ\Z¬JÆ=ml¬Õ#ü2%éªjßš¡ÿ\0Úä>‰UYÈRÁ¸»\nRÁK©JÄb58¨…4lz#µñÃ÷í‘Uˆ¬ˆF\'›“dPy¡\"11r¢|Ê=n¨¶lÊm¢Ñ¦fišÒÙQ§:3KmS®EWùH2\'?T©«‰ƒT^~‹³’ªi2@§Á=ïXìÙìê·ÿ\0&lœO>R}\\=†¨ø»5Š9Ël÷µn¿ ¥¤Â¯Ş¯>g-ZaQÛËê8É\'¼*›’ĞHòBÓ|–G9ëŠ½\\å_‹œÆ¸½ò^í)®Ù¾.î²}@è0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\05;,™å1…2zšLò˜ÈE•¶ø\\r•£ÖµÜuu•¶xd9JÒëZŒîæ\0½.?t%ïÒúq›YzÑÀ«Ñ{!ÔÔ´0ÉŒ«6¼Š§ÙQ{:G7D”Ñeˆ\ròE*L}Ès„÷‰¥s\'[=™Œ-u\ZMoUmÅ[şs8 |¬‰1•ìfgj–ú‹~Æ¥Ú-ZV|æiËÒÔO7¶iŞìÎW`t…Fè¤¶ÌNÈŠòÓUzZ0ÎŠIäÉ	¡‰r>ø,¸¶k2¡ù•\Z[ª/–¡vk\Z4Ï1«°*/oH_ĞÁK\\[*/Jçÿ\0RÕÉZbhHz*·êz{f­~R«KtÕu3ôõ2¿<ŠãÀ!$¡R’€VJ!RQ$\0*6EÅo‹»¬ŸS[!³®\"»Jåzò2•Sù¿€\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0xÔìÒdw”ÆÕ’«f~G}yPk/kğ¸åK­ª{Gcgm^iuµFwó\0\0\0\0\0\0\0H$ \0$‚Q> ÓOAYR¸SÒJüŒWŠ=ÒjÎ†Æ¨ñ³Px©îŠèô²§–(³È_(î:ÔvÙiÄßáˆ\Z¤ÎãlæívœÏ/´wC¢”ü´òKàs‰é3J¸EŞ¿¹ºÇSÒh&ŒÑô<&kš{2†™?G¤‰™Xˆ)ÑèÅ»Y³Y5.ü¥/Ôw_¥Õ_éüw£N˜F¢r\"!P\Z\nå-¹ôÛBš/’cô6Æ…h‰YË\"ğ’=q–UçH¦J\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0ó™ªøœ‰Ê­râ)“ŸU\rBªûZïŠn TJK´zÒ£;¬´¬GOÇQ\ZÍ«UQŠ­qÏºs¡6‘mJê*y&¥‘îsŸG‡ñI¢ºC[³Ù.NÉKİÖém_úzGè\r£Grô»Md1—ÊK‰gşrÖğHT:6ŠåtrŸ§t²—ê;µÑJNm•³Ë\rkìk\\ª}Ô–­Y²Ùµe‰\\u­&Ù4{5Ÿ2±ûÛMN,h+QİŞ•ÕòY23>/´W5¤óô«\'H\"\"Œ¢¸ª…Û-tLŒ/”w!bEµVO)µÀ5Õh/-’gU/´z%`QlöU3-àÂ*Zx“âkSàˆz£Q¼ˆˆT\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0k¸¹ˆ«ûĞô\0P‘±9ŸÈ¬\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0?ÿÙ'),(40,0,'ÿØÿà\0JFIF\0\0\0\0\0\0ÿÛ\0„\0	\r\r\r\r\r\r( \Z&!1\"%*+..:383,9(-/-\n\n\n\r7--+----+--+.-7-++5-.-+70-+8++-37+++-7-1+8-27-++77-ÿÀ\0\0á\0á\"\0ÿÄ\0\0\0\0\0\0\0\0\0\0\0\0\0\0ÿÄ\0O\0\0\0\0\0\0!1±2Qqr²\"Aa4BDRTUbs„‘’“¡ÁÂÒÓ#3‚”³$Scƒ¤C¢ÃÑğÿÄ\0\0\0\0\0\0\0\0\0\0\0\0\0\0ÿÄ\0\0\0\0\0\0\0\0\0\0\01!ÿÚ\0\0\0?\0¼@\0\0\0\0\0\0\0\0#qÛ·JËÕÏEôdßØ‚[¦t«Ám{ÙóßTùş¦WŞ÷xğê1q•Iä£³[Ë<µ¦–K[y=¨®×\r7ßäÅÿ\0¹Ë.“v¶/¾©óıLã¾©û/©šíûi½ÿ\0\"?KË>¿mw×ÒÃòÇÃu°ıõOÙ/‘œ÷Í?d¾³^ß\r7«m´Wû´ÿ\0(ú\r¾Ö‡ÒÃò‡Ãu°]ódUx?TŠpÉzım¦‡ä’xµ§Zœ+ĞTéÎQ†œg¤äòY¥´³ËZz¹‡Ãux&L{…\'µ)¬òò5™œ*Ë°\0E\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0néãœ)ü\'İ‘2EãñÎ0ëıÖX™qDğã£k×©ıºEN[ü<Ç(Ùõën‘P\n˜ñõN9´¹Îû›W\ryçáJVØøÖOg”ÇOå;\'RRå<ò#N#¯/Ì•³ŠÏ4Öim^8©,²|ÌÃ‰’ª7µæu4gYòá×‡iTÌë/âSëÃ´€Ú|3ş—Ÿï$M„uÓóïd±k8€4\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0¸×&gÙd‘ì‡]öYb^)96}zßÛ¤SÅÁÃç&Ï¯[±H¨aÚ\\í!Lxá¢ß\0wùzz×_úuôsû¿öõ¯ÑÕ\"ª(Ğ-…À%ÿ\0·­>©\ng£^K¶ÑµÓãßz]­”òÎ>O›0<3:Ë—¼;H”î›¹9ØS·«ß4®©İ:Ê:´ÚtšŒ³Sò¿¨‹²åÃ¯Òjì¶Ã¥ïd¡c¶2ŞÉBÖq\0h\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0#1½ë>Ë$ÈÌsd:Ïs,KÅÃæË>µ~Å££ÊYo-Î_¤ºÕûJ*=e¼Rqº|²Zş¤uÕ»¨¼}\Z‘ÕR¢ŠrmF1YÊRj1Š[[ob#ï1‹JzmÍ½.5gKŒ¯NbÕ®:OÂåGg:ç.†|¯ªû/ª${pN¤•:9×Õ]ñ³­’ËÃyx^sï¯FŒT«V£B2z1•Z°§/bœšÍùÛ¼NÒœø©ÜÛB³ÑJ”î)F£sËGÁo=y¬ºMI«Î\ZZP°§ÂàîT!FŠıÖÄ‘\\ÚKÂƒ÷ÑŞ‹†¿Yõ®WÕH­è=qé[ÌeÕ°±Û™od©e¶2ß\"TTÄ\0 \0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0ŒÇ6C¬÷d^9²g¸±/w³ëWìP*Z¨õ–òÙáïÖ}jıŠMC•²Ş)8ÛL~Œ*Z×„©Æ«âj8BPSıâƒÑi?\Zydy|C§z´;å_S´âèR…·B¤¤©·N¬œ†¸G^”rYºrÔC+Z‹<ëÏ)\'­i¬›‹Z¼-K9gæZÍé6ç\Zª¥Fµ8;ØT©*Ñr…K­nšNœT¢ô)K5“Y/ë>gJ¥YÙS©O‰£mB*9ÊŒ+Â…+u\'ËÑ”§.|áwh=&ûéÇ6Û„#9<Ÿ‰xZ²Må«›˜Î¶¤“s”æé&Ü)Ë=¼Ş·×“HhÚ¯áÁúGV¦Z2|VY¾vVt^¸õ£¼²øo¬çŞo,£¥s—•şë97ãeeGlzVóucm,yPé–ù¤M*2ûÄ°©ˆ\0#@\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0ì‡Yî%¼sd:Ïqb^(Ş=gÖ¸ìP*Z¨õ–òÚáóÖ]7ŠG“ÍmZĞ¦<mÆ™Ó5ãØkßí+öçü[_Ë9ı¤cÜÿ\0iùfıDÓ`Tß‰Çä[¶ŸqŒäü)¬¼š5éğ…=·yôÚÚ?ügÂîçöÒş–×òÇ¨j½ß5#•ŠZÒw><üTŠ¾“×´w™X¿t7—Š\næ·\Z©iqkŠ£OGK-.DV|•·˜Â¢ü(õ£¼ÅëQ·6¨tËïÄM*2ß\"XVq\0h\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\"ñİ”úe¸”\"±İé–âÄ¼Qœ=½v]7šH[\\=r¬ş1Ù T¢˜ñÎd¾	Üî!zòµ´¯r“ÉÊ6é§ÌçÉ^v{~8:%\'wtŸxQŒië]óQdÜsö5[vs—–9İ.„R„kÔ¥k\r¨ÛÓ†sqZ¼\nPYååØEkeßxõ(¹Ï¹qZß¡UåÕƒlóR‹‹qiÆQyJ-5$ùš{\rœÃ8_ÀkÍSãêPmå\\Q•:mõµ¥çÈÉîÿ\0¸<Z‹œT)^¨çBî	x^5µËƒú³Í«‘gu»ğ£Öô|ŞÚÕ¡V¥\Z±tëRœ©ÔƒÛEäĞ¶~<³‚ÿ\0¹·¶¨7Ş%È‹T:eö’å¬â\0Ğ\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0Ec»)õâTŠÇvSé–âÄ¼Q\\=ò¬¾3Ù TÅ³Ãç*Ëã;¨0¦<nq¶Tì0»h$”(ÚF­L–Ù8q•%çnLÕœS¹ÅoJ²Î½ÕhÂ:MèSS’Œ ¹£Ò6¸\\Bşk<ÓS¶\Z©=“Œxº‘ùSùM_Æ°»¼&úTd´+ÛÔÒ¥RTá8Î9ø¢¤ši­k™ùQ‡Ûª\\}½Z•iÆ¢£S¢©KMÅÊ2ŠR–qj2ò¬¼¥ßú<÷CV½½{*²”Õ£„èI¼ÜiOIqyó\']%/‹ãÊµ>&•\nVôœ”êF4íó”ÒÊ-J¢ã–ròøO6Ë³ô}îjµµµkÊÑ•7xà¨ÂK\'ÄÃ<§—‹IÉåäIøÀñ?áÑ£ŠF¬RJêÚIåã©J›60+»\'ûÊ	O´Ãî+\Zø§š´¡NŒ²ÿ\01¹T’ÏÈ§æe‡ÿ\0’ÿ\0VŸi¸¨7Ş%Èl?•æûI’Öq\0h\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0#1½é–âLŒÆ½GL·\"Ä¼Q<>ò¬¾3ºR–ßÜ«Œî T‚˜ñağMÂ#ÂªJ})áõ¤¥5œ¨TÙÆÅxÖYf¼‹/-û{†àØÕÊp·¿¡¯‹«	g8gµFqjP~MFŸ™x~\'so-*ë[Íí•\Z³§\'ÒâÈ­¢Â¸*À-ª*°³U\'œxêµkA>}	=çFÜ\'Yá´§FÚtî1´!J\rJ»öUZÔ²ö;^­‹Y¯w×âÕ£¡W½©²pw5tZò¬õ€w]\\N¤çRrs©RrœæùRœnO¥¶váŸÆ£ğ´ûHÄ2°¿ãÑøZ}´ßáÏÂ§üßxš!ì…OÏ¹“¬â\0Ğ\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0Fã^£¦[‘$Fã>£¦[‘b^(®ùV?İ@¨Ëwô€åXügu¢œ\0;)Q”¶/>ÄEuƒ¶­¼ã­­\\éæ ^üz?\rK¶ŒC/ôÅ†¥Û@n*}Ì–\"lyTüû™,ZÎ \0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0v1ê:eö$v/ê:eö%âŠı 9V?İ@¨‹wôåØô\\î TB“7eE,“Z’‹×³ZÏK\"‘¡ˆGEFjZPYB¤\ZÒQö2^5Í³ÎEg×¥I-S‹Î=?şæ !<I­-ô¥9eš‹Ôòæé#€˜?¦(|5.Ú0Ì¼!ÿ\0ˆ¡ğÔ»h\rÁ°åSóîd¹cÊ§Ğ÷2Xµœ@\Z\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0ìcÔt¿°‘#ñhç¡üßabeÅú@PŸø*™=î#¥âRq¢Òùù\n|Ûè¬íëÅÑ¯FÅ)h·N¢Î:QÙ$öÅùQæq\'¹´~çñ—Í¬Läø×`lWêF	îm§¹üg?¨ø¹´¾çñ5H×@l_ê6îe/ê.Ïê>îe/ê.óOÒ5ÌÀ(Ê¥Õ´\"´¥;Š1ŠçniÜ»ˆÀ½Ì§ıEÏã2pçpËJª­µ\Z–j5tªÔ”SÔôtÛÉäŞµ¬y§éâÅxTúæK‘–/7ä{‰2UÇ€\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0%úät³,Å¾ñ>m-Å‰xó×qÒ›gÊ¤wIkgÒGGO‡ä:q«®*Œ¤£ZryF¡J£“zµ¨ËEs¼G¥s~šQ©sVŠT£qZVÕ!V2­U¦èÓ4ä¡Å94òRo[Ù6ºz+Èpé\nS„ŸñªEIB)ëO(ç)6£¯[Étôk¹<œVMé=4¼\\ñ\\ÿ\0S9cı±·\\¬î>]­Ñ3\\O‡²¤p‡š‡‘½Ä¹„sy~ÆKœï]±à\0#@\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0‰‰/>c,ùœSY5š{PJó©’ş†Ò÷ß8zOß|ã~£ŸŠ‰·¡Ôı÷Êsèu?}ó‡¨x¨†pKúOß|áèm/}ó‡¨x¨s†LúKß|ãC){ïœ=CÅca+_˜–:¨PŒQY}m¦mÛ¦3P\0@\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0ÿÙ'),(41,0,'<nfeProc versao=\"4.00\" xmlns=\"http://www.portalfiscal.inf.br/nfe\"><NFe xmlns=\"http://www.portalfiscal.inf.br/nfe\"><infNFe Id=\"NFe33260310613001000165550020000024581658654310\" versao=\"4.00\"><ide><cUF>33</cUF><cNF>65865431</cNF><natOp>6915 - REMESSA P/CONSERTO (Fora do Estado)</natOp><mod>55</mod><serie>2</serie><nNF>2458</nNF><dhEmi>2026-03-02T11:06:00-03:00</dhEmi><dhSaiEnt>2026-03-02T11:06:00-03:00</dhSaiEnt><tpNF>1</tpNF><idDest>2</idDest><cMunFG>3300456</cMunFG><tpImp>1</tpImp><tpEmis>1</tpEmis><cDV>0</cDV><tpAmb>1</tpAmb><finNFe>1</finNFe><indFinal>1</indFinal><indPres>0</indPres><procEmi>0</procEmi><verProc>5.55</verProc></ide><emit><CNPJ>10613001000165</CNPJ><xNome>Embratecc Rep Com e Serv de Equip Eletroeletronicos Ltda</xNome><xFant>Embratecc Tecnologia</xFant><enderEmit><xLgr>Rua Maestro Germano Dias teixeira</xLgr><nro>132</nro><xBairro>Rocha Sobrinho</xBairro><cMun>3300456</cMun><xMun>Belford Roxo</xMun><UF>RJ</UF><CEP>26130120</CEP><cPais>1058</cPais><xPais>Brasil</xPais><fone>2127614063</fone></enderEmit><IE>78756659</IE><CRT>1</CRT></emit><dest><CNPJ>08057340000160</CNPJ><xNome>ZKTECO DO BRASIL S.A.</xNome><enderDest><xLgr>Rua Maria Martins</xLgr><nro>11</nro><xCpl>Galpao 01  Area 01</xCpl><xBairro>Juliana</xBairro><cMun>3106200</cMun><xMun>Belo Horizonte</xMun><UF>MG</UF><CEP>31744590</CEP><cPais>1058</cPais><xPais>Brasil</xPais><fone>3130553530</fone></enderDest><indIEDest>1</indIEDest><IE>0010128320010</IE></dest><det nItem=\"1\"><prod><cProd>5589</cProd><cEAN>SEM GTIN</cEAN><xProd>Placa Mae -BGM1000 (CPU Zkteco)</xProd><NCM>00000000</NCM><CFOP>6915</CFOP><uCom>UN</uCom><qCom>6.0000</qCom><vUnCom>1921.3800000000</vUnCom><vProd>11528.28</vProd><cEANTrib>SEM GTIN</cEANTrib><uTrib>UN</uTrib><qTrib>6.0000</qTrib><vUnTrib>1921.3800000000</vUnTrib><indTot>1</indTot></prod><imposto><ICMS><ICMSSN102><orig>0</orig><CSOSN>400</CSOSN></ICMSSN102></ICMS><IPI><cEnq>999</cEnq><IPINT><CST>53</CST></IPINT></IPI><PIS><PISOutr><CST>99</CST><vBC>11528.28</vBC><pPIS>0.00</pPIS><vPIS>0.00</vPIS></PISOutr></PIS><COFINS><COFINSOutr><CST>99</CST><vBC>11528.28</vBC><pCOFINS>0.00</pCOFINS><vCOFINS>0.00</vCOFINS></COFINSOutr></COFINS></imposto></det><total><ICMSTot><vBC>0.00</vBC><vICMS>0.00</vICMS><vICMSDeson>0.00</vICMSDeson><vFCP>0.00</vFCP><vBCST>0.00</vBCST><vST>0.00</vST><vFCPST>0.00</vFCPST><vFCPSTRet>0.00</vFCPSTRet><qBCMono>0.00</qBCMono><vICMSMono>0.00</vICMSMono><qBCMonoReten>0.00</qBCMonoReten><vICMSMonoReten>0.00</vICMSMonoReten><qBCMonoRet>0.00</qBCMonoRet><vICMSMonoRet>0.00</vICMSMonoRet><vProd>11528.28</vProd><vFrete>0.00</vFrete><vSeg>0.00</vSeg><vDesc>0.00</vDesc><vII>0.00</vII><vIPI>0.00</vIPI><vIPIDevol>0.00</vIPIDevol><vPIS>0.00</vPIS><vCOFINS>0.00</vCOFINS><vOutro>0.00</vOutro><vNF>11528.28</vNF></ICMSTot></total><transp><modFrete>9</modFrete></transp><pag><detPag><tPag>01</tPag><vPag>11528.28</vPag></detPag></pag><infAdic><infCpl>EMPRESA ENQUADRADA NO REGIME SIMPLIFICADO DE SIMPLES E NACIONAL LEI123/2006 DE ICMS/ISSE NAO CREDITO DO IPI.| Suspensao nos termos do inciso I do artigo 52 do Livro I Decreto 27.427/00 - RICMS/RJ||RMA 42864   NS:2411187|RMA 42865   NS:2411157|RMA 42866   NS:2405053|RMA 42867   NS:R488|RMA 42868   NS:R492|RMA 42869   NS:R489|</infCpl></infAdic><infRespTec><CNPJ>12134405000100</CNPJ><xContato>SIGE - DESENVOLVIMENTO DE PROGRAMAS PARA GESTAO EMPRESAR</xContato><email>desenvolvimento@sigecloud.com.br</email><fone>51995412405</fone></infRespTec></infNFe><Signature xmlns=\"http://www.w3.org/2000/09/xmldsig#\"><SignedInfo><CanonicalizationMethod Algorithm=\"http://www.w3.org/TR/2001/REC-xml-c14n-20010315\" /><SignatureMethod Algorithm=\"http://www.w3.org/2000/09/xmldsig#rsa-sha1\" /><Reference URI=\"#NFe33260310613001000165550020000024581658654310\"><Transforms><Transform Algorithm=\"http://www.w3.org/2000/09/xmldsig#enveloped-signature\" /><Transform Algorithm=\"http://www.w3.org/TR/2001/REC-xml-c14n-20010315\" /></Transforms><DigestMethod Algorithm=\"http://www.w3.org/2000/09/xmldsig#sha1\" /><DigestValue>6/YwVYjgSPVr1yILgZfH2bqp+JE=</DigestValue></Reference></SignedInfo><SignatureValue>dS5Cd5fxed3EHGY39jy5Pl9TzXkJ93R1jXJhNoR4uKZli63rTaRljzI0kAlLyoi9qj7WOpLMA/k39FxjFeH0/SOuShx8BHXHc51daXcua6pHfQIJH/fylN+QqVL39+r6mBqime3MCLWnLv7f48bcUiE2j2pzxjDbJMbd7B4DCuA=</SignatureValue><KeyInfo><X509Data><X509Certificate>MIICOTCCAaKgAwIBAgIQUXn+h7UWga1DGzpPjVYJZDANBgkqhkiG9w0BAQUFADBbMVkwVwYDVQQDHlAAdwB3AHcALgBmAHMAaQBzAHQALgBjAG8AbQAuAGIAcgAgACgAUwBFAE0AIABWAEEATABJAEQAQQBEAEUAIABKAFUAUgDNAEQASQBDAEEAKTAeFw0yMDA4MTkwOTI3MDZaFw0yMzA4MTkwOTI3MDZaMFsxWTBXBgNVBAMeUAB3AHcAdwAuAGYAcwBpAHMAdAAuAGMAbwBtAC4AYgByACAAKABTAEUATQAgAFYAQQBMAEkARABBAEQARQAgAEoAVQBSAM0ARABJAEMAQQApMIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDVuzPKD5jupb87mp0A11qpowBTokuORSdopo6YbwvK9eyM0wi3P0qu1UuuVLSQTnHiKMdWEoEWvBmvMYKXpfvQWgAoyJb+IfI21edIrs/UjRxzaBsq8Ui/J9EAcACt60nAFmWMS3U/ZqIqxmv5VDyb+DE/DU9ZOlQ+KnWcE3o7vQIDAQABMA0GCSqGSIb3DQEBBQUAA4GBABV4U5v2ZnFKblaCRGWLZp/jaupbYpzHyYLSl7ur/7eLYH8vpK9JPKcnLekNvbrT224FuBfo1tRHV3vAH+lAWQKwsLNJByRHH4/5LmYVzIZCWLwWRUapANeouRYSGY7Ye9RuCK1T2I1RmrIBaG7uNFT+d9BXA/+bKcJ5hjYShOs8</X509Certificate></X509Data></KeyInfo></Signature></NFe><protNFe versao=\"4.00\" xmlns=\"http://www.portalfiscal.inf.br/nfe\"><infProt><tpAmb>1</tpAmb><verAplic>SVRS2601161142DR</verAplic><chNFe>33260310613001000165550020000024581658654310</chNFe><dhRecbto>2026-03-02T11:10:36-03:00</dhRecbto><nProt>233260094301537</nProt><digVal>6/YwVYjgSPVr1yILgZfH2bqp+JE=</digVal><cStat>100</cStat><xMotivo>Autorizado o uso da NF-e</xMotivo></infProt></protNFe></nfeProc>'),(43,0,'ÿØÿá\0Exif\0\0II*\0\0\0\0\0\0\0\0\0\0\0\0ÿì\0Ducky\0\0\0\0\0P\0\0ÿá,http://ns.adobe.com/xap/1.0/\0<?xpacket begin=\"ï»¿\" id=\"W5M0MpCehiHzreSzNTczkc9d\"?> <x:xmpmeta xmlns:x=\"adobe:ns:meta/\" x:xmptk=\"Adobe XMP Core 6.0-c002 79.164488, 2020/07/10-22:06:53        \"> <rdf:RDF xmlns:rdf=\"http://www.w3.org/1999/02/22-rdf-syntax-ns#\"> <rdf:Description rdf:about=\"\" xmlns:xmp=\"http://ns.adobe.com/xap/1.0/\" xmlns:xmpMM=\"http://ns.adobe.com/xap/1.0/mm/\" xmlns:stRef=\"http://ns.adobe.com/xap/1.0/sType/ResourceRef#\" xmp:CreatorTool=\"Adobe Photoshop 22.0 (Windows)\" xmpMM:InstanceID=\"xmp.iid:006E0671FAC611ED8AF5AEDECBBA81D9\" xmpMM:DocumentID=\"xmp.did:006E0672FAC611ED8AF5AEDECBBA81D9\"> <xmpMM:DerivedFrom stRef:instanceID=\"xmp.iid:006E066FFAC611ED8AF5AEDECBBA81D9\" stRef:documentID=\"xmp.did:006E0670FAC611ED8AF5AEDECBBA81D9\"/> </rdf:Description> </rdf:RDF> </x:xmpmeta> <?xpacket end=\"r\"?>ÿî\0Adobe\0dÀ\0\0\0ÿÛ\0„\0		\n\n				\r	\rÿÀ\0ôô\0ÿÄ\0Í\0\0\0\0\0\0\0\0\0\0\0\0\0\0	\n\0\0\0\0\0\0\0\0\0\0\0\0\n	\0!1AQaq\"	‘¡±2B#ÁR3%ár’²$5&6ğÑb‚Csƒ“4¢Sc³DeuñÂÒTdtEUV\'(£Ä…f78\0\0\0\0\0!1AQğaq‘±\"¡ÁÑá2B#ñRb‚â’¢Â$4ÿÚ\0\0\0?\0÷ñ§Ï>¼Ìg¥À u!‡¼°Àkô)Â2¥“[Ó£ÃÆ/wæ±®qù\0LPÍº4ûrÑ5½ë\ZãA\'»¼·æª„äfìÑÆâXéÇ<?æ ™ûU·¹ê‘7÷ÁÍúB`MfåÛïÁºÅ§gµ+[ô‚±š®—%<=JÕõÄe™‡è(*Ù,RbÉ\ZúğÊAúL@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@A\"ââ;hüI\ZÑÄå1DÎİÆ©,ÁßyàF0ö\ru]Ú´Š)6Y¦ÔìcÍï7±‚0¬²ŠNb­Ò¦;w½ö…ƒ²Ük–\ZÑ¬2·3}\n˜¤«×\rkªu§D¹×cÛÚã.ªöEww_#¦yÂŞŒ\\y9áÈ«E<Ñ7u»Ì§Ÿ^™yyº›eÃo6óêla¸Ùú\\¹!²–F’ØõÈƒä2\0CŸ-/\0ŒÎeV¶y6Šc›¡óüHüİêÒ6óEéÍÒ´÷º;[è¤sËxš[—<Xšªq_¸7âSæÎ5×ÙWÍo[Ïu#¸6ì©F‹_Š?YíÈƒÊ¾—pĞAy°Õ¯Zâfa-\nŒ˜dvß»Fÿ\0X|«î[cö†¨×OŞÚ)›oŠçD¤{F³Ğ£éUúïŒØ\\DøuL˜e–?)såv¡cÔ-¾ãõ›6‹o0i=¦+^„ÈÊm>&~Mö—ºôúñd»vö úa{¸ Ìì> ŞPuBÏuó{¦æàÛë\rbÚ„öŸ\rÀ Î´ï9Ş[¯)î>l¶´uàÛÛ¹à>å0KóÓm[ÃüÌ®ÀÕ3àÆş7¦µÎìÂ\\ˆ†}aÔû­C(Òº²õ ïªè5M>ZÓ—İ\\™NSëŞîh|6Ú-ûi_¸’8ááÌj˜-İ›ı 9û1³°Šæ„¼|Ä•ƒŠ/ÛÍÑs®º~\ZÓõ˜çR¸Ó$­ZDZ/væ§l\\ZÀü‰¥rğSƒ+ŞÛê†ÉİWïÒ4Íe‘kLş\rx×[]8Idrœy+Nj&³L6„ˆ%M46ĞËqq+`‚:Iæy\rkÑW9Äà\0¤ ñ×ª^iú›»÷N¶í›å†Ø7A·¢lNce‹Y3ğ¨tÔ/ ğ­9.½Q‡6Éê\rE.öëÆµ˜>ÿ\0Pcd¬«ÜÚWÜ}K\\²éK:GW5PÖ\\jw$8ÒK!¯:z«DÉQë»_wíİ±¯î+Ë×ºM6\0 !Îs,Î±­¯2ãP«kLBÕ×™Ã\0¶êÆ­Ğ//ı@óu0şĞ5ÍSû<èU•È.÷Æ/XÖŒgë¾Ú\"XÇ\Z´IAö—-ï3ÁÕJD:?Ò­¤tÍ;öÃpê;Ãt:Kû½BíÆYÚÛ—x™çÕÆI	Îâq$â³]¹,àÕ5‹£e¤é·ÚİğnwÙiÖ³^LÖ~s£päQªŸAİvYæÓ×ìÃ~±›I¾Œ[¡-RÉqo_xŠâÚœ|h¤øí)ÿ\0…µo¿E\\=“ ùñA5º‹d\0‰Ù äj×)=ĞÊ>ò$ãõ¢aúBE.£Múm\"ÆNÜÖñÿ\0è ¶Ïµ¶„õ3í5øPŸ£èAj›§?¸ÆM©e^y›ôJÕ7Iºo-IĞUÇîç{)D-’tS§O$²ÒúÚÛ—`{ªGI´;Qú¿rn\r8ª`½s~Š ®enOæÎ°oM;/Ç©\\4àÈA§ßuÛC,:™mûcàş‰Ö/ÜİC9\nrašZu»Î’ÆÅ¦y«Ür²1HÙw/‡¦vÈ™0Ú{cÏo^v»ìì<Çí}+¯=;ŒÇ¡¸ôûh¬w6Ö:¢îÖöĞA÷±ñÀáõÛÅLJ8½¿òí×M¨û{nßi;­»ßeîèÜîï92‹ö¾Ş<×\Z&¼Æ’#ÔmÚÒàâ.¦f8¾³Lqv­¸êÅÓ Øšå¬¤Öc\Zh¬¹9%vÅ™Z‘™„O\'Hmö\r¬2;(ãhkkAJ€…ÕÕ:ey‹gÆÚF\Z7/&!:àè]­¶œYbc\"«²\0@O=*>ä\'¡€õO@†]¿o¦˜€måünq¦pÒêzª±Ù|ÃJWò›â§äßV:5Çá:Ï‹Qº´4İn\rFYî¥ËÌ¾(X3s¢Ç9–¾°\\_İÚiÚt`İj7Ùi±ĞÓÄFÃh9T€¥WÓ/D:)³ú±´Í¡µ¬bLŠ97¾X=ëS¾-5Ìï>ÑÌêåmhÆÑ­À Ü().4ûÀEİ”@ñF×ÿ\0İßO¶ı}ûdh¹¾·¦ÚÉ_NhÊRû ½ÔË}Ò=Ÿ;Ÿõø5“Iõ¶ ƒ\r¼òå¢ú¾ñÑ}²I†×Á5ôÄæ ±Íä—ÊÔÁÁİÓ#ÍÎ+›øÏ«%ÈAŞyò¿w_bİØW‡ºë\Z“)èáÈ1K¯‡—‚ã{®ÀŸùnWS»ï™\"nûá™Ñ‰÷\rÛ¼ôñÈ:òÎzÑ)uğ¼Ø¯÷.­î{jıQ5¥„À|‘ÆPc—_[: ëuè<…Î‡½ÇtÏ¡/sğ¹İb¢Ó¬Ú[À®_D™¿.[Â‚Ãsğ½ê‹+î}XÚÓá€›O½‹ø²HƒÔ¾½|´‰ïÓ÷nÉÕŞĞK ßÛÀUö®¨:KÔ.œoşî‰öQ6åÎÚ×šåË-­íµr™í.XçŠ¾É#ppJÿ\0åC©sô®Z>Ü\Z›´‘õŞúßJ×!$tMÇói:¬Ø\rÆZŒ½®¨O©¸¾6ş¦ígEÓµ)È®.aûd¹±\\3Ø Hä‘®n=Šá¹êDm›MÓ\"èÍîsûæÃ%>’–ŸtŒ-ÊÀ^ZÏ4Ç)ÃÔ­”aÁŠ\0ö¸FĞÑòŠqÌG.ŞÄÄciŒdkq W÷óP5Sã~Ï1­Ê&èÈ)ù­hõ*Ùhyñ\n‰ğù¹èP~1¿§{lÄÿ\0Î\r÷¶Ôz¢ˆşSîLÿ\0÷µ™ª¿BÖô-~8Ì®Ğ5;=LFs{Äså§2rQYGÕFÜÜ:>ìĞ4mÏ·ï£Ô´=Áe¡¤ßÄjÉmî$ÃÒH/H:ñéÖ•»|¼jûÊXXİ¥WPkz=õ>ğ[Í,v×Öàşl±<8ÎcO$;ÛşO±õÙXóÆ—zŒìÁÑMm#\\×4bƒê«Ëîã“uô·ikò¼I.»£i\ZÄ®i«Lº›kwpêöºy$qï(7b\ryÔoæİ7üo/õOÅ i²}‘ÀÒ©X%u\"´é#éD!àZx8=Ã_j¨57RÆÜí˜[Ä6éáÇ…~ìb©uêò7â,à<ãtY­~xÙ°vØeEjë¿gäÇÖ«_å>äÛøÇ½¨äúÄğËÃJê;3Ğ¯7\\è–ıµ·ß§î}›âÉ5¶ÖÖÛ+™i$®Í!³\'¶Hš÷Kff$€	5ÑZ|Q7§¿t‡E–‡Û6úµÃ>@ûg}(2ë?ŠMm5‹İá¦µ$–­AÚüQv+‹E÷I·%µx˜/,¦§ğ¦ÏâmÑ)H÷ı£¼¬§´Û[9ÿ\0‰vd|I¼¸IO»¶ÜóÑ‰§®9^]­ş\"Y¦4~·¯ÛwË¢]ÿ\0æ5È2+/>ŞWo)Ÿ¨RØWÿ\0[Òµş‹rƒ&·ó¡åræfĞØ]ÀL.a>±,-¢–ÇÍ—]DiÖ¤òì@~§_õj²Ï­}Ô\ZgÕm¡pšİ~O\Z¨2+mû±o\06{ÓB»àaÔmd¯ğd(/pë\ZEÀ\rRÎpxçÕùPW2Xäı“÷¤¡h<Âøuëoi<“¡:¥£¼·ÔÖïİ6p9²~£ZÌÙŞnOİÉs$l6Ks»€wÇİßøUÆæ úgò|Ìéf5ØûaÍRŸ«˜)ó\'‰àí\"\ruÔš/Ni¯µy…;¢yH\Z\\æ\"\Z´ç>Èõ~•t&ÈÌ+‹²CßÃæA0·ÛËZ’÷NÀ;T\rEÔXÙ&¯µÉs » ıœÌÇ³’¥×«ÇïˆuÏ‰ç£ÑxMŒZl}±fŠx™½ä—éÁD)÷&Œ{ÚÎACßË»½YE+š}}¿J‘*˜ñÀr\'ÛÏ±§\nz0©ä K©­1ˆ8=Øÿ\0‰5áJcØƒŠ’8zK¾tÓ…ï\"¨%:sõ¡a=¥ şD}ÖÍ¤$…®íğÛ_V*˜Ltğœè¹V7ÿ\0„1ê:œ8Áª_AØèî¦a°ğ‚áëİĞ´Ço¼·\r³\\(æÅ«ßFu0Acƒ<¯9Ÿ,ï2\\L÷¾G/{ÜKœãÚJFòÃcïü*  úmò‹‘İé+Ø($Ø;UÄRŸü9£‡©àìê @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@A­ú–HÓtªTÖú˜wÄğ‘Ìi°ü0È©õÓò+¡9Õ3ÀÚTfm]†®(\'¶ñĞŸ¬ò;ğ\nÓİE:®Ü\0Âmî€Çígh¡ìÁgtÕãwÄ%Ù¼ãô®Bàk²¶“ME)FÜ\nÉ#œ­?Æ=ìæµ¨íÅ]E²i3`Ñ´¥9!ï§ƒ†Èæa‹šppü¨*=“ˆ8;èA	Ã…@q©&¾Š¢Pğ<}B’i‹¨¤C‰¨<8‚	®ö€ Bqá¥¸êYİ-Ñ-ßµ\r×½¶{ç¹fğršS.9sÓ5;¹)¦u¤inÕÀfªmbv¤ÑAI²ûc+ÛNh+LÍ­µŞ8(¶FšTB	àR‘bŞ?°ûÃ—ê¹¿\"ôéå)AºBÚæÿ\0íîÔ9»k§„ñOƒ²èµêm?Ò‰¯³|#‘ğŞ¦9:ÃJ\0²ÆS(I©¯j²Ë³HÌÍ¨i=‚œ}h\"nÆ”q­;	ªê¦¡·9å†ïCšVwZ¯\Z~\"toœ^•Ãk6^Ò¨ÀO¼IÅDs•­ücŞ×—N xë\ZB²‹Cˆ$aNÀ>tûpã…O:S\n)Jd.>ÓO!VŞÔBnZò Å^Ÿ¦j\Z½ä\Zv•g-ş¡pOi\0Ì÷‹È\0$’\0AY¯mlË:ö•6šnkîò?+£}8†½„´ê¨õF;»”\0\'Ï—jŠw@ë¦ÛÌûVœ®»¼ÂÒ8ƒ j=($G·³†(œhAO)0p$Uà0<±Ar\n¨Ÿ_dãOªïÈ‚Ë½M6>îÿ\0Ã&üˆ><¤ÊÉ:Ò†´’aØU®i¡ü9§è)âx;4€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€ƒZu:¿†é$a–ü\Zÿ\0²z˜æ4ó0&„‘iŞ*@VBkKÃ9jîîÎ\"¼½ße„áÛT\Z›5\rs:ÚäÆG-à³ºÕxãñ/şø}&­`Ù;GÁ{x9¥×şEç+ÛøÇ½®/jLÆ¸qìVf²¸ãÎ¦ ñDœøq(„†Ÿ:‘Ì&’úJPê©ùTI>›jníİ».·-¾©ø}£¤´ÓnZ×Ç1ˆÄĞ×±ß]¬ñ‹òğ®R~ª‰Œ¦\'š®h;S}ueiˆ¶õÆ‘àÒl³~,­.tQ°Ìí%£4ä¢³à›y¼ÎcË˜×‹š©Â§*¯{sLf»¸4]G˜áÕ/#·™õ¡š¹ôì% €¤—¡ÏmÃ¶6õœÚq1ÙÙ¶ŞŞïExa´’@`Ëh\rsM1çÏÉ«|Úø—èßßÿ\0ñß²ş²½Ö«LŞ:z³<\'<\'á‰§C·îm î‹û&ä´•¬¹‚.Lñj\\ÑÜÖüå‡ûªyyqúqAÎ\0ş=È9à‚sG4÷ µoê6ïÿ\0Ãeãé}8ùFÿ\0ü\'¥ Ê$?°[Tå¡•Ó™F’xáÁ\'™àìê\rcÕ\Zş¥¥î5ìğ¦9=ƒCê1ÌÑ›™ÊèD×‘À+Zğ‚q-n`191°Å@Ôûû)Õvö_d‹;€îÌ^ÜJÏbÕxÑñ¿ÎJœXb?±{<øo#0Æ­C*#œ­<£ŞÀîÁ>%\rKI>ª«¨³º˜à8cÉ@–qÃkZ¢RÉâx}¾…\"(kÇ°PO%N¨ÀñåêïR7F:¿¬ôs3\\Òç¸µ‘²ûİ¨kæ·™­t~ ObV:7I¾°¥1gÕ¾¹ÛïWî;Û+Ëıoso2Ó¸wä^îZÖˆ!ŒıV†´5­h\rhDåÖ\0\0˜6”\0}\n¬Óõ2şËR² ]é×¹¶.ú¹ãp9Iì#ÜPæî…÷X6¦íÛv_ˆn+m.ÖÛÃ—SÒ§ï|?R1«Zx9•ÏÁg]5­º¡ôİ÷ÿ\0*î»ÎÆ½â:kŒÛÆØåŸÎ|]FİÚÿ\0í6¿{«¶\'C¹b´‰ôğ£¨ipT×‚ÕóLn•õó(…hf`0ìPlAıÊ¨™í88…\"×½Ív6î5¯êÙpõ…éßÊP§AúFq£º}µ)PAÃNhãÏÒ‡ƒ²è5‡T…t½+ÚËü¸Õ½Ls\Ze™‡‰‰€1N}ÕVBk	ic¾®fà9vÕHœ\0£Éà\ZOuT\rOÔ[©hd`M­ÆWV¤XqRëUãGÄk(ó‡ÒòÚå/fĞ(?MÃµDs•§”0‰É’§‹ˆVQhš2Ò\\ÑP~ÏbDHÇ×ÍJF‡8€Ü2x(B¤\0Ö€+AÈó=ªD$öü¨8óçêùA_N<¿q&œòAÀ¥hHšÆR—<CÎ8ğAO0\0æâÓõj.£ŞÅ)D1õı\n¨¤œÜ™Û‚Fö?Ğ}Ü96Zà úyò”Iè/HInSıŸíQ˜\Z‡SNn=İé<ÏeĞjî©“ønN>ş´ø)gƒNÇJ½ÕÎ	9 ÕuS0niÀvŠãó\"Q‚D¨\r\rÌĞ~JàƒSuÙÔô\n\\ë[ºƒÀ¶¬¥;Ö[«Æß‰rùÂé…A96fÍk…*]>œ½)Ö·(÷°+ƒ÷’\nı£ô«(£s¹`(AõsA!Å8SÊ‚Æœ¸ €šp¯u8¢Rê9cô¢’=4Â¨!$ãÚPBi_W*5îÁR8$Ó³ÑÜ )Ö¼ğPCÄ`òP%Aú§4(\"d4úÆ£³ARm\0¦\"‘`Ş¤‘»¹ş¬–Ø…êÊ}?°NÜ•éŞÔ«{ÿ\0n8v ìŠ\r]Õ\'eÓ´sÄûö·îŸ‚˜æx5µZQÕ4§!]W\0’èÍE]Ã(9­^‰®&¼ñ–¨ê[ÚíGo<Šsº«¨NíYìZ¯¾$åŸß¦h“eì×8?^q©V¼Ö·(këƒ÷’7‰ÎkÙÅ]EÍ\n¢ãAA#\ZãÙŞTˆ\\pìõ ”ÂŠ8’ˆ!.õöw €G%J\\×Î¡:„8Íİ^À¤s\\w­5qìãDÈq<»DZñô(´ğí<ĞX7¡ş„nÑÿ\0vËO” ú…òœZ:Ñ–6”9Ú4ä]`0ùvI¬êŸó~‹RE/\\pî‰øŸB˜æ4ã\\à+›(áJàGg¢¨£5•ƒ€ö¸ã)ùTÚhsRĞ\ry\n(–¦êI\r¼Ğs;3}Òæ­†v~UÅªñ·âQQç¦EÜb¶iw§<ê#šÓÊ\rÁ,˜a˜ãÏŠ•\'Òj‚I&¼iN%æ§\Zö”óRªDÆ•çò(ú+^%ãùCZáZvWò)—a‡>(8­q44çÁ@†£·ĞPq˜€\r(IÄsR\"©#è@®oOzkÜ F×RœGhìA`ŞŸÔ­Ùß¦Ë¬ ú†òš\0è7GfJôãiTT\Zş¯ã‡jÊ                                      ÕTÓ´sÍ·#ıËÕ«ÌM0\rX)\\¾ixWU1 ‰sWÙ´õb‚faWœÀÕ V¾Œ\rEÔ¿kQĞ\ZÌÙ}ÎéÇÖæÅèñÇâTâ|áôÑµú›/f…>ÜÇò¨r´ò†¾¸?{/:¸ãÏŠ²Š\';\nqŠ	%Ø“Æœ?*	YÁàPCZŠ\nØšWŞxúPBã§‚	ãÚ‘ ‚I¨¯H!/;ñï@¨âM{JàŞt¥1ÿ\0ƒª¥ ypäJ‘Èä*‚!ó‰@°ï3ı\nİ`ŠÃ¥¯¤ƒê7Ê…Az2Gìßi‡`8û‡jÈ                                      Õ½S4Ó4¼*}éô§o„åjóDòi ~ç-*r1¦§h…uS[œHIÄâ]^$V„\"QH}\Z*ÑS1¥Pj£c©máA˜YÜ€y}v²Ûà½7|Jê<âôî¤vnÌ-©åšaô¨r™å\r}t~ö^8½Ü}*UP¹Øœ\rx)Hs<}B!%ÔüÓQÌ ’ê¹Â¥À5îP8&”›ôşU L4íAÉ4¯x„æ§j¸ĞáQ”óïAÅAôğî¢ÆjSæ(8¨æjxLAÎaÂ´Ÿ% 0Æ•Å@g° ˜×Dx(äGìVêØ6JcŞÔQ>Rœ]Ğ^\0ËÓÍ¨;?fj¾ª’4Í%Àf¥á¨ÿ\0få1ÌM/ı‘PÔóÀö­GÂGVƒ#ix8\"ÇŒ“V”hÊ)ëDµ7QËÛÌmC½ÊçÊ’°,ö-W’œN‘…vfÌ8şúnÅZó•§Á¯îˆñd­~¹ùj¬ªŞóßÅd:Uå­kÙ‘oİm \\mùï¯4æGU÷+‘5“ü9«…ã.o«ípÇx¦cŸÍœìŒÌy{”ÿ\0Ÿ4ÑYµöİÏ*Ç¸­¾‡FÕ?j}3ú²#ÂÕj›È_šØª³İ2âœ¡×ô÷Wå{TN«2ï\\sÏÁl›Èïšè‰ÿ\0í+æ úĞêÚtƒÕ÷áDRgËâ´wYøJÑ7“o5Àçè–³!o(®´ù>J]$ÒcËâ´î¬yü%j›Êš>¿A·[¿ÕGi\'ñnJ™_®=\"V¹¼²ù”„å@÷±§&iâOâHäé”}ÊòÏÍmŸË×˜KlfèNúŒwè·øÉÓ>H´rµËÑ>·AŒİßQó5ĞoˆÃÑSÑo$ıÊù¨Ò­Æ	“¤ÛÙ q®ßÔyz N‹yr¾p·ÍÓŞ¤[ş›¦ÛÂÌ»@Ô‡ÿ\0·N‹yI÷içºm¯»íğ¸Ù[–ØıQoÓ™òOU|án—NÖ`ñô\rf\0Ú’eÓo@15.„P(Äù\'ª<áH¤v¢É€Q\'X÷‘®ËİXƒ]:Jü¡Ô‡”çW –ôïj4´÷iãæ\nÉ                                      Õ}V4Ó48ŞHåX‰ô)¯2ZX\Z–ÔãVĞó\"‹U°—<‚iÂ´<\Zr™*	\0\0à8ÔòP5QÉv«·Şÿ\0k=¥Ögmkò,¶CJ<nø”¸ÿ\0|^Ÿ×–ÎÙy{‡ŞğQçÚOƒ_İ½”œ=·zx•d-Ï%@öŸÈ®÷±Ù~Xö¼ú”×vzÆı×´Ó-»›â@ùeÎÉŸtMÉ÷£o¶p~UOqZÙhõşPíü}bÒ.]s·ugØZGs©Àé`síßø›´‰íŸ”ÓÆmË!hÿ\0ˆh&.V®Æ‘\\²-Á¿vöŞÔu-6îëÇéš~©Kwc&‚Hu=EÚ\\b\'	gE3sJ)ì³S‚µ¶D²Ù£)»‡|è»Røiú„7SËú¼ºæ°Z1š•ùÓ˜÷Ü=ícDRŠË_ªÚs4Xç®ºÌp•³Õ]‘¡ê×Z&¥wuÕ¥ÜV/¹e±}»ç{ãF2LÃ1…ÒÆ)˜—\0ÀóP5ëÌ6¾¼ÂéşÛÒ^EcjÛûÇK­Zè.šWxlº½³eõ¼„¼´˜_€çh45\n•mÓ*j¯lZZj×9•¦ß56W”Ç:BĞDçoåUïUZµÁƒbÛËé/%ò¶CjÓ,¦ ¹ïË™¾ÄlkóÉ œx(ÓX¼qÄzå4Ì×†V=ËÔ-#jK§Ú_¿R¾¼Õ¡ñ´›]63q%À/lldM/fgÈç´5£¶¸m\Zºú«Ã1ãÿ\0O¥Øÿ\0UÜ÷z/»\\f”şS\\&ß([öÿ\0Tt­r÷ZÒnìwÒÕ4;K[ë»-Éfë¾ÚöY¡‚H2É+dHÚPGBjÓ7‰ŠÆgÕìÏÁåÆÎœÇñøyû>,–çvéVºV±ªÜjî†ËoYÍ¨ëOs&2ÛÚÛÆéd”Àep\ri 5¤¥VÚæºó1ùñ÷#VÏ»\\Dñií‡æ/¤^`v^ÿ\0ÔzG½dŞ{kJ»[’M7QÓüËo8Ÿˆ[[ç©ßS5)ú­]qyŒDÎ=ñêæÒ¶‹Z#<b>oš}T×VÔ{<l¥­\\öæëQŒH<»ûT&ò\'ö/tÓ‡áòWåjõ#å,Ÿì£sÃË:yµF€ÃÚ@ùvU«ê°®—¤\ZW-õh;¢zµy¢y4HÊÈ-—!h«–¾³8Sê‘”z‰AÉuä;(	¥1\0âƒSuÎ\Zß Sù%Ø™£š~e–Æ”x×ñ\'ó±çlı˜{¾«Æ±V9Ïµ3àÀn%š•úçš²«d¡5äqAíÇÃëlèzß—SÔ´ÿ\0{¾Ò·&ì³²ŸÄ‘¡°_Ín¢söµí1µÌ\r()E×HÍ#ÙùËÌßŸ¹owÊÏ·évÈµ¸µº´Ñ¦±šËQƒW¶÷·Lcoí¡u¼wa‡¿Ã{.­j]õVS×m™¥³öÎ±5ÅÕş‹æ»´¶°¸t/t\0ÛÙİûô†ÆZ[‚_P*xëZË~¹˜K×6‡¯·Pn¥bìºµÒu6ÛH`Ø>gO-³Ã2Lç8IL\\ÒEqKépÂ×½gŠÅ«ôŸbn;ë½KSÑå÷»·ø’:‡ÄØŞæGÎ…¢¾™°ÇââK\ZàZáUJÆZë¾ay·Ù\Z%¦¯m­µ÷Óêv×Ô\rÌ÷.vı:=,Ï3(\Z÷{¼@\\áõ’õÇv´Ä³BĞ{–‘õB÷ãTLüÕMSàjk-á·µoX†vØCMÓà·ü24qµ³{Ëf»|qk³9‘26Ó¹âWwÚßuéXÇMo[ÎfxôNb8Gí>.Ë}tÍ¢ÙãYˆÇ¸y±ÍÃµ7mÎa}¦X¶}Í¶®^4Í:öq+o´ëy½æÖ„S@Åí`iñZĞíš\Z.îÛ«U«6˜›tâgÏ39øË»´şÎ;xİ®¼+xœz¦Ü&yòÄÚ>\n^–è½OÖ¯5]ûÖM7JÙû¿^Ğ¬43µ4:véÆÆæîáó¶õóNÙœówF9”´©ÃzMtÏÑ=]S9åÂ1¹á×ªv}Qˆˆ˜ŒsÄÌNS·ÆØßZÎÍê®ØÒôËK×n\r“ªiûXK©MÎÕ®­d;Vß‚\'·…îÈï¹™!$`Ğ³ßn¬ÄG˜Ÿûs3ËÇËñwö”íõé‰Ìıî©Ìs¯F8NgÇÎ¯M¶ñÚ#³Ó·–¯¤ÜÛl&3ZÑ5[öj†\\[èî¶›NeÄg,ï³Æ}À©˜¸½Ø•ÙŞn¦ÈÙ19™¶cÏ1ğÕõn¤öZtÖ•¬ë‹Dâ¸›M­6ë´úóŠ×ükˆ‡Î¦âuKó…L¼xı†¯*ÜÑ\nvœ{{G¡@²ïıİ5ÿ\0åÒ}-P>£ü¤Iât¤^Ö`Íµ™AÀSNeBÌ                                      Õ}W4Ò´£ËßMOû\'«Wš\'“F·Ú,sIÊ2·‡ø¢¨­‹ŒÎ.5i}1\0­IR&7êÌÓBÚ´ƒÚIP57RëqÍgyÇ½Í®=«-(ñ§âJêùÄØ‡…v~Ê\'ø/UsíLø0+ªø³Wï¥YU®COËëAíçÃÂdòïf÷³3ë×Ås8p>Âõ»Iÿ\0TG§9yû©²Şï“½æÚLpì£ßÿ\0¤¯jå…µB¯Â„2€ö7íÈñÃÖ¹)šÚbZRc\nWD[rèÌ÷]˜2’¿ö~…İµ3ˆizD¨­dœ]2\'Şİ¹ÙJxĞĞğä±ÙJÓ!É¦İÆR%»¾Íıctp$g‰Å¹±Ç.¯ìÒõş0×V3)—W×ñI4pê7qkœ×ÿ\0%aÚë¤Æ&!4¼òË‰õFÛ9—óÏ^àì®ÄĞµDh¥vOe×4¶2•±©û‹®zÿ\0·ˆÖeÈÖ‚pËÆ¥iÜvÚë²10—µf-ŸãÖg¹½¼k­í-ÜöÒ&â¶¦œ*qZw]ªR¶ˆã3çàlÛx´Nx,ÓïÊíVËO´¹€›™™·aúÄxò­vÿ\0_¦´˜œ{Yïß²-Y¬Çí{}k\Zd²›9á,kœØ°1ÕhàN#_õÚ¦Õê‰ãÏŠûû‹kÛå*-Gvk÷q]êrÛ2[ÍT|qEnLµ”Tû\\K¸,{®ÃM6Z•Î#+hß~¹‰ÇSæ;Töu]Hr\0ù_?/^9)šE1 ‚Í¼Oô/tÔqÓäúZ }EyAn^‚tœTè&×&œ*tØÉAÙô\Z««\r#L­oy«rµ9¢y4pÊehú 4P×Z(&µÈÒa5üŠRŒS$ù‰úÍîš¨\Z‹©†š€A¦Îì“Çí-‹ÑãWÄ¿ûãlw:€Ÿ²êÁöNC…xHUsíZyG³ó`wf’ÉÀûNÇÖ¬ªÙ)Î!·§øñn	5·_~,Ez}´ã\\zxË†Ö¹hŸWÊûâ;»8­ârZ¨€ÍÙÉ†¿*Ãe~¬¹úq*Y_ú‡Ö\0\ZöÓˆZhu–Õ¶b»Ñà]:Fš\0àöz+›è]^º9»ŠtÎRu%‘Í\0ƒí\nğ¡\nİ¥³mY‹B]øË=q£Ú×ü­R³Óg<ı7I¿iu¦œğql¯3í8U^ÿ\0å>µ»¨áRĞ\"6·í\\Hì;@hZÌıÌÏª·êÕ˜óQX´·MÕ.\rk<ÑÛ³D`Èê|¡ZÓ÷\"µò‰ŸÉZız¦afÒ“U¼ÕÆ›nãøešoa„w˜­¶Z/ÛE#œÏáecª½SÎ>lgPmkY²Ó ¨ñ^<I*(ÈãÅïîh&«¦q´lò–;³x¬Õ;¨z­³6şá··û¸‹mlÂk–&ÚH^ò1=ëštÛ§ª|bf}¼İm¶“8‡Íö¬HÖ56ÿ\0ÓÓŞµ|‹ŞJ6œhHD¬ûÄÿ\0C7Nü>O¥ªúòˆ\0è\'HÆlÏıÚÅç:s¯.AÙÔ\Z£«?Íš0äoñ<i÷nÆŠôæ‰äÑô¡ŠÒ0F5íÿ\0ÑDØ*KH¥3´8W†&¨’‡$õ¡áßÅ@ÔM#ñ\rá¹sZ\\R¸ñsy¬¶ø/GßŠ8û\"¿ı!²ñı‚«^síZ|=Ÿ›_İşšZ~{¾Z«*¶HkùP{iğì}<¾ÂÚSúY¯WıìKÓÓê¬û~o#uæ7ÛİòzÇAÁMm.ªÛ)ŒÁÙH\0H9ö­-Æzåo˜Q²4ãáº vUW3å‰é*[±âÅ‚‡w:ŒÌºôÌNaÑx‹ÕIqíG©LÑ€êö·\nÊ¿ëÙêË–“‰Â]ğs¡´š”¤axíi-ù°ZŞ¹‰ÇSÜÇ”©š§Ù¶˜´HĞÏ\'æVÑ=YZc¯Vá‡ğ¸\\é‰õ¾Ÿ‘Oo?\\Â´ç^1æ·Jóm£DÇa_çG»+OÈÕ·o÷¦¾ÈSLâ³YñYÚÿ\0Ã´F±ì\"âõÆöã‘-e„<rË4ÿ\0)mÛÓ«u«á#óü~JhŒVÕsé„\r—q®Ü»ùV²Ó›N,šãí¶s‚jÒk7Îˆå^?ú¿öüåo:­áìıØ.­û’ÏuÈ$1iÚN…©\\ê‡--fÈÆ´ñt°ÉkÜ^º»/;qˆOı“ª\'wF<&2ùñÕİ›WÔœ@ÍZšÕğÒúhR‹~z¢mŞ¡»£—êù)ò…êÉ»^Ş„tÍ¯p l¯áŒ\r\ZtÈÈ©µªÖ                                      ÕYÃLÑÉà/Nÿ\0Í»±ZœÑ<šEÄæ%¢„Ä\r8S\"ÕDvç(p8€ñùq¢5däA¤@Ã‰iŞ§\Z_íê`|—‡Îk(ñ¿âPIó‘²ğÅ»CfÇŸ°MUcœûS<£ÙùµıÕ<YO,î©õ«*¶HyñîAí—Ã¹¤ùˆ“ˆİZíÿ\0]ìöÑ÷üååwÿ\0m§ÙòzÈ’ÎôÂ+i«x¹©K:«9K¸hÄJÒÒ}KLuWØÇm<aoŒ5ğ\\BiVì8Ãµ5ÚkhWM¢x(¦ö­AŒ+ùÂ«mµñõ3ß\\q„.>-“ZN{šiË0|êú§?œ/Ly)£Ø±´Ù$œ} ¨Õôl˜ğgÛÎ\"këbúæ¡5µ½­µ¹\"Y–09ió®½\Z«;-3Î?(ckôÌÖ9«oŒ77–úp—,1ÆØç4ÄGGŠxwé+:Å©h¿Œş|“xÆØˆå†?©1ºî©îN“Ã´sLú“¸–Û²€°Îy£\Z?ÄºiÚÑxç<#ÛéÅøîáÊ}?f3¹u+«û˜tı>!-ö öAai\r­((=–1£É¢«¯¶×]fmüq™ı}s?6v¼ıé¬G8à—¹ıÃkì]{G·œ\\ôM÷÷Ùr›‹‰låK‡_e•àÊs%qôÎøÛ3áÂ<£ËóŸ[N×\Zÿ\0×§\'Îf­ìêúÃ	©ÿ\0%«ãåô1ÉHÓëîD¬Û»›¹Ïıß&>°¡¨_&té|¥™ı“¶|.-nÌHí\"¨;X€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€ƒTugù«K­nİ‡û\'jóD´~bdœXŞ#»ükYQ2sLO\0pî(”²hÙMMH  Æ bƒMõ=Í:†Ú™Ì7ˆîËŠÇjôxëñ(§÷ÆÙ]§gìÊ‘Ìä*±ÎVQéâ××?¥“‰£É§­Yl˜ö×áÙÿ\0üùaİZîÓGÜ½®ÎÓÿ\0œ¸¶FvLúrz\nR£²¼Õ¦2ÂÚü“cÌç5¬ï&hâIà-£¦rRÎ‚õ7â9Ño­É²#Ú»ß~é»ö=?¨DÚÖ]hz5É‡$rJéZdğ\\^}\\ÒÖf!gÖ\'„pv}¾ª»†Íó³$Ù±õB-Ï§ÿ\0g:í·£¤-²\ZA‡Ç÷·8â\ZÅ¤föi›½¯^§Ûšìt»`üG<¿u|èû!º6óÙÚ^õ¾v—²z¹4ø¬ô\rVí²xq5“	œø„® 4½¾É ?*­;ÌÌf?Lü[4uV]ë·k›å´€²V80àAmZA]TúoRãíçgšxİ+m {&«³`\0pÅî\'€\0O%móÓh·†›º÷Ò­ì®»OptúKGCÙÛ’ÿ\0lÏvÆEíæ–ØŞùí×¼Io!™†7š²^½ÔİªÓœLNÛ¦-zõsÃ­\Z×Ä?Ê¶ÙÕw6‡«ïMv-É¥ê7\Z^¥t©–Rº)ZÉ\Zâ×JÒs Ï³û\rqh¤ÿ\0‡·ŸÃÁ?ñ·Z‘l}Yóğmyè×ZtíÆÎ‘ë÷Ûçn7î©nôÉì$t—¦FÚ²Íí<V75 sÄñ]\Z÷G{ÕháÓ1T~øâÇ»×:iÕ1Ç-ãgf6÷¼êz“‡ã×±º)ckÚæÙ@ú9Ğ´2>ƒÄ#õq]ÎÏ½4šÇÑú§ÏÙåñRõèµvO9ü=<Z›s?PÜö[¶ÎÉÙ-­t\rJïRº~Á-e¦b+‹È£\Z1\'Öº»¾Ö-iÿ\0*ÌG®o)iæ\"jä;WÔİ”ŒÓVœÅZÕùûé£’‘½Ü‘+Fîş¦î~8éò}!BRŞPØØü¿tx5´`msÛRtö~T›@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@A©ºµü×¥Së·–Â\"v*ôæ‰äÒ¹ÅF/hÄs¨Qi*\"âS¶„‘ÛBI!”\Z~÷¼Gg§š!¦z àu-¸CrÃtZG*TşE–Æ”xõñ*n_8›$™§glÊ\nğ§Ì©åiå-{t~öZŒs»éVB×!Ç°WJ!íÇÃœÿ\0øû4\'ö³] îñ\"!z½±ª=ÿ\07­şÛÇ³äô\nğ¡€*Ú¶ÊøàÅ÷¶·qµöFúİ®Ëw¶¶Ş±«Z<\nÒ[+¦c¨xÑÌg¿ø²éú¡Ô¯‡÷Oöë|˜ôçGÕ4Øµ+~¯Yk\ZŸPÅÃCªınîâÚSsùÿ\0ÉÚÖ\nò\\GLÏ§Ÿâè›O^lèöÍŞ=Pøiu¿¢[bi/·6ÄÖ÷^ÏÛË,q¾êßHÕaÕiãHæ0xŒ2Fœ\Z* *ÄL×ééÂ¶:¢}=<Z«ªŞeú;æË?Kü¨ôw@¹¾ëfî—kèe\\Z=«{£ıòé·Ò	g‡Œi…ÙœÇ’áÅª&Ñ1Œz~Åk19ŸOú½Gê®ãëÊwJí:U°áê„š¶½a¡u:úæGDtİ‘EÎ¬ß½‹Úv9¿{R»¶M«œxüòáûq™Î2}\"êGZ´½¹Ó]•Ô¡Ó>ë÷÷0u³\\¶6­¨h„FØ4û—Ø÷’dl§3Z3çmcst_lF<¹|ÛÒk]Jøui:~İéSvö†fŠÃNêæäÓì;üIm´ëÚ±¤¸æ†´)R»?¯§Ó5ÿ\0¶g¹ı½ÏÕ²<úb[ó®[Ÿ¥}é.ıëN»Ó}©}q¡YH6Æ>`ó{ª]¿İìÃŞèç™\'p%Æ§+^åÔV•™˜ñÌúç÷ñòàÇ·½¯hÄã3ËÕæÄ<¥ôRnƒô—Lºİğ¨ïw¿uïÛ¦DÈŸ¥ª7ÆlF2ƒkÄ`0±ÆBÑR»;\rZíO>6õÏ—²?·^okÌøpW­¹å\Zí¼’ÃNx···§âz¤˜Áiõä4ö#¸ñ£jW¡KS_mõq·„xÏérá­ú¸N1ø+÷dºVÚØÛ«KÒ¡1Ú\rRt³Jàéî&}”­tó¼qqìËF\r“¹ëß«îŞs8÷DyDzLøº³Xs_8ô—ÎV°2ë:“y‰€Àjøé}ŒqAiİ¤~ÇîßÃäõpAõ7å´èH\rxôÿ\0jTS\0‡¥AàìÂ\rOÕŸæ½,vÜJ?ı+Óš%£p\0R¼Yí#ÙªÕG\"Î$×ÚhôŒ§Š„¥ûb7š’ìäúPi®¨€5M˜×dÀK0XíiG?£_8»3Øoì~ÌÊy‘áñpäy*Ç9Lò†½¹wŞËûóS^õeVÉ%¶_§Ó ÿ\0j×)şö5ëi¦tV}¿7ºİ=Åıß\'¡0¼Ğ6¼\"Ø—E/Áoı\Zçqôû¨[rÉ–÷_ÚºŞe@Ìén´ùâ­ï.p[oÕO‡Í´FeÖ/‡¾èÒµ/\'ÕäpZìí7RÓw,’{Ê]\"şåÓ‰«õi\"\nå¤ÇDúz•Ù\"}<ŞwWX³øau7wéú…Öƒ·ºßÖkû_X‰lm­[ZÖåà}l’o\rÀı`Ky¬sÃÓÍÑËºq|¾ô/jù;ß³í¡mCÒm×Yé†òÒmbµÔ¬¯­¦·÷I¢Ô!\r•ï»qîsÉyvo¬\Zì¬EbcŸ§Éfz§ÉÛ¾•êZŞêéoJwNºÉ&Ü;ƒeh\Z¶âxncïwz|O#òŠç¸¸÷•ÙªÙÕ>§?q\\ñ†l-ßuui\05c®¢ñÚÜâ¡i[tVgÊ\'äÆ¹¶\"myµı.ënÏgëVì†TÈèãu¾Xš@Â¤ş^KëöÚ½Sëœyf|MñõûkƒÍÕ§í÷W|¦tô¹šNéİ·ã{éĞ¸†¶\"Ï3^L­§,9©îçîí¦ºqŒüqÇá+ÒŸnmyòˆ‡míKwŞŞHÉÿ\0Ò£•Âÿ\0V0c\\a·a I)‡Õgvj&½ØŒff¼#óŸ(ügÁÁkmŸŸOŠëye¤X\r/M‡İ,mÜ]°qsËõ¥•ç½ü\\ã‰à(0YvºfûmÕ9™LyG¨­«N­qËÓã-A¹#Õ7>ßŞPéÑ—Ã§èZŒ·×9b…µ•ŞÓ¹¹ÔÁ£è[^Úôö—­ç9ŸÓÍÏÚÖ×ˆ)›À­eÙµMÃÓTW°±¥|ê”m®Ä•§vÿ\0S÷=9éòŸ¡úò‘_îÿ\0ÑÇéöÔÊ)…™ÁAàì²\rQÕæİ$aÔ€ö.W§4KF<¹¬9F5¿\n-pà3¸\nœÏa œ+CR\nM\Z\0#L\Z Ò]P-\Z‚]‹M¥àep ÎÂkŞ²Ú½?|J©ığvIƒ³va¯o°xªG9ZyG§‹\\\\¾“KQJ½ÀüªUPIR¤{gğífn€DZõ£\\ÿ\0®«Üí1=½}ÿ\09yÆ¼í™ö|ÆHË†€Yì£(ÍUĞÈæ=iÊøÈs^;G¥eá.­wËÍ½ığè°Ü«~İtóÌñéLº¿¨»RêŸI4fg°½šWç¸m£›4L’’ïfHŞ\09qŒg¶™™ôÿ\0£iÙêwnˆtÒë¢İŞ]Ç¥_³ÚíÑÄ¿Êg“‰Ëâ[(‰ı\'µE3ª#é–Û=Né_[Ù&ÛÛG©Şh7ÇT:³¯c»Û]¼kíâ{ ~x-on\rÄŒ|M¦ZGh0Ãå5í->™ü\ZìÛˆÌC¹]\\èı×U¿³94î¡k=6‡¦[¢Ûq-¿X¢Õmíƒ4»†²H€·ÊÌ´!Â„Œ«H¤Í£ÉUœ·K¯#µ»ŠíÌï”K»pC³^£…UíI™éõa•-ÑÉÔîŒt§Nòı¶wv×Ò·<Û¦=×¼umá>©qlËGÛÉª˜ëgXç59ª‰àî×Ú[\\f|e—u¿¦ñ0µênµ×Í©×ıÃ®Ïjİ­´/v®™±·ï•ï¼}Î|ĞÔL}œ¹)Šßº¥cdm×9˜Œráûü•İ¶zq1ÂgŞÛ\Z¶¯ojÈâ‘ÚZÚ·Ã·µ…¡‘ÆÓÉ­®ñ5©8•Õm37ç9ã,û­‘^™†¦ézî¼ø†ÇEù/õ7ìF>¸\"”èov.îëdv›khã3#óŸ(ùø0šM·Dò5ÿ\0zËa¢tûwéš]»lì­vö¨a·.{œëIsI#Íäq8¸ú°Áy;bÖµæó™˜Ïı=N­]4İÑ›İg\rgRá5?äµ|“İJV¡¨íD­[·úŸ¹ñÿ\0°Iù©ï(æ¾_º:Eiûµ{Çód\\Iàì²\rMÕ¯æİÿ\0{“Ï¹z½9¢y4işÖl\\XkêZ¨‰ø¶J@·‘P”·I8SG>4SÚÛàV®¶¾ùs±eµz<|ø”KâyÁÙÄW#v~Ë’(|*ÔwTªG5§”zxµíÈûé›Ë1zÕ•[¤­1àx¢^İ|9ñòû	 7^»Ïş–5ìö–Æ˜÷üåÃ~;-îù=\nĞ´òÁi<T¶´ÖàF4¦\\÷¦8²¦xªCškÀ‡Ò¦—tÖÙ„’]ZeÃ;+˜axéœ¥¼UµÌE\rj~z+j¶ZÄõB–âî ]pü¹ÛAÚw UDDõğsÖİÄ°}BşëR¹¶6ï™Ï£Œ\rÇö¤w´|z[;x¥\"ó<œıÔÛª&°·LÛ])ş3ÜÛF7U·.dGóbc‡òˆôQo3nãW«ËÏÛú\'}c£«œ°ıg]¥æCRÒsf$Ö¼ëÌ’º»}sDÄx0Ù²6kÉ§m+½M±ê•ÒØi§ôVıİİÅİ‰…ç_lò\rT·yYÓÑ®3oû¼#õŸÂ\Zgf¸›xxxÏéóeWÚµ¥½½­¼1Z[Y°2ÖÒ’8™ØĞ8c‰æN%s}©¾¿¹œÎxÏ›]¶ÎºÌr†œêô×ÛguÛZI#ô]I…¼p’9Ç\nà5ÛİS§__gäÆÓ?{]£Íóñ¬ĞëZ¡n ÏQ‡ù\r_/¦¯%pã¢VÚ¡û˜?WËO”\"SşQXÖy{èå	%ûl9ä€1:l}‰<ÏeÔ\rMÕª7GÛÿ\0ê^¯Nh–ŠuØèrŒ	”jÕDRDÏÄ‡Kk‡şU	A-H\"€œ¿¸¤iN¨7]Û™E2Yß\ZÌÊ\ZúV;Zkx÷ñ(-p6c[@#Ù»- _uP\rU#šgÃÓÅ¯.ˆÈ%Ïp\'Ö¬…ºB1ÇÎa¶ŸwÓ •ÀnÍså/Š‹ÔÓ˜ÓYöüŞeötï´{>OCcö…p<=KJß-ã·[ñY¦]:n®&9\ZØlsx¾ÓÚ	öhì Ï\rÄ´1Wç1¶W¤aŒ2-]—ñYË>¶lç˜°êà8Çf‚YZÜpˆP47(yûÎ)‰¬ç‡³ÓÓÉ]vˆğøze=ñësíÍrkGêš}İÔ7/µŠíÅšË}˜[Ètn¦g\ZÒ¦\0-/9ˆÇ\\¹O·ÓÛ-ëX·ä·]kZÄZŞç·±–Gi÷³nŸpùu‰lÿ\0…µ¬p€]â`ˆ¯mz1ü¸s÷ùgÔåûÑYˆ«ØÖûzÕ¤Éw„ÚÄ×ZU¡º7o&Kyá‚İ¯a>!„ºi<G8†‡‡WÙ-^ÚVtıçŸ{#†q|¼»é9‹O>_¼ø.;ÚHu]©¯é0Ú™\"»²¹6öVòIßvÈmßâFæ¼¼IJÔ­´Ò×§T(ôàÚ-]•ˆ´pñhgVê„¬Ÿhl&úÍúâvŸøKµ;oqñaÆé¤«+ÜAf5p4]¥«-÷&\"¼yùç‡Æš£ıQJqœG.²Xt­û jvfòk½×w¦k¿·Õl´Ø¢³‘Ìs£Îc­ã·‡Œüş;¹–à¹i²mÕHáY1œLñõz¼<ÚÅ©šÌæsÃ‡Œx{\'ÇÅpÙÛëxj7rh;¹€k\Z-›ï·óíÅ¬³2îi ±Kq¼¾`$y^(	M\Zé6šÓ—«Ïãåó5Zki¤ÎyãÙÃ/?’û-Åî©(°Ó£}Äó8µ­f$d»€hâIÁoÛÖ±KÖü0Ê“6¬Ò8Êõ¯h¶ÚO·ÔÍ¹ÔeÚú«n¯šPÑg-c¼^\'Ÿ¡y½Æûníñá««E1ZùÄÃæÿ\0W­õ_ôÀà5|¥¹½Úò…#I¡áş”,µn¿ê~çÇşÁ->dCêwÊ#<¾ô‚•£¶&Ø4$:d5ôcØ“Ìğve@                                     Ô½[!ºnŒâhxòİ8+Óš\'“Fe5g/ò9Ğ5j *]/:G P@úå¨¥HöHÿ\0ˆKJuEÄkÛeÜ¤³¾Â´#à;¨²Ú½<üI²Ÿ8:•$ìí•š½¾áêUkOƒ_]âËØê|ªU[dÄÔŠc‰ô öÇáÖ]ı€²ƒêî½pú¼X×µÛV\'·¯¿ç/\'¸¯ûí>Ï“ĞÈœG:óıÕ…£Rêü£(<\0Åî\'AZVùtÇXïu‹[?Ñÿ\0(”ÜÊÃÍtÆµãÉËºÑN0±Ïu}¨Ä]rókl\Z^ÚƒRÁÄ¶:Öƒ´Ğ-;^vÄFgÓÅ][fñÇƒº½È½¶Ñº93Ë3‡Ş¸Ó€u(ÑÜÕ×¿E¯Sû9»¢soSÔÄqµÏ\"!+38â9ã_wv”û•Âö·V¼Ê]®‡{{‰ªÊt›Y\Z_Mhuä€Œ(ÇU±‚9¿ø+›Gqö¯5¬gåûû˜ö‘i‰‹pù¯‘Ëe¥Û{…·¹YàâÆ_+‡úI¤8½İç‡ 6‹}ş«Nf}84®5_ÊXõşª\Z_˜Ñ®«KI­;Šê¾¿µ²¶óg²f›2Ç´ı:ûq^NÛ&2BYø¦¬öåh-@{€’@0kxØÕÓÜl×moçáéóW¦gv~>¦ÍÓtÛ\rİğYF@x¸º–,Ä~yn\0v4`{Úûó>>’é×H×²b<XOQµşÃïkv¥ú¤I?šëIxrQ]X®ÈŸ“M¦/5õ¾pµœ5­Hp¤Ã‡ï\Z¾F^İy(ÚFˆ²Õ»?©ûŸŸêù+ó(T>Q«ıß:A€öl†‘Ì~	©íâ¦y£ÁÙe\0€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€ƒRõoù³G¨¨÷ÇWıÙW¢,ÑÔŠV W\nÔp8-TË‘LòĞ\ZS¶§€úPK•À±¼(æšR¸(4—U\\á¸ö«i˜×8ƒÃ3šĞ±ÛÉ¥>üIiığv“³í\r”ìy}Ãx*BÓà×÷8Í)å˜áßR¬ªÛ\'â‰{kğêo—ö>Gµ;³\\œiÂHù/s³™ëùËƒm3²gÙòwÆ]^ÖÚ‚\0n%q ú\0Ä­§µµ¹ğ‡=æ+<!A5õÕÀÍy8³ŠÌ4«éİ~•”R5ÏÏ§š´İ3Âeh¸½·µÍî‘xnpÆáä=ôíÄQ¾¥éé¬í3îôæ½±1Á£ºÓ®K¢lMKz}ııÏMõ7zZX@ùsŞÏ¤Ü–…±Ò6Q)k˜j\ZTÏİvñ8øÄÇèãÑi¥íÇ1ò˜·Ê%ÕÛ=[¬C@Ö-®n†ÜÔö=æ°/ú“¸XíOM‚Tj’}BOº1Ü4––.‘¬\",ù[™ô]¼ÏTRbg<q™ãÑ\\yÇóá|ænˆİ®mêÎ}WœÇÂ<=™g{n\r·¬n+fk0Ykº½¼·³nt¹îåŞ:«¤‘îÓô‹ëÉ4Ûhİ,-xsÃx.-]q\\c„DğÏşWú­çÓˆáÊQ¦b6ÌxN>¬ãHéˆğ™ã9ó÷±M;®İ]Õo6å¦¹t½Ã¦êztwûõûeÑA}&¡{¢Z_ZEj×·Â:[õˆŞò~ñÌm~¤¥ul¤Ód}8ˆÄxñú¦:¹ğ‰¬rğÇ”³ÛX§×=\\fcİÓëãÏÅ‘ôÿ\0«»ïrï‡h[æÂÆÒÛLt—\Z–2ZŞË,,®`×-äle‚+¹æš)\"’Aa°‡<=uı»mÕ7Ç˜Ç«—ºsíáÇ<Tï±[WœşXö;/¥mËg&£ª:K\ZCš(šK.®iÃ&a÷q×íœOÙÕû¾æ³ª\"¼mıı_l¤í¬_Ãñlg¾[hb·†;[kaH-aXÆ÷dó\'Ì¯:ñ;)×œÏœº6ÌtDÂÁ¨jCóªÚ(x×»±uZ¸­/÷^>›5æî³¹ÔöfûÕ}¹ª:Gº´ÌËIHo¤Ñ[¿¼jÌÇùV~E\"~ıf9>y5—WYÔÏ?\Z§ÖÆ¯‰—ĞG%j;¸\"V½Ù_Ù\rÌÿ\0/’Ÿ2©ÿ\0(nİ÷¤QkÇÛ, ŠSõ\\$|µª[š±ÉÙ•	j>®’4Í€?ãMIÿ\0VUéÍäĞÂ­q Ö Š0Æ¡jÍÜIÂ­¥{Q(]•Ì…¹ªCHÊ9ÔbƒIuYÿ\0®ö³	ÃÜ®I^{IXíi­ã÷Ä˜»ûàmp±û+ â@ğ[ïª¤->\r{uúi¨qÌì}jÈ[dáZññAìwÃò[qĞÒË›·ånéÖC-#ıx‰%Ä€+Ü*¾‡úûÌvñ3ÇŞó7Z#u¢gËäï‹õ&Â¹ÃîÁãÛ{R;ÒîK¾”ëşS•oŒpc×os²âsã‰î%i³·‰¯›¶&\'(-cºÕ*-!ñX\rtâùRš’¥a¯tiœZ}Ş?ú/kÆ!\\İ:ÂÊL÷~)w¬Dƒ³yÔ2¹ŸşuréÛkí®b:cã?²wk¬q2™6­tö´‹‡·ÀnHšÜl­rµ£\0;‚åíi´ÖVÓ¿«ƒºÖ&dcgqdŸ¤«4õâºû¼96Úuß0±\\İêz•×¹Ù2âşòfıÜ0ââÚKhÖ€ãW8Ñuì¥-Ûæf\"î\"oX˜ŒË2ÓvÕ½¬qË«Êİbõ¤HËz—Y[¼b\Zêx¯í—°Á^êÛi4¯ÿ\0îŸ„~-uê‹ëú¸Ïà¼Ü]½ìñ$y‘ÀûRIÇ±eÚW„ÒVÕnªÌK¼ÔBĞàrœ}4§­töšú¢ÔŸ\Z§4š©4İ2ãU>5Á,µŒÒGÓöZy•²#LÓÆMs·^\'Á~Şv-wN÷ñd^¬[XtqrÂÊZ×ò¯3ºÙÕ«3<]ÚëÕÑ1Ê%ó1«ã¬j<¾ôcşcWÎÛ›×JVÒµåÏ\n´nÏê†ääò„S¾P‡A:_•ıÛT\0×Â­é¡-ÍÉÙõ\0€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€ƒQu€‘£éN¦l·„‘şÍÊôæ‹4\\rœ]’®4æEpü«fi±âşĞ\Z+ÈcTÈûºSíaê¢%£º±_Çv¾‡N»¡¯Úl‚ƒ¹cµ¥A|Hœæóh;6pvvÊ9©@kNª‰ŸuŒÒWóÎõR-’wx õ›ÈuÀ‹¤W¹Gí.¨kºá‡búNÃ^{ZÏ®ß7Ïw·š÷6öWäïí¤WwìwºD_İ½Á‘4Î{°õ\n•´nsõ5¥æÊÿ\0Ã´Ëb_pïÅe{jCe³O£?×OBë×ÙË„~?³Kê¬Ç)3ßÊâÆ9àGèâ+\Z;\ZÁ€ù.Şß£ê‡Úk*	îCš$Ïíˆôvğ³´¿Tb]Q~º±Û½@DâçÖ\\OgyUß«íÚ,óú¾İø¹³Û·úÉ÷©¤v™¤J>êõÍ¬·¾ï¦oß\Z4w®­ıÅ\'_L}Vù{gÒ];uNÚç”zrgvv¶Zm£­4è=ÒOx-9¥œµ<‡ì`^f‹Íçã^¯c]N”‰.KZæŠWìGÕÍ[Ez6Í|%M3Ñi«º¾ÛqyuCG?Jê¥>Şø	eèÛ1á.4­\Z]JWMsXl>Óÿ\0çû,IS·oØİ8ç*ê®6ÏØÖ6LvV¶!omGƒÀëæ¼é¿EíòëÕX‹MqÁu6ò+nšõ r“¶uf2ŸåYÊ1ùW4k›RÑå–ºmş>·Ì†³†³©ÊaüF¯^­y(›U	Y÷gõGrîzñ>¨| ¹¯èKKx7fí¶eÄ€[¥Á^=üRÜÑàìê€@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@A¨:ÃOÂ4Š×ş4ÒŸêÜ´×Í[4	÷ƒQBèÁa¯zÕED s\npãÇ>DÇ·ˆ\0¸š^ÃÁŠêË©¯í‚áFşrˆ‘¤úÖ;ZQäÄmï>n6|o-ßfì˜Äm¯°=ÙÊI­OµUO¼˜5ÉûÙ?|ê|¿J‘m–‡‡¦È=xò˜:;-ÔÖÎ½»ı¥Õ¾îWnÀÇE—Øn/\'‰Ìh¾³úÈµ»*Æq··›ÂïuV{‹O9Ä|î—Qšg\n¾­‹êÄ\0dLıëFüÉ³·Š¹¦Ó	º0Ô’F ×Ÿ©N›Í\'ëÕ·«‚Ó=Ë…:W?¸½Y×«-õà·Z¾ïQ¹P>îæOhGú£óü\0æ\\BàÌh¶fqŸ­ç=3Í•Øí‹[\'½NHõ›øxí…]e	¦×ôÄvŸg¸«w=Äî¯Ó1øÏéótîíã·Ozı%ËåsàSÅwe8€ä¹;>L¯¦ıQ…™×9^æƒFŠ€8×¼­fŸon|ÜÕ·ÛÙ‰ä²İ]9À—š8ğ5ì <ıÕ11xFût^%S§èR^ŞßæÑ§Ùk}—ÊG&aƒ{]ò(ïwDDM9ü–İ¯8¿ƒ<e»Aˆ†E\rd,k áß~gFØÄÅ¼^İGlĞPi‡‘&\'ª,–è´[Í§z‹q5ŞÇê$´mÍQÁ§ºÒJŸñ.Õ}q>5Ÿ’”œoõKç+Z?®õLpñÿ\0ó\Z¾>^ärQ7»š%hİuı‘Ü¸ÿ\0Ø$õâ9¨SşPĞN˜¹¢ƒöCn7º­Òm *mÍÏ¨\Z‹¬Í\ZI§/û·-5óVÜ|kšg‚§6v\Z×¹l¢¤`øÚEcÄR¾•Y4Øæ9Ü©?•HÑ}ZËøÖ×ÃÚv™vã\0|ë\rÍ5¼€ø|Üí#ìÔìı•„_vesÍWÅo&\ruúIE*3Ÿ¤ ·I^$ñAëW×]Ü2Iç¦åÕ|9Ç9„“q˜/®şõ¯i3Êß7™ÜDÎÉÇ©İé}ıÃÙÒ®ÜîMğd§§êŠ¯Fc\\ó´|aÃ»U¼–›‹Ù­edw6ÓÛJãHÙ$niqìh#\ZöW&Í1Î³á­í®Ñ˜–Uc¶e¼+­eîÓ­Ia=î@8ƒ„ ÿ\0•Ww*ëïz~šqŸ9å«Ó×_¹Æx|ÿ\0fLÈ­ìm…•Œ²²ÍœÛÅRéùòÈ}©{¡s÷¶ÏªÓ™ôå¶Óíÿ\0—$Ï{ZĞG|}¿¸´í¦&1.wû•Z$›#ˆ¨\r­ä*«zı½™pÅ§]Ö{¹}ª3Ù\0Š’+ˆåŞ»wÒmX´İqÅ‘iÛx²óRùÚo`j	æ/`ìoÊ¹ö÷?s_M}óùC¦Ú¾å3fZ!20>JfÁ p\07†Š–ê§KZızÔ×WNk[ºy©A`¸×Ğ*UµS¯\\æT‰ê×rÆïtÉ|\\N“;[eiJYm´ı˜ú£0Ïf½—×L}èz¤8ê¤²tmfÖÕ$†”ÂÎRO—yÜë¾¼ÄñÄµ×ªİT¶=¯š½hşºÔûçşCWÌÏ7µ^JJŠóP•§u×öKrv{„Ÿ‘Õ”\'t¦ \ndÚ;qœA®]&Û8U-ÍÉÙÕ\0€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€ƒPu‡ù£IàëÇfôÉW×ÍäëÛH3ÀàppÁ½Õ ÑnÍ=ÃÚk°ph®ZpÇTj]ÀUô<ıjRÑ=W~moj´]¦Ş77\"LÄsà°Ü¾·_»èõ6;VxÁ£6¦ÎŠ@E=¨àk]BxŒ8ªx­äÅîE$”à=£­H·H+_¨=¸øqJøü¿¼6G5¿µºÙ1|8®ıQq>×Ÿ{ôî´{>ODb2¼g\rOÌ¶­£É¬OS™¢d¹#ÅÓñ{OkIÅ¦œÂÑ–Êg›¾´“J¼1ÕÏ‚è—ÛÊìIí<È<V”œñòpFu[Õ+tÄ89ù«œç¼píªõu[ª0ÛduUluÀn[ˆ#…yW¹sãíìqjÙÑl-3‰f{\"‰®’G±ÆÑW8ñ­æ»»ŠEéÔî“ÂĞÌ´½;1ÍĞmÆ£@æÇõ™§Õÿ\0)İü%Çÿ\0&vS¦8GÏöuk¤Z™l†(¨jïjARIå^>•É®Ø™ªÚ\'œJL¯uE´>Ü÷/€ñq<êÅo9åÍ]sÓi¯›,°ÓaÓbğ™íÌìn.¨Şî~Øâ¶Ù½çËÂZ5Æ¼Â~BìàğÓ¸ªÓ†a5pÀz2ô¯©Æ˜³ië4©ÿ\0Ø¥U4ÂuGzß,ÚÎ\ZÆ§†0ş#W¹»kÉ@Ò}#µUe§uT·\'}„•?\"!õKå\'öÓ¡ £·s†Šß„ÛW7iïIæ;6 iŞ²8·IÑ€ûW®¯ Dâ´×Í[ruù¿¦-C@×¼à{ÖÊ\'73†N$a@\rPC!¯p#ô„wPğúT\rÕ¢µµ¨\r°»\r\'…3·1Xîi­äÄV/Í¦Ñays†ÏÙeÌ¨ö+nÂ\Z)ÀR…SÅo&s„’ĞÖq\'Ö¤[ßÇ¿€íAí¯ÃòşLßÒÍs$‹ò/[·§VŠûgæò{˜˜İ3ê“º—wR·\\¼ñ=r2Ë­({­¼ö­\'ÙÄıI?Ó\Z`¼m–µwZ3lf8xG?/7™·tıÛDMâb+Ëøóğÿ\0òõ3-¸ÿ\0IŠO\ZúzÏrÚ‹<;ƒI\\([ù£ƒ;[EİÙì›kŒçßÍëv“ÕIœÌıSÏÛòòRnÛlÚ8º\rûËI˜æçû$zğ^7Ç›>ï_Ñ3ä×ÎŸ3CAàæî8®îŞóKb\\ú¶uDB†;K»ë\r¬Eîh9ÉöCGç=Ü\0«¼ˆèÏ§¹ívêÍYÆ¥Ûiì{ =ãÆI/œ(qÀ²1ö[ßÄ®ß;+3Â<?WvºÄ×+¤0†×}v¬9z\nç­ºo4OLôÊD³:„Rµvõy¯Mú‹OEıHtãî(H¥µ¼hâ°h>œT÷ÑÓ®\'ÎH¯ÿ\0±êg²Üæ´!®>ŠJ¯.óÊ]Öáh–Kók£‹­ón%~¶œHdñXßºk²Š–×êp9—‘KŞ–Õ[n©´òãÕ^îOµí;¢3xãù~ËïU@şËú¤Ì¥ƒöOYÃ³ù«Ø‡ÑR1y‡Ëµ³©Ó\nÌ?ˆÕÅnnªòPüUYhİCú\'¹ÕòSæP>ª¼£·/@ºYÃŸ·\r/Õ6¿/j™æˆv]@                                     Ó½c4ÒôAJƒzúÿ\0ºrÓ_5mÉ×æº’2•Á®§*­¡DÖš’\04q-#åª	QU­§×4ï§\Z3«gõÖÚ&¹Eá¥*CÁXîi­äoÄˆSÍ®Ê©ı‰Ù9ˆæ|ëùVp¼ø5íÅ|Y{Üj;1R…øöw ÷áÇ|½2N5İšèÊEÒEÈ½~ÖßéˆöüåÇ¶™¼Ï§\'w5M±¬j7²ÜÚï]OEµ|ldzm«Y‘„\n9Í&Ÿ\\âWuÙìİi˜Ù5(ˆy=×a³eú©²kPÊtk;6ÂŞÊëRŸY¸ƒ6}Fê,€º¢´üÑ€UÕªtÖ+36õÏ?{¯´¥´Ó¦Ö›Oœ©7ˆ¦ÚÔÑWB\0ôÈõ¿¯¶wW>¿“«|uk–µÒô{D²Y_îÖ1rF.§~Ñïàow1ªÙ3åú¼zj·VyC>e¼0Û²ŞÚ?\n&âîn{»^yŸ™sÖı|eéLE«ˆE|2j_e›a–™šÛ¥*s”µÀŸHæ¯²¾(Ù^›åi¹Ìârs©ŸY]¯U2ñÕ_ô/ûÇy>$¶î£;}+›ºÙ÷4â<%¾¸ÌDú™lÛH?m¥§Ö(W1ÕL7·Õ\\°ÏØm¾Ø´øÛÎM:ëßmI˜×Æöqq¦#Ø.ÿ\0Y¢cU±Ç\\æ¼yLóy·ş«DÒ¼ñê>+wVEz]Õµ´õšúìå^ÉÄG±éÏó‰ó|°k‚šÖ©Ëï†÷\\6æé¯%¹´ §5-;¨D÷&\'ş\\>DU^QÛN€ô°æÍ›hmÂ;¿TZà’¬rvYBD\Zs¬ŸÍZ.öÇÓ»îŠÓ_5mÉ Ÿ@æöŠ$âBİDF­Ê)g€9ñ%“#íT€I&´4VAüGk;†k Ğ9{@+\rÍu¼‹ø‘Ôy·Ù­.ŒÙ{$GJàß½½ë5§Á¯.1–L1Î~•\"…ø“ßÅx¼¹ùÜ›ËÏNÓØº]ğÕïõ_ÆŸª:ÈŸ~{bğ„/ú™x×Ó«|R¸œû±ù²s6™o)~*:À\0[tÀwÍ¯J‹l(µÿ\0•O+|côDêö-ÒüT7¡4ƒ¢;~<}“&³vï¢\0²¶êÏ„ücôR{yŸøOê´j_N¡j6“YIÑm¨ëiÇ:95Kó˜±Ù››+…F4M]Ìê·UsŸl~‹ı©Æ&İb¸øœuzZx]/ÙPŠDÃ> æ± `\0ÌÚ…¿üèÇñŸş¯ı¬¶v‘xçrÿ\0~¸[Ov4b”æÿ\0¥\n•ïzÇñ”Ó¶éÿ\0/Âé>%½~0mM‹l~ÓÅ¥Ü„ÿ\0\nqD¿{6ÿ\0øÊ?âFsÕ?Z®~#¾b®C²éÛ&Ø@¥K%;ı«Œ}jÓı„ôã¢=¹·ë…¯ÚÖñ‰™üöüD¼Ê1ÁÍ~Îİ¡Ö½‚?\0«ıúqˆøÛò’;ZÄc3ø8gÄ[Í<R:Hõ­¢×;\nşÎÇ@	à>ü,?äZcùş«ÓEkÊgÓÜ–ÿ\0ˆ·›G8–îİ±Hú¬ÛVÄüd%R6LzOêÓ¢0£?ß7DPoí\r€~fÚ°şP)×>™ıQöãZ5Ÿ>>kw•ªèZ¯Qté´rÎk\rNÚ=NˆÉosV¶:´–¸ŠŒB¹>Ü:™<òİ\\Iu;ƒçÙ¥}\0€€À*Ìåd-;‘+NèÚ{—¿O—ò ú¬ò“Cåÿ\0¥% Ÿ·)Cÿ\0tÚÖ½‰dC²j™ë1…è€ÿ\0ë wˆšãŠ¶–…q¡ˆRç·‡\Zâ·füÜ\rFg8Åª%#´\0Ãj„´‡VH{V`*}Òí£š°ßà×[È¯‰Í–È!áàì•J\Z‘÷<\nÎk»€²Ó\0\\hqR(Ü\r1ÿ\0R\nw=\'ˆA,AË•)Ç³·µ4ày÷ „öR‡\n ÃB¥@ÃPqBOêsAÆĞáÇ½4çò ç)Ç|§±\"„e§HQÁ@5ªNè¯ì¦å†->dU>QHşÀ:Y†cğ¶Üi\'íWH´5Ø¤¢—P4¿ZM4­Ö‡ß]ËşŒ­usRüšÆ²°ƒBÙ*;è¶Q€Ğå .u;PS\Z‡M_Í¦p1 DKIõl>Ò¡%ÂÎğ\n÷–K\rÍµ¼ø¹óa³2«²öXs@hÊ|…GJ§ŠÌ\n|d—¶qõ ¤p©ÄáÚ‚K±à8bh‚Yã‰¦(8ù»ûBG2\0íıÄğåD\0IÀTövB\rİÓ?.½UêÎ…}ºö®§iûCN¹÷9·äÔ ÑtÉ.Ö†Şâæ‚g3íd®\n³oámê§Bz™Ñ“£I¿48!Ò÷^vşçÒo\"Ôô›Ç3EìÀk#¨HÄW­¢IŒ5Â…Y=sOİ¯\0>AÅ½œOI@rA<Y÷IşŠnL?ìWÖªO\'²™|½t®®Ì#Ú[u­uk‡á‡•%ìê„ˆ4·Z›4.ë×;£+m^*] ë@ÓSí?1ÃÒµfš÷T=½Œõ÷WÒ‰S¹õƒ‹B\r)Õ³Kİµ\0ØŞ\Z!Ã æ°ßà×[È_‰Ï6;1ÄÕ’l”øM>Ï€¯UkûŒ%“5¾å\"ÄÔñÍÉ@•ËŸøb‚0î\n …Ô®ùPqOğúPKæq¨A˜t÷g\\uìm1¶Ÿ{k¶:#nx™w3Y+ÚGØËˆ=ª\'€ÙŞe:ƒ.ùê.©¶ìã=6é|Òí™ìöaie¦éO6Ş+â±÷Dd’B	5\0V8-nl»ÊõıÖñÔ·?—jå×{«Ú6¢lô©‰xÓ7&—hûİ#QÓë_A$$Éì½‡QUò+ÍÔö™24LĞÙ€Ë;G#M=À«ªã»ˆ@ùjôÓ‚iˆ4§o§µ4ä¡\0w ³nŒv¶ã¯->j|ˆ>©ü /İ.„Â?döï\ZŒÄèöd¸W‘ä’ˆvq@                                     Òİi iš~ÕëÇË[iñg± \Zì¥­¦µ=€Ê¶QËëšcQRÖf¯f\'‚%-Ô´Ö”…qú\r)Õ³Kí·«­/°<*2.}ş\rµ¼øœŞj:sí7û?Ù½ xgˆä³ky5¼î¤²aöÓÉH¤pï5A­qÂ¼ûTˆ3ràxwQ ş$ —^_ào+•>ezGÿ\0]i3œ¢Ü’Ö{í´ß{ô€İ\ZØ§ÿ\0ÈN‘ÈmåäĞSÌçI°¥ooÀîıYt¢ÿ\0ÆS^pë%È¥Íéÿ\0Ú®qÿ\0lõ1Ê<åOôú¡Îû0ìAÉáÆ€ñ¸ƒŒk†=È8¯@ğª4 rAfÜäşËn1ÿ\0wÍô ú­òˆ$\0évrOôKmä’²ÀU%ìÂ€@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@A¥zÖUèC¶õçäŒ­µx³»¯yÌĞC\\H5ÃŠÙDsÉY&Aiho¤aô ŠZ4ŠıŒ´\0ó òA£ººãø†ÖÌà¸ß•ÃìT®}íu<–ø‘e>jztF;d™iV»ÃvÕEœ.Ösş’J´i_J°§qÂ¸d •…\'%ƒ‰´§xÓ´©šT“½@‚”#·™A¹úÔİ³Ò-éø×zwPµ]ÀºÙ^6£6ŸøF§o.q|ÑÙ‰g±–AAÇŒ¦\'Áí¤t¯ª»âßmí&=¾İ›®æîğ\\n\rÑ}io,ä>êæI®%Ë½§R˜œ\Z9,ç\\ÇŒ­Õ•=§™}•Òıá<û{ÊWMvæğÚ÷Vqkº^«}3­îa/µ™Ö×LkÚá™¡íÁÍ5Uºba8—Sºº4½é»uMË£l§z~£áx;C@ñ=ÂİÑ°5ò3Åö‹¦w¶ş¼´F3™aTîÄzÔ ­1­(*ƒŠwãÚ‚*_\"qÂ¦ƒ¦PYw?õ_qrı_7ÉD%õ]å\r¹|¿ô¸ĞQûOnàk_Ô¶X¤¡Ù…\0€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€ƒHu¹ÙtÍ\0ğû%Ogİ•®©â¥İtÆ´5ãRå»4ùúZŒyO$ÊìÎb\\E;èA£ú¾æ‹ıªjK…é§´Êà°Ş×[Ê‰\Z<Ötìe¦mƒ²s6µÇÂ#ò,£šíe1¬’cöÒ¬)\\8Ÿ•BRÈæJ!ÁçJwòA¯£»Š:òã^Ô*8ùPC^Ü@åÜƒ‡†H×²F6F,xÌÓLEAAÀÊÖµ´\rcE\ZÀ(\0€€!A8aŠ\0Æ¸œ+ÚƒšÓ¼h¯q<‚;ûPq§a(,›˜×ln!^\Z|ÔôeAõWäùÙ¼½t´û_ÕM¼=®?ÌÖ_7bO4C³Š‹ë›Ãtİ¸	Á÷ÒŠvıÉZêæ¥ù:ßÓˆ­Héš«vj·’]6$ŒÄW™#J\\[™­¡ËìâŞ&€öö Ñe7QÚ‚¼,o›^GïëXok©åÄxæó]Ó AvÉAÿ\0DãÉe×jÉM$}x—B°\\H‡\Z¨º‚¼b%,Œ;=ƒ³ŸwbjÜN 4bO½±·5­å¹4MŸ¶ìÛ¨n\rËvÛÊIb·d·kœÖºiœÈãi9à-ñqåÌ»4‡Íµ´V³]Ö­6æ”æn\r:S½ÍàÛŸI@ cœó_`\\„0»ĞÎ¡n]xnh[¢h›Wcêòíí_ukš¤Z~Ÿu«B÷Ç%—4\"öF˜ÎoP\nTòXïß]4›Û8(™ŸdDq™-h¬fT:§IuİI“YÔ·Ø†ÌZÉyjØõ6Ë-Üq`}ÕgŞœŞÈË…W•£ûí;öFºkÛœÄNiˆ¬ÏıÜ~Ÿ>.z÷5´â\"~\rXi@îŞ#±{n„-¯\0p¯!ÍG\"ˆ“˜og4p»»pGu{ûĞq^õ ±îbfwş?£ê ú±ò„Ç3Ë×JC©ím\r´æÈÄ„hNÌ(}ëô†=?k;ìûüŞ²!8|•Zêæ¥ù:Ø.2çöşÅ;û~eĞË*¦\\	Ã\\ÓB;İP‰„É&&FÑí-\0†Óó¨x¡-Ö©rê{Xp&Òør®v\Z¹÷x5ÔòÓâ)#fó[Ó¶€@‡aì¨óõ‹a5#´Ue×ËXÍúByTÑH§ô\Zz¹)“ò¨Jğª!	Â¼=•8áNCŠ\r¿ĞŞ‰î¼ïví=.Yt½½¥Ûş%Ô\rÛ&s¤é-$9ñBÚºk‰‹Lvñ4çãÁ¥ï6Ë´ŞZOT´ó¯ôwvtWÊ§•ı§¸u~hº…ƒ­$|ìµ6ÌÔn^âßT¿t®y.ú•¥~±$4G›;«}óÓo,LÙº<ÚLµÍ½©hºÁOÃB×á»{¦·cZÖ°ÜÌÜŞ,¤f‘Í8ñSYÄæ}!18a·ÛCL×÷¼›^÷H:Ò¡§éÒ­İ4R»R’I~ïíÔJã^\\Êø­ØlíûO¿[tß¹Ûkfq1Ñ\"g«‡/ÙçÆÙ­:¢xŞÓ>å©›NÆÑÓ‹G\\É§·WÓ]6à{õĞ‰ÓÉ¢¶3+\\ì•lo•¥ 8cZ­§û[çÿ\0èœutÎ5ÇÓ\\â6ç<f+Ç0·İŸû¼qË—ş_³Po»}\ZËwë:´zeŸ­ífuÄ\r¹l7\")\\\\^Á1sA¯%ïÿ\0W³mûj[lÌÚs9˜Äã3Ó˜ğœ:´Úz\"mÏÓO\\Çñ.ö¢+êìõ ãÓ €ğÄÒ§Î@Û;…ÇäŠúE«Ï)\\Zô¦V·Lğîm6¦ÚŠhù‚4\r9ÀS‚[š#“²\n                                     Ñ>al_>Æ·Ô#fghÚ¼ïpäÉCíÏÊé\Z´Õ?R·äéC¯§-–PÃ€¨«+L\0ùK$ëmFw´1á´®¯#G`{¡5YÅ3T}ãë^8üà¨~ó¹.t»=·3Èeº†\ZŸÎ‰®ù9,¶ÆZRx¼õø…İ®¸t#{‡gÓ·?K6}í¼¼?áŸ=´Ãü×DVÂØi¢ZæS÷8Iôâ¥*r9ÎJ\'GEH’œ=\n\ZŠbp<@G1é/Úêİ[U×oÚ›£WÚò_66jé7“Yºá‘’èÛ)…Í.\r$0®Ô÷ïPu»[›\rkn]cO¾g‡}§Şê÷“ÛÎÊƒ’XŸ)cÅ@4p¢pŞßºÖ+¨Ş?M‚S=¶–ë™M¬s;KŞ$<ŞÖ‡ÔÏ#œù%’G¼—I#Şâç8ós‰«y)Pˆ„³.¯İ1Ã@*İSæ¶Q5­€5­Á¡¿B¬ñF@)Ï‚8BpZG0+Ï’xòô ã\\PAiµu¢nm‘Ò½¯“Zêf½c£Z²:f	\'a¸œƒÊ6Or\"_^6Ò­´£¦Ãg‚ÎFƒ§F\0Ü¡cm¬M\nÚÃ=é#<P,{›EqíıcC”µƒSµ’äp¨d„}ÛéÏ+Àw©LN\'$Æ^nŞA6™}y§ßAî×–S>ÚîÙüY,N-pì#˜<Âì‰Ï<Æñµäì¼†¸w…”,©©j×S—P`½IÙ°o}²í>6²;›œ\rXr¹ ÿ\0”Ò«hÊÕ—Müäô/TÜ¾Vvë··3î.÷“Ú]Cs>]£­NÙP\\}ÆìÑÄàÖ=Æ´\\ûk‰‰mIÌL:´5öëzD=bÔìšØ5g\n89€\0ğ?5Ã\ZªóZ9¥iÏŸ¡„ö“±@à`GgøqR€ğôcêP!8v‚\rIAÄÈÃJb=8ËÆ´5âƒŒ¤ğù9 ‹!¯DK‚Ú`M9ú!	,N´AhšItñòöÊ‰J7£z„Jíù±D$>ûOÈ@ıø?B|º½©¤vaúŒä€È¢&cƒC¤8\nÊä¼ù\nò‹ªhºµ§W:§Io¾÷U‘‹gir4²]E™¥·Z„±=¹­ß#áÛµÀ<—J€\'’¼ŞâA6°Cmoa··cb‚Š5¬`ÊÖØ\0¢ªSPu³­ı#ºÜm—víKq&½_­´¶àëèãht\\¼V4RŸlPqºë¿O5m\\º1q«>Òym®„–×–î1]ZÌÂÉ#{ps\\Ç\0Aˆ+x´KŒ f®×ÒfW^=ÊÙBª=b´w‰A^Ş&F_¢n(¢/&(/,SZê:eÛ%½İ­ËsÁ4NödV8µÍ8P¨˜‰Œ-0ó®ŞE·vØÔnw÷–ë;û±.éfØñ÷Ü.Ò[ˆOµ{hÃõÚ½¬ {M3KVk<[Å¢Î—I¬î].æM7[Ûz…†£nKg²¼°ºµ®æãRŒÂØ\\ ¼İ—”;3WºÍƒ|\r2şZÿ\0¢m%~°Úİ_Õåğ4¾–n‹Ù)Z¤\\kÃÄ©Ì¢ß£~d®Åmº!¼İCCú†ìcÙí´&`^àòßæºîB7Ÿ#C¤x}w\r·”?8÷4-è^è„8ñš+(©ŞsÎ(§\"ı‘ÿ\09™ú_udÍu©iÜI¸4=ÉîFax‡È›iˆ:6¦µÆ…×[Â0ßHiyæœ|ŒÂóÃ£Ì´knõİ‡f×}uFh8ÖŒ„•<|“˜^m>}`›Sªİ<ÒÚ~³ª^ÜĞú\"€$Dù+6…â?†çÈ}æ`Û»Œ‘²ÛT”ì>Í~E=6ò:¡[ÃO-\rç™=šĞ)œE£ê/#ÑY…Tt[Èê…Ößá»³c#ñ?2\Zt¬¯ÿ\0Û·pí§LRÇT.Œøvtj+ó	¯JÑ‰›rÙ¤ã2LGäûvG\\&!~]¬Ü×\\õ·zŞ3bf¦Â^AÅ ÔÓ)ûsæMáÚÎ‡y;éØÔô]¦ı?Ô¯õÍ*aqkÔ­ñ)¸dìÜYYelFò-c¨y·Šb#œ™™z]µ6–Õµ¸Ï&¡ªêOëzÕÆ3]Ï´ìNVŠœ­\nó$“Iœ¥•¨ïévÅß%Òî-¿oszZ\ZİR*Ãtx}ìtq§ ê…13˜ËIj¾RöeÑqÒõıWN5Ïá\\±½”£bvîV‹Ê½Ã/|¢ß°¸éÛÎŸÍ6®„úË/Ğ§î#¡ŠÍåw¨Ö/q´¾ÒïÀú®w0šñı$lâ­÷QĞ§´è‡[4kˆîìtÆ¾ê\n˜¯­5kyñåS(zTıØ:%™3gy‡¸s}¦‹ÙÌ­¹Ô\'Ò®\'5ı1{İAÉVm_%±+İ¾Ïó¼øôÆ¾Ìeõ¼|¤Q¼`ju×ÈÄªÇO|ÄÌğ÷ïX xú¯v¥1¦û6œTuÇ‘Ó*ì—®7g=÷R­Ãˆ¡\"æîCOH1ó)û‘ätÏš¡½êLÀ¾©HÅÌŠáÔõ›UsÔ“û»îY‰7]R¹$Š{6’;Ó‹®ÓîIÒ‹û´Ü<ı÷Ruƒ‰\r³Œcşt®O¹\'J®,úhÆç{êó¸~l6Ì;~urN˜\\‡–Í¦ğÁq¸5ÉCq9_jÂ}bß‚¹:aW–îŸÇõï5ÉİÍÏ¾¦”dm2Ÿ¹dôÂå—¾™3ëé×÷˜“Q»ÄöÕ²4¨ëŸ3¦zÒ¸MN×»ó¦»»yùæN©ó:ar‹£/‹ì­5Ãó^Ç<òâ	Q™1\n¶t£¦±ı]£WóiÊA)™0½i›/gè²™´­¤é³:•šÚÎŸ‡ùM`*2œ2dÿÙ');
/*!40000 ALTER TABLE `ost_file_chunk` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ost_filter`
--

DROP TABLE IF EXISTS `ost_filter`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `ost_filter` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `execorder` int(10) unsigned NOT NULL DEFAULT 99,
  `isactive` tinyint(1) unsigned NOT NULL DEFAULT 1,
  `flags` int(10) unsigned DEFAULT 0,
  `status` int(11) unsigned NOT NULL DEFAULT 0,
  `match_all_rules` tinyint(1) unsigned NOT NULL DEFAULT 0,
  `stop_onmatch` tinyint(1) unsigned NOT NULL DEFAULT 0,
  `target` enum('Any','Web','Email','API') NOT NULL DEFAULT 'Any',
  `email_id` int(10) unsigned NOT NULL DEFAULT 0,
  `name` varchar(32) NOT NULL DEFAULT '',
  `notes` text DEFAULT NULL,
  `created` datetime NOT NULL,
  `updated` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `target` (`target`),
  KEY `email_id` (`email_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ost_filter`
--

LOCK TABLES `ost_filter` WRITE;
/*!40000 ALTER TABLE `ost_filter` DISABLE KEYS */;
INSERT INTO `ost_filter` VALUES (1,99,1,0,0,0,0,'Email',0,'SYSTEM BAN LIST','Lista interna de e-mails banidos. NÃ£o remova','2026-07-01 10:26:32','2026-07-01 10:26:32');
/*!40000 ALTER TABLE `ost_filter` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ost_filter_action`
--

DROP TABLE IF EXISTS `ost_filter_action`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `ost_filter_action` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `filter_id` int(10) unsigned NOT NULL,
  `sort` int(10) unsigned NOT NULL DEFAULT 0,
  `type` varchar(24) NOT NULL,
  `configuration` text DEFAULT NULL,
  `updated` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `filter_id` (`filter_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ost_filter_action`
--

LOCK TABLES `ost_filter_action` WRITE;
/*!40000 ALTER TABLE `ost_filter_action` DISABLE KEYS */;
INSERT INTO `ost_filter_action` VALUES (1,1,1,'reject','[]','2026-07-01 10:26:32');
/*!40000 ALTER TABLE `ost_filter_action` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ost_filter_rule`
--

DROP TABLE IF EXISTS `ost_filter_rule`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `ost_filter_rule` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `filter_id` int(10) unsigned NOT NULL DEFAULT 0,
  `what` varchar(32) NOT NULL,
  `how` enum('equal','not_equal','contains','dn_contain','starts','ends','match','not_match') NOT NULL,
  `val` varchar(255) NOT NULL,
  `isactive` tinyint(1) unsigned NOT NULL DEFAULT 1,
  `notes` tinytext NOT NULL,
  `created` datetime NOT NULL,
  `updated` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `filter` (`filter_id`,`what`,`how`,`val`),
  KEY `filter_id` (`filter_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ost_filter_rule`
--

LOCK TABLES `ost_filter_rule` WRITE;
/*!40000 ALTER TABLE `ost_filter_rule` DISABLE KEYS */;
INSERT INTO `ost_filter_rule` VALUES (1,1,'email','equal','test@example.com',1,'','0000-00-00 00:00:00','2026-07-01 10:26:32');
/*!40000 ALTER TABLE `ost_filter_rule` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ost_form`
--

DROP TABLE IF EXISTS `ost_form`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `ost_form` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `pid` int(10) unsigned DEFAULT NULL,
  `type` varchar(8) NOT NULL DEFAULT 'G',
  `flags` int(10) unsigned NOT NULL DEFAULT 1,
  `title` varchar(255) NOT NULL,
  `instructions` varchar(512) DEFAULT NULL,
  `name` varchar(64) NOT NULL DEFAULT '',
  `notes` text DEFAULT NULL,
  `created` datetime NOT NULL,
  `updated` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `type` (`type`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ost_form`
--

LOCK TABLES `ost_form` WRITE;
/*!40000 ALTER TABLE `ost_form` DISABLE KEYS */;
INSERT INTO `ost_form` VALUES (1,NULL,'U',1,'InformaÃ§Ãµes de contato',NULL,'',NULL,'2026-07-01 10:26:32','2026-07-01 10:26:32'),(2,NULL,'T',1,'Detalhes do chamado','Por favor, descreva seu problema','','Este formulÃ¡rio serÃ¡ anexado a cada chamado, independentemente de sua origem. VocÃª pode adicionar qualquer campo a este formulÃ¡rio e ele estarÃ¡ disponÃ­veis para todos os chamados, sendo possÃ­vel efetuar pesquisas avanÃ§adas e filtrÃ¡veis.','2026-07-01 10:26:32','2026-07-01 10:26:32'),(3,NULL,'C',1,'InformaÃ§Ã£o da Empresa','Detalhes disponÃ­veis em modelos de e-mail','',NULL,'2026-07-01 10:26:32','2026-07-01 10:26:32'),(4,NULL,'O',1,'InformaÃ§Ãµes da OrganizaÃ§Ã£o','Detalhes da organizaÃ§Ã£o do usuÃ¡rio','',NULL,'2026-07-01 10:26:32','2026-07-01 10:26:32'),(5,NULL,'A',1,'Detalhes da Tarefa','Por Favor, Descreva o Problema','','Este formulÃ¡rio Ã© usado para criar uma tarefa.','2026-07-01 10:26:32','2026-07-01 10:26:32'),(6,NULL,'L1',0,'Propriedade do Status do Ticket','Propriedade que podem ser definidos no status do ticket.','',NULL,'2026-07-01 10:26:32','2026-07-01 10:26:32'),(7,NULL,'G',1,'Fotos e Anexos','Anexe fotos do(s) equipamento(s), etiqueta de sÃ©rie ou nota fiscal (opcional).','',NULL,'2026-07-01 11:11:22','2026-07-01 11:11:22');
/*!40000 ALTER TABLE `ost_form` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ost_form_entry`
--

DROP TABLE IF EXISTS `ost_form_entry`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `ost_form_entry` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `form_id` int(11) unsigned NOT NULL,
  `object_id` int(11) unsigned DEFAULT NULL,
  `object_type` char(1) NOT NULL DEFAULT 'T',
  `sort` int(11) unsigned NOT NULL DEFAULT 1,
  `extra` text DEFAULT NULL,
  `created` datetime NOT NULL,
  `updated` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `entry_lookup` (`object_type`,`object_id`)
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ost_form_entry`
--

LOCK TABLES `ost_form_entry` WRITE;
/*!40000 ALTER TABLE `ost_form_entry` DISABLE KEYS */;
INSERT INTO `ost_form_entry` VALUES (1,4,1,'O',1,NULL,'2026-07-01 10:26:32','2026-07-01 10:26:32'),(2,3,NULL,'C',1,NULL,'2026-07-01 10:26:33','2026-07-01 10:26:33'),(3,1,1,'U',1,NULL,'2026-07-01 10:26:33','2026-07-01 10:26:33'),(5,1,2,'U',1,NULL,'2026-07-01 10:31:48','2026-07-01 10:31:48'),(9,1,3,'U',1,NULL,'2026-07-01 15:30:41','2026-07-01 15:30:41'),(19,1,4,'U',1,NULL,'2026-07-03 14:26:21','2026-07-03 14:26:21'),(25,2,18,'T',1,NULL,'2026-07-03 22:59:06','2026-07-03 22:59:06'),(26,2,19,'T',1,NULL,'2026-07-06 07:32:28','2026-07-06 07:32:28'),(27,2,20,'T',1,NULL,'2026-07-07 17:28:09','2026-07-07 17:28:09'),(28,2,21,'T',1,NULL,'2026-07-13 13:26:47','2026-07-13 13:26:47');
/*!40000 ALTER TABLE `ost_form_entry` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ost_form_entry_values`
--

DROP TABLE IF EXISTS `ost_form_entry_values`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `ost_form_entry_values` (
  `entry_id` int(11) unsigned NOT NULL,
  `field_id` int(11) unsigned NOT NULL,
  `value` text DEFAULT NULL,
  `value_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`entry_id`,`field_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ost_form_entry_values`
--

LOCK TABLES `ost_form_entry_values` WRITE;
/*!40000 ALTER TABLE `ost_form_entry_values` DISABLE KEYS */;
INSERT INTO `ost_form_entry_values` VALUES (2,23,'ZKTeco - ManutenÃ§Ã£o',NULL),(2,24,NULL,NULL),(2,25,NULL,NULL),(2,26,NULL,NULL),(5,3,'31997910742',NULL),(5,4,NULL,NULL),(9,3,'11999999999',NULL),(9,4,NULL,NULL),(19,3,'31996270810',NULL),(19,4,NULL,NULL),(25,20,'ManutenÃ§Ã£o â€” v5l (S/N 1234)',NULL),(25,22,'Normal',2),(25,42,NULL,NULL),(26,20,'ManutenÃ§Ã£o â€” 4 equipamentos: V5L, V4L, Proma, Proface',NULL),(26,22,'Normal',2),(26,42,NULL,NULL),(27,20,'ManutenÃ§Ã£o â€” V5L (S/N 872347376)',NULL),(27,22,'Normal',2),(27,42,NULL,NULL),(28,20,'ManutenÃ§Ã£o â€” V3L Lite (S/N 24234234)',NULL),(28,22,'Normal',2),(28,42,NULL,NULL);
/*!40000 ALTER TABLE `ost_form_entry_values` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ost_form_field`
--

DROP TABLE IF EXISTS `ost_form_field`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `ost_form_field` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `form_id` int(11) unsigned NOT NULL,
  `flags` int(10) unsigned DEFAULT 1,
  `type` varchar(255) NOT NULL DEFAULT 'text',
  `label` varchar(255) NOT NULL,
  `name` varchar(64) NOT NULL,
  `configuration` text DEFAULT NULL,
  `sort` int(11) unsigned NOT NULL,
  `hint` varchar(512) DEFAULT NULL,
  `created` datetime NOT NULL,
  `updated` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `form_id` (`form_id`),
  KEY `sort` (`sort`)
) ENGINE=InnoDB AUTO_INCREMENT=43 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ost_form_field`
--

LOCK TABLES `ost_form_field` WRITE;
/*!40000 ALTER TABLE `ost_form_field` DISABLE KEYS */;
INSERT INTO `ost_form_field` VALUES (1,1,489395,'text','EndereÃ§o de e-mail','email','{\"size\":40,\"length\":64,\"validator\":\"email\"}',1,NULL,'2026-07-01 10:26:32','2026-07-01 10:26:32'),(2,1,489395,'text','Nome completo','name','{\"size\":40,\"length\":64}',2,NULL,'2026-07-01 10:26:32','2026-07-01 10:26:32'),(3,1,13057,'phone','Telefone/WhatsApp','phone','{\"ext\":false}',3,NULL,'2026-07-01 10:26:32','2026-07-01 10:26:32'),(4,1,12289,'memo','Notas internas','notes','{\"rows\":4,\"cols\":40}',4,NULL,'2026-07-01 10:26:32','2026-07-01 10:26:32'),(20,2,489265,'text','Resumo do Problema','subject','{\"size\":40,\"length\":70}',1,NULL,'2026-07-01 10:26:32','2026-07-01 10:26:32'),(21,2,480547,'thread','Detalhes do Problema','message',NULL,2,'Detalhes sobre o (s)motivo (s)para a abertura do chamado.','2026-07-01 10:26:32','2026-07-01 10:26:32'),(22,2,274609,'priority','NÃ­vel de prioridade','priority',NULL,3,NULL,'2026-07-01 10:26:32','2026-07-01 10:26:32'),(23,3,291249,'text','Nome da Empresa','name','{\"size\":40,\"length\":64}',1,NULL,'2026-07-01 10:26:32','2026-07-01 10:26:32'),(24,3,274705,'text','Website','website','{\"size\":40,\"length\":64}',2,NULL,'2026-07-01 10:26:32','2026-07-01 10:26:32'),(25,3,274705,'phone','NÃºmero do Telefone','phone','{\"ext\":false}',3,NULL,'2026-07-01 10:26:32','2026-07-01 10:26:32'),(26,3,12545,'memo','EndereÃ§o','address','{\"rows\":2,\"cols\":40,\"html\":false,\"length\":100}',4,NULL,'2026-07-01 10:26:32','2026-07-01 10:26:32'),(27,4,489395,'text','Nome','name','{\"size\":40,\"length\":64}',1,NULL,'2026-07-01 10:26:32','2026-07-01 10:26:32'),(28,4,13057,'memo','EndereÃ§o','address','{\"rows\":2,\"cols\":40,\"length\":100,\"html\":false}',2,NULL,'2026-07-01 10:26:32','2026-07-01 10:26:32'),(29,4,13057,'phone','Telefone','phone',NULL,3,NULL,'2026-07-01 10:26:32','2026-07-01 10:26:32'),(30,4,13057,'text','Website','website','{\"size\":40,\"length\":0}',4,NULL,'2026-07-01 10:26:32','2026-07-01 10:26:32'),(31,4,12289,'memo','Notas internas','notes','{\"rows\":4,\"cols\":40}',5,NULL,'2026-07-01 10:26:32','2026-07-01 10:26:32'),(32,5,487601,'text','TÃ­tulo','title','{\"size\":40,\"length\":50}',1,NULL,'2026-07-01 10:26:32','2026-07-01 10:26:32'),(33,5,413939,'thread','DescriÃ§Ã£o','description',NULL,2,'Detalhes do(s) motivo(s) da criaÃ§Ã£o da tarefa.','2026-07-01 10:26:32','2026-07-01 10:26:32'),(34,6,487665,'state','Estado','state','{\"prompt\":\"Estado do ticket\"}',1,NULL,'2026-07-01 10:26:32','2026-07-01 10:26:32'),(35,6,471073,'memo','DescriÃ§Ã£o','description','{\"rows\":\"2\",\"cols\":\"40\",\"html\":\"\",\"length\":\"100\"}',3,NULL,'2026-07-01 10:26:32','2026-07-01 10:26:32'),(41,7,13057,'files','Fotos do equipamento','equip_fotos','{\"size\":8388608,\"mimetypes\":{\"image\":\"Images\"},\"extensions\":\"\",\"max\":2}',1,'Anexe atÃ© 2 fotos. No celular Ã© possÃ­vel tirar a foto na hora pela cÃ¢mera.','2026-07-01 13:47:50','2026-07-01 13:47:50'),(42,2,13057,'memo','ObservaÃ§Ãµes','observacoes','{\"rows\":3,\"cols\":40}',4,NULL,'2026-07-01 13:47:50','2026-07-01 13:47:50');
/*!40000 ALTER TABLE `ost_form_field` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ost_group`
--

DROP TABLE IF EXISTS `ost_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `ost_group` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `role_id` int(11) unsigned NOT NULL,
  `flags` int(11) unsigned NOT NULL DEFAULT 1,
  `name` varchar(120) NOT NULL DEFAULT '',
  `notes` text DEFAULT NULL,
  `created` datetime NOT NULL,
  `updated` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `role_id` (`role_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ost_group`
--

LOCK TABLES `ost_group` WRITE;
/*!40000 ALTER TABLE `ost_group` DISABLE KEYS */;
/*!40000 ALTER TABLE `ost_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ost_help_topic`
--

DROP TABLE IF EXISTS `ost_help_topic`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `ost_help_topic` (
  `topic_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `topic_pid` int(10) unsigned NOT NULL DEFAULT 0,
  `ispublic` tinyint(1) unsigned NOT NULL DEFAULT 1,
  `noautoresp` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `flags` int(10) unsigned DEFAULT 0,
  `status_id` int(10) unsigned NOT NULL DEFAULT 0,
  `priority_id` int(10) unsigned NOT NULL DEFAULT 0,
  `dept_id` int(10) unsigned NOT NULL DEFAULT 0,
  `staff_id` int(10) unsigned NOT NULL DEFAULT 0,
  `team_id` int(10) unsigned NOT NULL DEFAULT 0,
  `sla_id` int(10) unsigned NOT NULL DEFAULT 0,
  `page_id` int(10) unsigned NOT NULL DEFAULT 0,
  `sequence_id` int(10) unsigned NOT NULL DEFAULT 0,
  `sort` int(10) unsigned NOT NULL DEFAULT 0,
  `topic` varchar(128) NOT NULL DEFAULT '',
  `number_format` varchar(32) DEFAULT NULL,
  `notes` text DEFAULT NULL,
  `created` datetime NOT NULL,
  `updated` datetime NOT NULL,
  PRIMARY KEY (`topic_id`),
  UNIQUE KEY `topic` (`topic`,`topic_pid`),
  KEY `topic_pid` (`topic_pid`),
  KEY `priority_id` (`priority_id`),
  KEY `dept_id` (`dept_id`),
  KEY `staff_id` (`staff_id`,`team_id`),
  KEY `sla_id` (`sla_id`),
  KEY `page_id` (`page_id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ost_help_topic`
--

LOCK TABLES `ost_help_topic` WRITE;
/*!40000 ALTER TABLE `ost_help_topic` DISABLE KEYS */;
INSERT INTO `ost_help_topic` VALUES (1,0,1,0,2,0,2,3,0,0,0,0,0,1,'SolicitaÃ§Ã£o de ManutenÃ§Ã£o',NULL,'Perguntas sobre produtos ou serviÃ§os','2026-07-01 10:26:32','2026-07-01 10:26:32');
/*!40000 ALTER TABLE `ost_help_topic` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ost_help_topic_form`
--

DROP TABLE IF EXISTS `ost_help_topic_form`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `ost_help_topic_form` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `topic_id` int(11) unsigned NOT NULL DEFAULT 0,
  `form_id` int(10) unsigned NOT NULL DEFAULT 0,
  `sort` int(10) unsigned NOT NULL DEFAULT 1,
  `extra` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `topic-form` (`topic_id`,`form_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ost_help_topic_form`
--

LOCK TABLES `ost_help_topic_form` WRITE;
/*!40000 ALTER TABLE `ost_help_topic_form` DISABLE KEYS */;
/*!40000 ALTER TABLE `ost_help_topic_form` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ost_list`
--

DROP TABLE IF EXISTS `ost_list`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `ost_list` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `name_plural` varchar(255) DEFAULT NULL,
  `sort_mode` enum('Alpha','-Alpha','SortCol') NOT NULL DEFAULT 'Alpha',
  `masks` int(11) unsigned NOT NULL DEFAULT 0,
  `type` varchar(16) DEFAULT NULL,
  `configuration` text NOT NULL DEFAULT '',
  `notes` text DEFAULT NULL,
  `created` datetime NOT NULL,
  `updated` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `type` (`type`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ost_list`
--

LOCK TABLES `ost_list` WRITE;
/*!40000 ALTER TABLE `ost_list` DISABLE KEYS */;
INSERT INTO `ost_list` VALUES (1,'Status do Chamado','Status do ticket','SortCol',13,'ticket-status','{\"handler\":\"TicketStatusList\"}','Status do ticket','2026-07-01 10:26:32','2026-07-01 10:26:32');
/*!40000 ALTER TABLE `ost_list` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ost_list_items`
--

DROP TABLE IF EXISTS `ost_list_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `ost_list_items` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `list_id` int(11) DEFAULT NULL,
  `status` int(11) unsigned NOT NULL DEFAULT 1,
  `value` varchar(255) NOT NULL,
  `extra` varchar(255) DEFAULT NULL,
  `sort` int(11) NOT NULL DEFAULT 1,
  `properties` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `list_item_lookup` (`list_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ost_list_items`
--

LOCK TABLES `ost_list_items` WRITE;
/*!40000 ALTER TABLE `ost_list_items` DISABLE KEYS */;
/*!40000 ALTER TABLE `ost_list_items` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ost_lock`
--

DROP TABLE IF EXISTS `ost_lock`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `ost_lock` (
  `lock_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `staff_id` int(10) unsigned NOT NULL DEFAULT 0,
  `expire` datetime DEFAULT NULL,
  `code` varchar(20) DEFAULT NULL,
  `created` datetime NOT NULL,
  PRIMARY KEY (`lock_id`),
  KEY `staff_id` (`staff_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ost_lock`
--

LOCK TABLES `ost_lock` WRITE;
/*!40000 ALTER TABLE `ost_lock` DISABLE KEYS */;
/*!40000 ALTER TABLE `ost_lock` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ost_note`
--

DROP TABLE IF EXISTS `ost_note`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `ost_note` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `pid` int(11) unsigned DEFAULT NULL,
  `staff_id` int(11) unsigned NOT NULL DEFAULT 0,
  `ext_id` varchar(10) DEFAULT NULL,
  `body` text DEFAULT NULL,
  `status` int(11) unsigned NOT NULL DEFAULT 0,
  `sort` int(11) unsigned NOT NULL DEFAULT 0,
  `created` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `ext_id` (`ext_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ost_note`
--

LOCK TABLES `ost_note` WRITE;
/*!40000 ALTER TABLE `ost_note` DISABLE KEYS */;
/*!40000 ALTER TABLE `ost_note` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ost_organization`
--

DROP TABLE IF EXISTS `ost_organization`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `ost_organization` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(128) NOT NULL DEFAULT '',
  `manager` varchar(16) NOT NULL DEFAULT '',
  `status` int(11) unsigned NOT NULL DEFAULT 0,
  `domain` varchar(256) NOT NULL DEFAULT '',
  `extra` text DEFAULT NULL,
  `created` timestamp NULL DEFAULT NULL,
  `updated` timestamp NULL DEFAULT NULL ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ost_organization`
--

LOCK TABLES `ost_organization` WRITE;
/*!40000 ALTER TABLE `ost_organization` DISABLE KEYS */;
INSERT INTO `ost_organization` VALUES (1,'osTicket','',8,'',NULL,'2026-07-01 13:26:32',NULL);
/*!40000 ALTER TABLE `ost_organization` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ost_organization__cdata`
--

DROP TABLE IF EXISTS `ost_organization__cdata`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `ost_organization__cdata` (
  `org_id` int(11) unsigned NOT NULL,
  `name` mediumtext DEFAULT NULL,
  `address` mediumtext DEFAULT NULL,
  `phone` mediumtext DEFAULT NULL,
  `website` mediumtext DEFAULT NULL,
  `notes` mediumtext DEFAULT NULL,
  PRIMARY KEY (`org_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ost_organization__cdata`
--

LOCK TABLES `ost_organization__cdata` WRITE;
/*!40000 ALTER TABLE `ost_organization__cdata` DISABLE KEYS */;
/*!40000 ALTER TABLE `ost_organization__cdata` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ost_plugin`
--

DROP TABLE IF EXISTS `ost_plugin`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `ost_plugin` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(30) NOT NULL,
  `install_path` varchar(60) NOT NULL,
  `isphar` tinyint(1) NOT NULL DEFAULT 0,
  `isactive` tinyint(1) NOT NULL DEFAULT 0,
  `version` varchar(64) DEFAULT NULL,
  `notes` text DEFAULT NULL,
  `installed` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `install_path` (`install_path`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ost_plugin`
--

LOCK TABLES `ost_plugin` WRITE;
/*!40000 ALTER TABLE `ost_plugin` DISABLE KEYS */;
/*!40000 ALTER TABLE `ost_plugin` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ost_plugin_instance`
--

DROP TABLE IF EXISTS `ost_plugin_instance`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `ost_plugin_instance` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `plugin_id` int(11) unsigned NOT NULL,
  `flags` int(10) NOT NULL DEFAULT 0,
  `name` varchar(128) NOT NULL DEFAULT '',
  `notes` text DEFAULT NULL,
  `created` datetime NOT NULL,
  `updated` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `plugin_id` (`plugin_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ost_plugin_instance`
--

LOCK TABLES `ost_plugin_instance` WRITE;
/*!40000 ALTER TABLE `ost_plugin_instance` DISABLE KEYS */;
/*!40000 ALTER TABLE `ost_plugin_instance` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ost_queue`
--

DROP TABLE IF EXISTS `ost_queue`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `ost_queue` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `parent_id` int(11) unsigned NOT NULL DEFAULT 0,
  `columns_id` int(11) unsigned DEFAULT NULL,
  `sort_id` int(11) unsigned DEFAULT NULL,
  `flags` int(11) unsigned NOT NULL DEFAULT 0,
  `staff_id` int(11) unsigned NOT NULL DEFAULT 0,
  `sort` int(11) unsigned NOT NULL DEFAULT 0,
  `title` varchar(60) DEFAULT NULL,
  `config` text DEFAULT NULL,
  `filter` varchar(64) DEFAULT NULL,
  `root` varchar(32) DEFAULT NULL,
  `path` varchar(80) NOT NULL DEFAULT '/',
  `created` datetime NOT NULL,
  `updated` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `staff_id` (`staff_id`),
  KEY `parent_id` (`parent_id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ost_queue`
--

LOCK TABLES `ost_queue` WRITE;
/*!40000 ALTER TABLE `ost_queue` DISABLE KEYS */;
INSERT INTO `ost_queue` VALUES (1,0,NULL,1,3,0,1,'Aberto','[[\"status__state\",\"includes\",{\"open\":\"Open\"}]]',NULL,'T','/','2026-07-01 10:26:32','0000-00-00 00:00:00'),(2,1,NULL,4,43,0,1,'Aberto','{\"criteria\":[[\"isanswered\",\"nset\",null]],\"conditions\":[]}',NULL,'T','/','2026-07-01 10:26:32','0000-00-00 00:00:00'),(3,1,NULL,4,43,0,2,'Respondidos','{\"criteria\":[[\"isanswered\",\"set\",null]],\"conditions\":[]}',NULL,'T','/','2026-07-01 10:26:32','0000-00-00 00:00:00'),(4,1,NULL,4,43,0,3,'Atrasado','{\"criteria\":[[\"isoverdue\",\"set\",null]],\"conditions\":[]}',NULL,'T','/','2026-07-01 10:26:32','0000-00-00 00:00:00'),(5,0,NULL,3,3,0,3,'Meus Chamados','{\"criteria\":[[\"assignee\",\"includes\",{\"M\":\"Me\",\"T\":\"One of my teams\"}],[\"status__state\",\"includes\",{\"open\":\"Open\"}]],\"conditions\":[]}',NULL,'T','/','2026-07-01 10:26:32','0000-00-00 00:00:00'),(6,5,NULL,NULL,43,0,1,'AtribuÃ­do a mim','{\"criteria\":[[\"assignee\",\"includes\",{\"M\":\"Me\"}]],\"conditions\":[]}',NULL,'T','/','2026-07-01 10:26:32','0000-00-00 00:00:00'),(7,5,NULL,NULL,43,0,2,'Equipes AtribuÃ­dos','{\"criteria\":[[\"assignee\",\"!includes\",{\"M\":\"Me\"}]],\"conditions\":[]}',NULL,'T','/','2026-07-01 10:26:32','0000-00-00 00:00:00'),(8,0,NULL,5,3,0,4,'Encerrado','{\"criteria\":[[\"status__state\",\"includes\",{\"closed\":\"Closed\"}]],\"conditions\":[]}',NULL,'T','/','2026-07-01 10:26:32','0000-00-00 00:00:00'),(9,8,NULL,5,43,0,1,'Hoje','{\"criteria\":[[\"closed\",\"period\",\"td\"]],\"conditions\":[]}',NULL,'T','/','2026-07-01 10:26:32','0000-00-00 00:00:00'),(10,8,NULL,5,43,0,2,'Ontem','{\"criteria\":[[\"closed\",\"period\",\"yd\"]],\"conditions\":[]}',NULL,'T','/','2026-07-01 10:26:32','0000-00-00 00:00:00'),(11,8,NULL,5,43,0,3,'Esta semana','{\"criteria\":[[\"closed\",\"period\",\"tw\"]],\"conditions\":[]}',NULL,'T','/','2026-07-01 10:26:32','0000-00-00 00:00:00'),(12,8,NULL,5,43,0,4,'Este mÃªs','{\"criteria\":[[\"closed\",\"period\",\"tm\"]],\"conditions\":[]}',NULL,'T','/','2026-07-01 10:26:32','0000-00-00 00:00:00'),(13,8,NULL,6,43,0,5,'Este trimestre','{\"criteria\":[[\"closed\",\"period\",\"tq\"]],\"conditions\":[]}',NULL,'T','/','2026-07-01 10:26:32','0000-00-00 00:00:00'),(14,8,NULL,7,43,0,6,'Este ano','{\"criteria\":[[\"closed\",\"period\",\"ty\"]],\"conditions\":[]}',NULL,'T','/','2026-07-01 10:26:32','0000-00-00 00:00:00');
/*!40000 ALTER TABLE `ost_queue` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ost_queue_column`
--

DROP TABLE IF EXISTS `ost_queue_column`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `ost_queue_column` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `flags` int(10) unsigned NOT NULL DEFAULT 0,
  `name` varchar(64) NOT NULL DEFAULT '',
  `primary` varchar(64) NOT NULL DEFAULT '',
  `secondary` varchar(64) DEFAULT NULL,
  `filter` varchar(32) DEFAULT NULL,
  `truncate` varchar(16) DEFAULT NULL,
  `annotations` text DEFAULT NULL,
  `conditions` text DEFAULT NULL,
  `extra` text DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ost_queue_column`
--

LOCK TABLES `ost_queue_column` WRITE;
/*!40000 ALTER TABLE `ost_queue_column` DISABLE KEYS */;
INSERT INTO `ost_queue_column` VALUES (1,0,'NÃºmero do Chamado','number',NULL,'link:ticketP','wrap','[{\"c\":\"TicketSourceDecoration\",\"p\":\"b\"}]','[{\"crit\":[\"isanswered\",\"nset\",null],\"prop\":{\"font-weight\":\"bold\"}}]',NULL),(2,0,'Data de CriaÃ§Ã£o','created',NULL,'date:full','wrap','[]','[]',NULL),(3,0,'Assunto','cdata__subject',NULL,'link:ticket','ellipsis','[{\"c\":\"TicketThreadCount\",\"p\":\">\"},{\"c\":\"ThreadAttachmentCount\",\"p\":\"a\"},{\"c\":\"OverdueFlagDecoration\",\"p\":\"<\"},{\"c\":\"LockDecoration\",\"p\":\"<\"}]','[{\"crit\":[\"isanswered\",\"nset\",null],\"prop\":{\"font-weight\":\"bold\"}}]',NULL),(4,0,'Nome de UsuÃ¡rio','user__name',NULL,NULL,'wrap','[{\"c\":\"ThreadCollaboratorCount\",\"p\":\">\"}]','[]',NULL),(5,0,'Prioridade','cdata__priority',NULL,NULL,'wrap','[]','[]',NULL),(6,0,'Status','status__id',NULL,NULL,'wrap','[]','[]',NULL),(7,0,'Data de ConclusÃ£o','closed',NULL,'date:full','wrap','[]','[]',NULL),(8,0,'Designado','assignee',NULL,NULL,'wrap','[]','[]',NULL),(9,0,'Data de Vencimento','duedate','est_duedate','date:human','wrap','[]','[]',NULL),(10,0,'Ãšltima AtualizaÃ§Ã£o','lastupdate',NULL,'date:full','wrap','[]','[]',NULL),(11,0,'Departamento','dept_id',NULL,NULL,'wrap','[]','[]',NULL),(12,0,'Ãšltima Mensagem','thread__lastmessage',NULL,'date:human','wrap','[]','[]',NULL),(13,0,'Ãšltima Resposta','thread__lastresponse',NULL,'date:human','wrap','[]','[]',NULL),(14,0,'Equipe','team_id',NULL,NULL,'wrap','[]','[]',NULL);
/*!40000 ALTER TABLE `ost_queue_column` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ost_queue_columns`
--

DROP TABLE IF EXISTS `ost_queue_columns`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `ost_queue_columns` (
  `queue_id` int(11) unsigned NOT NULL,
  `column_id` int(11) unsigned NOT NULL,
  `staff_id` int(11) unsigned NOT NULL,
  `bits` int(10) unsigned NOT NULL DEFAULT 0,
  `sort` int(10) unsigned NOT NULL DEFAULT 1,
  `heading` varchar(64) DEFAULT NULL,
  `width` int(10) unsigned NOT NULL DEFAULT 100,
  PRIMARY KEY (`queue_id`,`column_id`,`staff_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ost_queue_columns`
--

LOCK TABLES `ost_queue_columns` WRITE;
/*!40000 ALTER TABLE `ost_queue_columns` DISABLE KEYS */;
INSERT INTO `ost_queue_columns` VALUES (1,1,0,1,1,'Ticket',100),(1,3,0,1,4,'Assunto',300),(1,4,0,1,5,'De',185),(1,5,0,1,6,'Prioridade',85),(1,6,0,0,2,'Status',110),(1,8,0,1,7,'AtribuÃ­do a',160),(1,10,0,1,3,'Ãšltima AtualizaÃ§Ã£o',150),(2,1,0,1,1,'Ticket',100),(2,3,0,1,4,'Assunto',300),(2,4,0,1,5,'De',185),(2,5,0,1,6,'Prioridade',85),(2,6,0,0,2,'Status',110),(2,8,0,1,7,'AtribuÃ­do a',160),(2,10,0,1,3,'Ãšltima AtualizaÃ§Ã£o',150),(3,1,0,1,1,'Ticket',100),(3,3,0,1,4,'Assunto',300),(3,4,0,1,5,'De',185),(3,5,0,1,6,'Prioridade',85),(3,6,0,0,2,'Status',110),(3,8,0,1,7,'AtribuÃ­do a',160),(3,10,0,1,3,'Ãšltima AtualizaÃ§Ã£o',150),(4,1,0,1,1,'Ticket',100),(4,3,0,1,4,'Assunto',300),(4,4,0,1,5,'De',185),(4,5,0,1,6,'Prioridade',85),(4,6,0,0,2,'Status',110),(4,8,0,1,7,'AtribuÃ­do a',160),(4,9,0,1,10,'Data de Vencimento',150),(5,1,0,1,1,'Ticket',100),(5,3,0,1,4,'Assunto',300),(5,4,0,1,5,'De',185),(5,5,0,1,6,'Prioridade',85),(5,6,0,0,2,'Status',110),(5,10,0,1,3,'Ãšltima AtualizaÃ§Ã£o',150),(5,11,0,1,7,'Departamento',160),(6,1,0,1,1,'Ticket',100),(6,3,0,1,4,'Assunto',300),(6,4,0,1,5,'De',185),(6,5,0,1,6,'Prioridade',85),(6,6,0,0,2,'Status',110),(6,10,0,1,3,'Ãšltima AtualizaÃ§Ã£o',150),(6,11,0,1,7,'Departamento',160),(7,1,0,1,1,'Ticket',100),(7,3,0,1,4,'Assunto',300),(7,4,0,1,5,'De',185),(7,5,0,1,6,'Prioridade',85),(7,6,0,0,2,'Status',110),(7,10,0,1,3,'Ãšltima AtualizaÃ§Ã£o',150),(7,14,0,1,7,'Equipe',160),(8,1,0,1,1,'Ticket',100),(8,3,0,1,4,'Assunto',300),(8,4,0,1,5,'De',185),(8,6,0,0,2,'Status',110),(8,7,0,1,3,'Data de Fechamento',150),(8,8,0,1,7,'Fechado por',160),(9,1,0,1,1,'Ticket',100),(9,3,0,1,4,'Assunto',300),(9,4,0,1,5,'De',185),(9,6,0,0,2,'Status',110),(9,7,0,1,3,'Data de Fechamento',150),(9,8,0,1,7,'Fechado por',160),(10,1,0,1,1,'Ticket',100),(10,3,0,1,4,'Assunto',300),(10,4,0,1,5,'De',185),(10,6,0,0,2,'Status',110),(10,7,0,1,3,'Data de Fechamento',150),(10,8,0,1,7,'Fechado por',160),(11,1,0,1,1,'Ticket',100),(11,3,0,1,4,'Assunto',300),(11,4,0,1,5,'De',185),(11,6,0,0,2,'Status',110),(11,7,0,1,3,'Data de Fechamento',150),(11,8,0,1,7,'Fechado por',160),(12,1,0,1,1,'Ticket',100),(12,3,0,1,4,'Assunto',300),(12,4,0,1,5,'De',185),(12,6,0,0,2,'Status',110),(12,7,0,1,3,'Data de Fechamento',150),(12,8,0,1,7,'Fechado por',160),(13,1,0,1,1,'Ticket',100),(13,3,0,1,4,'Assunto',300),(13,4,0,1,5,'De',185),(13,6,0,0,2,'Status',110),(13,7,0,1,3,'Data de Fechamento',150),(13,8,0,1,7,'Fechado por',160),(14,1,0,1,1,'Ticket',100),(14,3,0,1,4,'Assunto',300),(14,4,0,1,5,'De',185),(14,6,0,0,2,'Status',110),(14,7,0,1,3,'Data de Fechamento',150),(14,8,0,1,7,'Fechado por',160);
/*!40000 ALTER TABLE `ost_queue_columns` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ost_queue_config`
--

DROP TABLE IF EXISTS `ost_queue_config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `ost_queue_config` (
  `queue_id` int(11) unsigned NOT NULL,
  `staff_id` int(11) unsigned NOT NULL,
  `setting` text DEFAULT NULL,
  `updated` datetime NOT NULL,
  PRIMARY KEY (`queue_id`,`staff_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ost_queue_config`
--

LOCK TABLES `ost_queue_config` WRITE;
/*!40000 ALTER TABLE `ost_queue_config` DISABLE KEYS */;
/*!40000 ALTER TABLE `ost_queue_config` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ost_queue_export`
--

DROP TABLE IF EXISTS `ost_queue_export`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `ost_queue_export` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `queue_id` int(11) unsigned NOT NULL,
  `path` varchar(64) NOT NULL DEFAULT '',
  `heading` varchar(64) DEFAULT NULL,
  `sort` int(10) unsigned NOT NULL DEFAULT 1,
  PRIMARY KEY (`id`),
  KEY `queue_id` (`queue_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ost_queue_export`
--

LOCK TABLES `ost_queue_export` WRITE;
/*!40000 ALTER TABLE `ost_queue_export` DISABLE KEYS */;
/*!40000 ALTER TABLE `ost_queue_export` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ost_queue_sort`
--

DROP TABLE IF EXISTS `ost_queue_sort`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `ost_queue_sort` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `root` varchar(32) DEFAULT NULL,
  `name` varchar(64) NOT NULL DEFAULT '',
  `columns` text DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ost_queue_sort`
--

LOCK TABLES `ost_queue_sort` WRITE;
/*!40000 ALTER TABLE `ost_queue_sort` DISABLE KEYS */;
INSERT INTO `ost_queue_sort` VALUES (1,NULL,'Prioridade + Atualizados Recentemente','[\"-cdata__priority\",\"-lastupdate\"]','2026-07-01 10:26:32'),(2,NULL,'Prioridade + Recentemente Criados','[\"-cdata__priority\",\"-created\"]','2026-07-01 10:26:32'),(3,NULL,'Prioridade + Data Termino','[\"-cdata__priority\",\"-est_duedate\"]','2026-07-01 10:26:32'),(4,NULL,'Data de Vencimento','[\"-est_duedate\"]','2026-07-01 10:26:32'),(5,NULL,'Data de conclusÃ£o','[\"-closed\"]','2026-07-01 10:26:32'),(6,NULL,'Data de CriaÃ§Ã£o','[\"-created\"]','2026-07-01 10:26:32'),(7,NULL,'Atualizar Data','[\"-lastupdate\"]','2026-07-01 10:26:32');
/*!40000 ALTER TABLE `ost_queue_sort` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ost_queue_sorts`
--

DROP TABLE IF EXISTS `ost_queue_sorts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `ost_queue_sorts` (
  `queue_id` int(11) unsigned NOT NULL,
  `sort_id` int(11) unsigned NOT NULL,
  `bits` int(11) unsigned NOT NULL DEFAULT 0,
  `sort` int(10) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`queue_id`,`sort_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ost_queue_sorts`
--

LOCK TABLES `ost_queue_sorts` WRITE;
/*!40000 ALTER TABLE `ost_queue_sorts` DISABLE KEYS */;
INSERT INTO `ost_queue_sorts` VALUES (1,1,0,0),(1,2,0,0),(1,3,0,0),(1,4,0,0),(1,6,0,0),(1,7,0,0),(5,1,0,0),(5,2,0,0),(5,3,0,0),(5,4,0,0),(5,6,0,0),(5,7,0,0),(6,1,0,0),(6,2,0,0),(6,3,0,0),(6,4,0,0),(6,6,0,0),(6,7,0,0),(7,1,0,0),(7,2,0,0),(7,3,0,0),(7,4,0,0),(7,6,0,0),(7,7,0,0),(8,1,0,0),(8,2,0,0),(8,3,0,0),(8,4,0,0),(8,5,0,0),(8,6,0,0),(8,7,0,0),(9,1,0,0),(9,2,0,0),(9,3,0,0),(9,4,0,0),(9,5,0,0),(9,6,0,0),(9,7,0,0),(10,1,0,0),(10,2,0,0),(10,3,0,0),(10,4,0,0),(10,5,0,0),(10,6,0,0),(10,7,0,0),(11,1,0,0),(11,2,0,0),(11,3,0,0),(11,4,0,0),(11,5,0,0),(11,6,0,0),(11,7,0,0),(12,1,0,0),(12,2,0,0),(12,3,0,0),(12,4,0,0),(12,5,0,0),(12,6,0,0),(12,7,0,0),(13,1,0,0),(13,2,0,0),(13,3,0,0),(13,4,0,0),(13,5,0,0),(13,6,0,0),(13,7,0,0),(14,1,0,0),(14,2,0,0),(14,3,0,0),(14,4,0,0),(14,5,0,0),(14,6,0,0),(14,7,0,0);
/*!40000 ALTER TABLE `ost_queue_sorts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ost_role`
--

DROP TABLE IF EXISTS `ost_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `ost_role` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `flags` int(10) unsigned NOT NULL DEFAULT 1,
  `name` varchar(64) DEFAULT NULL,
  `permissions` text DEFAULT NULL,
  `notes` text DEFAULT NULL,
  `created` datetime NOT NULL,
  `updated` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ost_role`
--

LOCK TABLES `ost_role` WRITE;
/*!40000 ALTER TABLE `ost_role` DISABLE KEYS */;
INSERT INTO `ost_role` VALUES (1,1,'Acesso total','{\"ticket.assign\":1,\"ticket.close\":1,\"ticket.create\":1,\"ticket.delete\":1,\"ticket.edit\":1,\"thread.edit\":1,\"ticket.link\":1,\"ticket.markanswered\":1,\"ticket.merge\":1,\"ticket.reply\":1,\"ticket.refer\":1,\"ticket.release\":1,\"ticket.transfer\":1,\"task.assign\":1,\"task.close\":1,\"task.create\":1,\"task.delete\":1,\"task.edit\":1,\"task.reply\":1,\"task.transfer\":1,\"canned.manage\":1}','FunÃ§Ã£o com acesso ilimitado','2026-07-01 10:26:32','2026-07-01 10:26:32'),(2,1,'Acesso expandido','{\"ticket.assign\":1,\"ticket.close\":1,\"ticket.create\":1,\"ticket.edit\":1,\"ticket.link\":1,\"ticket.merge\":1,\"ticket.reply\":1,\"ticket.refer\":1,\"ticket.release\":1,\"ticket.transfer\":1,\"task.assign\":1,\"task.close\":1,\"task.create\":1,\"task.edit\":1,\"task.reply\":1,\"task.transfer\":1,\"canned.manage\":1}','FunÃ§Ã£o com acesso expandido','2026-07-01 10:26:32','2026-07-01 10:26:32'),(3,1,'Acesso Limitado','{\"ticket.assign\":1,\"ticket.create\":1,\"ticket.link\":1,\"ticket.merge\":1,\"ticket.refer\":1,\"ticket.release\":1,\"ticket.transfer\":1,\"task.assign\":1,\"task.reply\":1,\"task.transfer\":1}','FunÃ§Ã£o com acesso ilimitado','2026-07-01 10:26:32','2026-07-01 10:26:32'),(4,1,'VisualizaÃ§Ã£o apenas',NULL,'FunÃ§Ã£o simples sem permissÃµes','2026-07-01 10:26:32','2026-07-01 10:26:32');
/*!40000 ALTER TABLE `ost_role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ost_schedule`
--

DROP TABLE IF EXISTS `ost_schedule`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `ost_schedule` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `flags` int(11) unsigned NOT NULL DEFAULT 0,
  `name` varchar(255) NOT NULL,
  `timezone` varchar(64) DEFAULT NULL,
  `description` varchar(255) NOT NULL,
  `created` datetime NOT NULL,
  `updated` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ost_schedule`
--

LOCK TABLES `ost_schedule` WRITE;
/*!40000 ALTER TABLE `ost_schedule` DISABLE KEYS */;
INSERT INTO `ost_schedule` VALUES (1,1,'Segunda a sexta-feira de 08:00 Ã s 17:00',NULL,'','2026-07-01 10:26:32','2026-07-01 10:26:32'),(2,1,'24/7',NULL,'','2026-07-01 10:26:32','2026-07-01 10:26:32'),(3,1,'24/5',NULL,'','2026-07-01 10:26:32','2026-07-01 10:26:32'),(4,0,'Feriados dos Estados Unidos',NULL,'','2026-07-01 10:26:32','2026-07-01 10:26:32');
/*!40000 ALTER TABLE `ost_schedule` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ost_schedule_entry`
--

DROP TABLE IF EXISTS `ost_schedule_entry`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `ost_schedule_entry` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `schedule_id` int(11) unsigned NOT NULL DEFAULT 0,
  `flags` int(11) unsigned NOT NULL DEFAULT 0,
  `sort` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `name` varchar(255) NOT NULL,
  `repeats` varchar(16) NOT NULL DEFAULT 'never',
  `starts_on` date DEFAULT NULL,
  `starts_at` time DEFAULT NULL,
  `ends_on` date DEFAULT NULL,
  `ends_at` time DEFAULT NULL,
  `stops_on` datetime DEFAULT NULL,
  `day` tinyint(4) DEFAULT NULL,
  `week` tinyint(4) DEFAULT NULL,
  `month` tinyint(4) DEFAULT NULL,
  `created` datetime NOT NULL,
  `updated` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `schedule_id` (`schedule_id`),
  KEY `repeats` (`repeats`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ost_schedule_entry`
--

LOCK TABLES `ost_schedule_entry` WRITE;
/*!40000 ALTER TABLE `ost_schedule_entry` DISABLE KEYS */;
INSERT INTO `ost_schedule_entry` VALUES (1,1,0,0,'Segunda-feira','weekly','0000-00-00','08:00:00','0000-00-00','17:00:00',NULL,1,NULL,NULL,'0000-00-00 00:00:00','2026-07-01 10:26:32'),(2,1,0,0,'TerÃ§a-feira','weekly','0000-00-00','08:00:00','0000-00-00','17:00:00',NULL,2,NULL,NULL,'0000-00-00 00:00:00','2026-07-01 10:26:32'),(3,1,0,0,'Quarta-feira','weekly','0000-00-00','08:00:00','0000-00-00','17:00:00',NULL,3,NULL,NULL,'0000-00-00 00:00:00','2026-07-01 10:26:32'),(4,1,0,0,'Quinta-feira','weekly','0000-00-00','08:00:00','0000-00-00','17:00:00',NULL,4,NULL,NULL,'0000-00-00 00:00:00','2026-07-01 10:26:32'),(5,1,0,0,'Sexta-feira','weekly','0000-00-00','08:00:00','0000-00-00','17:00:00',NULL,5,NULL,NULL,'0000-00-00 00:00:00','2026-07-01 10:26:32'),(6,2,0,0,'Diariamente','daily','0000-00-00','00:00:00','0000-00-00','23:59:59',NULL,NULL,NULL,NULL,'0000-00-00 00:00:00','2026-07-01 10:26:32'),(7,3,0,0,'Dias da semana','weekdays','0000-00-00','00:00:00','0000-00-00','23:59:59',NULL,NULL,NULL,NULL,'0000-00-00 00:00:00','2026-07-01 10:26:32'),(8,4,0,0,'Dia de Ano Novo','yearly','0000-00-00','00:00:00','0000-00-00','23:59:59',NULL,1,NULL,1,'0000-00-00 00:00:00','2026-07-01 10:26:33'),(9,4,0,0,'Dia de Martin Luther King','yearly','0000-00-00','00:00:00','0000-00-00','23:59:59',NULL,1,3,1,'0000-00-00 00:00:00','2026-07-01 10:26:33'),(10,4,0,0,'Memorial Day','yearly','0000-00-00','00:00:00','0000-00-00','23:59:59',NULL,1,-1,5,'0000-00-00 00:00:00','2026-07-01 10:26:33'),(11,4,0,0,'Dia da IndependÃªncia Americana','yearly','0000-00-00','00:00:00','0000-00-00','23:59:59',NULL,4,NULL,7,'0000-00-00 00:00:00','2026-07-01 10:26:33'),(12,4,0,0,'Dia do Trabalhador','yearly','0000-00-00','00:00:00','0000-00-00','23:59:59',NULL,1,1,9,'0000-00-00 00:00:00','2026-07-01 10:26:33'),(13,4,0,0,'Dia dos Povos IndÃ­genas','yearly','0000-00-00','00:00:00','0000-00-00','23:59:59',NULL,1,2,10,'0000-00-00 00:00:00','2026-07-01 10:26:33'),(14,4,0,0,'Dia dos Veteranos de Guerra','yearly','0000-00-00','00:00:00','0000-00-00','23:59:59',NULL,11,NULL,11,'0000-00-00 00:00:00','2026-07-01 10:26:33'),(15,4,0,0,'Dia de AÃ§Ã£o de GraÃ§as','yearly','0000-00-00','00:00:00','0000-00-00','23:59:59',NULL,4,4,11,'0000-00-00 00:00:00','2026-07-01 10:26:33'),(16,4,0,0,'Dia de Natal','yearly','0000-00-00','00:00:00','0000-00-00','23:59:59',NULL,25,NULL,12,'0000-00-00 00:00:00','2026-07-01 10:26:33');
/*!40000 ALTER TABLE `ost_schedule_entry` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ost_sequence`
--

DROP TABLE IF EXISTS `ost_sequence`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `ost_sequence` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(64) DEFAULT NULL,
  `flags` int(10) unsigned DEFAULT NULL,
  `next` bigint(20) unsigned NOT NULL DEFAULT 1,
  `increment` int(11) DEFAULT 1,
  `padding` char(1) DEFAULT '0',
  `updated` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ost_sequence`
--

LOCK TABLES `ost_sequence` WRITE;
/*!40000 ALTER TABLE `ost_sequence` DISABLE KEYS */;
INSERT INTO `ost_sequence` VALUES (1,'Tickets Gerais',1,1,1,'0','0000-00-00 00:00:00'),(2,'SequÃªncia de Tarefas',1,1,1,'0','0000-00-00 00:00:00');
/*!40000 ALTER TABLE `ost_sequence` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ost_session`
--

DROP TABLE IF EXISTS `ost_session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `ost_session` (
  `session_id` varchar(255) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '',
  `session_data` blob DEFAULT NULL,
  `session_expire` datetime DEFAULT NULL,
  `session_updated` datetime DEFAULT NULL,
  `user_id` varchar(16) NOT NULL DEFAULT '0' COMMENT 'osTicket staff/client ID',
  `user_ip` varchar(64) NOT NULL,
  `user_agent` varchar(255) NOT NULL,
  PRIMARY KEY (`session_id`),
  KEY `updated` (`session_updated`),
  KEY `user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ost_session`
--

LOCK TABLES `ost_session` WRITE;
/*!40000 ALTER TABLE `ost_session` DISABLE KEYS */;
INSERT INTO `ost_session` VALUES ('01o16fft1sa84gjc9lrbrlv0gd','csrf|a:2:{s:5:\"token\";s:40:\"c9d6a6ed21ae79654d064276fc3e360807e58a56\";s:4:\"time\";i:1783420077;}_auth|a:1:{s:5:\"staff\";N;}','2026-07-08 07:27:57','2026-07-07 07:27:57','0','::1','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36'),('021f325e77381c2cfdf98ef0e5faabe2','csrf|a:2:{s:5:\"token\";s:40:\"cc776af58ba5536da47ce64f4173482b13926e16\";s:4:\"time\";i:1783598696;}_auth|a:2:{s:4:\"user\";a:1:{s:7:\"strikes\";i:1;}s:5:\"staff\";a:1:{s:7:\"strikes\";i:2;}}:token|a:1:{s:6:\"client\";s:76:\"b343c2df9dc6c634b106688708b2b358:1783598687:3b1412753f475cc969c37231dd6eaea2\";}_staff|a:1:{s:4:\"auth\";a:0:{}}','2026-07-10 12:04:45','2026-07-09 12:04:56','0','172.18.0.1','curl/8.21.0'),('08767c08d24ceec3172212d5415feade','csrf|a:2:{s:5:\"token\";s:40:\"9a54faf15d7520ea1eedc6931a0d2bbfcb8eb4ab\";s:4:\"time\";i:1783451707;}_auth|a:1:{s:5:\"staff\";N;}','2026-07-08 19:15:07','2026-07-07 19:15:07','0','172.18.0.1','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36'),('0a6acfc927d9e2ae7abfe5e783380e63','csrf|a:2:{s:5:\"token\";s:40:\"d14a0c7fd04d7009208b92e5996d0fe119947ac1\";s:4:\"time\";i:1783446377;}_auth|a:1:{s:5:\"staff\";N;}','2026-07-08 17:46:17','2026-07-07 17:46:17','0','172.18.0.1','curl/8.19.0'),('104e2b665e59e865c3b49aa3aa489796','csrf|a:2:{s:5:\"token\";s:40:\"0d120a8e09d9f684d7be9b663a58bafeef0e3799\";s:4:\"time\";i:1783947557;}_auth|a:1:{s:5:\"staff\";N;}','2026-07-14 12:59:17','2026-07-13 12:59:17','0','172.18.0.1','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36'),('20t25mpumt9lrf9kpmkgq0vobo','csrf|a:2:{s:5:\"token\";s:40:\"99172fc280bcee1e590ef7d8ebc1a124063d44f9\";s:4:\"time\";i:1783420077;}','2026-07-08 07:27:57','2026-07-07 07:27:57','0','::1','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36'),('2483a82ee972a318b4f61b9607ff4efd','csrf|N;','2026-07-14 13:17:25','2026-07-13 13:17:25','0','',''),('2e88502ecda6c5862b6bdeac5937a8a4','csrf|a:2:{s:5:\"token\";s:40:\"a7bda999a68f5c22bb891838fceeaa123b63fbdd\";s:4:\"time\";i:1783949601;}_auth|a:2:{s:4:\"user\";a:2:{s:2:\"id\";i:2;s:3:\"key\";s:8:\"client:2\";}s:5:\"staff\";a:3:{s:2:\"id\";i:1;s:3:\"key\";s:19:\"local:julianotorres\";s:3:\"2fa\";N;}}_staff|a:1:{s:4:\"auth\";a:0:{}}:token|a:2:{s:6:\"client\";s:76:\"58095bb2845b396ae489c279e81192ed:1783949601:3b1412753f475cc969c37231dd6eaea2\";s:5:\"staff\";s:76:\"a9db6a59bf9d55cf603cc4f283d57974:1783949381:3b1412753f475cc969c37231dd6eaea2\";}TIME_BOMB|i:1783949700;client:Q|N;cfg:core|a:1:{s:11:\"db_timezone\";s:3:\"UTC\";}::Q:T|i:1;sort|a:1:{i:1;a:2:{s:9:\"queuesort\";O:9:\"QueueSort\":7:{s:2:\"ht\";a:5:{s:2:\"id\";i:1;s:4:\"root\";N;s:4:\"name\";s:37:\"Prioridade + Atualizados Recentemente\";s:7:\"columns\";s:34:\"[\"-cdata__priority\",\"-lastupdate\"]\";s:7:\"updated\";s:19:\"2026-07-01 10:26:32\";}s:5:\"dirty\";a:0:{}s:7:\"__new__\";b:0;s:11:\"__deleted__\";b:0;s:12:\"__deferred__\";a:0:{}s:8:\"_columns\";a:2:{s:15:\"cdata__priority\";b:1;s:10:\"lastupdate\";b:1;}s:6:\"_extra\";N;}s:3:\"dir\";i:0;}}lastcroncall|i:1783949383;:email|a:1:{i:1;a:1:{s:8:\"formdata\";a:21:{s:13:\"__CSRFToken__\";s:40:\"a7bda999a68f5c22bb891838fceeaa123b63fbdd\";s:2:\"do\";s:6:\"update\";s:2:\"id\";s:1:\"1\";s:5:\"email\";s:25:\"juliano.torres@zkteco.com\";s:4:\"name\";s:21:\"ZKTeco - ManutenÃ§Ã£o\";s:7:\"dept_id\";s:1:\"3\";s:11:\"priority_id\";s:1:\"2\";s:8:\"topic_id\";s:1:\"1\";s:12:\"mailbox_host\";s:18:\"imap.exmail.qq.com\";s:12:\"mailbox_port\";s:3:\"993\";s:14:\"mailbox_folder\";s:5:\"INBOX\";s:16:\"mailbox_protocol\";s:4:\"IMAP\";s:15:\"mailbox_auth_bk\";s:5:\"basic\";s:14:\"mailbox_active\";s:1:\"1\";s:17:\"mailbox_fetchfreq\";s:1:\"1\";s:16:\"mailbox_fetchmax\";s:1:\"1\";s:17:\"mailbox_postfetch\";s:7:\"nothing\";s:11:\"smtp_active\";s:1:\"1\";s:9:\"smtp_host\";s:24:\"ssl://smtp.exmail.qq.com\";s:9:\"smtp_port\";s:3:\"465\";s:12:\"smtp_auth_bk\";s:5:\"basic\";}}}','2026-07-13 14:03:21','2026-07-13 13:33:21','0','172.18.0.1','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36'),('31ebf9c440a8ed598ec586d0cd8272e9','csrf|a:2:{s:5:\"token\";s:40:\"09ed0ffc7ae5f888e2d2ed67572661510709aa55\";s:4:\"time\";i:1783615281;}_auth|a:1:{s:5:\"staff\";N;}','2026-07-10 16:41:21','2026-07-09 16:41:21','0','172.18.0.1','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36'),('40ee93c4f483f041e2570c053d2fe4ef','csrf|a:2:{s:5:\"token\";s:40:\"af52f098594c9c3faab0476ac734b0274eba55d2\";s:4:\"time\";i:1783596794;}_auth|a:1:{s:4:\"user\";N;}','2026-07-10 11:33:14','2026-07-09 11:33:14','0','172.18.0.1','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36'),('4d3048158fae93710aafb7379370cada','csrf|a:2:{s:5:\"token\";s:40:\"5b4799a93d67b26fe9a84670ce0bb0405ebbade5\";s:4:\"time\";i:1783597639;}_auth|a:1:{s:4:\"user\";a:1:{s:7:\"strikes\";i:1;}}:token|a:1:{s:6:\"client\";s:76:\"6cfa730e7ea00b96a9a8cf42aea32f02:1783597639:3b1412753f475cc969c37231dd6eaea2\";}','2026-07-10 11:34:55','2026-07-09 11:47:19','0','172.18.0.1','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36'),('50b4ba3da6b714f5d160f038d7860862','csrf|a:2:{s:5:\"token\";s:40:\"622ff88cb8f9abce533316f769489d7efc939d33\";s:4:\"time\";i:1783444705;}_auth|a:1:{s:5:\"staff\";N;}','2026-07-08 17:18:25','2026-07-07 17:18:25','0','172.18.0.1','curl/8.19.0'),('51f78331cf80857c224d7d01bfcdae9e','csrf|a:2:{s:5:\"token\";s:40:\"0edbeec00a67a1aaa4ce99321028d0d2e4cc9cf8\";s:4:\"time\";i:1783598719;}_auth|a:1:{s:4:\"user\";N;}','2026-07-10 12:05:19','2026-07-09 12:05:19','0','172.18.0.1','curl/8.21.0'),('51f7c046afbaadb91753030b5030f930','csrf|a:2:{s:5:\"token\";s:40:\"0c86eee03a068ff678e683f74ce5b46d4d63ce92\";s:4:\"time\";i:1783947562;}_auth|a:1:{s:5:\"staff\";N;}','2026-07-14 12:59:22','2026-07-13 12:59:22','0','172.18.0.1','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36'),('5308b5e45bac424c3f7ac0e710f2c1bc','csrf|a:2:{s:5:\"token\";s:40:\"06b7341f70db05ae86b98e16648871c617cf4281\";s:4:\"time\";i:1783596858;}_auth|a:2:{s:4:\"user\";a:2:{s:2:\"id\";i:2;s:3:\"key\";s:8:\"client:2\";}s:5:\"staff\";N;}_staff|a:1:{s:4:\"auth\";a:2:{s:4:\"dest\";s:5:\"/scp/\";s:3:\"msg\";s:36:\"Ã‰ necessÃ¡rio um token CSRF vÃ¡lido\";}}:token|a:1:{s:6:\"client\";s:76:\"7ddefd46c600d9c786f797b42d555794:1783596827:3b1412753f475cc969c37231dd6eaea2\";}TIME_BOMB|i:1783596837;client:Q|N;cfg:core|a:1:{s:11:\"db_timezone\";s:3:\"UTC\";}TTD|i:1783597014;','2026-07-09 11:36:54','2026-07-09 11:34:54','0','172.18.0.1','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36'),('536ddb45f3a0cf37471cdbdbf462d2da','csrf|a:2:{s:5:\"token\";s:40:\"492be1b7831ce415af63ac0d8c7a3d33862cfb1b\";s:4:\"time\";i:1783947559;}_auth|a:1:{s:4:\"user\";N;}','2026-07-14 12:59:19','2026-07-13 12:59:19','0','172.18.0.1','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36'),('5kg5buel6lt0606b5icdu1940i','csrf|a:2:{s:5:\"token\";s:40:\"bfad14e9120e1fca41a6a0974eaed37b54387685\";s:4:\"time\";i:1783420075;}','2026-07-08 07:27:55','2026-07-07 07:27:55','0','::1','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36'),('68e879830591571d7624c88d47b7eeec','csrf|N;','2026-07-14 13:18:13','2026-07-13 13:18:13','0','',''),('6ceba56fa411b1457a5a5994983e856b','csrf|a:2:{s:5:\"token\";s:40:\"d98afa40287e639fd5efa95bc376f607a14cb8cb\";s:4:\"time\";i:1783596811;}_auth|a:1:{s:5:\"staff\";N;}','2026-07-10 11:33:31','2026-07-09 11:33:31','0','172.18.0.1','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36'),('6e4bd566a013da39a87adc56271f5bcf','csrf|a:2:{s:5:\"token\";s:40:\"f4e32d063458e66563f6cba166b8120fd5d941b2\";s:4:\"time\";i:1783449139;}','2026-07-08 18:32:19','2026-07-07 18:32:19','0','172.18.0.1','curl/8.21.0'),('768ab87740928ec11cb3f17403423665','csrf|a:2:{s:5:\"token\";s:40:\"4f58536a70ecec81f785ad3cd74db64273d76e63\";s:4:\"time\";i:1783455086;}_client|a:1:{s:4:\"auth\";a:1:{s:4:\"dest\";s:18:\"/tickets.php?id=19\";}}_auth|a:1:{s:4:\"user\";a:2:{s:2:\"id\";i:2;s:3:\"key\";s:8:\"client:2\";}}:token|a:1:{s:6:\"client\";s:76:\"a52304fac37473136a812a97d024fb47:1783455085:3b1412753f475cc969c37231dd6eaea2\";}TIME_BOMB|i:1783455095;cfg:core|a:1:{s:11:\"db_timezone\";s:3:\"UTC\";}TTD|i:1783455452;','2026-07-07 20:17:32','2026-07-07 20:15:32','0','172.18.0.1','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36'),('791a75e8ea5d23a04d8c6495c36a6fa1','csrf|N;','2026-07-14 13:17:43','2026-07-13 13:17:43','0','',''),('9aee6921ff33748dedda760ee1f38098','csrf|a:2:{s:5:\"token\";s:40:\"a7bda999a68f5c22bb891838fceeaa123b63fbdd\";s:4:\"time\";i:1783947884;}_auth|a:2:{s:4:\"user\";a:2:{s:2:\"id\";i:2;s:3:\"key\";s:8:\"client:2\";}s:5:\"staff\";a:3:{s:2:\"id\";i:1;s:3:\"key\";s:19:\"local:julianotorres\";s:3:\"2fa\";N;}}_staff|a:1:{s:4:\"auth\";a:0:{}}:token|a:2:{s:6:\"client\";s:76:\"03bc1dd1ec271628a2ac4fbefe540ba7:1783947833:3b1412753f475cc969c37231dd6eaea2\";s:5:\"staff\";s:76:\"340baaaf4daf9db53e0a4f4ad8d28b5a:1783947880:3b1412753f475cc969c37231dd6eaea2\";}TIME_BOMB|i:1783947890;client:Q|N;cfg:core|a:1:{s:11:\"db_timezone\";s:3:\"UTC\";}::Q:T|i:1;sort|a:1:{i:1;a:2:{s:9:\"queuesort\";O:9:\"QueueSort\":7:{s:2:\"ht\";a:5:{s:2:\"id\";i:1;s:4:\"root\";N;s:4:\"name\";s:37:\"Prioridade + Atualizados Recentemente\";s:7:\"columns\";s:34:\"[\"-cdata__priority\",\"-lastupdate\"]\";s:7:\"updated\";s:19:\"2026-07-01 10:26:32\";}s:5:\"dirty\";a:0:{}s:7:\"__new__\";b:0;s:11:\"__deleted__\";b:0;s:12:\"__deferred__\";a:0:{}s:8:\"_columns\";a:2:{s:15:\"cdata__priority\";b:1;s:10:\"lastupdate\";b:1;}s:6:\"_extra\";N;}s:3:\"dir\";i:0;}}lastcroncall|i:1783947882;TTD|i:1783948020;','2026-07-13 13:07:00','2026-07-13 13:05:00','1','172.18.0.1','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36'),('9ba6eed56d6fb80ae2a5ba154a0b2e9a','csrf|a:2:{s:5:\"token\";s:40:\"4f58536a70ecec81f785ad3cd74db64273d76e63\";s:4:\"time\";i:1783455438;}_client|a:1:{s:4:\"auth\";a:1:{s:4:\"dest\";s:18:\"/tickets.php?id=19\";}}_auth|a:2:{s:4:\"user\";a:2:{s:2:\"id\";i:2;s:3:\"key\";s:8:\"client:2\";}s:5:\"staff\";a:3:{s:2:\"id\";i:1;s:3:\"key\";s:19:\"local:julianotorres\";s:3:\"2fa\";N;}}:token|a:2:{s:6:\"client\";s:76:\"0df9fc07c4fce4ca29460f9c07ca92da:1783455391:3b1412753f475cc969c37231dd6eaea2\";s:5:\"staff\";s:76:\"2d23348f39c4540d1e47e649dcaf8ad8:1783455434:3b1412753f475cc969c37231dd6eaea2\";}TIME_BOMB|i:1783455444;cfg:core|a:1:{s:11:\"db_timezone\";s:3:\"UTC\";}_staff|a:1:{s:4:\"auth\";a:2:{s:4:\"dest\";s:17:\"/scp/zk-equip.php\";s:3:\"msg\";s:26:\"AutenticaÃ§Ã£o NecessÃ¡ria\";}}TTD|i:1783455565;','2026-07-07 20:19:25','2026-07-07 20:17:25','1','172.18.0.1','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36'),('a33d456876fa184803b893b926d486f8','csrf|a:2:{s:5:\"token\";s:40:\"900c63be0f2769305e647c5a71c0d19872d7fdd9\";s:4:\"time\";i:1783615281;}_auth|a:1:{s:4:\"user\";N;}','2026-07-10 16:41:21','2026-07-09 16:41:21','0','172.18.0.1','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36'),('a3fb94f105d4f8b5ec1574c589e242c7','csrf|a:2:{s:5:\"token\";s:40:\"6d28b1ecc9a70921d4064ab06d6365b2a39bd31f\";s:4:\"time\";i:1783453879;}_staff|a:1:{s:4:\"auth\";a:2:{s:4:\"dest\";s:22:\"/scp/tickets.php?id=20\";s:3:\"msg\";s:26:\"AutenticaÃ§Ã£o NecessÃ¡ria\";}}_auth|a:2:{s:5:\"staff\";a:3:{s:2:\"id\";i:1;s:3:\"key\";s:19:\"local:julianotorres\";s:3:\"2fa\";N;}s:4:\"user\";a:2:{s:2:\"id\";i:2;s:3:\"key\";s:8:\"client:2\";}}:token|a:2:{s:5:\"staff\";s:76:\"a7d7719a02b6ef035bd14fbb4edd3c7e:1783453804:3b1412753f475cc969c37231dd6eaea2\";s:6:\"client\";s:76:\"7e1fa108fcf454f3f87d065cb9c27f39:1783453879:3b1412753f475cc969c37231dd6eaea2\";}TIME_BOMB|i:1783455098;cfg:core|a:1:{s:11:\"db_timezone\";s:3:\"UTC\";}lastcroncall|i:1783453806;::Q:T|i:1;sort|a:1:{i:1;a:2:{s:9:\"queuesort\";O:9:\"QueueSort\":7:{s:2:\"ht\";a:5:{s:2:\"id\";i:1;s:4:\"root\";N;s:4:\"name\";s:37:\"Prioridade + Atualizados Recentemente\";s:7:\"columns\";s:34:\"[\"-cdata__priority\",\"-lastupdate\"]\";s:7:\"updated\";s:19:\"2026-07-01 10:26:32\";}s:5:\"dirty\";a:0:{}s:7:\"__new__\";b:0;s:11:\"__deleted__\";b:0;s:12:\"__deferred__\";a:0:{}s:8:\"_columns\";a:2:{s:15:\"cdata__priority\";b:1;s:10:\"lastupdate\";b:1;}s:6:\"_extra\";N;}s:3:\"dir\";i:0;}}client:Q|N;','2026-07-07 20:21:19','2026-07-07 19:51:19','0','172.18.0.1','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36'),('a7ef3ed8e39a009ad7977cc53b3b1121','csrf|a:2:{s:5:\"token\";s:40:\"e0a76952efc10593c150a007b9e426d51cd83d26\";s:4:\"time\";i:1783513350;}_auth|a:1:{s:4:\"user\";N;}','2026-07-09 12:22:30','2026-07-08 12:22:30','0','172.18.0.1','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36'),('affab77260b33c897f6e671870b259e4','csrf|a:2:{s:5:\"token\";s:40:\"96773db2d24377a4dbd741db122b4ec286c0e9ad\";s:4:\"time\";i:1783449140;}_auth|a:1:{s:5:\"staff\";N;}','2026-07-08 18:32:20','2026-07-07 18:32:20','0','172.18.0.1','curl/8.21.0'),('c0nva5dep65oqtpduql8qvgv3u','csrf|a:2:{s:5:\"token\";s:40:\"c03ac7a0607a28131c8c6d8151b324c95cb9963a\";s:4:\"time\";i:1783431345;}_auth|a:1:{s:4:\"user\";N;}','2026-07-08 10:35:45','2026-07-07 10:35:45','0','::1','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36'),('c1994ffb427bc146d9fa926ec1abec86','csrf|a:2:{s:5:\"token\";s:40:\"a7bda999a68f5c22bb891838fceeaa123b63fbdd\";s:4:\"time\";i:1783949207;}_auth|a:2:{s:4:\"user\";a:2:{s:2:\"id\";i:2;s:3:\"key\";s:8:\"client:2\";}s:5:\"staff\";a:3:{s:2:\"id\";i:1;s:3:\"key\";s:19:\"local:julianotorres\";s:3:\"2fa\";N;}}_staff|a:1:{s:4:\"auth\";a:0:{}}:token|a:2:{s:6:\"client\";s:76:\"b7117de1ce2298285dc92e64b9793216:1783949207:3b1412753f475cc969c37231dd6eaea2\";s:5:\"staff\";s:76:\"3efbdd74e92183544a4eaeff76b448e4:1783948986:3b1412753f475cc969c37231dd6eaea2\";}TIME_BOMB|i:1783949700;client:Q|N;cfg:core|a:1:{s:11:\"db_timezone\";s:3:\"UTC\";}::Q:T|i:1;sort|a:1:{i:1;a:2:{s:9:\"queuesort\";O:9:\"QueueSort\":7:{s:2:\"ht\";a:5:{s:2:\"id\";i:1;s:4:\"root\";N;s:4:\"name\";s:37:\"Prioridade + Atualizados Recentemente\";s:7:\"columns\";s:34:\"[\"-cdata__priority\",\"-lastupdate\"]\";s:7:\"updated\";s:19:\"2026-07-01 10:26:32\";}s:5:\"dirty\";a:0:{}s:7:\"__new__\";b:0;s:11:\"__deleted__\";b:0;s:12:\"__deferred__\";a:0:{}s:8:\"_columns\";a:2:{s:15:\"cdata__priority\";b:1;s:10:\"lastupdate\";b:1;}s:6:\"_extra\";N;}s:3:\"dir\";i:0;}}lastcroncall|i:1783948922;:email|a:1:{i:1;a:1:{s:8:\"formdata\";a:21:{s:13:\"__CSRFToken__\";s:40:\"a7bda999a68f5c22bb891838fceeaa123b63fbdd\";s:2:\"do\";s:6:\"update\";s:2:\"id\";s:1:\"1\";s:5:\"email\";s:25:\"juliano.torres@zkteco.com\";s:4:\"name\";s:21:\"ZKTeco - ManutenÃ§Ã£o\";s:7:\"dept_id\";s:1:\"3\";s:11:\"priority_id\";s:1:\"2\";s:8:\"topic_id\";s:1:\"1\";s:12:\"mailbox_host\";s:18:\"imap.exmail.qq.com\";s:12:\"mailbox_port\";s:3:\"993\";s:14:\"mailbox_folder\";s:5:\"INBOX\";s:16:\"mailbox_protocol\";s:4:\"IMAP\";s:15:\"mailbox_auth_bk\";s:5:\"basic\";s:14:\"mailbox_active\";s:1:\"1\";s:17:\"mailbox_fetchfreq\";s:1:\"1\";s:16:\"mailbox_fetchmax\";s:1:\"1\";s:17:\"mailbox_postfetch\";s:7:\"nothing\";s:11:\"smtp_active\";s:1:\"1\";s:9:\"smtp_host\";s:24:\"ssl://smtp.exmail.qq.com\";s:9:\"smtp_port\";s:3:\"465\";s:12:\"smtp_auth_bk\";s:5:\"basic\";}}}TTD|i:1783949336;','2026-07-13 13:28:56','2026-07-13 13:26:56','0','172.18.0.1','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36'),('c1npki8c8lfqkqhkn4lgte33m3','csrf|N;_staff|a:1:{s:4:\"auth\";a:2:{s:4:\"dest\";s:21:\"/osticket/upload/scp/\";s:3:\"msg\";s:26:\"AutenticaÃ§Ã£o NecessÃ¡ria\";}}','2026-07-08 07:27:57','2026-07-07 07:27:57','0','::1','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36'),('d43861afc76443190a0f65cbd1b3f4c5','csrf|a:2:{s:5:\"token\";s:40:\"599437c693a67c15ffeed9c1c3e248a107ff0d43\";s:4:\"time\";i:1783599844;}_auth|a:2:{s:5:\"staff\";a:3:{s:2:\"id\";i:1;s:3:\"key\";s:19:\"local:julianotorres\";s:3:\"2fa\";N;}s:4:\"user\";a:2:{s:2:\"id\";i:2;s:3:\"key\";s:8:\"client:2\";}}:token|a:2:{s:5:\"staff\";s:76:\"4b02fbf11f3b8fdf722088ddc41c1ee3:1783599816:3b1412753f475cc969c37231dd6eaea2\";s:6:\"client\";s:76:\"057dabf95dd72fb68972e4ff792763c9:1783599836:3b1412753f475cc969c37231dd6eaea2\";}TIME_BOMB|i:1783599853;::Q:T|i:1;sort|a:1:{i:1;a:2:{s:9:\"queuesort\";O:9:\"QueueSort\":7:{s:2:\"ht\";a:5:{s:2:\"id\";i:1;s:4:\"root\";N;s:4:\"name\";s:37:\"Prioridade + Atualizados Recentemente\";s:7:\"columns\";s:34:\"[\"-cdata__priority\",\"-lastupdate\"]\";s:7:\"updated\";s:19:\"2026-07-01 10:26:32\";}s:5:\"dirty\";a:0:{}s:7:\"__new__\";b:0;s:11:\"__deleted__\";b:0;s:12:\"__deferred__\";a:0:{}s:8:\"_columns\";a:2:{s:15:\"cdata__priority\";b:1;s:10:\"lastupdate\";b:1;}s:6:\"_extra\";N;}s:3:\"dir\";i:0;}}cfg:core|a:1:{s:11:\"db_timezone\";s:3:\"UTC\";}lastcroncall|i:1783599825;client:Q|N;','2026-07-10 12:23:24','2026-07-09 12:24:04','1','172.18.0.1','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36'),('d97f7503d67a76613f53b3d1fff30a15','csrf|a:2:{s:5:\"token\";s:40:\"e2c082b3018faa57dadd752f2775b9d4e6ad9f92\";s:4:\"time\";i:1783598792;}_auth|a:1:{s:4:\"user\";a:1:{s:7:\"strikes\";i:1;}}','2026-07-10 12:06:31','2026-07-09 12:06:32','0','172.18.0.1','curl/8.21.0'),('da492753d746b8f840aa13bdbe9e9ae3','csrf|a:2:{s:5:\"token\";s:40:\"4f58536a70ecec81f785ad3cd74db64273d76e63\";s:4:\"time\";i:1783455465;}_client|a:1:{s:4:\"auth\";a:1:{s:4:\"dest\";s:18:\"/tickets.php?id=19\";}}_auth|a:2:{s:4:\"user\";a:2:{s:2:\"id\";i:2;s:3:\"key\";s:8:\"client:2\";}s:5:\"staff\";a:3:{s:2:\"id\";i:1;s:3:\"key\";s:19:\"local:julianotorres\";s:3:\"2fa\";N;}}:token|a:2:{s:6:\"client\";s:76:\"afe2334f30c6654389b680b7a11fd3ab:1783455465:3b1412753f475cc969c37231dd6eaea2\";s:5:\"staff\";s:76:\"2d23348f39c4540d1e47e649dcaf8ad8:1783455434:3b1412753f475cc969c37231dd6eaea2\";}TIME_BOMB|i:1783457245;cfg:core|a:1:{s:11:\"db_timezone\";s:3:\"UTC\";}_staff|a:1:{s:4:\"auth\";a:2:{s:4:\"dest\";s:17:\"/scp/zk-equip.php\";s:3:\"msg\";s:26:\"AutenticaÃ§Ã£o NecessÃ¡ria\";}}::Q:T|i:1;sort|a:1:{i:1;a:2:{s:9:\"queuesort\";O:9:\"QueueSort\":7:{s:2:\"ht\";a:5:{s:2:\"id\";i:1;s:4:\"root\";N;s:4:\"name\";s:37:\"Prioridade + Atualizados Recentemente\";s:7:\"columns\";s:34:\"[\"-cdata__priority\",\"-lastupdate\"]\";s:7:\"updated\";s:19:\"2026-07-01 10:26:32\";}s:5:\"dirty\";a:0:{}s:7:\"__new__\";b:0;s:11:\"__deleted__\";b:0;s:12:\"__deferred__\";a:0:{}s:8:\"_columns\";a:2:{s:15:\"cdata__priority\";b:1;s:10:\"lastupdate\";b:1;}s:6:\"_extra\";N;}s:3:\"dir\";i:0;}}lastcroncall|i:1783455446;','2026-07-07 20:47:45','2026-07-07 20:17:45','0','172.18.0.1','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36'),('e40b154114bf07ab91290a54eb286e38','csrf|a:2:{s:5:\"token\";s:40:\"ec4eaa5be99b9dce66b519bac69a32984a75d95f\";s:4:\"time\";i:1783626797;}_auth|a:1:{s:4:\"user\";N;}','2026-07-10 19:53:15','2026-07-09 19:53:17','0','172.18.0.1','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36'),('e513ef78a40c60da601daff7b080e45b','csrf|a:2:{s:5:\"token\";s:40:\"32db518ab0b8c9805722e956916120154b036254\";s:4:\"time\";i:1783452217;}_staff|a:1:{s:4:\"auth\";a:2:{s:4:\"dest\";s:22:\"/scp/tickets.php?id=20\";s:3:\"msg\";s:26:\"AutenticaÃ§Ã£o NecessÃ¡ria\";}}_auth|a:1:{s:5:\"staff\";a:3:{s:2:\"id\";i:1;s:3:\"key\";s:19:\"local:julianotorres\";s:3:\"2fa\";N;}}:token|a:1:{s:5:\"staff\";s:76:\"dac45c0d88f57e15a0dfc2c12c74a8b2:1783452184:3b1412753f475cc969c37231dd6eaea2\";}TIME_BOMB|i:1783454013;cfg:core|a:1:{s:11:\"db_timezone\";s:3:\"UTC\";}lastcroncall|i:1783452192;::Q:T|i:1;sort|a:1:{i:1;a:2:{s:9:\"queuesort\";O:9:\"QueueSort\":7:{s:2:\"ht\";a:5:{s:2:\"id\";i:1;s:4:\"root\";N;s:4:\"name\";s:37:\"Prioridade + Atualizados Recentemente\";s:7:\"columns\";s:34:\"[\"-cdata__priority\",\"-lastupdate\"]\";s:7:\"updated\";s:19:\"2026-07-01 10:26:32\";}s:5:\"dirty\";a:0:{}s:7:\"__new__\";b:0;s:11:\"__deleted__\";b:0;s:12:\"__deferred__\";a:0:{}s:8:\"_columns\";a:2:{s:15:\"cdata__priority\";b:1;s:10:\"lastupdate\";b:1;}s:6:\"_extra\";N;}s:3:\"dir\";i:0;}}','2026-07-07 19:53:33','2026-07-07 19:23:37','1','172.18.0.1','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36'),('e5c4b10406131b2eeb558782c4e3e2ce','csrf|a:2:{s:5:\"token\";s:40:\"3f824b2aa3e2a96e293d1fe17150442bbacd43e6\";s:4:\"time\";i:1783508649;}_auth|a:1:{s:4:\"user\";N;}','2026-07-09 11:04:06','2026-07-08 11:04:10','0','172.18.0.1','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36'),('e9381a8202f659d70810cd86362d1634','csrf|N;','2026-07-14 13:27:56','2026-07-13 13:27:56','0','',''),('face58ad3fc85a70e11724781f62b353','csrf|a:2:{s:5:\"token\";s:40:\"df320c0f3f28d072de649b518a27d89881aa87e9\";s:4:\"time\";i:1783444707;}_auth|a:1:{s:5:\"staff\";N;}','2026-07-08 17:18:27','2026-07-07 17:18:27','0','172.18.0.1','curl/8.19.0'),('gv1b0ik2sodn9bgnne677dd1ct','csrf|a:2:{s:5:\"token\";s:40:\"38618baed2d20043cc6cf2dcc875713e2e78f7d5\";s:4:\"time\";i:1783431345;}_auth|a:1:{s:5:\"staff\";N;}','2026-07-08 10:35:45','2026-07-07 10:35:45','0','::1','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36'),('ma5109pprt36mrp46mqg6u81r7','csrf|N;_staff|a:1:{s:4:\"auth\";a:2:{s:4:\"dest\";s:21:\"/osticket/upload/scp/\";s:3:\"msg\";s:26:\"AutenticaÃ§Ã£o NecessÃ¡ria\";}}','2026-07-08 07:27:55','2026-07-07 07:27:55','0','::1','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36'),('paf76d248bbv42uq35so8lp7db','csrf|a:2:{s:5:\"token\";s:40:\"f4d4af70f04d856564852dc2baf275406892cb16\";s:4:\"time\";i:1783420078;}_auth|a:1:{s:4:\"user\";N;}','2026-07-08 07:27:58','2026-07-07 07:27:58','0','::1','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36'),('r25s0925u62hnq08palj60e1o3','csrf|a:2:{s:5:\"token\";s:40:\"6c30093e6b0f5a4cced9c348efcb3dc184ecf57b\";s:4:\"time\";i:1783435126;}_staff|a:1:{s:4:\"auth\";a:2:{s:4:\"dest\";s:167:\"/osticket/upload/scp/tickets.php?a=zksearch&zk_q=&zk_status=8&zk_state=&zk_dept=&zk_assignee=&zk_topic=&zk_sla=&zk_created_from=&zk_created_to=&zk_due_from=&zk_due_to=\";s:3:\"msg\";s:26:\"AutenticaÃ§Ã£o NecessÃ¡ria\";}}_auth|a:1:{s:5:\"staff\";a:3:{s:2:\"id\";i:1;s:3:\"key\";s:19:\"local:julianotorres\";s:3:\"2fa\";N;}}:token|a:1:{s:5:\"staff\";s:76:\"f22bbefcfd271d2c3a13dd58411ee6cc:1783435125:837ec5754f503cfaaee0929fd48974e7\";}TIME_BOMB|i:1783435135;advsearch|a:1:{s:5:\"zkadv\";a:1:{i:0;a:3:{i:0;s:10:\"status__id\";i:1;s:8:\"includes\";i:2;a:1:{i:8;s:1:\"8\";}}}}::Q:T|s:11:\"adhoc,zkadv\";cfg:core|a:1:{s:11:\"db_timezone\";s:17:\"America/Sao_Paulo\";}lastcroncall|i:1783435126;','2026-07-08 11:32:55','2026-07-07 11:38:46','1','::1','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36'),('sboln5eadc4cprsuq05kmqjg7m','csrf|N;_staff|a:1:{s:4:\"auth\";a:2:{s:4:\"dest\";s:21:\"/osticket/upload/scp/\";s:3:\"msg\";s:26:\"AutenticaÃ§Ã£o NecessÃ¡ria\";}}','2026-07-08 10:35:45','2026-07-07 10:35:45','0','::1','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36'),('smu9jcin6ohh29jl1q46be9p2n','csrf|a:2:{s:5:\"token\";s:40:\"ea1955471b32d15327f4cf3dabe6ce82574b0f25\";s:4:\"time\";i:1783431344;}','2026-07-08 10:35:44','2026-07-07 10:35:44','0','::1','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36'),('upf1ee4m73gd3ha9hltf801b4v','csrf|a:2:{s:5:\"token\";s:40:\"6b446f725f53a85e1f7a7eae0e048029a4a94a55\";s:4:\"time\";i:1783427061;}_staff|a:1:{s:4:\"auth\";a:2:{s:4:\"dest\";s:38:\"/osticket/upload/scp/tickets.php?id=19\";s:3:\"msg\";s:26:\"AutenticaÃ§Ã£o NecessÃ¡ria\";}}_auth|a:1:{s:5:\"staff\";a:3:{s:2:\"id\";i:1;s:3:\"key\";s:19:\"local:julianotorres\";s:3:\"2fa\";N;}}:token|a:1:{s:5:\"staff\";s:76:\"5ec9e5fcef79147bd3bbb474f626aaf9:1783427057:837ec5754f503cfaaee0929fd48974e7\";}TIME_BOMB|i:1783427070;cfg:core|a:1:{s:11:\"db_timezone\";s:17:\"America/Sao_Paulo\";}lastcroncall|i:1783427061;','2026-07-08 09:24:08','2026-07-07 09:24:21','1','::1','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36');
/*!40000 ALTER TABLE `ost_session` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ost_sla`
--

DROP TABLE IF EXISTS `ost_sla`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `ost_sla` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `schedule_id` int(10) unsigned NOT NULL DEFAULT 0,
  `flags` int(10) unsigned NOT NULL DEFAULT 3,
  `grace_period` int(10) unsigned NOT NULL DEFAULT 0,
  `name` varchar(64) NOT NULL DEFAULT '',
  `notes` text DEFAULT NULL,
  `created` datetime NOT NULL,
  `updated` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ost_sla`
--

LOCK TABLES `ost_sla` WRITE;
/*!40000 ALTER TABLE `ost_sla` DISABLE KEYS */;
INSERT INTO `ost_sla` VALUES (1,0,3,18,'SLA PadrÃ£o',NULL,'2026-07-01 10:26:32','2026-07-01 10:26:32');
/*!40000 ALTER TABLE `ost_sla` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ost_staff`
--

DROP TABLE IF EXISTS `ost_staff`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `ost_staff` (
  `staff_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `dept_id` int(10) unsigned NOT NULL DEFAULT 0,
  `role_id` int(10) unsigned NOT NULL DEFAULT 0,
  `username` varchar(32) NOT NULL DEFAULT '',
  `firstname` varchar(32) DEFAULT NULL,
  `lastname` varchar(32) DEFAULT NULL,
  `passwd` varchar(128) DEFAULT NULL,
  `backend` varchar(32) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `phone` varchar(24) NOT NULL DEFAULT '',
  `phone_ext` varchar(6) DEFAULT NULL,
  `mobile` varchar(24) NOT NULL DEFAULT '',
  `signature` text NOT NULL,
  `lang` varchar(16) DEFAULT NULL,
  `timezone` varchar(64) DEFAULT NULL,
  `locale` varchar(16) DEFAULT NULL,
  `notes` text DEFAULT NULL,
  `isactive` tinyint(1) NOT NULL DEFAULT 1,
  `isadmin` tinyint(1) NOT NULL DEFAULT 0,
  `isvisible` tinyint(1) unsigned NOT NULL DEFAULT 1,
  `onvacation` tinyint(1) unsigned NOT NULL DEFAULT 0,
  `assigned_only` tinyint(1) unsigned NOT NULL DEFAULT 0,
  `show_assigned_tickets` tinyint(1) unsigned NOT NULL DEFAULT 0,
  `change_passwd` tinyint(1) unsigned NOT NULL DEFAULT 0,
  `max_page_size` int(11) unsigned NOT NULL DEFAULT 0,
  `auto_refresh_rate` int(10) unsigned NOT NULL DEFAULT 0,
  `default_signature_type` enum('none','mine','dept') NOT NULL DEFAULT 'none',
  `default_paper_size` enum('Letter','Legal','Ledger','A4','A3') NOT NULL DEFAULT 'Letter',
  `extra` text DEFAULT NULL,
  `permissions` text DEFAULT NULL,
  `created` datetime NOT NULL,
  `lastlogin` datetime DEFAULT NULL,
  `passwdreset` datetime DEFAULT NULL,
  `updated` datetime NOT NULL,
  PRIMARY KEY (`staff_id`),
  UNIQUE KEY `username` (`username`),
  KEY `dept_id` (`dept_id`),
  KEY `issuperuser` (`isadmin`),
  KEY `isactive` (`isactive`),
  KEY `onvacation` (`onvacation`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ost_staff`
--

LOCK TABLES `ost_staff` WRITE;
/*!40000 ALTER TABLE `ost_staff` DISABLE KEYS */;
INSERT INTO `ost_staff` VALUES (1,1,1,'julianotorres','Juliano','Torres','$2a$08$91ngfjnxRLw372ME1aL8KeaM3vQDKwyPqTPn1HprI.YAoS29OkU7a',NULL,'juliano.zkteco@gmail.com','',NULL,'','',NULL,NULL,NULL,NULL,1,1,1,0,0,0,0,25,0,'none','Letter','{\"browser_lang\":\"pt_BR\"}','{\"user.create\":1,\"user.delete\":1,\"user.edit\":1,\"user.manage\":1,\"user.dir\":1,\"org.create\":1,\"org.delete\":1,\"org.edit\":1,\"faq.manage\":1,\"visibility.agents\":1,\"emails.banlist\":1,\"visibility.departments\":1}','2026-07-01 10:26:33','2026-07-13 13:04:40','2026-07-01 10:26:33','2026-07-13 13:04:40');
/*!40000 ALTER TABLE `ost_staff` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ost_staff_dept_access`
--

DROP TABLE IF EXISTS `ost_staff_dept_access`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `ost_staff_dept_access` (
  `staff_id` int(10) unsigned NOT NULL DEFAULT 0,
  `dept_id` int(10) unsigned NOT NULL DEFAULT 0,
  `role_id` int(10) unsigned NOT NULL DEFAULT 0,
  `flags` int(10) unsigned NOT NULL DEFAULT 1,
  PRIMARY KEY (`staff_id`,`dept_id`),
  KEY `dept_id` (`dept_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ost_staff_dept_access`
--

LOCK TABLES `ost_staff_dept_access` WRITE;
/*!40000 ALTER TABLE `ost_staff_dept_access` DISABLE KEYS */;
INSERT INTO `ost_staff_dept_access` VALUES (1,2,1,1),(1,3,1,1);
/*!40000 ALTER TABLE `ost_staff_dept_access` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ost_syslog`
--

DROP TABLE IF EXISTS `ost_syslog`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `ost_syslog` (
  `log_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `log_type` enum('Debug','Warning','Error') NOT NULL,
  `title` varchar(255) NOT NULL,
  `log` text NOT NULL,
  `logger` varchar(64) NOT NULL,
  `ip_address` varchar(64) NOT NULL,
  `created` datetime NOT NULL,
  `updated` datetime NOT NULL,
  PRIMARY KEY (`log_id`),
  KEY `log_type` (`log_type`)
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ost_syslog`
--

LOCK TABLES `ost_syslog` WRITE;
/*!40000 ALTER TABLE `ost_syslog` DISABLE KEYS */;
INSERT INTO `ost_syslog` VALUES (1,'Debug','osTicket installed!','ParabÃ©ns a instalaÃ§Ã£o bÃ¡sica do osTicket estÃ¡ concluÃ­da!\nObrigado por escolher o osTicket!','','::1','2026-07-01 10:26:34','2026-07-01 10:26:34'),(2,'Warning','Token CSRF invÃ¡lido __CSRFToken__','Token CSRF invÃ¡lido [cfc3b9427115be751f5c31066e2b31e91e766a52] em http://localhost/osticket/upload/scp/emails.php?id=1','','::1','2026-07-01 10:40:37','2026-07-01 10:40:37'),(3,'Warning','Token CSRF invÃ¡lido __CSRFToken__','Token CSRF invÃ¡lido [cfc3b9427115be751f5c31066e2b31e91e766a52] em http://localhost/osticket/upload/scp/emails.php?id=1','','::1','2026-07-01 10:40:41','2026-07-01 10:40:41'),(4,'Warning','Token CSRF invÃ¡lido __CSRFToken__','Token CSRF invÃ¡lido [c89f4b9825910a92f843b71bd1eab5d87aaf2987] em http://localhost/osticket/upload/scp/login.php','','::1','2026-07-01 13:44:15','2026-07-01 13:44:15'),(5,'Warning','Token CSRF invÃ¡lido __CSRFToken__','Token CSRF invÃ¡lido [05588d3aadf0edccdba3108ce7be87321d0c3941] em http://localhost/osticket/upload/open.php','','::1','2026-07-01 20:28:01','2026-07-01 20:28:01'),(6,'Warning','Token CSRF invÃ¡lido __CSRFToken__','Token CSRF invÃ¡lido [c3b61daf7e6ba442a1c83120c75e9816db60ee3a] em http://localhost/osticket/upload/login.php','','::1','2026-07-02 13:48:12','2026-07-02 13:48:12'),(7,'Warning','Token CSRF invÃ¡lido __CSRFToken__','Token CSRF invÃ¡lido [279c1d20104e8b10399fd1434b5eefb6a4962963] em http://localhost/osticket/upload/scp/login.php','','::1','2026-07-02 13:48:45','2026-07-02 13:48:45'),(8,'Warning','Token CSRF invÃ¡lido __CSRFToken__','Token CSRF invÃ¡lido [2437a001e8a0f82323e596263ffbf90d15ab5082] em http://localhost/osticket/upload/login.php','','::1','2026-07-03 14:34:21','2026-07-03 14:34:21'),(9,'Warning','Token CSRF invÃ¡lido __CSRFToken__','Token CSRF invÃ¡lido [2f692e2d2df2d0554f0124fc1ad4490edcdf6721] em http://localhost/osticket/upload/scp/login.php','','::1','2026-07-04 09:27:01','2026-07-04 09:27:01'),(10,'Error','Erro no serviÃ§o de envio de e-mail','NÃ£o foi possÃ­vel o envio do email por SMTP: juliano.torres@zkteco.com (ssl://smtp.exmail.qq.com:465/SMTP) Could not read from smtp.exmail.qq.com ','','::1','2026-07-04 09:40:32','2026-07-04 09:40:32'),(11,'Error','Erro no serviÃ§o de envio de e-mail','Unable to email via Sendmail Unable to send mail: mail(): Failed to connect to mailserver at \"localhost\" port 25, verify your \"SMTP\" and \"smtp_port\" setting in php.ini or use ini_set() ','','::1','2026-07-04 09:40:34','2026-07-04 09:40:34'),(12,'Warning','Token CSRF invÃ¡lido __CSRFToken__','Token CSRF invÃ¡lido [0db67565a98738e424b4e13e65794a7630f18166] em http://localhost/osticket/upload/zk-equip-edit.php','','::1','2026-07-06 07:56:47','2026-07-06 07:56:47'),(13,'Warning','Token CSRF invÃ¡lido __CSRFToken__','Token CSRF invÃ¡lido [06cb865d105c5a2c1cdc82ddbcb5efac1eea9d5a] em http://localhost/osticket/upload/scp/ajax.php/tickets/19/status','','::1','2026-07-07 08:52:12','2026-07-07 08:52:12'),(14,'Warning','Token CSRF invÃ¡lido __CSRFToken__','Token CSRF invÃ¡lido [e91a25bf84a6082060ae25f9cde190e530557d21] em http://localhost:8080/scp/login.php','','172.18.0.1','2026-07-07 17:21:10','2026-07-07 17:21:10'),(15,'Warning','Token CSRF invÃ¡lido __CSRFToken__','Token CSRF invÃ¡lido [85823ed94e65f1326b152dce563f1f93746f2954] em http://localhost:8080/scp/login.php','','172.18.0.1','2026-07-07 17:30:26','2026-07-07 17:30:26'),(16,'Warning','Token CSRF invÃ¡lido __CSRFToken__','Token CSRF invÃ¡lido [e8abbf39686fcf9943f07c5de4f5b86b8c8f5b9d] em http://localhost:8080/login.php','','172.18.0.1','2026-07-07 19:40:17','2026-07-07 19:40:17'),(17,'Warning','Token CSRF invÃ¡lido __CSRFToken__','Token CSRF invÃ¡lido [ac5fe44534cbf2256ae3775ad0d657681ab04aa4] em http://localhost:8080/scp/login.php','','172.18.0.1','2026-07-09 11:34:17','2026-07-09 11:34:17'),(18,'Warning','Token CSRF invÃ¡lido __CSRFToken__','Token CSRF invÃ¡lido [tokeninvalido] em http://localhost:8080/login.php','','172.18.0.1','2026-07-09 12:04:48','2026-07-09 12:04:48'),(19,'Warning','Token CSRF invÃ¡lido __CSRFToken__','Token CSRF invÃ¡lido [tokeninvalido] em http://localhost:8080/login.php','','172.18.0.1','2026-07-09 12:04:49','2026-07-09 12:04:49'),(20,'Warning','Token CSRF invÃ¡lido __CSRFToken__','Token CSRF invÃ¡lido [tokeninvalido] em http://localhost:8080/scp/login.php','','172.18.0.1','2026-07-09 12:04:55','2026-07-09 12:04:55'),(21,'Warning','Token CSRF invÃ¡lido __CSRFToken__','Token CSRF invÃ¡lido [tokeninvalido] em http://localhost:8080/login.php','','172.18.0.1','2026-07-09 12:05:19','2026-07-09 12:05:19'),(22,'Warning','Token CSRF invÃ¡lido __CSRFToken__','Token CSRF invÃ¡lido [7bc889dc825dbb8d23d8e69441166b8fb7b74033] em http://localhost:8080/login.php','','172.18.0.1','2026-07-09 12:23:47','2026-07-09 12:23:47'),(23,'Warning','Token CSRF invÃ¡lido __CSRFToken__','Token CSRF invÃ¡lido [0c86eee03a068ff678e683f74ce5b46d4d63ce92] em http://localhost:8080/scp/login.php','','172.18.0.1','2026-07-13 12:59:33','2026-07-13 12:59:33'),(24,'Warning','Falha ao inciar uma sessÃ£o de um agente (julianotorres@gmail.com)','Nome de usuÃ¡rio: julianotorres@gmail.com IP: 172.18.0.1 Tempo: Jul 13, 2026, 1:00 pm UTC Tentativas: 3','','172.18.0.1','2026-07-13 13:00:01','2026-07-13 13:00:01'),(25,'Warning','Excessivas tentativas de login (julianotorres@gmail.com)','Excessivas tentativas de login por um agente? Nome de usuÃ¡rio: julianotorres@gmail.com IP: 172.18.0.1 Tempo: Jul 13, 2026, 1:00 pm UTC Tentativas: 5 Tempo de espera: 2 minutos ','','172.18.0.1','2026-07-13 13:00:42','2026-07-13 13:00:42'),(26,'Error','Erro no serviÃ§o de envio de e-mail','Unable to email via Sendmail Unable to send mail: Unknown error ','','172.18.0.1','2026-07-13 13:00:43','2026-07-13 13:00:43'),(27,'Warning','Excessivas tentativas de login (julianotorres@gmail.com)','Excessivas tentativas de login por um agente? Nome de usuÃ¡rio: julianotorres@gmail.com IP: 172.18.0.1 Tempo: Jul 13, 2026, 1:00 pm UTC Tentativas: 6 Tempo de espera: 2 minutos ','','172.18.0.1','2026-07-13 13:00:49','2026-07-13 13:00:49'),(28,'Error','Erro no serviÃ§o de envio de e-mail','Unable to email via Sendmail Unable to send mail: Unknown error ','','172.18.0.1','2026-07-13 13:00:49','2026-07-13 13:00:49'),(29,'Warning','Excessivas tentativas de login ()','Excessivas tentativas de login por um agente? Nome de usuÃ¡rio: IP: 172.18.0.1 Tempo: Jul 13, 2026, 1:01 pm UTC Tentativas: 7 Tempo de espera: 2 minutos ','','172.18.0.1','2026-07-13 13:01:10','2026-07-13 13:01:10'),(30,'Error','Erro no serviÃ§o de envio de e-mail','Unable to email via Sendmail Unable to send mail: Unknown error ','','172.18.0.1','2026-07-13 13:01:11','2026-07-13 13:01:11'),(31,'Warning','Excessivas de tentativas de login (usuÃ¡rio)','Nome de usuÃ¡rio: juliano.zkteco@gmail.com IP: 172.18.0.1 Tempo: Jul 13, 2026, 1:01 pm UTC Tentativas: 3','','172.18.0.1','2026-07-13 13:01:52','2026-07-13 13:01:52'),(32,'Warning','Token CSRF invÃ¡lido __CSRFToken__','Token CSRF invÃ¡lido [91d07b09ff27ba9e40066487bbcf3e878ade0cca] em http://localhost:8080/scp/login.php','','172.18.0.1','2026-07-13 13:04:28','2026-07-13 13:04:28');
/*!40000 ALTER TABLE `ost_syslog` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ost_task`
--

DROP TABLE IF EXISTS `ost_task`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `ost_task` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `object_id` int(11) NOT NULL DEFAULT 0,
  `object_type` char(1) NOT NULL,
  `number` varchar(20) DEFAULT NULL,
  `dept_id` int(10) unsigned NOT NULL DEFAULT 0,
  `staff_id` int(10) unsigned NOT NULL DEFAULT 0,
  `team_id` int(10) unsigned NOT NULL DEFAULT 0,
  `lock_id` int(11) unsigned NOT NULL DEFAULT 0,
  `flags` int(10) unsigned NOT NULL DEFAULT 0,
  `duedate` datetime DEFAULT NULL,
  `closed` datetime DEFAULT NULL,
  `created` datetime NOT NULL,
  `updated` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `dept_id` (`dept_id`),
  KEY `staff_id` (`staff_id`),
  KEY `team_id` (`team_id`),
  KEY `created` (`created`),
  KEY `object` (`object_id`,`object_type`),
  KEY `flags` (`flags`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ost_task`
--

LOCK TABLES `ost_task` WRITE;
/*!40000 ALTER TABLE `ost_task` DISABLE KEYS */;
/*!40000 ALTER TABLE `ost_task` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ost_task__cdata`
--

DROP TABLE IF EXISTS `ost_task__cdata`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `ost_task__cdata` (
  `task_id` int(11) unsigned NOT NULL,
  `title` mediumtext DEFAULT NULL,
  PRIMARY KEY (`task_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ost_task__cdata`
--

LOCK TABLES `ost_task__cdata` WRITE;
/*!40000 ALTER TABLE `ost_task__cdata` DISABLE KEYS */;
/*!40000 ALTER TABLE `ost_task__cdata` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ost_team`
--

DROP TABLE IF EXISTS `ost_team`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `ost_team` (
  `team_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `lead_id` int(10) unsigned NOT NULL DEFAULT 0,
  `flags` int(10) unsigned NOT NULL DEFAULT 1,
  `name` varchar(125) NOT NULL DEFAULT '',
  `notes` text DEFAULT NULL,
  `created` datetime NOT NULL,
  `updated` datetime NOT NULL,
  PRIMARY KEY (`team_id`),
  UNIQUE KEY `name` (`name`),
  KEY `lead_id` (`lead_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ost_team`
--

LOCK TABLES `ost_team` WRITE;
/*!40000 ALTER TABLE `ost_team` DISABLE KEYS */;
INSERT INTO `ost_team` VALUES (1,0,1,'NÃ­vel 1 de Atendimento','Atendimento de nÃ­vel 1, responsÃ¡vel pelo atendimento inicial aos clientes','2026-07-01 10:26:32','2026-07-01 10:26:32');
/*!40000 ALTER TABLE `ost_team` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ost_team_member`
--

DROP TABLE IF EXISTS `ost_team_member`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `ost_team_member` (
  `team_id` int(10) unsigned NOT NULL DEFAULT 0,
  `staff_id` int(10) unsigned NOT NULL,
  `flags` int(10) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`team_id`,`staff_id`),
  KEY `staff_id` (`staff_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ost_team_member`
--

LOCK TABLES `ost_team_member` WRITE;
/*!40000 ALTER TABLE `ost_team_member` DISABLE KEYS */;
/*!40000 ALTER TABLE `ost_team_member` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ost_thread`
--

DROP TABLE IF EXISTS `ost_thread`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `ost_thread` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `object_id` int(11) unsigned NOT NULL,
  `object_type` char(1) NOT NULL,
  `extra` text DEFAULT NULL,
  `lastresponse` datetime DEFAULT NULL,
  `lastmessage` datetime DEFAULT NULL,
  `created` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `object_id` (`object_id`),
  KEY `object_type` (`object_type`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ost_thread`
--

LOCK TABLES `ost_thread` WRITE;
/*!40000 ALTER TABLE `ost_thread` DISABLE KEYS */;
INSERT INTO `ost_thread` VALUES (18,18,'T',NULL,'2026-07-04 09:56:50','2026-07-04 09:52:05','2026-07-03 22:59:06'),(19,19,'T',NULL,'2026-07-13 13:29:41','2026-07-06 07:32:28','2026-07-06 07:32:28'),(20,20,'T',NULL,NULL,'2026-07-07 17:28:09','2026-07-07 17:28:09'),(21,21,'T',NULL,NULL,'2026-07-13 13:26:47','2026-07-13 13:26:47');
/*!40000 ALTER TABLE `ost_thread` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ost_thread_collaborator`
--

DROP TABLE IF EXISTS `ost_thread_collaborator`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `ost_thread_collaborator` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `flags` int(10) unsigned NOT NULL DEFAULT 1,
  `thread_id` int(11) unsigned NOT NULL DEFAULT 0,
  `user_id` int(11) unsigned NOT NULL DEFAULT 0,
  `role` char(1) NOT NULL DEFAULT 'M',
  `created` datetime NOT NULL,
  `updated` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `collab` (`thread_id`,`user_id`),
  KEY `user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ost_thread_collaborator`
--

LOCK TABLES `ost_thread_collaborator` WRITE;
/*!40000 ALTER TABLE `ost_thread_collaborator` DISABLE KEYS */;
/*!40000 ALTER TABLE `ost_thread_collaborator` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ost_thread_entry`
--

DROP TABLE IF EXISTS `ost_thread_entry`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `ost_thread_entry` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `pid` int(11) unsigned NOT NULL DEFAULT 0,
  `thread_id` int(11) unsigned NOT NULL DEFAULT 0,
  `staff_id` int(11) unsigned NOT NULL DEFAULT 0,
  `user_id` int(11) unsigned NOT NULL DEFAULT 0,
  `type` char(1) NOT NULL DEFAULT '',
  `flags` int(11) unsigned NOT NULL DEFAULT 0,
  `poster` varchar(128) NOT NULL DEFAULT '',
  `editor` int(10) unsigned DEFAULT NULL,
  `editor_type` char(1) DEFAULT NULL,
  `source` varchar(32) NOT NULL DEFAULT '',
  `title` varchar(255) DEFAULT NULL,
  `body` text NOT NULL,
  `format` varchar(16) NOT NULL DEFAULT 'html',
  `ip_address` varchar(64) NOT NULL DEFAULT '',
  `extra` text DEFAULT NULL,
  `recipients` text DEFAULT NULL,
  `created` datetime NOT NULL,
  `updated` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `pid` (`pid`),
  KEY `thread_id` (`thread_id`),
  KEY `staff_id` (`staff_id`),
  KEY `type` (`type`)
) ENGINE=InnoDB AUTO_INCREMENT=117 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ost_thread_entry`
--

LOCK TABLES `ost_thread_entry` WRITE;
/*!40000 ALTER TABLE `ost_thread_entry` DISABLE KEYS */;
INSERT INTO `ost_thread_entry` VALUES (87,0,18,0,2,'M',65,'Juliano Torres Rezende',NULL,NULL,'','ManutenÃ§Ã£o â€” v5l (S/N 1234)','<p>SolicitaÃ§Ã£o de manutenÃ§Ã£o com <b>1</b> equipamento(s):</p><ol><li><b>v5l</b> â€” S/N 1234<br /><i>Resumo:</i> test<br /><i>Detalhamento/ObservaÃ§Ã£o:</i> tetes</li></ol>','html','::1',NULL,NULL,'2026-07-03 22:59:06','2026-07-03 22:59:06'),(88,0,18,0,0,'N',192,'Juliano Torres Rezende',NULL,NULL,'','Envio do produto informado','O solicitante informou o envio do produto: OUTRA','html','::1',NULL,NULL,'2026-07-03 23:01:52','2026-07-03 23:01:52'),(89,0,18,0,0,'N',192,'Juliano Torres Rezende',NULL,NULL,'','Envio do produto confirmado','O solicitante confirmou que o produto foi enviado: OUTRA','html','::1',NULL,NULL,'2026-07-03 23:01:56','2026-07-03 23:01:56'),(90,0,18,1,0,'N',64,'Juliano Torres',NULL,NULL,'','Nota Fiscal verificada','XML da Nota Fiscal verificado â€” sem erros.','html','::1',NULL,NULL,'2026-07-03 23:09:43','2026-07-03 23:09:43'),(91,0,18,0,0,'N',192,'SYSTEM (Auto Assignment)',NULL,NULL,'','Ticket Assigned to Juliano Torres','Produto recebido na ZKTeco (teste do fluxo de chegada)','html','',NULL,NULL,'2026-07-03 23:16:53','2026-07-03 23:16:53'),(92,0,18,0,0,'N',192,'SYSTEM (Auto Assignment)',NULL,NULL,'','Ticket Assigned to Juliano Torres','ReatribuiÃ§Ã£o (idempotÃªncia)','html','',NULL,NULL,'2026-07-03 23:16:53','2026-07-03 23:16:53'),(93,87,18,1,0,'R',64,'Juliano Torres',NULL,NULL,'',NULL,'<p><b>AtualizaÃ§Ã£o dos seus equipamentos:</b></p><ul><li><b>v5l (S/N 1234)</b>: status atualizado para <b>Em anÃ¡lise</b></li><li><b>v5l (S/N 1234)</b> â€” laudo tÃ©cnico:<br /><em>Equipamento em anÃ¡lise no laboratÃ³rio. Identificado desgaste no conector do touch â€” aguardando teste de bancada para confirmar a troca.</em></li></ul><p style=\"color:#666;font-size:12px\">VocÃª pode acompanhar todos os detalhes abrindo o chamado no portal.</p>','html','',NULL,NULL,'2026-07-04 09:34:08','2026-07-04 09:34:08'),(94,0,18,0,2,'M',64,'Juliano Torres Rezende',NULL,NULL,'',NULL,'<p>Entendido, estou no aguardo</p>','html','::1',NULL,NULL,'2026-07-04 09:39:33','2026-07-04 09:39:33'),(95,94,18,1,0,'R',64,'Juliano Torres',NULL,NULL,'',NULL,'<p><b>AtualizaÃ§Ã£o dos seus equipamentos:</b></p><ul><li><b>v5l (S/N 1234)</b> â€” laudo tÃ©cnico:<br /><em>Checando tela e sensor</em></li></ul><p style=\"color:#666;font-size:12px\">VocÃª pode acompanhar todos os detalhes abrindo o chamado no portal.</p>','html','::1',NULL,NULL,'2026-07-04 09:41:57','2026-07-04 09:41:57'),(96,0,18,0,2,'M',64,'Juliano Torres Rezende',NULL,NULL,'',NULL,'<p>Entendido, estou no aguardo</p>','html','::1',NULL,NULL,'2026-07-04 09:42:26','2026-07-04 09:42:26'),(97,96,18,1,0,'R',64,'Juliano Torres',NULL,NULL,'',NULL,'<p><b>AtualizaÃ§Ã£o dos seus equipamentos:</b></p><ul><li><b>v5l (S/N 1234)</b>: status atualizado para <b>Em reparo</b></li></ul><p style=\"color:#666;font-size:12px\">VocÃª pode acompanhar todos os detalhes abrindo o chamado no portal.</p>','html','::1',NULL,NULL,'2026-07-04 09:51:29','2026-07-04 09:51:29'),(98,0,18,0,2,'M',64,'Juliano Torres Rezende',NULL,NULL,'',NULL,'<p>Entendido, estou no aguardo</p>','html','::1',NULL,NULL,'2026-07-04 09:52:05','2026-07-04 09:52:05'),(99,0,18,1,0,'N',64,'Juliano Torres',NULL,NULL,'','Status Alterado','<p>ManutenÃ§Ã£o finalizada</p>','html','::1',NULL,NULL,'2026-07-04 09:54:28','2026-07-04 09:54:28'),(100,98,18,1,0,'R',64,'Juliano Torres',NULL,NULL,'',NULL,'<p><b>AtualizaÃ§Ã£o dos seus equipamentos:</b></p><ul><li><b>v5l (S/N 1234)</b>: status atualizado para <b>Reparado</b></li></ul><p style=\"color:#666;font-size:12px\">VocÃª pode acompanhar todos os detalhes abrindo o chamado no portal.</p>','html','::1',NULL,NULL,'2026-07-04 09:56:50','2026-07-04 09:56:50'),(101,0,19,0,2,'M',65,'Juliano Torres Rezende',NULL,NULL,'','ManutenÃ§Ã£o â€” 4 equipamentos: V5L, V4L, Proma, Proface','<p>SolicitaÃ§Ã£o de manutenÃ§Ã£o com <b>4</b> equipamento(s):</p><ol><li><b>V5L</b> â€” S/N 4444<br /><i>Resumo:</i> teste<br /><i>Detalhamento/ObservaÃ§Ã£o:</i> teste</li><li><b>V4L</b> â€” S/N 3333<br /><i>Resumo:</i> teste<br /><i>Detalhamento/ObservaÃ§Ã£o:</i> teste</li><li><b>Proma</b> â€” S/N 5555<br /><i>Resumo:</i> teste<br /><i>Detalhamento/ObservaÃ§Ã£o:</i> teste</li><li><b>Proface</b> â€” S/N 8888<br /><i>Resumo:</i> teste<br /><i>Detalhamento/ObservaÃ§Ã£o:</i> teste</li></ol>','html','::1',NULL,NULL,'2026-07-06 07:32:28','2026-07-06 07:32:28'),(102,0,19,0,0,'N',192,'Juliano Torres Rezende',NULL,NULL,'','Envio do produto informado','O solicitante informou o envio do produto: O PRÃ“PRIO','html','::1',NULL,NULL,'2026-07-06 07:57:19','2026-07-06 07:57:19'),(103,0,19,0,0,'N',192,'Juliano Torres Rezende',NULL,NULL,'','Envio do produto confirmado','O solicitante confirmou que o produto foi enviado: O PRÃ“PRIO','html','::1',NULL,NULL,'2026-07-06 07:57:32','2026-07-06 07:57:32'),(104,0,19,1,0,'N',64,'Juliano Torres',NULL,NULL,'','Status Alterado','<p>Inicada a anÃ¡lise</p>','html','::1',NULL,NULL,'2026-07-07 08:46:42','2026-07-07 08:46:42'),(105,0,19,1,0,'N',64,'Juliano Torres',NULL,NULL,'','Status Alterado','<p>recebido</p>','html','::1',NULL,NULL,'2026-07-07 08:53:12','2026-07-07 08:53:12'),(106,0,19,1,0,'N',64,'Juliano Torres',NULL,NULL,'','Status Alterado','<p>Iniciado</p>','html','::1',NULL,NULL,'2026-07-07 08:53:38','2026-07-07 08:53:38'),(107,0,20,0,2,'M',65,'Juliano Torres Rezende',NULL,NULL,'','ManutenÃ§Ã£o â€” V5L (S/N 872347376)','<p>SolicitaÃ§Ã£o de manutenÃ§Ã£o com <b>1</b> equipamento(s):</p><ol><li><b>V5L</b> â€” S/N 872347376<br /><i>Resumo:</i> NÃ£o liga<br /><i>Detalhamento/ObservaÃ§Ã£o:</i> Caiu um raio</li></ol>','html','172.18.0.1',NULL,NULL,'2026-07-07 17:28:09','2026-07-07 17:28:09'),(108,0,20,0,0,'N',192,'Juliano Torres Rezende',NULL,NULL,'','Envio do produto informado','O solicitante informou o envio do produto: O PRÃ“PRIO','html','172.18.0.1',NULL,NULL,'2026-07-07 17:29:23','2026-07-07 17:29:23'),(109,0,20,0,0,'N',192,'Juliano Torres Rezende',NULL,NULL,'','Envio do produto confirmado','O solicitante confirmou que o produto foi enviado: O PRÃ“PRIO','html','172.18.0.1',NULL,NULL,'2026-07-07 17:29:47','2026-07-07 17:29:47'),(110,0,20,1,0,'N',64,'Juliano Torres',NULL,NULL,'','Status Alterado','<p>teste</p>','html','172.18.0.1',NULL,NULL,'2026-07-07 17:31:15','2026-07-07 17:31:15'),(111,101,19,1,0,'R',64,'Juliano Torres',NULL,NULL,'',NULL,'<p><b>AtualizaÃ§Ã£o dos seus equipamentos:</b></p><ul><li><b>V5L (S/N 4444)</b>: status atualizado para <b>Em anÃ¡lise</b></li></ul><p style=\"color:#666;font-size:12px\">VocÃª pode acompanhar todos os detalhes abrindo o chamado no portal.</p>','html','172.18.0.1',NULL,NULL,'2026-07-07 19:50:32','2026-07-07 19:50:32'),(112,101,19,1,0,'R',64,'Juliano Torres',NULL,NULL,'',NULL,'<p><b>AtualizaÃ§Ã£o dos seus equipamentos:</b></p><ul><li><b>V4L (S/N 3333)</b>: status atualizado para <b>Em anÃ¡lise</b></li></ul><p style=\"color:#666;font-size:12px\">VocÃª pode acompanhar todos os detalhes abrindo o chamado no portal.</p>','html','172.18.0.1',NULL,NULL,'2026-07-07 20:17:36','2026-07-07 20:17:36'),(113,101,19,1,0,'R',64,'Juliano Torres',NULL,NULL,'',NULL,'<p><b>AtualizaÃ§Ã£o dos seus equipamentos:</b></p><ul><li><b>Proma (S/N 5555)</b>: status atualizado para <b>Em anÃ¡lise</b></li><li><b>Proma (S/N 5555)</b> â€” laudo tÃ©cnico:<br /><em>Aguardando peÃ§a</em></li></ul><p style=\"color:#666;font-size:12px\">VocÃª pode acompanhar todos os detalhes abrindo o chamado no portal.</p>','html','172.18.0.1',NULL,NULL,'2026-07-13 13:06:53','2026-07-13 13:06:53'),(114,101,19,1,0,'R',64,'Juliano Torres',NULL,NULL,'',NULL,'<p><b>AtualizaÃ§Ã£o dos seus equipamentos:</b></p><ul><li><b>Proma (S/N 5555)</b>: status atualizado para <b>Aguardando peÃ§a</b></li><li><b>Proma (S/N 5555)</b> â€” laudo tÃ©cnico:<br /><em>Aguardando display</em></li><li><b>Proface (S/N 8888)</b>: status atualizado para <b>Em anÃ¡lise</b></li><li><b>Proface (S/N 8888)</b> â€” laudo tÃ©cnico:<br /><em>Iniciando testes</em></li></ul><p style=\"color:#666;font-size:12px\">VocÃª pode acompanhar todos os detalhes abrindo o chamado no portal.</p>','html','172.18.0.1',NULL,NULL,'2026-07-13 13:22:00','2026-07-13 13:22:00'),(115,0,21,0,2,'M',65,'Juliano Torres Rezende',NULL,NULL,'','ManutenÃ§Ã£o â€” V3L Lite (S/N 24234234)','<p>SolicitaÃ§Ã£o de manutenÃ§Ã£o com <b>1</b> equipamento(s):</p><ol><li><b>V3L Lite</b> â€” S/N 24234234<br /><i>Resumo:</i> teste<br /><i>Detalhamento/ObservaÃ§Ã£o:</i> teste</li></ol>','html','172.18.0.1',NULL,NULL,'2026-07-13 13:26:47','2026-07-13 13:26:47'),(116,101,19,1,0,'R',64,'Juliano Torres',NULL,NULL,'',NULL,'<p><b>AtualizaÃ§Ã£o dos seus equipamentos:</b></p><ul><li><b>Proma (S/N 5555)</b>: status atualizado para <b>Em reparo</b></li></ul><p style=\"color:#666;font-size:12px\">VocÃª pode acompanhar todos os detalhes abrindo o chamado no portal.</p>','html','172.18.0.1',NULL,NULL,'2026-07-13 13:29:41','2026-07-13 13:29:41');
/*!40000 ALTER TABLE `ost_thread_entry` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ost_thread_entry_email`
--

DROP TABLE IF EXISTS `ost_thread_entry_email`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `ost_thread_entry_email` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `thread_entry_id` int(11) unsigned NOT NULL,
  `email_id` int(11) unsigned DEFAULT NULL,
  `mid` varchar(255) NOT NULL,
  `headers` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `thread_entry_id` (`thread_entry_id`),
  KEY `mid` (`mid`),
  KEY `email_id` (`email_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ost_thread_entry_email`
--

LOCK TABLES `ost_thread_entry_email` WRITE;
/*!40000 ALTER TABLE `ost_thread_entry_email` DISABLE KEYS */;
/*!40000 ALTER TABLE `ost_thread_entry_email` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ost_thread_entry_merge`
--

DROP TABLE IF EXISTS `ost_thread_entry_merge`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `ost_thread_entry_merge` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `thread_entry_id` int(11) unsigned NOT NULL,
  `data` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `thread_entry_id` (`thread_entry_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ost_thread_entry_merge`
--

LOCK TABLES `ost_thread_entry_merge` WRITE;
/*!40000 ALTER TABLE `ost_thread_entry_merge` DISABLE KEYS */;
/*!40000 ALTER TABLE `ost_thread_entry_merge` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ost_thread_event`
--

DROP TABLE IF EXISTS `ost_thread_event`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `ost_thread_event` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `thread_id` int(11) unsigned NOT NULL DEFAULT 0,
  `thread_type` char(1) NOT NULL DEFAULT '',
  `event_id` int(11) unsigned DEFAULT NULL,
  `staff_id` int(11) unsigned NOT NULL,
  `team_id` int(11) unsigned NOT NULL,
  `dept_id` int(11) unsigned NOT NULL,
  `topic_id` int(11) unsigned NOT NULL,
  `data` varchar(1024) DEFAULT NULL COMMENT 'Encoded differences',
  `username` varchar(128) NOT NULL DEFAULT 'SYSTEM',
  `uid` int(11) unsigned DEFAULT NULL,
  `uid_type` char(1) NOT NULL DEFAULT 'S',
  `annulled` tinyint(1) unsigned NOT NULL DEFAULT 0,
  `timestamp` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `ticket_state` (`thread_id`,`event_id`,`timestamp`),
  KEY `ticket_stats` (`timestamp`,`event_id`)
) ENGINE=InnoDB AUTO_INCREMENT=64 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ost_thread_event`
--

LOCK TABLES `ost_thread_event` WRITE;
/*!40000 ALTER TABLE `ost_thread_event` DISABLE KEYS */;
INSERT INTO `ost_thread_event` VALUES (1,0,'T',1,0,0,1,1,NULL,'SYSTEM',1,'U',0,'2026-07-01 10:26:33'),(2,0,'T',1,0,0,3,1,NULL,'Juliano Torres Rezende',2,'U',0,'2026-07-01 11:14:18'),(3,1,'T',14,1,0,1,1,NULL,'julianotorres',1,'S',0,'2026-07-01 11:19:16'),(4,0,'T',9,1,0,3,1,'{\"fields\":{\"22\":[[\"Normal\",2],null],\"41\":[\"null\",\"{\\\"3\\\":\\\"Imagem2.png\\\"}\"]}}','Juliano Torres Rezende',2,'U',0,'2026-07-01 14:14:22'),(5,0,'T',9,1,0,3,1,'{\"fields\":{\"22\":[[\"Normal\",2],null],\"41\":[\"{\\\"3\\\":\\\"Imagem2.png\\\"}\",\"[]\"]}}','Juliano Torres Rezende',2,'U',0,'2026-07-01 14:59:20'),(6,2,'T',14,1,0,3,1,NULL,'SYSTEM',NULL,'S',0,'2026-07-01 15:02:27'),(7,0,'T',1,0,0,3,1,NULL,'SYSTEM',2,'U',0,'2026-07-01 15:29:24'),(8,3,'T',14,0,0,3,1,NULL,'SYSTEM',NULL,'S',0,'2026-07-01 15:29:32'),(9,0,'T',1,0,0,3,1,NULL,'SYSTEM',2,'U',0,'2026-07-01 15:31:31'),(10,4,'T',14,0,0,3,1,NULL,'SYSTEM',NULL,'S',0,'2026-07-01 15:31:39'),(11,0,'T',1,0,0,3,1,NULL,'Juliano Torres Rezende',2,'U',0,'2026-07-01 19:15:13'),(12,0,'T',1,0,0,3,1,NULL,'Juliano Torres Rezende',2,'U',0,'2026-07-01 19:36:26'),(13,0,'T',1,0,0,3,1,NULL,'Juliano Torres Rezende',2,'U',0,'2026-07-01 20:29:59'),(14,0,'T',1,0,0,3,1,NULL,'Juliano Torres Rezende',2,'U',0,'2026-07-02 09:53:21'),(15,0,'T',1,0,0,3,1,NULL,'Juliano Torres Rezende',2,'U',0,'2026-07-02 10:15:00'),(16,5,'T',14,0,0,3,1,NULL,'Juliano Torres Rezende',NULL,'S',0,'2026-07-02 11:16:55'),(17,6,'T',14,0,0,3,1,NULL,'Juliano Torres Rezende',NULL,'S',0,'2026-07-02 11:16:55'),(18,7,'T',14,0,0,3,1,NULL,'Juliano Torres Rezende',NULL,'S',0,'2026-07-02 11:16:55'),(19,8,'T',14,0,0,3,1,NULL,'Juliano Torres Rezende',NULL,'S',0,'2026-07-02 11:16:55'),(20,9,'T',14,0,0,3,1,NULL,'Juliano Torres Rezende',NULL,'S',0,'2026-07-02 11:16:55'),(21,0,'T',1,0,0,3,1,NULL,'Juliano Torres Rezende',2,'U',0,'2026-07-02 11:36:27'),(22,0,'T',1,0,0,3,1,NULL,'Juliano Torres Rezende',2,'U',0,'2026-07-02 15:24:35'),(23,11,'T',14,0,0,3,1,NULL,'Juliano Torres Rezende',NULL,'S',0,'2026-07-02 15:29:06'),(24,0,'T',9,0,0,3,1,'{\"status\":6}','SYSTEM',NULL,'S',0,'2026-07-02 20:11:32'),(25,0,'T',1,0,0,3,1,NULL,'Juliano Torres Rezende',2,'U',0,'2026-07-03 09:49:29'),(26,0,'T',9,0,0,3,1,'{\"status\":6}','Juliano Torres Rezende',NULL,'S',0,'2026-07-03 14:02:32'),(27,0,'T',1,0,0,3,1,NULL,'OTAVIO PRADO DA SILVA',4,'U',0,'2026-07-03 14:29:00'),(28,0,'T',9,0,0,3,1,'{\"status\":6}','OTAVIO PRADO DA SILVA',NULL,'S',0,'2026-07-03 14:30:25'),(29,0,'T',1,0,0,3,1,NULL,'Juliano Torres Rezende',2,'U',0,'2026-07-03 14:51:54'),(30,0,'T',9,0,0,3,1,'{\"status\":6}','Juliano Torres Rezende',NULL,'S',0,'2026-07-03 15:07:25'),(31,0,'T',1,0,0,3,1,NULL,'Juliano Torres Rezende',2,'U',0,'2026-07-03 15:12:17'),(32,0,'T',9,0,0,3,1,'{\"status\":6}','Juliano Torres Rezende',NULL,'S',0,'2026-07-03 15:12:54'),(33,10,'T',14,0,0,3,1,NULL,'SYSTEM',NULL,'S',0,'2026-07-03 15:17:51'),(34,12,'T',14,1,0,3,1,NULL,'SYSTEM',NULL,'S',0,'2026-07-03 15:17:52'),(35,13,'T',14,0,0,3,1,NULL,'SYSTEM',NULL,'S',0,'2026-07-03 15:17:52'),(36,14,'T',14,0,0,3,1,NULL,'SYSTEM',NULL,'S',0,'2026-07-03 15:17:52'),(37,15,'T',14,0,0,3,1,NULL,'SYSTEM',NULL,'S',0,'2026-07-03 15:17:52'),(38,0,'T',1,0,0,3,1,NULL,'Juliano Torres Rezende',2,'U',0,'2026-07-03 21:41:25'),(39,0,'T',1,0,0,3,1,NULL,'Juliano Torres Rezende',2,'U',0,'2026-07-03 21:55:20'),(40,0,'T',9,0,0,3,1,'{\"status\":6}','Juliano Torres Rezende',NULL,'S',0,'2026-07-03 21:59:34'),(41,16,'T',14,1,0,3,1,NULL,'SYSTEM',NULL,'S',0,'2026-07-03 22:40:11'),(42,17,'T',14,0,0,3,1,NULL,'SYSTEM',NULL,'S',0,'2026-07-03 22:40:11'),(43,18,'T',1,0,0,3,1,NULL,'Juliano Torres Rezende',2,'U',0,'2026-07-03 22:59:06'),(44,18,'T',4,1,0,3,1,'{\"claim\":true}','julianotorres',1,'S',0,'2026-07-03 23:01:17'),(45,18,'T',9,1,0,3,1,'{\"status\":6}','Juliano Torres Rezende',NULL,'S',0,'2026-07-03 23:01:56'),(46,18,'T',4,1,0,3,1,'{\"staff\":1}','SYSTEM',NULL,'S',0,'2026-07-03 23:16:53'),(47,18,'T',9,1,0,3,1,'{\"status\":7}','SYSTEM',NULL,'S',0,'2026-07-03 23:16:53'),(48,18,'T',4,1,0,3,1,'{\"staff\":1}','SYSTEM',NULL,'S',0,'2026-07-03 23:16:53'),(49,18,'T',9,1,0,3,1,'{\"status\":6}','SYSTEM',NULL,'S',0,'2026-07-04 09:30:09'),(50,18,'T',9,1,0,3,1,'{\"status\":7}','SYSTEM',NULL,'S',0,'2026-07-04 09:31:30'),(51,18,'T',2,1,0,3,1,'{\"status\":[2,\"Resolvido\"]}','julianotorres',1,'S',0,'2026-07-04 09:54:28'),(52,19,'T',1,0,0,3,1,NULL,'Juliano Torres Rezende',2,'U',0,'2026-07-06 07:32:28'),(53,19,'T',9,0,0,3,1,'{\"status\":6}','Juliano Torres Rezende',NULL,'S',0,'2026-07-06 07:57:22'),(54,19,'T',9,1,0,3,1,'{\"status\":7}','julianotorres',1,'S',0,'2026-07-06 07:59:16'),(55,19,'T',9,1,0,3,1,'{\"status\":8}','julianotorres',1,'S',0,'2026-07-07 08:46:42'),(56,19,'T',9,1,0,3,1,'{\"status\":7}','julianotorres',1,'S',0,'2026-07-07 08:53:12'),(57,19,'T',9,1,0,3,1,'{\"status\":8}','julianotorres',1,'S',0,'2026-07-07 08:53:38'),(58,20,'T',1,0,0,3,1,NULL,'Juliano Torres Rezende',2,'U',0,'2026-07-07 17:28:09'),(59,20,'T',9,0,0,3,1,'{\"status\":6}','Juliano Torres Rezende',NULL,'S',0,'2026-07-07 17:29:36'),(60,20,'T',9,1,0,3,1,'{\"status\":7}','julianotorres',1,'S',0,'2026-07-07 17:31:15'),(61,19,'T',8,0,0,3,1,NULL,'SYSTEM',NULL,'S',0,'2026-07-09 12:23:45'),(62,20,'T',8,0,0,3,1,NULL,'SYSTEM',NULL,'S',0,'2026-07-13 13:04:42'),(63,21,'T',1,0,0,3,1,NULL,'Juliano Torres Rezende',2,'U',0,'2026-07-13 13:26:47');
/*!40000 ALTER TABLE `ost_thread_event` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ost_thread_referral`
--

DROP TABLE IF EXISTS `ost_thread_referral`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `ost_thread_referral` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `thread_id` int(11) unsigned NOT NULL,
  `object_id` int(11) unsigned NOT NULL,
  `object_type` char(1) NOT NULL,
  `created` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ref` (`object_id`,`object_type`,`thread_id`),
  KEY `thread_id` (`thread_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ost_thread_referral`
--

LOCK TABLES `ost_thread_referral` WRITE;
/*!40000 ALTER TABLE `ost_thread_referral` DISABLE KEYS */;
INSERT INTO `ost_thread_referral` VALUES (1,18,1,'S','2026-07-04 09:54:28');
/*!40000 ALTER TABLE `ost_thread_referral` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ost_ticket`
--

DROP TABLE IF EXISTS `ost_ticket`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `ost_ticket` (
  `ticket_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `ticket_pid` int(11) unsigned DEFAULT NULL,
  `number` varchar(20) DEFAULT NULL,
  `user_id` int(11) unsigned NOT NULL DEFAULT 0,
  `user_email_id` int(11) unsigned NOT NULL DEFAULT 0,
  `status_id` int(10) unsigned NOT NULL DEFAULT 0,
  `dept_id` int(10) unsigned NOT NULL DEFAULT 0,
  `sla_id` int(10) unsigned NOT NULL DEFAULT 0,
  `topic_id` int(10) unsigned NOT NULL DEFAULT 0,
  `staff_id` int(10) unsigned NOT NULL DEFAULT 0,
  `team_id` int(10) unsigned NOT NULL DEFAULT 0,
  `email_id` int(11) unsigned NOT NULL DEFAULT 0,
  `lock_id` int(11) unsigned NOT NULL DEFAULT 0,
  `flags` int(10) unsigned NOT NULL DEFAULT 0,
  `sort` int(11) unsigned NOT NULL DEFAULT 0,
  `ip_address` varchar(64) NOT NULL DEFAULT '',
  `source` enum('Web','Email','Phone','API','Other') NOT NULL DEFAULT 'Other',
  `source_extra` varchar(40) DEFAULT NULL,
  `isoverdue` tinyint(1) unsigned NOT NULL DEFAULT 0,
  `isanswered` tinyint(1) unsigned NOT NULL DEFAULT 0,
  `duedate` datetime DEFAULT NULL,
  `est_duedate` datetime DEFAULT NULL,
  `reopened` datetime DEFAULT NULL,
  `closed` datetime DEFAULT NULL,
  `lastupdate` datetime DEFAULT NULL,
  `created` datetime NOT NULL,
  `updated` datetime NOT NULL,
  PRIMARY KEY (`ticket_id`),
  KEY `user_id` (`user_id`),
  KEY `dept_id` (`dept_id`),
  KEY `staff_id` (`staff_id`),
  KEY `team_id` (`team_id`),
  KEY `status_id` (`status_id`),
  KEY `created` (`created`),
  KEY `closed` (`closed`),
  KEY `duedate` (`duedate`),
  KEY `topic_id` (`topic_id`),
  KEY `sla_id` (`sla_id`),
  KEY `ticket_pid` (`ticket_pid`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ost_ticket`
--

LOCK TABLES `ost_ticket` WRITE;
/*!40000 ALTER TABLE `ost_ticket` DISABLE KEYS */;
INSERT INTO `ost_ticket` VALUES (18,NULL,'889540',2,0,2,3,1,1,1,0,0,0,0,0,'::1','Web',NULL,0,1,NULL,'2026-07-08 08:00:00',NULL,'2026-07-04 09:54:28','2026-07-04 09:54:28','2026-07-03 22:59:06','2026-07-04 09:56:50'),(19,NULL,'105968',2,0,8,3,1,1,0,0,0,0,0,0,'::1','Web',NULL,1,1,NULL,'2026-07-08 08:00:00',NULL,NULL,'2026-07-06 07:32:28','2026-07-06 07:32:28','2026-07-09 12:23:45'),(20,NULL,'552884',2,0,7,3,1,1,0,0,0,0,0,0,'172.18.0.1','Web',NULL,1,0,NULL,'2026-07-09 17:28:09',NULL,NULL,'2026-07-07 17:28:09','2026-07-07 17:28:09','2026-07-13 13:04:42'),(21,NULL,'479206',2,0,1,3,1,1,0,0,0,0,0,0,'172.18.0.1','Web',NULL,0,0,NULL,'2026-07-15 13:26:47',NULL,NULL,'2026-07-13 13:26:47','2026-07-13 13:26:47','2026-07-13 13:26:47');
/*!40000 ALTER TABLE `ost_ticket` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ost_ticket__cdata`
--

DROP TABLE IF EXISTS `ost_ticket__cdata`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `ost_ticket__cdata` (
  `ticket_id` int(11) unsigned NOT NULL,
  `subject` mediumtext DEFAULT NULL,
  `priority` mediumtext DEFAULT NULL,
  PRIMARY KEY (`ticket_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ost_ticket__cdata`
--

LOCK TABLES `ost_ticket__cdata` WRITE;
/*!40000 ALTER TABLE `ost_ticket__cdata` DISABLE KEYS */;
INSERT INTO `ost_ticket__cdata` VALUES (18,'ManutenÃ§Ã£o â€” v5l (S/N 1234)','2'),(19,'ManutenÃ§Ã£o â€” 4 equipamentos: V5L, V4L, Proma, Proface','2'),(20,'ManutenÃ§Ã£o â€” V5L (S/N 872347376)','2'),(21,'ManutenÃ§Ã£o â€” V3L Lite (S/N 24234234)','2');
/*!40000 ALTER TABLE `ost_ticket__cdata` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ost_ticket_priority`
--

DROP TABLE IF EXISTS `ost_ticket_priority`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `ost_ticket_priority` (
  `priority_id` tinyint(4) NOT NULL AUTO_INCREMENT,
  `priority` varchar(60) NOT NULL DEFAULT '',
  `priority_desc` varchar(30) NOT NULL DEFAULT '',
  `priority_color` varchar(7) NOT NULL DEFAULT '',
  `priority_urgency` tinyint(1) unsigned NOT NULL DEFAULT 0,
  `ispublic` tinyint(1) NOT NULL DEFAULT 1,
  PRIMARY KEY (`priority_id`),
  UNIQUE KEY `priority` (`priority`),
  KEY `priority_urgency` (`priority_urgency`),
  KEY `ispublic` (`ispublic`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ost_ticket_priority`
--

LOCK TABLES `ost_ticket_priority` WRITE;
/*!40000 ALTER TABLE `ost_ticket_priority` DISABLE KEYS */;
INSERT INTO `ost_ticket_priority` VALUES (1,'low','Baixa','#DDFFDD',4,1),(2,'normal','Normal','#FFFFF0',3,1),(3,'high','Alta','#FEE7E7',2,1),(4,'emergency','EmergÃªncia','#FEE7E7',1,1);
/*!40000 ALTER TABLE `ost_ticket_priority` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ost_ticket_status`
--

DROP TABLE IF EXISTS `ost_ticket_status`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `ost_ticket_status` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(60) NOT NULL DEFAULT '',
  `state` varchar(16) DEFAULT NULL,
  `mode` int(11) unsigned NOT NULL DEFAULT 0,
  `flags` int(11) unsigned NOT NULL DEFAULT 0,
  `sort` int(11) unsigned NOT NULL DEFAULT 0,
  `properties` text NOT NULL,
  `created` datetime NOT NULL,
  `updated` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`),
  KEY `state` (`state`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ost_ticket_status`
--

LOCK TABLES `ost_ticket_status` WRITE;
/*!40000 ALTER TABLE `ost_ticket_status` DISABLE KEYS */;
INSERT INTO `ost_ticket_status` VALUES (1,'Solicitado','open',3,0,1,'{\"description\":\"Tickets Abertos.\"}','2026-07-01 10:26:32','2026-07-02 14:32:08'),(2,'Resolvido','closed',1,0,5,'{\"allowreopen\":true,\"reopenstatus\":0,\"description\":\"Chamados resolvidos\"}','2026-07-01 10:26:32','0000-00-00 00:00:00'),(3,'Encerrado','closed',3,0,6,'{\"allowreopen\":true,\"reopenstatus\":0,\"description\":\"Tickets fechados. Os tickets ainda podem ser acessados a partir dos pain\\u00e9is de cliente e da equipe.\"}','2026-07-01 10:26:32','0000-00-00 00:00:00'),(4,'Arquivados','archived',3,0,7,'{\"description\":\"Tickets dispon\\u00edveis apenas administrativamente, mas n\\u00e3o acess\\u00edveis a partir da lista de tickets ou do painel do cliente.\"}','2026-07-01 10:26:32','0000-00-00 00:00:00'),(5,'Deletado','deleted',3,0,8,'{\"description\":\"Existem Tickets na fila para exclus\\u00e3o. Esses Tickets n\\u00e3o est\\u00e3o acess\\u00edveis na fila de Tickets.\"}','2026-07-01 10:26:32','0000-00-00 00:00:00'),(6,'Enviado','open',3,0,2,'{\"description\":\"Produto enviado pelo cliente - aguardando chegada na ZKTeco.\"}','2026-07-02 20:10:20','2026-07-02 20:10:20'),(7,'Recebido','open',1,0,3,'{\"description\":\"Produto recebido na ZKTeco - em atendimento. Acompanhe o status por equipamento no chamado.\"}','2026-07-03 23:15:22','2026-07-03 23:15:22'),(8,'Em manutenÃ§Ã£o','open',1,0,4,'{\"description\":\"Equipamento(s) em manutenÃ§Ã£o na ZKTeco.\"}','2026-07-07 08:23:09','2026-07-07 08:23:09');
/*!40000 ALTER TABLE `ost_ticket_status` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ost_translation`
--

DROP TABLE IF EXISTS `ost_translation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `ost_translation` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `object_hash` char(16) CHARACTER SET ascii COLLATE ascii_general_ci DEFAULT NULL,
  `type` enum('phrase','article','override') DEFAULT NULL,
  `flags` int(10) unsigned NOT NULL DEFAULT 0,
  `revision` int(11) unsigned DEFAULT NULL,
  `agent_id` int(10) unsigned NOT NULL DEFAULT 0,
  `lang` varchar(16) NOT NULL DEFAULT '',
  `text` mediumtext NOT NULL,
  `source_text` text DEFAULT NULL,
  `updated` timestamp NULL DEFAULT NULL ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `type` (`type`,`lang`),
  KEY `object_hash` (`object_hash`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ost_translation`
--

LOCK TABLES `ost_translation` WRITE;
/*!40000 ALTER TABLE `ost_translation` DISABLE KEYS */;
/*!40000 ALTER TABLE `ost_translation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ost_user`
--

DROP TABLE IF EXISTS `ost_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `ost_user` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `org_id` int(10) unsigned NOT NULL,
  `default_email_id` int(10) NOT NULL,
  `status` int(11) unsigned NOT NULL DEFAULT 0,
  `name` varchar(128) NOT NULL,
  `created` datetime NOT NULL,
  `updated` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `org_id` (`org_id`),
  KEY `default_email_id` (`default_email_id`),
  KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ost_user`
--

LOCK TABLES `ost_user` WRITE;
/*!40000 ALTER TABLE `ost_user` DISABLE KEYS */;
INSERT INTO `ost_user` VALUES (1,1,1,0,'Atendimento osTicket','2026-07-01 10:26:33','2026-07-01 10:26:34'),(2,0,2,0,'Juliano Torres Rezende','2026-07-01 10:31:48','2026-07-01 13:58:27'),(3,0,3,0,'Cliente Teste','2026-07-01 15:30:41','2026-07-01 15:30:41'),(4,0,4,0,'OTAVIO PRADO DA SILVA','2026-07-03 14:26:21','2026-07-03 14:26:21');
/*!40000 ALTER TABLE `ost_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ost_user__cdata`
--

DROP TABLE IF EXISTS `ost_user__cdata`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `ost_user__cdata` (
  `user_id` int(11) unsigned NOT NULL,
  `email` mediumtext DEFAULT NULL,
  `name` mediumtext DEFAULT NULL,
  `phone` mediumtext DEFAULT NULL,
  `notes` mediumtext DEFAULT NULL,
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ost_user__cdata`
--

LOCK TABLES `ost_user__cdata` WRITE;
/*!40000 ALTER TABLE `ost_user__cdata` DISABLE KEYS */;
INSERT INTO `ost_user__cdata` VALUES (2,NULL,NULL,'31997910742',''),(3,NULL,NULL,'11999999999',''),(4,NULL,NULL,'31996270810','');
/*!40000 ALTER TABLE `ost_user__cdata` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ost_user_account`
--

DROP TABLE IF EXISTS `ost_user_account`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `ost_user_account` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned NOT NULL,
  `status` int(11) unsigned NOT NULL DEFAULT 0,
  `timezone` varchar(64) DEFAULT NULL,
  `lang` varchar(16) DEFAULT NULL,
  `username` varchar(64) DEFAULT NULL,
  `passwd` varchar(128) CHARACTER SET ascii COLLATE ascii_bin DEFAULT NULL,
  `backend` varchar(32) DEFAULT NULL,
  `extra` text DEFAULT NULL,
  `registered` timestamp NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`),
  KEY `user_id` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ost_user_account`
--

LOCK TABLES `ost_user_account` WRITE;
/*!40000 ALTER TABLE `ost_user_account` DISABLE KEYS */;
INSERT INTO `ost_user_account` VALUES (1,2,1,'America/Argentina/Buenos_Aires',NULL,NULL,'$2a$08$Ek0kVkMl8CCMKxF4ATDJIeKSF6ySSExUHOlCi8P71tOKTHC5LAdR.',NULL,'{\"browser_lang\":\"pt_BR\"}','2026-07-01 13:31:48'),(2,4,1,NULL,NULL,NULL,'$2a$08$DP0g03kxA9M1OHc5TJXQ4OBUShOG9cLdQXy5UPUQaDaSNsxRn9tqi',NULL,'{\"browser_lang\":\"pt_BR\"}','2026-07-03 17:26:21');
/*!40000 ALTER TABLE `ost_user_account` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ost_user_email`
--

DROP TABLE IF EXISTS `ost_user_email`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `ost_user_email` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned NOT NULL,
  `flags` int(10) unsigned NOT NULL DEFAULT 0,
  `address` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `address` (`address`),
  KEY `user_email_lookup` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ost_user_email`
--

LOCK TABLES `ost_user_email` WRITE;
/*!40000 ALTER TABLE `ost_user_email` DISABLE KEYS */;
INSERT INTO `ost_user_email` VALUES (1,1,0,'support@osticket.com'),(2,2,0,'julianotorres@gmail.com'),(3,3,0,'teste@example.com'),(4,4,0,'otaviopradosilva@gmail.com');
/*!40000 ALTER TABLE `ost_user_email` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ost_zk_equipment`
--

DROP TABLE IF EXISTS `ost_zk_equipment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `ost_zk_equipment` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `ticket_id` int(11) unsigned NOT NULL,
  `seq` int(10) unsigned NOT NULL DEFAULT 0,
  `modelo` varchar(120) NOT NULL DEFAULT '',
  `numero_serie` varchar(120) NOT NULL DEFAULT '',
  `resumo` varchar(255) NOT NULL DEFAULT '',
  `detalhamento` text DEFAULT NULL,
  `descricao` varchar(255) NOT NULL DEFAULT '',
  `status` varchar(32) NOT NULL DEFAULT 'recebido',
  `pendencia` varchar(32) NOT NULL DEFAULT '',
  `laudo` text DEFAULT NULL,
  `nota_interna` text DEFAULT NULL,
  `staff_id` int(10) unsigned NOT NULL DEFAULT 0,
  `created` datetime NOT NULL,
  `updated` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `ticket_id` (`ticket_id`),
  KEY `ticket_status` (`ticket_id`,`status`),
  KEY `serie` (`numero_serie`)
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ost_zk_equipment`
--

LOCK TABLES `ost_zk_equipment` WRITE;
/*!40000 ALTER TABLE `ost_zk_equipment` DISABLE KEYS */;
INSERT INTO `ost_zk_equipment` VALUES (27,18,1,'v5l','1234','test','tetes','','reparado','','Checando tela e sensor','',1,'2026-07-03 22:59:14','2026-07-04 09:56:50'),(28,19,1,'V5L','4444','teste','teste','','em_analise','','','',1,'2026-07-06 07:32:37','2026-07-13 13:29:41'),(29,19,2,'V4L','3333','teste','teste','','em_analise','','','',1,'2026-07-06 07:32:37','2026-07-13 13:29:41'),(30,19,3,'Proma','5555','teste','teste','','em_reparo','','Aguardando display','',1,'2026-07-06 07:32:37','2026-07-13 13:29:41'),(31,19,4,'Proface','8888','teste','teste','','em_analise','','Iniciando testes','',1,'2026-07-06 07:32:37','2026-07-13 13:29:41'),(32,20,1,'V5L','872347376','NÃ£o liga','Caiu um raio','','recebido','',NULL,NULL,0,'2026-07-07 17:28:21','2026-07-07 17:28:21'),(33,21,1,'V3L Lite','24234234','teste','teste','','recebido','sem_nf',NULL,NULL,0,'2026-07-13 13:26:56','2026-07-13 13:26:56');
/*!40000 ALTER TABLE `ost_zk_equipment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ost_zk_equipment_event`
--

DROP TABLE IF EXISTS `ost_zk_equipment_event`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `ost_zk_equipment_event` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `equipment_id` int(11) unsigned NOT NULL,
  `ticket_id` int(11) unsigned NOT NULL,
  `from_status` varchar(32) DEFAULT NULL,
  `to_status` varchar(32) NOT NULL,
  `note` varchar(255) DEFAULT NULL,
  `staff_id` int(10) unsigned NOT NULL DEFAULT 0,
  `created` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `equipment` (`equipment_id`),
  KEY `ticket` (`ticket_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ost_zk_equipment_event`
--

LOCK TABLES `ost_zk_equipment_event` WRITE;
/*!40000 ALTER TABLE `ost_zk_equipment_event` DISABLE KEYS */;
INSERT INTO `ost_zk_equipment_event` VALUES (1,27,18,'recebido','em_analise',NULL,1,'2026-07-03 23:08:55'),(2,27,18,'em_analise','aguardando_peca',NULL,1,'2026-07-03 23:21:15'),(3,27,18,'recebido','em_reparo',NULL,1,'2026-07-04 09:51:29'),(4,27,18,'em_reparo','reparado',NULL,1,'2026-07-04 09:56:50'),(5,28,19,'recebido','em_analise',NULL,1,'2026-07-07 19:50:32'),(6,29,19,'recebido','em_analise',NULL,1,'2026-07-07 20:17:36'),(7,30,19,'recebido','em_analise',NULL,1,'2026-07-13 13:06:53'),(8,30,19,'em_analise','aguardando_peca',NULL,1,'2026-07-13 13:22:00'),(9,31,19,'recebido','em_analise',NULL,1,'2026-07-13 13:22:00'),(10,30,19,'aguardando_peca','em_reparo',NULL,1,'2026-07-13 13:29:41');
/*!40000 ALTER TABLE `ost_zk_equipment_event` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ost_zk_equipment_file`
--

DROP TABLE IF EXISTS `ost_zk_equipment_file`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `ost_zk_equipment_file` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `ticket_id` int(11) unsigned NOT NULL,
  `equipment_id` int(11) unsigned NOT NULL,
  `file_id` int(11) NOT NULL,
  `slot` tinyint(1) unsigned NOT NULL DEFAULT 1,
  `created` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `ticket_id` (`ticket_id`),
  KEY `equipment_id` (`equipment_id`),
  KEY `file_id` (`file_id`),
  KEY `equipment_slot` (`equipment_id`,`slot`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ost_zk_equipment_file`
--

LOCK TABLES `ost_zk_equipment_file` WRITE;
/*!40000 ALTER TABLE `ost_zk_equipment_file` DISABLE KEYS */;
INSERT INTO `ost_zk_equipment_file` VALUES (18,18,27,40,2,'2026-07-03 22:59:14'),(19,19,28,22,2,'2026-07-06 07:32:37'),(20,19,29,23,2,'2026-07-06 07:32:37'),(21,19,30,40,2,'2026-07-06 07:32:37'),(22,19,31,26,2,'2026-07-06 07:32:37'),(23,20,32,22,2,'2026-07-07 17:28:21'),(24,21,33,43,2,'2026-07-13 13:26:56');
/*!40000 ALTER TABLE `ost_zk_equipment_file` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ost_zk_ticket_envio`
--

DROP TABLE IF EXISTS `ost_zk_ticket_envio`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `ost_zk_ticket_envio` (
  `ticket_id` int(10) unsigned NOT NULL,
  `transportadora` varchar(16) NOT NULL DEFAULT '',
  `rastreio` varchar(64) NOT NULL DEFAULT '',
  `updated` datetime NOT NULL,
  `confirmado` datetime DEFAULT NULL,
  PRIMARY KEY (`ticket_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ost_zk_ticket_envio`
--

LOCK TABLES `ost_zk_ticket_envio` WRITE;
/*!40000 ALTER TABLE `ost_zk_ticket_envio` DISABLE KEYS */;
INSERT INTO `ost_zk_ticket_envio` VALUES (18,'outra','','2026-07-03 23:01:56','2026-07-03 23:01:56'),(19,'o_proprio','','2026-07-06 07:57:22','2026-07-06 07:57:22'),(20,'o_proprio','','2026-07-07 17:29:36','2026-07-07 17:29:36');
/*!40000 ALTER TABLE `ost_zk_ticket_envio` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ost_zk_ticket_file`
--

DROP TABLE IF EXISTS `ost_zk_ticket_file`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `ost_zk_ticket_file` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `ticket_id` int(10) unsigned NOT NULL,
  `file_id` int(11) NOT NULL,
  `kind` varchar(16) NOT NULL DEFAULT 'nf',
  `created` datetime NOT NULL,
  `errors` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `ticket_id` (`ticket_id`)
) ENGINE=InnoDB AUTO_INCREMENT=39 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ost_zk_ticket_file`
--

LOCK TABLES `ost_zk_ticket_file` WRITE;
/*!40000 ALTER TABLE `ost_zk_ticket_file` DISABLE KEYS */;
INSERT INTO `ost_zk_ticket_file` VALUES (35,18,41,'nf','2026-07-03 23:01:44',''),(36,19,41,'nf','2026-07-06 07:57:06',''),(38,20,41,'nf','2026-07-07 17:29:05','');
/*!40000 ALTER TABLE `ost_zk_ticket_file` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'zkteco_manutencao'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-07-13 13:33:50
