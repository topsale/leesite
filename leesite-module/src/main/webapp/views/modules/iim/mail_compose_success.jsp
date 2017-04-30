<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/views/include/taglib.jsp"%>
<!DOCTYPE html>
<html>
<head>
    <title>邮件结果</title>
    <meta name="decorator" content="blank"/>
</head>
<body>
    <script type="text/javascript">
        $(function () {
            <c:if test="${mailCompose.status == '0'}">
            alert("邮件已经保存到草稿箱！");
            window.location.href = "${ctx}/iim/mailCompose/list?status=0&orderBy=sendtime desc";
            </c:if>
            <c:if test="${mailCompose.status == '1'}">
            alert("邮件发送成功！");
            window.location.href = "${ctx}/iim/mailCompose/list?status=1&orderBy=sendtime desc";
            </c:if>
        });
    </script>
</body>
</html>