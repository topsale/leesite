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

package com.funtl.leesite.modules.test.service.tree;

import java.util.List;

import com.funtl.leesite.common.service.TreeService;
import com.funtl.leesite.common.utils.StringUtils;
import com.funtl.leesite.modules.test.dao.tree.TestTreeDao;
import com.funtl.leesite.modules.test.entity.tree.TestTree;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

/**
 * 组织机构Service
 *
 * @author Lusifer
 * @version 2016-05-06
 */
@Service
@Transactional(readOnly = true)
public class TestTreeService extends TreeService<TestTreeDao, TestTree> {

	public TestTree get(String id) {
		return super.get(id);
	}

	public List<TestTree> findList(TestTree testTree) {
		if (StringUtils.isNotBlank(testTree.getParentIds())) {
			testTree.setParentIds("," + testTree.getParentIds() + ",");
		}
		return super.findList(testTree);
	}

	@Transactional(readOnly = false)
	public void save(TestTree testTree) {
		super.save(testTree);
	}

	@Transactional(readOnly = false)
	public void delete(TestTree testTree) {
		super.delete(testTree);
	}

}