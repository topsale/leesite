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

package com.funtl.leesite.modules.iim.entity;

import java.util.Date;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.funtl.leesite.common.persistence.DataEntity;
import com.funtl.leesite.modules.sys.entity.User;

import org.hibernate.validator.constraints.Length;


/**
 * 发件箱Entity
 *
 * @author Lusifer
 * @version 2015-11-15
 */
public class MailBox extends DataEntity<MailBox> {

	private static final long serialVersionUID = 1L;
	private String readstatus;        // 状态 0 未读 1 已读
	private User sender;        // 发件人
	private User receiver;        // 收件人
	private Date sendtime;        // 发送时间
	private Mail mail;        // 邮件外键 父类

	public MailBox() {
		super();
	}

	public MailBox(String id) {
		super(id);
	}

	public MailBox(Mail mail) {
		this.mail = mail;
	}

	@Length(min = 0, max = 45, message = "状态 0 未读 1 已读长度必须介于 0 和 45 之间")
	public String getReadstatus() {
		return readstatus;
	}

	public void setReadstatus(String readstatus) {
		this.readstatus = readstatus;
	}

	public User getSender() {
		return sender;
	}

	public void setSender(User sender) {
		this.sender = sender;
	}

	public User getReceiver() {
		return receiver;
	}

	public void setReceiver(User receiver) {
		this.receiver = receiver;
	}

	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	public Date getSendtime() {
		return sendtime;
	}

	public void setSendtime(Date sendtime) {
		this.sendtime = sendtime;
	}

	@Length(min = 0, max = 64, message = "邮件外键长度必须介于 0 和 64 之间")
	public Mail getMail() {
		return mail;
	}

	public void setMail(Mail mail) {
		this.mail = mail;
	}

}