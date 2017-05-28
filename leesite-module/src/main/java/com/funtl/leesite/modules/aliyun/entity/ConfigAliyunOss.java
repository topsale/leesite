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

import org.hibernate.validator.constraints.Length;

import com.funtl.leesite.common.persistence.DataEntity;
import com.funtl.leesite.common.utils.excel.annotation.ExcelField;

/**
 * 阿里云配置Entity
 * @author Lusifer
 * @version 2017-05-28
 */
public class ConfigAliyunOss extends DataEntity<ConfigAliyunOss> {
	
	private static final long serialVersionUID = 1L;
	private String ossKey;		// Key
	private String ossSecret;		// Secret
	private String bucketName;		// Bucket Name
	private String ossEndPoint;		// OSS End Point
	private String autoCreateBucket;		// 自动创建 Bucket
	private String baiduUseStatus;		// 支持百度富文本
	private String useCdn;		// 启用 CDN
	private String cdnEndPoint;		// CDN End Point
	
	public ConfigAliyunOss() {
		super();
	}

	public ConfigAliyunOss(String id){
		super(id);
	}

	@Length(min=0, max=64, message="Key长度必须介于 0 和 64 之间")
	@ExcelField(title="Key", align=2, sort=1)
	public String getOssKey() {
		return ossKey;
	}

	public void setOssKey(String ossKey) {
		this.ossKey = ossKey;
	}
	
	@Length(min=0, max=64, message="Secret长度必须介于 0 和 64 之间")
	@ExcelField(title="Secret", align=2, sort=2)
	public String getOssSecret() {
		return ossSecret;
	}

	public void setOssSecret(String ossSecret) {
		this.ossSecret = ossSecret;
	}
	
	@Length(min=0, max=100, message="Bucket Name长度必须介于 0 和 100 之间")
	@ExcelField(title="Bucket Name", align=2, sort=3)
	public String getBucketName() {
		return bucketName;
	}

	public void setBucketName(String bucketName) {
		this.bucketName = bucketName;
	}
	
	@Length(min=0, max=100, message="OSS End Point长度必须介于 0 和 100 之间")
	@ExcelField(title="OSS End Point", align=2, sort=4)
	public String getOssEndPoint() {
		return ossEndPoint;
	}

	public void setOssEndPoint(String ossEndPoint) {
		this.ossEndPoint = ossEndPoint;
	}
	
	@Length(min=0, max=2, message="自动创建 Bucket长度必须介于 0 和 2 之间")
	@ExcelField(title="自动创建 Bucket", dictType="yes_no", align=2, sort=5)
	public String getAutoCreateBucket() {
		return autoCreateBucket;
	}

	public void setAutoCreateBucket(String autoCreateBucket) {
		this.autoCreateBucket = autoCreateBucket;
	}
	
	@Length(min=0, max=2, message="支持百度富文本长度必须介于 0 和 2 之间")
	@ExcelField(title="支持百度富文本", dictType="yes_no", align=2, sort=6)
	public String getBaiduUseStatus() {
		return baiduUseStatus;
	}

	public void setBaiduUseStatus(String baiduUseStatus) {
		this.baiduUseStatus = baiduUseStatus;
	}
	
	@Length(min=0, max=2, message="启用 CDN长度必须介于 0 和 2 之间")
	@ExcelField(title="启用 CDN", dictType="yes_no", align=2, sort=7)
	public String getUseCdn() {
		return useCdn;
	}

	public void setUseCdn(String useCdn) {
		this.useCdn = useCdn;
	}
	
	@Length(min=0, max=100, message="CDN End Point长度必须介于 0 和 100 之间")
	@ExcelField(title="CDN End Point", align=2, sort=8)
	public String getCdnEndPoint() {
		return cdnEndPoint;
	}

	public void setCdnEndPoint(String cdnEndPoint) {
		this.cdnEndPoint = cdnEndPoint;
	}
	
}