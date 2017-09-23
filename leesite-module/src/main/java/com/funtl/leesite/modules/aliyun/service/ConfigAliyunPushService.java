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
package com.funtl.leesite.modules.aliyun.service;

import java.util.List;

import com.funtl.leesite.common.persistence.Page;
import com.funtl.leesite.common.service.CrudService;
import com.funtl.leesite.modules.aliyun.dao.ConfigAliyunPushDao;
import com.funtl.leesite.modules.aliyun.entity.ConfigAliyunPush;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

/**
 * 阿里云配置Service
 *
 * @author Lusifer
 * @version 2017-09-23
 */
@Service
@Transactional(readOnly = true)
public class ConfigAliyunPushService extends CrudService<ConfigAliyunPushDao, ConfigAliyunPush> {

	public ConfigAliyunPush get(String id) {
		return super.get(id);
	}

	public List<ConfigAliyunPush> findList(ConfigAliyunPush configAliyunPush) {
		return super.findList(configAliyunPush);
	}

	public Page<ConfigAliyunPush> findPage(Page<ConfigAliyunPush> page, ConfigAliyunPush configAliyunPush) {
		return super.findPage(page, configAliyunPush);
	}

	@Transactional(readOnly = false)
	public void save(ConfigAliyunPush configAliyunPush) {
		super.save(configAliyunPush);
	}

	@Transactional(readOnly = false)
	public void delete(ConfigAliyunPush configAliyunPush) {
		super.delete(configAliyunPush);
	}


}