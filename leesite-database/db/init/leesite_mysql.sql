/*
SQLyog Ultimate v12.09 (64 bit)
MySQL - 5.7.17 : Database - leesite
*********************************************************************
*/


/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`leesite` /*!40100 DEFAULT CHARACTER SET utf8mb4 */;

USE `leesite`;

/*Table structure for table `calendar` */

DROP TABLE IF EXISTS `calendar`;

CREATE TABLE `calendar` (
  `id` varchar(64) NOT NULL COMMENT '主键',
  `title` varchar(64) DEFAULT NULL COMMENT '事件标题',
  `starttime` varchar(64) CHARACTER SET utf8 DEFAULT NULL COMMENT '事件开始时间',
  `endtime` varchar(64) CHARACTER SET utf8 DEFAULT NULL COMMENT '事件结束时间',
  `allday` varchar(64) CHARACTER SET utf8 DEFAULT NULL COMMENT '是否为全天时间',
  `color` varchar(64) CHARACTER SET utf8 DEFAULT NULL COMMENT '时间的背景色',
  `userid` varchar(64) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='日历';

/*Table structure for table `case_one_to_many_first` */

DROP TABLE IF EXISTS `case_one_to_many_first`;

CREATE TABLE `case_one_to_many_first` (
  `id` varchar(64) NOT NULL DEFAULT '' COMMENT '编号',
  `startarea` varchar(64) DEFAULT NULL COMMENT '出发地',
  `endarea` varchar(64) DEFAULT NULL COMMENT '目的地',
  `price` double DEFAULT NULL COMMENT '代理价格',
  `case_one_to_many_main` varchar(64) DEFAULT NULL COMMENT '外键',
  `create_by` varchar(64) DEFAULT NULL COMMENT '创建者',
  `create_date` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT NULL COMMENT '更新者',
  `update_date` datetime DEFAULT NULL COMMENT '更新时间',
  `remarks` varchar(255) DEFAULT NULL COMMENT '备注信息',
  `del_flag` char(1) DEFAULT NULL COMMENT '删除标记',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='一对多子表1';

/*Table structure for table `case_one_to_many_main` */

DROP TABLE IF EXISTS `case_one_to_many_main`;

CREATE TABLE `case_one_to_many_main` (
  `id` varchar(64) NOT NULL DEFAULT '' COMMENT '编号',
  `user_id` varchar(64) DEFAULT NULL COMMENT '归属用户',
  `office_id` varchar(64) DEFAULT NULL COMMENT '归属部门',
  `area_id` varchar(64) DEFAULT NULL COMMENT '归属区域',
  `name` varchar(100) DEFAULT NULL COMMENT '名称',
  `sex` char(1) DEFAULT NULL COMMENT '性别',
  `in_date` date DEFAULT NULL COMMENT '加入日期',
  `create_by` varchar(64) DEFAULT NULL COMMENT '创建者',
  `create_date` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT NULL COMMENT '更新者',
  `update_date` datetime DEFAULT NULL COMMENT '更新时间',
  `remarks` varchar(255) DEFAULT NULL COMMENT '备注信息',
  `del_flag` char(1) DEFAULT NULL COMMENT '删除标记',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='一对多主表';

/*Table structure for table `case_one_to_many_second` */

DROP TABLE IF EXISTS `case_one_to_many_second`;

CREATE TABLE `case_one_to_many_second` (
  `id` varchar(64) NOT NULL DEFAULT '' COMMENT '主键',
  `startarea` varchar(64) DEFAULT NULL COMMENT '出发地',
  `endarea` varchar(64) DEFAULT NULL COMMENT '目的地',
  `price` double DEFAULT NULL COMMENT '代理价格',
  `case_one_to_many_main` varchar(64) DEFAULT NULL COMMENT '外键',
  `create_by` varchar(64) DEFAULT NULL COMMENT '创建者',
  `create_date` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT NULL COMMENT '更新者',
  `update_date` datetime DEFAULT NULL COMMENT '更新时间',
  `remarks` varchar(255) DEFAULT NULL COMMENT '备注信息',
  `del_flag` varchar(64) DEFAULT NULL COMMENT '逻辑删除标记（0：显示；1：隐藏）',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='一对多子表2';

/*Table structure for table `case_one_to_many_third` */

DROP TABLE IF EXISTS `case_one_to_many_third`;

CREATE TABLE `case_one_to_many_third` (
  `id` varchar(64) NOT NULL DEFAULT '' COMMENT '主键',
  `startarea` varchar(64) DEFAULT NULL COMMENT '出发地',
  `endarea` varchar(64) DEFAULT NULL COMMENT '目的地',
  `price` double DEFAULT NULL COMMENT '代理价格',
  `case_one_to_many_main` varchar(64) DEFAULT NULL COMMENT '外键',
  `create_by` varchar(64) DEFAULT NULL COMMENT '创建者',
  `create_date` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT NULL COMMENT '更新者',
  `update_date` datetime DEFAULT NULL COMMENT '更新时间',
  `remarks` varchar(255) DEFAULT NULL COMMENT '备注信息',
  `del_flag` varchar(64) DEFAULT NULL COMMENT '逻辑删除标记（0：显示；1：隐藏）',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='一对多子表3';

/*Table structure for table `case_single_table` */

DROP TABLE IF EXISTS `case_single_table`;

CREATE TABLE `case_single_table` (
  `id` varchar(64) NOT NULL DEFAULT '' COMMENT '主键',
  `user_id` varchar(64) DEFAULT NULL COMMENT '员工',
  `office_id` varchar(64) DEFAULT NULL COMMENT '归属部门',
  `area_id` varchar(64) DEFAULT NULL COMMENT '归属区域',
  `begin_date` datetime DEFAULT NULL COMMENT '请假开始日期',
  `end_date` datetime DEFAULT NULL COMMENT '请假结束日期',
  `create_by` varchar(64) DEFAULT NULL COMMENT '创建者',
  `create_date` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT NULL COMMENT '更新者',
  `update_date` datetime DEFAULT NULL COMMENT '更新时间',
  `remarks` varchar(257) CHARACTER SET utf8 DEFAULT NULL COMMENT '备注信息',
  `del_flag` varchar(64) DEFAULT NULL COMMENT '逻辑删除标记（0：显示；1：隐藏）',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='单表';

/*Table structure for table `case_tree_table` */

DROP TABLE IF EXISTS `case_tree_table`;

CREATE TABLE `case_tree_table` (
  `id` varchar(64) NOT NULL DEFAULT '' COMMENT '主键',
  `name` varchar(100) CHARACTER SET utf8 DEFAULT NULL COMMENT '名称',
  `sort` decimal(10,0) DEFAULT NULL COMMENT '排序',
  `parent_id` varchar(64) DEFAULT NULL COMMENT '父级编号',
  `parent_ids` varchar(2000) DEFAULT NULL COMMENT '所有父级编号',
  `create_by` varchar(64) DEFAULT NULL COMMENT '创建者',
  `create_date` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT NULL COMMENT '更新者',
  `update_date` datetime DEFAULT NULL COMMENT '更新时间',
  `remarks` varchar(255) CHARACTER SET utf8 DEFAULT NULL COMMENT '备注信息',
  `del_flag` varchar(64) DEFAULT NULL COMMENT '逻辑删除标记（0：显示；1：隐藏）',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='树结构';

/*Table structure for table `config_aliyun_oss` */

DROP TABLE IF EXISTS `config_aliyun_oss`;

CREATE TABLE `config_aliyun_oss` (
  `id` varchar(64) NOT NULL COMMENT '编号',
  `oss_key` varchar(64) DEFAULT NULL COMMENT 'Key',
  `oss_secret` varchar(64) DEFAULT NULL COMMENT 'Secret',
  `bucket_name` varchar(100) DEFAULT NULL COMMENT 'Bucket Name',
  `oss_end_point` varchar(100) DEFAULT NULL COMMENT 'OSS End Point',
  `auto_create_bucket` varchar(2) DEFAULT NULL COMMENT '自动创建 Bucket',
  `baidu_use_status` varchar(2) DEFAULT NULL COMMENT '支持百度富文本',
  `use_cdn` varchar(2) DEFAULT NULL COMMENT '启用 CDN',
  `cdn_end_point` varchar(100) DEFAULT NULL COMMENT 'CDN End Point',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='对象存储 OSS';

/*Table structure for table `config_aliyun_push` */

DROP TABLE IF EXISTS `config_aliyun_push`;

CREATE TABLE `config_aliyun_push` (
  `id` varchar(64) NOT NULL COMMENT '编号',
  `access_key_id` varchar(64) DEFAULT NULL COMMENT 'Key',
  `access_key_secret` varchar(64) DEFAULT NULL COMMENT 'Secret',
  `app_key` varchar(64) DEFAULT NULL COMMENT 'AppKey',
  `region_id` varchar(64) DEFAULT NULL COMMENT 'RegionId',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='移动推送';

/*Table structure for table `config_mail` */

DROP TABLE IF EXISTS `config_mail`;

CREATE TABLE `config_mail` (
  `id` varchar(64) NOT NULL COMMENT '编号',
  `mail_host` varchar(100) NOT NULL COMMENT '主机名',
  `mail_port` int(11) NOT NULL COMMENT '主机端口',
  `mail_username` varchar(100) NOT NULL COMMENT '邮箱地址',
  `mail_password` varchar(100) NOT NULL COMMENT '邮箱密码',
  `mail_from` varchar(100) NOT NULL COMMENT '发件人昵称',
  `mail_ssl` varchar(1) NOT NULL COMMENT '使用SSL/TLS',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='邮箱配置';

/*Table structure for table `config_sms` */

DROP TABLE IF EXISTS `config_sms`;

CREATE TABLE `config_sms` (
  `id` varchar(64) NOT NULL COMMENT '编号',
  `sms_access_id` varchar(64) NOT NULL COMMENT 'AccessId',
  `sms_access_key` varchar(64) NOT NULL COMMENT 'AccessKey',
  `sms_mns_endpoint` varchar(255) NOT NULL COMMENT 'MNSEndpoint',
  `sms_topic` varchar(255) NOT NULL COMMENT '主题',
  `sms_sign_name` varchar(20) NOT NULL COMMENT '签名',
  `test_number` varchar(20) NOT NULL COMMENT '测试手机',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='短信配置';

/*Table structure for table `config_sms_template` */

DROP TABLE IF EXISTS `config_sms_template`;

CREATE TABLE `config_sms_template` (
  `id` varchar(64) NOT NULL DEFAULT '' COMMENT '编号',
  `sms_template_name` varchar(20) NOT NULL COMMENT '模板名称',
  `sms_template_code` varchar(64) NOT NULL COMMENT '模板编码',
  `sms_template_type` varchar(2) NOT NULL COMMENT '模板类型',
  `sms_template_content` varchar(755) NOT NULL COMMENT '短信内容',
  `config_sms` varchar(64) NOT NULL COMMENT '外键',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='短信模板';

/*Table structure for table `gen_scheme` */

DROP TABLE IF EXISTS `gen_scheme`;

CREATE TABLE `gen_scheme` (
  `id` varchar(64) NOT NULL COMMENT '编号',
  `name` varchar(200) DEFAULT NULL COMMENT '名称',
  `category` varchar(2000) DEFAULT NULL COMMENT '分类',
  `package_name` varchar(500) DEFAULT NULL COMMENT '生成包路径',
  `module_name` varchar(30) DEFAULT NULL COMMENT '生成模块名',
  `sub_module_name` varchar(30) DEFAULT NULL COMMENT '生成子模块名',
  `function_name` varchar(500) DEFAULT NULL COMMENT '生成功能名',
  `function_name_simple` varchar(100) DEFAULT NULL COMMENT '生成功能名（简写）',
  `function_author` varchar(100) DEFAULT NULL COMMENT '生成功能作者',
  `gen_table_id` varchar(200) DEFAULT NULL COMMENT '生成表编号',
  `create_by` varchar(64) DEFAULT NULL COMMENT '创建者',
  `create_date` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT NULL COMMENT '更新者',
  `update_date` datetime DEFAULT NULL COMMENT '更新时间',
  `remarks` varchar(255) DEFAULT NULL COMMENT '备注信息',
  `del_flag` char(1) NOT NULL DEFAULT '0' COMMENT '删除标记（0：正常；1：删除）',
  PRIMARY KEY (`id`),
  KEY `gen_scheme_del_flag` (`del_flag`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='生成方案';

/*Table structure for table `gen_table` */

DROP TABLE IF EXISTS `gen_table`;

CREATE TABLE `gen_table` (
  `id` varchar(64) NOT NULL COMMENT '编号',
  `name` varchar(200) DEFAULT NULL COMMENT '名称',
  `comments` varchar(500) DEFAULT NULL COMMENT '描述',
  `class_name` varchar(100) DEFAULT NULL COMMENT '实体类名称',
  `parent_table` varchar(200) DEFAULT NULL COMMENT '关联父表',
  `parent_table_fk` varchar(100) DEFAULT NULL COMMENT '关联父表外键',
  `create_by` varchar(64) DEFAULT NULL COMMENT '创建者',
  `create_date` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT NULL COMMENT '更新者',
  `update_date` datetime DEFAULT NULL COMMENT '更新时间',
  `remarks` varchar(255) DEFAULT NULL COMMENT '备注信息',
  `del_flag` char(1) DEFAULT '0' COMMENT '删除标记（0：正常；1：删除）',
  `issync` varchar(45) DEFAULT NULL COMMENT '同步',
  `table_type` varchar(45) DEFAULT NULL COMMENT '表类型',
  PRIMARY KEY (`id`),
  KEY `gen_table_name` (`name`),
  KEY `gen_table_del_flag` (`del_flag`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='业务表';

/*Table structure for table `gen_table_column` */

DROP TABLE IF EXISTS `gen_table_column`;

CREATE TABLE `gen_table_column` (
  `id` varchar(64) NOT NULL COMMENT '编号',
  `gen_table_id` varchar(64) DEFAULT NULL COMMENT '归属表编号',
  `name` varchar(200) DEFAULT NULL COMMENT '名称',
  `comments` varchar(500) DEFAULT NULL COMMENT '描述',
  `jdbc_type` varchar(100) DEFAULT NULL COMMENT '列的数据类型的字节长度',
  `java_type` varchar(500) DEFAULT NULL COMMENT 'JAVA类型',
  `java_field` varchar(200) DEFAULT NULL COMMENT 'JAVA字段名',
  `is_pk` char(1) DEFAULT NULL COMMENT '是否主键',
  `is_null` char(1) DEFAULT NULL COMMENT '是否可为空',
  `is_insert` char(1) DEFAULT NULL COMMENT '是否为插入字段',
  `is_edit` char(1) DEFAULT NULL COMMENT '是否编辑字段',
  `is_list` char(1) DEFAULT NULL COMMENT '是否列表字段',
  `is_query` char(1) DEFAULT NULL COMMENT '是否查询字段',
  `query_type` varchar(200) DEFAULT NULL COMMENT '查询方式（等于、不等于、大于、小于、范围、左LIKE、右LIKE、左右LIKE）',
  `show_type` varchar(200) DEFAULT NULL COMMENT '字段生成方案（文本框、文本域、下拉框、复选框、单选框、字典选择、人员选择、部门选择、区域选择）',
  `dict_type` varchar(200) DEFAULT NULL COMMENT '字典类型',
  `settings` varchar(2000) DEFAULT NULL COMMENT '其它设置（扩展字段JSON）',
  `sort` decimal(10,0) DEFAULT NULL COMMENT '排序（升序）',
  `create_by` varchar(64) DEFAULT NULL COMMENT '创建者',
  `create_date` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT NULL COMMENT '更新者',
  `update_date` datetime DEFAULT NULL COMMENT '更新时间',
  `remarks` varchar(255) DEFAULT NULL COMMENT '备注信息',
  `del_flag` char(1) DEFAULT '0' COMMENT '删除标记（0：正常；1：删除）',
  `is_form` varchar(45) DEFAULT NULL COMMENT '是否表单显示',
  `tableName` varchar(45) DEFAULT NULL COMMENT '管理的查询表名',
  `fieldLabels` varchar(512) DEFAULT NULL,
  `fieldKeys` varchar(512) DEFAULT NULL,
  `searchLabel` varchar(45) DEFAULT NULL,
  `searchKey` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `gen_table_column_table_id` (`gen_table_id`),
  KEY `gen_table_column_name` (`name`),
  KEY `gen_table_column_sort` (`sort`),
  KEY `gen_table_column_del_flag` (`del_flag`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='业务表字段';

/*Table structure for table `gen_template` */

DROP TABLE IF EXISTS `gen_template`;

CREATE TABLE `gen_template` (
  `id` varchar(64) NOT NULL COMMENT '编号',
  `name` varchar(200) DEFAULT NULL COMMENT '名称',
  `category` varchar(2000) DEFAULT NULL COMMENT '分类',
  `file_path` varchar(500) DEFAULT NULL COMMENT '生成文件路径',
  `file_name` varchar(200) DEFAULT NULL COMMENT '生成文件名',
  `content` text COMMENT '内容',
  `create_by` varchar(64) DEFAULT NULL COMMENT '创建者',
  `create_date` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT NULL COMMENT '更新者',
  `update_date` datetime DEFAULT NULL COMMENT '更新时间',
  `remarks` varchar(255) DEFAULT NULL COMMENT '备注信息',
  `del_flag` char(1) NOT NULL DEFAULT '0' COMMENT '删除标记（0：正常；1：删除）',
  PRIMARY KEY (`id`),
  KEY `gen_template_del_falg` (`del_flag`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='代码模板表';

/*Table structure for table `iim_chat_history` */

DROP TABLE IF EXISTS `iim_chat_history`;

CREATE TABLE `iim_chat_history` (
  `id` varchar(64) NOT NULL,
  `userid1` varchar(64) CHARACTER SET utf8 DEFAULT NULL,
  `userid2` varchar(64) CHARACTER SET utf8 DEFAULT NULL,
  `msg` varchar(1024) CHARACTER SET utf8 DEFAULT NULL,
  `status` varchar(45) DEFAULT NULL,
  `create_date` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `iim_mail` */

DROP TABLE IF EXISTS `iim_mail`;

CREATE TABLE `iim_mail` (
  `id` varchar(64) NOT NULL,
  `title` varchar(128) DEFAULT NULL COMMENT '标题',
  `overview` varchar(128) DEFAULT NULL COMMENT '内容概要',
  `content` longblob COMMENT '内容',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='邮件';

/*Table structure for table `iim_mail_box` */

DROP TABLE IF EXISTS `iim_mail_box`;

CREATE TABLE `iim_mail_box` (
  `id` varchar(64) NOT NULL,
  `readstatus` varchar(45) DEFAULT NULL COMMENT '状态 0 未读 1 已读',
  `senderId` varchar(64) DEFAULT NULL COMMENT '发件人',
  `receiverId` varchar(6400) DEFAULT NULL COMMENT '收件人',
  `sendtime` datetime DEFAULT NULL COMMENT '发送时间',
  `mailid` varchar(64) DEFAULT NULL COMMENT '邮件外键',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='收件箱';

/*Table structure for table `iim_mail_compose` */

DROP TABLE IF EXISTS `iim_mail_compose`;

CREATE TABLE `iim_mail_compose` (
  `id` varchar(64) NOT NULL,
  `status` varchar(45) DEFAULT NULL COMMENT '状态 0 草稿 1 已发送',
  `readstatus` varchar(45) DEFAULT NULL COMMENT '状态 0 未读 1 已读',
  `senderId` varchar(64) DEFAULT NULL COMMENT '发送者',
  `receiverId` varchar(6400) DEFAULT NULL COMMENT '接收者',
  `sendtime` datetime DEFAULT NULL COMMENT '发送时间',
  `mailId` varchar(64) DEFAULT NULL COMMENT '邮件id',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='发件箱 草稿箱';

/*Table structure for table `monitor` */

DROP TABLE IF EXISTS `monitor`;

CREATE TABLE `monitor` (
  `id` varchar(64) NOT NULL DEFAULT '' COMMENT '主键',
  `cpu` varchar(64) DEFAULT NULL COMMENT 'cpu使用率',
  `jvm` varchar(64) DEFAULT NULL COMMENT 'jvm使用率',
  `ram` varchar(64) DEFAULT NULL COMMENT '内存使用率',
  `toemail` varchar(64) DEFAULT NULL COMMENT '警告通知邮箱',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='系统监控';

/*Table structure for table `oa_notify` */

DROP TABLE IF EXISTS `oa_notify`;

CREATE TABLE `oa_notify` (
  `id` varchar(64) NOT NULL COMMENT '编号',
  `type` char(1) DEFAULT NULL COMMENT '类型',
  `title` varchar(200) DEFAULT NULL COMMENT '标题',
  `content` varchar(2000) DEFAULT NULL COMMENT '内容',
  `files` varchar(2000) DEFAULT NULL COMMENT '附件',
  `status` char(1) DEFAULT NULL COMMENT '状态',
  `create_by` varchar(64) NOT NULL COMMENT '创建者',
  `create_date` datetime NOT NULL COMMENT '创建时间',
  `update_by` varchar(64) NOT NULL COMMENT '更新者',
  `update_date` datetime NOT NULL COMMENT '更新时间',
  `remarks` varchar(255) DEFAULT NULL COMMENT '备注信息',
  `del_flag` char(1) NOT NULL DEFAULT '0' COMMENT '删除标记',
  PRIMARY KEY (`id`),
  KEY `oa_notify_del_flag` (`del_flag`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='通知通告';

/*Table structure for table `oa_notify_record` */

DROP TABLE IF EXISTS `oa_notify_record`;

CREATE TABLE `oa_notify_record` (
  `id` varchar(64) NOT NULL COMMENT '编号',
  `oa_notify_id` varchar(64) DEFAULT NULL COMMENT '通知通告ID',
  `user_id` varchar(64) DEFAULT NULL COMMENT '接受人',
  `read_flag` char(1) DEFAULT '0' COMMENT '阅读标记',
  `read_date` date DEFAULT NULL COMMENT '阅读时间',
  PRIMARY KEY (`id`),
  KEY `oa_notify_record_notify_id` (`oa_notify_id`),
  KEY `oa_notify_record_user_id` (`user_id`),
  KEY `oa_notify_record_read_flag` (`read_flag`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='通知通告发送记录';

/*Table structure for table `sys_area` */

DROP TABLE IF EXISTS `sys_area`;

CREATE TABLE `sys_area` (
  `id` varchar(64) NOT NULL COMMENT '编号',
  `parent_id` varchar(64) NOT NULL COMMENT '父级编号',
  `parent_ids` varchar(2000) NOT NULL COMMENT '所有父级编号',
  `name` varchar(100) NOT NULL COMMENT '名称',
  `sort` decimal(10,0) NOT NULL COMMENT '排序',
  `code` varchar(100) DEFAULT NULL COMMENT '区域编码',
  `type` char(1) DEFAULT NULL COMMENT '区域类型',
  `create_by` varchar(64) NOT NULL COMMENT '创建者',
  `create_date` datetime NOT NULL COMMENT '创建时间',
  `update_by` varchar(64) NOT NULL COMMENT '更新者',
  `update_date` datetime NOT NULL COMMENT '更新时间',
  `remarks` varchar(255) DEFAULT NULL COMMENT '备注信息',
  `del_flag` char(1) NOT NULL DEFAULT '0' COMMENT '删除标记',
  PRIMARY KEY (`id`),
  KEY `sys_area_parent_id` (`parent_id`),
  KEY `sys_area_del_flag` (`del_flag`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='区域表';

/*Table structure for table `sys_dict` */

DROP TABLE IF EXISTS `sys_dict`;

CREATE TABLE `sys_dict` (
  `id` varchar(64) NOT NULL COMMENT '编号',
  `value` varchar(100) NOT NULL COMMENT '数据值',
  `label` varchar(100) NOT NULL COMMENT '标签名',
  `type` varchar(100) NOT NULL COMMENT '类型',
  `description` varchar(100) NOT NULL COMMENT '描述',
  `sort` decimal(10,0) NOT NULL COMMENT '排序（升序）',
  `parent_id` varchar(64) DEFAULT '0' COMMENT '父级编号',
  `create_by` varchar(64) NOT NULL COMMENT '创建者',
  `create_date` datetime NOT NULL COMMENT '创建时间',
  `update_by` varchar(64) NOT NULL COMMENT '更新者',
  `update_date` datetime NOT NULL COMMENT '更新时间',
  `remarks` varchar(255) DEFAULT NULL COMMENT '备注信息',
  `del_flag` char(1) NOT NULL DEFAULT '0' COMMENT '删除标记',
  PRIMARY KEY (`id`),
  KEY `sys_dict_value` (`value`),
  KEY `sys_dict_label` (`label`),
  KEY `sys_dict_del_flag` (`del_flag`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='字典表';

/*Table structure for table `sys_log` */

DROP TABLE IF EXISTS `sys_log`;

CREATE TABLE `sys_log` (
  `id` varchar(64) NOT NULL COMMENT '编号',
  `type` char(1) DEFAULT '1' COMMENT '日志类型',
  `title` varchar(255) DEFAULT '' COMMENT '日志标题',
  `create_by` varchar(64) DEFAULT NULL COMMENT '创建者',
  `create_date` datetime DEFAULT NULL COMMENT '创建时间',
  `remote_addr` varchar(255) DEFAULT NULL COMMENT '操作IP地址',
  `user_agent` varchar(255) DEFAULT NULL COMMENT '用户代理',
  `request_uri` varchar(255) DEFAULT NULL COMMENT '请求URI',
  `method` varchar(5) DEFAULT NULL COMMENT '操作方式',
  `params` text COMMENT '操作提交的数据',
  `exception` text COMMENT '异常信息',
  PRIMARY KEY (`id`),
  KEY `sys_log_create_by` (`create_by`),
  KEY `sys_log_request_uri` (`request_uri`),
  KEY `sys_log_type` (`type`),
  KEY `sys_log_create_date` (`create_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='日志表';

/*Table structure for table `sys_mdict` */

DROP TABLE IF EXISTS `sys_mdict`;

CREATE TABLE `sys_mdict` (
  `id` varchar(64) NOT NULL COMMENT '编号',
  `parent_id` varchar(64) NOT NULL COMMENT '父级编号',
  `parent_ids` varchar(2000) NOT NULL COMMENT '所有父级编号',
  `name` varchar(100) NOT NULL COMMENT '名称',
  `sort` decimal(10,0) NOT NULL COMMENT '排序',
  `description` varchar(100) DEFAULT NULL COMMENT '描述',
  `create_by` varchar(64) NOT NULL COMMENT '创建者',
  `create_date` datetime NOT NULL COMMENT '创建时间',
  `update_by` varchar(64) NOT NULL COMMENT '更新者',
  `update_date` datetime NOT NULL COMMENT '更新时间',
  `remarks` varchar(255) DEFAULT NULL COMMENT '备注信息',
  `del_flag` char(1) NOT NULL DEFAULT '0' COMMENT '删除标记',
  PRIMARY KEY (`id`),
  KEY `sys_mdict_parent_id` (`parent_id`),
  KEY `sys_mdict_del_flag` (`del_flag`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='多级字典表';

/*Table structure for table `sys_menu` */

DROP TABLE IF EXISTS `sys_menu`;

CREATE TABLE `sys_menu` (
  `id` varchar(64) NOT NULL COMMENT '编号',
  `parent_id` varchar(64) NOT NULL COMMENT '父级编号',
  `parent_ids` varchar(2000) NOT NULL COMMENT '所有父级编号',
  `name` varchar(100) NOT NULL COMMENT '名称',
  `sort` decimal(10,0) NOT NULL COMMENT '排序',
  `href` varchar(2000) DEFAULT NULL COMMENT '链接',
  `target` varchar(20) DEFAULT NULL COMMENT '目标',
  `icon` varchar(100) DEFAULT NULL COMMENT '图标',
  `is_show` char(1) NOT NULL COMMENT '是否在菜单中显示',
  `permission` varchar(200) DEFAULT NULL COMMENT '权限标识',
  `create_by` varchar(64) NOT NULL COMMENT '创建者',
  `create_date` datetime NOT NULL COMMENT '创建时间',
  `update_by` varchar(64) NOT NULL COMMENT '更新者',
  `update_date` datetime NOT NULL COMMENT '更新时间',
  `remarks` varchar(255) DEFAULT NULL COMMENT '备注信息',
  `del_flag` char(1) NOT NULL DEFAULT '0' COMMENT '删除标记',
  PRIMARY KEY (`id`),
  KEY `sys_menu_parent_id` (`parent_id`),
  KEY `sys_menu_del_flag` (`del_flag`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='菜单表';

/*Table structure for table `sys_office` */

DROP TABLE IF EXISTS `sys_office`;

CREATE TABLE `sys_office` (
  `id` varchar(64) NOT NULL COMMENT '编号',
  `parent_id` varchar(64) NOT NULL COMMENT '父级编号',
  `parent_ids` varchar(2000) NOT NULL COMMENT '所有父级编号',
  `name` varchar(100) NOT NULL COMMENT '名称',
  `sort` decimal(10,0) NOT NULL COMMENT '排序',
  `area_id` varchar(64) NOT NULL COMMENT '归属区域',
  `code` varchar(100) DEFAULT NULL COMMENT '区域编码',
  `type` char(1) NOT NULL COMMENT '机构类型',
  `grade` char(1) NOT NULL COMMENT '机构等级',
  `address` varchar(255) DEFAULT NULL COMMENT '联系地址',
  `zip_code` varchar(100) DEFAULT NULL COMMENT '邮政编码',
  `master` varchar(100) DEFAULT NULL COMMENT '负责人',
  `phone` varchar(200) DEFAULT NULL COMMENT '电话',
  `fax` varchar(200) DEFAULT NULL COMMENT '传真',
  `email` varchar(200) DEFAULT NULL COMMENT '邮箱',
  `USEABLE` varchar(64) DEFAULT NULL COMMENT '是否启用',
  `PRIMARY_PERSON` varchar(64) DEFAULT NULL COMMENT '主负责人',
  `DEPUTY_PERSON` varchar(64) DEFAULT NULL COMMENT '副负责人',
  `create_by` varchar(64) NOT NULL COMMENT '创建者',
  `create_date` datetime NOT NULL COMMENT '创建时间',
  `update_by` varchar(64) NOT NULL COMMENT '更新者',
  `update_date` datetime NOT NULL COMMENT '更新时间',
  `remarks` varchar(255) DEFAULT NULL COMMENT '备注信息',
  `del_flag` char(1) NOT NULL DEFAULT '0' COMMENT '删除标记',
  PRIMARY KEY (`id`),
  KEY `sys_office_parent_id` (`parent_id`),
  KEY `sys_office_del_flag` (`del_flag`),
  KEY `sys_office_type` (`type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='机构表';

/*Table structure for table `sys_role` */

DROP TABLE IF EXISTS `sys_role`;

CREATE TABLE `sys_role` (
  `id` varchar(64) NOT NULL COMMENT '编号',
  `office_id` varchar(64) DEFAULT NULL COMMENT '归属机构',
  `name` varchar(100) NOT NULL COMMENT '角色名称',
  `enname` varchar(255) DEFAULT NULL COMMENT '英文名称',
  `role_type` varchar(255) DEFAULT NULL COMMENT '角色类型',
  `data_scope` char(1) DEFAULT NULL COMMENT '数据范围',
  `is_sys` varchar(64) DEFAULT NULL COMMENT '是否系统数据',
  `useable` varchar(64) DEFAULT NULL COMMENT '是否可用',
  `create_by` varchar(64) NOT NULL COMMENT '创建者',
  `create_date` datetime NOT NULL COMMENT '创建时间',
  `update_by` varchar(64) NOT NULL COMMENT '更新者',
  `update_date` datetime NOT NULL COMMENT '更新时间',
  `remarks` varchar(255) DEFAULT NULL COMMENT '备注信息',
  `del_flag` char(1) NOT NULL DEFAULT '0' COMMENT '删除标记',
  PRIMARY KEY (`id`),
  KEY `sys_role_del_flag` (`del_flag`),
  KEY `sys_role_enname` (`enname`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='角色表';

/*Table structure for table `sys_role_menu` */

DROP TABLE IF EXISTS `sys_role_menu`;

CREATE TABLE `sys_role_menu` (
  `role_id` varchar(64) NOT NULL COMMENT '角色编号',
  `menu_id` varchar(64) NOT NULL COMMENT '菜单编号',
  PRIMARY KEY (`role_id`,`menu_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='角色-菜单';

/*Table structure for table `sys_role_office` */

DROP TABLE IF EXISTS `sys_role_office`;

CREATE TABLE `sys_role_office` (
  `role_id` varchar(64) NOT NULL COMMENT '角色编号',
  `office_id` varchar(64) NOT NULL COMMENT '机构编号',
  PRIMARY KEY (`role_id`,`office_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='角色-机构';

/*Table structure for table `sys_user` */

DROP TABLE IF EXISTS `sys_user`;

CREATE TABLE `sys_user` (
  `id` varchar(64) NOT NULL COMMENT '编号',
  `company_id` varchar(64) DEFAULT NULL COMMENT '归属公司',
  `office_id` varchar(64) DEFAULT NULL COMMENT '归属部门',
  `login_name` varchar(100) DEFAULT NULL COMMENT '登录名',
  `password` varchar(100) DEFAULT NULL COMMENT '密码',
  `no` varchar(100) DEFAULT NULL COMMENT '工号',
  `name` varchar(100) DEFAULT NULL COMMENT '姓名',
  `email` varchar(200) DEFAULT NULL COMMENT '邮箱',
  `phone` varchar(200) DEFAULT NULL COMMENT '电话',
  `mobile` varchar(200) DEFAULT NULL COMMENT '手机',
  `user_type` char(1) DEFAULT NULL COMMENT '用户类型',
  `photo` varchar(1000) DEFAULT NULL COMMENT '用户头像',
  `login_ip` varchar(100) DEFAULT NULL COMMENT '最后登陆IP',
  `login_date` datetime DEFAULT NULL COMMENT '最后登陆时间',
  `login_flag` varchar(64) DEFAULT NULL COMMENT '是否可登录',
  `create_by` varchar(64) DEFAULT NULL COMMENT '创建者',
  `create_date` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT NULL COMMENT '更新者',
  `update_date` datetime DEFAULT NULL COMMENT '更新时间',
  `remarks` varchar(255) DEFAULT NULL COMMENT '备注信息',
  `del_flag` char(1) DEFAULT '0' COMMENT '删除标记',
  `qrcode` varchar(1000) DEFAULT NULL COMMENT '二维码',
  PRIMARY KEY (`id`),
  KEY `sys_user_office_id` (`office_id`),
  KEY `sys_user_login_name` (`login_name`),
  KEY `sys_user_company_id` (`company_id`),
  KEY `sys_user_update_date` (`update_date`),
  KEY `sys_user_del_flag` (`del_flag`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户表';

/*Table structure for table `sys_user_role` */

DROP TABLE IF EXISTS `sys_user_role`;

CREATE TABLE `sys_user_role` (
  `user_id` varchar(64) NOT NULL COMMENT '用户编号',
  `role_id` varchar(64) NOT NULL COMMENT '角色编号',
  PRIMARY KEY (`user_id`,`role_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户-角色';

/*Table structure for table `test_interface` */

DROP TABLE IF EXISTS `test_interface`;

CREATE TABLE `test_interface` (
  `id` varchar(64) NOT NULL DEFAULT '' COMMENT '主键',
  `type` varchar(16) DEFAULT NULL COMMENT '接口类型',
  `url` varchar(256) DEFAULT NULL COMMENT '请求URL',
  `body` varchar(2048) DEFAULT NULL COMMENT '请求body',
  `successmsg` varchar(512) DEFAULT NULL COMMENT '成功时返回消息',
  `errormsg` varchar(512) DEFAULT NULL COMMENT '失败时返回消息',
  `remarks` varchar(512) DEFAULT NULL COMMENT '备注',
  `del_flag` char(1) CHARACTER SET utf8 DEFAULT '0' COMMENT '删除标记',
  `name` varchar(1024) DEFAULT NULL COMMENT '接口名称',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='接口列表';

/*Table structure for table `qrtz_schedule_job` */

DROP TABLE IF EXISTS qrtz_fired_triggers;
DROP TABLE IF EXISTS qrtz_paused_trigger_grps;
DROP TABLE IF EXISTS qrtz_scheduler_state;
DROP TABLE IF EXISTS qrtz_locks;
DROP TABLE IF EXISTS qrtz_simple_triggers;
DROP TABLE IF EXISTS qrtz_simprop_triggers;
DROP TABLE IF EXISTS qrtz_cron_triggers;
DROP TABLE IF EXISTS qrtz_blob_triggers;
DROP TABLE IF EXISTS qrtz_triggers;
DROP TABLE IF EXISTS qrtz_job_details;
DROP TABLE IF EXISTS qrtz_calendars;
DROP TABLE IF EXISTS qrtz_schedule_job;

CREATE TABLE qrtz_job_details (
  sched_name VARCHAR (120) NOT NULL,
  job_name VARCHAR (200) NOT NULL,
  job_group VARCHAR (200) NOT NULL,
  description VARCHAR (250) NULL,
  job_class_name VARCHAR (250) NOT NULL,
  is_durable VARCHAR (1) NOT NULL,
  is_nonconcurrent VARCHAR (1) NOT NULL,
  is_update_data VARCHAR (1) NOT NULL,
  requests_recovery VARCHAR (1) NOT NULL,
  job_data BLOB NULL,
  PRIMARY KEY (sched_name, job_name, job_group)
) ENGINE = INNODB;

CREATE TABLE qrtz_triggers (
  sched_name VARCHAR (120) NOT NULL,
  trigger_name VARCHAR (200) NOT NULL,
  trigger_group VARCHAR (200) NOT NULL,
  job_name VARCHAR (200) NOT NULL,
  job_group VARCHAR (200) NOT NULL,
  description VARCHAR (250) NULL,
  next_fire_time BIGINT (13) NULL,
  prev_fire_time BIGINT (13) NULL,
  priority INTEGER NULL,
  trigger_state VARCHAR (16) NOT NULL,
  trigger_type VARCHAR (8) NOT NULL,
  start_time BIGINT (13) NOT NULL,
  end_time BIGINT (13) NULL,
  calendar_name VARCHAR (200) NULL,
  misfire_instr SMALLINT (2) NULL,
  job_data BLOB NULL,
  PRIMARY KEY (
    sched_name,
    trigger_name,
    trigger_group
  ),
  FOREIGN KEY (sched_name, job_name, job_group) REFERENCES qrtz_job_details (sched_name, job_name, job_group)
) ENGINE = INNODB;

CREATE TABLE qrtz_simple_triggers (
  sched_name VARCHAR (120) NOT NULL,
  trigger_name VARCHAR (200) NOT NULL,
  trigger_group VARCHAR (200) NOT NULL,
  repeat_count BIGINT (7) NOT NULL,
  repeat_interval BIGINT (12) NOT NULL,
  times_triggered BIGINT (10) NOT NULL,
  PRIMARY KEY (
    sched_name,
    trigger_name,
    trigger_group
  ),
  FOREIGN KEY (
    sched_name,
    trigger_name,
    trigger_group
  ) REFERENCES qrtz_triggers (
    sched_name,
    trigger_name,
    trigger_group
  )
) ENGINE = INNODB;

CREATE TABLE qrtz_cron_triggers (
  sched_name VARCHAR (120) NOT NULL,
  trigger_name VARCHAR (200) NOT NULL,
  trigger_group VARCHAR (200) NOT NULL,
  cron_expression VARCHAR (120) NOT NULL,
  time_zone_id VARCHAR (80),
  PRIMARY KEY (
    sched_name,
    trigger_name,
    trigger_group
  ),
  FOREIGN KEY (
    sched_name,
    trigger_name,
    trigger_group
  ) REFERENCES qrtz_triggers (
    sched_name,
    trigger_name,
    trigger_group
  )
) ENGINE = INNODB;

CREATE TABLE qrtz_simprop_triggers (
  sched_name VARCHAR (120) NOT NULL,
  trigger_name VARCHAR (200) NOT NULL,
  trigger_group VARCHAR (200) NOT NULL,
  str_prop_1 VARCHAR (512) NULL,
  str_prop_2 VARCHAR (512) NULL,
  str_prop_3 VARCHAR (512) NULL,
  int_prop_1 INT NULL,
  int_prop_2 INT NULL,
  long_prop_1 BIGINT NULL,
  long_prop_2 BIGINT NULL,
  dec_prop_1 NUMERIC (13, 4) NULL,
  dec_prop_2 NUMERIC (13, 4) NULL,
  bool_prop_1 VARCHAR (1) NULL,
  bool_prop_2 VARCHAR (1) NULL,
  PRIMARY KEY (
    sched_name,
    trigger_name,
    trigger_group
  ),
  FOREIGN KEY (
    sched_name,
    trigger_name,
    trigger_group
  ) REFERENCES qrtz_triggers (
    sched_name,
    trigger_name,
    trigger_group
  )
) ENGINE = INNODB;

CREATE TABLE qrtz_blob_triggers (
  sched_name VARCHAR (120) NOT NULL,
  trigger_name VARCHAR (200) NOT NULL,
  trigger_group VARCHAR (200) NOT NULL,
  blob_data BLOB NULL,
  PRIMARY KEY (
    sched_name,
    trigger_name,
    trigger_group
  ),
  INDEX (
    sched_name,
    trigger_name,
    trigger_group
  ),
  FOREIGN KEY (
    sched_name,
    trigger_name,
    trigger_group
  ) REFERENCES qrtz_triggers (
    sched_name,
    trigger_name,
    trigger_group
  )
) ENGINE = INNODB;

CREATE TABLE qrtz_calendars (
  sched_name VARCHAR (120) NOT NULL,
  calendar_name VARCHAR (200) NOT NULL,
  calendar BLOB NOT NULL,
  PRIMARY KEY (sched_name, calendar_name)
) ENGINE = INNODB;

CREATE TABLE qrtz_paused_trigger_grps (
  sched_name VARCHAR (120) NOT NULL,
  trigger_group VARCHAR (200) NOT NULL,
  PRIMARY KEY (sched_name, trigger_group)
) ENGINE = INNODB;

CREATE TABLE qrtz_fired_triggers (
  sched_name VARCHAR (120) NOT NULL,
  entry_id VARCHAR (95) NOT NULL,
  trigger_name VARCHAR (200) NOT NULL,
  trigger_group VARCHAR (200) NOT NULL,
  instance_name VARCHAR (200) NOT NULL,
  fired_time BIGINT (13) NOT NULL,
  sched_time BIGINT (13) NOT NULL,
  priority INTEGER NOT NULL,
  state VARCHAR (16) NOT NULL,
  job_name VARCHAR (200) NULL,
  job_group VARCHAR (200) NULL,
  is_nonconcurrent VARCHAR (1) NULL,
  requests_recovery VARCHAR (1) NULL,
  PRIMARY KEY (sched_name, entry_id)
) ENGINE = INNODB;

CREATE TABLE qrtz_scheduler_state (
  sched_name VARCHAR (120) NOT NULL,
  instance_name VARCHAR (200) NOT NULL,
  last_checkin_time BIGINT (13) NOT NULL,
  checkin_interval BIGINT (13) NOT NULL,
  PRIMARY KEY (sched_name, instance_name)
) ENGINE = INNODB;

CREATE TABLE qrtz_locks (
  sched_name VARCHAR (120) NOT NULL,
  lock_name VARCHAR (40) NOT NULL,
  PRIMARY KEY (sched_name, lock_name)
) ENGINE = INNODB;

CREATE TABLE `qrtz_schedule_job` (
  id VARCHAR (64) NOT NULL DEFAULT '' COMMENT '主键',
  job_name VARCHAR (255) DEFAULT NULL COMMENT '任务名称',
  alias_name VARCHAR (255) DEFAULT NULL COMMENT '任务别名',
  job_group VARCHAR (255) DEFAULT NULL COMMENT '任务分组',
  job_trigger VARCHAR (255) DEFAULT NULL COMMENT '触发器',
  STATUS VARCHAR (255) DEFAULT NULL COMMENT '任务状态',
  cron_expression VARCHAR (255) DEFAULT NULL COMMENT 'CRON表达式',
  is_sync VARCHAR (1) NOT NULL COMMENT '是否异步',
  url VARCHAR (255) DEFAULT NULL COMMENT '执行地址',
  create_by VARCHAR (64) DEFAULT NULL COMMENT '创建者',
  create_date DATETIME DEFAULT NULL COMMENT '创建时间',
  update_by VARCHAR (64) DEFAULT NULL COMMENT '更新者',
  update_date DATETIME DEFAULT NULL COMMENT '更新时间',
  remarks VARCHAR (257) DEFAULT NULL COMMENT '备注信息',
  del_flag VARCHAR (64) DEFAULT NULL COMMENT '逻辑删除标记（0：显示；1：隐藏）',
  PRIMARY KEY (`id`)
) ENGINE = INNODB DEFAULT CHARSET = utf8 COMMENT = '任务调度';

CREATE INDEX idx_qrtz_j_req_recovery ON qrtz_job_details(sched_name,requests_recovery);
CREATE INDEX idx_qrtz_j_grp ON qrtz_job_details(sched_name,job_group);

CREATE INDEX idx_qrtz_t_j ON qrtz_triggers(sched_name,job_name,job_group);
CREATE INDEX idx_qrtz_t_jg ON qrtz_triggers(sched_name,job_group);
CREATE INDEX idx_qrtz_t_c ON qrtz_triggers(sched_name,calendar_name);
CREATE INDEX idx_qrtz_t_g ON qrtz_triggers(sched_name,trigger_group);
CREATE INDEX idx_qrtz_t_state ON qrtz_triggers(sched_name,trigger_state);
CREATE INDEX idx_qrtz_t_n_state ON qrtz_triggers(sched_name,trigger_name,trigger_group,trigger_state);
CREATE INDEX idx_qrtz_t_n_g_state ON qrtz_triggers(sched_name,trigger_group,trigger_state);
CREATE INDEX idx_qrtz_t_next_fire_time ON qrtz_triggers(sched_name,next_fire_time);
CREATE INDEX idx_qrtz_t_nft_st ON qrtz_triggers(sched_name,trigger_state,next_fire_time);
CREATE INDEX idx_qrtz_t_nft_misfire ON qrtz_triggers(sched_name,misfire_instr,next_fire_time);
CREATE INDEX idx_qrtz_t_nft_st_misfire ON qrtz_triggers(sched_name,misfire_instr,next_fire_time,trigger_state);
CREATE INDEX idx_qrtz_t_nft_st_misfire_grp ON qrtz_triggers(sched_name,misfire_instr,next_fire_time,trigger_group,trigger_state);

CREATE INDEX idx_qrtz_ft_trig_inst_name ON qrtz_fired_triggers(sched_name,instance_name);
CREATE INDEX idx_qrtz_ft_inst_job_req_rcvry ON qrtz_fired_triggers(sched_name,instance_name,requests_recovery);
CREATE INDEX idx_qrtz_ft_j_g ON qrtz_fired_triggers(sched_name,job_name,job_group);
CREATE INDEX idx_qrtz_ft_jg ON qrtz_fired_triggers(sched_name,job_group);
CREATE INDEX idx_qrtz_ft_t_g ON qrtz_fired_triggers(sched_name,trigger_name,trigger_group);
CREATE INDEX idx_qrtz_ft_tg ON qrtz_fired_triggers(sched_name,trigger_group);

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
