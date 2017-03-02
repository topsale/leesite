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

package com.funtl.leesite.modules.sys.entity;

import com.funtl.leesite.common.persistence.DataEntity;
import com.funtl.leesite.common.utils.excel.annotation.ExcelField;

import org.hibernate.validator.constraints.Length;

/**
 * 系统配置Entity
 *
 * @author Lusifer
 * @version 2016-02-07
 */
public class SystemConfig extends DataEntity<SystemConfig> {

	private static final long serialVersionUID = 1L;
	private String smtp;        // 邮箱服务器地址
	private String port;        // 邮箱服务器端口
	private String mailName;        // 系统邮箱地址
	private String mailPassword;        // 系统邮箱密码
	private String smsName;        // 短信用户名
	private String smsPassword;        // 短信密码
	private boolean test = false;

	public SystemConfig() {
		super();
	}

	public SystemConfig(String id) {
		super(id);
	}

	@Length(min = 0, max = 64, message = "邮箱服务器地址长度必须介于 0 和 64 之间")
	@ExcelField(title = "邮箱服务器地址", align = 2, sort = 1)
	public String getSmtp() {
		return smtp;
	}

	public void setSmtp(String smtp) {
		this.smtp = smtp;
	}

	@Length(min = 0, max = 64, message = "邮箱服务器端口长度必须介于 0 和 64 之间")
	@ExcelField(title = "邮箱服务器端口", align = 2, sort = 2)
	public String getPort() {
		return port;
	}

	public void setPort(String port) {
		this.port = port;
	}

	@Length(min = 0, max = 64, message = "系统邮箱地址长度必须介于 0 和 64 之间")
	@ExcelField(title = "系统邮箱地址", align = 2, sort = 3)
	public String getMailName() {
		return mailName;
	}

	public void setMailName(String mailName) {
		this.mailName = mailName;
	}

	@Length(min = 0, max = 64, message = "系统邮箱密码长度必须介于 0 和 64 之间")
	@ExcelField(title = "系统邮箱密码", align = 2, sort = 4)
	public String getMailPassword() {
		return mailPassword;
	}

	public void setMailPassword(String mailPassword) {
		this.mailPassword = mailPassword;
	}

	@Length(min = 0, max = 64, message = "短信用户名长度必须介于 0 和 64 之间")
	@ExcelField(title = "短信用户名", align = 2, sort = 5)
	public String getSmsName() {
		return smsName;
	}

	public void setSmsName(String smsName) {
		this.smsName = smsName;
	}

	@Length(min = 0, max = 64, message = "短信密码长度必须介于 0 和 64 之间")
	@ExcelField(title = "短信密码", align = 2, sort = 6)
	public String getSmsPassword() {
		return smsPassword;
	}

	public void setSmsPassword(String smsPassword) {
		this.smsPassword = smsPassword;
	}

	public void setTest(boolean test) {
		this.test = test;
	}

	public boolean isTest() {
		return test;
	}

}