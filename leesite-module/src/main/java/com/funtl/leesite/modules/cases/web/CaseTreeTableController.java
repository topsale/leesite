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
package com.funtl.leesite.modules.cases.web;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.shiro.authz.annotation.Logical;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.google.common.collect.Lists;
import com.google.common.collect.Maps;
import com.funtl.leesite.common.utils.MyBeanUtils;
import com.funtl.leesite.common.config.Global;
import com.funtl.leesite.common.web.BaseController;
import com.funtl.leesite.common.utils.StringUtils;
import com.funtl.leesite.modules.cases.entity.CaseTreeTable;
import com.funtl.leesite.modules.cases.service.CaseTreeTableService;

/**
 * 生成示例Controller
 * @author Lusifer
 * @version 2017-05-05
 */
@Controller
@RequestMapping(value = "${adminPath}/cases/caseTreeTable")
public class CaseTreeTableController extends BaseController {

	@Autowired
	private CaseTreeTableService caseTreeTableService;
	
	@ModelAttribute
	public CaseTreeTable get(@RequestParam(required=false) String id) {
		CaseTreeTable entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = caseTreeTableService.get(id);
		}
		if (entity == null){
			entity = new CaseTreeTable();
		}
		return entity;
	}
	
	/**
	 * 树结构列表页面
	 */
	@RequiresPermissions("cases:caseTreeTable:list")
	@RequestMapping(value = {"list", ""})
	public String list(CaseTreeTable caseTreeTable, HttpServletRequest request, HttpServletResponse response, Model model) {
		List<CaseTreeTable> list = caseTreeTableService.findList(caseTreeTable); 
		model.addAttribute("list", list);
		return "modules/cases/caseTreeTableList";
	}

	/**
	 * 查看，增加，编辑树结构表单页面
	 */
	@RequiresPermissions(value={"cases:caseTreeTable:view","cases:caseTreeTable:add","cases:caseTreeTable:edit"},logical=Logical.OR)
	@RequestMapping(value = "form")
	public String form(CaseTreeTable caseTreeTable, Model model) {
		if (caseTreeTable.getParent()!=null && StringUtils.isNotBlank(caseTreeTable.getParent().getId())){
			caseTreeTable.setParent(caseTreeTableService.get(caseTreeTable.getParent().getId()));
			// 获取排序号，最末节点排序号+30
			if (StringUtils.isBlank(caseTreeTable.getId())){
				CaseTreeTable caseTreeTableChild = new CaseTreeTable();
				caseTreeTableChild.setParent(new CaseTreeTable(caseTreeTable.getParent().getId()));
				List<CaseTreeTable> list = caseTreeTableService.findList(caseTreeTable); 
				if (list.size() > 0){
					caseTreeTable.setSort(list.get(list.size()-1).getSort());
					if (caseTreeTable.getSort() != null){
						caseTreeTable.setSort(caseTreeTable.getSort() + 30);
					}
				}
			}
		}
		if (caseTreeTable.getSort() == null){
			caseTreeTable.setSort(30);
		}
		model.addAttribute("caseTreeTable", caseTreeTable);
		return "modules/cases/caseTreeTableForm";
	}

	/**
	 * 保存树结构
	 */
	@RequiresPermissions(value={"cases:caseTreeTable:add","cases:caseTreeTable:edit"},logical=Logical.OR)
	@RequestMapping(value = "save")
	public String save(CaseTreeTable caseTreeTable, Model model, RedirectAttributes redirectAttributes) throws Exception{
		if (!beanValidator(model, caseTreeTable)){
			return form(caseTreeTable, model);
		}
		if(!caseTreeTable.getIsNewRecord()){//编辑表单保存
			CaseTreeTable t = caseTreeTableService.get(caseTreeTable.getId());//从数据库取出记录的值
			MyBeanUtils.copyBeanNotNull2Bean(caseTreeTable, t);//将编辑表单中的非NULL值覆盖数据库记录中的值
			caseTreeTableService.save(t);//保存
		}else{//新增表单保存
			caseTreeTableService.save(caseTreeTable);//保存
		}
		addMessage(redirectAttributes, "保存树结构成功");
		return "redirect:"+Global.getAdminPath()+"/cases/caseTreeTable";
	}
	
	/**
	 * 删除树结构
	 */
	@RequiresPermissions("cases:caseTreeTable:del")
	@RequestMapping(value = "delete")
	public String delete(CaseTreeTable caseTreeTable, RedirectAttributes redirectAttributes) {
		caseTreeTableService.delete(caseTreeTable);
		addMessage(redirectAttributes, "删除树结构成功");
		return "redirect:"+Global.getAdminPath()+"/cases/caseTreeTable";
	}

	@RequiresPermissions("user")
	@ResponseBody
	@RequestMapping(value = "treeData")
	public List<Map<String, Object>> treeData(@RequestParam(required=false) String extId, HttpServletResponse response) {
		List<Map<String, Object>> mapList = Lists.newArrayList();
		List<CaseTreeTable> list = caseTreeTableService.findList(new CaseTreeTable());
		for (int i=0; i<list.size(); i++){
			CaseTreeTable e = list.get(i);
			if (StringUtils.isBlank(extId) || (extId!=null && !extId.equals(e.getId()) && e.getParentIds().indexOf(","+extId+",")==-1)){
				Map<String, Object> map = Maps.newHashMap();
				map.put("id", e.getId());
				map.put("pId", e.getParentId());
				map.put("name", e.getName());
				mapList.add(map);
			}
		}
		return mapList;
	}
	
}