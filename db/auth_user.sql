/*
 Navicat Premium Data Transfer

 Source Server         : 10.128.100.132
 Source Server Type    : MySQL
 Source Server Version : 50611
 Source Host           : 10.128.100.132
 Source Database       : demo

 Target Server Type    : MySQL
 Target Server Version : 50611
 File Encoding         : utf-8

 Date: 04/19/2017 16:07:16 PM
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
--  Table structure for `auth_user`
-- ----------------------------
DROP TABLE IF EXISTS `auth_user`;
CREATE TABLE `auth_user` (
  `ID` varchar(50) NOT NULL,
  `PASSWORD` varchar(50) NOT NULL,
  `USER_NAME` varchar(20) NOT NULL,
  `Login_Name` varchar(20) NOT NULL,
  `EMAIL` varchar(250) DEFAULT NULL,
  `PHONE` varchar(50) DEFAULT NULL,
  `DEL_FLAG` tinyint(1) NOT NULL,
  `STATUS` smallint(6) NOT NULL,
  `PARENT_ID` varchar(50) NOT NULL,
  `TYPE` smallint(6) NOT NULL,
  `GROUP_ID` varchar(50) NOT NULL,
  `CREATE_TIME` datetime NOT NULL,
  `MODEFY_TIME` datetime NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `auth_user_session`
-- ----------------------------
DROP TABLE IF EXISTS `auth_user_session`;
CREATE TABLE `auth_user_session` (
  `ID` varchar(50) NOT NULL,
  `SESSION_ID` varchar(50) NOT NULL,
  `CREATE_TIME` datetime NOT NULL,
  `EXPIRE_TIME` datetime NOT NULL,
  `USER_ID` varchar(50) NOT NULL,
  `DEL_FLAG` tinyint(1) NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

SET FOREIGN_KEY_CHECKS = 1;
