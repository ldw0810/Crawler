/*
Navicat MySQL Data Transfer

Source Server         : localhost
Source Server Version : 50717
Source Host           : localhost:3306
Source Database       : crawler_tenement

Target Server Type    : MYSQL
Target Server Version : 50717
File Encoding         : 65001

Date: 2017-04-17 16:39:55
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `auth_group`
-- ----------------------------
DROP TABLE IF EXISTS `auth_group`;
CREATE TABLE `auth_group` (
  `ID` varchar(50) NOT NULL,
  `NAME` varchar(250) DEFAULT NULL,
  `DEL_FLAG` tinyint(1) DEFAULT '0',
  `TYPE` tinyint(5) DEFAULT NULL,
  `CODE` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of auth_group
-- ----------------------------
INSERT INTO `auth_group` VALUES ('1', '管理员组', '0', null, null);
INSERT INTO `auth_group` VALUES ('2', '租户组', '0', null, null);
INSERT INTO `auth_group` VALUES ('3', '用户组', '0', null, null);

-- ----------------------------
-- Table structure for `auth_group_re_permission`
-- ----------------------------
DROP TABLE IF EXISTS `auth_group_re_permission`;
CREATE TABLE `auth_group_re_permission` (
  `ID` varchar(50) NOT NULL,
  `DEL_FLAG` tinyint(1) NOT NULL DEFAULT '0',
  `GROUP_ID` varchar(50) NOT NULL,
  `PERMISSION_ID` varchar(50) NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of auth_group_re_permission
-- ----------------------------
INSERT INTO `auth_group_re_permission` VALUES ('1', '0', '1', '1');
INSERT INTO `auth_group_re_permission` VALUES ('2', '0', '2', '1');

-- ----------------------------
-- Table structure for `auth_permission`
-- ----------------------------
DROP TABLE IF EXISTS `auth_permission`;
CREATE TABLE `auth_permission` (
  `ID` varchar(50) NOT NULL,
  `NAME` varchar(50) DEFAULT NULL,
  `CODE` varchar(10) DEFAULT NULL,
  `CONTENT` varchar(1000) DEFAULT NULL,
  `DEL_FLAG` tinyint(4) NOT NULL DEFAULT '0',
  `TYPE` tinyint(5) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of auth_permission
-- ----------------------------
INSERT INTO `auth_permission` VALUES ('1', '查询', null, '“/user/query”', '0', '0');

-- ----------------------------
-- Table structure for `auth_user`
-- ----------------------------
DROP TABLE IF EXISTS `auth_user`;
CREATE TABLE `auth_user` (
  `ID` varchar(50) NOT NULL,
  `PASSWORD` varchar(50) NOT NULL,
  `USER_NAME` varchar(20) NOT NULL,
  `LOGIN_NAME` varchar(20) NOT NULL,
  `EMAIL` varchar(250) DEFAULT NULL,
  `PHONE` varchar(20) DEFAULT NULL,
  `DEL_FLAG` tinyint(5) NOT NULL,
  `STATUS` tinyint(5) NOT NULL,
  `DESC` varchar(250) DEFAULT NULL,
  `PARENT_ID` varchar(50) NOT NULL,
  `TYPE` tinyint(5) NOT NULL,
  `GROUP_ID` varchar(50) NOT NULL,
  `CREATE_TIME` datetime NOT NULL,
  `IS_PAY` tinyint(5) DEFAULT NULL,
  `MODEFY_TIME` datetime NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of auth_user
-- ----------------------------
INSERT INTO `auth_user` VALUES ('009af3f020f911e786f600232490c701', '999999', 'dinzhigang', 'dinzhigang', 'dinzhigang@163.com', '15082862770', '0', '0', null, '-1', '1', '-1', '2017-04-14 17:59:08', null, '2017-04-14 17:59:08');
INSERT INTO `auth_user` VALUES ('01022a00202411e7b58d00232490c701', '222222', '赵能', 'zhaoneng', 'zhaoneng@163.com', '13630225743', '0', '0', null, '-1', '1', '-1', '2017-04-13 16:34:26', null, '2017-04-13 16:34:26');
INSERT INTO `auth_user` VALUES ('120b00b01e9911e7b0b400232490c701', '123', 'xiaoming', 'xiaoming', null, null, '0', '0', null, '-1', '1', '1', '2017-04-11 17:27:23', null, '2017-04-11 17:27:23');
INSERT INTO `auth_user` VALUES ('1249b1f01f4a11e7bb1c00232490c701', '654321', '小红', '小红', null, null, '0', '0', null, '-1', '1', '1', '2017-04-12 14:34:25', null, '2017-04-12 14:34:25');
INSERT INTO `auth_user` VALUES ('2a4e998f203111e797fd00232490c701', '222222', '赵能', 'zhaoneng', 'zhaoneng@163.com', '13630225743', '0', '0', null, '-1', '1', '-1', '2017-04-13 18:08:39', null, '2017-04-13 18:08:39');
INSERT INTO `auth_user` VALUES ('2b2cc9e11e9711e79de600232490c701', '123', 'lisi', 'lisi', null, null, '0', '0', null, '-1', '0', '1', '2017-04-11 17:13:47', null, '2017-04-11 17:13:47');
INSERT INTO `auth_user` VALUES ('45c7daae1e9711e7a5a400232490c701', '123', 'wangwu', 'wangwu', null, null, '0', '0', null, '-1', '0', '1', '2017-04-11 17:14:31', null, '2017-04-11 17:14:31');
INSERT INTO `auth_user` VALUES ('65fff25e20ed11e7934400232490c701', '222222', '赵能2', 'zhaoneng', 'zhaoneng@163.com', '13630225743', '0', '0', null, '-1', '1', '-1', '2017-04-14 16:36:04', null, '2017-04-14 16:36:04');
INSERT INTO `auth_user` VALUES ('713f95e120ed11e7b0fa00232490c701', '222222', '赵能2', 'zhaoneng', 'zhaoneng@163.com', '13630225743', '0', '0', null, '-1', '1', '-1', '2017-04-14 16:36:23', null, '2017-04-14 16:36:23');
INSERT INTO `auth_user` VALUES ('770c9eb020d811e7961f00232490c701', '222222', '赵能1', 'zhaoneng1', 'zhaoneng1@163.com', '13630225743', '0', '0', null, '-1', '1', '-1', '2017-04-14 14:06:14', null, '2017-04-14 14:06:14');
INSERT INTO `auth_user` VALUES ('8850bc9e20ed11e79ced00232490c701', '222222', '赵能2', 'zhaoneng', 'zhaoneng@163.com', '13630225743', '0', '0', null, '-1', '1', '-1', '2017-04-14 16:37:02', null, '2017-04-14 16:37:02');
INSERT INTO `auth_user` VALUES ('91fb684020ed11e7be4e00232490c701', '222222', '赵能2', 'zhaoneng', 'zhaoneng@163.com', '13630225743', '0', '0', null, '-1', '1', '-1', '2017-04-14 16:37:18', null, '2017-04-14 16:37:18');
INSERT INTO `auth_user` VALUES ('9a46f90f20ed11e78b6700232490c701', '222222', '赵能2', 'zhaoneng', 'zhaoneng@163.com', '13630225743', '0', '0', null, '-1', '1', '-1', '2017-04-14 16:37:32', null, '2017-04-14 16:37:32');
INSERT INTO `auth_user` VALUES ('9f4d92b020da11e7ad1e00232490c701', '123456', 'bikaqiu', 'bikaqiu', 'dahong@163.com', '15082862770', '0', '0', null, '-1', '1', '-1', '2017-04-14 14:21:40', null, '2017-04-14 15:01:48');
INSERT INTO `auth_user` VALUES ('a48297f0201a11e7bab300232490c701', '222222', 'hadoop', 'hadoop', 'email', '15082862770', '0', '0', null, '-1', '1', '-1', '2017-04-13 15:27:25', null, '2017-04-13 15:27:25');
INSERT INTO `auth_user` VALUES ('f0980240201711e7ae1000232490c701', '654321', '小刚', '小刚', null, null, '0', '0', null, '-1', '1', '1,2', '2017-04-13 15:08:05', null, '2017-04-13 15:08:05');
INSERT INTO `auth_user` VALUES ('fd6127e11e9611e7873800232490c701', '123456', 'shshshshhs', 'udate', 'zhaoneng1@163.com', '13630225743', '0', '0', null, '-1', '1', '-1', '2017-04-11 17:12:30', null, '2017-04-14 17:33:21');
