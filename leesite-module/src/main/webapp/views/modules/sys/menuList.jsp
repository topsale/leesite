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
    <meta charset="utf-8" />
    <title>${fns:getConfig('productName')} | 菜单管理</title>
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta content="width=device-width, initial-scale=1" name="viewport" />

    <!-- BEGIN REQUIRE TOP -->
    <script src="${ctxStatic}/assets/global/plugins/jquery.min.js" type="text/javascript"></script>
    <script src="${ctxStatic}/assets/global/plugins/jquery-migrate.min.js" type="text/javascript"></script>
    <link href="${ctxStatic}/assets/global/plugins/jquery-jbox/2.3/Skins/Bootstrap/jbox.min.css" rel="stylesheet" />
    <script src="${ctxStatic}/assets/global/plugins/jquery-jbox/2.3/jquery.jBox-2.3.min.js" type="text/javascript"></script>
    <!-- END REQUIRE TOP -->

    <%@include file="/views/include/treetable.jsp" %>

    <!-- BEGIN GLOBAL MANDATORY STYLES -->
    <link href="${ctxStatic}/assets/global/plugins/font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css" />
    <link href="${ctxStatic}/assets/global/plugins/simple-line-icons/simple-line-icons.min.css" rel="stylesheet" type="text/css" />
    <link href="${ctxStatic}/assets/global/plugins/bootstrap/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
    <link href="${ctxStatic}/assets/global/plugins/bootstrap-switch/css/bootstrap-switch.min.css" rel="stylesheet" type="text/css" />
    <!-- END GLOBAL MANDATORY STYLES -->
    <!-- BEGIN PAGE LEVEL PLUGINS -->
    <link href="${ctxStatic}/assets/global/plugins/morris/morris.css" rel="stylesheet" type="text/css" />
    <link href="${ctxStatic}/assets/global/plugins/datatables/datatables.min.css" rel="stylesheet" type="text/css" />
    <link href="${ctxStatic}/assets/global/plugins/datatables/plugins/bootstrap/datatables.bootstrap.css" rel="stylesheet" type="text/css" />
    <!-- END PAGE LEVEL PLUGINS -->
    <!-- BEGIN THEME GLOBAL STYLES -->
    <link href="${ctxStatic}/assets/global/css/components-rounded.min.css" rel="stylesheet" id="style_components" type="text/css" />
    <link href="${ctxStatic}/assets/global/css/plugins.min.css" rel="stylesheet" type="text/css" />
    <!-- END THEME GLOBAL STYLES -->
    <!-- BEGIN THEME LAYOUT STYLES -->
    <link href="${ctxStatic}/assets/layouts/layout4/css/layout.min.css" rel="stylesheet" type="text/css" />
    <link href="${ctxStatic}/assets/layouts/layout4/css/themes/default.min.css" rel="stylesheet" type="text/css" id="style_color" />
    <link href="${ctxStatic}/assets/layouts/layout4/css/custom.css" rel="stylesheet" type="text/css" />
    <!-- END THEME LAYOUT STYLES -->

    <link rel="shortcut icon" href="${ctxStatic}/favicon.ico" />
</head>

