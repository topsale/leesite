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
    <title>${fns:getConfig('productName')} | 推送通知</title>
    <meta name="decorator" content="default" />
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
                <t:menu menu="${fns:getTopMenu()}" parentName="阿里云" currentName="推送通知"></t:menu>
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
                                <span class="caption-subject bold font-grey-gallery uppercase"> 推送通知 </span>
                                <span class="caption-helper"></span>
                            </div>
                            <div class="tools">
                                <a href="" class="fullscreen"> </a>
                            </div>
                        </div>
                        <div class="portlet-body">
                            <form:form id="inputForm" modelAttribute="pushRequest" action="${ctx}/aliyun/configAliyunPush/sendPush" method="post" class="form-horizontal" cssStyle="padding: 5px;">
                                <sys:message content="${message}" />
                                <form:hidden path="pushType" />
                                <form:hidden path="deviceType" />

                                <table class="table table-striped table-bordered table-hover">
                                    <thead>
                                    <th colspan="2">通知内容（必填）</th>
                                    </thead>
                                    <tbody>
                                    <tr>
                                        <td class="active" style="width: 15%;">
                                            <label class="pull-right"><span style="color: #E7505A;"> * </span>通知标题：</label>
                                        </td>
                                        <td>
                                            <form:input path="title" htmlEscape="false" class="form-control required" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="active" style="width: 15%;">
                                            <label class="pull-right"><span style="color: #E7505A;"> * </span>通知内容：</label>
                                        </td>
                                        <td>
                                            <form:textarea path="body" htmlEscape="false" rows="3" class="form-control required" />
                                        </td>
                                    </tr>
                                    </tbody>
                                </table>

                                <table class="table table-striped table-bordered table-hover">
                                    <thead>
                                    <th colspan="2">高级设置（选填）</th>
                                    </thead>
                                    <tbody>
                                    <tr>
                                        <td colspan="2"><label class="pull-left">点击通知后操作：</label></td>
                                    </tr>
                                    <tr>
                                        <td class="active" style="width: 15%;">
                                            <label class="pull-right">后续操作：</label>
                                        </td>
                                        <td>
                                            <input name="androidOpenType" type="radio" class="icheck" checked="checked" value="APPLICATION">打开应用</input>
                                            <input name="androidOpenType" type="radio" class="icheck" value="ACTIVITY">打开指定页面</input>
                                            <input name="androidOpenType" type="radio" class="icheck" value="URL">打开指定网页</input>
                                            <input name="androidOpenType" type="radio" class="icheck" value="NONE">无跳转</input>
                                            <form:input path="androidOpenUrl" htmlEscape="false" class="form-control" placeholder="请输入URL" cssStyle="display: none; margin-top: 10px;" />
                                            <form:input path="androidActivity" htmlEscape="false" class="form-control" placeholder="请输入native" cssStyle="display: none; margin-top: 10px;" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="active" style="width: 15%;">
                                            <label class="pull-right">自定义参数：</label>
                                        </td>
                                        <td>
                                            <input id="extParameterCheckBox" name="hasExtParameters" type="checkbox" class="icheck" />
                                            key-value（最多5个）
                                            <table id="extParameterTable" class="table table-striped table-bordered table-hover" style="margin-top: 10px; display: none;">
                                                <thead>
                                                <th>key</th>
                                                <th colspan="2">value</th>
                                                </thead>
                                                <tbody>
                                                <tr>
                                                    <td>
                                                        <input name="extParameterKeys" type="text" class="form-control" />
                                                    </td>
                                                    <td>
                                                        <input name="extParameterValues" type="text" class="form-control" />
                                                    </td>
                                                    <td></td>
                                                </tr>
                                                </tbody>
                                                <tfoot>
                                                <td colspan="3">
                                                    <a id="addExtParameter" href="javascript:void(0);">+添加Key-Value</a>
                                                </td>
                                                </tfoot>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="2"><label class="pull-left">通知提醒方式：</label></td>
                                    </tr>
                                    <tr>
                                        <td class="active" style="width: 15%;">
                                            <label class="pull-right">提醒方式：</label>
                                        </td>
                                        <td>
                                            <input name="androidNotifyType" type="radio" class="icheck" value="VIBRATE">震动</input>
                                            <input name="androidNotifyType" type="radio" class="icheck" value="SOUND">声音</input>
                                            <input name="androidNotifyType" type="radio" class="icheck" checked="checked" value="BOTH">震动&声音</input>
                                            <input name="androidNotifyType" type="radio" class="icheck" value="NONE">静音</input>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="2"><label class="pull-left">发送对象及时间：</label></td>
                                    </tr>
                                    <tr>
                                        <td class="active" style="width: 15%;">
                                            <label class="pull-right">发送对象：</label>
                                        </td>
                                        <td>
                                            <input name="target" type="radio" class="icheck" checked="checked" value="ALL">所有人</input>
                                            <input name="target" type="radio" class="icheck" value="DEVICE">指定终端</input>
                                            <input name="target" type="radio" class="icheck" value="ACCOUNT">指定账号</input>
                                            <form:input path="targetValue" htmlEscape="false" class="form-control" cssStyle="display: none; margin-top: 10px;" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="active" style="width: 15%;">
                                            <label class="pull-right">发送时间：</label>
                                        </td>
                                        <td>
                                            <input name="pushTime" type="radio" class="icheck" checked="checked" value="0">立即发送</input>
                                            <input name="pushTime" type="radio" class="icheck" value="1">定时发送</input>
                                            <input id="pushDate" name="pushDate" type="text" maxlength="20" class="laydate-icon form-control layer-datetime" style="display:none; margin-top: 10px;" value="${fns:getDate('yyyy-MM-dd HH:mm')}" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="active" style="width: 15%;">
                                            <label class="pull-right">离线保存：</label>
                                        </td>
                                        <td>
                                            <input name="storeOffline" type="radio" class="icheck" checked="checked" value="false">不保存</input>
                                            <input name="storeOffline" type="radio" class="icheck" value="true">保存</input>
                                            <div id="divExpireTime" style="margin-top: 10px; display: none;">
                                                保存 <input id="expireTime" name="expireTime" type="text" value="72" style="width: 80px;" /> 小时，该时段之后再上线的用户将收不到推送
                                            </div>
                                        </td>
                                    </tr>
                                    </tbody>
                                </table>

                                <div class="form-actions pull-right">
                                    <shiro:hasPermission name="aliyun:configAliyunPush:pushNotify">
                                        <button class="btn btn-primary btn-sm" type="submit">确定发送</button>
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
    var validateForm;

    function doSubmit() {//回调函数，在编辑和保存动作时，供openDialog调用提交表单。
        if (validateForm.form()) {
            $("#inputForm").submit();
            return true;
        }

        return false;
    }

    $(document).ready(function () {
        validateForm = $("#inputForm").validate({
            errorElement: 'span',
            errorClass: 'help-inline border-red font-red',
            focusInvalid: false,
            errorContainer: "#messageBox",

            submitHandler: function (form) {
                loading('正在提交，请稍等...');
                form.submit();
            },

            errorPlacement: function (error, element) {
                $("#messageBox").text("输入有误，请先更正。");
                if (element.is(":checkbox") || element.is(":radio") || element.parent().is(".input-append")) {
                    error.appendTo(element.parent().parent());
                } else {
                    error.insertAfter(element);
                }
            }
        });

        // Android - 点击通知后动作
        $("input[name='androidOpenType']").on("ifChecked", function (event) {
            if ($(this).val() == "ACTIVITY") {
                $("#androidActivity").show();
                $("#androidOpenUrl").hide();
            } else if ($(this).val() == "URL") {
                $("#androidActivity").hide();
                $("#androidOpenUrl").show();
            } else {
                $("#androidActivity").hide();
                $("#androidOpenUrl").hide();
            }
        });

        // 扩展参数
        $("#extParameterCheckBox").on("ifChanged", function (event) {
            if ($(this).is(":checked")) {
                $("#extParameterTable").fadeIn();
            } else {
                $("#extParameterTable").fadeOut();
            }
        });

        $("#addExtParameter").click(function () {
            var trLength = $("#extParameterTable").find("tbody").find("tr").length;
            // 最多5条
            if (trLength < 5) {
                $("#extParameterTable").find("tbody").append(
                    "<tr>\n" +
                    "                                                    <td>\n" +
                    "                                                        <input name=\"extParameterKeys\" type=\"text\" class=\"form-control\" />\n" +
                    "                                                    </td>\n" +
                    "                                                    <td>\n" +
                    "                                                        <input name=\"extParameterValues\" type=\"text\" class=\"form-control\" />" +
                    "                                                    </td>\n" +
                    "                                                    <td>\n" +
                    "                                                        <a href=\"javascript:void(0);\" onclick='$(this).parent().parent().remove();'>删除</a>" +
                    "                                                    </td>\n" +
                    "                                                </tr>"
                );
            }
        });

        // 发送对象
        $("input[name='target']").on("ifChecked", function (event) {
            if ($(this).val() == "DEVICE") {
                $("#targetValue").show();
                $("#targetValue").attr("placeholder", "请输入DeviceID，多个终端用逗号分隔");
            } else if ($(this).val() == "ACCOUNT") {
                $("#targetValue").show();
                $("#targetValue").attr("placeholder", "请输入账号，多个账号用逗号分隔");
            } else {
                $("#targetValue").hide();
            }
        });

        // 发送时间
        $("input[name='pushTime']").on("ifChecked", function (event) {
            if ($(this).val() == "0") {
                $("#pushDate").hide();
            } else {
                $("#pushDate").show();
            }
        });

        // 离线保存
        $("input[name='storeOffline']").on("ifChecked", function (event) {
            if ($(this).val() == "false") {
                $("#divExpireTime").hide();
            } else {
                $("#divExpireTime").show();
            }
        });

        // 外部js调用
        laydate({
            elem: '#pushDate',
            event: 'focus',
            format: 'YYYY-MM-DD hh:mm',
            istime: true
        });
    });
</script>
</body>
</html>