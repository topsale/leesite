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
    <title>${fns:getConfig('productName')} | 柱状图案例</title>
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
                                <span class="caption-subject bold font-grey-gallery uppercase"> 柱状图案例 </span>
                                <span class="caption-helper"></span>
                            </div>
                            <div class="tools">
                                <a href="" class="fullscreen"> </a>
                            </div>
                        </div>
                        <div class="portlet-body">
                            单轴：
                            <div id="line_normal" class="main000"></div>
                            <echarts:bar
                                    id="line_normal"
                                    title="短期预测数据对比曲线"
                                    subtitle="短期预测数据对比曲线"
                                    xAxisData="${xAxisData}"
                                    yAxisData="${yAxisData}"
                                    xAxisName="预测时间"
                                    yAxisName="实际电量(MW)"
                            />

                            双轴：
                            <div id="line_yAxisIndex" class="main000"></div>
                            <echarts:bar
                                    id="line_yAxisIndex"
                                    title="短期预测数据对比曲线"
                                    subtitle="短期预测数据对比曲线"
                                    xAxisData="${xAxisData}"
                                    yAxisData="${yAxisData}"
                                    xAxisName="预测时间"
                                    yAxisName="实际电量(MW),实际总辐射(w/㎡)"
                                    yAxisIndex="${yAxisIndex}"/>
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
