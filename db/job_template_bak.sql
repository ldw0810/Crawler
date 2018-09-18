/*
Navicat MySQL Data Transfer

Source Server         : localhost_3306
Source Server Version : 50611
Source Host           : localhost:3306
Source Database       : crawler_db

Target Server Type    : MYSQL
Target Server Version : 50611
File Encoding         : 65001

Date: 2017-04-19 17:34:27
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
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of job_template
-- ----------------------------
INSERT INTO `job_template` VALUES ('1', '0', '0', '112312', null, null, null, null, '', null);
INSERT INTO `job_template` VALUES ('85f33911-2368-11e7-a7d7-e09467f6dff0', '0', '0', '京东列表页面', null, '2017-04-14 00:00:00', 'test1', '//ul[@class=\'gl-warp clearfix \']/li', null, 'https://list.jd.com/list.html?cat=https://list.jd.com/list.html?cat={categories}&pageNo={pageNo}');
INSERT INTO `job_template` VALUES ('f125688f-20f0-11e7-9acb-da017ca21966', '0', '0', '京东商城', null, '2017-04-14 00:00:00', 'test1', '//div[@id=\'booksort\']/div//a', '', 'https://book.jd.com/booksort.html');
INSERT INTO `job_template` VALUES ('f541c6f0-24c7-11e7-b066-e09467f6dff0', '0', '0', '京东详情页', null, '2017-04-14 00:00:00', 'test1', '', null, 'https:{detail_url}');

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
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of job_template_field
-- ----------------------------
INSERT INTO `job_template_field` VALUES ('1', '0', 'name', '名称', 'varchar', '1024', '1', '1', null, null, null, null, null);
INSERT INTO `job_template_field` VALUES ('2683c0c0-20f3-11e7-bf14-da017ca21966', '0', 'url', '地址', 'varchar', '255', 'test1', 'f125688f-20f0-11e7-9acb-da017ca21966', null, null, '@href', null, null);
INSERT INTO `job_template_field` VALUES ('320161e1-24c8-11e7-9867-e09467f6dff0', '0', 'price', '书籍价格', 'varchar', '255', 'test1', 'f541c6f0-24c7-11e7-b066-e09467f6dff0', null, null, '//strong[@id=\'jd-price\']/text()', null, null);
INSERT INTO `job_template_field` VALUES ('3b2d408f-24c8-11e7-a58b-e09467f6dff0', '0', 'comment_num', '评论数', 'varchar', '255', 'test1', 'f541c6f0-24c7-11e7-b066-e09467f6dff0', null, null, '//a[starts-with(@id,\'count J-comm-\')]/text()', null, null);
INSERT INTO `job_template_field` VALUES ('4251c540-24c2-11e7-bfb8-e09467f6dff0', '0', 'detail_url', '名称', 'varchar', '255', 'test1', '85f33911-2368-11e7-a7d7-e09467f6dff0', null, null, 'div[@class=\"gl-i-wrap j-sku-item\"]/div[@class=\"p-img\"]/a/@href[1]', null, null);
INSERT INTO `job_template_field` VALUES ('431f8140-24dd-11e7-9316-e09467f6dff0', '0', 'name', '名称', 'varchar', '255', 'test1', 'f541c6f0-24c7-11e7-b066-e09467f6dff0', null, null, '//div[@id=\'name\']/h1/text()', null, null);
INSERT INTO `job_template_field` VALUES ('4df35aae-24c9-11e7-948a-e09467f6dff0', '0', 'word_count', '字数', 'varchar', '255', 'test1', 'f541c6f0-24c7-11e7-b066-e09467f6dff0', '字数：([\\s]*[^\\s]*)', null, '//ul[@id=\'parameter2\']//text()', null, null);
INSERT INTO `job_template_field` VALUES ('55bc5acf-21a4-11e7-b90d-da017ca21966', '1', 'task_job_url', '名称', 'varchar', '255', 'test1', 'f125688f-20f0-11e7-9acb-da017ca21966', null, null, '', 'self.url', null);
INSERT INTO `job_template_field` VALUES ('5bc84f0f-24c9-11e7-80db-e09467f6dff0', '0', 'language', '正文语种', 'varchar', '255', 'test1', 'f541c6f0-24c7-11e7-b066-e09467f6dff0', '正文语种：([\\s]*[^\\s]*)', null, '//ul[@id=\'parameter2\']//text()', null, null);
INSERT INTO `job_template_field` VALUES ('6a7c8cb0-21a4-11e7-9412-da017ca21966', '0', 'task_job_url', '名称', 'varchar', '255', 'test1', 'f125688f-20f0-11e7-9acb-da017ca21966', null, null, '', 'self.url', null);
INSERT INTO `job_template_field` VALUES ('7effdfc0-24dd-11e7-9758-e09467f6dff0', '0', 'images', '图片地址', 'varchar', '1024', 'test1', 'f541c6f0-24c7-11e7-b066-e09467f6dff0', null, ';', '//div[@class=\'spec-items\']/ul/li/img/@src', null, null);
INSERT INTO `job_template_field` VALUES ('7fcd924f-20f3-11e7-a259-da017ca21966', '0', 'categories', '栏目ids', 'varchar', '255', 'test1', 'f125688f-20f0-11e7-9acb-da017ca21966', '[0-9]+(-[0-9]+)+', '', '@href', '\"{value}\".replace(\"-\",\",\")', null);
INSERT INTO `job_template_field` VALUES ('8e618991-2367-11e7-a883-e09467f6dff0', '0', 'name', '地址', 'varchar', '255', 'test1', '3d9e8cc0-21a9-11e7-b9ab-da017ca21966', null, null, 'div//a/@href', null, null);
INSERT INTO `job_template_field` VALUES ('9c516a8f-24c8-11e7-a500-e09467f6dff0', '0', 'publisher', '出版社数', 'varchar', '255', 'test1', 'f541c6f0-24c7-11e7-b066-e09467f6dff0', '出版社：([\\s]*[^\\s]*)', null, '//ul[@id=\'parameter2\']//text()', null, null);
INSERT INTO `job_template_field` VALUES ('a34de61e-24c8-11e7-bb83-e09467f6dff0', '0', 'banci', '版次数', 'varchar', '255', 'test1', 'f541c6f0-24c7-11e7-b066-e09467f6dff0', '版次：([\\s]*[^\\s]*)', null, '//ul[@id=\'parameter2\']//text()', null, null);
INSERT INTO `job_template_field` VALUES ('ae7c4b8f-24c8-11e7-9752-e09467f6dff0', '0', 'code', '商品编码', 'varchar', '255', 'test1', 'f541c6f0-24c7-11e7-b066-e09467f6dff0', '商品编码：([\\s]*[^\\s]*)', null, '//ul[@id=\'parameter2\']//text()', null, null);
INSERT INTO `job_template_field` VALUES ('b0af4361-20f2-11e7-bd80-da017ca21966', '0', 'name', '名称', 'varchar', '255', 'test1', 'f125688f-20f0-11e7-9acb-da017ca21966', null, null, 'text()', null, '');
INSERT INTO `job_template_field` VALUES ('bc5fe5f0-24c8-11e7-a8aa-e09467f6dff0', '0', 'package', '包装', 'varchar', '255', 'test1', 'f541c6f0-24c7-11e7-b066-e09467f6dff0', '包装：([\\s]*[^\\s]*)', null, '//ul[@id=\'parameter2\']//text()', null, null);
INSERT INTO `job_template_field` VALUES ('c6c46bb0-24c8-11e7-918f-e09467f6dff0', '0', 'kaiben', '开本', 'varchar', '255', 'test1', 'f541c6f0-24c7-11e7-b066-e09467f6dff0', '开本：([\\s]*[^\\s]*)', null, '//ul[@id=\'parameter2\']//text()', null, null);
INSERT INTO `job_template_field` VALUES ('d7e6dd5e-24c8-11e7-a432-e09467f6dff0', '0', 'publish_time', '出版时间', 'varchar', '255', 'test1', 'f541c6f0-24c7-11e7-b066-e09467f6dff0', '出版时间：([\\s]*[^\\s]*)', null, '//ul[@id=\'parameter2\']//text()', null, null);
INSERT INTO `job_template_field` VALUES ('e210a40f-24c8-11e7-a430-e09467f6dff0', '0', 'page', '用纸', 'varchar', '255', 'test1', 'f541c6f0-24c7-11e7-b066-e09467f6dff0', '用纸：([\\s]*[^\\s]*)', null, '//ul[@id=\'parameter2\']//text()', null, null);
INSERT INTO `job_template_field` VALUES ('e95c9f2e-24c8-11e7-adb9-e09467f6dff0', '0', 'pageNo', '页数', 'varchar', '255', 'test1', 'f541c6f0-24c7-11e7-b066-e09467f6dff0', '页数：([\\s]*[^\\s]*)', null, '//ul[@id=\'parameter2\']//text()', null, null);

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
INSERT INTO `job_template_param` VALUES ('caafbe5e-24c2-11e7-b49e-e09467f6dff0', '0', null, null, null, null, null, null, null, '0', null);
INSERT INTO `job_template_param` VALUES ('cc047e21-24b0-11e7-bc66-e09467f6dff0', '0', 'pageNo', '页数', '1', '{pageNo}+1<={pageCount}', '{pageNo}+1', '0000-00-00 00:00:00', 'test1', '0', '85f33911-2368-11e7-a7d7-e09467f6dff0');
INSERT INTO `job_template_param` VALUES ('dfea0240-24c2-11e7-b204-e09467f6dff0', '0', 'pageCount', '页数', '//span[@class=\'p-skip\'/em/b]', '', '', '0000-00-00 00:00:00', 'test1', '1', '85f33911-2368-11e7-a7d7-e09467f6dff0');

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
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of task_job
-- ----------------------------
INSERT INTO `task_job` VALUES ('1', '0', '2017-04-13 21:49:42', '京东列表', 'https://list.jd.com/list.html?cat=https://list.jd.com/list.html?cat={categories}&page={pageNo}&sort=sort_rank_asc', '0', '1', '85f33911-2368-11e7-a7d7-e09467f6dff0', 'jd_list', '18e7a7f0-20f9-11e7-8bcb-da017ca21966', null, null, null, null, null, null, null, null);
INSERT INTO `task_job` VALUES ('18e7a7f0-20f9-11e7-8bcb-da017ca21966', '0', '2017-04-14 00:00:00', '京东类目', 'https://book.jd.com/booksort.html', null, '3', 'f125688f-20f0-11e7-9acb-da017ca21966', 'taskJob_20170414000000', null, null, null, null, null, null, null, null, null);
INSERT INTO `task_job` VALUES ('68f66421-20ef-11e7-9b23-da017ca21966', '0', '2017-04-14 00:00:00', 'test', 'https://book.jd.com/booksort.html', null, null, 'f125688f-20f0-11e7-9acb-da017ca21966', null, null, null, null, null, null, null, null, null, null);
INSERT INTO `task_job` VALUES ('8e2bfa4f-24ca-11e7-8b9a-e09467f6dff0', '0', '2017-04-14 00:00:00', '京东详情', 'https:{detail_url}', null, '1', 'f541c6f0-24c7-11e7-b066-e09467f6dff0', 'taskJob_20170414000001', '1', null, null, null, null, null, null, null, null);

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
INSERT INTO `task_job_re_field` VALUES ('8d22121e-24cf-11e7-a3e8-e09467f6dff0', '0', '1', '4251c540-24c2-11e7-bfb8-e09467f6dff0', '85f33911-2368-11e7-a7d7-e09467f6dff0', '2017-04-19 15:12:30');
INSERT INTO `task_job_re_field` VALUES ('96c81f4f-24ce-11e7-9dd8-e09467f6dff0', '1', '8e2bfa4f-24ca-11e7-8b9a-e09467f6dff0', '320161e1-24c8-11e7-9867-e09467f6dff0', 'f541c6f0-24c7-11e7-b066-e09467f6dff0', '2017-04-19 15:05:36');
INSERT INTO `task_job_re_field` VALUES ('96d53eb0-24ce-11e7-91e5-e09467f6dff0', '1', '8e2bfa4f-24ca-11e7-8b9a-e09467f6dff0', '3b2d408f-24c8-11e7-a58b-e09467f6dff0', 'f541c6f0-24c7-11e7-b066-e09467f6dff0', '2017-04-19 15:05:37');
INSERT INTO `task_job_re_field` VALUES ('96e459e1-24ce-11e7-9c41-e09467f6dff0', '1', '8e2bfa4f-24ca-11e7-8b9a-e09467f6dff0', '4251c540-24c2-11e7-bfb8-e09467f6dff0', 'f541c6f0-24c7-11e7-b066-e09467f6dff0', '2017-04-19 15:05:37');
INSERT INTO `task_job_re_field` VALUES ('96ee930f-24ce-11e7-986f-e09467f6dff0', '1', '8e2bfa4f-24ca-11e7-8b9a-e09467f6dff0', '4df35aae-24c9-11e7-948a-e09467f6dff0', 'f541c6f0-24c7-11e7-b066-e09467f6dff0', '2017-04-19 15:05:37');
INSERT INTO `task_job_re_field` VALUES ('96f8f351-24ce-11e7-836d-e09467f6dff0', '1', '8e2bfa4f-24ca-11e7-8b9a-e09467f6dff0', '5bc84f0f-24c9-11e7-80db-e09467f6dff0', 'f541c6f0-24c7-11e7-b066-e09467f6dff0', '2017-04-19 15:05:37');
INSERT INTO `task_job_re_field` VALUES ('9707e76e-24ce-11e7-9194-e09467f6dff0', '1', '8e2bfa4f-24ca-11e7-8b9a-e09467f6dff0', '9c516a8f-24c8-11e7-a500-e09467f6dff0', 'f541c6f0-24c7-11e7-b066-e09467f6dff0', '2017-04-19 15:05:37');
INSERT INTO `task_job_re_field` VALUES ('970eec4f-24ce-11e7-a9a6-e09467f6dff0', '1', '8e2bfa4f-24ca-11e7-8b9a-e09467f6dff0', 'a34de61e-24c8-11e7-bb83-e09467f6dff0', 'f541c6f0-24c7-11e7-b066-e09467f6dff0', '2017-04-19 15:05:37');
INSERT INTO `task_job_re_field` VALUES ('971554f0-24ce-11e7-9b76-e09467f6dff0', '1', '8e2bfa4f-24ca-11e7-8b9a-e09467f6dff0', 'ae7c4b8f-24c8-11e7-9752-e09467f6dff0', 'f541c6f0-24c7-11e7-b066-e09467f6dff0', '2017-04-19 15:05:37');
INSERT INTO `task_job_re_field` VALUES ('971c32c0-24ce-11e7-99a9-e09467f6dff0', '1', '8e2bfa4f-24ca-11e7-8b9a-e09467f6dff0', 'bc5fe5f0-24c8-11e7-a8aa-e09467f6dff0', 'f541c6f0-24c7-11e7-b066-e09467f6dff0', '2017-04-19 15:05:37');
INSERT INTO `task_job_re_field` VALUES ('972337a1-24ce-11e7-a18f-e09467f6dff0', '1', '8e2bfa4f-24ca-11e7-8b9a-e09467f6dff0', 'c6c46bb0-24c8-11e7-918f-e09467f6dff0', 'f541c6f0-24c7-11e7-b066-e09467f6dff0', '2017-04-19 15:05:37');
INSERT INTO `task_job_re_field` VALUES ('9729a040-24ce-11e7-89cd-e09467f6dff0', '1', '8e2bfa4f-24ca-11e7-8b9a-e09467f6dff0', 'd7e6dd5e-24c8-11e7-a432-e09467f6dff0', 'f541c6f0-24c7-11e7-b066-e09467f6dff0', '2017-04-19 15:05:37');
INSERT INTO `task_job_re_field` VALUES ('973252cf-24ce-11e7-94ad-e09467f6dff0', '1', '8e2bfa4f-24ca-11e7-8b9a-e09467f6dff0', 'e210a40f-24c8-11e7-a430-e09467f6dff0', 'f541c6f0-24c7-11e7-b066-e09467f6dff0', '2017-04-19 15:05:37');
INSERT INTO `task_job_re_field` VALUES ('973a902e-24ce-11e7-9d43-e09467f6dff0', '1', '8e2bfa4f-24ca-11e7-8b9a-e09467f6dff0', 'e95c9f2e-24c8-11e7-adb9-e09467f6dff0', 'f541c6f0-24c7-11e7-b066-e09467f6dff0', '2017-04-19 15:05:37');
INSERT INTO `task_job_re_field` VALUES ('b3837a40-24dd-11e7-89a6-e09467f6dff0', '0', '8e2bfa4f-24ca-11e7-8b9a-e09467f6dff0', '320161e1-24c8-11e7-9867-e09467f6dff0', 'f541c6f0-24c7-11e7-b066-e09467f6dff0', '2017-04-19 16:53:47');
INSERT INTO `task_job_re_field` VALUES ('b3918400-24dd-11e7-b6f8-e09467f6dff0', '0', '8e2bfa4f-24ca-11e7-8b9a-e09467f6dff0', '3b2d408f-24c8-11e7-a58b-e09467f6dff0', 'f541c6f0-24c7-11e7-b066-e09467f6dff0', '2017-04-19 16:53:47');
INSERT INTO `task_job_re_field` VALUES ('b3983ac0-24dd-11e7-9d94-e09467f6dff0', '0', '8e2bfa4f-24ca-11e7-8b9a-e09467f6dff0', '431f8140-24dd-11e7-9316-e09467f6dff0', 'f541c6f0-24c7-11e7-b066-e09467f6dff0', '2017-04-19 16:53:47');
INSERT INTO `task_job_re_field` VALUES ('b39f1891-24dd-11e7-963f-e09467f6dff0', '0', '8e2bfa4f-24ca-11e7-8b9a-e09467f6dff0', '4df35aae-24c9-11e7-948a-e09467f6dff0', 'f541c6f0-24c7-11e7-b066-e09467f6dff0', '2017-04-19 16:53:47');
INSERT INTO `task_job_re_field` VALUES ('b3a5a840-24dd-11e7-b181-e09467f6dff0', '0', '8e2bfa4f-24ca-11e7-8b9a-e09467f6dff0', '5bc84f0f-24c9-11e7-80db-e09467f6dff0', 'f541c6f0-24c7-11e7-b066-e09467f6dff0', '2017-04-19 16:53:47');
INSERT INTO `task_job_re_field` VALUES ('b3aa6330-24dd-11e7-82c7-e09467f6dff0', '0', '8e2bfa4f-24ca-11e7-8b9a-e09467f6dff0', '7effdfc0-24dd-11e7-9758-e09467f6dff0', 'f541c6f0-24c7-11e7-b066-e09467f6dff0', '2017-04-19 16:53:47');
INSERT INTO `task_job_re_field` VALUES ('b3ae33c0-24dd-11e7-a798-e09467f6dff0', '0', '8e2bfa4f-24ca-11e7-8b9a-e09467f6dff0', '9c516a8f-24c8-11e7-a500-e09467f6dff0', 'f541c6f0-24c7-11e7-b066-e09467f6dff0', '2017-04-19 16:53:47');
INSERT INTO `task_job_re_field` VALUES ('b3b33cd1-24dd-11e7-ad33-e09467f6dff0', '0', '8e2bfa4f-24ca-11e7-8b9a-e09467f6dff0', 'a34de61e-24c8-11e7-bb83-e09467f6dff0', 'f541c6f0-24c7-11e7-b066-e09467f6dff0', '2017-04-19 16:53:47');
INSERT INTO `task_job_re_field` VALUES ('b3b86cf0-24dd-11e7-b909-e09467f6dff0', '0', '8e2bfa4f-24ca-11e7-8b9a-e09467f6dff0', 'ae7c4b8f-24c8-11e7-9752-e09467f6dff0', 'f541c6f0-24c7-11e7-b066-e09467f6dff0', '2017-04-19 16:53:47');
INSERT INTO `task_job_re_field` VALUES ('b3bd7600-24dd-11e7-85fc-e09467f6dff0', '0', '8e2bfa4f-24ca-11e7-8b9a-e09467f6dff0', 'bc5fe5f0-24c8-11e7-a8aa-e09467f6dff0', 'f541c6f0-24c7-11e7-b066-e09467f6dff0', '2017-04-19 16:53:48');
INSERT INTO `task_job_re_field` VALUES ('b3c2a61e-24dd-11e7-8240-e09467f6dff0', '0', '8e2bfa4f-24ca-11e7-8b9a-e09467f6dff0', 'c6c46bb0-24c8-11e7-918f-e09467f6dff0', 'f541c6f0-24c7-11e7-b066-e09467f6dff0', '2017-04-19 16:53:48');
INSERT INTO `task_job_re_field` VALUES ('b3ca955e-24dd-11e7-9bce-e09467f6dff0', '0', '8e2bfa4f-24ca-11e7-8b9a-e09467f6dff0', 'd7e6dd5e-24c8-11e7-a432-e09467f6dff0', 'f541c6f0-24c7-11e7-b066-e09467f6dff0', '2017-04-19 16:53:48');
INSERT INTO `task_job_re_field` VALUES ('b3cfec8f-24dd-11e7-9c3c-e09467f6dff0', '0', '8e2bfa4f-24ca-11e7-8b9a-e09467f6dff0', 'e210a40f-24c8-11e7-a430-e09467f6dff0', 'f541c6f0-24c7-11e7-b066-e09467f6dff0', '2017-04-19 16:53:48');
INSERT INTO `task_job_re_field` VALUES ('b3d4a780-24dd-11e7-89bb-e09467f6dff0', '0', '8e2bfa4f-24ca-11e7-8b9a-e09467f6dff0', 'e95c9f2e-24c8-11e7-adb9-e09467f6dff0', 'f541c6f0-24c7-11e7-b066-e09467f6dff0', '2017-04-19 16:53:48');
INSERT INTO `task_job_re_field` VALUES ('e86a8f4f-24ce-11e7-a3af-e09467f6dff0', '0', '18e7a7f0-20f9-11e7-8bcb-da017ca21966', '2683c0c0-20f3-11e7-bf14-da017ca21966', 'f125688f-20f0-11e7-9acb-da017ca21966', '2017-04-19 15:07:53');
INSERT INTO `task_job_re_field` VALUES ('e8771270-24ce-11e7-8fdd-e09467f6dff0', '0', '18e7a7f0-20f9-11e7-8bcb-da017ca21966', '6a7c8cb0-21a4-11e7-9412-da017ca21966', 'f125688f-20f0-11e7-9acb-da017ca21966', '2017-04-19 15:07:54');
INSERT INTO `task_job_re_field` VALUES ('e87dc930-24ce-11e7-ba6e-e09467f6dff0', '0', '18e7a7f0-20f9-11e7-8bcb-da017ca21966', '7fcd924f-20f3-11e7-a259-da017ca21966', 'f125688f-20f0-11e7-9acb-da017ca21966', '2017-04-19 15:07:54');
INSERT INTO `task_job_re_field` VALUES ('e88ac180-24ce-11e7-a1d4-e09467f6dff0', '0', '18e7a7f0-20f9-11e7-8bcb-da017ca21966', 'b0af4361-20f2-11e7-bd80-da017ca21966', 'f125688f-20f0-11e7-9acb-da017ca21966', '2017-04-19 15:07:54');

-- ----------------------------
-- Table structure for task_job_re_template_param
-- ----------------------------
DROP TABLE IF EXISTS `task_job_re_template_param`;
CREATE TABLE `task_job_re_template_param` (
  `ID` varchar(50) NOT NULL,
  `DEL_FLAG` tinyint(1) DEFAULT '0',
  `JOB_TEMPLATE_ID` varchar(50) DEFAULT NULL,
  `JOB_TEMPLATE_PARAM_ID` varchar(50) DEFAULT NULL,
  `TASK_JOB_ID` varchar(50) DEFAULT NULL,
  `CREATE_TIME` datetime DEFAULT NULL,
  `CREATE_USER_ID` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of task_job_re_template_param
-- ----------------------------
