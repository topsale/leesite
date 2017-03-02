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
import com.funtl.leesite.modules.iim.dao.MyCalendarDao;
import com.funtl.leesite.modules.iim.entity.MyCalendar;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;


/**
 * 日历Service
 *
 * @author Lusifer
 * @version 2016-04-19
 */
@Service
@Transactional(readOnly = true)
public class MyCalendarService extends CrudService<MyCalendarDao, MyCalendar> {

	public MyCalendar get(String id) {
		return super.get(id);
	}

	public List<MyCalendar> findList(MyCalendar myCalendar) {
		return super.findList(myCalendar);
	}

	public Page<MyCalendar> findPage(Page<MyCalendar> page, MyCalendar myCalendar) {
		return super.findPage(page, myCalendar);
	}

	@Transactional(readOnly = false)
	public void save(MyCalendar myCalendar) {
		super.save(myCalendar);
	}

	@Transactional(readOnly = false)
	public void delete(MyCalendar myCalendar) {
		super.delete(myCalendar);
	}

}