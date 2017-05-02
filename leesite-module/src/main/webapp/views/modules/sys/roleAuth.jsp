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
    <title>${fns:getConfig('productName')} | 角色管理</title>
    <meta name="decorator" content="form"/>
    <%@include file="/views/include/treeview.jsp" %>
</head>

<body style="background: white;">
<div class="form-body">
    <form:form id="inputForm" modelAttribute="role" action="${ctx}/sys/role/save" method="post" class="form-horizontal">
        <form:hidden path="id"/>
        <input  name="office.id" type="hidden" value="${role.office.id}">
        <input  name="office.name" type="hidden" value="${role.office.name}">
        <input  name="name" type="hidden" value="${role.name}">
        <input  name="oldName" type="hidden" value="${role.name}">
        <input  name="enname" type="hidden" value="${role.enname}">
        <input  name="oldEnname" type="hidden" value="${role.enname}">
        <input  name="roleType" type="hidden" value="${role.roleType}">
        <input  name="sysData" type="hidden" value="${role.sysData}">
        <input  name="useable" type="hidden" value="${role.useable}">
        <input  name="dataScope" type="hidden" value="${role.dataScope}">
        <input  name="remarks" type="hidden" value="${role.remarks}">
        <div id="menuTree" class="ztree" style="margin-top:3px;float:left;"></div>
        <form:hidden path="menuIds"/>
        <form:hidden path="officeIds"/>
    </form:form>
</div>

<%@include file="/views/include/foot.jsp" %>
<script type="text/javascript">
    var validateForm;
    function doSubmit() { // 回调函数，在编辑和保存动作时，供openDialog调用提交表单。
        if (validateForm.form()) {
            $("#inputForm").submit();
            return true;
        }
        return false;
    }

    $(document).ready(function () {
        validateForm = $("#inputForm").validate({
            errorElement: 'span',
            errorClass: 'help-inline border-red font-red',
            focusInvalid: false,
            errorContainer: "#messageBox",

            submitHandler: function (form) {
                var ids = [], nodes = tree.getCheckedNodes(true);
                for(var i=0; i<nodes.length; i++) {
                    ids.push(nodes[i].id);
                }
                $("#menuIds").val(ids);
                loading('正在提交，请稍等...');
                form.submit();
            },
            errorPlacement: function (error, element) {
                $("#messageBox").text("输入有误，请先更正");
                if (element.is(":checkbox") || element.is(":radio") || element.parent().is(".input-append")) {
                    error.appendTo(element.parent().parent());
                } else {
                    error.insertAfter(element);
                }
            }
        });

        var setting = {
            check: {enable: true, nocheckInherit: true}, view: {selectedMulti: false},
            data: {simpleData: {enable: true}}, callback: {
                beforeClick: function (id, node) {
                    tree.checkNode(node, !node.checked, true, true);
                    return false;
                }
            }
        };

        // 用户-菜单
        var zNodes = [
                <c:forEach items="${menuList}" var="menu">{
                id: "${menu.id}",
                pId: "${not empty menu.parent.id?menu.parent.id:0}",
                name: "${not empty menu.parent.id?menu.name:'权限列表'}"
            },
            </c:forEach>];

        // 初始化树结构
        var tree = $.fn.zTree.init($("#menuTree"), setting, zNodes);

        // 不选择父节点
        tree.setting.check.chkboxType = {"Y": "ps", "N": "s"};

        // 默认选择节点
        var ids = "${role.menuIds}".split(",");
        for (var i = 0; i < ids.length; i++) {
            var node = tree.getNodeByParam("id", ids[i]);
            try {
                tree.checkNode(node, true, false);
            } catch (e) {
            }
        }

        // 默认展开全部节点
        tree.expandAll(true);
    });
</script>
</body>
</html>