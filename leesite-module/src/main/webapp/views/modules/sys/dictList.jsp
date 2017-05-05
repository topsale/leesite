<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/views/include/taglib.jsp"%>

<!DOCTYPE html>
<!--[if IE 8]> <html lang="zh" class="ie8 no-js"> <![endif]-->
<!--[if IE 9]> <html lang="zh" class="ie9 no-js"> <![endif]-->
<!--[if !IE]><!-->
<html>
<!--<![endif]-->
<!-- BEGIN HEAD -->
<head>
    <title>${fns:getConfig('productName')} | 字典管理</title>
    <meta name="decorator" content="default"/>
</head>

<body class="page-container-bg-solid page-header-fixed page-sidebar-closed-hide-logo">
<!-- BEGIN CONTAINER -->
<div class="page-container">
    <!-- BEGIN SIDEBAR -->
    <div class="page-sidebar-wrapper">
        <!-- BEGIN SIDEBAR -->
        <div class="page-sidebar navbar-collapse collapse">
            <!-- BEGIN SIDEBAR MENU -->
            <ul class="page-sidebar-menu" data-keep-expanded="false" data-auto-scroll="true" data-slide-speed="200">
                <li class="heading">
                    <h3 class="uppercase">功能菜单</h3>
                </li>
                <t:menu menu="${fns:getTopMenu()}" parentName="系统设置" currentName="字典管理"></t:menu>
            </ul>
            <!-- END SIDEBAR MENU -->
        </div>
        <!-- END SIDEBAR -->
    </div>
    <!-- END SIDEBAR -->
    <!-- BEGIN CONTENT -->
    <div class="page-content-wrapper">
        <!-- BEGIN CONTENT BODY -->
        <div class="page-content" style="padding-top: 0;">
            <div class="row">
                <div class="col-md-12">
                    <!-- BEGIN Portlet PORTLET-->
                    <div class="portlet light">
                        <div class="portlet-title">
                            <div class="caption">
                                <span class="caption-subject bold font-grey-gallery uppercase"> 字典管理 </span>
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
                                    <form:form id="searchForm" modelAttribute="dict" action="${ctx}/sys/dict/" method="post" class="form-inline">
                                        <input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
                                        <input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
                                        <table:sortColumn id="orderBy" name="orderBy" value="${page.orderBy}" callback="sortOrRefresh();"/><!-- 支持排序 -->
                                        <div class="form-group">
                                            <label>类型：</label>
                                            <form:select id="type" path="type" class="form-control input-sm"><form:option value="" label=""/><form:options items="${typeList}" htmlEscape="false"/></form:select>
                                            <label>描述 ：</label>
                                            <form:input path="description" htmlEscape="false" maxlength="50" class="form-control input-sm"/>
                                        </div>
                                    </form:form>
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-md-12">
                                    <div class="pull-left">
                                        <shiro:hasPermission name="sys:dict:add">
                                            <table:addRow url="${ctx}/sys/dict/form" title="字典"></table:addRow><!-- 增加按钮 -->
                                        </shiro:hasPermission>
                                        <shiro:hasPermission name="sys:dict:edit">
                                            <table:editRow url="${ctx}/sys/dict/form" id="contentTable" title="字典"></table:editRow><!-- 编辑按钮 -->
                                        </shiro:hasPermission>
                                        <shiro:hasPermission name="sys:dict:del">
                                            <table:delRow url="${ctx}/sys/dict/deleteAll" id="contentTable"></table:delRow><!-- 删除按钮 -->
                                        </shiro:hasPermission>
                                        <button class="btn btn-default btn-sm" onclick="sortOrRefresh()" title="刷新"><i class="fa fa-refresh"></i> 刷新</button>
                                    </div>
                                    <div class="pull-right">
                                        <button  class="btn btn-primary btn-sm" onclick="search()" ><i class="fa fa-search"></i> 查询</button>
                                        <button  class="btn btn-primary btn-sm" onclick="reset()" ><i class="fa fa-refresh"></i> 重置</button>
                                    </div>
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-md-12">
                                    <div class="table-scrollable">
                                        <table id="contentTable" class="table table-striped table-bordered table-hover table-checkable">
                                            <thead>
                                            <tr>
                                                <th>
                                                    <label class="mt-checkbox mt-checkbox-single mt-checkbox-outline">
                                                        <input type="checkbox" class="group-checkable" data-set=".checkboxes" />
                                                        <span></span>
                                                    </label>
                                                </th>
                                                <th class="sort-column value">键值</th>
                                                <th>标签</th>
                                                <th class="sort-column type">类型</th>
                                                <th class="sort-column description">描述</th>
                                                <th class="sort-column sort">排序</th>
                                                <th>操作</th>
                                            </tr>
                                            </thead>
                                            <tbody>
                                            <c:forEach items="${page.list}" var="dict">
                                                <tr>
                                                    <td>
                                                        <label class="mt-checkbox mt-checkbox-single mt-checkbox-outline">
                                                            <input type="checkbox" class="checkboxes i-checks" id="${dict.id}" />
                                                            <span></span>
                                                        </label>
                                                    </td>
                                                    <td>${dict.value}</td>
                                                    <td><a  href="#" onclick="openDialogView('查看字典', '${ctx}/sys/dict/form?id=${dict.id}','900px', '600px')">${dict.label}</a></td>
                                                    <td><a href="javascript:" onclick="$('#type').val('${dict.type}');$('#searchForm').submit();return false;">${dict.type}</a></td>
                                                    <td>${dict.description}</td>
                                                    <td>${dict.sort}</td>
                                                    <td>
                                                        <shiro:hasPermission name="sys:dict:view">
                                                            <a href="#" onclick="openDialogView('查看字典', '${ctx}/sys/dict/form?id=${dict.id}','900px', '600px')" class="btn btn-info btn-xs"><i class="fa fa-search-plus"></i> 查看</a>
                                                        </shiro:hasPermission>
                                                        <shiro:hasPermission name="sys:dict:edit">
                                                            <a href="#" onclick="openDialog('修改字典', '${ctx}/sys/dict/form?id=${dict.id}','900px', '600px')" class="btn btn-success btn-xs"><i class="fa fa-edit"></i> 修改</a>
                                                        </shiro:hasPermission>
                                                        <shiro:hasPermission name="sys:dict:del">
                                                            <a href="${ctx}/sys/dict/delete?id=${dict.id}&type=${dict.type}" onclick="return confirmx('确认要删除该字典吗？', this.href)" class="btn btn-danger btn-xs"><i class="fa fa-trash"></i> 删除</a>
                                                        </shiro:hasPermission>
                                                        <shiro:hasPermission name="sys:dict:add">
                                                            <a href="#" onclick="openDialog('添加键值', '<c:url value='${fns:getAdminPath()}/sys/dict/form?type=${dict.type}&sort=${dict.sort+10}'><c:param name='description' value='${dict.description}'/></c:url>','900px', '600px')" class="btn btn-primary btn-xs" ><i class="fa fa-plus"></i> 添加键值</a>
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
                    <!-- END GRID PORTLET-->
                </div>
            </div>
        </div>
        <!-- END CONTENT BODY -->
    </div>
    <!-- END CONTENT -->
</div>
<!-- END CONTAINER -->

<%@include file="/views/include/foot.jsp" %>
</body>
</html>