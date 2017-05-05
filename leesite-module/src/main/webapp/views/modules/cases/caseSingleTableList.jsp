<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/views/include/taglib.jsp" %>

<!DOCTYPE html>
<!--[if IE 8]> <html lang="zh" class="ie8 no-js"> <![endif]-->
<!--[if IE 9]> <html lang="zh" class="ie9 no-js"> <![endif]-->
<!--[if !IE]><!-->
<html>
<!--<![endif]-->
<!-- BEGIN HEAD -->
<head>
	<title>${fns:getConfig('productName')} | 生成示例单表</title>
    <meta name="decorator" content="default"/>
</head>

<body class="page-container-bg-solid page-header-fixed page-sidebar-closed-hide-logo">
<div class="page-container">
	<div class="page-sidebar-wrapper">
        <div class="page-sidebar navbar-collapse collapse">
            <ul class="page-sidebar-menu" data-keep-expanded="false" data-auto-scroll="true" data-slide-speed="200">
                <li class="heading">
                    <h3 class="uppercase">功能菜单</h3>
                </li>
                <t:menu menu="${fns:getTopMenu()}" parentName="生成示例" currentName="单表"></t:menu>
            </ul>
        </div>
    </div>

    <div class="page-content-wrapper">
        <div class="page-content" style="padding-top: 0;">
            <div class="row">
                <div class="col-md-12">
                    <div class="portlet light">
                        <div class="portlet-title">
                            <div class="caption">
                                <span class="caption-subject bold font-grey-gallery uppercase"> 生成示例单表 </span>
                                <span class="caption-helper"></span>
                            </div>
                            <div class="tools">
                                <a href="" class="fullscreen"> </a>
                            </div>
                        </div>
                        <div class="portlet-body">
                            <sys:message content="${message}"/>
                            <div class="row" style="margin-bottom: 20px;">
                                <div class="col-md-12">
									<form:form id="searchForm" modelAttribute="caseSingleTable" action="${ctx}/cases/caseSingleTable" method="post" class="form-inline">
										<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
										<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
										<table:sortColumn id="orderBy" name="orderBy" value="${page.orderBy}" callback="sortOrRefresh();"/><!-- 支持排序 -->
										<div class="form-group">
                                            		<label>员工：</label>
														<sys:treeselect id="user" name="user.id" value="${caseSingleTable.user.id}" labelName="user.name" labelValue="${caseSingleTable.user.name}"
															title="用户" url="/sys/office/treeData?type=3" cssClass="form-control input-sm" allowClear="true" notAllowSelectParent="true"/>
                                        </div>
									</form:form>
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-md-12">
                                    <div class="pull-left">
										<shiro:hasPermission name="cases:caseSingleTable:add">
											<table:addRow url="${ctx}/cases/caseSingleTable/form" title="生成示例单表"></table:addRow><!-- 增加按钮 -->
										</shiro:hasPermission>
										<shiro:hasPermission name="cases:caseSingleTable:edit">
											<table:editRow url="${ctx}/cases/caseSingleTable/form" title="生成示例单表" id="contentTable"></table:editRow><!-- 编辑按钮 -->
										</shiro:hasPermission>
										<shiro:hasPermission name="cases:caseSingleTable:del">
											<table:delRow url="${ctx}/cases/caseSingleTable/deleteAll" id="contentTable"></table:delRow><!-- 删除按钮 -->
										</shiro:hasPermission>
										<shiro:hasPermission name="cases:caseSingleTable:import">
											<table:importExcel url="${ctx}/cases/caseSingleTable/import"></table:importExcel><!-- 导入按钮 -->
										</shiro:hasPermission>
										<shiro:hasPermission name="cases:caseSingleTable:export">
											<table:exportExcel url="${ctx}/cases/caseSingleTable/export"></table:exportExcel><!-- 导出按钮 -->
										</shiro:hasPermission>
                                        <button class="btn btn-default btn-sm" onclick="sortOrRefresh()" title="刷新"><i class="fa fa-refresh"></i> 刷新</button>
                                    </div>
                                    <div class="pull-right">
                                        <button class="btn btn-primary btn-sm" onclick="search()"><i class="fa fa-search"></i> 查询</button>
                                        <button class="btn btn-primary btn-sm" onclick="reset()"><i class="fa fa-refresh"></i> 重置</button>
                                    </div>
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-md-12">
                                    <div class="table-scrollable">
                                        <table id="contentTable" class="table table-striped table-bordered table-hover table-checkable">
											<thead>
												<tr style="cursor: pointer">
													<th>
														<label class="mt-checkbox mt-checkbox-single mt-checkbox-outline">
															<input type="checkbox" class="group-checkable" data-set=".checkboxes" />
															<span></span>
														</label>
													</th>
													<th class="sort-column user.name">员工</th>
													<th class="sort-column office.name">归属部门</th>
													<th class="sort-column area.name">归属区域</th>
													<th class="sort-column beginDate">请假开始日期</th>
													<th class="sort-column endDate">请假结束日期</th>
													<th class="sort-column remarks">备注信息</th>
													<th>操作</th>
												</tr>
											</thead>
											<tbody>
											<c:forEach items="${page.list}" var="caseSingleTable">
												<tr>
													<td>
														<label class="mt-checkbox mt-checkbox-single mt-checkbox-outline">
                                                            <input type="checkbox" class="checkboxes i-checks" id="${caseSingleTable.id}" />
                                                            <span></span>
                                                        </label>
													</td>
													<td><a  href="#" onclick="openDialogView('查看生成示例单表', '${ctx}/cases/caseSingleTable/form?id=${caseSingleTable.id}','900px', '600px')">
														${caseSingleTable.user.name}
													</a></td>
													<td>
														${caseSingleTable.office.name}
													</td>
													<td>
														${caseSingleTable.area.name}
													</td>
													<td>
														<fmt:formatDate value="${caseSingleTable.beginDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
													</td>
													<td>
														<fmt:formatDate value="${caseSingleTable.endDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
													</td>
													<td>
														${caseSingleTable.remarks}
													</td>
													<td>
														<shiro:hasPermission name="cases:caseSingleTable:view">
															<a href="#" onclick="openDialogView('查看生成示例单表', '${ctx}/cases/caseSingleTable/form?id=${caseSingleTable.id}','900px', '600px')" class="btn btn-info btn-xs" ><i class="fa fa-search-plus"></i> 查看</a>
														</shiro:hasPermission>
														<shiro:hasPermission name="cases:caseSingleTable:edit">
															<a href="#" onclick="openDialog('修改生成示例单表', '${ctx}/cases/caseSingleTable/form?id=${caseSingleTable.id}','900px', '600px')" class="btn btn-success btn-xs" ><i class="fa fa-edit"></i> 修改</a>
														</shiro:hasPermission>
														<shiro:hasPermission name="cases:caseSingleTable:del">
															<a href="${ctx}/cases/caseSingleTable/delete?id=${caseSingleTable.id}" onclick="return confirmx('确认要删除该生成示例单表吗？', this.href)" class="btn btn-danger btn-xs"><i class="fa fa-trash"></i> 删除</a>
														</shiro:hasPermission>
													</td>
												</tr>
											</c:forEach>
											</tbody>
										</table>
                                    </div>
                                    <table:page page="${page}"></table:page>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<%@ include file="/views/include/foot.jsp" %>
<script type="text/javascript">
	$(document).ready(function() {
	});
</script>
</body>
</html>