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
	<title>${fns:getConfig('productName')} | 短信配置</title>
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
				<t:menu menu="${fns:getTopMenu()}" parentName="系统配置" currentName="短信配置"></t:menu>
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
								<span class="caption-subject bold font-grey-gallery uppercase"> 短信配置 </span>
								<span class="caption-helper"><a href="https://help.aliyun.com/document_detail/51063.html?spm=5176.doc51082.2.5.d2YvaS" target="_blank">通过SDK发送短信</a> </span>
							</div>
							<div class="tools">
								<a href="" class="fullscreen"> </a>
							</div>
						</div>
						<div class="portlet-body">
							<sys:message content="${message}"/>
							<div class="note note-info">
								<p>1.发送短信使用的模板Code，可在<a href="https://mns.console.aliyun.com/sms?spm=5176.doc51063.2.12.RL5Sck#/sms/Template" target="_blank">这里</a>获取</p>
								<p>2.请自行添加“短信测试”模板，程序会通过“短信测试”四个字查找模板并发送测试短信</p>
								<p>3.验证码类的模板参数必须设置为“&dollar;{code}”并请勿将该参数传入工具类中</p>
								<p>4.短信验证码的生产和消费使用了消息队列处理</p>
								<p>5.查看短信推送状态的结果消息请参考<a href="https://help.aliyun.com/document_detail/52329.html?spm=5176.doc51063.2.14.PtL351" target="_blank">这里</a></p>
							</div>
							<form:form id="inputForm" modelAttribute="configSms" action="${ctx}/config/configSms/save" class="form-horizontal">
								<form:hidden path="id"/>

								<table class="table table-striped table-bordered table-hover">
									<tbody>
									<tr>
										<td class="active" style="width: 10%;"><label class="pull-right"><span style="color: #E7505A;"> * </span>AccessId：</label></td>
										<td colspan="3">
											<form:input path="smsAccessId" htmlEscape="false" maxlength="64" class="form-control required"/>
											<span class="help-inline">登陆<a href="https://ak-console.aliyun.com/?spm=5176.doc51063.2.7.WHdLYv#/accesskey" target="_blank">阿里云 AccessKey 管理页面</a>创建、查看</span>
										</td>
									</tr>
									<tr>
										<td class="active"><label class="pull-right"><span style="color: #E7505A;"> * </span>AccessKey：</label></td>
										<td colspan="3">
											<form:input path="smsAccessKey" htmlEscape="false" maxlength="64" class="form-control required"/>
											<span class="help-inline">登陆<a href="https://ak-console.aliyun.com/?spm=5176.doc51063.2.8.WHdLYv#/accesskey" target="_blank">阿里云 AccessKey 管理页面</a>创建、查看</span>
										</td>
									</tr>
									<tr>
										<td class="active"><label class="pull-right"><span style="color: #E7505A;"> * </span>MNSEndpoint：</label></td>
										<td colspan="3">
											<form:input path="smsMnsEndpoint" htmlEscape="false" maxlength="255" class="form-control required"/>
											<span class="help-inline">登陆<a href="https://mns.console.aliyun.com/?spm=5176.doc51063.2.9.WHdLYv" target="_blank">MNS控制台</a>，单击右上角“获取Endpoint”查看，选择公网地址</span>
										</td>
									</tr>
									<tr>
										<td class="active"><label class="pull-right"><span style="color: #E7505A;"> * </span>主题：</label></td>
										<td colspan="3">
											<form:input path="smsTopic" htmlEscape="false" maxlength="255" class="form-control required"/>
											<span class="help-inline">进入<a href="https://mns.console.aliyun.com/?spm=5176.doc51063.2.10.WHdLYv#/home/cn-hangzhou" target="_blank">控制台短信概览页</a>，获取主题名称</span>
										</td>
									</tr>
									<tr>
										<td class="active"><label class="pull-right"><span style="color: #E7505A;"> * </span>签名：</label></td>
										<td colspan="3">
											<form:input path="smsSignName" htmlEscape="false" maxlength="20" class="form-control required"/>
											<span class="help-inline">发送短信使用的签名，可在<a href="https://mns.console.aliyun.com/sms?spm=5176.doc51063.2.11.WHdLYv#/sms/Sign" target="_blank">这里</a>获取</span>
										</td>
									</tr>
									<tr>
										<td class="active"><label class="pull-right"><span style="color: #E7505A;"> * </span>测试手机：</label></td>
										<td colspan="3">
											<form:input path="testNumber" htmlEscape="false" maxlength="20" class="form-control required"/>
										</td>
									</tr>
									</tbody>
								</table>

								<div class="tabs-container">
									<ul class="nav nav-tabs">
										<li class="active"><a data-toggle="tab" href="#tab-1" aria-expanded="true">短信模板</a>
										</li>
									</ul>
									<div class="tab-content">
										<div id="tab-1" class="tab-pane active">
											<a class="btn btn-default btn-sm" onclick="addRow('#configSmsTemplateList', configSmsTemplateRowIdx, configSmsTemplateTpl);configSmsTemplateRowIdx = configSmsTemplateRowIdx + 1;" title="新增"><i class="fa fa-plus"></i> 新增</a>
											<div style="height:10px;"></div>
											<table id="contentTable" class="table table-striped table-bordered table-hover">
												<thead>
												<tr>
													<th class="hide"></th>
													<th>模板名称</th>
													<th>模板编码</th>
													<th>模板类型</th>
													<th>短信内容</th>
													<th width="10">&nbsp;</th>
												</tr>
												</thead>
												<tbody id="configSmsTemplateList">
												</tbody>
											</table>
											<script type="text/template" id="configSmsTemplateTpl">//<!--
				<tr id="configSmsTemplateList{{idx}}">
					<td class="hide">
						<input id="configSmsTemplateList{{idx}}_id" name="configSmsTemplateList[{{idx}}].id" type="hidden" value="{{row.id}}"/>
						<input id="configSmsTemplateList{{idx}}_delFlag" name="configSmsTemplateList[{{idx}}].delFlag" type="hidden" value="0"/>
					</td>

					<td>
						<input id="configSmsTemplateList{{idx}}_smsTemplateName" name="configSmsTemplateList[{{idx}}].smsTemplateName" type="text" value="{{row.smsTemplateName}}" maxlength="20" class="form-control required"/>
					</td>


					<td>
						<input id="configSmsTemplateList{{idx}}_smsTemplateCode" name="configSmsTemplateList[{{idx}}].smsTemplateCode" type="text" value="{{row.smsTemplateCode}}" maxlength="64" class="form-control required"/>
					</td>


					<td>
						<select id="configSmsTemplateList{{idx}}_smsTemplateType" name="configSmsTemplateList[{{idx}}].smsTemplateType" data-value="{{row.smsTemplateType}}" class="form-control m-b  required">
							<option value=""></option>
							<c:forEach items="${fns:getDictList('sms_template_type')}" var="dict">
								<option value="${dict.value}">${dict.label}</option>
							</c:forEach>
						</select>
					</td>


					<td>
						<input id="configSmsTemplateList{{idx}}_smsTemplateContent" name="configSmsTemplateList[{{idx}}].smsTemplateContent" type="text" value="{{row.smsTemplateContent}}" maxlength="755" class="form-control required"/>
					</td>

					<td class="text-center" width="10">
						{{#delBtn}}<span class="close" onclick="delRow(this, '#configSmsTemplateList{{idx}}')" title="删除">&times;</span>{{/delBtn}}
					</td>
				</tr>//-->
											</script>
											<script type="text/javascript">
                                                var configSmsTemplateRowIdx = 0, configSmsTemplateTpl = $("#configSmsTemplateTpl").html().replace(/(\/\/\<!\-\-)|(\/\/\-\->)/g,"");
                                                $(document).ready(function() {
                                                    var data = ${fns:toJson(configSms.configSmsTemplateList)};
                                                    for (var i=0; i<data.length; i++){
                                                        addRow('#configSmsTemplateList', configSmsTemplateRowIdx, configSmsTemplateTpl, data[i]);
                                                        configSmsTemplateRowIdx = configSmsTemplateRowIdx + 1;
                                                    }
                                                });
											</script>
										</div>
									</div>
								</div>

								<div class="form-actions pull-right">
									<shiro:hasPermission name="config:configSms:edit">
										<button class="btn btn-primary btn-sm" type="submit" onclick="saveSms();">保存</button>
										<button class="btn btn-danger btn-sm" type="submit" onclick="saveAndTestSms();">保存并测试</button>
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
    function saveSms() {
        $("#inputForm").attr("action", "${ctx}/config/configSms/save");
    }

    function saveAndTestSms() {
        $("#inputForm").attr("action", "${ctx}/config/configSms/sendTestSms");
    }

    $(document).ready(function() {
        var validateForm = $("#inputForm").validate({
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