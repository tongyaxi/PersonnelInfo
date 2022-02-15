/*
 Navicat Premium Data Transfer

 Source Server         : MySQL
 Source Server Type    : MySQL
 Source Server Version : 50721
 Source Host           : localhost:3306
 Source Schema         : personnelinfo

 Target Server Type    : MySQL
 Target Server Version : 50721
 File Encoding         : 65001

 Date: 09/02/2022 22:18:07
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for tb_dept
-- ----------------------------
DROP TABLE IF EXISTS `tb_dept`;
CREATE TABLE `tb_dept`  (
  `dept_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '部门编号',
  `dept_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '部门名称',
  PRIMARY KEY (`dept_id`) USING BTREE,
  UNIQUE INDEX `uq_dept_name`(`dept_name`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of tb_dept
-- ----------------------------
INSERT INTO `tb_dept` VALUES (1, 'Customer Service Department');
INSERT INTO `tb_dept` VALUES (2, 'Finance Department');
INSERT INTO `tb_dept` VALUES (3, 'Human Resources Department');
INSERT INTO `tb_dept` VALUES (4, 'Market Department');
INSERT INTO `tb_dept` VALUES (5, 'Technology Department');

-- ----------------------------
-- Table structure for tb_emp
-- ----------------------------
DROP TABLE IF EXISTS `tb_emp`;
CREATE TABLE `tb_emp`  (
  `emp_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '员工编号',
  `emp_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '员工姓名',
  `gender` tinyint(4) NULL DEFAULT NULL COMMENT '员工性别, 1男2女',
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '员工邮箱',
  `d_id` int(11) NULL DEFAULT NULL COMMENT '部门编号',
  PRIMARY KEY (`emp_id`) USING BTREE,
  UNIQUE INDEX `uq_emp_name`(`emp_name`) USING BTREE,
  INDEX `fk_emp_dept`(`d_id`) USING BTREE,
  CONSTRAINT `fk_emp_dept` FOREIGN KEY (`d_id`) REFERENCES `tb_dept` (`dept_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 291 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of tb_emp
-- ----------------------------
INSERT INTO `tb_emp` VALUES (1, 'test01', 1, 'test01@gmail.com', 1);
INSERT INTO `tb_emp` VALUES (2, 'test02', 2, 'test02@gmail.com', 2);
INSERT INTO `tb_emp` VALUES (3, 'test03', 2, 'test03@gmail.com', 3);
INSERT INTO `tb_emp` VALUES (4, 'test04', 1, 'test04@gmail.com', 1);
INSERT INTO `tb_emp` VALUES (5, 'test05', 1, 'test05@gmail.com', 1);
INSERT INTO `tb_emp` VALUES (6, 'test06', 1, 'test06@gmail.com', 1);
INSERT INTO `tb_emp` VALUES (7, 'test07', 1, 'test07@gmail.com', 1);
INSERT INTO `tb_emp` VALUES (8, 'test08', 1, 'test08@gmail.com', 1);
INSERT INTO `tb_emp` VALUES (9, 'test09', 1, 'test09@gmail.com', 1);
INSERT INTO `tb_emp` VALUES (10, 'test10', 1, 'test10@gmail.com', 1);
INSERT INTO `tb_emp` VALUES (11, 'test11', 1, 'test11@gmail.com', 1);
INSERT INTO `tb_emp` VALUES (12, 'test12', 1, 'test12@gmail.com', 1);
INSERT INTO `tb_emp` VALUES (13, 'test13', 1, 'test13@gmail.com', 1);
INSERT INTO `tb_emp` VALUES (14, 'test14', 1, 'test14@gmail.com', 1);
INSERT INTO `tb_emp` VALUES (15, 'test15', 1, 'test15@gmail.com', 1);
INSERT INTO `tb_emp` VALUES (16, 'test16', 1, 'test16@gmail.com', 1);
INSERT INTO `tb_emp` VALUES (17, 'test17', 1, 'test17@gmail.com', 1);
INSERT INTO `tb_emp` VALUES (18, 'test18', 1, 'test18@gmail.com', 1);
INSERT INTO `tb_emp` VALUES (19, 'test19', 1, 'test19@gmail.com', 1);
INSERT INTO `tb_emp` VALUES (20, 'test20', 1, 'test20@gmail.com', 1);
INSERT INTO `tb_emp` VALUES (21, 'test21', 1, 'test21@gmail.com', 1);
INSERT INTO `tb_emp` VALUES (22, 'test22', 1, 'test22@gmail.com', 1);
INSERT INTO `tb_emp` VALUES (23, 'test23', 1, 'test23@gmail.com', 1);
INSERT INTO `tb_emp` VALUES (24, 'test24', 1, 'test24@gmail.com', 1);
INSERT INTO `tb_emp` VALUES (25, 'test25', 1, 'test25@gmail.com', 1);
INSERT INTO `tb_emp` VALUES (26, 'test26', 1, 'test26@gmail.com', 1);
INSERT INTO `tb_emp` VALUES (27, 'test27', 1, 'test27@gmail.com', 1);
INSERT INTO `tb_emp` VALUES (28, 'test28', 1, 'test28@gmail.com', 1);
INSERT INTO `tb_emp` VALUES (29, 'test29', 1, 'test29@gmail.com', 1);
INSERT INTO `tb_emp` VALUES (30, 'test30', 1, 'test30@gmail.com', 1);

SET FOREIGN_KEY_CHECKS = 1;
