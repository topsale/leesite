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

package com.funtl.leesite.modules.gen.service;

import com.funtl.leesite.common.persistence.Page;
import com.funtl.leesite.common.service.BaseService;
import com.funtl.leesite.common.utils.StringUtils;
import com.funtl.leesite.modules.gen.dao.GenTemplateDao;
import com.funtl.leesite.modules.gen.entity.GenTemplate;

import org.apache.commons.lang3.StringEscapeUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

/**
 * 代码模板Service
 *
 * @author Lusifer
 * @version 2013-10-15
 */
@Service
@Transactional(readOnly = true)
public class GenTemplateService extends BaseService {

	@Autowired
	private GenTemplateDao genTemplateDao;

	public GenTemplate get(String id) {
		return genTemplateDao.get(id);
	}

	public Page<GenTemplate> find(Page<GenTemplate> page, GenTemplate genTemplate) {
		genTemplate.setPage(page);
		page.setList(genTemplateDao.findList(genTemplate));
		return page;
	}

	@Transactional(readOnly = false)
	public void save(GenTemplate genTemplate) {
		if (genTemplate.getContent() != null) {
			genTemplate.setContent(StringEscapeUtils.unescapeHtml4(genTemplate.getContent()));
		}
		if (StringUtils.isBlank(genTemplate.getId())) {
			genTemplate.preInsert();
			genTemplateDao.insert(genTemplate);
		} else {
			genTemplate.preUpdate();
			genTemplateDao.update(genTemplate);
		}
	}

	@Transactional(readOnly = false)
	public void delete(GenTemplate genTemplate) {
		genTemplateDao.delete(genTemplate);
	}

}
