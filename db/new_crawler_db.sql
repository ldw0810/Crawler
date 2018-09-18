/*
Navicat MySQL Data Transfer

Source Server         : localhost_3306
Source Server Version : 50611
Source Host           : localhost:3306
Source Database       : new_crawler_db

Target Server Type    : MYSQL
Target Server Version : 50611
File Encoding         : 65001

Date: 2017-05-12 01:44:50
*/

create database new_crawler_db;
use  new_crawler_db;
SET FOREIGN_KEY_CHECKS=0;
-- ----------------------------
-- Table structure for content_type
-- ----------------------------
DROP TABLE IF EXISTS `content_type`;
CREATE TABLE `content_type` (
  `ID` varchar(50) NOT NULL,
  `NAME` varchar(255) DEFAULT NULL,
  `DEL_FLAG` tinyint(1) DEFAULT NULL,
  `CREATE_TIME` datetime DEFAULT CURRENT_TIMESTAMP,
  `PARENT_ID` varchar(50) DEFAULT '-1',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of content_type
-- ----------------------------
INSERT INTO `content_type` VALUES ('1', '测试', '0', '2017-05-05 14:36:15', '-1');

-- ----------------------------
-- Table structure for data_job_template_13
-- ----------------------------
DROP TABLE IF EXISTS `data_job_template_13`;
CREATE TABLE `data_job_template_13` (
  `url` varchar(1024) DEFAULT NULL,
  `id` varchar(50) NOT NULL,
  `task_job_create_time` datetime DEFAULT NULL,
  `task_job_del_flag` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of data_job_template_13
-- ----------------------------
INSERT INTO `data_job_template_13` VALUES ('http://www.1905.com/mdb/film/2240433/', '7f7ada80-3654-11e7-98dc-e09467f6dff0', '2017-05-11 22:17:00', '0');
INSERT INTO `data_job_template_13` VALUES ('http://www.1905.com/mdb/film/2240433/', 'd1c22e4f-365a-11e7-a752-e09467f6dff0', '2017-05-11 23:02:15', '0');
INSERT INTO `data_job_template_13` VALUES ('http://www.1905.com/mdb/film/2240433/', 'de281440-3658-11e7-938b-e09467f6dff0', '2017-05-11 22:48:17', '0');
INSERT INTO `data_job_template_13` VALUES ('http://www.1905.com/mdb/film/2240433/', 'ed9bb9ee-3657-11e7-8f16-e09467f6dff0', '2017-05-11 22:41:33', '0');

-- ----------------------------
-- Table structure for data_job_template_14
-- ----------------------------
DROP TABLE IF EXISTS `data_job_template_14`;
CREATE TABLE `data_job_template_14` (
  `url` varchar(1024) DEFAULT NULL,
  `id` varchar(50) NOT NULL,
  `task_job_create_time` datetime DEFAULT NULL,
  `task_job_del_flag` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of data_job_template_14
-- ----------------------------

-- ----------------------------
-- Table structure for data_job_template_15
-- ----------------------------
DROP TABLE IF EXISTS `data_job_template_15`;
CREATE TABLE `data_job_template_15` (
  `url` varchar(1024) DEFAULT NULL,
  `id` varchar(50) NOT NULL,
  `task_job_create_time` datetime DEFAULT NULL,
  `task_job_del_flag` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of data_job_template_15
-- ----------------------------

-- ----------------------------
-- Table structure for data_job_template_25
-- ----------------------------
DROP TABLE IF EXISTS `data_job_template_25`;
CREATE TABLE `data_job_template_25` (
  `url` varchar(1024) DEFAULT NULL,
  `id` varchar(50) NOT NULL,
  `task_job_create_time` datetime DEFAULT NULL,
  `task_job_del_flag` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of data_job_template_25
-- ----------------------------
INSERT INTO `data_job_template_25` VALUES ('/?s=vod-read-id-122332.html', '7ec2d51e-3654-11e7-8ea9-e09467f6dff0', '2017-05-11 22:16:59', '0');
INSERT INTO `data_job_template_25` VALUES ('/?s=vod-read-id-122332.html', 'd150329e-365a-11e7-ba4e-e09467f6dff0', '2017-05-11 23:02:14', '0');
INSERT INTO `data_job_template_25` VALUES ('/?s=vod-read-id-118303.html', 'd1533fde-365a-11e7-9130-e09467f6dff0', '2017-05-11 23:02:14', '0');
INSERT INTO `data_job_template_25` VALUES ('/?s=vod-read-id-104570.html', 'd155ff00-365a-11e7-be47-e09467f6dff0', '2017-05-11 23:02:14', '0');
INSERT INTO `data_job_template_25` VALUES ('/?s=vod-read-id-104569.html', 'd158be1e-365a-11e7-9563-e09467f6dff0', '2017-05-11 23:02:14', '0');
INSERT INTO `data_job_template_25` VALUES ('/?s=vod-read-id-78208.html', 'd15b7d40-365a-11e7-b4f1-e09467f6dff0', '2017-05-11 23:02:14', '0');
INSERT INTO `data_job_template_25` VALUES ('/?s=vod-read-id-77995.html', 'd15dee40-365a-11e7-9fe3-e09467f6dff0', '2017-05-11 23:02:14', '0');
INSERT INTO `data_job_template_25` VALUES ('/?s=vod-read-id-67203.html', 'd1605f40-365a-11e7-8010-e09467f6dff0', '2017-05-11 23:02:14', '0');
INSERT INTO `data_job_template_25` VALUES ('/?s=vod-read-id-57375.html', 'd1636c80-365a-11e7-8b5b-e09467f6dff0', '2017-05-11 23:02:14', '0');
INSERT INTO `data_job_template_25` VALUES ('/?s=vod-read-id-122332.html', 'ddd400cf-3658-11e7-bd58-e09467f6dff0', '2017-05-11 22:48:16', '0');
INSERT INTO `data_job_template_25` VALUES ('/?s=vod-read-id-118303.html', 'ddd70e0f-3658-11e7-806a-e09467f6dff0', '2017-05-11 22:48:16', '0');
INSERT INTO `data_job_template_25` VALUES ('/?s=vod-read-id-104570.html', 'ddd9a61e-3658-11e7-8eb8-e09467f6dff0', '2017-05-11 22:48:16', '0');
INSERT INTO `data_job_template_25` VALUES ('/?s=vod-read-id-104569.html', 'dddbc900-3658-11e7-afc1-e09467f6dff0', '2017-05-11 22:48:16', '0');
INSERT INTO `data_job_template_25` VALUES ('/?s=vod-read-id-78208.html', 'ddde12f0-3658-11e7-8635-e09467f6dff0', '2017-05-11 22:48:16', '0');
INSERT INTO `data_job_template_25` VALUES ('/?s=vod-read-id-77995.html', 'dde035cf-3658-11e7-9f0a-e09467f6dff0', '2017-05-11 22:48:16', '0');
INSERT INTO `data_job_template_25` VALUES ('/?s=vod-read-id-67203.html', 'dde2a6cf-3658-11e7-bd62-e09467f6dff0', '2017-05-11 22:48:16', '0');
INSERT INTO `data_job_template_25` VALUES ('/?s=vod-read-id-57375.html', 'dde517cf-3658-11e7-87bb-e09467f6dff0', '2017-05-11 22:48:16', '0');
INSERT INTO `data_job_template_25` VALUES ('/?s=vod-read-id-122332.html', 'ed578500-3657-11e7-9e21-e09467f6dff0', '2017-05-11 22:41:33', '0');

-- ----------------------------
-- Table structure for data_job_template_28
-- ----------------------------
DROP TABLE IF EXISTS `data_job_template_28`;
CREATE TABLE `data_job_template_28` (
  `url` varchar(1024) DEFAULT NULL,
  `id` varchar(50) NOT NULL,
  `task_job_create_time` datetime DEFAULT NULL,
  `task_job_del_flag` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of data_job_template_28
-- ----------------------------

-- ----------------------------
-- Table structure for data_job_template_36
-- ----------------------------
DROP TABLE IF EXISTS `data_job_template_36`;
CREATE TABLE `data_job_template_36` (
  `movieName` varchar(1024) DEFAULT NULL,
  `movieTime` varchar(1024) DEFAULT NULL,
  `movieDirector` varchar(1024) DEFAULT NULL,
  `id` varchar(50) NOT NULL,
  `task_job_create_time` datetime DEFAULT NULL,
  `task_job_del_flag` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of data_job_template_36
-- ----------------------------
INSERT INTO `data_job_template_36` VALUES ('刺客信条', '<span class=\"type_txt\">2017-02-24</span>', '', '17739940-3668-11e7-957a-e09467f6dff0', '2017-05-12 00:37:15', '0');
INSERT INTO `data_job_template_36` VALUES ('刺客信条:权势', '', '', '178c7870-3668-11e7-b35a-e09467f6dff0', '2017-05-12 00:37:15', '0');
INSERT INTO `data_job_template_36` VALUES ('刺客信条:权势', '', '', 'c7366921-3668-11e7-9c76-e09467f6dff0', '2017-05-12 00:42:10', '0');
INSERT INTO `data_job_template_36` VALUES ('刺客信条', '2017-02-24', '', 'c74efa2e-3668-11e7-879c-e09467f6dff0', '2017-05-12 00:42:10', '0');

-- ----------------------------
-- Table structure for data_job_template_37
-- ----------------------------
DROP TABLE IF EXISTS `data_job_template_37`;
CREATE TABLE `data_job_template_37` (
  `movieName` varchar(1024) DEFAULT NULL,
  `movieTime` varchar(1024) DEFAULT NULL,
  `movieDiretor` varchar(1024) DEFAULT NULL,
  `id` varchar(50) NOT NULL,
  `task_job_create_time` datetime DEFAULT NULL,
  `task_job_del_flag` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of data_job_template_37
-- ----------------------------

-- ----------------------------
-- Table structure for data_job_template_41
-- ----------------------------
DROP TABLE IF EXISTS `data_job_template_41`;
CREATE TABLE `data_job_template_41` (
  `movieDirector` varchar(1024) DEFAULT NULL,
  `modieName` varchar(1024) DEFAULT NULL,
  `movieTime` varchar(1024) DEFAULT NULL,
  `id` varchar(50) NOT NULL,
  `task_job_create_time` datetime DEFAULT NULL,
  `task_job_del_flag` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of data_job_template_41
-- ----------------------------
INSERT INTO `data_job_template_41` VALUES ('◎导　　演　贾斯汀·库泽尔 Justin Kurzel', '◎片　　名　刺客信条 Assassin’s Creed', '◎年　　代　2016', '7d402cc0-3654-11e7-9f96-e09467f6dff0', '2017-05-11 22:16:56', '0');
INSERT INTO `data_job_template_41` VALUES ('◎导　　演　贾斯汀·库泽尔 Justin Kurzel', '◎片　　名　刺客信条 Assassin’s Creed', '◎年　　代　2016', 'd04e7a11-365a-11e7-b578-e09467f6dff0', '2017-05-11 23:02:12', '0');
INSERT INTO `data_job_template_41` VALUES ('◎导　　演　贾斯汀·库泽尔 Justin Kurzel', '◎片　　名　刺客信条 Assassin’s Creed', '◎年　　代　2016', 'dccddb70-3658-11e7-8d5a-e09467f6dff0', '2017-05-11 22:48:14', '0');

-- ----------------------------
-- Table structure for data_job_template_46
-- ----------------------------
DROP TABLE IF EXISTS `data_job_template_46`;
CREATE TABLE `data_job_template_46` (
  `movieDirector` varchar(1024) DEFAULT NULL,
  `movieName` varchar(1024) DEFAULT NULL,
  `movieTime` varchar(1024) DEFAULT NULL,
  `id` varchar(50) NOT NULL,
  `task_job_create_time` datetime DEFAULT NULL,
  `task_job_del_flag` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of data_job_template_46
-- ----------------------------
INSERT INTO `data_job_template_46` VALUES ('', '《刺客信条》发布会', '', '8062c980-3654-11e7-8039-e09467f6dff0', '2017-05-11 22:17:01', '0');
INSERT INTO `data_job_template_46` VALUES ('', '《刺客信条》发布会', '', 'd4701040-365a-11e7-a624-e09467f6dff0', '2017-05-11 23:02:19', '0');
INSERT INTO `data_job_template_46` VALUES ('', '《刺客信条》发布会', '', 'dfecf5c0-3658-11e7-aa51-e09467f6dff0', '2017-05-11 22:48:20', '0');
INSERT INTO `data_job_template_46` VALUES ('', '《刺客信条》发布会', '', 'ee34c59e-3657-11e7-be29-e09467f6dff0', '2017-05-11 22:41:34', '0');

-- ----------------------------
-- Table structure for data_job_template_49
-- ----------------------------
DROP TABLE IF EXISTS `data_job_template_49`;
CREATE TABLE `data_job_template_49` (
  `detailUrl` varchar(1024) DEFAULT NULL,
  `movieName` varchar(1024) DEFAULT NULL,
  `movieDirector` varchar(1024) DEFAULT NULL,
  `id` varchar(50) NOT NULL,
  `task_job_create_time` datetime DEFAULT NULL,
  `task_job_del_flag` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of data_job_template_49
-- ----------------------------
INSERT INTO `data_job_template_49` VALUES ('http://v.qq.com/x/cover/yz4vl2g8sma0zuu.html', '', '', '04f8e100-365c-11e7-95b5-e09467f6dff0', '2017-05-11 23:10:50', '0');
INSERT INTO `data_job_template_49` VALUES ('', '刺客信条', '', '04fc8a80-365c-11e7-bf19-e09467f6dff0', '2017-05-11 23:10:50', '0');
INSERT INTO `data_job_template_49` VALUES ('http://v.qq.com/detail/t/tlqma6dqnaailbj.html', '', '', '04ff97c0-365c-11e7-a20f-e09467f6dff0', '2017-05-11 23:10:50', '0');
INSERT INTO `data_job_template_49` VALUES ('', '刺客信条', '', '0502cc0f-365c-11e7-82ce-e09467f6dff0', '2017-05-11 23:10:50', '0');
INSERT INTO `data_job_template_49` VALUES ('', '刺客信条', '', '05051600-365c-11e7-952b-e09467f6dff0', '2017-05-11 23:10:50', '0');
INSERT INTO `data_job_template_49` VALUES ('', '刺客信条', '', '050711cf-365c-11e7-bfd6-e09467f6dff0', '2017-05-11 23:10:50', '0');
INSERT INTO `data_job_template_49` VALUES ('', '刺客信条', '', '050934b0-365c-11e7-a5e9-e09467f6dff0', '2017-05-11 23:10:50', '0');
INSERT INTO `data_job_template_49` VALUES ('', '刺客信条', '', '050b7ea1-365c-11e7-8210-e09467f6dff0', '2017-05-11 23:10:50', '0');
INSERT INTO `data_job_template_49` VALUES ('', '刺客信条', '', '050dc88f-365c-11e7-a749-e09467f6dff0', '2017-05-11 23:10:50', '0');
INSERT INTO `data_job_template_49` VALUES ('', '刺客信条', '', '0510398f-365c-11e7-9ae6-e09467f6dff0', '2017-05-11 23:10:50', '0');
INSERT INTO `data_job_template_49` VALUES ('', '刺客信条', '', '0512f8b0-365c-11e7-b1b7-e09467f6dff0', '2017-05-11 23:10:50', '0');
INSERT INTO `data_job_template_49` VALUES ('', '刺客信条', '', '05151b8f-365c-11e7-a129-e09467f6dff0', '2017-05-11 23:10:50', '0');
INSERT INTO `data_job_template_49` VALUES ('', '刺客信条', '', '0517b3a1-365c-11e7-841c-e09467f6dff0', '2017-05-11 23:10:50', '0');
INSERT INTO `data_job_template_49` VALUES ('', '刺客信条', '', '051a4bb0-365c-11e7-b625-e09467f6dff0', '2017-05-11 23:10:50', '0');
INSERT INTO `data_job_template_49` VALUES ('', '刺客信条', '', '051d31e1-365c-11e7-917c-e09467f6dff0', '2017-05-11 23:10:50', '0');
INSERT INTO `data_job_template_49` VALUES ('http://v.qq.com/x/cover/yz4vl2g8sma0zuu.html', '', '', '0b78044f-365e-11e7-8442-e09467f6dff0', '2017-05-11 23:25:23', '0');
INSERT INTO `data_job_template_49` VALUES ('', '刺客信条', '', '0cd76d40-365e-11e7-a820-e09467f6dff0', '2017-05-11 23:25:23', '0');
INSERT INTO `data_job_template_49` VALUES ('', '刺客信条', '', '0cda2c61-365e-11e7-a712-e09467f6dff0', '2017-05-11 23:25:23', '0');
INSERT INTO `data_job_template_49` VALUES ('http://v.qq.com/detail/t/tlqma6dqnaailbj.html', '', '', '0cdcc470-365e-11e7-a1d4-e09467f6dff0', '2017-05-11 23:25:23', '0');
INSERT INTO `data_job_template_49` VALUES ('', '刺客信条', '', '0cdf5c80-365e-11e7-8002-e09467f6dff0', '2017-05-11 23:25:23', '0');
INSERT INTO `data_job_template_49` VALUES ('', '刺客信条', '', '0ce1f48f-365e-11e7-b3b8-e09467f6dff0', '2017-05-11 23:25:23', '0');
INSERT INTO `data_job_template_49` VALUES ('', '刺客信条', '', '0ce4dac0-365e-11e7-a0df-e09467f6dff0', '2017-05-11 23:25:23', '0');
INSERT INTO `data_job_template_49` VALUES ('', '刺客信条', '', '0ce7c0f0-365e-11e7-bab6-e09467f6dff0', '2017-05-11 23:25:23', '0');
INSERT INTO `data_job_template_49` VALUES ('', '刺客信条', '', '0ceb6a70-365e-11e7-9fa0-e09467f6dff0', '2017-05-11 23:25:23', '0');
INSERT INTO `data_job_template_49` VALUES ('', '刺客信条', '', '0cef3b00-365e-11e7-b937-e09467f6dff0', '2017-05-11 23:25:23', '0');
INSERT INTO `data_job_template_49` VALUES ('', '刺客信条', '', '0cf26f4f-365e-11e7-8bb3-e09467f6dff0', '2017-05-11 23:25:23', '0');
INSERT INTO `data_job_template_49` VALUES ('', '刺客信条', '', '0cf6b50f-365e-11e7-ba4e-e09467f6dff0', '2017-05-11 23:25:23', '0');
INSERT INTO `data_job_template_49` VALUES ('', '刺客信条', '', '0cfaacae-365e-11e7-91ad-e09467f6dff0', '2017-05-11 23:25:23', '0');
INSERT INTO `data_job_template_49` VALUES ('', '刺客信条', '', '0cfe5630-365e-11e7-98f2-e09467f6dff0', '2017-05-11 23:25:23', '0');
INSERT INTO `data_job_template_49` VALUES ('', '刺客信条', '', '0d02ea0f-365e-11e7-bd31-e09467f6dff0', '2017-05-11 23:25:23', '0');
INSERT INTO `data_job_template_49` VALUES ('http://v.qq.com/detail/y/yz4vl2g8sma0zuu.html', '', '', '1a086e8f-3660-11e7-a459-e09467f6dff0', '2017-05-11 23:40:04', '0');
INSERT INTO `data_job_template_49` VALUES ('http://v.qq.com/detail/t/tlqma6dqnaailbj.html', '', '', '1a0c3f21-3660-11e7-bef0-e09467f6dff0', '2017-05-11 23:40:04', '0');
INSERT INTO `data_job_template_49` VALUES ('', '', '', '1a0efe40-3660-11e7-9e1d-e09467f6dff0', '2017-05-11 23:40:04', '0');
INSERT INTO `data_job_template_49` VALUES ('', '', '', '1a116f40-3660-11e7-8def-e09467f6dff0', '2017-05-11 23:40:04', '0');
INSERT INTO `data_job_template_49` VALUES ('', '刺客信条', '', '1a13b930-3660-11e7-922b-e09467f6dff0', '2017-05-11 23:40:04', '0');
INSERT INTO `data_job_template_49` VALUES ('', '刺客信条', '', '1a16031e-3660-11e7-8c0b-e09467f6dff0', '2017-05-11 23:40:04', '0');
INSERT INTO `data_job_template_49` VALUES ('', '刺客信条', '', '1a189b2e-3660-11e7-beed-e09467f6dff0', '2017-05-11 23:40:04', '0');
INSERT INTO `data_job_template_49` VALUES ('', '刺客信条', '', '1a1bcf80-3660-11e7-b2ab-e09467f6dff0', '2017-05-11 23:40:04', '0');
INSERT INTO `data_job_template_49` VALUES ('', '刺客信条', '', '1a1edcc0-3660-11e7-99d4-e09467f6dff0', '2017-05-11 23:40:04', '0');
INSERT INTO `data_job_template_49` VALUES ('', '刺客信条', '', '1a2174cf-3660-11e7-a3e4-e09467f6dff0', '2017-05-11 23:40:04', '0');
INSERT INTO `data_job_template_49` VALUES ('', '刺客信条', '', '1a23bec0-3660-11e7-ae5d-e09467f6dff0', '2017-05-11 23:40:04', '0');
INSERT INTO `data_job_template_49` VALUES ('', '刺客信条', '', '1a25e1a1-3660-11e7-b8da-e09467f6dff0', '2017-05-11 23:40:04', '0');
INSERT INTO `data_job_template_49` VALUES ('', '刺客信条', '', '1a2852a1-3660-11e7-8032-e09467f6dff0', '2017-05-11 23:40:04', '0');
INSERT INTO `data_job_template_49` VALUES ('', '刺客信条', '', '1a2a7580-3660-11e7-81fc-e09467f6dff0', '2017-05-11 23:40:04', '0');
INSERT INTO `data_job_template_49` VALUES ('', '刺客信条', '', '1a2ce680-3660-11e7-9e52-e09467f6dff0', '2017-05-11 23:40:04', '0');
INSERT INTO `data_job_template_49` VALUES ('http://v.qq.com/x/cover/yz4vl2g8sma0zuu.html', '', '', '1f0ce780-365c-11e7-84f7-e09467f6dff0', '2017-05-11 23:12:39', '0');
INSERT INTO `data_job_template_49` VALUES ('http://v.qq.com/x/cover/yz4vl2g8sma0zuu.html', '', '', '211433c0-365d-11e7-9587-e09467f6dff0', '2017-05-11 23:20:14', '0');
INSERT INTO `data_job_template_49` VALUES ('', '刺客信条', '', '22a0a021-365d-11e7-9dfb-e09467f6dff0', '2017-05-11 23:20:14', '0');
INSERT INTO `data_job_template_49` VALUES ('http://v.qq.com/detail/y/yz4vl2g8sma0zuu.html', '', '', '2f283dde-3666-11e7-b7ae-e09467f6dff0', '2017-05-12 00:23:36', '0');
INSERT INTO `data_job_template_49` VALUES ('http://v.qq.com/detail/t/tlqma6dqnaailbj.html', '', '', '2f2b9940-3666-11e7-a4a0-e09467f6dff0', '2017-05-12 00:23:36', '0');
INSERT INTO `data_job_template_49` VALUES ('', '', '', '2f2e314f-3666-11e7-82c4-e09467f6dff0', '2017-05-12 00:23:36', '0');
INSERT INTO `data_job_template_49` VALUES ('', '', '', '2f30f06e-3666-11e7-875b-e09467f6dff0', '2017-05-12 00:23:36', '0');
INSERT INTO `data_job_template_49` VALUES ('', '刺客信条', '', '2f33fdb0-3666-11e7-a363-e09467f6dff0', '2017-05-12 00:23:36', '0');
INSERT INTO `data_job_template_49` VALUES ('', '刺客信条', '', '2f373200-3666-11e7-b056-e09467f6dff0', '2017-05-12 00:23:36', '0');
INSERT INTO `data_job_template_49` VALUES ('', '刺客信条', '', '2f39f11e-3666-11e7-8aea-e09467f6dff0', '2017-05-12 00:23:36', '0');
INSERT INTO `data_job_template_49` VALUES ('', '刺客信条', '', '2f3cb040-3666-11e7-aedd-e09467f6dff0', '2017-05-12 00:23:36', '0');
INSERT INTO `data_job_template_49` VALUES ('', '刺客信条', '', '2f3f6f5e-3666-11e7-8b36-e09467f6dff0', '2017-05-12 00:23:36', '0');
INSERT INTO `data_job_template_49` VALUES ('', '刺客信条', '', '2f422e80-3666-11e7-830d-e09467f6dff0', '2017-05-12 00:23:36', '0');
INSERT INTO `data_job_template_49` VALUES ('', '刺客信条', '', '2f4514b0-3666-11e7-928f-e09467f6dff0', '2017-05-12 00:23:36', '0');
INSERT INTO `data_job_template_49` VALUES ('', '刺客信条', '', '2f47acc0-3666-11e7-b8b1-e09467f6dff0', '2017-05-12 00:23:36', '0');
INSERT INTO `data_job_template_49` VALUES ('', '刺客信条', '', '2f4a1dc0-3666-11e7-9c4c-e09467f6dff0', '2017-05-12 00:23:36', '0');
INSERT INTO `data_job_template_49` VALUES ('', '刺客信条', '', '2f4c8ec0-3666-11e7-bc49-e09467f6dff0', '2017-05-12 00:23:36', '0');
INSERT INTO `data_job_template_49` VALUES ('', '刺客信条', '', '2f4f4de1-3666-11e7-aff9-e09467f6dff0', '2017-05-12 00:23:36', '0');
INSERT INTO `data_job_template_49` VALUES ('http://v.qq.com/detail/y/yz4vl2g8sma0zuu.html', '', '', '31f2d3c0-365f-11e7-88e6-e09467f6dff0', '2017-05-11 23:33:34', '0');
INSERT INTO `data_job_template_49` VALUES ('http://v.qq.com/detail/t/tlqma6dqnaailbj.html', '', '', '31f6cb61-365f-11e7-bfe1-e09467f6dff0', '2017-05-11 23:33:34', '0');
INSERT INTO `data_job_template_49` VALUES ('', '', '', '31f9d8a1-365f-11e7-b7a6-e09467f6dff0', '2017-05-11 23:33:34', '0');
INSERT INTO `data_job_template_49` VALUES ('', '', '', '31fdf74f-365f-11e7-928e-e09467f6dff0', '2017-05-11 23:33:34', '0');
INSERT INTO `data_job_template_49` VALUES ('', '刺客信条', '', '32026421-365f-11e7-b791-e09467f6dff0', '2017-05-11 23:33:34', '0');
INSERT INTO `data_job_template_49` VALUES ('', '刺客信条', '', '3206a9de-365f-11e7-9dab-e09467f6dff0', '2017-05-11 23:33:34', '0');
INSERT INTO `data_job_template_49` VALUES ('', '刺客信条', '', '320a0540-365f-11e7-8343-e09467f6dff0', '2017-05-11 23:33:34', '0');
INSERT INTO `data_job_template_49` VALUES ('', '刺客信条', '', '320c7640-365f-11e7-9a7d-e09467f6dff0', '2017-05-11 23:33:34', '0');
INSERT INTO `data_job_template_49` VALUES ('', '刺客信条', '', '320f0e4f-365f-11e7-8366-e09467f6dff0', '2017-05-11 23:33:34', '0');
INSERT INTO `data_job_template_49` VALUES ('', '刺客信条', '', '321305f0-365f-11e7-8848-e09467f6dff0', '2017-05-11 23:33:34', '0');
INSERT INTO `data_job_template_49` VALUES ('', '刺客信条', '', '32188430-365f-11e7-aa1b-e09467f6dff0', '2017-05-11 23:33:34', '0');
INSERT INTO `data_job_template_49` VALUES ('', '刺客信条', '', '321bdf91-365f-11e7-aa35-e09467f6dff0', '2017-05-11 23:33:34', '0');
INSERT INTO `data_job_template_49` VALUES ('', '刺客信条', '', '321e9eb0-365f-11e7-8334-e09467f6dff0', '2017-05-11 23:33:34', '0');
INSERT INTO `data_job_template_49` VALUES ('', '刺客信条', '', '3221abf0-365f-11e7-82db-e09467f6dff0', '2017-05-11 23:33:34', '0');
INSERT INTO `data_job_template_49` VALUES ('', '刺客信条', '', '32241cf0-365f-11e7-a23b-e09467f6dff0', '2017-05-11 23:33:34', '0');
INSERT INTO `data_job_template_49` VALUES ('', '刺客信条', '', '373afa80-365d-11e7-b548-e09467f6dff0', '2017-05-11 23:20:14', '0');
INSERT INTO `data_job_template_49` VALUES ('', '刺客信条', '', '3a5ec530-365c-11e7-946f-e09467f6dff0', '2017-05-11 23:12:39', '0');
INSERT INTO `data_job_template_49` VALUES ('http://v.qq.com/detail/t/tlqma6dqnaailbj.html', '', '', '3b430ab0-365c-11e7-8def-e09467f6dff0', '2017-05-11 23:12:39', '0');
INSERT INTO `data_job_template_49` VALUES ('http://v.qq.com/detail/t/tlqma6dqnaailbj.html', '', '', '3bca1f8f-365d-11e7-8e9d-e09467f6dff0', '2017-05-11 23:20:14', '0');
INSERT INTO `data_job_template_49` VALUES ('', '刺客信条', '', '3d12255e-365c-11e7-afa9-e09467f6dff0', '2017-05-11 23:12:39', '0');
INSERT INTO `data_job_template_49` VALUES ('', '刺客信条', '', '45fe6300-365c-11e7-97f2-e09467f6dff0', '2017-05-11 23:12:39', '0');
INSERT INTO `data_job_template_49` VALUES ('', '刺客信条', '', '46017040-365c-11e7-9e58-e09467f6dff0', '2017-05-11 23:12:39', '0');
INSERT INTO `data_job_template_49` VALUES ('', '刺客信条', '', '4604a48f-365c-11e7-8a24-e09467f6dff0', '2017-05-11 23:12:39', '0');
INSERT INTO `data_job_template_49` VALUES ('', '刺客信条', '', '4607ffee-365c-11e7-8377-e09467f6dff0', '2017-05-11 23:12:39', '0');
INSERT INTO `data_job_template_49` VALUES ('', '刺客信条', '', '460ae61e-365c-11e7-823f-e09467f6dff0', '2017-05-11 23:12:39', '0');
INSERT INTO `data_job_template_49` VALUES ('', '刺客信条', '', '460dcc4f-365c-11e7-8789-e09467f6dff0', '2017-05-11 23:12:39', '0');
INSERT INTO `data_job_template_49` VALUES ('', '刺客信条', '', '46108b6e-365c-11e7-83b8-e09467f6dff0', '2017-05-11 23:12:39', '0');
INSERT INTO `data_job_template_49` VALUES ('', '刺客信条', '', '4613bfc0-365c-11e7-a2ae-e09467f6dff0', '2017-05-11 23:12:39', '0');
INSERT INTO `data_job_template_49` VALUES ('', '刺客信条', '', '46167ede-365c-11e7-bb82-e09467f6dff0', '2017-05-11 23:12:39', '0');
INSERT INTO `data_job_template_49` VALUES ('', '刺客信条', '', '461916f0-365c-11e7-b139-e09467f6dff0', '2017-05-11 23:12:39', '0');
INSERT INTO `data_job_template_49` VALUES ('', '刺客信条', '', '461b39cf-365c-11e7-9ae0-e09467f6dff0', '2017-05-11 23:12:39', '0');
INSERT INTO `data_job_template_49` VALUES ('', '刺客信条', '', '539f599e-365d-11e7-8f56-e09467f6dff0', '2017-05-11 23:20:14', '0');
INSERT INTO `data_job_template_49` VALUES ('', '刺客信条', '', '54eee40f-365d-11e7-b373-e09467f6dff0', '2017-05-11 23:20:14', '0');
INSERT INTO `data_job_template_49` VALUES ('', '刺客信条', '', '54f12e00-365d-11e7-9fad-e09467f6dff0', '2017-05-11 23:20:14', '0');
INSERT INTO `data_job_template_49` VALUES ('', '刺客信条', '', '54f329cf-365d-11e7-a03c-e09467f6dff0', '2017-05-11 23:20:14', '0');
INSERT INTO `data_job_template_49` VALUES ('', '刺客信条', '', '54f59acf-365d-11e7-8435-e09467f6dff0', '2017-05-11 23:20:14', '0');
INSERT INTO `data_job_template_49` VALUES ('', '刺客信条', '', '54f76f8f-365d-11e7-8cef-e09467f6dff0', '2017-05-11 23:20:14', '0');
INSERT INTO `data_job_template_49` VALUES ('', '刺客信条', '', '54fa55c0-365d-11e7-a399-e09467f6dff0', '2017-05-11 23:20:14', '0');
INSERT INTO `data_job_template_49` VALUES ('', '刺客信条', '', '54fdd830-365d-11e7-a257-e09467f6dff0', '2017-05-11 23:20:14', '0');
INSERT INTO `data_job_template_49` VALUES ('', '刺客信条', '', '5500e570-365d-11e7-b5b8-e09467f6dff0', '2017-05-11 23:20:14', '0');
INSERT INTO `data_job_template_49` VALUES ('', '刺客信条', '', '550440cf-365d-11e7-9540-e09467f6dff0', '2017-05-11 23:20:14', '0');
INSERT INTO `data_job_template_49` VALUES ('', '刺客信条', '', '55079c30-365d-11e7-ad87-e09467f6dff0', '2017-05-11 23:20:14', '0');
INSERT INTO `data_job_template_49` VALUES ('http://v.qq.com/detail/y/yz4vl2g8sma0zuu.html', '', '', '610318cf-3661-11e7-b88a-e09467f6dff0', '2017-05-11 23:49:12', '0');
INSERT INTO `data_job_template_49` VALUES ('', '刺客信条', '', '6106e95e-3661-11e7-984a-e09467f6dff0', '2017-05-11 23:49:12', '0');
INSERT INTO `data_job_template_49` VALUES ('', '刺客信条', '', '61098170-3661-11e7-b331-e09467f6dff0', '2017-05-11 23:49:12', '0');
INSERT INTO `data_job_template_49` VALUES ('http://v.qq.com/detail/t/tlqma6dqnaailbj.html', '', '', '610c679e-3661-11e7-8832-e09467f6dff0', '2017-05-11 23:49:12', '0');
INSERT INTO `data_job_template_49` VALUES ('', '刺客信条', '', '6110111e-3661-11e7-9e75-e09467f6dff0', '2017-05-11 23:49:12', '0');
INSERT INTO `data_job_template_49` VALUES ('', '刺客信条', '', '6112d040-3661-11e7-9aa0-e09467f6dff0', '2017-05-11 23:49:12', '0');
INSERT INTO `data_job_template_49` VALUES ('', '刺客信条', '', '6115b670-3661-11e7-9b6c-e09467f6dff0', '2017-05-11 23:49:12', '0');
INSERT INTO `data_job_template_49` VALUES ('', '刺客信条', '', '61189c9e-3661-11e7-b72c-e09467f6dff0', '2017-05-11 23:49:12', '0');
INSERT INTO `data_job_template_49` VALUES ('', '刺客信条', '', '6124355e-3661-11e7-962c-e09467f6dff0', '2017-05-11 23:49:12', '0');
INSERT INTO `data_job_template_49` VALUES ('', '刺客信条', '', '6128c940-3661-11e7-bc0f-e09467f6dff0', '2017-05-11 23:49:12', '0');
INSERT INTO `data_job_template_49` VALUES ('', '刺客信条', '', '612b885e-3661-11e7-8b97-e09467f6dff0', '2017-05-11 23:49:12', '0');
INSERT INTO `data_job_template_49` VALUES ('', '刺客信条', '', '612e2070-3661-11e7-a70d-e09467f6dff0', '2017-05-11 23:49:12', '0');
INSERT INTO `data_job_template_49` VALUES ('', '刺客信条', '', '61306a61-3661-11e7-9ff1-e09467f6dff0', '2017-05-11 23:49:12', '0');
INSERT INTO `data_job_template_49` VALUES ('', '刺客信条', '', '61328d40-3661-11e7-944a-e09467f6dff0', '2017-05-11 23:49:12', '0');
INSERT INTO `data_job_template_49` VALUES ('', '刺客信条', '', '6134d730-3661-11e7-a675-e09467f6dff0', '2017-05-11 23:49:12', '0');
INSERT INTO `data_job_template_49` VALUES ('http://v.qq.com/x/cover/yz4vl2g8sma0zuu.html', '', '', '696b60c0-365e-11e7-bbdf-e09467f6dff0', '2017-05-11 23:28:33', '0');
INSERT INTO `data_job_template_49` VALUES ('http://v.qq.com/detail/y/yz4vl2g8sma0zuu.html', '', '', '6cca5b80-3664-11e7-afe4-e09467f6dff0', '2017-05-12 00:11:01', '0');
INSERT INTO `data_job_template_49` VALUES ('http://v.qq.com/detail/t/tlqma6dqnaailbj.html', '', '', '6ccf8b9e-3664-11e7-af44-e09467f6dff0', '2017-05-12 00:11:01', '0');
INSERT INTO `data_job_template_49` VALUES ('', '', '', '6cd35c30-3664-11e7-bb39-e09467f6dff0', '2017-05-12 00:11:01', '0');
INSERT INTO `data_job_template_49` VALUES ('', '', '', '6cd6dea1-3664-11e7-b91d-e09467f6dff0', '2017-05-12 00:11:01', '0');
INSERT INTO `data_job_template_49` VALUES ('', '刺客信条', '', '6cd94fa1-3664-11e7-8263-e09467f6dff0', '2017-05-12 00:11:01', '0');
INSERT INTO `data_job_template_49` VALUES ('', '刺客信条', '', '6cdbc09e-3664-11e7-9a9e-e09467f6dff0', '2017-05-12 00:11:01', '0');
INSERT INTO `data_job_template_49` VALUES ('', '刺客信条', '', '6cde0a8f-3664-11e7-a9eb-e09467f6dff0', '2017-05-12 00:11:01', '0');
INSERT INTO `data_job_template_49` VALUES ('', '刺客信条', '', '6ce07b8f-3664-11e7-b4fb-e09467f6dff0', '2017-05-12 00:11:01', '0');
INSERT INTO `data_job_template_49` VALUES ('', '刺客信条', '', '6ce33aae-3664-11e7-a875-e09467f6dff0', '2017-05-12 00:11:01', '0');
INSERT INTO `data_job_template_49` VALUES ('', '刺客信条', '', '6ce5f9cf-3664-11e7-8045-e09467f6dff0', '2017-05-12 00:11:01', '0');
INSERT INTO `data_job_template_49` VALUES ('', '刺客信条', '', '6ce8b8f0-3664-11e7-adff-e09467f6dff0', '2017-05-12 00:11:01', '0');
INSERT INTO `data_job_template_49` VALUES ('', '刺客信条', '', '6ceb29f0-3664-11e7-80bf-e09467f6dff0', '2017-05-12 00:11:01', '0');
INSERT INTO `data_job_template_49` VALUES ('', '刺客信条', '', '6ced9af0-3664-11e7-a9ea-e09467f6dff0', '2017-05-12 00:11:01', '0');
INSERT INTO `data_job_template_49` VALUES ('', '刺客信条', '', '6cefe4e1-3664-11e7-8196-e09467f6dff0', '2017-05-12 00:11:01', '0');
INSERT INTO `data_job_template_49` VALUES ('', '刺客信条', '', '6cf207c0-3664-11e7-98d2-e09467f6dff0', '2017-05-12 00:11:01', '0');
INSERT INTO `data_job_template_49` VALUES ('http://v.qq.com/x/cover/yz4vl2g8sma0zuu.html', '', '', '7b80f6f0-365c-11e7-9577-e09467f6dff0', '2017-05-11 23:16:43', '0');
INSERT INTO `data_job_template_49` VALUES ('http://v.qq.com/detail/t/tlqma6dqnaailbj.html', '', '', '7c0de2c0-365e-11e7-bf9d-e09467f6dff0', '2017-05-11 23:28:33', '0');
INSERT INTO `data_job_template_49` VALUES ('http://v.qq.com/detail/5/56953.html', '', '', '7d07d321-365e-11e7-9903-e09467f6dff0', '2017-05-11 23:28:33', '0');
INSERT INTO `data_job_template_49` VALUES ('http://v.qq.com/detail/6/63929.html', '', '', '7da17b0f-365e-11e7-a989-e09467f6dff0', '2017-05-11 23:28:33', '0');
INSERT INTO `data_job_template_49` VALUES ('http://v.qq.com/detail/y/yz4vl2g8sma0zuu.html', '', '', '7dd8a8f0-3664-11e7-b46c-e09467f6dff0', '2017-05-12 00:11:29', '0');
INSERT INTO `data_job_template_49` VALUES ('', '刺客信条', '', '7ddc7980-3664-11e7-a159-e09467f6dff0', '2017-05-12 00:11:29', '0');
INSERT INTO `data_job_template_49` VALUES ('http://v.qq.com/detail/t/tlqma6dqnaailbj.html', '', '', '7ddeea80-3664-11e7-8734-e09467f6dff0', '2017-05-12 00:11:29', '0');
INSERT INTO `data_job_template_49` VALUES ('', '刺客信条', '', '7de1d0b0-3664-11e7-8d6c-e09467f6dff0', '2017-05-12 00:11:29', '0');
INSERT INTO `data_job_template_49` VALUES ('', '刺客信条', '', '7de48fcf-3664-11e7-b716-e09467f6dff0', '2017-05-12 00:11:29', '0');
INSERT INTO `data_job_template_49` VALUES ('', '刺客信条', '', '7de727e1-3664-11e7-b484-e09467f6dff0', '2017-05-12 00:11:29', '0');
INSERT INTO `data_job_template_49` VALUES ('', '刺客信条', '', '7de9bff0-3664-11e7-9c70-e09467f6dff0', '2017-05-12 00:11:29', '0');
INSERT INTO `data_job_template_49` VALUES ('', '刺客信条', '', '7dec5800-3664-11e7-a9ee-e09467f6dff0', '2017-05-12 00:11:29', '0');
INSERT INTO `data_job_template_49` VALUES ('', '刺客信条', '', '7def171e-3664-11e7-9ca1-e09467f6dff0', '2017-05-12 00:11:29', '0');
INSERT INTO `data_job_template_49` VALUES ('', '刺客信条', '', '7df112ee-3664-11e7-85f9-e09467f6dff0', '2017-05-12 00:11:29', '0');
INSERT INTO `data_job_template_49` VALUES ('', '刺客信条', '', '7df3d20f-3664-11e7-bf47-e09467f6dff0', '2017-05-12 00:11:29', '0');
INSERT INTO `data_job_template_49` VALUES ('', '刺客信条', '', '7df66a1e-3664-11e7-b9c8-e09467f6dff0', '2017-05-12 00:11:29', '0');
INSERT INTO `data_job_template_49` VALUES ('', '刺客信条', '', '7df8db21-3664-11e7-8422-e09467f6dff0', '2017-05-12 00:11:29', '0');
INSERT INTO `data_job_template_49` VALUES ('', '刺客信条', '', '7dfb9a40-3664-11e7-b7ef-e09467f6dff0', '2017-05-12 00:11:29', '0');
INSERT INTO `data_job_template_49` VALUES ('', '刺客信条', '', '7dfde430-3664-11e7-817d-e09467f6dff0', '2017-05-12 00:11:29', '0');
INSERT INTO `data_job_template_49` VALUES ('', '刺客信条', '', '7e7e1f6e-365e-11e7-8e41-e09467f6dff0', '2017-05-11 23:28:33', '0');
INSERT INTO `data_job_template_49` VALUES ('', '刺客信条', '', '7e80b780-365e-11e7-b6bc-e09467f6dff0', '2017-05-11 23:28:33', '0');
INSERT INTO `data_job_template_49` VALUES ('', '刺客信条', '', '7e830170-365e-11e7-8088-e09467f6dff0', '2017-05-11 23:28:33', '0');
INSERT INTO `data_job_template_49` VALUES ('', '刺客信条', '', '7e857270-365e-11e7-9516-e09467f6dff0', '2017-05-11 23:28:33', '0');
INSERT INTO `data_job_template_49` VALUES ('', '刺客信条', '', '7e87e370-365e-11e7-9702-e09467f6dff0', '2017-05-11 23:28:33', '0');
INSERT INTO `data_job_template_49` VALUES ('', '刺客信条', '', '7e8a5470-365e-11e7-9925-e09467f6dff0', '2017-05-11 23:28:33', '0');
INSERT INTO `data_job_template_49` VALUES ('', '刺客信条', '', '7e8d61b0-365e-11e7-b591-e09467f6dff0', '2017-05-11 23:28:33', '0');
INSERT INTO `data_job_template_49` VALUES ('', '刺客信条', '', '7e906ef0-365e-11e7-8a79-e09467f6dff0', '2017-05-11 23:28:33', '0');
INSERT INTO `data_job_template_49` VALUES ('', '刺客信条', '', '7e93ca51-365e-11e7-8014-e09467f6dff0', '2017-05-11 23:28:33', '0');
INSERT INTO `data_job_template_49` VALUES ('', '刺客信条', '', '7e95ed30-365e-11e7-828d-e09467f6dff0', '2017-05-11 23:28:33', '0');
INSERT INTO `data_job_template_49` VALUES ('', '刺客信条', '', '7e98d361-365e-11e7-8842-e09467f6dff0', '2017-05-11 23:28:33', '0');
INSERT INTO `data_job_template_49` VALUES ('http://v.qq.com/detail/y/yz4vl2g8sma0zuu.html', '', '', '8285c0d1-3665-11e7-a2d1-e09467f6dff0', '2017-05-12 00:18:47', '0');
INSERT INTO `data_job_template_49` VALUES ('http://v.qq.com/detail/t/tlqma6dqnaailbj.html', '', '', '8288ce0f-3665-11e7-ac63-e09467f6dff0', '2017-05-12 00:18:47', '0');
INSERT INTO `data_job_template_49` VALUES ('', '', '', '828b8d30-3665-11e7-b867-e09467f6dff0', '2017-05-12 00:18:47', '0');
INSERT INTO `data_job_template_49` VALUES ('', '', '', '828e2540-3665-11e7-a903-e09467f6dff0', '2017-05-12 00:18:47', '0');
INSERT INTO `data_job_template_49` VALUES ('', '刺客信条', '', '82913280-3665-11e7-a89e-e09467f6dff0', '2017-05-12 00:18:47', '0');
INSERT INTO `data_job_template_49` VALUES ('', '刺客信条', '', '8293f1a1-3665-11e7-a10b-e09467f6dff0', '2017-05-12 00:18:47', '0');
INSERT INTO `data_job_template_49` VALUES ('', '刺客信条', '', '829662a1-3665-11e7-8667-e09467f6dff0', '2017-05-12 00:18:47', '0');
INSERT INTO `data_job_template_49` VALUES ('', '刺客信条', '', '8298fab0-3665-11e7-9f32-e09467f6dff0', '2017-05-12 00:18:47', '0');
INSERT INTO `data_job_template_49` VALUES ('', '刺客信条', '', '829bb9cf-3665-11e7-9e0c-e09467f6dff0', '2017-05-12 00:18:47', '0');
INSERT INTO `data_job_template_49` VALUES ('', '刺客信条', '', '829e51e1-3665-11e7-8349-e09467f6dff0', '2017-05-12 00:18:47', '0');
INSERT INTO `data_job_template_49` VALUES ('', '刺客信条', '', '82a11100-3665-11e7-9da1-e09467f6dff0', '2017-05-12 00:18:47', '0');
INSERT INTO `data_job_template_49` VALUES ('', '刺客信条', '', '82a3d021-3665-11e7-967c-e09467f6dff0', '2017-05-12 00:18:47', '0');
INSERT INTO `data_job_template_49` VALUES ('', '刺客信条', '', '82a68f40-3665-11e7-82ff-e09467f6dff0', '2017-05-12 00:18:47', '0');
INSERT INTO `data_job_template_49` VALUES ('', '刺客信条', '', '82a94e61-3665-11e7-abea-e09467f6dff0', '2017-05-12 00:18:47', '0');
INSERT INTO `data_job_template_49` VALUES ('', '刺客信条', '', '82ac5ba1-3665-11e7-bfe7-e09467f6dff0', '2017-05-12 00:18:47', '0');
INSERT INTO `data_job_template_49` VALUES ('http://v.qq.com/detail/y/yz4vl2g8sma0zuu.html', '', '', '88564e40-365f-11e7-8a54-e09467f6dff0', '2017-05-11 23:35:59', '0');
INSERT INTO `data_job_template_49` VALUES ('http://v.qq.com/detail/t/tlqma6dqnaailbj.html', '', '', '885abb0f-365f-11e7-b5dd-e09467f6dff0', '2017-05-11 23:35:59', '0');
INSERT INTO `data_job_template_49` VALUES ('', '', '', '885d0500-365f-11e7-85cc-e09467f6dff0', '2017-05-11 23:35:59', '0');
INSERT INTO `data_job_template_49` VALUES ('', '', '', '885f00d1-365f-11e7-b335-e09467f6dff0', '2017-05-11 23:35:59', '0');
INSERT INTO `data_job_template_49` VALUES ('', '刺客信条', '', '886198e1-365f-11e7-8472-e09467f6dff0', '2017-05-11 23:35:59', '0');
INSERT INTO `data_job_template_49` VALUES ('', '刺客信条', '', '88645800-365f-11e7-b874-e09467f6dff0', '2017-05-11 23:35:59', '0');
INSERT INTO `data_job_template_49` VALUES ('', '刺客信条', '', '88676540-365f-11e7-b07c-e09467f6dff0', '2017-05-11 23:35:59', '0');
INSERT INTO `data_job_template_49` VALUES ('', '刺客信条', '', '886ac09e-365f-11e7-83be-e09467f6dff0', '2017-05-11 23:35:59', '0');
INSERT INTO `data_job_template_49` VALUES ('', '刺客信条', '', '886e1c00-365f-11e7-8195-e09467f6dff0', '2017-05-11 23:35:59', '0');
INSERT INTO `data_job_template_49` VALUES ('', '刺客信条', '', '88719e70-365f-11e7-9c29-e09467f6dff0', '2017-05-11 23:35:59', '0');
INSERT INTO `data_job_template_49` VALUES ('', '刺客信条', '', '887b6270-365f-11e7-a833-e09467f6dff0', '2017-05-11 23:35:59', '0');
INSERT INTO `data_job_template_49` VALUES ('', '刺客信条', '', '887ee4de-365f-11e7-b31e-e09467f6dff0', '2017-05-11 23:35:59', '0');
INSERT INTO `data_job_template_49` VALUES ('', '刺客信条', '', '8883038f-365f-11e7-b36c-e09467f6dff0', '2017-05-11 23:35:59', '0');
INSERT INTO `data_job_template_49` VALUES ('', '刺客信条', '', '888637e1-365f-11e7-87bd-e09467f6dff0', '2017-05-11 23:35:59', '0');
INSERT INTO `data_job_template_49` VALUES ('', '刺客信条', '', '88899340-365f-11e7-8b46-e09467f6dff0', '2017-05-11 23:35:59', '0');
INSERT INTO `data_job_template_49` VALUES ('http://v.qq.com/x/cover/yz4vl2g8sma0zuu.html', '', '', '9dc18a00-365b-11e7-895d-e09467f6dff0', '2017-05-11 23:07:57', '0');
INSERT INTO `data_job_template_49` VALUES ('', '刺客信条', '', '9dc72f4f-365b-11e7-8a7a-e09467f6dff0', '2017-05-11 23:07:57', '0');
INSERT INTO `data_job_template_49` VALUES ('http://v.qq.com/detail/t/tlqma6dqnaailbj.html', '', '', '9dcbc330-365b-11e7-ab76-e09467f6dff0', '2017-05-11 23:07:57', '0');
INSERT INTO `data_job_template_49` VALUES ('', '刺客信条', '', '9dcf45a1-365b-11e7-acad-e09467f6dff0', '2017-05-11 23:07:57', '0');
INSERT INTO `data_job_template_49` VALUES ('', '刺客信条', '', '9dd252e1-365b-11e7-b935-e09467f6dff0', '2017-05-11 23:07:57', '0');
INSERT INTO `data_job_template_49` VALUES ('', '刺客信条', '', '9dd4c3e1-365b-11e7-91fd-e09467f6dff0', '2017-05-11 23:07:57', '0');
INSERT INTO `data_job_template_49` VALUES ('', '刺客信条', '', '9dd78300-365b-11e7-a66f-e09467f6dff0', '2017-05-11 23:07:57', '0');
INSERT INTO `data_job_template_49` VALUES ('', '刺客信条', '', '9dda4221-365b-11e7-89f3-e09467f6dff0', '2017-05-11 23:07:57', '0');
INSERT INTO `data_job_template_49` VALUES ('', '刺客信条', '', '9ddd4f61-365b-11e7-bf9d-e09467f6dff0', '2017-05-11 23:07:57', '0');
INSERT INTO `data_job_template_49` VALUES ('', '刺客信条', '', '9de0d1cf-365b-11e7-b495-e09467f6dff0', '2017-05-11 23:07:57', '0');
INSERT INTO `data_job_template_49` VALUES ('', '刺客信条', '', '9de3df0f-365b-11e7-8303-e09467f6dff0', '2017-05-11 23:07:57', '0');
INSERT INTO `data_job_template_49` VALUES ('', '刺客信条', '', '9de6ec4f-365b-11e7-a070-e09467f6dff0', '2017-05-11 23:07:57', '0');
INSERT INTO `data_job_template_49` VALUES ('', '刺客信条', '', '9de9845e-365b-11e7-ad01-e09467f6dff0', '2017-05-11 23:07:57', '0');
INSERT INTO `data_job_template_49` VALUES ('', '刺客信条', '', '9dec1c6e-365b-11e7-a5aa-e09467f6dff0', '2017-05-11 23:07:57', '0');
INSERT INTO `data_job_template_49` VALUES ('', '刺客信条', '', '9deedb8f-365b-11e7-a7f1-e09467f6dff0', '2017-05-11 23:07:57', '0');
INSERT INTO `data_job_template_49` VALUES ('http://v.qq.com/detail/y/yz4vl2g8sma0zuu.html', '', '', 'a098da00-3668-11e7-93df-e09467f6dff0', '2017-05-12 00:41:05', '0');
INSERT INTO `data_job_template_49` VALUES ('http://v.qq.com/detail/t/tlqma6dqnaailbj.html', '', '', 'a09d46cf-3668-11e7-93a3-e09467f6dff0', '2017-05-12 00:41:05', '0');
INSERT INTO `data_job_template_49` VALUES ('', '', '', 'a09fdee1-3668-11e7-9603-e09467f6dff0', '2017-05-12 00:41:05', '0');
INSERT INTO `data_job_template_49` VALUES ('', '', '', 'a0a228cf-3668-11e7-8353-e09467f6dff0', '2017-05-12 00:41:05', '0');
INSERT INTO `data_job_template_49` VALUES ('', '刺客信条', '', 'a0a4249e-3668-11e7-9bab-e09467f6dff0', '2017-05-12 00:41:05', '0');
INSERT INTO `data_job_template_49` VALUES ('', '刺客信条', '', 'a0a66e91-3668-11e7-8867-e09467f6dff0', '2017-05-12 00:41:05', '0');
INSERT INTO `data_job_template_49` VALUES ('', '刺客信条', '', 'a0a89170-3668-11e7-bcb1-e09467f6dff0', '2017-05-12 00:41:05', '0');
INSERT INTO `data_job_template_49` VALUES ('', '刺客信条', '', 'a0ab508f-3668-11e7-8390-e09467f6dff0', '2017-05-12 00:41:05', '0');
INSERT INTO `data_job_template_49` VALUES ('', '刺客信条', '', 'a0ae36c0-3668-11e7-8f2a-e09467f6dff0', '2017-05-12 00:41:06', '0');
INSERT INTO `data_job_template_49` VALUES ('', '刺客信条', '', 'a0b14400-3668-11e7-a7cd-e09467f6dff0', '2017-05-12 00:41:06', '0');
INSERT INTO `data_job_template_49` VALUES ('', '刺客信条', '', 'a0b40321-3668-11e7-927e-e09467f6dff0', '2017-05-12 00:41:06', '0');
INSERT INTO `data_job_template_49` VALUES ('', '刺客信条', '', 'a0b6c240-3668-11e7-8380-e09467f6dff0', '2017-05-12 00:41:06', '0');
INSERT INTO `data_job_template_49` VALUES ('', '刺客信条', '', 'a0b95a4f-3668-11e7-ab94-e09467f6dff0', '2017-05-12 00:41:06', '0');
INSERT INTO `data_job_template_49` VALUES ('', '刺客信条', '', 'a0bbf261-3668-11e7-afcb-e09467f6dff0', '2017-05-12 00:41:06', '0');
INSERT INTO `data_job_template_49` VALUES ('', '刺客信条', '', 'a0bed88f-3668-11e7-af08-e09467f6dff0', '2017-05-12 00:41:06', '0');
INSERT INTO `data_job_template_49` VALUES ('http://v.qq.com/detail/y/yz4vl2g8sma0zuu.html', '', '', 'a58a8b0f-3660-11e7-b948-e09467f6dff0', '2017-05-11 23:43:58', '0');
INSERT INTO `data_job_template_49` VALUES ('', '刺客信条', '', 'a58ea9c0-3660-11e7-ad56-e09467f6dff0', '2017-05-11 23:43:58', '0');
INSERT INTO `data_job_template_49` VALUES ('http://v.qq.com/detail/t/tlqma6dqnaailbj.html', '', '', 'a591b700-3660-11e7-a0f9-e09467f6dff0', '2017-05-11 23:43:58', '0');
INSERT INTO `data_job_template_49` VALUES ('', '刺客信条', '', 'a5949d30-3660-11e7-abb4-e09467f6dff0', '2017-05-11 23:43:58', '0');
INSERT INTO `data_job_template_49` VALUES ('', '刺客信条', '', 'a596e721-3660-11e7-83f6-e09467f6dff0', '2017-05-11 23:43:58', '0');
INSERT INTO `data_job_template_49` VALUES ('', '刺客信条', '', 'a599310f-3660-11e7-bd2c-e09467f6dff0', '2017-05-11 23:43:58', '0');
INSERT INTO `data_job_template_49` VALUES ('', '刺客信条', '', 'a59b7b00-3660-11e7-88f3-e09467f6dff0', '2017-05-11 23:43:58', '0');
INSERT INTO `data_job_template_49` VALUES ('', '刺客信条', '', 'a59e3a1e-3660-11e7-af00-e09467f6dff0', '2017-05-11 23:43:58', '0');
INSERT INTO `data_job_template_49` VALUES ('', '刺客信条', '', 'a5a0d230-3660-11e7-84e4-e09467f6dff0', '2017-05-11 23:43:58', '0');
INSERT INTO `data_job_template_49` VALUES ('', '刺客信条', '', 'a5a36a40-3660-11e7-a0e4-e09467f6dff0', '2017-05-11 23:43:58', '0');
INSERT INTO `data_job_template_49` VALUES ('', '刺客信条', '', 'a5a58d21-3660-11e7-b3fd-e09467f6dff0', '2017-05-11 23:43:58', '0');
INSERT INTO `data_job_template_49` VALUES ('', '刺客信条', '', 'a5a788f0-3660-11e7-b406-e09467f6dff0', '2017-05-11 23:43:58', '0');
INSERT INTO `data_job_template_49` VALUES ('', '刺客信条', '', 'a5a984c0-3660-11e7-8390-e09467f6dff0', '2017-05-11 23:43:58', '0');
INSERT INTO `data_job_template_49` VALUES ('', '刺客信条', '', 'a5abceae-3660-11e7-9856-e09467f6dff0', '2017-05-11 23:43:58', '0');
INSERT INTO `data_job_template_49` VALUES ('', '刺客信条', '', 'a5c32740-3660-11e7-895f-e09467f6dff0', '2017-05-11 23:43:58', '0');
INSERT INTO `data_job_template_49` VALUES ('http://v.qq.com/x/cover/yz4vl2g8sma0zuu.html', '', '', 'b1c1c740-365b-11e7-8abe-e09467f6dff0', '2017-05-11 23:09:07', '0');
INSERT INTO `data_job_template_49` VALUES ('', '刺客信条', '', 'c7061d40-365b-11e7-81f7-e09467f6dff0', '2017-05-11 23:09:07', '0');
INSERT INTO `data_job_template_49` VALUES ('http://v.qq.com/detail/t/tlqma6dqnaailbj.html', '', '', 'c708dc61-365b-11e7-a0aa-e09467f6dff0', '2017-05-11 23:09:07', '0');
INSERT INTO `data_job_template_49` VALUES ('', '刺客信条', '', 'c70b7470-365b-11e7-8726-e09467f6dff0', '2017-05-11 23:09:07', '0');
INSERT INTO `data_job_template_49` VALUES ('', '刺客信条', '', 'c70e0c80-365b-11e7-b199-e09467f6dff0', '2017-05-11 23:09:07', '0');
INSERT INTO `data_job_template_49` VALUES ('', '刺客信条', '', 'c7118ef0-365b-11e7-a3f8-e09467f6dff0', '2017-05-11 23:09:07', '0');
INSERT INTO `data_job_template_49` VALUES ('', '刺客信条', '', 'c715115e-365b-11e7-a76d-e09467f6dff0', '2017-05-11 23:09:07', '0');
INSERT INTO `data_job_template_49` VALUES ('', '刺客信条', '', 'c71845ae-365b-11e7-ab7d-e09467f6dff0', '2017-05-11 23:09:07', '0');
INSERT INTO `data_job_template_49` VALUES ('', '刺客信条', '', 'c71b7a00-365b-11e7-952a-e09467f6dff0', '2017-05-11 23:09:07', '0');
INSERT INTO `data_job_template_49` VALUES ('', '刺客信条', '', 'c71f98b0-365b-11e7-99fe-e09467f6dff0', '2017-05-11 23:09:07', '0');
INSERT INTO `data_job_template_49` VALUES ('', '刺客信条', '', 'c723904f-365b-11e7-88f3-e09467f6dff0', '2017-05-11 23:09:07', '0');
INSERT INTO `data_job_template_49` VALUES ('', '刺客信条', '', 'c72760e1-365b-11e7-8466-e09467f6dff0', '2017-05-11 23:09:07', '0');
INSERT INTO `data_job_template_49` VALUES ('', '刺客信条', '', 'c72abc40-365b-11e7-a321-e09467f6dff0', '2017-05-11 23:09:07', '0');
INSERT INTO `data_job_template_49` VALUES ('', '刺客信条', '', 'c72da270-365b-11e7-9c77-e09467f6dff0', '2017-05-11 23:09:07', '0');
INSERT INTO `data_job_template_49` VALUES ('', '刺客信条', '', 'c730618f-365b-11e7-84c1-e09467f6dff0', '2017-05-11 23:09:07', '0');
INSERT INTO `data_job_template_49` VALUES ('http://v.qq.com/detail/t/tlqma6dqnaailbj.html', '', '', 'cd613340-365c-11e7-9a5d-e09467f6dff0', '2017-05-11 23:16:43', '0');
INSERT INTO `data_job_template_49` VALUES ('http://v.qq.com/detail/5/56953.html', '', '', 'd6e4a7cf-365c-11e7-872d-e09467f6dff0', '2017-05-11 23:16:43', '0');
INSERT INTO `data_job_template_49` VALUES ('http://v.qq.com/detail/6/63929.html', '', '', 'd6e6caae-365c-11e7-b7db-e09467f6dff0', '2017-05-11 23:16:43', '0');
INSERT INTO `data_job_template_49` VALUES ('', '刺客信条', '', 'd6e87861-365c-11e7-9919-e09467f6dff0', '2017-05-11 23:16:43', '0');
INSERT INTO `data_job_template_49` VALUES ('', '刺客信条', '', 'd6ea7430-365c-11e7-851f-e09467f6dff0', '2017-05-11 23:16:43', '0');
INSERT INTO `data_job_template_49` VALUES ('', '刺客信条', '', 'd6ec7000-365c-11e7-adcb-e09467f6dff0', '2017-05-11 23:16:43', '0');
INSERT INTO `data_job_template_49` VALUES ('', '刺客信条', '', 'd6ee44c0-365c-11e7-9cc6-e09467f6dff0', '2017-05-11 23:16:43', '0');
INSERT INTO `data_job_template_49` VALUES ('', '刺客信条', '', 'd6f0679e-365c-11e7-8823-e09467f6dff0', '2017-05-11 23:16:43', '0');
INSERT INTO `data_job_template_49` VALUES ('', '刺客信条', '', 'd701a5b0-365c-11e7-a86d-e09467f6dff0', '2017-05-11 23:16:43', '0');
INSERT INTO `data_job_template_49` VALUES ('', '刺客信条', '', 'd705010f-365c-11e7-a872-e09467f6dff0', '2017-05-11 23:16:43', '0');
INSERT INTO `data_job_template_49` VALUES ('', '刺客信条', '', 'd7083561-365c-11e7-afd9-e09467f6dff0', '2017-05-11 23:16:43', '0');
INSERT INTO `data_job_template_49` VALUES ('', '刺客信条', '', 'd70af480-365c-11e7-969e-e09467f6dff0', '2017-05-11 23:16:43', '0');
INSERT INTO `data_job_template_49` VALUES ('', '刺客信条', '', 'd70d6580-365c-11e7-9828-e09467f6dff0', '2017-05-11 23:16:43', '0');
INSERT INTO `data_job_template_49` VALUES ('', '刺客信条', '', 'd70fd680-365c-11e7-8719-e09467f6dff0', '2017-05-11 23:16:43', '0');
INSERT INTO `data_job_template_49` VALUES ('http://v.qq.com/detail/y/yz4vl2g8sma0zuu.html', '', '', 'e26aa64f-3660-11e7-a39f-e09467f6dff0', '2017-05-11 23:45:40', '0');
INSERT INTO `data_job_template_49` VALUES ('', '刺客信条', '', 'e26f131e-3660-11e7-856b-e09467f6dff0', '2017-05-11 23:45:40', '0');
INSERT INTO `data_job_template_49` VALUES ('', '刺客信条', '', 'e271ab2e-3660-11e7-81cb-e09467f6dff0', '2017-05-11 23:45:40', '0');
INSERT INTO `data_job_template_49` VALUES ('http://v.qq.com/detail/t/tlqma6dqnaailbj.html', '', '', 'e2741c30-3660-11e7-a226-e09467f6dff0', '2017-05-11 23:45:40', '0');
INSERT INTO `data_job_template_49` VALUES ('', '刺客信条', '', 'e2766621-3660-11e7-a5bd-e09467f6dff0', '2017-05-11 23:45:40', '0');
INSERT INTO `data_job_template_49` VALUES ('', '刺客信条', '', 'e278d721-3660-11e7-a376-e09467f6dff0', '2017-05-11 23:45:40', '0');
INSERT INTO `data_job_template_49` VALUES ('', '刺客信条', '', 'e27b210f-3660-11e7-aa50-e09467f6dff0', '2017-05-11 23:45:40', '0');
INSERT INTO `data_job_template_49` VALUES ('', '刺客信条', '', 'e27d920f-3660-11e7-8715-e09467f6dff0', '2017-05-11 23:45:40', '0');
INSERT INTO `data_job_template_49` VALUES ('', '刺客信条', '', 'e27fdc00-3660-11e7-a7ee-e09467f6dff0', '2017-05-11 23:45:40', '0');
INSERT INTO `data_job_template_49` VALUES ('', '刺客信条', '', 'e281fee1-3660-11e7-a9a3-e09467f6dff0', '2017-05-11 23:45:40', '0');
INSERT INTO `data_job_template_49` VALUES ('', '刺客信条', '', 'e28448cf-3660-11e7-8ce1-e09467f6dff0', '2017-05-11 23:45:40', '0');
INSERT INTO `data_job_template_49` VALUES ('', '刺客信条', '', 'e2866bb0-3660-11e7-86b5-e09467f6dff0', '2017-05-11 23:45:40', '0');
INSERT INTO `data_job_template_49` VALUES ('', '刺客信条', '', 'e2886780-3660-11e7-8642-e09467f6dff0', '2017-05-11 23:45:40', '0');
INSERT INTO `data_job_template_49` VALUES ('', '刺客信条', '', 'e28ad880-3660-11e7-ae3e-e09467f6dff0', '2017-05-11 23:45:40', '0');
INSERT INTO `data_job_template_49` VALUES ('', '刺客信条', '', 'e28d7091-3660-11e7-974d-e09467f6dff0', '2017-05-11 23:45:40', '0');
INSERT INTO `data_job_template_49` VALUES ('http://v.qq.com/detail/y/yz4vl2g8sma0zuu.html', '', '', 'f0ba6bd1-3667-11e7-abef-e09467f6dff0', '2017-05-12 00:36:10', '0');
INSERT INTO `data_job_template_49` VALUES ('http://v.qq.com/detail/t/tlqma6dqnaailbj.html', '', '', 'f0bdee40-3667-11e7-8235-e09467f6dff0', '2017-05-12 00:36:10', '0');
INSERT INTO `data_job_template_49` VALUES ('', '', '', 'f0c0864f-3667-11e7-baba-e09467f6dff0', '2017-05-12 00:36:10', '0');
INSERT INTO `data_job_template_49` VALUES ('', '', '', 'f0c2d040-3667-11e7-a208-e09467f6dff0', '2017-05-12 00:36:10', '0');
INSERT INTO `data_job_template_49` VALUES ('', '刺客信条', '', 'f0c51a30-3667-11e7-81d4-e09467f6dff0', '2017-05-12 00:36:10', '0');
INSERT INTO `data_job_template_49` VALUES ('', '刺客信条', '', 'f0c80061-3667-11e7-ae90-e09467f6dff0', '2017-05-12 00:36:10', '0');
INSERT INTO `data_job_template_49` VALUES ('', '刺客信条', '', 'f0ca7161-3667-11e7-9786-e09467f6dff0', '2017-05-12 00:36:10', '0');
INSERT INTO `data_job_template_49` VALUES ('', '刺客信条', '', 'f0ccbb4f-3667-11e7-951f-e09467f6dff0', '2017-05-12 00:36:10', '0');
INSERT INTO `data_job_template_49` VALUES ('', '刺客信条', '', 'f0ceb71e-3667-11e7-987f-e09467f6dff0', '2017-05-12 00:36:10', '0');
INSERT INTO `data_job_template_49` VALUES ('', '刺客信条', '', 'f0d0da00-3667-11e7-9078-e09467f6dff0', '2017-05-12 00:36:10', '0');
INSERT INTO `data_job_template_49` VALUES ('', '刺客信条', '', 'f0d323f0-3667-11e7-8a1c-e09467f6dff0', '2017-05-12 00:36:10', '0');
INSERT INTO `data_job_template_49` VALUES ('', '刺客信条', '', 'f0d594f0-3667-11e7-8a5e-e09467f6dff0', '2017-05-12 00:36:10', '0');
INSERT INTO `data_job_template_49` VALUES ('', '刺客信条', '', 'f0d8c940-3667-11e7-8559-e09467f6dff0', '2017-05-12 00:36:10', '0');
INSERT INTO `data_job_template_49` VALUES ('', '刺客信条', '', 'f0db3a40-3667-11e7-bb6d-e09467f6dff0', '2017-05-12 00:36:10', '0');
INSERT INTO `data_job_template_49` VALUES ('', '刺客信条', '', 'f0de4780-3667-11e7-b482-e09467f6dff0', '2017-05-12 00:36:10', '0');
INSERT INTO `data_job_template_49` VALUES ('http://v.qq.com/x/cover/yz4vl2g8sma0zuu.html', '', '', 'f154cd80-365b-11e7-a26a-e09467f6dff0', '2017-05-11 23:10:17', '0');
INSERT INTO `data_job_template_49` VALUES ('http://v.qq.com/detail/t/tlqma6dqnaailbj.html', '', '', 'f1593a4f-365b-11e7-9886-e09467f6dff0', '2017-05-11 23:10:17', '0');
INSERT INTO `data_job_template_49` VALUES ('http://v.qq.com/detail/5/56953.html', '', '', 'f15c478f-365b-11e7-a4e3-e09467f6dff0', '2017-05-11 23:10:17', '0');
INSERT INTO `data_job_template_49` VALUES ('http://v.qq.com/detail/6/63929.html', '', '', 'f15eb88f-365b-11e7-a8bd-e09467f6dff0', '2017-05-11 23:10:17', '0');
INSERT INTO `data_job_template_49` VALUES ('', '刺客信条', '', 'f1610280-365b-11e7-8082-e09467f6dff0', '2017-05-11 23:10:17', '0');
INSERT INTO `data_job_template_49` VALUES ('', '刺客信条', '', 'f1639a91-365b-11e7-9872-e09467f6dff0', '2017-05-11 23:10:17', '0');
INSERT INTO `data_job_template_49` VALUES ('', '刺客信条', '', 'f166a7d1-365b-11e7-ab93-e09467f6dff0', '2017-05-11 23:10:17', '0');
INSERT INTO `data_job_template_49` VALUES ('', '刺客信条', '', 'f16966f0-365b-11e7-848d-e09467f6dff0', '2017-05-11 23:10:17', '0');
INSERT INTO `data_job_template_49` VALUES ('', '刺客信条', '', 'f16bd7f0-365b-11e7-af35-e09467f6dff0', '2017-05-11 23:10:17', '0');
INSERT INTO `data_job_template_49` VALUES ('', '刺客信条', '', 'f16e21e1-365b-11e7-a3cc-e09467f6dff0', '2017-05-11 23:10:17', '0');
INSERT INTO `data_job_template_49` VALUES ('', '刺客信条', '', 'f170b9f0-365b-11e7-a4c1-e09467f6dff0', '2017-05-11 23:10:17', '0');
INSERT INTO `data_job_template_49` VALUES ('', '刺客信条', '', 'f173a021-365b-11e7-95e6-e09467f6dff0', '2017-05-11 23:10:17', '0');
INSERT INTO `data_job_template_49` VALUES ('', '刺客信条', '', 'f1772291-365b-11e7-bcc9-e09467f6dff0', '2017-05-11 23:10:17', '0');
INSERT INTO `data_job_template_49` VALUES ('', '刺客信条', '', 'f17a56e1-365b-11e7-8ecd-e09467f6dff0', '2017-05-11 23:10:17', '0');
INSERT INTO `data_job_template_49` VALUES ('', '刺客信条', '', 'f17d8b2e-365b-11e7-a118-e09467f6dff0', '2017-05-11 23:10:17', '0');
INSERT INTO `data_job_template_49` VALUES ('http://v.qq.com/detail/y/yz4vl2g8sma0zuu.html', '', '', 'f31a5c30-3664-11e7-b0d4-e09467f6dff0', '2017-05-12 00:14:46', '0');
INSERT INTO `data_job_template_49` VALUES ('', '刺客信条', '', 'f31e2cc0-3664-11e7-b297-e09467f6dff0', '2017-05-12 00:14:46', '0');
INSERT INTO `data_job_template_49` VALUES ('', '刺客信条', '', 'f321610f-3664-11e7-98ff-e09467f6dff0', '2017-05-12 00:14:46', '0');
INSERT INTO `data_job_template_49` VALUES ('http://v.qq.com/detail/t/tlqma6dqnaailbj.html', '', '', 'f324955e-3664-11e7-a845-e09467f6dff0', '2017-05-12 00:14:46', '0');
INSERT INTO `data_job_template_49` VALUES ('', '刺客信条', '', 'f327a29e-3664-11e7-8238-e09467f6dff0', '2017-05-12 00:14:46', '0');
INSERT INTO `data_job_template_49` VALUES ('', '刺客信条', '', 'f32bc14f-3664-11e7-afe7-e09467f6dff0', '2017-05-12 00:14:46', '0');
INSERT INTO `data_job_template_49` VALUES ('', '刺客信条', '', 'f32f43c0-3664-11e7-9f55-e09467f6dff0', '2017-05-12 00:14:46', '0');
INSERT INTO `data_job_template_49` VALUES ('', '刺客信条', '', 'f333144f-3664-11e7-8c6e-e09467f6dff0', '2017-05-12 00:14:46', '0');
INSERT INTO `data_job_template_49` VALUES ('', '刺客信条', '', 'f336489e-3664-11e7-88c0-e09467f6dff0', '2017-05-12 00:14:46', '0');
INSERT INTO `data_job_template_49` VALUES ('', '刺客信条', '', 'f33a1930-3664-11e7-86ea-e09467f6dff0', '2017-05-12 00:14:46', '0');
INSERT INTO `data_job_template_49` VALUES ('', '刺客信条', '', 'f33e37de-3664-11e7-a969-e09467f6dff0', '2017-05-12 00:14:46', '0');
INSERT INTO `data_job_template_49` VALUES ('', '刺客信条', '', 'f3419340-3664-11e7-8f32-e09467f6dff0', '2017-05-12 00:14:46', '0');
INSERT INTO `data_job_template_49` VALUES ('', '刺客信条', '', 'f344c78f-3664-11e7-adbe-e09467f6dff0', '2017-05-12 00:14:46', '0');
INSERT INTO `data_job_template_49` VALUES ('', '刺客信条', '', 'f34822f0-3664-11e7-88a7-e09467f6dff0', '2017-05-12 00:14:46', '0');
INSERT INTO `data_job_template_49` VALUES ('', '刺客信条', '', 'f3547f00-3664-11e7-9fb8-e09467f6dff0', '2017-05-12 00:14:46', '0');

-- ----------------------------
-- Table structure for data_job_template_5
-- ----------------------------
DROP TABLE IF EXISTS `data_job_template_5`;
CREATE TABLE `data_job_template_5` (
  `movieName` varchar(1024) DEFAULT NULL,
  `movieTime` varchar(1024) DEFAULT NULL,
  `movieDirector` varchar(1024) DEFAULT NULL,
  `id` varchar(50) NOT NULL,
  `task_job_create_time` datetime DEFAULT NULL,
  `task_job_del_flag` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of data_job_template_5
-- ----------------------------
INSERT INTO `data_job_template_5` VALUES ('刺客信条：血系(2009)', '时 间 ：2013-10-07 00:10:06', '导 演 ：明星', 'd233dbe1-365a-11e7-8dc6-e09467f6dff0', '2017-05-11 23:02:15', '0');
INSERT INTO `data_job_template_5` VALUES ('刺客信条2[真人版](2011)', '时 间 ：2013-10-07 00:10:17', '导 演 ：明星', 'd2487551-365a-11e7-b5dd-e09467f6dff0', '2017-05-11 23:02:16', '0');
INSERT INTO `data_job_template_5` VALUES ('刺客信条2[真人版](2011)', '时 间 ：2013-10-07 00:10:17', '导 演 ：明星', 'd2551f80-365a-11e7-807c-e09467f6dff0', '2017-05-11 23:02:16', '0');
INSERT INTO `data_job_template_5` VALUES ('刺客信条权势(2010)', '时 间 ：2015-04-25 10:04:29', '导 演 ：LaurentBernier', 'd26d1451-365a-11e7-8fc7-e09467f6dff0', '2017-05-11 23:02:16', '0');
INSERT INTO `data_job_template_5` VALUES ('刺客信条权势(2010)', '时 间 ：2015-04-25 10:04:29', '导 演 ：LaurentBernier', 'd27810d1-365a-11e7-a77c-e09467f6dff0', '2017-05-11 23:02:16', '0');
INSERT INTO `data_job_template_5` VALUES ('刺客信条权势(2010)', '时 间 ：2015-04-25 10:04:29', '导 演 ：LaurentBernier', 'd283a991-365a-11e7-bd4d-e09467f6dff0', '2017-05-11 23:02:16', '0');
INSERT INTO `data_job_template_5` VALUES ('刺客信条权势(2010)', '时 间 ：2015-04-25 10:04:29', '导 演 ：LaurentBernier', 'd28fde8f-365a-11e7-8e21-e09467f6dff0', '2017-05-11 23:02:16', '0');
INSERT INTO `data_job_template_5` VALUES ('刺客信条权势(2010)', '时 间 ：2015-04-25 10:04:29', '导 演 ：LaurentBernier', 'd29f20cf-365a-11e7-8a41-e09467f6dff0', '2017-05-11 23:02:16', '0');
INSERT INTO `data_job_template_5` VALUES ('刺客信条：余烬(2000)', '时 间 ：2013-10-03 21:10:42', '导 演 ：Laurent,Bernier', 'd419169e-365a-11e7-85cc-e09467f6dff0', '2017-05-11 23:02:19', '0');
INSERT INTO `data_job_template_5` VALUES ('刺客信条余烬(2011)', '时 间 ：2015-04-25 10:04:28', '导 演 ：LaurentBernier', 'de8130c0-3658-11e7-b4fd-e09467f6dff0', '2017-05-11 22:48:17', '0');
INSERT INTO `data_job_template_5` VALUES ('刺客信条权势(2010)', '时 间 ：2015-04-25 10:04:29', '导 演 ：LaurentBernier', 'de9afa4f-3658-11e7-9f18-e09467f6dff0', '2017-05-11 22:48:17', '0');
INSERT INTO `data_job_template_5` VALUES ('刺客信条：权势(2000)', '时 间 ：2013-10-04 02:10:01', '导 演 ：Laurent,Bernier', 'dec6c540-3658-11e7-ae5a-e09467f6dff0', '2017-05-11 22:48:18', '0');
INSERT INTO `data_job_template_5` VALUES ('刺客信条(2017)', '时 间 ：2017-02-21 18:02:50', '导 演 ：贾斯汀·库泽尔', 'deffd69e-3658-11e7-96e8-e09467f6dff0', '2017-05-11 22:48:18', '0');
INSERT INTO `data_job_template_5` VALUES ('刺客信条(2017)', '时 间 ：2017-02-21 18:02:50', '导 演 ：贾斯汀·库泽尔', 'df131080-3658-11e7-90d0-e09467f6dff0', '2017-05-11 22:48:18', '0');
INSERT INTO `data_job_template_5` VALUES ('刺客信条(2017)', '时 间 ：2017-02-21 18:02:50', '导 演 ：贾斯汀·库泽尔', 'df24006e-3658-11e7-887d-e09467f6dff0', '2017-05-11 22:48:18', '0');
INSERT INTO `data_job_template_5` VALUES ('刺客信条(2017)', '时 间 ：2017-02-21 18:02:50', '导 演 ：贾斯汀·库泽尔', 'df3146e1-3658-11e7-b63b-e09467f6dff0', '2017-05-11 22:48:18', '0');
INSERT INTO `data_job_template_5` VALUES ('刺客信条(2017)', '时 间 ：2017-02-21 18:02:50', '导 演 ：贾斯汀·库泽尔', 'df3e8d4f-3658-11e7-a197-e09467f6dff0', '2017-05-11 22:48:18', '0');
INSERT INTO `data_job_template_5` VALUES ('刺客信条：余烬(2000)', '时 间 ：2013-10-03 21:10:42', '导 演 ：Laurent,Bernier', 'dfc3269e-3658-11e7-9b9f-e09467f6dff0', '2017-05-11 22:48:19', '0');
INSERT INTO `data_job_template_5` VALUES ('刺客信条(2017)', '时 间 ：2017-02-21 18:02:50', '导 演 ：贾斯汀·库泽尔', 'eddb0cde-3657-11e7-92e4-e09467f6dff0', '2017-05-11 22:41:33', '0');
INSERT INTO `data_job_template_5` VALUES ('刺客信条(2017)', '时 间 ：2017-02-21 18:02:50', '导 演 ：贾斯汀·库泽尔', 'ede5e24f-3657-11e7-8f38-e09467f6dff0', '2017-05-11 22:41:33', '0');

-- ----------------------------
-- Table structure for data_job_template_50
-- ----------------------------
DROP TABLE IF EXISTS `data_job_template_50`;
CREATE TABLE `data_job_template_50` (
  `url` varchar(1024) DEFAULT NULL,
  `id` varchar(50) NOT NULL,
  `task_job_create_time` datetime DEFAULT NULL,
  `task_job_del_flag` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of data_job_template_50
-- ----------------------------
INSERT INTO `data_job_template_50` VALUES ('http://gaoqing.la/assassins-creed.html', '7a5bf88f-3654-11e7-a41e-e09467f6dff0', '2017-05-11 22:16:51', '0');
INSERT INTO `data_job_template_50` VALUES ('http://gaoqing.la/assassins-creed.html', 'ac06c1cf-365a-11e7-b7e7-e09467f6dff0', '2017-05-11 23:01:11', '0');
INSERT INTO `data_job_template_50` VALUES ('http://gaoqing.la/assassins-creed.html', 'd83a4991-3658-11e7-81f6-e09467f6dff0', '2017-05-11 22:48:07', '0');

-- ----------------------------
-- Table structure for data_job_template_58
-- ----------------------------
DROP TABLE IF EXISTS `data_job_template_58`;
CREATE TABLE `data_job_template_58` (
  `movieTime` varchar(1024) DEFAULT NULL,
  `movieDiretor` varchar(1024) DEFAULT NULL,
  `movieName` varchar(1024) DEFAULT NULL,
  `id` varchar(50) NOT NULL,
  `task_job_create_time` datetime DEFAULT NULL,
  `task_job_del_flag` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of data_job_template_58
-- ----------------------------

-- ----------------------------
-- Table structure for db_source
-- ----------------------------
DROP TABLE IF EXISTS `db_source`;
CREATE TABLE `db_source` (
  `ID` varchar(50) NOT NULL,
  `DEL_FLAG` tinyint(1) DEFAULT '0',
  `HOST` varchar(200) DEFAULT NULL,
  `USERNAME` varchar(200) DEFAULT NULL,
  `PASSWORD` varchar(200) DEFAULT NULL,
  `DBNAME` varchar(200) DEFAULT NULL,
  `TYPE` varchar(200) DEFAULT NULL,
  `CHARSET` varchar(200) DEFAULT NULL,
  `PATH` varchar(200) DEFAULT NULL,
  `CREATE_TIME` datetime DEFAULT CURRENT_TIMESTAMP,
  `PORT` int(8) DEFAULT NULL,
  `URL` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of db_source
-- ----------------------------
INSERT INTO `db_source` VALUES ('1', '0', '127.0.0.1', 'root', '', 'new_crawler_db', 'mysql', 'utf-8', null, '2017-05-11 17:02:17', '3306', null);

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
INSERT INTO `job_template` VALUES ('03a29e86-3554-11e7-81ad-00232490c701', '0', null, '九酷音乐搜索到的第一个音乐信息', null, null, null, '//div[@id=\"searchInfo\"]//ul[@class=\"clearfix\"]/li[1]', 'data_job_template_1', 'http://baidu.9ku.com/song/{key}/', '-1', '1', '1', null, null);
INSERT INTO `job_template` VALUES ('05c6ae99-347c-11e7-81ad-00232490c701', '0', null, '成都海关违法走私信息总页数', null, null, null, '//div[@id=\"ess_ctr193672_ListC_Info_AspNetPager\"]//tr/td[1]', 'data_job_template_2', 'http://chengdu.customs.gov.cn/publish/portal130/tab70919/', '-1', '3', '1', null, null);
INSERT INTO `job_template` VALUES ('07059670-3577-11e7-81ad-00232490c701', '0', null, '芒仔音乐铺指定音乐的详情信息', null, null, null, '//div[@class=\"songAboutL\"]', 'data_job_template_3', '{songUrl}', 'ae78b7e4-3576-11e7-81ad-00232490c701', '1', '1', null, null);
INSERT INTO `job_template` VALUES ('072241de-34b6-11e7-b41d-0025ab9a7c2c', '0', null, '小说阅读网搜索', null, '2017-05-09 20:48:50', null, '//div[@id=\'result-list\']//li/div[@class=\'book-img-box\']', 'data_job_template_4', 'https://www.readnovel.com/search?kw={key}', '-1', '2', '1', null, null);
INSERT INTO `job_template` VALUES ('0a3b3e07-352e-11e7-947a-b8aeed2fe120', '1', null, '吉吉影音(爱上看电影)详情界面', null, '2017-05-10 11:09:30', null, '//div[@class=\'zhuyan\']', 'data_job_template_5', 'http://www.iskdy.com{url}', '65ade85c-3528-11e7-947a-b8aeed2fe120', '0', '1', null, null);
INSERT INTO `job_template` VALUES ('13d28677-d305-4803-9f97-10ea86a08acc', '0', null, '成都海关行政许可第一页列表', null, null, null, '//table[@id=\"ess_ctr193591_ModuleContent\"]//ul/li', 'data_job_template_6', 'http://chengdu.customs.gov.cn/publish/portal130/tab70899/', 'd2756997-06e9-419c-8a10-72f484f48fdc', '3', '1', null, null);
INSERT INTO `job_template` VALUES ('15aa0610-5b4b-4ea8-a355-51ce72d1693e', '0', null, '市安监局案件信息第一页列表', null, null, null, '//ul[@class=\"infoList03 f14\"]/li', 'data_job_template_7', 'http://www.cdsafety.gov.cn/index.php?m=content&c=index&a=lists&catid=109', '5b6ae8d4-77c8-48ac-af78-75b2fabd41da', '3', '1', null, null);
INSERT INTO `job_template` VALUES ('1e6ec3db-3545-11e7-97d9-0025ab9a7c2c', '0', null, '114详情页', null, '2017-05-10 13:54:11', null, '//div[@class=\'cont fl\']', 'data_job_template_8', '{url144}', 'b3bb56ae-3532-11e7-97d9-0025ab9a7c2c', '2', '1', null, null);
INSERT INTO `job_template` VALUES ('200f8193-35f8-11e7-81ad-00232490c701', '0', null, '成都出入境检验检疫局行政处罚第一页列表', null, null, null, '//div[@class=\"ftya_wrap\"]//tbody/tr[position()>=2]', 'data_job_template_9', 'http://www.scciq.gov.cn/xzcf/index.htm', '6cba3e48-3488-11e7-81ad-00232490c701', '3', '1', null, null);
INSERT INTO `job_template` VALUES ('236f8237-35fa-11e7-81ad-00232490c701', '0', null, '成都出入境检验检疫局行政处罚单页列表', null, null, null, '//div[@class=\"ftya_wrap\"]//tbody/tr[position()>=2]', 'data_job_template_10', 'http://www.scciq.gov.cn/xzcf/index_{pageIndex}.htm', '6cba3e48-3488-11e7-81ad-00232490c701', '3', '1', null, null);
INSERT INTO `job_template` VALUES ('2847be6c-3498-11e7-9285-0025ab9a7c2c', '0', null, '起点中文网搜索', null, '2017-05-09 16:51:24', null, '//div[@id=\'result-list\']//li[1]/div[@class=\'book-img-box\']', 'data_job_template_11', 'http://se.qidian.com/?kw={key}', '-1', '2', '1', null, null);
INSERT INTO `job_template` VALUES ('2f4f7d28-451d-4006-86ef-49b50872d458', '0', null, '市安监局案件信息单页列表', null, null, null, '//ul[@class=\"infoList03 f14\"]/li', 'data_job_template_12', 'http://www.cdsafety.gov.cn/index.php?m=content&c=index&a=lists&catid=109&page={pageIndex}', '5b6ae8d4-77c8-48ac-af78-75b2fabd41da', '3', '1', null, null);
INSERT INTO `job_template` VALUES ('39feb7d2-3530-11e7-947a-b8aeed2fe120', '1', null, '1905电影网搜索', null, null, null, '//h2[@id=\'my_video_h2_old\']', 'data_job_template_13', 'http://www.1905.com/search/?q=&q={key}', '-1', '0', '1', null, null);
INSERT INTO `job_template` VALUES ('41a1ad3e-354d-11e7-947a-b8aeed2fe120', '1', null, '热片网搜索', null, null, null, '//ul[class=\'show-list\']/li', 'data_job_template_14', 'http://list.repian.com/?keyword={key}', '-1', '0', '1', '1', null);
INSERT INTO `job_template` VALUES ('45e1dade-3554-11e7-947a-b8aeed2fe120', '1', null, '讯多影视搜索', null, null, null, '//div[@id=\'zuo\']/h4', 'data_job_template_15', 'http://www.xunduo.cc/sousuo.php?wd={key}', '-1', '0', '1', null, null);
INSERT INTO `job_template` VALUES ('46546268-354e-11e7-947a-b8aeed2fe120', '1', null, '热片网详情', null, null, null, '//div[@id=\'detail-box\']', 'data_job_template_16', '{url}', '41a1ad3e-354d-11e7-947a-b8aeed2fe120', '0', '1', null, null);
INSERT INTO `job_template` VALUES ('47827cc7-3571-11e7-81ad-00232490c701', '0', null, '我爱音乐网指定音乐的详情信息', null, null, null, '//div[@id=\"cscms_music_play\"]//div[@class=\"mc_info rt\"]', 'data_job_template_17', '{songUrl}', 'bf78bb32-3570-11e7-81ad-00232490c701', '1', '1', null, null);
INSERT INTO `job_template` VALUES ('481ceccb-3565-11e7-81ad-00232490c701', '0', null, '一听音乐指定音乐的详情信息', null, null, null, '//div[@id=\"songinfo\"]', 'data_job_template_18', '{songUrl}', '83efcd8d-3564-11e7-81ad-00232490c701', '1', '1', null, null);
INSERT INTO `job_template` VALUES ('48bdb527-35fb-11e7-81ad-00232490c701', '0', null, '成都出入境检验检疫局行政处罚内容', null, null, null, '//div[@class=\"fdet_txt\"]//tbody', 'data_job_template_19', 'http://www.scciq.gov.cn{detailUrl}', '200f8193-35f8-11e7-81ad-00232490c701,236f8237-35fa-11e7-81ad-00232490c701', '3', '1', null, null);
INSERT INTO `job_template` VALUES ('5540015c-41a5-45cc-b45b-74dceb948f38', '0', null, '市农委行政处罚案件信息公开表内容', null, null, null, '//div[@id=\"myTable\"]/p/a', 'data_job_template_20', '{detailUrl}', '5e69b443-3740-429f-b466-5ccefbfefdb6,bf0b362b-c6ee-4f2f-9693-fe82ba424bb6', '3', '1', null, null);
INSERT INTO `job_template` VALUES ('58a05936-3dcb-4906-a27b-b3aeaa4124c0', '0', null, '成都海关行政许可单页列表', null, null, null, '//table[@id=\"ess_ctr193591_ModuleContent\"]//ul/li', 'data_job_template_21', 'http://chengdu.customs.gov.cn/publish/portal130/tab70899/module193591/page{pageIndex}.htm', 'd2756997-06e9-419c-8a10-72f484f48fdc', '3', '1', null, null);
INSERT INTO `job_template` VALUES ('5b6ae8d4-77c8-48ac-af78-75b2fabd41da', '0', null, '市安监局案件信息总页数', null, null, null, '//div[@id=\"pages\"]/a[last()-1]', 'data_job_template_22', 'http://www.cdsafety.gov.cn/index.php?m=content&c=index&a=lists&catid=109', '-1', '3', '1', null, null);
INSERT INTO `job_template` VALUES ('5e69b443-3740-429f-b466-5ccefbfefdb6', '0', null, '市农委行政处罚案件第一页列表', null, null, null, '//div[@class=\"pr\"]/div[@class=\"blk01\"]/ul/li', 'data_job_template_23', 'http://www.cdagri.gov.cn/wwwRoot/nw/zwgk/qlsx/xzcfajgs/index.html', 'c5b197b8-a74b-49a4-8895-3509a976b8f3', '3', '1', null, null);
INSERT INTO `job_template` VALUES ('6394fc7e-347c-11e7-81ad-00232490c701', '0', null, '成都海关违法走私信息第一页列表', null, null, null, '//table[@id=\"ess_ctr193672_ModuleContent\"]//ul/li', 'data_job_template_24', 'http://chengdu.customs.gov.cn/publish/portal130/tab70919/', '05c6ae99-347c-11e7-81ad-00232490c701', '3', '1', null, null);
INSERT INTO `job_template` VALUES ('65ade85c-3528-11e7-947a-b8aeed2fe120', '1', null, '吉吉影音(爱上看电影)搜索', null, '2017-05-10 10:30:04', null, '//div[@id=\'classpage6\']//div[@class=\'vodlist_l\']/ul', 'data_job_template_25', 'http://www.iskdy.com/index.php?m=vod&a=search&wd={key}', '-1', '0', '1', null, null);
INSERT INTO `job_template` VALUES ('6cba3e48-3488-11e7-81ad-00232490c701', '0', null, '成都出入境检验检疫局行政处罚总页数', null, null, null, '//div[@class=\"fpag_wrap\"]', 'data_job_template_26', 'http://www.scciq.gov.cn/xzcf/index.htm', '-1', '3', '1', null, null);
INSERT INTO `job_template` VALUES ('7382a702-35e9-11e7-81ad-00232490c701', '0', null, '5nd音乐网指定音乐的详情信息', null, null, null, '//div[@class=\"songAboutL\"]', 'data_job_template_27', '{songUrl}', '91a744da-35e8-11e7-81ad-00232490c701', '1', '1', null, null);
INSERT INTO `job_template` VALUES ('740532f2-355d-11e7-947a-b8aeed2fe120', '1', null, '琪琪布电影网搜索', null, null, null, '//div[@id=\'main\']/div/ul/li', 'data_job_template_28', 'http://www.qiqibu8.com/soso.asp?kwtype=0&searchword={key}', '-1', '0', '1', '1', null);
INSERT INTO `job_template` VALUES ('76a3bf16-3547-11e7-81ad-00232490c701', '0', null, 'qq音乐指定音乐的详情信息', null, null, null, '//div[@class=\'data__cont\']', 'data_job_template_29', '{songUrl}', 'b990638c-3544-11e7-81ad-00232490c701', '1', '1', null, null);
INSERT INTO `job_template` VALUES ('76cf6922-34a5-11e7-9285-0025ab9a7c2c', '0', null, '起点书籍详情页', null, '2017-05-09 18:51:42', null, '//div[@class=\'book-info \']', 'data_job_template_30', 'http:{newUrl}', '2847be6c-3498-11e7-9285-0025ab9a7c2c', '2', '1', null, null);
INSERT INTO `job_template` VALUES ('79b3bf64-3556-11e7-81ad-00232490c701', '0', null, '九酷音乐指定音乐的详情信息', null, null, null, '//div[@class=\"t-t\"]', 'data_job_template_31', '{songUrl}', '03a29e86-3554-11e7-81ad-00232490c701', '1', '1', null, null);
INSERT INTO `job_template` VALUES ('7bc0d842-357b-11e7-81ad-00232490c701', '0', null, '想听音乐网搜索到的第一个音乐的详情地址', null, null, null, '//div[@id=\"type01\"]/ul/li[1]/a[@class=\"songName\"]', 'data_job_template_32', 'http://www.yy3t.com/index.php/dance/so/key/?key={key}', '-1', '1', '1', null, null);
INSERT INTO `job_template` VALUES ('7ec22330-f120-49bb-888a-5c8d33fc95bc', '0', null, '市安监局案件信息内容', null, null, null, '//p[@style=\"line-height: 16px;\"]/a', 'data_job_template_33', '{detailUrl}', '15aa0610-5b4b-4ea8-a355-51ce72d1693e,2f4f7d28-451d-4006-86ef-49b50872d458', '3', '1', null, null);
INSERT INTO `job_template` VALUES ('7ecef0fa-3481-11e7-81ad-00232490c701', '0', null, '成都海关违法走私信息内容', null, null, null, '//div[@class=\"xl_Cont1\"]', 'data_job_template_34', 'http://chengdu.customs.gov.cn{detail_url}', '6394fc7e-347c-11e7-81ad-00232490c701,af654225-347c-11e7-81ad-00232490c701', '3', '1', null, null);
INSERT INTO `job_template` VALUES ('83efcd8d-3564-11e7-81ad-00232490c701', '0', null, '一听音乐搜索到的第一个音乐的详情地址', null, null, null, '//div[@id=\"resultList\"]//tbody/tr[1]/td[@class=\"song\"]/a', 'data_job_template_35', 'http://so.1ting.com/all.do?q={key}', '-1', '1', '1', null, null);
INSERT INTO `job_template` VALUES ('86a400fe-3525-11e7-947a-b8aeed2fe120', '0', null, '腾讯视频详情', null, '2017-05-10 10:08:43', null, '', 'data_job_template_36', '{detailUrl}', 'c12161be-3494-11e7-aa20-b8aeed2fe120', '0', '1', null, null);
INSERT INTO `job_template` VALUES ('8cc9d34c-355e-11e7-947a-b8aeed2fe120', '1', null, '琪琪布电影网详情页', null, null, null, '//div[@class=\'video-box\']', 'data_job_template_37', 'http://www.qiqibu8.com{url}', '740532f2-355d-11e7-947a-b8aeed2fe120', '0', '1', null, null);
INSERT INTO `job_template` VALUES ('90a8e36f-3555-11e7-97d9-0025ab9a7c2c', '0', null, '小说大全搜索', null, '2017-05-10 15:51:27', null, '//div[@class=\'imgbox\']', 'data_job_template_38', 'http://book.km.com/search.html?search_type=index&keyword={key}', '-1', '2', '1', null, null);
INSERT INTO `job_template` VALUES ('91a744da-35e8-11e7-81ad-00232490c701', '0', null, '5nd音乐网搜索到的第一个音乐的详情地址', null, null, null, '//ul[@class=\"mulist\"]/li[2]/p[1]/a', 'data_job_template_39', 'http://so.5nd.com/k_{key}', '-1', '1', '1', null, null);
INSERT INTO `job_template` VALUES ('93b6d456-355e-11e7-97d9-0025ab9a7c2c', '0', null, '鲸鱼中文搜索', null, '2017-05-10 16:56:53', null, '//div[@class=\'novel-info\']', 'data_job_template_40', 'http://www.jingyu.com/search/?kw={key}', '-1', '2', '1', null, null);
INSERT INTO `job_template` VALUES ('a17e9d1d-3523-11e7-947a-b8aeed2fe120', '1', null, '中国高清网详情页', null, '2017-05-10 09:54:55', null, '//div[@id=\'post_content\']/p[3]', 'data_job_template_41', '{url}', 'c283b2c4-3521-11e7-947a-b8aeed2fe120', '0', '1', null, null);
INSERT INTO `job_template` VALUES ('ae78b7e4-3576-11e7-81ad-00232490c701', '0', null, '芒仔音乐铺搜索到的第一个音乐的详情地址', null, null, null, '//div[@id=\"results\"]/div[1]/h3/a', 'data_job_template_42', 'http://so.yinyuepu.com/cse/search?q={key}&from=input&s=6692532090072095586&entry=1', '-1', '1', '1', null, null);
INSERT INTO `job_template` VALUES ('af654225-347c-11e7-81ad-00232490c701', '0', null, '成都海关违法走私信息单页列表', null, null, null, '//table[@id=\"ess_ctr193672_ModuleContent\"]//ul/li', 'data_job_template_43', 'http://chengdu.customs.gov.cn/publish/portal130/tab70919/module193672/page{pageIndex}.htm', '05c6ae99-347c-11e7-81ad-00232490c701', '3', '1', null, null);
INSERT INTO `job_template` VALUES ('b3bb56ae-3532-11e7-97d9-0025ab9a7c2c', '0', null, '114小说搜索', null, '2017-05-10 11:42:04', null, '//div[@class=\'searcont\']//dd', 'data_job_template_44', 'http://book.114la.com/search.html?s={key}', '-1', '2', '1', null, null);
INSERT INTO `job_template` VALUES ('b990638c-3544-11e7-81ad-00232490c701', '0', null, 'qq音乐搜索到的第一个音乐的详情地址', null, null, null, '//div[@id=\'song_box\']//ul[@class=\'songlist__list\']/li[1]//div[@class=\'songlist__songname\']/span/a', 'data_job_template_45', 'https://y.qq.com/portal/search.html#page=1&searchid=1&remoteplace=txt.yqq.top&t=song&w={key}', '-1', '1', '1', null, null);
INSERT INTO `job_template` VALUES ('b99e6a2c-3531-11e7-947a-b8aeed2fe120', '1', null, '1905电影网详情页', null, null, null, '//div[@class=\'db h100b pb02\']', 'data_job_template_46', '{url}', '39feb7d2-3530-11e7-947a-b8aeed2fe120', '0', '1', null, null);
INSERT INTO `job_template` VALUES ('bf0b362b-c6ee-4f2f-9693-fe82ba424bb6', '0', null, '市农委行政处罚案件单页列表', null, null, null, '//div[@class=\"pr\"]/div[@class=\"blk01\"]/ul/li', 'data_job_template_47', 'http://www.cdagri.gov.cn/wwwRoot/nw/zwgk/qlsx/xzcfajgs/index_{pageIndex}.html', 'c5b197b8-a74b-49a4-8895-3509a976b8f3', '3', '1', null, null);
INSERT INTO `job_template` VALUES ('bf78bb32-3570-11e7-81ad-00232490c701', '0', null, '我爱音乐网搜索到的第一个音乐的详情地址', null, null, null, '//tbody[@id=\"dance_list\"]/tr[2]/td[1]/div/a', 'data_job_template_48', 'http://www.5iyy.net/index.php/dance/so/key?key={key}&tp=1', '-1', '1', '1', null, null);
INSERT INTO `job_template` VALUES ('c12161be-3494-11e7-aa20-b8aeed2fe120', '0', '0', '腾讯视频搜索', null, '2017-05-09 16:53:02', null, '//div[@class=\'wrapper_main\']/div[contains(@class,\'result_item\')]', 'data_job_template_49', 'https://v.qq.com/x/search/?q={key}', '-1', '0', '1', null, null);
INSERT INTO `job_template` VALUES ('c283b2c4-3521-11e7-947a-b8aeed2fe120', '1', null, '中国高清网搜索页', null, '2017-05-10 09:44:20', null, '//ul[@id=\'post_container\']/li[1]//div[@class=\'thumbnail\']', 'data_job_template_50', 'http://gaoqing.la/?s={key}', '-1', '0', '1', null, null);
INSERT INTO `job_template` VALUES ('c53793f4-34b6-11e7-b41d-0025ab9a7c2c', '0', null, '小说阅读网详情页', null, '2017-05-09 20:55:12', null, '//div[@class=\'book-information cf\']/div[@class=\'book-info\']', 'data_job_template_51', 'https://{readnovelUrl}', '072241de-34b6-11e7-b41d-0025ab9a7c2c', '2', '1', null, null);
INSERT INTO `job_template` VALUES ('c5b197b8-a74b-49a4-8895-3509a976b8f3', '0', null, '市农委行政处罚案件总页数', null, null, null, '//div[@class=\"scott\"]/a[last()]', 'data_job_template_52', 'http://www.cdagri.gov.cn/wwwRoot/nw/zwgk/qlsx/xzcfajgs/index.html', '-1', '3', '1', null, null);
INSERT INTO `job_template` VALUES ('d2756997-06e9-419c-8a10-72f484f48fdc', '0', null, '成都海关行政许可总页数', null, null, null, '//div[@id=\"ess_ctr193591_ListC_Info_AspNetPager\"]//tr/td[1]', 'data_job_template_53', 'http://chengdu.customs.gov.cn/publish/portal130/tab70899/', '-1', '3', '1', null, null);
INSERT INTO `job_template` VALUES ('d4aaf892-3556-11e7-97d9-0025ab9a7c2c', '0', null, '小说大全详情', null, '2017-05-10 16:26:20', null, '//div[@class=\'abook clearfix\']', 'data_job_template_54', 'http://book.km.com{kmUrl}', '90a8e36f-3555-11e7-97d9-0025ab9a7c2c', '2', '1', null, null);
INSERT INTO `job_template` VALUES ('eac8e8a3-352e-11e7-97d9-0025ab9a7c2c', '0', null, '咪咕详情页', null, '2017-05-10 11:16:05', null, '//div[@class=\'read_con\']', 'data_job_template_55', 'http://www.cmread.com/{cmUrl}', 'ffe68206-352d-11e7-97d9-0025ab9a7c2c', '2', '1', null, null);
INSERT INTO `job_template` VALUES ('ef50c529-4e6e-4113-9f54-2270e54d7e2d', '0', null, '成都海关行政许可内容', null, null, null, '//div[@class=\"xl_Cont1\"]', 'data_job_template_56', 'http://chengdu.customs.gov.cn{detail_url}', '13d28677-d305-4803-9f97-10ea86a08acc,58a05936-3dcb-4906-a27b-b3aeaa4124c0', '3', '1', null, null);
INSERT INTO `job_template` VALUES ('f4f1a890-354e-11e7-97d9-0025ab9a7c2c', '0', null, '81中文网搜索', null, '2017-05-10 15:11:33', null, '//div[@class=\'result-game-item-detail\']', 'data_job_template_57', 'http://zhannei.baidu.com/cse/search?s=2988433831094058597&q={key}', '-1', '2', '1', null, null);
INSERT INTO `job_template` VALUES ('fa463989-3556-11e7-947a-b8aeed2fe120', '1', null, '讯多影视详情', null, null, null, '//div[@id=\'xinxi_zuo\']', 'data_job_template_58', 'http://www.xunduo.cc{url}', '45e1dade-3554-11e7-947a-b8aeed2fe120', '0', '1', null, null);
INSERT INTO `job_template` VALUES ('fca9bb42-357b-11e7-81ad-00232490c701', '0', null, '想听音乐网指定音乐的详情信息', null, null, null, '//div[@class=\"pFr\"]/div[2]', 'data_job_template_59', '{songUrl}', '7bc0d842-357b-11e7-81ad-00232490c701', '1', '1', null, null);
INSERT INTO `job_template` VALUES ('ffe68206-352d-11e7-97d9-0025ab9a7c2c', '0', null, '咪咕搜索', null, '2017-05-10 11:08:38', null, '//div[@class=\'book_le\']', 'data_job_template_60', 'http://www.cmread.com/u/new/searchResult?kwords={key}&bookItemType=0', '-1', '2', '1', null, null);

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
INSERT INTO `job_template_field` VALUES ('027ad6f4-355c-11e7-81ad-00232490c701', '0', 'songLan', '九酷音乐指定音乐的语种', 'varchar', '255', null, '79b3bf64-3556-11e7-81ad-00232490c701', '语言：(\\S*)', null, 'p[3]/text()', null, null, '2017-05-12 00:26:27');
INSERT INTO `job_template_field` VALUES ('0407cd18-35ea-11e7-81ad-00232490c701', '0', 'songSinger', '5nd音乐网指定音乐的歌手名', 'varchar', '255', null, '7382a702-35e9-11e7-81ad-00232490c701', null, null, 'div[@class=\"songInfo\"]/ul/li[2]/a/text()', null, null, '2017-05-12 00:26:27');
INSERT INTO `job_template_field` VALUES ('04582a8b-3572-11e7-81ad-00232490c701', '0', 'songSinger', '我爱音乐网指定音乐的歌手名', 'varchar', '255', null, '47827cc7-3571-11e7-81ad-00232490c701', null, null, 'p[1]/strong[1]/a/text()', null, null, '2017-05-12 00:26:27');
INSERT INTO `job_template_field` VALUES ('06e6bf26-357e-11e7-81ad-00232490c701', '0', 'songAlbum', '想听音乐网指定音乐的专辑名', 'varchar', '255', null, 'fca9bb42-357b-11e7-81ad-00232490c701', null, null, 'a[2]/span/text()', null, null, '2017-05-12 00:26:27');
INSERT INTO `job_template_field` VALUES ('06f43132-3483-11e7-81ad-00232490c701', '0', 'punishBody', '主体名称', 'varchar', '255', null, '7ecef0fa-3481-11e7-81ad-00232490c701', null, null, 'div[4]/span//tr[2]/td[2]/p/text()', null, null, '2017-05-12 00:26:27');
INSERT INTO `job_template_field` VALUES ('07f49578-b84b-4264-869e-93930d316624', '0', 'excelUrl', '市农委行政处罚案件信息公开表附件地址', 'varchar', '255', null, '5540015c-41a5-45cc-b45b-74dceb948f38', null, null, '@href', null, null, '2017-05-12 00:26:27');
INSERT INTO `job_template_field` VALUES ('08242ceb-3524-11e7-947a-b8aeed2fe120', '0', 'movieDirector', '中国高清导演', 'varchar', '1024', null, 'a17e9d1d-3523-11e7-947a-b8aeed2fe120', null, null, 'span[13]/text()', null, null, '2017-05-11 16:27:24');
INSERT INTO `job_template_field` VALUES ('0cba9458-3558-11e7-947a-b8aeed2fe120', '0', 'movieTime', '讯多影视年代', 'varchar', '1024', null, 'fa463989-3556-11e7-947a-b8aeed2fe120', null, null, 'h1/span/text()', null, null, '2017-05-11 16:27:24');
INSERT INTO `job_template_field` VALUES ('116f5b6c-3546-11e7-97d9-0025ab9a7c2c', '0', 'author', '114小说作者', 'varchar', '1024', null, '1e6ec3db-3545-11e7-97d9-0025ab9a7c2c', null, null, 'div[@class=\'view\']/span[1]/a/text()', null, null, '2017-05-11 16:27:24');
INSERT INTO `job_template_field` VALUES ('116fe589-3550-11e7-97d9-0025ab9a7c2c', '0', 'bookName', '81中文书名', 'varchar', '1024', null, 'f4f1a890-354e-11e7-97d9-0025ab9a7c2c', '', null, 'h3//a[@cpos=\'title\']/@title', null, null, '2017-05-11 16:27:24');
INSERT INTO `job_template_field` VALUES ('1518c050-3482-11e7-81ad-00232490c701', '0', 'punishResult', '行政处罚结果', 'varchar', '255', null, '7ecef0fa-3481-11e7-81ad-00232490c701', null, null, 'div[4]/span//tr[8]/td[2]/p/text()', null, null, '2017-05-12 00:26:28');
INSERT INTO `job_template_field` VALUES ('153c1d3e-3578-11e7-81ad-00232490c701', '0', 'songAlbum', '芒仔音乐铺指定音乐的专辑名', 'varchar', '255', null, '07059670-3577-11e7-81ad-00232490c701', null, null, 'div[@class=\"songInfo\"]/ul/li[3]/a/text()', null, null, '2017-05-12 00:26:28');
INSERT INTO `job_template_field` VALUES ('15cbde2c-3611-11e7-81ad-00232490c701', '0', 'penaltyDecisionNum', '处理决定书文号', null, null, null, '48bdb527-35fb-11e7-81ad-00232490c701', '：(.*)', null, 'tr[2]/td/p/text()', '{value}.encode(\'utf-8\')', null, '2017-05-12 00:26:28');
INSERT INTO `job_template_field` VALUES ('162cc096-3573-11e7-81ad-00232490c701', '0', 'songUploadTime', '我爱音乐网指定音乐的上传时间', 'varchar', '255', null, '47827cc7-3571-11e7-81ad-00232490c701', null, null, 'p[1]/text()[last()]', null, null, '2017-05-12 00:26:28');
INSERT INTO `job_template_field` VALUES ('1d42c850-3616-11e7-81ad-00232490c701', '0', 'penaltyTypes', '处罚种类', null, null, null, '48bdb527-35fb-11e7-81ad-00232490c701', '：(.*)', null, 'tr[5]/td/p/text()', '{value}.encode(\'utf-8\')', null, '2017-05-12 00:26:28');
INSERT INTO `job_template_field` VALUES ('1efdc576-10cf-4258-a6f5-6bdf43cd9aab', '0', 'detailUrl', '成都海关行政许可内容地址', 'varchar', '255', null, '58a05936-3dcb-4906-a27b-b3aeaa4124c0', null, null, 'a/@href', null, null, '2017-05-12 00:26:28');
INSERT INTO `job_template_field` VALUES ('1f34f459-34a3-11e7-aa20-b8aeed2fe120', '0', 'detailUrl', '腾讯视频详情页url', 'varchar', '1024', null, 'c12161be-3494-11e7-aa20-b8aeed2fe120', null, null, 'div[@class=\'_infos\']//a[@class=\'desc_more\']/@href', null, null, '2017-05-11 16:27:24');
INSERT INTO `job_template_field` VALUES ('20627482-357e-11e7-81ad-00232490c701', '0', 'songUploadTime', '想听音乐网指定音乐的上传时间', 'varchar', '255', null, 'fca9bb42-357b-11e7-81ad-00232490c701', null, null, 'span[6]/text()', null, null, '2017-05-12 00:26:28');
INSERT INTO `job_template_field` VALUES ('23eea1e5-352f-11e7-97d9-0025ab9a7c2c', '0', 'bookName', '咪咕书名', 'varchar', '1024', null, 'eac8e8a3-352e-11e7-97d9-0025ab9a7c2c', null, null, 'h2/span/text()', null, null, '2017-05-11 16:27:24');
INSERT INTO `job_template_field` VALUES ('24143a72-112d-4176-ab95-63374c02c772', '0', 'detailUrl', '市农委行政处罚案件信息公开表内容地址', 'varchar', '255', null, 'bf0b362b-c6ee-4f2f-9693-fe82ba424bb6', null, null, 'a/@href', null, null, '2017-05-12 00:26:28');
INSERT INTO `job_template_field` VALUES ('243a1053-34b6-11e7-b41d-0025ab9a7c2c', '0', 'readnovelUrl', '小说阅读网详情地址', 'varchar', '1024', null, '072241de-34b6-11e7-b41d-0025ab9a7c2c', null, null, 'a/@href', null, null, '2017-05-11 16:27:24');
INSERT INTO `job_template_field` VALUES ('24663cd2-355f-11e7-97d9-0025ab9a7c2c', '0', 'bookName', '鲸鱼中文书名', 'varchar', '1024', null, '93b6d456-355e-11e7-97d9-0025ab9a7c2c', null, null, 'div[@class=\'title\']/a/text()', null, null, '2017-05-11 16:27:24');
INSERT INTO `job_template_field` VALUES ('2617b448-34af-11e7-9285-0025ab9a7c2c', '0', 'bookName', '书名', 'varchar', '1024', null, '76cf6922-34a5-11e7-9285-0025ab9a7c2c', null, null, 'h1/em/text()', null, null, '2017-05-11 16:27:24');
INSERT INTO `job_template_field` VALUES ('2696a6d3-3571-11e7-81ad-00232490c701', '0', 'songUrl', '我爱音乐网搜索到的第一个音乐的详情地址', 'varchar', '255', null, 'bf78bb32-3570-11e7-81ad-00232490c701', null, null, '@href', null, null, '2017-05-12 00:26:28');
INSERT INTO `job_template_field` VALUES ('28e78450-3565-11e7-81ad-00232490c701', '0', 'songUrl', '一听音乐搜索到的第一个音乐的详情地址', 'varchar', '255', null, '83efcd8d-3564-11e7-81ad-00232490c701', null, null, '@href', null, null, '2017-05-12 00:26:28');
INSERT INTO `job_template_field` VALUES ('299bbdb7-3547-11e7-81ad-00232490c701', '0', 'songUrl', 'qq音乐搜索到的第一个音乐的详情地址', 'varchar', '255', null, 'b990638c-3544-11e7-81ad-00232490c701', null, null, '@href', null, null, '2017-05-12 00:26:28');
INSERT INTO `job_template_field` VALUES ('29fb36f4-3556-11e7-81ad-00232490c701', '0', 'songUrl', '九酷音乐搜索到的第一个音乐播放地址', 'varchar', '255', null, '03a29e86-3554-11e7-81ad-00232490c701', null, null, 'a[@class=\"songName\"]/@href', null, null, '2017-05-12 00:26:28');
INSERT INTO `job_template_field` VALUES ('2cebdfc5-34a5-11e7-9285-0025ab9a7c2c', '0', 'newUrl', '详情地址', 'varchar', '1024', null, '2847be6c-3498-11e7-9285-0025ab9a7c2c', null, null, 'a/@href', null, null, '2017-05-11 16:27:24');
INSERT INTO `job_template_field` VALUES ('2ed79c4c-3550-11e7-97d9-0025ab9a7c2c', '0', 'author', '81中文作者', 'varchar', '1024', null, 'f4f1a890-354e-11e7-97d9-0025ab9a7c2c', ' \\S+ ', null, 'div/p[1]/span[2]/text()', null, null, '2017-05-11 16:27:24');
INSERT INTO `job_template_field` VALUES ('31075354-3548-11e7-81ad-00232490c701', '0', 'songName', 'qq音乐指定音乐的音乐名字', 'varchar', '255', null, '76a3bf16-3547-11e7-81ad-00232490c701', null, null, 'div[2]/h1/text()', null, null, '2017-05-12 00:26:28');
INSERT INTO `job_template_field` VALUES ('322be04b-354f-11e7-947a-b8aeed2fe120', '0', 'movieTime', '热片网年代', 'varchar', '1024', null, '46546268-354e-11e7-947a-b8aeed2fe120', null, null, 'div[@class=\'detail-cols fn-clear\']//div[@class=\'info fn-clear\']/dl[8]/dd/span/text()', null, null, '2017-05-11 16:27:24');
INSERT INTO `job_template_field` VALUES ('35001523-3467-11e7-81ad-00232490c701', '0', 'grantUnit', '授予单位', 'varchar', '255', null, 'ef50c529-4e6e-4113-9f54-2270e54d7e2d', '(.+)准予.+', null, 'div[@class=\"titTop\"]/h1/strong/text()', '{value}.encode(\'utf-8\')', null, '2017-05-12 00:26:29');
INSERT INTO `job_template_field` VALUES ('357f9c7c-3617-11e7-81ad-00232490c701', '0', 'penaltyDate', '处罚决定日期', null, null, null, '48bdb527-35fb-11e7-81ad-00232490c701', '：(.*)', null, 'tr[last()]/td/p/text()', '{value}.encode(\'utf-8\')', null, '2017-05-12 00:26:29');
INSERT INTO `job_template_field` VALUES ('38d7cb87-347c-11e7-81ad-00232490c701', '0', 'pageCount', '成都海关违法走私信息总页数', 'varchar', '255', null, '05c6ae99-347c-11e7-81ad-00232490c701', '(\\d+)', null, 'text()[2]', null, null, '2017-05-12 00:26:29');
INSERT INTO `job_template_field` VALUES ('394d5b5b-349c-11e7-aa20-b8aeed2fe120', '0', 'movieName', '腾讯视频名称', 'varchar', '1024', null, 'c12161be-3494-11e7-aa20-b8aeed2fe120', null, null, 'h2[@class=\'result_title\']/a/em/text()', null, null, '2017-05-11 16:27:24');
INSERT INTO `job_template_field` VALUES ('394d5b5b-349c-11e7-aa20-b8aeed2fe1201', '0', 'movieName', '腾讯视频名称', 'varchar', '1024', null, '86a400fe-3525-11e7-947a-b8aeed2fe120', null, null, '//h1[@class=\'video_title_cn\']/a/text()', null, null, '2017-05-11 16:27:24');
INSERT INTO `job_template_field` VALUES ('398982f2-34b9-11e7-b41d-0025ab9a7c2c', '0', 'bookName', '小说阅读网书名', 'varchar', '1024', null, 'c53793f4-34b6-11e7-b41d-0025ab9a7c2c', null, null, 'h1/em/text()', null, null, '2017-05-11 16:27:24');
INSERT INTO `job_template_field` VALUES ('3a92edb0-3547-11e7-947a-b8aeed2fe120', '0', 'movieDirector', '1905电影导演', 'varchar', '1024', null, 'b99e6a2c-3531-11e7-947a-b8aeed2fe120', null, null, 'ol/li[1]/a/text()', null, null, '2017-05-11 16:27:24');
INSERT INTO `job_template_field` VALUES ('3c6d9ed7-34ba-11e7-b41d-0025ab9a7c2c', '0', 'type', '小说阅读网类型', 'varchar', '1024', null, 'c53793f4-34b6-11e7-b41d-0025ab9a7c2c', null, null, 'p/span[@class=\'tag\']/i/text()', null, null, '2017-05-11 16:27:24');
INSERT INTO `job_template_field` VALUES ('3d052a6e-881f-4a79-9715-4f897115cff8', '0', 'pageCount', '市安监局案件信息总页数', 'varchar', '255', null, '5b6ae8d4-77c8-48ac-af78-75b2fabd41da', 'page=(\\d+)', null, '@href', null, null, '2017-05-12 00:26:29');
INSERT INTO `job_template_field` VALUES ('3e602e04-3522-11e7-947a-b8aeed2fe120', '0', 'url', '中国高清网详情页面地址', 'varchar', '1024', null, 'c283b2c4-3521-11e7-947a-b8aeed2fe120', null, null, 'a/@href', null, null, '2017-05-11 16:27:24');
INSERT INTO `job_template_field` VALUES ('43b07772-355f-11e7-947a-b8aeed2fe120', '0', 'movieName', '琪琪布电影网名称', 'varchar', '1024', null, '8cc9d34c-355e-11e7-947a-b8aeed2fe120', null, null, 'div[@class=\'d-title\']/h2/a[last()]/text()', null, null, '2017-05-11 16:27:24');
INSERT INTO `job_template_field` VALUES ('4525fdbf-3468-11e7-81ad-00232490c701', '0', 'principalName', '主体名称', 'varchar', '255', null, 'ef50c529-4e6e-4113-9f54-2270e54d7e2d', null, null, 'div[last()]/span/text()[2]', null, null, '2017-05-12 00:26:29');
INSERT INTO `job_template_field` VALUES ('464d45cd-3532-11e7-947a-b8aeed2fe120', '0', 'movieName', '1905电影名称', 'varchar', '1024', null, 'b99e6a2c-3531-11e7-947a-b8aeed2fe120', null, null, 'div/h1/@title', null, null, '2017-05-11 16:27:24');
INSERT INTO `job_template_field` VALUES ('47ba7357-8b42-42b0-8b81-4e224b36b580', '0', 'detailUrl', '成都海关行政许可内容地址', 'varchar', '255', null, '13d28677-d305-4803-9f97-10ea86a08acc', null, null, 'a/@href', null, null, '2017-05-12 00:26:29');
INSERT INTO `job_template_field` VALUES ('48f14574-34af-11e7-9285-0025ab9a7c2c', '0', 'author', '作者', 'varchar', '1024', null, '76cf6922-34a5-11e7-9285-0025ab9a7c2c', null, null, 'h1//a[@class=\'writer\']/text()[1]', null, null, '2017-05-11 16:27:24');
INSERT INTO `job_template_field` VALUES ('4ad045e0-3559-11e7-97d9-0025ab9a7c2c', '0', 'Type', '小说大全类型', 'varchar', '1024', null, 'd4aaf892-3556-11e7-97d9-0025ab9a7c2c', null, null, 'div[@class=\'summary\']/ul/li[2]/a/text()', null, null, '2017-05-11 16:27:24');
INSERT INTO `job_template_field` VALUES ('4b247b1a-3549-11e7-81ad-00232490c701', '0', 'songSinger', 'qq音乐指定音乐的歌手名', 'varchar', '255', null, '76a3bf16-3547-11e7-81ad-00232490c701', null, null, 'div[1]/a/text()', null, null, '2017-05-12 00:26:29');
INSERT INTO `job_template_field` VALUES ('4c56de41-347d-11e7-81ad-00232490c701', '0', 'detailUrl', '成都海关违法走私信息内容地址', 'varchar', '255', null, 'af654225-347c-11e7-81ad-00232490c701', null, null, 'a/@href', null, null, '2017-05-12 00:26:29');
INSERT INTO `job_template_field` VALUES ('50699bf7-35e9-11e7-81ad-00232490c701', '0', 'songUrl', '5nd音乐网搜索到的第一个音乐的详情地址', 'varchar', '255', null, '91a744da-35e8-11e7-81ad-00232490c701', null, null, '@href', null, null, '2017-05-12 00:26:29');
INSERT INTO `job_template_field` VALUES ('52db2d94-35fa-11e7-81ad-00232490c701', '0', 'detailUrl', '成都出入境检验检疫局行政处罚内容地址', null, null, null, '236f8237-35fa-11e7-81ad-00232490c701', null, null, 'td[3]/a/@href', null, null, '2017-05-12 00:26:29');
INSERT INTO `job_template_field` VALUES ('53551295-3616-11e7-81ad-00232490c701', '0', 'penaltyResult', '处罚结果', null, null, null, '48bdb527-35fb-11e7-81ad-00232490c701', '：(.*)', null, 'tr[7]/td/p/text()', '{value}.encode(\'utf-8\')', null, '2017-05-12 00:26:29');
INSERT INTO `job_template_field` VALUES ('5a3bce61-34ad-11e7-aa20-b8aeed2fe120', '0', 'movieTime', '腾讯视频年代', 'varchar', '1024', null, 'ece53d51-34ac-11e7-aa20-b8aeed2fe120', null, null, 'span[@class=\'type_txt\']/text()', null, null, '2017-05-11 16:27:24');
INSERT INTO `job_template_field` VALUES ('5a3bce61-34ad-11e7-aa20-b8aeed2fe1201', '0', 'movieTime', '腾讯视频年代', 'varchar', '1024', null, '86a400fe-3525-11e7-947a-b8aeed2fe120', null, null, '//div[@class=\'video_type video_type_even cf\']//span[@class=\'type_txt\']/text()', null, null, '2017-05-11 16:27:24');
INSERT INTO `job_template_field` VALUES ('5b4ce864-3558-11e7-947a-b8aeed2fe120', '0', 'movieDiretor', '讯多影视导演', 'varchar', '1024', null, 'fa463989-3556-11e7-947a-b8aeed2fe120', null, null, 'ul/li[2]/text()\"', null, null, '2017-05-11 16:27:24');
INSERT INTO `job_template_field` VALUES ('5f063d66-3610-11e7-81ad-00232490c701', '0', 'principalName', '主体名称', null, null, null, '48bdb527-35fb-11e7-81ad-00232490c701', '：(.*)', null, 'tr[1]/td/p/text()', '{value}.encode(\'utf-8\')', null, '2017-05-12 00:26:30');
INSERT INTO `job_template_field` VALUES ('60b30eb3-352e-11e7-97d9-0025ab9a7c2c', '0', 'cmUrl', '咪咕详情地址', 'varchar', '1024', null, 'ffe68206-352d-11e7-97d9-0025ab9a7c2c', null, null, 'a/@href', null, null, '2017-05-11 16:27:24');
INSERT INTO `job_template_field` VALUES ('61be7db4-34b0-11e7-9285-0025ab9a7c2c', '0', 'type', '类型', 'varchar', '1024', null, '76cf6922-34a5-11e7-9285-0025ab9a7c2c', null, null, 'p[@class=\'tag\']/a/text()', null, null, '2017-05-11 16:27:24');
INSERT INTO `job_template_field` VALUES ('64c0bbf8-3468-11e7-81ad-00232490c701', '0', 'licenseDesc', '许可详情描述', 'varchar', '1024', null, 'ef50c529-4e6e-4113-9f54-2270e54d7e2d', null, null, 'div[last()]/span/text()[3 and last()]', '{value}.encode(\'utf-8\')', null, '2017-05-12 00:26:30');
INSERT INTO `job_template_field` VALUES ('64f9bebf-352f-11e7-97d9-0025ab9a7c2c', '0', 'author', '咪咕作者', 'varchar', '1024', null, 'eac8e8a3-352e-11e7-97d9-0025ab9a7c2c', '：(\\S+)', null, 'p/span[1]/text()[1]', null, null, '2017-05-11 16:27:24');
INSERT INTO `job_template_field` VALUES ('6a0f4f72-355e-11e7-947a-b8aeed2fe120', '0', 'url', '琪琪布电影网', 'varchar', '1024', null, '740532f2-355d-11e7-947a-b8aeed2fe120', null, null, 'a/@href', null, null, '2017-05-11 16:27:24');
INSERT INTO `job_template_field` VALUES ('6ad417fa-352e-11e7-947a-b8aeed2fe120', '0', 'movieName', '吉吉影音(爱上看电影)名称', 'varchar', '1024', null, '0a3b3e07-352e-11e7-947a-b8aeed2fe120', null, null, 'div[@class=\'moive_title\']/text()', null, null, '2017-05-11 16:27:24');
INSERT INTO `job_template_field` VALUES ('6b2b3e24-3565-11e7-81ad-00232490c701', '0', 'songName', '一听音乐指定音乐的音乐名字', 'varchar', '255', null, '481ceccb-3565-11e7-81ad-00232490c701', null, null, 'p[@class=\"songtitle\"]/a/text()', null, null, '2017-05-12 00:26:30');
INSERT INTO `job_template_field` VALUES ('6d717a70-355d-11e7-81ad-00232490c701', '0', 'songSize', '九酷音乐指定音乐的大小', 'varchar', '255', null, '79b3bf64-3556-11e7-81ad-00232490c701', '大小：(\\S* [K|M]B)', null, 'p[3]/text()', null, null, '2017-05-12 00:26:30');
INSERT INTO `job_template_field` VALUES ('790d5526-2c06-41d9-9608-0eaf82ea5cc3', '0', 'detailUrl', '市安监局案件信息内容地址', 'varchar', '255', null, '15aa0610-5b4b-4ea8-a355-51ce72d1693e', null, null, 'a/@href', null, null, '2017-05-12 00:26:30');
INSERT INTO `job_template_field` VALUES ('7a519e17-3611-11e7-81ad-00232490c701', '0', 'penaltyName', '处罚事项名称', null, null, null, '48bdb527-35fb-11e7-81ad-00232490c701', '：(.*)', null, 'tr[3]/td/p/text()', '{value}.encode(\'utf-8\')', null, '2017-05-12 00:26:30');
INSERT INTO `job_template_field` VALUES ('7b8b100e-3577-11e7-81ad-00232490c701', '0', 'songName', '芒仔音乐铺指定音乐的音乐名字', 'varchar', '255', null, '07059670-3577-11e7-81ad-00232490c701', null, null, 'h1/a/text()', null, null, '2017-05-12 00:26:30');
INSERT INTO `job_template_field` VALUES ('7c3b5a9f-3556-11e7-947a-b8aeed2fe120', '0', 'url', '讯多影视详情url', 'varchar', '1024', null, '45e1dade-3554-11e7-947a-b8aeed2fe120', null, null, 'a/@href', null, null, '2017-05-11 16:27:24');
INSERT INTO `job_template_field` VALUES ('80163542-347c-11e7-81ad-00232490c701', '0', 'detailUrl', '成都海关违法走私信息内容地址', 'varchar', '255', null, '6394fc7e-347c-11e7-81ad-00232490c701', null, null, 'a/@href', null, null, '2017-05-12 00:26:30');
INSERT INTO `job_template_field` VALUES ('80777fb7-354f-11e7-947a-b8aeed2fe120', '0', 'movieDiretor', '热片网导演', 'varchar', '1024', null, '46546268-354e-11e7-947a-b8aeed2fe120', null, null, 'div[@class=\'detail-cols fn-clear\']//div[@class=\'info fn-clear\']/dl[6]/dd//text()', null, null, '2017-05-11 16:27:24');
INSERT INTO `job_template_field` VALUES ('80c0fb09-354e-11e7-947a-b8aeed2fe120', '0', 'movieName', '热片网名称', 'varchar', '1024', null, '46546268-354e-11e7-947a-b8aeed2fe120', null, null, 'div[@class=\'detail-title fn-clear\']/h2/text()', null, null, '2017-05-11 16:27:24');
INSERT INTO `job_template_field` VALUES ('84189db4-355c-11e7-81ad-00232490c701', '0', 'songCompany', '九酷音乐指定音乐的发行公司', 'varchar', '255', null, '79b3bf64-3556-11e7-81ad-00232490c701', '发行公司：(\\S*)', null, 'p[2]/text()', null, null, '2017-05-12 00:26:30');
INSERT INTO `job_template_field` VALUES ('86a5fbc0-3557-11e7-81ad-00232490c701', '0', 'songName', '九酷音乐指定音乐的音乐名字', 'varchar', '255', null, '79b3bf64-3556-11e7-81ad-00232490c701', null, null, 'p[1]/a[1]/text()', null, null, '2017-05-12 00:26:30');
INSERT INTO `job_template_field` VALUES ('8b28a601-3549-11e7-81ad-00232490c701', '0', 'songAlbum', 'qq音乐指定音乐的专辑名', 'varchar', '255', null, '76a3bf16-3547-11e7-81ad-00232490c701', null, null, 'ul/li[1]/a/text()', null, null, '2017-05-12 00:26:30');
INSERT INTO `job_template_field` VALUES ('8c870ae1-349d-11e7-aa20-b8aeed2fe120', '0', 'movieDirector', '腾讯视频导演', 'varchar', '1024', null, 'c12161be-3494-11e7-aa20-b8aeed2fe120', null, null, 'div/div[@class=\'result_info\']/div[3]/span[@class=\'content\']//text()', null, null, '2017-05-11 16:27:24');
INSERT INTO `job_template_field` VALUES ('8c870ae1-349d-11e7-aa20-b8aeed2fe1201', '0', 'movieDirector', '腾讯视频导演', 'varchar', '1024', null, '86a400fe-3525-11e7-947a-b8aeed2fe120', null, null, '//ul[@class=\'actor_list cf\']/li[1]//span[1]/@text', null, null, '2017-05-11 16:27:24');
INSERT INTO `job_template_field` VALUES ('8f1fba72-35f9-11e7-81ad-00232490c701', '0', 'detailUrl', '成都出入境检验检疫局行政处罚内容地址', 'varchar', '255', null, '200f8193-35f8-11e7-81ad-00232490c701', null, null, 'td[3]/a/@href', null, null, '2017-05-12 00:26:30');
INSERT INTO `job_template_field` VALUES ('90124651-355f-11e7-947a-b8aeed2fe120', '0', 'movieTime', '琪琪布电影网年代', 'varchar', '1024', null, '8cc9d34c-355e-11e7-947a-b8aeed2fe120', null, null, 'div[@id=\'introduce\']//div[@class=\'info\']/dl[@class=\'gather\']/dd/text()', null, null, '2017-05-11 16:27:24');
INSERT INTO `job_template_field` VALUES ('90388cd6-3545-11e7-97d9-0025ab9a7c2c', '0', 'bookName', '114小说书名', 'varchar', '1024', null, '1e6ec3db-3545-11e7-97d9-0025ab9a7c2c', null, null, 'h2/text()', null, null, '2017-05-11 16:27:24');
INSERT INTO `job_template_field` VALUES ('91adad31-0971-434f-98a0-7faf8da4648b', '0', 'detailUrl', '市农委行政处罚案件信息公开表内容地址', 'varchar', '255', null, '5e69b443-3740-429f-b466-5ccefbfefdb6', null, null, 'a/@href', null, null, '2017-05-12 00:26:31');
INSERT INTO `job_template_field` VALUES ('92b38e12-3551-11e7-97d9-0025ab9a7c2c', '0', 'type', '81中文类型', 'varchar', '1024', null, 'f4f1a890-354e-11e7-97d9-0025ab9a7c2c', null, null, 'div/p[2]/span[2]/text()', null, null, '2017-05-11 16:27:24');
INSERT INTO `job_template_field` VALUES ('93169f60-3572-11e7-81ad-00232490c701', '0', 'songAlbum', '我爱音乐网指定音乐的专辑名', 'varchar', '255', null, '47827cc7-3571-11e7-81ad-00232490c701', null, null, 'p[1]/a[last()]/text()', null, null, '2017-05-12 00:26:31');
INSERT INTO `job_template_field` VALUES ('9420494f-3532-11e7-947a-b8aeed2fe120', '0', 'movieTime', '1905电影年代', 'varchar', '1024', null, 'b99e6a2c-3531-11e7-947a-b8aeed2fe120', null, null, 'ol/li[5]/a/text()', null, null, '2017-05-11 16:27:24');
INSERT INTO `job_template_field` VALUES ('95b4b46c-34b7-11e7-b41d-0025ab9a7c2c', '0', 'author', '小说阅读网作者', 'varchar', '1024', null, 'c53793f4-34b6-11e7-b41d-0025ab9a7c2c', '\\S\\S+', null, 'h1/a/text()', null, null, '2017-05-11 16:27:24');
INSERT INTO `job_template_field` VALUES ('9823f9eb-354e-11e7-81ad-00232490c701', '0', 'songCompany', 'qq音乐指定音乐的发行公司', 'varchar', '255', null, '76a3bf16-3547-11e7-81ad-00232490c701', null, null, 'ul/li[4]/a/text()', null, null, '2017-05-12 00:26:31');
INSERT INTO `job_template_field` VALUES ('9c975ea3-354d-11e7-81ad-00232490c701', '0', 'songLan', 'qq音乐指定音乐的语种', 'varchar', '255', null, '76a3bf16-3547-11e7-81ad-00232490c701', '语种：(.*)', null, 'ul/li[2]/text()', null, null, '2017-05-12 00:26:31');
INSERT INTO `job_template_field` VALUES ('9d342db3-3531-11e7-947a-b8aeed2fe120', '0', 'url', '1905电影网详情页url', 'varchar', '1024', null, '39feb7d2-3530-11e7-947a-b8aeed2fe120', null, null, 'a/@href', null, null, '2017-05-11 16:27:24');
INSERT INTO `job_template_field` VALUES ('9d41ee95-078d-40e8-95fe-267e24609551', '0', 'pageCount', '成都海关行政许可总页数', 'varchar', '255', null, 'd2756997-06e9-419c-8a10-72f484f48fdc', '(\\d+)', null, 'text()[2]', null, null, '2017-05-12 00:26:31');
INSERT INTO `job_template_field` VALUES ('a0afc251-3560-11e7-947a-b8aeed2fe120', '0', 'movieDiretor', '琪琪布电影网导演', 'varchar', '1024', null, '8cc9d34c-355e-11e7-947a-b8aeed2fe120', null, null, 'div[@id=\'introduce\']//div[@class=\'info\']/dl[@class=\'Type\']/dd/text()', null, null, '2017-05-11 16:27:24');
INSERT INTO `job_template_field` VALUES ('a13e5a8e-3565-11e7-81ad-00232490c701', '0', 'songSinger', '一听音乐指定音乐的歌手名', 'varchar', '255', null, '481ceccb-3565-11e7-81ad-00232490c701', null, null, 'p[@class=\"singer\"]/a/text()', null, null, '2017-05-12 00:26:31');
INSERT INTO `job_template_field` VALUES ('a17ebe5c-352e-11e7-947a-b8aeed2fe120', '0', 'movieTime', '吉吉影音(爱上看电影)年代', 'varchar', '1024', null, '0a3b3e07-352e-11e7-947a-b8aeed2fe120', null, null, 'ul/li[2]/text()', null, null, '2017-05-11 16:27:24');
INSERT INTO `job_template_field` VALUES ('a1dc5a6a-3558-11e7-97d9-0025ab9a7c2c', '0', 'author', '小说大全作者', 'varchar', '1024', null, 'd4aaf892-3556-11e7-97d9-0025ab9a7c2c', null, null, 'div[@class=\'tit_bg\']//span[@class=\'author\']/a/text()', null, null, '2017-05-11 16:27:24');
INSERT INTO `job_template_field` VALUES ('a4415a70-35ea-11e7-81ad-00232490c701', '0', 'songAlbum', '5nd音乐网指定音乐的专辑名', 'varchar', '255', null, '7382a702-35e9-11e7-81ad-00232490c701', null, null, 'div[@class=\"songInfo\"]/ul/li[3]/a/text()', null, null, '2017-05-12 00:26:31');
INSERT INTO `job_template_field` VALUES ('a99043b7-3555-11e7-97d9-0025ab9a7c2c', '0', 'kmUrl', '小说大全详情页', 'varchar', '1024', null, '90a8e36f-3555-11e7-97d9-0025ab9a7c2c', null, null, 'a/@href', null, null, '2017-05-11 16:27:24');
INSERT INTO `job_template_field` VALUES ('aaeb5533-3482-11e7-81ad-00232490c701', '0', 'punishBasis', '处罚依据', 'varchar', '255', null, '7ecef0fa-3481-11e7-81ad-00232490c701', null, null, 'div[4]/span//tr[7]/td[2]/p/text()', null, null, '2017-05-12 00:26:31');
INSERT INTO `job_template_field` VALUES ('b0cb823e-3577-11e7-81ad-00232490c701', '0', 'songSinger', '芒仔音乐铺指定音乐的歌手名', 'varchar', '255', null, '07059670-3577-11e7-81ad-00232490c701', null, null, 'div[@class=\"songInfo\"]/ul/li[2]/a/text()', null, null, '2017-05-12 00:26:31');
INSERT INTO `job_template_field` VALUES ('b68f18fc-355b-11e7-81ad-00232490c701', '0', 'songSinger', '九酷音乐指定音乐的歌手名', 'varchar', '255', null, '79b3bf64-3556-11e7-81ad-00232490c701', null, null, 'p[1]/a[2]/text()', null, null, '2017-05-12 00:26:31');
INSERT INTO `job_template_field` VALUES ('b74fb8e5-3546-11e7-97d9-0025ab9a7c2c', '0', 'type', '114小说类型', 'varchar', '1024', null, '1e6ec3db-3545-11e7-97d9-0025ab9a7c2c', null, null, 'div[@class=\'tags\']/a/text()', null, null, '2017-05-11 16:27:24');
INSERT INTO `job_template_field` VALUES ('b79c4791-352f-11e7-947a-b8aeed2fe120', '0', 'movieDirector', '吉吉影音(爱上看电影)导演', 'varchar', '1024', null, '0a3b3e07-352e-11e7-947a-b8aeed2fe120', null, null, 'ul/li[5]/text()', null, null, '2017-05-11 16:27:24');
INSERT INTO `job_template_field` VALUES ('b8d34478-3481-11e7-81ad-00232490c701', '0', 'punishTime', '行政处罚时间', 'varchar', '255', null, '7ecef0fa-3481-11e7-81ad-00232490c701', '发布时间：(.*)', null, 'div[@class=\"detailTime\"]/text()', '{value}.encode(\'utf-8\')', null, '2017-05-12 00:26:31');
INSERT INTO `job_template_field` VALUES ('ba9a32cc-3611-11e7-81ad-00232490c701', '0', 'penaltyGrounds', '处罚事由', null, null, null, '48bdb527-35fb-11e7-81ad-00232490c701', '：(.*)', null, 'tr[4]/td/p/text()', '{value}.encode(\'utf-8\')', null, '2017-05-12 00:26:31');
INSERT INTO `job_template_field` VALUES ('c00fbcd0-3523-11e7-947a-b8aeed2fe120', '0', 'modieName', '中国高清名称', 'varchar', '1024', null, 'a17e9d1d-3523-11e7-947a-b8aeed2fe120', null, null, 'span[1]/text()', null, null, '2017-05-11 16:27:24');
INSERT INTO `job_template_field` VALUES ('c054cc2d-3616-11e7-81ad-00232490c701', '0', 'performanceCategory', '执行情况类别', null, null, null, '48bdb527-35fb-11e7-81ad-00232490c701', '：(.*)', null, 'tr[8]/td/p/text()', '{value}.encode(\'utf-8\')', null, '2017-05-12 00:26:31');
INSERT INTO `job_template_field` VALUES ('c18e1060-3532-11e7-97d9-0025ab9a7c2c', '0', 'url144', '114小说详情地址', 'varchar', '1024', null, 'b3bb56ae-3532-11e7-97d9-0025ab9a7c2c', null, null, 'a[@target=\'_blank\']/@href', null, null, '2017-05-11 16:27:24');
INSERT INTO `job_template_field` VALUES ('c444f660-357d-11e7-81ad-00232490c701', '0', 'songName', '想听音乐网指定音乐的音乐名字', 'varchar', '255', null, 'fca9bb42-357b-11e7-81ad-00232490c701', null, null, 'a[1]/span/text()', null, null, '2017-05-12 00:26:32');
INSERT INTO `job_template_field` VALUES ('ca21047a-3565-11e7-81ad-00232490c701', '0', 'songAlbum', '一听音乐指定音乐的专辑名', 'varchar', '255', null, '481ceccb-3565-11e7-81ad-00232490c701', null, null, 'p[@class=\"album\"]/a/text()', null, null, '2017-05-12 00:26:32');
INSERT INTO `job_template_field` VALUES ('cb3a03a0-3482-11e7-81ad-00232490c701', '0', 'punishDesc', '违法详情描述', 'varchar', '1024', null, '7ecef0fa-3481-11e7-81ad-00232490c701', null, null, 'div[4]/span//tr[6]/td[2]/p/text()', null, null, '2017-05-12 00:26:32');
INSERT INTO `job_template_field` VALUES ('cb9aaf16-354e-11e7-81ad-00232490c701', '0', 'songPublicTime', 'qq音乐指定音乐的发行时间', 'varchar', '255', null, '76a3bf16-3547-11e7-81ad-00232490c701', '发行时间：(.*)', null, 'ul/li[last()]/text()', null, null, '2017-05-12 00:26:32');
INSERT INTO `job_template_field` VALUES ('cd5fc991-3615-11e7-81ad-00232490c701', '0', 'penaltyBasis', '处罚依据', null, null, null, '48bdb527-35fb-11e7-81ad-00232490c701', '：(.*)', null, 'tr[6]/td/p/text()', '{value}.encode(\'utf-8\')', null, '2017-05-12 00:26:32');
INSERT INTO `job_template_field` VALUES ('cdda2ac6-35ea-11e7-81ad-00232490c701', '0', 'songUploadTime', '5nd音乐网指定音乐的上传时间', 'varchar', '255', null, '7382a702-35e9-11e7-81ad-00232490c701', '发行时间：(.*)', null, 'div[@class=\"songInfo\"]/ul/li[4]/text()', null, null, '2017-05-12 00:26:32');
INSERT INTO `job_template_field` VALUES ('ce6dde78-3467-11e7-81ad-00232490c701', '0', 'grantTime', '授予时间', 'varchar', '1024', null, 'ef50c529-4e6e-4113-9f54-2270e54d7e2d', null, null, 'div[last()]/span/text()[5]', '{value}.encode(\'utf-8\')', null, '2017-05-12 00:26:32');
INSERT INTO `job_template_field` VALUES ('d212398b-352d-11e7-947a-b8aeed2fe120', '0', 'url', '吉吉影音(爱上看电影)详情页url', 'varchar', '1024', null, '65ade85c-3528-11e7-947a-b8aeed2fe120', null, null, 'a/@href', null, null, '2017-05-11 16:27:24');
INSERT INTO `job_template_field` VALUES ('d53a97c8-357b-11e7-81ad-00232490c701', '0', 'songUrl', '想听音乐网搜索到的第一个音乐的详情地址', 'varchar', '255', null, '7bc0d842-357b-11e7-81ad-00232490c701', null, null, '@href', null, null, '2017-05-12 00:26:32');
INSERT INTO `job_template_field` VALUES ('d580f6ba-3571-11e7-81ad-00232490c701', '0', 'songName', '我爱音乐网指定音乐的音乐名字', 'varchar', '255', null, '47827cc7-3571-11e7-81ad-00232490c701', null, null, 'div[1]/h1/text()', null, null, '2017-05-12 00:26:32');
INSERT INTO `job_template_field` VALUES ('d81d8671-3530-11e7-97d9-0025ab9a7c2c', '0', 'type', '咪咕类型', 'varchar', '1024', null, 'eac8e8a3-352e-11e7-97d9-0025ab9a7c2c', null, null, 'p/span[1]/a/text()', null, null, '2017-05-11 16:27:24');
INSERT INTO `job_template_field` VALUES ('d92756bc-355f-11e7-97d9-0025ab9a7c2c', '0', 'author', '鲸鱼中文作者', 'varchar', '1024', null, '93b6d456-355e-11e7-97d9-0025ab9a7c2c', null, null, 'div[@class=\'brief\']/span/a[1]/text()', null, null, '2017-05-11 16:27:24');
INSERT INTO `job_template_field` VALUES ('d92d16b0-372c-4ff2-a6df-31ac7fff7cc8', '0', 'pageCount', '市农委行政处罚案件总页数', 'varchar', '255', null, 'c5b197b8-a74b-49a4-8895-3509a976b8f3', 'index_(\\d)\\.html', null, '@href', null, null, '2017-05-12 00:26:32');
INSERT INTO `job_template_field` VALUES ('db492522-355b-11e7-81ad-00232490c701', '0', 'songAlbum', '九酷音乐指定音乐的专辑名', 'varchar', '255', null, '79b3bf64-3556-11e7-81ad-00232490c701', null, null, 'p[1]/a[3]/text()', null, null, '2017-05-12 00:26:32');
INSERT INTO `job_template_field` VALUES ('dbf7d968-c0f8-4bd6-8461-9e63f2dd3a55', '0', 'pdfUrl', '市安监局案件信息pdf附件地址', 'varchar', '255', null, '7ec22330-f120-49bb-888a-5c8d33fc95bc', null, null, '@href', null, null, '2017-05-12 00:26:32');
INSERT INTO `job_template_field` VALUES ('dc2b7d71-355c-11e7-81ad-00232490c701', '0', 'songPublicTime', '九酷音乐指定音乐的发行时间', 'varchar', '255', null, '79b3bf64-3556-11e7-81ad-00232490c701', '发行时间：(\\S*)', null, 'p[2]/text()', null, null, '2017-05-12 00:26:32');
INSERT INTO `job_template_field` VALUES ('dea20b0d-354d-11e7-81ad-00232490c701', '0', 'songGenre', 'qq音乐指定音乐的流派', 'varchar', '255', null, '76a3bf16-3547-11e7-81ad-00232490c701', '流派：(.*)', null, 'ul/li[3]/text()', null, null, '2017-05-12 00:26:33');
INSERT INTO `job_template_field` VALUES ('e1023e31-ba4c-4940-b97a-75b382bf35f3', '0', 'detailUrl', '市安监局案件信息内容地址', 'varchar', '255', null, '2f4f7d28-451d-4006-86ef-49b50872d458', null, null, 'a/@href', null, null, '2017-05-12 00:26:33');
INSERT INTO `job_template_field` VALUES ('e1a367f8-3557-11e7-947a-b8aeed2fe120', '0', 'movieName', '讯多影视名称', 'varchar', '1024', null, 'fa463989-3556-11e7-947a-b8aeed2fe120', null, null, 'h1/text()', null, null, '2017-05-11 16:27:24');
INSERT INTO `job_template_field` VALUES ('e4482cb7-354d-11e7-947a-b8aeed2fe120', '0', 'url', '热片网详情url', 'varchar', '1024', null, '41a1ad3e-354d-11e7-947a-b8aeed2fe120', null, null, 'a/@href', null, null, '2017-05-11 16:27:24');
INSERT INTO `job_template_field` VALUES ('e473bd48-3523-11e7-947a-b8aeed2fe120', '0', 'movieTime', '中国高清年代', 'varchar', '1024', null, 'a17e9d1d-3523-11e7-947a-b8aeed2fe120', null, null, 'span[3]/text()', null, null, '2017-05-11 16:27:24');
INSERT INTO `job_template_field` VALUES ('e5d7a7e6-35e9-11e7-81ad-00232490c701', '0', 'songName', '5nd音乐网指定音乐的音乐名字', 'varchar', '255', null, '7382a702-35e9-11e7-81ad-00232490c701', null, null, 'h1/a/text()', null, null, '2017-05-12 00:26:33');
INSERT INTO `job_template_field` VALUES ('e8b2cc54-3556-11e7-97d9-0025ab9a7c2c', '0', 'bookName', '小说大全书名', 'varchar', '1024', null, 'd4aaf892-3556-11e7-97d9-0025ab9a7c2c', '《(.+)》', null, 'div[@class=\'tit_bg\']/h2', null, null, '2017-05-11 16:27:24');
INSERT INTO `job_template_field` VALUES ('ea276ee3-3576-11e7-81ad-00232490c701', '0', 'songUrl', '芒仔音乐铺搜索到的第一个音乐的详情地址', 'varchar', '255', null, 'ae78b7e4-3576-11e7-81ad-00232490c701', null, null, '@href', null, null, '2017-05-12 00:26:33');
INSERT INTO `job_template_field` VALUES ('eae97a1c-3482-11e7-81ad-00232490c701', '0', 'punishType', '行政处罚类型', 'varchar', '255', null, '7ecef0fa-3481-11e7-81ad-00232490c701', null, null, 'div[4]/span//tr[4]/td[2]/p/text()', null, null, '2017-05-12 00:26:33');
INSERT INTO `job_template_field` VALUES ('ecdf75f6-355f-11e7-97d9-0025ab9a7c2c', '0', 'type', '鲸鱼中文类型', 'varchar', '1024', null, '93b6d456-355e-11e7-97d9-0025ab9a7c2c', null, null, 'div[@class=\'brief\']/span/a[2]/text()', null, null, '2017-05-11 16:27:24');
INSERT INTO `job_template_field` VALUES ('ef9adce9-3481-11e7-81ad-00232490c701', '0', 'punishUnit', '行政处罚单位', 'varchar', '255', null, '7ecef0fa-3481-11e7-81ad-00232490c701', null, null, 'div[4]/span//tr[1]/td[4]/p/text()', null, null, '2017-05-12 00:26:33');
INSERT INTO `job_template_field` VALUES ('f2153a33-357d-11e7-81ad-00232490c701', '0', 'songSinger', '想听音乐网指定音乐的歌手名', 'varchar', '255', null, 'fca9bb42-357b-11e7-81ad-00232490c701', null, null, 'span[3]/a/span/text()', null, null, '2017-05-12 00:26:33');
INSERT INTO `job_template_field` VALUES ('f42638f6-3467-11e7-81ad-00232490c701', '0', 'principalNo', '主体执照注册号', 'varchar', '255', null, 'ef50c529-4e6e-4113-9f54-2270e54d7e2d', null, null, 'div[last()]/span/text()[1]', null, null, '2017-05-12 00:26:33');
INSERT INTO `job_template_field` VALUES ('f747f914-3489-11e7-81ad-00232490c701', '0', 'pageCount', '成都出入境检验检疫局行政处罚总页数', 'varchar', '255', null, '6cba3e48-3488-11e7-81ad-00232490c701', '\\d/(\\d+)页', null, 'div/text()', '{value}.encode(\'utf-8\')', null, '2017-05-12 00:26:33');
INSERT INTO `job_template_field` VALUES ('fb86c0d5-3616-11e7-81ad-00232490c701', '0', 'penaltyOrgan', '处罚决定机关', null, null, null, '48bdb527-35fb-11e7-81ad-00232490c701', '：(.*)', null, 'tr[9]/td/p/text()', '{value}.encode(\'utf-8\')', null, '2017-05-12 00:26:33');

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
INSERT INTO `job_template_param` VALUES ('04978e50-cce2-4604-8664-55dad3d84574', null, 'pageIndex', '市安监局案件信息第pageIndex页', '2', '{pageIndex}<={pageCount}', '{pageIndex}+1', null, null, null, '2f4f7d28-451d-4006-86ef-49b50872d458');
INSERT INTO `job_template_param` VALUES ('608de0a5-e13b-457f-8ee3-90683b8d6a82', null, 'pageIndex', '成都海关行政许可第pageIndex页', '2', '{pageIndex}<={pageCount}', '{pageIndex}+1', null, null, null, '58a05936-3dcb-4906-a27b-b3aeaa4124c0');
INSERT INTO `job_template_param` VALUES ('67f1a464-35fa-11e7-81ad-00232490c701', null, 'pageIndex', '成都出入境检验检疫局行政处罚第pageIndex页', '2', '{pageIndex}<={pageCount}', '{pageIndex}+1', null, null, null, '236f8237-35fa-11e7-81ad-00232490c701');
INSERT INTO `job_template_param` VALUES ('74bb429f-4cae-45d1-ad39-b16a3a9b0fd7', '0', 'pageIndex', '市农委行政处罚案件第pageIndex+1页', '1', '{pageIndex}<={pageCount}', '{pageIndex}+1', null, null, '0', 'bf0b362b-c6ee-4f2f-9693-fe82ba424bb6');
INSERT INTO `job_template_param` VALUES ('d691bb15-347c-11e7-81ad-00232490c701', null, 'pageIndex', '成都海关违法走私信息第pageIndex页', '2', '{pageIndex}<={pageCount}', '{pageIndex}+1', null, null, null, 'af654225-347c-11e7-81ad-00232490c701');

-- ----------------------------
-- Table structure for log_info
-- ----------------------------
DROP TABLE IF EXISTS `log_info`;
CREATE TABLE `log_info` (
  `ID` varchar(50) NOT NULL,
  `DEL_FLAG` tinyint(1) DEFAULT NULL,
  `CREATE_TIME` datetime DEFAULT CURRENT_TIMESTAMP,
  `USER_ID` varchar(50) DEFAULT NULL,
  `OBJECT_ID` varchar(50) DEFAULT NULL,
  `CONTENT` varchar(2048) DEFAULT NULL,
  `TYPE` varchar(5) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of log_info
-- ----------------------------

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
-- Records of p_area
-- ----------------------------

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
-- Records of p_base_info
-- ----------------------------

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
-- Records of p_content_info
-- ----------------------------

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
-- Records of p_field_weight
-- ----------------------------
INSERT INTO `p_field_weight` VALUES ('1', '0', '2017-05-12 00:16:14', 'movieDirector', '导演', '0', '6', null);
INSERT INTO `p_field_weight` VALUES ('2', '0', '2017-05-12 00:17:30', 'movieTime', '名称', '0', '2', null);
INSERT INTO `p_field_weight` VALUES ('3', '0', '2017-05-12 00:17:30', 'movieTime', '年代', '0', '2', null);
INSERT INTO `p_field_weight` VALUES ('4', '0', '2017-05-12 00:28:58', 'songAlbum', '专辑名', '1', null, null);

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
-- Records of p_ip_storage
-- ----------------------------

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
-- Records of p_save_evidence
-- ----------------------------

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
INSERT INTO `p_search_task_job` VALUES ('1', 'key', '刺客信条', '0', null, null, null, '0', null, '072241de-34b6-11e7-b41d-0025ab9a7c2c,2847be6c-3498-11e7-9285-0025ab9a7c2c,39feb7d2-3530-11e7-947a-b8aeed2fe120,41a1ad3e-354d-11e7-947a-b8aeed2fe120,45e1dade-3554-11e7-947a-b8aeed2fe120,65ade85c-3528-11e7-947a-b8aeed2fe120,740532f2-355d-11e7-947a-b8aeed2fe120,90a8e36f-3555-11e7-97d9-0025ab9a7c2c,93b6d456-355e-11e7-97d9-0025ab9a7c2c,b3bb56ae-3532-11e7-97d9-0025ab9a7c2c,c12161be-3494-11e7-aa20-b8aeed2fe120,c283b2c4-3521-11e7-947a-b8aeed2fe120,f4f1a890-354e-11e7-97d9-0025ab9a7c2c,ffe68206-352d-11e7-97d9-0025ab9a7c2c');

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
-- Records of p_task_flow
-- ----------------------------

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
  `object_id` varchar(1024) DEFAULT NULL COMMENT '名单id',
  `object_type` varchar(1024) DEFAULT NULL COMMENT '白名单还是黑屏单1，是白 2是黑',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of p_white_and_black_list
-- ----------------------------
INSERT INTO `p_white_and_black_list` VALUES ('1', '0', '', null, '2017-05-12 00:57:17', '0', null, null, null);

-- ----------------------------
-- Table structure for s_anti_vice_info
-- ----------------------------
DROP TABLE IF EXISTS `s_anti_vice_info`;
CREATE TABLE `s_anti_vice_info` (
  `ID` varchar(50) NOT NULL,
  `DEL_FLAG` tinyint(1) NOT NULL,
  `CREATE_TIME` datetime NOT NULL,
  `TOTAL_CNT` int(11) DEFAULT '0',
  `WEB_CNT` int(11) DEFAULT '0',
  `IMG_CNT` int(11) DEFAULT '0',
  `VIDEO_CNT` int(11) DEFAULT NULL,
  `TEXT_CNT` int(11) DEFAULT NULL,
  `SAVED_CNT` int(11) DEFAULT NULL,
  `ANTI_VICE_CNT` int(11) DEFAULT NULL,
  `INT_SURVEILLANCE_CNT` int(11) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of s_anti_vice_info
-- ----------------------------
INSERT INTO `s_anti_vice_info` VALUES ('44', '0', '2017-05-10 11:26:19', '10000', '0', '1', '444', '204', '100', '120', '1000');

-- ----------------------------
-- Table structure for s_area
-- ----------------------------
DROP TABLE IF EXISTS `s_area`;
CREATE TABLE `s_area` (
  `ID` varchar(50) NOT NULL,
  `CITY_ID` varchar(50) DEFAULT NULL,
  `LAT` double DEFAULT NULL,
  `LNG` double DEFAULT NULL,
  `CODE` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of s_area
-- ----------------------------
INSERT INTO `s_area` VALUES ('1', '320500', '120.37', '31.19', 'utf8');
INSERT INTO `s_area` VALUES ('10', '610100', '108.57', '34.16', null);
INSERT INTO `s_area` VALUES ('11', '440300', '114.04', '22.37', null);
INSERT INTO `s_area` VALUES ('12', '442000', '113.23', '22.31', null);
INSERT INTO `s_area` VALUES ('13', '441900', '113.45', '23.02', null);
INSERT INTO `s_area` VALUES ('14', '510100', '104.04', '30.4', null);
INSERT INTO `s_area` VALUES ('15', '310100', '121.29', '31.13', null);
INSERT INTO `s_area` VALUES ('16', 'HK_01', '114.06', '22.12', null);
INSERT INTO `s_area` VALUES ('17', '101', '0', '0', null);
INSERT INTO `s_area` VALUES ('2', '110100', '116.28', '39.55', null);
INSERT INTO `s_area` VALUES ('3', '330100', '120.11', '30.16', null);
INSERT INTO `s_area` VALUES ('4', '320600', '121.03', '32.05', null);
INSERT INTO `s_area` VALUES ('5', '330500', '120.06', '30.52', null);
INSERT INTO `s_area` VALUES ('6', '320100', '118.47', '32.02', null);
INSERT INTO `s_area` VALUES ('7', '320300', '117.12', '34.16', null);
INSERT INTO `s_area` VALUES ('8', '330300', '120.39', '28.01', null);
INSERT INTO `s_area` VALUES ('9', '321200', '119.54', '32.29', null);

-- ----------------------------
-- Table structure for s_gis_detail_info
-- ----------------------------
DROP TABLE IF EXISTS `s_gis_detail_info`;
CREATE TABLE `s_gis_detail_info` (
  `id` varchar(50) NOT NULL,
  `del_flag` tinyint(1) NOT NULL,
  `create_time` datetime NOT NULL,
  `content_type` tinyint(5) DEFAULT NULL COMMENT '盗版类型',
  `detail_kv` varchar(512) DEFAULT NULL COMMENT '检索关键字',
  `baidu_search_cnt` int(11) DEFAULT NULL,
  `haosou_search_cnt` int(11) DEFAULT NULL,
  `sougou_search_cnt` int(11) DEFAULT NULL,
  `weixin_search_cnt` int(11) DEFAULT NULL,
  `all_cnt` int(11) DEFAULT NULL COMMENT '任务相关数据总量',
  `suitability` varchar(50) DEFAULT '' COMMENT '基础信息匹配度',
  `suitability_range` int(11) DEFAULT NULL COMMENT '匹配范围',
  `genuine_info` varchar(512) DEFAULT '' COMMENT '正版基本信息',
  `piracy_info` varchar(512) DEFAULT '' COMMENT '盗版基本信息',
  `piracy_source` varchar(50) DEFAULT '' COMMENT '盗版源头',
  `estimated_impact_cnt` int(11) DEFAULT NULL COMMENT '预计影响量',
  `transmission_rate` varchar(50) DEFAULT '' COMMENT '传播率',
  `spread_scope` int(11) DEFAULT NULL COMMENT '传播范围',
  `resource_size` varchar(50) DEFAULT '' COMMENT '盗版资源内容大小',
  `resource_in_date` datetime DEFAULT NULL COMMENT '盗版资源上架时间',
  `network_cnt` int(11) DEFAULT NULL COMMENT '全网检测数据总量',
  `detail_area_id` varchar(50) DEFAULT NULL,
  `detail_url` varchar(512) DEFAULT NULL,
  `task_job_id` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of s_gis_detail_info
-- ----------------------------
INSERT INTO `s_gis_detail_info` VALUES ('1', '0', '2017-05-10 17:37:39', '0', '人民的名义', '45645', '4964545', '6456456', '4654564', '6456456', '90', '232423', '卧虎藏龙;张艺谋;九十年代', '卧虎藏蛇;张艺煤;九十年代', '百度', '234234', '66', '34534', '4353', '2017-05-10 17:41:24', '235423', '320500', 'http://www.bilibili.com/', 'dc1f763f4a9840aaa25fb6a782c43fd8');

-- ----------------------------
-- Table structure for s_gis_info
-- ----------------------------
DROP TABLE IF EXISTS `s_gis_info`;
CREATE TABLE `s_gis_info` (
  `id` varchar(50) NOT NULL,
  `del_flag` tinyint(1) NOT NULL,
  `create_time` datetime NOT NULL,
  `content_type` tinyint(5) DEFAULT NULL,
  `province_id` int(11) DEFAULT NULL,
  `province_cnt` int(11) DEFAULT NULL,
  `latit_longit` varchar(512) DEFAULT NULL,
  `task_job_id` varchar(50) DEFAULT NULL,
  `overseas_type` varchar(50) DEFAULT NULL,
  `overseas_cnt` int(11) DEFAULT NULL,
  `detail_area_id` varchar(50) DEFAULT NULL,
  `detail_url` varchar(512) DEFAULT NULL,
  `detail_cnt` int(11) DEFAULT NULL,
  `detail_kv` varchar(512) DEFAULT NULL,
  `detail_judicature` tinyint(5) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of s_gis_info
-- ----------------------------
INSERT INTO `s_gis_info` VALUES ('1', '0', '2017-05-10 20:55:13', '5', null, '34534534', '', 'dc1f763f4a9840aaa25fb6a782c43fd8', '0', '234234', '320500', 'http://www.bilibili.com/', '34234', '人民的名义', '2');
INSERT INTO `s_gis_info` VALUES ('10', '0', '2017-05-11 22:11:20', '5', null, '34567', null, '29189428ec14482e9f76070fe94ab646', '0', '98123', '610100', 'http://www.tonghuacun.com/', '43441', '奔跑吧兄弟', '1');
INSERT INTO `s_gis_info` VALUES ('11', '0', '2017-05-11 22:12:47', '5', null, '56732', null, '5158b1ba54814ba592949d3df229ce27', '0', '23412', '440300', 'http://www.repian.com/', '32124', '中国好声音', '0');
INSERT INTO `s_gis_info` VALUES ('12', '0', '2017-05-11 22:14:10', '3', null, '341234', null, '62645fc1e64149b9916f71b420b2a596', '0', '342331', '442000', 'http://www.dy2018.com/', '43465', '大话西游', '2');
INSERT INTO `s_gis_info` VALUES ('13', '0', '2017-05-11 22:15:20', '5', null, '32123', null, '9282c445010a478a824a6b16fef074ec', '0', '67853', '441900', 'http://www.zzlxs.net/', '9870', '刺客信条', '0');
INSERT INTO `s_gis_info` VALUES ('14', '0', '2017-05-11 22:17:45', '3', null, '341234', null, '80eec40e12094c54ba6b49c883167580', '0', '6578', '510100', 'http://www.dy166.net/', '34235', '当幸福来敲门', '0');
INSERT INTO `s_gis_info` VALUES ('15', '0', '2017-05-11 22:20:28', '5', null, '55543', null, 'f513036f271c410dac1a1c192cc5e70f', '0', '4442', '310100', 'http://www.nk77.com/view/49692/', '12342', '笑傲江湖', '1');
INSERT INTO `s_gis_info` VALUES ('16', '0', '2017-05-11 22:22:04', '1', null, '32322', null, 'ce511c91c1bb4effa21d38dc4347018f', '0', '2221', 'HK_01', 'http://www.loldytt.com/', '11112', '高能少年团', '2');
INSERT INTO `s_gis_info` VALUES ('17', '0', '2017-05-11 23:23:47', '1', null, '31231', null, '3510e7edf99f4c5b85b6195a64be1a25', '1', '12312', '101', 'http://www.ikua.cc/', '32322', '吸血鬼日记', '0');
INSERT INTO `s_gis_info` VALUES ('18', '0', '2017-05-11 23:26:11', '1', null, '32412', null, '0621d10397fc4fccbbd85c9da33b8dee', '1', '3412', '101', 'http://www.51rrkank.com/', '12312', '釜山行', '1');
INSERT INTO `s_gis_info` VALUES ('19', '0', '2017-05-11 23:26:45', '2', null, '231231', null, 'dd2890da230a4c099bab0edab0444d10', '1', '23112', '101', 'http://www.beiwo.tv/', '3242', '海贼王', '2');
INSERT INTO `s_gis_info` VALUES ('2', '0', '2017-05-11 20:32:28', '1', null, '234234', null, '90921bff7d65488ea008a777fecbbeb6', '0', '34234', '110100', 'http://www.360kan.com/', '34234', '海贼王', '2');
INSERT INTO `s_gis_info` VALUES ('21', '0', '2017-05-11 23:28:45', '5', null, '234234', null, 'd587ff7904fb4a35aaebfd68d36c7b5d', '1', '42342', '101', 'www.vv60.com', '23423', '美丽人生', '0');
INSERT INTO `s_gis_info` VALUES ('22', '0', '2017-05-11 23:31:05', '1', null, '2313123', null, 'd8f1045e29904fceb8196d180aa67e4d', '1', '23424', '101', 'http://www.cc82.cc/', '4234', '卧虎藏龙', '1');
INSERT INTO `s_gis_info` VALUES ('3', '0', '2017-05-11 20:41:00', '2', null, '342432', null, 'a794b2ea602b4fa1bd3a46b461d54830', '0', '34234', '330100', 'http://v.baidu.com/', '34234', '心术', '1');
INSERT INTO `s_gis_info` VALUES ('4', '0', '2017-05-11 20:43:03', '3', null, '2342342', null, '133bd52e5cd14ae7ac89fdd6c96306b2', '0', '23423', '320600', 'http://www.mgtv.com/1', '234234', '奇葩说', '0');
INSERT INTO `s_gis_info` VALUES ('5', '0', '2017-05-11 20:44:01', '4', null, '34234', null, 'a101436612ea4eb9baa2c1098c6fa958', '0', '242342', '330500', 'http://www.ku6.com/', '234234', '快乐大本营', '2');
INSERT INTO `s_gis_info` VALUES ('6', '0', '2017-05-11 21:34:11', '1', null, '12345', null, 'a455d4ee4cb1441a97a4593ae94abba0', '0', '12345', '320100', 'http://v.ifeng.com/', '23345', '海上钢琴师', '0');
INSERT INTO `s_gis_info` VALUES ('7', '0', '2017-05-11 21:37:00', '1', null, '56789', null, '971933ce311b4c578ca5f5a057d8e8a0', '0', '67890', '320300', 'http://www.56.com/', '34521', '生化危机', '1');
INSERT INTO `s_gis_info` VALUES ('8', '0', '2017-05-11 21:39:42', '1', null, '12345', null, 'a3d10c7735a64d6facf4fa8211cf505a', '0', '97612', '330300', 'http://www.v1.cn/', '12356', '速度与激情', '0');
INSERT INTO `s_gis_info` VALUES ('9', '0', '2017-05-11 22:09:36', '2', null, '456787', null, 'eaee145510b2422fac2456c52da18a8b', '0', '43523', '321200', 'http://xiyou.cntv.cn/', '34563', '叶问', '2');

-- ----------------------------
-- Table structure for s_highcharts_info
-- ----------------------------
DROP TABLE IF EXISTS `s_highcharts_info`;
CREATE TABLE `s_highcharts_info` (
  `id` varchar(50) NOT NULL,
  `DEL_FLAG` tinyint(1) NOT NULL,
  `CREATE_TIME` datetime NOT NULL,
  `TOTAL_CNT` int(11) DEFAULT NULL,
  `CONTENT_TYPE` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of s_highcharts_info
-- ----------------------------
INSERT INTO `s_highcharts_info` VALUES ('0', '0', '2017-05-11 16:04:16', '1000', '0');
INSERT INTO `s_highcharts_info` VALUES ('1', '0', '2017-05-11 16:05:14', '222', '1');
INSERT INTO `s_highcharts_info` VALUES ('2', '0', '2017-05-11 16:05:26', '25689', '2');
INSERT INTO `s_highcharts_info` VALUES ('3', '0', '2017-05-11 16:05:40', '5575', '3');
INSERT INTO `s_highcharts_info` VALUES ('4', '0', '2017-05-11 16:05:50', '79587', '4');
INSERT INTO `s_highcharts_info` VALUES ('5', '0', '2017-05-11 16:06:02', '5547', '5');
INSERT INTO `s_highcharts_info` VALUES ('6', '0', '2017-05-11 16:06:12', '87144', '6');

-- ----------------------------
-- Table structure for s_hot_info
-- ----------------------------
DROP TABLE IF EXISTS `s_hot_info`;
CREATE TABLE `s_hot_info` (
  `ID` varchar(50) NOT NULL,
  `DEL_FLAG` tinyint(1) NOT NULL,
  `CREATE_TIME` datetime NOT NULL,
  `PERIOD_TYPE` smallint(6) DEFAULT NULL,
  `TIME_DIS` varchar(512) DEFAULT NULL,
  `CONTENT_TYPE` smallint(6) DEFAULT NULL,
  `SOURCE_URL` varchar(2048) DEFAULT NULL,
  `RANK_ID` varchar(10) DEFAULT NULL,
  `EXPONENT` varchar(512) DEFAULT NULL,
  `HOT_TREND` smallint(6) DEFAULT NULL,
  `DETAIL_IMG` varchar(512) DEFAULT NULL,
  `DETAIL_INFO` varchar(2048) DEFAULT NULL,
  `KEY_WORDS` varchar(512) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of s_hot_info
-- ----------------------------
INSERT INTO `s_hot_info` VALUES ('0', '0', '2017-05-09 19:27:39', '1', '0', '0', '0', '1', '0', '0', null, null, '人民的名义');
INSERT INTO `s_hot_info` VALUES ('1', '0', '2017-05-10 15:06:34', '1', '02', '0', '1', '2', '242', '1', null, null, '万年历');
INSERT INTO `s_hot_info` VALUES ('2', '0', '2017-05-10 15:54:31', '1', '2017-05-09', '0', '22', '3', '02', '2', null, null, 'PPD');
INSERT INTO `s_hot_info` VALUES ('3', '0', '2017-05-10 16:06:23', '1', '2017-05-10', '1', '22', '4', '0', '0', null, null, '五五开');
INSERT INTO `s_hot_info` VALUES ('4', '0', '2017-05-10 16:06:46', '1', '2017-05-11', '1', '12', '5', '50', '1', null, null, '东莞时间');
INSERT INTO `s_hot_info` VALUES ('5', '0', '2017-05-10 17:11:54', '1', '2017-05-11', '2', '22', '6', '55', '2', null, null, '皇朝酒吧');

-- ----------------------------
-- Table structure for s_judicature_info
-- ----------------------------
DROP TABLE IF EXISTS `s_judicature_info`;
CREATE TABLE `s_judicature_info` (
  `ID` varchar(50) NOT NULL,
  `DEL_FLAG` tinyint(1) NOT NULL DEFAULT '0',
  `CREATE_TIME` datetime NOT NULL,
  `SAVING_CNT` int(11) DEFAULT NULL,
  `SAVED_CNT` int(11) DEFAULT NULL,
  `CHANGED_CNT` int(11) DEFAULT NULL,
  `COMPROMISE_CNT` int(11) DEFAULT NULL,
  `PURSUE_CNT` int(11) DEFAULT NULL,
  `ADJUDGED_CNT` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of s_judicature_info
-- ----------------------------

-- ----------------------------
-- Table structure for s_taskstatus_info
-- ----------------------------
DROP TABLE IF EXISTS `s_taskstatus_info`;
CREATE TABLE `s_taskstatus_info` (
  `id` varchar(50) NOT NULL,
  `del_flag` tinyint(1) NOT NULL,
  `create_time` datetime NOT NULL,
  `content_type` tinyint(5) DEFAULT NULL,
  `task_job_id` varchar(50) DEFAULT NULL,
  `task_status` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of s_taskstatus_info
-- ----------------------------
INSERT INTO `s_taskstatus_info` VALUES ('1', '0', '2017-05-09 09:37:40', '1', 'b77be89e929b4d5e874e34c64bfffdc6', '0');
INSERT INTO `s_taskstatus_info` VALUES ('10', '0', '2017-05-09 09:44:20', '2', 'ccc9e031128a4fa980c542868fa8a884', '0');
INSERT INTO `s_taskstatus_info` VALUES ('11', '0', '2017-05-09 09:44:34', '3', '97f87db16e194e95ab174a5e95fbc262', '1');
INSERT INTO `s_taskstatus_info` VALUES ('12', '0', '2017-05-09 09:44:47', '4', '72ceee1ac93941bcbef74faa0173368d', '2');
INSERT INTO `s_taskstatus_info` VALUES ('13', '0', '2017-05-09 09:45:01', '1', '3b0a5a6938604f63af9ddf2d793924a0', '0');
INSERT INTO `s_taskstatus_info` VALUES ('14', '0', '2017-05-09 09:45:20', '2', '3a90da1d1f2041288480604056c9f2e0', '1');
INSERT INTO `s_taskstatus_info` VALUES ('15', '0', '2017-05-09 09:45:38', '3', 'fd36fb87cb104b92843b7ad2eac433f2', '2');
INSERT INTO `s_taskstatus_info` VALUES ('16', '0', '2017-05-09 09:45:56', '4', '2c0ef4c7e77644ddb1673ff12195a23b', '0');
INSERT INTO `s_taskstatus_info` VALUES ('2', '0', '2017-05-09 09:41:50', '2', '2288e23c65064de0b53d35941f35dcc0', '1');
INSERT INTO `s_taskstatus_info` VALUES ('3', '0', '2017-05-09 09:42:09', '3', '165b83e8f74b4fb1835cd0a0874b2927', '2');
INSERT INTO `s_taskstatus_info` VALUES ('4', '0', '2017-05-09 09:42:28', '4', '9b8a4ef83be74b05922fb7905d9e5a72', '0');
INSERT INTO `s_taskstatus_info` VALUES ('5', '0', '2017-05-09 09:42:49', '1', '83791636486b4146974535cea2967cb4', '1');
INSERT INTO `s_taskstatus_info` VALUES ('6', '0', '2017-05-09 09:43:05', '2', '8c735490eedd4663a7ba4e7e745b7737', '2');
INSERT INTO `s_taskstatus_info` VALUES ('7', '0', '2017-05-09 09:43:20', '3', 'e35c51b421b240beb6d75d32e31dd480', '0');
INSERT INTO `s_taskstatus_info` VALUES ('8', '0', '2017-05-09 09:43:44', '4', '51e71031b4b94b9f98ffe7f4f7802092', '1');
INSERT INTO `s_taskstatus_info` VALUES ('9', '0', '2017-05-09 09:44:06', '1', 'a974eda7679d4ade8df76c613e440e7c', '2');

-- ----------------------------
-- Table structure for s_tort_info
-- ----------------------------
DROP TABLE IF EXISTS `s_tort_info`;
CREATE TABLE `s_tort_info` (
  `id` varchar(50) NOT NULL,
  `del_flag` tinyint(1) NOT NULL,
  `create_time` datetime NOT NULL,
  `content_type` tinyint(5) DEFAULT NULL,
  `total_cnt` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of s_tort_info
-- ----------------------------
INSERT INTO `s_tort_info` VALUES ('1', '0', '2017-05-08 16:20:52', '0', '50000');
INSERT INTO `s_tort_info` VALUES ('2', '0', '2017-05-08 16:21:38', '1', '8999');
INSERT INTO `s_tort_info` VALUES ('3', '0', '2017-05-08 16:22:10', '2', '19999');
INSERT INTO `s_tort_info` VALUES ('4', '0', '2017-05-08 16:22:31', '3', '29999');
INSERT INTO `s_tort_info` VALUES ('5', '0', '2017-05-08 16:22:52', '4', '3');
INSERT INTO `s_tort_info` VALUES ('6', '0', '2017-05-09 14:58:38', '5', '1000');

-- ----------------------------
-- Table structure for s_total_info
-- ----------------------------
DROP TABLE IF EXISTS `s_total_info`;
CREATE TABLE `s_total_info` (
  `id` varchar(50) NOT NULL,
  `del_flag` tinyint(1) NOT NULL,
  `create_time` datetime NOT NULL,
  `period_type` tinyint(5) DEFAULT NULL,
  `time_dis` varchar(50) DEFAULT NULL,
  `content_type` tinyint(5) DEFAULT NULL,
  `tort_cnt` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of s_total_info
-- ----------------------------
INSERT INTO `s_total_info` VALUES ('1', '0', '2017-05-07 14:26:09', '2', '20170508', '0', '10000');
INSERT INTO `s_total_info` VALUES ('10', '0', '2017-05-08 15:51:07', '0', '20170508', '4', '784');
INSERT INTO `s_total_info` VALUES ('11', '0', '2017-05-08 15:51:41', '1', '20170508', '0', '6658');
INSERT INTO `s_total_info` VALUES ('12', '0', '2017-05-08 15:52:11', '1', '20170508', '1', '456');
INSERT INTO `s_total_info` VALUES ('13', '0', '2017-05-08 15:52:33', '1', '20170508', '2', '789');
INSERT INTO `s_total_info` VALUES ('14', '0', '2017-05-08 15:52:46', '1', '20170508', '3', '2163');
INSERT INTO `s_total_info` VALUES ('15', '0', '2017-05-08 15:53:08', '1', '20170508', '4', '3654');
INSERT INTO `s_total_info` VALUES ('16', '0', '2017-05-09 14:42:46', '0', '20170508', '5', '523');
INSERT INTO `s_total_info` VALUES ('17', '0', '2017-05-09 14:43:23', '1', '20170508', '5', '156');
INSERT INTO `s_total_info` VALUES ('18', '0', '2017-05-09 14:43:40', '2', '20170508', '5', '86');
INSERT INTO `s_total_info` VALUES ('2', '0', '2017-05-08 14:26:58', '2', '20170508', '1', '99');
INSERT INTO `s_total_info` VALUES ('3', '0', '2017-05-09 14:27:44', '2', '20170508', '2', '199');
INSERT INTO `s_total_info` VALUES ('4', '0', '2017-05-10 14:27:58', '2', '20170508', '3', '299');
INSERT INTO `s_total_info` VALUES ('5', '0', '2017-05-11 14:28:16', '2', '20170508', '4', '399');
INSERT INTO `s_total_info` VALUES ('6', '0', '2017-05-12 15:49:03', '0', '20170508', '0', '2000');
INSERT INTO `s_total_info` VALUES ('7', '0', '2017-05-06 15:50:01', '0', '20170508', '1', '125');
INSERT INTO `s_total_info` VALUES ('8', '0', '2017-05-08 15:50:26', '0', '20170508', '2', '146');
INSERT INTO `s_total_info` VALUES ('9', '0', '2017-05-08 15:50:48', '0', '20170508', '3', '455');

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
  `proxy_id` varchar(255) DEFAULT NULL COMMENT '代理id关联proxy_info',
  `content_type_id` varchar(50) DEFAULT NULL COMMENT '类型关联contentType',
  `execute_status` varchar(8) DEFAULT NULL COMMENT '执行状态',
  `page_offset` int(5) DEFAULT '1' COMMENT '翻页增量',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of task_job
-- ----------------------------

-- ----------------------------
-- Table structure for task_job_re_field
-- ----------------------------
DROP TABLE IF EXISTS `task_job_re_field`;
CREATE TABLE `task_job_re_field` (
  `ID` varchar(50) NOT NULL,
  `DEL_FLAG` tinyint(1) DEFAULT NULL,
  `TASK_JOB_ID` varchar(50) DEFAULT NULL,
  `JOB_TEMPALTE_FIELD_ID` varchar(50) DEFAULT NULL,
  `JOB_TEMPLATE_ID` varchar(50) DEFAULT NULL,
  `CREATE_TIME` datetime DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of task_job_re_field
-- ----------------------------

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

-- ----------------------------
-- Records of task_job_timer
-- ----------------------------

-- ----------------------------
-- Table structure for t_dynamic_pc_info
-- ----------------------------
DROP TABLE IF EXISTS `t_dynamic_pc_info`;
CREATE TABLE `t_dynamic_pc_info` (
  `ID` varchar(50) NOT NULL,
  `ASSETID` varchar(50) DEFAULT NULL,
  `IP` varchar(50) DEFAULT NULL,
  `MEMORY` varchar(50) DEFAULT NULL,
  `CPU` varchar(50) DEFAULT NULL,
  `IO` varchar(50) DEFAULT NULL,
  `ONLINE_TIME` varchar(50) DEFAULT NULL,
  `LOADAVG` varchar(50) DEFAULT NULL,
  `CREATE_DATE` datetime DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `ASSETID` (`ASSETID`),
  CONSTRAINT `t_dynamic_pc_info_ibfk_1` FOREIGN KEY (`ASSETID`) REFERENCES `t_static_pc_info` (`ASSETID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_dynamic_pc_info
-- ----------------------------
INSERT INTO `t_dynamic_pc_info` VALUES ('1', '1', '1', '1', '1', '1', '1', '1', '2017-04-19 10:32:42');
INSERT INTO `t_dynamic_pc_info` VALUES ('2', '2', '2', '2', '2', '2', '2', '2', '2017-04-20 10:32:55');
INSERT INTO `t_dynamic_pc_info` VALUES ('3', '3', '3', '3', '3', '3', '3', '3', '2017-04-19 10:33:09');
INSERT INTO `t_dynamic_pc_info` VALUES ('4', '2', '4', '2', '2', '4', '4', '4', '2017-04-21 10:35:32');

-- ----------------------------
-- Table structure for t_static_pc_info
-- ----------------------------
DROP TABLE IF EXISTS `t_static_pc_info`;
CREATE TABLE `t_static_pc_info` (
  `ASSETID` varchar(50) NOT NULL,
  `IP` varchar(50) DEFAULT NULL,
  `MEMORY` varchar(50) DEFAULT NULL,
  `HOSTNAME` varchar(320) DEFAULT NULL,
  `CPUPHYSICALNUM` varchar(1024) DEFAULT NULL,
  `DISKTOTAL` varchar(1024) DEFAULT NULL,
  `CPU_TOTAL` varchar(50) DEFAULT NULL,
  `CPU_CORE_NUM` varchar(50) DEFAULT NULL,
  `DEPLOYMENT` varchar(10) DEFAULT NULL,
  `STATUS` varchar(10) DEFAULT NULL,
  `CREATE_DATE` datetime DEFAULT NULL,
  `UPDATE_DATE` datetime DEFAULT NULL,
  `LOG_URL` varchar(1024) DEFAULT NULL,
  PRIMARY KEY (`ASSETID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_static_pc_info
-- ----------------------------
INSERT INTO `t_static_pc_info` VALUES ('1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '2017-04-19 10:31:32', '2017-04-19 10:31:35', '1');
INSERT INTO `t_static_pc_info` VALUES ('2', '2', '2', '2', '2', '2', '2', '2', '2', '2', '2017-04-19 10:31:59', '2017-04-19 10:32:03', '2');
INSERT INTO `t_static_pc_info` VALUES ('3', '3', '3', '3', '3', '3', '3', '3', '3', '3', '2017-04-19 10:32:17', '2017-04-19 10:32:21', '3');

-- ----------------------------
-- Table structure for url_re_city
-- ----------------------------
DROP TABLE IF EXISTS `url_re_city`;
CREATE TABLE `url_re_city` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(250) DEFAULT NULL,
  `url` varchar(250) DEFAULT NULL,
  `type` int(11) DEFAULT NULL,
  `ip` varchar(50) DEFAULT NULL,
  `country` varchar(50) DEFAULT NULL,
  `country_id` varchar(50) DEFAULT NULL,
  `area` varchar(50) DEFAULT NULL,
  `area_id` varchar(50) DEFAULT NULL,
  `region` varchar(50) DEFAULT NULL,
  `region_id` varchar(50) DEFAULT NULL,
  `city` varchar(50) DEFAULT NULL,
  `city_id` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=453 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of url_re_city
-- ----------------------------
INSERT INTO `url_re_city` VALUES ('3', '哔哩哔哩动画', 'http://www.bilibili.com/', '1', '180.97.199.10', '中国', 'CN', '华东', '300000', '江苏省', '320000', '苏州市', '320500');
INSERT INTO `url_re_city` VALUES ('4', '360影视', 'http://www.360kan.com/', '1', '220.181.157.98', '中国', 'CN', '华北', '100000', '北京市', '110000', '北京市', '110100');
INSERT INTO `url_re_city` VALUES ('5', '百度视频', 'http://v.baidu.com/', '1', '115.239.210.38', '中国', 'CN', '华东', '300000', '浙江省', '330000', '杭州市', '330100');
INSERT INTO `url_re_city` VALUES ('6', '芒果TV', 'http://www.mgtv.com/1', '1', '58.221.78.39', '中国', 'CN', '华东', '300000', '江苏省', '320000', '南通市', '320600');
INSERT INTO `url_re_city` VALUES ('7', '酷6网', 'http://www.ku6.com/', '1', '180.97.235.68', '中国', 'CN', '华东', '300000', '江苏省', '320000', '苏州市', '320500');
INSERT INTO `url_re_city` VALUES ('8', '响巢看看', 'http://www.kankan.com/?id=731002', '1', '183.131.178.75', '中国', 'CN', '华东', '300000', '浙江省', '330000', '湖州市', '330500');
INSERT INTO `url_re_city` VALUES ('9', '凤凰视频', 'http://v.ifeng.com/', '1', '61.155.237.56', '中国', 'CN', '华东', '300000', '江苏省', '320000', '南京市', '320100');
INSERT INTO `url_re_city` VALUES ('10', '56网', 'http://www.56.com/', '1', '221.229.202.148', '中国', 'CN', '华东', '300000', '江苏省', '320000', '徐州市', '320300');
INSERT INTO `url_re_city` VALUES ('11', '乐视网', 'http://www.le.com/', '1', '221.229.202.149', '中国', 'CN', '华东', '300000', '江苏省', '320000', '徐州市', '320300');
INSERT INTO `url_re_city` VALUES ('12', '人民电视', 'http://tv.people.com.cn/', '1', '180.97.235.68', '中国', 'CN', '华东', '300000', '江苏省', '320000', '苏州市', '320500');
INSERT INTO `url_re_city` VALUES ('13', '风行高清电影', 'http://www.fun.tv/?alliance=63645', '1', '220.181.167.6', '中国', 'CN', '华北', '100000', '北京市', '110000', '北京市', '110100');
INSERT INTO `url_re_city` VALUES ('14', '第一视频', 'http://www.v1.cn/', '1', '122.228.92.75', '中国', 'CN', '华东', '300000', '浙江省', '330000', '温州市', '330300');
INSERT INTO `url_re_city` VALUES ('15', '环球网视频', 'http://v.huanqiu.com/', '1', '180.101.217.141', '中国', 'CN', '华东', '300000', '江苏省', '320000', '扬州市', '321000');
INSERT INTO `url_re_city` VALUES ('16', 'PPTV网络电视', 'http://www.pptv.com/', '1', '202.102.68.102', '中国', 'CN', '华东', '300000', '江苏省', '320000', '南京市', '320100');
INSERT INTO `url_re_city` VALUES ('17', 'PPS影音', 'http://www.pps.tv/', '1', '58.220.49.142', '中国', 'CN', '华东', '300000', '江苏省', '320000', '扬州市', '321000');
INSERT INTO `url_re_city` VALUES ('18', '爱西柚视频', 'http://xiyou.cntv.cn/', '1', '58.222.19.59', '中国', 'CN', '华东', '300000', '江苏省', '320000', '泰州市', '321200');
INSERT INTO `url_re_city` VALUES ('19', '激动网', 'http://www.joy.cn/', '1', '122.227.201.86', '中国', 'CN', '华东', '300000', '浙江省', '330000', '宁波市', '330200');
INSERT INTO `url_re_city` VALUES ('20', '优米网', 'http://www.youmi.cn/', '1', '123.103.21.247', '中国', 'CN', '华北', '100000', '北京市', '110000', '北京市', '110100');
INSERT INTO `url_re_city` VALUES ('21', '淘米视频', 'http://v.61.com/', '1', '58.221.40.46', '中国', 'CN', '华东', '300000', '江苏省', '320000', '南通市', '320600');
INSERT INTO `url_re_city` VALUES ('22', '爱拍原创', 'http://www.aipai.com/', '1', '58.223.166.226', '中国', 'CN', '华东', '300000', '江苏省', '320000', '淮安市', '320800');
INSERT INTO `url_re_city` VALUES ('23', '爆米花视频', 'http://www.baomihua.com/', '1', '49.79.232.225', '中国', 'CN', '华东', '300000', '江苏省', '320000', '南京市', '320100');
INSERT INTO `url_re_city` VALUES ('24', '童话村', 'http://www.tonghuacun.com/', '1', '117.23.50.24', '中国', 'CN', '西北', '600000', '陕西省', '610000', '西安市', '610100');
INSERT INTO `url_re_city` VALUES ('25', '神马影院', 'http://www.ikua.cc/', '1', '23.225.167.40', '美国', 'US', '', '', '', '', '', '101');
INSERT INTO `url_re_city` VALUES ('26', '热片网', 'http://www.repian.com/', '1', '183.2.191.9', '中国', 'CN', '华南', '800000', '广东省', '440000', '深圳市', '440300');
INSERT INTO `url_re_city` VALUES ('27', '电影天堂', 'http://www.dy2018.com/', '1', '121.201.45.144', '中国', 'CN', '华南', '800000', '广东省', '440000', '中山市', '442000');
INSERT INTO `url_re_city` VALUES ('28', '人人影视', 'http://www.51rrkank.com/', '1', '180.150.230.201', '韩国', 'KR', '', '', '', '', '', '101');
INSERT INTO `url_re_city` VALUES ('29', '飘花电影网', 'http://www.piaohua.com/', '1', '192.151.230.248', '美国', 'US', '', '', '', '', '', '');
INSERT INTO `url_re_city` VALUES ('30', '阳光电影', 'http://www.ygdy8.com/', '1', '23.234.1.21', '美国', 'US', '', '', '', '', '', '');
INSERT INTO `url_re_city` VALUES ('31', '天天影院', 'http://www.zzlxs.net/', '1', '119.147.114.163', '中国', 'CN', '华南', '800000', '广东省', '440000', '东莞市', '441900');
INSERT INTO `url_re_city` VALUES ('32', '乐乐影视', 'http://www.85de.com/llyy.html', '1', '103.15.122.52', '香港', 'HK', '', '', '香港特别行政区', 'HK_01', '', '');
INSERT INTO `url_re_city` VALUES ('33', '九九影院', 'http://www.997v.com/', '1', '107.151.202.11', '美国', 'US', '', '', '', '', '', '');
INSERT INTO `url_re_city` VALUES ('34', '1905电影网', 'http://www.1905.com/mdb/film/list/country-USA/', '1', '222.186.140.75', '中国', 'CN', '华东', '300000', '江苏省', '320000', '镇江市', '321100');
INSERT INTO `url_re_city` VALUES ('35', '一流影院', 'http://www.dy166.net/', '1', '218.247.81.122', '中国', 'CN', '西南', '500000', '四川省', '510000', '成都市', '510100');
INSERT INTO `url_re_city` VALUES ('36', '琪琪影院', 'http://www.nk77.com/view/49692/', '1', '115.159.161.186', '中国', 'CN', '华东', '300000', '上海市', '310000', '上海市', '310100');
INSERT INTO `url_re_city` VALUES ('37', 'LOL电影天堂', 'http://www.loldytt.com/', '1', '47.90.50.147', '香港', 'HK', '', '', '香港特别行政区', 'HK_01', '', '');
INSERT INTO `url_re_city` VALUES ('38', '2345影视', 'http://dianying.2345.com/', '1', '221.228.75.191', '中国', 'CN', '华东', '300000', '江苏省', '320000', '无锡市', '320200');
INSERT INTO `url_re_city` VALUES ('39', '西瓜电影', 'http://www.xigua110.com/', '1', '121.201.45.173', '中国', 'CN', '华南', '800000', '广东省', '440000', '中山市', '442000');
INSERT INTO `url_re_city` VALUES ('40', 'ck电影网', 'http://www.ckck.tv/', '1', '58.211.137.87', '中国', 'CN', '华东', '300000', '江苏省', '320000', '苏州市', '320500');
INSERT INTO `url_re_city` VALUES ('41', '吉吉影音', 'http://www.iskdy.com/', '1', '121.201.77.132', '中国', 'CN', '华南', '800000', '广东省', '440000', '中山市', '442000');
INSERT INTO `url_re_city` VALUES ('42', '放电影网', 'http://www.fangdianying.tv/gufanbuzishang/', '1', '119.28.61.71', '中国', 'CN', '华北', '100000', '北京市', '110000', '北京市', '110100');
INSERT INTO `url_re_city` VALUES ('43', '圣城家园', 'http://www.cnscg.com/', '1', '58.211.137.231', '中国', 'CN', '华东', '300000', '江苏省', '320000', '苏州市', '320500');
INSERT INTO `url_re_city` VALUES ('44', '中国高清网', 'http://gaoqing.la/xxx-the-return-of-xander-cage.html', '1', '119.188.97.209', '中国', 'CN', '华东', '300000', '山东省', '370000', '济南市', '370100');
INSERT INTO `url_re_city` VALUES ('45', '迅雷电影天堂', 'http://www.xldytt.com/forum-34-1.html', '1', '122.10.95.58', '香港', 'HK', '', '', '香港特别行政区', 'HK_01', '', '');
INSERT INTO `url_re_city` VALUES ('46', '小调网', 'http://www.xiaopian.com/', '1', '121.201.121.21', '中国', 'CN', '华南', '800000', '广东省', '440000', '中山市', '442000');
INSERT INTO `url_re_city` VALUES ('47', '豆瓣电影', 'https://movie.douban.com/subject/26688480/?tag=热门&from=gaia', '1', '115.182.201.6', '中国', 'CN', '华北', '100000', '北京市', '110000', '北京市', '110100');
INSERT INTO `url_re_city` VALUES ('48', '80s手机电影', 'http://www.80s.tw/', '1', '58.222.42.9', '中国', 'CN', '华东', '300000', '江苏省', '320000', '泰州市', '321200');
INSERT INTO `url_re_city` VALUES ('49', '被窝电影', 'http://www.beiwo.tv/', '1', '106.185.55.150', '日本', 'JP', '', '', '', '', '', '101');
INSERT INTO `url_re_city` VALUES ('50', '6V电影网', 'http://www.6vhao.net/', '1', '23.234.1.21', '美国', 'US', '', '', '', '', '', '');
INSERT INTO `url_re_city` VALUES ('51', '多特电影', 'http://www.dotdy.com/', '1', '223.202.123.103', '中国', 'CN', '华北', '100000', '北京市', '110000', '北京市', '110100');
INSERT INTO `url_re_city` VALUES ('52', '八哥电影', 'http://www.8gdyhd.com/', '1', '125.88.190.11', '中国', 'CN', '华南', '800000', '广东省', '440000', '佛山市', '440600');
INSERT INTO `url_re_city` VALUES ('53', '7060手机电影', 'http://www.7060.la/', '1', '103.38.64.46', '香港', 'HK', '', '', '香港特别行政区', 'HK_01', '', '');
INSERT INTO `url_re_city` VALUES ('54', '优酷', 'www.youku.com', '1', '106.11.186.2', '中国', 'CN', '华北', '100000', '河北省', '130000', '张家口市', '130700');
INSERT INTO `url_re_city` VALUES ('55', '爱奇艺', 'www.iqiyi.com', '1', '58.220.49.142', '中国', 'CN', '华东', '300000', '江苏省', '320000', '扬州市', '321000');
INSERT INTO `url_re_city` VALUES ('56', '腾讯', 'V.qq.com', '1', '58.216.6.22', '中国', 'CN', '华东', '300000', '江苏省', '320000', '常州市', '320400');
INSERT INTO `url_re_city` VALUES ('57', '乐视', 'www.letv.com', '1', '221.229.202.149', '中国', 'CN', '华东', '300000', '江苏省', '320000', '徐州市', '320300');
INSERT INTO `url_re_city` VALUES ('58', '哔哩哔哩', 'www.bilibili.com', '1', '180.97.199.9', '中国', 'CN', '华东', '300000', '江苏省', '320000', '苏州市', '320500');
INSERT INTO `url_re_city` VALUES ('59', '搜狐视频', 'tv.sohu.com', '1', '101.227.172.11', '中国', 'CN', '华东', '300000', '上海市', '310000', '上海市', '310100');
INSERT INTO `url_re_city` VALUES ('60', 'AcFun', 'www.acfun.com', '1', '202.102.110.203', '中国', 'CN', '华东', '300000', '江苏省', '320000', '南京市', '320100');
INSERT INTO `url_re_city` VALUES ('61', '360影视', 'www.360kan.com', '1', '220.181.157.98', '中国', 'CN', '华北', '100000', '北京市', '110000', '北京市', '110100');
INSERT INTO `url_re_city` VALUES ('62', '土豆网', 'www.tudou.com', '1', '106.11.186.2', '中国', 'CN', '华北', '100000', '河北省', '130000', '张家口市', '130700');
INSERT INTO `url_re_city` VALUES ('63', '响巢看看', 'www.kankan.com', '1', '183.131.178.75', '中国', 'CN', '华东', '300000', '浙江省', '330000', '湖州市', '330500');
INSERT INTO `url_re_city` VALUES ('64', '酷6网', 'www.ku6.com', '1', '180.97.235.68', '中国', 'CN', '华东', '300000', '江苏省', '320000', '苏州市', '320500');
INSERT INTO `url_re_city` VALUES ('65', '凤凰视频', 'v.ifeng.com', '1', '61.147.210.175', '中国', 'CN', '华东', '300000', '江苏省', '320000', '南通市', '320600');
INSERT INTO `url_re_city` VALUES ('66', '56网', 'www.56.com', '1', '221.229.202.148', '中国', 'CN', '华东', '300000', '江苏省', '320000', '徐州市', '320300');
INSERT INTO `url_re_city` VALUES ('67', '人民电视', 'tv.people.com.cn', '1', '180.97.183.126', '中国', 'CN', '华东', '300000', '江苏省', '320000', '扬州市', '321000');
INSERT INTO `url_re_city` VALUES ('68', '六间房秀场', 'www.6.cn', '1', '58.221.78.112', '中国', 'CN', '华东', '300000', '江苏省', '320000', '南通市', '320600');
INSERT INTO `url_re_city` VALUES ('69', '风行网', 'www.fun.tv', '1', '220.181.167.5', '中国', 'CN', '华北', '100000', '北京市', '110000', '北京市', '110100');
INSERT INTO `url_re_city` VALUES ('70', '第一视频', 'www.v1.cn', '1', '122.228.92.79', '中国', 'CN', '华东', '300000', '浙江省', '330000', '温州市', '330300');
INSERT INTO `url_re_city` VALUES ('71', '环球网视频', 'v.huanqiu.com', '1', '180.101.217.151', '中国', 'CN', '华东', '300000', '江苏省', '320000', '扬州市', '321000');
INSERT INTO `url_re_city` VALUES ('72', 'PPTV网络电视', 'www.pptv.com', '1', '202.102.68.102', '中国', 'CN', '华东', '300000', '江苏省', '320000', '南京市', '320100');
INSERT INTO `url_re_city` VALUES ('73', 'PPS影音', 'www.pps.tv', '1', '58.220.49.142', '中国', 'CN', '华东', '300000', '江苏省', '320000', '扬州市', '321000');
INSERT INTO `url_re_city` VALUES ('74', '芒果TV', 'www.mgtv.com', '1', '61.147.210.175', '中国', 'CN', '华东', '300000', '江苏省', '320000', '南通市', '320600');
INSERT INTO `url_re_city` VALUES ('75', '爱西柚视频', 'xiyou.cntv.cn', '1', '61.155.162.122', '中国', 'CN', '华东', '300000', '江苏省', '320000', '苏州市', '320500');
INSERT INTO `url_re_city` VALUES ('76', 'm1905电影网', 'www.1905.com', '1', '61.147.219.9', '中国', 'CN', '华东', '300000', '江苏省', '320000', '南通市', '320600');
INSERT INTO `url_re_city` VALUES ('77', '激动网', 'www.joy.cn', '1', '122.227.201.86', '中国', 'CN', '华东', '300000', '浙江省', '330000', '宁波市', '330200');
INSERT INTO `url_re_city` VALUES ('78', '优米', 'www.youmi.cn', '1', '123.103.21.247', '中国', 'CN', '华北', '100000', '北京市', '110000', '北京市', '110100');
INSERT INTO `url_re_city` VALUES ('79', '我秀', 'www.woxiu.com', '1', '58.222.42.9', '中国', 'CN', '华东', '300000', '江苏省', '320000', '泰州市', '321200');
INSERT INTO `url_re_city` VALUES ('80', '看看新闻', 'www.kankanews.com', '1', '61.155.237.46', '中国', 'CN', '华东', '300000', '江苏省', '320000', '南京市', '320100');
INSERT INTO `url_re_city` VALUES ('81', '淘米', 'v.61.com', '1', '115.231.128.35', '中国', 'CN', '华东', '300000', '浙江省', '330000', '衢州市', '330800');
INSERT INTO `url_re_city` VALUES ('82', '爱拍原创', 'www.aipai.com', '1', '49.79.233.15', '中国', 'CN', '华东', '300000', '江苏省', '320000', '南京市', '320100');
INSERT INTO `url_re_city` VALUES ('83', '九秀', 'www.9xiu.com', '1', '58.222.40.26', '中国', 'CN', '华东', '300000', '江苏省', '320000', '泰州市', '321200');
INSERT INTO `url_re_city` VALUES ('84', '爆米花', 'www.baomihua.com', '1', '122.225.28.145', '中国', 'CN', '华东', '300000', '浙江省', '330000', '嘉兴市', '330400');
INSERT INTO `url_re_city` VALUES ('85', 'ZOL视频', 'zol.iqiyi.com.cn', '1', '107.155.25.115', '美国', 'US', '', '', '', '', '', '');
INSERT INTO `url_re_city` VALUES ('86', '钢铁视频', 'news.mysteel.com', '1', '61.129.113.111', '中国', 'CN', '华东', '300000', '上海市', '310000', '上海市', '310100');
INSERT INTO `url_re_city` VALUES ('87', '中搜视频', 'video.zhongsou.com', '1', '103.29.135.24', '中国', 'CN', '华北', '100000', '北京市', '110000', '北京市', '110100');
INSERT INTO `url_re_city` VALUES ('88', '播视网', 'www.boosj.com', '1', '222.186.137.102', '中国', 'CN', '华东', '300000', '江苏省', '320000', '镇江市', '321100');
INSERT INTO `url_re_city` VALUES ('89', '时光网', 'www.mtime.com', '1', '59.151.32.20', '中国', 'CN', '华北', '100000', '北京市', '110000', '北京市', '110100');
INSERT INTO `url_re_city` VALUES ('90', '豆瓣电影', 'movie.douban.com', '1', '115.182.201.8', '中国', 'CN', '华北', '100000', '北京市', '110000', '北京市', '110100');
INSERT INTO `url_re_city` VALUES ('91', '华数TV', 'www.wasu.cn', '1', '180.97.168.180', '中国', 'CN', '华东', '300000', '江苏省', '320000', '苏州市', '320500');
INSERT INTO `url_re_city` VALUES ('92', '奇趣视频', 'www.qiqusp.com', '1', '106.187.37.240', '日本', 'JP', '', '', '', '', '', '');
INSERT INTO `url_re_city` VALUES ('93', '迈视网', 'www.maxtv.cn', '1', '58.223.166.226', '中国', 'CN', '华东', '300000', '江苏省', '320000', '淮安市', '320800');
INSERT INTO `url_re_city` VALUES ('94', '琥珀网', 'www.hupo.tv', '1', '182.92.189.193', '中国', 'CN', '华北', '100000', '北京市', '110000', '北京市', '110100');
INSERT INTO `url_re_city` VALUES ('95', '新华视频', 'www.news.cn', '1', '221.228.64.30', '中国', 'CN', '华东', '300000', '江苏省', '320000', '无锡市', '320200');
INSERT INTO `url_re_city` VALUES ('96', '百度视频', 'v.baidu.com', '1', '115.239.210.38', '中国', 'CN', '华东', '300000', '浙江省', '330000', '杭州市', '330100');
INSERT INTO `url_re_city` VALUES ('97', '新浪视频', 'video.sina.com.cn', '1', '114.80.223.61', '中国', 'CN', '华东', '300000', '上海市', '310000', '上海市', '310100');
INSERT INTO `url_re_city` VALUES ('98', '人看人视频', 'www.rkanr.com', '1', '183.61.109.14', '中国', 'CN', '华南', '800000', '广东省', '440000', '广州市', '440100');
INSERT INTO `url_re_city` VALUES ('99', '悠视网', 'www.uusee.com', '1', '117.78.42.51', '中国', 'CN', '华北', '100000', '北京市', '110000', '北京市', '110100');
INSERT INTO `url_re_city` VALUES ('100', '中国佛教电影网', 'www.fjdy.org', '1', '222.222.210.88', '中国', 'CN', '华北', '100000', '河北省', '130000', '石家庄市', '130100');
INSERT INTO `url_re_city` VALUES ('101', '放放影院', 'www.fangfang.cc', '1', '23.226.179.137', '美国', 'US', '', '', '', '', '', '');
INSERT INTO `url_re_city` VALUES ('102', '山猫电影', 'www.3maody.com', '1', '103.53.224.252', '香港', 'HK', '', '', '香港特别行政区', 'HK_01', '', '');
INSERT INTO `url_re_city` VALUES ('103', '电影天堂', 'www.dytt8.net', '1', '192.126.112.124', '美国', 'US', '', '', '', '', '', '');
INSERT INTO `url_re_city` VALUES ('104', '酷米网', 'www.kumi.cn', '1', '122.226.182.42', '中国', 'CN', '华东', '300000', '浙江省', '330000', '台州市', '331000');
INSERT INTO `url_re_city` VALUES ('105', '天上人间动漫网', 'www.52tian.net', '1', '58.218.215.140', '中国', 'CN', '华东', '300000', '江苏省', '320000', '徐州市', '320300');
INSERT INTO `url_re_city` VALUES ('106', '极影动漫网', 'www.jiyingdm.com', '1', '103.35.149.199', '香港', 'HK', '', '', '香港特别行政区', 'HK_01', '', '');
INSERT INTO `url_re_city` VALUES ('107', '比特大雄', 'www.btdx8.com', '1', '23.225.140.202', '美国', 'US', '', '', '', '', '', '');
INSERT INTO `url_re_city` VALUES ('108', '维棠', 'www.vidown.cn', '1', '121.40.40.38', '中国', 'CN', '华东', '300000', '浙江省', '330000', '杭州市', '330100');
INSERT INTO `url_re_city` VALUES ('109', '迅多影视', 'www.xunduo.cc', '1', '216.189.52.216', '美国', 'US', '', '', '', '', '', '');
INSERT INTO `url_re_city` VALUES ('110', '西瓜电影', 'www.xigua110.com', '1', '183.2.191.9', '中国', 'CN', '华南', '800000', '广东省', '440000', '深圳市', '440300');
INSERT INTO `url_re_city` VALUES ('111', '面包网', 'www.mianbao99.com', '1', '121.201.45.173', '中国', 'CN', '华南', '800000', '广东省', '440000', '中山市', '442000');
INSERT INTO `url_re_city` VALUES ('112', '战地影院', 'www.zhandi.cc', '1', '23.234.13.89', '美国', 'US', '', '', '', '', '', '');
INSERT INTO `url_re_city` VALUES ('113', '山猫电影', 'www.3maody.com', '1', '103.53.224.252', '香港', 'HK', '', '', '香港特别行政区', 'HK_01', '', '');
INSERT INTO `url_re_city` VALUES ('114', '酷咕鸭电影', 'www.kuguya.com', '1', '103.53.224.6', '香港', 'HK', '', '', '香港特别行政区', 'HK_01', '', '');
INSERT INTO `url_re_city` VALUES ('115', '老片网', 'www.laopian.tv', '1', '106.185.54.41', '日本', 'JP', '', '', '', '', '', '');
INSERT INTO `url_re_city` VALUES ('116', '电影天堂', 'www.loldytt.com', '1', '47.90.50.147', '香港', 'HK', '', '', '香港特别行政区', 'HK_01', '', '');
INSERT INTO `url_re_city` VALUES ('117', '非凡影院', 'www.feifandy.net', '1', '59.45.175.80', '中国', 'CN', '东北', '200000', '辽宁省', '210000', '阜新市', '210900');
INSERT INTO `url_re_city` VALUES ('118', '暴风影音', 'www.baofeng.com', '1', '124.243.221.205', '中国', 'CN', '华北', '100000', '北京市', '110000', '北京市', '110100');
INSERT INTO `url_re_city` VALUES ('119', '蓝光影院', 'www.languang.cc', '1', '175.6.247.140', '中国', 'CN', '华中', '400000', '湖南省', '430000', '衡阳市', '430400');
INSERT INTO `url_re_city` VALUES ('120', '爱你影院', 'www.20yy.com', '1', '180.97.168.189', '中国', 'CN', '华东', '300000', '江苏省', '320000', '苏州市', '320500');
INSERT INTO `url_re_city` VALUES ('121', '多多影院', 'www.dd13.tv', '1', '23.234.1.21', '美国', 'US', '', '', '', '', '', '');
INSERT INTO `url_re_city` VALUES ('122', '天龙影院', 'www.2mao.cc', '1', '36.7.130.36', '中国', 'CN', '华东', '300000', '安徽省', '340000', '合肥市', '340100');
INSERT INTO `url_re_city` VALUES ('123', '羽翼网', 'www.yuyiyuyi.com', '1', '106.186.18.132', '日本', 'JP', '', '', '', '', '', '');
INSERT INTO `url_re_city` VALUES ('124', '巴巴影院', 'www.baba.cc', '1', '175.6.247.140', '中国', 'CN', '华中', '400000', '湖南省', '430000', '衡阳市', '430400');
INSERT INTO `url_re_city` VALUES ('125', '去看电影网', 'www.qkdy.tv', '1', '162.221.192.14', '美国', 'US', '', '', '', '', '', '');
INSERT INTO `url_re_city` VALUES ('126', '薇薇影院', 'www.vv60.com', '1', '47.88.241.69', '新加坡', 'SG', '', '', '', '', '', '101');
INSERT INTO `url_re_city` VALUES ('127', '第一影院', 'www.1yy.cc', '1', '59.45.175.80', '中国', 'CN', '东北', '200000', '辽宁省', '210000', '阜新市', '210900');
INSERT INTO `url_re_city` VALUES ('128', '无忧影院', 'www.kp31.com', '1', '58.216.107.11', '中国', 'CN', '华东', '300000', '江苏省', '320000', '常州市', '320400');
INSERT INTO `url_re_city` VALUES ('129', '被窝电影', 'www.beiwo.tv', '1', '106.185.55.150', '日本', 'JP', '', '', '', '', '', '');
INSERT INTO `url_re_city` VALUES ('130', 'TOM51', 'www.qvodzy.com', '1', '222.186.132.66', '中国', 'CN', '华东', '300000', '江苏省', '320000', '镇江市', '321100');
INSERT INTO `url_re_city` VALUES ('131', '华龙电影院', 'www.hualyy.com', '1', '137.175.119.245', '美国', 'US', '', '', '', '', '', '');
INSERT INTO `url_re_city` VALUES ('132', '都看影院', 'www.idoukk.com', '1', '47.89.41.215', '香港', 'HK', '', '', '香港特别行政区', 'HK_01', '', '');
INSERT INTO `url_re_city` VALUES ('133', '好看电影网', 'www.ybtdj.com', '1', '137.175.14.89', '美国', 'US', '', '', '', '', '', '');
INSERT INTO `url_re_city` VALUES ('134', '五号影院', 'http://www.wuhao.cc/', '1', '59.45.175.80', '中国', 'CN', '东北', '200000', '辽宁省', '210000', '阜新市', '210900');
INSERT INTO `url_re_city` VALUES ('135', '德华影视', 'http://www.dehua.la/', '1', '113.10.198.196', '香港', 'HK', '', '', '香港特别行政区', 'HK_01', '', '');
INSERT INTO `url_re_city` VALUES ('136', '西部院线', 'http://www.xibu.tv/', '1', '175.6.247.140', '中国', 'CN', '华中', '400000', '湖南省', '430000', '衡阳市', '430400');
INSERT INTO `url_re_city` VALUES ('137', '金山影视', 'http://v.duba.com/', '1', '115.239.210.38', '中国', 'CN', '华东', '300000', '浙江省', '330000', '杭州市', '330100');
INSERT INTO `url_re_city` VALUES ('138', '先看', 'http://www.xiankan.com/', '1', '47.93.118.119', '中国', 'CN', '华北', '100000', '北京市', '110000', '北京市', '110100');
INSERT INTO `url_re_city` VALUES ('139', '未来影院', 'http://www.2k2k.cc/', '1', '210.14.145.54', '中国', 'CN', '华北', '100000', '北京市', '110000', '北京市', '110100');
INSERT INTO `url_re_city` VALUES ('140', '奇特影院', 'http://www.qitete.com/', '1', '59.125.42.228', '台湾', 'TW', '', '', '', '', '', '');
INSERT INTO `url_re_city` VALUES ('141', '电影乐园', 'http://www.vkeke.net/', '1', '162.212.182.61', '美国', 'US', '', '', '', '', '', '');
INSERT INTO `url_re_city` VALUES ('142', '雨蓝影视', 'http://www.yublue.com/', '1', '45.120.29.13', '香港', 'HK', '', '', '香港特别行政区', 'HK_01', '', '');
INSERT INTO `url_re_city` VALUES ('143', '热岛电影', 'http://www.iredao.com/', '1', '121.201.45.241', '中国', 'CN', '华南', '800000', '广东省', '440000', '中山市', '442000');
INSERT INTO `url_re_city` VALUES ('144', '大哥', 'http://www.dage8.cc/', '1', '23.234.30.172', '美国', 'US', '', '', '', '', '', '');
INSERT INTO `url_re_city` VALUES ('145', '瓜田网', 'http://www.guatian.com/', '1', '58.218.215.168', '中国', 'CN', '华东', '300000', '江苏省', '320000', '徐州市', '320300');
INSERT INTO `url_re_city` VALUES ('146', '半岛电影院', 'http://www.guatian.com/', '1', '58.218.215.168', '中国', 'CN', '华东', '300000', '江苏省', '320000', '徐州市', '320300');
INSERT INTO `url_re_city` VALUES ('147', '琪琪影院', 'http://www.77vcd.com/', '1', '59.125.42.228', '台湾', 'TW', '', '', '', '', '', '');
INSERT INTO `url_re_city` VALUES ('148', '七七电视', 'http://www.77ds.net/', '1', '23.234.13.89', '美国', 'US', '', '', '', '', '', '');
INSERT INTO `url_re_city` VALUES ('149', '微观乐', 'http://www.vguanle.com/', '1', '123.207.99.186', '中国', 'CN', '华北', '100000', '北京市', '110000', '北京市', '110100');
INSERT INTO `url_re_city` VALUES ('150', '齐鲁电影网', 'http://www.qilumovie.com/', '1', '183.136.218.39', '中国', 'CN', '华东', '300000', '浙江省', '330000', '衢州市', '330800');
INSERT INTO `url_re_city` VALUES ('151', '星空电影', 'http://www.xkdy.net/', '1', '1.234.19.70', '韩国', 'KR', '', '', '', '', '', '');
INSERT INTO `url_re_city` VALUES ('152', '热片网', 'http://www.repian.com/', '1', '121.201.45.173', '中国', 'CN', '华南', '800000', '广东省', '440000', '中山市', '442000');
INSERT INTO `url_re_city` VALUES ('153', '无忧影院', 'http://www.5u.cc/', '1', '23.234.13.89', '美国', 'US', '', '', '', '', '', '');
INSERT INTO `url_re_city` VALUES ('154', '电影乐园', 'http://www.vkeke.net/', '1', '162.212.182.61', '美国', 'US', '', '', '', '', '', '');
INSERT INTO `url_re_city` VALUES ('155', '好看站', 'http://www.haokan666.com/', '1', '67.21.86.115', '美国', 'US', '', '', '', '', '', '');
INSERT INTO `url_re_city` VALUES ('156', '大狗狗', 'http://www.dagougou.cc/', '1', '23.234.13.89', '美国', 'US', '', '', '', '', '', '');
INSERT INTO `url_re_city` VALUES ('157', '电影港', 'http://www.dygang.com/', '1', '180.101.217.173', '中国', 'CN', '华东', '300000', '江苏省', '320000', '扬州市', '321000');
INSERT INTO `url_re_city` VALUES ('158', '百娱影视', 'http://www.baiy.net/dz1/', '1', '59.125.42.228', '台湾', 'TW', '', '', '', '', '', '');
INSERT INTO `url_re_city` VALUES ('159', '迅雷铺', 'http://www.xlpu.cc/', '1', '23.234.13.89', '美国', 'US', '', '', '', '', '', '');
INSERT INTO `url_re_city` VALUES ('160', 'XXDM', 'http://www.xxdm.org/', '1', '211.75.14.184', '台湾', 'TW', '', '', '', '', '', '');
INSERT INTO `url_re_city` VALUES ('161', '零零柒影视', 'http://www.g007.com/', '1', '183.136.218.39', '中国', 'CN', '华东', '300000', '浙江省', '330000', '衢州市', '330800');
INSERT INTO `url_re_city` VALUES ('162', '去看电影网', 'http://www.qkdy.tv/', '1', '162.221.192.14', '美国', 'US', '', '', '', '', '', '');
INSERT INTO `url_re_city` VALUES ('163', 'TV162', 'http://www.tv162.com/', '1', '180.131.50.197', '韩国', 'KR', '', '', '', '', '', '');
INSERT INTO `url_re_city` VALUES ('164', '老古影院', 'http://www.laogu.cc/', '1', '58.216.17.120', '中国', 'CN', '华东', '300000', '江苏省', '320000', '常州市', '320400');
INSERT INTO `url_re_city` VALUES ('165', '毒蛇影院', 'http://www.dushe.net/', '1', '23.234.13.89', '美国', 'US', '', '', '', '', '', '');
INSERT INTO `url_re_city` VALUES ('166', '55电视网', 'http://www.55ds.cc/', '1', '218.65.212.174', '中国', 'CN', '华南', '800000', '广西壮族自治区', '450000', '桂林市', '450300');
INSERT INTO `url_re_city` VALUES ('167', '神马影视', 'http://www.1684.cc/', '1', '175.6.247.140', '中国', 'CN', '华中', '400000', '湖南省', '430000', '衡阳市', '430400');
INSERT INTO `url_re_city` VALUES ('168', '威看影视网', 'http://www.7vk.com/', '1', '58.84.53.84', '香港', 'HK', '', '', '香港特别行政区', 'HK_01', '', '');
INSERT INTO `url_re_city` VALUES ('169', '双翼影院', 'http://www.8e7e.com/', '1', '45.113.82.31', '美国', 'US', '', '', '', '', '', '');
INSERT INTO `url_re_city` VALUES ('170', '剧风在线', 'http://www.88520.cc/', '1', '23.234.1.21', '美国', 'US', '', '', '', '', '', '');
INSERT INTO `url_re_city` VALUES ('171', '广清影院', 'http://www.93z.cc/', '1', '202.75.220.32', '中国', 'CN', '华东', '300000', '浙江省', '330000', '杭州市', '330100');
INSERT INTO `url_re_city` VALUES ('172', '不卡吧影视', 'http://www.bukaba.com/', '1', '221.228.64.40', '中国', 'CN', '华东', '300000', '江苏省', '320000', '无锡市', '320200');
INSERT INTO `url_re_city` VALUES ('173', '哥哥影视', 'http://www.gege.la/', '1', '58.216.107.11', '中国', 'CN', '华东', '300000', '江苏省', '320000', '常州市', '320400');
INSERT INTO `url_re_city` VALUES ('174', '幸福影视', 'http://www.contentchina.com/', '1', '119.23.136.186', '中国', 'CN', '华南', '800000', '广东省', '440000', '深圳市', '440300');
INSERT INTO `url_re_city` VALUES ('175', '五号影院', 'http://www.wuhao.cc/', '1', '59.45.175.80', '中国', 'CN', '东北', '200000', '辽宁省', '210000', '阜新市', '210900');
INSERT INTO `url_re_city` VALUES ('176', '黑夜影视', 'http://www.heiye.cc/', '1', '205.209.137.217', '美国', 'US', '', '', '', '', '', '');
INSERT INTO `url_re_city` VALUES ('177', '非凡影院', 'http://www.feifandy.net/', '1', '59.45.175.80', '中国', 'CN', '东北', '200000', '辽宁省', '210000', '阜新市', '210900');
INSERT INTO `url_re_city` VALUES ('178', '爱新电影', 'http://www.ixdy.com/', '1', '183.136.218.39', '中国', 'CN', '华东', '300000', '浙江省', '330000', '衢州市', '330800');
INSERT INTO `url_re_city` VALUES ('179', '雕本网', 'http://www.diaoben.com/', '1', '58.211.137.243', '中国', 'CN', '华东', '300000', '江苏省', '320000', '苏州市', '320500');
INSERT INTO `url_re_city` VALUES ('180', '神夜动漫', 'http://www.sydm.hk/', '1', '118.184.18.77', '中国', 'CN', '华东', '300000', '上海市', '310000', '上海市', '310100');
INSERT INTO `url_re_city` VALUES ('181', '黑米网', 'http://www.heimi001.com/', '1', '121.201.22.48', '中国', 'CN', '华南', '800000', '广东省', '440000', '中山市', '442000');
INSERT INTO `url_re_city` VALUES ('182', '电视剧大全', 'http://www.021nba.com/', '1', '113.10.195.204', '香港', 'HK', '', '', '香港特别行政区', 'HK_01', '', '');
INSERT INTO `url_re_city` VALUES ('183', '爱看影院', 'http://www.aikan.tv/', '1', '128.1.171.212', '美国', 'US', '', '', '', '', '', '');
INSERT INTO `url_re_city` VALUES ('184', '电影导航', 'http://www.dydh.tv/zt/', '1', '162.251.21.227', '英属维尔京群岛', 'VG', '', '', '', '', '', '');
INSERT INTO `url_re_city` VALUES ('185', '先锋影院', 'http://www.xfwz.cc/', '1', '222.186.57.168', '中国', 'CN', '华东', '300000', '江苏省', '320000', '镇江市', '321100');
INSERT INTO `url_re_city` VALUES ('186', '奇艺动漫', 'http://www.qydm.net/', '1', '43.246.173.233', '香港', 'HK', '', '', '香港特别行政区', 'HK_01', '', '');
INSERT INTO `url_re_city` VALUES ('187', '爱动漫', 'http://www.idm.cc/', '1', '58.211.137.76', '中国', 'CN', '华东', '300000', '江苏省', '320000', '苏州市', '320500');
INSERT INTO `url_re_city` VALUES ('188', '起跑线', 'http://tv.qpx.com/', '1', '122.228.206.88', '中国', 'CN', '华东', '300000', '浙江省', '330000', '温州市', '330300');
INSERT INTO `url_re_city` VALUES ('189', 'yes影视', 'http://www.yse360.cc/', '1', '67.198.213.19', '美国', 'US', '', '', '', '', '', '');
INSERT INTO `url_re_city` VALUES ('190', '雅图在线', 'http://www.yatu.tv/', '1', '175.6.247.143', '中国', 'CN', '华中', '400000', '湖南省', '430000', '衡阳市', '430400');
INSERT INTO `url_re_city` VALUES ('191', '55电视网', 'http://www.55ds.cc/', '1', '218.65.212.176', '中国', 'CN', '华南', '800000', '广西壮族自治区', '450000', '桂林市', '450300');
INSERT INTO `url_re_city` VALUES ('192', '七色影院', 'http://www.qisedy.com/', '1', '180.150.230.201', '韩国', 'KR', '', '', '', '', '', '');
INSERT INTO `url_re_city` VALUES ('193', '首播影视网', 'http://www.isoboys.com/', '1', '103.206.20.111', '香港', 'HK', '', '', '香港特别行政区', 'HK_01', '', '');
INSERT INTO `url_re_city` VALUES ('194', '89TV', 'http://www.89tv.cc/', '1', '113.10.198.110', '香港', 'HK', '', '', '香港特别行政区', 'HK_01', '', '');
INSERT INTO `url_re_city` VALUES ('195', '九宝宝电影', 'http://www.9bby.com/', '1', '103.68.192.26', '中国', 'CN', '华东', '300000', '江苏省', '320000', '镇江市', '321100');
INSERT INTO `url_re_city` VALUES ('196', '飘花资源网', 'http://www.piaohua.com/', '1', '121.201.121.17', '中国', 'CN', '华南', '800000', '广东省', '440000', '中山市', '442000');
INSERT INTO `url_re_city` VALUES ('197', '齐鲁电影网', 'http://www.qilumovie.com/', '1', '183.136.218.39', '中国', 'CN', '华东', '300000', '浙江省', '330000', '衢州市', '330800');
INSERT INTO `url_re_city` VALUES ('198', '琪琪布电影网', 'http://www.qiqibu8.com/', '1', '59.45.175.80', '中国', 'CN', '东北', '200000', '辽宁省', '210000', '阜新市', '210900');
INSERT INTO `url_re_city` VALUES ('199', '乐酷影视', 'http://www.6k.com/', '1', '61.164.149.231', '中国', 'CN', '华东', '300000', '浙江省', '330000', '温州市', '330300');
INSERT INTO `url_re_city` VALUES ('200', 'BT电影网', 'http://www.btsou.org/', '1', '116.255.174.149', '中国', 'CN', '华中', '400000', '河南省', '410000', '郑州市', '410100');
INSERT INTO `url_re_city` VALUES ('201', '热血电视剧', 'http://www.rxdsj.com/', '1', '23.234.13.89', '美国', 'US', '', '', '', '', '', '');
INSERT INTO `url_re_city` VALUES ('202', '天龙影院', 'http://www.2mao.cc/', '1', '36.7.130.36', '中国', 'CN', '华东', '300000', '安徽省', '340000', '合肥市', '340100');
INSERT INTO `url_re_city` VALUES ('203', '金瓜影视', 'http://www.jinguatv.com/', '1', '118.193.136.122', '中国', 'CN', '华东', '300000', '山东省', '370000', '', '-1');
INSERT INTO `url_re_city` VALUES ('204', '万花筒影院', 'http://www.wht007.com/', '1', '43.252.228.13', '香港', 'HK', '', '', '香港特别行政区', 'HK_01', '', '');
INSERT INTO `url_re_city` VALUES ('205', '土鳖视频', 'http://www.cc82.cc/', '1', '203.78.140.187', '印度', 'IN', '', '', '', '', '', '101');
INSERT INTO `url_re_city` VALUES ('206', '优片网', 'http://www.upian.cc/', '1', '58.211.137.245', '中国', 'CN', '华东', '300000', '江苏省', '320000', '苏州市', '320500');
INSERT INTO `url_re_city` VALUES ('207', '腾讯音乐', 'http://yue.qq.com/', '2', '180.96.86.192', '中国', 'CN', '华东', '300000', '江苏省', '320000', '南京市', '320100');
INSERT INTO `url_re_city` VALUES ('208', '网易云音乐', 'http://music.163.com/', '2', '59.111.160.197', '中国', 'CN', '华南', '800000', '广东省', '440000', '深圳市', '440300');
INSERT INTO `url_re_city` VALUES ('209', '磨坊高品质音乐论坛', 'http://www.moofeel.com/index.php', '2', '210.209.89.234', '香港', 'HK', '', '', '香港特别行政区', 'HK_01', '', '');
INSERT INTO `url_re_city` VALUES ('210', '九酷音乐', 'http://www.9ku.com/', '2', '61.147.210.175', '中国', 'CN', '华东', '300000', '江苏省', '320000', '南通市', '320600');
INSERT INTO `url_re_city` VALUES ('211', '5nd音乐网', 'http://www.5nd.com/', '2', '222.186.17.100', '中国', 'CN', '华东', '300000', '江苏省', '320000', '镇江市', '321100');
INSERT INTO `url_re_city` VALUES ('212', '320高品质MP3音乐', 'http://www.320mp3.com/', '2', '123.125.112.229', '中国', 'CN', '华北', '100000', '北京市', '110000', '北京市', '110100');
INSERT INTO `url_re_city` VALUES ('213', '51APE', 'http://www.51ape.com/', '2', '210.209.89.233', '香港', 'HK', '', '', '香港特别行政区', 'HK_01', '', '');
INSERT INTO `url_re_city` VALUES ('214', '咪咕音乐网', 'http://music.migu.cn/#', '2', '218.200.160.43', '中国', 'CN', '西南', '500000', '四川省', '510000', '', '');
INSERT INTO `url_re_city` VALUES ('215', '音乐巴士', 'http://www.yy8844.cn/', '2', '122.228.204.133', '中国', 'CN', '华东', '300000', '浙江省', '330000', '温州市', '330300');
INSERT INTO `url_re_city` VALUES ('216', '叮当音乐网', 'http://www.mtv123.com/', '2', '122.228.204.212', '中国', 'CN', '华东', '300000', '浙江省', '330000', '温州市', '330300');
INSERT INTO `url_re_city` VALUES ('217', '一听音乐', 'http://www.1ting.com/', '2', '222.186.17.100', '中国', 'CN', '华东', '300000', '江苏省', '320000', '镇江市', '321100');
INSERT INTO `url_re_city` VALUES ('218', '365音乐网', 'http://www.yue365.com/', '2', '222.186.13.53', '中国', 'CN', '华东', '300000', '江苏省', '320000', '镇江市', '321100');
INSERT INTO `url_re_city` VALUES ('219', '好听轻音乐网', 'http://www.htqyy.com/', '2', '115.29.28.246', '中国', 'CN', '华东', '300000', '浙江省', '330000', '杭州市', '330100');
INSERT INTO `url_re_city` VALUES ('220', '百度音乐', 'http://music.baidu.com/', '2', '182.61.35.21', '中国', 'CN', '华南', '800000', '广东省', '440000', '广州市', '440100');
INSERT INTO `url_re_city` VALUES ('221', '金山音乐', 'http://www.duba.com/music_index.html', '2', '218.92.225.200', '中国', 'CN', '华东', '300000', '江苏省', '320000', '盐城市', '320900');
INSERT INTO `url_re_city` VALUES ('222', '搜狗音乐', 'http://mp3.sogou.com/', '2', '106.120.188.46', '中国', 'CN', '华北', '100000', '北京市', '110000', '北京市', '110100');
INSERT INTO `url_re_city` VALUES ('223', '九天音乐', 'http://www.9sky.com/', '2', '114.55.236.110', '中国', 'CN', '华东', '300000', '浙江省', '330000', '杭州市', '330100');
INSERT INTO `url_re_city` VALUES ('224', '56音乐网', 'http://www.23356.com/', '2', '58.211.137.80', '中国', 'CN', '华东', '300000', '江苏省', '320000', '苏州市', '320500');
INSERT INTO `url_re_city` VALUES ('225', '今生缘音乐', 'http://www.666ccc.com/', '2', '104.27.146.128', '美国', 'US', '', '', '', '', '', '');
INSERT INTO `url_re_city` VALUES ('226', '多米音乐', 'http://www.duomi.com/', '2', '59.151.12.60', '中国', 'CN', '华北', '100000', '北京市', '110000', '北京市', '110100');
INSERT INTO `url_re_city` VALUES ('227', 'YYMP3音乐网', 'http://www.yymp3.com/', '2', '204.128.60.111', '美国', 'US', '', '', '', '', '', '');
INSERT INTO `url_re_city` VALUES ('228', '音乐人先锋榜', 'http://music.weibo.com/', '2', '123.126.56.253', '中国', 'CN', '华北', '100000', '北京市', '110000', '北京市', '110100');
INSERT INTO `url_re_city` VALUES ('229', '喜马拉雅FM', 'http://www.ximalaya.com/explore/', '2', '180.153.255.7', '中国', 'CN', '华东', '300000', '上海市', '310000', '上海市', '310100');
INSERT INTO `url_re_city` VALUES ('230', '音悦台', 'http://www.yinyuetai.com/', '2', '221.228.226.18', '中国', 'CN', '华东', '300000', '江苏省', '320000', '无锡市', '320200');
INSERT INTO `url_re_city` VALUES ('231', '豆瓣FM', 'https://douban.fm/', '2', '115.182.201.7', '中国', 'CN', '华北', '100000', '北京市', '110000', '北京市', '110100');
INSERT INTO `url_re_city` VALUES ('232', 'echo回声', 'http://www.app-echo.com/#/', '2', '180.97.219.63', '中国', 'CN', '华东', '300000', '江苏省', '320000', '淮安市', '320800');
INSERT INTO `url_re_city` VALUES ('233', '百度乐播', 'http://lebo.baidu.com/', '2', '180.76.183.17', '中国', 'CN', '华北', '100000', '北京市', '110000', '北京市', '110100');
INSERT INTO `url_re_city` VALUES ('234', '72DJ舞曲网', 'http://www.72dj.com/', '2', '222.186.49.186', '中国', 'CN', '华东', '300000', '江苏省', '320000', '镇江市', '321100');
INSERT INTO `url_re_city` VALUES ('235', '搜刮音乐平台', 'http://www.sogua.com/', '2', '183.60.201.102', '中国', 'CN', '华南', '800000', '广东省', '440000', '佛山市', '440600');
INSERT INTO `url_re_city` VALUES ('236', '好听163音乐网', 'http://www.haoting163.com/', '2', '47.90.10.47', '香港', 'HK', '', '', '香港特别行政区', 'HK_01', '', '');
INSERT INTO `url_re_city` VALUES ('237', '爱给网', 'http://www.2gei.com/music/', '2', '139.129.112.11', '中国', 'CN', '华东', '300000', '山东省', '370000', '青岛市', '370200');
INSERT INTO `url_re_city` VALUES ('238', '我爱音乐网', 'http://www.5iyy.net/', '2', '47.90.10.47', '香港', 'HK', '', '', '香港特别行政区', 'HK_01', '', '');
INSERT INTO `url_re_city` VALUES ('239', '完美汽车音乐', 'http://www.wanmeimv.com/forum.php', '2', '115.231.187.88', '中国', 'CN', '华东', '300000', '浙江省', '330000', '宁波市', '330200');
INSERT INTO `url_re_city` VALUES ('240', '极品社区', 'http://bbs.zzse.net/', '2', '61.160.247.153', '中国', 'CN', '华东', '300000', '江苏省', '320000', '常州市', '320400');
INSERT INTO `url_re_city` VALUES ('241', '汽车音乐网', 'http://www.carsmp3.com/', '2', '209.141.62.25', '美国', 'US', '', '', '', '', '', '');
INSERT INTO `url_re_city` VALUES ('242', '百度音乐随心听', 'http://fm.baidu.com/', '2', '180.76.183.17', '中国', 'CN', '华北', '100000', '北京市', '110000', '北京市', '110100');
INSERT INTO `url_re_city` VALUES ('243', '一听音乐', 'http://www.1ting.com/fo/    ', '2', '61.147.210.175', '中国', 'CN', '华东', '300000', '江苏省', '320000', '南通市', '320600');
INSERT INTO `url_re_city` VALUES ('244', 'DN在线听歌', 'http://music.dn1234.com/    ', '2', '58.216.107.101', '中国', 'CN', '华东', '300000', '江苏省', '320000', '常州市', '320400');
INSERT INTO `url_re_city` VALUES ('245', '芒仔音乐铺', 'http://www.yinyuepu.com/    ', '2', '122.228.248.219', '中国', 'CN', '华东', '300000', '浙江省', '330000', '温州市', '330300');
INSERT INTO `url_re_city` VALUES ('246', '听蛙音乐网', 'http://www.itingwa.com/', '2', '125.65.113.223', '中国', 'CN', '西南', '500000', '四川省', '510000', '绵阳市', '510700');
INSERT INTO `url_re_city` VALUES ('247', '佛教在线', 'http://music.fjnet.com/', '2', '115.159.71.66', '中国', 'CN', '华东', '300000', '上海市', '310000', '上海市', '310100');
INSERT INTO `url_re_city` VALUES ('248', '库客音乐', 'http://www.kuke.com/', '2', '60.205.130.221', '中国', 'CN', '华北', '100000', '北京市', '110000', '北京市', '110100');
INSERT INTO `url_re_city` VALUES ('249', '前卫音乐', 'http://www.dj520.com/', '2', '120.76.194.25', '中国', 'CN', '华南', '800000', '广东省', '440000', '深圳市', '440300');
INSERT INTO `url_re_city` VALUES ('250', '中国古曲网', 'http://www.guqu.net/', '2', '125.91.8.163', '中国', 'CN', '华南', '800000', '广东省', '440000', '汕头市', '440500');
INSERT INTO `url_re_city` VALUES ('251', 'DJ音乐厅', 'http://www.hcdj.com/', '2', '122.228.70.59', '中国', 'CN', '华东', '300000', '浙江省', '330000', '温州市', '330300');
INSERT INTO `url_re_city` VALUES ('252', '慢品', 'http://manpin.net/', '2', '47.90.78.27', '香港', 'HK', '', '', '香港特别行政区', 'HK_01', '', '');
INSERT INTO `url_re_city` VALUES ('253', '阿小猫', 'http://axiaomao.com/', '2', '115.29.224.67', '中国', 'CN', '华东', '300000', '浙江省', '330000', '杭州市', '330100');
INSERT INTO `url_re_city` VALUES ('254', '匪徒在线', 'http://www.94007.com/', '2', '118.144.82.174', '中国', 'CN', '华北', '100000', '北京市', '110000', '北京市', '110100');
INSERT INTO `url_re_city` VALUES ('255', 'DJ45', 'http://www.dj45.com/', '2', '222.186.30.192', '中国', 'CN', '华东', '300000', '江苏省', '320000', '镇江市', '321100');
INSERT INTO `url_re_city` VALUES ('256', '520666音乐网', 'http://www.520666.com/', '2', '47.89.26.149', '香港', 'HK', '', '', '香港特别行政区', 'HK_01', '', '');
INSERT INTO `url_re_city` VALUES ('257', '音灵dj网', 'http://www.djf1.com/', '2', '43.225.59.104', '香港', 'HK', '', '', '香港特别行政区', 'HK_01', '', '');
INSERT INTO `url_re_city` VALUES ('258', '宝贝DJ网', 'http://www.bbdj.com/', '2', '58.218.215.170', '中国', 'CN', '华东', '300000', '江苏省', '320000', '徐州市', '320300');
INSERT INTO `url_re_city` VALUES ('259', 'MOOV', 'https://moov.hk/', '2', '219.76.111.41', '香港', 'HK', '', '', '香港特别行政区', 'HK_01', '', '');
INSERT INTO `url_re_city` VALUES ('260', '可可西广场舞', 'http://www.cococ.com/', '2', '47.90.80.184', '香港', 'HK', '', '', '香港特别行政区', 'HK_01', '', '');
INSERT INTO `url_re_city` VALUES ('261', '慢摇Dj吧', 'http://www.mydjb.com/', '2', '58.218.215.163', '中国', 'CN', '华东', '300000', '江苏省', '320000', '徐州市', '320300');
INSERT INTO `url_re_city` VALUES ('262', '旗舰音乐网', 'https://www.xx186.com/', '2', '180.97.168.220', '中国', 'CN', '华东', '300000', '江苏省', '320000', '苏州市', '320500');
INSERT INTO `url_re_city` VALUES ('263', '水晶DJ网', 'http://www.dj97.com/', '2', '122.228.248.203', '中国', 'CN', '华东', '300000', '浙江省', '330000', '温州市', '330300');
INSERT INTO `url_re_city` VALUES ('264', '捌零音乐论坛', 'http://www.pt80.net/', '2', '115.238.138.185', '中国', 'CN', '华东', '300000', '浙江省', '330000', '宁波市', '330200');
INSERT INTO `url_re_city` VALUES ('265', '噢音乐', 'http://www.oyinyue.com/', '2', '59.56.19.184', '中国', 'CN', '华东', '300000', '福建省', '350000', '福州市', '350100');
INSERT INTO `url_re_city` VALUES ('266', '雪域藏族音乐网', 'http://www.snowmusic.com.cn/', '2', '118.244.234.225', '中国', 'CN', '华北', '100000', '北京市', '110000', '北京市', '110100');
INSERT INTO `url_re_city` VALUES ('267', '深港dj俱乐部', 'http://www.ik123.com/', '2', '180.97.66.35', '中国', 'CN', '华东', '300000', '江苏省', '320000', '苏州市', '320500');
INSERT INTO `url_re_city` VALUES ('268', '沃音乐', 'http://www.10155.com/#main/index.htm', '2', '58.254.132.4', '中国', 'CN', '华南', '800000', '广东省', '440000', '深圳市', '440300');
INSERT INTO `url_re_city` VALUES ('269', '高品质dj音乐盒', 'http://www.3378.com.cn/', '2', '115.238.255.188', '中国', 'CN', '华东', '300000', '浙江省', '330000', '丽水市', '331100');
INSERT INTO `url_re_city` VALUES ('270', '伤感音乐网', 'http://www.yy521.com/', '2', '117.27.245.96', '中国', 'CN', '华东', '300000', '福建省', '350000', '福州市', '350100');
INSERT INTO `url_re_city` VALUES ('271', '中国原创音乐基地 5SING', 'http://5sing.kugou.com/yc/index.html', '2', '115.231.37.27', '中国', 'CN', '华东', '300000', '浙江省', '330000', '宁波市', '330200');
INSERT INTO `url_re_city` VALUES ('272', '清风DJ音乐网', 'http://www.vvvdj.com/', '2', '180.97.168.180', '中国', 'CN', '华东', '300000', '江苏省', '320000', '苏州市', '320500');
INSERT INTO `url_re_city` VALUES ('273', '音乐地带-影音帝国区- 华声论坛', 'http://bbs.voc.com.cn/forum-77-1.html', '2', '220.168.248.214', '中国', 'CN', '华中', '400000', '湖南省', '430000', '长沙市', '430100');
INSERT INTO `url_re_city` VALUES ('274', '顶尖dj舞曲网', 'http://www.dj89.com/', '2', '60.169.78.231', '中国', 'CN', '华东', '300000', '安徽省', '340000', '芜湖市', '340200');
INSERT INTO `url_re_city` VALUES ('275', '疯吧', 'http://www.djf8.com/', '2', '119.254.167.112', '中国', 'CN', '华北', '100000', '北京市', '110000', '北京市', '110100');
INSERT INTO `url_re_city` VALUES ('276', 'MC喊麦', 'http://www.dj116.com/', '2', '43.240.14.209', '香港', 'HK', '', '', '香港特别行政区', 'HK_01', '', '');
INSERT INTO `url_re_city` VALUES ('277', '深度无损音乐论坛', 'http://www.deepms.net/', '2', '113.10.136.198', '香港', 'HK', '', '', '香港特别行政区', 'HK_01', '', '');
INSERT INTO `url_re_city` VALUES ('278', '三衢客栈', 'http://www.sqkz.com/k80.html', '2', '115.236.4.8', '中国', 'CN', '华东', '300000', '浙江省', '330000', '杭州市', '330100');
INSERT INTO `url_re_city` VALUES ('279', '串串烧音乐论坛', 'www.ccshao.com/index.php?gid=16', '2', '210.209.70.181', '香港', 'HK', '', '', '香港特别行政区', 'HK_01', '', '');
INSERT INTO `url_re_city` VALUES ('280', '杂碎音乐论坛', 'http://www.zasv.net/', '2', '172.87.27.47', '美国', 'US', '', '', '', '', '', '');
INSERT INTO `url_re_city` VALUES ('281', '风云音乐谷', 'http://www.hcyy.org/', '2', '43.227.98.233', '中国', 'CN', '华东', '300000', '山东省', '370000', '潍坊市', '370700');
INSERT INTO `url_re_city` VALUES ('282', '百事高音乐论坛', 'http://bbs.besgold.com/', '2', '59.36.101.196', '中国', 'CN', '华南', '800000', '广东省', '440000', '东莞市', '441900');
INSERT INTO `url_re_city` VALUES ('283', 'dj嗨嗨网', 'http://www.djkk.com/', '2', '202.75.220.31', '中国', 'CN', '华东', '300000', '浙江省', '330000', '杭州市', '330100');
INSERT INTO `url_re_city` VALUES ('284', '中国dj爱好者', 'http://www.djcc.cc/', '2', '220.164.144.201', '中国', 'CN', '西南', '500000', '云南省', '530000', '普洱市', '530800');
INSERT INTO `url_re_city` VALUES ('285', '海边dj舞曲网', 'http://www.dj806.com/', '2', '211.149.211.228', '中国', 'CN', '西南', '500000', '四川省', '510000', '成都市', '510100');
INSERT INTO `url_re_city` VALUES ('286', 'DJWMA舞曲网', 'http://www.djwma.com/', '2', '47.89.0.246', '香港', 'HK', '', '', '香港特别行政区', 'HK_01', '', '');
INSERT INTO `url_re_city` VALUES ('287', '5.1真音乐', 'http://www.5dian1.net/', '2', '211.149.233.201', '中国', 'CN', '西南', '500000', '四川省', '510000', '成都市', '510100');
INSERT INTO `url_re_city` VALUES ('288', '听歌123音乐网', 'http://www.tingge123.com/', '2', '180.97.168.197', '中国', 'CN', '华东', '300000', '江苏省', '320000', '苏州市', '320500');
INSERT INTO `url_re_city` VALUES ('289', '手机MP3', 'http://www.sjmp3.com/', '2', '47.90.18.124', '香港', 'HK', '', '', '香港特别行政区', 'HK_01', '', '');
INSERT INTO `url_re_city` VALUES ('290', '军歌网', 'http://www.jungewang.com/', '2', '121.201.5.160', '中国', 'CN', '华南', '800000', '广东省', '440000', '中山市', '442000');
INSERT INTO `url_re_city` VALUES ('291', 'MixDJ丨全球舞曲同步网', 'http://www.mixdj.cn/', '2', '58.211.137.240', '中国', 'CN', '华东', '300000', '江苏省', '320000', '苏州市', '320500');
INSERT INTO `url_re_city` VALUES ('292', '酷听音乐网', 'http://www.kting.org.cn/', '2', '47.90.10.47', '香港', 'HK', '', '', '香港特别行政区', 'HK_01', '', '');
INSERT INTO `url_re_city` VALUES ('293', 'DJ聚合分享网站 ', 'http://www.36dj.com/', '2', '61.147.118.206', '中国', 'CN', '华东', '300000', '江苏省', '320000', '扬州市', '321000');
INSERT INTO `url_re_city` VALUES ('294', '听三零音乐网', 'http://www.ting30.com/gequ/show1.html', '2', '106.122.250.46', '中国', 'CN', '华东', '300000', '福建省', '350000', '福州市', '350100');
INSERT INTO `url_re_city` VALUES ('295', '串烧歌曲网', 'http://www.dj810.com/ranks.html', '2', '221.229.173.107', '中国', 'CN', '华东', '300000', '江苏省', '320000', '徐州市', '320300');
INSERT INTO `url_re_city` VALUES ('296', '想听音乐网', 'http://www.yy3t.com/', '2', '47.90.10.47', '香港', 'HK', '', '', '香港特别行政区', 'HK_01', '', '');
INSERT INTO `url_re_city` VALUES ('297', '就要听音乐网', 'http://91listen.com/', '2', '139.129.227.101', '中国', 'CN', '华东', '300000', '山东省', '370000', '青岛市', '370200');
INSERT INTO `url_re_city` VALUES ('298', '基督教歌曲网', 'http://www.jdjgq.com/hotmusic.htm', '2', '124.228.91.141', '中国', 'CN', '华中', '400000', '湖南省', '430000', '衡阳市', '430400');
INSERT INTO `url_re_city` VALUES ('299', '要听舞曲网', 'http://www.111ttt.com/top/sWeekday.htm', '2', '122.228.70.15', '中国', 'CN', '华东', '300000', '浙江省', '330000', '温州市', '330300');
INSERT INTO `url_re_city` VALUES ('300', '风云音乐网', 'http://www.fengyunmusic.com/', '2', '47.90.10.47', '香港', 'HK', '', '', '香港特别行政区', 'HK_01', '', '');
INSERT INTO `url_re_city` VALUES ('301', '阿忠舞曲网', 'http://www.djazhong.com/index.php/ranks/fav.html', '2', '60.190.223.11', '中国', 'CN', '华东', '300000', '浙江省', '330000', '绍兴市', '330600');
INSERT INTO `url_re_city` VALUES ('302', '荔枝fm', 'http://www.lizhi.fm/', '2', '49.79.233.116', '中国', 'CN', '华东', '300000', '江苏省', '320000', '南京市', '320100');
INSERT INTO `url_re_city` VALUES ('303', 'QQ190音乐网', 'http://www.y2002.com/', '2', '119.147.139.113', '中国', 'CN', '华南', '800000', '广东省', '440000', '佛山市', '440600');
INSERT INTO `url_re_city` VALUES ('304', '中国传媒配音网', 'http://www.cmpy.cn/', '2', '61.147.98.146', '中国', 'CN', '华东', '300000', '江苏省', '320000', '扬州市', '321000');
INSERT INTO `url_re_city` VALUES ('305', '新地DJ音乐网', 'http://www.5ydj.com/', '2', '60.205.151.170', '中国', 'CN', '华北', '100000', '北京市', '110000', '北京市', '110100');
INSERT INTO `url_re_city` VALUES ('306', '99伴奏网', 'http://www.wo99.net/', '2', '222.186.21.29', '中国', 'CN', '华东', '300000', '江苏省', '320000', '镇江市', '321100');
INSERT INTO `url_re_city` VALUES ('307', '极点舞曲网', 'http://www.dj3721.net/', '2', '125.89.70.14', '中国', 'CN', '华南', '800000', '广东省', '440000', '珠海市', '440400');
INSERT INTO `url_re_city` VALUES ('308', '班得瑞全球中文网', 'https://www.bandari.net/', '2', '211.159.153.113', '中国', 'CN', '华东', '300000', '上海市', '310000', '上海市', '310100');
INSERT INTO `url_re_city` VALUES ('309', 'DJ先锋网', 'http://www.dj-dj.net/', '2', '220.164.144.201', '中国', 'CN', '西南', '500000', '云南省', '530000', '普洱市', '530800');
INSERT INTO `url_re_city` VALUES ('310', '爱音乐', 'http://www.imusic.cn/', '2', '14.146.228.10', '中国', 'CN', '华南', '800000', '广东省', '440000', '广州市', '440100');
INSERT INTO `url_re_city` VALUES ('311', '爱听交谊舞曲网,', 'http://www.2ting.net/', '2', '222.186.49.186', '中国', 'CN', '华东', '300000', '江苏省', '320000', '镇江市', '321100');
INSERT INTO `url_re_city` VALUES ('312', 'A8音乐网', 'http://www.a8.com/', '2', '106.122.250.46', '中国', 'CN', '华东', '300000', '福建省', '350000', '福州市', '350100');
INSERT INTO `url_re_city` VALUES ('313', '搜狐音乐', 'http://music.yule.sohu.com/', '2', '101.227.172.11', '中国', 'CN', '华东', '300000', '上海市', '310000', '上海市', '310100');
INSERT INTO `url_re_city` VALUES ('314', '新浪音乐', 'http://yue.sina.com.cn/', '2', '202.102.75.147', '中国', 'CN', '华东', '300000', '江苏省', '320000', '南京市', '320100');
INSERT INTO `url_re_city` VALUES ('315', '中国音乐网', 'http://www.yyjy.com/index.html', '2', '182.140.227.157', '中国', 'CN', '西南', '500000', '四川省', '510000', '成都市', '510100');
INSERT INTO `url_re_city` VALUES ('316', '炫音音乐论坛', 'http://bbs.musicool.cn/', '2', '122.224.5.239', '中国', 'CN', '华东', '300000', '浙江省', '330000', '绍兴市', '330600');
INSERT INTO `url_re_city` VALUES ('317', '新芭网', 'http://www.sin80.com/', '2', '175.102.3.129', '中国', 'CN', '华东', '300000', '上海市', '310000', '上海市', '310100');
INSERT INTO `url_re_city` VALUES ('318', 'dj耶耶网', 'http://www.djye.com/', '2', '222.186.49.200', '中国', 'CN', '华东', '300000', '江苏省', '320000', '镇江市', '321100');
INSERT INTO `url_re_city` VALUES ('319', '古典音乐频道', 'http://www.ncpa-classic.com/', '2', '58.221.78.105', '中国', 'CN', '华东', '300000', '江苏省', '320000', '南通市', '320600');
INSERT INTO `url_re_city` VALUES ('320', '高采样数字音乐厅', 'http://hd-hall.com/', '2', '115.28.237.117', '中国', 'CN', '华东', '300000', '山东省', '370000', '青岛市', '370200');
INSERT INTO `url_re_city` VALUES ('321', '基点局俱乐部', 'http://club.mydcentre.com/', '2', '27.24.190.218', '中国', 'CN', '华中', '400000', '湖北省', '420000', '咸宁市', '421200');
INSERT INTO `url_re_city` VALUES ('322', '电驴大全', 'http://www.verycd.com/', '2', '182.92.25.21', '中国', 'CN', '华北', '100000', '北京市', '110000', '北京市', '110100');
INSERT INTO `url_re_city` VALUES ('323', '有伴网', 'http://www.youban.com/', '2', '183.62.113.115', '中国', 'CN', '华南', '800000', '广东省', '440000', '深圳市', '440300');
INSERT INTO `url_re_city` VALUES ('324', '新芭网', 'http://www.sin80.com/', '2', '175.102.3.129', '中国', 'CN', '华东', '300000', '上海市', '310000', '上海市', '310100');
INSERT INTO `url_re_city` VALUES ('325', '京东音乐网', 'http://music.jd.com/', '2', '106.39.167.232', '中国', 'CN', '华北', '100000', '北京市', '110000', '北京市', '110100');
INSERT INTO `url_re_city` VALUES ('326', '乐吧谷', 'http://www.yuebagu.com/yuequ/gudianqu/', '2', '58.211.137.239', '中国', 'CN', '华东', '300000', '江苏省', '320000', '苏州市', '320500');
INSERT INTO `url_re_city` VALUES ('327', '摇头网', 'http://www.yaotou.com/', '2', '222.186.49.195', '中国', 'CN', '华东', '300000', '江苏省', '320000', '镇江市', '321100');
INSERT INTO `url_re_city` VALUES ('328', '想听音乐网', 'http://www.yy3t.com/', '2', '47.90.10.47', '香港', 'HK', '', '', '香港特别行政区', 'HK_01', '', '');
INSERT INTO `url_re_city` VALUES ('329', '酷听音乐网', 'http://www.kting.org.cn/', '2', '47.90.10.47', '香港', 'HK', '', '', '香港特别行政区', 'HK_01', '', '');
INSERT INTO `url_re_city` VALUES ('330', '原创EDM', 'http://www.y2002.com/', '2', '119.147.139.113', '中国', 'CN', '华南', '800000', '广东省', '440000', '佛山市', '440600');
INSERT INTO `url_re_city` VALUES ('331', '26音乐网', 'http://www.26yy.com/', '2', '218.247.87.158', '中国', 'CN', '西南', '500000', '四川省', '510000', '成都市', '510100');
INSERT INTO `url_re_city` VALUES ('332', '九酷电台', 'http://www.9ku.com/fm/', '2', '222.186.17.100', '中国', 'CN', '华东', '300000', '江苏省', '320000', '镇江市', '321100');
INSERT INTO `url_re_city` VALUES ('333', '嗨瑶音乐网', 'http://www.92kk.com/', '2', '122.228.248.200', '中国', 'CN', '华东', '300000', '浙江省', '330000', '温州市', '330300');
INSERT INTO `url_re_city` VALUES ('334', '言情小说吧', 'http://www.xs8.cn/', '3', '222.186.20.123', '中国', 'CN', '华东', '300000', '江苏省', '320000', '镇江市', '321100');
INSERT INTO `url_re_city` VALUES ('335', '小说大全', 'http://book.km.com/', '3', '124.243.254.3', '中国', 'CN', '华北', '100000', '北京市', '110000', '北京市', '110100');
INSERT INTO `url_re_city` VALUES ('336', '纵横中文网', 'http://www.zongheng.com/', '3', '180.97.66.35', '中国', 'CN', '华东', '300000', '江苏省', '320000', '苏州市', '320500');
INSERT INTO `url_re_city` VALUES ('337', '搜狗小说', 'http://xiaoshuo.sogou.com/', '3', '106.120.188.46', '中国', 'CN', '华北', '100000', '北京市', '110000', '北京市', '110100');
INSERT INTO `url_re_city` VALUES ('338', '红袖添香', 'http://www.hongxiu.com/', '3', '106.122.250.43', '中国', 'CN', '华东', '300000', '福建省', '350000', '福州市', '350100');
INSERT INTO `url_re_city` VALUES ('339', '17K小说网', 'http://www.17k.com/', '3', '58.218.215.165', '中国', 'CN', '华东', '300000', '江苏省', '320000', '徐州市', '320300');
INSERT INTO `url_re_city` VALUES ('340', '小说阅读网', 'https://www.readnovel.com/', '3', '101.226.212.177', '中国', 'CN', '华东', '300000', '上海市', '310000', '上海市', '310100');
INSERT INTO `url_re_city` VALUES ('341', '逐浪', 'http://www.zhulang.com/', '3', '59.63.234.28', '中国', 'CN', '华东', '300000', '江西省', '360000', '南昌市', '360100');
INSERT INTO `url_re_city` VALUES ('342', '潇湘书院', 'http://www.xxsy.net/', '3', '58.216.109.187', '中国', 'CN', '华东', '300000', '江苏省', '320000', '常州市', '320400');
INSERT INTO `url_re_city` VALUES ('343', '起点小说网', 'http://www.qidian.com/', '3', '221.228.67.145', '中国', 'CN', '华东', '300000', '江苏省', '320000', '无锡市', '320200');
INSERT INTO `url_re_city` VALUES ('344', '云起书院', 'http://yunqi.qq.com/', '3', '101.226.103.126', '中国', 'CN', '华东', '300000', '上海市', '310000', '上海市', '310100');
INSERT INTO `url_re_city` VALUES ('345', '凤鸣轩小说网', 'http://www.fmx.cn/', '3', '60.205.56.2', '中国', 'CN', '华北', '100000', '北京市', '110000', '北京市', '110100');
INSERT INTO `url_re_city` VALUES ('346', '红薯小说阅读网', 'http://www.hongshu.com/', '3', '117.21.219.92', '中国', 'CN', '华东', '300000', '江西省', '360000', '九江市', '360400');
INSERT INTO `url_re_city` VALUES ('347', '书海小说网', 'http://www.shuhai.com/', '3', '58.216.17.107', '中国', 'CN', '华东', '300000', '江苏省', '320000', '常州市', '320400');
INSERT INTO `url_re_city` VALUES ('348', '磨铁中文网', 'http://www.motie.com/', '3', '42.96.249.20', '中国', 'CN', '华东', '300000', '山东省', '370000', '青岛市', '370200');
INSERT INTO `url_re_city` VALUES ('349', '万松浦书院', 'http://www.wansongpu.com/', '3', '60.212.44.36', '中国', 'CN', '华东', '300000', '山东省', '370000', '烟台市', '370600');
INSERT INTO `url_re_city` VALUES ('350', '文中书城小说网', 'http://www.yuncheng.com/', '3', '61.151.186.106', '中国', 'CN', '华东', '300000', '上海市', '310000', '上海市', '310100');
INSERT INTO `url_re_city` VALUES ('351', 'hao123小说网', 'http://book.hao123.com/', '3', '180.97.66.48', '中国', 'CN', '华东', '300000', '江苏省', '320000', '苏州市', '320500');
INSERT INTO `url_re_city` VALUES ('352', '新小说吧', 'http://www.xxs8.com/', '3', '182.18.61.69', '中国', 'CN', '华北', '100000', '北京市', '110000', '北京市', '110100');
INSERT INTO `url_re_city` VALUES ('353', '看书网', 'http://about.kanshu.com/', '3', '124.202.154.70', '中国', 'CN', '华北', '100000', '北京市', '110000', '北京市', '110100');
INSERT INTO `url_re_city` VALUES ('354', '飞卢小说网', 'http://b.faloo.com/', '3', '115.231.29.34', '中国', 'CN', '华东', '300000', '浙江省', '330000', '湖州市', '330500');
INSERT INTO `url_re_city` VALUES ('355', '360小说网', 'http://www.jingyu.com/', '3', '116.62.84.160', '中国', 'CN', '华东', '300000', '浙江省', '330000', '杭州市', '330100');
INSERT INTO `url_re_city` VALUES ('356', '掌握阅读小说', 'http://yc.ireader.com.cn/', '3', '113.31.87.8', '中国', 'CN', '华北', '100000', '北京市', '110000', '北京市', '110100');
INSERT INTO `url_re_city` VALUES ('357', '国风中文网', 'http://guofeng.yuedu.163.com/', '3', '223.252.199.7', '中国', 'CN', '华东', '300000', '浙江省', '330000', '杭州市', '330100');
INSERT INTO `url_re_city` VALUES ('358', '无限小说网', 'http://www.55x.cn/', '3', '59.53.67.168', '中国', 'CN', '华东', '300000', '江西省', '360000', '南昌市', '360100');
INSERT INTO `url_re_city` VALUES ('359', '逸云书院', 'http://yynovel.motie.com/', '3', '139.129.199.219', '中国', 'CN', '华东', '300000', '山东省', '370000', '青岛市', '370200');
INSERT INTO `url_re_city` VALUES ('360', '孔夫子读书网', 'http://book.kongfz.com/', '3', '180.97.162.23', '中国', 'CN', '华东', '300000', '江苏省', '320000', '苏州市', '320500');
INSERT INTO `url_re_city` VALUES ('361', '暖暖书城', 'http://www.nnsc6.com/', '3', '103.235.244.165', '中国', 'CN', '华北', '100000', '北京市', '110000', '北京市', '110100');
INSERT INTO `url_re_city` VALUES ('362', '粉色书城', 'http://www.fensebook.com/', '3', '180.97.235.68', '中国', 'CN', '华东', '300000', '江苏省', '320000', '苏州市', '320500');
INSERT INTO `url_re_city` VALUES ('363', '凌云文学网', 'http://www.lingyun5.com/', '3', '103.235.244.161', '中国', 'CN', '华北', '100000', '北京市', '110000', '北京市', '110100');
INSERT INTO `url_re_city` VALUES ('364', '3G书城', 'http://www.3gsc.com.cn/', '3', '183.61.112.43', '中国', 'CN', '华南', '800000', '广东省', '440000', '广州市', '440100');
INSERT INTO `url_re_city` VALUES ('365', '优恋小说网', 'http://www.1999youlian.com/', '3', '222.186.171.138', '中国', 'CN', '华东', '300000', '江苏省', '320000', '镇江市', '321100');
INSERT INTO `url_re_city` VALUES ('366', '暗夜文学网', 'http://www.anyew.com/', '3', '101.201.63.140', '中国', 'CN', '华北', '100000', '北京市', '110000', '北京市', '110100');
INSERT INTO `url_re_city` VALUES ('367', '鬼姐姐小说网', 'http://www.guijj.com/', '3', '121.40.164.23', '中国', 'CN', '华东', '300000', '浙江省', '330000', '杭州市', '330100');
INSERT INTO `url_re_city` VALUES ('368', '甜悦读网', 'http://www.sweetread.net/', '3', '123.57.42.242', '中国', 'CN', '华北', '100000', '北京市', '110000', '北京市', '110100');
INSERT INTO `url_re_city` VALUES ('369', '长江中文网', 'http://www.cjzww.com/', '3', '124.202.158.10', '中国', 'CN', '华北', '100000', '北京市', '110000', '北京市', '110100');
INSERT INTO `url_re_city` VALUES ('370', '滕痕书院', 'http://www.tenghen.com/', '3', '114.112.96.71', '中国', 'CN', '华北', '100000', '北京市', '110000', '北京市', '110100');
INSERT INTO `url_re_city` VALUES ('371', '封神阅读网', 'http://www.fsyuedu.com/', '3', '123.57.221.91', '中国', 'CN', '华北', '100000', '北京市', '110000', '北京市', '110100');
INSERT INTO `url_re_city` VALUES ('372', '岳麓小说网', 'http://www.yueloo.com/', '3', '115.29.40.199', '中国', 'CN', '华东', '300000', '山东省', '370000', '青岛市', '370200');
INSERT INTO `url_re_city` VALUES ('373', '朵米阅读网', 'http://www.dmread.com/', '3', '101.200.141.41', '中国', 'CN', '华北', '100000', '北京市', '110000', '北京市', '110100');
INSERT INTO `url_re_city` VALUES ('374', '云文学网', 'http://www.yunwenxue.com/', '3', '210.14.73.194', '中国', 'CN', '华东', '300000', '上海市', '310000', '上海市', '310100');
INSERT INTO `url_re_city` VALUES ('375', '九库文学网', 'http://www.9kus.com/', '3', '121.201.20.115', '中国', 'CN', '华南', '800000', '广东省', '440000', '中山市', '442000');
INSERT INTO `url_re_city` VALUES ('376', '我爱小说网', 'http://www.5ixsw.com/', '3', '115.231.105.72', '中国', 'CN', '华东', '300000', '浙江省', '330000', '杭州市', '330100');
INSERT INTO `url_re_city` VALUES ('377', '传奇中文网', 'http://www.cqzww.com/', '3', '139.129.97.15', '中国', 'CN', '华东', '300000', '山东省', '370000', '青岛市', '370200');
INSERT INTO `url_re_city` VALUES ('378', '北雁堂中文网', 'http://www.ebtang.com/', '3', '112.126.73.137', '中国', 'CN', '华北', '100000', '北京市', '110000', '北京市', '110100');
INSERT INTO `url_re_city` VALUES ('379', '浩阅读', 'http://www.haoread.com/', '3', '123.57.44.159', '中国', 'CN', '华北', '100000', '北京市', '110000', '北京市', '110100');
INSERT INTO `url_re_city` VALUES ('380', '一千零一页', 'http://www.1001p.com/', '3', '221.122.67.136', '中国', 'CN', '华北', '100000', '北京市', '110000', '北京市', '110100');
INSERT INTO `url_re_city` VALUES ('381', '凤凰书城', 'http://yc.ifeng.com/', '3', '58.222.42.58', '中国', 'CN', '华东', '300000', '江苏省', '320000', '泰州市', '321200');
INSERT INTO `url_re_city` VALUES ('382', '恒言中文网', 'http://www.hengyan.com/', '3', '122.224.32.166', '中国', 'CN', '华东', '300000', '浙江省', '330000', '绍兴市', '330600');
INSERT INTO `url_re_city` VALUES ('383', '天下书盟网', 'http://www.fbook.net/', '3', '101.201.78.206', '中国', 'CN', '华北', '100000', '北京市', '110000', '北京市', '110100');
INSERT INTO `url_re_city` VALUES ('384', '花雨小说网', 'http://www.inbook.net/', '3', '121.9.242.86', '中国', 'CN', '华南', '800000', '广东省', '440000', '佛山市', '440600');
INSERT INTO `url_re_city` VALUES ('385', '半壁江阅读网', 'http://www.banbijiang.com/', '3', '114.141.171.229', '中国', 'CN', '华东', '300000', '上海市', '310000', '上海市', '310100');
INSERT INTO `url_re_city` VALUES ('386', '栀子花阅读', 'http://www.zhizihuan.com/', '3', '43.240.244.27', '中国', 'CN', '华北', '100000', '北京市', '110000', '北京市', '110100');
INSERT INTO `url_re_city` VALUES ('387', '阅书中文网', 'http://www.yuebook.net/', '3', '123.56.192.67', '中国', 'CN', '华北', '100000', '北京市', '110000', '北京市', '110100');
INSERT INTO `url_re_city` VALUES ('388', '阅读坊', 'http://www.yuedufang.com/', '3', '101.200.179.230', '中国', 'CN', '华北', '100000', '北京市', '110000', '北京市', '110100');
INSERT INTO `url_re_city` VALUES ('389', '圣诞文学网', 'http://www.shengdan.com/', '3', '222.73.241.170', '中国', 'CN', '华东', '300000', '上海市', '310000', '上海市', '310100');
INSERT INTO `url_re_city` VALUES ('390', '绝版中文网', 'http://www.jbzwread.com/', '3', '120.24.16.114', '中国', 'CN', '华南', '800000', '广东省', '440000', '深圳市', '440300');
INSERT INTO `url_re_city` VALUES ('391', '博阅中文网', 'http://www.lboyue.com/', '3', '112.124.59.159', '中国', 'CN', '华东', '300000', '浙江省', '330000', '杭州市', '330100');
INSERT INTO `url_re_city` VALUES ('392', '阅庭书院', 'http://www.ytread.com/', '3', '119.23.145.92', '中国', 'CN', '华南', '800000', '广东省', '440000', '深圳市', '440300');
INSERT INTO `url_re_city` VALUES ('393', '爱奇艺文学网', 'http://wenxue.iqiyi.com/', '3', '58.220.49.144', '中国', 'CN', '华东', '300000', '江苏省', '320000', '扬州市', '321000');
INSERT INTO `url_re_city` VALUES ('394', '听书网小说', 'http://www.kting.cn/', '3', '180.97.235.68', '中国', 'CN', '华东', '300000', '江苏省', '320000', '苏州市', '320500');
INSERT INTO `url_re_city` VALUES ('395', '落尘小说网', 'http://www.luochen.com/', '3', '120.55.194.88', '中国', 'CN', '华东', '300000', '浙江省', '330000', '杭州市', '330100');
INSERT INTO `url_re_city` VALUES ('396', '雨枫轩', 'http://www.rain8.com/', '3', '180.97.221.94', '中国', 'CN', '华东', '300000', '江苏省', '320000', '淮安市', '320800');
INSERT INTO `url_re_city` VALUES ('397', '蜜阅书苑', 'http://www.mixs.cn/', '3', '121.40.239.57', '中国', 'CN', '华东', '300000', '浙江省', '330000', '杭州市', '330100');
INSERT INTO `url_re_city` VALUES ('398', '懒猫阅读', 'http://www.lmyd5.com/', '3', '103.235.244.161', '中国', 'CN', '华北', '100000', '北京市', '110000', '北京市', '110100');
INSERT INTO `url_re_city` VALUES ('399', '草莓书城', 'http://www.caomeibook.com/', '3', '103.235.244.161', '中国', 'CN', '华北', '100000', '北京市', '110000', '北京市', '110100');
INSERT INTO `url_re_city` VALUES ('400', '梦想家书城', 'http://www.dreamersall.com/', '3', '101.37.43.206', '中国', 'CN', '华东', '300000', '浙江省', '330000', '杭州市', '330100');
INSERT INTO `url_re_city` VALUES ('401', '阿尔法书城', 'http://www.alphafun.com/', '3', '61.130.247.173', '中国', 'CN', '华东', '300000', '浙江省', '330000', '湖州市', '330500');
INSERT INTO `url_re_city` VALUES ('402', '品书文学网', 'http://www.pinshu.com/', '3', '101.201.116.161', '中国', 'CN', '华北', '100000', '北京市', '110000', '北京市', '110100');
INSERT INTO `url_re_city` VALUES ('403', '中文在线', 'http://www1.chineseall.com/', '3', '125.39.193.226', '中国', 'CN', '华北', '100000', '天津市', '120000', '天津市', '120100');
INSERT INTO `url_re_city` VALUES ('404', '偶家中文网', 'http://www.ouj.com/', '3', '221.228.79.225', '中国', 'CN', '华东', '300000', '江苏省', '320000', '无锡市', '320200');
INSERT INTO `url_re_city` VALUES ('405', '时阅文学', 'http://www.timeread.com/', '3', '43.240.244.19', '中国', 'CN', '华北', '100000', '北京市', '110000', '北京市', '110100');
INSERT INTO `url_re_city` VALUES ('406', '花溪小说网', 'http://www.huaxi.net/', '3', '47.93.158.209', '中国', 'CN', '华北', '100000', '北京市', '110000', '北京市', '110100');
INSERT INTO `url_re_city` VALUES ('407', '安卓读书网', 'http://www.andreader.com/', '3', '58.222.42.58', '中国', 'CN', '华东', '300000', '江苏省', '320000', '泰州市', '321200');
INSERT INTO `url_re_city` VALUES ('408', '妖气原创网', 'http://www.17yc.com/', '3', '123.57.48.109', '中国', 'CN', '华北', '100000', '北京市', '110000', '北京市', '110100');
INSERT INTO `url_re_city` VALUES ('409', '麦麦阅读', 'http://m.mmread.com/', '3', '123.57.219.79', '中国', 'CN', '华北', '100000', '北京市', '110000', '北京市', '110100');
INSERT INTO `url_re_city` VALUES ('410', '天地中文网', 'http://www.tiandizw.com/', '3', '180.97.168.188', '中国', 'CN', '华东', '300000', '江苏省', '320000', '苏州市', '320500');
INSERT INTO `url_re_city` VALUES ('411', '异客书栈', 'http://www.1ksz.com/', '3', '120.76.208.210', '中国', 'CN', '华南', '800000', '广东省', '440000', '深圳市', '440300');
INSERT INTO `url_re_city` VALUES ('412', '塔读文学', 'http://www.tadu.com/', '3', '211.151.212.33', '中国', 'CN', '华北', '100000', '北京市', '110000', '北京市', '110100');
INSERT INTO `url_re_city` VALUES ('413', '盛世阅读网', 'http://www.s4yd.com/', '3', '120.76.161.125', '中国', 'CN', '华南', '800000', '广东省', '440000', '深圳市', '440300');
INSERT INTO `url_re_city` VALUES ('414', '爆侃网文', 'http://www.baokan.name/', '3', '120.24.79.174', '中国', 'CN', '华南', '800000', '广东省', '440000', '深圳市', '440300');
INSERT INTO `url_re_city` VALUES ('415', '燃文小说 ', 'http://www.52ranwen.net/', '3', '183.86.218.14', '韩国', 'KR', '', '', '', '', '', '');
INSERT INTO `url_re_city` VALUES ('416', '擦火阅读', 'http://www.cahuo.com/', '3', '101.201.116.237', '中国', 'CN', '华北', '100000', '北京市', '110000', '北京市', '110100');
INSERT INTO `url_re_city` VALUES ('417', '陌上香坊', 'http://www.msxf.net/', '3', '119.29.125.202', '中国', 'CN', '华南', '800000', '广东省', '440000', '', '');
INSERT INTO `url_re_city` VALUES ('418', '四月天', 'http://www.4yt.net/', '3', '60.205.113.37', '中国', 'CN', '华北', '100000', '北京市', '110000', '北京市', '110100');
INSERT INTO `url_re_city` VALUES ('419', '汤圆小说网', 'http://www.itangyuan.com/', '3', '106.75.21.5', '中国', 'CN', '华东', '300000', '山东省', '370000', '济南市', '370100');
INSERT INTO `url_re_city` VALUES ('420', '二层楼书院', 'http://www.2cloo.com/', '3', '182.92.26.100', '中国', 'CN', '华北', '100000', '北京市', '110000', '北京市', '110100');
INSERT INTO `url_re_city` VALUES ('421', '魔情小说网', 'http://www.moqing.com/', '3', '61.147.218.24', '中国', 'CN', '华东', '300000', '江苏省', '320000', '南通市', '320600');
INSERT INTO `url_re_city` VALUES ('422', '千马中文网', 'http://www.qmcmw.com/', '3', '202.91.247.9', '中国', 'CN', '华东', '300000', '浙江省', '330000', '杭州市', '330100');
INSERT INTO `url_re_city` VALUES ('423', '悠空网小说', 'http://www.yokong.com/', '3', '58.216.17.125', '中国', 'CN', '华东', '300000', '江苏省', '320000', '常州市', '320400');
INSERT INTO `url_re_city` VALUES ('424', '暗时阅读网', 'http://www.anshi7.com/', '3', '121.40.127.202', '中国', 'CN', '华东', '300000', '浙江省', '330000', '杭州市', '330100');
INSERT INTO `url_re_city` VALUES ('425', '胭脂小说网', 'http://www.yznovel.com/', '3', '114.55.62.198', '中国', 'CN', '华东', '300000', '浙江省', '330000', '杭州市', '330100');
INSERT INTO `url_re_city` VALUES ('426', '沃读文学网', 'http://www.iwodu.com/', '3', '218.244.139.81', '中国', 'CN', '华东', '300000', '浙江省', '330000', '杭州市', '330100');
INSERT INTO `url_re_city` VALUES ('427', '小说520', 'http://www.xiaoshuo520.com/', '3', '139.196.228.89', '中国', 'CN', '华东', '300000', '上海市', '310000', '上海市', '310100');
INSERT INTO `url_re_city` VALUES ('428', '小说控', 'http://www.xiaoshuokong.com/', '3', '112.126.83.41', '中国', 'CN', '华北', '100000', '北京市', '110000', '北京市', '110100');
INSERT INTO `url_re_city` VALUES ('429', '巨匠网', 'http://www.jujiangkk.com/', '3', '123.56.129.203', '中国', 'CN', '华北', '100000', '北京市', '110000', '北京市', '110100');
INSERT INTO `url_re_city` VALUES ('430', '大鱼中文网', 'http://www.dayuread.com/', '3', '139.196.210.156', '中国', 'CN', '华东', '300000', '上海市', '310000', '上海市', '310100');
INSERT INTO `url_re_city` VALUES ('431', '莺田书城', 'http://www.yingtianbook.com/', '3', '121.42.46.197', '中国', 'CN', '华东', '300000', '山东省', '370000', '青岛市', '370200');
INSERT INTO `url_re_city` VALUES ('432', '熊猫看书网', 'http://www.xmkanshu.com/', '3', '118.26.21.72', '中国', 'CN', '华北', '100000', '北京市', '110000', '北京市', '110100');
INSERT INTO `url_re_city` VALUES ('433', '创酷中文网', 'http://www.acoolread.com/', '3', '123.57.204.32', '中国', 'CN', '华北', '100000', '北京市', '110000', '北京市', '110100');
INSERT INTO `url_re_city` VALUES ('434', '锦色文学网', 'http://www.jinsebook.com/', '3', '121.40.208.7', '中国', 'CN', '华东', '300000', '浙江省', '330000', '杭州市', '330100');
INSERT INTO `url_re_city` VALUES ('435', '书丛中文小说', 'http://www.shucong.com/', '3', '180.97.163.220', '中国', 'CN', '华东', '300000', '江苏省', '320000', '苏州市', '320500');
INSERT INTO `url_re_city` VALUES ('436', '蔷薇书院', 'http://www.qwsy.com/', '3', '125.90.88.76', '中国', 'CN', '华南', '800000', '广东省', '440000', '茂名市', '440900');
INSERT INTO `url_re_city` VALUES ('437', '小说大全', 'http://book.km.com/', '3', '124.243.254.3', '中国', 'CN', '华北', '100000', '北京市', '110000', '北京市', '110100');
INSERT INTO `url_re_city` VALUES ('438', '香网', 'http://www.xiang5.com/', '3', '180.97.168.189', '中国', 'CN', '华东', '300000', '江苏省', '320000', '苏州市', '320500');
INSERT INTO `url_re_city` VALUES ('439', '114小说', 'http://book.114la.com/', '3', '118.186.64.243', '中国', 'CN', '华北', '100000', '北京市', '110000', '北京市', '110100');
INSERT INTO `url_re_city` VALUES ('440', '三五中文网', 'http://www.35zww.com/', '3', '67.229.97.100', '美国', 'US', '', '', '', '', '', '');
INSERT INTO `url_re_city` VALUES ('441', '八一中文网', 'http://www.x81zw.com/', '3', '58.218.215.171', '中国', 'CN', '华东', '300000', '江苏省', '320000', '徐州市', '320300');
INSERT INTO `url_re_city` VALUES ('442', '棋子小说', 'http://www.qizi.la/', '3', '198.15.135.18', '美国', 'US', '', '', '', '', '', '');
INSERT INTO `url_re_city` VALUES ('443', '小说77', 'http://www.xiaoshuo77.com/', '3', '58.216.17.109', '中国', 'CN', '华东', '300000', '江苏省', '320000', '常州市', '320400');
INSERT INTO `url_re_city` VALUES ('444', '花曼原创网', 'http://www.hm-yc.com/', '3', '203.195.128.191', '中国', 'CN', '华南', '800000', '广东省', '440000', '广州市', '440100');
INSERT INTO `url_re_city` VALUES ('445', '鬼大爷小说', 'http://book.guidaye.com/', '3', '58.218.215.167', '中国', 'CN', '华东', '300000', '江苏省', '320000', '徐州市', '320300');
INSERT INTO `url_re_city` VALUES ('446', '风云小说阅读网', 'http://www.baoliny.com/', '3', '104.31.8.162', '美国', 'US', '', '', '', '', '', '');
INSERT INTO `url_re_city` VALUES ('447', '和讯读书网', 'http://book.hexun.com/', '3', '61.183.12.59', '中国', 'CN', '华中', '400000', '湖北省', '420000', '武汉市', '420100');
INSERT INTO `url_re_city` VALUES ('448', '世纪书城', 'http://www.2200book.com/', '3', '221.234.46.10', '中国', 'CN', '华中', '400000', '湖北省', '420000', '鄂州市', '420700');
INSERT INTO `url_re_city` VALUES ('449', '春田花花', 'http://www.ctbook.cn/', '3', '203.195.128.191', '中国', 'CN', '华南', '800000', '广东省', '440000', '广州市', '440100');
INSERT INTO `url_re_city` VALUES ('450', '华夏天空网', 'http://www.hxtk.com/', '3', '139.196.208.147', '中国', 'CN', '华东', '300000', '上海市', '310000', '上海市', '310100');
INSERT INTO `url_re_city` VALUES ('451', '玄色小说', 'http://www.xsread.com/', '3', '203.195.142.22', '中国', 'CN', '华南', '800000', '广东省', '440000', '广州市', '440100');
INSERT INTO `url_re_city` VALUES ('452', '铸剑阁', 'http://www.zhujiange.com/', '3', '203.195.142.22', '中国', 'CN', '华南', '800000', '广东省', '440000', '广州市', '440100');



-- ----------------------------
-- Table structure for `s_anti_vice_info`
-- ----------------------------
DROP TABLE IF EXISTS `s_anti_vice_info`;
CREATE TABLE `s_anti_vice_info` (
  `ID` varchar(50) NOT NULL,
  `DEL_FLAG` tinyint(1) NOT NULL,
  `CREATE_TIME` datetime NOT NULL,
  `TOTAL_CNT` int(11) DEFAULT '0',
  `WEB_CNT` int(11) DEFAULT '0',
  `IMG_CNT` int(11) DEFAULT '0',
  `VIDEO_CNT` int(11) DEFAULT NULL,
  `TEXT_CNT` int(11) DEFAULT NULL,
  `SAVED_CNT` int(11) DEFAULT NULL,
  `ANTI_VICE_CNT` int(11) DEFAULT NULL,
  `INT_SURVEILLANCE_CNT` int(11) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of s_anti_vice_info
-- ----------------------------
INSERT INTO `s_anti_vice_info` VALUES ('66', '0', '2017-05-10 11:26:19', '10000', '100', '200', '444', '204', '100', '120', '1000');

-- ----------------------------
-- Table structure for `s_area`
-- ----------------------------
DROP TABLE IF EXISTS `s_area`;
CREATE TABLE `s_area` (
  `ID` varchar(50) NOT NULL,
  `CITY_ID` varchar(50) DEFAULT NULL,
  `LAT` double DEFAULT NULL,
  `LNG` double DEFAULT NULL,
  `CODE` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of s_area
-- ----------------------------
INSERT INTO `s_area` VALUES ('1', '320500', '120.37', '31.19', 'utf8');
INSERT INTO `s_area` VALUES ('10', '610100', '108.57', '34.16', null);
INSERT INTO `s_area` VALUES ('11', '440300', '114.04', '22.37', null);
INSERT INTO `s_area` VALUES ('12', '442000', '113.23', '22.31', null);
INSERT INTO `s_area` VALUES ('13', '441900', '113.45', '23.02', null);
INSERT INTO `s_area` VALUES ('14', '510100', '104.04', '30.4', null);
INSERT INTO `s_area` VALUES ('15', '310100', '121.29', '31.13', null);
INSERT INTO `s_area` VALUES ('16', 'HK_01', '114.06', '22.12', null);
INSERT INTO `s_area` VALUES ('17', '101', '0', '0', null);
INSERT INTO `s_area` VALUES ('2', '110100', '116.28', '39.55', null);
INSERT INTO `s_area` VALUES ('3', '330100', '120.11', '30.16', null);
INSERT INTO `s_area` VALUES ('4', '320600', '121.03', '32.05', null);
INSERT INTO `s_area` VALUES ('5', '330500', '120.06', '30.52', null);
INSERT INTO `s_area` VALUES ('6', '320100', '118.47', '32.02', null);
INSERT INTO `s_area` VALUES ('7', '320300', '117.12', '34.16', null);
INSERT INTO `s_area` VALUES ('8', '330300', '120.39', '28.01', null);
INSERT INTO `s_area` VALUES ('9', '321200', '119.54', '32.29', null);

-- ----------------------------
-- Table structure for `s_gis_detail_info`
-- ----------------------------
DROP TABLE IF EXISTS `s_gis_detail_info`;
CREATE TABLE `s_gis_detail_info` (
  `id` varchar(50) NOT NULL,
  `del_flag` tinyint(1) NOT NULL,
  `create_time` datetime NOT NULL,
  `content_type` tinyint(5) DEFAULT NULL COMMENT '盗版类型',
  `detail_kv` varchar(512) DEFAULT NULL COMMENT '检索关键字',
  `baidu_search_cnt` int(11) DEFAULT NULL,
  `haosou_search_cnt` int(11) DEFAULT NULL,
  `sougou_search_cnt` int(11) DEFAULT NULL,
  `weixin_search_cnt` int(11) DEFAULT NULL,
  `all_cnt` int(11) DEFAULT NULL COMMENT '任务相关数据总量',
  `suitability` varchar(50) DEFAULT '' COMMENT '基础信息匹配度',
  `suitability_range` int(11) DEFAULT NULL COMMENT '匹配范围',
  `genuine_info` varchar(512) DEFAULT '' COMMENT '正版基本信息',
  `piracy_info` varchar(512) DEFAULT '' COMMENT '盗版基本信息',
  `piracy_source` varchar(50) DEFAULT '' COMMENT '盗版源头',
  `estimated_impact_cnt` int(11) DEFAULT NULL COMMENT '预计影响量',
  `transmission_rate` varchar(50) DEFAULT '' COMMENT '传播率',
  `spread_scope` int(11) DEFAULT NULL COMMENT '传播范围',
  `resource_size` varchar(50) DEFAULT '' COMMENT '盗版资源内容大小',
  `resource_in_date` datetime DEFAULT NULL COMMENT '盗版资源上架时间',
  `network_cnt` int(11) DEFAULT NULL COMMENT '全网检测数据总量',
  `detail_area_id` varchar(50) DEFAULT NULL,
  `detail_url` varchar(512) DEFAULT NULL,
  `task_job_id` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of s_gis_detail_info
-- ----------------------------
INSERT INTO `s_gis_detail_info` VALUES ('1', '0', '2017-05-10 17:37:39', '0', '人民的名义', '45645', '4964545', '6456456', '4654564', '6456456', '90', '232423', '卧虎藏龙;张艺谋;九十年代', '卧虎藏蛇;张艺煤;九十年代', '百度', '234234', '66', '34534', '4353', '2017-05-10 17:41:24', '235423', '320500', 'http://www.bilibili.com/', 'dc1f763f4a9840aaa25fb6a782c43fd8');

-- ----------------------------
-- Table structure for `s_gis_info`
-- ----------------------------
DROP TABLE IF EXISTS `s_gis_info`;
CREATE TABLE `s_gis_info` (
  `id` varchar(50) NOT NULL,
  `del_flag` tinyint(1) NOT NULL,
  `create_time` datetime NOT NULL,
  `content_type` tinyint(5) DEFAULT NULL,
  `province_id` int(11) DEFAULT NULL,
  `province_cnt` int(11) DEFAULT NULL,
  `latit_longit` varchar(512) DEFAULT NULL,
  `task_job_id` varchar(50) DEFAULT NULL,
  `overseas_type` varchar(50) DEFAULT NULL,
  `overseas_cnt` int(11) DEFAULT NULL,
  `detail_area_id` varchar(50) DEFAULT NULL,
  `detail_url` varchar(512) DEFAULT NULL,
  `detail_cnt` int(11) DEFAULT NULL,
  `detail_kv` varchar(512) DEFAULT NULL,
  `detail_judicature` tinyint(5) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of s_gis_info
-- ----------------------------
INSERT INTO `s_gis_info` VALUES ('1', '0', '2017-05-10 20:55:13', '5', null, '34534534', '', 'dc1f763f4a9840aaa25fb6a782c43fd8', '0', '234234', '320500', 'http://www.bilibili.com/', '34234', '人民的名义', '2');
INSERT INTO `s_gis_info` VALUES ('10', '0', '2017-05-11 22:11:20', '5', null, '34567', null, '29189428ec14482e9f76070fe94ab646', '0', '98123', '610100', 'http://www.tonghuacun.com/', '43441', '奔跑吧兄弟', '1');
INSERT INTO `s_gis_info` VALUES ('11', '0', '2017-05-11 22:12:47', '5', null, '56732', null, '5158b1ba54814ba592949d3df229ce27', '0', '23412', '440300', 'http://www.repian.com/', '32124', '中国好声音', '0');
INSERT INTO `s_gis_info` VALUES ('12', '0', '2017-05-11 22:14:10', '3', null, '341234', null, '62645fc1e64149b9916f71b420b2a596', '0', '342331', '442000', 'http://www.dy2018.com/', '43465', '大话西游', '2');
INSERT INTO `s_gis_info` VALUES ('13', '0', '2017-05-11 22:15:20', '5', null, '32123', null, '9282c445010a478a824a6b16fef074ec', '0', '67853', '441900', 'http://www.zzlxs.net/', '9870', '刺客信条', '0');
INSERT INTO `s_gis_info` VALUES ('14', '0', '2017-05-11 22:17:45', '3', null, '341234', null, '80eec40e12094c54ba6b49c883167580', '0', '6578', '510100', 'http://www.dy166.net/', '34235', '当幸福来敲门', '0');
INSERT INTO `s_gis_info` VALUES ('15', '0', '2017-05-11 22:20:28', '5', null, '55543', null, 'f513036f271c410dac1a1c192cc5e70f', '0', '4442', '310100', 'http://www.nk77.com/view/49692/', '12342', '笑傲江湖', '1');
INSERT INTO `s_gis_info` VALUES ('16', '0', '2017-05-11 22:22:04', '1', null, '32322', null, 'ce511c91c1bb4effa21d38dc4347018f', '0', '2221', 'HK_01', 'http://www.loldytt.com/', '11112', '高能少年团', '2');
INSERT INTO `s_gis_info` VALUES ('17', '0', '2017-05-11 23:23:47', '1', null, '31231', null, '3510e7edf99f4c5b85b6195a64be1a25', '1', '12312', '101', 'http://www.ikua.cc/', '32322', '吸血鬼日记', '0');
INSERT INTO `s_gis_info` VALUES ('18', '0', '2017-05-11 23:26:11', '1', null, '32412', null, '0621d10397fc4fccbbd85c9da33b8dee', '1', '3412', '101', 'http://www.51rrkank.com/', '12312', '釜山行', '1');
INSERT INTO `s_gis_info` VALUES ('19', '0', '2017-05-11 23:26:45', '2', null, '231231', null, 'dd2890da230a4c099bab0edab0444d10', '1', '23112', '101', 'http://www.beiwo.tv/', '3242', '海贼王', '2');
INSERT INTO `s_gis_info` VALUES ('2', '0', '2017-05-11 20:32:28', '1', null, '234234', null, '90921bff7d65488ea008a777fecbbeb6', '0', '34234', '110100', 'http://www.360kan.com/', '34234', '海贼王', '2');
INSERT INTO `s_gis_info` VALUES ('21', '0', '2017-05-11 23:28:45', '5', null, '234234', null, 'd587ff7904fb4a35aaebfd68d36c7b5d', '1', '42342', '101', 'www.vv60.com', '23423', '美丽人生', '0');
INSERT INTO `s_gis_info` VALUES ('22', '0', '2017-05-11 23:31:05', '1', null, '2313123', null, 'd8f1045e29904fceb8196d180aa67e4d', '1', '23424', '101', 'http://www.cc82.cc/', '4234', '卧虎藏龙', '1');
INSERT INTO `s_gis_info` VALUES ('3', '0', '2017-05-11 20:41:00', '2', null, '342432', null, 'a794b2ea602b4fa1bd3a46b461d54830', '0', '34234', '330100', 'http://v.baidu.com/', '34234', '心术', '1');
INSERT INTO `s_gis_info` VALUES ('4', '0', '2017-05-11 20:43:03', '3', null, '2342342', null, '133bd52e5cd14ae7ac89fdd6c96306b2', '0', '23423', '320600', 'http://www.mgtv.com/1', '234234', '奇葩说', '0');
INSERT INTO `s_gis_info` VALUES ('5', '0', '2017-05-11 20:44:01', '4', null, '34234', null, 'a101436612ea4eb9baa2c1098c6fa958', '0', '242342', '330500', 'http://www.ku6.com/', '234234', '快乐大本营', '2');
INSERT INTO `s_gis_info` VALUES ('6', '0', '2017-05-11 21:34:11', '1', null, '12345', null, 'a455d4ee4cb1441a97a4593ae94abba0', '0', '12345', '320100', 'http://v.ifeng.com/', '23345', '海上钢琴师', '0');
INSERT INTO `s_gis_info` VALUES ('7', '0', '2017-05-11 21:37:00', '1', null, '56789', null, '971933ce311b4c578ca5f5a057d8e8a0', '0', '67890', '320300', 'http://www.56.com/', '34521', '生化危机', '1');
INSERT INTO `s_gis_info` VALUES ('8', '0', '2017-05-11 21:39:42', '1', null, '12345', null, 'a3d10c7735a64d6facf4fa8211cf505a', '0', '97612', '330300', 'http://www.v1.cn/', '12356', '速度与激情', '0');
INSERT INTO `s_gis_info` VALUES ('9', '0', '2017-05-11 22:09:36', '2', null, '456787', null, 'eaee145510b2422fac2456c52da18a8b', '0', '43523', '321200', 'http://xiyou.cntv.cn/', '34563', '叶问', '2');

-- ----------------------------
-- Table structure for `s_highcharts_info`
-- ----------------------------
DROP TABLE IF EXISTS `s_highcharts_info`;
CREATE TABLE `s_highcharts_info` (
  `id` varchar(50) NOT NULL,
  `DEL_FLAG` tinyint(1) NOT NULL,
  `CREATE_TIME` datetime NOT NULL,
  `TOTAL_CNT` int(11) DEFAULT NULL,
  `CONTENT_TYPE` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of s_highcharts_info
-- ----------------------------
INSERT INTO `s_highcharts_info` VALUES ('0', '0', '2017-05-11 16:04:16', '1000', '0');
INSERT INTO `s_highcharts_info` VALUES ('1', '0', '2017-05-11 16:05:14', '222', '1');
INSERT INTO `s_highcharts_info` VALUES ('2', '0', '2017-05-11 16:05:26', '25689', '2');
INSERT INTO `s_highcharts_info` VALUES ('3', '0', '2017-05-11 16:05:40', '5575', '3');
INSERT INTO `s_highcharts_info` VALUES ('4', '0', '2017-05-11 16:05:50', '79587', '4');
INSERT INTO `s_highcharts_info` VALUES ('5', '0', '2017-05-11 16:06:02', '5547', '5');
INSERT INTO `s_highcharts_info` VALUES ('6', '0', '2017-05-11 16:06:12', '87144', '6');

-- ----------------------------
-- Table structure for `s_hot_info`
-- ----------------------------
DROP TABLE IF EXISTS `s_hot_info`;
CREATE TABLE `s_hot_info` (
  `ID` varchar(50) NOT NULL,
  `DEL_FLAG` tinyint(1) NOT NULL,
  `CREATE_TIME` datetime NOT NULL,
  `PERIOD_TYPE` smallint(6) DEFAULT NULL,
  `TIME_DIS` varchar(512) DEFAULT NULL,
  `CONTENT_TYPE` smallint(6) DEFAULT NULL,
  `SOURCE_URL` varchar(2048) DEFAULT NULL,
  `RANK_ID` varchar(10) DEFAULT NULL,
  `EXPONENT` varchar(512) DEFAULT NULL,
  `HOT_TREND` smallint(6) DEFAULT NULL,
  `DETAIL_IMG` varchar(512) DEFAULT NULL,
  `DETAIL_INFO` varchar(2048) DEFAULT NULL,
  `KEY_WORDS` varchar(512) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of s_hot_info
-- ----------------------------
INSERT INTO `s_hot_info` VALUES ('0', '0', '2017-05-09 19:27:39', '1', '0', '0', '0', '1', '0', '0', null, null, '人民的名义');
INSERT INTO `s_hot_info` VALUES ('1', '0', '2017-05-10 15:06:34', '1', '02', '0', '1', '2', '242', '1', null, null, '万年历');
INSERT INTO `s_hot_info` VALUES ('2', '0', '2017-05-10 15:54:31', '1', '2017-05-09', '0', '22', '3', '02', '2', null, null, 'PPD');
INSERT INTO `s_hot_info` VALUES ('3', '0', '2017-05-10 16:06:23', '1', '2017-05-10', '1', '22', '4', '0', '0', null, null, '五五开');
INSERT INTO `s_hot_info` VALUES ('4', '0', '2017-05-10 16:06:46', '1', '2017-05-11', '1', '12', '5', '50', '1', null, null, '东莞时间');
INSERT INTO `s_hot_info` VALUES ('5', '0', '2017-05-10 17:11:54', '1', '2017-05-11', '2', '22', '6', '55', '2', null, null, '皇朝酒吧');

-- ----------------------------
-- Table structure for `s_judicature_info`
-- ----------------------------
DROP TABLE IF EXISTS `s_judicature_info`;
CREATE TABLE `s_judicature_info` (
  `ID` varchar(50) NOT NULL,
  `DEL_FLAG` tinyint(1) NOT NULL DEFAULT '0',
  `CREATE_TIME` datetime NOT NULL,
  `SAVING_CNT` int(11) DEFAULT NULL,
  `SAVED_CNT` int(11) DEFAULT NULL,
  `CHANGED_CNT` int(11) DEFAULT NULL,
  `COMPROMISE_CNT` int(11) DEFAULT NULL,
  `PURSUE_CNT` int(11) DEFAULT NULL,
  `ADJUDGED_CNT` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of s_judicature_info
-- ----------------------------
INSERT INTO `s_judicature_info` VALUES ('66', '0', '2017-05-12 02:03:12', '2214', '1245', '2465', '1456', '1114', '1117');

-- ----------------------------
-- Table structure for `s_taskstatus_info`
-- ----------------------------
DROP TABLE IF EXISTS `s_taskstatus_info`;
CREATE TABLE `s_taskstatus_info` (
  `id` varchar(50) NOT NULL,
  `del_flag` tinyint(1) NOT NULL,
  `create_time` datetime NOT NULL,
  `content_type` tinyint(5) DEFAULT NULL,
  `task_job_id` varchar(50) DEFAULT NULL,
  `task_status` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of s_taskstatus_info
-- ----------------------------
INSERT INTO `s_taskstatus_info` VALUES ('1', '0', '2017-05-09 09:37:40', '1', 'b77be89e929b4d5e874e34c64bfffdc6', '0');
INSERT INTO `s_taskstatus_info` VALUES ('10', '0', '2017-05-09 09:44:20', '2', 'ccc9e031128a4fa980c542868fa8a884', '0');
INSERT INTO `s_taskstatus_info` VALUES ('11', '0', '2017-05-09 09:44:34', '3', '97f87db16e194e95ab174a5e95fbc262', '1');
INSERT INTO `s_taskstatus_info` VALUES ('12', '0', '2017-05-09 09:44:47', '4', '72ceee1ac93941bcbef74faa0173368d', '2');
INSERT INTO `s_taskstatus_info` VALUES ('13', '0', '2017-05-09 09:45:01', '1', '3b0a5a6938604f63af9ddf2d793924a0', '0');
INSERT INTO `s_taskstatus_info` VALUES ('14', '0', '2017-05-09 09:45:20', '2', '3a90da1d1f2041288480604056c9f2e0', '1');
INSERT INTO `s_taskstatus_info` VALUES ('15', '0', '2017-05-09 09:45:38', '3', 'fd36fb87cb104b92843b7ad2eac433f2', '2');
INSERT INTO `s_taskstatus_info` VALUES ('16', '0', '2017-05-09 09:45:56', '4', '2c0ef4c7e77644ddb1673ff12195a23b', '0');
INSERT INTO `s_taskstatus_info` VALUES ('2', '0', '2017-05-09 09:41:50', '2', '2288e23c65064de0b53d35941f35dcc0', '1');
INSERT INTO `s_taskstatus_info` VALUES ('3', '0', '2017-05-09 09:42:09', '3', '165b83e8f74b4fb1835cd0a0874b2927', '2');
INSERT INTO `s_taskstatus_info` VALUES ('4', '0', '2017-05-09 09:42:28', '4', '9b8a4ef83be74b05922fb7905d9e5a72', '0');
INSERT INTO `s_taskstatus_info` VALUES ('5', '0', '2017-05-09 09:42:49', '1', '83791636486b4146974535cea2967cb4', '1');
INSERT INTO `s_taskstatus_info` VALUES ('6', '0', '2017-05-09 09:43:05', '2', '8c735490eedd4663a7ba4e7e745b7737', '2');
INSERT INTO `s_taskstatus_info` VALUES ('7', '0', '2017-05-09 09:43:20', '3', 'e35c51b421b240beb6d75d32e31dd480', '0');
INSERT INTO `s_taskstatus_info` VALUES ('8', '0', '2017-05-09 09:43:44', '4', '51e71031b4b94b9f98ffe7f4f7802092', '1');
INSERT INTO `s_taskstatus_info` VALUES ('9', '0', '2017-05-09 09:44:06', '1', 'a974eda7679d4ade8df76c613e440e7c', '2');

-- ----------------------------
-- Table structure for `s_tort_info`
-- ----------------------------
DROP TABLE IF EXISTS `s_tort_info`;
CREATE TABLE `s_tort_info` (
  `id` varchar(50) NOT NULL,
  `del_flag` tinyint(1) NOT NULL,
  `create_time` datetime NOT NULL,
  `content_type` tinyint(5) DEFAULT NULL,
  `total_cnt` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of s_tort_info
-- ----------------------------
INSERT INTO `s_tort_info` VALUES ('1', '0', '2017-05-08 16:20:52', '0', '50000');
INSERT INTO `s_tort_info` VALUES ('2', '0', '2017-05-08 16:21:38', '1', '8999');
INSERT INTO `s_tort_info` VALUES ('3', '0', '2017-05-08 16:22:10', '2', '19999');
INSERT INTO `s_tort_info` VALUES ('4', '0', '2017-05-08 16:22:31', '3', '29999');
INSERT INTO `s_tort_info` VALUES ('5', '0', '2017-05-08 16:22:52', '4', '3');
INSERT INTO `s_tort_info` VALUES ('6', '0', '2017-05-09 14:58:38', '5', '1000');

-- ----------------------------
-- Table structure for `s_total_info`
-- ----------------------------
DROP TABLE IF EXISTS `s_total_info`;
CREATE TABLE `s_total_info` (
  `id` varchar(50) NOT NULL,
  `del_flag` tinyint(1) NOT NULL,
  `create_time` datetime NOT NULL,
  `period_type` tinyint(5) DEFAULT NULL,
  `time_dis` varchar(50) DEFAULT NULL,
  `content_type` tinyint(5) DEFAULT NULL,
  `tort_cnt` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of s_total_info
-- ----------------------------
INSERT INTO `s_total_info` VALUES ('1', '0', '2017-05-07 14:26:09', '2', '20170508', '0', '10000');
INSERT INTO `s_total_info` VALUES ('10', '0', '2017-05-08 15:51:07', '0', '20170508', '4', '784');
INSERT INTO `s_total_info` VALUES ('11', '0', '2017-05-08 15:51:41', '1', '20170508', '0', '6658');
INSERT INTO `s_total_info` VALUES ('12', '0', '2017-05-08 15:52:11', '1', '20170508', '1', '456');
INSERT INTO `s_total_info` VALUES ('13', '0', '2017-05-08 15:52:33', '1', '20170508', '2', '789');
INSERT INTO `s_total_info` VALUES ('14', '0', '2017-05-08 15:52:46', '1', '20170508', '3', '2163');
INSERT INTO `s_total_info` VALUES ('15', '0', '2017-05-08 15:53:08', '1', '20170508', '4', '3654');
INSERT INTO `s_total_info` VALUES ('16', '0', '2017-05-09 14:42:46', '0', '20170508', '5', '523');
INSERT INTO `s_total_info` VALUES ('17', '0', '2017-05-09 14:43:23', '1', '20170508', '5', '156');
INSERT INTO `s_total_info` VALUES ('18', '0', '2017-05-09 14:43:40', '2', '20170508', '5', '86');
INSERT INTO `s_total_info` VALUES ('2', '0', '2017-05-08 14:26:58', '2', '20170508', '1', '99');
INSERT INTO `s_total_info` VALUES ('3', '0', '2017-05-09 14:27:44', '2', '20170508', '2', '199');
INSERT INTO `s_total_info` VALUES ('4', '0', '2017-05-10 14:27:58', '2', '20170508', '3', '299');
INSERT INTO `s_total_info` VALUES ('5', '0', '2017-05-11 14:28:16', '2', '20170508', '4', '399');
INSERT INTO `s_total_info` VALUES ('6', '0', '2017-05-12 15:49:03', '0', '20170508', '0', '2000');
INSERT INTO `s_total_info` VALUES ('7', '0', '2017-05-06 15:50:01', '0', '20170508', '1', '125');
INSERT INTO `s_total_info` VALUES ('8', '0', '2017-05-08 15:50:26', '0', '20170508', '2', '146');
INSERT INTO `s_total_info` VALUES ('9', '0', '2017-05-08 15:50:48', '0', '20170508', '3', '455');

-- ----------------------------
-- Table structure for `url_re_city`
-- ----------------------------
DROP TABLE IF EXISTS `url_re_city`;
CREATE TABLE `url_re_city` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(250) DEFAULT NULL,
  `url` varchar(250) DEFAULT NULL,
  `type` int(11) DEFAULT NULL,
  `ip` varchar(50) DEFAULT NULL,
  `country` varchar(50) DEFAULT NULL,
  `country_id` varchar(50) DEFAULT NULL,
  `area` varchar(50) DEFAULT NULL,
  `area_id` varchar(50) DEFAULT NULL,
  `region` varchar(50) DEFAULT NULL,
  `region_id` varchar(50) DEFAULT NULL,
  `city` varchar(50) DEFAULT NULL,
  `city_id` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=453 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of url_re_city
-- ----------------------------
INSERT INTO `url_re_city` VALUES ('3', '哔哩哔哩动画', 'http://www.bilibili.com/', '1', '180.97.199.10', '中国', 'CN', '华东', '300000', '江苏省', '320000', '苏州市', '320500');
INSERT INTO `url_re_city` VALUES ('4', '360影视', 'http://www.360kan.com/', '1', '220.181.157.98', '中国', 'CN', '华北', '100000', '北京市', '110000', '北京市', '110100');
INSERT INTO `url_re_city` VALUES ('5', '百度视频', 'http://v.baidu.com/', '1', '115.239.210.38', '中国', 'CN', '华东', '300000', '浙江省', '330000', '杭州市', '330100');
INSERT INTO `url_re_city` VALUES ('6', '芒果TV', 'http://www.mgtv.com/1', '1', '58.221.78.39', '中国', 'CN', '华东', '300000', '江苏省', '320000', '南通市', '320600');
INSERT INTO `url_re_city` VALUES ('7', '酷6网', 'http://www.ku6.com/', '1', '180.97.235.68', '中国', 'CN', '华东', '300000', '江苏省', '320000', '苏州市', '320500');
INSERT INTO `url_re_city` VALUES ('8', '响巢看看', 'http://www.kankan.com/?id=731002', '1', '183.131.178.75', '中国', 'CN', '华东', '300000', '浙江省', '330000', '湖州市', '330500');
INSERT INTO `url_re_city` VALUES ('9', '凤凰视频', 'http://v.ifeng.com/', '1', '61.155.237.56', '中国', 'CN', '华东', '300000', '江苏省', '320000', '南京市', '320100');
INSERT INTO `url_re_city` VALUES ('10', '56网', 'http://www.56.com/', '1', '221.229.202.148', '中国', 'CN', '华东', '300000', '江苏省', '320000', '徐州市', '320300');
INSERT INTO `url_re_city` VALUES ('11', '乐视网', 'http://www.le.com/', '1', '221.229.202.149', '中国', 'CN', '华东', '300000', '江苏省', '320000', '徐州市', '320300');
INSERT INTO `url_re_city` VALUES ('12', '人民电视', 'http://tv.people.com.cn/', '1', '180.97.235.68', '中国', 'CN', '华东', '300000', '江苏省', '320000', '苏州市', '320500');
INSERT INTO `url_re_city` VALUES ('13', '风行高清电影', 'http://www.fun.tv/?alliance=63645', '1', '220.181.167.6', '中国', 'CN', '华北', '100000', '北京市', '110000', '北京市', '110100');
INSERT INTO `url_re_city` VALUES ('14', '第一视频', 'http://www.v1.cn/', '1', '122.228.92.75', '中国', 'CN', '华东', '300000', '浙江省', '330000', '温州市', '330300');
INSERT INTO `url_re_city` VALUES ('15', '环球网视频', 'http://v.huanqiu.com/', '1', '180.101.217.141', '中国', 'CN', '华东', '300000', '江苏省', '320000', '扬州市', '321000');
INSERT INTO `url_re_city` VALUES ('16', 'PPTV网络电视', 'http://www.pptv.com/', '1', '202.102.68.102', '中国', 'CN', '华东', '300000', '江苏省', '320000', '南京市', '320100');
INSERT INTO `url_re_city` VALUES ('17', 'PPS影音', 'http://www.pps.tv/', '1', '58.220.49.142', '中国', 'CN', '华东', '300000', '江苏省', '320000', '扬州市', '321000');
INSERT INTO `url_re_city` VALUES ('18', '爱西柚视频', 'http://xiyou.cntv.cn/', '1', '58.222.19.59', '中国', 'CN', '华东', '300000', '江苏省', '320000', '泰州市', '321200');
INSERT INTO `url_re_city` VALUES ('19', '激动网', 'http://www.joy.cn/', '1', '122.227.201.86', '中国', 'CN', '华东', '300000', '浙江省', '330000', '宁波市', '330200');
INSERT INTO `url_re_city` VALUES ('20', '优米网', 'http://www.youmi.cn/', '1', '123.103.21.247', '中国', 'CN', '华北', '100000', '北京市', '110000', '北京市', '110100');
INSERT INTO `url_re_city` VALUES ('21', '淘米视频', 'http://v.61.com/', '1', '58.221.40.46', '中国', 'CN', '华东', '300000', '江苏省', '320000', '南通市', '320600');
INSERT INTO `url_re_city` VALUES ('22', '爱拍原创', 'http://www.aipai.com/', '1', '58.223.166.226', '中国', 'CN', '华东', '300000', '江苏省', '320000', '淮安市', '320800');
INSERT INTO `url_re_city` VALUES ('23', '爆米花视频', 'http://www.baomihua.com/', '1', '49.79.232.225', '中国', 'CN', '华东', '300000', '江苏省', '320000', '南京市', '320100');
INSERT INTO `url_re_city` VALUES ('24', '童话村', 'http://www.tonghuacun.com/', '1', '117.23.50.24', '中国', 'CN', '西北', '600000', '陕西省', '610000', '西安市', '610100');
INSERT INTO `url_re_city` VALUES ('25', '神马影院', 'http://www.ikua.cc/', '1', '23.225.167.40', '美国', 'US', '', '', '', '', '', '101');
INSERT INTO `url_re_city` VALUES ('26', '热片网', 'http://www.repian.com/', '1', '183.2.191.9', '中国', 'CN', '华南', '800000', '广东省', '440000', '深圳市', '440300');
INSERT INTO `url_re_city` VALUES ('27', '电影天堂', 'http://www.dy2018.com/', '1', '121.201.45.144', '中国', 'CN', '华南', '800000', '广东省', '440000', '中山市', '442000');
INSERT INTO `url_re_city` VALUES ('28', '人人影视', 'http://www.51rrkank.com/', '1', '180.150.230.201', '韩国', 'KR', '', '', '', '', '', '101');
INSERT INTO `url_re_city` VALUES ('29', '飘花电影网', 'http://www.piaohua.com/', '1', '192.151.230.248', '美国', 'US', '', '', '', '', '', '');
INSERT INTO `url_re_city` VALUES ('30', '阳光电影', 'http://www.ygdy8.com/', '1', '23.234.1.21', '美国', 'US', '', '', '', '', '', '');
INSERT INTO `url_re_city` VALUES ('31', '天天影院', 'http://www.zzlxs.net/', '1', '119.147.114.163', '中国', 'CN', '华南', '800000', '广东省', '440000', '东莞市', '441900');
INSERT INTO `url_re_city` VALUES ('32', '乐乐影视', 'http://www.85de.com/llyy.html', '1', '103.15.122.52', '香港', 'HK', '', '', '香港特别行政区', 'HK_01', '', '');
INSERT INTO `url_re_city` VALUES ('33', '九九影院', 'http://www.997v.com/', '1', '107.151.202.11', '美国', 'US', '', '', '', '', '', '');
INSERT INTO `url_re_city` VALUES ('34', '1905电影网', 'http://www.1905.com/mdb/film/list/country-USA/', '1', '222.186.140.75', '中国', 'CN', '华东', '300000', '江苏省', '320000', '镇江市', '321100');
INSERT INTO `url_re_city` VALUES ('35', '一流影院', 'http://www.dy166.net/', '1', '218.247.81.122', '中国', 'CN', '西南', '500000', '四川省', '510000', '成都市', '510100');
INSERT INTO `url_re_city` VALUES ('36', '琪琪影院', 'http://www.nk77.com/view/49692/', '1', '115.159.161.186', '中国', 'CN', '华东', '300000', '上海市', '310000', '上海市', '310100');
INSERT INTO `url_re_city` VALUES ('37', 'LOL电影天堂', 'http://www.loldytt.com/', '1', '47.90.50.147', '香港', 'HK', '', '', '香港特别行政区', 'HK_01', '', '');
INSERT INTO `url_re_city` VALUES ('38', '2345影视', 'http://dianying.2345.com/', '1', '221.228.75.191', '中国', 'CN', '华东', '300000', '江苏省', '320000', '无锡市', '320200');
INSERT INTO `url_re_city` VALUES ('39', '西瓜电影', 'http://www.xigua110.com/', '1', '121.201.45.173', '中国', 'CN', '华南', '800000', '广东省', '440000', '中山市', '442000');
INSERT INTO `url_re_city` VALUES ('40', 'ck电影网', 'http://www.ckck.tv/', '1', '58.211.137.87', '中国', 'CN', '华东', '300000', '江苏省', '320000', '苏州市', '320500');
INSERT INTO `url_re_city` VALUES ('41', '吉吉影音', 'http://www.iskdy.com/', '1', '121.201.77.132', '中国', 'CN', '华南', '800000', '广东省', '440000', '中山市', '442000');
INSERT INTO `url_re_city` VALUES ('42', '放电影网', 'http://www.fangdianying.tv/gufanbuzishang/', '1', '119.28.61.71', '中国', 'CN', '华北', '100000', '北京市', '110000', '北京市', '110100');
INSERT INTO `url_re_city` VALUES ('43', '圣城家园', 'http://www.cnscg.com/', '1', '58.211.137.231', '中国', 'CN', '华东', '300000', '江苏省', '320000', '苏州市', '320500');
INSERT INTO `url_re_city` VALUES ('44', '中国高清网', 'http://gaoqing.la/xxx-the-return-of-xander-cage.html', '1', '119.188.97.209', '中国', 'CN', '华东', '300000', '山东省', '370000', '济南市', '370100');
INSERT INTO `url_re_city` VALUES ('45', '迅雷电影天堂', 'http://www.xldytt.com/forum-34-1.html', '1', '122.10.95.58', '香港', 'HK', '', '', '香港特别行政区', 'HK_01', '', '');
INSERT INTO `url_re_city` VALUES ('46', '小调网', 'http://www.xiaopian.com/', '1', '121.201.121.21', '中国', 'CN', '华南', '800000', '广东省', '440000', '中山市', '442000');
INSERT INTO `url_re_city` VALUES ('47', '豆瓣电影', 'https://movie.douban.com/subject/26688480/?tag=热门&from=gaia', '1', '115.182.201.6', '中国', 'CN', '华北', '100000', '北京市', '110000', '北京市', '110100');
INSERT INTO `url_re_city` VALUES ('48', '80s手机电影', 'http://www.80s.tw/', '1', '58.222.42.9', '中国', 'CN', '华东', '300000', '江苏省', '320000', '泰州市', '321200');
INSERT INTO `url_re_city` VALUES ('49', '被窝电影', 'http://www.beiwo.tv/', '1', '106.185.55.150', '日本', 'JP', '', '', '', '', '', '101');
INSERT INTO `url_re_city` VALUES ('50', '6V电影网', 'http://www.6vhao.net/', '1', '23.234.1.21', '美国', 'US', '', '', '', '', '', '');
INSERT INTO `url_re_city` VALUES ('51', '多特电影', 'http://www.dotdy.com/', '1', '223.202.123.103', '中国', 'CN', '华北', '100000', '北京市', '110000', '北京市', '110100');
INSERT INTO `url_re_city` VALUES ('52', '八哥电影', 'http://www.8gdyhd.com/', '1', '125.88.190.11', '中国', 'CN', '华南', '800000', '广东省', '440000', '佛山市', '440600');
INSERT INTO `url_re_city` VALUES ('53', '7060手机电影', 'http://www.7060.la/', '1', '103.38.64.46', '香港', 'HK', '', '', '香港特别行政区', 'HK_01', '', '');
INSERT INTO `url_re_city` VALUES ('54', '优酷', 'www.youku.com', '1', '106.11.186.2', '中国', 'CN', '华北', '100000', '河北省', '130000', '张家口市', '130700');
INSERT INTO `url_re_city` VALUES ('55', '爱奇艺', 'www.iqiyi.com', '1', '58.220.49.142', '中国', 'CN', '华东', '300000', '江苏省', '320000', '扬州市', '321000');
INSERT INTO `url_re_city` VALUES ('56', '腾讯', 'V.qq.com', '1', '58.216.6.22', '中国', 'CN', '华东', '300000', '江苏省', '320000', '常州市', '320400');
INSERT INTO `url_re_city` VALUES ('57', '乐视', 'www.letv.com', '1', '221.229.202.149', '中国', 'CN', '华东', '300000', '江苏省', '320000', '徐州市', '320300');
INSERT INTO `url_re_city` VALUES ('58', '哔哩哔哩', 'www.bilibili.com', '1', '180.97.199.9', '中国', 'CN', '华东', '300000', '江苏省', '320000', '苏州市', '320500');
INSERT INTO `url_re_city` VALUES ('59', '搜狐视频', 'tv.sohu.com', '1', '101.227.172.11', '中国', 'CN', '华东', '300000', '上海市', '310000', '上海市', '310100');
INSERT INTO `url_re_city` VALUES ('60', 'AcFun', 'www.acfun.com', '1', '202.102.110.203', '中国', 'CN', '华东', '300000', '江苏省', '320000', '南京市', '320100');
INSERT INTO `url_re_city` VALUES ('61', '360影视', 'www.360kan.com', '1', '220.181.157.98', '中国', 'CN', '华北', '100000', '北京市', '110000', '北京市', '110100');
INSERT INTO `url_re_city` VALUES ('62', '土豆网', 'www.tudou.com', '1', '106.11.186.2', '中国', 'CN', '华北', '100000', '河北省', '130000', '张家口市', '130700');
INSERT INTO `url_re_city` VALUES ('63', '响巢看看', 'www.kankan.com', '1', '183.131.178.75', '中国', 'CN', '华东', '300000', '浙江省', '330000', '湖州市', '330500');
INSERT INTO `url_re_city` VALUES ('64', '酷6网', 'www.ku6.com', '1', '180.97.235.68', '中国', 'CN', '华东', '300000', '江苏省', '320000', '苏州市', '320500');
INSERT INTO `url_re_city` VALUES ('65', '凤凰视频', 'v.ifeng.com', '1', '61.147.210.175', '中国', 'CN', '华东', '300000', '江苏省', '320000', '南通市', '320600');
INSERT INTO `url_re_city` VALUES ('66', '56网', 'www.56.com', '1', '221.229.202.148', '中国', 'CN', '华东', '300000', '江苏省', '320000', '徐州市', '320300');
INSERT INTO `url_re_city` VALUES ('67', '人民电视', 'tv.people.com.cn', '1', '180.97.183.126', '中国', 'CN', '华东', '300000', '江苏省', '320000', '扬州市', '321000');
INSERT INTO `url_re_city` VALUES ('68', '六间房秀场', 'www.6.cn', '1', '58.221.78.112', '中国', 'CN', '华东', '300000', '江苏省', '320000', '南通市', '320600');
INSERT INTO `url_re_city` VALUES ('69', '风行网', 'www.fun.tv', '1', '220.181.167.5', '中国', 'CN', '华北', '100000', '北京市', '110000', '北京市', '110100');
INSERT INTO `url_re_city` VALUES ('70', '第一视频', 'www.v1.cn', '1', '122.228.92.79', '中国', 'CN', '华东', '300000', '浙江省', '330000', '温州市', '330300');
INSERT INTO `url_re_city` VALUES ('71', '环球网视频', 'v.huanqiu.com', '1', '180.101.217.151', '中国', 'CN', '华东', '300000', '江苏省', '320000', '扬州市', '321000');
INSERT INTO `url_re_city` VALUES ('72', 'PPTV网络电视', 'www.pptv.com', '1', '202.102.68.102', '中国', 'CN', '华东', '300000', '江苏省', '320000', '南京市', '320100');
INSERT INTO `url_re_city` VALUES ('73', 'PPS影音', 'www.pps.tv', '1', '58.220.49.142', '中国', 'CN', '华东', '300000', '江苏省', '320000', '扬州市', '321000');
INSERT INTO `url_re_city` VALUES ('74', '芒果TV', 'www.mgtv.com', '1', '61.147.210.175', '中国', 'CN', '华东', '300000', '江苏省', '320000', '南通市', '320600');
INSERT INTO `url_re_city` VALUES ('75', '爱西柚视频', 'xiyou.cntv.cn', '1', '61.155.162.122', '中国', 'CN', '华东', '300000', '江苏省', '320000', '苏州市', '320500');
INSERT INTO `url_re_city` VALUES ('76', 'm1905电影网', 'www.1905.com', '1', '61.147.219.9', '中国', 'CN', '华东', '300000', '江苏省', '320000', '南通市', '320600');
INSERT INTO `url_re_city` VALUES ('77', '激动网', 'www.joy.cn', '1', '122.227.201.86', '中国', 'CN', '华东', '300000', '浙江省', '330000', '宁波市', '330200');
INSERT INTO `url_re_city` VALUES ('78', '优米', 'www.youmi.cn', '1', '123.103.21.247', '中国', 'CN', '华北', '100000', '北京市', '110000', '北京市', '110100');
INSERT INTO `url_re_city` VALUES ('79', '我秀', 'www.woxiu.com', '1', '58.222.42.9', '中国', 'CN', '华东', '300000', '江苏省', '320000', '泰州市', '321200');
INSERT INTO `url_re_city` VALUES ('80', '看看新闻', 'www.kankanews.com', '1', '61.155.237.46', '中国', 'CN', '华东', '300000', '江苏省', '320000', '南京市', '320100');
INSERT INTO `url_re_city` VALUES ('81', '淘米', 'v.61.com', '1', '115.231.128.35', '中国', 'CN', '华东', '300000', '浙江省', '330000', '衢州市', '330800');
INSERT INTO `url_re_city` VALUES ('82', '爱拍原创', 'www.aipai.com', '1', '49.79.233.15', '中国', 'CN', '华东', '300000', '江苏省', '320000', '南京市', '320100');
INSERT INTO `url_re_city` VALUES ('83', '九秀', 'www.9xiu.com', '1', '58.222.40.26', '中国', 'CN', '华东', '300000', '江苏省', '320000', '泰州市', '321200');
INSERT INTO `url_re_city` VALUES ('84', '爆米花', 'www.baomihua.com', '1', '122.225.28.145', '中国', 'CN', '华东', '300000', '浙江省', '330000', '嘉兴市', '330400');
INSERT INTO `url_re_city` VALUES ('85', 'ZOL视频', 'zol.iqiyi.com.cn', '1', '107.155.25.115', '美国', 'US', '', '', '', '', '', '');
INSERT INTO `url_re_city` VALUES ('86', '钢铁视频', 'news.mysteel.com', '1', '61.129.113.111', '中国', 'CN', '华东', '300000', '上海市', '310000', '上海市', '310100');
INSERT INTO `url_re_city` VALUES ('87', '中搜视频', 'video.zhongsou.com', '1', '103.29.135.24', '中国', 'CN', '华北', '100000', '北京市', '110000', '北京市', '110100');
INSERT INTO `url_re_city` VALUES ('88', '播视网', 'www.boosj.com', '1', '222.186.137.102', '中国', 'CN', '华东', '300000', '江苏省', '320000', '镇江市', '321100');
INSERT INTO `url_re_city` VALUES ('89', '时光网', 'www.mtime.com', '1', '59.151.32.20', '中国', 'CN', '华北', '100000', '北京市', '110000', '北京市', '110100');
INSERT INTO `url_re_city` VALUES ('90', '豆瓣电影', 'movie.douban.com', '1', '115.182.201.8', '中国', 'CN', '华北', '100000', '北京市', '110000', '北京市', '110100');
INSERT INTO `url_re_city` VALUES ('91', '华数TV', 'www.wasu.cn', '1', '180.97.168.180', '中国', 'CN', '华东', '300000', '江苏省', '320000', '苏州市', '320500');
INSERT INTO `url_re_city` VALUES ('92', '奇趣视频', 'www.qiqusp.com', '1', '106.187.37.240', '日本', 'JP', '', '', '', '', '', '');
INSERT INTO `url_re_city` VALUES ('93', '迈视网', 'www.maxtv.cn', '1', '58.223.166.226', '中国', 'CN', '华东', '300000', '江苏省', '320000', '淮安市', '320800');
INSERT INTO `url_re_city` VALUES ('94', '琥珀网', 'www.hupo.tv', '1', '182.92.189.193', '中国', 'CN', '华北', '100000', '北京市', '110000', '北京市', '110100');
INSERT INTO `url_re_city` VALUES ('95', '新华视频', 'www.news.cn', '1', '221.228.64.30', '中国', 'CN', '华东', '300000', '江苏省', '320000', '无锡市', '320200');
INSERT INTO `url_re_city` VALUES ('96', '百度视频', 'v.baidu.com', '1', '115.239.210.38', '中国', 'CN', '华东', '300000', '浙江省', '330000', '杭州市', '330100');
INSERT INTO `url_re_city` VALUES ('97', '新浪视频', 'video.sina.com.cn', '1', '114.80.223.61', '中国', 'CN', '华东', '300000', '上海市', '310000', '上海市', '310100');
INSERT INTO `url_re_city` VALUES ('98', '人看人视频', 'www.rkanr.com', '1', '183.61.109.14', '中国', 'CN', '华南', '800000', '广东省', '440000', '广州市', '440100');
INSERT INTO `url_re_city` VALUES ('99', '悠视网', 'www.uusee.com', '1', '117.78.42.51', '中国', 'CN', '华北', '100000', '北京市', '110000', '北京市', '110100');
INSERT INTO `url_re_city` VALUES ('100', '中国佛教电影网', 'www.fjdy.org', '1', '222.222.210.88', '中国', 'CN', '华北', '100000', '河北省', '130000', '石家庄市', '130100');
INSERT INTO `url_re_city` VALUES ('101', '放放影院', 'www.fangfang.cc', '1', '23.226.179.137', '美国', 'US', '', '', '', '', '', '');
INSERT INTO `url_re_city` VALUES ('102', '山猫电影', 'www.3maody.com', '1', '103.53.224.252', '香港', 'HK', '', '', '香港特别行政区', 'HK_01', '', '');
INSERT INTO `url_re_city` VALUES ('103', '电影天堂', 'www.dytt8.net', '1', '192.126.112.124', '美国', 'US', '', '', '', '', '', '');
INSERT INTO `url_re_city` VALUES ('104', '酷米网', 'www.kumi.cn', '1', '122.226.182.42', '中国', 'CN', '华东', '300000', '浙江省', '330000', '台州市', '331000');
INSERT INTO `url_re_city` VALUES ('105', '天上人间动漫网', 'www.52tian.net', '1', '58.218.215.140', '中国', 'CN', '华东', '300000', '江苏省', '320000', '徐州市', '320300');
INSERT INTO `url_re_city` VALUES ('106', '极影动漫网', 'www.jiyingdm.com', '1', '103.35.149.199', '香港', 'HK', '', '', '香港特别行政区', 'HK_01', '', '');
INSERT INTO `url_re_city` VALUES ('107', '比特大雄', 'www.btdx8.com', '1', '23.225.140.202', '美国', 'US', '', '', '', '', '', '');
INSERT INTO `url_re_city` VALUES ('108', '维棠', 'www.vidown.cn', '1', '121.40.40.38', '中国', 'CN', '华东', '300000', '浙江省', '330000', '杭州市', '330100');
INSERT INTO `url_re_city` VALUES ('109', '迅多影视', 'www.xunduo.cc', '1', '216.189.52.216', '美国', 'US', '', '', '', '', '', '');
INSERT INTO `url_re_city` VALUES ('110', '西瓜电影', 'www.xigua110.com', '1', '183.2.191.9', '中国', 'CN', '华南', '800000', '广东省', '440000', '深圳市', '440300');
INSERT INTO `url_re_city` VALUES ('111', '面包网', 'www.mianbao99.com', '1', '121.201.45.173', '中国', 'CN', '华南', '800000', '广东省', '440000', '中山市', '442000');
INSERT INTO `url_re_city` VALUES ('112', '战地影院', 'www.zhandi.cc', '1', '23.234.13.89', '美国', 'US', '', '', '', '', '', '');
INSERT INTO `url_re_city` VALUES ('113', '山猫电影', 'www.3maody.com', '1', '103.53.224.252', '香港', 'HK', '', '', '香港特别行政区', 'HK_01', '', '');
INSERT INTO `url_re_city` VALUES ('114', '酷咕鸭电影', 'www.kuguya.com', '1', '103.53.224.6', '香港', 'HK', '', '', '香港特别行政区', 'HK_01', '', '');
INSERT INTO `url_re_city` VALUES ('115', '老片网', 'www.laopian.tv', '1', '106.185.54.41', '日本', 'JP', '', '', '', '', '', '');
INSERT INTO `url_re_city` VALUES ('116', '电影天堂', 'www.loldytt.com', '1', '47.90.50.147', '香港', 'HK', '', '', '香港特别行政区', 'HK_01', '', '');
INSERT INTO `url_re_city` VALUES ('117', '非凡影院', 'www.feifandy.net', '1', '59.45.175.80', '中国', 'CN', '东北', '200000', '辽宁省', '210000', '阜新市', '210900');
INSERT INTO `url_re_city` VALUES ('118', '暴风影音', 'www.baofeng.com', '1', '124.243.221.205', '中国', 'CN', '华北', '100000', '北京市', '110000', '北京市', '110100');
INSERT INTO `url_re_city` VALUES ('119', '蓝光影院', 'www.languang.cc', '1', '175.6.247.140', '中国', 'CN', '华中', '400000', '湖南省', '430000', '衡阳市', '430400');
INSERT INTO `url_re_city` VALUES ('120', '爱你影院', 'www.20yy.com', '1', '180.97.168.189', '中国', 'CN', '华东', '300000', '江苏省', '320000', '苏州市', '320500');
INSERT INTO `url_re_city` VALUES ('121', '多多影院', 'www.dd13.tv', '1', '23.234.1.21', '美国', 'US', '', '', '', '', '', '');
INSERT INTO `url_re_city` VALUES ('122', '天龙影院', 'www.2mao.cc', '1', '36.7.130.36', '中国', 'CN', '华东', '300000', '安徽省', '340000', '合肥市', '340100');
INSERT INTO `url_re_city` VALUES ('123', '羽翼网', 'www.yuyiyuyi.com', '1', '106.186.18.132', '日本', 'JP', '', '', '', '', '', '');
INSERT INTO `url_re_city` VALUES ('124', '巴巴影院', 'www.baba.cc', '1', '175.6.247.140', '中国', 'CN', '华中', '400000', '湖南省', '430000', '衡阳市', '430400');
INSERT INTO `url_re_city` VALUES ('125', '去看电影网', 'www.qkdy.tv', '1', '162.221.192.14', '美国', 'US', '', '', '', '', '', '');
INSERT INTO `url_re_city` VALUES ('126', '薇薇影院', 'www.vv60.com', '1', '47.88.241.69', '新加坡', 'SG', '', '', '', '', '', '101');
INSERT INTO `url_re_city` VALUES ('127', '第一影院', 'www.1yy.cc', '1', '59.45.175.80', '中国', 'CN', '东北', '200000', '辽宁省', '210000', '阜新市', '210900');
INSERT INTO `url_re_city` VALUES ('128', '无忧影院', 'www.kp31.com', '1', '58.216.107.11', '中国', 'CN', '华东', '300000', '江苏省', '320000', '常州市', '320400');
INSERT INTO `url_re_city` VALUES ('129', '被窝电影', 'www.beiwo.tv', '1', '106.185.55.150', '日本', 'JP', '', '', '', '', '', '');
INSERT INTO `url_re_city` VALUES ('130', 'TOM51', 'www.qvodzy.com', '1', '222.186.132.66', '中国', 'CN', '华东', '300000', '江苏省', '320000', '镇江市', '321100');
INSERT INTO `url_re_city` VALUES ('131', '华龙电影院', 'www.hualyy.com', '1', '137.175.119.245', '美国', 'US', '', '', '', '', '', '');
INSERT INTO `url_re_city` VALUES ('132', '都看影院', 'www.idoukk.com', '1', '47.89.41.215', '香港', 'HK', '', '', '香港特别行政区', 'HK_01', '', '');
INSERT INTO `url_re_city` VALUES ('133', '好看电影网', 'www.ybtdj.com', '1', '137.175.14.89', '美国', 'US', '', '', '', '', '', '');
INSERT INTO `url_re_city` VALUES ('134', '五号影院', 'http://www.wuhao.cc/', '1', '59.45.175.80', '中国', 'CN', '东北', '200000', '辽宁省', '210000', '阜新市', '210900');
INSERT INTO `url_re_city` VALUES ('135', '德华影视', 'http://www.dehua.la/', '1', '113.10.198.196', '香港', 'HK', '', '', '香港特别行政区', 'HK_01', '', '');
INSERT INTO `url_re_city` VALUES ('136', '西部院线', 'http://www.xibu.tv/', '1', '175.6.247.140', '中国', 'CN', '华中', '400000', '湖南省', '430000', '衡阳市', '430400');
INSERT INTO `url_re_city` VALUES ('137', '金山影视', 'http://v.duba.com/', '1', '115.239.210.38', '中国', 'CN', '华东', '300000', '浙江省', '330000', '杭州市', '330100');
INSERT INTO `url_re_city` VALUES ('138', '先看', 'http://www.xiankan.com/', '1', '47.93.118.119', '中国', 'CN', '华北', '100000', '北京市', '110000', '北京市', '110100');
INSERT INTO `url_re_city` VALUES ('139', '未来影院', 'http://www.2k2k.cc/', '1', '210.14.145.54', '中国', 'CN', '华北', '100000', '北京市', '110000', '北京市', '110100');
INSERT INTO `url_re_city` VALUES ('140', '奇特影院', 'http://www.qitete.com/', '1', '59.125.42.228', '台湾', 'TW', '', '', '', '', '', '');
INSERT INTO `url_re_city` VALUES ('141', '电影乐园', 'http://www.vkeke.net/', '1', '162.212.182.61', '美国', 'US', '', '', '', '', '', '');
INSERT INTO `url_re_city` VALUES ('142', '雨蓝影视', 'http://www.yublue.com/', '1', '45.120.29.13', '香港', 'HK', '', '', '香港特别行政区', 'HK_01', '', '');
INSERT INTO `url_re_city` VALUES ('143', '热岛电影', 'http://www.iredao.com/', '1', '121.201.45.241', '中国', 'CN', '华南', '800000', '广东省', '440000', '中山市', '442000');
INSERT INTO `url_re_city` VALUES ('144', '大哥', 'http://www.dage8.cc/', '1', '23.234.30.172', '美国', 'US', '', '', '', '', '', '');
INSERT INTO `url_re_city` VALUES ('145', '瓜田网', 'http://www.guatian.com/', '1', '58.218.215.168', '中国', 'CN', '华东', '300000', '江苏省', '320000', '徐州市', '320300');
INSERT INTO `url_re_city` VALUES ('146', '半岛电影院', 'http://www.guatian.com/', '1', '58.218.215.168', '中国', 'CN', '华东', '300000', '江苏省', '320000', '徐州市', '320300');
INSERT INTO `url_re_city` VALUES ('147', '琪琪影院', 'http://www.77vcd.com/', '1', '59.125.42.228', '台湾', 'TW', '', '', '', '', '', '');
INSERT INTO `url_re_city` VALUES ('148', '七七电视', 'http://www.77ds.net/', '1', '23.234.13.89', '美国', 'US', '', '', '', '', '', '');
INSERT INTO `url_re_city` VALUES ('149', '微观乐', 'http://www.vguanle.com/', '1', '123.207.99.186', '中国', 'CN', '华北', '100000', '北京市', '110000', '北京市', '110100');
INSERT INTO `url_re_city` VALUES ('150', '齐鲁电影网', 'http://www.qilumovie.com/', '1', '183.136.218.39', '中国', 'CN', '华东', '300000', '浙江省', '330000', '衢州市', '330800');
INSERT INTO `url_re_city` VALUES ('151', '星空电影', 'http://www.xkdy.net/', '1', '1.234.19.70', '韩国', 'KR', '', '', '', '', '', '');
INSERT INTO `url_re_city` VALUES ('152', '热片网', 'http://www.repian.com/', '1', '121.201.45.173', '中国', 'CN', '华南', '800000', '广东省', '440000', '中山市', '442000');
INSERT INTO `url_re_city` VALUES ('153', '无忧影院', 'http://www.5u.cc/', '1', '23.234.13.89', '美国', 'US', '', '', '', '', '', '');
INSERT INTO `url_re_city` VALUES ('154', '电影乐园', 'http://www.vkeke.net/', '1', '162.212.182.61', '美国', 'US', '', '', '', '', '', '');
INSERT INTO `url_re_city` VALUES ('155', '好看站', 'http://www.haokan666.com/', '1', '67.21.86.115', '美国', 'US', '', '', '', '', '', '');
INSERT INTO `url_re_city` VALUES ('156', '大狗狗', 'http://www.dagougou.cc/', '1', '23.234.13.89', '美国', 'US', '', '', '', '', '', '');
INSERT INTO `url_re_city` VALUES ('157', '电影港', 'http://www.dygang.com/', '1', '180.101.217.173', '中国', 'CN', '华东', '300000', '江苏省', '320000', '扬州市', '321000');
INSERT INTO `url_re_city` VALUES ('158', '百娱影视', 'http://www.baiy.net/dz1/', '1', '59.125.42.228', '台湾', 'TW', '', '', '', '', '', '');
INSERT INTO `url_re_city` VALUES ('159', '迅雷铺', 'http://www.xlpu.cc/', '1', '23.234.13.89', '美国', 'US', '', '', '', '', '', '');
INSERT INTO `url_re_city` VALUES ('160', 'XXDM', 'http://www.xxdm.org/', '1', '211.75.14.184', '台湾', 'TW', '', '', '', '', '', '');
INSERT INTO `url_re_city` VALUES ('161', '零零柒影视', 'http://www.g007.com/', '1', '183.136.218.39', '中国', 'CN', '华东', '300000', '浙江省', '330000', '衢州市', '330800');
INSERT INTO `url_re_city` VALUES ('162', '去看电影网', 'http://www.qkdy.tv/', '1', '162.221.192.14', '美国', 'US', '', '', '', '', '', '');
INSERT INTO `url_re_city` VALUES ('163', 'TV162', 'http://www.tv162.com/', '1', '180.131.50.197', '韩国', 'KR', '', '', '', '', '', '');
INSERT INTO `url_re_city` VALUES ('164', '老古影院', 'http://www.laogu.cc/', '1', '58.216.17.120', '中国', 'CN', '华东', '300000', '江苏省', '320000', '常州市', '320400');
INSERT INTO `url_re_city` VALUES ('165', '毒蛇影院', 'http://www.dushe.net/', '1', '23.234.13.89', '美国', 'US', '', '', '', '', '', '');
INSERT INTO `url_re_city` VALUES ('166', '55电视网', 'http://www.55ds.cc/', '1', '218.65.212.174', '中国', 'CN', '华南', '800000', '广西壮族自治区', '450000', '桂林市', '450300');
INSERT INTO `url_re_city` VALUES ('167', '神马影视', 'http://www.1684.cc/', '1', '175.6.247.140', '中国', 'CN', '华中', '400000', '湖南省', '430000', '衡阳市', '430400');
INSERT INTO `url_re_city` VALUES ('168', '威看影视网', 'http://www.7vk.com/', '1', '58.84.53.84', '香港', 'HK', '', '', '香港特别行政区', 'HK_01', '', '');
INSERT INTO `url_re_city` VALUES ('169', '双翼影院', 'http://www.8e7e.com/', '1', '45.113.82.31', '美国', 'US', '', '', '', '', '', '');
INSERT INTO `url_re_city` VALUES ('170', '剧风在线', 'http://www.88520.cc/', '1', '23.234.1.21', '美国', 'US', '', '', '', '', '', '');
INSERT INTO `url_re_city` VALUES ('171', '广清影院', 'http://www.93z.cc/', '1', '202.75.220.32', '中国', 'CN', '华东', '300000', '浙江省', '330000', '杭州市', '330100');
INSERT INTO `url_re_city` VALUES ('172', '不卡吧影视', 'http://www.bukaba.com/', '1', '221.228.64.40', '中国', 'CN', '华东', '300000', '江苏省', '320000', '无锡市', '320200');
INSERT INTO `url_re_city` VALUES ('173', '哥哥影视', 'http://www.gege.la/', '1', '58.216.107.11', '中国', 'CN', '华东', '300000', '江苏省', '320000', '常州市', '320400');
INSERT INTO `url_re_city` VALUES ('174', '幸福影视', 'http://www.contentchina.com/', '1', '119.23.136.186', '中国', 'CN', '华南', '800000', '广东省', '440000', '深圳市', '440300');
INSERT INTO `url_re_city` VALUES ('175', '五号影院', 'http://www.wuhao.cc/', '1', '59.45.175.80', '中国', 'CN', '东北', '200000', '辽宁省', '210000', '阜新市', '210900');
INSERT INTO `url_re_city` VALUES ('176', '黑夜影视', 'http://www.heiye.cc/', '1', '205.209.137.217', '美国', 'US', '', '', '', '', '', '');
INSERT INTO `url_re_city` VALUES ('177', '非凡影院', 'http://www.feifandy.net/', '1', '59.45.175.80', '中国', 'CN', '东北', '200000', '辽宁省', '210000', '阜新市', '210900');
INSERT INTO `url_re_city` VALUES ('178', '爱新电影', 'http://www.ixdy.com/', '1', '183.136.218.39', '中国', 'CN', '华东', '300000', '浙江省', '330000', '衢州市', '330800');
INSERT INTO `url_re_city` VALUES ('179', '雕本网', 'http://www.diaoben.com/', '1', '58.211.137.243', '中国', 'CN', '华东', '300000', '江苏省', '320000', '苏州市', '320500');
INSERT INTO `url_re_city` VALUES ('180', '神夜动漫', 'http://www.sydm.hk/', '1', '118.184.18.77', '中国', 'CN', '华东', '300000', '上海市', '310000', '上海市', '310100');
INSERT INTO `url_re_city` VALUES ('181', '黑米网', 'http://www.heimi001.com/', '1', '121.201.22.48', '中国', 'CN', '华南', '800000', '广东省', '440000', '中山市', '442000');
INSERT INTO `url_re_city` VALUES ('182', '电视剧大全', 'http://www.021nba.com/', '1', '113.10.195.204', '香港', 'HK', '', '', '香港特别行政区', 'HK_01', '', '');
INSERT INTO `url_re_city` VALUES ('183', '爱看影院', 'http://www.aikan.tv/', '1', '128.1.171.212', '美国', 'US', '', '', '', '', '', '');
INSERT INTO `url_re_city` VALUES ('184', '电影导航', 'http://www.dydh.tv/zt/', '1', '162.251.21.227', '英属维尔京群岛', 'VG', '', '', '', '', '', '');
INSERT INTO `url_re_city` VALUES ('185', '先锋影院', 'http://www.xfwz.cc/', '1', '222.186.57.168', '中国', 'CN', '华东', '300000', '江苏省', '320000', '镇江市', '321100');
INSERT INTO `url_re_city` VALUES ('186', '奇艺动漫', 'http://www.qydm.net/', '1', '43.246.173.233', '香港', 'HK', '', '', '香港特别行政区', 'HK_01', '', '');
INSERT INTO `url_re_city` VALUES ('187', '爱动漫', 'http://www.idm.cc/', '1', '58.211.137.76', '中国', 'CN', '华东', '300000', '江苏省', '320000', '苏州市', '320500');
INSERT INTO `url_re_city` VALUES ('188', '起跑线', 'http://tv.qpx.com/', '1', '122.228.206.88', '中国', 'CN', '华东', '300000', '浙江省', '330000', '温州市', '330300');
INSERT INTO `url_re_city` VALUES ('189', 'yes影视', 'http://www.yse360.cc/', '1', '67.198.213.19', '美国', 'US', '', '', '', '', '', '');
INSERT INTO `url_re_city` VALUES ('190', '雅图在线', 'http://www.yatu.tv/', '1', '175.6.247.143', '中国', 'CN', '华中', '400000', '湖南省', '430000', '衡阳市', '430400');
INSERT INTO `url_re_city` VALUES ('191', '55电视网', 'http://www.55ds.cc/', '1', '218.65.212.176', '中国', 'CN', '华南', '800000', '广西壮族自治区', '450000', '桂林市', '450300');
INSERT INTO `url_re_city` VALUES ('192', '七色影院', 'http://www.qisedy.com/', '1', '180.150.230.201', '韩国', 'KR', '', '', '', '', '', '');
INSERT INTO `url_re_city` VALUES ('193', '首播影视网', 'http://www.isoboys.com/', '1', '103.206.20.111', '香港', 'HK', '', '', '香港特别行政区', 'HK_01', '', '');
INSERT INTO `url_re_city` VALUES ('194', '89TV', 'http://www.89tv.cc/', '1', '113.10.198.110', '香港', 'HK', '', '', '香港特别行政区', 'HK_01', '', '');
INSERT INTO `url_re_city` VALUES ('195', '九宝宝电影', 'http://www.9bby.com/', '1', '103.68.192.26', '中国', 'CN', '华东', '300000', '江苏省', '320000', '镇江市', '321100');
INSERT INTO `url_re_city` VALUES ('196', '飘花资源网', 'http://www.piaohua.com/', '1', '121.201.121.17', '中国', 'CN', '华南', '800000', '广东省', '440000', '中山市', '442000');
INSERT INTO `url_re_city` VALUES ('197', '齐鲁电影网', 'http://www.qilumovie.com/', '1', '183.136.218.39', '中国', 'CN', '华东', '300000', '浙江省', '330000', '衢州市', '330800');
INSERT INTO `url_re_city` VALUES ('198', '琪琪布电影网', 'http://www.qiqibu8.com/', '1', '59.45.175.80', '中国', 'CN', '东北', '200000', '辽宁省', '210000', '阜新市', '210900');
INSERT INTO `url_re_city` VALUES ('199', '乐酷影视', 'http://www.6k.com/', '1', '61.164.149.231', '中国', 'CN', '华东', '300000', '浙江省', '330000', '温州市', '330300');
INSERT INTO `url_re_city` VALUES ('200', 'BT电影网', 'http://www.btsou.org/', '1', '116.255.174.149', '中国', 'CN', '华中', '400000', '河南省', '410000', '郑州市', '410100');
INSERT INTO `url_re_city` VALUES ('201', '热血电视剧', 'http://www.rxdsj.com/', '1', '23.234.13.89', '美国', 'US', '', '', '', '', '', '');
INSERT INTO `url_re_city` VALUES ('202', '天龙影院', 'http://www.2mao.cc/', '1', '36.7.130.36', '中国', 'CN', '华东', '300000', '安徽省', '340000', '合肥市', '340100');
INSERT INTO `url_re_city` VALUES ('203', '金瓜影视', 'http://www.jinguatv.com/', '1', '118.193.136.122', '中国', 'CN', '华东', '300000', '山东省', '370000', '', '-1');
INSERT INTO `url_re_city` VALUES ('204', '万花筒影院', 'http://www.wht007.com/', '1', '43.252.228.13', '香港', 'HK', '', '', '香港特别行政区', 'HK_01', '', '');
INSERT INTO `url_re_city` VALUES ('205', '土鳖视频', 'http://www.cc82.cc/', '1', '203.78.140.187', '印度', 'IN', '', '', '', '', '', '101');
INSERT INTO `url_re_city` VALUES ('206', '优片网', 'http://www.upian.cc/', '1', '58.211.137.245', '中国', 'CN', '华东', '300000', '江苏省', '320000', '苏州市', '320500');
INSERT INTO `url_re_city` VALUES ('207', '腾讯音乐', 'http://yue.qq.com/', '2', '180.96.86.192', '中国', 'CN', '华东', '300000', '江苏省', '320000', '南京市', '320100');
INSERT INTO `url_re_city` VALUES ('208', '网易云音乐', 'http://music.163.com/', '2', '59.111.160.197', '中国', 'CN', '华南', '800000', '广东省', '440000', '深圳市', '440300');
INSERT INTO `url_re_city` VALUES ('209', '磨坊高品质音乐论坛', 'http://www.moofeel.com/index.php', '2', '210.209.89.234', '香港', 'HK', '', '', '香港特别行政区', 'HK_01', '', '');
INSERT INTO `url_re_city` VALUES ('210', '九酷音乐', 'http://www.9ku.com/', '2', '61.147.210.175', '中国', 'CN', '华东', '300000', '江苏省', '320000', '南通市', '320600');
INSERT INTO `url_re_city` VALUES ('211', '5nd音乐网', 'http://www.5nd.com/', '2', '222.186.17.100', '中国', 'CN', '华东', '300000', '江苏省', '320000', '镇江市', '321100');
INSERT INTO `url_re_city` VALUES ('212', '320高品质MP3音乐', 'http://www.320mp3.com/', '2', '123.125.112.229', '中国', 'CN', '华北', '100000', '北京市', '110000', '北京市', '110100');
INSERT INTO `url_re_city` VALUES ('213', '51APE', 'http://www.51ape.com/', '2', '210.209.89.233', '香港', 'HK', '', '', '香港特别行政区', 'HK_01', '', '');
INSERT INTO `url_re_city` VALUES ('214', '咪咕音乐网', 'http://music.migu.cn/#', '2', '218.200.160.43', '中国', 'CN', '西南', '500000', '四川省', '510000', '', '');
INSERT INTO `url_re_city` VALUES ('215', '音乐巴士', 'http://www.yy8844.cn/', '2', '122.228.204.133', '中国', 'CN', '华东', '300000', '浙江省', '330000', '温州市', '330300');
INSERT INTO `url_re_city` VALUES ('216', '叮当音乐网', 'http://www.mtv123.com/', '2', '122.228.204.212', '中国', 'CN', '华东', '300000', '浙江省', '330000', '温州市', '330300');
INSERT INTO `url_re_city` VALUES ('217', '一听音乐', 'http://www.1ting.com/', '2', '222.186.17.100', '中国', 'CN', '华东', '300000', '江苏省', '320000', '镇江市', '321100');
INSERT INTO `url_re_city` VALUES ('218', '365音乐网', 'http://www.yue365.com/', '2', '222.186.13.53', '中国', 'CN', '华东', '300000', '江苏省', '320000', '镇江市', '321100');
INSERT INTO `url_re_city` VALUES ('219', '好听轻音乐网', 'http://www.htqyy.com/', '2', '115.29.28.246', '中国', 'CN', '华东', '300000', '浙江省', '330000', '杭州市', '330100');
INSERT INTO `url_re_city` VALUES ('220', '百度音乐', 'http://music.baidu.com/', '2', '182.61.35.21', '中国', 'CN', '华南', '800000', '广东省', '440000', '广州市', '440100');
INSERT INTO `url_re_city` VALUES ('221', '金山音乐', 'http://www.duba.com/music_index.html', '2', '218.92.225.200', '中国', 'CN', '华东', '300000', '江苏省', '320000', '盐城市', '320900');
INSERT INTO `url_re_city` VALUES ('222', '搜狗音乐', 'http://mp3.sogou.com/', '2', '106.120.188.46', '中国', 'CN', '华北', '100000', '北京市', '110000', '北京市', '110100');
INSERT INTO `url_re_city` VALUES ('223', '九天音乐', 'http://www.9sky.com/', '2', '114.55.236.110', '中国', 'CN', '华东', '300000', '浙江省', '330000', '杭州市', '330100');
INSERT INTO `url_re_city` VALUES ('224', '56音乐网', 'http://www.23356.com/', '2', '58.211.137.80', '中国', 'CN', '华东', '300000', '江苏省', '320000', '苏州市', '320500');
INSERT INTO `url_re_city` VALUES ('225', '今生缘音乐', 'http://www.666ccc.com/', '2', '104.27.146.128', '美国', 'US', '', '', '', '', '', '');
INSERT INTO `url_re_city` VALUES ('226', '多米音乐', 'http://www.duomi.com/', '2', '59.151.12.60', '中国', 'CN', '华北', '100000', '北京市', '110000', '北京市', '110100');
INSERT INTO `url_re_city` VALUES ('227', 'YYMP3音乐网', 'http://www.yymp3.com/', '2', '204.128.60.111', '美国', 'US', '', '', '', '', '', '');
INSERT INTO `url_re_city` VALUES ('228', '音乐人先锋榜', 'http://music.weibo.com/', '2', '123.126.56.253', '中国', 'CN', '华北', '100000', '北京市', '110000', '北京市', '110100');
INSERT INTO `url_re_city` VALUES ('229', '喜马拉雅FM', 'http://www.ximalaya.com/explore/', '2', '180.153.255.7', '中国', 'CN', '华东', '300000', '上海市', '310000', '上海市', '310100');
INSERT INTO `url_re_city` VALUES ('230', '音悦台', 'http://www.yinyuetai.com/', '2', '221.228.226.18', '中国', 'CN', '华东', '300000', '江苏省', '320000', '无锡市', '320200');
INSERT INTO `url_re_city` VALUES ('231', '豆瓣FM', 'https://douban.fm/', '2', '115.182.201.7', '中国', 'CN', '华北', '100000', '北京市', '110000', '北京市', '110100');
INSERT INTO `url_re_city` VALUES ('232', 'echo回声', 'http://www.app-echo.com/#/', '2', '180.97.219.63', '中国', 'CN', '华东', '300000', '江苏省', '320000', '淮安市', '320800');
INSERT INTO `url_re_city` VALUES ('233', '百度乐播', 'http://lebo.baidu.com/', '2', '180.76.183.17', '中国', 'CN', '华北', '100000', '北京市', '110000', '北京市', '110100');
INSERT INTO `url_re_city` VALUES ('234', '72DJ舞曲网', 'http://www.72dj.com/', '2', '222.186.49.186', '中国', 'CN', '华东', '300000', '江苏省', '320000', '镇江市', '321100');
INSERT INTO `url_re_city` VALUES ('235', '搜刮音乐平台', 'http://www.sogua.com/', '2', '183.60.201.102', '中国', 'CN', '华南', '800000', '广东省', '440000', '佛山市', '440600');
INSERT INTO `url_re_city` VALUES ('236', '好听163音乐网', 'http://www.haoting163.com/', '2', '47.90.10.47', '香港', 'HK', '', '', '香港特别行政区', 'HK_01', '', '');
INSERT INTO `url_re_city` VALUES ('237', '爱给网', 'http://www.2gei.com/music/', '2', '139.129.112.11', '中国', 'CN', '华东', '300000', '山东省', '370000', '青岛市', '370200');
INSERT INTO `url_re_city` VALUES ('238', '我爱音乐网', 'http://www.5iyy.net/', '2', '47.90.10.47', '香港', 'HK', '', '', '香港特别行政区', 'HK_01', '', '');
INSERT INTO `url_re_city` VALUES ('239', '完美汽车音乐', 'http://www.wanmeimv.com/forum.php', '2', '115.231.187.88', '中国', 'CN', '华东', '300000', '浙江省', '330000', '宁波市', '330200');
INSERT INTO `url_re_city` VALUES ('240', '极品社区', 'http://bbs.zzse.net/', '2', '61.160.247.153', '中国', 'CN', '华东', '300000', '江苏省', '320000', '常州市', '320400');
INSERT INTO `url_re_city` VALUES ('241', '汽车音乐网', 'http://www.carsmp3.com/', '2', '209.141.62.25', '美国', 'US', '', '', '', '', '', '');
INSERT INTO `url_re_city` VALUES ('242', '百度音乐随心听', 'http://fm.baidu.com/', '2', '180.76.183.17', '中国', 'CN', '华北', '100000', '北京市', '110000', '北京市', '110100');
INSERT INTO `url_re_city` VALUES ('243', '一听音乐', 'http://www.1ting.com/fo/    ', '2', '61.147.210.175', '中国', 'CN', '华东', '300000', '江苏省', '320000', '南通市', '320600');
INSERT INTO `url_re_city` VALUES ('244', 'DN在线听歌', 'http://music.dn1234.com/    ', '2', '58.216.107.101', '中国', 'CN', '华东', '300000', '江苏省', '320000', '常州市', '320400');
INSERT INTO `url_re_city` VALUES ('245', '芒仔音乐铺', 'http://www.yinyuepu.com/    ', '2', '122.228.248.219', '中国', 'CN', '华东', '300000', '浙江省', '330000', '温州市', '330300');
INSERT INTO `url_re_city` VALUES ('246', '听蛙音乐网', 'http://www.itingwa.com/', '2', '125.65.113.223', '中国', 'CN', '西南', '500000', '四川省', '510000', '绵阳市', '510700');
INSERT INTO `url_re_city` VALUES ('247', '佛教在线', 'http://music.fjnet.com/', '2', '115.159.71.66', '中国', 'CN', '华东', '300000', '上海市', '310000', '上海市', '310100');
INSERT INTO `url_re_city` VALUES ('248', '库客音乐', 'http://www.kuke.com/', '2', '60.205.130.221', '中国', 'CN', '华北', '100000', '北京市', '110000', '北京市', '110100');
INSERT INTO `url_re_city` VALUES ('249', '前卫音乐', 'http://www.dj520.com/', '2', '120.76.194.25', '中国', 'CN', '华南', '800000', '广东省', '440000', '深圳市', '440300');
INSERT INTO `url_re_city` VALUES ('250', '中国古曲网', 'http://www.guqu.net/', '2', '125.91.8.163', '中国', 'CN', '华南', '800000', '广东省', '440000', '汕头市', '440500');
INSERT INTO `url_re_city` VALUES ('251', 'DJ音乐厅', 'http://www.hcdj.com/', '2', '122.228.70.59', '中国', 'CN', '华东', '300000', '浙江省', '330000', '温州市', '330300');
INSERT INTO `url_re_city` VALUES ('252', '慢品', 'http://manpin.net/', '2', '47.90.78.27', '香港', 'HK', '', '', '香港特别行政区', 'HK_01', '', '');
INSERT INTO `url_re_city` VALUES ('253', '阿小猫', 'http://axiaomao.com/', '2', '115.29.224.67', '中国', 'CN', '华东', '300000', '浙江省', '330000', '杭州市', '330100');
INSERT INTO `url_re_city` VALUES ('254', '匪徒在线', 'http://www.94007.com/', '2', '118.144.82.174', '中国', 'CN', '华北', '100000', '北京市', '110000', '北京市', '110100');
INSERT INTO `url_re_city` VALUES ('255', 'DJ45', 'http://www.dj45.com/', '2', '222.186.30.192', '中国', 'CN', '华东', '300000', '江苏省', '320000', '镇江市', '321100');
INSERT INTO `url_re_city` VALUES ('256', '520666音乐网', 'http://www.520666.com/', '2', '47.89.26.149', '香港', 'HK', '', '', '香港特别行政区', 'HK_01', '', '');
INSERT INTO `url_re_city` VALUES ('257', '音灵dj网', 'http://www.djf1.com/', '2', '43.225.59.104', '香港', 'HK', '', '', '香港特别行政区', 'HK_01', '', '');
INSERT INTO `url_re_city` VALUES ('258', '宝贝DJ网', 'http://www.bbdj.com/', '2', '58.218.215.170', '中国', 'CN', '华东', '300000', '江苏省', '320000', '徐州市', '320300');
INSERT INTO `url_re_city` VALUES ('259', 'MOOV', 'https://moov.hk/', '2', '219.76.111.41', '香港', 'HK', '', '', '香港特别行政区', 'HK_01', '', '');
INSERT INTO `url_re_city` VALUES ('260', '可可西广场舞', 'http://www.cococ.com/', '2', '47.90.80.184', '香港', 'HK', '', '', '香港特别行政区', 'HK_01', '', '');
INSERT INTO `url_re_city` VALUES ('261', '慢摇Dj吧', 'http://www.mydjb.com/', '2', '58.218.215.163', '中国', 'CN', '华东', '300000', '江苏省', '320000', '徐州市', '320300');
INSERT INTO `url_re_city` VALUES ('262', '旗舰音乐网', 'https://www.xx186.com/', '2', '180.97.168.220', '中国', 'CN', '华东', '300000', '江苏省', '320000', '苏州市', '320500');
INSERT INTO `url_re_city` VALUES ('263', '水晶DJ网', 'http://www.dj97.com/', '2', '122.228.248.203', '中国', 'CN', '华东', '300000', '浙江省', '330000', '温州市', '330300');
INSERT INTO `url_re_city` VALUES ('264', '捌零音乐论坛', 'http://www.pt80.net/', '2', '115.238.138.185', '中国', 'CN', '华东', '300000', '浙江省', '330000', '宁波市', '330200');
INSERT INTO `url_re_city` VALUES ('265', '噢音乐', 'http://www.oyinyue.com/', '2', '59.56.19.184', '中国', 'CN', '华东', '300000', '福建省', '350000', '福州市', '350100');
INSERT INTO `url_re_city` VALUES ('266', '雪域藏族音乐网', 'http://www.snowmusic.com.cn/', '2', '118.244.234.225', '中国', 'CN', '华北', '100000', '北京市', '110000', '北京市', '110100');
INSERT INTO `url_re_city` VALUES ('267', '深港dj俱乐部', 'http://www.ik123.com/', '2', '180.97.66.35', '中国', 'CN', '华东', '300000', '江苏省', '320000', '苏州市', '320500');
INSERT INTO `url_re_city` VALUES ('268', '沃音乐', 'http://www.10155.com/#main/index.htm', '2', '58.254.132.4', '中国', 'CN', '华南', '800000', '广东省', '440000', '深圳市', '440300');
INSERT INTO `url_re_city` VALUES ('269', '高品质dj音乐盒', 'http://www.3378.com.cn/', '2', '115.238.255.188', '中国', 'CN', '华东', '300000', '浙江省', '330000', '丽水市', '331100');
INSERT INTO `url_re_city` VALUES ('270', '伤感音乐网', 'http://www.yy521.com/', '2', '117.27.245.96', '中国', 'CN', '华东', '300000', '福建省', '350000', '福州市', '350100');
INSERT INTO `url_re_city` VALUES ('271', '中国原创音乐基地 5SING', 'http://5sing.kugou.com/yc/index.html', '2', '115.231.37.27', '中国', 'CN', '华东', '300000', '浙江省', '330000', '宁波市', '330200');
INSERT INTO `url_re_city` VALUES ('272', '清风DJ音乐网', 'http://www.vvvdj.com/', '2', '180.97.168.180', '中国', 'CN', '华东', '300000', '江苏省', '320000', '苏州市', '320500');
INSERT INTO `url_re_city` VALUES ('273', '音乐地带-影音帝国区- 华声论坛', 'http://bbs.voc.com.cn/forum-77-1.html', '2', '220.168.248.214', '中国', 'CN', '华中', '400000', '湖南省', '430000', '长沙市', '430100');
INSERT INTO `url_re_city` VALUES ('274', '顶尖dj舞曲网', 'http://www.dj89.com/', '2', '60.169.78.231', '中国', 'CN', '华东', '300000', '安徽省', '340000', '芜湖市', '340200');
INSERT INTO `url_re_city` VALUES ('275', '疯吧', 'http://www.djf8.com/', '2', '119.254.167.112', '中国', 'CN', '华北', '100000', '北京市', '110000', '北京市', '110100');
INSERT INTO `url_re_city` VALUES ('276', 'MC喊麦', 'http://www.dj116.com/', '2', '43.240.14.209', '香港', 'HK', '', '', '香港特别行政区', 'HK_01', '', '');
INSERT INTO `url_re_city` VALUES ('277', '深度无损音乐论坛', 'http://www.deepms.net/', '2', '113.10.136.198', '香港', 'HK', '', '', '香港特别行政区', 'HK_01', '', '');
INSERT INTO `url_re_city` VALUES ('278', '三衢客栈', 'http://www.sqkz.com/k80.html', '2', '115.236.4.8', '中国', 'CN', '华东', '300000', '浙江省', '330000', '杭州市', '330100');
INSERT INTO `url_re_city` VALUES ('279', '串串烧音乐论坛', 'www.ccshao.com/index.php?gid=16', '2', '210.209.70.181', '香港', 'HK', '', '', '香港特别行政区', 'HK_01', '', '');
INSERT INTO `url_re_city` VALUES ('280', '杂碎音乐论坛', 'http://www.zasv.net/', '2', '172.87.27.47', '美国', 'US', '', '', '', '', '', '');
INSERT INTO `url_re_city` VALUES ('281', '风云音乐谷', 'http://www.hcyy.org/', '2', '43.227.98.233', '中国', 'CN', '华东', '300000', '山东省', '370000', '潍坊市', '370700');
INSERT INTO `url_re_city` VALUES ('282', '百事高音乐论坛', 'http://bbs.besgold.com/', '2', '59.36.101.196', '中国', 'CN', '华南', '800000', '广东省', '440000', '东莞市', '441900');
INSERT INTO `url_re_city` VALUES ('283', 'dj嗨嗨网', 'http://www.djkk.com/', '2', '202.75.220.31', '中国', 'CN', '华东', '300000', '浙江省', '330000', '杭州市', '330100');
INSERT INTO `url_re_city` VALUES ('284', '中国dj爱好者', 'http://www.djcc.cc/', '2', '220.164.144.201', '中国', 'CN', '西南', '500000', '云南省', '530000', '普洱市', '530800');
INSERT INTO `url_re_city` VALUES ('285', '海边dj舞曲网', 'http://www.dj806.com/', '2', '211.149.211.228', '中国', 'CN', '西南', '500000', '四川省', '510000', '成都市', '510100');
INSERT INTO `url_re_city` VALUES ('286', 'DJWMA舞曲网', 'http://www.djwma.com/', '2', '47.89.0.246', '香港', 'HK', '', '', '香港特别行政区', 'HK_01', '', '');
INSERT INTO `url_re_city` VALUES ('287', '5.1真音乐', 'http://www.5dian1.net/', '2', '211.149.233.201', '中国', 'CN', '西南', '500000', '四川省', '510000', '成都市', '510100');
INSERT INTO `url_re_city` VALUES ('288', '听歌123音乐网', 'http://www.tingge123.com/', '2', '180.97.168.197', '中国', 'CN', '华东', '300000', '江苏省', '320000', '苏州市', '320500');
INSERT INTO `url_re_city` VALUES ('289', '手机MP3', 'http://www.sjmp3.com/', '2', '47.90.18.124', '香港', 'HK', '', '', '香港特别行政区', 'HK_01', '', '');
INSERT INTO `url_re_city` VALUES ('290', '军歌网', 'http://www.jungewang.com/', '2', '121.201.5.160', '中国', 'CN', '华南', '800000', '广东省', '440000', '中山市', '442000');
INSERT INTO `url_re_city` VALUES ('291', 'MixDJ丨全球舞曲同步网', 'http://www.mixdj.cn/', '2', '58.211.137.240', '中国', 'CN', '华东', '300000', '江苏省', '320000', '苏州市', '320500');
INSERT INTO `url_re_city` VALUES ('292', '酷听音乐网', 'http://www.kting.org.cn/', '2', '47.90.10.47', '香港', 'HK', '', '', '香港特别行政区', 'HK_01', '', '');
INSERT INTO `url_re_city` VALUES ('293', 'DJ聚合分享网站 ', 'http://www.36dj.com/', '2', '61.147.118.206', '中国', 'CN', '华东', '300000', '江苏省', '320000', '扬州市', '321000');
INSERT INTO `url_re_city` VALUES ('294', '听三零音乐网', 'http://www.ting30.com/gequ/show1.html', '2', '106.122.250.46', '中国', 'CN', '华东', '300000', '福建省', '350000', '福州市', '350100');
INSERT INTO `url_re_city` VALUES ('295', '串烧歌曲网', 'http://www.dj810.com/ranks.html', '2', '221.229.173.107', '中国', 'CN', '华东', '300000', '江苏省', '320000', '徐州市', '320300');
INSERT INTO `url_re_city` VALUES ('296', '想听音乐网', 'http://www.yy3t.com/', '2', '47.90.10.47', '香港', 'HK', '', '', '香港特别行政区', 'HK_01', '', '');
INSERT INTO `url_re_city` VALUES ('297', '就要听音乐网', 'http://91listen.com/', '2', '139.129.227.101', '中国', 'CN', '华东', '300000', '山东省', '370000', '青岛市', '370200');
INSERT INTO `url_re_city` VALUES ('298', '基督教歌曲网', 'http://www.jdjgq.com/hotmusic.htm', '2', '124.228.91.141', '中国', 'CN', '华中', '400000', '湖南省', '430000', '衡阳市', '430400');
INSERT INTO `url_re_city` VALUES ('299', '要听舞曲网', 'http://www.111ttt.com/top/sWeekday.htm', '2', '122.228.70.15', '中国', 'CN', '华东', '300000', '浙江省', '330000', '温州市', '330300');
INSERT INTO `url_re_city` VALUES ('300', '风云音乐网', 'http://www.fengyunmusic.com/', '2', '47.90.10.47', '香港', 'HK', '', '', '香港特别行政区', 'HK_01', '', '');
INSERT INTO `url_re_city` VALUES ('301', '阿忠舞曲网', 'http://www.djazhong.com/index.php/ranks/fav.html', '2', '60.190.223.11', '中国', 'CN', '华东', '300000', '浙江省', '330000', '绍兴市', '330600');
INSERT INTO `url_re_city` VALUES ('302', '荔枝fm', 'http://www.lizhi.fm/', '2', '49.79.233.116', '中国', 'CN', '华东', '300000', '江苏省', '320000', '南京市', '320100');
INSERT INTO `url_re_city` VALUES ('303', 'QQ190音乐网', 'http://www.y2002.com/', '2', '119.147.139.113', '中国', 'CN', '华南', '800000', '广东省', '440000', '佛山市', '440600');
INSERT INTO `url_re_city` VALUES ('304', '中国传媒配音网', 'http://www.cmpy.cn/', '2', '61.147.98.146', '中国', 'CN', '华东', '300000', '江苏省', '320000', '扬州市', '321000');
INSERT INTO `url_re_city` VALUES ('305', '新地DJ音乐网', 'http://www.5ydj.com/', '2', '60.205.151.170', '中国', 'CN', '华北', '100000', '北京市', '110000', '北京市', '110100');
INSERT INTO `url_re_city` VALUES ('306', '99伴奏网', 'http://www.wo99.net/', '2', '222.186.21.29', '中国', 'CN', '华东', '300000', '江苏省', '320000', '镇江市', '321100');
INSERT INTO `url_re_city` VALUES ('307', '极点舞曲网', 'http://www.dj3721.net/', '2', '125.89.70.14', '中国', 'CN', '华南', '800000', '广东省', '440000', '珠海市', '440400');
INSERT INTO `url_re_city` VALUES ('308', '班得瑞全球中文网', 'https://www.bandari.net/', '2', '211.159.153.113', '中国', 'CN', '华东', '300000', '上海市', '310000', '上海市', '310100');
INSERT INTO `url_re_city` VALUES ('309', 'DJ先锋网', 'http://www.dj-dj.net/', '2', '220.164.144.201', '中国', 'CN', '西南', '500000', '云南省', '530000', '普洱市', '530800');
INSERT INTO `url_re_city` VALUES ('310', '爱音乐', 'http://www.imusic.cn/', '2', '14.146.228.10', '中国', 'CN', '华南', '800000', '广东省', '440000', '广州市', '440100');
INSERT INTO `url_re_city` VALUES ('311', '爱听交谊舞曲网,', 'http://www.2ting.net/', '2', '222.186.49.186', '中国', 'CN', '华东', '300000', '江苏省', '320000', '镇江市', '321100');
INSERT INTO `url_re_city` VALUES ('312', 'A8音乐网', 'http://www.a8.com/', '2', '106.122.250.46', '中国', 'CN', '华东', '300000', '福建省', '350000', '福州市', '350100');
INSERT INTO `url_re_city` VALUES ('313', '搜狐音乐', 'http://music.yule.sohu.com/', '2', '101.227.172.11', '中国', 'CN', '华东', '300000', '上海市', '310000', '上海市', '310100');
INSERT INTO `url_re_city` VALUES ('314', '新浪音乐', 'http://yue.sina.com.cn/', '2', '202.102.75.147', '中国', 'CN', '华东', '300000', '江苏省', '320000', '南京市', '320100');
INSERT INTO `url_re_city` VALUES ('315', '中国音乐网', 'http://www.yyjy.com/index.html', '2', '182.140.227.157', '中国', 'CN', '西南', '500000', '四川省', '510000', '成都市', '510100');
INSERT INTO `url_re_city` VALUES ('316', '炫音音乐论坛', 'http://bbs.musicool.cn/', '2', '122.224.5.239', '中国', 'CN', '华东', '300000', '浙江省', '330000', '绍兴市', '330600');
INSERT INTO `url_re_city` VALUES ('317', '新芭网', 'http://www.sin80.com/', '2', '175.102.3.129', '中国', 'CN', '华东', '300000', '上海市', '310000', '上海市', '310100');
INSERT INTO `url_re_city` VALUES ('318', 'dj耶耶网', 'http://www.djye.com/', '2', '222.186.49.200', '中国', 'CN', '华东', '300000', '江苏省', '320000', '镇江市', '321100');
INSERT INTO `url_re_city` VALUES ('319', '古典音乐频道', 'http://www.ncpa-classic.com/', '2', '58.221.78.105', '中国', 'CN', '华东', '300000', '江苏省', '320000', '南通市', '320600');
INSERT INTO `url_re_city` VALUES ('320', '高采样数字音乐厅', 'http://hd-hall.com/', '2', '115.28.237.117', '中国', 'CN', '华东', '300000', '山东省', '370000', '青岛市', '370200');
INSERT INTO `url_re_city` VALUES ('321', '基点局俱乐部', 'http://club.mydcentre.com/', '2', '27.24.190.218', '中国', 'CN', '华中', '400000', '湖北省', '420000', '咸宁市', '421200');
INSERT INTO `url_re_city` VALUES ('322', '电驴大全', 'http://www.verycd.com/', '2', '182.92.25.21', '中国', 'CN', '华北', '100000', '北京市', '110000', '北京市', '110100');
INSERT INTO `url_re_city` VALUES ('323', '有伴网', 'http://www.youban.com/', '2', '183.62.113.115', '中国', 'CN', '华南', '800000', '广东省', '440000', '深圳市', '440300');
INSERT INTO `url_re_city` VALUES ('324', '新芭网', 'http://www.sin80.com/', '2', '175.102.3.129', '中国', 'CN', '华东', '300000', '上海市', '310000', '上海市', '310100');
INSERT INTO `url_re_city` VALUES ('325', '京东音乐网', 'http://music.jd.com/', '2', '106.39.167.232', '中国', 'CN', '华北', '100000', '北京市', '110000', '北京市', '110100');
INSERT INTO `url_re_city` VALUES ('326', '乐吧谷', 'http://www.yuebagu.com/yuequ/gudianqu/', '2', '58.211.137.239', '中国', 'CN', '华东', '300000', '江苏省', '320000', '苏州市', '320500');
INSERT INTO `url_re_city` VALUES ('327', '摇头网', 'http://www.yaotou.com/', '2', '222.186.49.195', '中国', 'CN', '华东', '300000', '江苏省', '320000', '镇江市', '321100');
INSERT INTO `url_re_city` VALUES ('328', '想听音乐网', 'http://www.yy3t.com/', '2', '47.90.10.47', '香港', 'HK', '', '', '香港特别行政区', 'HK_01', '', '');
INSERT INTO `url_re_city` VALUES ('329', '酷听音乐网', 'http://www.kting.org.cn/', '2', '47.90.10.47', '香港', 'HK', '', '', '香港特别行政区', 'HK_01', '', '');
INSERT INTO `url_re_city` VALUES ('330', '原创EDM', 'http://www.y2002.com/', '2', '119.147.139.113', '中国', 'CN', '华南', '800000', '广东省', '440000', '佛山市', '440600');
INSERT INTO `url_re_city` VALUES ('331', '26音乐网', 'http://www.26yy.com/', '2', '218.247.87.158', '中国', 'CN', '西南', '500000', '四川省', '510000', '成都市', '510100');
INSERT INTO `url_re_city` VALUES ('332', '九酷电台', 'http://www.9ku.com/fm/', '2', '222.186.17.100', '中国', 'CN', '华东', '300000', '江苏省', '320000', '镇江市', '321100');
INSERT INTO `url_re_city` VALUES ('333', '嗨瑶音乐网', 'http://www.92kk.com/', '2', '122.228.248.200', '中国', 'CN', '华东', '300000', '浙江省', '330000', '温州市', '330300');
INSERT INTO `url_re_city` VALUES ('334', '言情小说吧', 'http://www.xs8.cn/', '3', '222.186.20.123', '中国', 'CN', '华东', '300000', '江苏省', '320000', '镇江市', '321100');
INSERT INTO `url_re_city` VALUES ('335', '小说大全', 'http://book.km.com/', '3', '124.243.254.3', '中国', 'CN', '华北', '100000', '北京市', '110000', '北京市', '110100');
INSERT INTO `url_re_city` VALUES ('336', '纵横中文网', 'http://www.zongheng.com/', '3', '180.97.66.35', '中国', 'CN', '华东', '300000', '江苏省', '320000', '苏州市', '320500');
INSERT INTO `url_re_city` VALUES ('337', '搜狗小说', 'http://xiaoshuo.sogou.com/', '3', '106.120.188.46', '中国', 'CN', '华北', '100000', '北京市', '110000', '北京市', '110100');
INSERT INTO `url_re_city` VALUES ('338', '红袖添香', 'http://www.hongxiu.com/', '3', '106.122.250.43', '中国', 'CN', '华东', '300000', '福建省', '350000', '福州市', '350100');
INSERT INTO `url_re_city` VALUES ('339', '17K小说网', 'http://www.17k.com/', '3', '58.218.215.165', '中国', 'CN', '华东', '300000', '江苏省', '320000', '徐州市', '320300');
INSERT INTO `url_re_city` VALUES ('340', '小说阅读网', 'https://www.readnovel.com/', '3', '101.226.212.177', '中国', 'CN', '华东', '300000', '上海市', '310000', '上海市', '310100');
INSERT INTO `url_re_city` VALUES ('341', '逐浪', 'http://www.zhulang.com/', '3', '59.63.234.28', '中国', 'CN', '华东', '300000', '江西省', '360000', '南昌市', '360100');
INSERT INTO `url_re_city` VALUES ('342', '潇湘书院', 'http://www.xxsy.net/', '3', '58.216.109.187', '中国', 'CN', '华东', '300000', '江苏省', '320000', '常州市', '320400');
INSERT INTO `url_re_city` VALUES ('343', '起点小说网', 'http://www.qidian.com/', '3', '221.228.67.145', '中国', 'CN', '华东', '300000', '江苏省', '320000', '无锡市', '320200');
INSERT INTO `url_re_city` VALUES ('344', '云起书院', 'http://yunqi.qq.com/', '3', '101.226.103.126', '中国', 'CN', '华东', '300000', '上海市', '310000', '上海市', '310100');
INSERT INTO `url_re_city` VALUES ('345', '凤鸣轩小说网', 'http://www.fmx.cn/', '3', '60.205.56.2', '中国', 'CN', '华北', '100000', '北京市', '110000', '北京市', '110100');
INSERT INTO `url_re_city` VALUES ('346', '红薯小说阅读网', 'http://www.hongshu.com/', '3', '117.21.219.92', '中国', 'CN', '华东', '300000', '江西省', '360000', '九江市', '360400');
INSERT INTO `url_re_city` VALUES ('347', '书海小说网', 'http://www.shuhai.com/', '3', '58.216.17.107', '中国', 'CN', '华东', '300000', '江苏省', '320000', '常州市', '320400');
INSERT INTO `url_re_city` VALUES ('348', '磨铁中文网', 'http://www.motie.com/', '3', '42.96.249.20', '中国', 'CN', '华东', '300000', '山东省', '370000', '青岛市', '370200');
INSERT INTO `url_re_city` VALUES ('349', '万松浦书院', 'http://www.wansongpu.com/', '3', '60.212.44.36', '中国', 'CN', '华东', '300000', '山东省', '370000', '烟台市', '370600');
INSERT INTO `url_re_city` VALUES ('350', '文中书城小说网', 'http://www.yuncheng.com/', '3', '61.151.186.106', '中国', 'CN', '华东', '300000', '上海市', '310000', '上海市', '310100');
INSERT INTO `url_re_city` VALUES ('351', 'hao123小说网', 'http://book.hao123.com/', '3', '180.97.66.48', '中国', 'CN', '华东', '300000', '江苏省', '320000', '苏州市', '320500');
INSERT INTO `url_re_city` VALUES ('352', '新小说吧', 'http://www.xxs8.com/', '3', '182.18.61.69', '中国', 'CN', '华北', '100000', '北京市', '110000', '北京市', '110100');
INSERT INTO `url_re_city` VALUES ('353', '看书网', 'http://about.kanshu.com/', '3', '124.202.154.70', '中国', 'CN', '华北', '100000', '北京市', '110000', '北京市', '110100');
INSERT INTO `url_re_city` VALUES ('354', '飞卢小说网', 'http://b.faloo.com/', '3', '115.231.29.34', '中国', 'CN', '华东', '300000', '浙江省', '330000', '湖州市', '330500');
INSERT INTO `url_re_city` VALUES ('355', '360小说网', 'http://www.jingyu.com/', '3', '116.62.84.160', '中国', 'CN', '华东', '300000', '浙江省', '330000', '杭州市', '330100');
INSERT INTO `url_re_city` VALUES ('356', '掌握阅读小说', 'http://yc.ireader.com.cn/', '3', '113.31.87.8', '中国', 'CN', '华北', '100000', '北京市', '110000', '北京市', '110100');
INSERT INTO `url_re_city` VALUES ('357', '国风中文网', 'http://guofeng.yuedu.163.com/', '3', '223.252.199.7', '中国', 'CN', '华东', '300000', '浙江省', '330000', '杭州市', '330100');
INSERT INTO `url_re_city` VALUES ('358', '无限小说网', 'http://www.55x.cn/', '3', '59.53.67.168', '中国', 'CN', '华东', '300000', '江西省', '360000', '南昌市', '360100');
INSERT INTO `url_re_city` VALUES ('359', '逸云书院', 'http://yynovel.motie.com/', '3', '139.129.199.219', '中国', 'CN', '华东', '300000', '山东省', '370000', '青岛市', '370200');
INSERT INTO `url_re_city` VALUES ('360', '孔夫子读书网', 'http://book.kongfz.com/', '3', '180.97.162.23', '中国', 'CN', '华东', '300000', '江苏省', '320000', '苏州市', '320500');
INSERT INTO `url_re_city` VALUES ('361', '暖暖书城', 'http://www.nnsc6.com/', '3', '103.235.244.165', '中国', 'CN', '华北', '100000', '北京市', '110000', '北京市', '110100');
INSERT INTO `url_re_city` VALUES ('362', '粉色书城', 'http://www.fensebook.com/', '3', '180.97.235.68', '中国', 'CN', '华东', '300000', '江苏省', '320000', '苏州市', '320500');
INSERT INTO `url_re_city` VALUES ('363', '凌云文学网', 'http://www.lingyun5.com/', '3', '103.235.244.161', '中国', 'CN', '华北', '100000', '北京市', '110000', '北京市', '110100');
INSERT INTO `url_re_city` VALUES ('364', '3G书城', 'http://www.3gsc.com.cn/', '3', '183.61.112.43', '中国', 'CN', '华南', '800000', '广东省', '440000', '广州市', '440100');
INSERT INTO `url_re_city` VALUES ('365', '优恋小说网', 'http://www.1999youlian.com/', '3', '222.186.171.138', '中国', 'CN', '华东', '300000', '江苏省', '320000', '镇江市', '321100');
INSERT INTO `url_re_city` VALUES ('366', '暗夜文学网', 'http://www.anyew.com/', '3', '101.201.63.140', '中国', 'CN', '华北', '100000', '北京市', '110000', '北京市', '110100');
INSERT INTO `url_re_city` VALUES ('367', '鬼姐姐小说网', 'http://www.guijj.com/', '3', '121.40.164.23', '中国', 'CN', '华东', '300000', '浙江省', '330000', '杭州市', '330100');
INSERT INTO `url_re_city` VALUES ('368', '甜悦读网', 'http://www.sweetread.net/', '3', '123.57.42.242', '中国', 'CN', '华北', '100000', '北京市', '110000', '北京市', '110100');
INSERT INTO `url_re_city` VALUES ('369', '长江中文网', 'http://www.cjzww.com/', '3', '124.202.158.10', '中国', 'CN', '华北', '100000', '北京市', '110000', '北京市', '110100');
INSERT INTO `url_re_city` VALUES ('370', '滕痕书院', 'http://www.tenghen.com/', '3', '114.112.96.71', '中国', 'CN', '华北', '100000', '北京市', '110000', '北京市', '110100');
INSERT INTO `url_re_city` VALUES ('371', '封神阅读网', 'http://www.fsyuedu.com/', '3', '123.57.221.91', '中国', 'CN', '华北', '100000', '北京市', '110000', '北京市', '110100');
INSERT INTO `url_re_city` VALUES ('372', '岳麓小说网', 'http://www.yueloo.com/', '3', '115.29.40.199', '中国', 'CN', '华东', '300000', '山东省', '370000', '青岛市', '370200');
INSERT INTO `url_re_city` VALUES ('373', '朵米阅读网', 'http://www.dmread.com/', '3', '101.200.141.41', '中国', 'CN', '华北', '100000', '北京市', '110000', '北京市', '110100');
INSERT INTO `url_re_city` VALUES ('374', '云文学网', 'http://www.yunwenxue.com/', '3', '210.14.73.194', '中国', 'CN', '华东', '300000', '上海市', '310000', '上海市', '310100');
INSERT INTO `url_re_city` VALUES ('375', '九库文学网', 'http://www.9kus.com/', '3', '121.201.20.115', '中国', 'CN', '华南', '800000', '广东省', '440000', '中山市', '442000');
INSERT INTO `url_re_city` VALUES ('376', '我爱小说网', 'http://www.5ixsw.com/', '3', '115.231.105.72', '中国', 'CN', '华东', '300000', '浙江省', '330000', '杭州市', '330100');
INSERT INTO `url_re_city` VALUES ('377', '传奇中文网', 'http://www.cqzww.com/', '3', '139.129.97.15', '中国', 'CN', '华东', '300000', '山东省', '370000', '青岛市', '370200');
INSERT INTO `url_re_city` VALUES ('378', '北雁堂中文网', 'http://www.ebtang.com/', '3', '112.126.73.137', '中国', 'CN', '华北', '100000', '北京市', '110000', '北京市', '110100');
INSERT INTO `url_re_city` VALUES ('379', '浩阅读', 'http://www.haoread.com/', '3', '123.57.44.159', '中国', 'CN', '华北', '100000', '北京市', '110000', '北京市', '110100');
INSERT INTO `url_re_city` VALUES ('380', '一千零一页', 'http://www.1001p.com/', '3', '221.122.67.136', '中国', 'CN', '华北', '100000', '北京市', '110000', '北京市', '110100');
INSERT INTO `url_re_city` VALUES ('381', '凤凰书城', 'http://yc.ifeng.com/', '3', '58.222.42.58', '中国', 'CN', '华东', '300000', '江苏省', '320000', '泰州市', '321200');
INSERT INTO `url_re_city` VALUES ('382', '恒言中文网', 'http://www.hengyan.com/', '3', '122.224.32.166', '中国', 'CN', '华东', '300000', '浙江省', '330000', '绍兴市', '330600');
INSERT INTO `url_re_city` VALUES ('383', '天下书盟网', 'http://www.fbook.net/', '3', '101.201.78.206', '中国', 'CN', '华北', '100000', '北京市', '110000', '北京市', '110100');
INSERT INTO `url_re_city` VALUES ('384', '花雨小说网', 'http://www.inbook.net/', '3', '121.9.242.86', '中国', 'CN', '华南', '800000', '广东省', '440000', '佛山市', '440600');
INSERT INTO `url_re_city` VALUES ('385', '半壁江阅读网', 'http://www.banbijiang.com/', '3', '114.141.171.229', '中国', 'CN', '华东', '300000', '上海市', '310000', '上海市', '310100');
INSERT INTO `url_re_city` VALUES ('386', '栀子花阅读', 'http://www.zhizihuan.com/', '3', '43.240.244.27', '中国', 'CN', '华北', '100000', '北京市', '110000', '北京市', '110100');
INSERT INTO `url_re_city` VALUES ('387', '阅书中文网', 'http://www.yuebook.net/', '3', '123.56.192.67', '中国', 'CN', '华北', '100000', '北京市', '110000', '北京市', '110100');
INSERT INTO `url_re_city` VALUES ('388', '阅读坊', 'http://www.yuedufang.com/', '3', '101.200.179.230', '中国', 'CN', '华北', '100000', '北京市', '110000', '北京市', '110100');
INSERT INTO `url_re_city` VALUES ('389', '圣诞文学网', 'http://www.shengdan.com/', '3', '222.73.241.170', '中国', 'CN', '华东', '300000', '上海市', '310000', '上海市', '310100');
INSERT INTO `url_re_city` VALUES ('390', '绝版中文网', 'http://www.jbzwread.com/', '3', '120.24.16.114', '中国', 'CN', '华南', '800000', '广东省', '440000', '深圳市', '440300');
INSERT INTO `url_re_city` VALUES ('391', '博阅中文网', 'http://www.lboyue.com/', '3', '112.124.59.159', '中国', 'CN', '华东', '300000', '浙江省', '330000', '杭州市', '330100');
INSERT INTO `url_re_city` VALUES ('392', '阅庭书院', 'http://www.ytread.com/', '3', '119.23.145.92', '中国', 'CN', '华南', '800000', '广东省', '440000', '深圳市', '440300');
INSERT INTO `url_re_city` VALUES ('393', '爱奇艺文学网', 'http://wenxue.iqiyi.com/', '3', '58.220.49.144', '中国', 'CN', '华东', '300000', '江苏省', '320000', '扬州市', '321000');
INSERT INTO `url_re_city` VALUES ('394', '听书网小说', 'http://www.kting.cn/', '3', '180.97.235.68', '中国', 'CN', '华东', '300000', '江苏省', '320000', '苏州市', '320500');
INSERT INTO `url_re_city` VALUES ('395', '落尘小说网', 'http://www.luochen.com/', '3', '120.55.194.88', '中国', 'CN', '华东', '300000', '浙江省', '330000', '杭州市', '330100');
INSERT INTO `url_re_city` VALUES ('396', '雨枫轩', 'http://www.rain8.com/', '3', '180.97.221.94', '中国', 'CN', '华东', '300000', '江苏省', '320000', '淮安市', '320800');
INSERT INTO `url_re_city` VALUES ('397', '蜜阅书苑', 'http://www.mixs.cn/', '3', '121.40.239.57', '中国', 'CN', '华东', '300000', '浙江省', '330000', '杭州市', '330100');
INSERT INTO `url_re_city` VALUES ('398', '懒猫阅读', 'http://www.lmyd5.com/', '3', '103.235.244.161', '中国', 'CN', '华北', '100000', '北京市', '110000', '北京市', '110100');
INSERT INTO `url_re_city` VALUES ('399', '草莓书城', 'http://www.caomeibook.com/', '3', '103.235.244.161', '中国', 'CN', '华北', '100000', '北京市', '110000', '北京市', '110100');
INSERT INTO `url_re_city` VALUES ('400', '梦想家书城', 'http://www.dreamersall.com/', '3', '101.37.43.206', '中国', 'CN', '华东', '300000', '浙江省', '330000', '杭州市', '330100');
INSERT INTO `url_re_city` VALUES ('401', '阿尔法书城', 'http://www.alphafun.com/', '3', '61.130.247.173', '中国', 'CN', '华东', '300000', '浙江省', '330000', '湖州市', '330500');
INSERT INTO `url_re_city` VALUES ('402', '品书文学网', 'http://www.pinshu.com/', '3', '101.201.116.161', '中国', 'CN', '华北', '100000', '北京市', '110000', '北京市', '110100');
INSERT INTO `url_re_city` VALUES ('403', '中文在线', 'http://www1.chineseall.com/', '3', '125.39.193.226', '中国', 'CN', '华北', '100000', '天津市', '120000', '天津市', '120100');
INSERT INTO `url_re_city` VALUES ('404', '偶家中文网', 'http://www.ouj.com/', '3', '221.228.79.225', '中国', 'CN', '华东', '300000', '江苏省', '320000', '无锡市', '320200');
INSERT INTO `url_re_city` VALUES ('405', '时阅文学', 'http://www.timeread.com/', '3', '43.240.244.19', '中国', 'CN', '华北', '100000', '北京市', '110000', '北京市', '110100');
INSERT INTO `url_re_city` VALUES ('406', '花溪小说网', 'http://www.huaxi.net/', '3', '47.93.158.209', '中国', 'CN', '华北', '100000', '北京市', '110000', '北京市', '110100');
INSERT INTO `url_re_city` VALUES ('407', '安卓读书网', 'http://www.andreader.com/', '3', '58.222.42.58', '中国', 'CN', '华东', '300000', '江苏省', '320000', '泰州市', '321200');
INSERT INTO `url_re_city` VALUES ('408', '妖气原创网', 'http://www.17yc.com/', '3', '123.57.48.109', '中国', 'CN', '华北', '100000', '北京市', '110000', '北京市', '110100');
INSERT INTO `url_re_city` VALUES ('409', '麦麦阅读', 'http://m.mmread.com/', '3', '123.57.219.79', '中国', 'CN', '华北', '100000', '北京市', '110000', '北京市', '110100');
INSERT INTO `url_re_city` VALUES ('410', '天地中文网', 'http://www.tiandizw.com/', '3', '180.97.168.188', '中国', 'CN', '华东', '300000', '江苏省', '320000', '苏州市', '320500');
INSERT INTO `url_re_city` VALUES ('411', '异客书栈', 'http://www.1ksz.com/', '3', '120.76.208.210', '中国', 'CN', '华南', '800000', '广东省', '440000', '深圳市', '440300');
INSERT INTO `url_re_city` VALUES ('412', '塔读文学', 'http://www.tadu.com/', '3', '211.151.212.33', '中国', 'CN', '华北', '100000', '北京市', '110000', '北京市', '110100');
INSERT INTO `url_re_city` VALUES ('413', '盛世阅读网', 'http://www.s4yd.com/', '3', '120.76.161.125', '中国', 'CN', '华南', '800000', '广东省', '440000', '深圳市', '440300');
INSERT INTO `url_re_city` VALUES ('414', '爆侃网文', 'http://www.baokan.name/', '3', '120.24.79.174', '中国', 'CN', '华南', '800000', '广东省', '440000', '深圳市', '440300');
INSERT INTO `url_re_city` VALUES ('415', '燃文小说 ', 'http://www.52ranwen.net/', '3', '183.86.218.14', '韩国', 'KR', '', '', '', '', '', '');
INSERT INTO `url_re_city` VALUES ('416', '擦火阅读', 'http://www.cahuo.com/', '3', '101.201.116.237', '中国', 'CN', '华北', '100000', '北京市', '110000', '北京市', '110100');
INSERT INTO `url_re_city` VALUES ('417', '陌上香坊', 'http://www.msxf.net/', '3', '119.29.125.202', '中国', 'CN', '华南', '800000', '广东省', '440000', '', '');
INSERT INTO `url_re_city` VALUES ('418', '四月天', 'http://www.4yt.net/', '3', '60.205.113.37', '中国', 'CN', '华北', '100000', '北京市', '110000', '北京市', '110100');
INSERT INTO `url_re_city` VALUES ('419', '汤圆小说网', 'http://www.itangyuan.com/', '3', '106.75.21.5', '中国', 'CN', '华东', '300000', '山东省', '370000', '济南市', '370100');
INSERT INTO `url_re_city` VALUES ('420', '二层楼书院', 'http://www.2cloo.com/', '3', '182.92.26.100', '中国', 'CN', '华北', '100000', '北京市', '110000', '北京市', '110100');
INSERT INTO `url_re_city` VALUES ('421', '魔情小说网', 'http://www.moqing.com/', '3', '61.147.218.24', '中国', 'CN', '华东', '300000', '江苏省', '320000', '南通市', '320600');
INSERT INTO `url_re_city` VALUES ('422', '千马中文网', 'http://www.qmcmw.com/', '3', '202.91.247.9', '中国', 'CN', '华东', '300000', '浙江省', '330000', '杭州市', '330100');
INSERT INTO `url_re_city` VALUES ('423', '悠空网小说', 'http://www.yokong.com/', '3', '58.216.17.125', '中国', 'CN', '华东', '300000', '江苏省', '320000', '常州市', '320400');
INSERT INTO `url_re_city` VALUES ('424', '暗时阅读网', 'http://www.anshi7.com/', '3', '121.40.127.202', '中国', 'CN', '华东', '300000', '浙江省', '330000', '杭州市', '330100');
INSERT INTO `url_re_city` VALUES ('425', '胭脂小说网', 'http://www.yznovel.com/', '3', '114.55.62.198', '中国', 'CN', '华东', '300000', '浙江省', '330000', '杭州市', '330100');
INSERT INTO `url_re_city` VALUES ('426', '沃读文学网', 'http://www.iwodu.com/', '3', '218.244.139.81', '中国', 'CN', '华东', '300000', '浙江省', '330000', '杭州市', '330100');
INSERT INTO `url_re_city` VALUES ('427', '小说520', 'http://www.xiaoshuo520.com/', '3', '139.196.228.89', '中国', 'CN', '华东', '300000', '上海市', '310000', '上海市', '310100');
INSERT INTO `url_re_city` VALUES ('428', '小说控', 'http://www.xiaoshuokong.com/', '3', '112.126.83.41', '中国', 'CN', '华北', '100000', '北京市', '110000', '北京市', '110100');
INSERT INTO `url_re_city` VALUES ('429', '巨匠网', 'http://www.jujiangkk.com/', '3', '123.56.129.203', '中国', 'CN', '华北', '100000', '北京市', '110000', '北京市', '110100');
INSERT INTO `url_re_city` VALUES ('430', '大鱼中文网', 'http://www.dayuread.com/', '3', '139.196.210.156', '中国', 'CN', '华东', '300000', '上海市', '310000', '上海市', '310100');
INSERT INTO `url_re_city` VALUES ('431', '莺田书城', 'http://www.yingtianbook.com/', '3', '121.42.46.197', '中国', 'CN', '华东', '300000', '山东省', '370000', '青岛市', '370200');
INSERT INTO `url_re_city` VALUES ('432', '熊猫看书网', 'http://www.xmkanshu.com/', '3', '118.26.21.72', '中国', 'CN', '华北', '100000', '北京市', '110000', '北京市', '110100');
INSERT INTO `url_re_city` VALUES ('433', '创酷中文网', 'http://www.acoolread.com/', '3', '123.57.204.32', '中国', 'CN', '华北', '100000', '北京市', '110000', '北京市', '110100');
INSERT INTO `url_re_city` VALUES ('434', '锦色文学网', 'http://www.jinsebook.com/', '3', '121.40.208.7', '中国', 'CN', '华东', '300000', '浙江省', '330000', '杭州市', '330100');
INSERT INTO `url_re_city` VALUES ('435', '书丛中文小说', 'http://www.shucong.com/', '3', '180.97.163.220', '中国', 'CN', '华东', '300000', '江苏省', '320000', '苏州市', '320500');
INSERT INTO `url_re_city` VALUES ('436', '蔷薇书院', 'http://www.qwsy.com/', '3', '125.90.88.76', '中国', 'CN', '华南', '800000', '广东省', '440000', '茂名市', '440900');
INSERT INTO `url_re_city` VALUES ('437', '小说大全', 'http://book.km.com/', '3', '124.243.254.3', '中国', 'CN', '华北', '100000', '北京市', '110000', '北京市', '110100');
INSERT INTO `url_re_city` VALUES ('438', '香网', 'http://www.xiang5.com/', '3', '180.97.168.189', '中国', 'CN', '华东', '300000', '江苏省', '320000', '苏州市', '320500');
INSERT INTO `url_re_city` VALUES ('439', '114小说', 'http://book.114la.com/', '3', '118.186.64.243', '中国', 'CN', '华北', '100000', '北京市', '110000', '北京市', '110100');
INSERT INTO `url_re_city` VALUES ('440', '三五中文网', 'http://www.35zww.com/', '3', '67.229.97.100', '美国', 'US', '', '', '', '', '', '');
INSERT INTO `url_re_city` VALUES ('441', '八一中文网', 'http://www.x81zw.com/', '3', '58.218.215.171', '中国', 'CN', '华东', '300000', '江苏省', '320000', '徐州市', '320300');
INSERT INTO `url_re_city` VALUES ('442', '棋子小说', 'http://www.qizi.la/', '3', '198.15.135.18', '美国', 'US', '', '', '', '', '', '');
INSERT INTO `url_re_city` VALUES ('443', '小说77', 'http://www.xiaoshuo77.com/', '3', '58.216.17.109', '中国', 'CN', '华东', '300000', '江苏省', '320000', '常州市', '320400');
INSERT INTO `url_re_city` VALUES ('444', '花曼原创网', 'http://www.hm-yc.com/', '3', '203.195.128.191', '中国', 'CN', '华南', '800000', '广东省', '440000', '广州市', '440100');
INSERT INTO `url_re_city` VALUES ('445', '鬼大爷小说', 'http://book.guidaye.com/', '3', '58.218.215.167', '中国', 'CN', '华东', '300000', '江苏省', '320000', '徐州市', '320300');
INSERT INTO `url_re_city` VALUES ('446', '风云小说阅读网', 'http://www.baoliny.com/', '3', '104.31.8.162', '美国', 'US', '', '', '', '', '', '');
INSERT INTO `url_re_city` VALUES ('447', '和讯读书网', 'http://book.hexun.com/', '3', '61.183.12.59', '中国', 'CN', '华中', '400000', '湖北省', '420000', '武汉市', '420100');
INSERT INTO `url_re_city` VALUES ('448', '世纪书城', 'http://www.2200book.com/', '3', '221.234.46.10', '中国', 'CN', '华中', '400000', '湖北省', '420000', '鄂州市', '420700');
INSERT INTO `url_re_city` VALUES ('449', '春田花花', 'http://www.ctbook.cn/', '3', '203.195.128.191', '中国', 'CN', '华南', '800000', '广东省', '440000', '广州市', '440100');
INSERT INTO `url_re_city` VALUES ('450', '华夏天空网', 'http://www.hxtk.com/', '3', '139.196.208.147', '中国', 'CN', '华东', '300000', '上海市', '310000', '上海市', '310100');
INSERT INTO `url_re_city` VALUES ('451', '玄色小说', 'http://www.xsread.com/', '3', '203.195.142.22', '中国', 'CN', '华南', '800000', '广东省', '440000', '广州市', '440100');
INSERT INTO `url_re_city` VALUES ('452', '铸剑阁', 'http://www.zhujiange.com/', '3', '203.195.142.22', '中国', 'CN', '华南', '800000', '广东省', '440000', '广州市', '440100');

