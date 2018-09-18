/*
Navicat MySQL Data Transfer

Source Server         : crawler
Source Server Version : 50717
Source Host           : localhost:3306
Source Database       : new_crawler_db

Target Server Type    : MYSQL
Target Server Version : 50717
File Encoding         : 65001

Date: 2017-05-18 11:16:07
*/

SET FOREIGN_KEY_CHECKS=0;

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
-- Records of p_search_task_job
-- ----------------------------

INSERT INTO `p_search_task_job` VALUES ('12', 'xx', '黄鳝门事件', '0', null, null, null, '3', null, null);
INSERT INTO `p_search_task_job` VALUES ('13', 'xx', '江苏小贩捅死城管商户', '0', null, null, null, '3', null, null);
INSERT INTO `p_search_task_job` VALUES ('14', 'xx', '新疆皮山暴恐案', '0', null, null, null, '3', null, null);
INSERT INTO `p_search_task_job` VALUES ('3', 'aa', '人民的名义', '0', null, '5', '1', '0', null, null);
INSERT INTO `p_search_task_job` VALUES ('4', 'aa', '欢乐颂', '0', null, '5', null, '0', null, null);


