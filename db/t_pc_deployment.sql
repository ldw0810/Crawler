/*
Navicat MySQL Data Transfer

Source Server         : hqw
Source Server Version : 50717
Source Host           : localhost:3306
Source Database       : hqwtest

Target Server Type    : MYSQL
Target Server Version : 50717
File Encoding         : 65001

Date: 2017-04-20 16:20:28
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `t_pc_deployment`
-- ----------------------------
DROP TABLE IF EXISTS `t_pc_deployment`;
CREATE TABLE `t_pc_deployment` (
  `ID` varchar(50) NOT NULL,
  `IP` varchar(50) DEFAULT NULL,
  `DEPLOYMENT` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_pc_deployment
-- ----------------------------
INSERT INTO `t_pc_deployment` VALUES ('1', '1', '1|2');
INSERT INTO `t_pc_deployment` VALUES ('2', '2', '3');
