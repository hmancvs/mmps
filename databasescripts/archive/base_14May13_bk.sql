-- MySQL Administrator dump 1.4
--
-- ------------------------------------------------------
-- Server version	5.5.24-log


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;


--
-- Definition of table `aclgroup`
--

DROP TABLE IF EXISTS `aclgroup`;
CREATE TABLE `aclgroup` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `description` varchar(255) NOT NULL,
  `datecreated` datetime NOT NULL,
  `createdby` int(11) unsigned NOT NULL,
  `lastupdatedate` datetime DEFAULT NULL,
  `lastupdatedby` int(11) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `aclgroup`
--

/*!40000 ALTER TABLE `aclgroup` DISABLE KEYS */;
INSERT INTO `aclgroup` (`id`,`name`,`description`,`datecreated`,`createdby`,`lastupdatedate`,`lastupdatedby`) VALUES 
 (1,'Administrator','Overall system administrator','2013-05-01 12:00:00',1,NULL,NULL),
 (2,'Individual Customer','Customers who purchase items from the portal','2013-05-01 12:00:00',1,NULL,NULL),
 (3,'Company Admin','Administrator of company shopping platform','2013-05-01 12:00:00',1,NULL,NULL),
 (4,'Company Customer','Customer who registers to make purchases fromm a company','2013-05-01 12:00:00',1,NULL,NULL),
 (5,'Management','Management of portal and financial reports','2013-05-01 12:00:00',1,NULL,NULL),
 (6,'Data Clerk','Data entry clerk for portal ','2013-05-01 12:00:00',1,NULL,NULL);
/*!40000 ALTER TABLE `aclgroup` ENABLE KEYS */;


--
-- Definition of table `aclpermission`
--

DROP TABLE IF EXISTS `aclpermission`;
CREATE TABLE `aclpermission` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `groupid` int(11) unsigned DEFAULT NULL,
  `resourceid` int(11) unsigned NOT NULL,
  `create` enum('1','0') NOT NULL DEFAULT '0',
  `edit` enum('1','0') NOT NULL DEFAULT '0',
  `view` enum('1','0') NOT NULL DEFAULT '0',
  `list` enum('1','0') NOT NULL DEFAULT '0',
  `delete` enum('1','0') NOT NULL DEFAULT '0',
  `export` enum('1','0') NOT NULL DEFAULT '0',
  `approve` enum('1','0') NOT NULL DEFAULT '0',
  `acclist` enum('1','0') NOT NULL DEFAULT '0',
  `datecreated` datetime NOT NULL,
  `createdby` int(11) unsigned NOT NULL,
  `lastupdatedate` datetime DEFAULT NULL,
  `lastupdatedby` int(11) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=38 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `aclpermission`
--

