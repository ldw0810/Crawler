/*
Navicat MySQL Data Transfer

Source Server         : hqw
Source Server Version : 50717
Source Host           : localhost:3306
Source Database       : hqwtest

Target Server Type    : MYSQL
Target Server Version : 50717
File Encoding         : 65001

Date: 2017-04-19 16:06:13
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `t_dynamic_pc_info`
-- ----------------------------
DROP TABLE IF EXISTS `t_dynamic_pc_info`;
CREATE TABLE `t_dynamic_pc_info` (
  `ID` varchar(50) NOT NULL,
  `ASSETID` varchar(50) DEFAULT NULL,
  `IP` varchar(50) DEFAULT NULL,
  `MEMORY` varchar(50) DEFAULT NULL,
  `CPU` varchar(50) DEFAULT NULL,
  `IO` varchar(50) DEFAULT NULL,
  `ONLINE_TIME` varchar(50) DEFAULT NULL,
  `LOADAVG` varchar(50) DEFAULT NULL,
  `CREATE_DATE` datetime DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `ASSETID` (`ASSETID`),
  CONSTRAINT `t_dynamic_pc_info_ibfk_1` FOREIGN KEY (`ASSETID`) REFERENCES `t_static_pc_info` (`ASSETID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_dynamic_pc_info
-- ----------------------------
INSERT INTO `t_dynamic_pc_info` VALUES ('1', '1', '1', '1', '1', '1', '1', '1', '2017-04-19 10:32:42');
INSERT INTO `t_dynamic_pc_info` VALUES ('2', '2', '2', '2', '2', '2', '2', '2', '2017-04-20 10:32:55');
INSERT INTO `t_dynamic_pc_info` VALUES ('3', '3', '3', '3', '3', '3', '3', '3', '2017-04-19 10:33:09');
INSERT INTO `t_dynamic_pc_info` VALUES ('4', '2', '4', '2', '2', '4', '4', '4', '2017-04-21 10:35:32');

-- ----------------------------
-- Table structure for `t_static_pc_info`
-- ----------------------------
DROP TABLE IF EXISTS `t_static_pc_info`;
CREATE TABLE `t_static_pc_info` (
  `ASSETID` varchar(50) NOT NULL,
  `IP` varchar(50) DEFAULT NULL,
  `MEMORY` varchar(50) DEFAULT NULL,
  `HOSTNAME` varchar(320) DEFAULT NULL,
  `CPUPHYSICALNUM` varchar(1024) DEFAULT NULL,
  `DISKTOTAL` varchar(1024) DEFAULT NULL,
  `CPU_TOTAL` varchar(50) DEFAULT NULL,
  `CPU_CORE_NUM` varchar(50) DEFAULT NULL,
  `DEPLOYMENT` varchar(10) DEFAULT NULL,
  `STATUS` varchar(10) DEFAULT NULL,
  `CREATE_DATE` datetime DEFAULT NULL,
  `UPDATE_DATE` datetime DEFAULT NULL,
  `LOG_URL` varchar(1024) DEFAULT NULL,
  PRIMARY KEY (`ASSETID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_static_pc_info
-- ----------------------------
INSERT INTO `t_static_pc_info` VALUES ('1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '2017-04-19 10:31:32', '2017-04-19 10:31:35', '1');
INSERT INTO `t_static_pc_info` VALUES ('2', '2', '2', '2', '2', '2', '2', '2', '2', '2', '2017-04-19 10:31:59', '2017-04-19 10:32:03', '2');
INSERT INTO `t_static_pc_info` VALUES ('3', '3', '3', '3', '3', '3', '3', '3', '3', '3', '2017-04-19 10:32:17', '2017-04-19 10:32:21', '3');
