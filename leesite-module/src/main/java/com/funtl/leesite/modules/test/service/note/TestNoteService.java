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

package com.funtl.leesite.modules.test.service.note;

import java.util.List;

import com.funtl.leesite.common.persistence.Page;
import com.funtl.leesite.common.service.CrudService;
import com.funtl.leesite.modules.test.dao.note.TestNoteDao;
import com.funtl.leesite.modules.test.entity.note.TestNote;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

/**
 * 富文本测试Service
 *
 * @author Lusifer
 * @version 2016-05-06
 */
@Service
@Transactional(readOnly = true)
public class TestNoteService extends CrudService<TestNoteDao, TestNote> {

	public TestNote get(String id) {
		return super.get(id);
	}

	public List<TestNote> findList(TestNote testNote) {
		return super.findList(testNote);
	}

	public Page<TestNote> findPage(Page<TestNote> page, TestNote testNote) {
		return super.findPage(page, testNote);
	}

	@Transactional(readOnly = false)
	public void save(TestNote testNote) {
		super.save(testNote);
	}

	@Transactional(readOnly = false)
	public void delete(TestNote testNote) {
		super.delete(testNote);
	}


}