/*!40000 ALTER TABLE `aclpermission` DISABLE KEYS */;
INSERT INTO `aclpermission` (`id`,`groupid`,`resourceid`,`create`,`edit`,`view`,`list`,`delete`,`export`,`approve`,`acclist`,`datecreated`,`createdby`,`lastupdatedate`,`lastupdatedby`) VALUES 
 (1,1,1,'0','0','1','1','0','0','0','0','2012-03-01 12:00:00',1,NULL,NULL),
 (2,1,2,'1','1','1','1','1','0','0','0','2012-03-01 12:00:00',1,NULL,NULL),
 (3,1,3,'1','1','1','1','1','0','0','0','2012-03-01 12:00:00',1,NULL,NULL),
 (4,1,4,'0','0','1','1','0','1','0','0','2012-03-01 12:00:00',1,NULL,NULL),
 (5,1,5,'1','1','1','1','1','1','0','0','2012-03-01 12:00:00',1,NULL,NULL),
 (6,1,7,'1','1','1','1','0','0','0','0','2012-03-01 12:00:00',1,NULL,NULL),
 (7,1,8,'0','0','1','0','0','0','0','0','2012-03-01 12:00:00',1,NULL,NULL),
 (8,1,6,'0','0','1','0','0','0','0','0','2012-03-01 12:00:00',1,NULL,NULL),
 (9,1,9,'0','0','1','0','0','0','0','0','2012-03-01 12:00:00',1,NULL,NULL),
 (10,1,10,'0','0','1','0','0','0','0','0','2012-03-01 12:00:00',1,NULL,NULL),
 (11,1,11,'0','0','1','0','0','0','0','0','2012-03-01 12:00:00',1,NULL,NULL),
 (12,1,12,'1','1','1','1','1','0','0','0','2012-03-01 12:00:00',1,NULL,NULL),
 (13,2,3,'1','1','1','0','0','0','0','0','2012-09-07 22:05:39',1,NULL,NULL),
 (14,2,6,'0','0','1','0','0','0','0','0','2012-09-07 22:05:39',1,NULL,NULL),
 (15,2,12,'1','1','1','1','0','0','0','0','2012-09-07 22:05:39',1,NULL,NULL),
 (16,3,12,'1','1','1','1','0','0','0','0','2012-09-07 22:05:39',1,NULL,NULL),
 (17,4,12,'1','1','1','1','1','0','0','0','2012-09-07 22:05:39',1,NULL,NULL),
 (18,5,12,'1','1','1','1','1','0','0','0','2012-09-07 22:05:39',1,NULL,NULL),
 (19,1,13,'1','1','1','1','1','0','0','0','2012-09-07 22:05:39',1,NULL,NULL),
 (20,2,13,'0','0','1','1','0','0','0','0','2012-09-07 22:05:39',1,NULL,NULL),
 (21,3,13,'1','1','1','1','0','0','0','0','2012-09-07 22:05:39',1,NULL,NULL),
 (22,4,13,'1','1','1','1','0','0','0','0','2012-09-07 22:05:39',1,NULL,NULL),
 (23,5,13,'1','1','1','1','1','0','0','0','2012-09-07 22:05:39',1,NULL,NULL),
 (24,1,14,'0','0','1','0','0','0','0','0','2012-03-20 22:29:09',1,NULL,NULL),
 (25,5,14,'0','0','1','0','0','0','0','0','2012-03-20 22:29:09',1,NULL,NULL),
 (26,2,15,'0','0','1','0','0','0','0','0','2012-03-20 22:29:09',1,NULL,NULL),
 (27,4,16,'0','0','1','0','0','0','0','0','2012-03-20 22:29:09',1,NULL,NULL),
 (28,5,1,'0','0','1','1','0','0','0','0','0000-00-00 00:00:00',0,NULL,NULL),
 (29,5,2,'1','1','1','1','1','0','0','0','0000-00-00 00:00:00',0,NULL,NULL),
 (30,5,3,'1','1','1','1','1','0','0','0','0000-00-00 00:00:00',0,NULL,NULL),
 (31,3,3,'1','1','1','1','0','0','0','0','0000-00-00 00:00:00',0,NULL,NULL),
 (32,4,3,'1','1','1','1','0','0','0','0','0000-00-00 00:00:00',0,NULL,NULL),
 (33,3,6,'0','0','1','0','0','0','0','0','0000-00-00 00:00:00',0,NULL,NULL),
 (34,4,6,'0','0','1','0','0','0','0','0','0000-00-00 00:00:00',0,NULL,NULL),
 (35,5,6,'0','0','1','0','0','0','0','0','0000-00-00 00:00:00',0,NULL,NULL),
 (36,5,7,'1','1','1','1','0','0','0','0','0000-00-00 00:00:00',0,NULL,NULL),
 (37,3,14,'0','0','1','0','0','0','0','0','0000-00-00 00:00:00',0,NULL,NULL);
/*!40000 ALTER TABLE `aclpermission` ENABLE KEYS */;


--
-- Definition of table `aclresource`
--

DROP TABLE IF EXISTS `aclresource`;
CREATE TABLE `aclresource` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `description` varchar(255) NOT NULL,
  `create` enum('1','0') NOT NULL DEFAULT '0',
  `edit` enum('1','0') NOT NULL DEFAULT '0',
  `view` enum('1','0') NOT NULL DEFAULT '0',
  `list` enum('1','0') NOT NULL DEFAULT '0',
  `delete` enum('1','0') NOT NULL DEFAULT '0',
  `approve` enum('1','0') NOT NULL DEFAULT '0',
  `export` enum('1','0') NOT NULL DEFAULT '0',
  `acclist` enum('1','0') NOT NULL DEFAULT '0',
  `datecreated` datetime NOT NULL,
  `createdby` int(11) unsigned NOT NULL,
  `lastupdatedate` datetime DEFAULT NULL,
  `lastupdatedby` int(11) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `aclresource`
--

