<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/views/include/taglib.jsp" %>

<!DOCTYPE html>
<!--[if IE 8]> <html lang="zh" class="ie8 no-js"> <![endif]-->
<!--[if IE 9]> <html lang="zh" class="ie9 no-js"> <![endif]-->
<!--[if !IE]><!-->
<html>
<!--<![endif]-->
<!-- BEGIN HEAD -->
<head>
    <title>${fns:getConfig('productName')} | 邮箱配置</title>
    <meta name="decorator" content="default" />
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
                                <span class="caption-subject bold font-grey-gallery uppercase"> 邮箱配置 </span>
                                <span class="caption-helper"></span>
                            </div>
                            <div class="tools">
                                <a href="" class="fullscreen"> </a>
                            </div>
                        </div>
                        <div class="portlet-body">
                            <form:form id="inputForm" modelAttribute="configMail" method="post" class="form-horizontal">
                                <form:hidden path="id" />
                                <sys:message content="${message}" />

                                <table class="table table-striped table-bordered table-hover">
                                    <tbody>
                                    <tr>
                                        <td class="active" style="width: 10%;">
                                            <label class="pull-right"><span style="color: #E7505A;"> * </span>主机名：</label>
                                        </td>
                                        <td colspan="3">
                                            <form:input path="mailHost" htmlEscape="false" maxlength="100" class="form-control required" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="active">
                                            <label class="pull-right"><span style="color: #E7505A;"> * </span>主机端口：</label>
                                        </td>
                                        <td colspan="3">
                                            <form:input path="mailPort" htmlEscape="false" maxlength="11" class="form-control required digits" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="active">
                                            <label class="pull-right"><span style="color: #E7505A;"> * </span>邮箱地址：</label>
                                        </td>
                                        <td colspan="3">
                                            <form:input path="mailUsername" htmlEscape="false" maxlength="100" class="form-control required" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="active">
                                            <label class="pull-right"><span style="color: #E7505A;"> * </span>邮箱密码：</label>
                                        </td>
                                        <td colspan="3">
                                            <form:input type="password" path="mailPassword" htmlEscape="false" maxlength="100" class="form-control required" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="active">
                                            <label class="pull-right"><span style="color: #E7505A;"> * </span>发件人昵称：</label>
                                        </td>
                                        <td colspan="3">
                                            <form:input path="mailFrom" htmlEscape="false" maxlength="100" class="form-control required" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="active">
                                            <label class="pull-right"><span style="color: #E7505A;"> * </span>使用SSL/TLS：</label>
                                        </td>
                                        <td colspan="3">
                                            <form:select path="mailSsl" class="form-control required">
                                                <form:options items="${fns:getDictList('yes_no')}" itemLabel="label" itemValue="value" htmlEscape="false" />
                                            </form:select>
                                        </td>
                                    </tr>
                                    </tbody>
                                </table>

                                <div class="form-actions pull-right">
                                    <shiro:hasPermission name="config:configMail:edit">
                                        <button class="btn btn-primary btn-sm" type="submit" onclick="saveMail();">保存</button>
                                        <button class="btn btn-danger btn-sm" type="submit" onclick="saveAndTestMail();">保存并测试</button>
                                    </shiro:hasPermission>
                                </div>
                                <div class="clearfix"></div>
                            </form:form>
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
    function saveMail() {
        $("#inputForm").attr("action", "${ctx}/config/configMail/save");
    }

    function saveAndTestMail() {
        $("#inputForm").attr("action", "${ctx}/config/configMail/sendTestMail");
    }

    $(document).ready(function () {
        var validateForm = $("#inputForm").validate({
            errorElement: 'span',
            errorClass: 'help-inline border-red font-red',
            focusInvalid: false,
            errorContainer: "#messageBox",

            submitHandler: function (form) {
                loading('正在提交，请稍等...');
                form.submit();
            },

            errorPlacement: function (error, element) {
                $("#messageBox").text("输入有误，请先更正。");
                if (element.is(":checkbox") || element.is(":radio") || element.parent().is(".input-append")) {
                    error.appendTo(element.parent().parent());
                } else {
                    error.insertAfter(element);
                }
            }
        });
    });
</script>
</body>
</html>