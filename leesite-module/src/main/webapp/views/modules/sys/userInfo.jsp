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
    <title>${fns:getConfig('productName')} | 个人信息</title>
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
                <t:menu menu="${fns:getTopMenu()}" parentName="我的面板" currentName="个人信息"></t:menu>
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
            <sys:message hideType="1" content="${message}"/>
            <div class="row">
                <div class="col-md-6">
                    <!-- BEGIN Portlet PORTLET-->
                    <div class="portlet light">
                        <div class="portlet-title">
                            <div class="caption">
                                <span class="caption-subject bold font-grey-gallery uppercase"> 个人信息 </span>
                                <span class="caption-helper"></span>
                            </div>
                            <div class="actions">
                                <div class="btn-group">
                                    <a class="btn btn-circle btn-default" href="javascript:;" data-toggle="dropdown">
                                        <i class="fa fa-wrench"></i> 编辑
                                        <i class="fa fa-angle-down"></i>
                                    </a>
                                    <ul class="dropdown-menu pull-right">
                                        <li>
                                            <a href="${ctx}/sys/user/imageEdit"><i class="fa fa-file-image-o"></i> 修改头像 </a>
                                        </li>
                                        <li>
                                            <a id="userInfoBtn"><i class="fa fa-edit"></i> 编辑资料 </a>
                                        </li>
                                    </ul>
                                </div>
                            </div>
                        </div>
                        <div class="portlet-body">
                            <div class="row">
                                <div class="col-md-4">
                                    <img alt="image" class="img-responsive" src="${user.photo }" style="margin-bottom: 10px;" />
                                </div>
                                <div class="col-md-8">
                                    <div class="table-responsive">
                                        <table class="table table-bordered">
                                            <tbody>
                                                <tr>
                                                    <td><strong>姓名</strong></td>
                                                    <td>${user.name}</td>
                                                </tr>
                                                <tr>
                                                    <td><strong>邮箱</strong></td>
                                                    <td>${user.email}</td>
                                                </tr>
                                                <tr>
                                                    <td><strong>手机</strong></td>
                                                    <td>${user.mobile}</td>
                                                </tr>
                                                <tr>
                                                    <td><strong>电话</strong></td>
                                                    <td>${user.phone}</td>
                                                </tr>
                                                <tr>
                                                    <td><strong>公司</strong></td>
                                                    <td>${user.company.name}</td>
                                                </tr>
                                                <tr>
                                                    <td><strong>部门</strong></td>
                                                    <td>${user.office.name}</td>
                                                </tr>
                                                <tr>
                                                    <td><strong>备注</strong></td>
                                                    <td>${user.remarks}</td>
                                                </tr>
                                                <tr>
                                                    <td><strong>上次登录IP</strong></td>
                                                    <td>${user.oldLoginIp}</td>
                                                </tr>
                                                <tr>
                                                    <td><strong>上次登录时间</strong></td>
                                                    <td><fmt:formatDate value="${user.oldLoginDate}" type="both" dateStyle="full"/></td>
                                                </tr>
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!-- END GRID PORTLET-->
                </div>

                <div class="col-md-6">
                    <!-- BEGIN Portlet PORTLET-->
                    <div class="portlet light">
                        <div class="portlet-title">
                            <div class="caption">
                                <span class="caption-subject bold font-grey-gallery uppercase"> 注册信息 </span>
                                <span class="caption-helper"></span>
                            </div>
                            <div class="actions">
                                <div class="btn-group">
                                    <a class="btn btn-circle btn-default " href="javascript:;" data-toggle="dropdown">
                                        <i class="fa fa-wrench"></i> 编辑
                                        <i class="fa fa-angle-down"></i>
                                    </a>
                                    <ul class="dropdown-menu pull-right">
                                        <li>
                                            <a id="userPassWordBtn"><i class="fa fa-edit"></i> 修改密码 </a>
                                        </li>
                                    </ul>
                                </div>
                            </div>
                        </div>
                        <div class="portlet-body">
                            <div class="row">
                                <div class="col-md-8">
                                    <div class="table-responsive">
                                        <table class="table table-bordered">
                                            <tbody>
                                                <tr>
                                                    <td><strong>用户名</strong></td>
                                                    <td>${user.loginName}</td>
                                                </tr>
                                                <tr>
                                                    <td><strong>注册手机号码</strong></td>
                                                    <td>${user.mobile}</td>
                                                </tr>
                                                <tr>
                                                    <td><strong>用户角色</strong></td>
                                                    <td>${user.roleNames}</td>
                                                </tr>
                                                <tr>
                                                    <td><strong>用户类型</strong></td>
                                                    <td>${fns:getDictLabel(user.userType, 'sys_user_type', '无')}</td>
                                                </tr>
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <img width="100%" style="max-width:264px;" src="${user.qrCode}">
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
    $(document).ready(function () {
        $("#userPassWordBtn").click(function () {
            openDialog('修改密码', '${ctx}/sys/user/modifyPwd','600px', '400px');
        });

        $("#userInfoBtn").click(function () {
            openDialog('个人信息编辑', '${ctx}/sys/user/infoEdit','900px', '600px');
        });
    });
</script>
</body>
</html>