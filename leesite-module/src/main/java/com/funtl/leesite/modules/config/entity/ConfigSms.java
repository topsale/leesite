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

import java.util.List;

import com.funtl.leesite.common.persistence.DataEntity;
import com.funtl.leesite.common.utils.excel.annotation.ExcelField;
import com.google.common.collect.Lists;

import org.hibernate.validator.constraints.Length;

/**
 * 短信配置Entity
 * @author Lusifer
 * @version 2017-05-04
 */
public class ConfigSms extends DataEntity<ConfigSms> {
	
	private static final long serialVersionUID = 1L;
	private String smsAccessId;		// AccessId
	private String smsAccessKey;		// AccessKey
	private String smsMnsEndpoint;		// MNSEndpoint
	private String smsTopic;		// 主题
	private String smsSignName;		// 签名
	private String testNumber; // 测试手机
	private List<ConfigSmsTemplate> configSmsTemplateList = Lists.newArrayList();		// 子表列表
	
	public ConfigSms() {
		super();
	}

	public ConfigSms(String id){
		super(id);
	}

	@Length(min=1, max=64, message="AccessId长度必须介于 1 和 64 之间")
	@ExcelField(title="AccessId", align=2, sort=1)
	public String getSmsAccessId() {
		return smsAccessId;
	}

	public void setSmsAccessId(String smsAccessId) {
		this.smsAccessId = smsAccessId;
	}
	
	@Length(min=1, max=64, message="AccessKey长度必须介于 1 和 64 之间")
	@ExcelField(title="AccessKey", align=2, sort=2)
	public String getSmsAccessKey() {
		return smsAccessKey;
	}

	public void setSmsAccessKey(String smsAccessKey) {
		this.smsAccessKey = smsAccessKey;
	}
	
	@Length(min=1, max=255, message="MNSEndpoint长度必须介于 1 和 255 之间")
	@ExcelField(title="MNSEndpoint", align=2, sort=3)
	public String getSmsMnsEndpoint() {
		return smsMnsEndpoint;
	}

	public void setSmsMnsEndpoint(String smsMnsEndpoint) {
		this.smsMnsEndpoint = smsMnsEndpoint;
	}
	
	@Length(min=1, max=255, message="主题长度必须介于 1 和 255 之间")
	@ExcelField(title="主题", align=2, sort=4)
	public String getSmsTopic() {
		return smsTopic;
	}

	public void setSmsTopic(String smsTopic) {
		this.smsTopic = smsTopic;
	}
	
	@Length(min=1, max=20, message="签名长度必须介于 1 和 20 之间")
	@ExcelField(title="签名", align=2, sort=5)
	public String getSmsSignName() {
		return smsSignName;
	}

	public void setSmsSignName(String smsSignName) {
		this.smsSignName = smsSignName;
	}

	@Length(min=11, max=11, message="测试手机号必须满足11位")
	@ExcelField(title="测试手机", align=2, sort=5)
	public String getTestNumber() {
		return testNumber;
	}

	public void setTestNumber(String testNumber) {
		this.testNumber = testNumber;
	}
	
	public List<ConfigSmsTemplate> getConfigSmsTemplateList() {
		return configSmsTemplateList;
	}

	public void setConfigSmsTemplateList(List<ConfigSmsTemplate> configSmsTemplateList) {
		this.configSmsTemplateList = configSmsTemplateList;
	}
}