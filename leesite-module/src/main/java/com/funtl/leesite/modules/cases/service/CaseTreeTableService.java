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
package com.funtl.leesite.modules.cases.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.funtl.leesite.common.service.TreeService;
import com.funtl.leesite.common.utils.StringUtils;
import com.funtl.leesite.modules.cases.entity.CaseTreeTable;
import com.funtl.leesite.modules.cases.dao.CaseTreeTableDao;

/**
 * 生成示例Service
 * @author Lusifer
 * @version 2017-05-05
 */
@Service
@Transactional(readOnly = true)
public class CaseTreeTableService extends TreeService<CaseTreeTableDao, CaseTreeTable> {

	public CaseTreeTable get(String id) {
		return super.get(id);
	}
	
	public List<CaseTreeTable> findList(CaseTreeTable caseTreeTable) {
		if (StringUtils.isNotBlank(caseTreeTable.getParentIds())){
			caseTreeTable.setParentIds(","+caseTreeTable.getParentIds()+",");
		}
		return super.findList(caseTreeTable);
	}
	
	@Transactional(readOnly = false)
	public void save(CaseTreeTable caseTreeTable) {
		super.save(caseTreeTable);
	}
	
	@Transactional(readOnly = false)
	public void delete(CaseTreeTable caseTreeTable) {
		super.delete(caseTreeTable);
	}
	
}