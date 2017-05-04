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
package com.funtl.leesite.modules.config.web;

import com.funtl.leesite.common.config.Global;
import com.funtl.leesite.common.utils.MyBeanUtils;
import com.funtl.leesite.common.utils.StringUtils;
import com.funtl.leesite.common.web.BaseController;
import com.funtl.leesite.modules.config.entity.ConfigSms;
import com.funtl.leesite.modules.config.service.ConfigSmsService;

import org.apache.shiro.authz.annotation.Logical;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

/**
 * 短信配置Controller
 *
 * @author Lusifer
 * @version 2017-05-04
 */
@Controller
@RequestMapping(value = "${adminPath}/config/configSms")
public class ConfigSmsController extends BaseController {

	@Autowired
	private ConfigSmsService configSmsService;

	@ModelAttribute
	public ConfigSms get(@RequestParam(required = false) String id) {
		ConfigSms entity = null;
		if (StringUtils.isNotBlank(id)) {
			entity = configSmsService.get(id);
		}
		if (entity == null) {
			entity = new ConfigSms();
		}
		return entity;
	}

	/**
	 * 查看，增加，编辑短信配置表单页面
	 */
	@RequiresPermissions(value = {"config:configSms:view", "config:configSms:add", "config:configSms:edit"}, logical = Logical.OR)
	@RequestMapping(value = "form")
	public String form(ConfigSms configSms, Model model) {
		model.addAttribute("configSms", configSms);
		return "modules/config/configSmsForm";
	}

	/**
	 * 保存短信配置
	 */
	@RequiresPermissions(value = {"config:configSms:add", "config:configSms:edit"}, logical = Logical.OR)
	@RequestMapping(value = "save")
	public String save(ConfigSms configSms, Model model, RedirectAttributes redirectAttributes) throws Exception {
		if (!beanValidator(model, configSms)) {
			return form(configSms, model);
		}
		if (!configSms.getIsNewRecord()) {//编辑表单保存
			ConfigSms t = configSmsService.get(configSms.getId());//从数据库取出记录的值
			MyBeanUtils.copyBeanNotNull2Bean(configSms, t);//将编辑表单中的非NULL值覆盖数据库记录中的值
			configSmsService.save(t);//保存
		} else {//新增表单保存
			configSmsService.save(configSms);//保存
		}
		addMessage(redirectAttributes, "保存短信配置成功");
		return "redirect:" + Global.getAdminPath() + "/config/configSms/form?id=1";
	}
}
