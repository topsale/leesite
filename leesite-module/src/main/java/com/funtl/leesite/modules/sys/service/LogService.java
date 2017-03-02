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

import com.funtl.leesite.common.persistence.Page;
import com.funtl.leesite.common.service.CrudService;
import com.funtl.leesite.common.utils.DateUtils;
import com.funtl.leesite.modules.sys.dao.LogDao;
import com.funtl.leesite.modules.sys.entity.Log;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

/**
 * 日志Service
 *
 * @author Lusifer
 * @version 2014-05-16
 */
@Service
@Transactional(readOnly = true)
public class LogService extends CrudService<LogDao, Log> {

	@Autowired
	private LogDao logDao;

	public Page<Log> findPage(Page<Log> page, Log log) {

		// 设置默认时间范围，默认当前月
		if (log.getBeginDate() == null) {
			log.setBeginDate(DateUtils.setDays(DateUtils.parseDate(DateUtils.getDate()), 1));
		}
		if (log.getEndDate() == null) {
			log.setEndDate(DateUtils.addMonths(log.getBeginDate(), 1));
		}

		return super.findPage(page, log);

	}

	/**
	 * 删除全部数据
	 *
	 * @param entity
	 */
	@Transactional(readOnly = false)
	public void empty() {

		logDao.empty();
	}

}
