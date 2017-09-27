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

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.funtl.leesite.common.config.Global;
import com.funtl.leesite.common.persistence.Page;
import com.funtl.leesite.common.utils.MyBeanUtils;
import com.funtl.leesite.common.utils.StringUtils;
import com.funtl.leesite.common.web.BaseController;
import com.funtl.leesite.modules.tools.constants.QuartzConstant;
import com.funtl.leesite.modules.tools.entity.QrtzScheduleJob;
import com.funtl.leesite.modules.tools.service.QrtzScheduleJobService;
import com.funtl.leesite.modules.tools.utils.ScheduleUtils;

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
 * 任务调度Controller
 *
 * @author Lusifer
 * @version 2017-09-26
 */
@Controller
@RequestMapping(value = "${adminPath}/tools/qrtzScheduleJob")
public class QrtzScheduleJobController extends BaseController {

	@Autowired
	private QrtzScheduleJobService qrtzScheduleJobService;

	@ModelAttribute
	public QrtzScheduleJob get(@RequestParam(required = false) String id) {
		QrtzScheduleJob entity = null;
		if (StringUtils.isNotBlank(id)) {
			entity = qrtzScheduleJobService.get(id);
		}
		if (entity == null) {
			entity = new QrtzScheduleJob();
		}
		return entity;
	}

	/**
	 * 任务调度列表页面
	 */
	@RequiresPermissions("tools:qrtzScheduleJob:list")
	@RequestMapping(value = {"list", ""})
	public String list(QrtzScheduleJob qrtzScheduleJob, HttpServletRequest request, HttpServletResponse response, Model model) {
		if ("1".equals(qrtzScheduleJob.getNormal())) {
			List<QrtzScheduleJob> list = qrtzScheduleJobService.findNormal();
			model.addAttribute("list", list);
		} else {
			Page<QrtzScheduleJob> page = qrtzScheduleJobService.findPage(new Page<QrtzScheduleJob>(request, response), qrtzScheduleJob);
			model.addAttribute("page", page);
		}
		return "modules/tools/qrtzScheduleJobList";
	}

	/**
	 * 查看，增加，编辑任务调度表单页面
	 */
	@RequiresPermissions(value = {"tools:qrtzScheduleJob:view", "tools:qrtzScheduleJob:add", "tools:qrtzScheduleJob:edit"}, logical = Logical.OR)
	@RequestMapping(value = "form")
	public String form(QrtzScheduleJob qrtzScheduleJob, Model model) {
		if (qrtzScheduleJob.getStatus() == null) {
			qrtzScheduleJob.setStatus(QuartzConstant.NEW);
		}
		if (qrtzScheduleJob.getIsSync() == null) {
			qrtzScheduleJob.setIsSync("1");
		}
		model.addAttribute("qrtzScheduleJob", qrtzScheduleJob);
		return "modules/tools/qrtzScheduleJobForm";
	}

	/**
	 * 保存任务调度
	 */
	@RequiresPermissions(value = {"tools:qrtzScheduleJob:add", "tools:qrtzScheduleJob:edit"}, logical = Logical.OR)
	@RequestMapping(value = "save")
	public String save(QrtzScheduleJob qrtzScheduleJob, Model model, RedirectAttributes redirectAttributes) throws Exception {
		if (!beanValidator(model, qrtzScheduleJob)) {
			return form(qrtzScheduleJob, model);
		}

		if (!ScheduleUtils.checkCronExpression(qrtzScheduleJob.getCronExpression())) {
			addMessage(redirectAttributes, "保存任务调度失败，请检查CRON表达式");
		} else {
			if (!qrtzScheduleJob.getIsNewRecord()) {//编辑表单保存
				QrtzScheduleJob t = qrtzScheduleJobService.get(qrtzScheduleJob.getId());//从数据库取出记录的值
				MyBeanUtils.copyBeanNotNull2Bean(qrtzScheduleJob, t);//将编辑表单中的非NULL值覆盖数据库记录中的值
				qrtzScheduleJobService.save(t);//保存
			} else {//新增表单保存
				qrtzScheduleJobService.save(qrtzScheduleJob);//保存
			}

			addMessage(redirectAttributes, "保存任务调度成功");
		}

		return "redirect:" + Global.getAdminPath() + "/tools/qrtzScheduleJob";
	}

	/**
	 * 删除任务调度
	 */
	@RequiresPermissions("tools:qrtzScheduleJob:del")
	@RequestMapping(value = "delete")
	public String delete(QrtzScheduleJob qrtzScheduleJob, RedirectAttributes redirectAttributes) {
		qrtzScheduleJobService.delete(qrtzScheduleJob);
		addMessage(redirectAttributes, "删除任务调度成功");
		return "redirect:" + Global.getAdminPath() + "/tools/qrtzScheduleJob";
	}

	/**
	 * 批量删除任务调度
	 */
	@RequiresPermissions("tools:qrtzScheduleJob:del")
	@RequestMapping(value = "deleteAll")
	public String deleteAll(String ids, RedirectAttributes redirectAttributes) {
		String idArray[] = ids.split(",");
		for (String id : idArray) {
			qrtzScheduleJobService.delete(qrtzScheduleJobService.get(id));
		}
		addMessage(redirectAttributes, "删除任务调度成功");
		return "redirect:" + Global.getAdminPath() + "/tools/qrtzScheduleJob";
	}

	/**
	 * 运行
	 *
	 * @return
	 */
	@RequiresPermissions("tools:qrtzScheduleJob:edit")
	@RequestMapping(value = "runOnceScheduleJob")
	public String runOnceScheduleJob(String id) {
		qrtzScheduleJobService.runOnce(id);
		return "redirect:" + Global.getAdminPath() + "/tools/qrtzScheduleJob";
	}

	/**
	 * 暂停
	 *
	 * @return
	 */
	@RequiresPermissions("tools:qrtzScheduleJob:edit")
	@RequestMapping(value = "pauseScheduleJob")
	public String pauseScheduleJob(String id) {
		qrtzScheduleJobService.pauseJob(id);
		return "redirect:" + Global.getAdminPath() + "/tools/qrtzScheduleJob";
	}

	/**
	 * 恢复
	 *
	 * @return
	 */
	@RequiresPermissions("tools:qrtzScheduleJob:edit")
	@RequestMapping(value = "resumeScheduleJob")
	public String resumeScheduleJob(String id) {
		qrtzScheduleJobService.resumeJob(id);
		return "redirect:" + Global.getAdminPath() + "/tools/qrtzScheduleJob";
	}

}