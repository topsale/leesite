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

package com.funtl.leesite.modules.echarts.entity;

import com.funtl.leesite.common.persistence.DataEntity;
import com.funtl.leesite.common.utils.excel.annotation.ExcelField;

import org.hibernate.validator.constraints.Length;

/**
 * 班级Entity
 *
 * @author lgf
 * @version 2016-05-26
 */
public class PieClass extends DataEntity<PieClass> {

	private static final long serialVersionUID = 1L;
	private String className;        // 班级
	private Integer num;        // 人数

	public PieClass() {
		super();
	}

	public PieClass(String id) {
		super(id);
	}

	@Length(min = 0, max = 64, message = "班级长度必须介于 0 和 64 之间")
	@ExcelField(title = "班级", align = 2, sort = 7)
	public String getClassName() {
		return className;
	}

	public void setClassName(String className) {
		this.className = className;
	}

	@ExcelField(title = "人数", align = 2, sort = 8)
	public Integer getNum() {
		return num;
	}

	public void setNum(Integer num) {
		this.num = num;
	}

}