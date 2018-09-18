/*
Navicat MySQL Data Transfer

Source Server         : localhost_3306
Source Server Version : 50611
Source Host           : localhost:3306
Source Database       : crawler_db

Target Server Type    : MYSQL
Target Server Version : 50611
File Encoding         : 65001

Date: 2017-05-20 21:17:47
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for task_job_param
-- ----------------------------
DROP TABLE IF EXISTS `task_job_param`;
CREATE TABLE `task_job_param` (
  `ID` varchar(50) NOT NULL,
  `DEL_FLAG` tinyint(1) DEFAULT NULL,
  `PARAM_NAME_EN` varchar(255) DEFAULT NULL,
  `PARAM_NAME_CN` varchar(255) DEFAULT NULL,
  `PARAM_VALUE` varchar(255) DEFAULT NULL,
  `PARAM_CONDITION` varchar(255) DEFAULT NULL,
  `NEXT_PARAM_VALUE` varchar(255) DEFAULT NULL,
  `CREATE_TIME` datetime DEFAULT NULL,
  `CREATE_USER_ID` varchar(50) DEFAULT NULL,
  `TYPE` varchar(5) DEFAULT NULL,
  `TASK_JOB_ID` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of task_job_param
-- ----------------------------
