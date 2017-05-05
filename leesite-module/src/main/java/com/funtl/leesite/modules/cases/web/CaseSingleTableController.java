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

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.validation.ConstraintViolationException;

import org.apache.shiro.authz.annotation.Logical;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.google.common.collect.Lists;
import com.funtl.leesite.common.utils.DateUtils;
import com.funtl.leesite.common.utils.MyBeanUtils;
import com.funtl.leesite.common.config.Global;
import com.funtl.leesite.common.persistence.Page;
import com.funtl.leesite.common.web.BaseController;
import com.funtl.leesite.common.utils.StringUtils;
import com.funtl.leesite.common.utils.excel.ExportExcel;
import com.funtl.leesite.common.utils.excel.ImportExcel;
import com.funtl.leesite.modules.cases.entity.CaseSingleTable;
import com.funtl.leesite.modules.cases.service.CaseSingleTableService;

/**
 * 生成示例Controller
 * @author Lusifer
 * @version 2017-05-05
 */
@Controller
@RequestMapping(value = "${adminPath}/cases/caseSingleTable")
public class CaseSingleTableController extends BaseController {

	@Autowired
	private CaseSingleTableService caseSingleTableService;
	
	@ModelAttribute
	public CaseSingleTable get(@RequestParam(required=false) String id) {
		CaseSingleTable entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = caseSingleTableService.get(id);
		}
		if (entity == null){
			entity = new CaseSingleTable();
		}
		return entity;
	}
	
	/**
	 * 单表列表页面
	 */
	@RequiresPermissions("cases:caseSingleTable:list")
	@RequestMapping(value = {"list", ""})
	public String list(CaseSingleTable caseSingleTable, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<CaseSingleTable> page = caseSingleTableService.findPage(new Page<CaseSingleTable>(request, response), caseSingleTable); 
		model.addAttribute("page", page);
		return "modules/cases/caseSingleTableList";
	}

	/**
	 * 查看，增加，编辑单表表单页面
	 */
	@RequiresPermissions(value={"cases:caseSingleTable:view","cases:caseSingleTable:add","cases:caseSingleTable:edit"},logical=Logical.OR)
	@RequestMapping(value = "form")
	public String form(CaseSingleTable caseSingleTable, Model model) {
		model.addAttribute("caseSingleTable", caseSingleTable);
		return "modules/cases/caseSingleTableForm";
	}

	/**
	 * 保存单表
	 */
	@RequiresPermissions(value={"cases:caseSingleTable:add","cases:caseSingleTable:edit"},logical=Logical.OR)
	@RequestMapping(value = "save")
	public String save(CaseSingleTable caseSingleTable, Model model, RedirectAttributes redirectAttributes) throws Exception{
		if (!beanValidator(model, caseSingleTable)){
			return form(caseSingleTable, model);
		}
		if(!caseSingleTable.getIsNewRecord()){//编辑表单保存
			CaseSingleTable t = caseSingleTableService.get(caseSingleTable.getId());//从数据库取出记录的值
			MyBeanUtils.copyBeanNotNull2Bean(caseSingleTable, t);//将编辑表单中的非NULL值覆盖数据库记录中的值
			caseSingleTableService.save(t);//保存
		}else{//新增表单保存
			caseSingleTableService.save(caseSingleTable);//保存
		}
		addMessage(redirectAttributes, "保存单表成功");
		return "redirect:"+Global.getAdminPath()+"/cases/caseSingleTable";
	}
	
	/**
	 * 删除单表
	 */
	@RequiresPermissions("cases:caseSingleTable:del")
	@RequestMapping(value = "delete")
	public String delete(CaseSingleTable caseSingleTable, RedirectAttributes redirectAttributes) {
		caseSingleTableService.delete(caseSingleTable);
		addMessage(redirectAttributes, "删除单表成功");
		return "redirect:"+Global.getAdminPath()+"/cases/caseSingleTable";
	}
	
	/**
	 * 批量删除单表
	 */
	@RequiresPermissions("cases:caseSingleTable:del")
	@RequestMapping(value = "deleteAll")
	public String deleteAll(String ids, RedirectAttributes redirectAttributes) {
		String idArray[] =ids.split(",");
		for(String id : idArray){
			caseSingleTableService.delete(caseSingleTableService.get(id));
		}
		addMessage(redirectAttributes, "删除单表成功");
		return "redirect:"+Global.getAdminPath()+"/cases/caseSingleTable";
	}
	
	/**
	 * 导出excel文件
	 */
	@RequiresPermissions("cases:caseSingleTable:export")
    @RequestMapping(value = "export", method=RequestMethod.POST)
    public String exportFile(CaseSingleTable caseSingleTable, HttpServletRequest request, HttpServletResponse response, RedirectAttributes redirectAttributes) {
		try {
            String fileName = "单表"+DateUtils.getDate("yyyyMMddHHmmss")+".xlsx";
            Page<CaseSingleTable> page = caseSingleTableService.findPage(new Page<CaseSingleTable>(request, response, -1), caseSingleTable);
    		new ExportExcel("单表", CaseSingleTable.class).setDataList(page.getList()).write(response, fileName).dispose();
    		return null;
		} catch (Exception e) {
			addMessage(redirectAttributes, "导出单表记录失败！失败信息："+e.getMessage());
		}
		return "redirect:"+Global.getAdminPath()+"/cases/caseSingleTable";
    }

	/**
	 * 导入Excel数据
	 */
	@RequiresPermissions("cases:caseSingleTable:import")
    @RequestMapping(value = "import", method=RequestMethod.POST)
    public String importFile(MultipartFile file, RedirectAttributes redirectAttributes) {
		try {
			int successNum = 0;
			int failureNum = 0;
			StringBuilder failureMsg = new StringBuilder();
			ImportExcel ei = new ImportExcel(file, 1, 0);
			List<CaseSingleTable> list = ei.getDataList(CaseSingleTable.class);
			for (CaseSingleTable caseSingleTable : list){
				try{
					caseSingleTableService.save(caseSingleTable);
					successNum++;
				}catch(ConstraintViolationException ex){
					failureNum++;
				}catch (Exception ex) {
					failureNum++;
				}
			}
			if (failureNum>0){
				failureMsg.insert(0, "，失败 "+failureNum+" 条单表记录。");
			}
			addMessage(redirectAttributes, "已成功导入 "+successNum+" 条单表记录"+failureMsg);
		} catch (Exception e) {
			addMessage(redirectAttributes, "导入单表失败！失败信息："+e.getMessage());
		}
		return "redirect:"+Global.getAdminPath()+"/cases/caseSingleTable";
    }
	
	/**
	 * 下载导入单表数据模板
	 */
	@RequiresPermissions("cases:caseSingleTable:import")
    @RequestMapping(value = "import/template")
    public String importFileTemplate(HttpServletResponse response, RedirectAttributes redirectAttributes) {
		try {
            String fileName = "单表数据导入模板.xlsx";
    		List<CaseSingleTable> list = Lists.newArrayList(); 
    		new ExportExcel("单表数据", CaseSingleTable.class, 1).setDataList(list).write(response, fileName).dispose();
    		return null;
		} catch (Exception e) {
			addMessage(redirectAttributes, "导入模板下载失败！失败信息："+e.getMessage());
		}
		return "redirect:"+Global.getAdminPath()+"/cases/caseSingleTable";
    }
	
	
	

}