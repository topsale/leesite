<%
response.setStatus(403);

//获取异常类
Throwable ex = Exceptions.getThrowable(request);

// 如果是异步请求或是手机端，则直接返回信息
if (Servlets.isAjaxRequest(request)) {
	if (ex!=null && StringUtils.startsWith(ex.getMessage(), "msg:")){
		out.print(StringUtils.replace(ex.getMessage(), "msg:", ""));
	}else{
		out.print("操作权限不足.");
	}
}

//输出异常信息页面
else {
%>
<%@page import="com.funtl.leesite.common.utils.Exceptions"%>
<%@page import="com.funtl.leesite.common.utils.StringUtils"%>
<%@page import="com.funtl.leesite.common.web.Servlets"%>
<%@page contentType="text/html;charset=UTF-8" isErrorPage="true"%>
<%@include file="/views/include/taglib.jsp"%>
<!DOCTYPE html>
<html>
<head>
	<title>403 - 操作权限不足</title>
	<%@include file="/views/include/head.jsp" %>
	<link href="${ctxStatic}/assets/pages/css/error.min.css" rel="stylesheet" type="text/css" />
</head>
<body class="page-500-full-page">
<div class="row">
	<div class="col-md-12 page-500">
		<div class=" number font-red"> 403 </div>
		<div class=" details">
			<h3>操作权限不足</h3>
			<%
				if (ex != null && StringUtils.startsWith(ex.getMessage(), "msg:")) {
					out.print("<p>" + StringUtils.replace(ex.getMessage(), "msg:", "") + " <br/> <br/></p>");
				}
			%>
			<p>
				<a href="#" class="btn red btn-outline" onclick="history.go(-1);"> 返回上一页 </a><br/>
			</p>
		</div>
	</div>
</div>
</body>
</html>
<%
} out = pageContext.pushBody();
%>