/*
Navicat MySQL Data Transfer

Source Server         : localhost_3306
Source Server Version : 50611
Source Host           : localhost:3306
Source Database       : crawler_db

Target Server Type    : MYSQL
Target Server Version : 50611
File Encoding         : 65001

Date: 2017-05-03 15:30:59
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for proxy_info
-- ----------------------------
DROP TABLE IF EXISTS `proxy_info`;
CREATE TABLE `proxy_info` (
  `id` varchar(50) NOT NULL,
  `host_name` varchar(255) DEFAULT NULL,
  `port` varchar(8) DEFAULT NULL,
  `del_flag` tinyint(1) DEFAULT '0',
  `task_job_id` varchar(50) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `user_name` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `auth_url` varchar(255) DEFAULT NULL,
  `type` varchar(5) DEFAULT NULL,
  `file_id` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of proxy_info
-- ----------------------------
INSERT INTO `proxy_info` VALUES ('08ab7391-2fcb-11e7-8897-e09467f6dff0', null, null, '0', null, '2017-05-03 14:36:14', null, null, null, '1', null);
INSERT INTO `proxy_info` VALUES ('0d291700-2fcc-11e7-98f8-e09467f6dff0', null, null, '0', null, '2017-05-03 14:45:02', null, null, null, '1', null);
INSERT INTO `proxy_info` VALUES ('1ef61600-2fcb-11e7-a3b2-e09467f6dff0', null, null, '0', null, '2017-05-03 14:36:14', null, null, null, '1', null);
INSERT INTO `proxy_info` VALUES ('3c3bd470-2fcb-11e7-9a1f-e09467f6dff0', null, null, '0', null, '2017-05-03 14:39:08', null, null, null, '1', null);
INSERT INTO `proxy_info` VALUES ('4717deae-2fcc-11e7-8daf-e09467f6dff0', null, null, '0', null, '2017-05-03 14:46:31', null, null, null, '1', null);
INSERT INTO `proxy_info` VALUES ('71f1864f-2fcb-11e7-ab35-e09467f6dff0', null, null, '0', null, '2017-05-03 14:39:08', null, null, null, '1', null);
INSERT INTO `proxy_info` VALUES ('994b2030-2fd0-11e7-bb70-e09467f6dff0', null, null, '0', null, '2017-05-03 15:17:14', '123123', null, null, '2', null);
INSERT INTO `proxy_info` VALUES ('a5137bb0-2fd0-11e7-a902-e09467f6dff0', null, null, '0', null, '2017-05-03 15:17:14', '123123', null, null, '3', null);
INSERT INTO `proxy_info` VALUES ('b1c1e3b0-2fcb-11e7-85ef-e09467f6dff0', null, null, '0', null, '2017-05-03 14:39:08', null, null, null, '1', null);
INSERT INTO `proxy_info` VALUES ('bb310261-2fca-11e7-af21-e09467f6dff0', null, null, '0', null, '2017-05-03 14:35:17', null, null, null, '1', null);
INSERT INTO `proxy_info` VALUES ('bde1d50f-2fcb-11e7-a908-e09467f6dff0', null, null, '0', null, '2017-05-03 14:39:08', null, null, null, '1', null);
INSERT INTO `proxy_info` VALUES ('d045c770-2fcb-11e7-9748-e09467f6dff0', null, null, '0', null, '2017-05-03 14:39:08', null, null, null, '1', null);
INSERT INTO `proxy_info` VALUES ('d5c54db0-2fd0-11e7-9a86-e09467f6dff0', null, null, '0', null, '2017-05-03 15:19:21', '123123', null, null, '3', null);
INSERT INTO `proxy_info` VALUES ('d65ff94f-2fcb-11e7-a4dc-e09467f6dff0', null, null, '0', null, '2017-05-03 14:39:08', null, null, null, '1', null);
INSERT INTO `proxy_info` VALUES ('e9a8a65e-2fcb-11e7-8598-e09467f6dff0', null, null, '0', null, '2017-05-03 14:43:58', null, null, null, '1', null);
