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
import com.funtl.leesite.modules.iim.dao.MailComposeDao;
import com.funtl.leesite.modules.iim.entity.MailCompose;
import com.funtl.leesite.modules.iim.entity.MailPage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

/**
 * 发件箱Service
 *
 * @author Lusifer
 * @version 2015-11-13
 */
@Service
@Transactional(readOnly = true)
public class MailComposeService extends CrudService<MailComposeDao, MailCompose> {
	@Autowired
	private MailComposeDao mailComposeDao;

	public MailCompose get(String id) {
		return super.get(id);
	}

	public List<MailCompose> findList(MailCompose mailCompose) {
		return super.findList(mailCompose);
	}

	public Page<MailCompose> findPage(MailPage<MailCompose> page, MailCompose mailCompose) {
		return super.findPage(page, mailCompose);
	}

	@Transactional(readOnly = false)
	public void save(MailCompose mailCompose) {
		super.save(mailCompose);
	}

	@Transactional(readOnly = false)
	public void delete(MailCompose mailCompose) {
		super.delete(mailCompose);
	}

	public int getCount(MailCompose mailCompose) {
		return mailComposeDao.getCount(mailCompose);
	}

}