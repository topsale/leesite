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
    <title>${fns:getConfig('productName')} | 代码生成</title>
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
                <t:menu menu="${fns:getTopMenu()}" parentName="代码生成" currentName="业务表配置"></t:menu>
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
                                <span class="caption-subject bold font-grey-gallery uppercase"> 业务表${not empty genTable.id?'修改':'添加'} </span>
                                <span class="caption-helper"></span>
                            </div>
                            <div class="tools">
                                <a href="" class="fullscreen"> </a>
                            </div>
                        </div>
                        <div class="portlet-body">
                            <c:choose>
                                <c:when test="${empty genTable.name}">
                                    <form:form id="inputForm" modelAttribute="genTable" action="${ctx}/gen/genTable/form" method="post" class="form-horizontal">
                                        <form:hidden path="id"/>
                                        <sys:message content="${message}"/>

                                        <table class="table table-striped table-bordered table-hover">
                                            <tbody>
                                            <tr>
                                                <td class="active" style="width: 15%;">
                                                    <label class="pull-right"> 表名：</label>
                                                </td>
                                                <td>
                                                    <form:select path="name" class="form-control">
                                                        <form:options items="${tableList}" itemLabel="nameAndComments" itemValue="name" htmlEscape="false"/>
                                                    </form:select>
                                                </td>
                                            </tr>
                                            </tbody>
                                        </table>
                                        <div class="form-actions">
                                            <input id="btnSubmit" class="btn btn-primary btn-sm" type="submit" value="下一步"/>&nbsp;
                                            <input id="btnCancel" class="btn btn-default btn-sm" type="button" value="返 回" onclick="history.go(-1)"/>
                                        </div>
                                    </form:form>
                                </c:when>
                                <c:otherwise>
                                    <form:form id="inputForm" modelAttribute="genTable" action="${ctx}/gen/genTable/save" method="post" class="form-horizontal">
                                        <form:hidden path="id"/>
                                        <sys:message content="${message}"/>

                                        <table class="table table-striped table-bordered table-hover">
                                            <tr>
                                                <td class="active" style="width: 15%;">
                                                    <label class="pull-right"> <span style="color: #E7505A;"> * </span>表名：</label>
                                                </td>
                                                <td colspan="3">
                                                    <form:input path="name" htmlEscape="false" maxlength="200" class="form-control required" readonly="true" />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="active">
                                                    <label class="pull-right"> <span style="color: #E7505A;"> * </span>说明：</label>
                                                </td>
                                                <td colspan="3">
                                                    <form:input path="comments" htmlEscape="false" maxlength="200" class="form-control required"/>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="active">
                                                    <label class="pull-right"> <span style="color: #E7505A;"> * </span>类名：</label>
                                                </td>
                                                <td colspan="3">
                                                    <form:input path="className" htmlEscape="false" maxlength="200" class="form-control required"/>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="active">
                                                    <label class="pull-right"> 父表表名：</label>
                                                </td>
                                                <td>
                                                    <form:select path="parentTable" cssClass="form-control">
                                                        <form:option value="">无</form:option>
                                                        <form:options items="${tableList}" itemLabel="nameAndComments" itemValue="name" htmlEscape="false"/>
                                                    </form:select>
                                                </td>
                                                <td class="active">
                                                    <label class="pull-right"> 当前表外键：</label>
                                                </td>
                                                <td>
                                                    <form:select path="parentTableFk" cssClass="form-control">
                                                        <form:option value="">无</form:option>
                                                        <form:options items="${genTable.columnList}" itemLabel="nameAndComments" itemValue="name" htmlEscape="false"/>
                                                    </form:select>
                                                    <span class="help-inline">如果有父表，请指定父表表名和外键</span>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="active">
                                                    <label class="pull-right"> 备注：</label>
                                                </td>
                                                <td colspan="3">
                                                    <form:textarea path="remarks" htmlEscape="false" rows="3" maxlength="200" class="form-control"/>
                                                </td>
                                            </tr>
                                        </table>

                                        <div class="table-scrollable">
                                            <table id="contentTable" class="table table-striped table-bordered table-hover">
                                                <thead>
                                                <tr>
                                                    <th title="数据库字段名">列名</th>
                                                    <th title="默认读取数据库字段备注">说明</th>
                                                    <th title="数据库中设置的字段类型及长度">物理类型</th>
                                                    <th title="实体对象的属性字段类型">Java类型</th>
                                                    <th title="实体对象的属性字段（对象名.属性名|属性名2|属性名3，例如：用户user.id|name|loginName，属性名2和属性名3为Join时关联查询的字段）">
                                                        Java属性名称 <i class="icon-question-sign"></i></th>
                                                    <th title="是否是数据库主键">主键</th>
                                                    <th title="字段是否可为空值，不可为空字段自动进行空值验证">可空</th>
                                                    <th title="选中后该字段被加入到insert语句里">插入</th>
                                                    <th title="选中后该字段被加入到update语句里">编辑</th>
                                                    <th title="选中后该字段被加入到查询列表里">列表</th>
                                                    <th title="选中后该字段被加入到查询条件里">查询</th>
                                                    <th title="该字段为查询字段时的查询匹配放松">查询匹配方式</th>
                                                    <th title="字段在表单中显示的类型">显示表单类型</th>
                                                    <th title="显示表单类型设置为“下拉框、复选框、点选框”时，需设置字典的类型">字典类型</th>
                                                    <th>排序</th>
                                                </tr>
                                                </thead>
                                                <tbody>
                                                <c:forEach items="${genTable.columnList}" var="column" varStatus="vs">
                                                    <tr${column.delFlag eq '1'?' class="error" title="已删除的列，保存之后消失！"':''}>
                                                        <td nowrap>
                                                            <input type="hidden" name="columnList[${vs.index}].id" value="${column.id}"/>
                                                            <input type="hidden" name="columnList[${vs.index}].delFlag" value="${column.delFlag}"/>
                                                            <input type="hidden" name="columnList[${vs.index}].genTable.id" value="${column.genTable.id}"/>
                                                            <input type="hidden" name="columnList[${vs.index}].name" value="${column.name}"/>${column.name}
                                                        </td>
                                                        <td>
                                                            <input type="text" name="columnList[${vs.index}].comments" value="${column.comments}" maxlength="200" class="form-control required" style="width:100px;"/>
                                                        </td>
                                                        <td nowrap>
                                                            <input type="hidden" name="columnList[${vs.index}].jdbcType" value="${column.jdbcType}"/>${column.jdbcType}
                                                        </td>
                                                        <td>
                                                            <select name="columnList[${vs.index}].javaType" class="required form-control" style="width:100px;*width:90px">
                                                                <c:forEach items="${config.javaTypeList}" var="dict">
                                                                    <option value="${dict.value}" ${dict.value==column.javaType?'selected':''} title="${dict.description}">${dict.label}</option>
                                                                </c:forEach>
                                                            </select>
                                                        </td>
                                                        <td>
                                                            <input type="text" name="columnList[${vs.index}].javaField" value="${column.javaField}" maxlength="200" class="required form-control"/>
                                                        </td>
                                                        <td>
                                                            <input class="icheck" type="checkbox" name="columnList[${vs.index}].isPk" value="1" ${column.isPk eq '1' ? 'checked' : ''}/>
                                                        </td>
                                                        <td>
                                                            <input class="icheck" type="checkbox" name="columnList[${vs.index}].isNull" value="1" ${column.isNull eq '1' ? 'checked' : ''}/>
                                                        </td>
                                                        <td>
                                                            <input class="icheck" type="checkbox" name="columnList[${vs.index}].isInsert" value="1" ${column.isInsert eq '1' ? 'checked' : ''}/>
                                                        </td>
                                                        <td>
                                                            <input class="icheck" type="checkbox" name="columnList[${vs.index}].isEdit" value="1" ${column.isEdit eq '1' ? 'checked' : ''}/>
                                                        </td>
                                                        <td>
                                                            <input class="icheck" type="checkbox" name="columnList[${vs.index}].isList" value="1" ${column.isList eq '1' ? 'checked' : ''}/>
                                                        </td>
                                                        <td>
                                                            <input class="icheck" type="checkbox" name="columnList[${vs.index}].isQuery" value="1" ${column.isQuery eq '1' ? 'checked' : ''}/>
                                                        </td>
                                                        <td>
                                                            <select name="columnList[${vs.index}].queryType" class="required form-control">
                                                                <c:forEach items="${config.queryTypeList}" var="dict">
                                                                    <option value="${fns:escapeHtml(dict.value)}" ${fns:escapeHtml(dict.value)==column.queryType?'selected':''} title="${dict.description}">${fns:escapeHtml(dict.label)}</option>
                                                                </c:forEach>
                                                            </select>
                                                        </td>
                                                        <td>
                                                            <select name="columnList[${vs.index}].showType" class="form-control required" style="width:150px;">
                                                                <c:forEach items="${config.showTypeList}" var="dict">
                                                                    <option value="${dict.value}" ${dict.value==column.showType?'selected':''} title="${dict.description}">${dict.label}</option>
                                                                </c:forEach>
                                                            </select>
                                                        </td>
                                                        <td>
                                                            <input type="text" name="columnList[${vs.index}].dictType" value="${column.dictType}" maxlength="200" class="form-control"/>
                                                        </td>
                                                        <td>
                                                            <input type="text" name="columnList[${vs.index}].sort" value="${column.sort}" maxlength="200" class="required form-control digits" style="width: 80px;" />
                                                        </td>
                                                    </tr>
                                                </c:forEach>
                                                </tbody>
                                            </table>
                                        </div>
                                        <div class="form-actions pull-right">
                                            <shiro:hasPermission name="gen:genTable:edit"><input id="btnSubmit" class="btn btn-primary btn-sm" type="submit" value="保 存"/>&nbsp;</shiro:hasPermission>
                                            <input id="btnCancel" class="btn btn-default btn-sm" type="button" value="返 回" onclick="history.go(-1)"/>
                                        </div>
                                        <div class="clearfix"></div>
                                    </form:form>
                                </c:otherwise>
                            </c:choose>
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
        $("#inputForm").validate({
            errorElement: 'span',
            errorClass: 'help-inline border-red font-red',
            focusInvalid: false,
            errorContainer: "#messageBox",

            submitHandler: function (form) {
                loading('正在提交，请稍等...');
                $("input[type=checkbox]").each(function () {
                    $(this).after("<input type=\"hidden\" name=\"" + $(this).attr("name") + "\" value=\""
                        + ($(this).attr("checked") ? "1" : "0") + "\"/>");
                    $(this).attr("name", "_" + $(this).attr("name"));
                });
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
    });
</script>
</body>
</html>