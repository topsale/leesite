/*
 * Copyright 2015-2017 the original author or authors.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
package com.funtl.leesite.modules.tools.entity;

import com.funtl.leesite.common.persistence.DataEntity;
import com.funtl.leesite.common.utils.excel.annotation.ExcelField;

import org.hibernate.validator.constraints.Length;

/**
 * 任务调度Entity
 *
 * @author Lusifer
 * @version 2017-09-26
 */
public class QrtzScheduleJob extends DataEntity<QrtzScheduleJob> {

	/**
	 * 任务调度的参数key
	 */
	public static final String JOB_PARAM_KEY = "jobParam";

	private static final long serialVersionUID = 1L;
	private String jobName;        // 任务名称
	private String aliasName;        // 任务别名
	private String jobGroup;        // 任务分组
	private String jobTrigger;        // 触发器
	private String status;        // 任务状态
	private String cronExpression;        // CRON
	private String isSync;        // 是否异步
	private String url;        // 执行地址

	private String normal; // 正常状态

	public QrtzScheduleJob() {
		super();
	}

	public QrtzScheduleJob(String id) {
		super(id);
	}

	@Length(min = 0, max = 255, message = "任务名称长度必须介于 0 和 255 之间")
	@ExcelField(title = "任务名称", align = 2, sort = 1)
	public String getJobName() {
		return jobName;
	}

	public void setJobName(String jobName) {
		this.jobName = jobName;
	}

	@Length(min = 0, max = 255, message = "任务别名长度必须介于 0 和 255 之间")
	@ExcelField(title = "任务别名", align = 2, sort = 2)
	public String getAliasName() {
		return aliasName;
	}

	public void setAliasName(String aliasName) {
		this.aliasName = aliasName;
	}

	@Length(min = 0, max = 255, message = "任务分组长度必须介于 0 和 255 之间")
	@ExcelField(title = "任务分组", align = 2, sort = 3)
	public String getJobGroup() {
		return jobGroup;
	}

	public void setJobGroup(String jobGroup) {
		this.jobGroup = jobGroup;
	}

	@Length(min = 0, max = 255, message = "触发器长度必须介于 0 和 255 之间")
	@ExcelField(title = "触发器", align = 2, sort = 4)
	public String getJobTrigger() {
		return jobTrigger;
	}

	public void setJobTrigger(String jobTrigger) {
		this.jobTrigger = jobTrigger;
	}

	@Length(min = 0, max = 255, message = "任务状态长度必须介于 0 和 255 之间")
	@ExcelField(title = "任务状态", align = 2, sort = 5)
	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	@Length(min = 0, max = 255, message = "CRON长度必须介于 0 和 255 之间")
	@ExcelField(title = "CRON", align = 2, sort = 6)
	public String getCronExpression() {
		return cronExpression;
	}

	public void setCronExpression(String cronExpression) {
		this.cronExpression = cronExpression;
	}

	@Length(min = 1, max = 1, message = "是否异步长度必须介于 1 和 1 之间")
	@ExcelField(title = "是否异步", dictType = "yes_no", align = 2, sort = 7)
	public String getIsSync() {
		return isSync;
	}

	public void setIsSync(String isSync) {
		this.isSync = isSync;
	}

	@Length(min = 0, max = 255, message = "执行地址长度必须介于 0 和 255 之间")
	@ExcelField(title = "执行地址", align = 2, sort = 8)
	public String getUrl() {
		return url;
	}

	public void setUrl(String url) {
		this.url = url;
	}

	public String getNormal() {
		return normal;
	}

	public void setNormal(String normal) {
		this.normal = normal;
	}
}