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

    <link href="${ctxStatic}/assets/global/plugins/bootstrap-summernote/summernote.css" rel="stylesheet">
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
                                <li>
                                    <a href="${ctx}/iim/mailCompose/list?status=1&orderBy=sendtime desc" data-type="important" data-title="已发送"> 已发送
                                        <span class="badge badge-success">${mailComposeCount}</span>
                                    </a>
                                </li>
                                <li class="active">
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
                                <h1 class="pull-left">写信</h1>
                            </div>
                            <div class="row" style="margin-bottom: 10px;">
                                <div class="col-md-12">
                                    <div class="pull-left">
                                        <button type="button" class="btn btn-default btn-sm" onclick="saveLetter()"> <i class="fa fa-pencil"></i> 存为草稿</button>
                                        <a href="${ctx}/iim/mailBox/list" class="btn btn-default btn-sm tooltips" data-toggle="tooltip" data-placement="top" title="放弃"><i class="fa fa-times"></i> 放弃</a>
                                    </div>
                                </div>
                            </div>
                            <div class="inbox-content">
                                <div class="row">
                                    <div class="col-md-12">
                                        <div class="bg-grey-steel" style="height: 1px; margin-bottom: 10px;"></div>
                                        <form:form id="inputForm" modelAttribute="mailCompose" action="${ctx}/iim/mailCompose/save" method="post" class="form-horizontal">
                                            <table class="table table-striped table-bordered table-hover">
                                                <tbody>
                                                <tr>
                                                    <td class="active" style="width: 10%;">
                                                        <label class="pull-right">发送到：</label>
                                                    </td>
                                                    <td style="width: 90%;">
                                                        <sys:treeselect id="receiver" name="receiverIds" value="${receiverIds}" labelName="receiverNames" labelValue="${receiverNames}" title="用户" url="/sys/office/treeData?type=3" cssClass="form-control required" notAllowSelectParent="true" checked="true"/>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="active" style="width: 10%;">
                                                        <label class="pull-right">主题：</label>
                                                    </td>
                                                    <td style="width: 90%;">
                                                        <input type="text" id="title" name="mail.title"  class="form-control" value="${mailCompose.mail.title }">
                                                    </td>
                                                </tr>
                                                </tbody>
                                            </table>
                                            <input type="hidden" id="id" name="id" value="${mailCompose.id}"><!-- id -->
                                            <input type="hidden" id="status" name="status" value="0"><!-- 0 草稿  1 已发送 -->
                                            <input type="hidden" id="overview" name="mail.overview"><!-- 内容简介 -->
                                            <input type="hidden" id="content" name="mail.content"><!-- 内容 -->
                                        </form:form>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-12">
                                        <div class="summernote"></div>
                                        <div class="clearfix"></div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-12">
                                        <div class="pull-right" style="margin-top: 10px;">
                                            <button type="button" class="btn btn-primary btn-sm" onclick="sendLetter()"> <i class="fa fa-reply"></i> 发送</button>
                                            <a href="${ctx}/iim/mailBox/list" class="btn btn-danger btn-sm"><i class="fa fa-times"></i> 放弃</a>
                                            <button type="button" class="btn btn-success btn-sm" onclick="saveLetter()"> <i class="fa fa-pencil"></i> 存为草稿</button>
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

<div style="display:none" id="contentView">
${mailCompose.mail.content}
</div>

<%@include file="/views/include/foot.jsp" %>
<script src="${ctxStatic}/assets/global/plugins/bootstrap-summernote/summernote.min.js"></script>
<script src="${ctxStatic}/assets/global/plugins/bootstrap-summernote/lang/summernote-zh-CN.js"></script>
<script type="text/javascript">
    $(document).ready(function () {
        $('.summernote').summernote({
            lang: 'zh-CN',
            height: 400
        });
        $(".note-editable").html($("#contentView").text());
    });

    var edit = function () {
        $('.click2edit').summernote({
            focus: true
        });
    };

    var save = function () {
        var aHTML = $('.click2edit').code(); //save HTML If you need(aHTML: array).
        $('.click2edit').destroy();
    };

    function sendLetter(){
        if($("#receiverRecordId").val()==''){
            top.layer.alert('收件人不能为空！', {icon: 0});
            return;
        }
        if($("#title").val()==''){
            top.layer.alert('标题不能为空！', {icon: 0});
            return;
        }
        $("#status").val("1");
        $("#content").val($(".note-editable").html());
        $("#overview").val($(".note-editable").text().substring(0,20));
        var index = layer.load(1, {
            shade: [0.3,'#fff'] //0.1透明度的白色背景
        });
        $("#inputForm").submit();
    }

    function saveLetter(){
        if($("#title").val()==''){
            top.layer.alert('标题不能为空！', {icon: 0});
            return;
        }
        $("#status").val("0");
        $("#content").val($(".note-editable").html());
        $("#overview").val($(".note-editable").text().substring(0,20));
        var index = layer.load(1, {
            shade: [0.3,'#fff'] //0.1透明度的白色背景
        });
        $("#inputForm").submit();
    }
</script>
</body>
</html>