/*
Navicat MySQL Data Transfer

Source Server         : localhost_3306
Source Server Version : 50611
Source Host           : localhost:3306
Source Database       : crawler_db

Target Server Type    : MYSQL
Target Server Version : 50611
File Encoding         : 65001

Date: 2017-05-11 10:45:46
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for p_area
-- ----------------------------
DROP TABLE IF EXISTS `p_area`;
CREATE TABLE `p_area` (
  `ID` varchar(50) NOT NULL,
  `DEL_FLAG` tinyint(1) DEFAULT NULL,
  `CREATE_TIME` datetime DEFAULT NULL,
  `PROVINCE` varchar(8) DEFAULT NULL,
  `CITY` varchar(8) DEFAULT NULL,
  `COUNTRY` varchar(8) DEFAULT NULL,
  `LAT` double DEFAULT NULL,
  `LNG` double DEFAULT NULL,
  `CODE` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for p_base_info
-- ----------------------------
DROP TABLE IF EXISTS `p_base_info`;
CREATE TABLE `p_base_info` (
  `ID` varchar(50) NOT NULL,
  `DEL_FLAG` tinyint(1) DEFAULT '0',
  `CREATE_TIME` datetime DEFAULT NULL,
  `TYPE` varchar(100) DEFAULT NULL,
  `URL` varchar(512) DEFAULT NULL,
  `MATCH_DEGREE` varchar(10) DEFAULT NULL,
  `FIELD_ID` varchar(50) DEFAULT NULL,
  `FIELD_VALUE` varchar(512) DEFAULT NULL,
  `TASK_JOB_ID` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for p_content_info
-- ----------------------------
DROP TABLE IF EXISTS `p_content_info`;
CREATE TABLE `p_content_info` (
  `ID` varchar(50) NOT NULL,
  `DEL_FLAG` tinyint(1) DEFAULT '0',
  `CREATE_TIME` datetime DEFAULT CURRENT_TIMESTAMP,
  `TYPE` varchar(100) DEFAULT NULL,
  `URL` varchar(512) DEFAULT NULL,
  `MATCH_DEGREE` varchar(10) DEFAULT NULL,
  `FIELD_ID` varchar(512) DEFAULT NULL,
  `FIELD_VALUE` varchar(255) DEFAULT NULL,
  `FIELD_FLAG` varchar(5) DEFAULT NULL,
  `TASK_JOB_ID` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for p_field_weight
-- ----------------------------
DROP TABLE IF EXISTS `p_field_weight`;
CREATE TABLE `p_field_weight` (
  `ID` varchar(50) NOT NULL DEFAULT '0',
  `DEL_FLAG` tinyint(1) DEFAULT NULL,
  `CREATE_TIME` datetime DEFAULT NULL,
  `FIELD_NAME_EN` varchar(512) DEFAULT NULL,
  `FIELD_NAME_CN` varchar(512) DEFAULT NULL,
  `TYPE` varchar(8) DEFAULT NULL,
  `WEIGHT` double DEFAULT NULL,
  `TASK_JOB_ID` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for p_ip_storage
-- ----------------------------
DROP TABLE IF EXISTS `p_ip_storage`;
CREATE TABLE `p_ip_storage` (
  `ID` varchar(50) NOT NULL,
  `DEL_FLAG` tinyint(4) DEFAULT NULL,
  `CREATE_TIME` datetime DEFAULT NULL,
  `HOST_NAME` varchar(100) DEFAULT NULL,
  `IP` varchar(100) DEFAULT NULL,
  `PORT` varchar(6) DEFAULT NULL,
  `AREA_ID` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for p_save_evidence
-- ----------------------------
DROP TABLE IF EXISTS `p_save_evidence`;
CREATE TABLE `p_save_evidence` (
  `ID` varchar(50) NOT NULL,
  `DEL_FLAG` tinyint(1) DEFAULT '0',
  `CREATE_TIME` datetime DEFAULT NULL,
  `STATUS` varchar(100) DEFAULT NULL,
  `URL` varchar(512) DEFAULT NULL,
  `KEY` varchar(512) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for p_search_task_job
-- ----------------------------
DROP TABLE IF EXISTS `p_search_task_job`;
CREATE TABLE `p_search_task_job` (
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
-- Table structure for p_task_flow
-- ----------------------------
DROP TABLE IF EXISTS `p_task_flow`;
CREATE TABLE `p_task_flow` (
  `ID` varchar(50) NOT NULL,
  `DEL_FLAG` tinyint(1) DEFAULT '0',
  `TASK_JOB_ID` varchar(50) DEFAULT NULL,
  `STATUS` varchar(5) DEFAULT NULL,
  `CREATE_TIME` datetime DEFAULT NULL,
  `FLOW_NAME` varchar(50) DEFAULT NULL,
  `PARENT_ID` varchar(50) DEFAULT '-1',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for p_white_and_black_list
-- ----------------------------
DROP TABLE IF EXISTS `p_white_and_black_list`;
CREATE TABLE `p_white_and_black_list` (
  `ID` varchar(50) NOT NULL,
  `DEL_FLAG` tinyint(1) DEFAULT '0',
  `IP` varchar(50) DEFAULT NULL,
  `PORT` varchar(255) DEFAULT NULL,
  `CREATE_TIME` datetime DEFAULT NULL,
  `TYPE` varchar(50) DEFAULT NULL,
  `HOST_NAME` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
