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

package com.funtl.leesite.tools.baidu.ueditor.define;

import java.util.HashMap;
import java.util.Map;

/**
 * 定义请求action类型
 */
@SuppressWarnings("serial")
public final class ActionMap {

	public static final Map<String, Integer> mapping;
	// 获取配置请求
	public static final int CONFIG = 0;
	public static final int UPLOAD_IMAGE = 1;
	public static final int UPLOAD_SCRAWL = 2;
	public static final int UPLOAD_VIDEO = 3;
	public static final int UPLOAD_FILE = 4;
	public static final int CATCH_IMAGE = 5;
	public static final int LIST_FILE = 6;
	public static final int LIST_IMAGE = 7;

	static {
		mapping = new HashMap<String, Integer>() {{
			put("config", ActionMap.CONFIG);
			put("uploadimage", ActionMap.UPLOAD_IMAGE);
			put("uploadscrawl", ActionMap.UPLOAD_SCRAWL);
			put("uploadvideo", ActionMap.UPLOAD_VIDEO);
			put("uploadfile", ActionMap.UPLOAD_FILE);
			put("catchimage", ActionMap.CATCH_IMAGE);
			put("listfile", ActionMap.LIST_FILE);
			put("listimage", ActionMap.LIST_IMAGE);
		}};
	}

	public static int getType(String key) {
		return ActionMap.mapping.get(key);
	}

}
