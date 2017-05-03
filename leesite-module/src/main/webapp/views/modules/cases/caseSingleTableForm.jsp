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
	<title>${fns:getConfig('productName')} | 生成示例单表</title>
    <meta name="decorator" content="form"/>

</head>
<body style="background: white;">
<div class="form-body">
	<form:form id="inputForm" modelAttribute="caseSingleTable" action="${ctx}/cases/caseSingleTable/save" method="post" class="form-horizontal" cssStyle="padding: 5px;">
		<form:hidden path="id"/>
		<sys:message content="${message}"/>

		<table class="table table-striped table-bordered table-hover">
			<tbody>
				<tr>
					<td class="active" style="width: 15%;"><label class="pull-right"><span style="color: #E7505A;"> * </span>员工：</label></td>
					<td style="width: 35%;">
						<sys:treeselect id="user" name="user.id" value="${caseSingleTable.user.id}" labelName="user.name" labelValue="${caseSingleTable.user.name}"
							title="用户" url="/sys/office/treeData?type=3" cssClass="form-control required" allowClear="true" notAllowSelectParent="true"/>
					</td>
					<td class="active" style="width: 15%;"><label class="pull-right"><span style="color: #E7505A;"> * </span>归属部门：</label></td>
					<td style="width: 35%;">
						<sys:treeselect id="office" name="office.id" value="${caseSingleTable.office.id}" labelName="office.name" labelValue="${caseSingleTable.office.name}"
							title="部门" url="/sys/office/treeData?type=2" cssClass="form-control required" allowClear="true" notAllowSelectParent="true"/>
					</td>
				</tr>
				<tr>
					<td class="active" style="width: 15%;"><label class="pull-right">归属区域：</label></td>
					<td style="width: 35%;">
						<sys:treeselect id="area" name="area.id" value="${caseSingleTable.area.id}" labelName="area.name" labelValue="${caseSingleTable.area.name}"
							title="区域" url="/sys/area/treeData" cssClass="form-control " allowClear="true" notAllowSelectParent="true"/>
					</td>
					<td class="active" style="width: 15%;"><label class="pull-right"><span style="color: #E7505A;"> * </span>请假开始日期：</label></td>
					<td style="width: 35%;">
						<input id="beginDate" name="beginDate" type="text" maxlength="20" class="laydate-icon form-control layer-date required"
							value="<fmt:formatDate value="${caseSingleTable.beginDate}" pattern="yyyy-MM-dd HH:mm:ss"/>"/>
					</td>
				</tr>
				<tr>
					<td class="active" style="width: 15%;"><label class="pull-right"><span style="color: #E7505A;"> * </span>请假结束日期：</label></td>
					<td style="width: 35%;">
						<input id="endDate" name="endDate" type="text" maxlength="20" class="laydate-icon form-control layer-date required"
							value="<fmt:formatDate value="${caseSingleTable.endDate}" pattern="yyyy-MM-dd HH:mm:ss"/>"/>
					</td>
					<td class="active" style="width: 15%;"><label class="pull-right">备注信息：</label></td>
					<td style="width: 35%;">
						<form:textarea path="remarks" htmlEscape="false" rows="3" maxlength="257" class="form-control "/>
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
				if (element.is(":checkbox")||element.is(":radio")||element.parent().is(".input-append")){
					error.appendTo(element.parent().parent());
				} else {
					error.insertAfter(element);
				}
			}
		});

		laydate({
			elem: '#beginDate', // 目标元素。由于laydate.js封装了一个轻量级的选择器引擎，因此elem还允许你传入class、tag但必须按照这种方式 '#id .class'
			event: 'focus' // 响应事件。如果没有传入event，则按照默认的click
		});
		laydate({
			elem: '#endDate', // 目标元素。由于laydate.js封装了一个轻量级的选择器引擎，因此elem还允许你传入class、tag但必须按照这种方式 '#id .class'
			event: 'focus' // 响应事件。如果没有传入event，则按照默认的click
		});
	});
</script>
</body>
</html>