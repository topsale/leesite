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

package com.funtl.leesite.common.tag;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.jsp.JspTagException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.TagSupport;

import com.beust.jcommander.internal.Lists;
import com.funtl.leesite.common.config.Global;
import com.funtl.leesite.common.utils.SpringContextHolder;
import com.funtl.leesite.common.utils.StringUtils;
import com.funtl.leesite.modules.sys.entity.Menu;
import com.funtl.leesite.modules.sys.utils.UserUtils;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;


/**
 * 类描述：菜单标签
 * <p>
 *
 * @version 1.0
 * @date： 日期：2015-1-23 时间：上午10:17:45
 */
public class MenuTag extends TagSupport {
	private static final Logger logger = LoggerFactory.getLogger(MenuTag.class);

	private static final long serialVersionUID = 1L;
	protected Menu menu;// 菜单Map
	protected String parentName; //上级菜单名称
	protected String currentName; //当前菜单名称
	ServletContext context = SpringContextHolder.getBean(ServletContext.class);

	public Menu getMenu() {
		return menu;
	}

	public void setMenu(Menu menu) {
		this.menu = menu;
	}

	public String getParentName() {
		return parentName;
	}

	public void setParentName(String parentName) {
		this.parentName = parentName;
	}

	public String getCurrentName() {
		return currentName;
	}

	public void setCurrentName(String currentName) {
		this.currentName = currentName;
	}

	public int doStartTag() throws JspTagException {
		return EVAL_PAGE;
	}

	public int doEndTag() throws JspTagException {
		try {
			JspWriter out = this.pageContext.getOut();
			String menu = (String) this.pageContext.getSession().getAttribute("menu");
			if (menu != null) {
				out.print(menu);
			} else {
				out.print(end());

			}

		} catch (IOException e) {
			e.printStackTrace();
		}
		return EVAL_PAGE;
	}

	public String end() {
		StringBuffer treeMenu = getTreeMenu();
		String menuHtml = treeMenu.toString();
		menuHtml = menuHtml.substring(menuHtml.indexOf(">") + 1, menuHtml.lastIndexOf("<"));

		logger.debug(menuHtml);
		return menuHtml;
	}


	private StringBuffer getTreeMenu() {
		Menu menu = generateTreeNode("1");
		String activeIdsStr = UserUtils.findActiveIdsByName(parentName, currentName);
		List<String> activeIds = Lists.newArrayList();
		if (StringUtils.isNotEmpty(activeIdsStr)) {
			activeIds = Arrays.asList(activeIdsStr.split(","));
		}
		return recursionMenu(menu, activeIds, new StringBuffer());
	}

	private StringBuffer recursionMenu(Menu menu, List<String> activeIds, StringBuffer sb) {
		List<Menu> menus = menu.getChildren();
		if (menus != null && !menus.isEmpty()) {
			sb.append("<ul class=\"sub-menu\">");
		}
		for (Menu item : menus) {
			String active = "";
			String open = "";
			String selected = "";
			if (activeIds.contains(item.getId())) {
				active = "active";
				open = "open";
				selected = "selected";
			}
			sb.append("<li class=\"nav-item  " + active + " " + open + "\">");
			String href = item.getHref();
			if (StringUtils.isEmpty(href)) {
				href = "javascript:;";
			} else {
				if (href.startsWith("http://")) {// 如果是互联网资源
					href = href;
				} else if (href.endsWith(".html") && !href.endsWith("ckfinder.html")) {//如果是静态资源并且不是ckfinder.html，直接访问不加adminPath
					href = context.getContextPath() + href;
				} else {
					href = context.getContextPath() + Global.getAdminPath() + href;
				}
			}

			String target = item.getTarget() == null ? "" : item.getTarget();
			sb.append("<a href=\"" + href + "\" target=\"" + target + "\" class=\"nav-link nav-toggle\">");
			sb.append("<i class=\"" + item.getIcon() + "\"></i>");
			sb.append("<span class=\"title\">" + item.getName() + "</span>");
			sb.append("<span class=\"" + selected + "\"></span>");
			if (item.getChildren() != null && !item.getChildren().isEmpty()) {
				sb.append("<span class=\"arrow " + open + "\"></span>");
			}
			sb.append("</a>");
			recursionMenu(item, activeIds, sb);
			sb.append("</li>");

		}

		if (menus != null && !menus.isEmpty()) {
			sb.append("</ul>");
		}
		return sb;
	}

