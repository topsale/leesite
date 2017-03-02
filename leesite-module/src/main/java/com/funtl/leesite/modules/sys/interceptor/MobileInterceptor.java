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

package com.funtl.leesite.modules.sys.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.funtl.leesite.common.service.BaseService;

import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

/**
 * 手机端视图拦截器
 *
 * @author Lusifer
 * @version 2014-9-1
 */
public class MobileInterceptor extends BaseService implements HandlerInterceptor {

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
		return true;
	}

	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler, ModelAndView modelAndView) throws Exception {
		//		if (modelAndView != null){//手机端没有开发，默认打开PC端界面。如果你自己开发app端界面，请取消该注释。
		//			// 如果是手机或平板访问的话，则跳转到手机视图页面。
		//			if(UserAgentUtils.isMobileOrTablet(request) && !StringUtils.startsWithIgnoreCase(modelAndView.getViewName(), "redirect:")){
		//				modelAndView.setViewName("mobile/" + modelAndView.getViewName());
		//			}
		//		}
	}

	@Override
	public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex) throws Exception {

	}

}