<body class="page-container-bg-solid page-header-fixed page-sidebar-closed-hide-logo">
<!-- BEGIN HEADER -->
<div class="page-header navbar navbar-fixed-top">
    <!-- BEGIN HEADER INNER -->
    <div class="page-header-inner">
        <!-- BEGIN LOGO -->
        <div class="page-logo">
            <a href="${ctx}" style="text-decoration:none; margin-top: -2px;">
                <h4 class="logo-default font-white bold">${fns:getConfig('productName')}</h4>
            </a>
            <div class="menu-toggler sidebar-toggler">
                <!-- DOC: Remove the above "hide" to enable the sidebar toggler button on header -->
            </div>
        </div>
        <!-- END LOGO -->
        <!-- BEGIN RESPONSIVE MENU TOGGLER -->
        <a href="javascript:;" class="menu-toggler responsive-toggler" data-toggle="collapse" data-target=".navbar-collapse"> </a>
        <!-- END RESPONSIVE MENU TOGGLER -->
        <!-- BEGIN PAGE TOP -->
        <div class="page-top">
            <!-- BEGIN HEADER SEARCH BOX -->
            <!-- DOC: Apply "search-form-expanded" right after the "search-form" class to have half expanded search box -->
            <form class="search-form" action="${ctx}" method="GET">
                <div class="input-group">
                    <input type="text" class="form-control input-sm" placeholder="搜索..." name="query">
                    <span class="input-group-btn">
                                <a href="javascript:;" class="btn submit">
                                    <i class="icon-magnifier"></i>
                                </a>
                            </span>
                </div>
            </form>
            <!-- END HEADER SEARCH BOX -->
            <!-- BEGIN TOP NAVIGATION MENU -->
            <div class="top-menu">
                <ul class="nav navbar-nav pull-right">
                    <li class="separator hide"> </li>
                    <!-- BEGIN NOTIFICATION DROPDOWN -->
                    <!-- DOC: Apply "dropdown-dark" class after below "dropdown-extended" to change the dropdown styte -->
                    <!-- DOC: Apply "dropdown-hoverable" class after "dropdown" and remove data-toggle="dropdown" data-hover="dropdown" data-close-others="true" attributes to enable hover dropdown mode -->
                    <!-- DOC: Remove "dropdown-hoverable" and add data-toggle="dropdown" data-hover="dropdown" data-close-others="true" attributes to the below A element with dropdown-toggle class -->
                    <li class="dropdown dropdown-extended dropdown-notification dropdown-dark" id="header_notification_bar">
                        <a href="javascript:;" class="dropdown-toggle" data-toggle="dropdown" data-hover="dropdown" data-close-others="true">
                            <i class="icon-bell"></i>
                            <span class="badge badge-success"> ${fns:noReadNotifyCount()} </span>
                        </a>
                        <ul class="dropdown-menu">
                            <li class="external">
                                <h3>您有
                                    <span class="bold">${fns:noReadNotifyCount()} 条</span> 未读消息</h3>
                                <a href="${ctx}">全部</a>
                            </li>
                        </ul>
                    </li>
                    <!-- END NOTIFICATION DROPDOWN -->
                    <li class="separator hide"> </li>
                    <!-- BEGIN INBOX DROPDOWN -->
                    <!-- DOC: Apply "dropdown-dark" class after below "dropdown-extended" to change the dropdown styte -->
                    <li class="dropdown dropdown-extended dropdown-inbox dropdown-dark" id="header_inbox_bar">
                        <a href="javascript:;" class="dropdown-toggle" data-toggle="dropdown" data-hover="dropdown" data-close-others="true">
                            <i class="icon-envelope-open"></i>
                            <span class="badge badge-danger"> ${fns:noReadMailCount()} </span>
                        </a>
                        <ul class="dropdown-menu">
                            <li class="external">
                                <h3>您有
                                    <span class="bold">${fns:noReadMailCount()} 条</span> 未读邮件</h3>
                                <a href="app_inbox.html">全部</a>
                            </li>
                        </ul>
                    </li>
                    <!-- END INBOX DROPDOWN -->
                    <!-- BEGIN USER LOGIN DROPDOWN -->
                    <!-- DOC: Apply "dropdown-dark" class after below "dropdown-extended" to change the dropdown styte -->
                    <li class="dropdown dropdown-user dropdown-dark">
                        <a href="javascript:;" class="dropdown-toggle" data-toggle="dropdown" data-hover="dropdown" data-close-others="true">
                            <span class="username username-hide-on-mobile"> ${fns:getUser().name} </span>
                            <!-- DOC: Do not remove below empty space(&nbsp;) as its purposely used -->
                            <c:choose>
                                <c:when test="${not empty fns:getUser().photo}">
                                    <img alt="" class="img-circle" src="${fns:getUser().photo}" />
                                </c:when>
                                <c:otherwise>
                                    <img alt="" class="img-circle" src="${ctxStatic}/assets/layouts/layout/img/avatar.png" />
                                </c:otherwise>
                            </c:choose>
                        </a>
                        <ul class="dropdown-menu dropdown-menu-default">
                            <li>
                                <a href="app_calendar.html">
                                    <i class="icon-picture"></i> 修改头像 </a>
                            </li>
                            <li>
                                <a href="page_user_profile_1.html">
                                    <i class="icon-user"></i> 我的资料 </a>
                            </li>
                            <li>
                                <a href="app_inbox.html">
                                    <i class="icon-envelope-open"></i> 我的信箱
                                    <span class="badge badge-danger"> ${fns:noReadMailCount()} </span>
                                </a>
                            </li>
                            <li>
                                <a href="app_todo_2.html">
                                    <i class="icon-notebook"></i> 我的通讯录
                                </a>
                            </li>
                            <li class="divider"> </li>
                            <li>
                                <a href="${ctx}/logout">
                                    <i class="icon-key"></i> 安全退出 </a>
                            </li>
                        </ul>
                    </li>
                    <!-- END USER LOGIN DROPDOWN -->
                </ul>
            </div>
            <!-- END TOP NAVIGATION MENU -->
        </div>
        <!-- END PAGE TOP -->
    </div>
    <!-- END HEADER INNER -->
