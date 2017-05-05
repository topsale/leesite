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
	<title>${fns:getConfig('productName')} | 树结构</title>
	<meta name="decorator" content="default"/>
	<%@include file="/views/include/treetable.jsp" %>
</head>
<body class="page-container-bg-solid page-header-fixed page-sidebar-closed-hide-logo">
<div class="page-container">
	<div class="page-sidebar-wrapper">
        <div class="page-sidebar navbar-collapse collapse">
            <ul class="page-sidebar-menu" data-keep-expanded="false" data-auto-scroll="true" data-slide-speed="200">
                <li class="heading">
                    <h3 class="uppercase">功能菜单</h3>
                </li>
                <t:menu menu="${fns:getTopMenu()}" parentName="生成示例" currentName="树结构"></t:menu>
            </ul>
        </div>
    </div>

    <div class="page-content-wrapper">
        <div class="page-content" style="padding-top: 0;">
            <div class="row">
                <div class="col-md-12">
                    <div class="portlet light">
                        <div class="portlet-title">
                            <div class="caption">
                                <span class="caption-subject bold font-grey-gallery uppercase"> 树结构 </span>
                                <span class="caption-helper"></span>
                            </div>
                            <div class="tools">
                                <a href="" class="fullscreen"> </a>
                            </div>
                        </div>
                        <div class="portlet-body">
                            <sys:message content="${message}"/>
							<div class="row" style="margin-bottom: 20px;">
                                <div class="col-md-12">
									<form:form id="searchForm" modelAttribute="caseTreeTable" action="${ctx}/cases/caseTreeTable/" method="post" class="form-inline">
										<div class="form-group">
												<label>名称：</label>
												<form:input path="name" htmlEscape="false" maxlength="100" class="form-control input-sm"/>
										</div>
									</form:form>
                                </div>
                            </div>

                            <div class="row" style="margin-bottom: 20px;">
                                <div class="col-md-12">
                                    <div class="pull-left">
										<shiro:hasPermission name="cases:caseTreeTable:add">
											<table:addRow url="${ctx}/cases/caseTreeTable/form" title="树结构"></table:addRow><!-- 增加按钮 -->
										</shiro:hasPermission>
                                        <button class="btn btn-default btn-sm" onclick="refresh()" title="刷新"><i class="fa fa-refresh"></i> 刷新</button>
                                    </div>
                                    <div class="pull-right">
                                        <button class="btn btn-primary btn-sm" onclick="search()"><i class="fa fa-search"></i> 查询</button>
                                        <button class="btn btn-primary btn-sm" onclick="reset()"><i class="fa fa-refresh"></i> 重置</button>
                                    </div>
                                </div>
                            </div>

							<div class="row">
                                <div class="col-md-12">
                                    <table id="treeTable" class="table table-striped table-bordered table-hover">
										<thead>
											<tr>
												<th>名称</th>
												<th>备注信息</th>
												<shiro:hasPermission name="cases:caseTreeTable:edit"><th>操作</th></shiro:hasPermission>
											</tr>
										</thead>
										<tbody id="treeTableList"></tbody>
									</table>
									<script type="text/template" id="treeTableTpl">
										<tr id="{{row.id}}" pId="{{pid}}">
											<td><a  href="#" onclick="openDialogView('查看树结构', '${ctx}/cases/caseTreeTable/form?id={{row.id}}','900px', '600px')">
												{{row.name}}
											</a></td>
											<td>
												{{row.remarks}}
											</td>
											<td>
											<shiro:hasPermission name="cases:caseTreeTable:view">
												<a href="#" onclick="openDialogView('查看树结构', '${ctx}/cases/caseTreeTable/form?id={{row.id}}','900px', '600px')" class="btn btn-info btn-xs"><i class="fa fa-search-plus"></i>  查看</a>
												</shiro:hasPermission>
											<shiro:hasPermission name="cases:caseTreeTable:edit">
												<a href="#" onclick="openDialog('修改树结构', '${ctx}/cases/caseTreeTable/form?id={{row.id}}','900px', '600px')" class="btn btn-success btn-xs"><i class="fa fa-edit"></i> 修改</a>
											</shiro:hasPermission>
											<shiro:hasPermission name="cases:caseTreeTable:del">
												<a href="${ctx}/cases/caseTreeTable/delete?id={{row.id}}" onclick="return confirmx('确认要删除该树结构及所有子树结构吗？', this.href)" class="btn btn-danger btn-xs" ><i class="fa fa-trash"></i> 删除</a>
											</shiro:hasPermission>
											<shiro:hasPermission name="cases:caseTreeTable:add">
												<a href="#" onclick="openDialog('添加下级树结构', '${ctx}/cases/caseTreeTable/form?parent.id={{row.id}}','900px', '600px')" class="btn btn-primary btn-xs"><i class="fa fa-plus"></i> 添加下级树结构</a>
											</shiro:hasPermission>
											</td>
										</tr>
									</script>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<%@include file="/views/include/foot.jsp" %>
<script type="text/javascript">
	$(document).ready(function() {
		var tpl = $("#treeTableTpl").html().replace(/(\/\/\<!\-\-)|(\/\/\-\->)/g,"");
		var data = ${fns:toJson(list)}, ids = [], rootIds = [];
		for (var i=0; i<data.length; i++){
			ids.push(data[i].id);
		}
		ids = ',' + ids.join(',') + ',';
		for (var i=0; i<data.length; i++){
			if (ids.indexOf(','+data[i].parentId+',') == -1){
				if ((','+rootIds.join(',')+',').indexOf(','+data[i].parentId+',') == -1){
					rootIds.push(data[i].parentId);
				}
			}
		}
		for (var i=0; i<rootIds.length; i++){
			addRow("#treeTableList", tpl, data, rootIds[i], true);
		}
		$("#treeTable").treeTable({expandLevel : 5});
	});

	function addRow(list, tpl, data, pid, root){
		for (var i=0; i<data.length; i++){
			var row = data[i];
			if ((${fns:jsGetVal('row.parentId')}) == pid){
				$(list).append(Mustache.render(tpl, {
					dict: {
					blank123:0}, pid: (root?0:pid), row: row
				}));
				addRow(list, tpl, data, row.id);
			}
		}
	}

	function refresh(){//刷新
		window.location="${ctx}/cases/caseTreeTable";
	}
</script>
</body>
</html>