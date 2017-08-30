<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.aoshi.util.PropertyUtils"%>
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
	<!-- jsp文件头和头部 -->
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	
	<meta name="description" content="overview & stats" />
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
		<!-- basic styles -->
	<link href="static/css/bootstrap.min.css" rel="stylesheet" />
	<link href="static/css/bootstrap-responsive.min.css" rel="stylesheet" />
	<link rel="stylesheet" href="static/css/font-awesome.min.css" />
	<!-- page specific plugin styles -->
	<!-- 下拉框-->
	<link rel="stylesheet" href="static/css/chosen.css" />
	<!-- ace styles -->
	<link rel="stylesheet" href="static/css/ace.min.css" />
	<link rel="stylesheet" href="static/css/ace-responsive.min.css" />
	<link rel="stylesheet" href="static/css/ace-skins.min.css" />
	<script type="text/javascript" src="static/js/jquery-1.7.2.js"></script>
	<link rel="stylesheet" href="static/css/datepicker.css" /><!-- 日期框 -->
	<!--引入弹窗组件start-->
	<script type="text/javascript" src="plugins/attention/zDialog/zDrag.js"></script>
	<script type="text/javascript" src="plugins/attention/zDialog/zDialog.js"></script>
	<!--引入弹窗组件end-->
	<script type="text/javascript" src="static/js/jquery.tips.js"></script>
</head> 
<body>
		
<div class="container-fluid" id="main-container">


<div id="page-content" class="clearfix">
						
  <div class="row-fluid">


	<div class="row-fluid">
	
			<!-- 检索  -->
			<form action="coupon/couponList.do" method="post" name="" id="">
				<table>
							<tr>
								<td><span class="input-icon"> <input
										autocomplete="off" id="nav-search-input" type="text"
										name="keyword" value="${keyword }" placeholder="优惠券名称" style="width:400px;"/>
										<i id="nav-search-icon" class="icon-search"></i>
								</span></td>
									<td style="vertical-align: top;">
										<button class="btn btn-mini btn-light" onclick="search();"
											title="检索">
											<i id="nav-search-icon" class="icon-search"></i>
										</button>
									</td>
								
							</tr>
						</table>		
			</form>
			<!-- 检索  -->
		
		
			<table id="table_report" class="table table-striped table-bordered table-hover">
				
				<thead>
					<tr>
						<th style="text-align:center;">优惠券名称</th>
						<th style="text-align:center;">店铺</th>
						<th style="text-align:center;">优惠券logo</th>
						<th style="text-align:center;">领取次数</th>
						<th style="text-align:center;">面额</th>
						<th style="text-align:center;">描述</th>
						<th style="text-align:center;">状态</th>
						<th style="text-align:center;">操作</th>
					</tr>
				</thead>
										
				<tbody>
					
				<!-- 开始循环 -->	
				<c:choose>
					<c:when test="${not empty list}">
						<c:forEach items="${list}" var="coup" varStatus="vs">
									
							<tr>
								<td class='center' style="text-align:center;">${coup.name}</td>
								<td class='center' style="text-align:center;">${coup.shop.name}</td>
								<td class='center' style="text-align:center;">
								<a class="fancybox" href="<%=httpUrl%>${coup.logoUrl}">
										<img src="<%=httpUrl%>${coup.logoUrl}" width="20px" height="20px" >
									</a>
								</td>
								<td class='center' style="text-align:center;">${coup.receiveCount}</td>
								<td class='center' style="text-align:center;">${coup.price}</td>
								<td class='center' style="text-align:center;">${coup.descp}</td>
								
								<c:choose>
									<c:when test="${coup.status ==0}">
										<td class='center' style="text-align:center;">待审核</td>
									</c:when>
									<c:when test="${coup.status ==1}">
										<td class='center' style="text-align:center;">已审核</td>
									</c:when>
									<c:when test="${coup.status ==2}">
										<td class='center' style="text-align:center;">禁用</td>
									</c:when>
									<c:when test="${coup.status ==3}">
										<td class='center' style="text-align:center;">过期</td>
									</c:when>
								</c:choose>
								
								<td class='center' style=" style="text-align:center;">
								<a href="javascript:void(0);" onclick="detail(${coup.couponId})">详情</a>
								<c:choose>
									<c:when test="${coup.status ==0}">
										<a href="javascript:void(0);" onclick="review(${coup.couponId},'${coup.name}')">通过审核</a>
									</c:when>
									
								</c:choose>
								</td>
								
							</tr>
						
						</c:forEach>
						
						
						
					</c:when>
				<c:otherwise>
						<tr class="main_info">
							<td colspan="10" class="center">没有相关数据</td>
						</tr>
					</c:otherwise>
				</c:choose>
					
				
				</tbody>
			</table>
			
			<div class="page-header position-relative">
							<table style="width: 100%;">
								<tr>
									<td style="vertical-align: top;">
										<div class="pagination"
											style="float: right; padding-top: 0px; margin-top: 0px;">${page.pageStr}</div>
									</td>
								</tr>
							</table>
						</div>
	</div>
 
 
 
 
	<!-- PAGE CONTENT ENDS HERE -->
  </div><!--/row-->
	
</div><!--/#page-content-->
</div><!--/.fluid-container#main-container-->
		
		<!-- 返回顶部  -->
		<a href="#" id="btn-scroll-up" class="btn btn-small btn-inverse">
			<i class="icon-double-angle-up icon-only"></i>
		</a>
		
		<!-- 引入 -->
		<script type="text/javascript">window.jQuery || document.write("<script src='static/js/jquery-1.9.1.min.js'>\x3C/script>");</script>
		<script src="static/js/bootstrap.min.js"></script>
		<script src="static/js/ace-elements.min.js"></script>
		<script src="static/js/ace.min.js"></script>
		
		<script type="text/javascript" src="static/js/chosen.jquery.min.js"></script><!-- 下拉框 -->
		<script type="text/javascript" src="static/js/bootstrap-datepicker.min.js"></script><!-- 日期框 -->
		<script type="text/javascript" src="static/js/bootbox.min.js"></script><!-- 确认窗口 -->
		<!-- 引入 -->
		
		
		<script type="text/javascript" src="static/js/jquery.tips.js"></script><!--提示框-->
		
		<link rel="stylesheet" type="text/css" href="plugins/fancyBox/jquery.fancybox.css">
		<script type="text/javascript" src="plugins/fancyBox/jquery.fancybox.pack.js"></script>
		<script type="text/javascript">
		
		$(top.hangge());
		
		//检索
		function search(){
			top.jzts();
			$("#userForm").submit();
		}
		
		
		
		//审核
		function review(couponId,name){
			if(confirm("确定审核优惠券"+name+"吗?")){
				$.ajax({
					type: "POST",
					url: '<%=basePath%>coupon/review.do',
			    	data: {couponId:couponId},
					dataType:'json',
					//beforeSend: validateData,
					cache: false,
					success: function(data){
						if(data){
							history.go(0);
						}
					}
				});
			}
		}
		
		
		function detail(couponId){
			top.jzts();
			 var diag = new top.Dialog();
			 diag.Drag=true;
			 diag.Title ="详情";
			 diag.URL = '<%=basePath%>coupon/couponDetail.do?couponId='+couponId;
			 diag.Width = 700;
			 diag.Height = 500;
			 diag.CancelEvent = function(){ //关闭事件
				diag.close();
				setTimeout("self.location=self.location",100);
			 };
			 diag.show();
		}
		</script>
		
		<script type="text/javascript">
		
		$(function() {
			
			//日期框
			$('.date-picker').datepicker();
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

