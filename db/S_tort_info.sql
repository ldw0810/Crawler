/*
Navicat MySQL Data Transfer

Source Server         : localhost_33062
Source Server Version : 50718
Source Host           : localhost:3306
Source Database       : crawlerdb

Target Server Type    : MYSQL
Target Server Version : 50718
File Encoding         : 65001

Date: 2017-05-10 09:27:21
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `s_tort_info`
-- ----------------------------
DROP TABLE IF EXISTS `s_tort_info`;
CREATE TABLE `s_tort_info` (
  `ID` varchar(50) NOT NULL DEFAULT '0',
  `DEL_FLAG` tinyint(1) NOT NULL,
  `CREATE_TIME` datetime NOT NULL,
  `CONTENT_TYPE` tinyint(5) DEFAULT NULL,
  `TOTAL_CNT` int(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of s_tort_info
-- ----------------------------
