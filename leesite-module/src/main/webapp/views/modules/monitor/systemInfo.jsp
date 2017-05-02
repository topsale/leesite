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
    <title>${fns:getConfig('productName')} | 系统信息</title>
    <meta name="decorator" content="form"/>
</head>

<body style="background: white;">
<div class="form-body">
    <table class="table table-striped table-bordered table-hover">
        <tbody>
        <tr>
            <td class="active" style="width: 15%;">
                <label class="pull-right"> IP：</label>
            </td>
            <td style="width: 35%;">
                ${systemInfo.hostIp}
            </td>
            <td class="active" style="width: 15%;">
                <label class="pull-right"> 主机名：</label>
            </td>
            <td style="width: 35%;">
                ${systemInfo.hostName}
            </td>
        </tr>
        <tr>
            <td class="active">
                <label class="pull-right"> 操作系统名称：</label>
            </td>
            <td>
                ${systemInfo.osName}
            </td>
            <td class="active">
                <label class="pull-right"> 操作系统架构：</label>
            </td>
            <td>
                ${systemInfo.arch}
            </td>
        </tr>
        <tr>
            <td class="active">
                <label class="pull-right"> 操作系统版本：</label>
            </td>
            <td>
                ${systemInfo.osVersion}
            </td>
            <td class="active">
                <label class="pull-right"> 处理器个数：</label>
            </td>
            <td>
                ${systemInfo.processors}
            </td>
        </tr>
        <tr>
            <td class="active">
                <label class="pull-right"> Java的运行环境：</label>
            </td>
            <td>
                ${systemInfo.javaVersion}
            </td>
            <td class="active">
                <label class="pull-right"> Java供应商的URL：</label>
            </td>
            <td>
                ${systemInfo.javaUrl}
            </td>
        </tr>
        <tr>
            <td class="active">
                <label class="pull-right"> Java的安装路径：</label>
            </td>
            <td>
                ${systemInfo.javaHome}
            </td>
            <td class="active">
                <label class="pull-right"> 临时文件路径：</label>
            </td>
            <td>
                ${systemInfo.tmpdir}
            </td>
        </tr>
        </tbody>
    </table>
</div>
</body>
</html>