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
    <title>${fns:getConfig('productName')} | 信箱</title>
    <meta name="decorator" content="default"/>
    <link href="${ctxStatic}/assets/apps/css/inbox.min.css" rel="stylesheet" type="text/css" />
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
            <div class="inbox">
                <div class="row">
                    <div class="col-md-3">
                        <div class="inbox-sidebar">
                            <a href="${ctx}/iim/mailCompose/sendLetter" data-title="Compose" class="btn red compose-btn btn-block">
                                <i class="fa fa-edit"></i> 写信
                            </a>
                            <ul class="inbox-nav">
                                <li>
                                    <a href="javascript:;" class="sbold uppercase" data-title="文件夹"> 文件夹</a>
                                </li>
                                <li>
                                    <a href="${ctx}/iim/mailBox/list?orderBy=sendtime desc" data-type="inbox" data-title="收件箱"> 收件箱
                                        <span class="badge badge-primary">${noReadCount}</span>
                                    </a>
                                </li>
                                <li class="active">
                                    <a href="${ctx}/iim/mailCompose/list?status=1&orderBy=sendtime desc" data-type="important" data-title="已发送"> 已发送
                                        <span class="badge badge-success">${mailComposeCount}</span>
                                    </a>
                                </li>
                                <li>
                                    <a href="${ctx}/iim/mailCompose/list?status=0&orderBy=sendtime desc" data-type="sent" data-title="草稿箱"> 草稿箱
                                        <span class="badge badge-danger">${mailDraftCount}</span>
                                    </a>
                                </li>
                                <li class="divider"></li>
                                <li>
                                    <a href="javascript:;" class="sbold uppercase" data-title="分类"> 分类</a>
                                </li>
                                <li>
                                    <a href="##"> <i class="fa fa-circle text-navy"></i> 工作</a>
                                </li>
                                <li>
                                    <a href="##"> <i class="fa fa-circle text-danger"></i> 文档</a>
                                </li>
                                <li>
                                    <a href="##"> <i class="fa fa-circle text-primary"></i> 社交</a>
                                </li>
                                <li>
                                    <a href="##"> <i class="fa fa-circle text-info"></i> 广告</a>
                                </li>
                                <li>
                                    <a href="##"> <i class="fa fa-circle text-warning"></i> 客户端</a>
                                </li>
                                <li class="divider"></li>
                                <li>
                                    <a href="javascript:;" class="sbold uppercase" data-title="标签"> 标签</a>
                                </li>
                                <li style="float: left;">
                                    <a href="#"><i class="fa fa-tag"></i> 朋友</a>
                                </li>
                                <li style="float: left;">
                                    <a href="#"><i class="fa fa-tag"></i> 工作</a>
                                </li>
                                <li style="float: left;">
                                    <a href="#"><i class="fa fa-tag"></i> 家庭</a>
                                </li>
                                <li style="float: left;">
                                    <a href="#"><i class="fa fa-tag"></i> 孩子</a>
                                </li>
                                <li style="float: left;">
                                    <a href="#"><i class="fa fa-tag"></i> 假期</a>
                                </li>
                                <li style="float: left;">
                                    <a href="#"><i class="fa fa-tag"></i> 音乐</a>
                                </li>
                                <li style="float: left;">
                                    <a href="#"><i class="fa fa-tag"></i> 照片</a>
                                </li>
                                <li style="float: left;">
                                    <a href="#"><i class="fa fa-tag"></i> 电影</a>
                                </li>
                                <div class="clearfix"></div>
                            </ul>
                        </div>
                    </div>
                    <div class="col-md-9">
                        <div class="inbox-body">
                            <div class="inbox-header">
                                <h1 class="pull-left">已发送 (${mailComposeCount})</h1>
                                <form:form  id="searchForm" modelAttribute="mailCompose" action="${ctx}/iim/mailCompose/?status=1" method="post" class="form-inline pull-right">
                                    <input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
                                    <input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
                                    <table:sortColumn  id="orderBy" name="orderBy" value="${page.orderBy}" callback="sortOrRefresh();"></table:sortColumn><!-- 支持排序 -->
                                    <div class="input-group">
                                        <form:input path="mail.title" htmlEscape="false" maxlength="128"  class=" form-control" placeholder="搜索邮件标题，正文等"/>
                                        <div class="input-group-btn">
                                            <button id="btnSubmit" type="submit" class="btn btn-primary">
                                                <i class="fa fa-search"></i>
                                            </button>
                                        </div>
                                    </div>
                                </form:form>
                            </div>
                            <div class="row" style="margin-bottom: 10px;">
                                <div class="col-md-12">
                                    <div class="pull-left">
                                        <button class="btn btn-default btn-sm tooltips" data-toggle="tooltip" data-placement="left" title="刷新邮件列表" onclick="sortOrRefresh()"><i class="fa fa-refresh"></i> 刷新</button>
                                        <button class="btn btn-default btn-sm tooltips" data-toggle="tooltip" data-placement="top" title="标为已读"><i class="fa fa-eye"> 已读</i></button>
                                        <button class="btn btn-default btn-sm tooltips" data-toggle="tooltip" data-placement="top" title="标为重要"><i class="fa fa-exclamation"> 重要</i></button>
                                        <table:delRow url="${ctx}/iim/mailCompose/deleteAllCompose" id="contentTable"></table:delRow><!-- 删除按钮 -->
                                    </div>
                                    <div class="btn-group pull-right">
                                        ${page}
                                    </div>
                                </div>
                            </div>
                            <div class="inbox-content">
                                <div class="row">
                                    <div class="col-md-12">
                                        <div class="table-scrollable">
                                            <table id="contentTable" class="table table-striped table-bordered table-hover table-checkable">
                                                <thead>
                                                <tr>
                                                    <th>
                                                        <label class="mt-checkbox mt-checkbox-single mt-checkbox-outline">
                                                            <input type="checkbox" class="group-checkable" data-set=".checkboxes" />
                                                            <span></span>
                                                        </label>
                                                    </th>
                                                    <th class="sort-column receiver.name">收件人</th>
                                                    <th class="sort-column title">标题</th>
                                                    <th class="sort-column overview">内容</th>
                                                    <th class="sort-column sendtime">时间</th>
                                                    <th>操作</th>
                                                </tr>
                                                </thead>
                                                <tbody>
                                                <c:forEach items="${page.list}" var="mailCompose">
                                                    <tr>
                                                        <td>
                                                            <label class="mt-checkbox mt-checkbox-single mt-checkbox-outline">
                                                                <input type="checkbox" class="checkboxes i-checks" id="${mailCompose.id}" />
                                                                <span></span>
                                                            </label>
                                                        </td>
                                                        <td class="">
                                                            <a href="${ctx}/iim/mailCompose/detail?id=${mailCompose.id}">${mailCompose.receiver.name}</a>
                                                        </td>
                                                        <td class="mail-ontact">
                                                            <a href="${ctx}/iim/mailCompose/detail?id=${mailCompose.id}">${mailCompose.mail.title}</a>
                                                        </td>
                                                        <td class="mail-subject">
                                                            <a href="${ctx}/iim/mailCompose/detail?id=${mailCompose.id}">${mailCompose.mail.overview}</a>
                                                        </td>
                                                        <td class="mail-date">${fns:formatDateTime(mailCompose.sendtime)}</td>
                                                        <td>
                                                            <a href="${ctx}/iim/mailCompose/delete?id=${mailCompose.id}" onclick="return confirmx('确认要删除该站内信吗？', this.href)" class="btn btn-info btn-xs btn-danger"><i class="fa fa-trash"></i> 删除</a>
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
    $(function () {
        CheckTable.init("#contentTable");
    });

    function page(n,s){
        $("#pageNo").val(n);
        $("#pageSize").val(s);
        $("#searchForm").submit();
        return false;
    }
</script>
</body>
</html>