</div>
<!-- END HEADER -->
<!-- BEGIN HEADER & CONTENT DIVIDER -->
<div class="clearfix"> </div>
<!-- END HEADER & CONTENT DIVIDER -->
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
                                        <button id="btnSubmit" class="btn btn-default btn-sm " data-toggle="tooltip" data-placement="left" onclick="updateSort()" title="保存排序"><i class="fa fa-save"></i> 保存排序</button>
                                    </shiro:hasPermission>
                                    <button class="btn btn-default btn-sm " data-toggle="tooltip" data-placement="left" onclick="refresh()" title="刷新"><i class="fa fa-repeat"></i> 刷新</button>
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-md-12">
                                    <form id="listForm" method="post">
                                        <table id="treeTable" class="table table-striped table-bordered table-hover dataTable">
                                            <thead>
                                            <tr>
                                                <th><input type="checkbox" class="i-checks"></th>
                                                <th>名称</th>
                                                <th>链接</th>
                                                <th style="text-align:center;">排序</th>
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
                                                    <td> <input type="checkbox" id="${menu.id}" class="i-checks"></td>
                                                    <td nowrap><i class="icon-${not empty menu.icon?menu.icon:' hide'}"></i><a  href="#" onclick="openDialogView('查看菜单', '${ctx}/sys/menu/form?id=${menu.id}','800px', '500px')">${menu.name}</a></td>
                                                    <td title="${menu.href}">${fns:abbr(menu.href,30)}</td>
                                                    <td style="text-align:center;">
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
                                                            <a href="#" onclick="openDialogView('查看菜单', '${ctx}/sys/menu/form?id=${menu.id}','800px', '500px')" class="btn btn-info btn-xs" ><i class="fa fa-search-plus"></i> 查看</a>
                                                        </shiro:hasPermission>
                                                        <shiro:hasPermission name="sys:menu:edit">
                                                            <a href="#" onclick="openDialog('修改菜单', '${ctx}/sys/menu/form?id=${menu.id}','800px', '500px')" class="btn btn-success btn-xs" ><i class="fa fa-edit"></i> 修改</a>
                                                        </shiro:hasPermission>
                                                        <shiro:hasPermission name="sys:menu:del">
                                                            <a href="${ctx}/sys/menu/delete?id=${menu.id}" onclick="return confirmx('要删除该菜单及所有子菜单项吗？', this.href)" class="btn btn-danger btn-xs" ><i class="fa fa-trash"></i> 删除</a>
                                                        </shiro:hasPermission>
                                                        <shiro:hasPermission name="sys:menu:add">
                                                            <a href="#" onclick="openDialog('添加下级菜单', '${ctx}/sys/menu/form?parent.id=${menu.id}','800px', '500px')" class="btn btn-primary btn-xs" ><i class="fa fa-plus"></i> 添加下级菜单</a>
                                                        </shiro:hasPermission>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                            </tbody>
                                        </table>
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

<!--[if lt IE 9]>
<script src="${ctxStatic}/assets/global/plugins/respond.min.js"></script>
<script src="${ctxStatic}/assets/global/plugins/excanvas.min.js"></script>
<script src="${ctxStatic}/assets/global/plugins/ie8.fix.min.js"></script>
<![endif]-->
<!-- BEGIN CORE PLUGINS -->
<script src="${ctxStatic}/assets/global/plugins/bootstrap/js/bootstrap.min.js" type="text/javascript"></script>
<script src="${ctxStatic}/assets/global/plugins/js.cookie.min.js" type="text/javascript"></script>
<script src="${ctxStatic}/assets/global/plugins/jquery-slimscroll/jquery.slimscroll.min.js" type="text/javascript"></script>
<script src="${ctxStatic}/assets/global/plugins/jquery.blockui.min.js" type="text/javascript"></script>
<script src="${ctxStatic}/assets/global/plugins/bootstrap-switch/js/bootstrap-switch.min.js" type="text/javascript"></script>
<!-- END CORE PLUGINS -->
<!-- BEGIN PAGE LEVEL PLUGINS -->
<script src="${ctxStatic}/assets/global/plugins/morris/morris.min.js" type="text/javascript"></script>
<script src="${ctxStatic}/assets/global/plugins/morris/raphael-min.js" type="text/javascript"></script>
<script src="${ctxStatic}/assets/global/scripts/datatable.js" type="text/javascript"></script>
<script src="${ctxStatic}/assets/global/plugins/datatables/datatables.min.js" type="text/javascript"></script>
<script src="${ctxStatic}/assets/global/plugins/datatables/plugins/bootstrap/datatables.bootstrap.js" type="text/javascript"></script>
<!-- END PAGE LEVEL PLUGINS -->
<!-- BEGIN THEME GLOBAL SCRIPTS -->
<script src="${ctxStatic}/assets/global/scripts/app.min.js" type="text/javascript"></script>
<!-- END THEME GLOBAL SCRIPTS -->
<!-- BEGIN PAGE LEVEL SCRIPTS -->
<script src="${ctxStatic}/assets/pages/scripts/dashboard.min.js" type="text/javascript"></script>
<!-- END PAGE LEVEL SCRIPTS -->
<!-- BEGIN THEME LAYOUT SCRIPTS -->
<script src="${ctxStatic}/assets/layouts/layout4/scripts/layout.min.js" type="text/javascript"></script>
<script src="${ctxStatic}/assets/layouts/layout4/scripts/demo.min.js" type="text/javascript"></script>
<script src="${ctxStatic}/assets/layouts/global/scripts/quick-sidebar.min.js" type="text/javascript"></script>
<script src="${ctxStatic}/assets/layouts/global/scripts/quick-nav.min.js" type="text/javascript"></script>
<!-- END THEME LAYOUT SCRIPTS -->

<script>
    $(function () {
        $("#treeTable").treeTable({expandLevel: 2, column: 1}).show();
    });
</script>
</body>
</html>