	private static String getChildOfTree(Menu parent, int level, List<Menu> menuList) {

		StringBuffer menuString = new StringBuffer();
		String href = "";
		if (!parent.hasPermisson()) return "";
		if (level > 0) {//level 为0是功能菜单

			menuString.append("<li class=\"nav-item\">");

			ServletContext context = SpringContextHolder.getBean(ServletContext.class);
			if (parent.getHref() != null && parent.getHref().length() > 0) {


				if (parent.getHref().startsWith("http://")) {// 如果是互联网资源
					href = parent.getHref();
				} else if (parent.getHref().endsWith(".html") && !parent.getHref().endsWith("ckfinder.html")) {//如果是静态资源并且不是ckfinder.html，直接访问不加adminPath
					href = context.getContextPath() + parent.getHref();
				} else {
					href = context.getContextPath() + Global.getAdminPath() + parent.getHref();
				}
			}
		}

		if ((parent.getHref() == null || parent.getHref().trim().equals("")) && parent.getIsShow().equals("1")) {//如果是父节点且显示
			if (level > 0) {
				menuString.append("<a href=\"" + href + "\" class=\"nav-link nav-toggle\"><i class=\"" + parent.getIcon() + "\"></i><span class=\"title\">" + parent.getName() + "</span><span class=\"arrow\"></span></a>");
			}
			if (level == 1) {
				menuString.append("<ul class=\"sub-menu\"><li class=\"nav-item\">");
			} else if (level == 2) {
				menuString.append("<ul class=\"sub-menu\"><li class=\"nav-item\">");
			} else if (level == 3) {
				menuString.append("<ul class=\"sub-menu\"><li class=\"nav-item\">");
			} else if (level == 4) {
				menuString.append("<ul class=\"sub-menu\"><li class=\"nav-item\">");
			}
			for (Menu child : menuList) {
				if (child.getParentId().equals(parent.getId()) && child.getIsShow().equals("1")) {
					menuString.append(getChildOfTree(child, level + 1, menuList));
				}
			}
			if (level > 0) {
				menuString.append("</ul>");
			}
		} else {
			menuString.append("<a href=\"" + href + "\" target=\"" + parent.getTarget() + "\" class=\"nav-link\"><i class=\"" + parent.getIcon() + "\"></i><span class=\"title\">" + parent.getName() + "</span></a>");
		}
		if (level > 0) {
			menuString.append("</li>");
		}

		return menuString.toString();
	}

	/**
	 * @param nodeId
	 * @return
	 */
	public Menu getNodeById(String nodeId) {
		List<Menu> menuList = UserUtils.getMenuList();
		Menu menu = new Menu();
		for (Menu item : menuList) {
			if (nodeId.equals(item.getId()) && "1".equals(item.getIsShow())) {
				menu = item;
				break;
			}
		}
		return menu;
	}

	/**
	 * @param nodeId
	 * @return
	 */
	public List<Menu> getChildrenNodeById(String nodeId) {
		List<Menu> childrenMenus = new ArrayList<Menu>();
		List<Menu> menuList = UserUtils.getMenuList();
		for (Menu item : menuList) {
			if (nodeId.equals(item.getParentId()) && "1".equals(item.getIsShow())) {
				childrenMenus.add(item);
			}
		}
		return childrenMenus;
	}

	/**
	 * 递归生成Tree结构数据
	 *
	 * @param rootId
	 * @return
	 */
	public Menu generateTreeNode(String rootId) {
		Menu root = this.getNodeById(rootId);
		List<Menu> childrenTreeNode = this.getChildrenNodeById(rootId);
		root.getChildren().clear();
		root.getChildren().addAll(childrenTreeNode);
		for (Menu item : childrenTreeNode) {
			this.generateTreeNode(item.getId());
		}
		return root;
	}

}
