<%@ tag language="java" pageEncoding="UTF-8" %>
<%@ include file="/views/include/taglib.jsp" %>
<%@ attribute name="id" type="java.lang.String" required="true" description="编号" %>
<%@ attribute name="form" type="java.lang.String" required="true" description="表单 ID" %>
<%@ attribute name="name" type="java.lang.String" required="true" description="输入框名称" %>
<%@ attribute name="type" type="java.lang.String" required="true" description="image、file、textarea"%>
<%@ attribute name="value" type="java.lang.String" required="true" description="输入框值" %>

<script src="${ctxStatic}/baidu-ueditor/ueditor.config.js" type="text/javascript"></script>
<script src="${ctxStatic}/baidu-ueditor/ueditor.all.js" type="text/javascript"></script>

<c:if test="${type eq 'textarea'}">
	<script id="container_content${id}" type="text/plain" style="width:100%; height: 500px;">${value}</script>
	<input type="hidden" id="content_input${id}" name="${name}" />
	<script>
	var ue${id} = UE.getEditor('container_content${id}');
	$("#${form}").bind("submit", function() {
		$("#content_input${id}").val(ue${id}.getContent());
		return true;
	});
	</script>
</c:if>

<c:if test="${type eq 'image' or type eq 'file'}">
	<div class="input-group">
		<input id="${id}" name="${name}" type="text" class="form-control" value="${value}" readonly="readonly" onclick="up${type}${id}();" style="cursor: pointer;" />
		<span class="input-group-btn">
			<button type="button" class="btn btn-primary" onclick="show${id}();"><i class="icon-cloud-download"></i></button>
		</span>
	</div>

	<script type="text/plain" id="j_ueditorupload${id}" style="height:5px;display:none;"></script>
	<script>
		// 实例化编辑器
		var o_ueditorupload${id} = UE.getEditor('j_ueditorupload${id}', {
			autoHeightEnabled: false
		});

		o_ueditorupload${id}.ready(function () {
			o_ueditorupload${id}.hide(); // 隐藏编辑器

			// 监听图片上传
			<c:if test="${type eq 'image'}">
				// 监听图片上传
				o_ueditorupload${id}.addListener('beforeInsertImage', function (t, arg) {
				$("#${id}").val(arg[0].src).trigger('change');
				});
			</c:if>

			// 监听附件上传
			<c:if test="${type eq 'file'}">
				o_ueditorupload${id}.addListener('afterUpfile', function (t, arg) {
				$("#${id}").val(arg[0].url);
				});
			</c:if>
		});

		// 弹出上传的对话框
		function up${type}${id}() {
			var my${type}${id} = o_ueditorupload${id}.getDialog("${type eq 'image' ? 'insertimage' : 'attachment'}");
			my${type}${id}.open();
		}

		// 查看
		function show${id}() {
			windowOpen($("#${id}").val(), "", "900px", "600px");
		}
	</script>
</c:if>