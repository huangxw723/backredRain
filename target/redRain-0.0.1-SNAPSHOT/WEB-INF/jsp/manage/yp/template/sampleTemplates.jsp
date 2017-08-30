<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
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
	<link rel="stylesheet" href="static/css/font-awesome.min.css" />
	<!-- page specific plugin styles -->
	<!-- 下拉框-->
	<!-- ace styles -->
	<script type="text/javascript" src="static/js/jquery-1.7.2.js"></script>
	<link rel="stylesheet" href="static/css/datepicker.css" /><!-- 日期框 -->
	<!--引入弹窗组件start-->
	<!--引入弹窗组件end-->
	<script src="static/js/angular.min.js"></script>
	<style type="text/css">
		
			li{
				float: left;
				list-style: none;
				display: block;
				text-align: center;
			}
			a{
				display: block;
			}
	</style>
</head> 
<body ng-app="app" ng-controller="myCtrl">
		
<div class="container-fluid" id="main-container">

<div id="page-content" class="clearfix" style="margin-top: 50px">

	<div class="row-fluid">
			<div style="display: block;height: 600px">
				<ul>
					<li style="margin-left: 10px" ng-repeat="t in businessTemplates">
						<img alt="" ng-src="static/template/images/{{t.preview}}.png">
							<a href="javascript:void(0);" ng-click="selectSample(t.businessTemplateId)">选择</a>
					</li>
				</ul>
			</div>
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
	
</div><!--/#page-content-->
</div><!--/.fluid-container#main-container-->
		
		<!-- 返回顶部  -->
		<!-- <a href="#" id="btn-scroll-up" class="btn btn-small btn-inverse">
			<i class="icon-double-angle-up icon-only"></i>
		</a> -->
		
		<!-- 引入 -->
		<script type="text/javascript">window.jQuery || document.write("<script src='static/js/jquery-1.9.1.min.js'>\x3C/script>");</script>
		<script type="text/javascript" src="static/js/chosen.jquery.min.js"></script><!-- 下拉框 -->
		<script type="text/javascript" src="static/js/bootstrap-datepicker.min.js"></script><!-- 日期框 -->
		<!-- 引入 -->
		
		
		<script type="text/javascript" src="static/js/jquery.tips.js"></script><!--提示框-->
		<script type="text/javascript">
		//$(top.hangge());
		var businessTemplates = '${businessTemplates}';
		var app =   angular.module("app",[]);
		
		app.controller("myCtrl",function($scope,$http){
			$scope.businessTemplates = JSON.parse(businessTemplates);
			
			$scope.selectSample = function(businessTemplateId){
				selectSample(businessTemplateId);
			}
			
		})
		
		//选择
		function selectSample(businessTemplateId){
			 <%-- top.mainFrame.tab.add( {
	  				id :new Date().getTime(),
	  				title :"编辑模版",
	  				url :'<%=basePath%>yp/admin/template/toEditUserTemplate.do?userTemplateId='+userTemplateId,
	  				isClosed :true
	  			}); --%>
	  			$.ajax({
					type: "POST",
					url: '<%=basePath%>yp/admin/template/selectSample.do',
			    	data: {businessTemplateId:businessTemplateId},
					dataType:'json',
					//beforeSend: validateData,
					cache: false,
					success: function(data){
						if(data){
							top.Dialog.close();
						}
					}
			});
		}
		$(function() {
			
			//日期框
			$('.date-picker').datepicker();
			
		});
		
		</script>
		
		
	</body>
</html>

