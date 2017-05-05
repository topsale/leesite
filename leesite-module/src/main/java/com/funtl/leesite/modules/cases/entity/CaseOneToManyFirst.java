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
package com.funtl.leesite.modules.cases.entity;

import org.hibernate.validator.constraints.Length;
import javax.validation.constraints.NotNull;

import com.funtl.leesite.common.persistence.DataEntity;
import com.funtl.leesite.common.utils.excel.annotation.ExcelField;

/**
 * 生成示例Entity
 * @author Lusifer
 * @version 2017-05-05
 */
public class CaseOneToManyFirst extends DataEntity<CaseOneToManyFirst> {
	
	private static final long serialVersionUID = 1L;
	private String startarea;		// 出发地
	private String endarea;		// 目的地
	private Double price;		// 代理价格
	private CaseOneToManyMain caseOneToManyMain;		// 外键 父类
	
	public CaseOneToManyFirst() {
		super();
	}

	public CaseOneToManyFirst(String id){
		super(id);
	}

	public CaseOneToManyFirst(CaseOneToManyMain caseOneToManyMain){
		this.caseOneToManyMain = caseOneToManyMain;
	}

	@Length(min=1, max=64, message="出发地长度必须介于 1 和 64 之间")
	@ExcelField(title="出发地", align=2, sort=1)
	public String getStartarea() {
		return startarea;
	}

	public void setStartarea(String startarea) {
		this.startarea = startarea;
	}
	
	@Length(min=1, max=64, message="目的地长度必须介于 1 和 64 之间")
	@ExcelField(title="目的地", align=2, sort=2)
	public String getEndarea() {
		return endarea;
	}

	public void setEndarea(String endarea) {
		this.endarea = endarea;
	}
	
	@NotNull(message="代理价格不能为空")
	@ExcelField(title="代理价格", align=2, sort=3)
	public Double getPrice() {
		return price;
	}

	public void setPrice(Double price) {
		this.price = price;
	}
	
	@Length(min=1, max=64, message="外键长度必须介于 1 和 64 之间")
	public CaseOneToManyMain getCaseOneToManyMain() {
		return caseOneToManyMain;
	}

	public void setCaseOneToManyMain(CaseOneToManyMain caseOneToManyMain) {
		this.caseOneToManyMain = caseOneToManyMain;
	}
	
}