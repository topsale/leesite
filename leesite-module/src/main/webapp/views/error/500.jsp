<%
response.setStatus(500);

// 获取异常类
Throwable ex = Exceptions.getThrowable(request);
if (ex != null){
	LoggerFactory.getLogger("500.jsp").error(ex.getMessage(), ex);
}

// 编译错误信息
StringBuilder sb = new StringBuilder("错误信息：\n");
if (ex != null) {
	sb.append(Exceptions.getStackTraceAsString(ex));
} else {
	sb.append("未知错误.\n\n");
}

// 如果是异步请求或是手机端，则直接返回信息
if (Servlets.isAjaxRequest(request)) {
	out.print(sb);
}

// 输出异常信息页面
else {
%>
<%@page import="com.funtl.leesite.common.utils.Exceptions,com.funtl.leesite.common.utils.StringUtils"%>
<%@page import="com.funtl.leesite.common.web.Servlets"%>
<%@page import="org.slf4j.LoggerFactory"%>
<%@page contentType="text/html;charset=UTF-8" isErrorPage="true"%>
<%@include file="/views/include/taglib.jsp"%>
<!DOCTYPE html>
<html>
<head>
	<title>500 - 系统内部错误</title>
	<%@include file="/views/include/head.jsp" %>
	<link href="${ctxStatic}/assets/pages/css/error.min.css" rel="stylesheet" type="text/css" />
</head>
<body class="page-500-full-page">
<div class="row">
	<div class="col-md-12 page-500">
		<div class="number font-red"> 500 </div>
		<div class="details">
			<h3>系统内部错误</h3>
			<p>
				错误信息： <br />
				<%=ex == null ? "未知错误." : StringUtils.toHtml(ex.getMessage())%> <br />
			</p>
			<p>
				<a href="#" class="btn red btn-outline" onclick="history.go(-1);"> 返回上一页 </a><br />
			</p>
		</div>
		<div style="text-align: justify; padding-left: 50px;">
			<%=StringUtils.toHtml(sb.toString())%>
		</div>
	</div>
</div>
</body>
</html>
<%
} out = pageContext.pushBody();
%>