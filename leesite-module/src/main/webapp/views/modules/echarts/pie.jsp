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
    <title>${fns:getConfig('productName')} | 饼图案例</title>
    <meta name="decorator" content="default"/>
    <%@ include file="/views/include/echarts.jsp"%>
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
                <t:menu menu="${fns:getTopMenu()}" parentName="统计报表" currentName="饼图"></t:menu>
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
                                <span class="caption-subject bold font-grey-gallery uppercase"> 饼图案例 </span>
                                <span class="caption-helper"></span>
                            </div>
                            <div class="tools">
                                <a href="" class="fullscreen"> </a>
                            </div>
                        </div>
                        <div class="portlet-body">
                            <div id="pie" class="main000"></div>
                            <echarts:pie
                                    id="pie"
                                    title="某站点用户访问来源"
                                    subtitle="纯属虚构"
                                    orientData="${orientData}" />
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
