USE `leesite`;

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

INSERT INTO  `sys_menu` (`id`, `parent_id`, `parent_ids`, `name`, `sort`, `href`, `target`, `icon`, `is_show`, `permission`, `create_by`, `create_date`, `update_by`, `update_date`, `remarks`, `del_flag`) VALUES ('c9f37f09c5f74d8b8506ec5bee3cb467', '56e274e0ec1c41298e19ab46cf4e001f', '0,1,56e274e0ec1c41298e19ab46cf4e001f,', '任务调度', '180', '/tools/qrtzScheduleJob', '', '', '1', 'tools:qrtzScheduleJob:list', '1', '2017-09-26 17:54:04', '1', '2017-09-26 17:54:04', '', '0');
INSERT INTO  `sys_menu` (`id`, `parent_id`, `parent_ids`, `name`, `sort`, `href`, `target`, `icon`, `is_show`, `permission`, `create_by`, `create_date`, `update_by`, `update_date`, `remarks`, `del_flag`) VALUES ('1ffb74f0d2b14656b961d4b37ca0a6ba', 'c9f37f09c5f74d8b8506ec5bee3cb467', '0,1,56e274e0ec1c41298e19ab46cf4e001f,c9f37f09c5f74d8b8506ec5bee3cb467,', '查看', '30', '', '', '', '0', 'tools:qrtzScheduleJob:view', '1', '2017-09-26 17:55:36', '1', '2017-09-26 17:55:36', '', '0');
INSERT INTO  `sys_menu` (`id`, `parent_id`, `parent_ids`, `name`, `sort`, `href`, `target`, `icon`, `is_show`, `permission`, `create_by`, `create_date`, `update_by`, `update_date`, `remarks`, `del_flag`) VALUES ('36d28ea6fb294941a03a0f298fd3bf13', 'c9f37f09c5f74d8b8506ec5bee3cb467', '0,1,56e274e0ec1c41298e19ab46cf4e001f,c9f37f09c5f74d8b8506ec5bee3cb467,', '删除', '120', '', '', '', '0', 'tools:qrtzScheduleJob:del', '1', '2017-09-26 17:56:25', '1', '2017-09-26 17:56:25', '', '0');
INSERT INTO  `sys_menu` (`id`, `parent_id`, `parent_ids`, `name`, `sort`, `href`, `target`, `icon`, `is_show`, `permission`, `create_by`, `create_date`, `update_by`, `update_date`, `remarks`, `del_flag`) VALUES ('d5d5633f731349b08b6a3ae42b715135', 'c9f37f09c5f74d8b8506ec5bee3cb467', '0,1,56e274e0ec1c41298e19ab46cf4e001f,c9f37f09c5f74d8b8506ec5bee3cb467,', '增加', '90', '', '', '', '0', 'tools:qrtzScheduleJob:add', '1', '2017-09-26 17:56:08', '1', '2017-09-26 17:56:08', '', '0');
INSERT INTO  `sys_menu` (`id`, `parent_id`, `parent_ids`, `name`, `sort`, `href`, `target`, `icon`, `is_show`, `permission`, `create_by`, `create_date`, `update_by`, `update_date`, `remarks`, `del_flag`) VALUES ('f801afc1e89847d0b00937c28c0ecb79', 'c9f37f09c5f74d8b8506ec5bee3cb467', '0,1,56e274e0ec1c41298e19ab46cf4e001f,c9f37f09c5f74d8b8506ec5bee3cb467,', '修改', '60', '', '', '', '0', 'tools:qrtzScheduleJob:edit', '1', '2017-09-26 17:55:53', '1', '2017-09-26 17:55:53', '', '0');

INSERT INTO `qrtz_schedule_job` (`id`, `job_name`, `alias_name`, `job_group`, `job_trigger`, `status`, `cron_expression`, `is_sync`, `url`, `create_by`, `create_date`, `update_by`, `update_date`, `remarks`, `del_flag`) VALUES ('fe4b14794c3d47d7b0b5b32be27caa51', 'TestTask', '测试任务', 'test', 'TestTask', NULL, '0/10 * * * * ?', '1', 'http://localhost:8081/schedule/test/sayHi', '1', '2017-09-27 22:44:14', '1', '2017-09-27 23:26:14', '', '0');