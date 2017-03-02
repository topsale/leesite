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

package com.funtl.leesite.modules.oa.entity;

import java.util.Date;

import com.funtl.leesite.common.persistence.DataEntity;
import com.funtl.leesite.modules.sys.entity.User;

import org.hibernate.validator.constraints.Length;


/**
 * 通知通告记录Entity
 *
 * @author Lusifer
 * @version 2014-05-16
 */
public class OaNotifyRecord extends DataEntity<OaNotifyRecord> {

	private static final long serialVersionUID = 1L;
	private OaNotify oaNotify;        // 通知通告ID
	private User user;        // 接受人
	private String readFlag;        // 阅读标记（0：未读；1：已读）
	private Date readDate;        // 阅读时间


	public OaNotifyRecord() {
		super();
	}

	public OaNotifyRecord(String id) {
		super(id);
	}

	public OaNotifyRecord(OaNotify oaNotify) {
		this.oaNotify = oaNotify;
	}

	public OaNotify getOaNotify() {
		return oaNotify;
	}

	public void setOaNotify(OaNotify oaNotify) {
		this.oaNotify = oaNotify;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	@Length(min = 0, max = 1, message = "阅读标记（0：未读；1：已读）长度必须介于 0 和 1 之间")
	public String getReadFlag() {
		return readFlag;
	}

	public void setReadFlag(String readFlag) {
		this.readFlag = readFlag;
	}

	public Date getReadDate() {
		return readDate;
	}

	public void setReadDate(Date readDate) {
		this.readDate = readDate;
	}

}