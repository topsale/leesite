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

package com.funtl.leesite.modules.sys.service;

import java.util.List;

import com.funtl.leesite.common.service.TreeService;
import com.funtl.leesite.modules.sys.dao.OfficeDao;
import com.funtl.leesite.modules.sys.entity.Office;
import com.funtl.leesite.modules.sys.utils.UserUtils;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

/**
 * 机构Service
 *
 * @author Lusifer
 * @version 2014-05-16
 */
@Service
@Transactional(readOnly = true)
public class OfficeService extends TreeService<OfficeDao, Office> {

	public List<Office> findAll() {
		return UserUtils.getOfficeList();
	}

	public List<Office> findList(Boolean isAll) {
		if (isAll != null && isAll) {
			return UserUtils.getOfficeAllList();
		} else {
			return UserUtils.getOfficeList();
		}
	}

	@Transactional(readOnly = true)
	public List<Office> findList(Office office) {
		office.setParentIds(office.getParentIds() + "%");
		return dao.findByParentIdsLike(office);
	}

	@Transactional(readOnly = true)
	public Office getByCode(String code) {
		return dao.getByCode(code);
	}


	@Transactional(readOnly = false)
	public void save(Office office) {
		super.save(office);
		UserUtils.removeCache(UserUtils.CACHE_OFFICE_LIST);
	}

	@Transactional(readOnly = false)
	public void delete(Office office) {
		super.delete(office);
		UserUtils.removeCache(UserUtils.CACHE_OFFICE_LIST);
	}

}
