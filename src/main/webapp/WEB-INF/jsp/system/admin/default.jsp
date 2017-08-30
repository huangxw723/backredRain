<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<!DOCTYPE html>
<html lang="en">
<head>
<base href="<%=basePath%>">

<!-- jsp文件头和头部 -->
<%@ include file="top.jsp"%>

</head>
<body  style="overflow:Scroll;overflow-x:hidden">
	<div class="container-fluid" id="main-container">
			<div id="page-content" class="clearfix">
				<div class="page-header position-relative">
					<h1>
						后台首页 <small><i class="icon-double-angle-right"></i> </small>
					</h1>
				</div>
				<!--/page-header-->

				<div class="row-fluid">
				<img alt="" src="static/login/images/banner_slide_01.jpg" max-height="100%">
				</div>
		</div>
		<!-- #main-content -->
	</div>
	<script type="text/javascript">
		$(top.hangge());
	</script>
</body>
</html>
