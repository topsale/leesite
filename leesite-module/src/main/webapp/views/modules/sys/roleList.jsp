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
    <title>${fns:getConfig('productName')} | 角色管理</title>
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
                                <span class="caption-subject bold font-grey-gallery uppercase"> 角色管理 </span>
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
                                    <form:form id="searchForm" modelAttribute="role" action="${ctx}/sys/role/" method="post" class="form-inline">
                                        <input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
                                        <input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
                                        <table:sortColumn id="orderBy" name="orderBy" value="${page.orderBy}" callback="sortOrRefresh();"/><!-- 支持排序 -->
                                        <div class="form-group">
                                            <label>角色名称：</label>
                                            <form:input path="name" value="${role.name}"  htmlEscape="false" maxlength="64"  class=" form-control input-sm"/>
                                        </div>
                                    </form:form>
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-md-12">
                                    <div class="pull-left">
                                        <shiro:hasPermission name="sys:role:add">
                                            <table:addRow url="${ctx}/sys/role/form" title="角色"></table:addRow><!-- 增加按钮 -->
                                        </shiro:hasPermission>
                                        <shiro:hasPermission name="sys:role:edit">
                                            <table:editRow url="${ctx}/sys/role/form" id="contentTable"  title="角色"></table:editRow><!-- 编辑按钮 -->
                                        </shiro:hasPermission>
                                        <shiro:hasPermission name="sys:role:del">
                                            <table:delRow url="${ctx}/sys/role/deleteAll" id="contentTable"></table:delRow><!-- 删除按钮 -->
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
                                                <th>角色名称</th>
                                                <th>英文名称</th>
                                                <th>归属机构</th>
                                                <th>数据范围</th>
                                                <shiro:hasPermission name="sys:role:edit"><th>操作</th></shiro:hasPermission>
                                            </tr>
                                            </thead>
                                            <tbody>
                                            <c:forEach items="${list}" var="role">
                                                <tr>
                                                    <td>
                                                        <label class="mt-checkbox mt-checkbox-single mt-checkbox-outline">
                                                            <input type="checkbox" class="checkboxes i-checks" id="${role.id}" />
                                                            <span></span>
                                                        </label>
                                                    </td>
                                                    <td><a href="#" onclick="openDialogView('查看角色', '${ctx}/sys/role/form?id=${role.id}','900px', '600px')">${role.name}</a></td>
                                                    <td><a href="#" onclick="openDialogView('查看角色', '${ctx}/sys/role/form?id=${role.id}','900px', '600px')">${role.enname}</a></td>
                                                    <td>${role.office.name}</td>
                                                    <td>${fns:getDictLabel(role.dataScope, 'sys_data_scope', '无')}</td>
                                                    <td>
                                                        <shiro:hasPermission name="sys:role:view">
                                                            <a href="#" onclick="openDialogView('查看角色', '${ctx}/sys/role/form?id=${role.id}','900px', '600px')" class="btn btn-info btn-xs" ><i class="fa fa-search-plus"></i> 查看</a>
                                                        </shiro:hasPermission>
                                                        <shiro:hasPermission name="sys:role:edit">
                                                            <c:if test="${(role.sysData eq fns:getDictValue('是', 'yes_no', '1') && fns:getUser().admin)||!(role.sysData eq fns:getDictValue('是', 'yes_no', '1'))}">
                                                                <a href="#" onclick="openDialog('修改角色', '${ctx}/sys/role/form?id=${role.id}','900px', '600px')" class="btn btn-success btn-xs" ><i class="fa fa-edit"></i> 修改</a>
                                                            </c:if>
                                                        </shiro:hasPermission>
                                                        <shiro:hasPermission name="sys:role:del">
                                                            <a href="${ctx}/sys/role/delete?id=${role.id}" onclick="return confirmx('确认要删除该角色吗？', this.href)" class="btn  btn-danger btn-xs"><i class="fa fa-trash"></i> 删除</a>
                                                        </shiro:hasPermission>
                                                        <shiro:hasPermission name="sys:role:assign">
                                                            <a href="#" onclick="openDialog('权限设置', '${ctx}/sys/role/auth?id=${role.id}','350px', '700px')" class="btn btn-primary btn-xs" ><i class="fa fa-edit"></i> 权限设置</a>
                                                        </shiro:hasPermission>
                                                        <shiro:hasPermission name="sys:role:assign">
                                                            <a href="#" onclick="openDialogView('分配用户', '${ctx}/sys/role/assign?id=${role.id}','900px', '600px')"  class="btn  btn-warning btn-xs" ><i class="fa fa-plus"></i> 分配用户</a>
                                                        </shiro:hasPermission>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                            </tbody>
                                        </table>
                                    </div>
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