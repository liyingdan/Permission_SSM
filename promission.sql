/*
Navicat MySQL Data Transfer

Source Server         : Janet
Source Server Version : 50720
Source Host           : localhost:3306
Source Database       : promission

Target Server Type    : MYSQL
Target Server Version : 50720
File Encoding         : 65001

Date: 2019-04-26 18:59:11
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for department
-- ----------------------------
DROP TABLE IF EXISTS `department`;
CREATE TABLE `department` (
  `id` bigint(20) NOT NULL,
  `name` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of department
-- ----------------------------
INSERT INTO `department` VALUES ('1', '实践部');
INSERT INTO `department` VALUES ('2', '财务部');
INSERT INTO `department` VALUES ('3', '技术部');

-- ----------------------------
-- Table structure for employee
-- ----------------------------
DROP TABLE IF EXISTS `employee`;
CREATE TABLE `employee` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `username` varchar(50) DEFAULT NULL,
  `password` varchar(50) DEFAULT NULL,
  `inputtime` datetime DEFAULT NULL,
  `tel` varchar(20) DEFAULT NULL,
  `email` varchar(50) DEFAULT NULL,
  `state` tinyint(1) DEFAULT NULL,
  `admin` tinyint(1) DEFAULT NULL,
  `dep_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `dep_id` (`dep_id`),
  CONSTRAINT `employee_ibfk_1` FOREIGN KEY (`dep_id`) REFERENCES `department` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of employee
-- ----------------------------
INSERT INTO `employee` VALUES ('20', '齐衡', '13b9eb1123b900802e83d1c85a32605c', null, '', '', '1', '1', '3');
INSERT INTO `employee` VALUES ('21', '李应丹', '97e81c14ff8176bc1a7fc188817a0dd6', '2019-01-11 00:04:00', '15555555555555', 'lyd1511777@163.com', '1', '0', '2');
INSERT INTO `employee` VALUES ('22', '毛园', '5bb9db3fff332222de189a24619911a1', '2019-01-06 00:04:00', '12222222222', 'lisi@163.com', '1', '0', '2');
INSERT INTO `employee` VALUES ('23', '李自瑶', 'ba8aa46b4ed1308da6cc4c064834ab89', '2019-01-03 00:04:00', '15555555555555', 'lyd1511777@163.com', '1', '0', '2');

-- ----------------------------
-- Table structure for employee_role_rel
-- ----------------------------
DROP TABLE IF EXISTS `employee_role_rel`;
CREATE TABLE `employee_role_rel` (
  `eid` bigint(20) NOT NULL,
  `rid` bigint(20) NOT NULL,
  PRIMARY KEY (`eid`,`rid`),
  KEY `rid` (`rid`),
  CONSTRAINT `employee_role_rel_ibfk_1` FOREIGN KEY (`eid`) REFERENCES `employee` (`id`),
  CONSTRAINT `employee_role_rel_ibfk_2` FOREIGN KEY (`rid`) REFERENCES `role` (`rid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of employee_role_rel
-- ----------------------------
INSERT INTO `employee_role_rel` VALUES ('21', '1');
INSERT INTO `employee_role_rel` VALUES ('22', '2');
INSERT INTO `employee_role_rel` VALUES ('20', '3');
INSERT INTO `employee_role_rel` VALUES ('23', '3');

-- ----------------------------
-- Table structure for menu
-- ----------------------------
DROP TABLE IF EXISTS `menu`;
CREATE TABLE `menu` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `text` varchar(10) DEFAULT NULL,
  `url` varchar(30) DEFAULT NULL,
  `parent_id` bigint(20) DEFAULT NULL,
  `permission_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `parent_id` (`parent_id`),
  KEY `permission_id` (`permission_id`),
  CONSTRAINT `menu_ibfk_1` FOREIGN KEY (`parent_id`) REFERENCES `menu` (`id`),
  CONSTRAINT `menu_ibfk_2` FOREIGN KEY (`permission_id`) REFERENCES `permission` (`pid`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of menu
-- ----------------------------
INSERT INTO `menu` VALUES ('1', '系统管理', null, null, null);
INSERT INTO `menu` VALUES ('2', '员工管理', '/employee', '1', '4');
INSERT INTO `menu` VALUES ('3', '角色权限管理', '/role', '1', '5');
INSERT INTO `menu` VALUES ('4', '菜单管理', '/menu', '1', '6');
INSERT INTO `menu` VALUES ('9', 'ggg', 'm', '1', null);

-- ----------------------------
-- Table structure for permission
-- ----------------------------
DROP TABLE IF EXISTS `permission`;
CREATE TABLE `permission` (
  `pid` bigint(20) NOT NULL AUTO_INCREMENT,
  `pname` varchar(50) DEFAULT NULL,
  `presource` varchar(50) NOT NULL,
  PRIMARY KEY (`pid`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of permission
-- ----------------------------
INSERT INTO `permission` VALUES ('1', '员工添加', 'employee:add');
INSERT INTO `permission` VALUES ('2', '员工删除', 'employee:delete');
INSERT INTO `permission` VALUES ('3', '员工编辑', 'employee:edit');
INSERT INTO `permission` VALUES ('4', '员工主页', 'employee:index');
INSERT INTO `permission` VALUES ('5', '角色权限主页', 'role:index');
INSERT INTO `permission` VALUES ('6', '菜单主页', 'menu:index');

-- ----------------------------
-- Table structure for role
-- ----------------------------
DROP TABLE IF EXISTS `role`;
CREATE TABLE `role` (
  `rid` bigint(20) NOT NULL AUTO_INCREMENT,
  `rnum` varchar(50) DEFAULT NULL,
  `rname` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`rid`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of role
-- ----------------------------
INSERT INTO `role` VALUES ('1', 'ceo', '总裁');
INSERT INTO `role` VALUES ('2', 'hr', '人事');
INSERT INTO `role` VALUES ('3', 'manager', '经理');
INSERT INTO `role` VALUES ('4', 'employee', '员工');
INSERT INTO `role` VALUES ('8', 'manager', '');

-- ----------------------------
-- Table structure for role_permission_rel
-- ----------------------------
DROP TABLE IF EXISTS `role_permission_rel`;
CREATE TABLE `role_permission_rel` (
  `rid` bigint(20) NOT NULL,
  `pid` bigint(20) NOT NULL,
  PRIMARY KEY (`rid`,`pid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of role_permission_rel
-- ----------------------------
INSERT INTO `role_permission_rel` VALUES ('1', '1');
INSERT INTO `role_permission_rel` VALUES ('1', '2');
INSERT INTO `role_permission_rel` VALUES ('1', '3');
INSERT INTO `role_permission_rel` VALUES ('1', '4');
INSERT INTO `role_permission_rel` VALUES ('1', '5');
INSERT INTO `role_permission_rel` VALUES ('1', '6');
INSERT INTO `role_permission_rel` VALUES ('2', '4');
INSERT INTO `role_permission_rel` VALUES ('3', '4');
INSERT INTO `role_permission_rel` VALUES ('3', '5');
INSERT INTO `role_permission_rel` VALUES ('4', '4');
INSERT INTO `role_permission_rel` VALUES ('5', '5');

-- ----------------------------
-- Table structure for systemlog
-- ----------------------------
DROP TABLE IF EXISTS `systemlog`;
CREATE TABLE `systemlog` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `optime` datetime DEFAULT NULL,
  `ip` varchar(20) DEFAULT NULL,
  `function` varchar(255) DEFAULT NULL,
  `params` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=184 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of systemlog
-- ----------------------------
INSERT INTO `systemlog` VALUES ('1', '2019-04-21 20:43:00', null, 'com.lyd.service.impl.EmployeeServiceImpl:getEmployeeWithUsername', '[\"李应丹\"]');
INSERT INTO `systemlog` VALUES ('2', '2019-04-21 20:43:01', '0:0:0:0:0:0:0:1', 'com.lyd.service.impl.EmployeeServiceImpl:getRolesById', '[21]');
INSERT INTO `systemlog` VALUES ('3', '2019-04-21 20:43:01', '0:0:0:0:0:0:0:1', 'com.lyd.service.impl.EmployeeServiceImpl:getPermissionbyId', '[21]');
INSERT INTO `systemlog` VALUES ('4', '2019-04-21 20:43:01', '0:0:0:0:0:0:0:1', 'com.lyd.service.impl.MenuServiceImpl:getTreeData', '[]');
INSERT INTO `systemlog` VALUES ('5', '2019-04-21 20:43:02', '0:0:0:0:0:0:0:1', 'com.lyd.service.impl.DepartmentServiceImpl:getDepartmentList', '[]');
INSERT INTO `systemlog` VALUES ('6', '2019-04-21 20:43:02', '0:0:0:0:0:0:0:1', 'com.lyd.service.impl.RoleServiceImpl:getAllList', '[]');
INSERT INTO `systemlog` VALUES ('7', '2019-04-21 20:43:03', '0:0:0:0:0:0:0:1', 'com.lyd.service.impl.EmployeeServiceImpl:getEmployee', '[{\"page\":1,\"rows\":10,\"keyword\":null}]');
INSERT INTO `systemlog` VALUES ('8', '2019-04-21 20:57:13', '0:0:0:0:0:0:0:1', 'com.lyd.service.impl.EmployeeServiceImpl:getRolesById', '[21]');
INSERT INTO `systemlog` VALUES ('9', '2019-04-21 20:57:13', '0:0:0:0:0:0:0:1', 'com.lyd.service.impl.EmployeeServiceImpl:getPermissionbyId', '[21]');
INSERT INTO `systemlog` VALUES ('10', '2019-04-21 20:57:13', '0:0:0:0:0:0:0:1', 'com.lyd.service.impl.MenuServiceImpl:getTreeData', '[]');
INSERT INTO `systemlog` VALUES ('11', '2019-04-21 20:57:15', '0:0:0:0:0:0:0:1', 'com.lyd.service.impl.EmployeeServiceImpl:getEmployee', '[{\"page\":1,\"rows\":10,\"keyword\":null}]');
INSERT INTO `systemlog` VALUES ('12', '2019-04-21 20:57:15', '0:0:0:0:0:0:0:1', 'com.lyd.service.impl.DepartmentServiceImpl:getDepartmentList', '[]');
INSERT INTO `systemlog` VALUES ('13', '2019-04-21 20:57:16', '0:0:0:0:0:0:0:1', 'com.lyd.service.impl.RoleServiceImpl:getAllList', '[]');
INSERT INTO `systemlog` VALUES ('14', '2019-04-21 21:01:59', '0:0:0:0:0:0:0:1', 'com.lyd.service.impl.EmployeeServiceImpl:getRolesById', '[21]');
INSERT INTO `systemlog` VALUES ('15', '2019-04-21 21:01:59', '0:0:0:0:0:0:0:1', 'com.lyd.service.impl.EmployeeServiceImpl:getPermissionbyId', '[21]');
INSERT INTO `systemlog` VALUES ('16', '2019-04-21 21:01:59', '0:0:0:0:0:0:0:1', 'com.lyd.service.impl.MenuServiceImpl:getTreeData', '[]');
INSERT INTO `systemlog` VALUES ('17', '2019-04-21 21:01:59', '0:0:0:0:0:0:0:1', 'com.lyd.service.impl.EmployeeServiceImpl:getEmployee', '[{\"page\":1,\"rows\":10,\"keyword\":null}]');
INSERT INTO `systemlog` VALUES ('18', '2019-04-21 21:01:59', '0:0:0:0:0:0:0:1', 'com.lyd.service.impl.DepartmentServiceImpl:getDepartmentList', '[]');
INSERT INTO `systemlog` VALUES ('19', '2019-04-21 21:01:59', '0:0:0:0:0:0:0:1', 'com.lyd.service.impl.RoleServiceImpl:getAllList', '[]');
INSERT INTO `systemlog` VALUES ('20', '2019-04-21 21:02:38', null, 'com.lyd.service.impl.EmployeeServiceImpl:getEmployeeWithUsername', '[\"李应丹\"]');
INSERT INTO `systemlog` VALUES ('21', '2019-04-21 21:02:38', '0:0:0:0:0:0:0:1', 'com.lyd.service.impl.EmployeeServiceImpl:getRolesById', '[21]');
INSERT INTO `systemlog` VALUES ('22', '2019-04-21 21:02:38', '0:0:0:0:0:0:0:1', 'com.lyd.service.impl.EmployeeServiceImpl:getPermissionbyId', '[21]');
INSERT INTO `systemlog` VALUES ('23', '2019-04-21 21:02:38', '0:0:0:0:0:0:0:1', 'com.lyd.service.impl.MenuServiceImpl:getTreeData', '[]');
INSERT INTO `systemlog` VALUES ('24', '2019-04-21 21:02:39', '0:0:0:0:0:0:0:1', 'com.lyd.service.impl.EmployeeServiceImpl:getEmployee', '[{\"page\":1,\"rows\":10,\"keyword\":null}]');
INSERT INTO `systemlog` VALUES ('25', '2019-04-21 21:02:39', '0:0:0:0:0:0:0:1', 'com.lyd.service.impl.DepartmentServiceImpl:getDepartmentList', '[]');
INSERT INTO `systemlog` VALUES ('26', '2019-04-21 21:02:39', '0:0:0:0:0:0:0:1', 'com.lyd.service.impl.RoleServiceImpl:getAllList', '[]');
INSERT INTO `systemlog` VALUES ('27', '2019-04-21 21:03:36', '0:0:0:0:0:0:0:1', 'com.lyd.service.impl.MenuServiceImpl:getTreeData', '[]');
INSERT INTO `systemlog` VALUES ('28', '2019-04-21 21:03:36', '0:0:0:0:0:0:0:1', 'com.lyd.service.impl.EmployeeServiceImpl:getEmployee', '[{\"page\":1,\"rows\":10,\"keyword\":null}]');
INSERT INTO `systemlog` VALUES ('29', '2019-04-21 21:03:36', '0:0:0:0:0:0:0:1', 'com.lyd.service.impl.DepartmentServiceImpl:getDepartmentList', '[]');
INSERT INTO `systemlog` VALUES ('30', '2019-04-21 21:03:36', '0:0:0:0:0:0:0:1', 'com.lyd.service.impl.RoleServiceImpl:getAllList', '[]');
INSERT INTO `systemlog` VALUES ('31', '2019-04-21 21:11:38', '0:0:0:0:0:0:0:1', 'com.lyd.service.impl.EmployeeServiceImpl:getRolesById', '[21]');
INSERT INTO `systemlog` VALUES ('32', '2019-04-21 21:11:38', '0:0:0:0:0:0:0:1', 'com.lyd.service.impl.EmployeeServiceImpl:getPermissionbyId', '[21]');
INSERT INTO `systemlog` VALUES ('33', '2019-04-21 21:11:38', '0:0:0:0:0:0:0:1', 'com.lyd.service.impl.MenuServiceImpl:getTreeData', '[]');
INSERT INTO `systemlog` VALUES ('34', '2019-04-21 21:11:38', '0:0:0:0:0:0:0:1', 'com.lyd.service.impl.EmployeeServiceImpl:getEmployee', '[{\"page\":1,\"rows\":10,\"keyword\":null}]');
INSERT INTO `systemlog` VALUES ('35', '2019-04-21 21:11:38', '0:0:0:0:0:0:0:1', 'com.lyd.service.impl.DepartmentServiceImpl:getDepartmentList', '[]');
INSERT INTO `systemlog` VALUES ('36', '2019-04-21 21:11:38', '0:0:0:0:0:0:0:1', 'com.lyd.service.impl.RoleServiceImpl:getAllList', '[]');
INSERT INTO `systemlog` VALUES ('37', '2019-04-21 21:13:06', '0:0:0:0:0:0:0:1', 'com.lyd.service.impl.MenuServiceImpl:getTreeData', '[]');
INSERT INTO `systemlog` VALUES ('38', '2019-04-21 21:13:07', '0:0:0:0:0:0:0:1', 'com.lyd.service.impl.EmployeeServiceImpl:getEmployee', '[{\"page\":1,\"rows\":10,\"keyword\":null}]');
INSERT INTO `systemlog` VALUES ('39', '2019-04-21 21:13:07', '0:0:0:0:0:0:0:1', 'com.lyd.service.impl.DepartmentServiceImpl:getDepartmentList', '[]');
INSERT INTO `systemlog` VALUES ('40', '2019-04-21 21:13:07', '0:0:0:0:0:0:0:1', 'com.lyd.service.impl.RoleServiceImpl:getAllList', '[]');
INSERT INTO `systemlog` VALUES ('41', '2019-04-21 21:45:15', null, 'com.lyd.service.impl.EmployeeServiceImpl:getEmployeeWithUsername', '[\"李应丹\"]');
INSERT INTO `systemlog` VALUES ('42', '2019-04-21 21:45:16', '0:0:0:0:0:0:0:1', 'com.lyd.service.impl.EmployeeServiceImpl:getRolesById', '[21]');
INSERT INTO `systemlog` VALUES ('43', '2019-04-21 21:45:16', '0:0:0:0:0:0:0:1', 'com.lyd.service.impl.EmployeeServiceImpl:getPermissionbyId', '[21]');
INSERT INTO `systemlog` VALUES ('44', '2019-04-21 21:45:16', '0:0:0:0:0:0:0:1', 'com.lyd.service.impl.MenuServiceImpl:getTreeData', '[]');
INSERT INTO `systemlog` VALUES ('45', '2019-04-21 21:45:17', '0:0:0:0:0:0:0:1', 'com.lyd.service.impl.DepartmentServiceImpl:getDepartmentList', '[]');
INSERT INTO `systemlog` VALUES ('46', '2019-04-21 21:45:17', '0:0:0:0:0:0:0:1', 'com.lyd.service.impl.RoleServiceImpl:getAllList', '[]');
INSERT INTO `systemlog` VALUES ('47', '2019-04-21 21:45:18', '0:0:0:0:0:0:0:1', 'com.lyd.service.impl.EmployeeServiceImpl:getEmployee', '[{\"page\":1,\"rows\":10,\"keyword\":null}]');
INSERT INTO `systemlog` VALUES ('48', '2019-04-21 21:46:21', '0:0:0:0:0:0:0:1', 'com.lyd.service.impl.EmployeeServiceImpl:getAllEmployee', '[]');
INSERT INTO `systemlog` VALUES ('49', '2019-04-21 22:16:17', null, 'com.lyd.service.impl.EmployeeServiceImpl:getEmployeeWithUsername', '[\"李应丹\"]');
INSERT INTO `systemlog` VALUES ('50', '2019-04-21 22:16:18', '0:0:0:0:0:0:0:1', 'com.lyd.service.impl.EmployeeServiceImpl:getRolesById', '[21]');
INSERT INTO `systemlog` VALUES ('51', '2019-04-21 22:16:18', '0:0:0:0:0:0:0:1', 'com.lyd.service.impl.EmployeeServiceImpl:getPermissionbyId', '[21]');
INSERT INTO `systemlog` VALUES ('52', '2019-04-21 22:16:18', '0:0:0:0:0:0:0:1', 'com.lyd.service.impl.MenuServiceImpl:getTreeData', '[]');
INSERT INTO `systemlog` VALUES ('53', '2019-04-21 22:16:19', '0:0:0:0:0:0:0:1', 'com.lyd.service.impl.DepartmentServiceImpl:getDepartmentList', '[]');
INSERT INTO `systemlog` VALUES ('54', '2019-04-21 22:16:19', '0:0:0:0:0:0:0:1', 'com.lyd.service.impl.RoleServiceImpl:getAllList', '[]');
INSERT INTO `systemlog` VALUES ('55', '2019-04-21 22:16:19', '0:0:0:0:0:0:0:1', 'com.lyd.service.impl.EmployeeServiceImpl:getEmployee', '[{\"page\":1,\"rows\":10,\"keyword\":null}]');
INSERT INTO `systemlog` VALUES ('56', '2019-04-21 22:16:22', '0:0:0:0:0:0:0:1', 'com.lyd.service.impl.EmployeeServiceImpl:getAllEmployee', '[]');
INSERT INTO `systemlog` VALUES ('57', '2019-04-21 22:44:22', '0:0:0:0:0:0:0:1', 'com.lyd.service.impl.EmployeeServiceImpl:getRolesById', '[21]');
INSERT INTO `systemlog` VALUES ('58', '2019-04-21 22:44:22', '0:0:0:0:0:0:0:1', 'com.lyd.service.impl.EmployeeServiceImpl:getPermissionbyId', '[21]');
INSERT INTO `systemlog` VALUES ('59', '2019-04-21 22:44:22', '0:0:0:0:0:0:0:1', 'com.lyd.service.impl.MenuServiceImpl:getTreeData', '[]');
INSERT INTO `systemlog` VALUES ('60', '2019-04-21 22:44:23', '0:0:0:0:0:0:0:1', 'com.lyd.service.impl.EmployeeServiceImpl:getEmployee', '[{\"page\":1,\"rows\":10,\"keyword\":null}]');
INSERT INTO `systemlog` VALUES ('61', '2019-04-21 22:44:23', '0:0:0:0:0:0:0:1', 'com.lyd.service.impl.DepartmentServiceImpl:getDepartmentList', '[]');
INSERT INTO `systemlog` VALUES ('62', '2019-04-21 22:44:23', '0:0:0:0:0:0:0:1', 'com.lyd.service.impl.RoleServiceImpl:getAllList', '[]');
INSERT INTO `systemlog` VALUES ('63', '2019-04-21 23:07:41', null, 'com.lyd.service.impl.EmployeeServiceImpl:getEmployeeWithUsername', '[\"李应丹\"]');
INSERT INTO `systemlog` VALUES ('64', '2019-04-21 23:07:43', '0:0:0:0:0:0:0:1', 'com.lyd.service.impl.EmployeeServiceImpl:getRolesById', '[21]');
INSERT INTO `systemlog` VALUES ('65', '2019-04-21 23:07:43', '0:0:0:0:0:0:0:1', 'com.lyd.service.impl.EmployeeServiceImpl:getPermissionbyId', '[21]');
INSERT INTO `systemlog` VALUES ('66', '2019-04-21 23:07:44', '0:0:0:0:0:0:0:1', 'com.lyd.service.impl.MenuServiceImpl:getTreeData', '[]');
INSERT INTO `systemlog` VALUES ('67', '2019-04-21 23:07:44', '0:0:0:0:0:0:0:1', 'com.lyd.service.impl.DepartmentServiceImpl:getDepartmentList', '[]');
INSERT INTO `systemlog` VALUES ('68', '2019-04-21 23:07:44', '0:0:0:0:0:0:0:1', 'com.lyd.service.impl.RoleServiceImpl:getAllList', '[]');
INSERT INTO `systemlog` VALUES ('69', '2019-04-21 23:07:45', '0:0:0:0:0:0:0:1', 'com.lyd.service.impl.EmployeeServiceImpl:getEmployee', '[{\"page\":1,\"rows\":10,\"keyword\":null}]');
INSERT INTO `systemlog` VALUES ('70', '2019-04-22 09:21:20', '0:0:0:0:0:0:0:1', 'com.lyd.service.impl.EmployeeServiceImpl:getEmployeeWithUsername', '[\"李应丹\"]');
INSERT INTO `systemlog` VALUES ('71', '2019-04-22 09:21:21', '0:0:0:0:0:0:0:1', 'com.lyd.service.impl.EmployeeServiceImpl:getRolesById', '[21]');
INSERT INTO `systemlog` VALUES ('72', '2019-04-22 09:21:21', '0:0:0:0:0:0:0:1', 'com.lyd.service.impl.EmployeeServiceImpl:getPermissionbyId', '[21]');
INSERT INTO `systemlog` VALUES ('73', '2019-04-22 09:21:21', '0:0:0:0:0:0:0:1', 'com.lyd.service.impl.MenuServiceImpl:getTreeData', '[]');
INSERT INTO `systemlog` VALUES ('74', '2019-04-22 09:21:22', '0:0:0:0:0:0:0:1', 'com.lyd.service.impl.DepartmentServiceImpl:getDepartmentList', '[]');
INSERT INTO `systemlog` VALUES ('75', '2019-04-22 09:21:22', '0:0:0:0:0:0:0:1', 'com.lyd.service.impl.RoleServiceImpl:getAllList', '[]');
INSERT INTO `systemlog` VALUES ('76', '2019-04-22 09:21:22', '0:0:0:0:0:0:0:1', 'com.lyd.service.impl.EmployeeServiceImpl:getEmployee', '[{\"page\":1,\"rows\":10,\"keyword\":null}]');
INSERT INTO `systemlog` VALUES ('77', '2019-04-22 09:22:42', '0:0:0:0:0:0:0:1', 'com.lyd.service.impl.MenuServiceImpl:getTreeData', '[]');
INSERT INTO `systemlog` VALUES ('78', '2019-04-22 09:22:42', '0:0:0:0:0:0:0:1', 'com.lyd.service.impl.EmployeeServiceImpl:getEmployee', '[{\"page\":1,\"rows\":10,\"keyword\":null}]');
INSERT INTO `systemlog` VALUES ('79', '2019-04-22 09:22:42', '0:0:0:0:0:0:0:1', 'com.lyd.service.impl.DepartmentServiceImpl:getDepartmentList', '[]');
INSERT INTO `systemlog` VALUES ('80', '2019-04-22 09:22:42', '0:0:0:0:0:0:0:1', 'com.lyd.service.impl.RoleServiceImpl:getAllList', '[]');
INSERT INTO `systemlog` VALUES ('81', '2019-04-22 09:23:37', '0:0:0:0:0:0:0:1', 'com.lyd.service.impl.EmployeeServiceImpl:getEmployee', '[{\"page\":1,\"rows\":10,\"keyword\":null}]');
INSERT INTO `systemlog` VALUES ('82', '2019-04-22 14:21:44', '0:0:0:0:0:0:0:1', 'com.lyd.service.impl.EmployeeServiceImpl:getEmployeeWithUsername', '[\"李应丹\"]');
INSERT INTO `systemlog` VALUES ('83', '2019-04-22 14:21:46', '0:0:0:0:0:0:0:1', 'com.lyd.service.impl.EmployeeServiceImpl:getRolesById', '[21]');
INSERT INTO `systemlog` VALUES ('84', '2019-04-22 14:21:46', '0:0:0:0:0:0:0:1', 'com.lyd.service.impl.EmployeeServiceImpl:getPermissionbyId', '[21]');
INSERT INTO `systemlog` VALUES ('85', '2019-04-22 14:21:46', '0:0:0:0:0:0:0:1', 'com.lyd.service.impl.MenuServiceImpl:getTreeData', '[]');
INSERT INTO `systemlog` VALUES ('86', '2019-04-22 14:21:47', '0:0:0:0:0:0:0:1', 'com.lyd.service.impl.DepartmentServiceImpl:getDepartmentList', '[]');
INSERT INTO `systemlog` VALUES ('87', '2019-04-22 14:21:47', '0:0:0:0:0:0:0:1', 'com.lyd.service.impl.RoleServiceImpl:getAllList', '[]');
INSERT INTO `systemlog` VALUES ('88', '2019-04-22 14:21:47', '0:0:0:0:0:0:0:1', 'com.lyd.service.impl.EmployeeServiceImpl:getEmployee', '[{\"page\":1,\"rows\":10,\"keyword\":null}]');
INSERT INTO `systemlog` VALUES ('89', '2019-04-22 14:22:35', '0:0:0:0:0:0:0:1', 'com.lyd.service.impl.MenuServiceImpl:getTreeData', '[]');
INSERT INTO `systemlog` VALUES ('90', '2019-04-22 14:22:35', '0:0:0:0:0:0:0:1', 'com.lyd.service.impl.EmployeeServiceImpl:getEmployee', '[{\"page\":1,\"rows\":10,\"keyword\":null}]');
INSERT INTO `systemlog` VALUES ('91', '2019-04-22 14:22:35', '0:0:0:0:0:0:0:1', 'com.lyd.service.impl.DepartmentServiceImpl:getDepartmentList', '[]');
INSERT INTO `systemlog` VALUES ('92', '2019-04-22 14:22:36', '0:0:0:0:0:0:0:1', 'com.lyd.service.impl.RoleServiceImpl:getAllList', '[]');
INSERT INTO `systemlog` VALUES ('93', '2019-04-22 14:22:50', '0:0:0:0:0:0:0:1', 'com.lyd.service.impl.EmployeeServiceImpl:getEmployee', '[{\"page\":1,\"rows\":10,\"keyword\":null}]');
INSERT INTO `systemlog` VALUES ('94', '2019-04-22 14:33:16', '0:0:0:0:0:0:0:1', 'com.lyd.service.impl.EmployeeServiceImpl:getRolesById', '[21]');
INSERT INTO `systemlog` VALUES ('95', '2019-04-22 14:33:16', '0:0:0:0:0:0:0:1', 'com.lyd.service.impl.EmployeeServiceImpl:getPermissionbyId', '[21]');
INSERT INTO `systemlog` VALUES ('96', '2019-04-22 14:33:16', '0:0:0:0:0:0:0:1', 'com.lyd.service.impl.MenuServiceImpl:getTreeData', '[]');
INSERT INTO `systemlog` VALUES ('97', '2019-04-22 14:33:16', '0:0:0:0:0:0:0:1', 'com.lyd.service.impl.EmployeeServiceImpl:getEmployee', '[{\"page\":1,\"rows\":10,\"keyword\":null}]');
INSERT INTO `systemlog` VALUES ('98', '2019-04-22 14:33:16', '0:0:0:0:0:0:0:1', 'com.lyd.service.impl.DepartmentServiceImpl:getDepartmentList', '[]');
INSERT INTO `systemlog` VALUES ('99', '2019-04-22 14:33:16', '0:0:0:0:0:0:0:1', 'com.lyd.service.impl.RoleServiceImpl:getAllList', '[]');
INSERT INTO `systemlog` VALUES ('100', '2019-04-22 14:33:38', '0:0:0:0:0:0:0:1', 'com.lyd.service.impl.MenuServiceImpl:getTreeData', '[]');
INSERT INTO `systemlog` VALUES ('101', '2019-04-22 14:33:38', '0:0:0:0:0:0:0:1', 'com.lyd.service.impl.EmployeeServiceImpl:getEmployee', '[{\"page\":1,\"rows\":10,\"keyword\":null}]');
INSERT INTO `systemlog` VALUES ('102', '2019-04-22 14:33:38', '0:0:0:0:0:0:0:1', 'com.lyd.service.impl.DepartmentServiceImpl:getDepartmentList', '[]');
INSERT INTO `systemlog` VALUES ('103', '2019-04-22 14:33:38', '0:0:0:0:0:0:0:1', 'com.lyd.service.impl.RoleServiceImpl:getAllList', '[]');
INSERT INTO `systemlog` VALUES ('104', '2019-04-22 15:00:22', null, 'com.lyd.service.impl.EmployeeServiceImpl:getEmployeeWithUsername', '[\"李应丹\"]');
INSERT INTO `systemlog` VALUES ('105', '2019-04-22 15:00:23', '0:0:0:0:0:0:0:1', 'com.lyd.service.impl.EmployeeServiceImpl:getRolesById', '[21]');
INSERT INTO `systemlog` VALUES ('106', '2019-04-22 15:00:23', '0:0:0:0:0:0:0:1', 'com.lyd.service.impl.EmployeeServiceImpl:getPermissionbyId', '[21]');
INSERT INTO `systemlog` VALUES ('107', '2019-04-22 15:00:23', '0:0:0:0:0:0:0:1', 'com.lyd.service.impl.MenuServiceImpl:getTreeData', '[]');
INSERT INTO `systemlog` VALUES ('108', '2019-04-22 15:00:24', '0:0:0:0:0:0:0:1', 'com.lyd.service.impl.DepartmentServiceImpl:getDepartmentList', '[]');
INSERT INTO `systemlog` VALUES ('109', '2019-04-22 15:00:25', '0:0:0:0:0:0:0:1', 'com.lyd.service.impl.RoleServiceImpl:getAllList', '[]');
INSERT INTO `systemlog` VALUES ('110', '2019-04-22 15:00:26', '0:0:0:0:0:0:0:1', 'com.lyd.service.impl.EmployeeServiceImpl:getEmployee', '[{\"page\":1,\"rows\":10,\"keyword\":null}]');
INSERT INTO `systemlog` VALUES ('111', '2019-04-22 15:00:48', '0:0:0:0:0:0:0:1', 'com.lyd.service.impl.EmployeeServiceImpl:getEmployee', '[{\"page\":1,\"rows\":10,\"keyword\":null}]');
INSERT INTO `systemlog` VALUES ('112', '2019-04-22 16:36:01', null, 'com.lyd.service.impl.EmployeeServiceImpl:getEmployeeWithUsername', '[\"李应丹\"]');
INSERT INTO `systemlog` VALUES ('113', '2019-04-22 16:36:02', '0:0:0:0:0:0:0:1', 'com.lyd.service.impl.EmployeeServiceImpl:getRolesById', '[21]');
INSERT INTO `systemlog` VALUES ('114', '2019-04-22 16:36:02', '0:0:0:0:0:0:0:1', 'com.lyd.service.impl.EmployeeServiceImpl:getPermissionbyId', '[21]');
INSERT INTO `systemlog` VALUES ('115', '2019-04-22 16:36:02', '0:0:0:0:0:0:0:1', 'com.lyd.service.impl.MenuServiceImpl:getTreeData', '[]');
INSERT INTO `systemlog` VALUES ('116', '2019-04-22 16:36:03', '0:0:0:0:0:0:0:1', 'com.lyd.service.impl.DepartmentServiceImpl:getDepartmentList', '[]');
INSERT INTO `systemlog` VALUES ('117', '2019-04-22 16:36:03', '0:0:0:0:0:0:0:1', 'com.lyd.service.impl.RoleServiceImpl:getAllList', '[]');
INSERT INTO `systemlog` VALUES ('118', '2019-04-22 16:36:03', '0:0:0:0:0:0:0:1', 'com.lyd.service.impl.EmployeeServiceImpl:getEmployee', '[{\"page\":1,\"rows\":10,\"keyword\":null}]');
INSERT INTO `systemlog` VALUES ('119', '2019-04-22 16:36:10', '0:0:0:0:0:0:0:1', 'com.lyd.service.impl.EmployeeServiceImpl:getEmployee', '[{\"page\":1,\"rows\":10,\"keyword\":\"李\"}]');
INSERT INTO `systemlog` VALUES ('120', '2019-04-22 16:36:20', '0:0:0:0:0:0:0:1', 'com.lyd.service.impl.EmployeeServiceImpl:getEmployee', '[{\"page\":1,\"rows\":10,\"keyword\":\"15555\"}]');
INSERT INTO `systemlog` VALUES ('121', '2019-04-22 16:36:27', '0:0:0:0:0:0:0:1', 'com.lyd.service.impl.EmployeeServiceImpl:getEmployee', '[{\"page\":1,\"rows\":10,\"keyword\":\"1\"}]');
INSERT INTO `systemlog` VALUES ('122', '2019-04-22 16:36:40', '0:0:0:0:0:0:0:1', 'com.lyd.service.impl.EmployeeServiceImpl:getEmployee', '[{\"page\":1,\"rows\":10,\"keyword\":null}]');
INSERT INTO `systemlog` VALUES ('123', '2019-04-22 16:36:46', '0:0:0:0:0:0:0:1', 'com.lyd.service.impl.RoleServiceImpl:getRoles', '[{\"page\":1,\"rows\":10,\"keyword\":null}]');
INSERT INTO `systemlog` VALUES ('124', '2019-04-22 16:36:46', '0:0:0:0:0:0:0:1', 'com.lyd.service.impl.PermissionServiceImpl:permissionList', '[]');
INSERT INTO `systemlog` VALUES ('125', '2019-04-22 16:36:48', '0:0:0:0:0:0:0:1', 'com.lyd.service.impl.MenuServiceImpl:getMenuList', '[{\"page\":1,\"rows\":10,\"keyword\":null}]');
INSERT INTO `systemlog` VALUES ('126', '2019-04-22 16:36:48', '0:0:0:0:0:0:0:1', 'com.lyd.service.impl.MenuServiceImpl:parentList', '[]');
INSERT INTO `systemlog` VALUES ('127', '2019-04-22 16:37:34', '0:0:0:0:0:0:0:1', 'com.lyd.service.impl.EmployeeServiceImpl:getEmployee', '[{\"page\":1,\"rows\":10,\"keyword\":null}]');
INSERT INTO `systemlog` VALUES ('128', '2019-04-22 17:25:43', null, 'com.lyd.service.impl.EmployeeServiceImpl:getEmployeeWithUsername', '[\"李应丹\"]');
INSERT INTO `systemlog` VALUES ('129', '2019-04-22 17:25:44', '0:0:0:0:0:0:0:1', 'com.lyd.service.impl.EmployeeServiceImpl:getRolesById', '[21]');
INSERT INTO `systemlog` VALUES ('130', '2019-04-22 17:25:44', '0:0:0:0:0:0:0:1', 'com.lyd.service.impl.EmployeeServiceImpl:getPermissionbyId', '[21]');
INSERT INTO `systemlog` VALUES ('131', '2019-04-22 17:25:44', '0:0:0:0:0:0:0:1', 'com.lyd.service.impl.MenuServiceImpl:getTreeData', '[]');
INSERT INTO `systemlog` VALUES ('132', '2019-04-22 17:25:44', '0:0:0:0:0:0:0:1', 'com.lyd.service.impl.EmployeeServiceImpl:getEmployee', '[{\"page\":1,\"rows\":10,\"keyword\":null}]');
INSERT INTO `systemlog` VALUES ('133', '2019-04-22 17:25:44', '0:0:0:0:0:0:0:1', 'com.lyd.service.impl.DepartmentServiceImpl:getDepartmentList', '[]');
INSERT INTO `systemlog` VALUES ('134', '2019-04-22 17:25:44', '0:0:0:0:0:0:0:1', 'com.lyd.service.impl.RoleServiceImpl:getAllList', '[]');
INSERT INTO `systemlog` VALUES ('135', '2019-04-22 17:25:50', '0:0:0:0:0:0:0:1', 'com.lyd.service.impl.MenuServiceImpl:getMenuList', '[{\"page\":1,\"rows\":10,\"keyword\":null}]');
INSERT INTO `systemlog` VALUES ('136', '2019-04-22 17:25:50', '0:0:0:0:0:0:0:1', 'com.lyd.service.impl.MenuServiceImpl:parentList', '[]');
INSERT INTO `systemlog` VALUES ('137', '2019-04-22 17:25:57', '0:0:0:0:0:0:0:1', 'com.lyd.service.impl.MenuServiceImpl:insertMenu', '[{\"id\":null,\"text\":\"m\",\"url\":\"m\",\"parent\":{\"id\":null,\"text\":null,\"url\":null,\"parent\":null,\"permission\":null,\"children\":[]},\"permission\":null,\"children\":[]}]');
INSERT INTO `systemlog` VALUES ('138', '2019-04-22 17:25:57', '0:0:0:0:0:0:0:1', 'com.lyd.service.impl.MenuServiceImpl:parentList', '[]');
INSERT INTO `systemlog` VALUES ('139', '2019-04-22 17:25:57', '0:0:0:0:0:0:0:1', 'com.lyd.service.impl.MenuServiceImpl:getMenuList', '[{\"page\":1,\"rows\":10,\"keyword\":null}]');
INSERT INTO `systemlog` VALUES ('140', '2019-04-22 17:26:02', '0:0:0:0:0:0:0:1', 'com.lyd.service.impl.MenuServiceImpl:getTreeData', '[]');
INSERT INTO `systemlog` VALUES ('141', '2019-04-22 17:26:02', '0:0:0:0:0:0:0:1', 'com.lyd.service.impl.EmployeeServiceImpl:getEmployee', '[{\"page\":1,\"rows\":10,\"keyword\":null}]');
INSERT INTO `systemlog` VALUES ('142', '2019-04-22 17:26:02', '0:0:0:0:0:0:0:1', 'com.lyd.service.impl.DepartmentServiceImpl:getDepartmentList', '[]');
INSERT INTO `systemlog` VALUES ('143', '2019-04-22 17:26:02', '0:0:0:0:0:0:0:1', 'com.lyd.service.impl.RoleServiceImpl:getAllList', '[]');
INSERT INTO `systemlog` VALUES ('144', '2019-04-22 17:26:10', '0:0:0:0:0:0:0:1', 'com.lyd.service.impl.MenuServiceImpl:getMenuList', '[{\"page\":1,\"rows\":10,\"keyword\":null}]');
INSERT INTO `systemlog` VALUES ('145', '2019-04-22 17:26:10', '0:0:0:0:0:0:0:1', 'com.lyd.service.impl.MenuServiceImpl:parentList', '[]');
INSERT INTO `systemlog` VALUES ('146', '2019-04-22 17:26:16', '0:0:0:0:0:0:0:1', 'com.lyd.service.impl.MenuServiceImpl:deleteMenu', '[8]');
INSERT INTO `systemlog` VALUES ('147', '2019-04-22 17:26:16', '0:0:0:0:0:0:0:1', 'com.lyd.service.impl.MenuServiceImpl:parentList', '[]');
INSERT INTO `systemlog` VALUES ('148', '2019-04-22 17:26:16', '0:0:0:0:0:0:0:1', 'com.lyd.service.impl.MenuServiceImpl:getMenuList', '[{\"page\":1,\"rows\":10,\"keyword\":null}]');
INSERT INTO `systemlog` VALUES ('149', '2019-04-22 17:28:48', '0:0:0:0:0:0:0:1', 'com.lyd.service.impl.MenuServiceImpl:insertMenu', '[{\"id\":null,\"text\":\"ggg\",\"url\":\"m\",\"parent\":{\"id\":1,\"text\":null,\"url\":null,\"parent\":null,\"permission\":null,\"children\":[]},\"permission\":null,\"children\":[]}]');
INSERT INTO `systemlog` VALUES ('150', '2019-04-22 17:28:48', '0:0:0:0:0:0:0:1', 'com.lyd.service.impl.MenuServiceImpl:parentList', '[]');
INSERT INTO `systemlog` VALUES ('151', '2019-04-22 17:28:48', '0:0:0:0:0:0:0:1', 'com.lyd.service.impl.MenuServiceImpl:getMenuList', '[{\"page\":1,\"rows\":10,\"keyword\":null}]');
INSERT INTO `systemlog` VALUES ('152', '2019-04-22 17:28:54', '0:0:0:0:0:0:0:1', 'com.lyd.service.impl.EmployeeServiceImpl:getRolesById', '[21]');
INSERT INTO `systemlog` VALUES ('153', '2019-04-22 17:28:54', '0:0:0:0:0:0:0:1', 'com.lyd.service.impl.EmployeeServiceImpl:getPermissionbyId', '[21]');
INSERT INTO `systemlog` VALUES ('154', '2019-04-22 17:28:54', '0:0:0:0:0:0:0:1', 'com.lyd.service.impl.MenuServiceImpl:getTreeData', '[]');
INSERT INTO `systemlog` VALUES ('155', '2019-04-22 17:28:54', '0:0:0:0:0:0:0:1', 'com.lyd.service.impl.EmployeeServiceImpl:getEmployee', '[{\"page\":1,\"rows\":10,\"keyword\":null}]');
INSERT INTO `systemlog` VALUES ('156', '2019-04-22 17:28:54', '0:0:0:0:0:0:0:1', 'com.lyd.service.impl.DepartmentServiceImpl:getDepartmentList', '[]');
INSERT INTO `systemlog` VALUES ('157', '2019-04-22 17:28:54', '0:0:0:0:0:0:0:1', 'com.lyd.service.impl.RoleServiceImpl:getAllList', '[]');
INSERT INTO `systemlog` VALUES ('158', '2019-04-22 17:29:07', '0:0:0:0:0:0:0:1', 'com.lyd.service.impl.MenuServiceImpl:getMenuList', '[{\"page\":1,\"rows\":10,\"keyword\":null}]');
INSERT INTO `systemlog` VALUES ('159', '2019-04-22 17:29:07', '0:0:0:0:0:0:0:1', 'com.lyd.service.impl.MenuServiceImpl:parentList', '[]');
INSERT INTO `systemlog` VALUES ('160', '2019-04-22 17:29:09', '0:0:0:0:0:0:0:1', 'com.lyd.service.impl.RoleServiceImpl:getRoles', '[{\"page\":1,\"rows\":10,\"keyword\":null}]');
INSERT INTO `systemlog` VALUES ('161', '2019-04-22 17:29:09', '0:0:0:0:0:0:0:1', 'com.lyd.service.impl.PermissionServiceImpl:permissionList', '[]');
INSERT INTO `systemlog` VALUES ('162', '2019-04-22 21:24:23', null, 'com.lyd.service.impl.EmployeeServiceImpl:getEmployeeWithUsername', '[\"李应丹\"]');
INSERT INTO `systemlog` VALUES ('163', '2019-04-22 21:24:25', '0:0:0:0:0:0:0:1', 'com.lyd.service.impl.EmployeeServiceImpl:getRolesById', '[21]');
INSERT INTO `systemlog` VALUES ('164', '2019-04-22 21:24:25', '0:0:0:0:0:0:0:1', 'com.lyd.service.impl.EmployeeServiceImpl:getPermissionbyId', '[21]');
INSERT INTO `systemlog` VALUES ('165', '2019-04-22 21:24:25', '0:0:0:0:0:0:0:1', 'com.lyd.service.impl.MenuServiceImpl:getTreeData', '[]');
INSERT INTO `systemlog` VALUES ('166', '2019-04-22 21:24:26', '0:0:0:0:0:0:0:1', 'com.lyd.service.impl.DepartmentServiceImpl:getDepartmentList', '[]');
INSERT INTO `systemlog` VALUES ('167', '2019-04-22 21:24:26', '0:0:0:0:0:0:0:1', 'com.lyd.service.impl.RoleServiceImpl:getAllList', '[]');
INSERT INTO `systemlog` VALUES ('168', '2019-04-22 21:24:26', '0:0:0:0:0:0:0:1', 'com.lyd.service.impl.EmployeeServiceImpl:getEmployee', '[{\"page\":1,\"rows\":10,\"keyword\":null}]');
INSERT INTO `systemlog` VALUES ('169', '2019-04-22 21:29:50', '0:0:0:0:0:0:0:1', 'com.lyd.service.impl.EmployeeServiceImpl:getRolesById', '[21]');
INSERT INTO `systemlog` VALUES ('170', '2019-04-22 21:29:50', '0:0:0:0:0:0:0:1', 'com.lyd.service.impl.EmployeeServiceImpl:getPermissionbyId', '[21]');
INSERT INTO `systemlog` VALUES ('171', '2019-04-22 21:29:50', '0:0:0:0:0:0:0:1', 'com.lyd.service.impl.MenuServiceImpl:getTreeData', '[]');
INSERT INTO `systemlog` VALUES ('172', '2019-04-22 21:29:50', '0:0:0:0:0:0:0:1', 'com.lyd.service.impl.EmployeeServiceImpl:getEmployee', '[{\"page\":1,\"rows\":10,\"keyword\":null}]');
INSERT INTO `systemlog` VALUES ('173', '2019-04-22 21:29:50', '0:0:0:0:0:0:0:1', 'com.lyd.service.impl.DepartmentServiceImpl:getDepartmentList', '[]');
INSERT INTO `systemlog` VALUES ('174', '2019-04-22 21:29:50', '0:0:0:0:0:0:0:1', 'com.lyd.service.impl.RoleServiceImpl:getAllList', '[]');
INSERT INTO `systemlog` VALUES ('175', '2019-04-22 21:30:05', '0:0:0:0:0:0:0:1', 'com.lyd.service.impl.EmployeeServiceImpl:getEmployee', '[{\"page\":1,\"rows\":10,\"keyword\":null}]');
INSERT INTO `systemlog` VALUES ('176', '2019-04-22 22:25:25', null, 'com.lyd.service.impl.EmployeeServiceImpl:getEmployeeWithUsername', '[\"李应丹\"]');
INSERT INTO `systemlog` VALUES ('177', '2019-04-22 22:25:27', '0:0:0:0:0:0:0:1', 'com.lyd.service.impl.EmployeeServiceImpl:getRolesById', '[21]');
INSERT INTO `systemlog` VALUES ('178', '2019-04-22 22:25:27', '0:0:0:0:0:0:0:1', 'com.lyd.service.impl.EmployeeServiceImpl:getPermissionbyId', '[21]');
INSERT INTO `systemlog` VALUES ('179', '2019-04-22 22:25:27', '0:0:0:0:0:0:0:1', 'com.lyd.service.impl.MenuServiceImpl:getTreeData', '[]');
INSERT INTO `systemlog` VALUES ('180', '2019-04-22 22:25:28', '0:0:0:0:0:0:0:1', 'com.lyd.service.impl.DepartmentServiceImpl:getDepartmentList', '[]');
INSERT INTO `systemlog` VALUES ('181', '2019-04-22 22:25:28', '0:0:0:0:0:0:0:1', 'com.lyd.service.impl.RoleServiceImpl:getAllList', '[]');
INSERT INTO `systemlog` VALUES ('182', '2019-04-22 22:25:28', '0:0:0:0:0:0:0:1', 'com.lyd.service.impl.EmployeeServiceImpl:getEmployee', '[{\"page\":1,\"rows\":10,\"keyword\":null}]');
INSERT INTO `systemlog` VALUES ('183', '2019-04-22 22:25:34', '0:0:0:0:0:0:0:1', 'com.lyd.service.impl.EmployeeServiceImpl:getEmployee', '[{\"page\":1,\"rows\":10,\"keyword\":\"李\"}]');
