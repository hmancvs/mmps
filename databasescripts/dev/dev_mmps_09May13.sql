/*
Navicat MySQL Data Transfer

Source Server         : localhost_dev
Source Server Version : 50524
Source Host           : localhost:3306
Source Database       : mmps

Target Server Type    : MYSQL
Target Server Version : 50524
File Encoding         : 65001

Date: 2013-05-09 20:20:47
*/

SET FOREIGN_KEY_CHECKS=0;
-- ----------------------------
-- Table structure for `aclgroup`
-- ----------------------------
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

-- ----------------------------
-- Records of aclgroup
-- ----------------------------
INSERT INTO `aclgroup` VALUES ('1', 'Administrator', 'Overall system administrator', '2013-05-01 12:00:00', '1', null, null);
INSERT INTO `aclgroup` VALUES ('2', 'Individual Customer', 'Customers who purchase items from the portal', '2013-05-01 12:00:00', '1', null, null);
INSERT INTO `aclgroup` VALUES ('3', 'Company Admin', 'Administrator of company shopping platform', '2013-05-01 12:00:00', '1', null, null);
INSERT INTO `aclgroup` VALUES ('4', 'Company Customer', 'Customer who registers to make purchases fromm a company', '2013-05-01 12:00:00', '1', null, null);
INSERT INTO `aclgroup` VALUES ('5', 'Management', 'Management of portal and financial reports', '2013-05-01 12:00:00', '1', null, null);
INSERT INTO `aclgroup` VALUES ('6', 'Data Clerk', 'Data entry clerk for portal ', '2013-05-01 12:00:00', '1', null, null);

-- ----------------------------
-- Table structure for `aclpermission`
-- ----------------------------
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

