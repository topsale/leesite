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

import java.util.Map;

import com.funtl.leesite.common.config.Global;
import com.funtl.leesite.common.context.SpringMailSender;
import com.funtl.leesite.common.utils.MyBeanUtils;
import com.funtl.leesite.common.utils.StringUtils;
import com.funtl.leesite.common.web.BaseController;
import com.funtl.leesite.modules.config.entity.ConfigMail;
import com.funtl.leesite.modules.config.service.ConfigMailService;
import com.google.common.collect.Maps;

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
 * 邮箱配置Controller
 *
 * @author Lusifer
 * @version 2017-05-04
 */
@Controller
@RequestMapping(value = "${adminPath}/config/configMail")
public class ConfigMailController extends BaseController {

	@Autowired
	private SpringMailSender springMailSender;

	@Autowired
	private ConfigMailService configMailService;

	@ModelAttribute
	public ConfigMail get(@RequestParam(required = false) String id) {
		ConfigMail entity = null;
		if (StringUtils.isNotBlank(id)) {
			entity = configMailService.get(id);
		}
		if (entity == null) {
			entity = new ConfigMail();
		}
		return entity;
	}

	/**
	 * 查看，增加，编辑邮箱配置表单页面
	 */
	@RequiresPermissions(value = {"config:configMail:view", "config:configMail:add", "config:configMail:edit"}, logical = Logical.OR)
	@RequestMapping(value = "form")
	public String form(ConfigMail configMail, Model model) {
		model.addAttribute("configMail", configMail);
		return "modules/config/configMailForm";
	}

	/**
	 * 保存邮箱配置
	 */
	@RequiresPermissions(value = {"config:configMail:add", "config:configMail:edit"}, logical = Logical.OR)
	@RequestMapping(value = "save")
	public String save(ConfigMail configMail, Model model, RedirectAttributes redirectAttributes) throws Exception {
		if (!beanValidator(model, configMail)) {
			return form(configMail, model);
		}

		if (!configMail.getIsNewRecord()) { // 编辑表单保存
			ConfigMail t = configMailService.get(configMail.getId()); // 从数据库取出记录的值
			MyBeanUtils.copyBeanNotNull2Bean(configMail, t); // 将编辑表单中的非NULL值覆盖数据库记录中的值
			configMailService.save(t); // 保存
		}

		addMessage(redirectAttributes, "保存邮箱配置成功");
		return "redirect:" + Global.getAdminPath() + "/config/configMail/form?id=1";
	}

	/**
	 * 发送测试邮件
	 * @param configMail
	 * @param model
	 * @param redirectAttributes
	 * @return
	 */
	@RequiresPermissions("config:configMail:edit")
	@RequestMapping(value = "sendTestMail")
	public String sendTestMail(ConfigMail configMail, Model model, RedirectAttributes redirectAttributes) throws Exception {
		if (!beanValidator(model, configMail)) {
			return form(configMail, model);
		}

		if (!configMail.getIsNewRecord()) { // 编辑表单保存
			ConfigMail t = configMailService.get(configMail.getId()); // 从数据库取出记录的值
			MyBeanUtils.copyBeanNotNull2Bean(configMail, t); // 将编辑表单中的非NULL值覆盖数据库记录中的值
			configMailService.save(t); // 保存
		}

		Map<String, Object> map = Maps.newHashMap();
		map.put("username", configMail.getMailFrom());
		String result = springMailSender.send(configMail.getMailUsername(), "测试邮件", "test", map, false);

		if ("OK".equals(result)) {
			addMessage(redirectAttributes, "邮件发送成功");
		} else {
			addMessage(redirectAttributes, "邮件发送失败，".concat(result));
		}

		return "redirect:" + Global.getAdminPath() + "/config/configMail/form?id=1";
	}
}