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
    <title>${fns:getConfig('productName')} | 分配用户</title>
    <meta name="decorator" content="form"/>
</head>

<body style="background: white;">
<div class="form-body">
    <div style="padding: 5px;">
        <sys:message content="${message}"/>
        <button id="assignButton" type="submit" class="btn btn-primary btn-sm" style="margin-bottom: 10px;" title="添加人员"><i class="fa fa-plus"></i> 添加人员</button>
        <table class="table table-striped table-bordered table-hover">
            <tbody>
            <tr>
                <td class="active" style="width: 15%;">
                    <label class="pull-right"> 角色名称：</label>
                </td>
                <td style="width: 35%;">
                    ${role.name}
                </td>
                <td class="active" style="width: 15%;">
                    <label class="pull-right"> 归属机构：</label>
                </td>
                <td style="width: 35%;">
                    ${role.office.name}
                </td>
            </tr>
            <tr>
                <td class="active">
                    <label class="pull-right"> 英文名称：</label>
                </td>
                <td>
                    ${role.enname}
                </td>
                <td class="active">
                    <label class="pull-right"> 角色类型：</label>
                </td>
                <td>
                    ${role.roleType}
                </td>
            </tr>
            <tr>
                <td class="active">
                    <label class="pull-right"> 数据范围：</label>
                </td>
                <td colspan="3">
                    <c:set var="dictvalue" value="${role.dataScope}" scope="page" />
                    ${fns:getDictLabel(dictvalue, 'sys_data_scope', '')}
                </td>
            </tr>
            </tbody>
        </table>

        <form id="assignRoleForm" action="${ctx}/sys/role/assignrole" method="post" class="hide">
            <input type="hidden" name="id" value="${role.id}"/>
            <input id="idsArr" type="hidden" name="idsArr" value=""/>
        </form>

        <script type="text/javascript">
            $("#assignButton").click(function(){
                top.layer.open({
                    type: 2,
                    area: ['900px', '600px'],
                    title:"选择用户",
                    maxmin: true, //开启最大化最小化按钮
                    content: "${ctx}/sys/role/usertorole?id=${role.id}" ,
                    btn: ['确定', '关闭'],
                    yes: function(index, layero){
                        var pre_ids = layero.find("iframe")[0].contentWindow.pre_ids;
                        var ids = layero.find("iframe")[0].contentWindow.ids;
                        if(ids[0]==''){
                            ids.shift();
                            pre_ids.shift();
                        }

                        if(pre_ids.sort().toString() == ids.sort().toString()){
                            top.$.jBox.tip("未给角色【${role.name}】分配新成员！", 'info');
                            return false;
                        }

                        // 执行保存
                        loading('正在提交，请稍等...');
                        var idsArr = "";
                        for (var i = 0; i<ids.length; i++) {
                            idsArr = (idsArr + ids[i]) + (((i + 1)== ids.length) ? '':',');
                        }

                        $('#idsArr').val(idsArr);
                        $('#assignRoleForm').submit();
                        top.layer.close(index);
                    },
                    cancel: function(index){
                    }
                });
            });
        </script>

        <div class="table-scrollable">
            <table id="contentTable" class="table table-striped table-bordered table-hover">
                <thead>
                <tr>
                    <th>归属公司</th>
                    <th>归属部门</th>
                    <th>登录名</th>
                    <th>姓名</th>
                    <th>电话</th>
                    <th>手机</th>
                    <shiro:hasPermission name="sys:user:edit">
                        <th>操作</th>
                    </shiro:hasPermission></tr>
                </thead>
                <tbody>
                <c:forEach items="${userList}" var="user">
                    <tr>
                        <td>${user.company.name}</td>
                        <td>${user.office.name}</td>
                        <td><a href="${ctx}/sys/user/form?id=${user.id}">${user.loginName}</a></td>
                        <td>${user.name}</td>
                        <td>${user.phone}</td>
                        <td>${user.mobile}</td>
                        <shiro:hasPermission name="sys:role:edit">
                            <td>
                                <a href="${ctx}/sys/role/outrole?userId=${user.id}&roleId=${role.id}" onclick="return confirmx('确认要将用户<b>[${user.name}]</b>从<b>[${role.name}]</b>角色中移除吗？', this.href)">移除</a>
                            </td>
                        </shiro:hasPermission>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
</div>

<%@include file="/views/include/foot.jsp" %>
</body>
</html>