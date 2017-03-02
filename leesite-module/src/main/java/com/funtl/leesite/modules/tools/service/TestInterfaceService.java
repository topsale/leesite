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

package com.funtl.leesite.modules.tools.service;

import java.util.List;

import com.funtl.leesite.common.persistence.Page;
import com.funtl.leesite.common.service.CrudService;
import com.funtl.leesite.modules.tools.dao.TestInterfaceDao;
import com.funtl.leesite.modules.tools.entity.TestInterface;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

/**
 * 接口Service
 *
 * @author lgf
 * @version 2016-01-07
 */
@Service
@Transactional(readOnly = true)
public class TestInterfaceService extends CrudService<TestInterfaceDao, TestInterface> {

	public TestInterface get(String id) {
		return super.get(id);
	}

	public List<TestInterface> findList(TestInterface testInterface) {
		return super.findList(testInterface);
	}

	public Page<TestInterface> findPage(Page<TestInterface> page, TestInterface testInterface) {
		return super.findPage(page, testInterface);
	}

	@Transactional(readOnly = false)
	public void save(TestInterface testInterface) {
		super.save(testInterface);
	}

	@Transactional(readOnly = false)
	public void delete(TestInterface testInterface) {
		super.delete(testInterface);
	}

}