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
-- 任务数量
CREATE TABLE `task_job_count` (
  `ID` varchar(50) NOT NULL,
  `DEL_FLAG` tinyint(1) DEFAULT '0',
  `TASK_JOB_HISTORY_ID` varchar(50) DEFAULT NULL,
  `CREATE_TIME` datetime DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
-- 任务执行时间
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
  `CREATE_TIME` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


-- 代理信息
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
-- 静态代理
CREATE TABLE `static_proxy_info` (
  `id` varchar(50) NOT NULL,
  `host` varchar(30) DEFAULT NULL,
  `port` varchar(5) DEFAULT NULL,
  `del_flag` tinyint(1) DEFAULT '0',
  `CREATE_TIME` datetime DEFAULT NULL,
  `PROXY_INFO_ID` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 模板参数表
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

CREATE TABLE `content_type` (
  `ID` varchar(50) NOT NULL,
  `NAME` varchar(255) DEFAULT NULL,
  `DEL_FLAG` tinyint(1) DEFAULT NULL,
  `CREATE_TIME` datetime DEFAULT CURRENT_TIMESTAMP,
  `PARENT_ID` varchar(50) DEFAULT '-1',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
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
  -- `DEFAULT_VALUE` varchar(1024) DEFAULT NULL COMMENT '默认值',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `task_job_re_field` (
  `ID` varchar(50) NOT NULL,
  `DEL_FLAG` tinyint(1) DEFAULT NULL,
  `TASK_JOB_ID` varchar(50) DEFAULT NULL,
  `JOB_TEMPALTE_FIELD_ID` varchar(50) DEFAULT NULL,
  `JOB_TEMPLATE_ID` varchar(50) DEFAULT NULL,
  `CREATE_TIME` datetime DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
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
  `task_job_id` varchar(255) DEFAULT NULL,
  `object_type` varchar(8) DEFAULT NULL COMMENT '白名单还是黑屏单1，是白 2是黑',
  `request_type` int(3) DEFAULT NULL,
  `phantomjs_flag` tinyint(1) DEFAULT '0' COMMENT '是否启用phantomjs',
  `parse_type` varchar(10) DEFAULT '1' COMMENT '1:表示xpath,2:表示json',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 数据库增加字段 2017-05-03
alter table task_job add column `proxy_id` varchar(255) comment "代理id关联proxy_info" default null;

-- 数据库增加字段 2017-05-05
alter table task_job add column `content_type_id` varchar(50) comment "类型关联contentType" default null;
alter table task_job add column `execute_status` varchar(8) comment "执行状态" default null;

-- taskJob新增 2017-05-06
alter table task_job add column `page_offset` int(5) comment "翻页增量" default 1;

-- job_template_field 20170509
alter table job_template_field add column `create_time` Datetime comment "创建时间" default now();

-- job_template新增父级id 20170511
-- alter table job_template add column `parent_id` varchar(255) comment "父级id" default -1 ;
-- -- job_template 模板类型 20170511
-- alter table job_template add column `job_template_type` varchar(50) comment 'job_template_type' default -1;
-- alter table job_template add column `database_id` varchar(50) comment 'database_id' default -1;
-- alter table job_template add column `encode_type` varchar(10) comment "是否encode" default null;
-- 版权局代码
-- alter table p_white_and_black_list add column `object_id` varchar(1024)  comment "名单id" default null;
-- alter table p_white_and_black_list add column `object_type` varchar(1024) comment "白名单还是黑屏单1，是白 2是黑" default null ;
-- alter table job_template add column `object_type` varchar(8) comment "白名单还是黑屏单1，是白 2是黑" default null ;



-- -20170515 新增job历史表
CREATE TABLE `task_job_history` (
  `id` varchar(50) NOT NULL,
  `task_job_id` varchar(50) DEFAULT NULL,
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP,
  `del_flag` tinyint(1) DEFAULT NULL,
  `type` varchar(120) DEFAULT NULL,
  `status` varchar(8) DEFAULT NULL,
  `user_id` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



CREATE TABLE `task_job_param` (
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
  `TASK_JOB_ID` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


-- 新增模板增加任务Id 20170524
-- alter table job_template add column  `task_job_id` varchar(255) default null;
-- alter table job_template add column  `request_type` int(3) default null;

-- 新增任务和模板关系表
CREATE TABLE `task_job_re_template` (
  `ID` varchar(50) NOT NULL,
  `DEL_FLAG` tinyint(1) DEFAULT NULL,
  `TASK_JOB_ID` varchar(50) DEFAULT NULL,
  `JOB_TEMPLATE_ID` varchar(50) DEFAULT NULL,
  `CREATE_TIME` datetime DEFAULT NULL,
	`CREATE_USER_ID`	varchar(50) default NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 日志表添加字段 20170525
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
alter table log_info add column `task_job_history_id` varchar(50) default null comment "任务记录id";
alter table log_info add column `job_template_id` varchar(50) default null comment "模板id";
alter table log_info add column `url` varchar(1024) default null comment "url";
alter table job_template_field add column `DEFAULT_VALUE` varchar(1024) default null comment "默认值";
alter table task_job_re_template add column `field_ids` varchar(2048) default null;
-- alter table job_template add column `parse_type` varchar(10) default 1 comment "1:表示xpath,2:表示json";
-- alter table job_template add column `phantomjs_flag` tinyint(1) default 0 COMMENT "是否启用phantomjs";



-- 日志表增加状态值 20170526
alter table log_info add column `status` varchar(10) comment "状态值" default null;


-- 增加数据源kafka的topic配置

alter table db_source add column `topic` varchar(255) DEFAULT null comment "kafka topic配置";

-- 增加phantomjs睡眠时间
alter table `job_template` add column `sleep_time` int default 1 comment '睡眠时间';

-- 新增cookie配置
alter table `job_template` add column `cookie_flag` tinyint(1) default 0 COMMENT "是否启用cookie";
alter table `job_template` add column `cookie_obtain_url` varchar(255) default null;
alter table `job_template` add column `cookie_refresh_cycle` int(11) default -1;
-- 新增字段
ALTER TABLE `job_template` ADD COLUMN `u_login_behavior_id`  varchar(50) NULL AFTER `cookie_refresh_cycle`;
-- taskJob新增 2017-06-26
alter table task_job add column `key_word` varchar(255) default null comment "关键词";
-- 新增表
DROP TABLE IF EXISTS `user_login_behavior`;
CREATE TABLE `user_login_behavior` (
  `login_label` varchar(255) DEFAULT NULL,
  `vert_img_label` varchar(255) DEFAULT NULL,
  `vert_input_label` varchar(255) DEFAULT NULL,
  `pass_word_label` varchar(255) DEFAULT NULL,
  `user_label` varchar(255) DEFAULT NULL,
  `pass_word` varchar(255) DEFAULT NULL,
  `user_id` varchar(255) DEFAULT NULL,
  `id` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 新增字段(是否自动登录) 
ALTER TABLE `job_template` ADD COLUMN `auto_login`  tinyint(1) NOT NULL DEFAULT 0 AFTER `cookie_refresh_cycle`;
-- 2017-06-29数据预置
INSERT INTO `content_type` (`ID`, `NAME`, `DEL_FLAG`, `CREATE_TIME`, `PARENT_ID`) VALUES ('1', '视频', '0', '2017-06-29 21:51:48', '-1');
INSERT INTO `content_type` (`ID`, `NAME`, `DEL_FLAG`, `CREATE_TIME`, `PARENT_ID`) VALUES ('2', '图书', '0', '2017-06-29 21:52:00', '-1');

-- 监控采集趋势 2017-06-30
DROP TABLE IF EXISTS `data_listener`;
CREATE TABLE `data_listener` (
  `id` varchar(50) NOT NULL,
  `time` varchar(50) DEFAULT NULL,
  `count` varchar(250) DEFAULT NULL,
  `totle` varchar(250) DEFAULT NULL,
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 全网爬取 2017-07-05
ALTER TABLE `task_job`
ADD COLUMN `depth_limit`  int(5) NOT NULL DEFAULT 0 AFTER `key_word`;

-- Date: 2017-07-19 09:20:03 增加url状态表
DROP TABLE IF EXISTS `url_list_status`;
CREATE TABLE `url_list_status` (
  `id` varchar(50) NOT NULL DEFAULT '0',
  `url` varchar(255) DEFAULT NULL,
  `parentUrl` varchar(255) DEFAULT NULL,
  `status` tinyint(1) DEFAULT '0' COMMENT '状态',
  `desc` varchar(1024) DEFAULT NULL COMMENT '注释',
  `jobTemplateId` varchar(50) DEFAULT '-1',
  `jobTemplateParentId` varchar(50) DEFAULT '-1',
  `taskJobId` varchar(50) DEFAULT NULL COMMENT '任务id',
  `createTime` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `delFlag` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
-- Date:2017-07-25 增加节点监控相关表
--  Table structure for `t_static_pc_info`
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
--  Table structure for `t_dynamic_pc_info`
DROP TABLE IF EXISTS `t_dynamic_pc_info`;
CREATE TABLE `t_dynamic_pc_info` (
  `ID` varchar(50) NOT NULL,
  `ASSETID` varchar(50) DEFAULT NULL,
  `IP` varchar(50) DEFAULT NULL,
  `MEMORY` varchar(50) DEFAULT NULL,
  `CPU` varchar(50) DEFAULT NULL,
  `IO` varchar(1024) DEFAULT NULL,
  `ONLINE_TIME` varchar(50) DEFAULT NULL,
  `LOADAVG` varchar(50) DEFAULT NULL,
  `CREATE_DATE` datetime DEFAULT NULL,
  `net_width` varchar(255) DEFAULT '0' COMMENT '网络带宽',
  `hostname` varchar(255) DEFAULT NULL COMMENT '主机名',
  PRIMARY KEY (`ID`),
  KEY `ASSETID` (`ASSETID`),
  CONSTRAINT `t_dynamic_pc_info_ibfk_1` FOREIGN KEY (`ASSETID`) REFERENCES `t_static_pc_info` (`ASSETID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
--  Table structure for `t_pc_deployment`
DROP TABLE IF EXISTS `t_pc_deployment`;
CREATE TABLE `t_pc_deployment` (
  `ID` varchar(50) NOT NULL,
  `IP` varchar(50) DEFAULT NULL,
  `DEPLOYMENT` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Date:2017-08-02 增加启动谷歌抓取网址开关
alter table `job_template` add column `chrome_flag` tinyint(1) default 0;
-- Date: 2017/08/03 17:30  解决url过长导致无法入库的报错问题
ALTER TABLE `url_list_status`
MODIFY COLUMN `url`  varchar(1024) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL AFTER `id`,
MODIFY COLUMN `parentUrl`  varchar(1024) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL AFTER `url`,
MODIFY COLUMN `desc`  varchar(2048) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '注释' AFTER `status`;

-- 版本号管理 2017/08/07
CREATE TABLE `t_version` (
  `id` varchar(50) NOT NULL,
  `version_code` varchar(255) DEFAULT NULL,
  `description` varchar(1024) DEFAULT NULL,
  `release_note` varchar(1024) DEFAULT NULL,
  `del_flag` tinyint(1) DEFAULT '0',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Date: 2017/08/07 14:30  增加taskJobHistoryId字段，以解决两次爬取同一任务时的url状态冲突问题
ALTER TABLE `url_list_status`
ADD COLUMN `taskJobHistoryId`  varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '任务历史id' AFTER `taskJobId`;

-- Date:2017/08/14
CREATE TABLE `node_monitor` (
`id`  varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL ,
`name`  varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL ,
`node_ip`  varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL ,
`node_status`  tinyint(4) NULL DEFAULT NULL COMMENT '节点状态0：节点异常1：节点正常' ,
PRIMARY KEY (`id`)
)
ENGINE=InnoDB
DEFAULT CHARACTER SET=utf8 COLLATE=utf8_general_ci
ROW_FORMAT=DYNAMIC
;
-- Date:2017-08-25 节点监控动态表里增加状态字段
alter table `t_dynamic_pc_info` add column `STATUS` tinyint(4) default '0';