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

package com.funtl.leesite.modules.sys.dao;

import com.funtl.leesite.common.persistence.CrudDao;
import com.funtl.leesite.common.persistence.annotation.MyBatisDao;
import com.funtl.leesite.modules.sys.entity.Role;

/**
 * 角色DAO接口
 *
 * @author Lusifer
 * @version 2013-12-05
 */
@MyBatisDao
public interface RoleDao extends CrudDao<Role> {

	public Role getByName(Role role);

	public Role getByEnname(Role role);

	/**
	 * 维护角色与菜单权限关系
	 *
	 * @param role
	 * @return
	 */
	public int deleteRoleMenu(Role role);

	public int insertRoleMenu(Role role);

	/**
	 * 维护角色与公司部门关系
	 *
	 * @param role
	 * @return
	 */
	public int deleteRoleOffice(Role role);

	public int insertRoleOffice(Role role);

}
