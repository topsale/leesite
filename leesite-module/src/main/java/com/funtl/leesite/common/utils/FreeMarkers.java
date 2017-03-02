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

import freemarker.template.Configuration;
import freemarker.template.Template;

import java.io.IOException;
import java.io.StringReader;
import java.io.StringWriter;
import java.util.Map;

import org.springframework.core.io.DefaultResourceLoader;
import org.springframework.core.io.Resource;

/**
 * FreeMarkers工具类
 *
 * @author Lusifer
 * @version 2013-01-15
 */
public class FreeMarkers {

	public static String renderString(String templateString, Map<String, ?> model) {
		try {
			StringWriter result = new StringWriter();
			Template t = new Template("name", new StringReader(templateString), new Configuration(Configuration.VERSION_2_3_23));
			t.process(model, result);
			return result.toString();
		} catch (Exception e) {
			throw Exceptions.unchecked(e);
		}
	}

	public static String renderTemplate(Template template, Object model) {
		try {
			StringWriter result = new StringWriter();
			template.process(model, result);
			return result.toString();
		} catch (Exception e) {
			throw Exceptions.unchecked(e);
		}
	}

	public static Configuration buildConfiguration(String directory) throws IOException {
		Configuration cfg = new Configuration(Configuration.VERSION_2_3_23);
		Resource path = new DefaultResourceLoader().getResource(directory);
		cfg.setDirectoryForTemplateLoading(path.getFile());
		return cfg;
	}

	public static void main(String[] args) throws IOException {
		//		// renderString
		//		Map<String, String> model = com.google.common.collect.Maps.newHashMap();
		//		model.put("userName", "calvin");
		//		String result = FreeMarkers.renderString("hello ${userName}", model);
		//		System.out.println(result);
		//		// renderTemplate
		//		Configuration cfg = FreeMarkers.buildConfiguration("classpath:/");
		//		Template template = cfg.getTemplate("testTemplate.ftl");
		//		String result2 = FreeMarkers.renderTemplate(template, model);
		//		System.out.println(result2);

		//		Map<String, String> model = com.google.common.collect.Maps.newHashMap();
		//		model.put("userName", "calvin");
		//		String result = FreeMarkers.renderString("hello ${userName} ${r'${userName}'}", model);
		//		System.out.println(result);
	}

}