/*!40000 ALTER TABLE `aclresource` DISABLE KEYS */;
INSERT INTO `aclresource` (`id`,`name`,`description`,`create`,`edit`,`view`,`list`,`delete`,`approve`,`export`,`acclist`,`datecreated`,`createdby`,`lastupdatedate`,`lastupdatedby`) VALUES 
 (1,'Lookup Type','Look up types','0','0','1','1','0','0','0','0','2012-03-01 12:00:00',1,NULL,NULL),
 (2,'Lookup Value','Values for the lookup type','1','1','1','1','1','0','0','0','2012-03-01 12:00:00',1,NULL,NULL),
 (3,'User Account','A user within the application','1','1','1','1','1','0','1','0','2012-03-01 12:00:00',1,NULL,NULL),
 (4,'Audit Trail','Log of selected transactions within the application','0','0','1','1','0','0','1','0','2012-03-01 12:00:00',1,NULL,NULL),
 (5,'Role','Actions a member can execute on resources','1','1','1','1','1','0','1','0','2012-03-01 12:00:00',1,NULL,NULL),
 (6,'Dashboard','user dashboard','0','0','1','0','0','0','0','0','2012-03-01 12:00:00',1,NULL,NULL),
 (7,'Application Settings','Application Administration','1','1','1','1','0','0','0','0','2012-03-01 12:00:00',1,NULL,NULL),
 (8,'Report','The different reports in the Application','0','0','1','0','0','0','0','0','2012-03-01 12:00:00',1,NULL,NULL),
 (9,'Billing','Billing and payment information','0','0','1','0','0','0','0','0','2012-03-01 12:00:00',1,NULL,NULL),
 (10,'Payments Report','Payments Report','0','0','1','0','0','0','0','0','2012-03-01 12:00:00',1,NULL,NULL),
 (11,'Subscriptions Report','Subscriptions Report','0','0','1','0','0','0','0','0','2012-03-01 12:00:00',1,NULL,NULL);
/*!40000 ALTER TABLE `aclresource` ENABLE KEYS */;


--
-- Definition of table `aclusergroup`
--

DROP TABLE IF EXISTS `aclusergroup`;
CREATE TABLE `aclusergroup` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `groupid` int(11) unsigned NOT NULL,
  `userid` int(11) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_user_group` (`groupid`,`userid`),
  KEY `fk_usergroup_userid` (`userid`),
  CONSTRAINT `fk_usergroup_groupid` FOREIGN KEY (`groupid`) REFERENCES `aclgroup` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_usergroup_userid` FOREIGN KEY (`userid`) REFERENCES `useraccount` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2802 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `aclusergroup`
--

/*!40000 ALTER TABLE `aclusergroup` DISABLE KEYS */;
INSERT INTO `aclusergroup` (`id`,`groupid`,`userid`) VALUES 
 (1,1,1);
/*!40000 ALTER TABLE `aclusergroup` ENABLE KEYS */;


--
-- Definition of table `appconfig`
--

DROP TABLE IF EXISTS `appconfig`;
CREATE TABLE `appconfig` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `section` varchar(50) NOT NULL DEFAULT '',
  `optionname` varchar(50) NOT NULL,
  `description` varchar(255) NOT NULL,
  `optionvalue` varchar(255) DEFAULT '',
  `optiontype` varchar(15) DEFAULT '',
  `active` enum('Y','N') NOT NULL DEFAULT 'Y',
  `datecreated` datetime NOT NULL,
  `createdby` int(11) unsigned NOT NULL,
  `lastupdatedate` datetime DEFAULT NULL,
  `lastupdatedby` int(11) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `appconfig`
--

