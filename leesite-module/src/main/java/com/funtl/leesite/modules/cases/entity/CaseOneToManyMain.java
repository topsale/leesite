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

import com.funtl.leesite.modules.sys.entity.User;
import javax.validation.constraints.NotNull;
import com.funtl.leesite.modules.sys.entity.Office;
import com.funtl.leesite.modules.sys.entity.Area;
import org.hibernate.validator.constraints.Length;
import java.util.Date;
import com.fasterxml.jackson.annotation.JsonFormat;
import java.util.List;
import com.google.common.collect.Lists;

import com.funtl.leesite.common.persistence.DataEntity;
import com.funtl.leesite.common.utils.excel.annotation.ExcelField;

/**
 * 生成示例Entity
 * @author Lusifer
 * @version 2017-05-05
 */
public class CaseOneToManyMain extends DataEntity<CaseOneToManyMain> {
	
	private static final long serialVersionUID = 1L;
	private User user;		// 归属用户
	private Office office;		// 归属部门
	private Area area;		// 归属区域
	private String name;		// 名称
	private String sex;		// 性别
	private Date inDate;		// 加入日期
	private Date beginInDate;		// 开始 加入日期
	private Date endInDate;		// 结束 加入日期
	private List<CaseOneToManyFirst> caseOneToManyFirstList = Lists.newArrayList();		// 子表列表
	private List<CaseOneToManySecond> caseOneToManySecondList = Lists.newArrayList();		// 子表列表
	private List<CaseOneToManyThird> caseOneToManyThirdList = Lists.newArrayList();		// 子表列表
	
	public CaseOneToManyMain() {
		super();
	}

	public CaseOneToManyMain(String id){
		super(id);
	}

	@NotNull(message="归属用户不能为空")
	@ExcelField(title="归属用户", fieldType=User.class, value="user.name", align=2, sort=1)
	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}
	
	@NotNull(message="归属部门不能为空")
	@ExcelField(title="归属部门", fieldType=Office.class, value="office.name", align=2, sort=2)
	public Office getOffice() {
		return office;
	}

	public void setOffice(Office office) {
		this.office = office;
	}
	
	@NotNull(message="归属区域不能为空")
	@ExcelField(title="归属区域", fieldType=Area.class, value="area.name", align=2, sort=3)
	public Area getArea() {
		return area;
	}

	public void setArea(Area area) {
		this.area = area;
	}
	
	@Length(min=1, max=100, message="名称长度必须介于 1 和 100 之间")
	@ExcelField(title="名称", align=2, sort=4)
	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}
	
	@Length(min=1, max=1, message="性别长度必须介于 1 和 1 之间")
	@ExcelField(title="性别", dictType="sex", align=2, sort=5)
	public String getSex() {
		return sex;
	}

	public void setSex(String sex) {
		this.sex = sex;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	@NotNull(message="加入日期不能为空")
	@ExcelField(title="加入日期", align=2, sort=6)
	public Date getInDate() {
		return inDate;
	}

	public void setInDate(Date inDate) {
		this.inDate = inDate;
	}
	
	public Date getBeginInDate() {
		return beginInDate;
	}

	public void setBeginInDate(Date beginInDate) {
		this.beginInDate = beginInDate;
	}
	
	public Date getEndInDate() {
		return endInDate;
	}

	public void setEndInDate(Date endInDate) {
		this.endInDate = endInDate;
	}
		
	public List<CaseOneToManyFirst> getCaseOneToManyFirstList() {
		return caseOneToManyFirstList;
	}

	public void setCaseOneToManyFirstList(List<CaseOneToManyFirst> caseOneToManyFirstList) {
		this.caseOneToManyFirstList = caseOneToManyFirstList;
	}
	public List<CaseOneToManySecond> getCaseOneToManySecondList() {
		return caseOneToManySecondList;
	}

	public void setCaseOneToManySecondList(List<CaseOneToManySecond> caseOneToManySecondList) {
		this.caseOneToManySecondList = caseOneToManySecondList;
	}
	public List<CaseOneToManyThird> getCaseOneToManyThirdList() {
		return caseOneToManyThirdList;
	}

	public void setCaseOneToManyThirdList(List<CaseOneToManyThird> caseOneToManyThirdList) {
		this.caseOneToManyThirdList = caseOneToManyThirdList;
	}
}