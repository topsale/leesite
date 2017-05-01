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
    <title>${fns:getConfig('productName')} | 通讯录</title>
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
                                <span class="caption-subject bold font-grey-gallery uppercase"> 通讯录 </span>
                                <span class="caption-helper"> 可以向通讯录中的人发送，站内信，短消息和发起会话 </span>
                            </div>
                            <div class="tools">
                                <a href="" class="fullscreen"> </a>
                            </div>
                        </div>
                        <div class="portlet-body">
                            <div class="row" style="margin-bottom: 10px;">
                                <div class="col-md-12">
                                    <form:form id="searchForm" modelAttribute="user" action="${ctx}/iim/contact/index" method="post" class="input-group">
                                        <form:input path="name" htmlEscape="false" maxlength="50" placeholder="查找联系人" class="input form-control"/>
                                        <span class="input-group-btn">
                                            <button type="button" class="btn btn-primary" onclick="return search();"> <i class="fa fa-search"></i> 搜索</button>
                                        </span>
                                    </form:form>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-12">
                                    <span class="pull-right small text-muted">${fn:length(list)} 个联系人</span>
                                    <div class="table-scrollable">
                                        <table class="table table-striped table-hover">
                                            <tbody>
                                            <c:forEach items="${list}" var="user">
                                                <tr>
                                                    <td class="client-avatar"><img alt="image" src="${user.photo}"> </td>
                                                    <td><a data-toggle="tab" href="#contact-1" class="client-link">${user.name}</a>
                                                    <td>${user.office.name}</td>
                                                    <td class="contact-type"><i class="fa fa-envelope"> </i></td>
                                                    <td> ${user.email}</td>
                                                    <td class="contact-type"><i class="fa fa-mobile"> </i></td>
                                                    <td>${user.mobile}</td>
                                                    <td class="contact-type"><i class="fa fa-phone"> </i></td>
                                                    <td>${user.phone}</td>
                                                    <td class="contact-type"><a href="${ctx}/iim/mailCompose/sendLetter?id=${user.id}" class="btn btn-info btn-xs"><i class="fa fa-envelope"> 站内信</i></a></td>
                                                    <td class="contact-type"><a class="btn btn-info btn-xs"><i class="fa fa-qq"> 即时聊天</i></a></td>
                                                    <td class="client-status">
                                                        <c:if test="${user.loginFlag == '1'}">
                                                            <span class="btn btn-primary btn-xs">已激活</span>
                                                        </c:if>
                                                        <c:if test="${user.loginFlag == '0'}">
                                                            <span class="btn btn-danger btn-xs">未激活</span>
                                                        </c:if>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                            </tbody>
                                        </table>
                                    </div>
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
</body>
</html>