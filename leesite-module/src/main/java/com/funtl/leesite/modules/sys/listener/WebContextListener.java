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

package com.funtl.leesite.modules.sys.listener;

import java.util.concurrent.ExecutorService;
import java.util.concurrent.TimeUnit;

import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;

import com.funtl.leesite.common.sms.SmsValidateDisruptor;
import com.funtl.leesite.common.utils.ExecutorUtils;
import com.funtl.leesite.modules.sys.service.SystemService;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.context.WebApplicationContext;

public class WebContextListener extends org.springframework.web.context.ContextLoaderListener {
	private static final Logger logger = LoggerFactory.getLogger(WebContextListener.class);

	@Override
	public WebApplicationContext initWebApplicationContext(ServletContext servletContext) {
		if (!SystemService.printKeyLoadMessage()) {
			return null;
		}
		return super.initWebApplicationContext(servletContext);
	}

	@Override
	public void contextDestroyed(ServletContextEvent event) {
		// TODO 容器销毁时调用

		// 关闭 Disruptor
		SmsValidateDisruptor.getInstance().shutdown();

		try {
			// 平缓关闭 ExecutorService
			ExecutorService executor = ExecutorUtils.getCachedThreadPool();
			executor.shutdownNow();
			executor.awaitTermination(30 * 1000, TimeUnit.MILLISECONDS);
		} catch (InterruptedException e) {
			e.printStackTrace();
		}
		super.contextDestroyed(event);
	}
}
