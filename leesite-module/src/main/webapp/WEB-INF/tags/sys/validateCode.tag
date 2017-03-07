<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ include file="/views/include/taglib.jsp"%>
<%@ attribute name="name" type="java.lang.String" required="true" description="验证码输入框名称"%>
<%@ attribute name="inputCssStyle" type="java.lang.String" required="false" description="验证框样式"%>
<%@ attribute name="imageCssStyle" type="java.lang.String" required="false" description="验证码图片样式"%>
<%@ attribute name="buttonCssStyle" type="java.lang.String" required="false" description="看不清按钮样式"%>
<input type="text" id="${name}" name="${name}" maxlength="5" class="form-control form-control-solid placeholder-no-fix" autocomplete="off" placeholder="验证码" style="${inputCssStyle}"/>
<img src="${pageContext.request.contextPath}/servlet/validateCodeServlet" onclick="$('.${name}Refresh').click();" style="${imageCssStyle}"/>
<a href="javascript:" onclick="$('.${name}').attr('src','${pageContext.request.contextPath}/servlet/validateCodeServlet?'+new Date().getTime());" class="${name}Refresh" style="${buttonCssStyle}">看不清</a>