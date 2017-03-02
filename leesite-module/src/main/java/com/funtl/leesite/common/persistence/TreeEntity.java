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

package com.funtl.leesite.common.persistence;

import javax.validation.constraints.NotNull;

import com.fasterxml.jackson.annotation.JsonBackReference;
import com.funtl.leesite.common.utils.Reflections;
import com.funtl.leesite.common.utils.StringUtils;

import org.hibernate.validator.constraints.Length;

/**
 * 数据Entity类
 *
 * @author Lusifer
 * @version 2014-05-16
 */
public abstract class TreeEntity<T> extends DataEntity<T> {

	private static final long serialVersionUID = 1L;

	protected T parent;    // 父级编号
	protected String parentIds; // 所有父级编号
	protected String name;    // 机构名称
	protected Integer sort;        // 排序

	public TreeEntity() {
		super();
		this.sort = 30;
	}

	public TreeEntity(String id) {
		super(id);
	}

	/**
	 * 父对象，只能通过子类实现，父类实现mybatis无法读取
	 *
	 * @return
	 */
	@JsonBackReference
	@NotNull
	public abstract T getParent();

	/**
	 * 父对象，只能通过子类实现，父类实现mybatis无法读取
	 *
	 * @return
	 */
	public abstract void setParent(T parent);

	@Length(min = 1, max = 2000)
	public String getParentIds() {
		return parentIds;
	}

	public void setParentIds(String parentIds) {
		this.parentIds = parentIds;
	}

	@Length(min = 1, max = 100)
	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public Integer getSort() {
		return sort;
	}

	public void setSort(Integer sort) {
		this.sort = sort;
	}

	public String getParentId() {
		String id = null;
		if (parent != null) {
			id = (String) Reflections.getFieldValue(parent, "id");
		}
		return StringUtils.isNotBlank(id) ? id : "0";
	}

}
