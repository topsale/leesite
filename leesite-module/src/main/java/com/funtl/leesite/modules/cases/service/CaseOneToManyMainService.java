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

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.funtl.leesite.common.persistence.Page;
import com.funtl.leesite.common.service.CrudService;
import com.funtl.leesite.common.utils.StringUtils;
import com.funtl.leesite.modules.cases.entity.CaseOneToManyMain;
import com.funtl.leesite.modules.cases.dao.CaseOneToManyMainDao;
import com.funtl.leesite.modules.cases.entity.CaseOneToManyFirst;
import com.funtl.leesite.modules.cases.dao.CaseOneToManyFirstDao;
import com.funtl.leesite.modules.cases.entity.CaseOneToManySecond;
import com.funtl.leesite.modules.cases.dao.CaseOneToManySecondDao;
import com.funtl.leesite.modules.cases.entity.CaseOneToManyThird;
import com.funtl.leesite.modules.cases.dao.CaseOneToManyThirdDao;

/**
 * 生成示例Service
 * @author Lusifer
 * @version 2017-05-05
 */
@Service
@Transactional(readOnly = true)
public class CaseOneToManyMainService extends CrudService<CaseOneToManyMainDao, CaseOneToManyMain> {

	@Autowired
	private CaseOneToManyFirstDao caseOneToManyFirstDao;
	@Autowired
	private CaseOneToManySecondDao caseOneToManySecondDao;
	@Autowired
	private CaseOneToManyThirdDao caseOneToManyThirdDao;
	
	public CaseOneToManyMain get(String id) {
		CaseOneToManyMain caseOneToManyMain = super.get(id);
		caseOneToManyMain.setCaseOneToManyFirstList(caseOneToManyFirstDao.findList(new CaseOneToManyFirst(caseOneToManyMain)));
		caseOneToManyMain.setCaseOneToManySecondList(caseOneToManySecondDao.findList(new CaseOneToManySecond(caseOneToManyMain)));
		caseOneToManyMain.setCaseOneToManyThirdList(caseOneToManyThirdDao.findList(new CaseOneToManyThird(caseOneToManyMain)));
		return caseOneToManyMain;
	}
	
	public List<CaseOneToManyMain> findList(CaseOneToManyMain caseOneToManyMain) {
		return super.findList(caseOneToManyMain);
	}
	
	public Page<CaseOneToManyMain> findPage(Page<CaseOneToManyMain> page, CaseOneToManyMain caseOneToManyMain) {
		return super.findPage(page, caseOneToManyMain);
	}
	
	@Transactional(readOnly = false)
	public void save(CaseOneToManyMain caseOneToManyMain) {
		super.save(caseOneToManyMain);
		for (CaseOneToManyFirst caseOneToManyFirst : caseOneToManyMain.getCaseOneToManyFirstList()){
			if (caseOneToManyFirst.getId() == null){
				continue;
			}
			if (CaseOneToManyFirst.DEL_FLAG_NORMAL.equals(caseOneToManyFirst.getDelFlag())){
				if (StringUtils.isBlank(caseOneToManyFirst.getId())){
					caseOneToManyFirst.setCaseOneToManyMain(caseOneToManyMain);
					caseOneToManyFirst.preInsert();
					caseOneToManyFirstDao.insert(caseOneToManyFirst);
				}else{
					caseOneToManyFirst.preUpdate();
					caseOneToManyFirstDao.update(caseOneToManyFirst);
				}
			}else{
				caseOneToManyFirstDao.delete(caseOneToManyFirst);
			}
		}
		for (CaseOneToManySecond caseOneToManySecond : caseOneToManyMain.getCaseOneToManySecondList()){
			if (caseOneToManySecond.getId() == null){
				continue;
			}
			if (CaseOneToManySecond.DEL_FLAG_NORMAL.equals(caseOneToManySecond.getDelFlag())){
				if (StringUtils.isBlank(caseOneToManySecond.getId())){
					caseOneToManySecond.setCaseOneToManyMain(caseOneToManyMain);
					caseOneToManySecond.preInsert();
					caseOneToManySecondDao.insert(caseOneToManySecond);
				}else{
					caseOneToManySecond.preUpdate();
					caseOneToManySecondDao.update(caseOneToManySecond);
				}
			}else{
				caseOneToManySecondDao.delete(caseOneToManySecond);
			}
		}
		for (CaseOneToManyThird caseOneToManyThird : caseOneToManyMain.getCaseOneToManyThirdList()){
			if (caseOneToManyThird.getId() == null){
				continue;
			}
			if (CaseOneToManyThird.DEL_FLAG_NORMAL.equals(caseOneToManyThird.getDelFlag())){
				if (StringUtils.isBlank(caseOneToManyThird.getId())){
					caseOneToManyThird.setCaseOneToManyMain(caseOneToManyMain);
					caseOneToManyThird.preInsert();
					caseOneToManyThirdDao.insert(caseOneToManyThird);
				}else{
					caseOneToManyThird.preUpdate();
					caseOneToManyThirdDao.update(caseOneToManyThird);
				}
			}else{
				caseOneToManyThirdDao.delete(caseOneToManyThird);
			}
		}
	}
	
	@Transactional(readOnly = false)
	public void delete(CaseOneToManyMain caseOneToManyMain) {
		super.delete(caseOneToManyMain);
		caseOneToManyFirstDao.delete(new CaseOneToManyFirst(caseOneToManyMain));
		caseOneToManySecondDao.delete(new CaseOneToManySecond(caseOneToManyMain));
		caseOneToManyThirdDao.delete(new CaseOneToManyThird(caseOneToManyMain));
	}
	
}