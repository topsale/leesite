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
	<title>${fns:getConfig('productName')} | 一对多</title>
    <meta name="decorator" content="form"/>

</head>
<body style="background: white;">
<div class="form-body">
	<form:form id="inputForm" modelAttribute="caseOneToManyMain" action="${ctx}/cases/caseOneToManyMain/save" method="post" class="form-horizontal" cssStyle="padding: 5px;">
		<form:hidden path="id"/>
		<sys:message content="${message}"/>

		<table class="table table-striped table-bordered table-hover">
		   <tbody>
				<tr>
					<td class="active" style="width: 15%;"><label class="pull-right"><span style="color: #E7505A;"> * </span>归属用户：</label></td>
					<td style="width: 35%;">
						<sys:treeselect id="user" name="user.id" value="${caseOneToManyMain.user.id}" labelName="user.name" labelValue="${caseOneToManyMain.user.name}"
							title="用户" url="/sys/office/treeData?type=3" cssClass="form-control required" allowClear="true" notAllowSelectParent="true"/>
					</td>
					<td class="active" style="width: 15%;"><label class="pull-right"><span style="color: #E7505A;"> * </span>归属部门：</label></td>
					<td style="width: 35%;">
						<sys:treeselect id="office" name="office.id" value="${caseOneToManyMain.office.id}" labelName="office.name" labelValue="${caseOneToManyMain.office.name}"
							title="部门" url="/sys/office/treeData?type=2" cssClass="form-control required" allowClear="true" notAllowSelectParent="true"/>
					</td>
				</tr>
				<tr>
					<td class="active" style="width: 15%;"><label class="pull-right"><span style="color: #E7505A;"> * </span>归属区域：</label></td>
					<td style="width: 35%;">
						<sys:treeselect id="area" name="area.id" value="${caseOneToManyMain.area.id}" labelName="area.name" labelValue="${caseOneToManyMain.area.name}"
							title="区域" url="/sys/area/treeData" cssClass="form-control required" allowClear="true" notAllowSelectParent="true"/>
					</td>
					<td class="active" style="width: 15%;"><label class="pull-right"><span style="color: #E7505A;"> * </span>名称：</label></td>
					<td style="width: 35%;">
						<form:input path="name" htmlEscape="false" maxlength="100" class="form-control required"/>
					</td>
				</tr>
				<tr>
					<td class="active" style="width: 15%;"><label class="pull-right"><span style="color: #E7505A;"> * </span>性别：</label></td>
					<td style="width: 35%;">
						<form:radiobuttons path="sex" items="${fns:getDictList('sex')}" itemLabel="label" itemValue="value" htmlEscape="false" class="icheck required"/>
					</td>
					<td class="active" style="width: 15%;"><label class="pull-right"><span style="color: #E7505A;"> * </span>加入日期：</label></td>
					<td style="width: 35%;">
						<input id="inDate" name="inDate" type="text" maxlength="20" class="laydate-icon form-control layer-date required"
							value="<fmt:formatDate value="${caseOneToManyMain.inDate}" pattern="yyyy-MM-dd HH:mm:ss"/>"/>
					</td>
				</tr>
				<tr>
					<td class="active" style="width: 15%;"><label class="pull-right">备注信息：</label></td>
					<td style="width: 35%;">
						<form:textarea path="remarks" htmlEscape="false" rows="4" maxlength="255" class="form-control "/>
					</td>
					<td class="active" style="width: 15%;"></td>
		   			<td style="width: 35%;"></td>
		  		</tr>
		 	</tbody>
		</table>

		<div class="tabs-container">
            <ul class="nav nav-tabs">
				<li class="active"><a data-toggle="tab" href="#tab-1" aria-expanded="true">一对多子表1：</a>
                </li>
				<li class=""><a data-toggle="tab" href="#tab-2" aria-expanded="false">一对多子表2：</a>
                </li>
				<li class=""><a data-toggle="tab" href="#tab-3" aria-expanded="false">一对多子表3：</a>
                </li>
            </ul>
            <div class="tab-content">
				<div id="tab-1" class="tab-pane active">
			<a class="btn btn-default btn-sm" onclick="addRow('#caseOneToManyFirstList', caseOneToManyFirstRowIdx, caseOneToManyFirstTpl);caseOneToManyFirstRowIdx = caseOneToManyFirstRowIdx + 1;" title="新增"><i class="fa fa-plus"></i> 新增</a>
			<div style="height:10px;"></div>
			<table id="contentTable" class="table table-striped table-bordered table-hover">
				<thead>
					<tr>
						<th class="hide"></th>
						<th>出发地</th>
						<th>目的地</th>
						<th>代理价格</th>
						<th>备注信息</th>
						<th width="10">&nbsp;</th>
					</tr>
				</thead>
				<tbody id="caseOneToManyFirstList">
				</tbody>
			</table>
			<script type="text/template" id="caseOneToManyFirstTpl">//<!--
				<tr id="caseOneToManyFirstList{{idx}}">
					<td class="hide">
						<input id="caseOneToManyFirstList{{idx}}_id" name="caseOneToManyFirstList[{{idx}}].id" type="hidden" value="{{row.id}}"/>
						<input id="caseOneToManyFirstList{{idx}}_delFlag" name="caseOneToManyFirstList[{{idx}}].delFlag" type="hidden" value="0"/>
					</td>

					<td>
						<input id="caseOneToManyFirstList{{idx}}_startarea" name="caseOneToManyFirstList[{{idx}}].startarea" type="text" value="{{row.startarea}}" maxlength="64" class="form-control required"/>
					</td>


					<td>
						<input id="caseOneToManyFirstList{{idx}}_endarea" name="caseOneToManyFirstList[{{idx}}].endarea" type="text" value="{{row.endarea}}" maxlength="64" class="form-control required"/>
					</td>


					<td>
						<input id="caseOneToManyFirstList{{idx}}_price" name="caseOneToManyFirstList[{{idx}}].price" type="text" value="{{row.price}}" class="form-control required number"/>
					</td>


					<td>
						<textarea id="caseOneToManyFirstList{{idx}}_remarks" name="caseOneToManyFirstList[{{idx}}].remarks" rows="4" maxlength="255" class="form-control ">{{row.remarks}}</textarea>
					</td>

					<td class="text-center" width="10">
						{{#delBtn}}<span class="close" onclick="delRow(this, '#caseOneToManyFirstList{{idx}}')" title="删除">&times;</span>{{/delBtn}}
					</td>
				</tr>//-->
			</script>
			<script type="text/javascript">
				var caseOneToManyFirstRowIdx = 0, caseOneToManyFirstTpl = $("#caseOneToManyFirstTpl").html().replace(/(\/\/\<!\-\-)|(\/\/\-\->)/g,"");
				$(document).ready(function() {
					var data = ${fns:toJson(caseOneToManyMain.caseOneToManyFirstList)};
					for (var i=0; i<data.length; i++){
						addRow('#caseOneToManyFirstList', caseOneToManyFirstRowIdx, caseOneToManyFirstTpl, data[i]);
						caseOneToManyFirstRowIdx = caseOneToManyFirstRowIdx + 1;
					}
				});
			</script>
			</div>
				<div id="tab-2" class="tab-pane">
			<a class="btn btn-default btn-sm" onclick="addRow('#caseOneToManySecondList', caseOneToManySecondRowIdx, caseOneToManySecondTpl);caseOneToManySecondRowIdx = caseOneToManySecondRowIdx + 1;" title="新增"><i class="fa fa-plus"></i> 新增</a>
			<div style="height:10px;"></div>
			<table id="contentTable" class="table table-striped table-bordered table-hover">
				<thead>
					<tr>
						<th class="hide"></th>
						<th>出发地</th>
						<th>目的地</th>
						<th>代理价格</th>
						<th>备注信息</th>
						<th width="10">&nbsp;</th>
					</tr>
				</thead>
				<tbody id="caseOneToManySecondList">
				</tbody>
			</table>
			<script type="text/template" id="caseOneToManySecondTpl">//<!--
				<tr id="caseOneToManySecondList{{idx}}">
					<td class="hide">
						<input id="caseOneToManySecondList{{idx}}_id" name="caseOneToManySecondList[{{idx}}].id" type="hidden" value="{{row.id}}"/>
						<input id="caseOneToManySecondList{{idx}}_delFlag" name="caseOneToManySecondList[{{idx}}].delFlag" type="hidden" value="0"/>
					</td>

					<td>
						<input id="caseOneToManySecondList{{idx}}_startarea" name="caseOneToManySecondList[{{idx}}].startarea" type="text" value="{{row.startarea}}" maxlength="64" class="form-control required"/>
					</td>


					<td>
						<input id="caseOneToManySecondList{{idx}}_endarea" name="caseOneToManySecondList[{{idx}}].endarea" type="text" value="{{row.endarea}}" maxlength="64" class="form-control required"/>
					</td>


					<td>
						<input id="caseOneToManySecondList{{idx}}_price" name="caseOneToManySecondList[{{idx}}].price" type="text" value="{{row.price}}" class="form-control required number"/>
					</td>


					<td>
						<textarea id="caseOneToManySecondList{{idx}}_remarks" name="caseOneToManySecondList[{{idx}}].remarks" rows="4" maxlength="255" class="form-control ">{{row.remarks}}</textarea>
					</td>

					<td class="text-center" width="10">
						{{#delBtn}}<span class="close" onclick="delRow(this, '#caseOneToManySecondList{{idx}}')" title="删除">&times;</span>{{/delBtn}}
					</td>
				</tr>//-->
			</script>
			<script type="text/javascript">
				var caseOneToManySecondRowIdx = 0, caseOneToManySecondTpl = $("#caseOneToManySecondTpl").html().replace(/(\/\/\<!\-\-)|(\/\/\-\->)/g,"");
				$(document).ready(function() {
					var data = ${fns:toJson(caseOneToManyMain.caseOneToManySecondList)};
					for (var i=0; i<data.length; i++){
						addRow('#caseOneToManySecondList', caseOneToManySecondRowIdx, caseOneToManySecondTpl, data[i]);
						caseOneToManySecondRowIdx = caseOneToManySecondRowIdx + 1;
					}
				});
			</script>
			</div>
				<div id="tab-3" class="tab-pane">
			<a class="btn btn-default btn-sm" onclick="addRow('#caseOneToManyThirdList', caseOneToManyThirdRowIdx, caseOneToManyThirdTpl);caseOneToManyThirdRowIdx = caseOneToManyThirdRowIdx + 1;" title="新增"><i class="fa fa-plus"></i> 新增</a>
			<div style="height:10px;"></div>
			<table id="contentTable" class="table table-striped table-bordered table-hover">
				<thead>
					<tr>
						<th class="hide"></th>
						<th>出发地</th>
						<th>目的地</th>
						<th>代理价格</th>
						<th>备注信息</th>
						<th width="10">&nbsp;</th>
					</tr>
				</thead>
				<tbody id="caseOneToManyThirdList">
				</tbody>
			</table>
			<script type="text/template" id="caseOneToManyThirdTpl">//<!--
				<tr id="caseOneToManyThirdList{{idx}}">
					<td class="hide">
						<input id="caseOneToManyThirdList{{idx}}_id" name="caseOneToManyThirdList[{{idx}}].id" type="hidden" value="{{row.id}}"/>
						<input id="caseOneToManyThirdList{{idx}}_delFlag" name="caseOneToManyThirdList[{{idx}}].delFlag" type="hidden" value="0"/>
					</td>

					<td>
						<input id="caseOneToManyThirdList{{idx}}_startarea" name="caseOneToManyThirdList[{{idx}}].startarea" type="text" value="{{row.startarea}}" maxlength="64" class="form-control required"/>
					</td>


					<td>
						<input id="caseOneToManyThirdList{{idx}}_endarea" name="caseOneToManyThirdList[{{idx}}].endarea" type="text" value="{{row.endarea}}" maxlength="64" class="form-control required"/>
					</td>


					<td>
						<input id="caseOneToManyThirdList{{idx}}_price" name="caseOneToManyThirdList[{{idx}}].price" type="text" value="{{row.price}}" class="form-control required number"/>
					</td>


					<td>
						<textarea id="caseOneToManyThirdList{{idx}}_remarks" name="caseOneToManyThirdList[{{idx}}].remarks" rows="4" maxlength="255" class="form-control ">{{row.remarks}}</textarea>
					</td>

					<td class="text-center" width="10">
						{{#delBtn}}<span class="close" onclick="delRow(this, '#caseOneToManyThirdList{{idx}}')" title="删除">&times;</span>{{/delBtn}}
					</td>
				</tr>//-->
			</script>
			<script type="text/javascript">
				var caseOneToManyThirdRowIdx = 0, caseOneToManyThirdTpl = $("#caseOneToManyThirdTpl").html().replace(/(\/\/\<!\-\-)|(\/\/\-\->)/g,"");
				$(document).ready(function() {
					var data = ${fns:toJson(caseOneToManyMain.caseOneToManyThirdList)};
					for (var i=0; i<data.length; i++){
						addRow('#caseOneToManyThirdList', caseOneToManyThirdRowIdx, caseOneToManyThirdTpl, data[i]);
						caseOneToManyThirdRowIdx = caseOneToManyThirdRowIdx + 1;
					}
				});
			</script>
			</div>
		</div>
		</div>
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
					elem: '#inDate', //目标元素。由于laydate.js封装了一个轻量级的选择器引擎，因此elem还允许你传入class、tag但必须按照这种方式 '#id .class'
					event: 'focus' //响应事件。如果没有传入event，则按照默认的click
				});
	});
	function addRow(list, idx, tpl, row){
		$(list).append(Mustache.render(tpl, {
			idx: idx, delBtn: true, row: row
		}));
		$(list+idx).find("select").each(function(){
			$(this).val($(this).attr("data-value"));
		});
		$(list+idx).find("input[type='checkbox'], input[type='radio']").each(function(){
			var ss = $(this).attr("data-value").split(',');
			for (var i=0; i<ss.length; i++){
				if($(this).val() == ss[i]){
					$(this).attr("checked","checked");
				}
			}
		});
	}
	function delRow(obj, prefix){
		var id = $(prefix+"_id");
		var delFlag = $(prefix+"_delFlag");
		if (id.val() == ""){
			$(obj).parent().parent().remove();
		}else if(delFlag.val() == "0"){
			delFlag.val("1");
			$(obj).html("&divide;").attr("title", "撤销删除");
			$(obj).parent().parent().addClass("error");
		}else if(delFlag.val() == "1"){
			delFlag.val("0");
			$(obj).html("&times;").attr("title", "删除");
			$(obj).parent().parent().removeClass("error");
		}
	}
</script>
</body>
</html>