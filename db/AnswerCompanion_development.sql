-- phpMyAdmin SQL Dump
-- version 3.5.2.2
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Oct 31, 2014 at 06:01 PM
-- Server version: 5.6.21
-- PHP Version: 5.5.14

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
-- Table structure for table `courses`
--

CREATE TABLE IF NOT EXISTS `courses` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `section` varchar(255) DEFAULT NULL,
  `instructor_id` int(11) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `term` varchar(255) DEFAULT NULL,
  `archived` int(11) DEFAULT NULL,
  `passphrase` varchar(255) DEFAULT NULL,
  `position` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_courses_on_instructor_id` (`instructor_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=4 ;

--
-- Dumping data for table `courses`
--

INSERT INTO `courses` (`id`, `name`, `section`, `instructor_id`, `created_at`, `updated_at`, `term`, `archived`, `passphrase`, `position`) VALUES
(1, 'Algebra 1', '1', 1, '2014-10-22 14:28:19', '2014-10-28 17:55:56', 'A14', 0, 'Math rocks!', 1),
(2, 'no assets', '2', 1, '2014-10-24 01:31:11', '2014-10-30 14:51:20', 'A2', 0, 'No Assets Allowed!', 2),
(3, 'Algebra by MWC', '1', 2, '2014-10-22 14:28:19', '2014-10-30 13:56:17', 'A14', 0, 'Math rocks!', 1);

-- --------------------------------------------------------

--
-- Table structure for table `course_asset_model_types`
--

