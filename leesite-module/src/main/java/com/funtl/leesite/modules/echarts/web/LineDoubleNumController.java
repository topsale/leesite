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
import java.util.Random;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.funtl.leesite.common.web.BaseController;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping(value = "${adminPath}/echarts/linedoublenum")
public class LineDoubleNumController extends BaseController {
	private static final long serialVersionUID = -6886697421555222670L;

	private Map<String, Double[][]> axisDataArr;

	@RequestMapping(value = {"index", ""})
	public String index(HttpServletRequest request, HttpServletResponse response, Model model) {

		//x+y轴数据Double[x轴数据][y轴数据]
		request.setAttribute("axisDataArr", getaxisDataArr());
		return "modules/echarts/lineDoubleNum";
	}

	public Map<String, Double[][]> getaxisDataArr() {

		Random random = new Random();
		axisDataArr = new HashMap<String, Double[][]>();

		Double[][] data1 = new Double[10][2];
		for (int i = 0; i < 10; i++) {
			data1[i][0] = i + 0.0;
			data1[i][1] = random.nextInt(10) + 0.0;
		}
		axisDataArr.put("曲线一", data1);

		Double[][] data2 = new Double[10][2];
		for (int i = 0; i < 10; i++) {
			data2[i][0] = i + 1.0;
			data2[i][1] = random.nextInt(10) + 0.0;
		}
		axisDataArr.put("曲线二", data2);

		return axisDataArr;
	}

}
