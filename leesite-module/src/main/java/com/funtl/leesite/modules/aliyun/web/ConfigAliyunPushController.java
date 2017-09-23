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
package com.funtl.leesite.modules.aliyun.web;

import com.funtl.leesite.common.config.Global;
import com.funtl.leesite.common.utils.MyBeanUtils;
import com.funtl.leesite.common.utils.StringUtils;
import com.funtl.leesite.common.web.BaseController;
import com.funtl.leesite.modules.aliyun.entity.ConfigAliyunPush;
import com.funtl.leesite.modules.aliyun.service.ConfigAliyunPushService;

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
 * 阿里云配置Controller
 *
 * @author Lusifer
 * @version 2017-09-23
 */
@Controller
@RequestMapping(value = "${adminPath}/aliyun/configAliyunPush")
public class ConfigAliyunPushController extends BaseController {

	@Autowired
	private ConfigAliyunPushService configAliyunPushService;

	@ModelAttribute
	public ConfigAliyunPush get(@RequestParam(required = false) String id) {
		ConfigAliyunPush entity = null;
		if (StringUtils.isNotBlank(id)) {
			entity = configAliyunPushService.get(id);
		}
		if (entity == null) {
			entity = new ConfigAliyunPush();
		}
		return entity;
	}

	/**
	 * 查看，增加，编辑移动推送表单页面
	 */
	@RequiresPermissions(value = {"aliyun:configAliyunPush:view", "aliyun:configAliyunPush:add", "aliyun:configAliyunPush:edit"}, logical = Logical.OR)
	@RequestMapping(value = "form")
	public String form(ConfigAliyunPush configAliyunPush, Model model) {
		model.addAttribute("configAliyunPush", configAliyunPush);
		return "modules/aliyun/configAliyunPushForm";
	}

	/**
	 * 保存移动推送
	 */
	@RequiresPermissions(value = {"aliyun:configAliyunPush:add", "aliyun:configAliyunPush:edit"}, logical = Logical.OR)
	@RequestMapping(value = "save")
	public String save(ConfigAliyunPush configAliyunPush, Model model, RedirectAttributes redirectAttributes) throws Exception {
		if (!beanValidator(model, configAliyunPush)) {
			return form(configAliyunPush, model);
		}
		if (!configAliyunPush.getIsNewRecord()) {//编辑表单保存
			ConfigAliyunPush t = configAliyunPushService.get(configAliyunPush.getId());//从数据库取出记录的值
			MyBeanUtils.copyBeanNotNull2Bean(configAliyunPush, t);//将编辑表单中的非NULL值覆盖数据库记录中的值
			configAliyunPushService.save(t);//保存
		} else {//新增表单保存
			configAliyunPushService.save(configAliyunPush);//保存
		}
		addMessage(redirectAttributes, "保存移动推送成功");
		return "redirect:" + Global.getAdminPath() + "/aliyun/configAliyunPush/form?id=1";
	}

}