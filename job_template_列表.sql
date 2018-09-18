/*
Navicat MySQL Data Transfer

Source Server         : localhost_3306
Source Server Version : 50611
Source Host           : localhost:3306
Source Database       : new_crawler_db

Target Server Type    : MYSQL
Target Server Version : 50611
File Encoding         : 65001

Date: 2017-05-22 19:35:54
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for job_template
-- ----------------------------
DROP TABLE IF EXISTS `job_template`;
CREATE TABLE `job_template` (
  `ID` varchar(50) NOT NULL DEFAULT '0',
  `DEL_FLAG` tinyint(1) DEFAULT NULL,
  `FLAG` tinyint(1) DEFAULT NULL,
  `NAME` varchar(255) DEFAULT NULL,
  `DESC` varchar(1000) DEFAULT NULL,
  `CREATE_TIME` datetime DEFAULT NULL,
  `CREATE_USER_ID` varchar(10) DEFAULT NULL,
  `ROOT_PATH` varchar(255) DEFAULT NULL,
  `BASE_TABLE_NAME` varchar(255) DEFAULT NULL,
  `URL` varchar(255) DEFAULT NULL,
  `parent_id` varchar(255) DEFAULT '-1' COMMENT '父级id',
  `job_template_type` varchar(50) DEFAULT '-1' COMMENT 'job_template_type',
  `database_id` varchar(50) DEFAULT '-1' COMMENT 'database_id',
  `encode_type` varchar(10) DEFAULT NULL COMMENT '是否encode',
  `object_type` varchar(8) DEFAULT NULL COMMENT '白名单还是黑屏单1，是白 2是黑',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of job_template
-- ----------------------------
INSERT INTO `job_template` VALUES ('9a6d2c30-3edd-11e7-8d62-e09467f6dff0', '0', '0', '重庆市政府列表', null, '2017-05-20 00:00:00', 'test1', '//div[@class=\'index_head1 content_heads3\']/div|//div[@class=\'index_head1 content_heads4\']/div|//div[@class=\'index_head1 content_heads5\']/div', null, 'http://www.cqyz.gov.cn/index.html', null, null, null, null, null);
INSERT INTO `job_template` VALUES ('a6d65b8f-3edd-11e7-a5f4-e09467f6dff0', '0', '0', '重庆市政府列表', null, '2017-05-20 00:00:00', 'test1', '//div[@class=\'index_head1 content_heads3\']/div|//div[@class=\'index_head1 content_heads4\']/div|//div[@class=\'index_head1 content_heads5\']/div', null, 'http://www.cqyz.gov.cn/index.html', null, null, null, null, null);
INSERT INTO `job_template` VALUES ('b35cafe1-3edd-11e7-8f7d-e09467f6dff0', '0', '0', '重庆市政府列表', null, '2017-05-20 00:00:00', 'test1', '//div[@class=\'index_head1 content_heads3\']/div|//div[@class=\'index_head1 content_heads4\']/div|//div[@class=\'index_head1 content_heads5\']/div', null, 'http://www.cqyz.gov.cn/index.html', null, null, null, null, null);
INSERT INTO `job_template` VALUES ('e885a180-3d71-11e7-8f5b-e09467f6dff0', '0', '0', '重庆市政府子集列表', null, '2017-05-20 00:00:00', 'test1', '//ul[@class=\'pXxgk_list\']/li', null, 'http://www.cqyz.gov.cn/{href_url}', 'ae631f9e-3d71-11e7-a148-e09467f6dff0', null, null, null, null);

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
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of job_template_field
-- ----------------------------
INSERT INTO `job_template_field` VALUES ('7192f800-3d73-11e7-995f-e09467f6dff0', '0', 'detail_url', '详情地址', 'varchar', '1024', 'test1', 'e885a180-3d71-11e7-8f5b-e09467f6dff0', null, null, 'a/@href', null, null, '2017-05-20 00:00:00');
INSERT INTO `job_template_field` VALUES ('859000f0-3d73-11e7-9187-e09467f6dff0', '0', 'desc', '描述', 'varchar', '5048', 'test1', 'e885a180-3d71-11e7-8f5b-e09467f6dff0', null, null, 'p/text()', null, null, '2017-05-20 00:00:00');
INSERT INTO `job_template_field` VALUES ('9a07df30-3d73-11e7-8066-e09467f6dff0', '0', 'info', '描述', 'varchar', '100', 'test1', 'e885a180-3d71-11e7-8f5b-e09467f6dff0', null, null, 'font/text()', null, null, '2017-05-20 00:00:00');
INSERT INTO `job_template_field` VALUES ('f5586b4f-3d75-11e7-bf8e-e09467f6dff0', '0', 'pageCount', '总数', 'varchar', '255', 'test1', 'e885a180-3d71-11e7-8f5b-e09467f6dff0', null, null, '//span[@class=\'default_pgTotalPage\']/text()', null, null, '2017-04-14 00:00:00');

-- ----------------------------
-- Table structure for job_template_param
-- ----------------------------
DROP TABLE IF EXISTS `job_template_param`;
CREATE TABLE `job_template_param` (
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
  `JOB_TEMPLATE_ID` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of job_template_param
-- ----------------------------
INSERT INTO `job_template_param` VALUES ('b330624f-3d75-11e7-8e60-e09467f6dff0', '0', 'pageNo', '页数', '1', '{pageNo}+1<{pageCount}', '{pageNo}+1', '0000-00-00 00:00:00', 'test1', '0', 'e885a180-3d71-11e7-8f5b-e09467f6dff0');
