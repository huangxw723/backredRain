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
  		
<script type="text/javascript">
	 
</script>
	</head>
<body>


	<form >
	<div id="zhongxin" >
	<table id="table_report"  class="table table-striped table-bordered table-hover" style="overflow:scroll;">
		<c:choose>
			<c:when test="${not empty infoList}">
				<c:forEach items="${infoList}" var="var" > 
					<tr height="100px" >
						<c:if test="${var.type eq 1}">
							<td style="text-align:center; width:788px;"><div align="center" style="font-size:40px">大转盘:</div></td>
						</c:if>
						<%-- <c:if test="${var.type eq 2}">
							<td style="text-align:center"><div align="center" style="font-size:40px">摇一摇:</div></td>
						</c:if> --%>
						<c:if test="${var.type eq 3}">
							<td style="text-align:center"><div align="center" style="font-size:40px">优惠券:</div></td>
						</c:if>
						<td>
							<div style="font-size:20px">
								本月派发:${var.total}份<hr/>
								本月参与:${var.time}次
							</div>
						</td>
					</tr>
			 	</c:forEach>
			 		<tr>
			 			<td><div>备注:统计数据只包含 结束日期是当前月 审核通过的礼品(派完和过期)</div></td>
			 			<td></td>
			 		</tr>
		 </c:when>
		<c:otherwise>
				<tr class="main_info">
					<td colspan="10" class="center" style="font-size:20px">
						没有参加活动相关数据
					</td>
			 		
				</tr>
				<tr class="main_info">
			 		<td><div>备注:统计数据只包含 结束日期是当前月 审核通过的礼品(派完和过期)</div></td>
				</tr>
		</c:otherwise>
	</c:choose>
		 
	</table>
	</div>
	 
	</form>

</body>
</html>