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
	<title>${fns:getConfig('productName')} | 生成示例树结构</title>
    <meta name="decorator" content="form"/>
</head>
<body style="background: white;">
<div class="form-body">
	<form:form id="inputForm" modelAttribute="caseTreeTable" action="${ctx}/cases/caseTreeTable/save" method="post" class="form-horizontal" cssStyle="padding: 5px;">
		<form:hidden path="id"/>
		<sys:message content="${message}"/>

		<table class="table table-striped table-bordered table-hover">
			<tbody>
			<tr>
				<td class="active" style="width: 10%;"><label class="pull-right"><span style="color: #E7505A;"> * </span>名称：</label></td>
				<td style="width: 40%;">
					<form:input path="name" htmlEscape="false" maxlength="100" class="form-control  required"/>

				</td>
			</tr>
			<tr>
				<td class="active" style="width: 10%;"><label class="pull-right"><span style="color: #E7505A;"> * </span>排序：</label></td>
				<td style="width: 40%;">
					<form:input path="sort" htmlEscape="false" class="form-control  required digits"/>

				</td>
			</tr>
			<tr>
				<td class="active" style="width: 10%;"><label class="pull-right">上级父级编号:</label></td>
				<td style="width: 40%;">
					<sys:treeselect id="parent" name="parent.id" value="${caseTreeTable.parent.id}" labelName="parent.name" labelValue="${caseTreeTable.parent.name}"
						title="父级编号" url="/cases/caseTreeTable/treeData" extId="${caseTreeTable.id}" cssClass="form-control " allowClear="true"/>
				</td>
			</tr>
			<tr>
				<td class="active" style="width: 10%;"><label class="pull-right">备注信息：</label></td>
				<td style="width: 40%;">
					<form:textarea path="remarks" htmlEscape="false" rows="4" maxlength="255" class="form-control "/>

				</td>
			</tr>
			</tbody>
		</table>
	</form:form>
</div>

<%@include file="/views/include/foot.jsp" %>
<script type="text/javascript">
	var validateForm;
	function doSubmit(){//回调函数，在编辑和保存动作时，供openDialog调用提交表单。
	  if(validateForm.form()){
		  $("#inputForm").submit();
		  return true;
	  }

	  return false;
	}

	$(document).ready(function() {
		$("#name").focus();
		validateForm = $("#inputForm").validate({
			errorElement: 'span',
            errorClass: 'help-inline border-red font-red',
            focusInvalid: false,
            errorContainer: "#messageBox",

			submitHandler: function(form){
				loading('正在提交，请稍等...');
				form.submit();
			},

			errorPlacement: function(error, element) {
				$("#messageBox").text("输入有误，请先更正。");
				if (element.is(":checkbox") || element.is(":radio") || element.parent().is(".input-append")){
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