-- ----------------------------
-- Records of aclpermission
-- ----------------------------
INSERT INTO `aclpermission` VALUES ('1', '1', '1', '0', '0', '1', '1', '0', '0', '0', '0', '2012-03-01 12:00:00', '1', null, null);
INSERT INTO `aclpermission` VALUES ('2', '1', '2', '1', '1', '1', '1', '1', '0', '0', '0', '2012-03-01 12:00:00', '1', null, null);
INSERT INTO `aclpermission` VALUES ('3', '1', '3', '1', '1', '1', '1', '1', '0', '0', '0', '2012-03-01 12:00:00', '1', null, null);
INSERT INTO `aclpermission` VALUES ('4', '1', '4', '0', '0', '1', '1', '0', '1', '0', '0', '2012-03-01 12:00:00', '1', null, null);
INSERT INTO `aclpermission` VALUES ('5', '1', '5', '1', '1', '1', '1', '1', '1', '0', '0', '2012-03-01 12:00:00', '1', null, null);
INSERT INTO `aclpermission` VALUES ('6', '1', '7', '1', '1', '1', '1', '0', '0', '0', '0', '2012-03-01 12:00:00', '1', null, null);
INSERT INTO `aclpermission` VALUES ('7', '1', '8', '0', '0', '1', '0', '0', '0', '0', '0', '2012-03-01 12:00:00', '1', null, null);
INSERT INTO `aclpermission` VALUES ('8', '1', '6', '0', '0', '1', '0', '0', '0', '0', '0', '2012-03-01 12:00:00', '1', null, null);
INSERT INTO `aclpermission` VALUES ('9', '1', '9', '0', '0', '1', '0', '0', '0', '0', '0', '2012-03-01 12:00:00', '1', null, null);
INSERT INTO `aclpermission` VALUES ('10', '1', '10', '0', '0', '1', '0', '0', '0', '0', '0', '2012-03-01 12:00:00', '1', null, null);
INSERT INTO `aclpermission` VALUES ('11', '1', '11', '0', '0', '1', '0', '0', '0', '0', '0', '2012-03-01 12:00:00', '1', null, null);
INSERT INTO `aclpermission` VALUES ('12', '1', '12', '1', '1', '1', '1', '1', '0', '0', '0', '2012-03-01 12:00:00', '1', null, null);
INSERT INTO `aclpermission` VALUES ('13', '2', '3', '1', '1', '1', '0', '0', '0', '0', '0', '2012-09-07 22:05:39', '1', null, null);
INSERT INTO `aclpermission` VALUES ('14', '2', '6', '0', '0', '1', '0', '0', '0', '0', '0', '2012-09-07 22:05:39', '1', null, null);
INSERT INTO `aclpermission` VALUES ('15', '2', '12', '1', '1', '1', '1', '0', '0', '0', '0', '2012-09-07 22:05:39', '1', null, null);
INSERT INTO `aclpermission` VALUES ('16', '3', '12', '1', '1', '1', '1', '0', '0', '0', '0', '2012-09-07 22:05:39', '1', null, null);
INSERT INTO `aclpermission` VALUES ('17', '4', '12', '1', '1', '1', '1', '1', '0', '0', '0', '2012-09-07 22:05:39', '1', null, null);
INSERT INTO `aclpermission` VALUES ('18', '5', '12', '1', '1', '1', '1', '1', '0', '0', '0', '2012-09-07 22:05:39', '1', null, null);
INSERT INTO `aclpermission` VALUES ('19', '1', '13', '1', '1', '1', '1', '1', '0', '0', '0', '2012-09-07 22:05:39', '1', null, null);
INSERT INTO `aclpermission` VALUES ('20', '2', '13', '0', '0', '1', '1', '0', '0', '0', '0', '2012-09-07 22:05:39', '1', null, null);
INSERT INTO `aclpermission` VALUES ('21', '3', '13', '1', '1', '1', '1', '0', '0', '0', '0', '2012-09-07 22:05:39', '1', null, null);
INSERT INTO `aclpermission` VALUES ('22', '4', '13', '1', '1', '1', '1', '0', '0', '0', '0', '2012-09-07 22:05:39', '1', null, null);
INSERT INTO `aclpermission` VALUES ('23', '5', '13', '1', '1', '1', '1', '1', '0', '0', '0', '2012-09-07 22:05:39', '1', null, null);
INSERT INTO `aclpermission` VALUES ('24', '1', '14', '0', '0', '1', '0', '0', '0', '0', '0', '2012-03-20 22:29:09', '1', null, null);
INSERT INTO `aclpermission` VALUES ('25', '5', '14', '0', '0', '1', '0', '0', '0', '0', '0', '2012-03-20 22:29:09', '1', null, null);
INSERT INTO `aclpermission` VALUES ('26', '2', '15', '0', '0', '1', '0', '0', '0', '0', '0', '2012-03-20 22:29:09', '1', null, null);
INSERT INTO `aclpermission` VALUES ('27', '4', '16', '0', '0', '1', '0', '0', '0', '0', '0', '2012-03-20 22:29:09', '1', null, null);
INSERT INTO `aclpermission` VALUES ('28', '5', '1', '0', '0', '1', '1', '0', '0', '0', '0', '0000-00-00 00:00:00', '0', null, null);
INSERT INTO `aclpermission` VALUES ('29', '5', '2', '1', '1', '1', '1', '1', '0', '0', '0', '0000-00-00 00:00:00', '0', null, null);
INSERT INTO `aclpermission` VALUES ('30', '5', '3', '1', '1', '1', '1', '1', '0', '0', '0', '0000-00-00 00:00:00', '0', null, null);
INSERT INTO `aclpermission` VALUES ('31', '3', '3', '1', '1', '1', '1', '0', '0', '0', '0', '0000-00-00 00:00:00', '0', null, null);
INSERT INTO `aclpermission` VALUES ('32', '4', '3', '1', '1', '1', '1', '0', '0', '0', '0', '0000-00-00 00:00:00', '0', null, null);
INSERT INTO `aclpermission` VALUES ('33', '3', '6', '0', '0', '1', '0', '0', '0', '0', '0', '0000-00-00 00:00:00', '0', null, null);
INSERT INTO `aclpermission` VALUES ('34', '4', '6', '0', '0', '1', '0', '0', '0', '0', '0', '0000-00-00 00:00:00', '0', null, null);
INSERT INTO `aclpermission` VALUES ('35', '5', '6', '0', '0', '1', '0', '0', '0', '0', '0', '0000-00-00 00:00:00', '0', null, null);
INSERT INTO `aclpermission` VALUES ('36', '5', '7', '1', '1', '1', '1', '0', '0', '0', '0', '0000-00-00 00:00:00', '0', null, null);
INSERT INTO `aclpermission` VALUES ('37', '3', '14', '0', '0', '1', '0', '0', '0', '0', '0', '0000-00-00 00:00:00', '0', null, null);

-- ----------------------------
-- Table structure for `aclresource`
-- ----------------------------
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

