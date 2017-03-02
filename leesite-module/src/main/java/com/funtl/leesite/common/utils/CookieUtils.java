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

package com.funtl.leesite.common.utils;

import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.net.URLEncoder;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Cookie工具类
 *
 * @author Lusifer
 * @version 2013-01-15
 */
public class CookieUtils {

	/**
	 * 设置 Cookie（生成时间为1天）
	 *
	 * @param name  名称
	 * @param value 值
	 */
	public static void setCookie(HttpServletResponse response, String name, String value) {
		setCookie(response, name, value, 60 * 60 * 24);
	}

	/**
	 * 设置 Cookie
	 *
	 * @param name   名称
	 * @param value  值
	 * @param maxAge 生存时间（单位秒）
	 * @param uri    路径
	 */
	public static void setCookie(HttpServletResponse response, String name, String value, String path) {
		setCookie(response, name, value, path, 60 * 60 * 24);
	}

	/**
	 * 设置 Cookie
	 *
	 * @param name   名称
	 * @param value  值
	 * @param maxAge 生存时间（单位秒）
	 * @param uri    路径
	 */
	public static void setCookie(HttpServletResponse response, String name, String value, int maxAge) {
		setCookie(response, name, value, "/", maxAge);
	}

	/**
	 * 设置 Cookie
	 *
	 * @param name   名称
	 * @param value  值
	 * @param maxAge 生存时间（单位秒）
	 * @param uri    路径
	 */
	public static void setCookie(HttpServletResponse response, String name, String value, String path, int maxAge) {
		Cookie cookie = new Cookie(name, null);
		cookie.setPath(path);
		cookie.setMaxAge(maxAge);
		try {
			cookie.setValue(URLEncoder.encode(value, "utf-8"));
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		response.addCookie(cookie);
	}

	/**
	 * 获得指定Cookie的值
	 *
	 * @param name 名称
	 * @return 值
	 */
	public static String getCookie(HttpServletRequest request, String name) {
		return getCookie(request, null, name, false);
	}

	/**
	 * 获得指定Cookie的值，并删除。
	 *
	 * @param name 名称
	 * @return 值
	 */
	public static String getCookie(HttpServletRequest request, HttpServletResponse response, String name) {
		return getCookie(request, response, name, true);
	}

	/**
	 * 获得指定Cookie的值
	 *
	 * @param request  请求对象
	 * @param response 响应对象
	 * @param name     名字
	 * @param isRemove 是否移除
	 * @return 值
	 */
	public static String getCookie(HttpServletRequest request, HttpServletResponse response, String name, boolean isRemove) {
		String value = null;
		Cookie[] cookies = request.getCookies();
		if (cookies != null) {
			for (Cookie cookie : cookies) {
				if (cookie.getName().equals(name)) {
					try {
						value = URLDecoder.decode(cookie.getValue(), "utf-8");
					} catch (UnsupportedEncodingException e) {
						e.printStackTrace();
					}
					if (isRemove) {
						cookie.setMaxAge(0);
						response.addCookie(cookie);
					}
				}
			}
		}
		return value;
	}
}
