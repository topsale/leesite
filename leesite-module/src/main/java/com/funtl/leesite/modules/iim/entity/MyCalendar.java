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

import com.funtl.leesite.common.persistence.DataEntity;
import com.funtl.leesite.common.utils.excel.annotation.ExcelField;
import com.funtl.leesite.modules.sys.entity.User;

import org.hibernate.validator.constraints.Length;

/**
 * 日历Entity
 *
 * @author Lusifer
 * @version 2016-04-19
 */
public class MyCalendar extends DataEntity<MyCalendar> {

	private static final long serialVersionUID = 1L;
	private String title;        // 事件标题
	private String start;        // 事件开始时间
	private String end;        // 事件结束时间
	private String adllDay;        // 是否为全天时间
	private String color;        // 时间的背景色
	private User user;        // 所属用户

	public MyCalendar() {
		super();
	}

	public MyCalendar(String id) {
		super(id);
	}

	@Length(min = 0, max = 64, message = "事件标题长度必须介于 0 和 64 之间")
	@ExcelField(title = "事件标题", align = 2, sort = 1)
	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	@Length(min = 0, max = 64, message = "事件开始时间长度必须介于 0 和 64 之间")
	@ExcelField(title = "事件开始时间", align = 2, sort = 2)
	public String getStart() {
		return start;
	}

	public void setStart(String start) {
		this.start = start;
	}

	@Length(min = 0, max = 64, message = "事件结束时间长度必须介于 0 和 64 之间")
	@ExcelField(title = "事件结束时间", align = 2, sort = 3)
	public String getEnd() {
		return end;
	}

	public void setEnd(String end) {
		this.end = end;
	}

	@Length(min = 0, max = 64, message = "是否为全天时间长度必须介于 0 和 64 之间")
	@ExcelField(title = "是否为全天时间", align = 2, sort = 4)
	public String getAdllDay() {
		return adllDay;
	}

	public void setAdllDay(String adllDay) {
		this.adllDay = adllDay;
	}

	@Length(min = 0, max = 64, message = "时间的背景色长度必须介于 0 和 64 之间")
	@ExcelField(title = "时间的背景色", align = 2, sort = 5)
	public String getColor() {
		return color;
	}

	public void setColor(String color) {
		this.color = color;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public User getUser() {
		return user;
	}

}