/*!40000 ALTER TABLE `appconfig` DISABLE KEYS */;
INSERT INTO `appconfig` (`id`,`section`,`optionname`,`description`,`optionvalue`,`optiontype`,`active`,`datecreated`,`createdby`,`lastupdatedate`,`lastupdatedby`) VALUES 
 (1,'backup','retentionperiod','','30','integer','Y','2012-03-01 12:00:00',1,NULL,NULL),
 (2,'backup','scriptfolder','The path relative to the APPLICATION_PATH variable, use a starting / since the variable is a folder name','/backup/scripts','text','Y','2012-03-01 12:00:00',1,NULL,NULL),
 (3,'backup','usegzip','Whether to use gzip compression or not, options are yes and no','no','text','Y','2012-03-01 12:00:00',1,NULL,NULL),
 (4,'backup','removesqlfile','Remove SQL file after processing, options are yes and no','no','text','Y','2012-03-01 12:00:00',1,NULL,NULL),
 (5,'backup','sendemail','Send backup via email, options are yes and no','no','text','Y','2012-03-01 12:00:00',1,NULL,NULL),
 (6,'currency','defaultsymbol','','Ugx','text','Y','2012-03-01 12:00:00',1,NULL,NULL),
 (7,'currency','default','','Shs','text','Y','2012-03-01 12:00:00',1,NULL,NULL),
 (8,'currency','decimalplaces','','0','integer','Y','2012-03-01 12:00:00',1,NULL,NULL),
 (9,'currency','mincurrencyvalue','','1','decimal','Y','2012-03-01 12:00:00',1,NULL,NULL),
 (10,'currency','maxcurrencyvalue','','10000','decimal','Y','2012-03-01 12:00:00',1,NULL,NULL),
 (12,'dateandtime','shortformat','','m/d/Y','text','Y','2012-03-01 12:00:00',1,NULL,NULL),
 (13,'dateandtime','mediumformat','','M j, Y','text','Y','2012-03-01 12:00:00',1,NULL,NULL),
 (14,'dateandtime','longformat','','l, j F Y','text','Y','2012-03-01 12:00:00',1,NULL,NULL),
 (15,'dateandtime','mysqlformat','','%m/%d/%Y','text','Y','2012-03-01 12:00:00',1,NULL,NULL),
 (16,'dateandtime','mysqlmediumformat','','%d %b, %Y','text','Y','2012-03-01 12:00:00',1,NULL,NULL),
 (17,'dateandtime','mysqldateandtimeformat','','%m/%d/%Y - %H:%i:%s','text','Y','2012-03-01 12:00:00',1,NULL,NULL),
 (19,'password','minlength','The minimum length of a password','6','integer','Y','2012-03-01 12:00:00',1,NULL,NULL),
 (20,'dateandtime','mindate','The minimum date for the date picker','2','integer','Y','2012-03-01 12:00:00',1,NULL,NULL),
 (21,'dateandtime','maxdate','The maximum date for the date picker','2','integer','Y','2012-03-01 12:00:00',1,NULL,NULL),
 (22,'dateandtime','javascriptmediumformat','The format for Javascript dates','M dd, yy','text','Y','2012-03-01 12:00:00',1,NULL,NULL),
 (23,'dateandtime','javascriptshortformat','Short date for Javascript dates','m/dd/yy','test','Y','2012-03-01 12:00:00',1,NULL,NULL),
 (24,'document','allowedformats','Allowed document file formats','doc, docx, pdf, txt, jpg, jpeg, png, bmp','text','Y','2012-03-01 12:00:00',1,NULL,NULL),
 (25,'document','maximumfilesize','Maximum size of a document in bytes','2000000','integer','Y','2012-03-01 12:00:00',1,NULL,NULL),
 (26,'password','maxlength','The maximum length of a password','20','integer','Y','2012-03-01 12:00:00',1,NULL,NULL),
 (27,'paypal','receiveremail','The email address registered with the PayPal account to be used','paypal@domain.com','text','Y','2012-03-01 12:00:00',1,NULL,NULL),
 (28,'paypal','servername','PayPal Server name','www.sandbox.paypal.com','text','Y','2012-03-01 12:00:00',1,NULL,NULL),
 (29,'paypal','serverurl','The URL of the paypal server','https://www.sandbox.paypal.com/cgi-bin/webscr','text','Y','2012-03-01 12:00:00',1,NULL,NULL),
 (30,'notification','emailmessagesender','The email address the application uses to send out notifications','administrator@veritracker.com','text','Y','2012-03-01 12:00:00',1,NULL,NULL),
 (31,'profilephoto','allowedformats','Allowed photo file formats','jpg, jpeg, png','text','Y','2012-03-01 12:00:00',1,NULL,NULL),
 (32,'profilephoto','maximumfilesize','Maximum size of a profile photo in bytes','2000000','integer','Y','2012-03-01 12:00:00',1,NULL,NULL),
 (33,'paypal','itemname','Item name displayed in PayPal and on the receipt','Payment Membership','text','Y','2012-03-01 12:00:00',1,NULL,NULL),
 (34,'paypal','itemnumber','Item number displayed in PayPal and on the receipt','ZMD-001','text','Y','2012-03-01 12:00:00',1,NULL,NULL),
 (35,'notification','supportemailaddress','The address to which support emails are sent','admin@devmail.infomacorp.com','text','Y','2012-02-28 15:59:27',1,NULL,NULL),
 (36,'dateandtime','mindateofbirth','The number of years before today for allowable date for the hire date','100','integer','Y','2011-05-18 09:55:32',1,NULL,NULL);
