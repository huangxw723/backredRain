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

	var isExist = false;

	var isExistPhone = false;

	$(function() {
		$(".chzn-select").chosen(); 
		$(".chzn-select-deselect").chosen({allow_single_deselect:true}); 
		
		var operaResult = '${operaResult}';
		if(operaResult){
			alert(operaResult)
		}

		//鼠标失焦后用户名验证
		$("#account").blur(function(){

			var account = $('#account').val();
				if(!validateUtils.isEmpty(account)){
					$.ajax({
						type: "POST",
						url: '<%=basePath%>account/isExist.do',
						data: {account:account},
						dataType:'json',
						cache: false,
						success: function(data){
							if(data){
								isExist = true;
								$("#account").tips({
									side:3,
									msg:'该用户名已被注册!',
									bg:'#AE81FF',
									time:2
								});
								$("#account").focus();
								return false;
							}else{
								isExist = false;
							}
						}
					});
			}
		});

        //鼠标失焦后手机号码验证
        $("#phone").blur(function(){

            var phone = $('#phone').val();
            if(!validateUtils.isEmpty(phone)){
                $.ajax({
                    type: "POST",
                    url: '<%=basePath%>account/isExistPhone.do',
                    data: {phone:phone},
                    dataType:'json',
                    cache: false,
                    success: function(data){
                        if(data){
                            isExistPhone = true;
                            $("#phone").tips({
                                side:3,
                                msg:'该手机号码已被使用!',
                                bg:'#AE81FF',
                                time:2
                            });
                            $("#phone").focus();
                            return false;
                        }else{
                            isExistPhone = false;
                        }
                    }
                });
            }
        });


	});

	//保存
	function save(){

		if(isExist){
			$("#account").tips({
				side:3,
				msg:'该用户名已被注册!',
				bg:'#AE81FF',
				time:2
			});
			$("#account").focus();
			return false;
		}

        if(isExistPhone){
            $("#phone").tips({
                side:3,
                msg:'该手机号码已被使用!',
                bg:'#AE81FF',
                time:2
            });
            $("#phone").focus();
            return false;
        }

		var account = $('#account').val();
		if(validateUtils.isEmpty(account)){
			$("#account").tips({
				side : 3,
				msg : '请输入用户名!',
				bg : '#AE81FF',
				time : 2
			});
			$("#account").focus();
			return
		}

		 var nameReg =  new RegExp("^([\u4E00-\uFA29]|[\uE7C7-\uE7F3]|[a-zA-Z0-9_]){2,15}$");
		if(!nameReg.test($("#account").val())){
			$("#account").tips({
				side : 3,
				msg : '用户名不符合规范！',
				bg : '#AE81FF',
				time : 2
			});
			$("#account").focus();
			return false;
		}

		var password = $('#password').val();
		if(validateUtils.isEmpty(password)){
			$("#password").tips({
				side : 3,
				msg : '请设置密码!',
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

        var phone = $('#phone').val();
        if(validateUtils.isEmpty(phone)){
            $("#phone").tips({
                side:3,
                msg:'手机号码不能为空！',
                bg:'#AE81FF',
                time:2
            });
            $("#phone").focus();
            return false;
        }
        if(!validateUtils.isMobilePhone(phone)){
            $("#phone").tips({
                side:3,
                msg:'请填写正确的手机号码！',
                bg:'#AE81FF',
                time:2
            });
            $("#phone").focus();
            return false;
        }


		// 提交表单
	 	form.submit($('#usersForm'));

		/* $("#usersForm").submit();
		$("#zhongxin").hide();
		$("#zhongxin2").show(); */
		
	}

</script>
	</head>
<body>

	<form action="account/saveAccountOpera" name="usersForm" id="usersForm" method="post">

	<div id="zhongxin" >
	<table id="table_report" class="table table-striped table-bordered table-hover" style="overflow:scroll;">

		<tr height="45px">
			<td>商户类型:</td>
			<td>
				<input type="radio" id="type" name="type" value="1" checked="checked"/>
				<span class="lbl"> 商场</span>
				<input type="radio" id="type" name="type"  value="2" />
				<span class="lbl"> 店铺</span>
			</td>
		</tr>
		<tr height="45px">
			<td>用户名:</td>
			<td><input type="text" name="account" id="account"   placeholder="2-15位，中文、英文 下划线"  style="width: 370px" onkeyup="validateUtils.replaceSpaceEmpty(this);"  /></td>
		</tr>
		

		<tr height="45px">
			<td>设置密码:</td>
			<td><input type="password" name="password" id="password"  placeholder="6到20位" style="width: 370px" onkeyup="validateUtils.replaceSpaceEmpty(this);"/></td>
		</tr>
		<tr height="45px">
			<td>确认密码:</td>
			<td><input type="password" name="confirmPassword" id="confirm_password"  placeholder="6到20位" style="width: 370px" onkeyup="validateUtils.replaceSpaceEmpty(this);"/></td>
		</tr>
		<tr height="45px">
			<td>预留手机号码:</td>
			<td><input type="number" name="phone" id="phone"  placeholder="用于找回密码" style="width: 370px" onkeyup="validateUtils.replaceNotNumEmpty(this);"/></td>
		</tr>
		<tr height="45px">
			<td style="text-align: center;" colspan="2"></td>
		</tr>

		<tr >
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