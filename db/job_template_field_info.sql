/*
Navicat MySQL Data Transfer

Source Server         : localhost_3306
Source Server Version : 50611
Source Host           : localhost:3306
Source Database       : crawler_db

Target Server Type    : MYSQL
Target Server Version : 50611
File Encoding         : 65001

Date: 2017-05-05 14:12:29
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for job_template_field
-- ----------------------------
DROP TABLE IF EXISTS `job_template_field`;
CREATE TABLE `job_template_field` (
  `ID` varchar(50) NOT NULL,
  `DEL_FLAG` tinyint(1) DEFAULT '0',
  `FIELD_NAME_EN` varchar(255) DEFAULT NULL,
  `FIELD_NAME_CN` varchar(255) DEFAULT NULL,
  `DATA_TYPE` varchar(255) DEFAULT NULL,
  `DATA_LENGTH` int(10) DEFAULT NULL,
  `CREATE_USER_ID` varchar(2048) DEFAULT NULL,
  `JOB_TEMPLATE_ID` varchar(2048) DEFAULT NULL,
  `REG_EXP` varchar(255) DEFAULT NULL,
  `SPLIT` varchar(10) DEFAULT NULL,
  `FIELD_VALUE` varchar(255) DEFAULT NULL,
  `FUNC` varchar(255) DEFAULT NULL COMMENT '操作函数',
  `FIELD_CONDITION` varchar(1024) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
