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

package com.funtl.leesite.modules.sys.utils;

import com.funtl.leesite.common.persistence.Page;
import com.funtl.leesite.common.service.BaseService;
import com.funtl.leesite.common.utils.CacheUtils;
import com.funtl.leesite.common.utils.SpringContextHolder;
import com.funtl.leesite.modules.iim.entity.MailBox;
import com.funtl.leesite.modules.iim.entity.MailPage;
import com.funtl.leesite.modules.iim.service.MailBoxService;
import com.funtl.leesite.modules.oa.entity.OaNotify;
import com.funtl.leesite.modules.oa.service.OaNotifyService;
import com.funtl.leesite.modules.sys.dao.*;
import com.funtl.leesite.modules.sys.entity.*;
import com.funtl.leesite.modules.sys.security.SystemAuthorizingRealm.Principal;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.UnavailableSecurityManagerException;
import org.apache.shiro.session.InvalidSessionException;
import org.apache.shiro.session.Session;
import org.apache.shiro.subject.Subject;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Date;
import java.util.List;

/**
 * 用户工具类
 *
 * @author Lusifer
 * @version 2013-12-05
 */
public class UserUtils {

	private static UserDao userDao = SpringContextHolder.getBean(UserDao.class);
	private static RoleDao roleDao = SpringContextHolder.getBean(RoleDao.class);
	private static MenuDao menuDao = SpringContextHolder.getBean(MenuDao.class);
	private static AreaDao areaDao = SpringContextHolder.getBean(AreaDao.class);
	private static OfficeDao officeDao = SpringContextHolder.getBean(OfficeDao.class);

	public static final String USER_CACHE = "userCache";
	public static final String USER_CACHE_ID_ = "id_";
	public static final String USER_CACHE_LOGIN_NAME_ = "ln";
	public static final String USER_CACHE_LIST_BY_OFFICE_ID_ = "oid_";

	public static final String CACHE_ROLE_LIST = "roleList";
	public static final String CACHE_MENU_LIST = "menuList";
	public static final String CACHE_AREA_LIST = "areaList";
	public static final String CACHE_OFFICE_LIST = "officeList";
	public static final String CACHE_OFFICE_ALL_LIST = "officeAllList";

	/**
	 * 根据ID获取用户
	 *
	 * @param id
	 * @return 取不到返回null
	 */
	public static User get(String id) {
		User user = (User) CacheUtils.get(USER_CACHE, USER_CACHE_ID_ + id);
		if (user == null) {
			user = userDao.get(id);
			if (user == null) {
				return null;
			}
			user.setRoleList(roleDao.findList(new Role(user)));
			CacheUtils.put(USER_CACHE, USER_CACHE_ID_ + user.getId(), user);
			CacheUtils.put(USER_CACHE, USER_CACHE_LOGIN_NAME_ + user.getLoginName(), user);
		}
		return user;
	}

	/**
	 * 根据登录名获取用户
	 *
	 * @param loginName
	 * @return 取不到返回null
	 */
	public static User getByLoginName(String loginName) {
		User user = (User) CacheUtils.get(USER_CACHE, USER_CACHE_LOGIN_NAME_ + loginName);
		if (user == null) {
			user = userDao.getByLoginName(new User(null, loginName));
			if (user == null) {
				return null;
			}
			user.setRoleList(roleDao.findList(new Role(user)));
			CacheUtils.put(USER_CACHE, USER_CACHE_ID_ + user.getId(), user);
			CacheUtils.put(USER_CACHE, USER_CACHE_LOGIN_NAME_ + user.getLoginName(), user);
		}
		return user;
	}

	/**
	 * 清除当前用户缓存
	 */
	public static void clearCache() {
		removeCache(CACHE_ROLE_LIST);
		removeCache(CACHE_MENU_LIST);
		removeCache(CACHE_AREA_LIST);
		removeCache(CACHE_OFFICE_LIST);
		removeCache(CACHE_OFFICE_ALL_LIST);
		UserUtils.clearCache(getUser());
	}

	/**
	 * 清除指定用户缓存
	 *
	 * @param user
	 */
	public static void clearCache(User user) {
		CacheUtils.remove(USER_CACHE, USER_CACHE_ID_ + user.getId());
		CacheUtils.remove(USER_CACHE, USER_CACHE_LOGIN_NAME_ + user.getLoginName());
		CacheUtils.remove(USER_CACHE, USER_CACHE_LOGIN_NAME_ + user.getOldLoginName());
		if (user.getOffice() != null && user.getOffice().getId() != null) {
			CacheUtils.remove(USER_CACHE, USER_CACHE_LIST_BY_OFFICE_ID_ + user.getOffice().getId());
		}
	}

