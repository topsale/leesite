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

import com.funtl.leesite.common.persistence.DataEntity;
import com.funtl.leesite.common.utils.excel.annotation.ExcelField;

/**
 * 短信配置Entity
 * @author Lusifer
 * @version 2017-05-04
 */
public class ConfigSmsTemplate extends DataEntity<ConfigSmsTemplate> {
	
	private static final long serialVersionUID = 1L;
	private String smsTemplateName;		// 模板名称
	private String smsTemplateCode;		// 模板编码
	private String smsTemplateType;		// 模板类型
	private String smsTemplateContent;		// 短信内容
	private ConfigSms configSms;		// 外键 父类
	
	public ConfigSmsTemplate() {
		super();
	}

	public ConfigSmsTemplate(String id){
		super(id);
	}

	public ConfigSmsTemplate(ConfigSms configSms){
		this.configSms = configSms;
	}

	@Length(min=1, max=20, message="模板名称长度必须介于 1 和 20 之间")
	@ExcelField(title="模板名称", align=2, sort=1)
	public String getSmsTemplateName() {
		return smsTemplateName;
	}

	public void setSmsTemplateName(String smsTemplateName) {
		this.smsTemplateName = smsTemplateName;
	}
	
	@Length(min=1, max=64, message="模板编码长度必须介于 1 和 64 之间")
	@ExcelField(title="模板编码", align=2, sort=2)
	public String getSmsTemplateCode() {
		return smsTemplateCode;
	}

	public void setSmsTemplateCode(String smsTemplateCode) {
		this.smsTemplateCode = smsTemplateCode;
	}
	
	@Length(min=1, max=2, message="模板类型长度必须介于 1 和 2 之间")
	@ExcelField(title="模板类型", dictType="sms_template_type", align=2, sort=3)
	public String getSmsTemplateType() {
		return smsTemplateType;
	}

	public void setSmsTemplateType(String smsTemplateType) {
		this.smsTemplateType = smsTemplateType;
	}
	
	@Length(min=1, max=755, message="短信内容长度必须介于 1 和 755 之间")
	@ExcelField(title="短信内容", align=2, sort=4)
	public String getSmsTemplateContent() {
		return smsTemplateContent;
	}

	public void setSmsTemplateContent(String smsTemplateContent) {
		this.smsTemplateContent = smsTemplateContent;
	}
	
	@Length(min=1, max=64, message="外键长度必须介于 1 和 64 之间")
	public ConfigSms getConfigSms() {
		return configSms;
	}

	public void setConfigSms(ConfigSms configSms) {
		this.configSms = configSms;
	}
	
}