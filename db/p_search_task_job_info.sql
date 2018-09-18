/*
Navicat MySQL Data Transfer

Source Server         : localhost_3306555
Source Server Version : 50718
Source Host           : localhost:3306
Source Database       : crawlerdb

Target Server Type    : MYSQL
Target Server Version : 50718
File Encoding         : 65001

Date: 2017-05-17 23:17:33
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `p_search_task_job`
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
-- Records of p_search_task_job
-- ----------------------------
INSERT INTO `p_search_task_job` VALUES ('1', 'key', '刺客信条', '0', null, null, null, '0', null, '072241de-34b6-11e7-b41d-0025ab9a7c2c,2847be6c-3498-11e7-9285-0025ab9a7c2c,39feb7d2-3530-11e7-947a-b8aeed2fe120,41a1ad3e-354d-11e7-947a-b8aeed2fe120,45e1dade-3554-11e7-947a-b8aeed2fe120,65ade85c-3528-11e7-947a-b8aeed2fe120,740532f2-355d-11e7-947a-b8aeed2fe120,90a8e36f-3555-11e7-97d9-0025ab9a7c2c,93b6d456-355e-11e7-97d9-0025ab9a7c2c,b3bb56ae-3532-11e7-97d9-0025ab9a7c2c,c12161be-3494-11e7-aa20-b8aeed2fe120,c283b2c4-3521-11e7-947a-b8aeed2fe120,f4f1a890-354e-11e7-97d9-0025ab9a7c2c,ffe68206-352d-11e7-97d9-0025ab9a7c2c');
INSERT INTO `p_search_task_job` VALUES ('10', 'aa', '裸照门', '0', null, null, null, '4', null, null);
INSERT INTO `p_search_task_job` VALUES ('2', 'hh', 'jbjb', '0', null, null, null, '0', null, null);
INSERT INTO `p_search_task_job` VALUES ('3', 'aa', '人民的名义', '0', null, null, null, '1', null, null);
INSERT INTO `p_search_task_job` VALUES ('4', 'aa', '欢乐颂\r\n欢乐颂\r\n欢乐颂', '0', null, null, null, '1', null, null);
INSERT INTO `p_search_task_job` VALUES ('5', 'aa', '暧昧', '0', null, null, null, '2', null, null);
INSERT INTO `p_search_task_job` VALUES ('6', 'aa', '演员', '0', null, null, null, '2', null, null);
INSERT INTO `p_search_task_job` VALUES ('7', 'aa', '逆鳞', '0', null, null, null, '3', null, null);
INSERT INTO `p_search_task_job` VALUES ('8', 'aa', '择天记\r\n', '0', null, null, null, '3', null, null);
INSERT INTO `p_search_task_job` VALUES ('9', 'aa', '艳照门', '0', null, null, null, '4', null, null);