/*!40000 ALTER TABLE `appconfig` ENABLE KEYS */;


--
-- Definition of table `audittrail`
--

DROP TABLE IF EXISTS `audittrail`;
CREATE TABLE `audittrail` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `userid` int(11) unsigned DEFAULT NULL,
  `transactiontype` varchar(50) NOT NULL,
  `transactiondetails` mediumtext,
  `transactiondate` datetime NOT NULL,
  `executedby` int(11) unsigned DEFAULT NULL,
  `success` enum('N','Y') NOT NULL DEFAULT 'N',
  `browserdetails` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_audittrail_transactiontype` (`transactiontype`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `audittrail`
--

/*!40000 ALTER TABLE `audittrail` DISABLE KEYS */;
/*!40000 ALTER TABLE `audittrail` ENABLE KEYS */;


--
-- Definition of table `lookupquery`
--

DROP TABLE IF EXISTS `lookupquery`;
CREATE TABLE `lookupquery` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `querystring` varchar(500) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `lookupquery`
--

/*!40000 ALTER TABLE `lookupquery` DISABLE KEYS */;
INSERT INTO `lookupquery` (`id`,`name`,`description`,`querystring`) VALUES 
 (1,'ALL_USERS','Returns the list of all Users in the system','SELECT u.id as optionvalue, concat(u.firstname,\' \',u.lastname) as optiontext FROM useraccount u ORDER BY optiontext'),
 (2,'ALL_ACL_GROUPS','All defined ACL groups','SELECT id as optionvalue, name as optiontext FROM aclgroup'),
 (3,'ALL_RESOURCES','The resources that are secured within the application','SELECT r.name AS optiontext, r.id AS optionvalue FROM aclresource AS r ORDER BY optiontext');
/*!40000 ALTER TABLE `lookupquery` ENABLE KEYS */;


--
-- Definition of table `lookuptype`
--

DROP TABLE IF EXISTS `lookuptype`;
CREATE TABLE `lookuptype` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `displayname` varchar(50) NOT NULL,
  `listable` tinyint(4) unsigned DEFAULT '1',
  `updatable` tinyint(4) unsigned DEFAULT NULL,
  `description` varchar(255) NOT NULL,
  `datecreated` datetime NOT NULL,
  `createdby` int(11) unsigned NOT NULL,
  `lastupdatedate` datetime DEFAULT NULL,
  `lastupdatedby` int(11) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `lookuptype`
--

/*!40000 ALTER TABLE `lookuptype` DISABLE KEYS */;
INSERT INTO `lookuptype` (`id`,`name`,`displayname`,`listable`,`updatable`,`description`,`datecreated`,`createdby`,`lastupdatedate`,`lastupdatedby`) VALUES 
 (1,'YES_NO','Yes No Boolean ',1,0,'Yes, No value options.','2012-03-01 12:00:00',1,NULL,NULL),
 (2,'TRANSACTION_TYPES','Transaction Types',1,0,'System Audit Trail transaction types.','2012-03-01 12:00:00',1,NULL,NULL),
 (3,'LIST_ITEM_COUNT_OPTIONS','Listing Items Per Page Values',1,0,'Available number of items per page on lists','2012-03-01 12:00:00',1,NULL,NULL),
 (4,'ACTIVE_STATUS','Active Status Boolean',1,0,'Whether a user is active or not','2012-03-01 12:00:00',1,NULL,NULL),
 (5,'GENDER','Gender Values',1,0,'The different gender values','2012-03-19 18:50:51',1,NULL,NULL),
 (6,'ACTION_STATUS','Activity Statuses',1,1,'The progress status values','2012-03-01 12:00:00',1,NULL,NULL),
 (7,'CONTACTUS_CATEGORIES','Contact Us Form Categories',1,1,'The contactus form categories','2012-03-01 12:00:00',1,NULL,NULL);
/*!40000 ALTER TABLE `lookuptype` ENABLE KEYS */;


--
-- Definition of table `lookuptypevalue`
--

DROP TABLE IF EXISTS `lookuptypevalue`;
CREATE TABLE `lookuptypevalue` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `lookuptypeid` int(11) unsigned NOT NULL,
  `lookuptypevalue` varchar(50) NOT NULL,
  `lookupvaluedescription` varchar(255) NOT NULL,
  `createdby` int(11) unsigned NOT NULL,
  `datecreated` datetime NOT NULL,
  `lastupdatedate` datetime DEFAULT NULL,
  `lastupdatedby` int(11) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_lookuptypevalue_createdby` (`createdby`),
  KEY `fk_lookuptypevalue_lastupdatedby` (`lastupdatedby`),
  KEY `fk_lookuptypevalue_lookuptypeid` (`lookuptypeid`),
  CONSTRAINT `fk_lookuptypevalue_createdby` FOREIGN KEY (`createdby`) REFERENCES `useraccount` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_lookuptypevalue_lastupdatedby` FOREIGN KEY (`lastupdatedby`) REFERENCES `useraccount` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_lookuptypevalue_lookuptypeid` FOREIGN KEY (`lookuptypeid`) REFERENCES `lookuptype` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `lookuptypevalue`
