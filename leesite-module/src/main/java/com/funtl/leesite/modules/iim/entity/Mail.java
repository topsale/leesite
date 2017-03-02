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

import java.util.List;

import com.funtl.leesite.common.persistence.DataEntity;
import com.google.common.collect.Lists;

import org.hibernate.validator.constraints.Length;


/**
 * 发件箱Entity
 *
 * @author Lusifer
 * @version 2015-11-15
 */
public class Mail extends DataEntity<Mail> {

	private static final long serialVersionUID = 1L;
	private String title;        // 标题
	private String overview;        // 内容概要
	private String content;        // 内容
	private List<MailBox> mailBoxList = Lists.newArrayList();        // 子表列表
	private List<MailCompose> mailComposeList = Lists.newArrayList();        // 子表列表

	public Mail() {
		super();
	}

	public Mail(String id) {
		super(id);
	}

	@Length(min = 0, max = 128, message = "标题长度必须介于 0 和 128 之间")
	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	@Length(min = 0, max = 128, message = "内容概要长度必须介于 0 和 128 之间")
	public String getOverview() {
		return overview;
	}

	public void setOverview(String overview) {
		this.overview = overview;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public List<MailBox> getMailBoxList() {
		return mailBoxList;
	}

	public void setMailBoxList(List<MailBox> mailBoxList) {
		this.mailBoxList = mailBoxList;
	}

	public List<MailCompose> getMailComposeList() {
		return mailComposeList;
	}

	public void setMailComposeList(List<MailCompose> mailComposeList) {
		this.mailComposeList = mailComposeList;
	}
}