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

package com.funtl.leesite.modules.monitor.entity;

import com.funtl.leesite.common.persistence.DataEntity;
import com.funtl.leesite.common.utils.excel.annotation.ExcelField;

import org.hibernate.validator.constraints.Length;

/**
 * 系统监控Entity
 *
 * @author Lusifer
 * @version 2016-02-07
 */
public class Monitor extends DataEntity<Monitor> {

	private static final long serialVersionUID = 1L;
	private String cpu;        // cpu使用率
	private String jvm;        // jvm使用率
	private String ram;        // 内存使用率
	private String toEmail;        // 警告通知邮箱

	public Monitor() {
		super();
	}

	public Monitor(String id) {
		super(id);
	}

	@Length(min = 0, max = 64, message = "cpu使用率长度必须介于 0 和 64 之间")
	@ExcelField(title = "cpu使用率", align = 2, sort = 1)
	public String getCpu() {
		return cpu;
	}

	public void setCpu(String cpu) {
		this.cpu = cpu;
	}

	@Length(min = 0, max = 64, message = "jvm使用率长度必须介于 0 和 64 之间")
	@ExcelField(title = "jvm使用率", align = 2, sort = 2)
	public String getJvm() {
		return jvm;
	}

	public void setJvm(String jvm) {
		this.jvm = jvm;
	}

	@Length(min = 0, max = 64, message = "内存使用率长度必须介于 0 和 64 之间")
	@ExcelField(title = "内存使用率", align = 2, sort = 3)
	public String getRam() {
		return ram;
	}

	public void setRam(String ram) {
		this.ram = ram;
	}

	@Length(min = 0, max = 64, message = "警告通知邮箱长度必须介于 0 和 64 之间")
	@ExcelField(title = "警告通知邮箱", align = 2, sort = 4)
	public String getToEmail() {
		return toEmail;
	}

	public void setToEmail(String toEmail) {
		this.toEmail = toEmail;
	}

}