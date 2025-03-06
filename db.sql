-- MySQL dump 10.13  Distrib 5.7.36, for Linux (x86_64)
--
-- Host: localhost    Database: demo_kanboard
-- ------------------------------------------------------
-- Server version	5.7.36-log

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `action_has_params`
--

DROP TABLE IF EXISTS `action_has_params`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `action_has_params` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `action_id` int(11) NOT NULL,
  `name` mediumtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` mediumtext COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `action_id` (`action_id`),
  CONSTRAINT `action_has_params_ibfk_1` FOREIGN KEY (`action_id`) REFERENCES `actions` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `action_has_params`
--

LOCK TABLES `action_has_params` WRITE;
/*!40000 ALTER TABLE `action_has_params` DISABLE KEYS */;
/*!40000 ALTER TABLE `action_has_params` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `actions`
--

DROP TABLE IF EXISTS `actions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `actions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `project_id` int(11) NOT NULL,
  `event_name` mediumtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `action_name` mediumtext COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `project_id` (`project_id`),
  CONSTRAINT `actions_ibfk_1` FOREIGN KEY (`project_id`) REFERENCES `projects` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `actions`
--

LOCK TABLES `actions` WRITE;
/*!40000 ALTER TABLE `actions` DISABLE KEYS */;
/*!40000 ALTER TABLE `actions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `column_has_move_restrictions`
--

DROP TABLE IF EXISTS `column_has_move_restrictions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `column_has_move_restrictions` (
  `restriction_id` int(11) NOT NULL AUTO_INCREMENT,
  `project_id` int(11) NOT NULL,
  `role_id` int(11) NOT NULL,
  `src_column_id` int(11) NOT NULL,
  `dst_column_id` int(11) NOT NULL,
  `only_assigned` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`restriction_id`),
  UNIQUE KEY `role_id` (`role_id`,`src_column_id`,`dst_column_id`),
  KEY `project_id` (`project_id`),
  KEY `src_column_id` (`src_column_id`),
  KEY `dst_column_id` (`dst_column_id`),
  CONSTRAINT `column_has_move_restrictions_ibfk_1` FOREIGN KEY (`project_id`) REFERENCES `projects` (`id`) ON DELETE CASCADE,
  CONSTRAINT `column_has_move_restrictions_ibfk_2` FOREIGN KEY (`role_id`) REFERENCES `project_has_roles` (`role_id`) ON DELETE CASCADE,
  CONSTRAINT `column_has_move_restrictions_ibfk_3` FOREIGN KEY (`src_column_id`) REFERENCES `columns` (`id`) ON DELETE CASCADE,
  CONSTRAINT `column_has_move_restrictions_ibfk_4` FOREIGN KEY (`dst_column_id`) REFERENCES `columns` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `column_has_move_restrictions`
--

LOCK TABLES `column_has_move_restrictions` WRITE;
/*!40000 ALTER TABLE `column_has_move_restrictions` DISABLE KEYS */;
/*!40000 ALTER TABLE `column_has_move_restrictions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `column_has_restrictions`
--

DROP TABLE IF EXISTS `column_has_restrictions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `column_has_restrictions` (
  `restriction_id` int(11) NOT NULL AUTO_INCREMENT,
  `project_id` int(11) NOT NULL,
  `role_id` int(11) NOT NULL,
  `column_id` int(11) NOT NULL,
  `rule` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`restriction_id`),
  UNIQUE KEY `role_id` (`role_id`,`column_id`,`rule`),
  KEY `project_id` (`project_id`),
  KEY `column_id` (`column_id`),
  CONSTRAINT `column_has_restrictions_ibfk_1` FOREIGN KEY (`project_id`) REFERENCES `projects` (`id`) ON DELETE CASCADE,
  CONSTRAINT `column_has_restrictions_ibfk_2` FOREIGN KEY (`role_id`) REFERENCES `project_has_roles` (`role_id`) ON DELETE CASCADE,
  CONSTRAINT `column_has_restrictions_ibfk_3` FOREIGN KEY (`column_id`) REFERENCES `columns` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `column_has_restrictions`
--

LOCK TABLES `column_has_restrictions` WRITE;
/*!40000 ALTER TABLE `column_has_restrictions` DISABLE KEYS */;
/*!40000 ALTER TABLE `column_has_restrictions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `columns`
--

DROP TABLE IF EXISTS `columns`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `columns` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `position` int(11) NOT NULL,
  `project_id` int(11) NOT NULL,
  `task_limit` int(11) DEFAULT '0',
  `description` mediumtext COLLATE utf8mb4_unicode_ci,
  `hide_in_dashboard` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_title_project` (`title`,`project_id`),
  KEY `columns_project_idx` (`project_id`),
  CONSTRAINT `columns_ibfk_1` FOREIGN KEY (`project_id`) REFERENCES `projects` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `columns`
--

LOCK TABLES `columns` WRITE;
/*!40000 ALTER TABLE `columns` DISABLE KEYS */;
INSERT INTO `columns` VALUES (1,'In Review',1,1,0,'',0),(2,'Planned',2,1,0,'',0),(3,'In Progress',3,1,0,'',0),(4,'Complete',4,1,0,'',0);
/*!40000 ALTER TABLE `columns` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `comments`
--

DROP TABLE IF EXISTS `comments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `comments` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `task_id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT '0',
  `date_creation` bigint(20) DEFAULT NULL,
  `comment` mediumtext COLLATE utf8mb4_unicode_ci,
  `reference` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `date_modification` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `comments_reference_idx` (`reference`),
  KEY `comments_task_idx` (`task_id`),
  CONSTRAINT `comments_ibfk_1` FOREIGN KEY (`task_id`) REFERENCES `tasks` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `comments`
--

LOCK TABLES `comments` WRITE;
/*!40000 ALTER TABLE `comments` DISABLE KEYS */;
/*!40000 ALTER TABLE `comments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `currencies`
--

