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

package com.funtl.leesite.modules.test.service.one;

import java.util.List;

import com.funtl.leesite.common.persistence.Page;
import com.funtl.leesite.common.service.CrudService;
import com.funtl.leesite.modules.test.dao.one.FormLeaveDao;
import com.funtl.leesite.modules.test.entity.one.FormLeave;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

/**
 * 员工请假Service
 *
 * @author Lusifer
 * @version 2016-06-22
 */
@Service
@Transactional(readOnly = true)
public class FormLeaveService extends CrudService<FormLeaveDao, FormLeave> {

	public FormLeave get(String id) {
		return super.get(id);
	}

	public List<FormLeave> findList(FormLeave formLeave) {
		return super.findList(formLeave);
	}

	public Page<FormLeave> findPage(Page<FormLeave> page, FormLeave formLeave) {
		return super.findPage(page, formLeave);
	}

	@Transactional(readOnly = false)
	public void save(FormLeave formLeave) {
		super.save(formLeave);
	}

	@Transactional(readOnly = false)
	public void delete(FormLeave formLeave) {
		super.delete(formLeave);
	}


}