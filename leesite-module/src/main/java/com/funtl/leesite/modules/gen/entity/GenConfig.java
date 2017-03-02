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

package com.funtl.leesite.modules.gen.entity;

import java.io.Serializable;
import java.util.List;

import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlElementWrapper;
import javax.xml.bind.annotation.XmlRootElement;

import com.funtl.leesite.modules.sys.entity.Dict;


/**
 * 生成方案Entity
 *
 * @author Lusifer
 * @version 2013-10-15
 */
@XmlRootElement(name = "config")
public class GenConfig implements Serializable {

	private static final long serialVersionUID = 1L;
	private List<GenCategory> categoryList;    // 代码模板分类
	private List<Dict> javaTypeList;        // Java类型
	private List<Dict> queryTypeList;        // 查询类型
	private List<Dict> showTypeList;        // 显示类型

	public GenConfig() {
		super();
	}

	@XmlElementWrapper(name = "category")
	@XmlElement(name = "category")
	public List<GenCategory> getCategoryList() {
		return categoryList;
	}

	public void setCategoryList(List<GenCategory> categoryList) {
		this.categoryList = categoryList;
	}

	@XmlElementWrapper(name = "javaType")
	@XmlElement(name = "dict")
	public List<Dict> getJavaTypeList() {
		return javaTypeList;
	}

	public void setJavaTypeList(List<Dict> javaTypeList) {
		this.javaTypeList = javaTypeList;
	}

	@XmlElementWrapper(name = "queryType")
	@XmlElement(name = "dict")
	public List<Dict> getQueryTypeList() {
		return queryTypeList;
	}

	public void setQueryTypeList(List<Dict> queryTypeList) {
		this.queryTypeList = queryTypeList;
	}

	@XmlElementWrapper(name = "showType")
	@XmlElement(name = "dict")
	public List<Dict> getShowTypeList() {
		return showTypeList;
	}

	public void setShowTypeList(List<Dict> showTypeList) {
		this.showTypeList = showTypeList;
	}

}