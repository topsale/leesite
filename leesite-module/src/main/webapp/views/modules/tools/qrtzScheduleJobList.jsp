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
    <title>${fns:getConfig('productName')} | 任务调度</title>
    <meta name="decorator" content="default" />
</head>

<body class="page-container-bg-solid page-header-fixed page-sidebar-closed-hide-logo">
<div class="page-container">
    <div class="page-sidebar-wrapper">
        <div class="page-sidebar navbar-collapse collapse">
            <ul class="page-sidebar-menu" data-keep-expanded="false" data-auto-scroll="true" data-slide-speed="200">
                <li class="heading">
                    <h3 class="uppercase">功能菜单</h3>
                </li>
                <t:menu menu="${fns:getTopMenu()}" parentName="常用工具" currentName="任务调度"></t:menu>
            </ul>
        </div>
    </div>

    <div class="page-content-wrapper">
        <div class="page-content" style="padding-top: 0;">
            <div class="row">
                <div class="col-md-12">
                    <div class="portlet light">
                        <div class="portlet-title">
                            <div class="caption">
                                <span class="caption-subject bold font-grey-gallery uppercase"> 任务调度 </span>
                                <span class="caption-helper"></span>
                            </div>
                            <div class="tools">
                                <a href="" class="fullscreen"> </a>
                            </div>
                        </div>
                        <div class="portlet-body">
                            <sys:message content="${message}" />
                            <div class="row" style="margin-bottom: 20px;">
                                <div class="col-md-12">
                                    <form:form id="searchForm" modelAttribute="qrtzScheduleJob" action="${ctx}/tools/qrtzScheduleJob" method="post" class="form-inline">
                                        <input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}" />
                                        <input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}" />
                                        <table:sortColumn id="orderBy" name="orderBy" value="${page.orderBy}" callback="sortOrRefresh();" /><!-- 支持排序 -->
                                        <div class="form-group">
                                            <label>任务名称：</label>
                                            <form:input path="jobName" htmlEscape="false" maxlength="255" class="form-control input-sm" />
                                            <label>任务别名：</label>
                                            <form:input path="aliasName" htmlEscape="false" maxlength="255" class="form-control input-sm" />
                                            <label>任务分组：</label>
                                            <form:input path="jobGroup" htmlEscape="false" maxlength="255" class="form-control input-sm" />
                                            <label>是否异步：</label>
                                            <form:select path="isSync" class="form-control input-sm">
                                                <form:option value="" label="" />
                                                <form:options items="${fns:getDictList('yes_no')}" itemLabel="label" itemValue="value" htmlEscape="false" />
                                            </form:select>
                                            &nbsp;&nbsp;&nbsp;
                                            <label for="normal">
                                                <input id="normal" name="normal" class="icheck" type="checkbox"${qrtzScheduleJob.normal eq '1'?' checked':''} value="1" />查看运行中的任务
                                            </label>
                                        </div>
                                    </form:form>
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-md-12">
                                    <div class="pull-left">
                                        <shiro:hasPermission name="tools:qrtzScheduleJob:add">
                                            <table:addRow url="${ctx}/tools/qrtzScheduleJob/form" title="任务调度"></table:addRow><!-- 增加按钮 -->
                                        </shiro:hasPermission>
                                        <shiro:hasPermission name="tools:qrtzScheduleJob:edit">
                                            <table:editRow url="${ctx}/tools/qrtzScheduleJob/form" title="任务调度" id="contentTable"></table:editRow><!-- 编辑按钮 -->
                                        </shiro:hasPermission>
                                        <shiro:hasPermission name="tools:qrtzScheduleJob:del">
                                            <table:delRow url="${ctx}/tools/qrtzScheduleJob/deleteAll" id="contentTable"></table:delRow><!-- 删除按钮 -->
                                        </shiro:hasPermission>
                                        <shiro:hasPermission name="tools:qrtzScheduleJob:import">
                                            <table:importExcel url="${ctx}/tools/qrtzScheduleJob/import"></table:importExcel><!-- 导入按钮 -->
                                        </shiro:hasPermission>
                                        <shiro:hasPermission name="tools:qrtzScheduleJob:export">
                                            <table:exportExcel url="${ctx}/tools/qrtzScheduleJob/export"></table:exportExcel><!-- 导出按钮 -->
                                        </shiro:hasPermission>
                                        <button class="btn btn-default btn-sm" onclick="sortOrRefresh()" title="刷新">
                                            <i class="fa fa-refresh"></i> 刷新
                                        </button>
                                    </div>
                                    <div class="pull-right">
                                        <button class="btn btn-primary btn-sm" onclick="search()">
                                            <i class="fa fa-search"></i> 查询
                                        </button>
                                        <button class="btn btn-primary btn-sm" onclick="reset()">
                                            <i class="fa fa-refresh"></i> 重置
                                        </button>
                                    </div>
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-md-12">
                                    <div class="table-scrollable">
                                        <table id="contentTable" class="table table-striped table-bordered table-hover table-checkable">
                                            <thead>
                                            <tr style="cursor: pointer">
                                                <th>
                                                    <label class="mt-checkbox mt-checkbox-single mt-checkbox-outline">
                                                        <input type="checkbox" class="group-checkable" data-set=".checkboxes" />
                                                        <span></span>
                                                    </label>
                                                </th>
                                                <th>任务名称</th>
                                                <th>任务别名</th>
                                                <th>任务分组</th>
                                                <th>触发器</th>
                                                <th>任务状态</th>
                                                <th>CRON</th>
                                                <th>是否异步</th>
                                                <th>执行地址</th>
                                                <c:if test="${qrtzScheduleJob.normal ne '1'}">
                                                    <th class="sort-column updateDate">更新时间</th>
                                                    <th>操作</th>
                                                </c:if>
                                            </tr>
                                            </thead>
                                            <tbody>
                                            <c:forEach items="${qrtzScheduleJob.normal eq '1' ? list : page.list}" var="qrtzScheduleJob">
                                                <tr>
                                                    <td>
                                                        <label class="mt-checkbox mt-checkbox-single mt-checkbox-outline">
                                                            <input type="checkbox" class="checkboxes i-checks" id="${qrtzScheduleJob.id}" />
                                                            <span></span>
                                                        </label>
                                                    </td>
                                                    <td>
                                                        <c:choose>
                                                            <c:when test="${qrtzScheduleJob.id ne ''}">
                                                                <a href="#" onclick="openDialogView('查看任务调度', '${ctx}/tools/qrtzScheduleJob/form?id=${qrtzScheduleJob.id}','900px', '600px')">
                                                                        ${qrtzScheduleJob.jobName}
                                                                </a>
                                                            </c:when>
                                                            <c:otherwise>
                                                                ${qrtzScheduleJob.jobName}
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </td>
                                                    <td>
                                                            ${qrtzScheduleJob.aliasName}
                                                    </td>
                                                    <td>
                                                            ${qrtzScheduleJob.jobGroup}
                                                    </td>
                                                    <td>
                                                            ${qrtzScheduleJob.jobTrigger}
                                                    </td>
                                                    <td>
                                                        <c:if test="${qrtzScheduleJob.status eq '不存在' or qrtzScheduleJob.status eq '错误'}">
                                                            <span class="font-red">${qrtzScheduleJob.status}</span>
                                                        </c:if>
                                                        <c:if test="${qrtzScheduleJob.status eq '新建' or qrtzScheduleJob.status eq '正常'}">
                                                            <span class="font-blue">${qrtzScheduleJob.status}</span>
                                                        </c:if>
                                                        <c:if test="${qrtzScheduleJob.status eq '暂停' or qrtzScheduleJob.status eq '阻塞'}">
                                                            <span class="font-yellow-lemon">${qrtzScheduleJob.status}</span>
                                                        </c:if>
                                                        <c:if test="${qrtzScheduleJob.status eq '完成'}">
                                                            <span class="font-green">${qrtzScheduleJob.status}</span>
                                                        </c:if>
                                                    </td>
                                                    <td>
                                                            ${qrtzScheduleJob.cronExpression}
                                                    </td>
                                                    <td>
                                                            ${fns:getDictLabel(qrtzScheduleJob.isSync, 'yes_no', '')}
                                                    </td>
                                                    <td>
                                                            ${qrtzScheduleJob.url}
                                                    </td>
                                                    <c:if test="${qrtzScheduleJob.id ne ''}">
                                                        <td>
                                                            <fmt:formatDate value="${qrtzScheduleJob.updateDate}" pattern="yyyy-MM-dd HH:mm:ss" />
                                                        </td>
                                                        <td>
                                                            <shiro:hasPermission name="tools:qrtzScheduleJob:edit">
                                                                <a href="${ctx}/tools/qrtzScheduleJob/pauseScheduleJob?id=${qrtzScheduleJob.id}" class="btn btn-info btn-xs"><i class="fa fa-pause"></i>
                                                                    暂停</a>
                                                                <a href="${ctx}/tools/qrtzScheduleJob/resumeScheduleJob?id=${qrtzScheduleJob.id}" class="btn btn-info btn-xs"><i class="fa fa-reply"></i>
                                                                    恢复</a>
                                                                <a href="${ctx}/tools/qrtzScheduleJob/runOnceScheduleJob?id=${qrtzScheduleJob.id}" class="btn btn-info btn-xs"><i class="fa fa-play"></i>
                                                                    运行一次</a>
                                                            </shiro:hasPermission>
                                                            <shiro:hasPermission name="tools:qrtzScheduleJob:del">
                                                                <a href="${ctx}/tools/qrtzScheduleJob/delete?id=${qrtzScheduleJob.id}" onclick="return confirmx('确认要删除该任务调度吗？', this.href)" class="btn btn-danger btn-xs"><i class="fa fa-trash"></i>
                                                                    删除</a>
                                                            </shiro:hasPermission>
                                                        </td>
                                                    </c:if>
                                                </tr>
                                            </c:forEach>
                                            </tbody>
                                        </table>
                                    </div>
                                    <c:if test="${qrtzScheduleJob.normal ne '1'}">
                                        <table:page page="${page}"></table:page>
                                    </c:if>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<%@ include file="/views/include/foot.jsp" %>
<script type="text/javascript">
    $(document).ready(function () {
    });
</script>
</body>
</html>