CREATE TABLE IF NOT EXISTS `course_asset_model_types` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `name_of_model` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=6 ;

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
  `handler` text,
  `last_error` text,
  `run_at` datetime DEFAULT NULL,
  `locked_at` datetime DEFAULT NULL,
  `failed_at` datetime DEFAULT NULL,
  `locked_by` varchar(255) DEFAULT NULL,
  `queue` varchar(255) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `delayed_jobs_priority` (`priority`,`run_at`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=8 ;

-- --------------------------------------------------------

--
-- Table structure for table `documents`
--

CREATE TABLE IF NOT EXISTS `documents` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `description` varchar(255) DEFAULT NULL,
  `course_asset_id` int(11) DEFAULT NULL,
  `archived` int(11) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `position` int(11) DEFAULT NULL,
  `docfile` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=5 ;

--
-- Dumping data for table `documents`
--

INSERT INTO `documents` (`id`, `description`, `course_asset_id`, `archived`, `created_at`, `updated_at`, `position`, `docfile`) VALUES
(1, 'This is a test page.', 3, 0, '2014-10-23 14:13:51', '2014-10-23 14:13:51', 1, 'test_page.pdf'),
(2, 'T2000 summary', 3, 0, '2014-10-23 14:14:47', '2014-10-23 14:14:47', 2, 'T2000_Summary.pdf'),
(3, 'new doc', 3, 0, '2014-10-23 18:44:57', '2014-10-28 17:59:31', 3, 'vhdl_cheat_sheet.pdf');

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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=2 ;

--
-- Dumping data for table `enrollments`
--

INSERT INTO `enrollments` (`id`, `course_id`, `subject_id`, `created_at`, `updated_at`) VALUES
(1, 1, 1, '2014-10-31 11:44:23', '2014-10-31 11:44:23');

-- --------------------------------------------------------

--
-- Table structure for table `exercises`
--

CREATE TABLE IF NOT EXISTS `exercises` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `number` varchar(255) DEFAULT NULL,
  `page` varchar(255) DEFAULT NULL,
  `section_title_id` int(11) DEFAULT NULL,
  `textbook_id` int(11) DEFAULT NULL,
  `instructor_id` int(11) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=4 ;

--
-- Dumping data for table `exercises`
--

INSERT INTO `exercises` (`id`, `number`, `page`, `section_title_id`, `textbook_id`, `instructor_id`, `created_at`, `updated_at`) VALUES
(1, '1', '12', 1, 1, 1, '2014-10-22 16:49:50', '2014-10-22 16:49:50'),
(2, '2', '13', 1, 1, 1, '2014-10-27 11:57:46', '2014-10-27 11:57:46'),
(3, '3', '14', 1, 1, 1, '2014-10-27 11:58:55', '2014-10-27 11:58:55');

-- --------------------------------------------------------

--
-- Table structure for table `instructors`
--

CREATE TABLE IF NOT EXISTS `instructors` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `email` varchar(255) NOT NULL DEFAULT '',
  `encrypted_password` varchar(255) NOT NULL DEFAULT '',
  `reset_password_token` varchar(255) DEFAULT NULL,
  `reset_password_sent_at` datetime DEFAULT NULL,
  `remember_created_at` datetime DEFAULT NULL,
  `sign_in_count` int(11) DEFAULT '0',
  `current_sign_in_at` datetime DEFAULT NULL,
  `last_sign_in_at` datetime DEFAULT NULL,
  `current_sign_in_ip` varchar(255) DEFAULT NULL,
  `last_sign_in_ip` varchar(255) DEFAULT NULL,
  `confirmation_token` varchar(255) DEFAULT NULL,
  `confirmed_at` datetime DEFAULT NULL,
  `confirmation_sent_at` datetime DEFAULT NULL,
  `unconfirmed_email` varchar(255) DEFAULT NULL,
  `failed_attempts` int(11) DEFAULT '0',
  `unlock_token` varchar(255) DEFAULT NULL,
  `locked_at` datetime DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `firstname` varchar(255) DEFAULT NULL,
  `lastname` varchar(255) DEFAULT NULL,
  `username` varchar(255) DEFAULT NULL,
  `emailpref` int(11) DEFAULT '0',
  `paypalaccount` varchar(255) DEFAULT NULL,
  `privilege` int(11) DEFAULT '0',
  `grade` varchar(255) DEFAULT NULL,
  `accountbalance` float DEFAULT '0',
  `violationcount` int(11) DEFAULT '0',
  `deactivated` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_instructors_on_email` (`email`),
  UNIQUE KEY `index_instructors_on_reset_password_token` (`reset_password_token`),
  UNIQUE KEY `index_instructors_on_confirmation_token` (`confirmation_token`),
  UNIQUE KEY `index_instructors_on_unlock_token` (`unlock_token`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=3 ;

--
-- Dumping data for table `instructors`
--

INSERT INTO `instructors` (`id`, `email`, `encrypted_password`, `reset_password_token`, `reset_password_sent_at`, `remember_created_at`, `sign_in_count`, `current_sign_in_at`, `last_sign_in_at`, `current_sign_in_ip`, `last_sign_in_ip`, `confirmation_token`, `confirmed_at`, `confirmation_sent_at`, `unconfirmed_email`, `failed_attempts`, `unlock_token`, `locked_at`, `created_at`, `updated_at`, `firstname`, `lastname`, `username`, `emailpref`, `paypalaccount`, `privilege`, `grade`, `accountbalance`, `violationcount`, `deactivated`) VALUES
(1, 'mcoomey@gmail.com', '$2a$10$1YXIZI71L3dwoDcdWWhSdO.Rd.yOElep4s0b1UOFC1iyVInqejVk.', NULL, NULL, NULL, 6, '2014-10-31 15:36:24', '2014-10-31 13:06:38', '127.0.0.1', '127.0.0.1', NULL, '2014-10-22 13:09:51', '2014-10-22 13:09:22', NULL, 0, NULL, NULL, '2014-10-22 13:09:22', '2014-10-31 15:36:24', 'Michael', 'Coomey', 'mcoomey', 0, NULL, 0, NULL, 0, 0, 0),
(2, 'mwcoomey@gmail.com', '$2a$10$1YXIZI71L3dwoDcdWWhSdO.Rd.yOElep4s0b1UOFC1iyVInqejVk.', NULL, NULL, NULL, 4, '2014-10-29 18:45:46', '2014-10-27 23:29:19', '127.0.0.1', '127.0.0.1', NULL, '2014-10-22 13:09:51', '2014-10-22 13:09:22', NULL, 0, NULL, NULL, '2014-10-22 13:09:22', '2014-10-29 18:45:46', 'Michael', 'Coomey', 'mWcoomey', 0, NULL, 0, NULL, 0, 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `lessons`
--

CREATE TABLE IF NOT EXISTS `lessons` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) DEFAULT NULL,
  `page` varchar(255) DEFAULT NULL,
  `textbook_id` int(11) DEFAULT NULL,
  `instructor_id` int(11) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `links`
--

CREATE TABLE IF NOT EXISTS `links` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `description` varchar(255) DEFAULT NULL,
  `url` varchar(255) DEFAULT NULL,
  `course_asset_id` int(11) DEFAULT NULL,
  `archived` int(11) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `position` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=7 ;

--
-- Dumping data for table `links`
--

INSERT INTO `links` (`id`, `description`, `url`, `course_asset_id`, `archived`, `created_at`, `updated_at`, `position`) VALUES
(3, '1', '1', 5, 0, '2014-10-23 21:12:30', '2014-10-23 21:12:30', 1),
(4, '2', '2', 5, 0, '2014-10-23 21:12:36', '2014-10-28 18:21:42', 2),
(6, '4', '4', 5, 0, '2014-10-23 21:12:50', '2014-10-28 18:21:44', 3);

-- --------------------------------------------------------

--
-- Table structure for table `parents`
--

CREATE TABLE IF NOT EXISTS `parents` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `email` varchar(255) NOT NULL DEFAULT '',
  `encrypted_password` varchar(255) NOT NULL DEFAULT '',
  `reset_password_token` varchar(255) DEFAULT NULL,
  `reset_password_sent_at` datetime DEFAULT NULL,
  `remember_created_at` datetime DEFAULT NULL,
  `sign_in_count` int(11) DEFAULT '0',
  `current_sign_in_at` datetime DEFAULT NULL,
  `last_sign_in_at` datetime DEFAULT NULL,
  `current_sign_in_ip` varchar(255) DEFAULT NULL,
  `last_sign_in_ip` varchar(255) DEFAULT NULL,
  `confirmation_token` varchar(255) DEFAULT NULL,
  `confirmed_at` datetime DEFAULT NULL,
  `confirmation_sent_at` datetime DEFAULT NULL,
  `unconfirmed_email` varchar(255) DEFAULT NULL,
  `failed_attempts` int(11) DEFAULT '0',
  `unlock_token` varchar(255) DEFAULT NULL,
  `locked_at` datetime DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `firstname` varchar(255) DEFAULT NULL,
  `lastname` varchar(255) DEFAULT NULL,
  `deactivated` tinyint(1) DEFAULT '0',
  `username` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_parents_on_email` (`email`),
  UNIQUE KEY `index_parents_on_reset_password_token` (`reset_password_token`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `parent_emails`
--

CREATE TABLE IF NOT EXISTS `parent_emails` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `student_id` int(11) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `index_parent_emails_on_student_id_and_email` (`student_id`,`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `roles`
--

CREATE TABLE IF NOT EXISTS `roles` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=5 ;

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
  `roleable_type` varchar(255) DEFAULT NULL,
  `roleable_id` int(11) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=3 ;

--
-- Dumping data for table `role_assignments`
--

INSERT INTO `role_assignments` (`id`, `role_id`, `roleable_type`, `roleable_id`, `created_at`, `updated_at`) VALUES
(1, 2, 'Instructor', 1, '2014-10-22 13:09:24', '2014-10-22 13:09:24'),
(2, 3, 'Student', 1, '2014-10-29 18:09:23', '2014-10-29 18:09:23');

-- --------------------------------------------------------

--
-- Table structure for table `schema_migrations`
--

CREATE TABLE IF NOT EXISTS `schema_migrations` (
  `version` varchar(255) NOT NULL,
  UNIQUE KEY `unique_schema_migrations` (`version`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

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
('20141014234537'),
('20141017001404'),
('20141031174336');

-- --------------------------------------------------------

--
-- Table structure for table `schools`
--

CREATE TABLE IF NOT EXISTS `schools` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `town` varchar(255) DEFAULT NULL,
  `state` varchar(255) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=3 ;

--
-- Dumping data for table `schools`
--

INSERT INTO `schools` (`id`, `name`, `town`, `state`, `created_at`, `updated_at`) VALUES
(1, 'Oxford High School', 'Oxford', 'MA', '2014-10-22 10:00:05', '2014-10-22 10:00:05'),
(2, 'Wachusett Regional High School', 'Holden', 'MA', '2014-10-29 18:09:21', '2014-10-29 18:09:21');

-- --------------------------------------------------------

--
-- Table structure for table `school_memberships`
--

CREATE TABLE IF NOT EXISTS `school_memberships` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `school_id` int(11) DEFAULT NULL,
  `schoolmember_id` int(11) DEFAULT NULL,
  `schoolmember_type` varchar(255) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `index_school_memberships_on_id_and_type` (`schoolmember_id`,`schoolmember_type`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=4 ;

--
-- Dumping data for table `school_memberships`
--

INSERT INTO `school_memberships` (`id`, `school_id`, `schoolmember_id`, `schoolmember_type`, `created_at`, `updated_at`) VALUES
(1, 1, 1, 'Instructor', '2014-10-22 10:00:07', '2014-10-22 10:00:07'),
(2, 1, 2, 'Instructor', '2014-10-22 13:09:24', '2014-10-22 13:09:24'),
(3, 2, 1, 'Student', '2014-10-29 18:09:22', '2014-10-29 18:09:22');

-- --------------------------------------------------------

--
-- Table structure for table `section_titles`
--

CREATE TABLE IF NOT EXISTS `section_titles` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `textbook_id` int(11) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=2 ;

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
-- Table structure for table `students`
--

CREATE TABLE IF NOT EXISTS `students` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `email` varchar(255) NOT NULL DEFAULT '',
  `encrypted_password` varchar(255) NOT NULL DEFAULT '',
  `reset_password_token` varchar(255) DEFAULT NULL,
  `reset_password_sent_at` datetime DEFAULT NULL,
  `remember_created_at` datetime DEFAULT NULL,
  `sign_in_count` int(11) DEFAULT '0',
  `current_sign_in_at` datetime DEFAULT NULL,
  `last_sign_in_at` datetime DEFAULT NULL,
  `current_sign_in_ip` varchar(255) DEFAULT NULL,
  `last_sign_in_ip` varchar(255) DEFAULT NULL,
  `confirmation_token` varchar(255) DEFAULT NULL,
  `confirmed_at` datetime DEFAULT NULL,
  `confirmation_sent_at` datetime DEFAULT NULL,
  `unconfirmed_email` varchar(255) DEFAULT NULL,
  `failed_attempts` int(11) DEFAULT '0',
  `unlock_token` varchar(255) DEFAULT NULL,
  `locked_at` datetime DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `firstname` varchar(255) DEFAULT NULL,
  `lastname` varchar(255) DEFAULT NULL,
  `username` varchar(255) DEFAULT NULL,
  `emailpref` int(11) DEFAULT '0',
  `paypalaccount` varchar(255) DEFAULT NULL,
  `privilege` int(11) DEFAULT '0',
  `grade` varchar(255) DEFAULT NULL,
  `accountbalance` float DEFAULT '0',
  `violationcount` int(11) DEFAULT '0',
  `deactivated` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_students_on_email` (`email`),
  UNIQUE KEY `index_students_on_reset_password_token` (`reset_password_token`),
  UNIQUE KEY `index_students_on_confirmation_token` (`confirmation_token`),
  UNIQUE KEY `index_students_on_unlock_token` (`unlock_token`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=2 ;

--
-- Dumping data for table `students`
--

INSERT INTO `students` (`id`, `email`, `encrypted_password`, `reset_password_token`, `reset_password_sent_at`, `remember_created_at`, `sign_in_count`, `current_sign_in_at`, `last_sign_in_at`, `current_sign_in_ip`, `last_sign_in_ip`, `confirmation_token`, `confirmed_at`, `confirmation_sent_at`, `unconfirmed_email`, `failed_attempts`, `unlock_token`, `locked_at`, `created_at`, `updated_at`, `firstname`, `lastname`, `username`, `emailpref`, `paypalaccount`, `privilege`, `grade`, `accountbalance`, `violationcount`, `deactivated`) VALUES
(1, 'spamfreemwc@gmail.com', '$2a$10$4qfldfqkioNkbFoYIBm9Te.T8F8dhYYUz3D2e1hYHjny3B1XbTY6u', NULL, NULL, NULL, 2, '2014-10-31 13:40:44', '2014-10-29 18:10:05', '127.0.0.1', '127.0.0.1', NULL, '2014-10-29 18:10:05', '2014-10-29 18:09:21', NULL, 0, NULL, NULL, '2014-10-29 18:09:21', '2014-10-31 13:40:44', 'Spam', 'Free', 'Spammy', 0, NULL, 0, NULL, 0, 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `subjects`
--

CREATE TABLE IF NOT EXISTS `subjects` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `student_id` int(11) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `archived` tinyint(1) DEFAULT NULL,
  `term` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `position` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=5 ;

--
-- Dumping data for table `subjects`
--

INSERT INTO `subjects` (`id`, `name`, `student_id`, `created_at`, `updated_at`, `archived`, `term`, `description`, `position`) VALUES
(1, 'Sub 1', 1, '2014-10-30 14:40:23', '2014-10-30 15:18:12', 0, 'A14', 'M, Tu, Th, F - Block 5', 1),
(2, 'Sub 2', 1, '2014-10-30 15:17:03', '2014-10-30 15:20:13', 0, '2', '2nd subject', 2),
(3, 'Sub 3', 1, '2014-10-30 15:17:30', '2014-10-31 01:12:07', 0, '3', '3rd subject', 3),
(4, 'Sub 4', 1, '2014-10-30 15:17:53', '2014-10-31 01:12:07', 1, '4', '4th subject', 1);

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
  `isbn13` varchar(255) DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `author` varchar(255) DEFAULT NULL,
  `publisher` varchar(255) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `image_link` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=5 ;

--
-- Dumping data for table `textbooks`
--

INSERT INTO `textbooks` (`id`, `isbn13`, `title`, `author`, `publisher`, `created_at`, `updated_at`, `image_link`) VALUES
(1, '9780130523167', 'Algebra 1', 'Allan Bellman, Sadie Chavis Bragg, Randall I. Charles', 'Pearson Prentice Hall', '2014-10-22 14:30:48', '2014-10-22 14:30:48', 'http://bks5.books.google.com/books?id=Rd4tQwAACAAJ&printsec=frontcover&img=1&zoom=1&source=gbs_api'),
(2, '9780321557643', 'Intermediate Algebra', 'Margaret L. Lial, John Hornsby, Terry McGinnis', 'Addison-Wesley Longman', '2014-10-22 14:34:20', '2014-10-22 14:34:20', 'http://bks5.books.google.com/books?id=2OlJPgAACAAJ&printsec=frontcover&img=1&zoom=1&source=gbs_api'),
(3, '9780078746376', 'Glencoe Chemistry: Matter and Change, Student Edition', 'McGraw-Hill, Glencoe', 'Glencoe/McGraw-Hill', '2014-10-22 15:32:36', '2014-10-22 15:32:36', 'http://bks5.books.google.com/books?id=OZInPwAACAAJ&printsec=frontcover&img=1&zoom=1&source=gbs_api'),
(4, '9780131101630', 'The C Programming Language', 'Brian W. Kernighan', 'Prentice Hall PTR', '2014-10-25 18:20:54', '2014-10-25 18:20:54', 'http://bks2.books.google.com/books?id=fMKTngEACAAJ&printsec=frontcover&img=1&zoom=1&source=gbs_api');

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
  KEY `index_textbook_delegations_on_textbook_id_and_subject_id` (`textbook_id`),
  KEY `index_textbook_delegations_on_textable_id_and_textable_type` (`course_asset_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=4 ;

--
-- Dumping data for table `textbook_delegations`
--

INSERT INTO `textbook_delegations` (`id`, `textbook_id`, `created_at`, `updated_at`, `course_asset_id`, `archived`, `position`) VALUES
(3, 1, '2014-10-24 01:47:22', '2014-10-25 18:14:33', 1, 0, 1);

-- --------------------------------------------------------

--
-- Table structure for table `textbook_videos`
--

CREATE TABLE IF NOT EXISTS `textbook_videos` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `videofile` varchar(255) DEFAULT NULL,
  `length` varchar(255) DEFAULT NULL,
  `videofile_processed` int(11) DEFAULT NULL,
  `videoable_type` varchar(255) DEFAULT NULL,
  `videoable_id` int(11) DEFAULT NULL,
  `textbook_id` int(11) DEFAULT NULL,
  `instructor_id` int(11) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `old_version_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_textbook_videos_on_videoable_id_and_videoable_type` (`videoable_id`,`videoable_type`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=7 ;

--
-- Dumping data for table `textbook_videos`
--

INSERT INTO `textbook_videos` (`id`, `videofile`, `length`, `videofile_processed`, `videoable_type`, `videoable_id`, `textbook_id`, `instructor_id`, `created_at`, `updated_at`, `old_version_id`) VALUES
(2, 'Wildlife_512kb.mp4', '00:00:30.07', 1, 'Exercise', 1, 1, 1, '2014-10-22 22:15:13', '2014-10-22 22:17:05', NULL),
(4, 'Wildlife_512kb.mp4', '00:00:30.07', 1, 'Exercise', 1, 1, 1, '2014-10-28 01:42:35', '2014-10-28 01:50:34', NULL),
(6, 'short.mp4', '00:00:08.55', 1, 'Exercise', 3, 1, 1, '2014-10-28 10:48:02', '2014-10-28 10:52:50', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `textboxes`
--

CREATE TABLE IF NOT EXISTS `textboxes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `content` text,
  `course_asset_id` int(11) DEFAULT NULL,
  `archived` int(11) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `position` int(11) DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=9 ;

--
-- Dumping data for table `textboxes`
--

INSERT INTO `textboxes` (`id`, `content`, `course_asset_id`, `archived`, `created_at`, `updated_at`, `position`, `title`) VALUES
(2, 'Textbox 2', 4, 0, '2014-10-23 19:45:28', '2014-10-29 16:21:43', 1, 'tb#2');

-- --------------------------------------------------------

--
-- Table structure for table `videos`
--

CREATE TABLE IF NOT EXISTS `videos` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `videofile` varchar(255) DEFAULT NULL,
  `length` varchar(255) DEFAULT NULL,
  `archived` int(11) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `videofile_processed` int(11) DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `position` int(11) DEFAULT NULL,
  `course_asset_id` int(11) DEFAULT NULL,
  `instructor_id` int(11) DEFAULT NULL,
  `old_version_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=7 ;

--
-- Dumping data for table `videos`
--

INSERT INTO `videos` (`id`, `videofile`, `length`, `archived`, `created_at`, `updated_at`, `videofile_processed`, `title`, `description`, `position`, `course_asset_id`, `instructor_id`, `old_version_id`) VALUES
(2, 'Wildlife_512kb.mp4', '00:00:30.07', 1, '2014-10-23 00:06:14', '2014-10-28 16:05:57', 1, 'Short1', 'The short  video', 3, 2, 1, NULL),
(3, 'short.mp4', '00:00:08.55', 1, '2014-10-23 01:00:10', '2014-10-28 16:17:55', 1, 'Short & Sweet', 'A short video about Answer Companion', 1, 2, 1, NULL),
(4, 'Kate_magic.mp4', '00:00:44.84', 2, '2014-10-23 10:10:02', '2014-10-23 10:16:32', 1, 'Future', 'Into the future', 1, 2, 1, NULL),
(5, 'Wildlife_512kb.mp4', '00:00:30.07', 1, '2014-10-23 11:18:26', '2014-10-23 11:20:31', 1, 'newest', 'newest ca video', 2, 2, 1, NULL),
(6, 'Kate_magic_copy.mp4', '00:00:44.84', 2, '2014-10-23 11:19:01', '2014-10-23 11:27:33', 1, 'Magic Show', 'copy', 2, 2, 1, NULL);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
