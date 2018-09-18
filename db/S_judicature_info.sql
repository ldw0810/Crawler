/*
Navicat MySQL Data Transfer

Source Server         : localhost_33062
Source Server Version : 50718
Source Host           : localhost:3306
Source Database       : crawlerdb

Target Server Type    : MYSQL
Target Server Version : 50718
File Encoding         : 65001

Date: 2017-05-10 09:30:45
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `s_judicature_info`
-- ----------------------------
DROP TABLE IF EXISTS `s_judicature_info`;
CREATE TABLE `s_judicature_info` (
  `ID` varchar(50) NOT NULL,
  `DEL_FLAG` tinyint(1) NOT NULL DEFAULT '0',
  `CREATE_TIME` datetime NOT NULL,
  `SAVING_CNT` int(11) DEFAULT NULL,
  `SAVED_CNT` int(11) DEFAULT NULL,
  `CHANGED_CNT` int(11) DEFAULT NULL,
  `COMPROMISE_CNT` int(11) DEFAULT NULL,
  `PURSUE_CNT` int(11) DEFAULT NULL,
  `ADJUDGED_CNT` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of s_judicature_info
-- ----------------------------
