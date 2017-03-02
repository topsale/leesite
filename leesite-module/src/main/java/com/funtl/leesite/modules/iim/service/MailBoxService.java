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

package com.funtl.leesite.modules.iim.service;

import java.util.List;

import com.funtl.leesite.common.persistence.Page;
import com.funtl.leesite.common.service.CrudService;
import com.funtl.leesite.modules.iim.dao.MailBoxDao;
import com.funtl.leesite.modules.iim.entity.MailBox;
import com.funtl.leesite.modules.iim.entity.MailPage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

/**
 * 收件箱Service
 *
 * @author Lusifer
 * @version 2015-11-13
 */
@Service
@Transactional(readOnly = true)
public class MailBoxService extends CrudService<MailBoxDao, MailBox> {

	@Autowired
	private MailBoxDao mailBoxDao;

	public MailBox get(String id) {
		return super.get(id);
	}

	public List<MailBox> findList(MailBox mailBox) {
		return super.findList(mailBox);
	}

	public Page<MailBox> findPage(MailPage<MailBox> page, MailBox mailBox) {
		return super.findPage(page, mailBox);
	}

	@Transactional(readOnly = false)
	public void save(MailBox mailBox) {
		super.save(mailBox);
	}

	@Transactional(readOnly = false)
	public void delete(MailBox mailBox) {
		super.delete(mailBox);
	}

	public int getCount(MailBox mailBox) {
		return mailBoxDao.getCount(mailBox);
	}

}