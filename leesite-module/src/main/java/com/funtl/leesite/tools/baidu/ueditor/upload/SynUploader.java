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

package com.funtl.leesite.tools.baidu.ueditor.upload;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;

import javax.servlet.http.HttpServletRequest;

import com.aliyun.oss.OSSClient;
import com.aliyun.oss.model.Bucket;
import com.aliyun.oss.model.PutObjectResult;
import com.funtl.leesite.common.utils.SpringContextHolder;
import com.funtl.leesite.modules.aliyun.entity.ConfigAliyunOss;
import com.funtl.leesite.modules.aliyun.service.ConfigAliyunOssService;
import com.funtl.leesite.tools.aliyun.sdk.oss.BucketService;
import com.funtl.leesite.tools.aliyun.sdk.oss.ObjectService;
import com.funtl.leesite.tools.baidu.ueditor.utils.SystemUtil;

import org.json.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 * 同步上传文件到阿里云OSS<br>
 *
 * @create date : 2014年10月28日 22:11:00
 * @Author XieXianbin<a.b@hotmail.com>
 * @Source Repositories Address:
 * <https://github.com/qikemi/UEditor-for-aliyun-OSS>
 */
public class SynUploader extends Thread {
	private static Logger logger = LoggerFactory.getLogger(SynUploader.class);

	private ConfigAliyunOssService configAliyunOssService = SpringContextHolder.getBean(ConfigAliyunOssService.class);

	public boolean upload(JSONObject stateJson, OSSClient client, HttpServletRequest request) {
		ConfigAliyunOss configAliyunOss = configAliyunOssService.get("1");

		Bucket bucket = BucketService.create(client, configAliyunOss.getBucketName());
		// get the key, which the upload file path
		String key = stateJson.getString("url").replaceFirst("/", "");
		try {
			FileInputStream fileInputStream = new FileInputStream(new File(SystemUtil.getProjectRootPath() + key));
			PutObjectResult result = ObjectService.putObject(client, bucket.getName(), key, fileInputStream);
			logger.debug("upload file to aliyun OSS object server success. ETag: " + result.getETag());
			return true;
		} catch (FileNotFoundException e) {
			logger.error("upload file to aliyun OSS object server occur FileNotFoundException.");
		} catch (NumberFormatException e) {
			logger.error("upload file to aliyun OSS object server occur NumberFormatException.");
		} catch (IOException e) {
			logger.error("upload file to aliyun OSS object server occur IOException.");
		}
		return false;
	}

}