-- ----------------------------
-- Records of aclresource
-- ----------------------------
INSERT INTO `aclresource` VALUES ('1', 'Lookup Type', 'Look up types', '0', '0', '1', '1', '0', '0', '0', '0', '2012-03-01 12:00:00', '1', null, null);
INSERT INTO `aclresource` VALUES ('2', 'Lookup Value', 'Values for the lookup type', '1', '1', '1', '1', '1', '0', '0', '0', '2012-03-01 12:00:00', '1', null, null);
INSERT INTO `aclresource` VALUES ('3', 'User Account', 'A user within the application', '1', '1', '1', '1', '1', '0', '1', '0', '2012-03-01 12:00:00', '1', null, null);
INSERT INTO `aclresource` VALUES ('4', 'Audit Trail', 'Log of selected transactions within the application', '0', '0', '1', '1', '0', '0', '1', '0', '2012-03-01 12:00:00', '1', null, null);
INSERT INTO `aclresource` VALUES ('5', 'Role', 'Actions a member can execute on resources', '1', '1', '1', '1', '1', '0', '1', '0', '2012-03-01 12:00:00', '1', null, null);
INSERT INTO `aclresource` VALUES ('6', 'Dashboard', 'user dashboard', '0', '0', '1', '0', '0', '0', '0', '0', '2012-03-01 12:00:00', '1', null, null);
INSERT INTO `aclresource` VALUES ('7', 'Application Settings', 'Application Administration', '1', '1', '1', '1', '0', '0', '0', '0', '2012-03-01 12:00:00', '1', null, null);
INSERT INTO `aclresource` VALUES ('8', 'Report', 'The different reports in the Application', '0', '0', '1', '0', '0', '0', '0', '0', '2012-03-01 12:00:00', '1', null, null);
INSERT INTO `aclresource` VALUES ('9', 'Billing', 'Billing and payment information', '0', '0', '1', '0', '0', '0', '0', '0', '2012-03-01 12:00:00', '1', null, null);
INSERT INTO `aclresource` VALUES ('10', 'Payments Report', 'Payments Report', '0', '0', '1', '0', '0', '0', '0', '0', '2012-03-01 12:00:00', '1', null, null);
INSERT INTO `aclresource` VALUES ('11', 'Subscriptions Report', 'Subscriptions Report', '0', '0', '1', '0', '0', '0', '0', '0', '2012-03-01 12:00:00', '1', null, null);

-- ----------------------------
-- Table structure for `aclusergroup`
-- ----------------------------
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

-- ----------------------------
-- Records of aclusergroup
-- ----------------------------
INSERT INTO `aclusergroup` VALUES ('1', '1', '1');

-- ----------------------------
-- Table structure for `address`
-- ----------------------------
DROP TABLE IF EXISTS `address`;
CREATE TABLE `address` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `userid` int(11) unsigned DEFAULT NULL,
  `customerid` int(11) unsigned DEFAULT NULL,
  `type` tinyint(3) unsigned NOT NULL,
  `firstname` varchar(50) DEFAULT NULL,
  `lastname` varchar(50) DEFAULT NULL,
  `company` varchar(50) DEFAULT NULL,
  `country` varchar(2) DEFAULT NULL,
  `city` varchar(50) DEFAULT NULL,
  `state` varchar(50) DEFAULT NULL,
  `zipcode` varchar(15) DEFAULT NULL,
  `postalcode` varchar(15) DEFAULT NULL,
  `streetaddress` varchar(255) DEFAULT NULL,
  `streetaddress2` varchar(255) DEFAULT NULL,
  `isprimary` tinyint(4) unsigned DEFAULT NULL,
  `datecreated` date DEFAULT NULL,
  `createdby` int(11) unsigned DEFAULT NULL,
  `lastupdatedate` date DEFAULT NULL,
  `lastupdatedby` int(11) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_address_type` (`type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of address
-- ----------------------------

-- ----------------------------
-- Table structure for `appconfig`
-- ----------------------------
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

