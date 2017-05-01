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
    <title>${fns:getConfig('productName')} | 查看通知</title>
    <meta name="decorator" content="form"/>
</head>

<body style="background: white;">
<div class="form-body">
    <form:form id="inputForm" modelAttribute="oaNotify" action="${ctx}/oa/oaNotify/save" method="post" class="form-horizontal" cssStyle="padding: 5px;">
        <form:hidden path="id"/>
        <sys:message content="${message}"/>

        <table class="table table-striped table-bordered table-hover">
            <tbody>
            <tr>
                <td class="active" style="width: 10%;">
                    <label class="pull-right"> <span style="color: #E7505A;"> * </span>类型：</label>
                </td>
                <td style="width: 40%;">
                    <form:select path="type" class="form-control required">
                        <form:option value="" label=""/>
                        <form:options items="${fns:getDictList('oa_notify_type')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
                    </form:select>
                </td>
                <td class="active" style="width: 10%;">
                    <label class="pull-right"> <span style="color: #E7505A;"> * </span>标题：</label>
                </td>
                <td style="width: 40%;">
                    <form:input path="title" htmlEscape="false" maxlength="200" class="form-control required"/>
                </td>
            </tr>
            <tr>
                <td class="active">
                    <label class="pull-right"> <span style="color: #E7505A;"> * </span>内容：</label>
                </td>
                <td colspan="3">
                    <form:textarea path="content" htmlEscape="false" rows="6" maxlength="2000" class="form-control required"/>
                </td>
            </tr>
            <tr>
                <td class="active">
                    <label class="pull-right"> 附件：</label>
                </td>
                <td colspan="3">
                    <c:if test="${oaNotify.status ne '1'}">
                        <form:hidden id="files" path="files" htmlEscape="false" maxlength="255" class="form-control"/>
                        <sys:ckfinder input="files" type="files" uploadPath="/oa/notify" selectMultiple="true"/>
                    </c:if>
                    <c:if test="${oaNotify.status eq '1'}">
                        <form:hidden id="files" path="files" htmlEscape="false" maxlength="255" class="form-control"/>
                        <sys:ckfinder input="files" type="files" uploadPath="/oa/notify" selectMultiple="true" readonly="true" />
                    </c:if>
                </td>
            </tr>

            <c:if test="${oaNotify.status ne '1'}">
                <tr>
                    <td class="active">
                        <label class="pull-right"> <span style="color: #E7505A;"> * </span>状态：</label>
                    </td>
                    <td>
                        <div class="input-group">
                            <div class="icheck-inline">
                                <form:radiobuttons path="status" items="${fns:getDictList('oa_notify_status')}" itemLabel="label" itemValue="value" htmlEscape="false" class="required icheck"/>
                            </div>
                        </div>
                    </td>
                    <td class="active">
                        <label class="pull-right"> <span style="color: #E7505A;"> * </span>接受人：</label>
                    </td>
                    <td>
                        <sys:treeselect id="oaNotifyRecord" name="oaNotifyRecordIds" value="${oaNotify.oaNotifyRecordIds}" labelName="oaNotifyRecordNames" labelValue="${oaNotify.oaNotifyRecordNames}" title="用户" url="/sys/office/treeData?type=3" cssClass="form-control required" notAllowSelectParent="true" checked="true"/>
                    </td>
                </tr>
            </c:if>

            <c:if test="${oaNotify.status eq '1'}">
                <tr>
                    <td class="active">
                        <label class="pull-right"> 接受人：</label>
                    </td>
                    <td colspan="3">
                        <div class="table-scrollable">
                            <table id="contentTable" class="table table-striped table-bordered table-hover">
                                <thead>
                                <tr>
                                    <th>接受人</th>
                                    <th>接受部门</th>
                                    <th>阅读状态</th>
                                    <th>阅读时间</th>
                                </tr>
                                </thead>
                                <tbody>
                                <c:forEach items="${oaNotify.oaNotifyRecordList}" var="oaNotifyRecord">
                                    <tr>
                                        <td>
                                                ${oaNotifyRecord.user.name}
                                        </td>
                                        <td>
                                                ${oaNotifyRecord.user.office.name}
                                        </td>
                                        <td>
                                                ${fns:getDictLabel(oaNotifyRecord.readFlag, 'oa_notify_read', '')}
                                        </td>
                                        <td>
                                            <fmt:formatDate value="${oaNotifyRecord.readDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
                                        </td>
                                    </tr>
                                </c:forEach>
                                </tbody>
                            </table>
                        </div>
                        <div class="pull-right">
                            已查阅：${oaNotify.readNum} &nbsp; 未查阅：${oaNotify.unReadNum} &nbsp; 总共：${oaNotify.readNum + oaNotify.unReadNum}
                        </div>
                    </td>
                </tr>
            </c:if>
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