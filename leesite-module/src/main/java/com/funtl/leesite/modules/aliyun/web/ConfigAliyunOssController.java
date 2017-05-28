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
import com.funtl.leesite.modules.aliyun.entity.ConfigAliyunOss;
import com.funtl.leesite.modules.aliyun.service.ConfigAliyunOssService;

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
 * @version 2017-05-28
 */
@Controller
@RequestMapping(value = "${adminPath}/aliyun/configAliyunOss")
public class ConfigAliyunOssController extends BaseController {

	@Autowired
	private ConfigAliyunOssService configAliyunOssService;

	@ModelAttribute
	public ConfigAliyunOss get(@RequestParam(required = false) String id) {
		ConfigAliyunOss entity = null;
		if (StringUtils.isNotBlank(id)) {
			entity = configAliyunOssService.get(id);
		}
		if (entity == null) {
			entity = new ConfigAliyunOss();
		}
		return entity;
	}

	/**
	 * 查看，增加，编辑对象存储 OSS表单页面
	 */
	@RequiresPermissions(value = {"aliyun:configAliyunOss:view", "aliyun:configAliyunOss:edit"}, logical = Logical.OR)
	@RequestMapping(value = "form")
	public String form(ConfigAliyunOss configAliyunOss, Model model) {
		model.addAttribute("configAliyunOss", configAliyunOss);
		return "modules/aliyun/configAliyunOssForm";
	}

	/**
	 * 保存对象存储 OSS
	 */
	@RequiresPermissions(value = {"aliyun:configAliyunOss:edit"}, logical = Logical.OR)
	@RequestMapping(value = "save")
	public String save(ConfigAliyunOss configAliyunOss, Model model, RedirectAttributes redirectAttributes) throws Exception {
		if (!beanValidator(model, configAliyunOss)) {
			return form(configAliyunOss, model);
		}
		if (!configAliyunOss.getIsNewRecord()) {//编辑表单保存
			ConfigAliyunOss t = configAliyunOssService.get(configAliyunOss.getId());//从数据库取出记录的值
			MyBeanUtils.copyBeanNotNull2Bean(configAliyunOss, t);//将编辑表单中的非NULL值覆盖数据库记录中的值
			configAliyunOssService.save(t);//保存
		} else {//新增表单保存
			configAliyunOssService.save(configAliyunOss);//保存
		}
		addMessage(redirectAttributes, "保存对象存储 OSS 成功");
		return "redirect:" + Global.getAdminPath() + "/aliyun/configAliyunOss/form?id=1";
	}
}