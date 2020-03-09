-- MySQL Dump modified by gem 'activerecord-mysql-structure'


DROP TABLE IF EXISTS `classified_types`;
CREATE TABLE `classified_types` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `classifieds`;
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
  KEY `index_classifieds_on_employee_id` (`employee_id`),
  KEY `index_classifieds_on_classified_type_id` (`classified_type_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `schema_migrations`;
CREATE TABLE `schema_migrations` (
  `version` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  UNIQUE KEY `unique_schema_migrations` (`version`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `teams`;
CREATE TABLE `teams` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `email` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `description` text COLLATE utf8_unicode_ci,
  PRIMARY KEY (`id`),
  KEY `index_teams_on_name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


INSERT INTO `schema_migrations` (version) VALUES
('20150213221911'),
('20150213222926'),
('20150213225251'),
('20150213230121'),
('20150213232012'),
('20150214000513'),
('20150214004737'),
('20150214005057'),
('20150214011626'),
('20150214013535'),
('20150214084227'),
('20150216213539'),
('20150315230851'),
('20150315230955'),
('20150319154456'),
('20150411191006'),
('20150417172914'),
('20150418072605'),
('20150612174040'),
('20150612181455'),
('20150612232043'),
('20160422080533'),
('20160424213633');
