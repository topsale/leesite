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
    <title>${fns:getConfig('productName')} | 接口测试</title>
    <meta name="decorator" content="default"/>

    <style type="text/css">
        .AutoNewline {
            Word-break: break-all; /*必须*/
        }
    </style>
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
                                <span class="caption-subject bold font-grey-gallery uppercase"> 接口列表 </span>
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
                                    <form:form id="searchForm" modelAttribute="testInterface" action="${ctx}/tools/testInterface/" method="post" class="form-inline">
                                        <input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
                                        <input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
                                        <table:sortColumn id="orderBy" name="orderBy" value="${page.orderBy}" callback="sortOrRefresh();"/><!-- 支持排序 -->
                                        <div class="form-group">
                                            <label>接口名称：</label>
                                            <form:input path="name" htmlEscape="false" maxlength="1024"  class=" form-control input-sm"/>
                                            <label>接口类型：</label>
                                            <form:select path="type"  class="form-control input-sm">
                                                <form:option value="" label=""/>
                                                <form:options items="${fns:getDictList('interface_type')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
                                            </form:select>
                                        </div>
                                    </form:form>
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-md-12">
                                    <div class="pull-left">
                                        <shiro:hasPermission name="tools:testInterface:add">
                                            <table:addRow url="${ctx}/tools/testInterface/form" title="接口"></table:addRow><!-- 增加按钮 -->
                                        </shiro:hasPermission>
                                        <shiro:hasPermission name="tools:testInterface:edit">
                                            <table:editRow url="${ctx}/tools/testInterface/form" title="接口" id="contentTable"></table:editRow><!-- 编辑按钮 -->
                                        </shiro:hasPermission>
                                        <shiro:hasPermission name="tools:testInterface:del">
                                            <table:delRow url="${ctx}/tools/testInterface/deleteAll" id="contentTable"></table:delRow><!-- 删除按钮 -->
                                        </shiro:hasPermission>
                                        <shiro:hasPermission name="tools:testInterface:import">
                                            <table:importExcel url="${ctx}/tools/testInterface/import"></table:importExcel><!-- 导入按钮 -->
                                        </shiro:hasPermission>
                                        <shiro:hasPermission name="tools:testInterface:export">
                                            <table:exportExcel url="${ctx}/tools/testInterface/export"></table:exportExcel><!-- 导出按钮 -->
                                        </shiro:hasPermission>
                                        <button class="btn btn-default btn-sm" onclick="test()" title="测试"><i class="fa fa-check"></i> 测试</button>
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
                                                <th  width="180px"  class="nowrap sort-column name">接口名称</th>
                                                <th  width="80px"  class="nowrap sort-column type">接口类型</th>
                                                <th  class="nowrap sort-column url">请求URL</th>
                                                <th  class="nowrap sort-column body">请求body</th>
                                                <th  width="110px" class="nowrap sort-column successmsg">成功时返回消息</th>
                                                <th  width="110px" class="nowrap sort-column errormsg">失败时返回消息</th>
                                                <th  width="300px">操作</th>
                                            </tr>
                                            </thead>
                                            <tbody>
                                            <c:forEach items="${page.list}" var="testInterface">
                                                <tr>
                                                    <td>
                                                        <label class="mt-checkbox mt-checkbox-single mt-checkbox-outline">
                                                            <input type="checkbox" class="checkboxes i-checks" id="${testInterface.id}" />
                                                            <span></span>
                                                        </label>
                                                    </td>
                                                    <td  class="AutoNewline"><a  href="#" onclick="openDialogView('查看接口', '${ctx}/tools/testInterface/form?id=${testInterface.id}','900px', '600px')">
                                                            ${testInterface.name}
                                                    </a></td>
                                                    <td  class="AutoNewline">
                                                            ${fns:getDictLabel(testInterface.type, 'interface_type', '')}
                                                    </td>
                                                    <td  class="AutoNewline">
                                                            ${testInterface.url}
                                                    </td>
                                                    <td class="AutoNewline">
                                                            ${testInterface.body}
                                                    </td>
                                                    <td  class="AutoNewline">
                                                            ${testInterface.successmsg}
                                                    </td>
                                                    <td  class="AutoNewline">
                                                            ${testInterface.errormsg}
                                                    </td>
                                                    <td>
                                                        <a href="javaScript:test('${testInterface.id}')" class="btn btn-info btn-xs" ><i class="fa  fa-check icon-white"></i> 测试</a>
                                                        <shiro:hasPermission name="tools:testInterface:view">
                                                            <a href="#" onclick="openDialogView('查看接口', '${ctx}/tools/testInterface/form?id=${testInterface.id}','900px', '600px')" class="btn btn-info btn-xs" ><i class="fa fa-search-plus"></i> 查看</a>
                                                        </shiro:hasPermission>
                                                        <shiro:hasPermission name="tools:testInterface:edit">
                                                            <a href="#" onclick="openDialog('修改接口', '${ctx}/tools/testInterface/form?id=${testInterface.id}','900px', '600px')" class="btn btn-success btn-xs" ><i class="fa fa-edit"></i> 修改</a>
                                                        </shiro:hasPermission>
                                                        <shiro:hasPermission name="tools:testInterface:del">
                                                            <a href="${ctx}/tools/testInterface/delete?id=${testInterface.id}" onclick="return confirmx('确认要删除该接口吗？', this.href)"   class="btn btn-danger btn-xs"><i class="fa fa-trash"></i> 删除</a>
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
<script type="text/javascript">
    function test(id) {
        if (!id) {
            var size = $("#contentTable tbody tr td input.i-checks:checked").size();
            if (size == 0) {
                top.layer.alert('请至少选择一条数据!', {icon: 0, title: '警告'});
                return;
            }
            if (size > 1) {
                top.layer.alert('只能选择一条数据!', {icon: 0, title: '警告'});
                return;
            }
            id = $("#contentTable tbody tr td input.i-checks:checkbox:checked").attr("id");
        }
        window.open("${ctx}/tools/testInterface/test?id=" + id);
    }
</script>
</body>
</html>