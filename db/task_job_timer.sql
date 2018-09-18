/*
Navicat MySQL Data Transfer

Source Server         : localhost_3306
Source Server Version : 50611
Source Host           : localhost:3306
Source Database       : crawler_db

Target Server Type    : MYSQL
Target Server Version : 50611
File Encoding         : 65001

Date: 2017-05-05 14:18:47
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for task_job_timer
-- ----------------------------
DROP TABLE IF EXISTS `task_job_timer`;
CREATE TABLE `task_job_timer` (
  `ID` varchar(50) NOT NULL,
  `START_TIME` datetime DEFAULT NULL,
  `DEL_FLAG` tinyint(1) DEFAULT '0',
  `REPEAT_TIME` int(11) DEFAULT '1' COMMENT '-1表示不停执行',
  `HOUR` int(11) DEFAULT NULL,
  `MINUTE` int(11) DEFAULT NULL,
  `WEEK_DAY` varchar(255) DEFAULT NULL,
  `MONTH_DAY` varchar(255) DEFAULT NULL,
  `YEAR_MONTH` varchar(255) DEFAULT NULL,
  `END_TIME` datetime DEFAULT NULL,
  `CREATE_TIME` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
