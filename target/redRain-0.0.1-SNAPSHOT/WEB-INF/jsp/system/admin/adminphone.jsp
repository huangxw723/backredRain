<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="com.aoshi.util.PropertyUtils"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	String httpUrl = PropertyUtils.getHTTP_URL();
	
%>
<!DOCTYPE html>
<html lang="en">
<head>
<base href="<%=basePath%>">
<meta charset="utf-8" />
<title></title>
<meta name="description" content="overview & stats" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<link href="static/css/bootstrap.min.css" rel="stylesheet" />
<link href="static/css/bootstrap-responsive.min.css" rel="stylesheet" />
<link rel="stylesheet" href="static/css/font-awesome.min.css" />
<!-- 下拉框 -->
<link rel="stylesheet" href="static/css/chosen.css" />
<link rel="stylesheet" href="static/css/ace.min.css" />
<link rel="stylesheet" href="static/css/ace-responsive.min.css" />
<link rel="stylesheet" href="static/css/ace-skins.min.css" />
<script type="text/javascript" src="static/js/jquery-1.7.2.js"></script>
<link rel="stylesheet" href="static/css/datepicker.css" />
<!-- 日期框 -->
<!--引入弹窗组件start-->
<script type="text/javascript" src="plugins/attention/zDialog/zDrag.js"></script>
<script type="text/javascript"
	src="plugins/attention/zDialog/zDialog.js"></script>
<!--引入弹窗组件end-->
<!--提示框-->
<script type="text/javascript" src="static/js/jquery.tips.js"></script>
<script type="text/javascript" src="static/js/common/commonutils.js"></script>
<script src="static/js/base64Compress.js"></script>
<script src="static/js/layer/layer.js"></script>



<script type="text/javascript">

function checkPhone(){
	var phone = $("#adminPhone").val();
	if (!phone.match(/^(((13[0-9]{1})|(15[0-9]{1})|(18[0-9]{1})|(17[0-9]{1}))+\d{8})$/)) { 
		alert("手机号码格式有误");
		return ;
		}
	
}

//发送验证码
function sendSms(obj){ 
	var phone = $("#adminPhone").val();
	   $.ajax({
		    type : "post",
	        url : "user/sms",
	        dataType : "json",
			async: false,
			data : {
				phone: phone
			},
	        success : function (data) {
	        	if("0"==data.status){
	        		settime(obj)
	    			alert("验证码发送成功");
	    			return;
	    			}else{
	    				alert("验证码发送失败")
		    			return;
	    			}
	        }
	});
} 
	var codeFlag = false;
	function checkSms(){
		var phone = $("#adminPhone").val();
		var code = $("#phoneCode").val();

		   $.ajax({
			    type : "post",
		        url : "user/checkVerifyCode",
		        dataType : "json",
				async: false,
				data : {
					phone: phone,
					code:code
				},
		        success : function (data) {
		        	if("0"==data.status){
		        		codeFlag = true;
		        		
		        		//alert("验证正确");
		    			return;
		    			//alert("验证码发送成功");				
		    			}else{
		    				alert("验证码错误")
			    			return;
		    			}
		        }
		});
}

	function sendSave(){
		var adminInfoId= $("#adminInfoId").val();
		//checkSms();
		if(!codeFlag){
			alert("验证码错误")
			return;
			}
	//	if(codeFlag){
			 var form = $("#phoneForm");
			 top.jzts();
			 var diag = new top.Dialog();
			 diag.Drag=true;
			 diag.Title ="修改绑定手机";
			 diag.URL = '<%=basePath%>user/sendUpdateAdminPhone?adminInfoId='+adminInfoId;
			 diag.Width = 1150;
			 diag.Height = 610;
			 diag.CancelEvent = function(){ //关闭事件
				diag.close();
				form.submit();
			 //window.location.href="user/phone";
			 };
			 diag.show();
		/* }else{
			alert("请输入正确的验证码");
			return;
		} */
		
		
/* 		var phone = $("#adminPhone").val();
		var code = $("#phoneCode").val();
		var adminInfoId = $("#adminInfoId").val();
	
		if(codeFlag){
			$.ajax({
			    type : "post",
		        url : "user/updateAdminPhone",
		        dataType : "json",
				async: false,
				data : {
					phone: phone,
					code:code,
					adminInfoId:adminInfoId
				},
		        success : function (data) {
		        	if("0"==data.status){
		        		alert("修改成功");
		        		
						//setTimeout("self.location=self.location",100);
						return;
		    			}
		        	else if("1"==data.status) {
		    				alert("修改失败");
							setTimeout(window.location.href="user/phone",100);
			    			return;
		    		}else if("2"==data.status){
	    				alert("验证码已过期");
	    				return;
		    		}
		        }
		});
		}else{
			alert("请输入正确的验证码");
			return;
		} */
	}
	
	
	
	
	//验证码倒计时
	var countdown = 60;
	function settime(obj) {
	 	var phone = jQuery("#adminPhone").val();
		if (phone == null || $.trim(phone).length == 0) {
			//$("#phonemessage").html("<i class='' id='messagetyle'></i><span>手机号码不能为空</span>");
			alert("手机号码不能为空");
			return false;
		}
		if (countdown == 0) {
			obj.removeAttribute("disabled");
			//$('#textCode').addClass('codeType');
			$("#textCode").text("获取验证码");
			countdown = 60;
			return;
		} else {
			obj.setAttribute("disabled", true);
			//var msg = ;
			$("#textCode").text("重新发送(" + countdown + ")");
			//obj.value = "重新发送(" + countdown + ")";
			countdown--;
		}
		setTimeout(function() {
			settime(obj)
		}, 1000) 
	}
	
	
	
	
	
	
	
</script>

</head>
<body>
	<form action="user/phone" name="phoneForm" id="phoneForm"
		method="post" >
		<div id="">
			<table id="table_report"
				class="table table-striped table-bordered table-hover"
				style="overflow: scroll;">

				<tr height="45px">
					<td>手机号</td>
					<td><input type="number" onblur="checkPhone()" name="adminPhone"
						id="adminPhone" style="width: 370px"
						value="${adminPhone}" />
				</tr> 

				<tr height="45px">
					<td>验证码</td>
					<td><input  onchange="checkSms();" type="number" name="phoneCode"
						id="phoneCode" style="width: 370px"
						value="" />
				<button class="btn btn-mini btn-primary" onclick="sendSms(this);"><span class="" id="textCode">获取验证码</span></button>
						</td>
				
				</tr>
			<input type="hidden" name="userId" id="userId" style="width: 370px" value="${userId}" "/>
			
			<input type="hidden" name="adminInfoId" id="adminInfoId" style="width: 370px" value="${adminInfoId}" "/>
			
				<tr id="operaArea">
					<td style="text-align: center;" colspan="2"><a
						class="btn btn-mini btn-primary" onclick="sendSave();">下一步</a> <a
						class="btn btn-mini btn-danger" href="user/phone">取消</a></td>
				</tr>
			</table>
		</div>
	</form>

</body>
</html>