-- ----------------------------
-- Records of appconfig
-- ----------------------------
INSERT INTO `appconfig` VALUES ('1', 'backup', 'retentionperiod', '', '30', 'integer', 'Y', '2012-03-01 12:00:00', '1', null, null);
INSERT INTO `appconfig` VALUES ('2', 'backup', 'scriptfolder', 'The path relative to the APPLICATION_PATH variable, use a starting / since the variable is a folder name', '/backup/scripts', 'text', 'Y', '2012-03-01 12:00:00', '1', null, null);
INSERT INTO `appconfig` VALUES ('3', 'backup', 'usegzip', 'Whether to use gzip compression or not, options are yes and no', 'no', 'text', 'Y', '2012-03-01 12:00:00', '1', null, null);
INSERT INTO `appconfig` VALUES ('4', 'backup', 'removesqlfile', 'Remove SQL file after processing, options are yes and no', 'no', 'text', 'Y', '2012-03-01 12:00:00', '1', null, null);
INSERT INTO `appconfig` VALUES ('5', 'backup', 'sendemail', 'Send backup via email, options are yes and no', 'no', 'text', 'Y', '2012-03-01 12:00:00', '1', null, null);
INSERT INTO `appconfig` VALUES ('6', 'currency', 'defaultsymbol', '', 'Ugx', 'text', 'Y', '2012-03-01 12:00:00', '1', null, null);
INSERT INTO `appconfig` VALUES ('7', 'currency', 'default', '', 'Shs', 'text', 'Y', '2012-03-01 12:00:00', '1', null, null);
INSERT INTO `appconfig` VALUES ('8', 'currency', 'decimalplaces', '', '0', 'integer', 'Y', '2012-03-01 12:00:00', '1', null, null);
INSERT INTO `appconfig` VALUES ('9', 'currency', 'mincurrencyvalue', '', '1', 'decimal', 'Y', '2012-03-01 12:00:00', '1', null, null);
INSERT INTO `appconfig` VALUES ('10', 'currency', 'maxcurrencyvalue', '', '10000', 'decimal', 'Y', '2012-03-01 12:00:00', '1', null, null);
INSERT INTO `appconfig` VALUES ('12', 'dateandtime', 'shortformat', '', 'm/d/Y', 'text', 'Y', '2012-03-01 12:00:00', '1', null, null);
INSERT INTO `appconfig` VALUES ('13', 'dateandtime', 'mediumformat', '', 'M j, Y', 'text', 'Y', '2012-03-01 12:00:00', '1', null, null);
INSERT INTO `appconfig` VALUES ('14', 'dateandtime', 'longformat', '', 'l, j F Y', 'text', 'Y', '2012-03-01 12:00:00', '1', null, null);
INSERT INTO `appconfig` VALUES ('15', 'dateandtime', 'mysqlformat', '', '%m/%d/%Y', 'text', 'Y', '2012-03-01 12:00:00', '1', null, null);
INSERT INTO `appconfig` VALUES ('16', 'dateandtime', 'mysqlmediumformat', '', '%d %b, %Y', 'text', 'Y', '2012-03-01 12:00:00', '1', null, null);
INSERT INTO `appconfig` VALUES ('17', 'dateandtime', 'mysqldateandtimeformat', '', '%m/%d/%Y - %H:%i:%s', 'text', 'Y', '2012-03-01 12:00:00', '1', null, null);
INSERT INTO `appconfig` VALUES ('19', 'password', 'minlength', 'The minimum length of a password', '6', 'integer', 'Y', '2012-03-01 12:00:00', '1', null, null);
INSERT INTO `appconfig` VALUES ('20', 'dateandtime', 'mindate', 'The minimum date for the date picker', '2', 'integer', 'Y', '2012-03-01 12:00:00', '1', null, null);
INSERT INTO `appconfig` VALUES ('21', 'dateandtime', 'maxdate', 'The maximum date for the date picker', '2', 'integer', 'Y', '2012-03-01 12:00:00', '1', null, null);
INSERT INTO `appconfig` VALUES ('22', 'dateandtime', 'javascriptmediumformat', 'The format for Javascript dates', 'M dd, yy', 'text', 'Y', '2012-03-01 12:00:00', '1', null, null);
INSERT INTO `appconfig` VALUES ('23', 'dateandtime', 'javascriptshortformat', 'Short date for Javascript dates', 'm/dd/yy', 'test', 'Y', '2012-03-01 12:00:00', '1', null, null);
INSERT INTO `appconfig` VALUES ('24', 'document', 'allowedformats', 'Allowed document file formats', 'doc, docx, pdf, txt, jpg, jpeg, png, bmp', 'text', 'Y', '2012-03-01 12:00:00', '1', null, null);
INSERT INTO `appconfig` VALUES ('25', 'document', 'maximumfilesize', 'Maximum size of a document in bytes', '2000000', 'integer', 'Y', '2012-03-01 12:00:00', '1', null, null);
INSERT INTO `appconfig` VALUES ('26', 'password', 'maxlength', 'The maximum length of a password', '20', 'integer', 'Y', '2012-03-01 12:00:00', '1', null, null);
INSERT INTO `appconfig` VALUES ('27', 'paypal', 'receiveremail', 'The email address registered with the PayPal account to be used', 'paypal@domain.com', 'text', 'Y', '2012-03-01 12:00:00', '1', null, null);
INSERT INTO `appconfig` VALUES ('28', 'paypal', 'servername', 'PayPal Server name', 'www.sandbox.paypal.com', 'text', 'Y', '2012-03-01 12:00:00', '1', null, null);
INSERT INTO `appconfig` VALUES ('29', 'paypal', 'serverurl', 'The URL of the paypal server', 'https://www.sandbox.paypal.com/cgi-bin/webscr', 'text', 'Y', '2012-03-01 12:00:00', '1', null, null);
INSERT INTO `appconfig` VALUES ('30', 'notification', 'emailmessagesender', 'The email address the application uses to send out notifications', 'administrator@veritracker.com', 'text', 'Y', '2012-03-01 12:00:00', '1', null, null);
INSERT INTO `appconfig` VALUES ('31', 'profilephoto', 'allowedformats', 'Allowed photo file formats', 'jpg, jpeg, png', 'text', 'Y', '2012-03-01 12:00:00', '1', null, null);
INSERT INTO `appconfig` VALUES ('32', 'profilephoto', 'maximumfilesize', 'Maximum size of a profile photo in bytes', '2000000', 'integer', 'Y', '2012-03-01 12:00:00', '1', null, null);
INSERT INTO `appconfig` VALUES ('33', 'paypal', 'itemname', 'Item name displayed in PayPal and on the receipt', 'Payment Membership', 'text', 'Y', '2012-03-01 12:00:00', '1', null, null);
INSERT INTO `appconfig` VALUES ('34', 'paypal', 'itemnumber', 'Item number displayed in PayPal and on the receipt', 'ZMD-001', 'text', 'Y', '2012-03-01 12:00:00', '1', null, null);
INSERT INTO `appconfig` VALUES ('35', 'notification', 'supportemailaddress', 'The address to which support emails are sent', 'admin@devmail.infomacorp.com', 'text', 'Y', '2012-02-28 15:59:27', '1', null, null);
INSERT INTO `appconfig` VALUES ('36', 'dateandtime', 'mindateofbirth', 'The number of years before today for allowable date for the hire date', '100', 'integer', 'Y', '2011-05-18 09:55:32', '1', null, null);

