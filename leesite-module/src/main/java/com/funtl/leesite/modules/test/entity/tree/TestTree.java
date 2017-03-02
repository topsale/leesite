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

package com.funtl.leesite.modules.test.entity.tree;

import javax.validation.constraints.NotNull;

import com.fasterxml.jackson.annotation.JsonBackReference;
import com.funtl.leesite.common.persistence.TreeEntity;

import org.hibernate.validator.constraints.Length;

/**
 * 组织机构Entity
 *
 * @author Lusifer
 * @version 2016-05-06
 */
public class TestTree extends TreeEntity<TestTree> {

	private static final long serialVersionUID = 1L;
	private String name;        // 名称
	private Integer sort;        // 排序
	private TestTree parent;        // 父级编号
	private String parentIds;        // 所有父级编号

	public TestTree() {
		super();
	}

	public TestTree(String id) {
		super(id);
	}

	@Length(min = 1, max = 100, message = "名称长度必须介于 1 和 100 之间")
	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	@NotNull(message = "排序不能为空")
	public Integer getSort() {
		return sort;
	}

	public void setSort(Integer sort) {
		this.sort = sort;
	}

	@JsonBackReference
	@NotNull(message = "父级编号不能为空")
	public TestTree getParent() {
		return parent;
	}

	public void setParent(TestTree parent) {
		this.parent = parent;
	}

	@Length(min = 1, max = 2000, message = "所有父级编号长度必须介于 1 和 2000 之间")
	public String getParentIds() {
		return parentIds;
	}

	public void setParentIds(String parentIds) {
		this.parentIds = parentIds;
	}

	public String getParentId() {
		return parent != null && parent.getId() != null ? parent.getId() : "0";
	}
}