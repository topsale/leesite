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
    <title>${fns:getConfig('productName')} | 站内信</title>
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
                                <li class="active">
                                    <a href="${ctx}/iim/mailBox/list?orderBy=sendtime desc" data-type="inbox" data-title="收件箱"> 收件箱
                                        <span class="badge badge-primary">${noReadCount}</span>
                                    </a>
                                </li>
                                <li>
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
                                <h1 class="pull-left">查看邮件</h1>
                            </div>
                            <div class="row" style="margin-bottom: 10px;">
                                <div class="col-md-12">
                                    <a href="${ctx}/iim/mailBox/list?orderBy=sendtime desc" class="btn btn-default btn-sm tooltips" data-toggle="tooltip" data-placement="top" title="返回"><i class="fa fa-backward"></i> 返回</a>
                                    <a href="${ctx}/iim/mailCompose/replyLetter?id=${mailBox.id}" class="btn btn-default btn-sm tooltips" data-toggle="tooltip" data-placement="top" title="回复"><i class="fa fa-reply"></i> 回复</a>
                                    <a href="#" class="btn btn-default btn-sm tooltips" data-toggle="tooltip" data-placement="top" title="打印邮件"><i class="fa fa-print"> 打印</i> </a>
                                    <a href="#" class="btn btn-default btn-sm tooltips" data-toggle="tooltip" data-placement="top" title="标为垃圾邮件"><i class="fa fa-trash-o"> 标为垃圾邮件</i> </a>
                                </div>
                            </div>
                            <div class="inbox-content">
                                <div class="row">
                                    <div class="col-md-12">
                                        <h3>
                                            <span>主题： </span>${mailBox.mail.title }
                                        </h3>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-12">
                                        <h5>
                                            <span>发件人：${(fns:getUserById(mailBox.sender)).name}</span>
                                        </h5>
                                        <h5>
                                            <span>收件人：${(fns:getUserById(mailBox.receiver)).name}</span>
                                        </h5>
                                        <h5>
                                            <span>发送时间：<fmt:formatDate value="${mailBox.sendtime}" pattern="yyyy-MM-dd HH:mm:ss"/></span>
                                        </h5>
                                    </div>
                                </div>
                                <div class="bg-grey-steel" style="height: 1px;"></div>
                                <div class="row" style="padding-top: 20px; padding-bottom: 20px;">
                                    <div class="col-md-12">
                                        ${fns:unescapeHtml(mailBox.mail.content)}
                                    </div>
                                </div>
                                <div class="bg-grey-steel" style="height: 1px;"></div>
                                <div class="row">
                                    <div class="col-md-12">
                                        <div class="pull-right" style="margin-top: 10px;">
                                            <a class="btn btn-default btn-sm" href="${ctx}/iim/mailCompose/replyLetter?id=${mailBox.id}"><i class="fa fa-reply"></i> 回复</a>
                                            <button onclick="return confirmx('确认要删除该站内信吗？', '${ctx}/iim/mailBox/delete?id=${mailBox.id}')"  data-placement="top" data-toggle="tooltip" title="删除邮件" class="btn btn-sm btn-default tooltips"><i class="fa fa-trash-o"></i> 删除</button>
                                        </div>
                                        <div class="clearfix"></div>
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
</body>
</html>