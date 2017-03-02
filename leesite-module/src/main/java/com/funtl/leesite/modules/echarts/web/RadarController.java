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

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.funtl.leesite.common.web.BaseController;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping(value = "${adminPath}/echarts/radar")
public class RadarController extends BaseController {

	private static final long serialVersionUID = 7375363226310112119L;

	private List<Map<String, Object>> orientData;

	@RequestMapping(value = {"index", ""})
	public String index(HttpServletRequest request, HttpServletResponse response, Model model) {
		request.setAttribute("orientData", getorientData8());
		return "modules/echarts/radar";

	}

	public List<Map<String, Object>> getorientData8() {
		orientData = new ArrayList<Map<String, Object>>();

		Double[] dataArr1 = new Double[]{0.1 * 100, 0.2 * 100, 0.3 * 100, 0.1 * 100, 0.05 * 100, 0.05 * 100, 0.1 * 100, 0.1 * 100};
		Map<String, Object> mapData1 = new HashMap<String, Object>();
		mapData1.put("dataArr", dataArr1);
		mapData1.put("title", "玫瑰图1");
		orientData.add(mapData1);

		Double[] dataArr2 = new Double[]{0.05 * 100, 0.05 * 100, 0.1 * 100, 0.1 * 100, 0.1 * 100, 0.2 * 100, 0.3 * 100, 0.1 * 100};
		Map<String, Object> mapData2 = new HashMap<String, Object>();
		mapData2.put("dataArr", dataArr2);
		mapData2.put("title", "玫瑰图2");
		orientData.add(mapData2);

		return orientData;

	}
}
