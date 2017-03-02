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

package com.funtl.leesite.common.xstream;

import java.util.Date;

import com.funtl.leesite.common.utils.DateUtils;
import com.thoughtworks.xstream.converters.Converter;
import com.thoughtworks.xstream.converters.MarshallingContext;
import com.thoughtworks.xstream.converters.UnmarshallingContext;
import com.thoughtworks.xstream.io.HierarchicalStreamReader;
import com.thoughtworks.xstream.io.HierarchicalStreamWriter;

/**
 * XStream 日期转换类
 *
 * @author WangZhen
 */
public class DateTimeConverter implements Converter {

	public void marshal(Object source, HierarchicalStreamWriter writer, MarshallingContext context) {
		Date date = (Date) source;
		if (date != null) {
			writer.setValue(DateUtils.formatDateTime(date));
		} else {
			writer.setValue("");
		}
	}

	public Object unmarshal(HierarchicalStreamReader reader, UnmarshallingContext context) {
		try {
			Date date = DateUtils.parseDate(reader.getValue());
			return date;
		} catch (Exception e) {
			return null;
		}
	}

	@SuppressWarnings("rawtypes")
	public boolean canConvert(Class type) {
		return type.equals(Date.class);
	}

}
