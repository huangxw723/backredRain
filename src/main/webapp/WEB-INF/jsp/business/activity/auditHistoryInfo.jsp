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
		<!--引入弹窗组件start-->
		<script type="text/javascript" src="plugins/attention/zDialog/zDrag.js"></script>
		<script type="text/javascript" src="plugins/attention/zDialog/zDialog.js"></script>
		<!--引入弹窗组件end-->
		<!--提示框-->
		<script type="text/javascript" src="static/js/jquery.tips.js"></script>
		<script type="text/javascript" src="static/js/common/commonutils.js"></script>
		
  		
<script type="text/javascript">
	$(top.hangge());

</script>
	</head>
<body>

	<form method="post">

	<div id="zhongxin" >
	<table id="table_report" class="table table-striped table-hover" style="overflow:scroll;">
	     <div>活动编号: ${event.asEventId}</div>
	     </br>
		 
			<tr height="45px">
				<td>商户名称：</td>
				<td><input   disabled="disabled"  type="text"  value="${event.shopName}" style="width: 670px" /></td>
			</tr>

			<tr height="45px">
				<td>活动名称：</td>
				<td><input    type="text" disabled="disabled"  value="${event.eventName}" style="width: 670px" /></td>
			</tr>
			<tr height="45px">
				<td>活动主题：</td>
				<td><input    type="text" disabled="disabled" value="${event.eventTitle}" style="width: 670px" /></td>
			</tr>

			<tr height="45px">
			    <td>活动时间：</td>
				<td ><input type="text" disabled="disabled" value="${event.startTime}~${event.endTime}" style="width: 670px"  /></td>
			</tr>

			<tr height="45px">
				<td>活动logo：</td>
				<td >
					<a class="fancybox" href="<%=httpUrl%>${event.eventLogo}">
						<img src="<%=httpUrl%>${event.eventLogo}" width="50px" height="50px" />
					</a>
				</td>
			</tr>

			<tr height="45px">		   
				<td>活动详情：</td>
				<td>
					<textarea style="width:1000px;height:259px;" disabled="disabled"  id="eventDetail" >
						${event.eventDetail}
					</textarea>
				</td>
				
			</tr>
			
			<tr height="100px">
				<td>审批理由：</td>
				<td colspan="3">
					 <textarea style="width:670px;height:200px"  disabled="disabled">${event.reason}</textarea>
				</td>
			</tr>
			<tr height="100px">
				<td colspan="4">
					<c:if test="${event.auditStatus == 1}">
						<img alt="" src="static/img/prizeConfigyes.png">
					</c:if>
					<c:if test="${event.auditStatus == 2}">
						<img alt="" src="static/img/prizeConfigpas.png">
					</c:if>
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
	<script type="text/javascript" src="static/js/chosen.jquery.min.js"></script><!-- 下拉框 -->
	<script type="text/javascript" src="static/js/bootbox.min.js"></script><!-- 确认窗口 -->
		
	<!-- 压缩图片 -->
	<script type="text/javascript" src="static/js/base64.js"></script>

	<!--编辑器  -->
	<script src="plugins/ckeditor/ckeditor.js"></script>
	<script src="plugins/ckeditor/config.js"></script>

	<link rel="stylesheet" type="text/css" href="plugins/fancyBox/jquery.fancybox.css">
	<script type="text/javascript" src="plugins/fancyBox/jquery.fancybox.pack.js"></script>
	<!-- 查看图片 -->
	<script type="text/javascript" src="static/js/chosen.jquery.min.js"></script><!-- 下拉框 -->
	<script type="text/javascript">

		$(top.hangge());

		//初始化编辑器
		CKEDITOR.replace('eventDetail',{
			width:678,
			//fontSize_defaultLabel:26,

		});

		$(function() {
			$(".fancybox").fancybox({
				helpers: {
					title: {
						type: 'inside'
					}
				}
			});

		});
	
  </script>
</body>
</html>