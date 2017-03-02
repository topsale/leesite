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

import java.util.ArrayList;
import java.util.List;

public class Group {

	private String name;
	private int nums;
	private int id;

	private List<Friend> item = new ArrayList();

	public void setItem(List item) {
		this.item = item;
	}

	public List getItem() {
		return item;
	}

	public void setNums(int nums) {
		this.nums = nums;
	}

	public int getNums() {
		return nums;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getName() {
		return name;
	}

	public void setId(int id) {
		this.id = id;
	}

	public int getId() {
		return id;
	}

}
