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

import java.util.List;

import com.funtl.leesite.common.persistence.CrudDao;
import com.funtl.leesite.common.persistence.annotation.MyBatisDao;
import com.funtl.leesite.modules.sys.entity.User;

import org.apache.ibatis.annotations.Param;

/**
 * 用户DAO接口
 *
 * @author Lusifer
 * @version 2014-05-16
 */
@MyBatisDao
public interface UserDao extends CrudDao<User> {

	/**
	 * 根据登录名称查询用户
	 *
	 * @param loginName
	 * @return
	 */
	public User getByLoginName(User user);

	/**
	 * 通过OfficeId获取用户列表，仅返回用户id和name（树查询用户时用）
	 *
	 * @param user
	 * @return
	 */
	public List<User> findUserByOfficeId(User user);

	/**
	 * 查询全部用户数目
	 *
	 * @return
	 */
	public long findAllCount(User user);

	/**
	 * 更新用户密码
	 *
	 * @param user
	 * @return
	 */
	public int updatePasswordById(User user);

	/**
	 * 更新登录信息，如：登录IP、登录时间
	 *
	 * @param user
	 * @return
	 */
	public int updateLoginInfo(User user);

	/**
	 * 删除用户角色关联数据
	 *
	 * @param user
	 * @return
	 */
	public int deleteUserRole(User user);

	/**
	 * 插入用户角色关联数据
	 *
	 * @param user
	 * @return
	 */
	public int insertUserRole(User user);

	/**
	 * 更新用户信息
	 *
	 * @param user
	 * @return
	 */
	public int updateUserInfo(User user);

	/**
	 * 插入好友
	 */
	public int insertFriend(@Param("id") String id, @Param("userId") String userId, @Param("friendId") String friendId);

	/**
	 * 查找好友
	 */
	public User findFriend(@Param("userId") String userId, @Param("friendId") String friendId);

	/**
	 * 删除好友
	 */
	public void deleteFriend(@Param("userId") String userId, @Param("friendId") String friendId);

	/**
	 * 获取我的好友列表
	 */
	public List<User> findFriends(User currentUser);

	/**
	 * 查询用户-->用来添加到常用联系人
	 */
	public List<User> searchUsers(User user);

	/**
	 *
	 */

	public List<User> findListByOffice(User user);


}
