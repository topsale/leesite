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
    <title>${fns:getConfig('productName')} | 系统监控</title>
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
                <t:menu menu="${fns:getTopMenu()}" parentName="系统监控" currentName="系统监控管理"></t:menu>
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
                                <span class="caption-subject bold font-grey-gallery uppercase"> 实时监控 </span>
                                <span class="caption-helper"></span>
                            </div>
                        </div>
                        <div class="portlet-body">
                            <table style="width: 100%;">
                                <tr>
                                    <td width="33.3%">
                                        <div id="main_one" style="height: 240px;"></div>
                                    </td>
                                    <td width="33.3%">
                                        <div id="main_two" style="height: 240px;"></div>
                                    </td>
                                    <td width="33.3%">
                                        <div id="main_three" style="height: 240px;"></div>
                                    </td>
                                </tr>
                            </table>
                            <div id="main" style="height: 370px; margin-top: 20px;"></div>
                        </div>
                    </div>
                    <!-- END GRID PORTLET-->
                </div>
            </div>

            <div class="row">
                <div class="col-md-12">
                    <!-- BEGIN Portlet PORTLET-->
                    <div class="portlet light">
                        <div class="portlet-title">
                            <div class="caption">
                                <span class="caption-subject bold font-grey-gallery uppercase"> 警告设置 </span>
                                <span class="caption-helper"></span>
                            </div>
                        </div>
                        <div class="portlet-body">
                            <div class="table-scrollable">
                                <table id="contentTable" class="table table-striped table-bordered table-hover">
                                    <thead>
                                    <tr style="background-color: #FAEBCC; text-align: center;">
                                        <td width="100">名称</td>
                                        <td width="100">参数</td>
                                        <td width="205">预警设置</td>
                                        <td width="375">邮箱设置</td>
                                    </tr>
                                    </thead>
                                    <tbody id="tbody">
                                    <tr>
                                        <td style='padding-left: 10px; text-align: left;vertical-align: middle;'>CPU</td>
                                        <td style='padding-left: 10px; text-align: left;vertical-align: middle;'>当前使用率：<span id="td_cpuUsage" style="color: red;">50</span> %</td>
                                        <td align="center">
                                            <table>
                                                <tr>
                                                    <td>使用率超出</td>
                                                    <td>
                                                        &nbsp;<input style="width: 50px; height: 30px; text-align: center;" name='cpu' id='cpu' type='text' value='${cpu}' />&nbsp;%，
                                                    </td>
                                                    <td>发送邮箱提示 <a class='btn btn-info btn-sm' href='javascript:void(0)' onclick='modifySer("cpu");'>修改 </a></td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td rowspan='3' align="center" style="vertical-align: middle;">
                                            <input style="width: 250px; height: 30px; text-align: center;" name='toEmail' id='toEmail' type='text' value='${toEmail}' />
                                            <a style="margin-top: -5px;" class='btn btn-info btn-sm' href='javascript:void(0)' onclick='modifySer("toEmail");'>修改 </a>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style='padding-left: 10px; text-align: left;vertical-align: middle;'>服务器内存</td>
                                        <td style='padding-left: 10px; text-align: left;vertical-align: middle;'>当前使用率：<span id="td_serverUsage" style="color: blue;">50</span> %</td>
                                        <td align="center">
                                            <table>
                                                <tr>
                                                    <td>使用率超出</td>
                                                    <td>
                                                        &nbsp;<input style="width: 50px; height: 30px; text-align: center;" name='ram' id='ram' type='text' value='${ram}' />&nbsp;%，
                                                    </td>
                                                    <td>发送邮箱提示 <a class='btn btn-info btn-sm' href='javascript:void(0)' onclick='modifySer("ram");'>修改 </a></td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style='padding-left: 10px; text-align: left;vertical-align: middle;'>JVM内存</td>
                                        <td style='padding-left: 10px; text-align: left;vertical-align: middle;'>当前使用率：<span id="td_jvmUsage" style="color: green;">50</span> %
                                        </td>
                                        <td align="center">
                                            <table>
                                                <tr>
                                                    <td>使用率超出</td>
                                                    <td>
                                                        &nbsp;<input style="width: 50px; height: 30px; text-align: center;" name='jvm' id='jvm' type='text' value='${jvm}' />&nbsp;%，
                                                    </td>
                                                    <td>发送邮箱提示 <a class='btn btn-info btn-sm' href='javascript:void(0)' onclick='modifySer("jvm");'>修改 </a></td>
                                                </tr>
                                            </table>
                                    </tr>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                    <!-- END GRID PORTLET-->
                </div>
            </div>

            <div class="row">
                <div class="col-md-12">
                    <!-- BEGIN Portlet PORTLET-->
                    <div class="portlet light">
                        <div class="portlet-title">
                            <div class="caption">
                                <span class="caption-subject bold font-grey-gallery uppercase"> 服务器信息 </span>
                                <span class="caption-helper"></span>
                            </div>
                        </div>
                        <div class="portlet-body">
                            <iframe src="${ctx}/monitor/systemInfo" width="100%" height="300" frameborder="0" scrolling="no"></iframe>
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
<script src="${ctxStatic}/assets/global/plugins/echarts/echarts-all.js"></script>
<script src="${ctxStatic}/assets/global/scripts/systemInfo.js"></script>
<script type="text/javascript">
    function modifySer(key) {
        $.ajax({
            async: false,
            url: "${ctx}/monitor/modifySetting?" + key + "=" + $("#" + key).val(),
            dataType: "json",
            success: function (data) {
                if (data.success) {
                    alert("更新成功！");
                } else {
                    alert("更新失败！");
                }
            }
        });
    }
</script>
</body>
</html>