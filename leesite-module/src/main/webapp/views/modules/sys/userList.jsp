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
    <title>${fns:getConfig('productName')} | 用户列表</title>
    <meta name="decorator" content="blank"/>
</head>

<body style="background: white;">
<sys:message content="${message}"/>

<div class="row" style="margin-bottom: 20px;">
    <div class="col-md-12">
        <form:form id="searchForm" modelAttribute="user" action="${ctx}/sys/user/list" method="post" class="form-inline">
            <input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
            <input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
            <table:sortColumn id="orderBy" name="orderBy" value="${page.orderBy}" callback="sortOrRefresh();"/><!-- 支持排序 -->
            <div class="form-group">
                <lable>归属公司：</lable>
                <sys:treeselect id="company" name="company.id" value="${user.company.id}" labelName="company.name" labelValue="${user.company.name}" title="公司" url="/sys/office/treeData?type=1" cssClass=" form-control input-sm" allowClear="true"/>
                <lable>登录名：</lable>
                <form:input path="loginName" htmlEscape="false" maxlength="50" class=" form-control input-sm"/>
                <lable>归属部门：</lable>
                <sys:treeselect id="office" name="office.id" value="${user.office.id}" labelName="office.name" labelValue="${user.office.name}" title="部门" url="/sys/office/treeData?type=2" cssClass=" form-control input-sm" allowClear="true" notAllowSelectParent="true"/>
                <lable>姓&nbsp;&nbsp;&nbsp;名：</lable>
                <form:input path="name" htmlEscape="false" maxlength="50" class=" form-control input-sm"/>
            </div>
        </form:form>
    </div>
</div>

<div class="row">
    <div class="col-md-12">
        <div class="pull-left">
            <shiro:hasPermission name="sys:user:add">
                <table:addRow url="${ctx}/sys/user/form" title="用户" width="900px" height="600px" target="officeContent"></table:addRow><!-- 增加按钮 -->
            </shiro:hasPermission>
            <shiro:hasPermission name="sys:user:edit">
                <table:editRow url="${ctx}/sys/user/form" id="contentTable"  title="用户" width="900px" height="600px" target="officeContent"></table:editRow><!-- 编辑按钮 -->
            </shiro:hasPermission>
            <shiro:hasPermission name="sys:user:del">
                <table:delRow url="${ctx}/sys/user/deleteAll" id="contentTable"></table:delRow><!-- 删除按钮 -->
            </shiro:hasPermission>
            <shiro:hasPermission name="sys:user:import">
                <table:importExcel url="${ctx}/sys/user/import"></table:importExcel><!-- 导入按钮 -->
            </shiro:hasPermission>
            <shiro:hasPermission name="sys:user:export">
                <table:exportExcel url="${ctx}/sys/user/export"></table:exportExcel><!-- 导出按钮 -->
            </shiro:hasPermission>
            <button class="btn btn-default btn-sm" onclick="sortOrRefresh()"><i class="fa fa-repeat"></i> 刷新</button>
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
                    <th class="sort-column login_name">登录名</th>
                    <th class="sort-column name">姓名</th>
                    <th class="sort-column phone">电话</th>
                    <th class="sort-column mobile">手机</th>
                    <th class="sort-column c.name">归属公司</th>
                    <th class="sort-column o.name">归属部门</th>
                    <th>操作</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach items="${page.list}" var="user">
                    <tr>
                        <td>
                            <label class="mt-checkbox mt-checkbox-single mt-checkbox-outline">
                                <input type="checkbox" class="checkboxes i-checks" id="${user.id}" />
                                <span></span>
                            </label>
                        </td>
                        <td><a  href="#" onclick="openDialogView('查看用户', '${ctx}/sys/user/form?id=${user.id}','900px', '600px')">${user.loginName}</a></td>
                        <td>${user.name}</td>
                        <td>${user.phone}</td>
                        <td>${user.mobile}</td>
                        <td>${user.company.name}</td>
                        <td>${user.office.name}</td>
                        <td>
                            <shiro:hasPermission name="sys:user:view">
                                <a href="#" onclick="openDialogView('查看用户', '${ctx}/sys/user/form?id=${user.id}','900px', '600px')" class="btn btn-info btn-xs" ><i class="fa fa-search-plus"></i> 查看</a>
                            </shiro:hasPermission>
                            <shiro:hasPermission name="sys:user:edit">
                                <a href="#" onclick="openDialog('修改用户', '${ctx}/sys/user/form?id=${user.id}','900px', '600px', 'officeContent')" class="btn btn-success btn-xs" ><i class="fa fa-edit"></i> 修改</a>
                            </shiro:hasPermission>
                            <shiro:hasPermission name="sys:user:del">
                                <a href="${ctx}/sys/user/delete?id=${user.id}" onclick="return confirmx('确认要删除该用户吗？', this.href)" class="btn btn-danger btn-xs"><i class="fa fa-trash"></i> 删除</a>
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

<%@include file="/views/include/foot.jsp" %>
</body>
</html>