	/**
	 * 获取当前用户
	 *
	 * @return 取不到返回 new User()
	 */
	public static User getUser() {
		Principal principal = getPrincipal();
		if (principal != null) {
			User user = get(principal.getId());
			if (user != null) {
				return user;
			}
			return new User();
		}
		// 如果没有登录，则返回实例化空的User对象。
		return new User();
	}

	/**
	 * 获取当前用户角色列表
	 *
	 * @return
	 */
	public static List<Role> getRoleList() {
		@SuppressWarnings("unchecked") List<Role> roleList = (List<Role>) getCache(CACHE_ROLE_LIST);
		if (roleList == null) {
			User user = getUser();
			if (user.isAdmin()) {
				roleList = roleDao.findAllList(new Role());
			} else {
				Role role = new Role();
				role.getSqlMap().put("dsf", BaseService.dataScopeFilter(user.getCurrentUser(), "o", "u"));
				roleList = roleDao.findList(role);
			}
			putCache(CACHE_ROLE_LIST, roleList);
		}
		return roleList;
	}

	/**
	 * 获取当前用户授权菜单
	 *
	 * @return
	 */
	public static List<Menu> getMenuList() {
		@SuppressWarnings("unchecked") List<Menu> menuList = (List<Menu>) getCache(CACHE_MENU_LIST);
		if (menuList == null) {
			User user = getUser();
			if (user.isAdmin()) {
				menuList = menuDao.findAllList(new Menu());
			} else {
				Menu m = new Menu();
				m.setUserId(user.getId());
				menuList = menuDao.findByUserId(m);
			}
			putCache(CACHE_MENU_LIST, menuList);
		}
		return menuList;
	}

	/**
	 * 获取当前用户授权菜单
	 *
	 * @return
	 */
	public static Menu getTopMenu() {
		Menu topMenu = getMenuList().get(0);
		return topMenu;
	}

	/**
	 * 获取当前用户授权的区域
	 *
	 * @return
	 */
	public static List<Area> getAreaList() {
		@SuppressWarnings("unchecked") List<Area> areaList = (List<Area>) getCache(CACHE_AREA_LIST);
		if (areaList == null) {
			areaList = areaDao.findAllList(new Area());
			putCache(CACHE_AREA_LIST, areaList);
		}
		return areaList;
	}

	/**
	 * 获取当前用户有权限访问的部门
	 *
	 * @return
	 */
	public static List<Office> getOfficeList() {
		@SuppressWarnings("unchecked") List<Office> officeList = (List<Office>) getCache(CACHE_OFFICE_LIST);
		if (officeList == null) {
			User user = getUser();
			if (user.isAdmin()) {
				officeList = officeDao.findAllList(new Office());
			} else {
				Office office = new Office();
				office.getSqlMap().put("dsf", BaseService.dataScopeFilter(user, "a", ""));
				officeList = officeDao.findList(office);
			}
			putCache(CACHE_OFFICE_LIST, officeList);
		}
		return officeList;
	}

	/**
	 * 获取当前用户有权限访问的部门
	 *
	 * @return
	 */
	public static List<Office> getOfficeAllList() {
		@SuppressWarnings("unchecked") List<Office> officeList = (List<Office>) getCache(CACHE_OFFICE_ALL_LIST);
		if (officeList == null) {
			officeList = officeDao.findAllList(new Office());
		}
		return officeList;
	}

	/**
	 * 获取授权主要对象
	 */
	public static Subject getSubject() {
		return SecurityUtils.getSubject();
	}

	/**
	 * 获取当前登录者对象
	 */
	public static Principal getPrincipal() {
		try {
			Subject subject = SecurityUtils.getSubject();
			Principal principal = (Principal) subject.getPrincipal();
			if (principal != null) {
				return principal;
			}
			//			subject.logout();
		} catch (UnavailableSecurityManagerException e) {

		} catch (InvalidSessionException e) {

		}
		return null;
	}

	public static Session getSession() {
		try {
			Subject subject = SecurityUtils.getSubject();
			Session session = subject.getSession(false);
			if (session == null) {
				session = subject.getSession();
			}
			if (session != null) {
				return session;
			}
			//			subject.logout();
		} catch (InvalidSessionException e) {

		}
		return null;
	}

	// ============== User Cache ==============

	public static Object getCache(String key) {
		return getCache(key, null);
	}

	public static Object getCache(String key, Object defaultValue) {
		//		Object obj = getCacheMap().get(key);
		Object obj = getSession().getAttribute(key);
		return obj == null ? defaultValue : obj;
	}

