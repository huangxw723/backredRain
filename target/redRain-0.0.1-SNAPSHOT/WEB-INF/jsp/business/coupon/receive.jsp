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
		<!--日期格式化-->
		<script type="text/javascript" src="static/js/dateFormat.js"></script>
  		

	</head>
<body>

	<form action="coupon/couponsReceiveHistory.do" name="usersForm" id="usersForm" method="post">
	<div id="zhongxin" >
     <table id="table_report" class="table table-striped table-hover" >			
				<tr><td style="text-align: center;" colspan="2" ><font size="5">兑换礼品</font></td></tr>
			    <tr style="text-align: center;">
						<td style="text-align: right;"><h3>兑换编号:</h3></td>
						<td style="text-align: left;"><input type="text" id="sn" name="sn" style="height:50px;"></td>									
				</tr>
			
				<tr id="operaArea">
			      <td style="text-align: center;" colspan="2" >
                  <a class="btn btn-mini btn-primary" onclick="receive()" style="width: 90px; height: 34px; line-height:34px">兑换</a>
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
	<!--引入弹窗组件start-->
	<script type="text/javascript" src="plugins/attention/zDialog/zDrag.js"></script>
	<script type="text/javascript" src="plugins/attention/zDialog/zDialog.js"></script>
	<!--引入弹窗组件end-->
	<!--提示框-->
	<script type="text/javascript" src="static/js/jquery.tips.js"></script>
	<script type="text/javascript" src="static/js/common/commonutils.js"></script>	
	<script type="text/javascript">
	$(top.hangge());
    function receive(){
     var no = $("#sn").val();  
     if(validateUtils.isEmpty(no)){
			$("#sn").tips({
				side:3,
	            msg:'请输入要兑换的编号',
	            bg:'#AE81FF',
	            time:2
	        });
			$("#sn").focus();
			return false;
		}
      
		 $.ajax({
			type: "POST",
			url: '<%=basePath%>coupon/editReceive.do',
	    	data: {sn:no},
			dataType:'json',
			cache: false,
			success: function(data){
				if(data == 100){
					alert("优惠券使用时间有问题");
					top.Dialog.close();
				}else if(data == 200){
					alert("无效的优惠券");
					top.Dialog.close();
				}else if(data == 50){
					alert("优惠券未到开始时间");
					top.Dialog.close();
				}else if(data == 300){
					alert("优惠券已过期");
					 top.Dialog.close();
				}else if(data == 400){
					alert("不是本店铺的优惠券");
					 top.Dialog.close();
				}else if(data == 500){
					alert("优惠券已经被使用");
					 top.Dialog.close();
				}else if(data == 600){
					alert("尚未领取");
					 top.Dialog.close();
				}else if(data == 700){
					alert("兑换成功");
					 top.Dialog.close();
				}else if(data == 800){
					alert("没有该权限");
					 top.Dialog.close();
				}
			}
		}); 
    }			
			
	</script>
</body>
</html>