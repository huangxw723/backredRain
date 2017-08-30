<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.aoshi.util.PropertyUtils"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
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
		<link rel="stylesheet" href="static/css/datepicker.css" /><!-- 日期框 -->
		<!--引入弹窗组件start-->
		<script type="text/javascript" src="plugins/attention/zDialog/zDrag.js"></script>
		<script type="text/javascript" src="plugins/attention/zDialog/zDialog.js"></script>
		<!--引入弹窗组件end-->
		<!--提示框-->
		<script type="text/javascript" src="static/js/jquery.tips.js"></script>
		<script type="text/javascript" src="static/js/common/commonutils.js"></script>
		
  		
<script type="text/javascript">
	$(top.hangge());
	
	$(function() {
		$(".chzn-select").chosen(); 
		$(".chzn-select-deselect").chosen({allow_single_deselect:true}); 
		
		var operaResult = '${operaResult}';
		if(operaResult){
			alert(operaResult)
		}
	});
	
	$(function(){
		//日期框
		$('.date-picker').datepicker();
	});
	
	
	
	//更改图片
    function changeImg(){
        $("#fileInput").trigger("click");
    }
	
	//保存
	function save(){


		var oldPassword = $("#old_password").val();
		if(validateUtils.isEmpty(oldPassword)){
			$("#old_password").tips({
				side : 3,
				msg : '请输入原密码!',
				bg : '#AE81FF',
				time : 2
			});
			$("#old_password").focus();
			return
		}

		var password = $('#password').val();
		if(validateUtils.isEmpty(password)){
			$("#password").tips({
				side : 3,
				msg : '请输入新密码!',
				bg : '#AE81FF',
				time : 2
			});
			$("#password").focus();
			return
		}

		if (password.length >20 ||password.length < 6) {
			$("#password").tips({
				side : 3,
				msg : '密码长度6到20位!',
				bg : '#AE81FF',
				time : 2
			});
			$("#password").focus();
			return false;
		}

		if(oldPassword==password){
			$("#password").tips({
				side : 3,
				msg : '新密码不能与旧密码相同!',
				bg : '#AE81FF',
				time : 2
			});
			$("#password").focus();
			return
		}

		var confirmPassword = $('#confirm_password').val();
		if(validateUtils.isEmpty(confirmPassword)){
			$("#confirm_password").tips({
				side : 3,
				msg : '请输入确认密码!',
				bg : '#AE81FF',
				time : 2
			});
			$("#confirm_password").focus();
			return
		}
		if (confirmPassword.length >20 ||confirmPassword.length < 6) {
			$("#confirm_password").tips({
				side : 3,
				msg : '密码长度6到20位!',
				bg : '#AE81FF',
				time : 2
			});
			$("#confirm_password").focus();
			return false;
		}

		if(password != confirmPassword){
			$("#confirm_password").tips({
				side : 3,
				msg : '两次密码输入不一样!',
				bg : '#AE81FF',
				time : 2
			});
			$("#confirm_password").focus();
			return
		}


		   $.ajax({
			    type : "post",
		        url : "setting/updatePass",
		        dataType : "json",
				async: false,
				data : {
					oldPassword: oldPassword,
					password:password
				},
		        success : function (data) {
		        	if("0"==data.status){
		        		codeFlag = true;
		        		alert("修改成功");
						window.location.href="<%=basePath%>";
		    			return;
		    			//alert("验证码发送成功");				
		    	}else if("0"==data.status){
		    				alert("验证码错误")
			    			return;
		    			}
		    	else if("1"==data.status){
    				alert("系统繁忙，请联系管理员")
	    			return;
    			}else if("2"==data.status){
    				alert("原密码不正确")
	    			return;
    			}else if("3"==data.status){
    				alert("修改失败")
    				return;
    			}
		        }
		});
		
		
		
		
		
		
		// 提交表单
	//form.submit($('#usersForm'));
	

		/* $("#usersForm").submit();
		$("#zhongxin").hide();
		$("#zhongxin2").show(); */
		
	}

</script>
	</head>
<body>

	<form action="setting/updatePwd" name="usersForm" id="usersForm" method="post">
	<input type="hidden" name="close" id="close" value="0"/>
	<div id="zhongxin" >
	<table id="table_report" class="table table-striped table-bordered table-hover" style="overflow:scroll;">
	
		<tr height="45px">
			<td>原密码:</td>
			<td><input type="password" name="oldPassword" id="old_password"  placeholder="请输入原密码" style="width: 370px" onkeyup="validateUtils.replaceSpaceEmpty(this);"/></td>
		</tr>
		
		<tr height="45px">
			<td>新密码:</td>
			<td><input type="password" name="password" id="password"  placeholder="6到20位" style="width: 370px" onkeyup="validateUtils.replaceSpaceEmpty(this);"/></td>
		</tr>
		<tr height="45px">
			<td>确认密码:</td>
			<td><input type="password" name="confirmPassword" id="confirm_password"  placeholder="6到20位" style="width: 370px" onkeyup="validateUtils.replaceSpaceEmpty(this);"/></td>
		</tr>
		
		
		<tr>
					<td style="text-align: center;" colspan="2">
		                <a class="btn btn-mini btn-primary" onclick="save();">保存</a>
						&nbsp;&nbsp;&nbsp;&nbsp;
						<a class="btn btn-mini btn-danger" onclick="top.Dialog.close();">取消</a>
					</td>
				</tr>
             	
       
		
	</table>
	</div>
	
	<div id="zhongxin2" class="center" style="display:none">
      <br />
      <br />
      <br />
      <br />
      <br />
      <img src="static/images/jiazai.gif" />
      <br />
      <h4 class="lighter block green">提交中...</h4>
    </div>
    
	</form>

	<!-- 引入 -->
	<script type="text/javascript">window.jQuery || document.write("<script src='static/js/jquery-1.9.1.min.js'>\x3C/script>");</script>
	<script src="static/js/bootstrap.min.js"></script>
	<script src="static/js/ace-elements.min.js"></script>
	<script src="static/js/ace.min.js"></script>
	<script type="text/javascript" src="static/js/bootstrap-datepicker.min.js"></script><!-- 日期框 -->
	<script type="text/javascript" src="static/js/chosen.jquery.min.js"></script><!-- 下拉框 -->
	<script type="text/javascript" src="static/js/bootbox.min.js"></script><!-- 确认窗口 -->
		
	<script type="text/javascript" src="static/js/base64.js"></script>
	<!-- 压缩图片 -->

	<link rel="stylesheet" type="text/css" href="plugins/fancyBox/jquery.fancybox.css">
	<script type="text/javascript" src="plugins/fancyBox/jquery.fancybox.pack.js"></script>
	<!-- 查看图片 -->
	
	<script type="text/javascript">
	$(top.hangge());
	//上传
	$('#fileInput:visible').ace_file_input({
		no_file : '请选择图片 ...',
		btn_choose : '选择',
		btn_change : '更改',
		droppable : false,
		onchange : null,
		thumbnail : false,
		before_remove : function() {
			$("#url").val("");
			$("#imgBox").attr("href", "").hide();
			$("#imgHref").attr("src", "");
			return true;
		}
	});
	
	new img2base64("fileInput", "url", "imgHref", "imgBox");

	$("#imgBox").fancybox({
		helpers : {
			title : {
				type : 'inside'
			}
		}
	});
  </script>
</body>
</html>