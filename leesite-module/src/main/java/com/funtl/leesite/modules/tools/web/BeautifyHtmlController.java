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

package com.funtl.leesite.modules.tools.web;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.funtl.leesite.common.web.BaseController;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * 表单构建工具
 *
 * @author lgf
 * @version 2016-01-07
 */
@Controller
@RequestMapping(value = "${adminPath}/tools/beautifyhtml")
public class BeautifyHtmlController extends BaseController {


	/**
	 * 打开表单构建工具
	 */
	@RequestMapping(value = {"index", ""})
	public String index(HttpServletRequest request, HttpServletResponse response, Model model) {
		return "modules/tools/form_builder";
	}


}