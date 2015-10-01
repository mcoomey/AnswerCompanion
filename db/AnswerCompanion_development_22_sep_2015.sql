-- MySQL dump 10.13  Distrib 5.6.21, for osx10.10 (x86_64)
--
-- Host: localhost    Database: AnswerCompanion_development
-- ------------------------------------------------------
-- Server version	5.6.21

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
-- Table structure for table `countries`
--

DROP TABLE IF EXISTS `countries`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `countries` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `countries`
--

LOCK TABLES `countries` WRITE;
/*!40000 ALTER TABLE `countries` DISABLE KEYS */;
INSERT INTO `countries` VALUES (1,'United States','2015-06-21 00:22:29','2015-06-21 00:22:29');
/*!40000 ALTER TABLE `countries` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `course_asset_model_types`
--

DROP TABLE IF EXISTS `course_asset_model_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `course_asset_model_types` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `name_of_model` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `course_asset_model_types`
--

LOCK TABLES `course_asset_model_types` WRITE;
/*!40000 ALTER TABLE `course_asset_model_types` DISABLE KEYS */;
INSERT INTO `course_asset_model_types` VALUES (1,'Textbooks','2014-10-22 13:40:11','2014-10-22 13:40:11','textbook_delegations'),(2,'Videos','2014-10-22 13:40:11','2014-10-22 13:40:11','videos'),(3,'Documents','2014-10-22 13:40:11','2014-10-22 13:40:11','documents'),(4,'Links','2014-10-22 13:40:11','2014-10-22 13:40:11','links'),(5,'Plain Text','2014-10-22 13:40:11','2014-10-22 13:40:11','textboxes');
/*!40000 ALTER TABLE `course_asset_model_types` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `course_assets`
--

DROP TABLE IF EXISTS `course_assets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `course_assets` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `model_type` int(11) DEFAULT NULL,
  `assetable_id` int(11) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `position` int(11) DEFAULT NULL,
  `assetable_type` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `course_assets`
--

LOCK TABLES `course_assets` WRITE;
/*!40000 ALTER TABLE `course_assets` DISABLE KEYS */;
INSERT INTO `course_assets` VALUES (1,'Textbooks',1,1,'2015-03-12 01:40:36','2015-03-12 01:40:36',1,'Course'),(2,'Videos',2,1,'2015-03-12 01:42:21','2015-03-12 01:42:21',2,'Course'),(4,'Documents',3,1,'2015-05-01 00:10:06','2015-05-01 00:10:06',3,'Course'),(6,'Textbook',1,3,'2015-05-02 01:33:21','2015-05-02 01:33:21',1,'Course'),(7,'Links',4,1,'2015-05-06 15:55:30','2015-05-06 15:55:30',4,'Course'),(8,'Plain Text',5,1,'2015-05-06 22:58:43','2015-05-06 22:58:43',5,'Course'),(10,'Textbooks',1,4,'2015-05-16 22:58:00','2015-05-16 22:58:00',1,'Course');
/*!40000 ALTER TABLE `course_assets` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `courses`
--

DROP TABLE IF EXISTS `courses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `courses` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `section` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `instructor_id` int(11) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `term` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `archived` int(11) DEFAULT NULL,
  `passphrase` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `position` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_courses_on_instructor_id` (`instructor_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `courses`
--

LOCK TABLES `courses` WRITE;
/*!40000 ALTER TABLE `courses` DISABLE KEYS */;
INSERT INTO `courses` VALUES (1,'Algebra 1','1',1,'2015-03-12 01:39:23','2015-05-07 14:00:02','A',0,'Algebra 1 rocks!',1),(2,'Empty','0',1,'2015-03-15 14:52:31','2015-05-07 14:00:02','0',0,'nothing here',2),(3,'Ruby','2',1,'2015-05-02 01:32:54','2015-05-07 14:00:02','B',0,'',3),(4,'C Programming','1',1,'2015-05-16 22:57:44','2015-05-21 18:20:31','AB',0,'This is a passphrase',4);
/*!40000 ALTER TABLE `courses` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `delayed_jobs`
--

DROP TABLE IF EXISTS `delayed_jobs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `delayed_jobs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `priority` int(11) DEFAULT '0',
  `attempts` int(11) DEFAULT '0',
  `handler` text COLLATE utf8_unicode_ci,
  `last_error` text COLLATE utf8_unicode_ci,
  `run_at` datetime DEFAULT NULL,
  `locked_at` datetime DEFAULT NULL,
  `failed_at` datetime DEFAULT NULL,
  `locked_by` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `queue` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `delayed_jobs_priority` (`priority`,`run_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `delayed_jobs`
--

LOCK TABLES `delayed_jobs` WRITE;
/*!40000 ALTER TABLE `delayed_jobs` DISABLE KEYS */;
/*!40000 ALTER TABLE `delayed_jobs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `documents`
--

DROP TABLE IF EXISTS `documents`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `documents` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `description` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `course_asset_id` int(11) DEFAULT NULL,
  `archived` int(11) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `position` int(11) DEFAULT NULL,
  `docfile` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `documents`
--

LOCK TABLES `documents` WRITE;
/*!40000 ALTER TABLE `documents` DISABLE KEYS */;
/*!40000 ALTER TABLE `documents` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `enrollments`
--

DROP TABLE IF EXISTS `enrollments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `enrollments` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `course_id` int(11) DEFAULT NULL,
  `subject_id` int(11) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `index_enrollments_on_course_id_and_subject_id` (`course_id`,`subject_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `enrollments`
--

LOCK TABLES `enrollments` WRITE;
/*!40000 ALTER TABLE `enrollments` DISABLE KEYS */;
/*!40000 ALTER TABLE `enrollments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `exercises`
--

DROP TABLE IF EXISTS `exercises`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `exercises` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `number` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `page` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `section_title_id` int(11) DEFAULT NULL,
  `textbook_id` int(11) DEFAULT NULL,
  `instructor_id` int(11) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `exercises`
--

LOCK TABLES `exercises` WRITE;
/*!40000 ALTER TABLE `exercises` DISABLE KEYS */;
INSERT INTO `exercises` VALUES (1,'1','10',1,1,1,'2014-10-22 16:49:50','2015-06-03 10:48:42'),(2,'2','13',1,1,1,'2014-10-27 11:57:46','2014-10-27 11:57:46'),(3,'3','15',1,1,1,'2014-10-27 11:58:55','2015-06-05 12:34:26'),(7,'4','15',1,1,1,'2015-06-05 23:29:38','2015-06-05 23:29:48');
/*!40000 ALTER TABLE `exercises` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `instructors`
--

DROP TABLE IF EXISTS `instructors`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `instructors` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `email` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `encrypted_password` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `reset_password_token` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `reset_password_sent_at` datetime DEFAULT NULL,
  `remember_created_at` datetime DEFAULT NULL,
  `sign_in_count` int(11) DEFAULT '0',
  `current_sign_in_at` datetime DEFAULT NULL,
  `last_sign_in_at` datetime DEFAULT NULL,
  `current_sign_in_ip` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `last_sign_in_ip` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `confirmation_token` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `confirmed_at` datetime DEFAULT NULL,
  `confirmation_sent_at` datetime DEFAULT NULL,
  `unconfirmed_email` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `failed_attempts` int(11) DEFAULT '0',
  `unlock_token` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `locked_at` datetime DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `firstname` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `lastname` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `username` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `emailpref` int(11) DEFAULT '0',
  `paypalaccount` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `privilege` int(11) DEFAULT '0',
  `grade` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `accountbalance` float DEFAULT '0',
  `violationcount` int(11) DEFAULT '0',
  `deactivated` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_instructors_on_email` (`email`),
  UNIQUE KEY `index_instructors_on_confirmation_token` (`confirmation_token`),
  UNIQUE KEY `index_instructors_on_reset_password_token` (`reset_password_token`),
  UNIQUE KEY `index_instructors_on_unlock_token` (`unlock_token`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `instructors`
--

LOCK TABLES `instructors` WRITE;
/*!40000 ALTER TABLE `instructors` DISABLE KEYS */;
INSERT INTO `instructors` VALUES (1,'mcoomey@gmail.com','$2a$10$1YXIZI71L3dwoDcdWWhSdO.Rd.yOElep4s0b1UOFC1iyVInqejVk.',NULL,NULL,NULL,51,'2015-08-13 22:51:15','2015-08-08 23:27:58','127.0.0.1','127.0.0.1',NULL,'2014-10-22 13:09:51','2014-10-22 13:09:22',NULL,0,NULL,NULL,'2014-10-22 13:09:22','2015-08-13 22:51:15','Michael','Coomey','mcoomey',0,NULL,0,NULL,0,0,0),(2,'mcoomey@charter.net','$2a$10$sAv7TclFEy55YtPoKD9jVeF5c2F4gPokxIwdjhmDbPLdF8TTfuu2C',NULL,NULL,NULL,9,'2015-09-22 17:42:20','2015-09-21 17:11:51','127.0.0.1','127.0.0.1',NULL,'2015-08-31 11:25:14','2015-08-30 18:10:17',NULL,0,NULL,NULL,'2015-08-30 18:10:17','2015-09-22 17:42:20','Michael','Coomey','mwc1',0,NULL,0,NULL,0,0,0);
/*!40000 ALTER TABLE `instructors` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lessons`
--

DROP TABLE IF EXISTS `lessons`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `lessons` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `page` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `textbook_id` int(11) DEFAULT NULL,
  `instructor_id` int(11) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lessons`
--

LOCK TABLES `lessons` WRITE;
/*!40000 ALTER TABLE `lessons` DISABLE KEYS */;
INSERT INTO `lessons` VALUES (1,'1.1 Basic Concepts','2',1,1,'2015-05-22 14:05:21','2015-06-03 16:54:02'),(2,'junk and stuff','88',1,1,'2015-05-22 14:05:52','2015-06-05 12:23:35'),(3,'new lesson','104',1,1,'2015-05-25 12:57:18','2015-05-25 12:57:18'),(7,'more junk','301',1,1,'2015-06-04 17:20:42','2015-06-04 17:21:46'),(8,'more junk','0',1,1,'2015-06-05 23:27:30','2015-06-05 23:28:01');
/*!40000 ALTER TABLE `lessons` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `links`
--

DROP TABLE IF EXISTS `links`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `links` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `description` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `url` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `course_asset_id` int(11) DEFAULT NULL,
  `archived` int(11) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `position` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `links`
--

LOCK TABLES `links` WRITE;
/*!40000 ALTER TABLE `links` DISABLE KEYS */;
INSERT INTO `links` VALUES (7,'Dynamic Test','www.dynamictest.com',17,0,'2015-06-11 19:08:49','2015-06-11 19:08:49',1),(8,'Answer Companion','www.answercompanion.com',17,0,'2015-06-11 19:09:12','2015-06-11 19:09:56',2);
/*!40000 ALTER TABLE `links` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `parent_emails`
--

DROP TABLE IF EXISTS `parent_emails`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `parent_emails` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `student_id` int(11) DEFAULT NULL,
  `email` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `index_parent_emails_on_student_id_and_email` (`student_id`,`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `parent_emails`
--

LOCK TABLES `parent_emails` WRITE;
/*!40000 ALTER TABLE `parent_emails` DISABLE KEYS */;
/*!40000 ALTER TABLE `parent_emails` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `parents`
--

DROP TABLE IF EXISTS `parents`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `parents` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `email` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `encrypted_password` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `reset_password_token` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `reset_password_sent_at` datetime DEFAULT NULL,
  `remember_created_at` datetime DEFAULT NULL,
  `sign_in_count` int(11) DEFAULT '0',
  `current_sign_in_at` datetime DEFAULT NULL,
  `last_sign_in_at` datetime DEFAULT NULL,
  `current_sign_in_ip` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `last_sign_in_ip` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `confirmation_token` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `confirmed_at` datetime DEFAULT NULL,
  `confirmation_sent_at` datetime DEFAULT NULL,
  `unconfirmed_email` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `failed_attempts` int(11) DEFAULT '0',
  `unlock_token` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `locked_at` datetime DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `firstname` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `lastname` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `deactivated` tinyint(1) DEFAULT '0',
  `username` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_parents_on_email` (`email`),
  UNIQUE KEY `index_parents_on_reset_password_token` (`reset_password_token`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `parents`
--

LOCK TABLES `parents` WRITE;
/*!40000 ALTER TABLE `parents` DISABLE KEYS */;
/*!40000 ALTER TABLE `parents` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `role_assignments`
--

DROP TABLE IF EXISTS `role_assignments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `role_assignments` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `role_id` int(11) DEFAULT NULL,
  `roleable_type` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `roleable_id` int(11) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `role_assignments`
--

LOCK TABLES `role_assignments` WRITE;
/*!40000 ALTER TABLE `role_assignments` DISABLE KEYS */;
INSERT INTO `role_assignments` VALUES (1,2,'Instructor',1,'2014-10-22 13:09:24','2014-10-22 13:09:24'),(2,2,'Instructor',2,'2015-08-10 21:15:57','2015-08-10 21:15:57'),(3,2,'Instructor',3,'2015-08-13 19:46:54','2015-08-13 19:46:54'),(4,2,'Instructor',4,'2015-08-13 22:47:11','2015-08-13 22:47:11'),(5,2,'Instructor',5,'2015-08-13 22:48:38','2015-08-13 22:48:38'),(6,2,'Instructor',2,'2015-08-15 15:59:40','2015-08-15 15:59:40'),(7,2,'Instructor',3,'2015-08-15 18:46:56','2015-08-15 18:46:56'),(8,2,'Instructor',4,'2015-08-15 20:49:36','2015-08-15 20:49:36'),(9,2,'Instructor',5,'2015-08-16 14:30:45','2015-08-16 14:30:45'),(10,2,'Instructor',6,'2015-08-17 23:24:20','2015-08-17 23:24:20'),(11,2,'Instructor',7,'2015-08-17 23:31:45','2015-08-17 23:31:45'),(12,2,'Instructor',8,'2015-08-18 02:54:39','2015-08-18 02:54:39'),(13,2,'Instructor',9,'2015-08-18 02:57:00','2015-08-18 02:57:00'),(14,2,'Instructor',10,'2015-08-18 02:58:57','2015-08-18 02:58:57'),(15,2,'Instructor',11,'2015-08-18 18:27:20','2015-08-18 18:27:20'),(16,2,'Instructor',12,'2015-08-19 11:55:36','2015-08-19 11:55:36'),(17,2,'Instructor',13,'2015-08-26 22:51:43','2015-08-26 22:51:43'),(18,2,'Instructor',14,'2015-08-26 23:08:18','2015-08-26 23:08:18'),(19,2,'Instructor',15,'2015-08-26 23:23:03','2015-08-26 23:23:03'),(20,2,'Instructor',16,'2015-08-26 23:25:15','2015-08-26 23:25:15'),(21,2,'Instructor',17,'2015-08-26 23:28:53','2015-08-26 23:28:53'),(22,2,'Instructor',18,'2015-08-26 23:34:08','2015-08-26 23:34:08'),(23,2,'Instructor',19,'2015-08-26 23:37:09','2015-08-26 23:37:09'),(24,2,'Instructor',2,'2015-08-30 18:10:17','2015-08-30 18:10:17'),(25,2,'Instructor',3,'2015-09-21 15:22:17','2015-09-21 15:22:17');
/*!40000 ALTER TABLE `role_assignments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `roles`
--

DROP TABLE IF EXISTS `roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `roles` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `roles`
--

LOCK TABLES `roles` WRITE;
/*!40000 ALTER TABLE `roles` DISABLE KEYS */;
INSERT INTO `roles` VALUES (1,'Administrator','2014-10-22 13:04:35','2014-10-22 13:04:35'),(2,'Instructor','2014-10-22 13:04:35','2014-10-22 13:04:35'),(3,'Student','2014-10-22 13:04:35','2014-10-22 13:04:35'),(4,'Parent','2014-10-22 13:04:35','2014-10-22 13:04:35');
/*!40000 ALTER TABLE `roles` ENABLE KEYS */;
UNLOCK TABLES;

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

