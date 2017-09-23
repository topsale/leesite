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
package com.funtl.leesite.modules.aliyun.entity;

import com.funtl.leesite.common.persistence.DataEntity;
import com.funtl.leesite.common.utils.excel.annotation.ExcelField;

import org.hibernate.validator.constraints.Length;

/**
 * 阿里云配置Entity
 *
 * @author Lusifer
 * @version 2017-09-23
 */
public class ConfigAliyunPush extends DataEntity<ConfigAliyunPush> {

	private static final long serialVersionUID = 1L;
	private String accessKeyId;        // Key
	private String accessKeySecret;        // Secret
	private String appKey;        // AppKey
	private String regionId;        // RegionId

	public ConfigAliyunPush() {
		super();
	}

	public ConfigAliyunPush(String id) {
		super(id);
	}

	@Length(min = 0, max = 64, message = "Key长度必须介于 0 和 64 之间")
	@ExcelField(title = "Key", align = 2, sort = 1)
	public String getAccessKeyId() {
		return accessKeyId;
	}

	public void setAccessKeyId(String accessKeyId) {
		this.accessKeyId = accessKeyId;
	}

	@Length(min = 0, max = 64, message = "Secret长度必须介于 0 和 64 之间")
	@ExcelField(title = "Secret", align = 2, sort = 2)
	public String getAccessKeySecret() {
		return accessKeySecret;
	}

	public void setAccessKeySecret(String accessKeySecret) {
		this.accessKeySecret = accessKeySecret;
	}

	@Length(min = 0, max = 64, message = "AppKey长度必须介于 0 和 64 之间")
	@ExcelField(title = "AppKey", align = 2, sort = 3)
	public String getAppKey() {
		return appKey;
	}

	public void setAppKey(String appKey) {
		this.appKey = appKey;
	}

	@Length(min = 0, max = 64, message = "RegionId长度必须介于 0 和 64 之间")
	@ExcelField(title = "RegionId", align = 2, sort = 4)
	public String getRegionId() {
		return regionId;
	}

	public void setRegionId(String regionId) {
		this.regionId = regionId;
	}

}