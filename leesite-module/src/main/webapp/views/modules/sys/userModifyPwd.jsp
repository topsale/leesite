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
    <title>${fns:getConfig('productName')} | 修改密码</title>
    <meta name="decorator" content="form"/>
</head>

<body style="background: white;">
<div class="form-body">
    <!-- BEGIN FORM-->
    <form:form id="inputForm" modelAttribute="user" action="${ctx}/sys/user/modifyPwd" method="post" class="form-horizontal" cssStyle="padding: 5px;">
        <form:hidden path="id"/>
        <sys:message hideType="1" content="${message}"/>

        <table class="table table-striped table-bordered table-hover">
            <tbody>
            <tr>
                <td class="active" style="width: 20%;">
                    <label class="pull-right"><span style="color: #E7505A;"> * </span>旧密码：</label>
                </td>
                <td>
                    <input id="oldPassword" name="oldPassword" type="password" value="" maxlength="50" minlength="3"  class="form-control required"/>
                </td>
            </tr>
            <tr>
                <td class="active" style="width: 20%;">
                    <label class="pull-right"><span style="color: #E7505A;"> * </span>新密码：</label>
                </td>
                <td>
                    <input id="newPassword" name="newPassword" type="password" value="" maxlength="50" minlength="3" class="form-control required"/>
                </td>
            </tr>
            <tr>
                <td class="active" style="width: 20%;">
                    <label class="pull-right"><span style="color: #E7505A;"> * </span>确认密码：</label>
                </td>
                <td>
                    <input id="confirmNewPassword" name="confirmNewPassword" type="password" value="" maxlength="50" minlength="3" class="form-control required" equalTo="#newPassword" />
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

            messages: {
                confirmNewPassword: {equalTo: "两次密码输入不一致，请重新输入"}
            },

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