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

package com.funtl.leesite.common.persistence;

import java.util.List;

/**
 * DAO支持类实现
 *
 * @param <T>
 * @author Lusifer
 * @version 2014-05-16
 */
public interface TreeDao<T extends TreeEntity<T>> extends CrudDao<T> {

	/**
	 * 找到所有子节点
	 *
	 * @param entity
	 * @return
	 */
	public List<T> findByParentIdsLike(T entity);

	/**
	 * 更新所有父节点字段
	 *
	 * @param entity
	 * @return
	 */
	public int updateParentIds(T entity);

}