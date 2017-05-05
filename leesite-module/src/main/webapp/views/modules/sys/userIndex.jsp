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
    <title>${fns:getConfig('productName')} | 用户管理</title>
    <meta name="decorator" content="default"/>
    <%@include file="/views/include/treeview.jsp" %>
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
                <t:menu menu="${fns:getTopMenu()}" parentName="系统设置" currentName="用户管理"></t:menu>
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
                <div class="col-md-2">
                    <div class="portlet light">
                        <div class="portlet-title">
                            <div class="caption">
                                <span class="caption-subject bold font-grey-gallery uppercase"> 组织机构 </span>
                                <span class="caption-helper"></span>
                            </div>
                            <div class="tools">
                                <a href="javascript:;" onclick="window.location = '${ctx}/sys/user/index'">
                                    <i class="fa fa-refresh"></i>
                                </a>
                            </div>
                        </div>
                        <div class="portlet-body">
                            <div id="ztree" class="ztree"></div>
                        </div>
                    </div>
                </div>

                <div class="col-md-10">
                    <div class="portlet light">
                        <div class="portlet-title">
                            <div class="caption">
                                <span class="caption-subject bold font-grey-gallery uppercase"> 用户列表 </span>
                                <span class="caption-helper"></span>
                            </div>
                            <div class="tools">
                                <a href="" class="fullscreen"> </a>
                            </div>
                        </div>
                        <div class="portlet-body">
                            <iframe id="officeContent" name="officeContent" src="${ctx}/sys/user/list" width="100%" height="800" frameborder="0" scrolling="no"></iframe>
                        </div>
                    </div>
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
    var setting = {
        data: {simpleData: {enable: true, idKey: "id", pIdKey: "pId", rootPId: '0'}},
        callback: {
            onClick: function (event, treeId, treeNode) {
                var id = treeNode.id == '0' ? '' : treeNode.id;
                $('#officeContent').attr("src", "${ctx}/sys/user/list?office.id=" + id + "&office.name=" + treeNode.name);
            }
        }
    };

    function refreshTree() {
        $.getJSON("${ctx}/sys/office/treeData", function (data) {
            $.fn.zTree.init($("#ztree"), setting, data).expandAll(true);
        });
    }
    refreshTree();
</script>
</body>
</html>
