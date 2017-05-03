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
    <title>${fns:getConfig('productName')} | 接口测试</title>
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
                                <span class="caption-subject bold font-grey-gallery uppercase"> ${testInterface.name == null?'服务器':testInterface.name}接口测试 </span>
                                <span class="caption-helper"></span>
                            </div>
                            <div class="tools">
                                <a href="" class="fullscreen"> </a>
                            </div>
                        </div>
                        <div class="portlet-body">
                            <table class="table table-striped table-bordered table-hover">
                                <tbody>
                                <tr>
                                    <td class="active" style="width: 10%;">
                                        <label class="pull-right"> 接口类型：</label>
                                    </td>
                                    <td colspan="3">
                                        <input type="hidden" name="S_TYPE" id="S_TYPE" value="${testInterface.type eq 'post'?'POST':'GET'}"/>
                                        <input name="form-field-radio"  class="form-control icheck" type="radio" value="POST" <c:if test="${testInterface.type eq 'post'}">checked="checked"</c:if> >POST
                                        <input name="form-field-radio"  class="form-control icheck" type="radio" value="GET" <c:if test="${testInterface.type eq 'get'}">checked="checked"</c:if> >GET
                                    </td>
                                </tr>
                                <tr>
                                    <td class="active">
                                        <label class="pull-right"> 请求url：</label>
                                    </td>
                                    <td colspan="3">
                                        <input type="text" id="serverUrl" title="输入请求地址" value="${testInterface.url }"  class="form-control" >
                                        <span class="help-inline">如果URL包括JSESSIONID字段，请先调用登录接口，把生成的JSESSIONID参数替换此处的值，否则会提示没有登录。</span>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="active">
                                        <label class="pull-right"> Post Body：</label>
                                    </td>
                                    <td colspan="3">
                                        <input type="text" id="requestBody" title="输入请求地址" value="${testInterface.body }"  class="form-control" >
                                        <span class="help-inline">格式:  name1=value1&name2=value2, 如果是get请求请留空。</span>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="active">
                                        <label class="pull-right"> 返回结果：</label>
                                    </td>
                                    <td colspan="3">
                                        <textarea id="json-field" title="返回结果" class="form-control"></textarea>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="active" style="width: 10%;">
                                        <label class="pull-right"> 服务器响应：</label>
                                    </td>
                                    <td style="width: 40%;">
                                        <span id="stime" style="color: #E7505A;">-</span>&nbsp;毫秒
                                    </td>
                                    <td class="active" style="width: 10%;">
                                        <label class="pull-right"> 客户端请求：</label>
                                    </td>
                                    <td style="width: 40%;">
                                        <span id="ctime" style="color: #E7505A;">-</span>&nbsp;毫秒
                                    </td>
                                </tr>
                                </tbody>
                            </table>
                            <div class="form-actions">
                                <a class="btn btn-sm btn-primary" onclick="sendSever();">请求</a>
                                <a class="btn btn-sm btn-default" onclick="gReload();">重置</a>
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
<script src="${ctxStatic}/assets/global/scripts/interfaceTest.js"></script>
</body>
</html>