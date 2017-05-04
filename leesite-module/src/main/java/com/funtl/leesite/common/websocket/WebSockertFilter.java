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

package com.funtl.leesite.common.websocket;

import java.io.IOException;
import java.net.UnknownHostException;
import java.util.Calendar;
import java.util.Date;
import java.util.Timer;
import java.util.TimerTask;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;

import com.funtl.leesite.common.websocket.onchat.ChatServer;

import org.java_websocket.WebSocketImpl;


public class WebSockertFilter implements Filter {


	/**
	 * 初始化
	 */
	public void init(FilterConfig fc) throws ServletException {
		this.startWebsocketChatServer();
		//	this.startWebsocketOnline();
	}

	/**
	 * 启动即时聊天服务
	 */
	public void startWebsocketChatServer() {
		WebSocketImpl.DEBUG = false;
		ChatServer s;
		try {
			s = new ChatServer(8668);
			s.start();
			System.out.println("WebSocket server is started. Port: " + s.getPort());
		} catch (UnknownHostException e) {
			e.printStackTrace();
		}
	}


	//计时器
	public void timer() {
		Calendar calendar = Calendar.getInstance();
		calendar.set(Calendar.HOUR_OF_DAY, 9); // 控制时
		calendar.set(Calendar.MINUTE, 0);        // 控制分
		calendar.set(Calendar.SECOND, 0);        // 控制秒

		Date time = calendar.getTime();        // 得出执行任务的时间

		Timer timer = new Timer();
		timer.scheduleAtFixedRate(new TimerTask() {
			public void run() {

				//PersonService personService = (PersonService)ApplicationContext.getBean("personService");


				//System.out.println("-------设定要指定任务--------");
			}
		}, time, 1000 * 60 * 60 * 24);// 这里设定将延时每天固定执行
	}


	public void destroy() {

	}


	public void doFilter(ServletRequest arg0, ServletResponse arg1, FilterChain arg2) throws IOException, ServletException {

	}


}
