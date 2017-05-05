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
    <title>${fns:getConfig('productName')} | 代码生成</title>
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
                                <span class="caption-subject bold font-grey-gallery uppercase"> 生成方案${not empty genScheme.id?'修改':'添加'} </span>
                                <span class="caption-helper"></span>
                            </div>
                            <div class="tools">
                                <a href="" class="fullscreen"> </a>
                            </div>
                        </div>
                        <div class="portlet-body">
                            <form:form id="inputForm" modelAttribute="genScheme" action="${ctx}/gen/genScheme/save" method="post" class="form-horizontal">
                                <form:hidden path="id"/>
                                <form:hidden path="flag"/>
                                <sys:message content="${message}"/>

                                <table class="table table-striped table-bordered table-hover">
                                    <tbody>
                                    <tr>
                                        <td class="active" style="width: 10%;">
                                            <label class="pull-right"> <span style="color: #E7505A;"> * </span>方案名称：</label>
                                        </td>
                                        <td>
                                            <form:input path="name" htmlEscape="false" maxlength="200" class="form-control required"/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="active">
                                            <label class="pull-right"> <span style="color: #E7505A;"> * </span>模板分类：</label>
                                        </td>
                                        <td>
                                            <form:select path="category" class="form-control required">
                                                <form:options items="${config.categoryList}" itemLabel="label" itemValue="value" htmlEscape="false"/>
                                            </form:select>
                                            <span class="help-inline">
                                                生成结构：{包名}/{模块名}/{分层(dao,entity,service,web)}/{子模块名}/{java类}
                                            </span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="active">
                                            <label class="pull-right"> <span style="color: #E7505A;"> * </span>生成包路径：</label>
                                        </td>
                                        <td>
                                            <form:input path="packageName" htmlEscape="false" maxlength="500" class="form-control required"/>
                                            <span class="help-inline">建议模块包：com.funtl.leesite.modules</span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="active">
                                            <label class="pull-right"> <span style="color: #E7505A;"> * </span>生成模块名：</label>
                                        </td>
                                        <td>
                                            <form:input path="moduleName" htmlEscape="false" maxlength="500" class="form-control required"/>
                                            <span class="help-inline">可理解为子系统名，例如 sys</span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="active">
                                            <label class="pull-right"> 生成子模块名：</label>
                                        </td>
                                        <td>
                                            <form:input path="subModuleName" htmlEscape="false" maxlength="500" class="form-control"/>
                                            <span class="help-inline">可选，分层下的文件夹 </span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="active">
                                            <label class="pull-right"> <span style="color: #E7505A;"> * </span>生成功能描述：</label>
                                        </td>
                                        <td>
                                            <form:input path="functionName" htmlEscape="false" maxlength="500" class="form-control required"/>
                                            <span class="help-inline">将设置到类描述</span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="active">
                                            <label class="pull-right"> <span style="color: #E7505A;"> * </span>生成功能名：</label>
                                        </td>
                                        <td>
                                            <form:input path="functionNameSimple" htmlEscape="false" maxlength="500" class="form-control required"/>
                                            <span class="help-inline">用作功能提示，如：保存“某某”成功</span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="active">
                                            <label class="pull-right"> <span style="color: #E7505A;"> * </span>生成功能作者：</label>
                                        </td>
                                        <td>
                                            <form:input path="functionAuthor" htmlEscape="false" maxlength="500" class="form-control required"/>
                                            <span class="help-inline">功能开发者</span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="active">
                                            <label class="pull-right"> <span style="color: #E7505A;"> * </span>业务表名：</label>
                                        </td>
                                        <td>
                                            <form:select path="genTable.id" class="form-control required">
                                                <form:options items="${tableList}" itemLabel="nameAndComments" itemValue="id" htmlEscape="false"/>
                                            </form:select>
                                            <span class="help-inline">生成的数据表，一对多情况下请选择主表</span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="active">
                                            <label class="pull-right"> 备注：</label>
                                        </td>
                                        <td>
                                            <form:textarea path="remarks" htmlEscape="false" rows="3" maxlength="200" class="form-control"/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="active">
                                            <label class="pull-right"> 生成选项：</label>
                                        </td>
                                        <td>
                                            <form:checkbox path="replaceFile" label="是否替换现有文件" cssClass="icheck" />
                                        </td>
                                    </tr>
                                    </tbody>
                                </table>
                                <div class="form-actions pull-right">
                                    <shiro:hasPermission name="gen:genScheme:edit">
                                        <input id="btnSubmit" class="btn btn-primary btn-sm" type="submit" value="保存方案" onclick="$('#flag').val('0');"/>&nbsp;
                                        <input id="btnSubmit" class="btn btn-danger btn-sm" type="submit" value="保存并生成代码" onclick="$('#flag').val('1');"/>&nbsp;
                                    </shiro:hasPermission>
                                    <input id="btnCancel" class="btn btn-default btn-sm" type="button" value="返 回" onclick="history.go(-1)"/>
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
        $("#inputForm").validate({
            errorElement: 'span',
            errorClass: 'help-inline border-red font-red',
            focusInvalid: false,
            errorContainer: "#messageBox",

            submitHandler: function (form) {
                loading('正在提交，请稍等...');
                form.submit();
            },

            errorContainer: "#messageBox",
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