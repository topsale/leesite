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
    <title>${fns:getConfig('productName')} | 通告列表</title>
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
                <t:menu menu="${fns:getTopMenu()}" parentName="在线办公" currentName="${oaNotify.self?'我的通告':'通告管理'}"></t:menu>
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
                                <span class="caption-subject bold font-grey-gallery uppercase"> 通告列表 </span>
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
                                    <form:form id="searchForm" modelAttribute="oaNotify" action="${ctx}/oa/oaNotify/${oaNotify.self?'self':''}" method="post" class="form-inline">
                                        <input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
                                        <input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
                                        <table:sortColumn id="orderBy" name="orderBy" value="${page.orderBy}" callback="sortOrRefresh();"/><!-- 支持排序 -->
                                        <div class="form-group">
                                            <label>标题：</label>
                                            <form:input path="title" htmlEscape="false" maxlength="200"  class="form-control input-sm"/>
                                            <label>类型：</label>
                                            <form:select path="type" class="form-control input-sm">
                                                <form:option value="" label=""/>
                                                <form:options items="${fns:getDictList('oa_notify_type')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
                                            </form:select>
                                            <c:if test="${!requestScope.oaNotify.self}">
                                                <label>状态：</label>
                                                <div class="input-group">
                                                    <div class="icheck-inline">
                                                        <form:radiobuttons path="status" class="icheck" items="${fns:getDictList('oa_notify_status')}" itemLabel="label" itemValue="value" htmlEscape="false" />
                                                    </div>
                                                </div>
                                            </c:if>
                                        </div>
                                    </form:form>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-12">
                                    <div class="pull-left">
                                        <c:if test="${!requestScope.oaNotify.self}">
                                            <shiro:hasPermission name="oa:oaNotify:add">
                                                <table:addRow url="${ctx}/oa/oaNotify/form" title="通知"></table:addRow><!-- 增加按钮 -->
                                            </shiro:hasPermission>
                                            <shiro:hasPermission name="oa:oaNotify:edit">
                                                <table:editRow url="${ctx}/oa/oaNotify/form" id="contentTable"  title="通知" width="900px" height="600px"></table:editRow><!-- 编辑按钮 -->
                                            </shiro:hasPermission>
                                            <shiro:hasPermission name="oa:oaNotify:del">
                                                <table:delRow url="${ctx}/oa/oaNotify/deleteAll" id="contentTable"></table:delRow><!-- 删除按钮 -->
                                            </shiro:hasPermission>
                                            <button class="btn btn-default btn-sm" onclick="sortOrRefresh()"><i class="fa fa-repeat"></i> 刷新</button>
                                        </c:if>
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
                                                <th>标题</th>
                                                <th>类型</th>
                                                <th>状态</th>
                                                <th>查阅状态</th>
                                                <th>更新时间</th>
                                                <th>操作</th>
                                            </tr>
                                            </thead>
                                            <tbody>
                                            <c:forEach items="${page.list}" var="oaNotify">
                                                <tr>
                                                    <td>
                                                        <label class="mt-checkbox mt-checkbox-single mt-checkbox-outline">
                                                            <input type="checkbox" class="checkboxes i-checks" id="${oaNotify.id}" />
                                                            <span></span>
                                                        </label>
                                                    </td>
                                                    <td>
                                                        <a href="#" onclick="openDialogView('查看通知', '${ctx}/oa/oaNotify/${requestScope.oaNotify.self?'view':'form'}?id=${oaNotify.id}','900px', '600px')">
                                                            ${fns:abbr(oaNotify.title,50)}
                                                        </a>
                                                    </td>
                                                    <td>
                                                            ${fns:getDictLabel(oaNotify.type, 'oa_notify_type', '')}
                                                    </td>
                                                    <td>
                                                            ${fns:getDictLabel(oaNotify.status, 'oa_notify_status', '')}
                                                    </td>
                                                    <td>
                                                        <c:if test="${requestScope.oaNotify.self}">
                                                            ${fns:getDictLabel(oaNotify.readFlag, 'oa_notify_read', '')}
                                                        </c:if>
                                                        <c:if test="${!requestScope.oaNotify.self}">
                                                            ${oaNotify.readNum} / ${oaNotify.readNum + oaNotify.unReadNum}
                                                        </c:if>
                                                    </td>
                                                    <td>
                                                        <fmt:formatDate value="${oaNotify.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
                                                    </td>
                                                    <td>
                                                        <c:if test="${!requestScope.oaNotify.self}">
                                                            <shiro:hasPermission name="oa:oaNotify:view">
                                                                <a href="#" onclick="openDialogView('查看通知', '${ctx}/oa/oaNotify/form?id=${oaNotify.id}','900px', '600px')" class="btn btn-info btn-xs" ><i class="fa fa-search-plus"> 查看</i></a>
                                                            </shiro:hasPermission>
                                                            <shiro:hasPermission name="oa:oaNotify:edit">
                                                                <a href="#" onclick="openDialog('修改通知', '${ctx}/oa/oaNotify/form?id=${oaNotify.id}','900px', '600px')" class="btn btn-success btn-xs" ><i class="fa fa-edit"> 修改</i></a>
                                                            </shiro:hasPermission>
                                                            <shiro:hasPermission name="oa:oaNotify:del">
                                                                <a href="${ctx}/oa/oaNotify/delete?id=${oaNotify.id}" onclick="return confirmx('确认要删除该通知吗？', this.href)"   class="btn btn-danger btn-xs"><i class="fa fa-trash"> 删除</i></a>
                                                            </shiro:hasPermission>
                                                        </c:if>
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