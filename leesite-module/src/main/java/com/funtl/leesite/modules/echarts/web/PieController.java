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

package com.funtl.leesite.modules.echarts.web;

import java.util.HashMap;
import java.util.Map;

import com.funtl.leesite.common.web.BaseController;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping(value = "${adminPath}/echarts/pie")
public class PieController extends BaseController {

	private static final long serialVersionUID = 7375363226310112119L;

	private Map<String, Object> orientData;

	@RequestMapping(value = {"index", ""})
	public String index(Model model) {
		model.addAttribute("orientData", getorientData());
		return "modules/echarts/pie";
	}

	public Map<String, Object> getorientData() {
		orientData = new HashMap<String, Object>();
		orientData.put("直接访问", 335);
		orientData.put("邮件营销", 310);
		orientData.put("联盟广告", 234);
		orientData.put("视频广告", 135);
		orientData.put("搜索引擎", 1548);
		return orientData;
	}
}
