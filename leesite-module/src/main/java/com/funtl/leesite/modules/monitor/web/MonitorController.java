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

package com.funtl.leesite.modules.monitor.web;


import java.util.Map;

import com.funtl.leesite.common.context.SpringMailSender;
import com.funtl.leesite.common.json.AjaxJson;
import com.funtl.leesite.common.utils.MyBeanUtils;
import com.funtl.leesite.common.utils.StringUtils;
import com.funtl.leesite.common.web.BaseController;
import com.funtl.leesite.modules.monitor.entity.Monitor;
import com.funtl.leesite.modules.monitor.service.MonitorService;
import com.funtl.leesite.modules.monitor.utils.SystemInfo;
import com.google.common.collect.Maps;

import org.hyperic.sigar.Sigar;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;


/**
 * 系统监控Controller
 *
 * @author Lusifer
 * @version 2016-02-07
 */
@Controller
@RequestMapping(value = "${adminPath}/monitor")
public class MonitorController extends BaseController {
	@Autowired
	private SpringMailSender springMailSender;

	@Autowired
	private MonitorService monitorService;

	@ModelAttribute
	public Monitor get(@RequestParam(required = false) String id) {
		Monitor entity = null;
		if (StringUtils.isNotBlank(id)) {
			entity = monitorService.get(id);
		}
		if (entity == null) {
			entity = new Monitor();
		}
		return entity;
	}

	@RequestMapping("info")
	public String info(Model model) throws Exception {
		Monitor monitor = monitorService.get("1");
		model.addAttribute("cpu", monitor.getCpu());
		model.addAttribute("jvm", monitor.getJvm());
		model.addAttribute("ram", monitor.getRam());
		model.addAttribute("toEmail", monitor.getToEmail());
		return "modules/monitor/info";
	}

	@RequestMapping("monitor")
	public String monitor() throws Exception {
		return "modules/monitor/monitor";
	}

	@RequestMapping("systemInfo")
	public String systemInfo(Model model) throws Exception {
		model.addAttribute("systemInfo", SystemInfo.SystemProperty());
		return "modules/monitor/systemInfo";
	}

	@ResponseBody
	@RequestMapping("usage")
	public Map usage() throws Exception {
		Monitor monitor = monitorService.get("1");
		Map<?, ?> sigar = SystemInfo.usage(new Sigar());
		String content = "";
		content += "您预设的 cpu 使用率警告线是 <span style='color:blue'>" + monitor.getCpu() + "%</span>，当前使用率是 <span style='color:red'>" + sigar.get("cpuUsage") + "%</span><br />";
		content += "您预设的 jvm 使用率警告线是 <span style='color:blue'>" + monitor.getJvm() + "%</span>，当前使用率是 <span style='color:red'>" + sigar.get("jvmUsage") + "%</span><br />";
		content += "您预设的 ram 使用率警告线是 <span style='color:blue'>" + monitor.getRam() + "%</span>，当前使用率是 <span style='color:red'>" + sigar.get("ramUsage") + "%</span><br />";
		if (Float.valueOf(sigar.get("cpuUsage").toString()) >= Float.valueOf(monitor.getCpu()) || Float.valueOf(sigar.get("jvmUsage").toString()) >= Float.valueOf(monitor.getJvm()) || Float.valueOf(sigar.get("ramUsage").toString()) >= Float.valueOf(monitor.getRam())) {
			// 邮件预警
			Map<String, Object> map = Maps.newHashMap();
			map.put("content", content);
			springMailSender.send(monitor.getToEmail(), "服务器监控预警", "monitor", map, true);
		}
		return sigar;
	}

	/**
	 * 修改配置
	 *
	 * @param monitor
	 * @return
	 * @throws Exception
	 */
	@ResponseBody
	@RequestMapping("modifySetting")
	public AjaxJson save(Monitor monitor) {
		AjaxJson j = new AjaxJson();
		String message = "保存成功";
		Monitor t = monitorService.get("1");
		try {
			monitor.setId("1");
			MyBeanUtils.copyBeanNotNull2Bean(monitor, t);
			monitorService.save(t);
		} catch (Exception e) {
			e.printStackTrace();
			j.setSuccess(false);
			message = "保存失败";
		}
		j.setMsg(message);
		return j;
	}
}