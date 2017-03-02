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

package com.funtl.leesite.common.web;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.ckfinder.connector.ConnectorServlet;
import com.funtl.leesite.common.config.Global;
import com.funtl.leesite.common.utils.FileUtils;
import com.funtl.leesite.modules.sys.security.SystemAuthorizingRealm.Principal;
import com.funtl.leesite.modules.sys.utils.UserUtils;

/**
 * CKFinderConnectorServlet
 *
 * @author Lusifer
 * @version 2014-06-25
 */
public class CKFinderConnectorServlet extends ConnectorServlet {

	private static final long serialVersionUID = 1L;

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		prepareGetResponse(request, response, false);
		super.doGet(request, response);
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		prepareGetResponse(request, response, true);
		super.doPost(request, response);
	}

	private void prepareGetResponse(final HttpServletRequest request, final HttpServletResponse response, final boolean post) throws ServletException {
		Principal principal = (Principal) UserUtils.getPrincipal();
		if (principal == null) {
			return;
		}
		String command = request.getParameter("command");
		String type = request.getParameter("type");
		// 初始化时，如果startupPath文件夹不存在，则自动创建startupPath文件夹
		if ("Init".equals(command)) {
			String startupPath = request.getParameter("startupPath");// 当前文件夹可指定为模块名
			if (startupPath != null) {
				String[] ss = startupPath.split(":");
				if (ss.length == 2) {
					String realPath = Global.getUserfilesBaseDir() + Global.USERFILES_BASE_URL + principal + "/" + ss[0] + ss[1];
					FileUtils.createDirectory(realPath);
				}
			}
		}
		// 快捷上传，自动创建当前文件夹，并上传到该路径
		else if ("QuickUpload".equals(command) && type != null) {
			String currentFolder = request.getParameter("currentFolder");// 当前文件夹可指定为模块名
			String realPath = Global.getUserfilesBaseDir() + Global.USERFILES_BASE_URL + principal + "/" + type + (currentFolder != null ? currentFolder : "");
			FileUtils.createDirectory(realPath);
		}
		//		System.out.println("------------------------");
		//		for (Object key : request.getParameterMap().keySet()){
		//			System.out.println(key + ": " + request.getParameter(key.toString()));
		//		}
	}

}
