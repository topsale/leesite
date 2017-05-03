var locat = (window.location+'').split('/'); 
$(function(){if('tool'== locat[3]){locat =  locat[0]+'//'+locat[2];}else{locat =  locat[0]+'//'+locat[2]+'/'+locat[3];};});

//清除空格
String.prototype.trim=function(){
     return this.replace(/(^\s*)|(\s*$)/g,'');
};

function uploadTwo(){
	if($("#uploadify1").val()){
		top.layer.alert('请选择二维码！', {icon: 0});
	return false;
	}
	$('#uploadify1').uploadifyUpload();
}	

//去后台解析二维码返回解析内容
function readContent(str){
	$.ajax({
		type: "POST",
		url: locat+'/tools/TwoDimensionCodeController/readTwoDimensionCode',
    	data: {imgId:str,tm:new Date().getTime()},
		dataType:'json',
		cache: false,
		success: function(data){
			 if("success" == data.result){
				 if('null' == data.readContent || null == data.readContent){
					 top.layer.alert('读取失败，二维码无效！', {icon: 0});
				 }else{
					 $("#readContent").text(data.readContent);
				 }
			 }else{
				 top.layer.alert('后台读取出错！', {icon: 0});
				 return;
			 }
		}
	});
}

//生成二维码
function createTwoD(){
	if($("#encoderContent").val()==""){
		top.layer.alert('输入框不能为空！', {icon: 0});
		$("#encoderContent").focus();
		return false;
	}
	$.ajax({
		type: "POST",
		url: locat+'/tools/TwoDimensionCodeController/createTwoDimensionCode.do',
    	data: {encoderContent:$("#encoderContent").val(),tm:new Date().getTime()},
		dataType:'json',
		cache: false,
		success: function(data){
			 
			 if(data.success){
				 $("#encoderImgId").attr("src",data.body.filePath);       
			 }else{
				 top.layer.alert('生成二维码失败！', {icon: 0});
				 return false;
			 }
			 
			 
		}
	});
	return true;
}