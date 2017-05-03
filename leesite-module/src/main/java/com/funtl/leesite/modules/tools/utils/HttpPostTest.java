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

package com.funtl.leesite.modules.tools.utils;


import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.apache.http.HttpEntity;
import org.apache.http.HttpResponse;
import org.apache.http.NameValuePair;
import org.apache.http.ParseException;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.client.methods.HttpUriRequest;
import org.apache.http.entity.ContentType;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.impl.conn.PoolingHttpClientConnectionManager;
import org.apache.http.message.BasicNameValuePair;
import org.apache.http.util.EntityUtils;
import org.apache.log4j.Logger;


public class HttpPostTest {
	private static Logger log = Logger.getLogger(HttpPostTest.class);
	Map<String, String> params;
	String url;

	public static String post(String url, Map<String, String> params) {
		PoolingHttpClientConnectionManager cm = new PoolingHttpClientConnectionManager();
		CloseableHttpClient httpclient = HttpClients.custom().setConnectionManager(cm).build();
		String body = null;

		log.info("create httppost:" + url);
		HttpPost post = postForm(url, params);

		body = invoke(httpclient, post);

		return body;
	}

	public HttpPostTest(String url, Map<String, String> params) {
		this.url = url;
		this.params = params;
	}

	public static String get(String url) {
		PoolingHttpClientConnectionManager cm = new PoolingHttpClientConnectionManager();
		CloseableHttpClient httpclient = HttpClients.custom().setConnectionManager(cm).build();
		String body = null;

		log.info("create httppost:" + url);
		HttpGet get = new HttpGet(url);
		body = invoke(httpclient, get);

		return body;
	}


	private static String invoke(CloseableHttpClient httpclient, HttpUriRequest httpost) {

		HttpResponse response = sendRequest(httpclient, httpost);
		String body = paseResponse(response);

		return body;
	}

	private static String paseResponse(HttpResponse response) {
		log.info("get response from http server..");
		HttpEntity entity = response.getEntity();

		log.info("response status: " + response.getStatusLine());
		String charset = ContentType.getOrDefault(entity).getCharset().toString();
		log.info(charset);

		String body = null;
		try {
			body = EntityUtils.toString(entity);
			log.info(body);
		} catch (ParseException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}

		return body;
	}

	private static HttpResponse sendRequest(CloseableHttpClient httpclient, HttpUriRequest httpost) {
		log.info("execute post...");
		HttpResponse response = null;

		try {
			response = httpclient.execute(httpost);
		} catch (ClientProtocolException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		return response;
	}

	private static HttpPost postForm(String url, Map<String, String> params) {

		HttpPost httpost = new HttpPost(url);
		List<NameValuePair> nvps = new ArrayList<NameValuePair>();

		Set<String> keySet = params.keySet();
		for (String key : keySet) {
			nvps.add(new BasicNameValuePair(key, params.get(key)));
		}

		log.info("set utf-8 form entity to httppost");
		httpost.setEntity(new UrlEncodedFormEntity(nvps, StandardCharsets.UTF_8));

		return httpost;
	}

	public static void main(String[] agrs) {
		Map<String, String> params = new HashMap<String, String>();
		params.put("name", "jeeplus");
		params.put("password", "admin");

		String xml = HttpPostTest.post("http://localhost:8080/HeartCare/a/login", params);
	}

	public String post() {

		//		Map<String, String> params = new HashMap<String, String>();
		//		params.put("name", "admin");
		//		params.put("password", "admin");

		String xml = HttpPostTest.post(url, params);
		return xml;
	}
}