-- ----------------------------
-- Table structure for `audittrail`
-- ----------------------------
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

-- ----------------------------
-- Records of audittrail
-- ----------------------------

-- ----------------------------
-- Table structure for `category`
-- ----------------------------
DROP TABLE IF EXISTS `category`;
CREATE TABLE `category` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `parentid` int(11) unsigned DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `image` varchar(255) DEFAULT NULL,
  `description` varchar(500) DEFAULT '',
  `meta_description` varchar(500) DEFAULT NULL,
  `code` char(3) NOT NULL DEFAULT '',
  `defaultprice` decimal(10,0) DEFAULT NULL,
  `status` tinyint(4) unsigned DEFAULT NULL,
  `sortorder` tinyint(4) unsigned DEFAULT NULL,
  `top` tinyint(4) unsigned DEFAULT NULL,
  `column` tinyint(4) unsigned DEFAULT NULL,
  `datecreated` datetime NOT NULL,
  `createdby` int(11) unsigned NOT NULL,
  `lastupdatedate` datetime DEFAULT NULL,
  `lastupdatedby` int(11) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_categorycode` (`code`),
  KEY `fk_category_parent` (`parentid`),
  KEY `fk_category_createdby` (`createdby`),
  KEY `fk_category_lastupdatedby` (`lastupdatedby`),
  CONSTRAINT `fk_category_createdby` FOREIGN KEY (`createdby`) REFERENCES `useraccount` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_category_lastupdatedby` FOREIGN KEY (`lastupdatedby`) REFERENCES `useraccount` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_category_parent` FOREIGN KEY (`parentid`) REFERENCES `category` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=47 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of category
-- ----------------------------

-- ----------------------------
-- Table structure for `customer`
-- ----------------------------
DROP TABLE IF EXISTS `customer`;
CREATE TABLE `customer` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `type` tinyint(4) unsigned NOT NULL,
  `firstname` varchar(50) DEFAULT NULL,
  `lastname` varchar(50) DEFAULT NULL,
  `othername` varchar(50) DEFAULT NULL,
  `orgname` varchar(50) DEFAULT NULL,
  `contactperson` varchar(255) DEFAULT NULL,
  `email` varchar(50) NOT NULL,
  `phone` varchar(15) NOT NULL,
  `phone2` varchar(15) DEFAULT NULL,
  `status` tinyint(4) unsigned NOT NULL,
  `addressid` int(11) unsigned DEFAULT NULL,
  `isapproved` tinyint(4) unsigned DEFAULT NULL,
  `dateapproved` datetime DEFAULT NULL,
  `approvedbyid` int(4) unsigned DEFAULT NULL,
  `loginid` int(11) unsigned DEFAULT NULL,
  `datecreated` datetime NOT NULL,
  `createdby` int(11) unsigned NOT NULL,
  `lastupdatedate` date DEFAULT NULL,
  `lastupdatedby` int(11) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of customer
-- ----------------------------

-- ----------------------------
-- Table structure for `lookupquery`
-- ----------------------------
DROP TABLE IF EXISTS `lookupquery`;
CREATE TABLE `lookupquery` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `querystring` varchar(500) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of lookupquery
-- ----------------------------
INSERT INTO `lookupquery` VALUES ('1', 'ALL_USERS', 'Returns the list of all Users in the system', 'SELECT u.id as optionvalue, concat(u.firstname,\' \',u.lastname) as optiontext FROM useraccount u ORDER BY optiontext');
INSERT INTO `lookupquery` VALUES ('2', 'ALL_ACL_GROUPS', 'All defined ACL groups', 'SELECT id as optionvalue, name as optiontext FROM aclgroup');
INSERT INTO `lookupquery` VALUES ('3', 'ALL_RESOURCES', 'The resources that are secured within the application', 'SELECT r.name AS optiontext, r.id AS optionvalue FROM aclresource AS r ORDER BY optiontext');

-- ----------------------------
-- Table structure for `lookuptype`
-- ----------------------------
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

-- ----------------------------
-- Records of lookuptype
-- ----------------------------
INSERT INTO `lookuptype` VALUES ('1', 'YES_NO', 'Yes No Boolean ', '1', '0', 'Yes, No value options.', '2012-03-01 12:00:00', '1', null, null);
INSERT INTO `lookuptype` VALUES ('2', 'TRANSACTION_TYPES', 'Transaction Types', '1', '0', 'System Audit Trail transaction types.', '2012-03-01 12:00:00', '1', null, null);
INSERT INTO `lookuptype` VALUES ('3', 'LIST_ITEM_COUNT_OPTIONS', 'Listing Items Per Page Values', '1', '0', 'Available number of items per page on lists', '2012-03-01 12:00:00', '1', null, null);
INSERT INTO `lookuptype` VALUES ('4', 'ACTIVE_STATUS', 'Active Status Boolean', '1', '0', 'Whether a user is active or not', '2012-03-01 12:00:00', '1', null, null);
INSERT INTO `lookuptype` VALUES ('5', 'GENDER', 'Gender Values', '1', '0', 'The different gender values', '2012-03-19 18:50:51', '1', null, null);
INSERT INTO `lookuptype` VALUES ('6', 'ACTION_STATUS', 'Activity Statuses', '1', '1', 'The progress status values', '2012-03-01 12:00:00', '1', null, null);
INSERT INTO `lookuptype` VALUES ('7', 'CONTACTUS_CATEGORIES', 'Contact Us Form Categories', '1', '1', 'The contactus form categories', '2012-03-01 12:00:00', '1', null, null);

-- ----------------------------
-- Table structure for `lookuptypevalue`
-- ----------------------------
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

-- ----------------------------
-- Records of lookuptypevalue
-- ----------------------------
INSERT INTO `lookuptypevalue` VALUES ('1', '1', '1', 'Yes', '1', '2012-03-01 12:00:00', null, null);
INSERT INTO `lookuptypevalue` VALUES ('2', '1', '0', 'No', '1', '2012-03-01 12:00:00', null, null);
INSERT INTO `lookuptypevalue` VALUES ('3', '2', 'Login', 'User login transaction', '1', '2012-03-01 12:00:00', null, null);
INSERT INTO `lookuptypevalue` VALUES ('4', '2', 'Logout', 'User logout transaction', '1', '2012-03-01 12:00:00', null, null);
INSERT INTO `lookuptypevalue` VALUES ('5', '2', 'Recover Password', 'User password recovery transaction', '1', '2012-03-01 12:00:00', null, null);
INSERT INTO `lookuptypevalue` VALUES ('6', '3', '10', '10', '1', '2012-03-01 12:00:00', null, null);
INSERT INTO `lookuptypevalue` VALUES ('7', '3', '25', '25', '1', '2012-03-01 12:00:00', null, null);
INSERT INTO `lookuptypevalue` VALUES ('8', '3', '50', '50', '1', '2012-03-01 12:00:00', null, null);
INSERT INTO `lookuptypevalue` VALUES ('9', '3', '100', '100', '1', '2012-03-01 12:00:00', null, null);
INSERT INTO `lookuptypevalue` VALUES ('10', '4', 'Active', 'Active', '1', '2012-03-01 12:00:00', null, null);
INSERT INTO `lookuptypevalue` VALUES ('11', '4', 'In Active', 'In Active', '1', '2012-03-01 12:00:00', null, null);
INSERT INTO `lookuptypevalue` VALUES ('12', '3', '250', '100', '1', '2012-03-01 12:00:00', null, null);
INSERT INTO `lookuptypevalue` VALUES ('13', '3', '500', '100', '1', '2012-03-01 12:00:00', null, null);
INSERT INTO `lookuptypevalue` VALUES ('14', '3', 'All', '100', '1', '2012-03-01 12:00:00', null, null);
INSERT INTO `lookuptypevalue` VALUES ('15', '5', 'Visa', 'Visa', '1', '2012-03-01 12:00:00', null, null);
INSERT INTO `lookuptypevalue` VALUES ('16', '5', 'MasterCard', 'MasterCard', '1', '2012-03-01 12:00:00', null, null);
INSERT INTO `lookuptypevalue` VALUES ('17', '5', 'Discover', 'Discover', '1', '2012-03-01 12:00:00', null, null);
INSERT INTO `lookuptypevalue` VALUES ('18', '5', 'American Express', 'American Express', '1', '2012-03-01 12:00:00', null, null);
INSERT INTO `lookuptypevalue` VALUES ('19', '5', '1', 'Male', '1', '2012-03-22 12:06:17', null, null);
INSERT INTO `lookuptypevalue` VALUES ('20', '5', '2', 'Female', '1', '2012-03-22 12:06:28', null, null);
INSERT INTO `lookuptypevalue` VALUES ('21', '6', '1', 'Not Started', '1', '2012-03-01 12:00:00', null, null);
INSERT INTO `lookuptypevalue` VALUES ('22', '6', '2', 'In Progress', '1', '2012-03-01 12:00:00', null, null);
INSERT INTO `lookuptypevalue` VALUES ('23', '6', '3', 'Completed', '1', '2012-03-01 12:00:00', null, null);
INSERT INTO `lookuptypevalue` VALUES ('24', '7', '1', 'Feedback', '1', '2012-03-01 12:00:00', null, null);
INSERT INTO `lookuptypevalue` VALUES ('25', '7', '2', 'Ask a Question', '1', '2012-03-01 12:00:00', null, null);
INSERT INTO `lookuptypevalue` VALUES ('26', '7', '3', 'Submit a Bug', '1', '2012-03-01 12:00:00', null, null);
INSERT INTO `lookuptypevalue` VALUES ('27', '7', '4', 'Sign up Problems', '1', '2012-03-01 12:00:00', null, null);
INSERT INTO `lookuptypevalue` VALUES ('28', '7', '5', 'Account compromised', '1', '2012-03-01 12:00:00', null, null);
INSERT INTO `lookuptypevalue` VALUES ('29', '7', '6', 'Failed to Login', '1', '2012-03-01 12:00:00', null, null);
INSERT INTO `lookuptypevalue` VALUES ('30', '7', '7', 'Suggestion', '1', '2012-03-01 12:00:00', null, null);
INSERT INTO `lookuptypevalue` VALUES ('31', '7', '8', 'Need Help', '1', '2012-03-01 12:00:00', null, null);
INSERT INTO `lookuptypevalue` VALUES ('32', '7', '9', 'Other', '1', '2012-03-01 12:00:00', null, null);

-- ----------------------------
-- Table structure for `order`
-- ----------------------------
DROP TABLE IF EXISTS `order`;
CREATE TABLE `order` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `type` tinyint(4) unsigned NOT NULL,
  `customerid` int(11) unsigned DEFAULT NULL,
  `storeid` int(11) unsigned DEFAULT NULL,
  `userid` int(11) unsigned DEFAULT NULL,
  `invoiceno` varchar(15) DEFAULT NULL,
  `addressid` int(11) unsigned DEFAULT NULL,
  `status` tinyint(4) unsigned NOT NULL,
  `totalamount` decimal(10,0) DEFAULT NULL,
  `comment` varchar(500) DEFAULT NULL,
  `datecreated` datetime NOT NULL,
  `createdby` int(11) unsigned NOT NULL,
  `lastupdatedate` date DEFAULT NULL,
  `lastupdatedby` int(11) unsigned DEFAULT NULL,
  `firstname` varchar(50) DEFAULT NULL,
  `lastname` varchar(50) DEFAULT NULL,
  `phone` varchar(15) NOT NULL,
  `email` varchar(50) NOT NULL,
  `country` varchar(2) DEFAULT NULL,
  `city` varchar(50) DEFAULT NULL,
  `state` varchar(50) DEFAULT NULL,
  `zipcode` varchar(15) DEFAULT NULL,
  `postalcode` varchar(15) DEFAULT NULL,
  `streetaddress` varchar(255) DEFAULT NULL,
  `streetaddress2` varchar(255) DEFAULT NULL,
  `useragent` varchar(50) DEFAULT NULL,
  `useros` varchar(50) DEFAULT NULL,
  `userip` varchar(50) DEFAULT NULL,
  `userbrowser` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of order
-- ----------------------------

-- ----------------------------
-- Table structure for `product`
-- ----------------------------
DROP TABLE IF EXISTS `product`;
CREATE TABLE `product` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `storeid` int(11) NOT NULL,
  `ref` varchar(50) DEFAULT NULL,
  `model` varchar(50) DEFAULT NULL,
  `serialno` varchar(25) DEFAULT NULL,
  `manufacturer` varchar(50) DEFAULT NULL,
  `description` varchar(1000) DEFAULT NULL,
  `quantity` decimal(10,2) unsigned DEFAULT NULL,
  `type` tinyint(4) unsigned DEFAULT NULL,
  `categoryid` int(4) unsigned DEFAULT NULL,
  `category_class` tinyint(4) unsigned DEFAULT '1',
  `status` tinyint(4) unsigned DEFAULT '1',
  `sortorder` tinyint(4) unsigned DEFAULT NULL,
  `minimum` decimal(10,2) unsigned DEFAULT NULL,
  `email_minimum` tinyint(4) unsigned DEFAULT NULL,
  `subtract` tinyint(4) unsigned DEFAULT NULL,
  `shipping` tinyint(4) unsigned DEFAULT NULL COMMENT '0',
  `showquantity` tinyint(4) unsigned DEFAULT NULL,
  `unitprice` decimal(10,2) unsigned DEFAULT NULL,
  `price` decimal(10,2) unsigned DEFAULT NULL,
  `currency` tinyint(4) unsigned DEFAULT NULL,
  `length` decimal(10,2) unsigned NOT NULL DEFAULT '0.00',
  `width` decimal(10,2) unsigned NOT NULL DEFAULT '0.00',
  `height` decimal(10,2) unsigned NOT NULL DEFAULT '0.00',
  `dimensionunit` tinyint(4) unsigned DEFAULT NULL,
  `weight` decimal(10,2) unsigned DEFAULT NULL,
  `weightunit` tinyint(4) unsigned DEFAULT NULL,
  `points` decimal(10,2) unsigned DEFAULT NULL,
  `dateavailable` date DEFAULT NULL,
  `datecreated` datetime NOT NULL,
  `createdby` int(11) unsigned NOT NULL,
  `lastupdatedate` datetime DEFAULT NULL,
  `lastupdatedby` int(11) unsigned DEFAULT NULL,
  `meta_description` varchar(255) DEFAULT NULL,
  `meta_keyword` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of product
-- ----------------------------

-- ----------------------------
-- Table structure for `product_category`
-- ----------------------------
DROP TABLE IF EXISTS `product_category`;
CREATE TABLE `product_category` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `productid` int(11) unsigned NOT NULL,
  `categoryid` int(11) unsigned NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of product_category
-- ----------------------------

-- ----------------------------
-- Table structure for `product_download`
-- ----------------------------
DROP TABLE IF EXISTS `product_download`;
CREATE TABLE `product_download` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `productid` int(11) unsigned NOT NULL,
  `filename` varchar(255) NOT NULL,
  `title` varchar(255) NOT NULL,
  `path` varchar(500) NOT NULL,
  `filesize` decimal(10,0) unsigned DEFAULT NULL,
  `code` varchar(50) DEFAULT NULL,
  `remaining` decimal(10,2) unsigned DEFAULT NULL,
  `sortorder` tinyint(4) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of product_download
-- ----------------------------

-- ----------------------------
-- Table structure for `product_tag`
-- ----------------------------
DROP TABLE IF EXISTS `product_tag`;
CREATE TABLE `product_tag` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `productid` int(11) unsigned DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of product_tag
-- ----------------------------

-- ----------------------------
-- Table structure for `session`
-- ----------------------------
DROP TABLE IF EXISTS `session`;
CREATE TABLE `session` (
  `id` char(32) NOT NULL DEFAULT '',
  `modified` int(11) DEFAULT NULL,
  `lifetime` int(11) DEFAULT NULL,
  `data` mediumtext,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of session
-- ----------------------------

-- ----------------------------
-- Table structure for `store`
-- ----------------------------
DROP TABLE IF EXISTS `store`;
CREATE TABLE `store` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `customerid` int(11) unsigned NOT NULL,
  `userid` int(11) unsigned DEFAULT NULL,
  `name` varchar(50) NOT NULL,
  `username` varchar(15) NOT NULL,
  `url` varchar(255) NOT NULL,
  `tagline` varchar(50) DEFAULT NULL,
  `description` varchar(500) DEFAULT NULL,
  `datecreated` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of store
-- ----------------------------

-- ----------------------------
-- Table structure for `user_customer`
-- ----------------------------
DROP TABLE IF EXISTS `user_customer`;
CREATE TABLE `user_customer` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `userid` int(11) unsigned NOT NULL,
  `customerid` int(11) unsigned NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of user_customer
-- ----------------------------

-- ----------------------------
-- Table structure for `useraccount`
-- ----------------------------
DROP TABLE IF EXISTS `useraccount`;
CREATE TABLE `useraccount` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `type` tinyint(4) NOT NULL,
  `firstname` varchar(50) NOT NULL,
  `lastname` varchar(50) NOT NULL,
  `othernames` varchar(50) DEFAULT NULL,
  `username` varchar(15) DEFAULT NULL,
  `email` varchar(50) DEFAULT NULL,
  `email2` varchar(50) DEFAULT NULL,
  `phone` varchar(15) DEFAULT NULL,
  `phone2` varchar(15) DEFAULT NULL,
  `password` varchar(50) DEFAULT '',
  `gender` tinyint(4) DEFAULT NULL,
  `dateofbirth` date DEFAULT NULL,
  `isactive` tinyint(4) unsigned DEFAULT '0',
  `activationkey` varchar(50) DEFAULT NULL,
  `activationdate` datetime DEFAULT NULL,
  `agreedtoterms` tinyint(1) unsigned DEFAULT '0',
  `addressid` int(11) unsigned DEFAULT NULL,
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
  `storeid` int(11) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_useraccount_createdby` (`createdby`),
  KEY `fk_useraccount_lastupdatedby` (`lastupdatedby`),
  KEY `index_useraccount_isactive` (`isactive`) USING BTREE,
  KEY `index_useraccount_username` (`username`),
  CONSTRAINT `fk_useraccount_createdby` FOREIGN KEY (`createdby`) REFERENCES `useraccount` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `fk_useraccount_lastupdatedby` FOREIGN KEY (`lastupdatedby`) REFERENCES `useraccount` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2802 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of useraccount
-- ----------------------------
INSERT INTO `useraccount` VALUES ('1', '1', 'Edward', 'Lawrence', 'Peterson', 'admin', 'admin@devmail.infomacorp.com', null, null, null, '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', '1', '1950-01-01', '1', '', '2013-05-01 01:33:10', '1', null, '', '', '', null, null, '2012-09-07 10:06:57', '1', null, null, null, null, null, null, null);