--

/*!40000 ALTER TABLE `lookuptypevalue` DISABLE KEYS */;
INSERT INTO `lookuptypevalue` (`id`,`lookuptypeid`,`lookuptypevalue`,`lookupvaluedescription`,`createdby`,`datecreated`,`lastupdatedate`,`lastupdatedby`) VALUES 
 (1,1,'1','Yes',1,'2012-03-01 12:00:00',NULL,NULL),
 (2,1,'0','No',1,'2012-03-01 12:00:00',NULL,NULL),
 (3,2,'Login','User login transaction',1,'2012-03-01 12:00:00',NULL,NULL),
 (4,2,'Logout','User logout transaction',1,'2012-03-01 12:00:00',NULL,NULL),
 (5,2,'Recover Password','User password recovery transaction',1,'2012-03-01 12:00:00',NULL,NULL),
 (6,3,'10','10',1,'2012-03-01 12:00:00',NULL,NULL),
 (7,3,'25','25',1,'2012-03-01 12:00:00',NULL,NULL),
 (8,3,'50','50',1,'2012-03-01 12:00:00',NULL,NULL),
 (9,3,'100','100',1,'2012-03-01 12:00:00',NULL,NULL),
 (10,4,'Active','Active',1,'2012-03-01 12:00:00',NULL,NULL),
 (11,4,'In Active','In Active',1,'2012-03-01 12:00:00',NULL,NULL),
 (12,3,'250','100',1,'2012-03-01 12:00:00',NULL,NULL),
 (13,3,'500','100',1,'2012-03-01 12:00:00',NULL,NULL),
 (14,3,'All','100',1,'2012-03-01 12:00:00',NULL,NULL),
 (15,5,'Visa','Visa',1,'2012-03-01 12:00:00',NULL,NULL),
 (16,5,'MasterCard','MasterCard',1,'2012-03-01 12:00:00',NULL,NULL),
 (17,5,'Discover','Discover',1,'2012-03-01 12:00:00',NULL,NULL),
 (18,5,'American Express','American Express',1,'2012-03-01 12:00:00',NULL,NULL),
 (19,5,'1','Male',1,'2012-03-22 12:06:17',NULL,NULL),
 (20,5,'2','Female',1,'2012-03-22 12:06:28',NULL,NULL),
 (21,6,'1','Not Started',1,'2012-03-01 12:00:00',NULL,NULL),
 (22,6,'2','In Progress',1,'2012-03-01 12:00:00',NULL,NULL),
 (23,6,'3','Completed',1,'2012-03-01 12:00:00',NULL,NULL),
 (24,7,'1','Feedback',1,'2012-03-01 12:00:00',NULL,NULL),
 (25,7,'2','Ask a Question',1,'2012-03-01 12:00:00',NULL,NULL),
 (26,7,'3','Submit a Bug',1,'2012-03-01 12:00:00',NULL,NULL),
 (27,7,'4','Sign up Problems',1,'2012-03-01 12:00:00',NULL,NULL),
 (28,7,'5','Account compromised',1,'2012-03-01 12:00:00',NULL,NULL),
 (29,7,'6','Failed to Login',1,'2012-03-01 12:00:00',NULL,NULL),
 (30,7,'7','Suggestion',1,'2012-03-01 12:00:00',NULL,NULL),
 (31,7,'8','Need Help',1,'2012-03-01 12:00:00',NULL,NULL),
 (32,7,'9','Other',1,'2012-03-01 12:00:00',NULL,NULL);
