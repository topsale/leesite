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

package com.funtl.leesite.modules.test.entity.onetomany;

import javax.validation.constraints.NotNull;

import com.funtl.leesite.common.persistence.DataEntity;
import com.funtl.leesite.common.utils.excel.annotation.ExcelField;
import com.funtl.leesite.modules.sys.entity.Area;

import org.hibernate.validator.constraints.Length;

/**
 * 票务代理Entity
 *
 * @author Lusifer
 * @version 2016-06-22
 */
public class TestDataChild2 extends DataEntity<TestDataChild2> {

	private static final long serialVersionUID = 1L;
	private Area startArea;        // 出发地
	private Area endArea;        // 目的地
	private Double price;        // 代理价格
	private TestDataMain testDataMain;        // 外键 父类

	public TestDataChild2() {
		super();
	}

	public TestDataChild2(String id) {
		super(id);
	}

	public TestDataChild2(TestDataMain testDataMain) {
		this.testDataMain = testDataMain;
	}

	@NotNull(message = "出发地不能为空")
	@ExcelField(title = "出发地", fieldType = Area.class, value = "startArea.name", align = 2, sort = 1)
	public Area getStartArea() {
		return startArea;
	}

	public void setStartArea(Area startArea) {
		this.startArea = startArea;
	}

	@NotNull(message = "目的地不能为空")
	@ExcelField(title = "目的地", fieldType = Area.class, value = "endArea.name", align = 2, sort = 2)
	public Area getEndArea() {
		return endArea;
	}

	public void setEndArea(Area endArea) {
		this.endArea = endArea;
	}

	@ExcelField(title = "代理价格", align = 2, sort = 3)
	public Double getPrice() {
		return price;
	}

	public void setPrice(Double price) {
		this.price = price;
	}

	@Length(min = 1, max = 64, message = "外键长度必须介于 1 和 64 之间")
	public TestDataMain getTestDataMain() {
		return testDataMain;
	}

	public void setTestDataMain(TestDataMain testDataMain) {
		this.testDataMain = testDataMain;
	}

}