--
-- Dumping data for table `schema_migrations`
--

LOCK TABLES `schema_migrations` WRITE;
/*!40000 ALTER TABLE `schema_migrations` DISABLE KEYS */;
INSERT INTO `schema_migrations` VALUES ('20120302232009'),('20120302232059'),('20120307181217'),('20120315183633'),('20120328200141'),('20120417204301'),('20120418160732'),('20121023121828'),('20121023121928'),('20121023122013'),('20121023122415'),('20121030180850'),('20121129191919'),('20121217134827'),('20130125131215'),('20130325203703'),('20130327182400'),('20130328004848'),('20130330202715'),('20130405003210'),('20130421160850'),('20130423155439'),('20130429154556'),('20130501203113'),('20130502171113'),('20130502174403'),('20130504003631'),('20130530173549'),('20130628172824'),('20130628181628'),('20130706120825'),('20130709174138'),('20130710183238'),('20130919200639'),('20130924153543'),('20131014124455'),('20131020144511'),('20131028225546'),('20131029113702'),('20131029113738'),('20131029121544'),('20131029122617'),('20131029180702'),('20131030184318'),('20131030223137'),('20131201155517'),('20140330174548'),('20140405173718'),('20140405175251'),('20140418152934'),('20140419204006'),('20140425145722'),('20140425180737'),('20140426232641'),('20140514174206'),('20140530173833'),('20140621200037'),('20140704142907'),('20140811185506'),('20140813123645'),('20140820190749'),('20140821144822'),('20140904192633'),('20140923134927'),('20140929150610'),('20140929150704'),('20140929150822'),('20140929151014'),('20140929151044'),('20140929151145'),('20140929171850'),('20140929171914'),('20140929174041'),('20140929174310'),('20140929183205'),('20140930234816'),('20141001152323'),('20141017001404'),('20141106141659'),('20150513232329'),('20150621000004'),('20150621000542'),('20150621001305'),('20150621124559');
/*!40000 ALTER TABLE `schema_migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `school_memberships`
--

DROP TABLE IF EXISTS `school_memberships`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `school_memberships` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `school_id` int(11) DEFAULT NULL,
  `schoolmember_id` int(11) DEFAULT NULL,
  `schoolmember_type` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `index_school_memberships_on_id_and_type` (`schoolmember_id`,`schoolmember_type`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `school_memberships`
--

LOCK TABLES `school_memberships` WRITE;
/*!40000 ALTER TABLE `school_memberships` DISABLE KEYS */;
INSERT INTO `school_memberships` VALUES (1,1,1,'Instructor','2015-07-03 11:51:56','2015-07-03 11:51:56'),(2,1,2,'Instructor','2015-09-19 23:21:49','2015-09-19 23:21:49'),(5,5,2,'Instructor','2015-09-19 23:23:33','2015-09-19 23:23:33');
/*!40000 ALTER TABLE `school_memberships` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `schools`
--

DROP TABLE IF EXISTS `schools`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `schools` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `town` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `state_id` int(11) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `schools`
--

LOCK TABLES `schools` WRITE;
/*!40000 ALTER TABLE `schools` DISABLE KEYS */;
INSERT INTO `schools` VALUES (1,'Oxford High School','Oxford',34,'2014-10-22 10:00:05','2014-10-22 10:00:05'),(5,'Wachusett Regional High School','Holden',34,'2015-09-19 23:23:33','2015-09-19 23:23:33'),(9,'New School','Newtown',25,'2015-09-20 12:26:37','2015-09-20 12:26:37');
/*!40000 ALTER TABLE `schools` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `section_titles`
--

DROP TABLE IF EXISTS `section_titles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `section_titles` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `textbook_id` int(11) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `section_titles`
--

LOCK TABLES `section_titles` WRITE;
/*!40000 ALTER TABLE `section_titles` DISABLE KEYS */;
INSERT INTO `section_titles` VALUES (1,'Chapter Summary',1,'2014-10-22 16:49:50','2014-10-22 16:49:50');
/*!40000 ALTER TABLE `section_titles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `site_assets`
--

DROP TABLE IF EXISTS `site_assets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `site_assets` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `model_type` int(11) DEFAULT NULL,
  `course_id` int(11) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `position` int(11) DEFAULT NULL,
  `type` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `site_assets`
--

LOCK TABLES `site_assets` WRITE;
/*!40000 ALTER TABLE `site_assets` DISABLE KEYS */;
INSERT INTO `site_assets` VALUES (1,'Textbooks',1,1,'2014-10-22 16:36:24','2014-10-22 16:36:24',1,NULL),(2,'Videos',2,1,'2014-10-22 23:09:05','2014-10-22 23:09:05',2,NULL),(3,'Documents',3,1,'2014-10-23 11:38:20','2014-10-23 11:38:20',3,NULL),(4,'Textboxes',5,1,'2014-10-23 19:43:58','2014-10-23 19:43:58',5,NULL),(5,'Links',4,1,'2014-10-23 20:17:18','2014-10-23 20:17:18',4,NULL);
/*!40000 ALTER TABLE `site_assets` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `states`
--

DROP TABLE IF EXISTS `states`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `states` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `abbrev` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `country_id` int(11) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=52 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `states`
--

LOCK TABLES `states` WRITE;
/*!40000 ALTER TABLE `states` DISABLE KEYS */;
INSERT INTO `states` VALUES (1,'Alabama','AL',1,'2015-06-21 18:37:14','2015-06-21 18:37:14'),(2,'Alaska','AK',1,'2015-06-21 18:37:14','2015-06-21 18:37:14'),(3,'Arizona','AZ',1,'2015-06-21 18:37:14','2015-06-21 18:37:14'),(4,'Arkansas','AR',1,'2015-06-21 18:37:14','2015-06-21 18:37:14'),(5,'California','CA',1,'2015-06-21 18:37:14','2015-06-21 18:37:14'),(6,'Colorado','CO',1,'2015-06-21 18:37:14','2015-06-21 18:37:14'),(7,'Connecticut','CT',1,'2015-06-21 18:37:14','2015-06-21 18:37:14'),(8,'Delaware','DE',1,'2015-06-21 18:37:14','2015-06-21 18:37:14'),(9,'District of Columbia','DC',1,'2015-06-21 18:37:14','2015-06-21 18:37:14'),(10,'Florida','FL',1,'2015-06-21 18:37:14','2015-06-21 18:37:14'),(11,'Georgia','GA',1,'2015-06-21 18:37:14','2015-06-21 18:37:14'),(12,'Hawaii','HI',1,'2015-06-21 18:37:14','2015-06-21 18:37:14'),(13,'Idaho','ID',1,'2015-06-21 18:37:14','2015-06-21 18:37:14'),(14,'Illinois','IL',1,'2015-06-21 18:37:14','2015-06-21 18:37:14'),(15,'Indiana','IN',1,'2015-06-21 18:37:14','2015-06-21 18:37:14'),(16,'Iowa','IA',1,'2015-06-21 18:37:14','2015-06-21 18:37:14'),(17,'Kansas','KS',1,'2015-06-21 18:37:14','2015-06-21 18:37:14'),(18,'Kentucky','KY',1,'2015-06-21 18:37:14','2015-06-21 18:37:14'),(19,'Louisiana','LA',1,'2015-06-21 18:37:14','2015-06-21 18:37:14'),(20,'Maine','ME',1,'2015-06-21 18:37:14','2015-06-21 18:37:14'),(21,'Montana','MT',1,'2015-06-21 18:37:14','2015-06-21 18:37:14'),(22,'Nebraska','NE',1,'2015-06-21 18:37:14','2015-06-21 18:37:14'),(23,'Nevada','NV',1,'2015-06-21 18:37:14','2015-06-21 18:37:14'),(24,'New Hampshire','NH',1,'2015-06-21 18:37:14','2015-06-21 18:37:14'),(25,'New Jersey','NJ',1,'2015-06-21 18:37:14','2015-06-21 18:37:14'),(26,'New Mexico','NM',1,'2015-06-21 18:37:14','2015-06-21 18:37:14'),(27,'New York','NY',1,'2015-06-21 18:37:14','2015-06-21 18:37:14'),(28,'North Carolina','NC',1,'2015-06-21 18:37:14','2015-06-21 18:37:14'),(29,'North Dakota','ND',1,'2015-06-21 18:37:14','2015-06-21 18:37:14'),(30,'Ohio','OH',1,'2015-06-21 18:37:14','2015-06-21 18:37:14'),(31,'Oklahoma','OK',1,'2015-06-21 18:37:14','2015-06-21 18:37:14'),(32,'Oregon','OR',1,'2015-06-21 18:37:14','2015-06-21 18:37:14'),(33,'Maryland','MD',1,'2015-06-21 18:37:14','2015-06-21 18:37:14'),(34,'Massachusetts','MA',1,'2015-06-21 18:37:14','2015-06-21 18:37:14'),(35,'Michigan','MI',1,'2015-06-21 18:37:14','2015-06-21 18:37:14'),(36,'Minnesota','MN',1,'2015-06-21 18:37:14','2015-06-21 18:37:14'),(37,'Mississippi','MS',1,'2015-06-21 18:37:14','2015-06-21 18:37:14'),(38,'Missouri','MO',1,'2015-06-21 18:37:14','2015-06-21 18:37:14'),(39,'Pennsylvania','PA',1,'2015-06-21 18:37:14','2015-06-21 18:37:14'),(40,'Rhode Island','RI',1,'2015-06-21 18:37:14','2015-06-21 18:37:14'),(41,'South Carolina','SC',1,'2015-06-21 18:37:14','2015-06-21 18:37:14'),(42,'South Dakota','SD',1,'2015-06-21 18:37:14','2015-06-21 18:37:14'),(43,'Tennessee','TN',1,'2015-06-21 18:37:14','2015-06-21 18:37:14'),(44,'Texas','TX',1,'2015-06-21 18:37:14','2015-06-21 18:37:14'),(45,'Utah','UT',1,'2015-06-21 18:37:14','2015-06-21 18:37:14'),(46,'Vermont','VT',1,'2015-06-21 18:37:14','2015-06-21 18:37:14'),(47,'Virginia','VA',1,'2015-06-21 18:37:14','2015-06-21 18:37:14'),(48,'Washington','WA',1,'2015-06-21 18:37:14','2015-06-21 18:37:14'),(49,'West Virginia','WV',1,'2015-06-21 18:37:14','2015-06-21 18:37:14'),(50,'Wisconsin','WI',1,'2015-06-21 18:37:14','2015-06-21 18:37:14'),(51,'Wyoming','WY',1,'2015-06-21 18:37:14','2015-06-21 18:37:14');
/*!40000 ALTER TABLE `states` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `students`
--

DROP TABLE IF EXISTS `students`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `students` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `email` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `encrypted_password` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `reset_password_token` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `reset_password_sent_at` datetime DEFAULT NULL,
  `remember_created_at` datetime DEFAULT NULL,
  `sign_in_count` int(11) DEFAULT '0',
  `current_sign_in_at` datetime DEFAULT NULL,
  `last_sign_in_at` datetime DEFAULT NULL,
  `current_sign_in_ip` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `last_sign_in_ip` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `confirmation_token` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `confirmed_at` datetime DEFAULT NULL,
  `confirmation_sent_at` datetime DEFAULT NULL,
  `unconfirmed_email` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `failed_attempts` int(11) DEFAULT '0',
  `unlock_token` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `locked_at` datetime DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `firstname` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `lastname` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `username` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `emailpref` int(11) DEFAULT '0',
  `paypalaccount` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `privilege` int(11) DEFAULT '0',
  `grade` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `accountbalance` float DEFAULT '0',
  `violationcount` int(11) DEFAULT '0',
  `deactivated` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_students_on_email` (`email`),
  UNIQUE KEY `index_students_on_confirmation_token` (`confirmation_token`),
  UNIQUE KEY `index_students_on_reset_password_token` (`reset_password_token`),
  UNIQUE KEY `index_students_on_unlock_token` (`unlock_token`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `students`
--

LOCK TABLES `students` WRITE;
/*!40000 ALTER TABLE `students` DISABLE KEYS */;
/*!40000 ALTER TABLE `students` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `subject_assets`
--

DROP TABLE IF EXISTS `subject_assets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `subject_assets` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `model_type` int(11) DEFAULT NULL,
  `subject_id` int(11) DEFAULT NULL,
  `position` int(11) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `subject_assets`
--

LOCK TABLES `subject_assets` WRITE;
/*!40000 ALTER TABLE `subject_assets` DISABLE KEYS */;
/*!40000 ALTER TABLE `subject_assets` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `subjects`
--

DROP TABLE IF EXISTS `subjects`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `subjects` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `student_id` int(11) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `archived` tinyint(1) DEFAULT NULL,
  `term` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `description` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `position` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `subjects`
--

LOCK TABLES `subjects` WRITE;
/*!40000 ALTER TABLE `subjects` DISABLE KEYS */;
/*!40000 ALTER TABLE `subjects` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `textbook_delegations`
--

DROP TABLE IF EXISTS `textbook_delegations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `textbook_delegations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `textbook_id` int(11) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `course_asset_id` int(11) DEFAULT NULL,
  `archived` int(11) DEFAULT NULL,
  `position` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_textbook_delegations_on_textable_id_and_textable_type` (`course_asset_id`),
  KEY `index_textbook_delegations_on_textbook_id_and_subject_id` (`textbook_id`)
) ENGINE=InnoDB AUTO_INCREMENT=61 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `textbook_delegations`
--

LOCK TABLES `textbook_delegations` WRITE;
/*!40000 ALTER TABLE `textbook_delegations` DISABLE KEYS */;
INSERT INTO `textbook_delegations` VALUES (43,1,'2015-05-16 18:46:31','2015-05-16 18:46:31',1,0,1),(47,8,'2015-05-16 22:56:02','2015-05-16 22:56:02',6,0,1),(48,4,'2015-05-16 22:56:21','2015-05-16 22:56:21',6,1,1),(49,4,'2015-05-16 22:58:19','2015-05-16 22:58:19',10,0,1),(58,13,'2015-06-07 13:06:04','2015-06-07 13:06:04',9,0,1),(59,8,'2015-06-10 15:54:27','2015-06-11 19:35:43',9,0,2),(60,2,'2015-07-18 00:40:20','2015-07-18 00:40:20',1,0,2);
/*!40000 ALTER TABLE `textbook_delegations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `textbook_videos`
--

DROP TABLE IF EXISTS `textbook_videos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `textbook_videos` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `videofile` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `length` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `videofile_processed` int(11) DEFAULT NULL,
  `videoable_type` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `videoable_id` int(11) DEFAULT NULL,
  `textbook_id` int(11) DEFAULT NULL,
  `instructor_id` int(11) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `old_version_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_textbook_videos_on_videoable_id_and_videoable_type` (`videoable_id`,`videoable_type`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `textbook_videos`
--

LOCK TABLES `textbook_videos` WRITE;
/*!40000 ALTER TABLE `textbook_videos` DISABLE KEYS */;
INSERT INTO `textbook_videos` VALUES (1,'small1.mp4','00:00:05.57',1,'Lesson',1,1,1,'2015-05-27 18:24:40','2015-06-02 16:51:47',NULL),(7,'small2.mp4','00:00:05.57',1,'Lesson',1,1,1,'2015-06-04 15:03:53','2015-06-04 15:04:13',NULL),(8,'small2.mp4','00:00:05.57',1,'Exercise',6,1,1,'2015-06-05 18:09:05','2015-06-05 18:09:23',NULL);
/*!40000 ALTER TABLE `textbook_videos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `textbooks`
--

DROP TABLE IF EXISTS `textbooks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `textbooks` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `isbn13` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `title` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `author` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `publisher` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `image_link` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `textbook_image` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `textbooks`
--

LOCK TABLES `textbooks` WRITE;
/*!40000 ALTER TABLE `textbooks` DISABLE KEYS */;
INSERT INTO `textbooks` VALUES (1,'9780130523167','Algebra 1','Allan Bellman, Sadie Chavis Bragg, Randall I. Charles','Pearson Prentice Hall','2014-10-22 14:30:48','2015-05-14 15:08:52','http://bks5.books.google.com/books?id=Rd4tQwAACAAJ&printsec=frontcover&img=1&zoom=1&source=gbs_api','front_cover.png'),(2,'9780321557643','Intermediate Algebra','Margaret L. Lial, John Hornsby, Terry McGinnis','Addison-Wesley Longman','2014-10-22 14:34:20','2015-05-14 15:12:57','http://bks5.books.google.com/books?id=2OlJPgAACAAJ&printsec=frontcover&img=1&zoom=1&source=gbs_api','front_cover.png'),(3,'9780078746376','Glencoe Chemistry: Matter and Change, Student Edition','McGraw-Hill, Glencoe','Glencoe/McGraw-Hill','2014-10-22 15:32:36','2015-05-14 15:13:05','http://bks5.books.google.com/books?id=OZInPwAACAAJ&printsec=frontcover&img=1&zoom=1&source=gbs_api','front_cover.png'),(4,'9780131101630','The C Programming Language','Brian W. Kernighan','Prentice Hall PTR','2014-10-25 18:20:54','2015-05-14 15:13:16','http://bks2.books.google.com/books?id=fMKTngEACAAJ&printsec=frontcover&img=1&zoom=1&source=gbs_api','front_cover.png'),(5,'9780470485040','Fedora 11 and Red Hat Enterprise Linux Bible','Christopher Negus, Eric Foster-Johnson','John Wiley & Sons','2015-03-15 03:42:15','2015-05-14 15:13:28','http://books.google.com/books/content?id=EHQOdKnawU8C&printsec=frontcover&img=1&zoom=1&edge=none&source=gbs_api','front_cover.png'),(8,'9781934356081','Programming Ruby 1.9: The Pragmatic Programmers\' Guide','David Thomas',NULL,'2015-05-15 15:00:49','2015-05-15 15:00:49','http://bks4.books.google.com/books/content?id=f89GPgAACAAJ&printsec=frontcover&img=1&zoom=1&source=gbs_api','front_cover.png'),(9,'9780596100926','Perl Testing: A Developer\'s Notebook','Ian Langworth, Chromatic','\"O\'Reilly Media, Inc.\"','2015-05-15 15:06:42','2015-05-15 15:06:42','http://bks7.books.google.com/books/content?id=gLgi8qJ03XoC&printsec=frontcover&img=1&zoom=1&edge=none&source=gbs_api','front_cover.png'),(10,'9780596000271','Programming Perl: 3rd Edition','Larry Wall, Tom Christiansen, Jon Orwant','\"O\'Reilly Media, Inc.\"','2015-05-17 00:23:14','2015-05-17 00:23:14','http://bks5.books.google.com/books/content?id=xx5JBSqcQzIC&printsec=frontcover&img=1&zoom=1&edge=none&source=gbs_api','front_cover.png'),(11,'9780596006990','Programming C#: Building .NET Applications with C#','Jesse Liberty','O\'Reilly Media','2015-05-17 00:23:49','2015-05-17 00:23:49','http://bks0.books.google.com/books/content?id=6s0nmQEACAAJ&printsec=frontcover&img=1&zoom=1&source=gbs_api','front_cover.png'),(12,'9781934356470','Metaprogramming Ruby: Program Like the Ruby Pros','Paolo Perrotta',NULL,'2015-05-17 00:25:42','2015-05-17 00:25:42','http://bks8.books.google.com/books/content?id=86YGQQAACAAJ&printsec=frontcover&img=1&zoom=1&source=gbs_api','front_cover.png'),(13,'9780596516178','The Ruby Programming Language','David Flanagan, Yukihiro Matsumoto','\"O\'Reilly Media, Inc.\"','2015-06-07 13:06:04','2015-06-07 13:06:04','http://bks7.books.google.com/books/content?id=rbY5mz-_VdQC&printsec=frontcover&img=1&zoom=1&edge=none&source=gbs_api','front_cover.png');
/*!40000 ALTER TABLE `textbooks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `textboxes`
--

DROP TABLE IF EXISTS `textboxes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `textboxes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `content` text COLLATE utf8_unicode_ci,
  `course_asset_id` int(11) DEFAULT NULL,
  `archived` int(11) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `position` int(11) DEFAULT NULL,
  `title` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `textboxes`
--

LOCK TABLES `textboxes` WRITE;
/*!40000 ALTER TABLE `textboxes` DISABLE KEYS */;
/*!40000 ALTER TABLE `textboxes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `videos`
--

DROP TABLE IF EXISTS `videos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `videos` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `videofile` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `length` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `archived` int(11) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `videofile_processed` int(11) DEFAULT NULL,
  `title` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `description` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `position` int(11) DEFAULT NULL,
  `course_asset_id` int(11) DEFAULT NULL,
  `instructor_id` int(11) DEFAULT NULL,
  `old_version_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `videos`
--

LOCK TABLES `videos` WRITE;
/*!40000 ALTER TABLE `videos` DISABLE KEYS */;
/*!40000 ALTER TABLE `videos` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2015-09-22 13:48:49