	public static void putCache(String key, Object value) {
		//		getCacheMap().put(key, value);
		getSession().setAttribute(key, value);
	}

	public static void removeCache(String key) {
		//		getCacheMap().remove(key);
		getSession().removeAttribute(key);
	}

	public static String getTime(Date date) {
		StringBuffer time = new StringBuffer();
		Date date2 = new Date();
		long temp = date2.getTime() - date.getTime();
		long days = temp / 1000 / 3600 / 24;                //相差小时数
		if (days > 0) {
			time.append(days + "天");
		}
		long temp1 = temp % (1000 * 3600 * 24);
		long hours = temp1 / 1000 / 3600;                //相差小时数
		if (days > 0 || hours > 0) {
			time.append(hours + "小时");
		}
		long temp2 = temp1 % (1000 * 3600);
		long mins = temp2 / 1000 / 60;                    //相差分钟数
		time.append(mins + "分钟");
		return time.toString();
	}

	/**
	 * 导出Excel调用,根据姓名转换为ID
	 */
	public static User getByUserName(String name) {
		User u = new User();
		u.setName(name);
		List<User> list = userDao.findList(u);
		if (list.size() > 0) {
			return list.get(0);
		} else {
			return new User();
		}
	}

	/**
	 * 导出Excel使用，根据名字转换为id
	 */
	public static Office getByOfficeName(String name) {
		Office o = new Office();
		o.setName(name);
		List<Office> list = officeDao.findList(o);
		if (list.size() > 0) {
			return list.get(0);
		} else {
			return new Office();
		}
	}

	/**
	 * 导出Excel使用，根据名字转换为id
	 */
	public static Area getByAreaName(String name) {
		Area a = new Area();
		a.setName(name);
		List<Area> list = areaDao.findList(a);
		if (list.size() > 0) {
			return list.get(0);
		} else {
			return new Area();
		}
	}

	/**
	 * 未读通知笔数
	 * @return
	 */
	public static long noReadNotifyCount() {
		OaNotifyService oaNotifyService = SpringContextHolder.getBean(OaNotifyService.class);
		OaNotify oaNotify = new OaNotify();
		oaNotify.setSelf(true);
		oaNotify.setReadFlag("0");
		return oaNotifyService.findCount(oaNotify);
	}

	/**
	 * 未读通知列表
	 * @param request
	 * @param response
	 * @return
	 */
	public static List<OaNotify> noReadNotifyList(HttpServletRequest request, HttpServletResponse response) {
		OaNotifyService oaNotifyService = SpringContextHolder.getBean(OaNotifyService.class);
		OaNotify oaNotify = new OaNotify();
		oaNotify.setSelf(true);
		oaNotify.setReadFlag("0");
		Page<OaNotify> page = oaNotifyService.find(new Page<OaNotify>(request, response), oaNotify);
		return page.getList();
	}

	/**
	 * 未读邮件笔数
	 * @return
	 */
	public static int noReadMailCount() {
		MailBoxService mailBoxService = SpringContextHolder.getBean(MailBoxService.class);
		MailBox mailBox = new MailBox();
		mailBox.setReceiver(UserUtils.getUser());
		mailBox.setReadstatus("0");//筛选未读
		return mailBoxService.getCount(mailBox);
	}

	/**
	 * 未读邮件列表
	 * @param request
	 * @param response
	 * @return
	 */
	public static List<MailBox> noReadMailList(HttpServletRequest request, HttpServletResponse response) {
		MailBoxService mailBoxService = SpringContextHolder.getBean(MailBoxService.class);
		MailBox mailBox = new MailBox();
		mailBox.setReceiver(UserUtils.getUser());
		mailBox.setReadstatus("0");//筛选未读
		Page<MailBox> page = mailBoxService.findPage(new MailPage<MailBox>(request, response), mailBox);
		return page.getList();
	}


	public static String findActiveIdsByName(String parentName,String currentName) {
		List<Menu> menus = menuDao.findParentIdsByName(currentName);
		if(menus == null || menus.isEmpty()){
			return null;
		}
		//菜单名称有重复，需要去根据父级菜单来判断
		if(menus.size() > 1){
			for(Menu menu : menus){
				Menu parentMenu = menuDao.get(menu.getParentId());
				if(parentName.equals(parentMenu.getName())){
					return menu.getParentIds() + menu.getId();
				}
			}
		}else{
			Menu menu = menus.get(0);
			return menu.getParentIds()+menu.getId();
		}

		return null;
	}


}
