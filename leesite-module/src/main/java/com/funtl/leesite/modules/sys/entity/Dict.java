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

package com.funtl.leesite.modules.sys.entity;

import javax.validation.constraints.NotNull;
import javax.xml.bind.annotation.XmlAttribute;

import com.funtl.leesite.common.persistence.DataEntity;

import org.hibernate.validator.constraints.Length;

/**
 * 字典Entity
 *
 * @author Lusifer
 * @version 2013-05-15
 */
public class Dict extends DataEntity<Dict> {

	private static final long serialVersionUID = 1L;
	private String value;    // 数据值
	private String label;    // 标签名
	private String type;    // 类型
	private String description;// 描述
	private Integer sort;    // 排序
	private String parentId;//父Id

	public Dict() {
		super();
	}

	public Dict(String id) {
		super(id);
	}

	public Dict(String value, String label) {
		this.value = value;
		this.label = label;
	}

	@XmlAttribute
	@Length(min = 1, max = 100)
	public String getValue() {
		return value;
	}

	public void setValue(String value) {
		this.value = value;
	}

	@XmlAttribute
	@Length(min = 1, max = 100)
	public String getLabel() {
		return label;
	}

	public void setLabel(String label) {
		this.label = label;
	}

	@Length(min = 1, max = 100)
	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	@XmlAttribute
	@Length(min = 0, max = 100)
	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	@NotNull
	public Integer getSort() {
		return sort;
	}

	public void setSort(Integer sort) {
		this.sort = sort;
	}

	@Length(min = 1, max = 100)
	public String getParentId() {
		return parentId;
	}

	public void setParentId(String parentId) {
		this.parentId = parentId;
	}

	@Override
	public String toString() {
		return label;
	}
}