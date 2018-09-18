/*
Navicat MySQL Data Transfer

Source Server         : crawler
Source Server Version : 50717
Source Host           : localhost:3306
Source Database       : new_crawler_db

Target Server Type    : MYSQL
Target Server Version : 50717
File Encoding         : 65001

Date: 2017-05-18 11:16:25
*/

SET FOREIGN_KEY_CHECKS=0;

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

INSERT INTO `s_gis_detail_info` VALUES ('10', '0', '2017-05-10 00:00:00', '3', '优衣库', '8245', '4432', '14991', '367346', '5433212', '90', '232423', '优衣库;青年男女;21世纪', '优衣库', '百度', '234234', '66', '34534', '4353', '2017-05-10 17:41:24', '235423', '320500', 'http://www.bilibili.com/', '11');
INSERT INTO `s_gis_detail_info` VALUES ('12', '0', '2017-05-18 02:34:09', '3', '黄鳝门事件', '3281', '563', '880', '5791', '5433212', '12', '224030', '2017年2月，老虎直播平台一名叫琪琪的女主播为“博取眼球”吸引观众刷礼物，用黄鳝进行了一系列不可描述的事情，女主播琪琪直播黄鳝视频事件也迅速登上微博热搜榜，引起众多网友热议。', '黄鳝门;主播琪琪;2017-05-10', 'http://www.mnw.cn ', '1111', '0.12', '1111', '1111', '2017-05-10 00:00:00', '460000', '441900', 'http://www.mnw.cn/sports/dzjj/201703/1643394.html', '12');
INSERT INTO `s_gis_detail_info` VALUES ('13', '0', '2017-05-01 00:00:00', '3', '江苏小贩捅死城管商户', '3281', '563', '880', '5791', '5433212', '11', '1221', '2017年5月16日上午8时15分，市公安局110指挥中心接到群众报警称，太滆菜场有人持刀砍人。接报警后，我市警方立即组织警力赶赴现场开展先期处置工作，将5名伤者送医救治，同时发现持刀伤人作案嫌疑人张建国行凶后已逃离现场。我市警方迅速启动重大突发案件侦破机制，在市委市政府和上级公安机关的统一指挥下，抽调足够警力展开追缉和案侦等工作。', '江苏小贩捅死城管商户事件;小贩;2017-05-10', 'po.baidu.com ', '2222', '1.1', '2222', '2222', '2017-05-10 00:00:00', '111000', '441900', 'https://po.baidu.com/feed/share?context={%22nid%22:%22news_2428131919605215851%22}', '13');
INSERT INTO `s_gis_detail_info` VALUES ('14', '0', '2017-05-01 00:00:00', '3', '新疆皮山暴恐案', '692', '268', '56', '426', '5433212', '13', '975', '2017年2月14日19时20分许，3名暴徒在皮山县城某小区内持刀砍杀群众，公安便民警务站民警一分钟内迅速处置，当场击毙3名暴徒。案件造成10名群众受伤。其中，5人因伤势过重经医院抢救无效死亡。', '新疆皮山暴恐案;新疆人;2017-02-14', 'www.4hw.com.cn', '3333', '1.3', '3333', '3333', '2017-02-14 19:20:00', '75000', '441900', 'http://www.4hw.com.cn/new/shnews/20170216/12_326836.html', '14');
INSERT INTO `s_gis_detail_info` VALUES ('2', '0', '2017-05-10 17:37:39', '0', '人民的名义', '343778', '1202415', '777251', '5476551', '5433212', '90', '232423', '人民的名义;李路;21世纪', '人民的名义;李路;21世纪', '百度', '234234', '66', '34534', '4353', '2017-05-10 17:41:24', '235423', '320500', 'http://www.bilibili.com/', '3');
INSERT INTO `s_gis_detail_info` VALUES ('3', '0', '2017-05-10 00:00:00', '0', '欢乐颂', '375207', '98839', '231479', '48484772', '5433212', '90', '232423', '欢乐颂;孔笙，简川訸;21世纪', '欢乐颂；孔笙，简川訸；21世纪', '百度', '234234', '66', '34534', '4353', '2017-05-10 17:41:24', '235423', '320500', 'http://www.bilibili.com/', '4');
INSERT INTO `s_gis_detail_info` VALUES ('4', '0', '2017-05-10 00:00:00', '1', '暧昧', '5966', '3271', '42129', '927342', '5433212', '90', '232423', '暧昧;薛之谦;暧昧;2017-04-11; 海蝶音乐', '暧昧；薛之谦；二十年代', '百度', '234234', '66', '34534', '4353', '2017-05-10 17:41:24', '235423', '320500', 'http://www.bilibili.com/', '5');
INSERT INTO `s_gis_detail_info` VALUES ('5', '0', '2017-05-10 00:00:00', '1', '演员', '10139', '3789', '117774', '4346735', '5433212', '90', '232423', '绅士;薛之谦;演员;2015-06-05; 海蝶音乐', '演员；薛之谦；二十年代', '百度', '234234', '66', '34534', '4353', '2017-05-10 17:41:24', '235423', '320500', 'http://www.bilibili.com/', '6');
INSERT INTO `s_gis_detail_info` VALUES ('6', '0', '2017-05-10 00:00:00', '2', '逆鳞', '255944', '3711', '31637', '6294', '5433212', '90', '232423', '逆鳞;柳下挥;2015-11-11;东方玄幻', '逆鳞；柳下挥；二十年代', '百度', '234234', '66', '34534', '4353', '2017-05-10 17:41:24', '235423', '320500', 'http://www.bilibili.com/', '7');
INSERT INTO `s_gis_detail_info` VALUES ('7', '0', '2017-05-10 00:00:00', '2', '择天记', '698015', '622781', '764586', '18120', '5433212', '90', '232423', '择天记;猫腻;2015-10-7;东方玄幻', '择天记', '百度', '234234', '66', '34534', '4353', '2017-05-10 17:41:24', '235423', '320500', 'http://www.bilibili.com/', '8');
INSERT INTO `s_gis_detail_info` VALUES ('8', '0', '2017-05-10 00:00:00', '3', '艳照门', '17407', '4322', '26948', '86327', '5433212', '90', '232423', '艳照门;冠希哥;21世纪', '冠希哥', '百度', '234234', '66', '34534', '4353', '2017-05-10 17:41:24', '235423', '320500', 'http://www.bilibili.com/', '9');
INSERT INTO `s_gis_detail_info` VALUES ('9', '0', '2017-05-10 00:00:00', '3', '裸照门', '274', '23', '104', '797', '5433212', '90', '232423', '裸照门;日本青年;21世纪', '裸照门', '百度', '234234', '66', '34534', '4353', '2017-05-10 17:41:24', '235423', '320500', 'http://www.bilibili.com/', '10');

