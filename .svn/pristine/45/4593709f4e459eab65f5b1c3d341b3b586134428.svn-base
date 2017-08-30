
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.aoshi.util.PropertyUtils"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
	String httpUrl = PropertyUtils.getHTTP_URL();
%>
<!DOCTYPE html>
<html lang="en">
<head>
	<base href="<%=basePath%>">
	<%@ include file="../../system/admin/top.jsp"%>
	<meta charset="UTF-8">

	<link rel="stylesheet" type="text/css" href="TenantManage/css/base.css">
	<link rel="stylesheet" type="text/css" href="TenantManage/css/fill_in_info.css">
</head>
<body>
	<div id="app">
		<div class="indicate_box">
			<div class="indicate">
				<div class="between">
					<div class="step_box ">
						<div class="step">
							1
						</div>
						<span>填写商家个人信息</span>
					</div>
					<i class="towards_right"></i>
					<div class="step_box ">
						<div class="step">
							2
						</div>
						<span>填写商户信息</span>
					</div>

					<c:choose>
						<c:when test="${type == 2}">
							<i class="towards_right"></i>
							<div class="step_box <c:if test='${info.auditStatus == 0 || info.auditStatus == 3}'>current</c:if>">
								<div class="step">
									3
								</div>
								 <c:choose>
									 <c:when test="${info.auditStatus == 3}">
										 <span>业主审核不通过</span>
									 </c:when>
									 <c:when test="${info.auditStatus == 1}">
										 <span>业主审核通过</span>
									 </c:when>
									 <c:otherwise>
										 <span>等待业主审核</span>
									 </c:otherwise>
								 </c:choose>
							</div>
							<i class="towards_right"></i>
							<div class="step_box <c:if test='${info.auditStatus == 1}'>current</c:if>">
								<div class="step">
									4
								</div>
								<c:choose>
									<c:when test="${info.auditStatus == 2}">
										<span>管理员审核通过</span>
									</c:when>
									<c:otherwise>
										<span>等待管理员审核</span>
									</c:otherwise>
								</c:choose>
							</div>
							<i class="towards_right"></i>
							<div class="step_box <c:if test='${info.auditStatus == 2}'>current</c:if>">
								<div class="step">
									5
								</div>
								<span>恭喜您，入驻成功</span>
							</div>
						</c:when>
						<c:otherwise>
							<i class="towards_right"></i>
							<div class="step_box <c:if test='${info.auditStatus == 0 || info.auditStatus == 3}'>current</c:if>">
								<div class="step">
									3
								</div>
								<c:choose>
									<c:when test="${info.auditStatus == 3}">
										<span>管理员审核不通过</span>
									</c:when>
									<c:when test="${info.auditStatus == 2}">
										<span>管理员审核通过</span>
									</c:when>
									<c:otherwise>
										<span>等待管理员审核</span>
									</c:otherwise>
								</c:choose>
							</div>
							<i class="towards_right"></i>
							<div class="step_box <c:if test='${info.auditStatus == 2}'>current</c:if>">
								<div class="step">
									4
								</div>
								<span>恭喜您，入驻成功</span>
							</div>

						</c:otherwise>
					</c:choose>


				</div>
			</div>
		</div>

		<!-- 成功 -->
		<div id="success" >
			<div class="success_describe">
				<c:if test='${info.auditStatus == 0}'> <i></i> <span>请等待业主审核结果</span></c:if>
				<c:if test='${info.auditStatus == 1}'><i></i> <span>请等待管理员审核结果</span></c:if>
				<c:if test='${info.auditStatus == 2}'><i></i><span>恭喜您，入驻成功</span></c:if>
				<c:if test='${info.auditStatus == 3}'>
					<c:if test='${type == 2}'>
						<span style="color: #ea4043; ">业主审核不通过</span>
					</c:if>
					<c:if test='${type == 1}'>
						<span style="color: #ea4043; ">管理员审核不通过</span>
					</c:if>

				</c:if>
			</div>
		</div>
		<br/>
		<c:if test='${info.auditStatus == 3}'>
			<div  style="text-align: center;">
					<span style="color: #1ca8ed; ">审核意见:</span>
					<textarea disabled="disabled" style="width:1000px;height:200px"  name="reason" id="reason">${info.reason}</textarea>
			</div>
			<div style="text-align: center;">
				<a class="btn btn-mini btn-primary" id="a1" onclick="prizeStatus(1);" style="width: 90px; height: 34px; line-height:34px">返回修改</a>
			</div>
		</c:if>
	</div>
	
	<!-- 模态框 -->
	<div id="masklayer"></div>

</body>
</html>
<!-- <script src="js/vue.js"></script>
<script src="js/vue-router.js"></script> -->
<script src="TenantManage/js/jquery-1.11.1.min.js"></script>
<script src="TenantManage/js/fil_in_info.js"></script>
<!-- <script>
	
	// 填写商家个人信息
	var individual = document.getElementById('individual_info').innerHTML
	// 填写商户信息
	var seller = document.getElementById('seller_info').innerHTML;
	// 成功
	var success = document.getElementById('success').innerHTML;
	console.log(success)
	// var success = '<div class="success_describe"><i></i><span>请等待业主审核结果{{message}}</span></div>'

	var Individual = {
		template: individual
	}

	var Seller = {
		template: seller
	}

	var Success = {
		template: success
	}

	var routes = [
		{path: '/', component: Individual},
		{path: '/seller', component: Seller},
		{path: '/success', component: Success},
		//重定向
        {path:'*',redirect:'/'}
	]

	// 生成路由实例
	var router = new VueRouter({
		routes
	});

	// 挂载到Vue上
	new Vue({
		el: '#app',
		router,
		data: {
			seen: false,
			message: 'Dwx'
		}
	});
</script> -->