DROP TABLE IF EXISTS `currencies`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `currencies` (
  `currency` char(3) COLLATE utf8mb4_unicode_ci NOT NULL,
  `rate` float DEFAULT '0',
  UNIQUE KEY `currency` (`currency`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `currencies`
--

LOCK TABLES `currencies` WRITE;
/*!40000 ALTER TABLE `currencies` DISABLE KEYS */;
/*!40000 ALTER TABLE `currencies` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `custom_filters`
--

DROP TABLE IF EXISTS `custom_filters`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `custom_filters` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `filter` mediumtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `project_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `name` mediumtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `is_shared` tinyint(1) DEFAULT '0',
  `append` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `project_id` (`project_id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `custom_filters_ibfk_1` FOREIGN KEY (`project_id`) REFERENCES `projects` (`id`) ON DELETE CASCADE,
  CONSTRAINT `custom_filters_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `custom_filters`
--

LOCK TABLES `custom_filters` WRITE;
/*!40000 ALTER TABLE `custom_filters` DISABLE KEYS */;
/*!40000 ALTER TABLE `custom_filters` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `group_has_users`
--

DROP TABLE IF EXISTS `group_has_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `group_has_users` (
  `group_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  UNIQUE KEY `group_id` (`group_id`,`user_id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `group_has_users_ibfk_1` FOREIGN KEY (`group_id`) REFERENCES `groups` (`id`) ON DELETE CASCADE,
  CONSTRAINT `group_has_users_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `group_has_users`
--

LOCK TABLES `group_has_users` WRITE;
/*!40000 ALTER TABLE `group_has_users` DISABLE KEYS */;
/*!40000 ALTER TABLE `group_has_users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `groups`
--

DROP TABLE IF EXISTS `groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `groups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `external_id` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `groups`
--

LOCK TABLES `groups` WRITE;
/*!40000 ALTER TABLE `groups` DISABLE KEYS */;
/*!40000 ALTER TABLE `groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `invites`
--

DROP TABLE IF EXISTS `invites`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `invites` (
  `email` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `project_id` int(11) NOT NULL,
  `token` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`email`,`token`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `invites`
--

LOCK TABLES `invites` WRITE;
/*!40000 ALTER TABLE `invites` DISABLE KEYS */;
/*!40000 ALTER TABLE `invites` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `last_logins`
--

DROP TABLE IF EXISTS `last_logins`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `last_logins` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `auth_type` varchar(25) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `ip` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_agent` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `date_creation` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `last_logins_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `last_logins`
--

LOCK TABLES `last_logins` WRITE;
/*!40000 ALTER TABLE `last_logins` DISABLE KEYS */;
INSERT INTO `last_logins` VALUES (1,'Database',1,'172.70.230.132','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/121.0.0.0 Safari/537.36',1706602239),(2,'RememberMe',1,'162.158.155.196','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/121.0.0.0 Safari/537.36',1707016122),(3,'Database',1,'192.168.33.1','Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:109.0) Gecko/20100101 Firefox/115.0',1709211644),(4,'Database',1,'192.168.33.1','Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:133.0) Gecko/20100101 Firefox/133.0',1736950567),(5,'RememberMe',1,'192.168.33.1','Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:133.0) Gecko/20100101 Firefox/133.0',1737003500),(6,'RememberMe',1,'192.168.33.1','Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:133.0) Gecko/20100101 Firefox/133.0',1737003500);
/*!40000 ALTER TABLE `last_logins` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `links`
--

DROP TABLE IF EXISTS `links`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `links` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `label` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `opposite_id` int(11) DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `label` (`label`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `links`
--

LOCK TABLES `links` WRITE;
/*!40000 ALTER TABLE `links` DISABLE KEYS */;
INSERT INTO `links` VALUES (1,'relates to',0),(2,'blocks',3),(3,'is blocked by',2),(4,'duplicates',5),(5,'is duplicated by',4),(6,'is a parent of',7),(7,'is a child of',6),(8,'is a milestone of',9),(9,'targets milestone',8),(10,'is fixed by',11),(11,'fixes',10);
/*!40000 ALTER TABLE `links` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `password_reset`
--

DROP TABLE IF EXISTS `password_reset`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `password_reset` (
  `token` varchar(80) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` int(11) NOT NULL,
  `date_expiration` int(11) NOT NULL,
  `date_creation` int(11) NOT NULL,
  `ip` varchar(45) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_agent` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  PRIMARY KEY (`token`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `password_reset_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `password_reset`
--

LOCK TABLES `password_reset` WRITE;
/*!40000 ALTER TABLE `password_reset` DISABLE KEYS */;
/*!40000 ALTER TABLE `password_reset` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `plugin_schema_versions`
--

DROP TABLE IF EXISTS `plugin_schema_versions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `plugin_schema_versions` (
  `plugin` varchar(80) COLLATE utf8mb4_unicode_ci NOT NULL,
  `version` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`plugin`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `plugin_schema_versions`
--

LOCK TABLES `plugin_schema_versions` WRITE;
/*!40000 ALTER TABLE `plugin_schema_versions` DISABLE KEYS */;
/*!40000 ALTER TABLE `plugin_schema_versions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `predefined_task_descriptions`
--

DROP TABLE IF EXISTS `predefined_task_descriptions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `predefined_task_descriptions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `project_id` int(11) NOT NULL,
  `title` mediumtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` mediumtext COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `project_id` (`project_id`),
  CONSTRAINT `predefined_task_descriptions_ibfk_1` FOREIGN KEY (`project_id`) REFERENCES `projects` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `predefined_task_descriptions`
--

LOCK TABLES `predefined_task_descriptions` WRITE;
/*!40000 ALTER TABLE `predefined_task_descriptions` DISABLE KEYS */;
/*!40000 ALTER TABLE `predefined_task_descriptions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `project_activities`
--

DROP TABLE IF EXISTS `project_activities`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `project_activities` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `date_creation` bigint(20) DEFAULT NULL,
  `event_name` mediumtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `creator_id` int(11) DEFAULT NULL,
  `project_id` int(11) DEFAULT NULL,
  `task_id` int(11) DEFAULT NULL,
  `data` mediumtext COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`id`),
  KEY `creator_id` (`creator_id`),
  KEY `project_id` (`project_id`),
  KEY `task_id` (`task_id`),
  CONSTRAINT `project_activities_ibfk_1` FOREIGN KEY (`creator_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `project_activities_ibfk_2` FOREIGN KEY (`project_id`) REFERENCES `projects` (`id`) ON DELETE CASCADE,
  CONSTRAINT `project_activities_ibfk_3` FOREIGN KEY (`task_id`) REFERENCES `tasks` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `project_activities`
--

LOCK TABLES `project_activities` WRITE;
/*!40000 ALTER TABLE `project_activities` DISABLE KEYS */;
INSERT INTO `project_activities` VALUES (4,1736956307,'task.create',1,1,2,'{\"task_id\":2,\"task\":{\"id\":2,\"title\":\"Remove robot valid\",\"description\":\"\",\"date_creation\":1736956307,\"date_completed\":null,\"date_due\":0,\"color_id\":\"yellow\",\"project_id\":1,\"column_id\":1,\"owner_id\":0,\"position\":2,\"score\":0,\"is_active\":1,\"category_id\":0,\"creator_id\":1,\"date_modification\":1736956307,\"reference\":\"\",\"date_started\":0,\"time_spent\":0,\"time_estimated\":0,\"swimlane_id\":1,\"date_moved\":1736956307,\"recurrence_status\":0,\"recurrence_trigger\":0,\"recurrence_factor\":0,\"recurrence_timeframe\":0,\"recurrence_basedate\":0,\"recurrence_parent\":null,\"recurrence_child\":null,\"priority\":0,\"external_provider\":null,\"external_uri\":null,\"category_name\":null,\"swimlane_name\":\"Default swimlane\",\"project_name\":\"Roadmap\",\"column_title\":\"In Review\",\"assignee_username\":null,\"assignee_name\":null,\"creator_username\":\"admin\",\"creator_name\":null,\"category_description\":null,\"column_position\":1}}'),(5,1737003519,'task.create',1,1,3,'{\"task_id\":3,\"task\":{\"id\":3,\"title\":\"test\",\"description\":\"\",\"date_creation\":1737003518,\"date_completed\":null,\"date_due\":0,\"color_id\":\"yellow\",\"project_id\":1,\"column_id\":2,\"owner_id\":0,\"position\":1,\"score\":0,\"is_active\":1,\"category_id\":0,\"creator_id\":1,\"date_modification\":1737003518,\"reference\":\"\",\"date_started\":0,\"time_spent\":0,\"time_estimated\":0,\"swimlane_id\":1,\"date_moved\":1737003518,\"recurrence_status\":0,\"recurrence_trigger\":0,\"recurrence_factor\":0,\"recurrence_timeframe\":0,\"recurrence_basedate\":0,\"recurrence_parent\":null,\"recurrence_child\":null,\"priority\":0,\"external_provider\":null,\"external_uri\":null,\"category_name\":null,\"swimlane_name\":\"Default swimlane\",\"project_name\":\"Roadmap\",\"column_title\":\"Planned\",\"assignee_username\":null,\"assignee_name\":null,\"creator_username\":\"admin\",\"creator_name\":null,\"category_description\":null,\"column_position\":2}}'),(6,1737003525,'task.move.column',1,1,2,'{\"task_id\":2,\"task\":{\"id\":2,\"title\":\"Remove robot valid\",\"description\":\"\",\"date_creation\":1736956307,\"date_completed\":null,\"date_due\":0,\"color_id\":\"yellow\",\"project_id\":1,\"column_id\":3,\"owner_id\":0,\"position\":1,\"score\":5,\"is_active\":1,\"category_id\":0,\"creator_id\":1,\"date_modification\":1737003525,\"reference\":\"\",\"date_started\":0,\"time_spent\":0,\"time_estimated\":0,\"swimlane_id\":1,\"date_moved\":1737003525,\"recurrence_status\":0,\"recurrence_trigger\":0,\"recurrence_factor\":0,\"recurrence_timeframe\":0,\"recurrence_basedate\":0,\"recurrence_parent\":null,\"recurrence_child\":null,\"priority\":0,\"external_provider\":null,\"external_uri\":null,\"category_name\":null,\"swimlane_name\":\"Default swimlane\",\"project_name\":\"Roadmap\",\"column_title\":\"In Progress\",\"assignee_username\":null,\"assignee_name\":null,\"creator_username\":\"admin\",\"creator_name\":null,\"category_description\":null,\"column_position\":3},\"changes\":{\"src_column_id\":1,\"dst_column_id\":\"3\",\"date_moved\":1736956307},\"project_id\":1,\"position\":1,\"column_id\":\"3\",\"swimlane_id\":\"1\",\"src_column_id\":1,\"dst_column_id\":\"3\",\"date_moved\":1736956307,\"recurrence_status\":0,\"recurrence_trigger\":0}'),(7,1737003794,'task.move.column',1,1,2,'{\"task_id\":2,\"task\":{\"id\":2,\"title\":\"Remove robot valid\",\"description\":\"\",\"date_creation\":1736956307,\"date_completed\":null,\"date_due\":0,\"color_id\":\"yellow\",\"project_id\":1,\"column_id\":2,\"owner_id\":0,\"position\":2,\"score\":5,\"is_active\":1,\"category_id\":0,\"creator_id\":1,\"date_modification\":1737003794,\"reference\":\"\",\"date_started\":0,\"time_spent\":0,\"time_estimated\":0,\"swimlane_id\":1,\"date_moved\":1737003794,\"recurrence_status\":0,\"recurrence_trigger\":0,\"recurrence_factor\":0,\"recurrence_timeframe\":0,\"recurrence_basedate\":0,\"recurrence_parent\":null,\"recurrence_child\":null,\"priority\":0,\"external_provider\":null,\"external_uri\":null,\"category_name\":null,\"swimlane_name\":\"Default swimlane\",\"project_name\":\"Roadmap\",\"column_title\":\"Planned\",\"assignee_username\":null,\"assignee_name\":null,\"creator_username\":\"admin\",\"creator_name\":null,\"category_description\":null,\"column_position\":2},\"changes\":{\"src_column_id\":3,\"dst_column_id\":\"2\",\"date_moved\":1737003525},\"project_id\":1,\"position\":2,\"column_id\":\"2\",\"swimlane_id\":\"1\",\"src_column_id\":3,\"dst_column_id\":\"2\",\"date_moved\":1737003525,\"recurrence_status\":0,\"recurrence_trigger\":0}'),(8,1737003833,'task.update',1,1,3,'{\"task_id\":3,\"task\":{\"id\":3,\"title\":\"Login with github\",\"description\":\"\",\"date_creation\":1737003518,\"date_completed\":null,\"date_due\":0,\"color_id\":\"yellow\",\"project_id\":1,\"column_id\":2,\"owner_id\":0,\"position\":1,\"score\":0,\"is_active\":1,\"category_id\":0,\"creator_id\":1,\"date_modification\":1737003833,\"reference\":\"\",\"date_started\":0,\"time_spent\":0,\"time_estimated\":0,\"swimlane_id\":1,\"date_moved\":1737003518,\"recurrence_status\":0,\"recurrence_trigger\":0,\"recurrence_factor\":0,\"recurrence_timeframe\":0,\"recurrence_basedate\":0,\"recurrence_parent\":null,\"recurrence_child\":null,\"priority\":0,\"external_provider\":null,\"external_uri\":null,\"category_name\":null,\"swimlane_name\":\"Default swimlane\",\"project_name\":\"Roadmap\",\"column_title\":\"Planned\",\"assignee_username\":null,\"assignee_name\":null,\"creator_username\":\"admin\",\"creator_name\":null,\"category_description\":null,\"column_position\":2},\"changes\":{\"title\":\"Login with github\"}}'),(9,1737003840,'task.update',1,1,3,'{\"task_id\":3,\"task\":{\"id\":3,\"title\":\"Login with github\",\"description\":\"testsetestestest\",\"date_creation\":1737003518,\"date_completed\":null,\"date_due\":0,\"color_id\":\"yellow\",\"project_id\":1,\"column_id\":2,\"owner_id\":0,\"position\":1,\"score\":0,\"is_active\":1,\"category_id\":0,\"creator_id\":1,\"date_modification\":1737003840,\"reference\":\"\",\"date_started\":0,\"time_spent\":0,\"time_estimated\":0,\"swimlane_id\":1,\"date_moved\":1737003518,\"recurrence_status\":0,\"recurrence_trigger\":0,\"recurrence_factor\":0,\"recurrence_timeframe\":0,\"recurrence_basedate\":0,\"recurrence_parent\":null,\"recurrence_child\":null,\"priority\":0,\"external_provider\":null,\"external_uri\":null,\"category_name\":null,\"swimlane_name\":\"Default swimlane\",\"project_name\":\"Roadmap\",\"column_title\":\"Planned\",\"assignee_username\":null,\"assignee_name\":null,\"creator_username\":\"admin\",\"creator_name\":null,\"category_description\":null,\"column_position\":2},\"changes\":{\"description\":\"testsetestestest\"}}'),(10,1737007262,'task.move.column',1,1,2,'{\"task_id\":2,\"task\":{\"id\":2,\"title\":\"Remove robot valid\",\"description\":\"\",\"date_creation\":1736956307,\"date_completed\":null,\"date_due\":0,\"color_id\":\"yellow\",\"project_id\":1,\"column_id\":4,\"owner_id\":0,\"position\":1,\"score\":5,\"is_active\":1,\"category_id\":0,\"creator_id\":1,\"date_modification\":1737007262,\"reference\":\"\",\"date_started\":0,\"time_spent\":0,\"time_estimated\":0,\"swimlane_id\":1,\"date_moved\":1737007262,\"recurrence_status\":0,\"recurrence_trigger\":0,\"recurrence_factor\":0,\"recurrence_timeframe\":0,\"recurrence_basedate\":0,\"recurrence_parent\":null,\"recurrence_child\":null,\"priority\":0,\"external_provider\":null,\"external_uri\":null,\"category_name\":null,\"swimlane_name\":\"Default swimlane\",\"project_name\":\"Roadmap\",\"column_title\":\"Complete\",\"assignee_username\":null,\"assignee_name\":null,\"creator_username\":\"admin\",\"creator_name\":null,\"category_description\":null,\"column_position\":4},\"changes\":{\"src_column_id\":2,\"dst_column_id\":\"4\",\"date_moved\":1737003794},\"project_id\":1,\"position\":1,\"column_id\":\"4\",\"swimlane_id\":\"1\",\"src_column_id\":2,\"dst_column_id\":\"4\",\"date_moved\":1737003794,\"recurrence_status\":0,\"recurrence_trigger\":0}'),(11,1737008561,'task.update',1,1,3,'{\"task_id\":3,\"task\":{\"id\":3,\"title\":\"Login with github\",\"description\":\"test\",\"date_creation\":1737003518,\"date_completed\":null,\"date_due\":0,\"color_id\":\"yellow\",\"project_id\":1,\"column_id\":2,\"owner_id\":0,\"position\":1,\"score\":0,\"is_active\":1,\"category_id\":0,\"creator_id\":1,\"date_modification\":1737008561,\"reference\":\"\",\"date_started\":0,\"time_spent\":0,\"time_estimated\":0,\"swimlane_id\":1,\"date_moved\":1737003518,\"recurrence_status\":0,\"recurrence_trigger\":0,\"recurrence_factor\":0,\"recurrence_timeframe\":0,\"recurrence_basedate\":0,\"recurrence_parent\":null,\"recurrence_child\":null,\"priority\":0,\"external_provider\":null,\"external_uri\":null,\"category_name\":null,\"swimlane_name\":\"Default swimlane\",\"project_name\":\"Roadmap\",\"column_title\":\"Planned\",\"assignee_username\":null,\"assignee_name\":null,\"creator_username\":\"admin\",\"creator_name\":null,\"category_description\":null,\"column_position\":2},\"changes\":{\"description\":\"test\"}}'),(12,1737008621,'task.update',1,1,3,'{\"task_id\":3,\"task\":{\"id\":3,\"title\":\"Login with github\",\"description\":\"test\",\"date_creation\":1737003518,\"date_completed\":null,\"date_due\":0,\"color_id\":\"yellow\",\"project_id\":1,\"column_id\":2,\"owner_id\":0,\"position\":1,\"score\":0,\"is_active\":1,\"category_id\":0,\"creator_id\":1,\"date_modification\":1737008621,\"reference\":\"\",\"date_started\":0,\"time_spent\":85,\"time_estimated\":100,\"swimlane_id\":1,\"date_moved\":1737003518,\"recurrence_status\":0,\"recurrence_trigger\":0,\"recurrence_factor\":0,\"recurrence_timeframe\":0,\"recurrence_basedate\":0,\"recurrence_parent\":null,\"recurrence_child\":null,\"priority\":0,\"external_provider\":null,\"external_uri\":null,\"category_name\":null,\"swimlane_name\":\"Default swimlane\",\"project_name\":\"Roadmap\",\"column_title\":\"Planned\",\"assignee_username\":null,\"assignee_name\":null,\"creator_username\":\"admin\",\"creator_name\":null,\"category_description\":null,\"column_position\":2},\"changes\":{\"time_estimated\":\"100\",\"time_spent\":\"85\"}}'),(13,1737009064,'task.move.column',1,1,2,'{\"task_id\":2,\"task\":{\"id\":2,\"title\":\"Remove robot valid\",\"description\":\"\",\"date_creation\":1736956307,\"date_completed\":null,\"date_due\":0,\"color_id\":\"yellow\",\"project_id\":1,\"column_id\":3,\"owner_id\":0,\"position\":1,\"score\":5,\"is_active\":1,\"category_id\":0,\"creator_id\":1,\"date_modification\":1737009064,\"reference\":\"\",\"date_started\":0,\"time_spent\":0,\"time_estimated\":0,\"swimlane_id\":1,\"date_moved\":1737009064,\"recurrence_status\":0,\"recurrence_trigger\":0,\"recurrence_factor\":0,\"recurrence_timeframe\":0,\"recurrence_basedate\":0,\"recurrence_parent\":null,\"recurrence_child\":null,\"priority\":0,\"external_provider\":null,\"external_uri\":null,\"category_name\":null,\"swimlane_name\":\"Default swimlane\",\"project_name\":\"Roadmap\",\"column_title\":\"In Progress\",\"assignee_username\":null,\"assignee_name\":null,\"creator_username\":\"admin\",\"creator_name\":null,\"category_description\":null,\"column_position\":3},\"changes\":{\"src_column_id\":4,\"dst_column_id\":\"3\",\"date_moved\":1737007262},\"project_id\":1,\"position\":1,\"column_id\":\"3\",\"swimlane_id\":\"1\",\"src_column_id\":4,\"dst_column_id\":\"3\",\"date_moved\":1737007262,\"recurrence_status\":0,\"recurrence_trigger\":0}'),(14,1737009232,'task.update',1,1,2,'{\"task_id\":2,\"task\":{\"id\":2,\"title\":\"Optimize the process of adding custom domain names\",\"description\":\"\",\"date_creation\":1736956307,\"date_completed\":null,\"date_due\":0,\"color_id\":\"yellow\",\"project_id\":1,\"column_id\":3,\"owner_id\":0,\"position\":1,\"score\":5,\"is_active\":1,\"category_id\":0,\"creator_id\":1,\"date_modification\":1737009232,\"reference\":\"\",\"date_started\":0,\"time_spent\":10,\"time_estimated\":100,\"swimlane_id\":1,\"date_moved\":1737009064,\"recurrence_status\":0,\"recurrence_trigger\":0,\"recurrence_factor\":0,\"recurrence_timeframe\":0,\"recurrence_basedate\":0,\"recurrence_parent\":null,\"recurrence_child\":null,\"priority\":2,\"external_provider\":null,\"external_uri\":null,\"category_name\":null,\"swimlane_name\":\"Default swimlane\",\"project_name\":\"Roadmap\",\"column_title\":\"In Progress\",\"assignee_username\":null,\"assignee_name\":null,\"creator_username\":\"admin\",\"creator_name\":null,\"category_description\":null,\"column_position\":3},\"changes\":{\"title\":\"Optimize the process of adding custom domain names\",\"priority\":2,\"time_estimated\":\"100\",\"time_spent\":\"10\"}}'),(16,1737028655,'task.move.column',1,1,3,'{\"task_id\":3,\"task\":{\"id\":3,\"title\":\"Login with github\",\"description\":\"test\",\"date_creation\":1737003518,\"date_completed\":null,\"date_due\":0,\"color_id\":\"yellow\",\"project_id\":1,\"column_id\":4,\"owner_id\":0,\"position\":1,\"score\":1,\"is_active\":1,\"category_id\":0,\"creator_id\":1,\"date_modification\":1737028655,\"reference\":\"\",\"date_started\":0,\"time_spent\":85,\"time_estimated\":100,\"swimlane_id\":1,\"date_moved\":1737028655,\"recurrence_status\":0,\"recurrence_trigger\":0,\"recurrence_factor\":0,\"recurrence_timeframe\":0,\"recurrence_basedate\":0,\"recurrence_parent\":null,\"recurrence_child\":null,\"priority\":0,\"external_provider\":null,\"external_uri\":null,\"category_name\":null,\"swimlane_name\":\"Default swimlane\",\"project_name\":\"Roadmap\",\"column_title\":\"Complete\",\"assignee_username\":null,\"assignee_name\":null,\"creator_username\":\"admin\",\"creator_name\":null,\"category_description\":null,\"column_position\":4},\"changes\":{\"src_column_id\":2,\"dst_column_id\":\"4\",\"date_moved\":1737003518},\"project_id\":1,\"position\":1,\"column_id\":\"4\",\"swimlane_id\":\"1\",\"src_column_id\":2,\"dst_column_id\":\"4\",\"date_moved\":1737003518,\"recurrence_status\":0,\"recurrence_trigger\":0}');
/*!40000 ALTER TABLE `project_activities` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `project_daily_column_stats`
--

DROP TABLE IF EXISTS `project_daily_column_stats`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `project_daily_column_stats` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `day` char(10) COLLATE utf8mb4_unicode_ci NOT NULL,
  `project_id` int(11) NOT NULL,
  `column_id` int(11) NOT NULL,
  `total` int(11) NOT NULL DEFAULT '0',
  `score` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `project_daily_column_stats_idx` (`day`,`project_id`,`column_id`),
  KEY `column_id` (`column_id`),
  KEY `project_id` (`project_id`),
  CONSTRAINT `project_daily_column_stats_ibfk_1` FOREIGN KEY (`column_id`) REFERENCES `columns` (`id`) ON DELETE CASCADE,
  CONSTRAINT `project_daily_column_stats_ibfk_2` FOREIGN KEY (`project_id`) REFERENCES `projects` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `project_daily_column_stats`
--

LOCK TABLES `project_daily_column_stats` WRITE;
/*!40000 ALTER TABLE `project_daily_column_stats` DISABLE KEYS */;
INSERT INTO `project_daily_column_stats` VALUES (3,'2025-01-15',1,1,2,0),(33,'2025-01-16',1,1,1,4),(34,'2025-01-16',1,3,1,5),(35,'2025-01-16',1,4,1,1);
/*!40000 ALTER TABLE `project_daily_column_stats` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `project_daily_stats`
--

DROP TABLE IF EXISTS `project_daily_stats`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `project_daily_stats` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `day` char(10) COLLATE utf8mb4_unicode_ci NOT NULL,
  `project_id` int(11) NOT NULL,
  `avg_lead_time` int(11) NOT NULL DEFAULT '0',
  `avg_cycle_time` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `project_daily_stats_idx` (`day`,`project_id`),
  KEY `project_id` (`project_id`),
  CONSTRAINT `project_daily_stats_ibfk_1` FOREIGN KEY (`project_id`) REFERENCES `projects` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `project_daily_stats`
--

LOCK TABLES `project_daily_stats` WRITE;
/*!40000 ALTER TABLE `project_daily_stats` DISABLE KEYS */;
INSERT INTO `project_daily_stats` VALUES (3,'2025-01-15',1,2711,0),(15,'2025-01-16',1,58418,0);
/*!40000 ALTER TABLE `project_daily_stats` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `project_has_categories`
--

DROP TABLE IF EXISTS `project_has_categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `project_has_categories` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `project_id` int(11) NOT NULL,
  `description` mediumtext COLLATE utf8mb4_unicode_ci,
  `color_id` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_project_category` (`project_id`,`name`),
  KEY `categories_project_idx` (`project_id`),
  CONSTRAINT `project_has_categories_ibfk_1` FOREIGN KEY (`project_id`) REFERENCES `projects` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `project_has_categories`
--

LOCK TABLES `project_has_categories` WRITE;
/*!40000 ALTER TABLE `project_has_categories` DISABLE KEYS */;
/*!40000 ALTER TABLE `project_has_categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `project_has_files`
--

DROP TABLE IF EXISTS `project_has_files`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `project_has_files` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `project_id` int(11) NOT NULL,
  `name` mediumtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `path` mediumtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `is_image` tinyint(1) DEFAULT '0',
  `size` int(11) NOT NULL DEFAULT '0',
  `user_id` int(11) NOT NULL DEFAULT '0',
  `date` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `project_id` (`project_id`),
  CONSTRAINT `project_has_files_ibfk_1` FOREIGN KEY (`project_id`) REFERENCES `projects` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `project_has_files`
--

LOCK TABLES `project_has_files` WRITE;
/*!40000 ALTER TABLE `project_has_files` DISABLE KEYS */;
/*!40000 ALTER TABLE `project_has_files` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `project_has_groups`
--

DROP TABLE IF EXISTS `project_has_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `project_has_groups` (
  `group_id` int(11) NOT NULL,
  `project_id` int(11) NOT NULL,
  `role` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  UNIQUE KEY `group_id` (`group_id`,`project_id`),
  KEY `project_id` (`project_id`),
  CONSTRAINT `project_has_groups_ibfk_1` FOREIGN KEY (`group_id`) REFERENCES `groups` (`id`) ON DELETE CASCADE,
  CONSTRAINT `project_has_groups_ibfk_2` FOREIGN KEY (`project_id`) REFERENCES `projects` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `project_has_groups`
--

LOCK TABLES `project_has_groups` WRITE;
/*!40000 ALTER TABLE `project_has_groups` DISABLE KEYS */;
/*!40000 ALTER TABLE `project_has_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `project_has_metadata`
--

DROP TABLE IF EXISTS `project_has_metadata`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `project_has_metadata` (
  `project_id` int(11) NOT NULL,
  `name` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `changed_by` int(11) NOT NULL DEFAULT '0',
  `changed_on` int(11) NOT NULL DEFAULT '0',
  UNIQUE KEY `project_id` (`project_id`,`name`),
  CONSTRAINT `project_has_metadata_ibfk_1` FOREIGN KEY (`project_id`) REFERENCES `projects` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `project_has_metadata`
--

LOCK TABLES `project_has_metadata` WRITE;
/*!40000 ALTER TABLE `project_has_metadata` DISABLE KEYS */;
/*!40000 ALTER TABLE `project_has_metadata` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `project_has_notification_types`
--

DROP TABLE IF EXISTS `project_has_notification_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `project_has_notification_types` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `project_id` int(11) NOT NULL,
  `notification_type` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `project_id` (`project_id`,`notification_type`),
  CONSTRAINT `project_has_notification_types_ibfk_1` FOREIGN KEY (`project_id`) REFERENCES `projects` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `project_has_notification_types`
--

LOCK TABLES `project_has_notification_types` WRITE;
/*!40000 ALTER TABLE `project_has_notification_types` DISABLE KEYS */;
/*!40000 ALTER TABLE `project_has_notification_types` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `project_has_roles`
--

DROP TABLE IF EXISTS `project_has_roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `project_has_roles` (
  `role_id` int(11) NOT NULL AUTO_INCREMENT,
  `role` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `project_id` int(11) NOT NULL,
  PRIMARY KEY (`role_id`),
  UNIQUE KEY `project_id` (`project_id`,`role`),
  CONSTRAINT `project_has_roles_ibfk_1` FOREIGN KEY (`project_id`) REFERENCES `projects` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `project_has_roles`
--

LOCK TABLES `project_has_roles` WRITE;
/*!40000 ALTER TABLE `project_has_roles` DISABLE KEYS */;
/*!40000 ALTER TABLE `project_has_roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `project_has_users`
--

DROP TABLE IF EXISTS `project_has_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `project_has_users` (
  `project_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `role` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  UNIQUE KEY `idx_project_user` (`project_id`,`user_id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `project_has_users_ibfk_1` FOREIGN KEY (`project_id`) REFERENCES `projects` (`id`) ON DELETE CASCADE,
  CONSTRAINT `project_has_users_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `project_has_users`
--

LOCK TABLES `project_has_users` WRITE;
/*!40000 ALTER TABLE `project_has_users` DISABLE KEYS */;
INSERT INTO `project_has_users` VALUES (1,1,'project-manager'),(1,2,'project-member');
/*!40000 ALTER TABLE `project_has_users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `project_role_has_restrictions`
--

DROP TABLE IF EXISTS `project_role_has_restrictions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `project_role_has_restrictions` (
  `restriction_id` int(11) NOT NULL AUTO_INCREMENT,
  `project_id` int(11) NOT NULL,
  `role_id` int(11) NOT NULL,
  `rule` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`restriction_id`),
  UNIQUE KEY `role_id` (`role_id`,`rule`),
  KEY `project_id` (`project_id`),
  CONSTRAINT `project_role_has_restrictions_ibfk_1` FOREIGN KEY (`project_id`) REFERENCES `projects` (`id`) ON DELETE CASCADE,
  CONSTRAINT `project_role_has_restrictions_ibfk_2` FOREIGN KEY (`role_id`) REFERENCES `project_has_roles` (`role_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `project_role_has_restrictions`
--

LOCK TABLES `project_role_has_restrictions` WRITE;
/*!40000 ALTER TABLE `project_role_has_restrictions` DISABLE KEYS */;
/*!40000 ALTER TABLE `project_role_has_restrictions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `projects`
--

DROP TABLE IF EXISTS `projects`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `projects` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` mediumtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `is_active` tinyint(4) DEFAULT '1',
  `token` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `last_modified` bigint(20) DEFAULT NULL,
  `is_public` tinyint(1) DEFAULT '0',
  `is_private` tinyint(1) DEFAULT '0',
  `description` mediumtext COLLATE utf8mb4_unicode_ci,
  `identifier` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `start_date` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `end_date` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `owner_id` int(11) DEFAULT '0',
  `priority_default` int(11) DEFAULT '0',
  `priority_start` int(11) DEFAULT '0',
  `priority_end` int(11) DEFAULT '3',
  `email` mediumtext COLLATE utf8mb4_unicode_ci,
  `predefined_email_subjects` mediumtext COLLATE utf8mb4_unicode_ci,
  `per_swimlane_task_limits` int(11) NOT NULL DEFAULT '0',
  `task_limit` int(11) DEFAULT '0',
  `enable_global_tags` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `projects`
--

LOCK TABLES `projects` WRITE;
/*!40000 ALTER TABLE `projects` DISABLE KEYS */;
INSERT INTO `projects` VALUES (1,'Roadmap',1,'',1737028655,0,0,NULL,'ROADMAP','','',1,0,0,3,NULL,NULL,0,0,1);
/*!40000 ALTER TABLE `projects` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `remember_me`
--

DROP TABLE IF EXISTS `remember_me`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `remember_me` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `ip` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_agent` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `token` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `sequence` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `expiration` int(11) DEFAULT NULL,
  `date_creation` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `remember_me_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `remember_me`
--

LOCK TABLES `remember_me` WRITE;
/*!40000 ALTER TABLE `remember_me` DISABLE KEYS */;
INSERT INTO `remember_me` VALUES (1,1,'192.168.33.1','Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:133.0) Gecko/20100101 Firefox/133.0','dfcddb25367cca699d14aab4bcd7685f82c5b3639b260c65adf821ddf137539b','b41401017ee1a9caee9e2ca4a54e29b4b00b0f1f2bef6be0dc3560eecdab',1742134567,1736950567);
/*!40000 ALTER TABLE `remember_me` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `schema_version`
--

DROP TABLE IF EXISTS `schema_version`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `schema_version` (
  `version` int(11) DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `schema_version`
--

LOCK TABLES `schema_version` WRITE;
/*!40000 ALTER TABLE `schema_version` DISABLE KEYS */;
INSERT INTO `schema_version` VALUES (138);
/*!40000 ALTER TABLE `schema_version` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sessions`
--

DROP TABLE IF EXISTS `sessions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sessions` (
  `id` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `expire_at` int(11) NOT NULL,
  `data` longtext COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sessions`
--

LOCK TABLES `sessions` WRITE;
/*!40000 ALTER TABLE `sessions` DISABLE KEYS */;
INSERT INTO `sessions` VALUES ('02a0b339a99353a955bcfcce6662d6a6',1709286276,''),('0f13aa5290469f4db930ed4661e52228',1711389167,'redirectAfterLogin|s:1:\"/\";csrf_key|s:64:\"4f8b0cecc72768db2e699bb5e9b2e32486b79f9c35565e9a27ab9972410409e1\";user|a:24:{s:2:\"id\";i:1;s:8:\"username\";s:5:\"admin\";s:12:\"is_ldap_user\";b:0;s:4:\"name\";N;s:5:\"email\";N;s:9:\"google_id\";N;s:9:\"github_id\";N;s:21:\"notifications_enabled\";i:0;s:8:\"timezone\";N;s:8:\"language\";N;s:18:\"disable_login_form\";i:0;s:19:\"twofactor_activated\";b:0;s:16:\"twofactor_secret\";N;s:5:\"token\";s:0:\"\";s:20:\"notifications_filter\";i:4;s:15:\"nb_failed_login\";i:0;s:20:\"lock_expiration_date\";i:0;s:9:\"gitlab_id\";N;s:4:\"role\";s:9:\"app-admin\";s:9:\"is_active\";i:1;s:11:\"avatar_path\";N;s:16:\"api_access_token\";N;s:6:\"filter\";N;s:5:\"theme\";s:5:\"light\";}postAuthenticationValidated|b:0;hasSubtaskInProgress|b:0;'),('14a282f758426933122b742eb55b86e4',1706616639,'redirectAfterLogin|s:1:\"/\";csrf_key|s:64:\"65a0dbc2ed8c0bedd0af7fb1630c055a1b2516a427d20415e8a4b47549822bb7\";hasRememberMe|b:1;'),('17667eb7532ab1cf9cc02fb579f8bcab',1709286191,'redirectAfterLogin|s:1:\"/\";user|a:24:{s:2:\"id\";i:1;s:8:\"username\";s:5:\"admin\";s:12:\"is_ldap_user\";b:0;s:4:\"name\";N;s:5:\"email\";N;s:9:\"google_id\";N;s:9:\"github_id\";N;s:21:\"notifications_enabled\";i:0;s:8:\"timezone\";N;s:8:\"language\";N;s:18:\"disable_login_form\";i:0;s:19:\"twofactor_activated\";b:0;s:16:\"twofactor_secret\";N;s:5:\"token\";s:0:\"\";s:20:\"notifications_filter\";i:4;s:15:\"nb_failed_login\";i:0;s:20:\"lock_expiration_date\";i:0;s:9:\"gitlab_id\";N;s:4:\"role\";s:9:\"app-admin\";s:9:\"is_active\";i:1;s:11:\"avatar_path\";N;s:16:\"api_access_token\";N;s:6:\"filter\";N;s:5:\"theme\";s:5:\"light\";}postAuthenticationValidated|b:0;hasSubtaskInProgress|b:0;'),('1b1cc053f8fdc209d61adbcb59bdf818',1709286192,'redirectAfterLogin|s:1:\"/\";user|a:24:{s:2:\"id\";i:1;s:8:\"username\";s:5:\"admin\";s:12:\"is_ldap_user\";b:0;s:4:\"name\";N;s:5:\"email\";N;s:9:\"google_id\";N;s:9:\"github_id\";N;s:21:\"notifications_enabled\";i:0;s:8:\"timezone\";N;s:8:\"language\";N;s:18:\"disable_login_form\";i:0;s:19:\"twofactor_activated\";b:0;s:16:\"twofactor_secret\";N;s:5:\"token\";s:0:\"\";s:20:\"notifications_filter\";i:4;s:15:\"nb_failed_login\";i:0;s:20:\"lock_expiration_date\";i:0;s:9:\"gitlab_id\";N;s:4:\"role\";s:9:\"app-admin\";s:9:\"is_active\";i:1;s:11:\"avatar_path\";N;s:16:\"api_access_token\";N;s:6:\"filter\";N;s:5:\"theme\";s:5:\"light\";}postAuthenticationValidated|b:0;hasSubtaskInProgress|b:0;'),('1ded101159a4803156a0e5fad42caecd',1709226044,'redirectAfterLogin|s:1:\"/\";csrf_key|s:64:\"971df6ab6ecadc05a12d7cbde823e19bf2b5233ab9351e8fcf475bccf4c90805\";hasRememberMe|b:1;'),('2189204980eb14e2aabfc9438887590f',1709286187,'redirectAfterLogin|s:1:\"/\";user|a:24:{s:2:\"id\";i:1;s:8:\"username\";s:5:\"admin\";s:12:\"is_ldap_user\";b:0;s:4:\"name\";N;s:5:\"email\";N;s:9:\"google_id\";N;s:9:\"github_id\";N;s:21:\"notifications_enabled\";i:0;s:8:\"timezone\";N;s:8:\"language\";N;s:18:\"disable_login_form\";i:0;s:19:\"twofactor_activated\";b:0;s:16:\"twofactor_secret\";N;s:5:\"token\";s:0:\"\";s:20:\"notifications_filter\";i:4;s:15:\"nb_failed_login\";i:0;s:20:\"lock_expiration_date\";i:0;s:9:\"gitlab_id\";N;s:4:\"role\";s:9:\"app-admin\";s:9:\"is_active\";i:1;s:11:\"avatar_path\";N;s:16:\"api_access_token\";N;s:6:\"filter\";N;s:5:\"theme\";s:5:\"light\";}postAuthenticationValidated|b:0;hasSubtaskInProgress|b:0;'),('30305e2662fd8510db8cf5ecfdcb38fd',1709286187,'redirectAfterLogin|s:1:\"/\";user|a:24:{s:2:\"id\";i:1;s:8:\"username\";s:5:\"admin\";s:12:\"is_ldap_user\";b:0;s:4:\"name\";N;s:5:\"email\";N;s:9:\"google_id\";N;s:9:\"github_id\";N;s:21:\"notifications_enabled\";i:0;s:8:\"timezone\";N;s:8:\"language\";N;s:18:\"disable_login_form\";i:0;s:19:\"twofactor_activated\";b:0;s:16:\"twofactor_secret\";N;s:5:\"token\";s:0:\"\";s:20:\"notifications_filter\";i:4;s:15:\"nb_failed_login\";i:0;s:20:\"lock_expiration_date\";i:0;s:9:\"gitlab_id\";N;s:4:\"role\";s:9:\"app-admin\";s:9:\"is_active\";i:1;s:11:\"avatar_path\";N;s:16:\"api_access_token\";N;s:6:\"filter\";N;s:5:\"theme\";s:5:\"light\";}postAuthenticationValidated|b:0;hasSubtaskInProgress|b:0;'),('3543f4370688852d7c2e3e950fbbe5d9',1736964967,'redirectAfterLogin|s:1:\"/\";csrf_key|s:64:\"401d2ea5ab74a8e6940dc5d2974a265340c1c116d04090515ec5d7a74525df55\";hasRememberMe|b:1;'),('36b4a07014611a711f6389c0939f7ee5',1709286191,'redirectAfterLogin|s:1:\"/\";user|a:24:{s:2:\"id\";i:1;s:8:\"username\";s:5:\"admin\";s:12:\"is_ldap_user\";b:0;s:4:\"name\";N;s:5:\"email\";N;s:9:\"google_id\";N;s:9:\"github_id\";N;s:21:\"notifications_enabled\";i:0;s:8:\"timezone\";N;s:8:\"language\";N;s:18:\"disable_login_form\";i:0;s:19:\"twofactor_activated\";b:0;s:16:\"twofactor_secret\";N;s:5:\"token\";s:0:\"\";s:20:\"notifications_filter\";i:4;s:15:\"nb_failed_login\";i:0;s:20:\"lock_expiration_date\";i:0;s:9:\"gitlab_id\";N;s:4:\"role\";s:9:\"app-admin\";s:9:\"is_active\";i:1;s:11:\"avatar_path\";N;s:16:\"api_access_token\";N;s:6:\"filter\";N;s:5:\"theme\";s:5:\"light\";}postAuthenticationValidated|b:0;hasSubtaskInProgress|b:0;'),('3830cb8ba6e1ca7d76d13bfd2a22740d',1737043814,'user|a:24:{s:2:\"id\";i:1;s:8:\"username\";s:5:\"admin\";s:12:\"is_ldap_user\";b:0;s:4:\"name\";N;s:5:\"email\";N;s:9:\"google_id\";N;s:9:\"github_id\";N;s:21:\"notifications_enabled\";i:0;s:8:\"timezone\";N;s:8:\"language\";N;s:18:\"disable_login_form\";i:0;s:19:\"twofactor_activated\";b:0;s:16:\"twofactor_secret\";N;s:5:\"token\";s:0:\"\";s:20:\"notifications_filter\";i:4;s:15:\"nb_failed_login\";i:0;s:20:\"lock_expiration_date\";i:0;s:9:\"gitlab_id\";N;s:4:\"role\";s:9:\"app-admin\";s:9:\"is_active\";i:1;s:11:\"avatar_path\";N;s:16:\"api_access_token\";N;s:6:\"filter\";N;s:5:\"theme\";s:5:\"light\";}postAuthenticationValidated|b:0;hasSubtaskInProgress|b:0;filters:1|s:11:\"status:open\";pcsrf_key|s:64:\"5fa765999621a79b198d0831862ff50a42a8a657750afe0997eef89fc15e7511\";csrf_key|s:64:\"0680a1e3265ca947619dc3722315209623edaae94efe837bea9ce1957426616d\";flash|a:0:{}'),('383e93d719e5ff63e94f8511718d43b3',1707030522,''),('395dbe55c3bdcfb36b2b3c28af6ad182',1737017902,'user|a:24:{s:2:\"id\";i:1;s:8:\"username\";s:5:\"admin\";s:12:\"is_ldap_user\";b:0;s:4:\"name\";N;s:5:\"email\";N;s:9:\"google_id\";N;s:9:\"github_id\";N;s:21:\"notifications_enabled\";i:0;s:8:\"timezone\";N;s:8:\"language\";N;s:18:\"disable_login_form\";i:0;s:19:\"twofactor_activated\";b:0;s:16:\"twofactor_secret\";N;s:5:\"token\";s:0:\"\";s:20:\"notifications_filter\";i:4;s:15:\"nb_failed_login\";i:0;s:20:\"lock_expiration_date\";i:0;s:9:\"gitlab_id\";N;s:4:\"role\";s:9:\"app-admin\";s:9:\"is_active\";i:1;s:11:\"avatar_path\";N;s:16:\"api_access_token\";N;s:6:\"filter\";N;s:5:\"theme\";s:5:\"light\";}postAuthenticationValidated|b:1;'),('3d13ae77108956f618d5aebc620a57c0',1709286192,'redirectAfterLogin|s:1:\"/\";user|a:24:{s:2:\"id\";i:1;s:8:\"username\";s:5:\"admin\";s:12:\"is_ldap_user\";b:0;s:4:\"name\";N;s:5:\"email\";N;s:9:\"google_id\";N;s:9:\"github_id\";N;s:21:\"notifications_enabled\";i:0;s:8:\"timezone\";N;s:8:\"language\";N;s:18:\"disable_login_form\";i:0;s:19:\"twofactor_activated\";b:0;s:16:\"twofactor_secret\";N;s:5:\"token\";s:0:\"\";s:20:\"notifications_filter\";i:4;s:15:\"nb_failed_login\";i:0;s:20:\"lock_expiration_date\";i:0;s:9:\"gitlab_id\";N;s:4:\"role\";s:9:\"app-admin\";s:9:\"is_active\";i:1;s:11:\"avatar_path\";N;s:16:\"api_access_token\";N;s:6:\"filter\";N;s:5:\"theme\";s:5:\"light\";}postAuthenticationValidated|b:0;hasSubtaskInProgress|b:0;'),('3e72d9625fd5d273200fa0c58826f615',1709286188,'redirectAfterLogin|s:1:\"/\";user|a:24:{s:2:\"id\";i:1;s:8:\"username\";s:5:\"admin\";s:12:\"is_ldap_user\";b:0;s:4:\"name\";N;s:5:\"email\";N;s:9:\"google_id\";N;s:9:\"github_id\";N;s:21:\"notifications_enabled\";i:0;s:8:\"timezone\";N;s:8:\"language\";N;s:18:\"disable_login_form\";i:0;s:19:\"twofactor_activated\";b:0;s:16:\"twofactor_secret\";N;s:5:\"token\";s:0:\"\";s:20:\"notifications_filter\";i:4;s:15:\"nb_failed_login\";i:0;s:20:\"lock_expiration_date\";i:0;s:9:\"gitlab_id\";N;s:4:\"role\";s:9:\"app-admin\";s:9:\"is_active\";i:1;s:11:\"avatar_path\";N;s:16:\"api_access_token\";N;s:6:\"filter\";N;s:5:\"theme\";s:5:\"light\";}postAuthenticationValidated|b:0;hasSubtaskInProgress|b:0;'),('40463fc6b0a01d69c4c961e89ee83728',1709286191,'redirectAfterLogin|s:1:\"/\";user|a:24:{s:2:\"id\";i:1;s:8:\"username\";s:5:\"admin\";s:12:\"is_ldap_user\";b:0;s:4:\"name\";N;s:5:\"email\";N;s:9:\"google_id\";N;s:9:\"github_id\";N;s:21:\"notifications_enabled\";i:0;s:8:\"timezone\";N;s:8:\"language\";N;s:18:\"disable_login_form\";i:0;s:19:\"twofactor_activated\";b:0;s:16:\"twofactor_secret\";N;s:5:\"token\";s:0:\"\";s:20:\"notifications_filter\";i:4;s:15:\"nb_failed_login\";i:0;s:20:\"lock_expiration_date\";i:0;s:9:\"gitlab_id\";N;s:4:\"role\";s:9:\"app-admin\";s:9:\"is_active\";i:1;s:11:\"avatar_path\";N;s:16:\"api_access_token\";N;s:6:\"filter\";N;s:5:\"theme\";s:5:\"light\";}postAuthenticationValidated|b:0;hasSubtaskInProgress|b:0;'),('409d081f8f9adc150c4fe4d9f3f755b8',1709286189,'redirectAfterLogin|s:1:\"/\";user|a:24:{s:2:\"id\";i:1;s:8:\"username\";s:5:\"admin\";s:12:\"is_ldap_user\";b:0;s:4:\"name\";N;s:5:\"email\";N;s:9:\"google_id\";N;s:9:\"github_id\";N;s:21:\"notifications_enabled\";i:0;s:8:\"timezone\";N;s:8:\"language\";N;s:18:\"disable_login_form\";i:0;s:19:\"twofactor_activated\";b:0;s:16:\"twofactor_secret\";N;s:5:\"token\";s:0:\"\";s:20:\"notifications_filter\";i:4;s:15:\"nb_failed_login\";i:0;s:20:\"lock_expiration_date\";i:0;s:9:\"gitlab_id\";N;s:4:\"role\";s:9:\"app-admin\";s:9:\"is_active\";i:1;s:11:\"avatar_path\";N;s:16:\"api_access_token\";N;s:6:\"filter\";N;s:5:\"theme\";s:5:\"light\";}postAuthenticationValidated|b:0;hasSubtaskInProgress|b:0;'),('4b4a2cb5bcd5990b9501b62ad3c5bd49',1707030540,'csrf_key|s:64:\"efd59432e6d5bf268c23affa9e349d516c40217fec237b9304540bf006d3254d\";redirectAfterLogin|s:78:\"/?controller=BoardViewController&action=show&project_id=1&search=status%3Aopen\";'),('58bbbaed83f353fb44f223bc7603d9e4',1737043814,'user|a:24:{s:2:\"id\";i:1;s:8:\"username\";s:5:\"admin\";s:12:\"is_ldap_user\";b:0;s:4:\"name\";N;s:5:\"email\";N;s:9:\"google_id\";N;s:9:\"github_id\";N;s:21:\"notifications_enabled\";i:0;s:8:\"timezone\";N;s:8:\"language\";N;s:18:\"disable_login_form\";i:0;s:19:\"twofactor_activated\";b:0;s:16:\"twofactor_secret\";N;s:5:\"token\";s:0:\"\";s:20:\"notifications_filter\";i:4;s:15:\"nb_failed_login\";i:0;s:20:\"lock_expiration_date\";i:0;s:9:\"gitlab_id\";N;s:4:\"role\";s:9:\"app-admin\";s:9:\"is_active\";i:1;s:11:\"avatar_path\";N;s:16:\"api_access_token\";N;s:6:\"filter\";N;s:5:\"theme\";s:5:\"light\";}postAuthenticationValidated|b:1;hasSubtaskInProgress|b:0;filters:1|s:11:\"status:open\";pcsrf_key|s:64:\"5fa765999621a79b198d0831862ff50a42a8a657750afe0997eef89fc15e7511\";csrf_key|s:64:\"0680a1e3265ca947619dc3722315209623edaae94efe837bea9ce1957426616d\";flash|a:0:{}'),('590a85a2288cec57386ae9cb42c87733',1709226290,'redirectAfterLogin|s:1:\"/\";csrf_key|s:64:\"0b0d0c0badb3f435d6391e536fd5b6dc1136638fe49f08212a0e52c15174193f\";'),('64eb859a985e6a8eb79212c7a7e76053',1709286756,'csrf_key|s:64:\"e30fbebe347ba12ad29b9ff8cf9ca8705baaf93570af390d1a86fa545fd475e1\";redirectAfterLogin|s:47:\"/?cid=54&token=65293005441e8cbf0da291c004f88127\";'),('6b3c814611d64e9c21656ced3f1c8b76',1737017900,''),('6e9007e3af2b4b6ec359ed31b56ba55d',1707133985,'redirectAfterLogin|s:78:\"/?controller=BoardViewController&action=show&project_id=1&search=status%3Aopen\";csrf_key|s:64:\"8b24697ac6b140446a86cb2dc038dc0e1bfd530344e5b8fd660d9c29db4a9f55\";'),('7097d7f7b5fdd5f718641a894e310c4e',1709286188,'redirectAfterLogin|s:1:\"/\";user|a:24:{s:2:\"id\";i:1;s:8:\"username\";s:5:\"admin\";s:12:\"is_ldap_user\";b:0;s:4:\"name\";N;s:5:\"email\";N;s:9:\"google_id\";N;s:9:\"github_id\";N;s:21:\"notifications_enabled\";i:0;s:8:\"timezone\";N;s:8:\"language\";N;s:18:\"disable_login_form\";i:0;s:19:\"twofactor_activated\";b:0;s:16:\"twofactor_secret\";N;s:5:\"token\";s:0:\"\";s:20:\"notifications_filter\";i:4;s:15:\"nb_failed_login\";i:0;s:20:\"lock_expiration_date\";i:0;s:9:\"gitlab_id\";N;s:4:\"role\";s:9:\"app-admin\";s:9:\"is_active\";i:1;s:11:\"avatar_path\";N;s:16:\"api_access_token\";N;s:6:\"filter\";N;s:5:\"theme\";s:5:\"light\";}postAuthenticationValidated|b:0;hasSubtaskInProgress|b:0;'),('75527efad6bdd92dd28122791a5af084',1709286186,'redirectAfterLogin|s:1:\"/\";user|a:24:{s:2:\"id\";i:1;s:8:\"username\";s:5:\"admin\";s:12:\"is_ldap_user\";b:0;s:4:\"name\";N;s:5:\"email\";N;s:9:\"google_id\";N;s:9:\"github_id\";N;s:21:\"notifications_enabled\";i:0;s:8:\"timezone\";N;s:8:\"language\";N;s:18:\"disable_login_form\";i:0;s:19:\"twofactor_activated\";b:0;s:16:\"twofactor_secret\";N;s:5:\"token\";s:0:\"\";s:20:\"notifications_filter\";i:4;s:15:\"nb_failed_login\";i:0;s:20:\"lock_expiration_date\";i:0;s:9:\"gitlab_id\";N;s:4:\"role\";s:9:\"app-admin\";s:9:\"is_active\";i:1;s:11:\"avatar_path\";N;s:16:\"api_access_token\";N;s:6:\"filter\";N;s:5:\"theme\";s:5:\"light\";}postAuthenticationValidated|b:0;hasSubtaskInProgress|b:0;'),('75b4e43ab857f5fc0fb39b66088bbbba',1709286766,'csrf_key|s:64:\"763eb804dfdfbc8644782e52e4cdeb8d397614d7470e960fe7e826653577d38e\";'),('75fd6cb9d1c3a0de6860653c2a1b2c25',1709286190,'redirectAfterLogin|s:1:\"/\";user|a:24:{s:2:\"id\";i:1;s:8:\"username\";s:5:\"admin\";s:12:\"is_ldap_user\";b:0;s:4:\"name\";N;s:5:\"email\";N;s:9:\"google_id\";N;s:9:\"github_id\";N;s:21:\"notifications_enabled\";i:0;s:8:\"timezone\";N;s:8:\"language\";N;s:18:\"disable_login_form\";i:0;s:19:\"twofactor_activated\";b:0;s:16:\"twofactor_secret\";N;s:5:\"token\";s:0:\"\";s:20:\"notifications_filter\";i:4;s:15:\"nb_failed_login\";i:0;s:20:\"lock_expiration_date\";i:0;s:9:\"gitlab_id\";N;s:4:\"role\";s:9:\"app-admin\";s:9:\"is_active\";i:1;s:11:\"avatar_path\";N;s:16:\"api_access_token\";N;s:6:\"filter\";N;s:5:\"theme\";s:5:\"light\";}postAuthenticationValidated|b:0;hasSubtaskInProgress|b:0;'),('77782ed0ba28112dcbb776fd9773aac4',1709286189,'redirectAfterLogin|s:1:\"/\";user|a:24:{s:2:\"id\";i:1;s:8:\"username\";s:5:\"admin\";s:12:\"is_ldap_user\";b:0;s:4:\"name\";N;s:5:\"email\";N;s:9:\"google_id\";N;s:9:\"github_id\";N;s:21:\"notifications_enabled\";i:0;s:8:\"timezone\";N;s:8:\"language\";N;s:18:\"disable_login_form\";i:0;s:19:\"twofactor_activated\";b:0;s:16:\"twofactor_secret\";N;s:5:\"token\";s:0:\"\";s:20:\"notifications_filter\";i:4;s:15:\"nb_failed_login\";i:0;s:20:\"lock_expiration_date\";i:0;s:9:\"gitlab_id\";N;s:4:\"role\";s:9:\"app-admin\";s:9:\"is_active\";i:1;s:11:\"avatar_path\";N;s:16:\"api_access_token\";N;s:6:\"filter\";N;s:5:\"theme\";s:5:\"light\";}postAuthenticationValidated|b:0;hasSubtaskInProgress|b:0;'),('802cc3fe6133fe4ea5bda9ec165ce596',1709286190,'redirectAfterLogin|s:1:\"/\";user|a:24:{s:2:\"id\";i:1;s:8:\"username\";s:5:\"admin\";s:12:\"is_ldap_user\";b:0;s:4:\"name\";N;s:5:\"email\";N;s:9:\"google_id\";N;s:9:\"github_id\";N;s:21:\"notifications_enabled\";i:0;s:8:\"timezone\";N;s:8:\"language\";N;s:18:\"disable_login_form\";i:0;s:19:\"twofactor_activated\";b:0;s:16:\"twofactor_secret\";N;s:5:\"token\";s:0:\"\";s:20:\"notifications_filter\";i:4;s:15:\"nb_failed_login\";i:0;s:20:\"lock_expiration_date\";i:0;s:9:\"gitlab_id\";N;s:4:\"role\";s:9:\"app-admin\";s:9:\"is_active\";i:1;s:11:\"avatar_path\";N;s:16:\"api_access_token\";N;s:6:\"filter\";N;s:5:\"theme\";s:5:\"light\";}postAuthenticationValidated|b:0;hasSubtaskInProgress|b:0;'),('8d9fe25ab3e8ca5a6e510c608eb37fa8',1709286189,'redirectAfterLogin|s:1:\"/\";user|a:24:{s:2:\"id\";i:1;s:8:\"username\";s:5:\"admin\";s:12:\"is_ldap_user\";b:0;s:4:\"name\";N;s:5:\"email\";N;s:9:\"google_id\";N;s:9:\"github_id\";N;s:21:\"notifications_enabled\";i:0;s:8:\"timezone\";N;s:8:\"language\";N;s:18:\"disable_login_form\";i:0;s:19:\"twofactor_activated\";b:0;s:16:\"twofactor_secret\";N;s:5:\"token\";s:0:\"\";s:20:\"notifications_filter\";i:4;s:15:\"nb_failed_login\";i:0;s:20:\"lock_expiration_date\";i:0;s:9:\"gitlab_id\";N;s:4:\"role\";s:9:\"app-admin\";s:9:\"is_active\";i:1;s:11:\"avatar_path\";N;s:16:\"api_access_token\";N;s:6:\"filter\";N;s:5:\"theme\";s:5:\"light\";}postAuthenticationValidated|b:0;hasSubtaskInProgress|b:0;'),('936e19c782f7bf4e1849b36830a51c79',1709286183,'redirectAfterLogin|s:1:\"/\";user|a:24:{s:2:\"id\";i:1;s:8:\"username\";s:5:\"admin\";s:12:\"is_ldap_user\";b:0;s:4:\"name\";N;s:5:\"email\";N;s:9:\"google_id\";N;s:9:\"github_id\";N;s:21:\"notifications_enabled\";i:0;s:8:\"timezone\";N;s:8:\"language\";N;s:18:\"disable_login_form\";i:0;s:19:\"twofactor_activated\";b:0;s:16:\"twofactor_secret\";N;s:5:\"token\";s:0:\"\";s:20:\"notifications_filter\";i:4;s:15:\"nb_failed_login\";i:0;s:20:\"lock_expiration_date\";i:0;s:9:\"gitlab_id\";N;s:4:\"role\";s:9:\"app-admin\";s:9:\"is_active\";i:1;s:11:\"avatar_path\";N;s:16:\"api_access_token\";N;s:6:\"filter\";N;s:5:\"theme\";s:5:\"light\";}postAuthenticationValidated|b:0;hasSubtaskInProgress|b:0;'),('9763c48864c3f01943e78eb55a9a7707',1706623947,'csrf_key|s:64:\"65a0dbc2ed8c0bedd0af7fb1630c055a1b2516a427d20415e8a4b47549822bb7\";hasRememberMe|b:1;user|a:24:{s:2:\"id\";i:1;s:8:\"username\";s:5:\"admin\";s:12:\"is_ldap_user\";b:0;s:4:\"name\";N;s:5:\"email\";N;s:9:\"google_id\";N;s:9:\"github_id\";N;s:21:\"notifications_enabled\";i:0;s:8:\"timezone\";N;s:8:\"language\";N;s:18:\"disable_login_form\";i:0;s:19:\"twofactor_activated\";b:0;s:16:\"twofactor_secret\";N;s:5:\"token\";s:0:\"\";s:20:\"notifications_filter\";i:4;s:15:\"nb_failed_login\";i:0;s:20:\"lock_expiration_date\";i:0;s:9:\"gitlab_id\";N;s:4:\"role\";s:9:\"app-admin\";s:9:\"is_active\";i:1;s:11:\"avatar_path\";N;s:16:\"api_access_token\";N;s:6:\"filter\";N;s:5:\"theme\";s:5:\"light\";}postAuthenticationValidated|b:0;hasSubtaskInProgress|b:0;flash|a:0:{}filters:1|s:11:\"status:open\";pcsrf_key|s:64:\"dd96efde7374cc8866774697deae99db42657d6dc2d2de882e8fd7d7a38f3619\";'),('9bc4fb44d758baff872d5f1177f99610',1736975562,'csrf_key|s:64:\"401d2ea5ab74a8e6940dc5d2974a265340c1c116d04090515ec5d7a74525df55\";hasRememberMe|b:1;user|a:24:{s:2:\"id\";i:1;s:8:\"username\";s:5:\"admin\";s:12:\"is_ldap_user\";b:0;s:4:\"name\";N;s:5:\"email\";N;s:9:\"google_id\";N;s:9:\"github_id\";N;s:21:\"notifications_enabled\";i:0;s:8:\"timezone\";N;s:8:\"language\";N;s:18:\"disable_login_form\";i:0;s:19:\"twofactor_activated\";b:0;s:16:\"twofactor_secret\";N;s:5:\"token\";s:0:\"\";s:20:\"notifications_filter\";i:4;s:15:\"nb_failed_login\";i:1;s:20:\"lock_expiration_date\";i:0;s:9:\"gitlab_id\";N;s:4:\"role\";s:9:\"app-admin\";s:9:\"is_active\";i:1;s:11:\"avatar_path\";N;s:16:\"api_access_token\";N;s:6:\"filter\";N;s:5:\"theme\";s:5:\"light\";}postAuthenticationValidated|b:0;hasSubtaskInProgress|b:0;filters:1|s:11:\"status:open\";pcsrf_key|s:64:\"ee6dd020d96eabd54d7060618bfdf932dfc8cf2bbfcd70f604451372e617c8bf\";flash|a:0:{}listOrder:1|a:2:{i:0;s:8:\"tasks.id\";i:1;s:4:\"DESC\";}'),('9e536155ee227fd2e5282c7497af7ffe',1709286188,'redirectAfterLogin|s:1:\"/\";user|a:24:{s:2:\"id\";i:1;s:8:\"username\";s:5:\"admin\";s:12:\"is_ldap_user\";b:0;s:4:\"name\";N;s:5:\"email\";N;s:9:\"google_id\";N;s:9:\"github_id\";N;s:21:\"notifications_enabled\";i:0;s:8:\"timezone\";N;s:8:\"language\";N;s:18:\"disable_login_form\";i:0;s:19:\"twofactor_activated\";b:0;s:16:\"twofactor_secret\";N;s:5:\"token\";s:0:\"\";s:20:\"notifications_filter\";i:4;s:15:\"nb_failed_login\";i:0;s:20:\"lock_expiration_date\";i:0;s:9:\"gitlab_id\";N;s:4:\"role\";s:9:\"app-admin\";s:9:\"is_active\";i:1;s:11:\"avatar_path\";N;s:16:\"api_access_token\";N;s:6:\"filter\";N;s:5:\"theme\";s:5:\"light\";}postAuthenticationValidated|b:0;hasSubtaskInProgress|b:0;'),('a4c76c6ef56bd2ee3d72507cb67a34ec',1737017900,''),('adc873b8931dacf81d166a5382d03d56',1709286192,'redirectAfterLogin|s:1:\"/\";user|a:24:{s:2:\"id\";i:1;s:8:\"username\";s:5:\"admin\";s:12:\"is_ldap_user\";b:0;s:4:\"name\";N;s:5:\"email\";N;s:9:\"google_id\";N;s:9:\"github_id\";N;s:21:\"notifications_enabled\";i:0;s:8:\"timezone\";N;s:8:\"language\";N;s:18:\"disable_login_form\";i:0;s:19:\"twofactor_activated\";b:0;s:16:\"twofactor_secret\";N;s:5:\"token\";s:0:\"\";s:20:\"notifications_filter\";i:4;s:15:\"nb_failed_login\";i:0;s:20:\"lock_expiration_date\";i:0;s:9:\"gitlab_id\";N;s:4:\"role\";s:9:\"app-admin\";s:9:\"is_active\";i:1;s:11:\"avatar_path\";N;s:16:\"api_access_token\";N;s:6:\"filter\";N;s:5:\"theme\";s:5:\"light\";}postAuthenticationValidated|b:0;hasSubtaskInProgress|b:0;'),('b40ca5e7be193eccc250a0bd68ed3f70',1737043814,'user|a:24:{s:2:\"id\";i:1;s:8:\"username\";s:5:\"admin\";s:12:\"is_ldap_user\";b:0;s:4:\"name\";N;s:5:\"email\";N;s:9:\"google_id\";N;s:9:\"github_id\";N;s:21:\"notifications_enabled\";i:0;s:8:\"timezone\";N;s:8:\"language\";N;s:18:\"disable_login_form\";i:0;s:19:\"twofactor_activated\";b:0;s:16:\"twofactor_secret\";N;s:5:\"token\";s:0:\"\";s:20:\"notifications_filter\";i:4;s:15:\"nb_failed_login\";i:0;s:20:\"lock_expiration_date\";i:0;s:9:\"gitlab_id\";N;s:4:\"role\";s:9:\"app-admin\";s:9:\"is_active\";i:1;s:11:\"avatar_path\";N;s:16:\"api_access_token\";N;s:6:\"filter\";N;s:5:\"theme\";s:5:\"light\";}postAuthenticationValidated|b:0;hasSubtaskInProgress|b:0;filters:1|s:11:\"status:open\";pcsrf_key|s:64:\"5fa765999621a79b198d0831862ff50a42a8a657750afe0997eef89fc15e7511\";csrf_key|s:64:\"0680a1e3265ca947619dc3722315209623edaae94efe837bea9ce1957426616d\";flash|a:0:{}'),('c20f2542899b3627a35341ae33f49c79',1711389045,'redirectAfterLogin|s:1:\"/\";csrf_key|s:64:\"4f8b0cecc72768db2e699bb5e9b2e32486b79f9c35565e9a27ab9972410409e1\";'),('cb13a40b6d7ad4e3d1ea477360a8c1f9',1709312916,'csrf_key|s:64:\"763eb804dfdfbc8644782e52e4cdeb8d397614d7470e960fe7e826653577d38e\";user|a:24:{s:2:\"id\";i:1;s:8:\"username\";s:5:\"admin\";s:12:\"is_ldap_user\";b:0;s:4:\"name\";N;s:5:\"email\";N;s:9:\"google_id\";N;s:9:\"github_id\";N;s:21:\"notifications_enabled\";i:0;s:8:\"timezone\";N;s:8:\"language\";N;s:18:\"disable_login_form\";i:0;s:19:\"twofactor_activated\";b:0;s:16:\"twofactor_secret\";N;s:5:\"token\";s:0:\"\";s:20:\"notifications_filter\";i:4;s:15:\"nb_failed_login\";i:0;s:20:\"lock_expiration_date\";i:0;s:9:\"gitlab_id\";N;s:4:\"role\";s:9:\"app-admin\";s:9:\"is_active\";i:1;s:11:\"avatar_path\";N;s:16:\"api_access_token\";N;s:6:\"filter\";N;s:5:\"theme\";s:5:\"light\";}postAuthenticationValidated|b:0;hasSubtaskInProgress|b:0;filters:1|s:11:\"status:open\";pcsrf_key|s:64:\"6efe4cabd7d7282db698f7f4bbc9edddabe6c86dfd29f9621a764223b9d62175\";'),('dbda7dd192da9fbba49d9fcb73ded25d',1709286189,'redirectAfterLogin|s:1:\"/\";user|a:24:{s:2:\"id\";i:1;s:8:\"username\";s:5:\"admin\";s:12:\"is_ldap_user\";b:0;s:4:\"name\";N;s:5:\"email\";N;s:9:\"google_id\";N;s:9:\"github_id\";N;s:21:\"notifications_enabled\";i:0;s:8:\"timezone\";N;s:8:\"language\";N;s:18:\"disable_login_form\";i:0;s:19:\"twofactor_activated\";b:0;s:16:\"twofactor_secret\";N;s:5:\"token\";s:0:\"\";s:20:\"notifications_filter\";i:4;s:15:\"nb_failed_login\";i:0;s:20:\"lock_expiration_date\";i:0;s:9:\"gitlab_id\";N;s:4:\"role\";s:9:\"app-admin\";s:9:\"is_active\";i:1;s:11:\"avatar_path\";N;s:16:\"api_access_token\";N;s:6:\"filter\";N;s:5:\"theme\";s:5:\"light\";}postAuthenticationValidated|b:0;hasSubtaskInProgress|b:0;'),('e38c2d17c59274340f2dff337fd759c0',1709286190,'redirectAfterLogin|s:1:\"/\";user|a:24:{s:2:\"id\";i:1;s:8:\"username\";s:5:\"admin\";s:12:\"is_ldap_user\";b:0;s:4:\"name\";N;s:5:\"email\";N;s:9:\"google_id\";N;s:9:\"github_id\";N;s:21:\"notifications_enabled\";i:0;s:8:\"timezone\";N;s:8:\"language\";N;s:18:\"disable_login_form\";i:0;s:19:\"twofactor_activated\";b:0;s:16:\"twofactor_secret\";N;s:5:\"token\";s:0:\"\";s:20:\"notifications_filter\";i:4;s:15:\"nb_failed_login\";i:0;s:20:\"lock_expiration_date\";i:0;s:9:\"gitlab_id\";N;s:4:\"role\";s:9:\"app-admin\";s:9:\"is_active\";i:1;s:11:\"avatar_path\";N;s:16:\"api_access_token\";N;s:6:\"filter\";N;s:5:\"theme\";s:5:\"light\";}postAuthenticationValidated|b:0;hasSubtaskInProgress|b:0;'),('eb3beda5ffaccbee8ca93d7c941c8da5',1709286188,'redirectAfterLogin|s:1:\"/\";user|a:24:{s:2:\"id\";i:1;s:8:\"username\";s:5:\"admin\";s:12:\"is_ldap_user\";b:0;s:4:\"name\";N;s:5:\"email\";N;s:9:\"google_id\";N;s:9:\"github_id\";N;s:21:\"notifications_enabled\";i:0;s:8:\"timezone\";N;s:8:\"language\";N;s:18:\"disable_login_form\";i:0;s:19:\"twofactor_activated\";b:0;s:16:\"twofactor_secret\";N;s:5:\"token\";s:0:\"\";s:20:\"notifications_filter\";i:4;s:15:\"nb_failed_login\";i:0;s:20:\"lock_expiration_date\";i:0;s:9:\"gitlab_id\";N;s:4:\"role\";s:9:\"app-admin\";s:9:\"is_active\";i:1;s:11:\"avatar_path\";N;s:16:\"api_access_token\";N;s:6:\"filter\";N;s:5:\"theme\";s:5:\"light\";}postAuthenticationValidated|b:0;hasSubtaskInProgress|b:0;'),('f17db3f31dfc4e482a989ad66d5e0641',1709286174,'redirectAfterLogin|s:1:\"/\";'),('f347e02af924a58058a94ef66a3b9766',1709286267,'redirectAfterLogin|s:1:\"/\";user|a:24:{s:2:\"id\";i:1;s:8:\"username\";s:5:\"admin\";s:12:\"is_ldap_user\";b:0;s:4:\"name\";N;s:5:\"email\";N;s:9:\"google_id\";N;s:9:\"github_id\";N;s:21:\"notifications_enabled\";i:0;s:8:\"timezone\";N;s:8:\"language\";N;s:18:\"disable_login_form\";i:0;s:19:\"twofactor_activated\";b:0;s:16:\"twofactor_secret\";N;s:5:\"token\";s:0:\"\";s:20:\"notifications_filter\";i:4;s:15:\"nb_failed_login\";i:0;s:20:\"lock_expiration_date\";i:0;s:9:\"gitlab_id\";N;s:4:\"role\";s:9:\"app-admin\";s:9:\"is_active\";i:1;s:11:\"avatar_path\";N;s:16:\"api_access_token\";N;s:6:\"filter\";N;s:5:\"theme\";s:5:\"light\";}postAuthenticationValidated|b:0;hasSubtaskInProgress|b:0;'),('fdb2c9f21289a14b3b406eceb17740cc',1709286189,'redirectAfterLogin|s:1:\"/\";user|a:24:{s:2:\"id\";i:1;s:8:\"username\";s:5:\"admin\";s:12:\"is_ldap_user\";b:0;s:4:\"name\";N;s:5:\"email\";N;s:9:\"google_id\";N;s:9:\"github_id\";N;s:21:\"notifications_enabled\";i:0;s:8:\"timezone\";N;s:8:\"language\";N;s:18:\"disable_login_form\";i:0;s:19:\"twofactor_activated\";b:0;s:16:\"twofactor_secret\";N;s:5:\"token\";s:0:\"\";s:20:\"notifications_filter\";i:4;s:15:\"nb_failed_login\";i:0;s:20:\"lock_expiration_date\";i:0;s:9:\"gitlab_id\";N;s:4:\"role\";s:9:\"app-admin\";s:9:\"is_active\";i:1;s:11:\"avatar_path\";N;s:16:\"api_access_token\";N;s:6:\"filter\";N;s:5:\"theme\";s:5:\"light\";}postAuthenticationValidated|b:0;hasSubtaskInProgress|b:0;'),('ffc386a88c99498ba20ae09c79840252',1709286189,'redirectAfterLogin|s:1:\"/\";user|a:24:{s:2:\"id\";i:1;s:8:\"username\";s:5:\"admin\";s:12:\"is_ldap_user\";b:0;s:4:\"name\";N;s:5:\"email\";N;s:9:\"google_id\";N;s:9:\"github_id\";N;s:21:\"notifications_enabled\";i:0;s:8:\"timezone\";N;s:8:\"language\";N;s:18:\"disable_login_form\";i:0;s:19:\"twofactor_activated\";b:0;s:16:\"twofactor_secret\";N;s:5:\"token\";s:0:\"\";s:20:\"notifications_filter\";i:4;s:15:\"nb_failed_login\";i:0;s:20:\"lock_expiration_date\";i:0;s:9:\"gitlab_id\";N;s:4:\"role\";s:9:\"app-admin\";s:9:\"is_active\";i:1;s:11:\"avatar_path\";N;s:16:\"api_access_token\";N;s:6:\"filter\";N;s:5:\"theme\";s:5:\"light\";}postAuthenticationValidated|b:0;hasSubtaskInProgress|b:0;');
/*!40000 ALTER TABLE `sessions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `settings`
--

DROP TABLE IF EXISTS `settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `settings` (
  `option` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` text COLLATE utf8mb4_unicode_ci,
  `changed_by` int(11) NOT NULL DEFAULT '0',
  `changed_on` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`option`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `settings`
--

LOCK TABLES `settings` WRITE;
/*!40000 ALTER TABLE `settings` DISABLE KEYS */;
INSERT INTO `settings` VALUES ('api_token','2c70e4308def39942146cfb7a5f62cc9af9dd99255f20ce4b3d4f31893d1',0,0),('application_currency','USD',0,0),('application_date_format','m/d/Y',0,0),('application_language','en_US',0,0),('application_stylesheet','',0,0),('application_timezone','UTC',0,0),('application_url','',0,0),('board_columns','',0,0),('board_highlight_period','172800',0,0),('board_private_refresh_interval','10',0,0),('board_public_refresh_interval','60',0,0),('calendar_project_tasks','date_started',0,0),('calendar_user_subtasks_time_tracking','0',0,0),('calendar_user_tasks','date_started',0,0),('cfd_include_closed_tasks','1',0,0),('default_color','yellow',0,0),('integration_gravatar','0',0,0),('password_reset','1',0,0),('project_categories','',0,0),('subtask_restriction','0',0,0),('subtask_time_tracking','1',0,0),('webhook_token','d5ff2a78a7830e2f9cefb5b73c490c5d24685bccce43ae2a241d1457f23a',0,0),('webhook_url','',0,0);
/*!40000 ALTER TABLE `settings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `subtask_time_tracking`
--

DROP TABLE IF EXISTS `subtask_time_tracking`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `subtask_time_tracking` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `subtask_id` int(11) NOT NULL,
  `start` bigint(20) DEFAULT NULL,
  `end` bigint(20) DEFAULT NULL,
  `time_spent` float DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `subtask_id` (`subtask_id`),
  CONSTRAINT `subtask_time_tracking_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `subtask_time_tracking_ibfk_2` FOREIGN KEY (`subtask_id`) REFERENCES `subtasks` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `subtask_time_tracking`
--

LOCK TABLES `subtask_time_tracking` WRITE;
/*!40000 ALTER TABLE `subtask_time_tracking` DISABLE KEYS */;
/*!40000 ALTER TABLE `subtask_time_tracking` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `subtasks`
--

DROP TABLE IF EXISTS `subtasks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `subtasks` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` mediumtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` int(11) DEFAULT '0',
  `time_estimated` float DEFAULT NULL,
  `time_spent` float DEFAULT NULL,
  `task_id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `position` int(11) DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `subtasks_task_idx` (`task_id`),
  CONSTRAINT `subtasks_ibfk_1` FOREIGN KEY (`task_id`) REFERENCES `tasks` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `subtasks`
--

LOCK TABLES `subtasks` WRITE;
/*!40000 ALTER TABLE `subtasks` DISABLE KEYS */;
/*!40000 ALTER TABLE `subtasks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `swimlanes`
--

DROP TABLE IF EXISTS `swimlanes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `swimlanes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `position` int(11) DEFAULT '1',
  `is_active` int(11) DEFAULT '1',
  `project_id` int(11) DEFAULT NULL,
  `description` mediumtext COLLATE utf8mb4_unicode_ci,
  `task_limit` int(11) DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`,`project_id`),
  KEY `swimlanes_project_idx` (`project_id`),
  CONSTRAINT `swimlanes_ibfk_1` FOREIGN KEY (`project_id`) REFERENCES `projects` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `swimlanes`
--

LOCK TABLES `swimlanes` WRITE;
/*!40000 ALTER TABLE `swimlanes` DISABLE KEYS */;
INSERT INTO `swimlanes` VALUES (1,'Default swimlane',1,1,1,'',0);
/*!40000 ALTER TABLE `swimlanes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tags`
--

DROP TABLE IF EXISTS `tags`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tags` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `project_id` int(11) NOT NULL,
  `color_id` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `project_id` (`project_id`,`name`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tags`
--

LOCK TABLES `tags` WRITE;
/*!40000 ALTER TABLE `tags` DISABLE KEYS */;
INSERT INTO `tags` VALUES (1,'Account',1,NULL),(2,'Functional',1,NULL),(3,'User Experience',1,NULL);
/*!40000 ALTER TABLE `tags` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `task_has_external_links`
--

DROP TABLE IF EXISTS `task_has_external_links`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `task_has_external_links` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `link_type` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `dependency` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `title` mediumtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `url` mediumtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `date_creation` int(11) NOT NULL,
  `date_modification` int(11) NOT NULL,
  `task_id` int(11) NOT NULL,
  `creator_id` int(11) DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `task_id` (`task_id`),
  CONSTRAINT `task_has_external_links_ibfk_1` FOREIGN KEY (`task_id`) REFERENCES `tasks` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `task_has_external_links`
--

LOCK TABLES `task_has_external_links` WRITE;
/*!40000 ALTER TABLE `task_has_external_links` DISABLE KEYS */;
/*!40000 ALTER TABLE `task_has_external_links` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `task_has_files`
--

DROP TABLE IF EXISTS `task_has_files`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `task_has_files` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` mediumtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `path` mediumtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `is_image` tinyint(1) DEFAULT '0',
  `task_id` int(11) NOT NULL,
  `date` bigint(20) DEFAULT NULL,
  `user_id` int(11) NOT NULL DEFAULT '0',
  `size` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `files_task_idx` (`task_id`),
  CONSTRAINT `task_has_files_ibfk_1` FOREIGN KEY (`task_id`) REFERENCES `tasks` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `task_has_files`
--

LOCK TABLES `task_has_files` WRITE;
/*!40000 ALTER TABLE `task_has_files` DISABLE KEYS */;
/*!40000 ALTER TABLE `task_has_files` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `task_has_links`
--

DROP TABLE IF EXISTS `task_has_links`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `task_has_links` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `link_id` int(11) NOT NULL,
  `task_id` int(11) NOT NULL,
  `opposite_task_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `task_has_links_unique` (`link_id`,`task_id`,`opposite_task_id`),
  KEY `opposite_task_id` (`opposite_task_id`),
  KEY `task_has_links_task_index` (`task_id`),
  CONSTRAINT `task_has_links_ibfk_1` FOREIGN KEY (`link_id`) REFERENCES `links` (`id`) ON DELETE CASCADE,
  CONSTRAINT `task_has_links_ibfk_2` FOREIGN KEY (`task_id`) REFERENCES `tasks` (`id`) ON DELETE CASCADE,
  CONSTRAINT `task_has_links_ibfk_3` FOREIGN KEY (`opposite_task_id`) REFERENCES `tasks` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `task_has_links`
--

LOCK TABLES `task_has_links` WRITE;
/*!40000 ALTER TABLE `task_has_links` DISABLE KEYS */;
/*!40000 ALTER TABLE `task_has_links` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `task_has_metadata`
--

DROP TABLE IF EXISTS `task_has_metadata`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `task_has_metadata` (
  `task_id` int(11) NOT NULL,
  `name` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `changed_by` int(11) NOT NULL DEFAULT '0',
  `changed_on` int(11) NOT NULL DEFAULT '0',
  UNIQUE KEY `task_id` (`task_id`,`name`),
  CONSTRAINT `task_has_metadata_ibfk_1` FOREIGN KEY (`task_id`) REFERENCES `tasks` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `task_has_metadata`
--

LOCK TABLES `task_has_metadata` WRITE;
/*!40000 ALTER TABLE `task_has_metadata` DISABLE KEYS */;
/*!40000 ALTER TABLE `task_has_metadata` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `task_has_tags`
--

DROP TABLE IF EXISTS `task_has_tags`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `task_has_tags` (
  `task_id` int(11) NOT NULL,
  `tag_id` int(11) NOT NULL,
  UNIQUE KEY `tag_id` (`tag_id`,`task_id`),
  KEY `task_id` (`task_id`),
  CONSTRAINT `task_has_tags_ibfk_1` FOREIGN KEY (`task_id`) REFERENCES `tasks` (`id`) ON DELETE CASCADE,
  CONSTRAINT `task_has_tags_ibfk_2` FOREIGN KEY (`tag_id`) REFERENCES `tags` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `task_has_tags`
--

LOCK TABLES `task_has_tags` WRITE;
/*!40000 ALTER TABLE `task_has_tags` DISABLE KEYS */;
INSERT INTO `task_has_tags` VALUES (2,1),(2,3),(3,2);
/*!40000 ALTER TABLE `task_has_tags` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tasks`
--

DROP TABLE IF EXISTS `tasks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tasks` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` mediumtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` mediumtext COLLATE utf8mb4_unicode_ci,
  `date_creation` bigint(20) DEFAULT NULL,
  `date_completed` bigint(20) DEFAULT NULL,
  `date_due` bigint(20) DEFAULT NULL,
  `color_id` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `project_id` int(11) NOT NULL,
  `column_id` int(11) NOT NULL,
  `owner_id` int(11) DEFAULT '0',
  `position` int(11) DEFAULT NULL,
  `score` int(11) DEFAULT NULL,
  `is_active` tinyint(4) DEFAULT '1',
  `category_id` int(11) DEFAULT '0',
  `creator_id` int(11) DEFAULT '0',
  `date_modification` int(11) DEFAULT '0',
  `reference` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `date_started` bigint(20) DEFAULT NULL,
  `time_spent` float DEFAULT '0',
  `time_estimated` float DEFAULT '0',
  `swimlane_id` int(11) NOT NULL,
  `date_moved` bigint(20) DEFAULT NULL,
  `recurrence_status` int(11) NOT NULL DEFAULT '0',
  `recurrence_trigger` int(11) NOT NULL DEFAULT '0',
  `recurrence_factor` int(11) NOT NULL DEFAULT '0',
  `recurrence_timeframe` int(11) NOT NULL DEFAULT '0',
  `recurrence_basedate` int(11) NOT NULL DEFAULT '0',
  `recurrence_parent` int(11) DEFAULT NULL,
  `recurrence_child` int(11) DEFAULT NULL,
  `priority` int(11) DEFAULT '0',
  `external_provider` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `external_uri` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_task_active` (`is_active`),
  KEY `column_id` (`column_id`),
  KEY `tasks_reference_idx` (`reference`),
  KEY `tasks_project_idx` (`project_id`),
  KEY `tasks_swimlane_ibfk_1` (`swimlane_id`),
  CONSTRAINT `tasks_ibfk_1` FOREIGN KEY (`project_id`) REFERENCES `projects` (`id`) ON DELETE CASCADE,
  CONSTRAINT `tasks_ibfk_2` FOREIGN KEY (`column_id`) REFERENCES `columns` (`id`) ON DELETE CASCADE,
  CONSTRAINT `tasks_swimlane_ibfk_1` FOREIGN KEY (`swimlane_id`) REFERENCES `swimlanes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tasks`
--

LOCK TABLES `tasks` WRITE;
/*!40000 ALTER TABLE `tasks` DISABLE KEYS */;
INSERT INTO `tasks` VALUES (2,'Optimize the process of adding custom domain names','',1736956307,NULL,0,'yellow',1,3,0,1,5,1,0,1,1737009232,'',0,10,100,1,1737009064,0,0,0,0,0,NULL,NULL,2,NULL,NULL),(3,'Login with github','',1737003518,NULL,0,'yellow',1,4,0,1,1,1,0,1,1737028655,'',0,85,100,1,1737028655,0,0,0,0,0,NULL,NULL,0,NULL,NULL);
/*!40000 ALTER TABLE `tasks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `transitions`
--

DROP TABLE IF EXISTS `transitions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `transitions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `project_id` int(11) NOT NULL,
  `task_id` int(11) NOT NULL,
  `src_column_id` int(11) NOT NULL,
  `dst_column_id` int(11) NOT NULL,
  `date` bigint(20) DEFAULT NULL,
  `time_spent` int(11) DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `src_column_id` (`src_column_id`),
  KEY `dst_column_id` (`dst_column_id`),
  KEY `transitions_task_index` (`task_id`),
  KEY `transitions_project_index` (`project_id`),
  KEY `transitions_user_index` (`user_id`),
  CONSTRAINT `transitions_ibfk_1` FOREIGN KEY (`src_column_id`) REFERENCES `columns` (`id`) ON DELETE CASCADE,
  CONSTRAINT `transitions_ibfk_2` FOREIGN KEY (`dst_column_id`) REFERENCES `columns` (`id`) ON DELETE CASCADE,
  CONSTRAINT `transitions_ibfk_3` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `transitions_ibfk_4` FOREIGN KEY (`project_id`) REFERENCES `projects` (`id`) ON DELETE CASCADE,
  CONSTRAINT `transitions_ibfk_5` FOREIGN KEY (`task_id`) REFERENCES `tasks` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `transitions`
--

LOCK TABLES `transitions` WRITE;
/*!40000 ALTER TABLE `transitions` DISABLE KEYS */;
INSERT INTO `transitions` VALUES (1,1,1,2,1,3,1737003525,47218),(2,1,1,2,3,2,1737003794,269),(3,1,1,2,2,4,1737007262,3468),(4,1,1,2,4,3,1737009064,1802),(5,1,1,3,2,4,1737028655,25137);
/*!40000 ALTER TABLE `transitions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_has_metadata`
--

DROP TABLE IF EXISTS `user_has_metadata`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_has_metadata` (
  `user_id` int(11) NOT NULL,
  `name` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `changed_by` int(11) NOT NULL DEFAULT '0',
  `changed_on` int(11) NOT NULL DEFAULT '0',
  UNIQUE KEY `user_id` (`user_id`,`name`),
  CONSTRAINT `user_has_metadata_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_has_metadata`
--

LOCK TABLES `user_has_metadata` WRITE;
/*!40000 ALTER TABLE `user_has_metadata` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_has_metadata` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_has_notification_types`
--

DROP TABLE IF EXISTS `user_has_notification_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_has_notification_types` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `notification_type` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_has_notification_types_user_idx` (`user_id`,`notification_type`),
  CONSTRAINT `user_has_notification_types_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_has_notification_types`
--

LOCK TABLES `user_has_notification_types` WRITE;
/*!40000 ALTER TABLE `user_has_notification_types` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_has_notification_types` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_has_notifications`
--

DROP TABLE IF EXISTS `user_has_notifications`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_has_notifications` (
  `user_id` int(11) NOT NULL,
  `project_id` int(11) NOT NULL,
  UNIQUE KEY `user_has_notifications_unique_idx` (`user_id`,`project_id`),
  KEY `user_has_notifications_ibfk_2` (`project_id`),
  CONSTRAINT `user_has_notifications_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `user_has_notifications_ibfk_2` FOREIGN KEY (`project_id`) REFERENCES `projects` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_has_notifications`
--

LOCK TABLES `user_has_notifications` WRITE;
/*!40000 ALTER TABLE `user_has_notifications` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_has_notifications` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_has_unread_notifications`
--

DROP TABLE IF EXISTS `user_has_unread_notifications`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_has_unread_notifications` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `date_creation` bigint(20) NOT NULL,
  `event_name` mediumtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `event_data` mediumtext COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `user_has_unread_notifications_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_has_unread_notifications`
--

LOCK TABLES `user_has_unread_notifications` WRITE;
/*!40000 ALTER TABLE `user_has_unread_notifications` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_has_unread_notifications` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_ldap_user` tinyint(1) DEFAULT '0',
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `google_id` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `github_id` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `notifications_enabled` tinyint(1) DEFAULT '0',
  `timezone` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `language` varchar(11) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `disable_login_form` tinyint(1) DEFAULT '0',
  `twofactor_activated` tinyint(1) DEFAULT '0',
  `twofactor_secret` char(16) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `token` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `notifications_filter` int(11) DEFAULT '4',
  `nb_failed_login` int(11) DEFAULT '0',
  `lock_expiration_date` bigint(20) DEFAULT NULL,
  `gitlab_id` int(11) DEFAULT NULL,
  `role` varchar(25) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'app-user',
  `is_active` tinyint(1) DEFAULT '1',
  `avatar_path` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `api_access_token` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `filter` mediumtext COLLATE utf8mb4_unicode_ci,
  `theme` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'light',
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_username_idx` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'admin','$2y$10$9APBSiYm/GzE3crtHwnHbOmfTS9Nj./mTbNVwo2meCuJ56pxP0AOO',0,NULL,NULL,NULL,NULL,0,NULL,NULL,0,0,NULL,'',4,0,0,NULL,'app-admin',1,NULL,NULL,NULL,'light'),(2,'Anonymous','$2y$10$Gb0gOCUEXNezKscLsCyY2.hOqUlg1XrtXH5Shv8ZLfRmcGq.6iLW2',0,'Anonymous','anonymous@example.com',NULL,NULL,0,'','',1,0,NULL,'',4,0,NULL,NULL,'app-user',1,NULL,NULL,'','light');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-01-16 12:10:26
