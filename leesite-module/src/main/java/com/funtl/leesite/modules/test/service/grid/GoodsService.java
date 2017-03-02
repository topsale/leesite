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

package com.funtl.leesite.modules.test.service.grid;

import java.util.List;

import com.funtl.leesite.common.persistence.Page;
import com.funtl.leesite.common.service.CrudService;
import com.funtl.leesite.modules.test.dao.grid.GoodsDao;
import com.funtl.leesite.modules.test.entity.grid.Category;
import com.funtl.leesite.modules.test.entity.grid.Goods;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

/**
 * 商品Service
 *
 * @author Lusifer
 * @version 2016-05-06
 */
@Service
@Transactional(readOnly = true)
public class GoodsService extends CrudService<GoodsDao, Goods> {

	public Goods get(String id) {
		return super.get(id);
	}

	public List<Goods> findList(Goods goods) {
		return super.findList(goods);
	}

	public Page<Goods> findPage(Page<Goods> page, Goods goods) {
		return super.findPage(page, goods);
	}

	@Transactional(readOnly = false)
	public void save(Goods goods) {
		super.save(goods);
	}

	@Transactional(readOnly = false)
	public void delete(Goods goods) {
		super.delete(goods);
	}

	public Page<Category> findPageBycategory(Page<Category> page, Category category) {
		category.setPage(page);
		page.setList(dao.findListBycategory(category));
		return page;
	}


}