<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/views/include/taglib.jsp"%>
<%@page import="com.funtl.leesite.common.web.Servlets"%>
<%
response.setStatus(404);

// 如果是异步请求或是手机端，则直接返回信息
if (Servlets.isAjaxRequest(request)) {
	out.print("页面不存在.");
}

//输出异常信息页面
else {
%>
<!DOCTYPE html>
<html>

<head>
  <title>404 - 页面不存在</title>
    <%@include file="/views/include/head.jsp" %>
    <link href="${ctxStatic}/assets/pages/css/error.min.css" rel="stylesheet" type="text/css" />
</head>
<body class="page-500-full-page">
<div class="row">
    <div class="col-md-12 page-500">
        <div class=" number font-red"> 404 </div>
        <div class=" details">
            <h3>页面未找到</h3>
            <p>
                抱歉，页面好像去火星了 <br />
            </p>
            <p>
                <a href="#" class="btn red btn-outline" onclick="history.go(-1);"> 返回上一页 </a><br />
            </p>
        </div>
    </div>
</div>
</body>
</html>
<%}%>