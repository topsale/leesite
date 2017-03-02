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

import java.util.HashMap;

/**
 * 查询参数类
 *
 * @author Lusifer
 * @version 2013-8-23
 */
public class Parameter extends HashMap<String, Object> {

	private static final long serialVersionUID = 1L;

	/**
	 * 构造类，例：new Parameter(id, parentIds)
	 *
	 * @param values 参数值
	 */
	public Parameter(Object... values) {
		if (values != null) {
			for (int i = 0; i < values.length; i++) {
				put("p" + (i + 1), values[i]);
			}
		}
	}

	/**
	 * 构造类，例：new Parameter(new Object[][]{{"id", id}, {"parentIds", parentIds}})
	 *
	 * @param parameters 参数二维数组
	 */
	public Parameter(Object[][] parameters) {
		if (parameters != null) {
			for (Object[] os : parameters) {
				if (os.length == 2) {
					put((String) os[0], os[1]);
				}
			}
		}
	}

}
