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
    <title>${fns:getConfig('productName')} | 接口测试</title>
    <meta name="decorator" content="form"/>
</head>

<body style="background: white;">
<div class="form-body">
    <form:form id="inputForm" modelAttribute="testInterface" action="${ctx}/tools/testInterface/save" method="post" class="form-horizontal" cssStyle="padding: 5px;">
        <form:hidden path="id"/>
        <sys:message content="${message}"/>

        <table class="table table-striped table-bordered table-hover">
            <tbody>
            <tr>
                <td class="active" style="width: 15%;">
                    <label class="pull-right"> 接口名称：</label>
                </td>
                <td style="width: 35%;">
                    <form:input path="name" htmlEscape="false" maxlength="1024" class="form-control "/>
                </td>
                <td class="active" style="width: 15%;">
                    <label class="pull-right"> 接口类型：</label>
                </td>
                <td style="width: 35%;">
                    <form:select path="type" class="form-control ">
                        <form:option value="" label=""/>
                        <form:options items="${fns:getDictList('interface_type')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
                    </form:select>
                </td>
            </tr>
            <tr>
                <td class="active">
                    <label class="pull-right"> 请求URL：</label>
                </td>
                <td colspan="3">
                    <form:input path="url" htmlEscape="false" maxlength="256" class="form-control "/>
                </td>
            </tr>
            <tr>
                <td class="active">
                    <label class="pull-right"> 请求body：</label>
                </td>
                <td colspan="3">
                    <form:input path="body" htmlEscape="false" maxlength="2048" class="form-control "/>
                </td>
            </tr>
            <tr>
                <td class="active">
                    <label class="pull-right"> 成功时返回消息：</label>
                </td>
                <td colspan="3">
                    <form:input path="successmsg" htmlEscape="false" maxlength="512" class="form-control "/>
                </td>
            </tr>
            <tr>
                <td class="active">
                    <label class="pull-right"> 失败时返回消息：</label>
                </td>
                <td colspan="3">
                    <form:input path="errormsg" htmlEscape="false" maxlength="512" class="form-control "/>
                </td>
            </tr>
            <tr>
                <td class="active">
                    <label class="pull-right"> 备注：</label>
                </td>
                <td colspan="3">
                    <form:textarea path="remarks" htmlEscape="false" rows="5" maxlength="512" class="form-control "/>
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