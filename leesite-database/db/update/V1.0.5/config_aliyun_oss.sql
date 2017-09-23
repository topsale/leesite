USE `leesite`;

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

/*Data for the table `config_aliyun_oss` */

insert  into `config_aliyun_oss`(`id`,`oss_key`,`oss_secret`,`bucket_name`,`oss_end_point`,`auto_create_bucket`,`baidu_use_status`,`use_cdn`,`cdn_end_point`) values ('1','oss_key','oss_secret','bucket_name','oss_end_point','0','1','0','cdn_end_point');

/*Data for the table `sys_menu` */

INSERT INTO `sys_menu` (`id`, `parent_id`, `parent_ids`, `name`, `sort`, `href`, `target`, `icon`, `is_show`, `permission`, `create_by`, `create_date`, `update_by`, `update_date`, `remarks`, `del_flag`) VALUES ('c9dd1e4a96d64aa3925ee948f871eb02', '1', '0,1,', '阿里云配置', '61', '', '', 'icon-cloud-upload', '1', '', '1', '2017-05-28 01:29:39', '1', '2017-05-28 01:29:39', '', '0');
INSERT INTO `sys_menu` (`id`, `parent_id`, `parent_ids`, `name`, `sort`, `href`, `target`, `icon`, `is_show`, `permission`, `create_by`, `create_date`, `update_by`, `update_date`, `remarks`, `del_flag`) VALUES ('87476f51daf44cf48b77149d0121816a', 'c9dd1e4a96d64aa3925ee948f871eb02', '0,1,c9dd1e4a96d64aa3925ee948f871eb02,', '对象存储 OSS', '30', '/aliyun/configAliyunOss/form?id=1', '', '', '1', '', '1', '2017-05-28 01:30:28', '1', '2017-05-28 01:31:10', '', '0');
INSERT INTO `sys_menu` (`id`, `parent_id`, `parent_ids`, `name`, `sort`, `href`, `target`, `icon`, `is_show`, `permission`, `create_by`, `create_date`, `update_by`, `update_date`, `remarks`, `del_flag`) VALUES ('4b4d4e7f2be8429380d1a2b5141de5a2', '87476f51daf44cf48b77149d0121816a', '0,1,c9dd1e4a96d64aa3925ee948f871eb02,87476f51daf44cf48b77149d0121816a,', '编辑', '60', '', '', '', '0', 'aliyun:configAliyunOss:edit', '1', '2017-05-28 01:32:13', '1', '2017-05-28 01:32:13', '', '0');
INSERT INTO `sys_menu` (`id`, `parent_id`, `parent_ids`, `name`, `sort`, `href`, `target`, `icon`, `is_show`, `permission`, `create_by`, `create_date`, `update_by`, `update_date`, `remarks`, `del_flag`) VALUES ('65affbf57e7d4018b612f025661fdc23', '87476f51daf44cf48b77149d0121816a', '0,1,c9dd1e4a96d64aa3925ee948f871eb02,87476f51daf44cf48b77149d0121816a,', '查看', '30', '', '', '', '0', 'aliyun:configAliyunOss:view', '1', '2017-05-28 01:31:59', '1', '2017-05-28 01:31:59', '', '0');
