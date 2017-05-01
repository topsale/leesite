<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/views/include/taglib.jsp"%>

<!DOCTYPE html>
<!--[if IE 8]> <html lang="zh" class="ie8 no-js"> <![endif]-->
<!--[if IE 9]> <html lang="zh" class="ie9 no-js"> <![endif]-->
<!--[if !IE]><!-->
<html>
<!--<![endif]-->

<head>
    <title>${fns:getConfig('productName')} | 菜单管理</title>
    <meta name="decorator" content="default"/>
    <%@include file="/views/include/treetable.jsp" %>
</head>

<body class="page-container-bg-solid page-header-fixed page-sidebar-closed-hide-logo">
<!-- BEGIN CONTAINER -->
<div class="page-container">
    <!-- BEGIN SIDEBAR -->
    <div class="page-sidebar-wrapper">
        <!-- BEGIN SIDEBAR -->
        <!-- DOC: Set data-auto-scroll="false" to disable the sidebar from auto scrolling/focusing -->
        <!-- DOC: Change data-auto-speed="200" to adjust the sub menu slide up/down speed -->
        <div class="page-sidebar navbar-collapse collapse">
            <!-- BEGIN SIDEBAR MENU -->
            <!-- DOC: Apply "page-sidebar-menu-light" class right after "page-sidebar-menu" to enable light sidebar menu style(without borders) -->
            <!-- DOC: Apply "page-sidebar-menu-hover-submenu" class right after "page-sidebar-menu" to enable hoverable(hover vs accordion) sub menu mode -->
            <!-- DOC: Apply "page-sidebar-menu-closed" class right after "page-sidebar-menu" to collapse("page-sidebar-closed" class must be applied to the body element) the sidebar sub menu mode -->
            <!-- DOC: Set data-auto-scroll="false" to disable the sidebar from auto scrolling/focusing -->
            <!-- DOC: Set data-keep-expand="true" to keep the submenues expanded -->
            <!-- DOC: Set data-auto-speed="200" to adjust the sub menu slide up/down speed -->
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
                                <span class="caption-subject bold font-grey-gallery uppercase"> 菜单列表 </span>
                                <span class="caption-helper"></span>
                            </div>
                            <div class="tools">
                                <a href="" class="fullscreen"> </a>
                            </div>
                        </div>
                        <div class="portlet-body">
                            <sys:message content="${message}"/>
                            <div class="row" style="margin-bottom: 10px;">
                                <div class="col-md-12">
                                    <shiro:hasPermission name="sys:menu:add">
                                        <table:addRow url="${ctx}/sys/menu/form" title="菜单"></table:addRow><!-- 增加按钮 -->
                                    </shiro:hasPermission>
                                    <shiro:hasPermission name="sys:menu:edit">
                                        <table:editRow url="${ctx}/sys/menu/form" id="treeTable" title="菜单"></table:editRow><!-- 编辑按钮 -->
                                    </shiro:hasPermission>
                                    <shiro:hasPermission name="sys:menu:del">
                                        <table:delRow url="${ctx}/sys/menu/deleteAll" id="treeTable"></table:delRow><!-- 删除按钮 -->
                                    </shiro:hasPermission>
                                    <shiro:hasPermission name="sys:menu:updateSort">
                                        <button id="btnSubmit" class="btn btn-default btn-sm" data-toggle="tooltip" data-placement="left" onclick="updateSort()" title="保存排序"><i class="fa fa-save"></i> 保存排序</button>
                                    </shiro:hasPermission>
                                    <button class="btn btn-default btn-sm " data-toggle="tooltip" data-placement="left" onclick="refresh()" title="刷新"><i class="fa fa-repeat"></i> 刷新</button>
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-md-12">
                                    <form id="listForm" method="post">
                                        <div class="table-scrollable">
                                            <table id="treeTable" class="table table-striped table-bordered table-hover table-checkable">
                                                <thead>
                                                <tr>
                                                    <th>
                                                        <label class="mt-checkbox mt-checkbox-single mt-checkbox-outline">
                                                            <input type="checkbox" class="group-checkable" data-set=".checkboxes" />
                                                            <span></span>
                                                        </label>
                                                    </th>
                                                    <th>名称</th>
                                                    <th>链接</th>
                                                    <th>排序</th>
                                                    <th>可见</th>
                                                    <th>权限标识</th>
                                                    <shiro:hasPermission name="sys:menu:edit">
                                                        <th>操作</th>
                                                    </shiro:hasPermission>
                                                </tr>
                                                </thead>
                                                <tbody>
                                                <c:forEach items="${list}" var="menu">
                                                    <tr id="${menu.id}" pId="${menu.parent.id ne '1'?menu.parent.id:'0'}">
                                                        <td>
                                                            <label class="mt-checkbox mt-checkbox-single mt-checkbox-outline">
                                                                <input type="checkbox" class="checkboxes i-checks" id="${menu.id}" />
                                                                <span></span>
                                                            </label>
                                                        </td>
                                                        <td nowrap><i class="${not empty menu.icon?menu.icon:' hide'}"></i>&nbsp;<a  href="#" onclick="openDialogView('查看菜单', '${ctx}/sys/menu/form?id=${menu.id}','900px', '600px')">${menu.name}</a></td>
                                                        <td title="${menu.href}">${fns:abbr(menu.href,30)}</td>
                                                        <td>
                                                            <shiro:hasPermission name="sys:menu:updateSort">
                                                                <input type="hidden" name="ids" value="${menu.id}"/>
                                                                <input name="sorts" type="text" value="${menu.sort}" class="form-control" style="width:100px;margin:0;padding:0;text-align:center;">
                                                            </shiro:hasPermission><shiro:lacksPermission name="sys:menu:updateSort">
                                                            ${menu.sort}
                                                        </shiro:lacksPermission>
                                                        </td>
                                                        <td>${menu.isShow eq '1'?'显示':'隐藏'}</td>
                                                        <td title="${menu.permission}">${fns:abbr(menu.permission,30)}</td>
                                                        <td nowrap>
                                                            <shiro:hasPermission name="sys:menu:view">
                                                                <a href="#" onclick="openDialogView('查看菜单', '${ctx}/sys/menu/form?id=${menu.id}','900px', '600px')" class="btn btn-info btn-xs" ><i class="fa fa-search-plus"></i> 查看</a>
                                                            </shiro:hasPermission>
                                                            <shiro:hasPermission name="sys:menu:edit">
                                                                <a href="#" onclick="openDialog('修改菜单', '${ctx}/sys/menu/form?id=${menu.id}','900px', '600px')" class="btn btn-success btn-xs" ><i class="fa fa-edit"></i> 修改</a>
                                                            </shiro:hasPermission>
                                                            <shiro:hasPermission name="sys:menu:del">
                                                                <a href="${ctx}/sys/menu/delete?id=${menu.id}" onclick="return confirmx('要删除该菜单及所有子菜单项吗？', this.href)" class="btn btn-danger btn-xs" ><i class="fa fa-trash"></i> 删除</a>
                                                            </shiro:hasPermission>
                                                            <shiro:hasPermission name="sys:menu:add">
                                                                <a href="#" onclick="openDialog('添加下级菜单', '${ctx}/sys/menu/form?parent.id=${menu.id}','900px', '600px')" class="btn btn-primary btn-xs" ><i class="fa fa-plus"></i> 添加下级菜单</a>
                                                            </shiro:hasPermission>
                                                        </td>
                                                    </tr>
                                                </c:forEach>
                                                </tbody>
                                            </table>
                                        </div>
                                    </form>
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
<script>
    $(function () {
        $("#treeTable").treeTable({expandLevel: 1, column: 1}).show();
    });

    // 刷新
    function refresh(){
        window.location="${ctx}/sys/menu/";
    }

    // 保存排序
    function updateSort() {
        loading('正在提交，请稍等...');
        $("#listForm").attr("action", "${ctx}/sys/menu/updateSort");
        $("#listForm").submit();
    }
</script>
</body>
</html>