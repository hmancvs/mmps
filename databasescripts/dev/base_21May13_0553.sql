/*
Navicat MySQL Data Transfer

Source Server         : localhost_dev
Source Server Version : 50524
Source Host           : localhost:3306
Source Database       : mmps

Target Server Type    : MYSQL
Target Server Version : 50524
File Encoding         : 65001

Date: 2013-05-21 06:54:04
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
  PRIMARY KEY (`id`),
  KEY `fk_aclpermission_groupid` (`groupid`),
  KEY `fk_aclpermission_resourceid` (`resourceid`),
  CONSTRAINT `fk_aclpermission_groupid` FOREIGN KEY (`groupid`) REFERENCES `aclgroup` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_aclpermission_resourceid` FOREIGN KEY (`resourceid`) REFERENCES `aclresource` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
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
INSERT INTO `aclpermission` VALUES ('13', '2', '3', '1', '1', '1', '0', '0', '0', '0', '0', '2012-03-01 12:00:00', '1', null, null);
INSERT INTO `aclpermission` VALUES ('14', '2', '6', '0', '0', '1', '0', '0', '0', '0', '0', '2012-09-07 22:05:39', '1', null, null);
INSERT INTO `aclpermission` VALUES ('28', '5', '1', '0', '0', '1', '1', '0', '0', '0', '0', '2012-03-01 12:00:00', '1', null, null);
INSERT INTO `aclpermission` VALUES ('29', '5', '2', '1', '1', '1', '1', '1', '0', '0', '0', '2012-03-01 12:00:00', '1', null, null);
INSERT INTO `aclpermission` VALUES ('30', '5', '3', '1', '1', '1', '1', '1', '0', '0', '0', '2012-03-01 12:00:00', '1', null, null);
INSERT INTO `aclpermission` VALUES ('31', '3', '3', '1', '1', '1', '1', '0', '0', '0', '0', '2012-03-01 12:00:00', '1', null, null);
INSERT INTO `aclpermission` VALUES ('32', '4', '3', '1', '1', '1', '1', '0', '0', '0', '0', '2012-03-01 12:00:00', '1', null, null);
INSERT INTO `aclpermission` VALUES ('33', '3', '6', '0', '0', '1', '0', '0', '0', '0', '0', '2012-03-01 12:00:00', '1', null, null);
INSERT INTO `aclpermission` VALUES ('34', '4', '6', '0', '0', '1', '0', '0', '0', '0', '0', '2012-03-01 12:00:00', '1', null, null);
INSERT INTO `aclpermission` VALUES ('35', '5', '6', '0', '0', '1', '0', '0', '0', '0', '0', '2012-03-01 12:00:00', '1', null, null);
INSERT INTO `aclpermission` VALUES ('36', '5', '7', '1', '1', '1', '1', '0', '0', '0', '0', '2012-03-01 12:00:00', '1', null, null);
INSERT INTO `aclpermission` VALUES ('37', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '2012-03-01 12:00:00', '1', null, null);

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
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;

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
INSERT INTO `aclresource` VALUES ('12', 'Merchant', 'Store owners', '1', '1', '1', '1', '1', '1', '1', '1', '2012-03-01 12:00:00', '1', null, null);

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
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of aclusergroup
-- ----------------------------
INSERT INTO `aclusergroup` VALUES ('1', '1', '1');
INSERT INTO `aclusergroup` VALUES ('7', '2', '7');
INSERT INTO `aclusergroup` VALUES ('8', '2', '8');

-- ----------------------------
-- Table structure for `address`
-- ----------------------------
DROP TABLE IF EXISTS `address`;
CREATE TABLE `address` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `userid` int(11) unsigned DEFAULT NULL,
  `merchantid` int(11) unsigned DEFAULT NULL,
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
  KEY `index_address_type` (`type`),
  KEY `fk_address_userid` (`userid`),
  KEY `fk_address_merchantid` (`merchantid`),
  KEY `index_address_isprimary` (`isprimary`),
  CONSTRAINT `fk_address_merchantid` FOREIGN KEY (`merchantid`) REFERENCES `merchant` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_address_userid` FOREIGN KEY (`userid`) REFERENCES `useraccount` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of address
-- ----------------------------
INSERT INTO `address` VALUES ('1', '7', null, '1', null, null, null, 'UG', 'assaaa', null, null, null, 'sffsdds', null, '1', '2013-05-17', '7', '2013-05-20', '7');
INSERT INTO `address` VALUES ('2', '1', null, '1', null, null, null, 'UG', null, null, null, null, null, null, '1', '2013-05-20', '1', null, '1');
INSERT INTO `address` VALUES ('3', '8', null, '1', null, null, null, 'UG', null, null, null, null, null, null, '1', '2013-05-20', '1', null, null);

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
  CONSTRAINT `fk_category_parent` FOREIGN KEY (`parentid`) REFERENCES `category` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of category
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
  KEY `fk_lookuptypevalue_lookuptypeid` (`lookuptypeid`),
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
-- Table structure for `merchant`
-- ----------------------------
DROP TABLE IF EXISTS `merchant`;
CREATE TABLE `merchant` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `type` tinyint(4) unsigned NOT NULL,
  `firstname` varchar(50) DEFAULT NULL,
  `lastname` varchar(50) DEFAULT NULL,
  `orgname` varchar(50) DEFAULT NULL,
  `contactperson` varchar(255) DEFAULT NULL,
  `email` varchar(50) NOT NULL,
  `phone` varchar(15) NOT NULL,
  `phone2` varchar(15) DEFAULT NULL,
  `status` tinyint(4) unsigned DEFAULT NULL,
  `dateapproved` datetime DEFAULT NULL,
  `approvedbyid` int(4) unsigned DEFAULT NULL,
  `datecreated` datetime NOT NULL,
  `createdby` int(11) unsigned NOT NULL,
  `lastupdatedate` date DEFAULT NULL,
  `lastupdatedby` int(11) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_merchant_approvedbyid` (`approvedbyid`),
  KEY `index_merchant_type` (`type`),
  KEY `index_merchant_status` (`status`) USING BTREE,
  CONSTRAINT `fk_merchant_approvedbyid` FOREIGN KEY (`approvedbyid`) REFERENCES `useraccount` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of merchant
-- ----------------------------
INSERT INTO `merchant` VALUES ('1', '1', null, null, 'Kadic Hospital', 'George Micheal', 'test@domain.com', '256756145216', null, '1', null, null, '2013-05-17 18:48:30', '1', null, null);
INSERT INTO `merchant` VALUES ('2', '2', 'Leonell', 'Ndugwa', null, null, 'test2@domain.com', '256751450321', null, '1', null, null, '2013-05-20 18:48:30', '1', null, null);

-- ----------------------------
-- Table structure for `merchant_category`
-- ----------------------------
DROP TABLE IF EXISTS `merchant_category`;
CREATE TABLE `merchant_category` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `merchantid` int(11) unsigned NOT NULL,
  `categoryid` int(11) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_merchantcategory_merchantid` (`merchantid`),
  KEY `fk_merchantcategory_categoryidd` (`categoryid`),
  CONSTRAINT `fk_merchantcategory_categoryidd` FOREIGN KEY (`categoryid`) REFERENCES `category` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_merchantcategory_merchantid` FOREIGN KEY (`merchantid`) REFERENCES `merchant` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of merchant_category
-- ----------------------------

-- ----------------------------
-- Table structure for `order`
-- ----------------------------
DROP TABLE IF EXISTS `order`;
CREATE TABLE `order` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `merchantid` int(11) unsigned NOT NULL,
  `storeid` int(11) unsigned DEFAULT NULL,
  `userid` int(11) unsigned DEFAULT NULL,
  `invoiceno` varchar(15) DEFAULT NULL,
  `orderno` varchar(15) NOT NULL,
  `orderdate` date NOT NULL,
  `refno` varchar(15) NOT NULL,
  `type` tinyint(4) unsigned NOT NULL,
  `status` tinyint(4) unsigned NOT NULL,
  `totalamount` decimal(10,0) NOT NULL,
  `comment` varchar(500) DEFAULT NULL,
  `delivermethod` tinyint(4) unsigned DEFAULT NULL,
  `addressid` int(11) unsigned DEFAULT NULL,
  `datecreated` datetime NOT NULL,
  `createdby` int(11) unsigned NOT NULL,
  `lastupdatedate` date DEFAULT NULL,
  `lastupdatedby` int(11) unsigned DEFAULT NULL,
  `firstname` varchar(50) DEFAULT NULL,
  `lastname` varchar(50) DEFAULT NULL,
  `phone` varchar(15) DEFAULT NULL,
  `email` varchar(50) DEFAULT NULL,
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
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_order_orderno` (`orderno`),
  KEY `fk_order_userid` (`userid`),
  KEY `fk_order_storeid` (`storeid`),
  KEY `fk_order_merchantid` (`merchantid`),
  KEY `fk_order_addressid` (`addressid`),
  KEY `index_order_type` (`type`),
  KEY `index_order_status` (`status`),
  KEY `index_order_refno` (`refno`),
  CONSTRAINT `fk_order_addressid` FOREIGN KEY (`addressid`) REFERENCES `address` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `fk_order_merchantid` FOREIGN KEY (`merchantid`) REFERENCES `merchant` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_order_storeid` FOREIGN KEY (`storeid`) REFERENCES `store` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_order_userid` FOREIGN KEY (`userid`) REFERENCES `useraccount` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of order
-- ----------------------------

-- ----------------------------
-- Table structure for `order_download`
-- ----------------------------
DROP TABLE IF EXISTS `order_download`;
CREATE TABLE `order_download` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `orderid` int(11) unsigned NOT NULL,
  `downloadid` int(11) unsigned NOT NULL,
  `expirydate` date DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_orderdownload_orderid` (`orderid`),
  KEY `fk_orderdownload_downloadid` (`downloadid`),
  CONSTRAINT `fk_orderdownload_downloadid` FOREIGN KEY (`downloadid`) REFERENCES `product_download` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_orderdownload_orderid` FOREIGN KEY (`orderid`) REFERENCES `order` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of order_download
-- ----------------------------

-- ----------------------------
-- Table structure for `order_history`
-- ----------------------------
DROP TABLE IF EXISTS `order_history`;
CREATE TABLE `order_history` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `orderid` int(11) unsigned NOT NULL,
  `status` tinyint(11) unsigned NOT NULL,
  `notifypayer` tinyint(4) unsigned DEFAULT NULL,
  `notifymerchant` tinyint(4) unsigned DEFAULT NULL,
  `datecreated` datetime DEFAULT NULL,
  `comment` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_orderhistory_orderid` (`orderid`),
  KEY `index_orderhistory_status` (`status`),
  CONSTRAINT `fk_orderhistory_orderid` FOREIGN KEY (`orderid`) REFERENCES `order` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of order_history
-- ----------------------------

-- ----------------------------
-- Table structure for `order_notify`
-- ----------------------------
DROP TABLE IF EXISTS `order_notify`;
CREATE TABLE `order_notify` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `orderid` int(11) unsigned NOT NULL,
  `trxno` varchar(15) NOT NULL,
  `phone` varchar(15) NOT NULL,
  `isvalid` tinyint(4) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_ordernotify_orderid` (`orderid`),
  CONSTRAINT `fk_ordernotify_orderid` FOREIGN KEY (`orderid`) REFERENCES `order` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of order_notify
-- ----------------------------

-- ----------------------------
-- Table structure for `order_product`
-- ----------------------------
DROP TABLE IF EXISTS `order_product`;
CREATE TABLE `order_product` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `orderid` int(11) unsigned NOT NULL,
  `productid` int(11) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_orderproduct_orderid` (`orderid`),
  KEY `fk_orderproduct_productid` (`productid`),
  CONSTRAINT `fk_orderproduct_orderid` FOREIGN KEY (`orderid`) REFERENCES `order` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_orderproduct_productid` FOREIGN KEY (`productid`) REFERENCES `product` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of order_product
-- ----------------------------

-- ----------------------------
-- Table structure for `payment`
-- ----------------------------
DROP TABLE IF EXISTS `payment`;
CREATE TABLE `payment` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `orderid` int(11) unsigned DEFAULT NULL,
  `refno` varchar(25) DEFAULT NULL,
  `trxno` varchar(25) DEFAULT NULL,
  `status` tinyint(4) unsigned NOT NULL,
  `amount` decimal(10,0) DEFAULT NULL,
  `paymenttype` tinyint(4) unsigned NOT NULL DEFAULT '2',
  `paymentdate` date DEFAULT NULL,
  `verifiedbyid` int(11) unsigned DEFAULT NULL,
  `verifier` varchar(255) DEFAULT NULL,
  `datecreated` datetime NOT NULL,
  `createdby` int(11) unsigned NOT NULL,
  `lastupdatedate` date DEFAULT NULL,
  `lastupdatedby` int(11) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_payment_unique_refno` (`refno`) USING BTREE,
  KEY `fk_payment_orderid` (`orderid`),
  KEY `fk_payment_verifiedby` (`verifiedbyid`),
  KEY `unique_payment_status` (`status`),
  CONSTRAINT `fk_payment_orderid` FOREIGN KEY (`orderid`) REFERENCES `order` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_payment_verifiedby` FOREIGN KEY (`verifiedbyid`) REFERENCES `useraccount` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of payment
-- ----------------------------

-- ----------------------------
-- Table structure for `payment_fee`
-- ----------------------------
DROP TABLE IF EXISTS `payment_fee`;
CREATE TABLE `payment_fee` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `paymentid` int(11) unsigned NOT NULL,
  `fee` varchar(255) NOT NULL,
  `reason` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_paymentfee_paymentid` (`paymentid`),
  CONSTRAINT `fk_paymentfee_paymentid` FOREIGN KEY (`paymentid`) REFERENCES `payment` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of payment_fee
-- ----------------------------

-- ----------------------------
-- Table structure for `payment_notify`
-- ----------------------------
DROP TABLE IF EXISTS `payment_notify`;
CREATE TABLE `payment_notify` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `paymentid` int(11) unsigned NOT NULL,
  `phone` varchar(15) NOT NULL,
  `sms` varchar(160) NOT NULL,
  `datedelivered` datetime NOT NULL,
  `status` tinyint(3) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_paymentnotify_paymentid` (`paymentid`),
  CONSTRAINT `fk_paymentnotify_paymentid` FOREIGN KEY (`paymentid`) REFERENCES `payment` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of payment_notify
-- ----------------------------

-- ----------------------------
-- Table structure for `product`
-- ----------------------------
DROP TABLE IF EXISTS `product`;
CREATE TABLE `product` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `storeid` int(11) unsigned NOT NULL,
  `refno` varchar(50) DEFAULT NULL,
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
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_product_refno` (`refno`) USING BTREE,
  KEY `fk_product_storeid` (`storeid`),
  KEY `fk_product_categoryid` (`categoryid`),
  CONSTRAINT `fk_product_categoryid` FOREIGN KEY (`categoryid`) REFERENCES `category` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_product_storeid` FOREIGN KEY (`storeid`) REFERENCES `store` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
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
  PRIMARY KEY (`id`),
  KEY `fk_productcategory_productid` (`productid`),
  KEY `fk_productcategory_categoryid` (`categoryid`),
  CONSTRAINT `fk_productcategory_categoryid` FOREIGN KEY (`categoryid`) REFERENCES `category` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_productcategory_productid` FOREIGN KEY (`productid`) REFERENCES `product` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
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
  `ext` varchar(6) DEFAULT NULL,
  `code` varchar(50) DEFAULT NULL,
  `alias` varchar(50) DEFAULT NULL,
  `artist` varchar(50) DEFAULT NULL,
  `album` varchar(50) DEFAULT NULL,
  `sortorder` tinyint(4) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_productdownload_productid` (`productid`),
  CONSTRAINT `fk_productdownload_productid` FOREIGN KEY (`productid`) REFERENCES `product` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
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
  PRIMARY KEY (`id`),
  KEY `fk_producttag_productid` (`productid`),
  KEY `index_product_tag` (`name`),
  CONSTRAINT `fk_producttag_productid` FOREIGN KEY (`productid`) REFERENCES `product` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of product_tag
-- ----------------------------

-- ----------------------------
-- Table structure for `product_watchlist`
-- ----------------------------
DROP TABLE IF EXISTS `product_watchlist`;
CREATE TABLE `product_watchlist` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `userid` int(11) unsigned NOT NULL,
  `productid` int(11) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_productwishlist_productid` (`productid`),
  KEY `fk_productwishlist_userid` (`userid`),
  CONSTRAINT `fk_productwishlist_productid` FOREIGN KEY (`productid`) REFERENCES `product` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_productwishlist_userid` FOREIGN KEY (`userid`) REFERENCES `useraccount` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of product_watchlist
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
INSERT INTO `session` VALUES ('emhkld71ju9h7266gm1tbl5dj1', '1369049901', '21104000', 'Default|a:6:{s:11:\"initialized\";b:1;s:6:\"errors\";s:0:\"\";s:14:\"successmessage\";s:0:\"\";s:10:\"formvalues\";a:0:{}s:18:\"newsletter_success\";s:0:\"\";s:16:\"newsletter_error\";s:0:\"\";}');
INSERT INTO `session` VALUES ('huga2qi9pm0vo4rn9i09ekouj7', '1369108329', '21104000', 'Default|a:15:{s:11:\"initialized\";b:1;s:6:\"errors\";s:0:\"\";s:14:\"successmessage\";s:0:\"\";s:10:\"formvalues\";a:0:{}s:18:\"newsletter_success\";s:0:\"\";s:16:\"newsletter_error\";s:0:\"\";s:6:\"userid\";s:1:\"1\";s:9:\"firstname\";s:6:\"Edward\";s:8:\"lastname\";s:8:\"Lawrence\";s:5:\"email\";s:28:\"admin@devmail.infomacorp.com\";s:6:\"gender\";s:1:\"1\";s:5:\"phone\";s:0:\"\";s:11:\"profilepath\";s:73:\"<a href=\"javascript: void(0)\">http://127.0.0.1/mmps/public/user/admin</a>\";s:4:\"type\";s:1:\"1\";s:12:\"settingslink\";s:128:\"<li><a href=\"/mmps/public/appconfig/overview\" title=\"Application Settings\">Settings</a><span class=\"toplinkspacer\">|</span></li>\";}');
INSERT INTO `session` VALUES ('s2g57mg2ktiber73gc5ovfgim2', '1368781503', '21104000', 'Default|a:14:{s:11:\"initialized\";b:1;s:6:\"errors\";s:0:\"\";s:14:\"successmessage\";s:0:\"\";s:10:\"formvalues\";a:0:{}s:18:\"newsletter_success\";s:0:\"\";s:16:\"newsletter_error\";s:0:\"\";s:6:\"userid\";s:1:\"7\";s:9:\"firstname\";s:4:\"Same\";s:8:\"lastname\";s:6:\"Kajoko\";s:5:\"email\";s:27:\"test@devmail.infomacorp.com\";s:6:\"gender\";s:1:\"1\";s:5:\"phone\";s:12:\"256712595279\";s:11:\"profilepath\";s:68:\"<a href=\"javascript: void(0)\">http://127.0.0.1/mmps/public/user/</a>\";s:4:\"type\";s:1:\"2\";}');

-- ----------------------------
-- Table structure for `store`
-- ----------------------------
DROP TABLE IF EXISTS `store`;
CREATE TABLE `store` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `merchantid` int(11) unsigned NOT NULL,
  `name` varchar(50) NOT NULL,
  `username` varchar(15) NOT NULL,
  `url` varchar(255) NOT NULL,
  `tagline` varchar(50) DEFAULT NULL,
  `description` varchar(500) DEFAULT NULL,
  `datecreated` datetime DEFAULT NULL,
  `createdby` int(11) unsigned DEFAULT NULL,
  `lastupdatedate` datetime DEFAULT NULL,
  `lastupdatedby` int(11) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_store_merchantid` (`merchantid`),
  KEY `index_store_username` (`username`),
  CONSTRAINT `fk_store_merchantid` FOREIGN KEY (`merchantid`) REFERENCES `merchant` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of store
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
  KEY `index_useraccount_isactive` (`isactive`) USING BTREE,
  KEY `index_useraccount_username` (`username`),
  KEY `index_useraccount_phone` (`phone`),
  KEY `index_useraccount_email` (`email`),
  KEY `index_useraccount_phone_isactivated` (`phone_isactivated`),
  KEY `index_useraccount_phone2_isactivated` (`phone2_isactivated`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of useraccount
-- ----------------------------
INSERT INTO `useraccount` VALUES ('1', '1', 'Edward', 'Lawrence', 'Peterson', 'admin', 'admin@devmail.infomacorp.com', null, '', '', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', '1', '1950-01-01', '1', '', '2013-05-01 01:33:10', '1', '', '', '', null, null, '2012-09-07 10:06:57', '1', '2013-05-20 00:56:10', '1', null, null, null, null);
INSERT INTO `useraccount` VALUES ('7', '2', 'Kagwa', 'Steve', null, null, 'test@devmail.infomacorp.com', 'test2@devmail.infomacorp.com', '256785123654', '256754126523', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', '1', null, '1', '', '2013-05-16 11:16:20', '1', null, '', null, null, null, '2013-05-15 19:25:06', '7', '2013-05-20 18:27:53', '7', '', '', '1', '0');
INSERT INTO `useraccount` VALUES ('8', '2', 'Ken', 'Kimson', null, null, 'test2@devmail.infomacorp.com', null, '256795621452', null, '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', '1', null, '1', '', '2013-05-20 01:03:36', '1', null, '', null, null, null, '2013-05-20 00:58:04', '8', '2013-05-20 01:03:36', null, null, null, '0', '0');
