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

package com.funtl.leesite.modules.iim.web;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.funtl.leesite.common.config.Global;
import com.funtl.leesite.common.persistence.Page;
import com.funtl.leesite.common.utils.StringUtils;
import com.funtl.leesite.common.web.BaseController;
import com.funtl.leesite.modules.iim.entity.Mail;
import com.funtl.leesite.modules.iim.service.MailService;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

/**
 * 发件箱Controller
 *
 * @author Lusifer
 * @version 2015-11-15
 */
@Controller
@RequestMapping(value = "${adminPath}/iim/mail")
public class MailController extends BaseController {

	@Autowired
	private MailService mailService;

	@ModelAttribute
	public Mail get(@RequestParam(required = false) String id) {
		Mail entity = null;
		if (StringUtils.isNotBlank(id)) {
			entity = mailService.get(id);
		}
		if (entity == null) {
			entity = new Mail();
		}
		return entity;
	}

	@RequiresPermissions("iim:mail:view")
	@RequestMapping(value = {"list", ""})
	public String list(Mail mail, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<Mail> page = mailService.findPage(new Page<Mail>(request, response), mail);
		model.addAttribute("page", page);
		return "modules/iim/mailList";
	}

	@RequiresPermissions("iim:mail:view")
	@RequestMapping(value = "form")
	public String form(Mail mail, Model model) {
		model.addAttribute("mail", mail);
		return "modules/iim/mailForm";
	}

	@RequestMapping(value = "save")
	public String save(Mail mail, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, mail)) {
			return form(mail, model);
		}
		mailService.save(mail);
		addMessage(redirectAttributes, "删除站内信成功");
		return "redirect:" + Global.getAdminPath() + "/iim/mail/";
	}

	@RequestMapping(value = "delete")
	public String delete(Mail mail, RedirectAttributes redirectAttributes) {
		mailService.delete(mail);
		addMessage(redirectAttributes, "删除站内信成功");
		return "redirect:" + Global.getAdminPath() + "/iim/mail/";
	}

	/**
	 * 批量删除
	 */
	@RequestMapping(value = "deleteAll")
	public String deleteAll(String ids, RedirectAttributes redirectAttributes) {
		String idArray[] = ids.split(",");
		for (String id : idArray) {
			mailService.delete(mailService.get(id));
		}
		addMessage(redirectAttributes, "删除站内信成功");
		return "redirect:" + Global.getAdminPath() + "/iim/mail/";
	}

}