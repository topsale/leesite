USE `leesite`;

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

/*Data for the table `config_aliyun_push` */

INSERT INTO `config_aliyun_push` (`id`, `access_key_id`, `access_key_secret`, `app_key`, `region_id`) VALUES ('1', '_YOUR_ACCESS_KEY_ID_HERE_', '_YOUR_ACCESS_KEY_SECRET_HERE_', '_YOUR_APP_KEY_HERE_', 'cn-hangzhou');

/*Data for the table `sys_menu` */

INSERT INTO `sys_menu` (`id`, `parent_id`, `parent_ids`, `name`, `sort`, `href`, `target`, `icon`, `is_show`, `permission`, `create_by`, `create_date`, `update_by`, `update_date`, `remarks`, `del_flag`) VALUES ('42d0ed6020c444aabd4c30c214792d48', 'c9dd1e4a96d64aa3925ee948f871eb02', '0,1,c9dd1e4a96d64aa3925ee948f871eb02,', '移动推送', '60', '/aliyun/configAliyunPush/form?id=1', '', '', '1', '', '1', '2017-09-23 12:50:46', '1', '2017-09-23 12:51:19', '', '0');
INSERT INTO `sys_menu` (`id`, `parent_id`, `parent_ids`, `name`, `sort`, `href`, `target`, `icon`, `is_show`, `permission`, `create_by`, `create_date`, `update_by`, `update_date`, `remarks`, `del_flag`) VALUES ('b0af18e4443d41eb953fae46ccf60a80', '42d0ed6020c444aabd4c30c214792d48', '0,1,c9dd1e4a96d64aa3925ee948f871eb02,42d0ed6020c444aabd4c30c214792d48,', '查看', '30', '', '', '', '0', 'aliyun:configAliyunPush:view', '1', '2017-09-23 12:51:50', '1', '2017-09-23 12:51:50', '', '0');
INSERT INTO `sys_menu` (`id`, `parent_id`, `parent_ids`, `name`, `sort`, `href`, `target`, `icon`, `is_show`, `permission`, `create_by`, `create_date`, `update_by`, `update_date`, `remarks`, `del_flag`) VALUES ('e9a5aa861d3f40c98fc7bfbaa3bd0312', '42d0ed6020c444aabd4c30c214792d48', '0,1,c9dd1e4a96d64aa3925ee948f871eb02,42d0ed6020c444aabd4c30c214792d48,', '编辑', '60', '', '', '', '0', 'aliyun:configAliyunPush:edit', '1', '2017-09-23 12:52:06', '1', '2017-09-23 12:52:06', '', '0');