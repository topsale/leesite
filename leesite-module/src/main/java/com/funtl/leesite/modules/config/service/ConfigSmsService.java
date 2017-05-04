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
package com.funtl.leesite.modules.config.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.funtl.leesite.common.persistence.Page;
import com.funtl.leesite.common.service.CrudService;
import com.funtl.leesite.common.utils.StringUtils;
import com.funtl.leesite.modules.config.entity.ConfigSms;
import com.funtl.leesite.modules.config.dao.ConfigSmsDao;
import com.funtl.leesite.modules.config.entity.ConfigSmsTemplate;
import com.funtl.leesite.modules.config.dao.ConfigSmsTemplateDao;

/**
 * 短信配置Service
 * @author Lusifer
 * @version 2017-05-04
 */
@Service
@Transactional(readOnly = true)
public class ConfigSmsService extends CrudService<ConfigSmsDao, ConfigSms> {

	@Autowired
	private ConfigSmsTemplateDao configSmsTemplateDao;
	
	public ConfigSms get(String id) {
		ConfigSms configSms = super.get(id);
		configSms.setConfigSmsTemplateList(configSmsTemplateDao.findList(new ConfigSmsTemplate(configSms)));
		return configSms;
	}
	
	public List<ConfigSms> findList(ConfigSms configSms) {
		return super.findList(configSms);
	}
	
	public Page<ConfigSms> findPage(Page<ConfigSms> page, ConfigSms configSms) {
		return super.findPage(page, configSms);
	}
	
	@Transactional(readOnly = false)
	public void save(ConfigSms configSms) {
		super.save(configSms);
		for (ConfigSmsTemplate configSmsTemplate : configSms.getConfigSmsTemplateList()){
			if (configSmsTemplate.getId() == null){
				continue;
			}
			if (ConfigSmsTemplate.DEL_FLAG_NORMAL.equals(configSmsTemplate.getDelFlag())){
				if (StringUtils.isBlank(configSmsTemplate.getId())){
					configSmsTemplate.setConfigSms(configSms);
					configSmsTemplate.preInsert();
					configSmsTemplateDao.insert(configSmsTemplate);
				}else{
					configSmsTemplate.preUpdate();
					configSmsTemplateDao.update(configSmsTemplate);
				}
			}else{
				configSmsTemplateDao.delete(configSmsTemplate);
			}
		}
	}
	
	@Transactional(readOnly = false)
	public void delete(ConfigSms configSms) {
		super.delete(configSms);
		configSmsTemplateDao.delete(new ConfigSmsTemplate(configSms));
	}
	
}