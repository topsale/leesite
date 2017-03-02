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

package com.funtl.leesite.modules.iim.utils;


import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

/**
 * 日期及时间处理函数
 *
 * @author Lusifer
 */
public class DateUtil {

	private static final String DEFAULT_PATTERN = "yyyy-MM-dd HH:mm:ss";

	/**
	 * 字符串时间转LONG
	 *
	 * @param sdate
	 * @return
	 */
	public static long string2long(String sdate) {
		if (sdate.length() < 11) {
			sdate = sdate + " 00:00:00";
		}
		SimpleDateFormat sdf = new SimpleDateFormat(DEFAULT_PATTERN);
		Date dt2 = null;
		try {
			dt2 = sdf.parse(sdate);
		} catch (ParseException e) {
			e.printStackTrace();
		}
		//继续转换得到秒数的long型
		long lTime = dt2.getTime() / 1000;
		return lTime;
	}

	/**
	 * LONG时间转字符串
	 *
	 * @param ldate
	 * @return
	 */
	public static String long2string(long ldate) {
		SimpleDateFormat sdf = new SimpleDateFormat(DEFAULT_PATTERN);
		//前面的ldate是秒数，先乘1000得到毫秒数，再转为java.util.Date类型
		java.util.Date dt = new Date(ldate * 1000);
		String sDateTime = sdf.format(dt);  //得到精确到秒的表示
		if (sDateTime.endsWith("00:00:00")) {
			sDateTime = sDateTime.substring(0, 10);
		}
		return sDateTime;
	}
}
