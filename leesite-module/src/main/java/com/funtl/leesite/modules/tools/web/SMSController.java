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

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.funtl.leesite.common.sms.SMSUtils;
import com.funtl.leesite.common.web.BaseController;
import com.funtl.leesite.modules.sys.entity.SystemConfig;
import com.funtl.leesite.modules.sys.service.SystemConfigService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * 发送短信
 *
 * @author lgf
 * @version 2016-01-07
 */
@Controller
@RequestMapping(value = "${adminPath}/tools/sms")
public class SMSController extends BaseController {

	@Autowired
	private SystemConfigService systemConfigService;

	/**
	 * 打开短信页面
	 */
	@RequestMapping(value = {"index", ""})
	public String index(HttpServletRequest request, HttpServletResponse response, Model model) {
		return "modules/tools/sendSMS";
	}

	/**
	 * 发送短信
	 */
	@RequestMapping("send")
	public String send(String tels, HttpServletResponse response, String content, Model model) throws Exception {
		SystemConfig config = systemConfigService.get("1");
		String result = "";
		try {
			String resultCode = SMSUtils.send(config.getSmsName(), config.getSmsPassword(), tels, content);
			if (!resultCode.equals("100")) {

				result = "短信发送失败，错误代码：" + resultCode + "，请 联系管理员。";

			} else {
				result = "短信发送成功";
			}
		} catch (IOException e) {
			result = "因未知原因导致短信发送失败，请联系管理员。";
		}

		model.addAttribute("result", result);
		return "modules/tools/sendSMSResult";
	}

}