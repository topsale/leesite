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
	<title>${fns:getConfig('productName')} | 生成示例一对多</title>
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
                <t:menu menu="${fns:getTopMenu()}"></t:menu>
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
                                <span class="caption-subject bold font-grey-gallery uppercase"> 生成示例一对多 </span>
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
									<form:form id="searchForm" modelAttribute="caseOneToManyMain" action="${ctx}/cases/caseOneToManyMain" method="post" class="form-inline">
										<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
										<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
										<table:sortColumn id="orderBy" name="orderBy" value="${page.orderBy}" callback="sortOrRefresh();"/><!-- 支持排序 -->
										<div class="form-group">
                                            		<label>归属用户：</label>
														<sys:treeselect id="user" name="user.id" value="${caseOneToManyMain.user.id}" labelName="user.name" labelValue="${caseOneToManyMain.user.name}"
															title="用户" url="/sys/office/treeData?type=3" cssClass="form-control input-sm" allowClear="true" notAllowSelectParent="true"/>
                                            		<label>名称：</label>
                                            			<form:input path="name" htmlEscape="false" maxlength="100" class="form-control input-sm"/>
                                            		<label>性别：</label>
														<form:radiobuttons class="icheck" path="sex" items="${fns:getDictList('sex')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
                                            		<label>加入日期：</label>
														<input id="beginInDate" name="beginInDate" type="text" maxlength="20" class="laydate-icon form-control layer-date input-sm"
															value="<fmt:formatDate value="${caseOneToManyMain.beginInDate}" pattern="yyyy-MM-dd HH:mm:ss"/>"/> -
														<input id="endInDate" name="endInDate" type="text" maxlength="20" class="laydate-icon form-control layer-date input-sm"
															value="<fmt:formatDate value="${caseOneToManyMain.endInDate}" pattern="yyyy-MM-dd HH:mm:ss"/>"/>
                                        </div>
									</form:form>
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-md-12">
                                    <div class="pull-left">
										<shiro:hasPermission name="cases:caseOneToManyMain:add">
											<table:addRow url="${ctx}/cases/caseOneToManyMain/form" title="生成示例一对多"></table:addRow><!-- 增加按钮 -->
										</shiro:hasPermission>
										<shiro:hasPermission name="cases:caseOneToManyMain:edit">
											<table:editRow url="${ctx}/cases/caseOneToManyMain/form" title="生成示例一对多" id="contentTable"></table:editRow><!-- 编辑按钮 -->
										</shiro:hasPermission>
										<shiro:hasPermission name="cases:caseOneToManyMain:del">
											<table:delRow url="${ctx}/cases/caseOneToManyMain/deleteAll" id="contentTable"></table:delRow><!-- 删除按钮 -->
										</shiro:hasPermission>
										<shiro:hasPermission name="cases:caseOneToManyMain:import">
											<table:importExcel url="${ctx}/cases/caseOneToManyMain/import"></table:importExcel><!-- 导入按钮 -->
										</shiro:hasPermission>
										<shiro:hasPermission name="cases:caseOneToManyMain:export">
											<table:exportExcel url="${ctx}/cases/caseOneToManyMain/export"></table:exportExcel><!-- 导出按钮 -->
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
													<th class="sort-column user.name">归属用户</th>
													<th class="sort-column office.name">归属部门</th>
													<th class="sort-column area.name">归属区域</th>
													<th class="sort-column name">名称</th>
													<th class="sort-column sex">性别</th>
													<th class="sort-column inDate">加入日期</th>
													<th class="sort-column remarks">备注信息</th>
													<th>操作</th>
												</tr>
											</thead>
											<tbody>
											<c:forEach items="${page.list}" var="caseOneToManyMain">
												<tr>
													<td>
														<label class="mt-checkbox mt-checkbox-single mt-checkbox-outline">
                                                            <input type="checkbox" class="checkboxes i-checks" id="${caseOneToManyMain.id}" />
                                                            <span></span>
                                                        </label>
													</td>
													<td><a  href="#" onclick="openDialogView('查看生成示例一对多', '${ctx}/cases/caseOneToManyMain/form?id=${caseOneToManyMain.id}','900px', '600px')">
														${caseOneToManyMain.user.name}
													</a></td>
													<td>
														${caseOneToManyMain.office.name}
													</td>
													<td>
														${caseOneToManyMain.area.name}
													</td>
													<td>
														${caseOneToManyMain.name}
													</td>
													<td>
														${fns:getDictLabel(caseOneToManyMain.sex, 'sex', '')}
													</td>
													<td>
														<fmt:formatDate value="${caseOneToManyMain.inDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
													</td>
													<td>
														${caseOneToManyMain.remarks}
													</td>
													<td>
														<shiro:hasPermission name="cases:caseOneToManyMain:view">
															<a href="#" onclick="openDialogView('查看生成示例一对多', '${ctx}/cases/caseOneToManyMain/form?id=${caseOneToManyMain.id}','900px', '600px')" class="btn btn-info btn-xs" ><i class="fa fa-search-plus"></i> 查看</a>
														</shiro:hasPermission>
														<shiro:hasPermission name="cases:caseOneToManyMain:edit">
															<a href="#" onclick="openDialog('修改生成示例一对多', '${ctx}/cases/caseOneToManyMain/form?id=${caseOneToManyMain.id}','900px', '600px')" class="btn btn-success btn-xs" ><i class="fa fa-edit"></i> 修改</a>
														</shiro:hasPermission>
														<shiro:hasPermission name="cases:caseOneToManyMain:del">
															<a href="${ctx}/cases/caseOneToManyMain/delete?id=${caseOneToManyMain.id}" onclick="return confirmx('确认要删除该生成示例一对多吗？', this.href)" class="btn btn-danger btn-xs"><i class="fa fa-trash"></i> 删除</a>
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
				laydate({
					elem: '#beginInDate', // 目标元素。由于laydate.js封装了一个轻量级的选择器引擎，因此elem还允许你传入class、tag但必须按照这种方式 '#id .class'
					event: 'focus' // 响应事件。如果没有传入event，则按照默认的click
				});

				laydate({
					elem: '#endInDate', // 目标元素。由于laydate.js封装了一个轻量级的选择器引擎，因此elem还允许你传入class、tag但必须按照这种方式 '#id .class'
					event: 'focus' // 响应事件。如果没有传入event，则按照默认的click
				});
	});
</script>
</body>
</html>