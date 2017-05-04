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
package com.funtl.leesite.modules.config.entity;

import org.hibernate.validator.constraints.Length;
import javax.validation.constraints.NotNull;

import com.funtl.leesite.common.persistence.DataEntity;
import com.funtl.leesite.common.utils.excel.annotation.ExcelField;

/**
 * 邮箱配置Entity
 * @author Lusifer
 * @version 2017-05-04
 */
public class ConfigMail extends DataEntity<ConfigMail> {
	
	private static final long serialVersionUID = 1L;
	private String mailHost;		// 主机名
	private Integer mailPort;		// 主机端口
	private String mailUsername;		// 邮箱地址
	private String mailPassword;		// 邮箱密码
	private String mailFrom;		// 发件人昵称
	private String mailSsl;		// 使用SSL/TLS
	
	public ConfigMail() {
		super();
	}

	public ConfigMail(String id){
		super(id);
	}

	@Length(min=1, max=100, message="主机名长度必须介于 1 和 100 之间")
	@ExcelField(title="主机名", align=2, sort=1)
	public String getMailHost() {
		return mailHost;
	}

	public void setMailHost(String mailHost) {
		this.mailHost = mailHost;
	}
	
	@NotNull(message="主机端口不能为空")
	@ExcelField(title="主机端口", align=2, sort=2)
	public Integer getMailPort() {
		return mailPort;
	}

	public void setMailPort(Integer mailPort) {
		this.mailPort = mailPort;
	}
	
	@Length(min=1, max=100, message="邮箱地址长度必须介于 1 和 100 之间")
	@ExcelField(title="邮箱地址", align=2, sort=3)
	public String getMailUsername() {
		return mailUsername;
	}

	public void setMailUsername(String mailUsername) {
		this.mailUsername = mailUsername;
	}
	
	@Length(min=1, max=100, message="邮箱密码长度必须介于 1 和 100 之间")
	@ExcelField(title="邮箱密码", align=2, sort=4)
	public String getMailPassword() {
		return mailPassword;
	}

	public void setMailPassword(String mailPassword) {
		this.mailPassword = mailPassword;
	}
	
	@Length(min=1, max=100, message="发件人昵称长度必须介于 1 和 100 之间")
	@ExcelField(title="发件人昵称", align=2, sort=5)
	public String getMailFrom() {
		return mailFrom;
	}

	public void setMailFrom(String mailFrom) {
		this.mailFrom = mailFrom;
	}
	
	@Length(min=1, max=1, message="使用SSL/TLS长度必须介于 1 和 1 之间")
	@ExcelField(title="使用SSL/TLS", align=2, sort=6)
	public String getMailSsl() {
		return mailSsl;
	}

	public void setMailSsl(String mailSsl) {
		this.mailSsl = mailSsl;
	}
	
}