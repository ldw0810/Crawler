/*
Navicat MySQL Data Transfer

Source Server         : 172.21.14.35_3306
Source Server Version : 50636
Source Host           : 172.21.14.35:3306
Source Database       : crawler_db

Target Server Type    : MYSQL
Target Server Version : 50636
File Encoding         : 65001

Date: 2017-05-12 02:29:23
*/

SET FOREIGN_KEY_CHECKS=0;

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
