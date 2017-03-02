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

package com.funtl.leesite.common.service;

import java.util.Collection;
import java.util.List;

import com.funtl.leesite.common.persistence.CrudDao;
import com.funtl.leesite.common.persistence.DataEntity;
import com.funtl.leesite.common.persistence.Page;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.transaction.annotation.Transactional;

/**
 * Service基类
 *
 * @author Lusifer
 * @version 2014-05-16
 */
@Transactional(readOnly = true)
public abstract class CrudService<D extends CrudDao<T>, T extends DataEntity<T>> extends BaseService {

	/**
	 * 持久层对象
	 */
	@Autowired
	protected D dao;

	/**
	 * 获取单条数据
	 *
	 * @param id
	 * @return
	 */
	public T get(String id) {
		return dao.get(id);
	}

	/**
	 * 获取单条数据
	 *
	 * @param entity
	 * @return
	 */
	public T get(T entity) {
		return dao.get(entity);
	}

	/**
	 * 查询列表数据
	 *
	 * @param entity
	 * @return
	 */
	public List<T> findList(T entity) {
		return dao.findList(entity);
	}

	/**
	 * 查询分页数据
	 *
	 * @param page   分页对象
	 * @param entity
	 * @return
	 */
	public Page<T> findPage(Page<T> page, T entity) {
		entity.setPage(page);
		page.setList(dao.findList(entity));
		return page;
	}

	/**
	 * 保存数据（插入或更新）
	 *
	 * @param entity
	 */
	@Transactional(readOnly = false)
	public void save(T entity) {
		if (entity.getIsNewRecord()) {
			entity.preInsert();
			dao.insert(entity);
		} else {
			entity.preUpdate();
			dao.update(entity);
		}
	}

	/**
	 * 删除数据
	 *
	 * @param entity
	 */
	@Transactional(readOnly = false)
	public void delete(T entity) {
		dao.delete(entity);
	}


	/**
	 * 删除全部数据
	 *
	 * @param entity
	 */
	@Transactional(readOnly = false)
	public void deleteAll(Collection<T> entitys) {
		for (T entity : entitys) {
			dao.delete(entity);
		}
	}


	/**
	 * 获取单条数据
	 *
	 * @param id
	 * @return
	 */
	public T findUniqueByProperty(String propertyName, Object value) {
		return dao.findUniqueByProperty(propertyName, value);
	}

}
