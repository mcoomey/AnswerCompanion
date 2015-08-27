-- phpMyAdmin SQL Dump
-- version 3.5.2.2
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Aug 10, 2015 at 12:42 PM
-- Server version: 5.6.21
-- PHP Version: 5.5.24

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `AnswerCompanion_development`
--

-- --------------------------------------------------------

--
-- Table structure for table `countries`
--

CREATE TABLE IF NOT EXISTS `countries` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=2 ;

--
-- Dumping data for table `countries`
--

INSERT INTO `countries` (`id`, `name`, `created_at`, `updated_at`) VALUES
(1, 'United States', '2015-06-21 00:22:29', '2015-06-21 00:22:29');

-- --------------------------------------------------------

--
-- Table structure for table `courses`
--

CREATE TABLE IF NOT EXISTS `courses` (
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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=5 ;

--
-- Dumping data for table `courses`
--

INSERT INTO `courses` (`id`, `name`, `section`, `instructor_id`, `created_at`, `updated_at`, `term`, `archived`, `passphrase`, `position`) VALUES
(1, 'Algebra 1', '1', 1, '2015-03-12 01:39:23', '2015-05-07 14:00:02', 'A', 0, 'Algebra 1 rocks!', 1),
(2, 'Empty', '0', 1, '2015-03-15 14:52:31', '2015-05-07 14:00:02', '0', 0, 'nothing here', 2),
(3, 'Ruby', '2', 1, '2015-05-02 01:32:54', '2015-05-07 14:00:02', 'B', 0, '', 3),
(4, 'C Programming', '1', 1, '2015-05-16 22:57:44', '2015-05-21 18:20:31', 'AB', 0, 'This is a passphrase', 4);

-- --------------------------------------------------------

--
-- Table structure for table `course_assets`
--

CREATE TABLE IF NOT EXISTS `course_assets` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `model_type` int(11) DEFAULT NULL,
  `assetable_id` int(11) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `position` int(11) DEFAULT NULL,
  `assetable_type` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=18 ;

--
-- Dumping data for table `course_assets`
--

INSERT INTO `course_assets` (`id`, `name`, `model_type`, `assetable_id`, `created_at`, `updated_at`, `position`, `assetable_type`) VALUES
(1, 'Textbooks', 1, 1, '2015-03-12 01:40:36', '2015-03-12 01:40:36', 1, 'Course'),
(2, 'Videos', 2, 1, '2015-03-12 01:42:21', '2015-03-12 01:42:21', 2, 'Course'),
(4, 'Documents', 3, 1, '2015-05-01 00:10:06', '2015-05-01 00:10:06', 3, 'Course'),
(6, 'Textbook', 1, 3, '2015-05-02 01:33:21', '2015-05-02 01:33:21', 1, 'Course'),
(7, 'Links', 4, 1, '2015-05-06 15:55:30', '2015-05-06 15:55:30', 4, 'Course'),
(8, 'Plain Text', 5, 1, '2015-05-06 22:58:43', '2015-05-06 22:58:43', 5, 'Course'),
(10, 'Textbooks', 1, 4, '2015-05-16 22:58:00', '2015-05-16 22:58:00', 1, 'Course');

-- --------------------------------------------------------

--
-- Table structure for table `course_asset_model_types`
--

CREATE TABLE IF NOT EXISTS `course_asset_model_types` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `name_of_model` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=6 ;

--
-- Dumping data for table `course_asset_model_types`
--

INSERT INTO `course_asset_model_types` (`id`, `name`, `created_at`, `updated_at`, `name_of_model`) VALUES
(1, 'Textbooks', '2014-10-22 13:40:11', '2014-10-22 13:40:11', 'textbook_delegations'),
(2, 'Videos', '2014-10-22 13:40:11', '2014-10-22 13:40:11', 'videos'),
(3, 'Documents', '2014-10-22 13:40:11', '2014-10-22 13:40:11', 'documents'),
(4, 'Links', '2014-10-22 13:40:11', '2014-10-22 13:40:11', 'links'),
(5, 'Plain Text', '2014-10-22 13:40:11', '2014-10-22 13:40:11', 'textboxes');

-- --------------------------------------------------------

--
-- Table structure for table `delayed_jobs`
--

CREATE TABLE IF NOT EXISTS `delayed_jobs` (
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `documents`
--

CREATE TABLE IF NOT EXISTS `documents` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `description` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `course_asset_id` int(11) DEFAULT NULL,
  `archived` int(11) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `position` int(11) DEFAULT NULL,
  `docfile` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=14 ;

-- --------------------------------------------------------

--
-- Table structure for table `enrollments`
--

CREATE TABLE IF NOT EXISTS `enrollments` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `course_id` int(11) DEFAULT NULL,
  `subject_id` int(11) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `index_enrollments_on_course_id_and_subject_id` (`course_id`,`subject_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `exercises`
--

CREATE TABLE IF NOT EXISTS `exercises` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `number` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `page` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `section_title_id` int(11) DEFAULT NULL,
  `textbook_id` int(11) DEFAULT NULL,
  `instructor_id` int(11) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=8 ;

--
-- Dumping data for table `exercises`
--

INSERT INTO `exercises` (`id`, `number`, `page`, `section_title_id`, `textbook_id`, `instructor_id`, `created_at`, `updated_at`) VALUES
(1, '1', '10', 1, 1, 1, '2014-10-22 16:49:50', '2015-06-03 10:48:42'),
(2, '2', '13', 1, 1, 1, '2014-10-27 11:57:46', '2014-10-27 11:57:46'),
(3, '3', '15', 1, 1, 1, '2014-10-27 11:58:55', '2015-06-05 12:34:26'),
(7, '4', '15', 1, 1, 1, '2015-06-05 23:29:38', '2015-06-05 23:29:48');

-- --------------------------------------------------------

--
-- Table structure for table `instructors`
--

CREATE TABLE IF NOT EXISTS `instructors` (
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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=2 ;

--
-- Dumping data for table `instructors`
--

INSERT INTO `instructors` (`id`, `email`, `encrypted_password`, `reset_password_token`, `reset_password_sent_at`, `remember_created_at`, `sign_in_count`, `current_sign_in_at`, `last_sign_in_at`, `current_sign_in_ip`, `last_sign_in_ip`, `confirmation_token`, `confirmed_at`, `confirmation_sent_at`, `unconfirmed_email`, `failed_attempts`, `unlock_token`, `locked_at`, `created_at`, `updated_at`, `firstname`, `lastname`, `username`, `emailpref`, `paypalaccount`, `privilege`, `grade`, `accountbalance`, `violationcount`, `deactivated`) VALUES
(1, 'mcoomey@gmail.com', '$2a$10$1YXIZI71L3dwoDcdWWhSdO.Rd.yOElep4s0b1UOFC1iyVInqejVk.', NULL, NULL, NULL, 50, '2015-08-08 23:27:58', '2015-08-05 19:42:53', '127.0.0.1', '127.0.0.1', NULL, '2014-10-22 13:09:51', '2014-10-22 13:09:22', NULL, 0, NULL, NULL, '2014-10-22 13:09:22', '2015-08-08 23:27:58', 'Michael', 'Coomey', 'mcoomey', 0, NULL, 0, NULL, 0, 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `lessons`
--

CREATE TABLE IF NOT EXISTS `lessons` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `page` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `textbook_id` int(11) DEFAULT NULL,
  `instructor_id` int(11) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=9 ;

--
-- Dumping data for table `lessons`
--

INSERT INTO `lessons` (`id`, `title`, `page`, `textbook_id`, `instructor_id`, `created_at`, `updated_at`) VALUES
(1, '1.1 Basic Concepts', '2', 1, 1, '2015-05-22 14:05:21', '2015-06-03 16:54:02'),
(2, 'junk and stuff', '88', 1, 1, '2015-05-22 14:05:52', '2015-06-05 12:23:35'),
(3, 'new lesson', '104', 1, 1, '2015-05-25 12:57:18', '2015-05-25 12:57:18'),
(7, 'more junk', '301', 1, 1, '2015-06-04 17:20:42', '2015-06-04 17:21:46'),
(8, 'more junk', '0', 1, 1, '2015-06-05 23:27:30', '2015-06-05 23:28:01');

-- --------------------------------------------------------

--
-- Table structure for table `links`
--

CREATE TABLE IF NOT EXISTS `links` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `description` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `url` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `course_asset_id` int(11) DEFAULT NULL,
  `archived` int(11) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `position` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=9 ;

--
-- Dumping data for table `links`
--

INSERT INTO `links` (`id`, `description`, `url`, `course_asset_id`, `archived`, `created_at`, `updated_at`, `position`) VALUES
(7, 'Dynamic Test', 'www.dynamictest.com', 17, 0, '2015-06-11 19:08:49', '2015-06-11 19:08:49', 1),
(8, 'Answer Companion', 'www.answercompanion.com', 17, 0, '2015-06-11 19:09:12', '2015-06-11 19:09:56', 2);

-- --------------------------------------------------------

--
-- Table structure for table `parents`
--

CREATE TABLE IF NOT EXISTS `parents` (
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `parent_emails`
--

CREATE TABLE IF NOT EXISTS `parent_emails` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `student_id` int(11) DEFAULT NULL,
  `email` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `index_parent_emails_on_student_id_and_email` (`student_id`,`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `roles`
--

CREATE TABLE IF NOT EXISTS `roles` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=5 ;

--
-- Dumping data for table `roles`
--

INSERT INTO `roles` (`id`, `name`, `created_at`, `updated_at`) VALUES
(1, 'Administrator', '2014-10-22 13:04:35', '2014-10-22 13:04:35'),
(2, 'Instructor', '2014-10-22 13:04:35', '2014-10-22 13:04:35'),
(3, 'Student', '2014-10-22 13:04:35', '2014-10-22 13:04:35'),
(4, 'Parent', '2014-10-22 13:04:35', '2014-10-22 13:04:35');

-- --------------------------------------------------------

--
-- Table structure for table `role_assignments`
--

CREATE TABLE IF NOT EXISTS `role_assignments` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `role_id` int(11) DEFAULT NULL,
  `roleable_type` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `roleable_id` int(11) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=2 ;

--
-- Dumping data for table `role_assignments`
--

INSERT INTO `role_assignments` (`id`, `role_id`, `roleable_type`, `roleable_id`, `created_at`, `updated_at`) VALUES
(1, 2, 'Instructor', 1, '2014-10-22 13:09:24', '2014-10-22 13:09:24');

-- --------------------------------------------------------

--
-- Table structure for table `schema_migrations`
--

CREATE TABLE IF NOT EXISTS `schema_migrations` (
  `version` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  UNIQUE KEY `unique_schema_migrations` (`version`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `schema_migrations`
--

INSERT INTO `schema_migrations` (`version`) VALUES
('20120302232009'),
('20120302232059'),
('20120307181217'),
('20120315183633'),
('20120328200141'),
('20120417204301'),
('20120418160732'),
('20121023121828'),
('20121023121928'),
('20121023122013'),
('20121023122415'),
('20121030180850'),
('20121129191919'),
('20121217134827'),
('20130125131215'),
('20130325203703'),
('20130327182400'),
('20130328004848'),
('20130330202715'),
('20130405003210'),
('20130421160850'),
('20130423155439'),
('20130429154556'),
('20130501203113'),
('20130502171113'),
('20130502174403'),
('20130504003631'),
('20130530173549'),
('20130628172824'),
('20130628181628'),
('20130706120825'),
('20130709174138'),
('20130710183238'),
('20130919200639'),
('20130924153543'),
('20131014124455'),
('20131020144511'),
('20131028225546'),
('20131029113702'),
('20131029113738'),
('20131029121544'),
('20131029122617'),
('20131029180702'),
('20131030184318'),
('20131030223137'),
('20131201155517'),
('20140330174548'),
('20140405173718'),
('20140405175251'),
('20140418152934'),
('20140419204006'),
('20140425145722'),
('20140425180737'),
('20140426232641'),
('20140514174206'),
('20140530173833'),
('20140621200037'),
('20140704142907'),
('20140811185506'),
('20140813123645'),
('20140820190749'),
('20140821144822'),
('20140904192633'),
('20140923134927'),
('20140929150610'),
('20140929150704'),
('20140929150822'),
('20140929151014'),
('20140929151044'),
('20140929151145'),
('20140929171850'),
('20140929171914'),
('20140929174041'),
('20140929174310'),
('20140929183205'),
('20140930234816'),
('20141001152323'),
('20141017001404'),
('20141106141659'),
('20150513232329'),
('20150621000004'),
('20150621000542'),
('20150621001305'),
('20150621124559');

-- --------------------------------------------------------

--
-- Table structure for table `schools`
--

CREATE TABLE IF NOT EXISTS `schools` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `town` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `state_id` int(11) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=3 ;

--
-- Dumping data for table `schools`
--

INSERT INTO `schools` (`id`, `name`, `town`, `state_id`, `created_at`, `updated_at`) VALUES
(1, 'Oxford High School', 'Oxford', 34, '2014-10-22 10:00:05', '2014-10-22 10:00:05'),
(2, 'Wachusett Regional High School', 'Holden', 34, '2014-10-29 18:09:21', '2014-10-29 18:09:21');

-- --------------------------------------------------------

--
-- Table structure for table `school_memberships`
--

CREATE TABLE IF NOT EXISTS `school_memberships` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `school_id` int(11) DEFAULT NULL,
  `schoolmember_id` int(11) DEFAULT NULL,
  `schoolmember_type` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `index_school_memberships_on_id_and_type` (`schoolmember_id`,`schoolmember_type`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=2 ;

--
-- Dumping data for table `school_memberships`
--

INSERT INTO `school_memberships` (`id`, `school_id`, `schoolmember_id`, `schoolmember_type`, `created_at`, `updated_at`) VALUES
(1, 1, 1, 'Instructor', '2015-07-03 11:51:56', '2015-07-03 11:51:56');

-- --------------------------------------------------------

--
-- Table structure for table `section_titles`
--

CREATE TABLE IF NOT EXISTS `section_titles` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `textbook_id` int(11) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=2 ;

--
-- Dumping data for table `section_titles`
--

INSERT INTO `section_titles` (`id`, `name`, `textbook_id`, `created_at`, `updated_at`) VALUES
(1, 'Chapter Summary', 1, '2014-10-22 16:49:50', '2014-10-22 16:49:50');

-- --------------------------------------------------------

--
-- Table structure for table `site_assets`
--

CREATE TABLE IF NOT EXISTS `site_assets` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `model_type` int(11) DEFAULT NULL,
  `course_id` int(11) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `position` int(11) DEFAULT NULL,
  `type` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=6 ;

--
-- Dumping data for table `site_assets`
--

INSERT INTO `site_assets` (`id`, `name`, `model_type`, `course_id`, `created_at`, `updated_at`, `position`, `type`) VALUES
(1, 'Textbooks', 1, 1, '2014-10-22 16:36:24', '2014-10-22 16:36:24', 1, NULL),
(2, 'Videos', 2, 1, '2014-10-22 23:09:05', '2014-10-22 23:09:05', 2, NULL),
(3, 'Documents', 3, 1, '2014-10-23 11:38:20', '2014-10-23 11:38:20', 3, NULL),
(4, 'Textboxes', 5, 1, '2014-10-23 19:43:58', '2014-10-23 19:43:58', 5, NULL),
(5, 'Links', 4, 1, '2014-10-23 20:17:18', '2014-10-23 20:17:18', 4, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `states`
--

CREATE TABLE IF NOT EXISTS `states` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `abbrev` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `country_id` int(11) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=52 ;

--
-- Dumping data for table `states`
--

INSERT INTO `states` (`id`, `name`, `abbrev`, `country_id`, `created_at`, `updated_at`) VALUES
(1, 'Alabama', 'AL', 1, '2015-06-21 18:37:14', '2015-06-21 18:37:14'),
(2, 'Alaska', 'AK', 1, '2015-06-21 18:37:14', '2015-06-21 18:37:14'),
(3, 'Arizona', 'AZ', 1, '2015-06-21 18:37:14', '2015-06-21 18:37:14'),
(4, 'Arkansas', 'AR', 1, '2015-06-21 18:37:14', '2015-06-21 18:37:14'),
(5, 'California', 'CA', 1, '2015-06-21 18:37:14', '2015-06-21 18:37:14'),
(6, 'Colorado', 'CO', 1, '2015-06-21 18:37:14', '2015-06-21 18:37:14'),
(7, 'Connecticut', 'CT', 1, '2015-06-21 18:37:14', '2015-06-21 18:37:14'),
(8, 'Delaware', 'DE', 1, '2015-06-21 18:37:14', '2015-06-21 18:37:14'),
(9, 'District of Columbia', 'DC', 1, '2015-06-21 18:37:14', '2015-06-21 18:37:14'),
(10, 'Florida', 'FL', 1, '2015-06-21 18:37:14', '2015-06-21 18:37:14'),
(11, 'Georgia', 'GA', 1, '2015-06-21 18:37:14', '2015-06-21 18:37:14'),
(12, 'Hawaii', 'HI', 1, '2015-06-21 18:37:14', '2015-06-21 18:37:14'),
(13, 'Idaho', 'ID', 1, '2015-06-21 18:37:14', '2015-06-21 18:37:14'),
(14, 'Illinois', 'IL', 1, '2015-06-21 18:37:14', '2015-06-21 18:37:14'),
(15, 'Indiana', 'IN', 1, '2015-06-21 18:37:14', '2015-06-21 18:37:14'),
(16, 'Iowa', 'IA', 1, '2015-06-21 18:37:14', '2015-06-21 18:37:14'),
(17, 'Kansas', 'KS', 1, '2015-06-21 18:37:14', '2015-06-21 18:37:14'),
(18, 'Kentucky', 'KY', 1, '2015-06-21 18:37:14', '2015-06-21 18:37:14'),
(19, 'Louisiana', 'LA', 1, '2015-06-21 18:37:14', '2015-06-21 18:37:14'),
(20, 'Maine', 'ME', 1, '2015-06-21 18:37:14', '2015-06-21 18:37:14'),
(21, 'Montana', 'MT', 1, '2015-06-21 18:37:14', '2015-06-21 18:37:14'),
(22, 'Nebraska', 'NE', 1, '2015-06-21 18:37:14', '2015-06-21 18:37:14'),
(23, 'Nevada', 'NV', 1, '2015-06-21 18:37:14', '2015-06-21 18:37:14'),
(24, 'New Hampshire', 'NH', 1, '2015-06-21 18:37:14', '2015-06-21 18:37:14'),
(25, 'New Jersey', 'NJ', 1, '2015-06-21 18:37:14', '2015-06-21 18:37:14'),
(26, 'New Mexico', 'NM', 1, '2015-06-21 18:37:14', '2015-06-21 18:37:14'),
(27, 'New York', 'NY', 1, '2015-06-21 18:37:14', '2015-06-21 18:37:14'),
(28, 'North Carolina', 'NC', 1, '2015-06-21 18:37:14', '2015-06-21 18:37:14'),
(29, 'North Dakota', 'ND', 1, '2015-06-21 18:37:14', '2015-06-21 18:37:14'),
(30, 'Ohio', 'OH', 1, '2015-06-21 18:37:14', '2015-06-21 18:37:14'),
(31, 'Oklahoma', 'OK', 1, '2015-06-21 18:37:14', '2015-06-21 18:37:14'),
(32, 'Oregon', 'OR', 1, '2015-06-21 18:37:14', '2015-06-21 18:37:14'),
(33, 'Maryland', 'MD', 1, '2015-06-21 18:37:14', '2015-06-21 18:37:14'),
(34, 'Massachusetts', 'MA', 1, '2015-06-21 18:37:14', '2015-06-21 18:37:14'),
(35, 'Michigan', 'MI', 1, '2015-06-21 18:37:14', '2015-06-21 18:37:14'),
(36, 'Minnesota', 'MN', 1, '2015-06-21 18:37:14', '2015-06-21 18:37:14'),
(37, 'Mississippi', 'MS', 1, '2015-06-21 18:37:14', '2015-06-21 18:37:14'),
(38, 'Missouri', 'MO', 1, '2015-06-21 18:37:14', '2015-06-21 18:37:14'),
(39, 'Pennsylvania', 'PA', 1, '2015-06-21 18:37:14', '2015-06-21 18:37:14'),
(40, 'Rhode Island', 'RI', 1, '2015-06-21 18:37:14', '2015-06-21 18:37:14'),
(41, 'South Carolina', 'SC', 1, '2015-06-21 18:37:14', '2015-06-21 18:37:14'),
(42, 'South Dakota', 'SD', 1, '2015-06-21 18:37:14', '2015-06-21 18:37:14'),
(43, 'Tennessee', 'TN', 1, '2015-06-21 18:37:14', '2015-06-21 18:37:14'),
(44, 'Texas', 'TX', 1, '2015-06-21 18:37:14', '2015-06-21 18:37:14'),
(45, 'Utah', 'UT', 1, '2015-06-21 18:37:14', '2015-06-21 18:37:14'),
(46, 'Vermont', 'VT', 1, '2015-06-21 18:37:14', '2015-06-21 18:37:14'),
(47, 'Virginia', 'VA', 1, '2015-06-21 18:37:14', '2015-06-21 18:37:14'),
(48, 'Washington', 'WA', 1, '2015-06-21 18:37:14', '2015-06-21 18:37:14'),
(49, 'West Virginia', 'WV', 1, '2015-06-21 18:37:14', '2015-06-21 18:37:14'),
(50, 'Wisconsin', 'WI', 1, '2015-06-21 18:37:14', '2015-06-21 18:37:14'),
(51, 'Wyoming', 'WY', 1, '2015-06-21 18:37:14', '2015-06-21 18:37:14');

-- --------------------------------------------------------

--
-- Table structure for table `students`
--

CREATE TABLE IF NOT EXISTS `students` (
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `subjects`
--

CREATE TABLE IF NOT EXISTS `subjects` (
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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=5 ;

-- --------------------------------------------------------

--
-- Table structure for table `subject_assets`
--

CREATE TABLE IF NOT EXISTS `subject_assets` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `model_type` int(11) DEFAULT NULL,
  `subject_id` int(11) DEFAULT NULL,
  `position` int(11) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `textbooks`
--

CREATE TABLE IF NOT EXISTS `textbooks` (
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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=14 ;

--
-- Dumping data for table `textbooks`
--

INSERT INTO `textbooks` (`id`, `isbn13`, `title`, `author`, `publisher`, `created_at`, `updated_at`, `image_link`, `textbook_image`) VALUES
(1, '9780130523167', 'Algebra 1', 'Allan Bellman, Sadie Chavis Bragg, Randall I. Charles', 'Pearson Prentice Hall', '2014-10-22 14:30:48', '2015-05-14 15:08:52', 'http://bks5.books.google.com/books?id=Rd4tQwAACAAJ&printsec=frontcover&img=1&zoom=1&source=gbs_api', 'front_cover.png'),
(2, '9780321557643', 'Intermediate Algebra', 'Margaret L. Lial, John Hornsby, Terry McGinnis', 'Addison-Wesley Longman', '2014-10-22 14:34:20', '2015-05-14 15:12:57', 'http://bks5.books.google.com/books?id=2OlJPgAACAAJ&printsec=frontcover&img=1&zoom=1&source=gbs_api', 'front_cover.png'),
(3, '9780078746376', 'Glencoe Chemistry: Matter and Change, Student Edition', 'McGraw-Hill, Glencoe', 'Glencoe/McGraw-Hill', '2014-10-22 15:32:36', '2015-05-14 15:13:05', 'http://bks5.books.google.com/books?id=OZInPwAACAAJ&printsec=frontcover&img=1&zoom=1&source=gbs_api', 'front_cover.png'),
(4, '9780131101630', 'The C Programming Language', 'Brian W. Kernighan', 'Prentice Hall PTR', '2014-10-25 18:20:54', '2015-05-14 15:13:16', 'http://bks2.books.google.com/books?id=fMKTngEACAAJ&printsec=frontcover&img=1&zoom=1&source=gbs_api', 'front_cover.png'),
(5, '9780470485040', 'Fedora 11 and Red Hat Enterprise Linux Bible', 'Christopher Negus, Eric Foster-Johnson', 'John Wiley & Sons', '2015-03-15 03:42:15', '2015-05-14 15:13:28', 'http://books.google.com/books/content?id=EHQOdKnawU8C&printsec=frontcover&img=1&zoom=1&edge=none&source=gbs_api', 'front_cover.png'),
(8, '9781934356081', 'Programming Ruby 1.9: The Pragmatic Programmers'' Guide', 'David Thomas', NULL, '2015-05-15 15:00:49', '2015-05-15 15:00:49', 'http://bks4.books.google.com/books/content?id=f89GPgAACAAJ&printsec=frontcover&img=1&zoom=1&source=gbs_api', 'front_cover.png'),
(9, '9780596100926', 'Perl Testing: A Developer''s Notebook', 'Ian Langworth, Chromatic', '"O''Reilly Media, Inc."', '2015-05-15 15:06:42', '2015-05-15 15:06:42', 'http://bks7.books.google.com/books/content?id=gLgi8qJ03XoC&printsec=frontcover&img=1&zoom=1&edge=none&source=gbs_api', 'front_cover.png'),
(10, '9780596000271', 'Programming Perl: 3rd Edition', 'Larry Wall, Tom Christiansen, Jon Orwant', '"O''Reilly Media, Inc."', '2015-05-17 00:23:14', '2015-05-17 00:23:14', 'http://bks5.books.google.com/books/content?id=xx5JBSqcQzIC&printsec=frontcover&img=1&zoom=1&edge=none&source=gbs_api', 'front_cover.png'),
(11, '9780596006990', 'Programming C#: Building .NET Applications with C#', 'Jesse Liberty', 'O''Reilly Media', '2015-05-17 00:23:49', '2015-05-17 00:23:49', 'http://bks0.books.google.com/books/content?id=6s0nmQEACAAJ&printsec=frontcover&img=1&zoom=1&source=gbs_api', 'front_cover.png'),
(12, '9781934356470', 'Metaprogramming Ruby: Program Like the Ruby Pros', 'Paolo Perrotta', NULL, '2015-05-17 00:25:42', '2015-05-17 00:25:42', 'http://bks8.books.google.com/books/content?id=86YGQQAACAAJ&printsec=frontcover&img=1&zoom=1&source=gbs_api', 'front_cover.png'),
(13, '9780596516178', 'The Ruby Programming Language', 'David Flanagan, Yukihiro Matsumoto', '"O''Reilly Media, Inc."', '2015-06-07 13:06:04', '2015-06-07 13:06:04', 'http://bks7.books.google.com/books/content?id=rbY5mz-_VdQC&printsec=frontcover&img=1&zoom=1&edge=none&source=gbs_api', 'front_cover.png');

-- --------------------------------------------------------

--
-- Table structure for table `textbook_delegations`
--

CREATE TABLE IF NOT EXISTS `textbook_delegations` (
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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=61 ;

--
-- Dumping data for table `textbook_delegations`
--

INSERT INTO `textbook_delegations` (`id`, `textbook_id`, `created_at`, `updated_at`, `course_asset_id`, `archived`, `position`) VALUES
(43, 1, '2015-05-16 18:46:31', '2015-05-16 18:46:31', 1, 0, 1),
(47, 8, '2015-05-16 22:56:02', '2015-05-16 22:56:02', 6, 0, 1),
(48, 4, '2015-05-16 22:56:21', '2015-05-16 22:56:21', 6, 1, 1),
(49, 4, '2015-05-16 22:58:19', '2015-05-16 22:58:19', 10, 0, 1),
(58, 13, '2015-06-07 13:06:04', '2015-06-07 13:06:04', 9, 0, 1),
(59, 8, '2015-06-10 15:54:27', '2015-06-11 19:35:43', 9, 0, 2),
(60, 2, '2015-07-18 00:40:20', '2015-07-18 00:40:20', 1, 0, 2);

-- --------------------------------------------------------

--
-- Table structure for table `textbook_videos`
--

CREATE TABLE IF NOT EXISTS `textbook_videos` (
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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=9 ;

--
-- Dumping data for table `textbook_videos`
--

INSERT INTO `textbook_videos` (`id`, `videofile`, `length`, `videofile_processed`, `videoable_type`, `videoable_id`, `textbook_id`, `instructor_id`, `created_at`, `updated_at`, `old_version_id`) VALUES
(1, 'small1.mp4', '00:00:05.57', 1, 'Lesson', 1, 1, 1, '2015-05-27 18:24:40', '2015-06-02 16:51:47', NULL),
(7, 'small2.mp4', '00:00:05.57', 1, 'Lesson', 1, 1, 1, '2015-06-04 15:03:53', '2015-06-04 15:04:13', NULL),
(8, 'small2.mp4', '00:00:05.57', 1, 'Exercise', 6, 1, 1, '2015-06-05 18:09:05', '2015-06-05 18:09:23', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `textboxes`
--

CREATE TABLE IF NOT EXISTS `textboxes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `content` text COLLATE utf8_unicode_ci,
  `course_asset_id` int(11) DEFAULT NULL,
  `archived` int(11) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `position` int(11) DEFAULT NULL,
  `title` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `videos`
--

CREATE TABLE IF NOT EXISTS `videos` (
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
