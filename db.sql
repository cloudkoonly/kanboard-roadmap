-- MySQL dump 10.13  Distrib 8.0.27, for Linux (x86_64)
--
-- Host: localhost    Database: roadmap
-- ------------------------------------------------------
-- Server version	8.0.27

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
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
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `action_has_params` (
  `id` int NOT NULL AUTO_INCREMENT,
  `action_id` int NOT NULL,
  `name` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
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
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `actions` (
  `id` int NOT NULL AUTO_INCREMENT,
  `project_id` int NOT NULL,
  `event_name` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `action_name` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
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
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `column_has_move_restrictions` (
  `restriction_id` int NOT NULL AUTO_INCREMENT,
  `project_id` int NOT NULL,
  `role_id` int NOT NULL,
  `src_column_id` int NOT NULL,
  `dst_column_id` int NOT NULL,
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
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `column_has_restrictions` (
  `restriction_id` int NOT NULL AUTO_INCREMENT,
  `project_id` int NOT NULL,
  `role_id` int NOT NULL,
  `column_id` int NOT NULL,
  `rule` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
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
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `columns` (
  `id` int NOT NULL AUTO_INCREMENT,
  `title` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `position` int NOT NULL,
  `project_id` int NOT NULL,
  `task_limit` int DEFAULT '0',
  `description` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `hide_in_dashboard` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_title_project` (`title`,`project_id`),
  KEY `columns_project_idx` (`project_id`),
  CONSTRAINT `columns_ibfk_1` FOREIGN KEY (`project_id`) REFERENCES `projects` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `columns`
--

LOCK TABLES `columns` WRITE;
/*!40000 ALTER TABLE `columns` DISABLE KEYS */;
INSERT INTO `columns` VALUES (1,'In Review',2,1,0,'',0),(2,'Planned',3,1,0,'',0),(3,'In Progress',4,1,0,'',0),(4,'Complete',5,1,0,'',0),(5,'Feedback',1,1,0,'',0),(6,'Changelog',6,1,0,'',0);
/*!40000 ALTER TABLE `columns` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `comments`
--

DROP TABLE IF EXISTS `comments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `comments` (
  `id` int NOT NULL AUTO_INCREMENT,
  `task_id` int NOT NULL,
  `user_id` int DEFAULT '0',
  `date_creation` bigint DEFAULT NULL,
  `comment` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `reference` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '',
  `date_modification` bigint DEFAULT NULL,
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
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `currencies` (
  `currency` char(3) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
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
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `custom_filters` (
  `id` int NOT NULL AUTO_INCREMENT,
  `filter` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `project_id` int NOT NULL,
  `user_id` int NOT NULL,
  `name` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
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
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `group_has_users` (
  `group_id` int NOT NULL,
  `user_id` int NOT NULL,
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
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `groups` (
  `id` int NOT NULL AUTO_INCREMENT,
  `external_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '',
  `name` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
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
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `invites` (
  `email` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `project_id` int NOT NULL,
  `token` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
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
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `last_logins` (
  `id` int NOT NULL AUTO_INCREMENT,
  `auth_type` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_id` int DEFAULT NULL,
  `ip` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_agent` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `date_creation` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `last_logins_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `last_logins`
--

LOCK TABLES `last_logins` WRITE;
/*!40000 ALTER TABLE `last_logins` DISABLE KEYS */;
INSERT INTO `last_logins` VALUES (1,'Database',1,'172.70.230.132','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/121.0.0.0 Safari/537.36',1706602239),(2,'RememberMe',1,'162.158.155.196','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/121.0.0.0 Safari/537.36',1707016122),(3,'Database',1,'192.168.33.1','Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:109.0) Gecko/20100101 Firefox/115.0',1709211644),(4,'Database',1,'192.168.33.1','Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:133.0) Gecko/20100101 Firefox/133.0',1736950567),(5,'RememberMe',1,'192.168.33.1','Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:133.0) Gecko/20100101 Firefox/133.0',1737003500),(6,'RememberMe',1,'192.168.33.1','Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:133.0) Gecko/20100101 Firefox/133.0',1737003500),(7,'Database',1,'192.168.33.1','Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:133.0) Gecko/20100101 Firefox/133.0',1742378686),(8,'RememberMe',1,'192.168.33.1','Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:133.0) Gecko/20100101 Firefox/133.0',1742459802);
/*!40000 ALTER TABLE `last_logins` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `links`
--

DROP TABLE IF EXISTS `links`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `links` (
  `id` int NOT NULL AUTO_INCREMENT,
  `label` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `opposite_id` int DEFAULT '0',
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
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `password_reset` (
  `token` varchar(80) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` int NOT NULL,
  `date_expiration` int NOT NULL,
  `date_creation` int NOT NULL,
  `ip` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_agent` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
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
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `plugin_schema_versions` (
  `plugin` varchar(80) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `version` int NOT NULL DEFAULT '0',
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
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `predefined_task_descriptions` (
  `id` int NOT NULL AUTO_INCREMENT,
  `project_id` int NOT NULL,
  `title` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
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
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `project_activities` (
  `id` int NOT NULL AUTO_INCREMENT,
  `date_creation` bigint DEFAULT NULL,
  `event_name` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `creator_id` int DEFAULT NULL,
  `project_id` int DEFAULT NULL,
  `task_id` int DEFAULT NULL,
  `data` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`id`),
  KEY `creator_id` (`creator_id`),
  KEY `project_id` (`project_id`),
  KEY `task_id` (`task_id`),
  CONSTRAINT `project_activities_ibfk_1` FOREIGN KEY (`creator_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `project_activities_ibfk_2` FOREIGN KEY (`project_id`) REFERENCES `projects` (`id`) ON DELETE CASCADE,
  CONSTRAINT `project_activities_ibfk_3` FOREIGN KEY (`task_id`) REFERENCES `tasks` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `project_activities`
--

LOCK TABLES `project_activities` WRITE;
/*!40000 ALTER TABLE `project_activities` DISABLE KEYS */;
INSERT INTO `project_activities` VALUES (4,1736956307,'task.create',1,1,2,'{\"task_id\":2,\"task\":{\"id\":2,\"title\":\"Remove robot valid\",\"description\":\"\",\"date_creation\":1736956307,\"date_completed\":null,\"date_due\":0,\"color_id\":\"yellow\",\"project_id\":1,\"column_id\":1,\"owner_id\":0,\"position\":2,\"score\":0,\"is_active\":1,\"category_id\":0,\"creator_id\":1,\"date_modification\":1736956307,\"reference\":\"\",\"date_started\":0,\"time_spent\":0,\"time_estimated\":0,\"swimlane_id\":1,\"date_moved\":1736956307,\"recurrence_status\":0,\"recurrence_trigger\":0,\"recurrence_factor\":0,\"recurrence_timeframe\":0,\"recurrence_basedate\":0,\"recurrence_parent\":null,\"recurrence_child\":null,\"priority\":0,\"external_provider\":null,\"external_uri\":null,\"category_name\":null,\"swimlane_name\":\"Default swimlane\",\"project_name\":\"Roadmap\",\"column_title\":\"In Review\",\"assignee_username\":null,\"assignee_name\":null,\"creator_username\":\"admin\",\"creator_name\":null,\"category_description\":null,\"column_position\":1}}'),(5,1737003519,'task.create',1,1,3,'{\"task_id\":3,\"task\":{\"id\":3,\"title\":\"test\",\"description\":\"\",\"date_creation\":1737003518,\"date_completed\":null,\"date_due\":0,\"color_id\":\"yellow\",\"project_id\":1,\"column_id\":2,\"owner_id\":0,\"position\":1,\"score\":0,\"is_active\":1,\"category_id\":0,\"creator_id\":1,\"date_modification\":1737003518,\"reference\":\"\",\"date_started\":0,\"time_spent\":0,\"time_estimated\":0,\"swimlane_id\":1,\"date_moved\":1737003518,\"recurrence_status\":0,\"recurrence_trigger\":0,\"recurrence_factor\":0,\"recurrence_timeframe\":0,\"recurrence_basedate\":0,\"recurrence_parent\":null,\"recurrence_child\":null,\"priority\":0,\"external_provider\":null,\"external_uri\":null,\"category_name\":null,\"swimlane_name\":\"Default swimlane\",\"project_name\":\"Roadmap\",\"column_title\":\"Planned\",\"assignee_username\":null,\"assignee_name\":null,\"creator_username\":\"admin\",\"creator_name\":null,\"category_description\":null,\"column_position\":2}}'),(6,1737003525,'task.move.column',1,1,2,'{\"task_id\":2,\"task\":{\"id\":2,\"title\":\"Remove robot valid\",\"description\":\"\",\"date_creation\":1736956307,\"date_completed\":null,\"date_due\":0,\"color_id\":\"yellow\",\"project_id\":1,\"column_id\":3,\"owner_id\":0,\"position\":1,\"score\":5,\"is_active\":1,\"category_id\":0,\"creator_id\":1,\"date_modification\":1737003525,\"reference\":\"\",\"date_started\":0,\"time_spent\":0,\"time_estimated\":0,\"swimlane_id\":1,\"date_moved\":1737003525,\"recurrence_status\":0,\"recurrence_trigger\":0,\"recurrence_factor\":0,\"recurrence_timeframe\":0,\"recurrence_basedate\":0,\"recurrence_parent\":null,\"recurrence_child\":null,\"priority\":0,\"external_provider\":null,\"external_uri\":null,\"category_name\":null,\"swimlane_name\":\"Default swimlane\",\"project_name\":\"Roadmap\",\"column_title\":\"In Progress\",\"assignee_username\":null,\"assignee_name\":null,\"creator_username\":\"admin\",\"creator_name\":null,\"category_description\":null,\"column_position\":3},\"changes\":{\"src_column_id\":1,\"dst_column_id\":\"3\",\"date_moved\":1736956307},\"project_id\":1,\"position\":1,\"column_id\":\"3\",\"swimlane_id\":\"1\",\"src_column_id\":1,\"dst_column_id\":\"3\",\"date_moved\":1736956307,\"recurrence_status\":0,\"recurrence_trigger\":0}'),(7,1737003794,'task.move.column',1,1,2,'{\"task_id\":2,\"task\":{\"id\":2,\"title\":\"Remove robot valid\",\"description\":\"\",\"date_creation\":1736956307,\"date_completed\":null,\"date_due\":0,\"color_id\":\"yellow\",\"project_id\":1,\"column_id\":2,\"owner_id\":0,\"position\":2,\"score\":5,\"is_active\":1,\"category_id\":0,\"creator_id\":1,\"date_modification\":1737003794,\"reference\":\"\",\"date_started\":0,\"time_spent\":0,\"time_estimated\":0,\"swimlane_id\":1,\"date_moved\":1737003794,\"recurrence_status\":0,\"recurrence_trigger\":0,\"recurrence_factor\":0,\"recurrence_timeframe\":0,\"recurrence_basedate\":0,\"recurrence_parent\":null,\"recurrence_child\":null,\"priority\":0,\"external_provider\":null,\"external_uri\":null,\"category_name\":null,\"swimlane_name\":\"Default swimlane\",\"project_name\":\"Roadmap\",\"column_title\":\"Planned\",\"assignee_username\":null,\"assignee_name\":null,\"creator_username\":\"admin\",\"creator_name\":null,\"category_description\":null,\"column_position\":2},\"changes\":{\"src_column_id\":3,\"dst_column_id\":\"2\",\"date_moved\":1737003525},\"project_id\":1,\"position\":2,\"column_id\":\"2\",\"swimlane_id\":\"1\",\"src_column_id\":3,\"dst_column_id\":\"2\",\"date_moved\":1737003525,\"recurrence_status\":0,\"recurrence_trigger\":0}'),(8,1737003833,'task.update',1,1,3,'{\"task_id\":3,\"task\":{\"id\":3,\"title\":\"Login with github\",\"description\":\"\",\"date_creation\":1737003518,\"date_completed\":null,\"date_due\":0,\"color_id\":\"yellow\",\"project_id\":1,\"column_id\":2,\"owner_id\":0,\"position\":1,\"score\":0,\"is_active\":1,\"category_id\":0,\"creator_id\":1,\"date_modification\":1737003833,\"reference\":\"\",\"date_started\":0,\"time_spent\":0,\"time_estimated\":0,\"swimlane_id\":1,\"date_moved\":1737003518,\"recurrence_status\":0,\"recurrence_trigger\":0,\"recurrence_factor\":0,\"recurrence_timeframe\":0,\"recurrence_basedate\":0,\"recurrence_parent\":null,\"recurrence_child\":null,\"priority\":0,\"external_provider\":null,\"external_uri\":null,\"category_name\":null,\"swimlane_name\":\"Default swimlane\",\"project_name\":\"Roadmap\",\"column_title\":\"Planned\",\"assignee_username\":null,\"assignee_name\":null,\"creator_username\":\"admin\",\"creator_name\":null,\"category_description\":null,\"column_position\":2},\"changes\":{\"title\":\"Login with github\"}}'),(9,1737003840,'task.update',1,1,3,'{\"task_id\":3,\"task\":{\"id\":3,\"title\":\"Login with github\",\"description\":\"testsetestestest\",\"date_creation\":1737003518,\"date_completed\":null,\"date_due\":0,\"color_id\":\"yellow\",\"project_id\":1,\"column_id\":2,\"owner_id\":0,\"position\":1,\"score\":0,\"is_active\":1,\"category_id\":0,\"creator_id\":1,\"date_modification\":1737003840,\"reference\":\"\",\"date_started\":0,\"time_spent\":0,\"time_estimated\":0,\"swimlane_id\":1,\"date_moved\":1737003518,\"recurrence_status\":0,\"recurrence_trigger\":0,\"recurrence_factor\":0,\"recurrence_timeframe\":0,\"recurrence_basedate\":0,\"recurrence_parent\":null,\"recurrence_child\":null,\"priority\":0,\"external_provider\":null,\"external_uri\":null,\"category_name\":null,\"swimlane_name\":\"Default swimlane\",\"project_name\":\"Roadmap\",\"column_title\":\"Planned\",\"assignee_username\":null,\"assignee_name\":null,\"creator_username\":\"admin\",\"creator_name\":null,\"category_description\":null,\"column_position\":2},\"changes\":{\"description\":\"testsetestestest\"}}'),(10,1737007262,'task.move.column',1,1,2,'{\"task_id\":2,\"task\":{\"id\":2,\"title\":\"Remove robot valid\",\"description\":\"\",\"date_creation\":1736956307,\"date_completed\":null,\"date_due\":0,\"color_id\":\"yellow\",\"project_id\":1,\"column_id\":4,\"owner_id\":0,\"position\":1,\"score\":5,\"is_active\":1,\"category_id\":0,\"creator_id\":1,\"date_modification\":1737007262,\"reference\":\"\",\"date_started\":0,\"time_spent\":0,\"time_estimated\":0,\"swimlane_id\":1,\"date_moved\":1737007262,\"recurrence_status\":0,\"recurrence_trigger\":0,\"recurrence_factor\":0,\"recurrence_timeframe\":0,\"recurrence_basedate\":0,\"recurrence_parent\":null,\"recurrence_child\":null,\"priority\":0,\"external_provider\":null,\"external_uri\":null,\"category_name\":null,\"swimlane_name\":\"Default swimlane\",\"project_name\":\"Roadmap\",\"column_title\":\"Complete\",\"assignee_username\":null,\"assignee_name\":null,\"creator_username\":\"admin\",\"creator_name\":null,\"category_description\":null,\"column_position\":4},\"changes\":{\"src_column_id\":2,\"dst_column_id\":\"4\",\"date_moved\":1737003794},\"project_id\":1,\"position\":1,\"column_id\":\"4\",\"swimlane_id\":\"1\",\"src_column_id\":2,\"dst_column_id\":\"4\",\"date_moved\":1737003794,\"recurrence_status\":0,\"recurrence_trigger\":0}'),(11,1737008561,'task.update',1,1,3,'{\"task_id\":3,\"task\":{\"id\":3,\"title\":\"Login with github\",\"description\":\"test\",\"date_creation\":1737003518,\"date_completed\":null,\"date_due\":0,\"color_id\":\"yellow\",\"project_id\":1,\"column_id\":2,\"owner_id\":0,\"position\":1,\"score\":0,\"is_active\":1,\"category_id\":0,\"creator_id\":1,\"date_modification\":1737008561,\"reference\":\"\",\"date_started\":0,\"time_spent\":0,\"time_estimated\":0,\"swimlane_id\":1,\"date_moved\":1737003518,\"recurrence_status\":0,\"recurrence_trigger\":0,\"recurrence_factor\":0,\"recurrence_timeframe\":0,\"recurrence_basedate\":0,\"recurrence_parent\":null,\"recurrence_child\":null,\"priority\":0,\"external_provider\":null,\"external_uri\":null,\"category_name\":null,\"swimlane_name\":\"Default swimlane\",\"project_name\":\"Roadmap\",\"column_title\":\"Planned\",\"assignee_username\":null,\"assignee_name\":null,\"creator_username\":\"admin\",\"creator_name\":null,\"category_description\":null,\"column_position\":2},\"changes\":{\"description\":\"test\"}}'),(12,1737008621,'task.update',1,1,3,'{\"task_id\":3,\"task\":{\"id\":3,\"title\":\"Login with github\",\"description\":\"test\",\"date_creation\":1737003518,\"date_completed\":null,\"date_due\":0,\"color_id\":\"yellow\",\"project_id\":1,\"column_id\":2,\"owner_id\":0,\"position\":1,\"score\":0,\"is_active\":1,\"category_id\":0,\"creator_id\":1,\"date_modification\":1737008621,\"reference\":\"\",\"date_started\":0,\"time_spent\":85,\"time_estimated\":100,\"swimlane_id\":1,\"date_moved\":1737003518,\"recurrence_status\":0,\"recurrence_trigger\":0,\"recurrence_factor\":0,\"recurrence_timeframe\":0,\"recurrence_basedate\":0,\"recurrence_parent\":null,\"recurrence_child\":null,\"priority\":0,\"external_provider\":null,\"external_uri\":null,\"category_name\":null,\"swimlane_name\":\"Default swimlane\",\"project_name\":\"Roadmap\",\"column_title\":\"Planned\",\"assignee_username\":null,\"assignee_name\":null,\"creator_username\":\"admin\",\"creator_name\":null,\"category_description\":null,\"column_position\":2},\"changes\":{\"time_estimated\":\"100\",\"time_spent\":\"85\"}}'),(13,1737009064,'task.move.column',1,1,2,'{\"task_id\":2,\"task\":{\"id\":2,\"title\":\"Remove robot valid\",\"description\":\"\",\"date_creation\":1736956307,\"date_completed\":null,\"date_due\":0,\"color_id\":\"yellow\",\"project_id\":1,\"column_id\":3,\"owner_id\":0,\"position\":1,\"score\":5,\"is_active\":1,\"category_id\":0,\"creator_id\":1,\"date_modification\":1737009064,\"reference\":\"\",\"date_started\":0,\"time_spent\":0,\"time_estimated\":0,\"swimlane_id\":1,\"date_moved\":1737009064,\"recurrence_status\":0,\"recurrence_trigger\":0,\"recurrence_factor\":0,\"recurrence_timeframe\":0,\"recurrence_basedate\":0,\"recurrence_parent\":null,\"recurrence_child\":null,\"priority\":0,\"external_provider\":null,\"external_uri\":null,\"category_name\":null,\"swimlane_name\":\"Default swimlane\",\"project_name\":\"Roadmap\",\"column_title\":\"In Progress\",\"assignee_username\":null,\"assignee_name\":null,\"creator_username\":\"admin\",\"creator_name\":null,\"category_description\":null,\"column_position\":3},\"changes\":{\"src_column_id\":4,\"dst_column_id\":\"3\",\"date_moved\":1737007262},\"project_id\":1,\"position\":1,\"column_id\":\"3\",\"swimlane_id\":\"1\",\"src_column_id\":4,\"dst_column_id\":\"3\",\"date_moved\":1737007262,\"recurrence_status\":0,\"recurrence_trigger\":0}'),(14,1737009232,'task.update',1,1,2,'{\"task_id\":2,\"task\":{\"id\":2,\"title\":\"Optimize the process of adding custom domain names\",\"description\":\"\",\"date_creation\":1736956307,\"date_completed\":null,\"date_due\":0,\"color_id\":\"yellow\",\"project_id\":1,\"column_id\":3,\"owner_id\":0,\"position\":1,\"score\":5,\"is_active\":1,\"category_id\":0,\"creator_id\":1,\"date_modification\":1737009232,\"reference\":\"\",\"date_started\":0,\"time_spent\":10,\"time_estimated\":100,\"swimlane_id\":1,\"date_moved\":1737009064,\"recurrence_status\":0,\"recurrence_trigger\":0,\"recurrence_factor\":0,\"recurrence_timeframe\":0,\"recurrence_basedate\":0,\"recurrence_parent\":null,\"recurrence_child\":null,\"priority\":2,\"external_provider\":null,\"external_uri\":null,\"category_name\":null,\"swimlane_name\":\"Default swimlane\",\"project_name\":\"Roadmap\",\"column_title\":\"In Progress\",\"assignee_username\":null,\"assignee_name\":null,\"creator_username\":\"admin\",\"creator_name\":null,\"category_description\":null,\"column_position\":3},\"changes\":{\"title\":\"Optimize the process of adding custom domain names\",\"priority\":2,\"time_estimated\":\"100\",\"time_spent\":\"10\"}}'),(16,1737028655,'task.move.column',1,1,3,'{\"task_id\":3,\"task\":{\"id\":3,\"title\":\"Login with github\",\"description\":\"test\",\"date_creation\":1737003518,\"date_completed\":null,\"date_due\":0,\"color_id\":\"yellow\",\"project_id\":1,\"column_id\":4,\"owner_id\":0,\"position\":1,\"score\":1,\"is_active\":1,\"category_id\":0,\"creator_id\":1,\"date_modification\":1737028655,\"reference\":\"\",\"date_started\":0,\"time_spent\":85,\"time_estimated\":100,\"swimlane_id\":1,\"date_moved\":1737028655,\"recurrence_status\":0,\"recurrence_trigger\":0,\"recurrence_factor\":0,\"recurrence_timeframe\":0,\"recurrence_basedate\":0,\"recurrence_parent\":null,\"recurrence_child\":null,\"priority\":0,\"external_provider\":null,\"external_uri\":null,\"category_name\":null,\"swimlane_name\":\"Default swimlane\",\"project_name\":\"Roadmap\",\"column_title\":\"Complete\",\"assignee_username\":null,\"assignee_name\":null,\"creator_username\":\"admin\",\"creator_name\":null,\"category_description\":null,\"column_position\":4},\"changes\":{\"src_column_id\":2,\"dst_column_id\":\"4\",\"date_moved\":1737003518},\"project_id\":1,\"position\":1,\"column_id\":\"4\",\"swimlane_id\":\"1\",\"src_column_id\":2,\"dst_column_id\":\"4\",\"date_moved\":1737003518,\"recurrence_status\":0,\"recurrence_trigger\":0}'),(17,1742385808,'task.create',1,1,4,'{\"task_id\":4,\"task\":{\"id\":4,\"title\":\"V1.0.1 New Features & Bug Fixes\",\"description\":\"New Features\\r\\n- Added user authentication system\\r\\n- Implemented email notifications for feedback updates\\r\\n\\r\\nBug Fixes\\r\\n- Fixed sorting issues in feedback list\\r\\n- Resolved mobile responsive layout issues\",\"date_creation\":1742385808,\"date_completed\":null,\"date_due\":0,\"color_id\":\"yellow\",\"project_id\":1,\"column_id\":6,\"owner_id\":0,\"position\":1,\"score\":0,\"is_active\":1,\"category_id\":0,\"creator_id\":1,\"date_modification\":1742385808,\"reference\":\"\",\"date_started\":0,\"time_spent\":0,\"time_estimated\":0,\"swimlane_id\":1,\"date_moved\":1742385808,\"recurrence_status\":0,\"recurrence_trigger\":0,\"recurrence_factor\":0,\"recurrence_timeframe\":0,\"recurrence_basedate\":0,\"recurrence_parent\":null,\"recurrence_child\":null,\"priority\":0,\"external_provider\":null,\"external_uri\":null,\"category_name\":null,\"swimlane_name\":\"Default swimlane\",\"project_name\":\"Roadmap\",\"column_title\":\"Changelog\",\"assignee_username\":null,\"assignee_name\":null,\"creator_username\":\"admin\",\"creator_name\":null,\"category_description\":null,\"column_position\":6}}'),(18,1742385819,'task.update',1,1,4,'{\"task_id\":4,\"task\":{\"id\":4,\"title\":\"V1.0.1 New Features & Bug Fixes\",\"description\":\"New Features\\r\\n- Added user authentication system\\r\\n- Implemented email notifications for feedback updates\\r\\n\\r\\nBug Fixes\\r\\n- Fixed sorting issues in feedback list\\r\\n- Resolved mobile responsive layout issues\",\"date_creation\":1742385808,\"date_completed\":null,\"date_due\":0,\"color_id\":\"yellow\",\"project_id\":1,\"column_id\":6,\"owner_id\":0,\"position\":1,\"score\":0,\"is_active\":1,\"category_id\":0,\"creator_id\":1,\"date_modification\":1742385819,\"reference\":\"\",\"date_started\":1742342400,\"time_spent\":0,\"time_estimated\":0,\"swimlane_id\":1,\"date_moved\":1742385808,\"recurrence_status\":0,\"recurrence_trigger\":0,\"recurrence_factor\":0,\"recurrence_timeframe\":0,\"recurrence_basedate\":0,\"recurrence_parent\":null,\"recurrence_child\":null,\"priority\":0,\"external_provider\":null,\"external_uri\":null,\"category_name\":null,\"swimlane_name\":\"Default swimlane\",\"project_name\":\"Roadmap\",\"column_title\":\"Changelog\",\"assignee_username\":null,\"assignee_name\":null,\"creator_username\":\"admin\",\"creator_name\":null,\"category_description\":null,\"column_position\":6},\"changes\":{\"date_started\":1742342400}}'),(19,1742459940,'task.update',1,1,4,'{\"task_id\":4,\"task\":{\"id\":4,\"title\":\"V1.0.1 New Features & Bug Fixes\",\"description\":\"New Features\\r\\n- Added user authentication system\\r\\n- Implemented email notifications for feedback updates\\r\\n\\r\\nBug Fixes\\r\\n- Fixed sorting issues in feedback list\\r\\n- Resolved mobile responsive layout issues\",\"date_creation\":1742385808,\"date_completed\":null,\"date_due\":0,\"color_id\":\"blue\",\"project_id\":1,\"column_id\":6,\"owner_id\":0,\"position\":1,\"score\":0,\"is_active\":1,\"category_id\":0,\"creator_id\":1,\"date_modification\":1742459940,\"reference\":\"\",\"date_started\":1742342400,\"time_spent\":0,\"time_estimated\":0,\"swimlane_id\":1,\"date_moved\":1742385808,\"recurrence_status\":0,\"recurrence_trigger\":0,\"recurrence_factor\":0,\"recurrence_timeframe\":0,\"recurrence_basedate\":0,\"recurrence_parent\":null,\"recurrence_child\":null,\"priority\":0,\"external_provider\":null,\"external_uri\":null,\"category_name\":null,\"swimlane_name\":\"Default swimlane\",\"project_name\":\"Roadmap\",\"column_title\":\"Changelog\",\"assignee_username\":null,\"assignee_name\":null,\"creator_username\":\"admin\",\"creator_name\":null,\"category_description\":null,\"column_position\":6},\"changes\":{\"color_id\":\"blue\"}}'),(20,1742459957,'task.update',1,1,8,'{\"task_id\":8,\"task\":{\"id\":8,\"title\":\"This is a first feedback\",\"description\":\"\",\"date_creation\":1742387935,\"date_completed\":null,\"date_due\":0,\"color_id\":\"green\",\"project_id\":1,\"column_id\":5,\"owner_id\":0,\"position\":null,\"score\":0,\"is_active\":1,\"category_id\":0,\"creator_id\":0,\"date_modification\":1742459957,\"reference\":\"\",\"date_started\":0,\"time_spent\":0,\"time_estimated\":0,\"swimlane_id\":1,\"date_moved\":null,\"recurrence_status\":0,\"recurrence_trigger\":0,\"recurrence_factor\":0,\"recurrence_timeframe\":0,\"recurrence_basedate\":0,\"recurrence_parent\":null,\"recurrence_child\":null,\"priority\":0,\"external_provider\":null,\"external_uri\":null,\"category_name\":null,\"swimlane_name\":\"Default swimlane\",\"project_name\":\"Roadmap\",\"column_title\":\"Feedback\",\"assignee_username\":null,\"assignee_name\":null,\"creator_username\":null,\"creator_name\":null,\"category_description\":null,\"column_position\":1},\"changes\":{\"color_id\":\"green\",\"date_due\":0,\"date_started\":0,\"score\":0}}'),(21,1742460646,'task.update',1,1,8,'{\"task_id\":8,\"task\":{\"id\":8,\"title\":\"This is a first feedback\",\"description\":\"\",\"date_creation\":1742387935,\"date_completed\":null,\"date_due\":0,\"color_id\":\"green\",\"project_id\":1,\"column_id\":5,\"owner_id\":0,\"position\":null,\"score\":0,\"is_active\":1,\"category_id\":0,\"creator_id\":0,\"date_modification\":1742460646,\"reference\":\"\",\"date_started\":1742378400,\"time_spent\":0,\"time_estimated\":0,\"swimlane_id\":1,\"date_moved\":null,\"recurrence_status\":0,\"recurrence_trigger\":0,\"recurrence_factor\":0,\"recurrence_timeframe\":0,\"recurrence_basedate\":0,\"recurrence_parent\":null,\"recurrence_child\":null,\"priority\":0,\"external_provider\":null,\"external_uri\":null,\"category_name\":null,\"swimlane_name\":\"Default swimlane\",\"project_name\":\"Roadmap\",\"column_title\":\"Feedback\",\"assignee_username\":null,\"assignee_name\":null,\"creator_username\":null,\"creator_name\":null,\"category_description\":null,\"column_position\":1},\"changes\":{\"date_started\":1742378400}}');
/*!40000 ALTER TABLE `project_activities` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `project_daily_column_stats`
--

DROP TABLE IF EXISTS `project_daily_column_stats`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `project_daily_column_stats` (
  `id` int NOT NULL AUTO_INCREMENT,
  `day` char(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `project_id` int NOT NULL,
  `column_id` int NOT NULL,
  `total` int NOT NULL DEFAULT '0',
  `score` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `project_daily_column_stats_idx` (`day`,`project_id`,`column_id`),
  KEY `column_id` (`column_id`),
  KEY `project_id` (`project_id`),
  CONSTRAINT `project_daily_column_stats_ibfk_1` FOREIGN KEY (`column_id`) REFERENCES `columns` (`id`) ON DELETE CASCADE,
  CONSTRAINT `project_daily_column_stats_ibfk_2` FOREIGN KEY (`project_id`) REFERENCES `projects` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=54 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `project_daily_column_stats`
--

LOCK TABLES `project_daily_column_stats` WRITE;
/*!40000 ALTER TABLE `project_daily_column_stats` DISABLE KEYS */;
INSERT INTO `project_daily_column_stats` VALUES (3,'2025-01-15',1,1,2,0),(33,'2025-01-16',1,1,1,4),(34,'2025-01-16',1,3,1,5),(35,'2025-01-16',1,4,1,1),(39,'2025-03-19',1,3,1,5),(40,'2025-03-19',1,4,1,1),(41,'2025-03-19',1,6,1,0),(50,'2025-03-20',1,3,1,5),(51,'2025-03-20',1,4,1,1),(52,'2025-03-20',1,6,1,0),(53,'2025-03-20',1,5,1,0);
/*!40000 ALTER TABLE `project_daily_column_stats` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `project_daily_stats`
--

DROP TABLE IF EXISTS `project_daily_stats`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `project_daily_stats` (
  `id` int NOT NULL AUTO_INCREMENT,
  `day` char(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `project_id` int NOT NULL,
  `avg_lead_time` int NOT NULL DEFAULT '0',
  `avg_cycle_time` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `project_daily_stats_idx` (`day`,`project_id`),
  KEY `project_id` (`project_id`),
  CONSTRAINT `project_daily_stats_ibfk_1` FOREIGN KEY (`project_id`) REFERENCES `projects` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `project_daily_stats`
--

LOCK TABLES `project_daily_stats` WRITE;
/*!40000 ALTER TABLE `project_daily_stats` DISABLE KEYS */;
INSERT INTO `project_daily_stats` VALUES (3,'2025-01-15',1,2711,0),(15,'2025-01-16',1,58418,0),(17,'2025-03-19',1,3603941,14473),(20,'2025-03-20',1,2777254,50123);
/*!40000 ALTER TABLE `project_daily_stats` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `project_has_categories`
--

DROP TABLE IF EXISTS `project_has_categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `project_has_categories` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `project_id` int NOT NULL,
  `description` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `color_id` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
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
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `project_has_files` (
  `id` int NOT NULL AUTO_INCREMENT,
  `project_id` int NOT NULL,
  `name` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `path` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `is_image` tinyint(1) DEFAULT '0',
  `size` int NOT NULL DEFAULT '0',
  `user_id` int NOT NULL DEFAULT '0',
  `date` int NOT NULL DEFAULT '0',
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
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `project_has_groups` (
  `group_id` int NOT NULL,
  `project_id` int NOT NULL,
  `role` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
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
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `project_has_metadata` (
  `project_id` int NOT NULL,
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '',
  `changed_by` int NOT NULL DEFAULT '0',
  `changed_on` int NOT NULL DEFAULT '0',
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
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `project_has_notification_types` (
  `id` int NOT NULL AUTO_INCREMENT,
  `project_id` int NOT NULL,
  `notification_type` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
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
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `project_has_roles` (
  `role_id` int NOT NULL AUTO_INCREMENT,
  `role` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `project_id` int NOT NULL,
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
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `project_has_users` (
  `project_id` int NOT NULL,
  `user_id` int NOT NULL,
  `role` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
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
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `project_role_has_restrictions` (
  `restriction_id` int NOT NULL AUTO_INCREMENT,
  `project_id` int NOT NULL,
  `role_id` int NOT NULL,
  `rule` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
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
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `projects` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `is_active` tinyint DEFAULT '1',
  `token` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `last_modified` bigint DEFAULT NULL,
  `is_public` tinyint(1) DEFAULT '0',
  `is_private` tinyint(1) DEFAULT '0',
  `description` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `identifier` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '',
  `start_date` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '',
  `end_date` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '',
  `owner_id` int DEFAULT '0',
  `priority_default` int DEFAULT '0',
  `priority_start` int DEFAULT '0',
  `priority_end` int DEFAULT '3',
  `email` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `predefined_email_subjects` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `per_swimlane_task_limits` int NOT NULL DEFAULT '0',
  `task_limit` int DEFAULT '0',
  `enable_global_tags` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `projects`
--

LOCK TABLES `projects` WRITE;
/*!40000 ALTER TABLE `projects` DISABLE KEYS */;
INSERT INTO `projects` VALUES (1,'Roadmap',1,'',1742460646,0,0,NULL,'ROADMAP','','',1,0,0,3,NULL,NULL,0,0,1);
/*!40000 ALTER TABLE `projects` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `remember_me`
--

DROP TABLE IF EXISTS `remember_me`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `remember_me` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int DEFAULT NULL,
  `ip` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_agent` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `token` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `sequence` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `expiration` int DEFAULT NULL,
  `date_creation` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `remember_me_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `remember_me`
--

LOCK TABLES `remember_me` WRITE;
/*!40000 ALTER TABLE `remember_me` DISABLE KEYS */;
INSERT INTO `remember_me` VALUES (2,1,'192.168.33.1','Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:133.0) Gecko/20100101 Firefox/133.0','e61b6dacb571b5e5585f8522f81b690b4ceb21aeb95682351dfea082ffe56b54','8d26b5d7d146273ed205b974fd7eba19259ee5f533f80e26a5c43cfc0ff1',1747562686,1742378686);
/*!40000 ALTER TABLE `remember_me` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `schema_version`
--

DROP TABLE IF EXISTS `schema_version`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `schema_version` (
  `version` int DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
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
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sessions` (
  `id` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `expire_at` int NOT NULL,
  `data` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sessions`
--

LOCK TABLES `sessions` WRITE;
/*!40000 ALTER TABLE `sessions` DISABLE KEYS */;
INSERT INTO `sessions` VALUES ('2715c88857319abe870ec2995a0bb075',1742474202,''),('2bcf650b1ed14f6397518ad6ab3074db',1742393086,'redirectAfterLogin|s:1:\"/\";csrf_key|s:64:\"950a92621cd7564a83d7944f833463a3ba6de79a4c169ad80f7d6bf19390fcb5\";hasRememberMe|b:1;'),('50b7d01e27adddd9e8112c4d12c8e524',1742394178,'csrf_key|s:64:\"950a92621cd7564a83d7944f833463a3ba6de79a4c169ad80f7d6bf19390fcb5\";hasRememberMe|b:1;user|a:24:{s:2:\"id\";i:1;s:8:\"username\";s:5:\"admin\";s:12:\"is_ldap_user\";b:0;s:4:\"name\";N;s:5:\"email\";N;s:9:\"google_id\";N;s:9:\"github_id\";N;s:21:\"notifications_enabled\";i:0;s:8:\"timezone\";N;s:8:\"language\";N;s:18:\"disable_login_form\";i:0;s:19:\"twofactor_activated\";b:0;s:16:\"twofactor_secret\";N;s:5:\"token\";s:0:\"\";s:20:\"notifications_filter\";i:4;s:15:\"nb_failed_login\";i:0;s:20:\"lock_expiration_date\";i:0;s:9:\"gitlab_id\";N;s:4:\"role\";s:9:\"app-admin\";s:9:\"is_active\";i:1;s:11:\"avatar_path\";N;s:16:\"api_access_token\";N;s:6:\"filter\";N;s:5:\"theme\";s:5:\"light\";}postAuthenticationValidated|b:0;hasSubtaskInProgress|b:0;'),('97ede0d356ac9b4da57a211e114f0615',1742412760,'csrf_key|s:64:\"950a92621cd7564a83d7944f833463a3ba6de79a4c169ad80f7d6bf19390fcb5\";hasRememberMe|b:1;user|a:24:{s:2:\"id\";i:1;s:8:\"username\";s:5:\"admin\";s:12:\"is_ldap_user\";b:0;s:4:\"name\";N;s:5:\"email\";N;s:9:\"google_id\";N;s:9:\"github_id\";N;s:21:\"notifications_enabled\";i:0;s:8:\"timezone\";N;s:8:\"language\";N;s:18:\"disable_login_form\";i:0;s:19:\"twofactor_activated\";b:0;s:16:\"twofactor_secret\";N;s:5:\"token\";s:0:\"\";s:20:\"notifications_filter\";i:4;s:15:\"nb_failed_login\";i:0;s:20:\"lock_expiration_date\";i:0;s:9:\"gitlab_id\";N;s:4:\"role\";s:9:\"app-admin\";s:9:\"is_active\";i:1;s:11:\"avatar_path\";N;s:16:\"api_access_token\";N;s:6:\"filter\";N;s:5:\"theme\";s:5:\"light\";}postAuthenticationValidated|b:0;hasSubtaskInProgress|b:0;flash|a:0:{}filters:1|s:11:\"status:open\";pcsrf_key|s:64:\"414be38bbaa1e4ee10fd93a8adb101aa1ab7553c5ff84a4853f789a33bfc3aec\";'),('afcd9cfb70c0e91436597748650288b2',1742394178,'csrf_key|s:64:\"950a92621cd7564a83d7944f833463a3ba6de79a4c169ad80f7d6bf19390fcb5\";hasRememberMe|b:1;user|a:24:{s:2:\"id\";i:1;s:8:\"username\";s:5:\"admin\";s:12:\"is_ldap_user\";b:0;s:4:\"name\";N;s:5:\"email\";N;s:9:\"google_id\";N;s:9:\"github_id\";N;s:21:\"notifications_enabled\";i:0;s:8:\"timezone\";N;s:8:\"language\";N;s:18:\"disable_login_form\";i:0;s:19:\"twofactor_activated\";b:0;s:16:\"twofactor_secret\";N;s:5:\"token\";s:0:\"\";s:20:\"notifications_filter\";i:4;s:15:\"nb_failed_login\";i:0;s:20:\"lock_expiration_date\";i:0;s:9:\"gitlab_id\";N;s:4:\"role\";s:9:\"app-admin\";s:9:\"is_active\";i:1;s:11:\"avatar_path\";N;s:16:\"api_access_token\";N;s:6:\"filter\";N;s:5:\"theme\";s:5:\"light\";}postAuthenticationValidated|b:0;hasSubtaskInProgress|b:0;'),('d573e4757731e8d72f3dd80abb5254f2',1742477737,'user|a:24:{s:2:\"id\";i:1;s:8:\"username\";s:5:\"admin\";s:12:\"is_ldap_user\";b:0;s:4:\"name\";N;s:5:\"email\";N;s:9:\"google_id\";N;s:9:\"github_id\";N;s:21:\"notifications_enabled\";i:0;s:8:\"timezone\";N;s:8:\"language\";N;s:18:\"disable_login_form\";i:0;s:19:\"twofactor_activated\";b:0;s:16:\"twofactor_secret\";N;s:5:\"token\";s:0:\"\";s:20:\"notifications_filter\";i:4;s:15:\"nb_failed_login\";i:0;s:20:\"lock_expiration_date\";i:0;s:9:\"gitlab_id\";N;s:4:\"role\";s:9:\"app-admin\";s:9:\"is_active\";i:1;s:11:\"avatar_path\";N;s:16:\"api_access_token\";N;s:6:\"filter\";N;s:5:\"theme\";s:5:\"light\";}postAuthenticationValidated|b:1;hasSubtaskInProgress|b:0;filters:1|s:11:\"status:open\";pcsrf_key|s:64:\"be58fb4fa8bb4d79bb2f566f36ae3fe571043a27981e41733862475606198caf\";csrf_key|s:64:\"bb8c85b1d30e0dda0bec193386edb3b7075ff959ecce1594c1d9aa6cc694c519\";flash|a:0:{}');
/*!40000 ALTER TABLE `sessions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `settings`
--

DROP TABLE IF EXISTS `settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `settings` (
  `option` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `changed_by` int NOT NULL DEFAULT '0',
  `changed_on` int NOT NULL DEFAULT '0',
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
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `subtask_time_tracking` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `subtask_id` int NOT NULL,
  `start` bigint DEFAULT NULL,
  `end` bigint DEFAULT NULL,
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
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `subtasks` (
  `id` int NOT NULL AUTO_INCREMENT,
  `title` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` int DEFAULT '0',
  `time_estimated` float DEFAULT NULL,
  `time_spent` float DEFAULT NULL,
  `task_id` int NOT NULL,
  `user_id` int DEFAULT NULL,
  `position` int DEFAULT '1',
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
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `swimlanes` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `position` int DEFAULT '1',
  `is_active` int DEFAULT '1',
  `project_id` int DEFAULT NULL,
  `description` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `task_limit` int DEFAULT '0',
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
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tags` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `project_id` int NOT NULL,
  `color_id` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `project_id` (`project_id`,`name`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tags`
--

LOCK TABLES `tags` WRITE;
/*!40000 ALTER TABLE `tags` DISABLE KEYS */;
INSERT INTO `tags` VALUES (1,'Account',1,NULL),(2,'Functional',1,NULL),(3,'User Experience',1,NULL),(4,'General',0,NULL),(5,'Bug',0,NULL),(6,'Feature',0,NULL);
/*!40000 ALTER TABLE `tags` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `task_has_external_links`
--

DROP TABLE IF EXISTS `task_has_external_links`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `task_has_external_links` (
  `id` int NOT NULL AUTO_INCREMENT,
  `link_type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `dependency` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `title` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `url` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `date_creation` int NOT NULL,
  `date_modification` int NOT NULL,
  `task_id` int NOT NULL,
  `creator_id` int DEFAULT '0',
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
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `task_has_files` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `path` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `is_image` tinyint(1) DEFAULT '0',
  `task_id` int NOT NULL,
  `date` bigint DEFAULT NULL,
  `user_id` int NOT NULL DEFAULT '0',
  `size` int NOT NULL DEFAULT '0',
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
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `task_has_links` (
  `id` int NOT NULL AUTO_INCREMENT,
  `link_id` int NOT NULL,
  `task_id` int NOT NULL,
  `opposite_task_id` int NOT NULL,
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
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `task_has_metadata` (
  `task_id` int NOT NULL,
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '',
  `changed_by` int NOT NULL DEFAULT '0',
  `changed_on` int NOT NULL DEFAULT '0',
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
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `task_has_tags` (
  `task_id` int NOT NULL,
  `tag_id` int NOT NULL,
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
INSERT INTO `task_has_tags` VALUES (2,1),(2,3),(3,2),(8,4),(15,6);
/*!40000 ALTER TABLE `task_has_tags` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tasks`
--

DROP TABLE IF EXISTS `tasks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tasks` (
  `id` int NOT NULL AUTO_INCREMENT,
  `title` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `date_creation` bigint DEFAULT NULL,
  `date_completed` bigint DEFAULT NULL,
  `date_due` bigint DEFAULT NULL,
  `color_id` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `project_id` int NOT NULL,
  `column_id` int NOT NULL,
  `owner_id` int DEFAULT '0',
  `position` int DEFAULT NULL,
  `score` int DEFAULT NULL,
  `is_active` tinyint DEFAULT '1',
  `category_id` int DEFAULT '0',
  `creator_id` int DEFAULT '0',
  `date_modification` int DEFAULT '0',
  `reference` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '',
  `date_started` bigint DEFAULT NULL,
  `time_spent` float DEFAULT '0',
  `time_estimated` float DEFAULT '0',
  `swimlane_id` int NOT NULL,
  `date_moved` bigint DEFAULT NULL,
  `recurrence_status` int NOT NULL DEFAULT '0',
  `recurrence_trigger` int NOT NULL DEFAULT '0',
  `recurrence_factor` int NOT NULL DEFAULT '0',
  `recurrence_timeframe` int NOT NULL DEFAULT '0',
  `recurrence_basedate` int NOT NULL DEFAULT '0',
  `recurrence_parent` int DEFAULT NULL,
  `recurrence_child` int DEFAULT NULL,
  `priority` int DEFAULT '0',
  `external_provider` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `external_uri` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_task_active` (`is_active`),
  KEY `column_id` (`column_id`),
  KEY `tasks_reference_idx` (`reference`),
  KEY `tasks_project_idx` (`project_id`),
  KEY `tasks_swimlane_ibfk_1` (`swimlane_id`),
  CONSTRAINT `tasks_ibfk_1` FOREIGN KEY (`project_id`) REFERENCES `projects` (`id`) ON DELETE CASCADE,
  CONSTRAINT `tasks_ibfk_2` FOREIGN KEY (`column_id`) REFERENCES `columns` (`id`) ON DELETE CASCADE,
  CONSTRAINT `tasks_swimlane_ibfk_1` FOREIGN KEY (`swimlane_id`) REFERENCES `swimlanes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tasks`
--

LOCK TABLES `tasks` WRITE;
/*!40000 ALTER TABLE `tasks` DISABLE KEYS */;
INSERT INTO `tasks` VALUES (2,'Optimize the process of adding custom domain names','',1736956307,NULL,0,'yellow',1,3,0,1,5,1,0,1,1737009232,'',0,10,100,1,1737009064,0,0,0,0,0,NULL,NULL,2,NULL,NULL),(3,'Login with github','',1737003518,NULL,0,'yellow',1,4,0,1,1,1,0,1,1737028655,'',0,85,100,1,1737028655,0,0,0,0,0,NULL,NULL,0,NULL,NULL),(4,'V1.0.1 New Features & Bug Fixes','New Features\r\n- Added user authentication system\r\n- Implemented email notifications for feedback updates\r\n\r\nBug Fixes\r\n- Fixed sorting issues in feedback list\r\n- Resolved mobile responsive layout issues',1742385808,NULL,0,'blue',1,6,0,1,0,1,0,1,1742459940,'',1742342400,0,0,1,1742385808,0,0,0,0,0,NULL,NULL,0,NULL,NULL),(8,'This is a first feedback','',1742387935,NULL,0,'green',1,5,0,NULL,1,1,0,0,1742460646,'',1742378400,0,0,1,NULL,0,0,0,0,0,NULL,NULL,0,NULL,NULL),(15,'Add verification whether the submission is a robot','',1742461042,NULL,NULL,'green',1,5,0,NULL,NULL,1,0,0,0,'support@cloudkoonly.com',NULL,0,0,1,NULL,0,0,0,0,0,NULL,NULL,0,NULL,NULL);
/*!40000 ALTER TABLE `tasks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `transitions`
--

DROP TABLE IF EXISTS `transitions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `transitions` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `project_id` int NOT NULL,
  `task_id` int NOT NULL,
  `src_column_id` int NOT NULL,
  `dst_column_id` int NOT NULL,
  `date` bigint DEFAULT NULL,
  `time_spent` int DEFAULT '0',
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
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_has_metadata` (
  `user_id` int NOT NULL,
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '',
  `changed_by` int NOT NULL DEFAULT '0',
  `changed_on` int NOT NULL DEFAULT '0',
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
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_has_notification_types` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `notification_type` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
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
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_has_notifications` (
  `user_id` int NOT NULL,
  `project_id` int NOT NULL,
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
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_has_unread_notifications` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `date_creation` bigint NOT NULL,
  `event_name` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `event_data` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
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
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_ldap_user` tinyint(1) DEFAULT '0',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `google_id` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `github_id` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `notifications_enabled` tinyint(1) DEFAULT '0',
  `timezone` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `language` varchar(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `disable_login_form` tinyint(1) DEFAULT '0',
  `twofactor_activated` tinyint(1) DEFAULT '0',
  `twofactor_secret` char(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `token` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '',
  `notifications_filter` int DEFAULT '4',
  `nb_failed_login` int DEFAULT '0',
  `lock_expiration_date` bigint DEFAULT NULL,
  `gitlab_id` int DEFAULT NULL,
  `role` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'app-user',
  `is_active` tinyint(1) DEFAULT '1',
  `avatar_path` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `api_access_token` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `filter` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `theme` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'light',
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_username_idx` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'admin','$2y$10$vb8qkbGfkUGLpqJfXXlz1uUX1FohYpzPPqlVc3O6EcItJyAxskV9q',0,NULL,NULL,NULL,NULL,0,NULL,NULL,0,0,NULL,'',4,0,0,NULL,'app-admin',1,NULL,NULL,NULL,'light'),(2,'Anonymous','$2y$10$Gb0gOCUEXNezKscLsCyY2.hOqUlg1XrtXH5Shv8ZLfRmcGq.6iLW2',0,'Anonymous','anonymous@example.com',NULL,NULL,0,'','',1,0,NULL,'',4,0,NULL,NULL,'app-user',1,NULL,NULL,'','light');
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

-- Dump completed on 2025-03-20  9:42:31
