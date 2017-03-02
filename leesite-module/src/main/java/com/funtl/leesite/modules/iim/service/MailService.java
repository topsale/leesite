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
import com.funtl.leesite.common.utils.StringUtils;
import com.funtl.leesite.modules.iim.dao.MailBoxDao;
import com.funtl.leesite.modules.iim.dao.MailComposeDao;
import com.funtl.leesite.modules.iim.dao.MailDao;
import com.funtl.leesite.modules.iim.entity.Mail;
import com.funtl.leesite.modules.iim.entity.MailBox;
import com.funtl.leesite.modules.iim.entity.MailCompose;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

/**
 * 发件箱Service
 *
 * @author Lusifer
 * @version 2015-11-15
 */
@Service
@Transactional(readOnly = true)
public class MailService extends CrudService<MailDao, Mail> {

	@Autowired
	private MailBoxDao mailBoxDao;
	@Autowired
	private MailComposeDao mailComposeDao;

	public Mail get(String id) {
		Mail mail = super.get(id);
		mail.setMailBoxList(mailBoxDao.findList(new MailBox(mail)));
		mail.setMailComposeList(mailComposeDao.findList(new MailCompose(mail)));
		return mail;
	}

	public List<Mail> findList(Mail mail) {
		return super.findList(mail);
	}

	public Page<Mail> findPage(Page<Mail> page, Mail mail) {
		return super.findPage(page, mail);
	}

	@Transactional(readOnly = false)
	public void save(Mail mail) {
		super.save(mail);
		for (MailBox mailBox : mail.getMailBoxList()) {
			if (mailBox.getId() == null) {
				continue;
			}
			if (MailBox.DEL_FLAG_NORMAL.equals(mailBox.getDelFlag())) {
				if (StringUtils.isBlank(mailBox.getId())) {
					mailBox.setMail(mail);
					mailBox.preInsert();
					mailBoxDao.insert(mailBox);
				} else {
					mailBox.preUpdate();
					mailBoxDao.update(mailBox);
				}
			} else {
				mailBoxDao.delete(mailBox);
			}
		}
		for (MailCompose mailCompose : mail.getMailComposeList()) {
			if (mailCompose.getId() == null) {
				continue;
			}
			if (MailCompose.DEL_FLAG_NORMAL.equals(mailCompose.getDelFlag())) {
				if (StringUtils.isBlank(mailCompose.getId())) {
					mailCompose.setMail(mail);
					mailCompose.preInsert();
					mailComposeDao.insert(mailCompose);
				} else {
					mailCompose.preUpdate();
					mailComposeDao.update(mailCompose);
				}
			} else {
				mailComposeDao.delete(mailCompose);
			}
		}
	}

	@Transactional(readOnly = false)
	public void saveOnlyMain(Mail mail) {
		super.save(mail);
		for (MailBox mailBox : mail.getMailBoxList()) {
			if (mailBox.getId() == null) {
				continue;
			}
			if (MailBox.DEL_FLAG_NORMAL.equals(mailBox.getDelFlag())) {
				if (StringUtils.isBlank(mailBox.getId())) {
					mailBox.setMail(mail);
					mailBox.preInsert();
					mailBoxDao.insert(mailBox);
				} else {
					mailBox.preUpdate();
					mailBoxDao.update(mailBox);
				}
			} else {
				mailBoxDao.delete(mailBox);
			}
		}
		for (MailCompose mailCompose : mail.getMailComposeList()) {
			if (mailCompose.getId() == null) {
				continue;
			}
			if (MailCompose.DEL_FLAG_NORMAL.equals(mailCompose.getDelFlag())) {
				if (StringUtils.isBlank(mailCompose.getId())) {
					mailCompose.setMail(mail);
					mailCompose.preInsert();
					mailComposeDao.insert(mailCompose);
				} else {
					mailCompose.preUpdate();
					mailComposeDao.update(mailCompose);
				}
			} else {
				mailComposeDao.delete(mailCompose);
			}
		}
	}

	@Transactional(readOnly = false)
	public void delete(Mail mail) {
		super.delete(mail);
		mailBoxDao.delete(new MailBox(mail));
		mailComposeDao.delete(new MailCompose(mail));
	}

}