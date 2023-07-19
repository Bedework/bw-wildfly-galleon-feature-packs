-- MySQL dump 10.13  Distrib 8.0.33, for Linux (aarch64)
--
-- Host: localhost    Database: calprddb00
-- ------------------------------------------------------
-- Server version	8.0.33-0ubuntu0.22.04.2

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `bw_admingroupmembers`
--

DROP TABLE IF EXISTS `bw_admingroupmembers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bw_admingroupmembers` (
  `bw_groupid` int NOT NULL,
  `memberid` int NOT NULL,
  `member_is_group` char(1) NOT NULL,
  PRIMARY KEY (`bw_groupid`,`memberid`,`member_is_group`),
  KEY `bw_agm_ag_fk` (`bw_groupid`),
  CONSTRAINT `bw_agm_ag_fk` FOREIGN KEY (`bw_groupid`) REFERENCES `bw_admingroups` (`bw_groupid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `bw_admingroups`
--

DROP TABLE IF EXISTS `bw_admingroups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bw_admingroups` (
  `bw_groupid` int NOT NULL AUTO_INCREMENT,
  `bwseq` int NOT NULL,
  `account` varchar(255) NOT NULL,
  `bw_principal_ref` varchar(255) NOT NULL,
  `description` varchar(2000) DEFAULT NULL,
  `bw_group_owner` varchar(255) NOT NULL,
  `bw_owner` varchar(255) NOT NULL,
  PRIMARY KEY (`bw_groupid`),
  UNIQUE KEY `account` (`account`),
  KEY `bwidx_ag_href` (`bw_principal_ref`),
  KEY `bwidx_ag_owner` (`bw_owner`),
  KEY `bwidx_ag_group_owner` (`bw_group_owner`)
) ENGINE=InnoDB AUTO_INCREMENT=312 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `bw_alarm_attendees`
--

DROP TABLE IF EXISTS `bw_alarm_attendees`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bw_alarm_attendees` (
  `alarmid` int NOT NULL,
  `attendeeid` int NOT NULL,
  PRIMARY KEY (`alarmid`,`attendeeid`),
  KEY `bw_aa_att_fk` (`attendeeid`),
  KEY `bw_aa_alarm_fk` (`alarmid`),
  CONSTRAINT `bw_aa_alarm_fk` FOREIGN KEY (`alarmid`) REFERENCES `bw_alarms` (`alarmid`),
  CONSTRAINT `bw_aa_att_fk` FOREIGN KEY (`attendeeid`) REFERENCES `bw_attendees` (`attendeeid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `bw_alarmdescriptions`
--

DROP TABLE IF EXISTS `bw_alarmdescriptions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bw_alarmdescriptions` (
  `bw_alarmid` int NOT NULL,
  `bw_strid` int NOT NULL,
  PRIMARY KEY (`bw_alarmid`,`bw_strid`),
  UNIQUE KEY `bw_strid` (`bw_strid`),
  KEY `bw_ad_str_fk` (`bw_strid`),
  KEY `bw_ad_alarm_fk` (`bw_alarmid`),
  CONSTRAINT `bw_ad_alarm_fk` FOREIGN KEY (`bw_alarmid`) REFERENCES `bw_alarms` (`alarmid`),
  CONSTRAINT `bw_ad_str_fk` FOREIGN KEY (`bw_strid`) REFERENCES `bw_strings` (`bw_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `bw_alarms`
--

DROP TABLE IF EXISTS `bw_alarms`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bw_alarms` (
  `alarmid` int NOT NULL AUTO_INCREMENT,
  `bwseq` int NOT NULL,
  `alarm_type` int DEFAULT NULL,
  `bw_owner` varchar(255) NOT NULL,
  `publick` char(1) NOT NULL,
  `trigger_rfctime` varchar(16) DEFAULT NULL,
  `trigger_start` char(1) NOT NULL,
  `duration` varchar(100) DEFAULT NULL,
  `repetitions` int DEFAULT NULL,
  `attach` varchar(2000) DEFAULT NULL,
  `trigger_time` varchar(16) DEFAULT NULL,
  `previous_trigger` varchar(16) DEFAULT NULL,
  `repeat_count` int DEFAULT NULL,
  `expired` char(1) NOT NULL,
  PRIMARY KEY (`alarmid`),
  KEY `bwidx_alarm_owner` (`bw_owner`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `bw_alarmsummaries`
--

DROP TABLE IF EXISTS `bw_alarmsummaries`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bw_alarmsummaries` (
  `bw_alarmid` int NOT NULL,
  `bw_strid` int NOT NULL,
  PRIMARY KEY (`bw_alarmid`,`bw_strid`),
  UNIQUE KEY `bw_strid` (`bw_strid`),
  KEY `bw_as_str_fk` (`bw_strid`),
  KEY `bw_as_alarm_fk` (`bw_alarmid`),
  CONSTRAINT `bw_as_alarm_fk` FOREIGN KEY (`bw_alarmid`) REFERENCES `bw_alarms` (`alarmid`),
  CONSTRAINT `bw_as_str_fk` FOREIGN KEY (`bw_strid`) REFERENCES `bw_strings` (`bw_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `bw_attachments`
--

DROP TABLE IF EXISTS `bw_attachments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bw_attachments` (
  `bwid` int NOT NULL AUTO_INCREMENT,
  `bw_fmttype` varchar(20) DEFAULT NULL,
  `bw_valuetype` varchar(20) DEFAULT NULL,
  `bw_encoding` varchar(2000) DEFAULT NULL,
  `bw_uri` varchar(2000) DEFAULT NULL,
  `bw_value` longtext,
  PRIMARY KEY (`bwid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `bw_attendees`
--

DROP TABLE IF EXISTS `bw_attendees`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bw_attendees` (
  `attendeeid` int NOT NULL AUTO_INCREMENT,
  `cn` varchar(2000) DEFAULT NULL,
  `cutype` varchar(2000) DEFAULT NULL,
  `delegated_from` varchar(2000) DEFAULT NULL,
  `delegated_to` varchar(2000) DEFAULT NULL,
  `dir` varchar(2000) DEFAULT NULL,
  `lang` varchar(100) DEFAULT NULL,
  `member` varchar(2000) DEFAULT NULL,
  `rsvp` char(1) DEFAULT NULL,
  `role` varchar(200) DEFAULT NULL,
  `partstat` varchar(100) DEFAULT NULL,
  `sent_by` varchar(2000) DEFAULT NULL,
  `attendee_uri` varchar(2000) DEFAULT NULL,
  `rfcsequence` int DEFAULT NULL,
  `bw_sched_agent` int DEFAULT NULL,
  `bw_sched_status` varchar(100) DEFAULT NULL,
  `dtstamp` varchar(16) DEFAULT NULL,
  PRIMARY KEY (`attendeeid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `bw_auth`
--

DROP TABLE IF EXISTS `bw_auth`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bw_auth` (
  `userid` int NOT NULL AUTO_INCREMENT,
  `bwseq` int NOT NULL,
  `bw_user` varchar(255) NOT NULL,
  `autoaddCategories` char(1) NOT NULL,
  `autoaddLocations` char(1) NOT NULL,
  `autoaddContacts` char(1) NOT NULL,
  `autoaddCalendars` char(1) NOT NULL,
  `usertype` int DEFAULT NULL,
  PRIMARY KEY (`userid`),
  KEY `bwidx_au_user` (`bw_user`)
) ENGINE=InnoDB AUTO_INCREMENT=1439 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `bw_authprefcalendars`
--

DROP TABLE IF EXISTS `bw_authprefcalendars`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bw_authprefcalendars` (
  `userid` int NOT NULL,
  `calendarid` int NOT NULL,
  PRIMARY KEY (`userid`,`calendarid`),
  KEY `bw_apcat_cal_fk1` (`calendarid`),
  KEY `bw_apcal_ap_fk1` (`userid`),
  CONSTRAINT `bw_apcal_ap_fk1` FOREIGN KEY (`userid`) REFERENCES `bw_auth` (`userid`),
  CONSTRAINT `bw_apcat_cal_fk1` FOREIGN KEY (`calendarid`) REFERENCES `bw_calendars` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `bw_authprefcategories`
--

DROP TABLE IF EXISTS `bw_authprefcategories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bw_authprefcategories` (
  `userid` int NOT NULL,
  `categoryid` int NOT NULL,
  PRIMARY KEY (`userid`,`categoryid`),
  KEY `bw_apcat_ap_fk1` (`userid`),
  KEY `bw_apcat_cat_fk1` (`categoryid`),
  CONSTRAINT `bw_apcat_ap_fk1` FOREIGN KEY (`userid`) REFERENCES `bw_auth` (`userid`),
  CONSTRAINT `bw_apcat_cat_fk1` FOREIGN KEY (`categoryid`) REFERENCES `bw_categories` (`categoryid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `bw_authprefcontacts`
--

DROP TABLE IF EXISTS `bw_authprefcontacts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bw_authprefcontacts` (
  `userid` int NOT NULL,
  `contactid` int NOT NULL,
  PRIMARY KEY (`userid`,`contactid`),
  KEY `bw_apcon_ap_fk1` (`userid`),
  KEY `bw_apcon_con_fk1` (`contactid`),
  CONSTRAINT `bw_apcon_ap_fk1` FOREIGN KEY (`userid`) REFERENCES `bw_auth` (`userid`),
  CONSTRAINT `bw_apcon_con_fk1` FOREIGN KEY (`contactid`) REFERENCES `bw_contacts` (`entityid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `bw_authpreflocations`
--

DROP TABLE IF EXISTS `bw_authpreflocations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bw_authpreflocations` (
  `userid` int NOT NULL,
  `locationid` int NOT NULL,
  PRIMARY KEY (`userid`,`locationid`),
  KEY `bw_aploc_ap_fk1` (`userid`),
  KEY `bw_aploc_loc_fk1` (`locationid`),
  CONSTRAINT `bw_aploc_ap_fk1` FOREIGN KEY (`userid`) REFERENCES `bw_auth` (`userid`),
  CONSTRAINT `bw_aploc_loc_fk1` FOREIGN KEY (`locationid`) REFERENCES `bw_locations` (`entityid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `bw_calendar_categories`
--

DROP TABLE IF EXISTS `bw_calendar_categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bw_calendar_categories` (
  `calendarid` int NOT NULL,
  `categoryid` int NOT NULL,
  PRIMARY KEY (`calendarid`,`categoryid`),
  KEY `bw_calcat_cid_fk` (`calendarid`),
  KEY `bw_cal_cat_fk` (`categoryid`),
  CONSTRAINT `bw_cal_cat_fk` FOREIGN KEY (`categoryid`) REFERENCES `bw_categories` (`categoryid`),
  CONSTRAINT `bw_calcat_cid_fk` FOREIGN KEY (`calendarid`) REFERENCES `bw_calendars` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `bw_calendar_properties`
--

DROP TABLE IF EXISTS `bw_calendar_properties`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bw_calendar_properties` (
  `bwid` int NOT NULL,
  `bw_name` varchar(200) DEFAULT NULL,
  `bw_value` longtext,
  KEY `bw_calprp_pid_fk` (`bwid`),
  CONSTRAINT `bw_calprp_pid_fk` FOREIGN KEY (`bwid`) REFERENCES `bw_calendars` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `bw_calendars`
--

DROP TABLE IF EXISTS `bw_calendars`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bw_calendars` (
  `id` int NOT NULL AUTO_INCREMENT,
  `bwseq` int NOT NULL,
  `bw_creator` varchar(255) DEFAULT NULL,
  `bw_owner` varchar(255) DEFAULT NULL,
  `bwaccess` varchar(3900) DEFAULT NULL,
  `publick` char(1) NOT NULL,
  `calname` varchar(100) NOT NULL,
  `bwpath` varchar(3000) NOT NULL,
  `bw_col_path` varchar(3000) DEFAULT NULL,
  `summary` varchar(500) DEFAULT NULL,
  `description` varchar(1000) DEFAULT NULL,
  `mail_list_id` varchar(200) DEFAULT NULL,
  `caltype` int NOT NULL,
  `bw_created` varchar(16) NOT NULL,
  `bw_filterexpr` longtext,
  `bw_alias_uri` varchar(500) DEFAULT NULL,
  `display` char(1) NOT NULL,
  `affects_free_busy` char(1) NOT NULL,
  `ignore_transparency` char(1) NOT NULL,
  `unremoveable` char(1) NOT NULL,
  `bwrefreshseconds` int DEFAULT NULL,
  `bwlastrefresh` varchar(16) DEFAULT NULL,
  `bwlastetag` varchar(256) DEFAULT NULL,
  `bwrid` varchar(256) DEFAULT NULL,
  `bwrpw` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `bwidx_cal_owner` (`bw_owner`),
  KEY `bwidx_calpath` (`bwpath`(255)),
  KEY `bwidx_cal_colpath` (`bw_col_path`(255)),
  KEY `bwidx_cal_creator` (`bw_creator`)
) ENGINE=InnoDB AUTO_INCREMENT=28225 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `bw_calsuites`
--

DROP TABLE IF EXISTS `bw_calsuites`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bw_calsuites` (
  `csid` int NOT NULL AUTO_INCREMENT,
  `bwseq` int NOT NULL,
  `bw_creator` varchar(255) DEFAULT NULL,
  `bw_owner` varchar(255) DEFAULT NULL,
  `bwaccess` varchar(3900) DEFAULT NULL,
  `publick` char(1) NOT NULL,
  `csname` varchar(255) NOT NULL,
  `groupid` int NOT NULL,
  `bw_root_collection` varchar(3000) DEFAULT NULL,
  `bw_submissions_root` varchar(3000) DEFAULT NULL,
  PRIMARY KEY (`csid`),
  UNIQUE KEY `csname` (`csname`),
  KEY `bwidx_cs_rootcol` (`bw_root_collection`(255)),
  KEY `bwidx_cs_subroot` (`bw_submissions_root`(255)),
  KEY `bwidx_calsuite_group` (`groupid`),
  KEY `bwidx_cals_owner` (`bw_owner`),
  KEY `bwidx_cals_creator` (`bw_creator`),
  KEY `bw_cs_ag_fk` (`groupid`),
  CONSTRAINT `bw_cs_ag_fk` FOREIGN KEY (`groupid`) REFERENCES `bw_admingroups` (`bw_groupid`)
) ENGINE=InnoDB AUTO_INCREMENT=177 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `bw_categories`
--

DROP TABLE IF EXISTS `bw_categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bw_categories` (
  `categoryid` int NOT NULL AUTO_INCREMENT,
  `bwseq` int NOT NULL,
  `bw_creator` varchar(255) DEFAULT NULL,
  `bw_owner` varchar(255) DEFAULT NULL,
  `bwaccess` varchar(3900) DEFAULT NULL,
  `publick` char(1) NOT NULL,
  `bw_catwdid` int NOT NULL,
  `bw_catdescid` int DEFAULT NULL,
  `bw_uid` varchar(50) NOT NULL,
  PRIMARY KEY (`categoryid`),
  UNIQUE KEY `bw_catwdid` (`bw_catwdid`),
  UNIQUE KEY `bw_uid` (`bw_uid`),
  UNIQUE KEY `bw_catdescid` (`bw_catdescid`),
  KEY `bwidx_category_uid` (`bw_uid`),
  KEY `bwidx_cat_creator` (`bw_creator`),
  KEY `bwidx_cat_owner` (`bw_owner`),
  KEY `bw_cat_desc_fk` (`bw_catdescid`),
  KEY `bw_cat_wd_fk` (`bw_catwdid`),
  CONSTRAINT `bw_cat_desc_fk` FOREIGN KEY (`bw_catdescid`) REFERENCES `bw_strings` (`bw_id`),
  CONSTRAINT `bw_cat_wd_fk` FOREIGN KEY (`bw_catwdid`) REFERENCES `bw_strings` (`bw_id`)
) ENGINE=InnoDB AUTO_INCREMENT=757 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `bw_collection_lastmods`
--

DROP TABLE IF EXISTS `bw_collection_lastmods`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bw_collection_lastmods` (
  `bw_id` int NOT NULL,
  `bwpath` varchar(3000) NOT NULL,
  `bw_timestamp` varchar(16) NOT NULL,
  `bw_sequence` int DEFAULT NULL,
  PRIMARY KEY (`bw_id`),
  KEY `bwidx_collm_path` (`bwpath`(255)),
  KEY `FK816FC2DE293D1D8D` (`bw_id`),
  CONSTRAINT `FK816FC2DE293D1D8D` FOREIGN KEY (`bw_id`) REFERENCES `bw_calendars` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `bw_contacts`
--

DROP TABLE IF EXISTS `bw_contacts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bw_contacts` (
  `entityid` int NOT NULL AUTO_INCREMENT,
  `bwseq` int NOT NULL,
  `bw_creator` varchar(255) DEFAULT NULL,
  `bw_owner` varchar(255) DEFAULT NULL,
  `bwaccess` varchar(3900) DEFAULT NULL,
  `publick` char(1) NOT NULL,
  `bw_uid` varchar(50) NOT NULL,
  `bw_connameid` int NOT NULL,
  `bw_phone` varchar(255) DEFAULT NULL,
  `bw_email` varchar(255) DEFAULT NULL,
  `bw_link` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`entityid`),
  UNIQUE KEY `bw_uid` (`bw_uid`),
  UNIQUE KEY `bw_connameid` (`bw_connameid`),
  KEY `bwidx_con_creator` (`bw_creator`),
  KEY `bwidx_con_owner` (`bw_owner`),
  KEY `bwidx_contact_uid` (`bw_uid`),
  KEY `bw_con_name_fk` (`bw_connameid`),
  CONSTRAINT `bw_con_name_fk` FOREIGN KEY (`bw_connameid`) REFERENCES `bw_strings` (`bw_id`)
) ENGINE=InnoDB AUTO_INCREMENT=359 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `bw_entity_alarms`
--

DROP TABLE IF EXISTS `bw_entity_alarms`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bw_entity_alarms` (
  `eventid` int NOT NULL,
  `alarmid` int NOT NULL,
  PRIMARY KEY (`eventid`,`alarmid`),
  KEY `bw_eventalm_eid_fk` (`eventid`),
  KEY `bw_event_alarm_fk` (`alarmid`),
  CONSTRAINT `bw_event_alarm_fk` FOREIGN KEY (`alarmid`) REFERENCES `bw_alarms` (`alarmid`),
  CONSTRAINT `bw_eventalm_eid_fk` FOREIGN KEY (`eventid`) REFERENCES `bw_events` (`eventid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `bw_entity_attachments`
--

DROP TABLE IF EXISTS `bw_entity_attachments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bw_entity_attachments` (
  `eventid` int NOT NULL,
  `attachid` int NOT NULL,
  PRIMARY KEY (`eventid`,`attachid`),
  KEY `bw_eventattach_eid_fk` (`eventid`),
  KEY `bw_event_attach_fk` (`attachid`),
  CONSTRAINT `bw_event_attach_fk` FOREIGN KEY (`attachid`) REFERENCES `bw_attachments` (`bwid`),
  CONSTRAINT `bw_eventattach_eid_fk` FOREIGN KEY (`eventid`) REFERENCES `bw_events` (`eventid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `bw_event_annotations`
--

DROP TABLE IF EXISTS `bw_event_annotations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bw_event_annotations` (
  `eventid` int NOT NULL AUTO_INCREMENT,
  `bwseq` int NOT NULL,
  `bw_entity_type` int DEFAULT NULL,
  `bw_col_path` varchar(3000) NOT NULL,
  `eventname` varchar(500) DEFAULT NULL,
  `bw_uid` varchar(1000) DEFAULT NULL,
  `bw_creator` varchar(255) DEFAULT NULL,
  `bw_owner` varchar(255) DEFAULT NULL,
  `bwaccess` varchar(3900) DEFAULT NULL,
  `publick` char(1) DEFAULT NULL,
  `start_date_type` char(1) DEFAULT NULL,
  `start_tzid` varchar(255) DEFAULT NULL,
  `start_dtval` varchar(16) DEFAULT NULL,
  `start_date` varchar(16) DEFAULT NULL,
  `bw_start_floating` char(1) DEFAULT NULL,
  `end_date_type` char(1) DEFAULT NULL,
  `end_tzid` varchar(255) DEFAULT NULL,
  `end_dtval` varchar(16) DEFAULT NULL,
  `end_date` varchar(16) DEFAULT NULL,
  `bw_end_floating` char(1) DEFAULT NULL,
  `duration` varchar(255) DEFAULT NULL,
  `end_type` char(1) DEFAULT NULL,
  `bw_nostart` char(1) DEFAULT NULL,
  `bw_deleted` char(1) DEFAULT NULL,
  `bwtombstoned` char(1) DEFAULT NULL,
  `bw_class` varchar(250) DEFAULT NULL,
  `bw_link` varchar(500) DEFAULT NULL,
  `bw_geolatitude` decimal(19,2) DEFAULT NULL,
  `bw_geolongitude` decimal(19,2) DEFAULT NULL,
  `status` varchar(255) DEFAULT NULL,
  `cost` varchar(255) DEFAULT NULL,
  `bw_dtstamp` varchar(16) DEFAULT NULL,
  `bw_lastmod` varchar(16) DEFAULT NULL,
  `bw_created` varchar(16) DEFAULT NULL,
  `priority` int DEFAULT NULL,
  `locationid` int DEFAULT NULL,
  `rfcsequence` int DEFAULT NULL,
  `transparency` varchar(100) DEFAULT NULL,
  `percent_complete` int DEFAULT NULL,
  `completed` varchar(16) DEFAULT NULL,
  `recurring` char(1) DEFAULT NULL,
  `recurrence_id` varchar(16) DEFAULT NULL,
  `latest_date` varchar(255) DEFAULT NULL,
  `schedule_method` int DEFAULT NULL,
  `originator` varchar(255) DEFAULT NULL,
  `bw_org_cn` varchar(500) DEFAULT NULL,
  `bw_org_dir` varchar(500) DEFAULT NULL,
  `bw_org_lang` varchar(100) DEFAULT NULL,
  `bw_org_sentby` varchar(500) DEFAULT NULL,
  `bw_org_uri` varchar(500) DEFAULT NULL,
  `bw_org_sched_status` varchar(100) DEFAULT NULL,
  `bw_org_dtstamp` varchar(16) DEFAULT NULL,
  `bw_reltype` varchar(100) DEFAULT NULL,
  `bw_reltoval` varchar(500) DEFAULT NULL,
  `schedule_state` int DEFAULT NULL,
  `targetid` int DEFAULT NULL,
  `masterid` int DEFAULT NULL,
  `bw_override` char(1) NOT NULL,
  `bw_empty_flags` varchar(200) DEFAULT NULL,
  `bw_stag` varchar(21) DEFAULT NULL,
  PRIMARY KEY (`eventid`),
  KEY `bwidx_eann_recurring` (`recurring`),
  KEY `bwidx_eann_end` (`end_date`),
  KEY `bwidx_eann_start_floating` (`bw_start_floating`),
  KEY `bwidx_eann_deleted` (`bw_deleted`),
  KEY `bwidx_eann_colpath` (`bw_col_path`(255)),
  KEY `bwidx_eann_end_floating` (`bw_end_floating`),
  KEY `bwidx_eann_creator` (`bw_creator`),
  KEY `bwidx_eann_location` (`locationid`),
  KEY `bwidx_eann_owner` (`bw_owner`),
  KEY `bwidx_eann_start` (`start_date`),
  KEY `bwidx_eann_latest_date` (`latest_date`),
  KEY `bw_eann_tgt_fk` (`targetid`),
  KEY `bw_eann_mstr_fk` (`masterid`),
  KEY `bw_eann_loc_fk` (`locationid`),
  CONSTRAINT `bw_eann_loc_fk` FOREIGN KEY (`locationid`) REFERENCES `bw_locations` (`entityid`),
  CONSTRAINT `bw_eann_mstr_fk` FOREIGN KEY (`masterid`) REFERENCES `bw_events` (`eventid`),
  CONSTRAINT `bw_eann_tgt_fk` FOREIGN KEY (`targetid`) REFERENCES `bw_events` (`eventid`)
) ENGINE=InnoDB AUTO_INCREMENT=1729 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `bw_event_attendees`
--

DROP TABLE IF EXISTS `bw_event_attendees`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bw_event_attendees` (
  `eventid` int NOT NULL,
  `attendeeid` int NOT NULL,
  PRIMARY KEY (`eventid`,`attendeeid`),
  KEY `bw_event_att_fk` (`attendeeid`),
  KEY `bw_eventatt_eid_fk` (`eventid`),
  CONSTRAINT `bw_event_att_fk` FOREIGN KEY (`attendeeid`) REFERENCES `bw_attendees` (`attendeeid`),
  CONSTRAINT `bw_eventatt_eid_fk` FOREIGN KEY (`eventid`) REFERENCES `bw_events` (`eventid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `bw_event_availuids`
--

DROP TABLE IF EXISTS `bw_event_availuids`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bw_event_availuids` (
  `eventid` int NOT NULL,
  `avluid` varchar(255) NOT NULL,
  PRIMARY KEY (`eventid`,`avluid`),
  KEY `bw_event_avluid_fk` (`eventid`),
  CONSTRAINT `bw_event_avluid_fk` FOREIGN KEY (`eventid`) REFERENCES `bw_events` (`eventid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `bw_event_categories`
--

DROP TABLE IF EXISTS `bw_event_categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bw_event_categories` (
  `eventid` int NOT NULL,
  `categoryid` int NOT NULL,
  PRIMARY KEY (`eventid`,`categoryid`),
  KEY `bw_eventcat_eid_fk` (`eventid`),
  KEY `bw_event_cat_fk` (`categoryid`),
  CONSTRAINT `bw_event_cat_fk` FOREIGN KEY (`categoryid`) REFERENCES `bw_categories` (`categoryid`),
  CONSTRAINT `bw_eventcat_eid_fk` FOREIGN KEY (`eventid`) REFERENCES `bw_events` (`eventid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `bw_event_comments`
--

DROP TABLE IF EXISTS `bw_event_comments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bw_event_comments` (
  `bw_eventid` int NOT NULL,
  `bw_strid` int NOT NULL,
  PRIMARY KEY (`bw_eventid`,`bw_strid`),
  UNIQUE KEY `bw_strid` (`bw_strid`),
  KEY `bw_event_com_fk` (`bw_strid`),
  KEY `bw_eventcom_eid_fk` (`bw_eventid`),
  CONSTRAINT `bw_event_com_fk` FOREIGN KEY (`bw_strid`) REFERENCES `bw_strings` (`bw_id`),
  CONSTRAINT `bw_eventcom_eid_fk` FOREIGN KEY (`bw_eventid`) REFERENCES `bw_events` (`eventid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `bw_event_contacts`
--

DROP TABLE IF EXISTS `bw_event_contacts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bw_event_contacts` (
  `eventid` int NOT NULL,
  `contactid` int NOT NULL,
  PRIMARY KEY (`eventid`,`contactid`),
  KEY `bw_eventcon_eid_fk` (`eventid`),
  KEY `bw_event_con_fk` (`contactid`),
  CONSTRAINT `bw_event_con_fk` FOREIGN KEY (`contactid`) REFERENCES `bw_contacts` (`entityid`),
  CONSTRAINT `bw_eventcon_eid_fk` FOREIGN KEY (`eventid`) REFERENCES `bw_events` (`eventid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `bw_event_descriptions`
--

DROP TABLE IF EXISTS `bw_event_descriptions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bw_event_descriptions` (
  `bw_eventid` int NOT NULL,
  `bw_strid` int NOT NULL,
  PRIMARY KEY (`bw_eventid`,`bw_strid`),
  UNIQUE KEY `bw_strid` (`bw_strid`),
  KEY `bw_event_desc_fk` (`bw_strid`),
  KEY `bw_eventdesc_eid_fk` (`bw_eventid`),
  CONSTRAINT `bw_event_desc_fk` FOREIGN KEY (`bw_strid`) REFERENCES `bw_longstrings` (`bw_id`),
  CONSTRAINT `bw_eventdesc_eid_fk` FOREIGN KEY (`bw_eventid`) REFERENCES `bw_events` (`eventid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `bw_event_exdates`
--

DROP TABLE IF EXISTS `bw_event_exdates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bw_event_exdates` (
  `eventid` int NOT NULL,
  `ex_date_type` char(1) NOT NULL,
  `ex_tzid` varchar(255) DEFAULT NULL,
  `ex_dtval` varchar(16) NOT NULL,
  `ex_date` varchar(16) NOT NULL,
  PRIMARY KEY (`eventid`,`ex_date_type`,`ex_dtval`,`ex_date`),
  KEY `bwidx_event_exdate` (`ex_date`),
  KEY `bw_event_edate_fk` (`eventid`),
  CONSTRAINT `bw_event_edate_fk` FOREIGN KEY (`eventid`) REFERENCES `bw_events` (`eventid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `bw_event_exrules`
--

DROP TABLE IF EXISTS `bw_event_exrules`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bw_event_exrules` (
  `eventid` int NOT NULL,
  `exrule` varchar(255) NOT NULL,
  PRIMARY KEY (`eventid`,`exrule`),
  KEY `bw_event_erule_fk` (`eventid`),
  CONSTRAINT `bw_event_erule_fk` FOREIGN KEY (`eventid`) REFERENCES `bw_events` (`eventid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `bw_event_rdates`
--

DROP TABLE IF EXISTS `bw_event_rdates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bw_event_rdates` (
  `eventid` int NOT NULL,
  `r_date_type` char(1) NOT NULL,
  `r_tzid` varchar(255) DEFAULT NULL,
  `r_dtval` varchar(16) NOT NULL,
  `r_date` varchar(16) NOT NULL,
  PRIMARY KEY (`eventid`,`r_date_type`,`r_dtval`,`r_date`),
  KEY `bwidx_event_rdate` (`r_date`),
  KEY `bw_event_rdate_fk` (`eventid`),
  CONSTRAINT `bw_event_rdate_fk` FOREIGN KEY (`eventid`) REFERENCES `bw_events` (`eventid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `bw_event_recipients`
--

DROP TABLE IF EXISTS `bw_event_recipients`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bw_event_recipients` (
  `eventid` int NOT NULL,
  `recipient` varchar(255) NOT NULL,
  PRIMARY KEY (`eventid`,`recipient`),
  KEY `bw_event_recip_fk` (`eventid`),
  CONSTRAINT `bw_event_recip_fk` FOREIGN KEY (`eventid`) REFERENCES `bw_events` (`eventid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `bw_event_resources`
--

DROP TABLE IF EXISTS `bw_event_resources`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bw_event_resources` (
  `bw_eventid` int NOT NULL,
  `bw_strid` int NOT NULL,
  PRIMARY KEY (`bw_eventid`,`bw_strid`),
  UNIQUE KEY `bw_strid` (`bw_strid`),
  KEY `bw_event_res_fk` (`bw_strid`),
  KEY `bw_eventres_eid_fk` (`bw_eventid`),
  CONSTRAINT `bw_event_res_fk` FOREIGN KEY (`bw_strid`) REFERENCES `bw_strings` (`bw_id`),
  CONSTRAINT `bw_eventres_eid_fk` FOREIGN KEY (`bw_eventid`) REFERENCES `bw_events` (`eventid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `bw_event_rrules`
--

DROP TABLE IF EXISTS `bw_event_rrules`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bw_event_rrules` (
  `eventid` int NOT NULL,
  `rrule` varchar(255) NOT NULL,
  PRIMARY KEY (`eventid`,`rrule`),
  KEY `bw_event_rrule_fk` (`eventid`),
  CONSTRAINT `bw_event_rrule_fk` FOREIGN KEY (`eventid`) REFERENCES `bw_events` (`eventid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `bw_event_summaries`
--

DROP TABLE IF EXISTS `bw_event_summaries`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bw_event_summaries` (
  `bw_eventid` int NOT NULL,
  `bw_strid` int NOT NULL,
  PRIMARY KEY (`bw_eventid`,`bw_strid`),
  UNIQUE KEY `bw_strid` (`bw_strid`),
  KEY `bw_event_sum_fk` (`bw_strid`),
  KEY `bw_eventsum_eid_fk` (`bw_eventid`),
  CONSTRAINT `bw_event_sum_fk` FOREIGN KEY (`bw_strid`) REFERENCES `bw_strings` (`bw_id`),
  CONSTRAINT `bw_eventsum_eid_fk` FOREIGN KEY (`bw_eventid`) REFERENCES `bw_events` (`eventid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `bw_event_xprops`
--

DROP TABLE IF EXISTS `bw_event_xprops`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bw_event_xprops` (
  `bw_eventid` int NOT NULL,
  `bw_name` varchar(100) DEFAULT NULL,
  `bw_pars` varchar(4000) DEFAULT NULL,
  `bw_value` longtext,
  `bwxp_position` int NOT NULL,
  PRIMARY KEY (`bw_eventid`,`bwxp_position`),
  KEY `bw_eventxp_eid_fk` (`bw_eventid`),
  CONSTRAINT `bw_eventxp_eid_fk` FOREIGN KEY (`bw_eventid`) REFERENCES `bw_events` (`eventid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `bw_eventann_alarms`
--

DROP TABLE IF EXISTS `bw_eventann_alarms`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bw_eventann_alarms` (
  `eventid` int NOT NULL,
  `alarmid` int NOT NULL,
  PRIMARY KEY (`eventid`,`alarmid`),
  KEY `bw_eannalm_eid_fk` (`eventid`),
  KEY `bw_eann_alarm_fk` (`alarmid`),
  CONSTRAINT `bw_eann_alarm_fk` FOREIGN KEY (`alarmid`) REFERENCES `bw_alarms` (`alarmid`),
  CONSTRAINT `bw_eannalm_eid_fk` FOREIGN KEY (`eventid`) REFERENCES `bw_event_annotations` (`eventid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `bw_eventann_attachments`
--

DROP TABLE IF EXISTS `bw_eventann_attachments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bw_eventann_attachments` (
  `eventid` int NOT NULL,
  `attachid` int NOT NULL,
  PRIMARY KEY (`eventid`,`attachid`),
  KEY `bw_eannattach_eid_fk` (`eventid`),
  KEY `bw_eann_attach_fk` (`attachid`),
  CONSTRAINT `bw_eann_attach_fk` FOREIGN KEY (`attachid`) REFERENCES `bw_attachments` (`bwid`),
  CONSTRAINT `bw_eannattach_eid_fk` FOREIGN KEY (`eventid`) REFERENCES `bw_event_annotations` (`eventid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `bw_eventann_attendees`
--

DROP TABLE IF EXISTS `bw_eventann_attendees`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bw_eventann_attendees` (
  `eventid` int NOT NULL,
  `attendeeid` int NOT NULL,
  PRIMARY KEY (`eventid`,`attendeeid`),
  KEY `bw_eann_att_fk` (`attendeeid`),
  KEY `bw_eannatt_eid_fk` (`eventid`),
  CONSTRAINT `bw_eann_att_fk` FOREIGN KEY (`attendeeid`) REFERENCES `bw_attendees` (`attendeeid`),
  CONSTRAINT `bw_eannatt_eid_fk` FOREIGN KEY (`eventid`) REFERENCES `bw_event_annotations` (`eventid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `bw_eventann_categories`
--

DROP TABLE IF EXISTS `bw_eventann_categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bw_eventann_categories` (
  `eventid` int NOT NULL,
  `categoryid` int NOT NULL,
  PRIMARY KEY (`eventid`,`categoryid`),
  KEY `bw_eanncat_eid_fk` (`eventid`),
  KEY `bw_eann_cat_fk` (`categoryid`),
  CONSTRAINT `bw_eann_cat_fk` FOREIGN KEY (`categoryid`) REFERENCES `bw_categories` (`categoryid`),
  CONSTRAINT `bw_eanncat_eid_fk` FOREIGN KEY (`eventid`) REFERENCES `bw_event_annotations` (`eventid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `bw_eventann_comments`
--

DROP TABLE IF EXISTS `bw_eventann_comments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bw_eventann_comments` (
  `bw_eventid` int NOT NULL,
  `bw_strid` int NOT NULL,
  PRIMARY KEY (`bw_eventid`,`bw_strid`),
  UNIQUE KEY `bw_strid` (`bw_strid`),
  KEY `bw_eann_com_fk` (`bw_strid`),
  KEY `bw_eanncom_eid_fk` (`bw_eventid`),
  CONSTRAINT `bw_eann_com_fk` FOREIGN KEY (`bw_strid`) REFERENCES `bw_strings` (`bw_id`),
  CONSTRAINT `bw_eanncom_eid_fk` FOREIGN KEY (`bw_eventid`) REFERENCES `bw_event_annotations` (`eventid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `bw_eventann_contacts`
--

DROP TABLE IF EXISTS `bw_eventann_contacts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bw_eventann_contacts` (
  `eventid` int NOT NULL,
  `contactid` int NOT NULL,
  PRIMARY KEY (`eventid`,`contactid`),
  KEY `bw_eanncon_eid_fk` (`eventid`),
  KEY `bw_eann_con_fk` (`contactid`),
  CONSTRAINT `bw_eann_con_fk` FOREIGN KEY (`contactid`) REFERENCES `bw_contacts` (`entityid`),
  CONSTRAINT `bw_eanncon_eid_fk` FOREIGN KEY (`eventid`) REFERENCES `bw_event_annotations` (`eventid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `bw_eventann_descriptions`
--

DROP TABLE IF EXISTS `bw_eventann_descriptions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bw_eventann_descriptions` (
  `bw_eventid` int NOT NULL,
  `bw_strid` int NOT NULL,
  PRIMARY KEY (`bw_eventid`,`bw_strid`),
  UNIQUE KEY `bw_strid` (`bw_strid`),
  KEY `bw_eann_desc_fk` (`bw_strid`),
  KEY `bw_eanndesc_eid_fk` (`bw_eventid`),
  CONSTRAINT `bw_eann_desc_fk` FOREIGN KEY (`bw_strid`) REFERENCES `bw_longstrings` (`bw_id`),
  CONSTRAINT `bw_eanndesc_eid_fk` FOREIGN KEY (`bw_eventid`) REFERENCES `bw_event_annotations` (`eventid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `bw_eventann_exdates`
--

DROP TABLE IF EXISTS `bw_eventann_exdates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bw_eventann_exdates` (
  `eventid` int NOT NULL,
  `ex_date_type` char(1) NOT NULL,
  `ex_tzid` varchar(255) DEFAULT NULL,
  `ex_dtval` varchar(16) NOT NULL,
  `ex_date` varchar(16) NOT NULL,
  PRIMARY KEY (`eventid`,`ex_date_type`,`ex_dtval`,`ex_date`),
  KEY `bwidx_eann_exdate` (`ex_date`),
  KEY `bw_eann_edate_fk` (`eventid`),
  CONSTRAINT `bw_eann_edate_fk` FOREIGN KEY (`eventid`) REFERENCES `bw_event_annotations` (`eventid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `bw_eventann_exrules`
--

DROP TABLE IF EXISTS `bw_eventann_exrules`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bw_eventann_exrules` (
  `eventid` int NOT NULL,
  `exrule` varchar(255) NOT NULL,
  PRIMARY KEY (`eventid`,`exrule`),
  KEY `bw_eann_erule_fk` (`eventid`),
  CONSTRAINT `bw_eann_erule_fk` FOREIGN KEY (`eventid`) REFERENCES `bw_event_annotations` (`eventid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `bw_eventann_rdates`
--

DROP TABLE IF EXISTS `bw_eventann_rdates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bw_eventann_rdates` (
  `eventid` int NOT NULL,
  `r_date_type` char(1) NOT NULL,
  `r_tzid` varchar(255) DEFAULT NULL,
  `r_dtval` varchar(16) NOT NULL,
  `r_date` varchar(16) NOT NULL,
  PRIMARY KEY (`eventid`,`r_date_type`,`r_dtval`,`r_date`),
  KEY `bwidx_eann_rdate` (`r_date`),
  KEY `bw_eann_rdate_fk` (`eventid`),
  CONSTRAINT `bw_eann_rdate_fk` FOREIGN KEY (`eventid`) REFERENCES `bw_event_annotations` (`eventid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `bw_eventann_recipients`
--

DROP TABLE IF EXISTS `bw_eventann_recipients`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bw_eventann_recipients` (
  `eventid` int NOT NULL,
  `recipient` varchar(255) NOT NULL,
  PRIMARY KEY (`eventid`,`recipient`),
  KEY `bw_eann_recip_fk` (`eventid`),
  CONSTRAINT `bw_eann_recip_fk` FOREIGN KEY (`eventid`) REFERENCES `bw_event_annotations` (`eventid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `bw_eventann_resources`
--

DROP TABLE IF EXISTS `bw_eventann_resources`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bw_eventann_resources` (
  `bw_eventid` int NOT NULL,
  `bw_strid` int NOT NULL,
  PRIMARY KEY (`bw_eventid`,`bw_strid`),
  UNIQUE KEY `bw_strid` (`bw_strid`),
  KEY `bw_eann_res_fk` (`bw_strid`),
  KEY `bw_eannres_eid_fk` (`bw_eventid`),
  CONSTRAINT `bw_eann_res_fk` FOREIGN KEY (`bw_strid`) REFERENCES `bw_strings` (`bw_id`),
  CONSTRAINT `bw_eannres_eid_fk` FOREIGN KEY (`bw_eventid`) REFERENCES `bw_event_annotations` (`eventid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `bw_eventann_rrules`
--

DROP TABLE IF EXISTS `bw_eventann_rrules`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bw_eventann_rrules` (
  `eventid` int NOT NULL,
  `rrule` varchar(255) DEFAULT NULL,
  KEY `bw_eann_rrule_fk` (`eventid`),
  CONSTRAINT `bw_eann_rrule_fk` FOREIGN KEY (`eventid`) REFERENCES `bw_event_annotations` (`eventid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `bw_eventann_rstatus`
--

DROP TABLE IF EXISTS `bw_eventann_rstatus`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bw_eventann_rstatus` (
  `eventid` int NOT NULL,
  `bw_rscode` varchar(100) DEFAULT NULL,
  `bw_rsdescid` int DEFAULT NULL,
  `bw_rsdata` varchar(250) DEFAULT NULL,
  UNIQUE KEY `bw_rsdescid` (`bw_rsdescid`),
  KEY `bw_eann_rst_fk` (`bw_rsdescid`),
  KEY `bw_eannrst_eid_fk` (`eventid`),
  CONSTRAINT `bw_eann_rst_fk` FOREIGN KEY (`bw_rsdescid`) REFERENCES `bw_strings` (`bw_id`),
  CONSTRAINT `bw_eannrst_eid_fk` FOREIGN KEY (`eventid`) REFERENCES `bw_event_annotations` (`eventid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `bw_eventann_summaries`
--

DROP TABLE IF EXISTS `bw_eventann_summaries`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bw_eventann_summaries` (
  `bw_eventid` int NOT NULL,
  `bw_strid` int NOT NULL,
  PRIMARY KEY (`bw_eventid`,`bw_strid`),
  UNIQUE KEY `bw_strid` (`bw_strid`),
  KEY `bw_eann_sum_fk` (`bw_strid`),
  KEY `bw_eannsum_eid_fk` (`bw_eventid`),
  CONSTRAINT `bw_eann_sum_fk` FOREIGN KEY (`bw_strid`) REFERENCES `bw_strings` (`bw_id`),
  CONSTRAINT `bw_eannsum_eid_fk` FOREIGN KEY (`bw_eventid`) REFERENCES `bw_event_annotations` (`eventid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `bw_eventann_xprops`
--

DROP TABLE IF EXISTS `bw_eventann_xprops`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bw_eventann_xprops` (
  `bw_eventannid` int NOT NULL,
  `bw_name` varchar(100) DEFAULT NULL,
  `bw_pars` varchar(4000) DEFAULT NULL,
  `bw_value` longtext,
  `bwxp_position` int NOT NULL,
  PRIMARY KEY (`bw_eventannid`,`bwxp_position`),
  KEY `bw_eventannxp_eid_fk` (`bw_eventannid`),
  CONSTRAINT `bw_eventannxp_eid_fk` FOREIGN KEY (`bw_eventannid`) REFERENCES `bw_event_annotations` (`eventid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `bw_events`
--

DROP TABLE IF EXISTS `bw_events`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bw_events` (
  `eventid` int NOT NULL AUTO_INCREMENT,
  `bwseq` int NOT NULL,
  `bw_entity_type` int DEFAULT NULL,
  `bw_col_path` varchar(3000) NOT NULL,
  `bw_uid` varchar(1000) DEFAULT NULL,
  `eventname` varchar(500) DEFAULT NULL,
  `bw_creator` varchar(255) DEFAULT NULL,
  `bw_owner` varchar(255) DEFAULT NULL,
  `bwaccess` varchar(3900) DEFAULT NULL,
  `publick` char(1) NOT NULL,
  `start_date_type` char(1) DEFAULT NULL,
  `start_tzid` varchar(255) DEFAULT NULL,
  `start_dtval` varchar(16) DEFAULT NULL,
  `start_date` varchar(16) DEFAULT NULL,
  `bw_start_floating` char(1) DEFAULT NULL,
  `end_date_type` char(1) DEFAULT NULL,
  `end_tzid` varchar(255) DEFAULT NULL,
  `end_dtval` varchar(16) DEFAULT NULL,
  `end_date` varchar(16) DEFAULT NULL,
  `bw_end_floating` char(1) DEFAULT NULL,
  `duration` varchar(255) DEFAULT NULL,
  `end_type` char(1) NOT NULL,
  `bw_nostart` char(1) NOT NULL,
  `bw_deleted` char(1) NOT NULL,
  `bwtombstoned` char(1) DEFAULT NULL,
  `bw_class` varchar(250) DEFAULT NULL,
  `bw_link` varchar(500) DEFAULT NULL,
  `bw_geolatitude` decimal(19,2) DEFAULT NULL,
  `bw_geolongitude` decimal(19,2) DEFAULT NULL,
  `status` varchar(255) DEFAULT NULL,
  `cost` varchar(255) DEFAULT NULL,
  `bw_dtstamp` varchar(16) DEFAULT NULL,
  `bw_lastmod` varchar(16) NOT NULL,
  `bw_created` varchar(16) NOT NULL,
  `priority` int DEFAULT NULL,
  `locationid` int DEFAULT NULL,
  `rfcsequence` int DEFAULT NULL,
  `transparency` varchar(100) DEFAULT NULL,
  `percent_complete` int DEFAULT NULL,
  `completed` varchar(16) DEFAULT NULL,
  `recurring` char(1) NOT NULL,
  `recurrence_id` varchar(16) DEFAULT NULL,
  `latest_date` varchar(255) DEFAULT NULL,
  `schedule_method` int DEFAULT NULL,
  `originator` varchar(255) DEFAULT NULL,
  `bw_org_cn` varchar(500) DEFAULT NULL,
  `bw_org_dir` varchar(500) DEFAULT NULL,
  `bw_org_lang` varchar(100) DEFAULT NULL,
  `bw_org_sentby` varchar(500) DEFAULT NULL,
  `bw_org_uri` varchar(500) DEFAULT NULL,
  `bw_org_sched_status` varchar(100) DEFAULT NULL,
  `bw_org_dtstamp` varchar(16) DEFAULT NULL,
  `bw_reltype` varchar(100) DEFAULT NULL,
  `bw_reltoval` varchar(500) DEFAULT NULL,
  `schedule_state` int DEFAULT NULL,
  `bw_org_scheduleobj` bit(1) NOT NULL,
  `bw_att_scheduleobj` bit(1) NOT NULL,
  `busy_type` int DEFAULT NULL,
  `bw_stag` varchar(21) DEFAULT NULL,
  PRIMARY KEY (`eventid`),
  KEY `bwidx_event_start` (`start_date`),
  KEY `bw_idx_orgsobj` (`bw_org_scheduleobj`),
  KEY `bwidx_event_end_floating` (`bw_end_floating`),
  KEY `bwidx_event_recurring` (`recurring`),
  KEY `bwidx_event_start_floating` (`bw_start_floating`),
  KEY `bwidx_event_creator` (`bw_creator`),
  KEY `bwidx_ev_colpath` (`bw_col_path`(255)),
  KEY `bwidx_event_owner` (`bw_owner`),
  KEY `bwidx_event_location` (`locationid`),
  KEY `bw_idx_attsobj` (`bw_att_scheduleobj`),
  KEY `bwidx_event_end` (`end_date`),
  KEY `bwidx_event_deleted` (`bw_deleted`),
  KEY `bwidx_event_cal_name_uid` (`bw_uid`(255),`eventname`(255)),
  KEY `bwidx_event_latest_date` (`latest_date`),
  KEY `bw_event_loc_fk` (`locationid`),
  CONSTRAINT `bw_event_loc_fk` FOREIGN KEY (`locationid`) REFERENCES `bw_locations` (`entityid`)
) ENGINE=InnoDB AUTO_INCREMENT=76439 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `bw_fbcomp`
--

DROP TABLE IF EXISTS `bw_fbcomp`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bw_fbcomp` (
  `bwid` int NOT NULL AUTO_INCREMENT,
  `bwseq` int NOT NULL,
  `bwtype` int DEFAULT NULL,
  `bwvalue` varchar(3900) DEFAULT NULL,
  `eventid` int DEFAULT NULL,
  `fbcomp_position` int DEFAULT NULL,
  PRIMARY KEY (`bwid`),
  KEY `bw_eventfbc_eid_fk` (`eventid`),
  CONSTRAINT `bw_eventfbc_eid_fk` FOREIGN KEY (`eventid`) REFERENCES `bw_events` (`eventid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `bw_filter_descriptions`
--

DROP TABLE IF EXISTS `bw_filter_descriptions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bw_filter_descriptions` (
  `bw_eventid` int NOT NULL,
  `bw_strid` int NOT NULL,
  PRIMARY KEY (`bw_eventid`,`bw_strid`),
  UNIQUE KEY `bw_strid` (`bw_strid`),
  KEY `bw_fktr_desc_fk` (`bw_strid`),
  KEY `bw_fltrdesc_eid_fk` (`bw_eventid`),
  CONSTRAINT `bw_fktr_desc_fk` FOREIGN KEY (`bw_strid`) REFERENCES `bw_longstrings` (`bw_id`),
  CONSTRAINT `bw_fltrdesc_eid_fk` FOREIGN KEY (`bw_eventid`) REFERENCES `bw_filters` (`filterid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `bw_filter_display_names`
--

DROP TABLE IF EXISTS `bw_filter_display_names`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bw_filter_display_names` (
  `bw_eventid` int NOT NULL,
  `bw_strid` int NOT NULL,
  PRIMARY KEY (`bw_eventid`,`bw_strid`),
  UNIQUE KEY `bw_strid` (`bw_strid`),
  KEY `bw_fltrdname_fk` (`bw_strid`),
  KEY `bw_fltrdname_eid_fk` (`bw_eventid`),
  CONSTRAINT `bw_fltrdname_eid_fk` FOREIGN KEY (`bw_eventid`) REFERENCES `bw_filters` (`filterid`),
  CONSTRAINT `bw_fltrdname_fk` FOREIGN KEY (`bw_strid`) REFERENCES `bw_strings` (`bw_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `bw_filters`
--

DROP TABLE IF EXISTS `bw_filters`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bw_filters` (
  `filterid` int NOT NULL AUTO_INCREMENT,
  `bwseq` int NOT NULL,
  `bw_owner` varchar(255) DEFAULT NULL,
  `publick` char(1) NOT NULL,
  `filtername` varchar(200) DEFAULT NULL,
  `bwdefinition` longtext,
  PRIMARY KEY (`filterid`),
  KEY `bwidx_flt_owner` (`bw_owner`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `bw_group_members`
--

DROP TABLE IF EXISTS `bw_group_members`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bw_group_members` (
  `groupid` int NOT NULL,
  `memberid` int NOT NULL,
  `member_is_group` char(1) NOT NULL,
  PRIMARY KEY (`groupid`,`memberid`,`member_is_group`),
  KEY `bw_grp_grp_fk` (`groupid`),
  CONSTRAINT `bw_grp_grp_fk` FOREIGN KEY (`groupid`) REFERENCES `bw_groups` (`bw_group_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `bw_groups`
--

DROP TABLE IF EXISTS `bw_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bw_groups` (
  `bw_group_id` int NOT NULL AUTO_INCREMENT,
  `bwseq` int NOT NULL,
  `bw_account` varchar(200) NOT NULL,
  `bw_principal_ref` varchar(255) NOT NULL,
  PRIMARY KEY (`bw_group_id`),
  UNIQUE KEY `bw_account` (`bw_account`),
  KEY `bwidx_grp_href` (`bw_principal_ref`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `bw_hostinfo`
--

DROP TABLE IF EXISTS `bw_hostinfo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bw_hostinfo` (
  `bwid` int NOT NULL AUTO_INCREMENT,
  `bwseq` int NOT NULL,
  `bwhostname` varchar(255) NOT NULL,
  `bwport` int DEFAULT NULL,
  `bwsecure` char(1) NOT NULL,
  `bwsvcs` varchar(255) NOT NULL,
  `bwcaldav_url` varchar(255) DEFAULT NULL,
  `bwcaldav_principal` varchar(255) DEFAULT NULL,
  `bwcaldav_cred` varchar(255) DEFAULT NULL,
  `bwrt_url` varchar(255) DEFAULT NULL,
  `bwrt_principal` varchar(255) DEFAULT NULL,
  `bwrt_cred` varchar(255) DEFAULT NULL,
  `bwfb_url` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`bwid`),
  UNIQUE KEY `bwhostname` (`bwhostname`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `bw_locations`
--

DROP TABLE IF EXISTS `bw_locations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bw_locations` (
  `entityid` int NOT NULL AUTO_INCREMENT,
  `bwseq` int NOT NULL,
  `bw_creator` varchar(255) DEFAULT NULL,
  `bw_owner` varchar(255) DEFAULT NULL,
  `bwaccess` varchar(3900) DEFAULT NULL,
  `publick` char(1) NOT NULL,
  `bw_uid` varchar(50) NOT NULL,
  `bw_locaddrid` int NOT NULL,
  `bw_locsubaddrid` int DEFAULT NULL,
  `bw_link` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`entityid`),
  UNIQUE KEY `bw_uid` (`bw_uid`),
  UNIQUE KEY `bw_locaddrid` (`bw_locaddrid`),
  UNIQUE KEY `bw_locsubaddrid` (`bw_locsubaddrid`),
  KEY `bwidx_loc_uid` (`bw_uid`),
  KEY `bwidx_loc_owner` (`bw_owner`),
  KEY `bwidx_loc_creator` (`bw_creator`),
  KEY `bw_loc_addr_fk` (`bw_locaddrid`),
  KEY `bw_loc_sadd_fk` (`bw_locsubaddrid`),
  CONSTRAINT `bw_loc_addr_fk` FOREIGN KEY (`bw_locaddrid`) REFERENCES `bw_strings` (`bw_id`),
  CONSTRAINT `bw_loc_sadd_fk` FOREIGN KEY (`bw_locsubaddrid`) REFERENCES `bw_strings` (`bw_id`)
) ENGINE=InnoDB AUTO_INCREMENT=575 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `bw_longstrings`
--

DROP TABLE IF EXISTS `bw_longstrings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bw_longstrings` (
  `bw_id` int NOT NULL AUTO_INCREMENT,
  `bwseq` int NOT NULL,
  `bw_lang` varchar(100) DEFAULT NULL,
  `bw_value` longtext,
  PRIMARY KEY (`bw_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1621810 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `bw_preferences`
--

DROP TABLE IF EXISTS `bw_preferences`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bw_preferences` (
  `prefid` int NOT NULL AUTO_INCREMENT,
  `bwseq` int NOT NULL,
  `bw_owner` varchar(255) NOT NULL,
  `email` varchar(255) DEFAULT NULL,
  `bw_default_calendar` varchar(3900) DEFAULT NULL,
  `skin_name` varchar(255) DEFAULT NULL,
  `skin_style` varchar(255) DEFAULT NULL,
  `preferred_view` varchar(255) DEFAULT NULL,
  `preferred_view_period` varchar(255) DEFAULT NULL,
  `bw_page_size` int DEFAULT NULL,
  `workdays` varchar(255) DEFAULT NULL,
  `workday_start` int DEFAULT NULL,
  `workday_end` int DEFAULT NULL,
  `preferred_endtype` varchar(255) DEFAULT NULL,
  `bwuser_mode` int DEFAULT NULL,
  `bw_hour24` char(1) NOT NULL,
  `bw_sched_autoresp` char(1) NOT NULL,
  `bw_sched_autocancelaction` int DEFAULT NULL,
  `bw_sched_double_book` char(1) NOT NULL,
  `bw_sched_autoproc_resp` int DEFAULT NULL,
  PRIMARY KEY (`prefid`),
  KEY `bwidx_prefs_owner` (`bw_owner`)
) ENGINE=InnoDB AUTO_INCREMENT=5052 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `bw_recurrences`
--

DROP TABLE IF EXISTS `bw_recurrences`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bw_recurrences` (
  `recurrence_id` varchar(16) NOT NULL,
  `masterid` int NOT NULL,
  `bwseq` int NOT NULL,
  `start_date_type` char(1) NOT NULL,
  `start_tzid` varchar(255) DEFAULT NULL,
  `start_dtval` varchar(16) NOT NULL,
  `start_date` varchar(16) NOT NULL,
  `bw_rstart_floating` char(1) DEFAULT NULL,
  `end_date_type` char(1) DEFAULT NULL,
  `end_tzid` varchar(255) DEFAULT NULL,
  `end_dtval` varchar(255) DEFAULT NULL,
  `end_date` varchar(255) DEFAULT NULL,
  `bw_rend_floating` char(1) DEFAULT NULL,
  `overrideid` int DEFAULT NULL,
  PRIMARY KEY (`recurrence_id`,`masterid`),
  KEY `bwidx_recur_start` (`start_date`),
  KEY `bwidx_rstart_floating` (`bw_rstart_floating`),
  KEY `bwidx_rend_floating` (`bw_rend_floating`),
  KEY `bwidx_recur_end` (`end_date`),
  KEY `bw_ri_mstr_fk` (`masterid`),
  KEY `bw_ri_ov_fk` (`overrideid`),
  CONSTRAINT `bw_ri_mstr_fk` FOREIGN KEY (`masterid`) REFERENCES `bw_events` (`eventid`),
  CONSTRAINT `bw_ri_ov_fk` FOREIGN KEY (`overrideid`) REFERENCES `bw_event_annotations` (`eventid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `bw_resource_contents`
--

DROP TABLE IF EXISTS `bw_resource_contents`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bw_resource_contents` (
  `id` int NOT NULL AUTO_INCREMENT,
  `bwseq` int NOT NULL,
  `bw_col_path` varchar(3000) DEFAULT NULL,
  `bwname` varchar(100) NOT NULL,
  `bw_value` blob,
  PRIMARY KEY (`id`),
  KEY `bwidx_rsrc_colpath` (`bw_col_path`(255))
) ENGINE=InnoDB AUTO_INCREMENT=88063 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `bw_resources`
--

DROP TABLE IF EXISTS `bw_resources`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bw_resources` (
  `id` int NOT NULL AUTO_INCREMENT,
  `bwseq` int NOT NULL,
  `bw_col_path` varchar(3000) NOT NULL,
  `bw_creator` varchar(255) DEFAULT NULL,
  `bw_owner` varchar(255) DEFAULT NULL,
  `bwaccess` varchar(3900) DEFAULT NULL,
  `publick` char(1) NOT NULL,
  `bwname` varchar(100) NOT NULL,
  `bw_created` varchar(16) NOT NULL,
  `bw_lastmod` varchar(16) NOT NULL,
  `bwsequence` int DEFAULT NULL,
  `bw_contenttype` varchar(1000) DEFAULT NULL,
  `bw_encoding` varchar(1000) DEFAULT NULL,
  `bwcontent_length` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `bwidx_rsrc_owner` (`bw_owner`),
  KEY `bwidx_rsrc_colpath` (`bw_col_path`(255)),
  KEY `bwidx_rsrc_creator` (`bw_creator`)
) ENGINE=InnoDB AUTO_INCREMENT=88064 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `bw_rstatus`
--

DROP TABLE IF EXISTS `bw_rstatus`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bw_rstatus` (
  `eventid` int NOT NULL,
  `bw_rscode` varchar(100) DEFAULT NULL,
  `bw_rsdescid` int DEFAULT NULL,
  `bw_rsdata` varchar(250) DEFAULT NULL,
  UNIQUE KEY `bw_rsdescid` (`bw_rsdescid`),
  KEY `bw_event_rst_fk` (`bw_rsdescid`),
  KEY `bw_eventrst_eid_fk` (`eventid`),
  CONSTRAINT `bw_event_rst_fk` FOREIGN KEY (`bw_rsdescid`) REFERENCES `bw_strings` (`bw_id`),
  CONSTRAINT `bw_eventrst_eid_fk` FOREIGN KEY (`eventid`) REFERENCES `bw_events` (`eventid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `bw_sched_msg`
--

DROP TABLE IF EXISTS `bw_sched_msg`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bw_sched_msg` (
  `id` int NOT NULL AUTO_INCREMENT,
  `bwseq` int NOT NULL,
  `bw_timestamp` varchar(16) NOT NULL,
  `bw_sequence` int DEFAULT NULL,
  `bw_lastproc` varchar(16) NOT NULL,
  `bw_inbox` char(1) NOT NULL,
  `bw_principal_href` varchar(255) DEFAULT NULL,
  `bw_eventname` varchar(500) DEFAULT NULL,
  `bw_recurrence_id` varchar(16) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `bwidx_smsg_eventname` (`bw_eventname`(255)),
  KEY `bwidx_smsg_timestamp` (`bw_timestamp`),
  KEY `bwidx_smsg_principal` (`bw_principal_href`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `bw_settings`
--

DROP TABLE IF EXISTS `bw_settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bw_settings` (
  `id` int NOT NULL AUTO_INCREMENT,
  `bwseq` int NOT NULL,
  `bwname` varchar(200) DEFAULT NULL,
  `tzid` varchar(255) DEFAULT NULL,
  `systemid` varchar(255) DEFAULT NULL,
  `publicCalendarRoot` varchar(100) DEFAULT NULL,
  `userCalendarRoot` varchar(100) DEFAULT NULL,
  `userDefaultCalendar` varchar(100) DEFAULT NULL,
  `defaultTrashCalendar` varchar(100) DEFAULT NULL,
  `userInbox` varchar(100) DEFAULT NULL,
  `userOutbox` varchar(100) DEFAULT NULL,
  `deletedCalendar` varchar(100) DEFAULT NULL,
  `busyCalendar` varchar(100) DEFAULT NULL,
  `defaultUserViewName` varchar(100) DEFAULT NULL,
  `default_user_hour24` char(1) DEFAULT NULL,
  `public_user` varchar(100) DEFAULT NULL,
  `http_connections_per_user` int DEFAULT NULL,
  `http_connections_per_host` int DEFAULT NULL,
  `http_connections` int DEFAULT NULL,
  `maxPublicDescriptionLength` int DEFAULT NULL,
  `maxUserDescriptionLength` int DEFAULT NULL,
  `maxUserEntitySize` int DEFAULT NULL,
  `defaultUserQuota` bigint DEFAULT NULL,
  `bwmax_instances` int DEFAULT NULL,
  `bwmax_years` int DEFAULT NULL,
  `userauth_class` varchar(200) DEFAULT NULL,
  `mailer_class` varchar(200) DEFAULT NULL,
  `admingroups_class` varchar(200) DEFAULT NULL,
  `usergroups_class` varchar(200) DEFAULT NULL,
  `directory_browsing_disallowed` char(1) DEFAULT NULL,
  `bwindex_root` varchar(500) DEFAULT NULL,
  `bwlocales` varchar(1000) DEFAULT NULL,
  `bwroot_users` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `bw_strings`
--

DROP TABLE IF EXISTS `bw_strings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bw_strings` (
  `bw_id` int NOT NULL AUTO_INCREMENT,
  `bwseq` int NOT NULL,
  `bw_lang` varchar(100) DEFAULT NULL,
  `bw_value` varchar(3900) DEFAULT NULL,
  PRIMARY KEY (`bw_id`)
) ENGINE=InnoDB AUTO_INCREMENT=108334 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `bw_system_properties`
--

DROP TABLE IF EXISTS `bw_system_properties`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bw_system_properties` (
  `bwid` int NOT NULL,
  `bw_name` varchar(200) DEFAULT NULL,
  `bw_value` longtext,
  KEY `bw_sysprp_pid_fk` (`bwid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `bw_user_properties`
--

DROP TABLE IF EXISTS `bw_user_properties`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bw_user_properties` (
  `bwid` int NOT NULL,
  `bw_name` varchar(200) DEFAULT NULL,
  `bw_value` longtext,
  KEY `bw_prprp_pid_fk` (`bwid`),
  CONSTRAINT `bw_prprp_pid_fk` FOREIGN KEY (`bwid`) REFERENCES `bw_preferences` (`prefid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `bw_user_views`
--

DROP TABLE IF EXISTS `bw_user_views`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bw_user_views` (
  `prefid` int NOT NULL,
  `elt` int NOT NULL,
  PRIMARY KEY (`prefid`,`elt`),
  KEY `bw_pr_view_fk` (`elt`),
  KEY `bw_prview_pid_fk` (`prefid`),
  CONSTRAINT `bw_pr_view_fk` FOREIGN KEY (`elt`) REFERENCES `bw_views` (`viewid`),
  CONSTRAINT `bw_prview_pid_fk` FOREIGN KEY (`prefid`) REFERENCES `bw_preferences` (`prefid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `bw_userinfo`
--

DROP TABLE IF EXISTS `bw_userinfo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bw_userinfo` (
  `userid` int NOT NULL,
  `bwseq` int NOT NULL,
  `bw_user` varchar(255) NOT NULL,
  `lastname` varchar(255) DEFAULT NULL,
  `firstname` varchar(255) DEFAULT NULL,
  `phone` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `department` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`userid`),
  KEY `bwidx_ui_owner` (`bw_user`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `bw_userinfo_properties`
--

DROP TABLE IF EXISTS `bw_userinfo_properties`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bw_userinfo_properties` (
  `user_info` int NOT NULL,
  `propname` varchar(255) NOT NULL,
  `val` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`user_info`,`propname`),
  KEY `bw_ui_pid_fk` (`user_info`),
  CONSTRAINT `bw_ui_pid_fk` FOREIGN KEY (`user_info`) REFERENCES `bw_userinfo` (`userid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `bw_users`
--

DROP TABLE IF EXISTS `bw_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bw_users` (
  `userid` int NOT NULL AUTO_INCREMENT,
  `bwseq` int NOT NULL,
  `bw_account` varchar(200) NOT NULL,
  `bw_principal_ref` varchar(255) NOT NULL,
  `instance_owner` char(1) NOT NULL,
  `bw_created` datetime DEFAULT NULL,
  `bw_last_logon` datetime DEFAULT NULL,
  `bw_last_access` datetime DEFAULT NULL,
  `bw_last_modify` datetime DEFAULT NULL,
  `bw_category_access` varchar(3900) DEFAULT NULL,
  `bw_contact_access` varchar(3900) DEFAULT NULL,
  `bw_location_access` varchar(3900) DEFAULT NULL,
  `bw_quota` bigint DEFAULT NULL,
  PRIMARY KEY (`userid`),
  UNIQUE KEY `bw_account` (`bw_account`),
  KEY `bwidx_user_href` (`bw_principal_ref`),
  KEY `bwidx_user_instance_owner` (`instance_owner`)
) ENGINE=InnoDB AUTO_INCREMENT=55041 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `bw_view_collections`
--

DROP TABLE IF EXISTS `bw_view_collections`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bw_view_collections` (
  `viewid` int NOT NULL,
  `bw_calpath` varchar(255) NOT NULL,
  `bw_path_positon` int NOT NULL,
  PRIMARY KEY (`viewid`,`bw_path_positon`),
  KEY `bw_cal_vid_fk` (`viewid`),
  CONSTRAINT `bw_cal_vid_fk` FOREIGN KEY (`viewid`) REFERENCES `bw_views` (`viewid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `bw_views`
--

DROP TABLE IF EXISTS `bw_views`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bw_views` (
  `viewid` int NOT NULL AUTO_INCREMENT,
  `bwseq` int NOT NULL,
  `viewname` varchar(100) NOT NULL,
  PRIMARY KEY (`viewid`)
) ENGINE=InnoDB AUTO_INCREMENT=6458 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Temporary view structure for view `view_yb_calendars`
--

DROP TABLE IF EXISTS `view_yb_calendars`;
/*!50001 DROP VIEW IF EXISTS `view_yb_calendars`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `view_yb_calendars` AS SELECT 
 1 AS `calendar_id`,
 1 AS `name`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `view_yb_locations`
--

DROP TABLE IF EXISTS `view_yb_locations`;
/*!50001 DROP VIEW IF EXISTS `view_yb_locations`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `view_yb_locations` AS SELECT 
 1 AS `location_id`,
 1 AS `abbreviation`,
 1 AS `description`,
 1 AS `street_address`,
 1 AS `city_state`,
 1 AS `zip`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `view_yb_sponsors`
--

DROP TABLE IF EXISTS `view_yb_sponsors`;
/*!50001 DROP VIEW IF EXISTS `view_yb_sponsors`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `view_yb_sponsors` AS SELECT 
 1 AS `sponsor_id`,
 1 AS `name`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `view_yb_tags`
--

DROP TABLE IF EXISTS `view_yb_tags`;
/*!50001 DROP VIEW IF EXISTS `view_yb_tags`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `view_yb_tags` AS SELECT 
 1 AS `tag_id`,
 1 AS `description`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `yb_about_html`
--

DROP TABLE IF EXISTS `yb_about_html`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `yb_about_html` (
  `yb_suite` varchar(64) NOT NULL,
  `yb_about_html` longtext NOT NULL,
  PRIMARY KEY (`yb_suite`),
  KEY `yb_about_html_by_suite` (`yb_suite`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `yb_additional_links`
--

DROP TABLE IF EXISTS `yb_additional_links`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `yb_additional_links` (
  `yb_suite` varchar(64) NOT NULL,
  `yb_name` varchar(128) NOT NULL,
  `yb_link` varchar(255) NOT NULL,
  PRIMARY KEY (`yb_suite`,`yb_name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `yb_audit`
--

DROP TABLE IF EXISTS `yb_audit`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `yb_audit` (
  `yb_id` int NOT NULL AUTO_INCREMENT,
  `yb_nodeid` varchar(255) NOT NULL,
  `yb_netid` varchar(64) NOT NULL,
  `yb_suite` varchar(64) NOT NULL,
  `yb_type` varchar(64) NOT NULL,
  `yb_timestamp` bigint unsigned NOT NULL,
  `yb_timestamp_d` datetime NOT NULL,
  PRIMARY KEY (`yb_id`),
  KEY `yb_audit_by_time` (`yb_timestamp`)
) ENGINE=InnoDB AUTO_INCREMENT=3609 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `yb_cache_stats`
--

DROP TABLE IF EXISTS `yb_cache_stats`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `yb_cache_stats` (
  `yb_id` int NOT NULL AUTO_INCREMENT,
  `yb_nodeid` varchar(128) NOT NULL,
  `yb_date` varchar(21) NOT NULL,
  `yb_day` varchar(11) NOT NULL,
  `yb_time` varchar(9) NOT NULL,
  `yb_hits` bigint NOT NULL,
  `yb_misses` bigint NOT NULL,
  `yb_invalidations` bigint NOT NULL,
  PRIMARY KEY (`yb_id`),
  UNIQUE KEY `yb_cache_unq` (`yb_nodeid`,`yb_date`),
  KEY `yb_cache_by_date` (`yb_date`),
  KEY `yb_cache_by_day` (`yb_day`),
  KEY `yb_cache_by_time` (`yb_time`)
) ENGINE=InnoDB AUTO_INCREMENT=251008 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `yb_cron`
--

DROP TABLE IF EXISTS `yb_cron`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `yb_cron` (
  `yb_id` int NOT NULL AUTO_INCREMENT,
  `yb_nodeid` varchar(255) NOT NULL,
  `yb_type` varchar(64) NOT NULL,
  `yb_log` varchar(512) NOT NULL,
  `yb_timestamp` bigint unsigned NOT NULL,
  `yb_timestamp_d` datetime NOT NULL,
  PRIMARY KEY (`yb_id`),
  KEY `yb_cron_by_time` (`yb_timestamp`)
) ENGINE=InnoDB AUTO_INCREMENT=596344 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `yb_css`
--

DROP TABLE IF EXISTS `yb_css`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `yb_css` (
  `yb_suite` varchar(64) NOT NULL,
  `yb_css` longtext NOT NULL,
  PRIMARY KEY (`yb_suite`),
  KEY `yb_css_by_suite` (`yb_suite`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `yb_customizer`
--

DROP TABLE IF EXISTS `yb_customizer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `yb_customizer` (
  `yb_id` int NOT NULL AUTO_INCREMENT,
  `yb_nodeid` varchar(255) DEFAULT NULL,
  `yb_timestamp` bigint unsigned NOT NULL,
  `yb_userid` varchar(255) DEFAULT NULL,
  `yb_suite` varchar(255) DEFAULT NULL,
  `yb_xslt` longtext,
  PRIMARY KEY (`yb_id`),
  KEY `yb_cust_by_suite` (`yb_suite`),
  KEY `yb_cust_by_tstamp` (`yb_timestamp`)
) ENGINE=InnoDB AUTO_INCREMENT=80 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `yb_featured_events`
--

DROP TABLE IF EXISTS `yb_featured_events`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `yb_featured_events` (
  `yb_suite` varchar(64) NOT NULL,
  `yb_left_alt` varchar(255) NOT NULL,
  `yb_left_image_url` varchar(255) NOT NULL,
  `yb_left_event_url` varchar(255) NOT NULL,
  `yb_middle_alt` varchar(255) NOT NULL,
  `yb_middle_image_url` varchar(255) NOT NULL,
  `yb_middle_event_url` varchar(255) NOT NULL,
  `yb_right_alt` varchar(255) NOT NULL,
  `yb_right_image_url` varchar(255) NOT NULL,
  `yb_right_event_url` varchar(255) NOT NULL,
  PRIMARY KEY (`yb_suite`),
  KEY `yb_fe_by_suite` (`yb_suite`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `yb_global_settings`
--

DROP TABLE IF EXISTS `yb_global_settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `yb_global_settings` (
  `yb_name` varchar(64) NOT NULL,
  `yb_value` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`yb_name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `yb_location`
--

DROP TABLE IF EXISTS `yb_location`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `yb_location` (
  `yb_bid` varchar(8) NOT NULL,
  `yb_abbreviation` varchar(12) DEFAULT NULL,
  `yb_description` varchar(255) NOT NULL,
  `yb_address1` varchar(255) NOT NULL,
  `yb_address2` varchar(255) NOT NULL,
  `yb_zip` varchar(255) NOT NULL,
  PRIMARY KEY (`yb_bid`),
  KEY `yb_loc_by_abbrev` (`yb_abbreviation`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `yb_other_calendars`
--

DROP TABLE IF EXISTS `yb_other_calendars`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `yb_other_calendars` (
  `yb_name` varchar(128) NOT NULL,
  `yb_link` varchar(255) NOT NULL,
  PRIMARY KEY (`yb_name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `yb_print_category`
--

DROP TABLE IF EXISTS `yb_print_category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `yb_print_category` (
  `yb_id` int NOT NULL AUTO_INCREMENT,
  `yb_name` varchar(255) NOT NULL,
  `yb_collapsed` tinyint(1) NOT NULL,
  `yb_weekLimited` tinyint(1) NOT NULL,
  PRIMARY KEY (`yb_id`),
  KEY `yb_pc_by_name` (`yb_name`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `yb_sponsor_code`
--

DROP TABLE IF EXISTS `yb_sponsor_code`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `yb_sponsor_code` (
  `yb_code` varchar(12) NOT NULL,
  `yb_name` varchar(255) NOT NULL,
  PRIMARY KEY (`yb_code`),
  KEY `yb_sc_by_code` (`yb_code`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `yb_suite_settings`
--

DROP TABLE IF EXISTS `yb_suite_settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `yb_suite_settings` (
  `yb_suite` varchar(64) NOT NULL,
  `yb_name` varchar(64) NOT NULL,
  `yb_value` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`yb_suite`,`yb_name`),
  UNIQUE KEY `yb_ss_by_both` (`yb_suite`,`yb_name`),
  KEY `yb_ss_by_suite` (`yb_suite`),
  KEY `yb_ss_by_name` (`yb_name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `yb_updates`
--

DROP TABLE IF EXISTS `yb_updates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `yb_updates` (
  `yb_nodeid` varchar(255) NOT NULL DEFAULT '',
  `yb_timestamp` bigint unsigned NOT NULL,
  PRIMARY KEY (`yb_nodeid`),
  KEY `yb_updates_by_nodeid` (`yb_nodeid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `yb_views`
--

DROP TABLE IF EXISTS `yb_views`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `yb_views` (
  `yb_suite` varchar(64) NOT NULL,
  `yb_views` longtext NOT NULL,
  PRIMARY KEY (`yb_suite`),
  KEY `yb_view_by_suite` (`yb_suite`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Final view structure for view `view_yb_calendars`
--

/*!50001 DROP VIEW IF EXISTS `view_yb_calendars`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb3 */;
/*!50001 SET character_set_results     = utf8mb3 */;
/*!50001 SET collation_connection      = utf8mb3_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`calprddb00`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `view_yb_calendars` AS select `cs`.`csname` AS `calendar_id`,`ss`.`yb_value` AS `name` from (`bw_calsuites` `cs` left join `yb_suite_settings` `ss` on((`cs`.`csname` = convert(`ss`.`yb_suite` using utf8mb3)))) where (`ss`.`yb_name` = 'title') */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `view_yb_locations`
--

/*!50001 DROP VIEW IF EXISTS `view_yb_locations`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb3 */;
/*!50001 SET character_set_results     = utf8mb3 */;
/*!50001 SET collation_connection      = utf8mb3_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`calprddb00`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `view_yb_locations` AS select `yb_location`.`yb_bid` AS `location_id`,`yb_location`.`yb_abbreviation` AS `abbreviation`,`yb_location`.`yb_description` AS `description`,`yb_location`.`yb_address1` AS `street_address`,`yb_location`.`yb_address2` AS `city_state`,`yb_location`.`yb_zip` AS `zip` from `yb_location` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `view_yb_sponsors`
--

/*!50001 DROP VIEW IF EXISTS `view_yb_sponsors`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb3 */;
/*!50001 SET character_set_results     = utf8mb3 */;
/*!50001 SET collation_connection      = utf8mb3_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`calprddb00`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `view_yb_sponsors` AS select `yb_sponsor_code`.`yb_code` AS `sponsor_id`,`yb_sponsor_code`.`yb_name` AS `name` from `yb_sponsor_code` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `view_yb_tags`
--

/*!50001 DROP VIEW IF EXISTS `view_yb_tags`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb3 */;
/*!50001 SET character_set_results     = utf8mb3 */;
/*!50001 SET collation_connection      = utf8mb3_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`calprddb00`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `view_yb_tags` AS select `s_wd`.`bw_value` AS `tag_id`,`s_dsc`.`bw_value` AS `description` from ((`bw_categories` `cat` left join `bw_strings` `s_wd` on((`cat`.`bw_catwdid` = `s_wd`.`bw_id`))) left join `bw_strings` `s_dsc` on((`cat`.`bw_catdescid` = `s_dsc`.`bw_id`))) where ((not((`s_wd`.`bw_value` like '.%'))) and (not((`s_wd`.`bw_value` like '\\_%')))) order by `s_wd`.`bw_value` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-07-18 19:22:02
