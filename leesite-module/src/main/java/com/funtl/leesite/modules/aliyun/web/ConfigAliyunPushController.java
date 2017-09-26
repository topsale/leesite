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

import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import com.aliyuncs.push.model.v20160801.ListSummaryAppsResponse;
import com.aliyuncs.push.model.v20160801.PushRequest;
import com.aliyuncs.utils.ParameterHelper;
import com.funtl.leesite.common.config.Global;
import com.funtl.leesite.common.mapper.JsonMapper;
import com.funtl.leesite.common.utils.DateUtils;
import com.funtl.leesite.common.utils.MyBeanUtils;
import com.funtl.leesite.common.utils.StringUtils;
import com.funtl.leesite.common.web.BaseController;
import com.funtl.leesite.modules.aliyun.entity.ConfigAliyunPush;
import com.funtl.leesite.modules.aliyun.service.ConfigAliyunPushService;
import com.funtl.leesite.tools.aliyun.java.sdk.push.PushApiForApp;
import com.funtl.leesite.tools.aliyun.java.sdk.push.PushApiForPush;
import com.funtl.leesite.tools.aliyun.java.sdk.push.PushConstant;
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
	public String form(ConfigAliyunPush configAliyunPush, Model model) throws Exception {
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

	/**
	 * APP概览列表
	 *
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequiresPermissions(value = "aliyun:configAliyunPush:view")
	@RequestMapping(value = "listSummaryApps")
	public String listSummaryApps(Model model) throws Exception {
		PushApiForApp pushApiForApp = new PushApiForApp();
		List<ListSummaryAppsResponse.SummaryAppInfo> summaryAppInfos = pushApiForApp.listSummaryApps();
		model.addAttribute("summaryAppInfos", summaryAppInfos);
		return "modules/aliyun/listSummaryApps";
	}

	/**
	 * 推送通知
	 *
	 * @return
	 */
	@RequiresPermissions(value = "aliyun:configAliyunPush:pushNotify")
	@RequestMapping(value = "pushNotify")
	public String pushNotify(PushRequest pushRequest, Model model) {
		pushRequest.setPushType(PushConstant.PushType.NOTICE);
		pushRequest.setDeviceType(PushConstant.DeviceType.ANDROID);
		model.addAttribute("pushRequest", pushRequest);
		return "modules/aliyun/pushNotify";
	}

	/**
	 * 推送消息
	 *
	 * @return
	 */
	@RequiresPermissions(value = "aliyun:configAliyunPush:pushMessage")
	@RequestMapping(value = "pushMessage")
	public String pushMessage(PushRequest pushRequest, Model model) {
		pushRequest.setPushType(PushConstant.PushType.MESSAGE);
		pushRequest.setDeviceType(PushConstant.DeviceType.ANDROID);
		model.addAttribute("pushRequest", pushRequest);
		return "modules/aliyun/pushMessage";
	}

	/**
	 * 发送推送
	 *
	 * @param pushRequest
	 * @param model
	 * @param redirectAttributes
	 * @return
	 */
	@RequiresPermissions(value = {"aliyun:configAliyunPush:pushNotify", "aliyun:configAliyunPush:pushMessage"})
	@RequestMapping(value = "sendPush")
	public String sendPush(PushRequest pushRequest, Model model, HttpServletRequest request, RedirectAttributes redirectAttributes) throws Exception {
		// 发送对象为所有人
		if (PushConstant.Target.ALL.equals(pushRequest.getTarget())) {
			pushRequest.setTargetValue(PushConstant.Target.ALL);
		}

		pushRequest.setAndroidNotificationBarType(1); // 通知栏自定义样式0-100
		pushRequest.setAndroidNotificationBarPriority(1); // 通知栏自定义样式0-100

		pushRequest.setAndroidMusic("default"); // Android通知音乐

		// 设定通知的扩展属性。(注意 : 该参数要以 json map 的格式传入,否则会解析出错)
		boolean hasExtParameters = "on".equals(request.getParameter("hasExtParameters")) ? true : false;
		if (hasExtParameters) {
			String[] extParameterKeys = request.getParameterValues("extParameterKeys");
			String[] extParameterValues = request.getParameterValues("extParameterValues");
			if (extParameterKeys != null && extParameterKeys.length > 0 && extParameterValues != null && extParameterValues.length > 0 && extParameterKeys.length == extParameterValues.length) {
				Map<String, String> kvMap = Maps.newHashMap();
				for (int i = 0; i < extParameterKeys.length; i++) {
					kvMap.put(extParameterKeys[i], extParameterValues[i]);
				}
				pushRequest.setAndroidExtParameters(JsonMapper.toJsonString(kvMap));
			}
		} else {
			pushRequest.setAndroidExtParameters("");
		}

		// 延后推送。可选，如果不设置表示立即推送
		if ("0".equals(pushRequest.getPushTime())) {
			Date pushDate = new Date(System.currentTimeMillis()); // 30秒之间的时间点, 也可以设置成你指定固定时间
			String pushTime = ParameterHelper.getISO8601Time(pushDate);
			pushRequest.setPushTime(pushTime);
		} else {
			Date pushDate = DateUtils.parseDate(request.getParameter("pushDate"));
			String pushTime = ParameterHelper.getISO8601Time(pushDate);
			pushRequest.setPushTime(pushTime);
		}

		// 离线消息是否保存,若保存, 在推送时候，用户即使不在线，下一次上线则会收到
		if (pushRequest.getStoreOffline()) {
			int iExpireTime = Integer.parseInt(request.getParameter("expireTime"));
			String expireTime = ParameterHelper.getISO8601Time(new Date(System.currentTimeMillis() + iExpireTime * 3600 * 1000)); // iExpireTime 小时后消息失效, 不会再发送
			pushRequest.setExpireTime(expireTime);
		} else {
			String expireTime = ParameterHelper.getISO8601Time(new Date(System.currentTimeMillis()  + 1 * 3600 * 1000));
			pushRequest.setExpireTime(expireTime);
		}

		// 发送
		PushApiForPush pushApiForPush = new PushApiForPush();
		pushApiForPush.advancedPush(pushRequest);


		if (PushConstant.PushType.MESSAGE.equals(pushRequest.getPushType())) {
			addMessage(redirectAttributes, "推送消息成功");
			return "redirect:" + Global.getAdminPath() + "/aliyun/configAliyunPush/pushMessage";
		} else {
			addMessage(redirectAttributes, "推送通知成功");
			return "redirect:" + Global.getAdminPath() + "/aliyun/configAliyunPush/pushNotify";
		}
	}

}