/*
Navicat MySQL Data Transfer

Source Server         : localhost_3306
Source Server Version : 50611
Source Host           : localhost:3306
Source Database       : crawler_db

Target Server Type    : MYSQL
Target Server Version : 50611
File Encoding         : 65001

Date: 2017-05-03 15:31:12
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for static_proxy_info
-- ----------------------------
DROP TABLE IF EXISTS `static_proxy_info`;
CREATE TABLE `static_proxy_info` (
  `id` varchar(50) NOT NULL,
  `host` varchar(30) DEFAULT NULL,
  `port` varchar(5) DEFAULT NULL,
  `del_flag` tinyint(1) DEFAULT '0',
  `CREATE_TIME` datetime DEFAULT NULL,
  `PROXY_INFO_ID` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
