--
-- MySQL dump 10.13  Distrib 5.5.44, for osx10.11 (x86_64)
--
-- Host: localhost    Database: development
-- ------------------------------------------------------
-- Server version 5.5.44

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

-- Table structure for table `classifieds`
--

DROP TABLE IF EXISTS `classifieds`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `classifieds` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `content` text COLLATE utf8_unicode_ci,
  `dollars` int(11) DEFAULT NULL,
  `employee_id` int(11) DEFAULT NULL,
  `classified_type_id` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `item_img_file_name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `item_img_content_type` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `item_img_file_size` int(11) DEFAULT NULL,
  `item_img_updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `arbitrary_index_name` (`employee_id`, `classified_type_id`) USING BTREE,
  KEY `index_classifieds_on_employee_id` (`employee_id`),
  KEY `index_classifieds_on_classified_type_id` (`classified_type_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `schema_migrations`
--

DROP TABLE IF EXISTS `schema_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `schema_migrations` (
  `version` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  UNIQUE KEY `unique_schema_migrations` (`version`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2016-06-02 13:55:23
INSERT INTO schema_migrations (version) VALUES ('20150213221911');

INSERT INTO schema_migrations (version) VALUES ('20150213222926');

INSERT INTO schema_migrations (version) VALUES ('20150213225251');

INSERT INTO schema_migrations (version) VALUES ('20150213230121');

INSERT INTO schema_migrations (version) VALUES ('20150213232012');

INSERT INTO schema_migrations (version) VALUES ('20150214000513');

INSERT INTO schema_migrations (version) VALUES ('20150214004737');

INSERT INTO schema_migrations (version) VALUES ('20150214005057');

INSERT INTO schema_migrations (version) VALUES ('20150214011626');

INSERT INTO schema_migrations (version) VALUES ('20150214013535');

INSERT INTO schema_migrations (version) VALUES ('20150214084227');

INSERT INTO schema_migrations (version) VALUES ('20150216213539');

INSERT INTO schema_migrations (version) VALUES ('20150315230851');

INSERT INTO schema_migrations (version) VALUES ('20150315230955');

INSERT INTO schema_migrations (version) VALUES ('20150319154456');

INSERT INTO schema_migrations (version) VALUES ('20150411191006');

INSERT INTO schema_migrations (version) VALUES ('20150417172914');

INSERT INTO schema_migrations (version) VALUES ('20150418072605');

INSERT INTO schema_migrations (version) VALUES ('20150612174040');

INSERT INTO schema_migrations (version) VALUES ('20150612181455');

INSERT INTO schema_migrations (version) VALUES ('20150612232043');

INSERT INTO schema_migrations (version) VALUES ('20160424213633');

