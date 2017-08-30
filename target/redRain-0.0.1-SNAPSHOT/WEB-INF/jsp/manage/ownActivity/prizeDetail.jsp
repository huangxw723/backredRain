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
		<link rel="stylesheet" href="static/css/bootstrap-datetimepicker.min.css" /><!-- 日期框 -->
		<!-- <link rel="stylesheet" href="static/css/datepicker.css" /> --><!-- 日期框 -->
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

	<form action="" name="usersForm" id="usersForm" method="post">
	<div id="zhongxin" >
	<table id="table_report" class="table table-striped table-bordered table-hover" style="overflow:scroll;">
		<tr height="45px">
			<td>礼品编号:</td>
			<td><input type="text" disabled="disabled" value="${p.sn}" style="width: 370px" /></td>
		</tr>	
		<tr height="45px">			
			<td>礼品名称:</td>
			<td><input  type="text" disabled="disabled" value="${p.prizeName}" style="width: 370px"  /></td>
		</tr>			
		<tr height="45px">
			<td>礼品类型:</td>			
					<c:if test="${'折扣券' eq p.name }">
						<td id="td4">折扣券&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;折扣力度:<input disabled="disabled"   value="${p.price}" style="width: 100px" />折</td>
					</c:if>
					<c:if test="${'代金券' eq p.name}">
						<td id="td4">代金券&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;优惠额度:<input disabled="disabled"   value="${p.price}" style="width: 100px" />元</td>
					</c:if>
					<c:if test="${'礼品券' eq p.name}">				
						<td id="td4">礼品券</td>
					</c:if>
					<c:if test="${'积分' eq p.name}">						
						<td id="td4">积分</td>
					</c:if>
		</tr>
		<tr height="45px">			
			<td>礼品数量(余/总):</td>
			<td><input  type="text"  disabled="disabled" value="${p.surplus_counts}/${p.counts}" style="width: 370px"  /></td>
		</tr>		
		<tr height="45px">			
			<td>使用期限:</td>
			<td><input  type="text"  disabled="disabled" value="${p.startTime}~${p.endTime}" style="width: 370px"  /></td>
		</tr> 
		<tr height="45px">
			<td>描述:</td>
			<td><textarea name="prizeDescp" id="prizeDescp"  disabled="disabled" style="width: 400px;resize:none;height:200px;" >${p.prizeDescp}</textarea></td>
		</tr>		
		<tr height="45px">
		    <td>礼品logo：</td>
			<td> 
				<a class="fancybox" href="<%=httpUrl%>${p.logo}">
	                <img src="<%=httpUrl%>${p.logo}" alt="${p.logo}" width="80px" height="45px" />
	            </a>
			</td>
		</tr>
			
	</table>
	</div>	
	</form>

	<!-- 引入 -->
	<script type="text/javascript">window.jQuery || document.write("<script src='static/js/jquery-1.9.1.min.js'>\x3C/script>");</script>
	<script src="static/js/bootstrap.min.js"></script>
	<script src="static/js/ace-elements.min.js"></script>
	<script src="static/js/ace.min.js"></script>
	<!-- <script type="text/javascript" src="static/js/bootstrap-datepicker.min.js"></script> --><!-- 日期框 -->
	<script type="text/javascript" src="static/js/bootstrap-datetimepicker.js"></script><!-- 日期框 -->
	<script type="text/javascript" src="static/js/bootstrap-datetimepicker.zh-CN.js"></script><!-- 日期框 -->
	<script type="text/javascript" src="static/js/chosen.jquery.min.js"></script><!-- 下拉框 -->
	<script type="text/javascript" src="static/js/bootbox.min.js"></script><!-- 确认窗口 -->
		
	<script type="text/javascript" src="static/js/base64.js"></script>
	<!-- 压缩图片 -->
	<link rel="stylesheet" type="text/css" href="plugins/fancyBox/jquery.fancybox.css">
	<script type="text/javascript" src="plugins/fancyBox/jquery.fancybox.pack.js"></script>
	<!-- 查看图片 -->
	<script type="text/javascript">

	 $(document).ready(function () {
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