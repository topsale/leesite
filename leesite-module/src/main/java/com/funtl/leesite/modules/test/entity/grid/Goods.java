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

package com.funtl.leesite.modules.test.entity.grid;

import com.funtl.leesite.common.persistence.DataEntity;
import com.funtl.leesite.common.utils.excel.annotation.ExcelField;

import org.hibernate.validator.constraints.Length;

/**
 * 商品Entity
 *
 * @author Lusifer
 * @version 2016-05-06
 */
public class Goods extends DataEntity<Goods> {

	private static final long serialVersionUID = 1L;
	private String name;        // 商品名称
	private Category category;        // 所属类型
	private String price;        // 价格

	public Goods() {
		super();
	}

	public Goods(String id) {
		super(id);
	}

	@Length(min = 0, max = 64, message = "商品名称长度必须介于 0 和 64 之间")
	@ExcelField(title = "商品名称", align = 2, sort = 1)
	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	@ExcelField(title = "所属类型", align = 2, sort = 2)
	public Category getCategory() {
		return category;
	}

	public void setCategory(Category category) {
		this.category = category;
	}

	@Length(min = 0, max = 64, message = "价格长度必须介于 0 和 64 之间")
	@ExcelField(title = "价格", align = 2, sort = 3)
	public String getPrice() {
		return price;
	}

	public void setPrice(String price) {
		this.price = price;
	}

}