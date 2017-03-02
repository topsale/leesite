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

package com.funtl.leesite.modules.monitor.service;

import java.util.List;

import com.funtl.leesite.common.persistence.Page;
import com.funtl.leesite.common.service.CrudService;
import com.funtl.leesite.modules.monitor.dao.MonitorDao;
import com.funtl.leesite.modules.monitor.entity.Monitor;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

/**
 * 系统监控Service
 *
 * @author Lusifer
 * @version 2016-02-07
 */
@Service
@Transactional(readOnly = true)
public class MonitorService extends CrudService<MonitorDao, Monitor> {

	public Monitor get(String id) {
		return super.get(id);
	}

	public List<Monitor> findList(Monitor monitor) {
		return super.findList(monitor);
	}

	public Page<Monitor> findPage(Page<Monitor> page, Monitor monitor) {
		return super.findPage(page, monitor);
	}

	@Transactional(readOnly = false)
	public void save(Monitor monitor) {
		super.save(monitor);
	}

	@Transactional(readOnly = false)
	public void delete(Monitor monitor) {
		super.delete(monitor);
	}

}