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
    <title>${fns:getConfig('productName')} | 移动推送</title>
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
                <t:menu menu="${fns:getTopMenu()}" parentName="阿里云配置" currentName="移动推送"></t:menu>
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
                                <span class="caption-subject bold font-grey-gallery uppercase"> 移动推送 </span>
                                <span class="caption-helper"></span>
                            </div>
                            <div class="tools">
                                <a href="" class="fullscreen"> </a>
                            </div>
                        </div>
                        <div class="portlet-body">
                            <form:form id="inputForm" modelAttribute="configAliyunPush" action="${ctx}/aliyun/configAliyunPush/save" method="post" class="form-horizontal" cssStyle="padding: 5px;">
                                <form:hidden path="id" />
                                <sys:message content="${message}" />

                                <table class="table table-striped table-bordered table-hover">
                                    <tbody>
                                    <tr>
                                        <td class="active" style="width: 15%;"><label class="pull-right">Key：</label>
                                        </td>
                                        <td>
                                            <form:input path="accessKeyId" htmlEscape="false" maxlength="64" class="form-control " />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="active" style="width: 15%;"><label class="pull-right">Secret：</label>
                                        </td>
                                        <td>
                                            <form:input path="accessKeySecret" htmlEscape="false" maxlength="64" class="form-control " />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="active" style="width: 15%;"><label class="pull-right">AppKey：</label>
                                        </td>
                                        <td>
                                            <form:input path="appKey" htmlEscape="false" maxlength="64" class="form-control " />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="active" style="width: 15%;">
                                            <label class="pull-right">RegionId：</label>
                                        </td>
                                        <td>
                                            <form:input path="regionId" htmlEscape="false" maxlength="64" class="form-control " />
                                            <span class="help-inline font-red">注意：目前该值固定，不用动</span>
                                        </td>
                                    </tr>
                                    </tbody>
                                </table>

                                <div class="form-actions pull-right">
                                    <shiro:hasPermission name="aliyun:configAliyunPush:edit">
                                        <button class="btn btn-primary btn-sm" type="submit">保存</button>
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