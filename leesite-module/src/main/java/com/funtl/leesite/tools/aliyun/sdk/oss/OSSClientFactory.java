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

package com.funtl.leesite.tools.aliyun.sdk.oss;

import com.aliyun.oss.OSSClient;
import com.funtl.leesite.common.utils.SpringContextHolder;
import com.funtl.leesite.modules.aliyun.entity.ConfigAliyunOss;
import com.funtl.leesite.modules.aliyun.service.ConfigAliyunOssService;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 * OSSClient是OSS服务的Java客户端，它为调用者提供了一系列的方法，用于和OSS服务进行交互<br>
 *
 * @create date : 2014年10月28日 上午11:20:56
 * @Author XieXianbin<a.b@hotmail.com>
 * @Source Repositories Address: <https://github.com/qikemi/UEditor-for-aliyun-OSS>
 */
public class OSSClientFactory {
	private static Logger logger = LoggerFactory.getLogger(OSSClientFactory.class);
	private static OSSClient client = null;

	private static ConfigAliyunOssService configAliyunOssService = SpringContextHolder.getBean(ConfigAliyunOssService.class);

	/**
	 * 新建OSSClient
	 *
	 * @return
	 */
	public static OSSClient createOSSClient() {
		if (null == client) {
			ConfigAliyunOss configAliyunOss = configAliyunOssService.get("1");
			client = new OSSClient(configAliyunOss.getOssEndPoint(), configAliyunOss.getOssKey(), configAliyunOss.getOssSecret());
			logger.debug("First CreateOSSClient success.");
		}
		return client;
	}

}
