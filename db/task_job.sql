/*
Navicat MySQL Data Transfer

Source Server         : localhost_3306
Source Server Version : 50611
Source Host           : localhost:3306
Source Database       : crawler_db

Target Server Type    : MYSQL
Target Server Version : 50611
File Encoding         : 65001

Date: 2017-04-26 17:41:26
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for task_job
-- ----------------------------
DROP TABLE IF EXISTS `task_job`;
CREATE TABLE `task_job` (
  `ID` varchar(50) NOT NULL,
  `DEL_FLAG` tinyint(1) DEFAULT NULL,
  `CREATE_TIME` datetime DEFAULT NULL,
  `NAME` varchar(20) DEFAULT NULL,
  `URL` varchar(255) DEFAULT NULL,
  `TYPE` varchar(50) DEFAULT NULL COMMENT '关联网站类型表',
  `STATUS` tinyint(5) DEFAULT NULL COMMENT '执行状态',
  `JOB_TEMPLATE_ID` varchar(50) DEFAULT NULL COMMENT '模板id',
  `TABLE_NAME` varchar(255) DEFAULT NULL COMMENT '表名',
  `PARENT_ID` varchar(50) DEFAULT '-1' COMMENT '父任务Id',
  `CREATE_USER_ID` varchar(50) DEFAULT NULL,
  `GRAP_PERIOD` int(11) DEFAULT NULL,
  `GRAP_INTERVAL` int(11) DEFAULT NULL,
  `PAGE_LIMIT` int(11) DEFAULT NULL COMMENT '页数上限',
  `PROXY_TYPE` varchar(5) DEFAULT NULL,
  `ENCODE_TYPE_ID` varchar(50) DEFAULT NULL COMMENT '编码',
  `DATABASE_ID` varchar(50) DEFAULT NULL COMMENT '数据库配置Id',
  `LAST_EXECUTE_TIME` datetime DEFAULT NULL COMMENT '最后执行时间',
  `TASK_JOB_TIMER_ID` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of task_job
-- ----------------------------