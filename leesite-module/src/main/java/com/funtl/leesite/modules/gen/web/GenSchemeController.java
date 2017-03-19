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

package com.funtl.leesite.modules.gen.web;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.funtl.leesite.common.persistence.Page;
import com.funtl.leesite.common.utils.StringUtils;
import com.funtl.leesite.common.web.BaseController;
import com.funtl.leesite.modules.gen.entity.GenScheme;
import com.funtl.leesite.modules.gen.service.GenSchemeService;
import com.funtl.leesite.modules.gen.service.GenTableService;
import com.funtl.leesite.modules.gen.util.GenUtils;
import com.funtl.leesite.modules.sys.entity.User;
import com.funtl.leesite.modules.sys.utils.UserUtils;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

/**
 * 生成方案Controller
 *
 * @author Lusifer
 * @version 2013-10-15
 */
@Controller
@RequestMapping(value = "${adminPath}/gen/genScheme")
public class GenSchemeController extends BaseController {

	@Autowired
	private GenSchemeService genSchemeService;

	@Autowired
	private GenTableService genTableService;

	@ModelAttribute
	public GenScheme get(@RequestParam(required = false) String id) {
		if (StringUtils.isNotBlank(id)) {
			return genSchemeService.get(id);
		} else {
			return new GenScheme();
		}
	}

	@RequiresPermissions("gen:genScheme:view")
	@RequestMapping(value = {"list", ""})
	public String list(GenScheme genScheme, HttpServletRequest request, HttpServletResponse response, Model model) {
		User user = UserUtils.getUser();
		if (!user.isAdmin()) {
			genScheme.setCreateBy(user);
		}
		Page<GenScheme> page = genSchemeService.find(new Page<GenScheme>(request, response), genScheme);
		model.addAttribute("page", page);

		//验证设置的源码路径是否正确
		if (!genSchemeService.checkSrcPathConfig()) {
			addMessage(model, "您未配置源码路径“srcPath”或您配置的路径不正确，只有正确配置后才能生成源码</br>" + "请在“leesite.properties”中配置正确的“srcPath”。</br>" + "srcPath路径需指向jeesite项目源码所在的路径，如：C:\\Users\\Administrator\\workspace\\jeesite");
		}

		return "modules/gen/genSchemeList";
	}

	@RequiresPermissions("gen:genScheme:view")
	@RequestMapping(value = "form")
	public String form(GenScheme genScheme, Model model) {
		if (StringUtils.isBlank(genScheme.getPackageName())) {
			genScheme.setPackageName("com.jeeplus.modules");
		}
		//		if (StringUtils.isBlank(genScheme.getFunctionAuthor())){
		//			genScheme.setFunctionAuthor(UserUtils.getUser().getName());
		//		}
		model.addAttribute("genScheme", genScheme);
		model.addAttribute("config", GenUtils.getConfig());
		model.addAttribute("tableList", genTableService.findAll());
		return "modules/gen/genSchemeForm";
	}

	@RequiresPermissions("gen:genScheme:edit")
	@RequestMapping(value = "save")
	public String save(GenScheme genScheme, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, genScheme)) {
			return form(genScheme, model);
		}

		//验证设置的源码路径是否正确
		if ("1".equals(genScheme.getFlag())) {
			if (!genSchemeService.checkSrcPathConfig()) {
				addMessage(redirectAttributes, "您未配置源码路径“srcPath”，或您配置的路径不正确");
				return "redirect:" + adminPath + "/gen/genScheme/?repage";
			}
		}

		String result = genSchemeService.save(genScheme);
		addMessage(redirectAttributes, "操作生成方案'" + genScheme.getName() + "'成功<br/>" + result);
		return "redirect:" + adminPath + "/gen/genScheme/?repage";
	}

	@RequiresPermissions("gen:genScheme:edit")
	@RequestMapping(value = "delete")
	public String delete(GenScheme genScheme, RedirectAttributes redirectAttributes) {
		genSchemeService.delete(genScheme);
		addMessage(redirectAttributes, "删除生成方案成功");
		return "redirect:" + adminPath + "/gen/genScheme/?repage";
	}

}