/*!40000 ALTER TABLE `lookuptypevalue` ENABLE KEYS */;


--
-- Definition of table `session`
--

DROP TABLE IF EXISTS `session`;
CREATE TABLE `session` (
  `id` char(32) NOT NULL DEFAULT '',
  `modified` int(11) DEFAULT NULL,
  `lifetime` int(11) DEFAULT NULL,
  `data` mediumtext,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `session`
--

/*!40000 ALTER TABLE `session` DISABLE KEYS */;
/*!40000 ALTER TABLE `session` ENABLE KEYS */;


--
-- Definition of table `useraccount`
--

DROP TABLE IF EXISTS `useraccount`;
CREATE TABLE `useraccount` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `type` tinyint(4) NOT NULL,
  `firstname` varchar(255) NOT NULL,
  `lastname` varchar(255) NOT NULL,
  `othernames` varchar(255) DEFAULT NULL,
  `username` varchar(10) DEFAULT NULL,
  `email` varchar(50) DEFAULT NULL,
  `email2` varchar(50) DEFAULT NULL,
  `phone` varchar(15) DEFAULT NULL,
  `phone2` varchar(15) DEFAULT NULL,
  `password` varchar(50) DEFAULT '',
  `gender` tinyint(4) DEFAULT NULL,
  `country` varchar(2) DEFAULT NULL,
  `city` varchar(50) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `dateofbirth` date DEFAULT NULL,
  `isactive` tinyint(4) unsigned DEFAULT '0',
  `activationkey` varchar(50) DEFAULT NULL,
  `activationdate` datetime DEFAULT NULL,
  `agreedtoterms` tinyint(1) unsigned DEFAULT '0',
  `bio` mediumtext,
  `profilephoto` varchar(255) DEFAULT '',
  `notes` varchar(1000) DEFAULT NULL,
  `securityquestion` tinyint(4) unsigned DEFAULT NULL,
  `securityanswer` tinyint(4) unsigned DEFAULT NULL,
  `datecreated` datetime NOT NULL,
  `createdby` int(11) unsigned DEFAULT NULL,
  `lastupdatedate` datetime DEFAULT NULL,
  `lastupdatedby` int(11) unsigned DEFAULT NULL,
  `phone_actkey` varchar(10) DEFAULT NULL,
  `phone2_actkey` varchar(10) DEFAULT NULL,
  `phone_isactivated` tinyint(4) unsigned DEFAULT NULL,
  `phone2_isactivated` tinyint(4) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_useraccount_createdby` (`createdby`),
  KEY `fk_useraccount_lastupdatedby` (`lastupdatedby`),
  KEY `index_useraccount_isactive` (`isactive`) USING BTREE,
  KEY `index_useraccount_country` (`country`),
  KEY `index_useraccount_username` (`username`),
  CONSTRAINT `fk_useraccount_createdby` FOREIGN KEY (`createdby`) REFERENCES `useraccount` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `fk_useraccount_lastupdatedby` FOREIGN KEY (`lastupdatedby`) REFERENCES `useraccount` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2802 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `useraccount`
--

/*!40000 ALTER TABLE `useraccount` DISABLE KEYS */;
INSERT INTO `useraccount` (`id`,`type`,`firstname`,`lastname`,`othernames`,`username`,`email`,`email2`,`phone`,`phone2`,`password`,`gender`,`country`,`city`,`address`,`dateofbirth`,`isactive`,`activationkey`,`activationdate`,`agreedtoterms`,`bio`,`profilephoto`,`notes`,`securityquestion`,`securityanswer`,`datecreated`,`createdby`,`lastupdatedate`,`lastupdatedby`,`phone_actkey`,`phone2_actkey`,`phone_isactivated`,`phone2_isactivated`) VALUES 
 (1,1,'Edward','Lawrence','Peterson','admin','admin@devmail.infomacorp.com',NULL,NULL,NULL,'5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8',1,'UG',NULL,NULL,'1950-01-01',1,'','2013-05-01 01:33:10',1,'','','',NULL,NULL,'2012-09-07 10:06:57',1,NULL,NULL,NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `useraccount` ENABLE KEYS */;




/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
