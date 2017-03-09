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
    <title>${fns:getConfig('productName')}</title>
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta content="width=device-width, initial-scale=1" name="viewport" />

    <!-- BEGIN REQUIRE TOP -->
    <script src="${ctxStatic}/assets/global/plugins/jquery.min.js" type="text/javascript"></script>
    <script src="${ctxStatic}/assets/global/plugins/jquery-migrate.min.js" type="text/javascript"></script>
    <link href="${ctxStatic}/assets/global/plugins/jquery-jbox/2.3/Skins/Bootstrap/jbox.min.css" rel="stylesheet" />
    <script src="${ctxStatic}/assets/global/plugins/jquery-jbox/2.3/jquery.jBox-2.3.min.js" type="text/javascript"></script>
    <!-- END REQUIRE TOP -->

    <!-- BEGIN GLOBAL MANDATORY STYLES -->
    <link href="${ctxStatic}/assets/global/plugins/font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css" />
    <link href="${ctxStatic}/assets/global/plugins/simple-line-icons/simple-line-icons.min.css" rel="stylesheet" type="text/css" />
    <link href="${ctxStatic}/assets/global/plugins/bootstrap/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
    <link href="${ctxStatic}/assets/global/plugins/bootstrap-switch/css/bootstrap-switch.min.css" rel="stylesheet" type="text/css" />
    <!-- END GLOBAL MANDATORY STYLES -->
    <!-- BEGIN PAGE LEVEL PLUGINS -->
    <link href="${ctxStatic}/assets/global/plugins/morris/morris.css" rel="stylesheet" type="text/css" />
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
                                <span class="badge badge-success"> ${count} </span>
                            </a>
                            <ul class="dropdown-menu">
                                <li class="external">
                                    <h3>您有
                                        <span class="bold">${count} 条</span> 未读消息</h3>
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
                                <span class="badge badge-danger"> ${noReadCount} </span>
                            </a>
                            <ul class="dropdown-menu">
                                <li class="external">
                                    <h3>您有
                                        <span class="bold">${noReadCount} 条</span> 未读邮件</h3>
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
                                        <span class="badge badge-danger"> ${noReadCount} </span>
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
</body>
</html>