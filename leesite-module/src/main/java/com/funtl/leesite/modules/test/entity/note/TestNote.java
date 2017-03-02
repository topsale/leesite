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

package com.funtl.leesite.modules.test.entity.note;

import com.funtl.leesite.common.persistence.DataEntity;
import com.funtl.leesite.common.utils.excel.annotation.ExcelField;

import org.hibernate.validator.constraints.Length;

/**
 * 富文本测试Entity
 *
 * @author Lusifer
 * @version 2016-05-06
 */
public class TestNote extends DataEntity<TestNote> {

	private static final long serialVersionUID = 1L;
	private String title;        // 标题
	private String contents;        // 内容

	public TestNote() {
		super();
	}

	public TestNote(String id) {
		super(id);
	}

	@Length(min = 0, max = 64, message = "标题长度必须介于 0 和 64 之间")
	@ExcelField(title = "标题", align = 2, sort = 7)
	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	@ExcelField(title = "内容", align = 2, sort = 8)
	public String getContents() {
		return contents;
	}

	public void setContents(String contents) {
		this.contents = contents;
	}

}