/*
Navicat MySQL Data Transfer

Source Server         : 172.21.14.36
Source Server Version : 50636
Source Host           : 172.21.14.36:3306
Source Database       : wyy

Target Server Type    : MYSQL
Target Server Version : 50636
File Encoding         : 65001

Date: 2017-07-19 09:20:03
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `url_list_status`
-- ----------------------------
DROP TABLE IF EXISTS `url_list_status`;
CREATE TABLE `url_list_status` (
  `id` varchar(50) NOT NULL DEFAULT '0',
  `url` varchar(1024) DEFAULT NULL,
  `parentUrl` varchar(1024) DEFAULT NULL,
  `status` tinyint(1) DEFAULT '0' COMMENT '状态',
  `desc` varchar(2048) DEFAULT NULL COMMENT '注释',
  `jobTemplateId` varchar(50) DEFAULT '-1',
  `jobTemplateParentId` varchar(50) DEFAULT '-1',
  `taskJobId` varchar(50) DEFAULT NULL COMMENT '任务id',
  `taskJobHistoryId` varchar(50) DEFAULT NULL COMMENT '任务历史id',
  `createTime` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `delFlag` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of url_list_status
-- ----------------------------
