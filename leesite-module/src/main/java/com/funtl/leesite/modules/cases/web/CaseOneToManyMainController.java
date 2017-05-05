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
import com.funtl.leesite.modules.cases.entity.CaseOneToManyMain;
import com.funtl.leesite.modules.cases.service.CaseOneToManyMainService;

/**
 * 生成示例Controller
 * @author Lusifer
 * @version 2017-05-05
 */
@Controller
@RequestMapping(value = "${adminPath}/cases/caseOneToManyMain")
public class CaseOneToManyMainController extends BaseController {

	@Autowired
	private CaseOneToManyMainService caseOneToManyMainService;
	
	@ModelAttribute
	public CaseOneToManyMain get(@RequestParam(required=false) String id) {
		CaseOneToManyMain entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = caseOneToManyMainService.get(id);
		}
		if (entity == null){
			entity = new CaseOneToManyMain();
		}
		return entity;
	}
	
	/**
	 * 一对多列表页面
	 */
	@RequiresPermissions("cases:caseOneToManyMain:list")
	@RequestMapping(value = {"list", ""})
	public String list(CaseOneToManyMain caseOneToManyMain, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<CaseOneToManyMain> page = caseOneToManyMainService.findPage(new Page<CaseOneToManyMain>(request, response), caseOneToManyMain); 
		model.addAttribute("page", page);
		return "modules/cases/caseOneToManyMainList";
	}

	/**
	 * 查看，增加，编辑一对多表单页面
	 */
	@RequiresPermissions(value={"cases:caseOneToManyMain:view","cases:caseOneToManyMain:add","cases:caseOneToManyMain:edit"},logical=Logical.OR)
	@RequestMapping(value = "form")
	public String form(CaseOneToManyMain caseOneToManyMain, Model model) {
		model.addAttribute("caseOneToManyMain", caseOneToManyMain);
		return "modules/cases/caseOneToManyMainForm";
	}

	/**
	 * 保存一对多
	 */
	@RequiresPermissions(value={"cases:caseOneToManyMain:add","cases:caseOneToManyMain:edit"},logical=Logical.OR)
	@RequestMapping(value = "save")
	public String save(CaseOneToManyMain caseOneToManyMain, Model model, RedirectAttributes redirectAttributes) throws Exception{
		if (!beanValidator(model, caseOneToManyMain)){
			return form(caseOneToManyMain, model);
		}
		if(!caseOneToManyMain.getIsNewRecord()){//编辑表单保存
			CaseOneToManyMain t = caseOneToManyMainService.get(caseOneToManyMain.getId());//从数据库取出记录的值
			MyBeanUtils.copyBeanNotNull2Bean(caseOneToManyMain, t);//将编辑表单中的非NULL值覆盖数据库记录中的值
			caseOneToManyMainService.save(t);//保存
		}else{//新增表单保存
			caseOneToManyMainService.save(caseOneToManyMain);//保存
		}
		addMessage(redirectAttributes, "保存一对多成功");
		return "redirect:"+Global.getAdminPath()+"/cases/caseOneToManyMain";
	}
	
	/**
	 * 删除一对多
	 */
	@RequiresPermissions("cases:caseOneToManyMain:del")
	@RequestMapping(value = "delete")
	public String delete(CaseOneToManyMain caseOneToManyMain, RedirectAttributes redirectAttributes) {
		caseOneToManyMainService.delete(caseOneToManyMain);
		addMessage(redirectAttributes, "删除一对多成功");
		return "redirect:"+Global.getAdminPath()+"/cases/caseOneToManyMain";
	}
	
	/**
	 * 批量删除一对多
	 */
	@RequiresPermissions("cases:caseOneToManyMain:del")
	@RequestMapping(value = "deleteAll")
	public String deleteAll(String ids, RedirectAttributes redirectAttributes) {
		String idArray[] =ids.split(",");
		for(String id : idArray){
			caseOneToManyMainService.delete(caseOneToManyMainService.get(id));
		}
		addMessage(redirectAttributes, "删除一对多成功");
		return "redirect:"+Global.getAdminPath()+"/cases/caseOneToManyMain";
	}
	
	/**
	 * 导出excel文件
	 */
	@RequiresPermissions("cases:caseOneToManyMain:export")
    @RequestMapping(value = "export", method=RequestMethod.POST)
    public String exportFile(CaseOneToManyMain caseOneToManyMain, HttpServletRequest request, HttpServletResponse response, RedirectAttributes redirectAttributes) {
		try {
            String fileName = "一对多"+DateUtils.getDate("yyyyMMddHHmmss")+".xlsx";
            Page<CaseOneToManyMain> page = caseOneToManyMainService.findPage(new Page<CaseOneToManyMain>(request, response, -1), caseOneToManyMain);
    		new ExportExcel("一对多", CaseOneToManyMain.class).setDataList(page.getList()).write(response, fileName).dispose();
    		return null;
		} catch (Exception e) {
			addMessage(redirectAttributes, "导出一对多记录失败！失败信息："+e.getMessage());
		}
		return "redirect:"+Global.getAdminPath()+"/cases/caseOneToManyMain";
    }

	/**
	 * 导入Excel数据
	 */
	@RequiresPermissions("cases:caseOneToManyMain:import")
    @RequestMapping(value = "import", method=RequestMethod.POST)
    public String importFile(MultipartFile file, RedirectAttributes redirectAttributes) {
		try {
			int successNum = 0;
			int failureNum = 0;
			StringBuilder failureMsg = new StringBuilder();
			ImportExcel ei = new ImportExcel(file, 1, 0);
			List<CaseOneToManyMain> list = ei.getDataList(CaseOneToManyMain.class);
			for (CaseOneToManyMain caseOneToManyMain : list){
				try{
					caseOneToManyMainService.save(caseOneToManyMain);
					successNum++;
				}catch(ConstraintViolationException ex){
					failureNum++;
				}catch (Exception ex) {
					failureNum++;
				}
			}
			if (failureNum>0){
				failureMsg.insert(0, "，失败 "+failureNum+" 条一对多记录。");
			}
			addMessage(redirectAttributes, "已成功导入 "+successNum+" 条一对多记录"+failureMsg);
		} catch (Exception e) {
			addMessage(redirectAttributes, "导入一对多失败！失败信息："+e.getMessage());
		}
		return "redirect:"+Global.getAdminPath()+"/cases/caseOneToManyMain";
    }
	
	/**
	 * 下载导入一对多数据模板
	 */
	@RequiresPermissions("cases:caseOneToManyMain:import")
    @RequestMapping(value = "import/template")
    public String importFileTemplate(HttpServletResponse response, RedirectAttributes redirectAttributes) {
		try {
            String fileName = "一对多数据导入模板.xlsx";
    		List<CaseOneToManyMain> list = Lists.newArrayList(); 
    		new ExportExcel("一对多数据", CaseOneToManyMain.class, 1).setDataList(list).write(response, fileName).dispose();
    		return null;
		} catch (Exception e) {
			addMessage(redirectAttributes, "导入模板下载失败！失败信息："+e.getMessage());
		}
		return "redirect:"+Global.getAdminPath()+"/cases/caseOneToManyMain";
    }
	
	
	

}