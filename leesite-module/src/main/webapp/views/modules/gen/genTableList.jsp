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
    <title>${fns:getConfig('productName')} | 代码生成</title>
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
                <t:menu menu="${fns:getTopMenu()}"></t:menu>
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
                                <span class="caption-subject bold font-grey-gallery uppercase"> 业务表配置 </span>
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
                                    <form:form id="searchForm" modelAttribute="genTable" action="${ctx}/gen/genTable/" method="post" class="form-inline">
                                        <input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
                                        <input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
                                        <sys:tableSort id="orderBy" name="orderBy" value="${page.orderBy}" callback="page();"/>
                                        <div class="form-group">
                                            <label>表名：</label>
                                            <form:input path="nameLike" htmlEscape="false" maxlength="50" class="form-control"/>
                                            <label>说明 ：</label>
                                            <form:input path="comments" htmlEscape="false" maxlength="50" class="form-control"/>
                                            <label>父表表名：</label>
                                            <form:input path="parentTable" htmlEscape="false" maxlength="50" class="form-control"/>
                                        </div>
                                    </form:form>
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-md-12">
                                    <div class="pull-left">
                                        <shiro:hasPermission name="gen:genTable:edit">
                                            <a href="${ctx}/gen/genTable/form" class="btn btn-default btn-sm"><i class="fa fa-plus"></i> 业务表添加</a>
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
                                        <table id="contentTable" class="table table-striped table-bordered table-hover">
                                            <thead>
                                            <tr>
                                                <th class="sort-column name">表名</th>
                                                <th>说明</th>
                                                <th class="sort-column class_name">类名</th>
                                                <th class="sort-column parent_table">父表</th>
                                                <shiro:hasPermission name="gen:genTable:edit">
                                                    <th>操作</th>
                                                </shiro:hasPermission>
                                            </tr>
                                            </thead>
                                            <tbody>
                                            <c:forEach items="${page.list}" var="genTable">
                                                <tr>
                                                    <td><a href="${ctx}/gen/genTable/form?id=${genTable.id}">${genTable.name}</a></td>
                                                    <td>${genTable.comments}</td>
                                                    <td>${genTable.className}</td>
                                                    <td title="点击查询子表"><a href="javascript:" onclick="$('#parentTable').val('${genTable.parentTable}');$('#searchForm').submit();">${genTable.parentTable}</a></td>
                                                    <shiro:hasPermission name="gen:genTable:edit"><td>
                                                        <a href="${ctx}/gen/genTable/form?id=${genTable.id}" class="btn btn-success btn-xs"><i class="fa fa-edit"></i> 修改</a>
                                                        <a href="${ctx}/gen/genTable/delete?id=${genTable.id}" onclick="return confirmx('确认要删除该业务表吗？', this.href)" class="btn btn-danger btn-xs"><i class="fa fa-trash"></i> 删除</a>
                                                    </td></shiro:hasPermission>
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