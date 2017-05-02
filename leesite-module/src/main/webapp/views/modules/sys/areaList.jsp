<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/views/include/taglib.jsp"%>

<!DOCTYPE html>
<!--[if IE 8]> <html lang="zh" class="ie8 no-js"> <![endif]-->
<!--[if IE 9]> <html lang="zh" class="ie9 no-js"> <![endif]-->
<!--[if !IE]><!-->
<html>
<!--<![endif]-->
<!-- BEGIN HEAD -->
<head>
    <title>${fns:getConfig('productName')} | 区域管理</title>
    <meta name="decorator" content="default"/>
    <%@include file="/views/include/treetable.jsp" %>
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
                <t:menu menu="${fns:getTopMenu()}"></t:menu>
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
                                <span class="caption-subject bold font-grey-gallery uppercase"> 区域管理 </span>
                                <span class="caption-helper"></span>
                            </div>
                            <div class="tools">
                                <a href="" class="fullscreen"> </a>
                            </div>
                        </div>
                        <div class="portlet-body">
                            <sys:message content="${message}"/>
                            <div class="row" style="margin-bottom: 10px;">
                                <div class="col-md-12">
                                    <shiro:hasPermission name="sys:area:add">
                                        <table:addRow url="${ctx}/sys/area/form" title="区域"></table:addRow><!-- 增加按钮 -->
                                    </shiro:hasPermission>
                                    <button class="btn btn-default btn-sm" data-toggle="tooltip" data-placement="left" onclick="refresh()" title="刷新"><i class="fa fa-refresh"></i> 刷新</button>
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-md-12">
                                    <table id="treeTable" class="table table-striped table-bordered table-hover">
                                        <thead>
                                        <tr>
                                            <th>区域名称</th>
                                            <th>区域编码</th>
                                            <th>区域类型</th>
                                            <th>备注</th>
                                            <th>操作</th>
                                        </tr>
                                        </thead>
                                        <tbody id="treeTableList"></tbody>
                                    </table>
                                    <script type="text/template" id="treeTableTpl">
                                        <tr id="{{row.id}}" pId="{{pid}}">
                                            <td><a  href="#" onclick="openDialogView('查看区域', '${ctx}/sys/area/form?id={{row.id}}','900px', '600px')">{{row.name}}</a></td>
                                            <td>{{row.code}}</td>
                                            <td>{{dict.type}}</td>
                                            <td>{{row.remarks}}</td>
                                            <td>
                                                <shiro:hasPermission name="sys:area:view">
                                                    <a href="#" onclick="openDialogView('查看区域', '${ctx}/sys/area/form?id={{row.id}}','900px', '600px')" class="btn btn-info btn-xs" ><i class="fa fa-search-plus"></i>  查看</a>
                                                </shiro:hasPermission>
                                                <shiro:hasPermission name="sys:area:edit">
                                                    <a href="#" onclick="openDialog('修改区域', '${ctx}/sys/area/form?id={{row.id}}','900px', '600px')" class="btn btn-success btn-xs" ><i class="fa fa-edit"></i> 修改</a>
                                                </shiro:hasPermission>
                                                <shiro:hasPermission name="sys:area:del">
                                                    <a href="${ctx}/sys/area/delete?id={{row.id}}" onclick="return confirmx('要删除该区域及所有子区域项吗？', this.href)" class="btn btn-danger btn-xs" ><i class="fa fa-trash"></i> 删除</a>
                                                </shiro:hasPermission>
                                                <shiro:hasPermission name="sys:area:add">
                                                    <a href="#" onclick="openDialog('添加下级区域', '${ctx}/sys/area/form?parent.id={{row.id}}','900px', '600px')" class="btn btn-primary btn-xs" ><i class="fa fa-plus"></i> 添加下级区域</a>
                                                </shiro:hasPermission>
                                            </td>
                                        </tr>
                                    </script>
                                </div>
                            </div>
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
    $(document).ready(function() {
        var tpl = $("#treeTableTpl").html().replace(/(\/\/\<!\-\-)|(\/\/\-\->)/g,"");
        var data = ${fns:toJson(list)}, rootId = "0";
        addRow("#treeTableList", tpl, data, rootId, true);
        $("#treeTable").treeTable({expandLevel : 5});
    });

    function addRow(list, tpl, data, pid, root){
        for (var i=0; i<data.length; i++){
            var row = data[i];
            if ((${fns:jsGetVal('row.parentId')}) == pid){
                $(list).append(Mustache.render(tpl, {
                    dict: {
                        type: getDictLabel(${fns:toJson(fns:getDictList('sys_area_type'))}, row.type)
                    }, pid: (root?0:pid), row: row
                }));
                addRow(list, tpl, data, row.id);
            }
        }
    }

    function refresh(){//刷新
        window.location="${ctx}/sys/area/";
    }
</script>
</body>
</html>