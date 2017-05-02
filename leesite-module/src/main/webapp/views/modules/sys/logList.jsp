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
    <title>${fns:getConfig('productName')} | 日志查询</title>
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
                                <span class="caption-subject bold font-grey-gallery uppercase"> 日志查询 </span>
                                <span class="caption-helper"></span>
                            </div>
                            <div class="tools">
                                <a href="" class="fullscreen"> </a>
                            </div>
                        </div>
                        <div class="portlet-body">
                            <sys:message content="${message}"/>
                            <div class="row" style="margin-bottom: 20px;">
                                <div class="col-md-12">
                                    <form:form id="searchForm" action="${ctx}/sys/log/" method="post" class="form-inline">
                                        <input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
                                        <input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
                                        <table:sortColumn id="orderBy" name="orderBy" value="${page.orderBy}" callback="sortOrRefresh();"/><!-- 支持排序 -->
                                        <div class="form-group">
                                            <label>操作菜单：</label>
                                            <input id="title" name="title" type="text" maxlength="50" class="form-control input-sm" value="${log.title}"/>
                                            <label>用户ID：</label>
                                            <input id="createBy.id" name="createBy.id" type="text" maxlength="50" class="form-control input-sm" value="${log.createBy.id}"/>
                                            <label>URI：</label>
                                            <input id="requestUri" name="requestUri" type="text" maxlength="50"  class="form-control input-sm" value="${log.requestUri}"/>
                                            <label>日期范围：&nbsp;</label>
                                            <input id="beginDate" name="beginDate" type="text" maxlength="20" class="laydate-icon form-control layer-date input-sm" value="<fmt:formatDate value="${log.beginDate}" pattern="yyyy-MM-dd"/>"/>
                                            <label>--</label>
                                            <input id="endDate" name="endDate" type="text" maxlength="20" class=" laydate-icon form-control layer-date input-sm" value="<fmt:formatDate value="${log.endDate}" pattern="yyyy-MM-dd"/>" />
                                            &nbsp;&nbsp;&nbsp;
                                            <label for="exception">
                                                <input id="exception" name="exception" class="i-checks icheck" type="checkbox"${log.exception eq '1'?' checked':''} value="1"/>只查询异常信息
                                            </label>
                                        </div>
                                    </form:form>
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-md-12">
                                    <div class="pull-left">
                                        <shiro:hasPermission name="sys:log:del">
                                            <table:delRow url="${ctx}/sys/log/deleteAll" id="contentTable"></table:delRow><!-- 删除按钮 -->
                                            <button class="btn btn-default btn-sm"  onclick="confirmx('确认要清空日志吗？','${ctx}/sys/log/empty')" title="清空"><i class="fa fa-trash"></i> 清空</button>
                                        </shiro:hasPermission>
                                        <button class="btn btn-default btn-sm" onclick="sortOrRefresh()" title="刷新"><i class="fa fa-refresh"></i> 刷新</button>
                                    </div>
                                    <div class="pull-right">
                                        <button  class="btn btn-primary btn-sm" onclick="search()" ><i class="fa fa-search"></i> 查询</button>
                                        <button  class="btn btn-primary btn-sm" onclick="reset()" ><i class="fa fa-refresh"></i> 重置</button>
                                    </div>
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-md-12">
                                    <div class="table-scrollable">
                                        <table id="contentTable" class="table table-striped table-bordered table-hover table-checkable">
                                            <thead>
                                            <tr>
                                                <th>
                                                    <label class="mt-checkbox mt-checkbox-single mt-checkbox-outline">
                                                        <input type="checkbox" class="group-checkable" data-set=".checkboxes" />
                                                        <span></span>
                                                    </label>
                                                </th>
                                                <th>操作菜单</th>
                                                <th>操作用户</th>
                                                <th>所在公司</th>
                                                <th>所在部门</th>
                                                <th>URI</th>
                                                <th>提交方式</th>
                                                <th>操作者IP</th>
                                                <th>操作时间</th>
                                            </tr>
                                            </thead>
                                            <tbody>
                                            <%request.setAttribute("strEnter", "\n");request.setAttribute("strTab", "\t");%>
                                            <c:forEach items="${page.list}" var="log">
                                                <tr>
                                                    <td>
                                                        <label class="mt-checkbox mt-checkbox-single mt-checkbox-outline">
                                                            <input type="checkbox" class="checkboxes i-checks" id="${log.id}" />
                                                            <span></span>
                                                        </label>
                                                    </td>
                                                    <td>${log.title}</td>
                                                    <td>${log.createBy.name}</td>
                                                    <td>${log.createBy.company.name}</td>
                                                    <td>${log.createBy.office.name}</td>
                                                    <td><strong>${log.requestUri}</strong></td>
                                                    <td>${log.method}</td>
                                                    <td>${log.remoteAddr}</td>
                                                    <td><fmt:formatDate value="${log.createDate}" type="both"/></td>
                                                </tr>
                                                <c:if test="${not empty log.exception}">
                                                    <tr>
                                                        <td colspan="9" style="word-wrap:break-word; word-break:break-all; text-align: left; padding-left: 10px;">
                                                                <%-- 用户代理: ${log.userAgent}<br/> --%>
                                                                <%-- 提交参数: ${fns:escapeHtml(log.params)} <br/> --%>
                                                            异常信息: <br/>
                                                                ${fn:replace(fn:replace(fns:escapeHtml(log.exception), strEnter, '<br/>'), strTab, '&nbsp; &nbsp; ')}
                                                        </td>
                                                    </tr>
                                                </c:if>
                                            </c:forEach>
                                            </tbody>
                                        </table>
                                    </div>
                                    <table:page page="${page}"></table:page>
                                </div>
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
<script type="text/javascript">
    $(document).ready(function() {
        // 外部js调用
        laydate({
            elem: '#beginDate', //目标元素。由于laydate.js封装了一个轻量级的选择器引擎，因此elem还允许你传入class、tag但必须按照这种方式 '#id .class'
            event: 'focus' //响应事件。如果没有传入event，则按照默认的click
        });

        laydate({
            elem: '#endDate', //目标元素。由于laydate.js封装了一个轻量级的选择器引擎，因此elem还允许你传入class、tag但必须按照这种方式 '#id .class'
            event: 'focus' //响应事件。如果没有传入event，则按照默认的click
        });
    });
</script>
</body>
</html>