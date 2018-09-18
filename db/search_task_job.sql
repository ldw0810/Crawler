/*
Navicat MySQL Data Transfer

Source Server         : localhost_3306
Source Server Version : 50611
Source Host           : localhost:3306
Source Database       : crawler_db

Target Server Type    : MYSQL
Target Server Version : 50611
File Encoding         : 65001

Date: 2017-05-09 17:49:56
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for search_task_job
-- ----------------------------
DROP TABLE IF EXISTS `search_task_job`;
CREATE TABLE `search_task_job` (
  `ID` varchar(50) NOT NULL,
  `NAME` varchar(255) DEFAULT NULL COMMENT '任务名称',
  `KEY` varchar(255) DEFAULT NULL COMMENT '关键词',
  `DEL_FLAG` tinyint(1) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `STATUS` varchar(255) DEFAULT NULL COMMENT '是否存证',
  `EXECUTE_STATUS` varchar(255) DEFAULT NULL,
  `TYPE` varchar(5) DEFAULT NULL COMMENT '类型',
  `CREATE_USER_ID` varchar(50) DEFAULT NULL,
  `child_ids` varchar(1024) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of search_task_job
-- ----------------------------
INSERT INTO `search_task_job` VALUES ('1', '1', '1', '0', '2017-05-09 17:47:15', '1', '1', '1', null, null);
