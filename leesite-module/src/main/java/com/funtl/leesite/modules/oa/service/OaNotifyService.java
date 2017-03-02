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

package com.funtl.leesite.modules.oa.service;

import java.util.Date;

import com.funtl.leesite.common.persistence.Page;
import com.funtl.leesite.common.service.CrudService;
import com.funtl.leesite.modules.oa.dao.OaNotifyDao;
import com.funtl.leesite.modules.oa.dao.OaNotifyRecordDao;
import com.funtl.leesite.modules.oa.entity.OaNotify;
import com.funtl.leesite.modules.oa.entity.OaNotifyRecord;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

/**
 * 通知通告Service
 *
 * @author Lusifer
 * @version 2014-05-16
 */
@Service
@Transactional(readOnly = true)
public class OaNotifyService extends CrudService<OaNotifyDao, OaNotify> {

	@Autowired
	private OaNotifyRecordDao oaNotifyRecordDao;

	public OaNotify get(String id) {
		OaNotify entity = dao.get(id);
		return entity;
	}

	/**
	 * 获取通知发送记录
	 *
	 * @param oaNotify
	 * @return
	 */
	public OaNotify getRecordList(OaNotify oaNotify) {
		oaNotify.setOaNotifyRecordList(oaNotifyRecordDao.findList(new OaNotifyRecord(oaNotify)));
		return oaNotify;
	}

	public Page<OaNotify> find(Page<OaNotify> page, OaNotify oaNotify) {
		oaNotify.setPage(page);
		page.setList(dao.findList(oaNotify));
		return page;
	}

	/**
	 * 获取通知数目
	 *
	 * @param oaNotify
	 * @return
	 */
	public Long findCount(OaNotify oaNotify) {
		return dao.findCount(oaNotify);
	}

	@Transactional(readOnly = false)
	public void save(OaNotify oaNotify) {
		super.save(oaNotify);

		// 更新发送接受人记录
		oaNotifyRecordDao.deleteByOaNotifyId(oaNotify.getId());
		if (oaNotify.getOaNotifyRecordList().size() > 0) {
			oaNotifyRecordDao.insertAll(oaNotify.getOaNotifyRecordList());
		}
	}

	/**
	 * 更新阅读状态
	 */
	@Transactional(readOnly = false)
	public void updateReadFlag(OaNotify oaNotify) {
		OaNotifyRecord oaNotifyRecord = new OaNotifyRecord(oaNotify);
		oaNotifyRecord.setUser(oaNotifyRecord.getCurrentUser());
		oaNotifyRecord.setReadDate(new Date());
		oaNotifyRecord.setReadFlag("1");
		oaNotifyRecordDao.update(oaNotifyRecord);
	}
}