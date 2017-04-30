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
    <title>${fns:getConfig('productName')} | 菜单管理</title>
    <meta name="decorator" content="form"/>
</head>

<body style="background: white;">
<div class="form-body">
    <!-- BEGIN FORM-->
    <form:form id="inputForm" modelAttribute="menu" action="${ctx}/sys/menu/save" method="post" class="form-horizontal" cssStyle="padding: 5px;">
        <form:hidden path="id"/>
        <sys:message content="${message}"/>

        <table class="table table-striped table-bordered table-hover">
            <tbody>
            <tr>
                <td class="active" style="width: 10%;">
                    <label class="pull-right">上级菜单：</label>
                </td>
                <td style="width: 40%;">
                    <sys:treeselect id="menu" name="parent.id" value="${menu.parent.id}" labelName="parent.name" labelValue="${menu.parent.name}" title="菜单" url="/sys/menu/treeData" extId="${menu.id}" cssClass="form-control required"/>
                </td>
                <td class="active" style="width: 10%;">
                    <label class="pull-right"> <span style="color: #E7505A;"> * </span>名称：</label>
                </td>
                <td style="width: 40%;">
                    <form:input path="name" htmlEscape="false" maxlength="50" class="required form-control"/>
                </td>
            </tr>
            <tr>
                <td class="active">
                    <label class="pull-right">链接：</label>
                </td>
                <td>
                    <form:input path="href" htmlEscape="false" maxlength="2000" class="form-control "/>
                    <span class="help-inline">点击菜单跳转的页面</span>
                </td>
                <td class="active"><label class="pull-right">目标：</label></td>
                <td>
                    <form:input path="target" htmlEscape="false" maxlength="10" class="form-control "/>
                    <span class="help-inline">链接打开的目标窗口</span>
                </td>
            </tr>
            <tr>
                <td class="active">
                    <label class="pull-right">图标：</label>
                </td>
                <td>
                    <sys:iconselect id="icon" name="icon" value="${menu.icon}"/>
                </td>
                <td class="active">
                    <label class="pull-right"><span style="color: #E7505A;"> * </span>排序：</label>
                </td>
                <td>
                    <form:input path="sort" htmlEscape="false" maxlength="50" class="required digits form-control"/>
                    <span class="help-inline">排列顺序，升序</span>
                </td>
            </tr>
            <tr>
                <td class="active">
                    <label class="pull-right">可见：</label>
                </td>
                <td>
                    <form:radiobuttons path="isShow" items="${fns:getDictList('show_hide')}" itemLabel="label" itemValue="value" htmlEscape="false" class="required" cssStyle="margin-left: 10px;" />
                    <br />
                    <span class="help-inline" style="margin-left: 10px;">该菜单或操作是否显示到系统菜单中</span>
                </td>
                <td class="active">
                    <label class="pull-right">权限标识：</label>
                </td>
                <td>
                    <form:input path="permission" htmlEscape="false" maxlength="100" class="form-control"/>
                    <span class="help-inline">控制器中定义的权限标识，如：@RequiresPermissions("权限标识")</span>
                </td>
            </tr>
            <tr>
                <td class="active">
                    <label class="pull-right">备注：</label>
                </td>
                <td colspan="3">
                    <form:textarea path="remarks" htmlEscape="false" rows="5" maxlength="200" class="form-control "/>
                </td>
            </tr>
            </tbody>
        </table>
    </form:form>
</div>

<%@include file="/views/include/foot.jsp" %>
<script type="text/javascript">
    var validateForm;
    function doSubmit() { // 回调函数，在编辑和保存动作时，供openDialog调用提交表单。
        if (validateForm.form()) {
            $("#inputForm").submit();
            return true;
        }
        return false;
    }

    $(document).ready(function () {
        validateForm = $("#inputForm").validate({
            errorElement: 'span',
            errorClass: 'help-inline border-red font-red',
            focusInvalid: false,
            errorContainer: "#messageBox",

            submitHandler: function (form) {
                loading('正在提交，请稍等...');
                form.submit();
            },
            errorPlacement: function (error, element) {
                $("#messageBox").text("输入有误，请先更正");
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