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
    <title>${fns:getConfig('productName')} | 机构管理</title>
    <meta name="decorator" content="form"/>
</head>

<body style="background: white;">
<div class="form-body">
    <form:form id="inputForm" modelAttribute="office" action="${ctx}/sys/office/save" method="post" class="form-horizontal" cssStyle="padding: 5px;">
        <form:hidden path="id"/>
        <sys:message content="${message}"/>

        <table class="table table-striped table-bordered table-hover">
            <tbody>
            <tr>
                <td class="active" style="width: 15%;">
                    <label class="pull-right"> 上级机构：</label>
                </td>
                <td style="width: 35%;">
                    <sys:treeselect id="office" name="parent.id" value="${office.parent.id}" labelName="parent.name" labelValue="${office.parent.name}" title="机构" url="/sys/office/treeData" extId="${office.id}"  cssClass="form-control" allowClear="${office.currentUser.admin}"/>
                </td>
                <td class="active" style="width: 15%;">
                    <label class="pull-right"> <span style="color: #E7505A;"> * </span>归属区域：</label>
                </td>
                <td style="width: 35%;">
                    <sys:treeselect id="area" name="area.id" value="${office.area.id}" labelName="area.name" labelValue="${office.area.name}" title="区域" url="/sys/area/treeData" cssClass="form-control required"/>
                </td>
            </tr>
            <tr>
                <td class="active">
                    <label class="pull-right"> <span style="color: #E7505A;"> * </span>机构名称：</label>
                </td>
                <td>
                    <form:input path="name" htmlEscape="false" maxlength="50" class="form-control required"/>
                </td>
                <td class="active">
                    <label class="pull-right"> 机构编码：</label>
                </td>
                <td>
                    <form:input path="code" htmlEscape="false" maxlength="50" class="form-control"/>
                </td>
            </tr>
            <tr>
                <td class="active">
                    <label class="pull-right"> 机构类型：</label>
                </td>
                <td>
                    <form:select path="type" class="form-control">
                        <form:options items="${fns:getDictList('sys_office_type')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
                    </form:select>
                </td>
                <td class="active">
                    <label class="pull-right"> 机构级别：</label>
                </td>
                <td>
                    <form:select path="grade" class="form-control">
                        <form:options items="${fns:getDictList('sys_office_grade')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
                    </form:select>
                </td>
            </tr>
            <tr>
                <td class="active">
                    <label class="pull-right"> 是否可用：</label>
                </td>
                <td>
                    <form:select path="useable" class="form-control">
                        <form:options items="${fns:getDictList('yes_no')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
                    </form:select>
                </td>
                <td class="active">
                    <label class="pull-right"> 主负责人：</label>
                </td>
                <td>
                    <sys:treeselect id="primaryPerson" name="primaryPerson.id" value="${office.primaryPerson.id}" labelName="office.primaryPerson.name" labelValue="${office.primaryPerson.name}" title="用户" url="/sys/office/treeData?type=3" cssClass="form-control" allowClear="true" notAllowSelectParent="true"/>
                </td>
            </tr>
            <tr>
                <td class="active">
                    <label class="pull-right"> 副负责人：</label>
                </td>
                <td>
                    <sys:treeselect id="deputyPerson" name="deputyPerson.id" value="${office.deputyPerson.id}" labelName="office.deputyPerson.name" labelValue="${office.deputyPerson.name}" title="用户" url="/sys/office/treeData?type=3" cssClass="form-control" allowClear="true" notAllowSelectParent="true"/>
                </td>
                <td class="active">
                    <label class="pull-right"> 联系地址：</label>
                </td>
                <td>
                    <form:input path="address" htmlEscape="false" maxlength="50" cssClass="form-control" />
                </td>
            </tr>
            <tr>
                <td class="active">
                    <label class="pull-right"> 邮政编码：</label>
                </td>
                <td>
                    <form:input path="zipCode" htmlEscape="false" maxlength="50" cssClass="form-control" />
                </td>
                <td class="active">
                    <label class="pull-right"> 负责人：</label>
                </td>
                <td>
                    <form:input path="master" htmlEscape="false" maxlength="50" cssClass="form-control" />
                </td>
            </tr>
            <tr>
                <td class="active">
                    <label class="pull-right"> 电话：</label>
                </td>
                <td>
                    <form:input path="phone" htmlEscape="false" maxlength="50" cssClass="form-control" />
                </td>
                <td class="active">
                    <label class="pull-right"> 传真：</label>
                </td>
                <td>
                    <form:input path="fax" htmlEscape="false" maxlength="50" cssClass="form-control" />
                </td>
            </tr>
            <tr>
                <td class="active">
                    <label class="pull-right"> 邮箱：</label>
                </td>
                <td colspan="3">
                    <form:input path="email" htmlEscape="false" maxlength="50" cssClass="form-control" />
                </td>
            </tr>
            <tr>
                <td class="active">
                    <label class="pull-right"> 备注：</label>
                </td>
                <td colspan="3">
                    <form:textarea path="remarks" htmlEscape="false" rows="5" maxlength="200" class="form-control"/>
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