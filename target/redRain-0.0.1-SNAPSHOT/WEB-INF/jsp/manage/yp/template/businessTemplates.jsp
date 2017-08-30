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
			
			.type_div{
				width: 100%;
				height: 32px;
				float: left;
				margin-top:10px;
				margin-left: 4%;
			}
			.type li.on{
				background: #ccc;
				
			}
			.type li{
				float:left;
				cursor: pointer;
    			line-height: 30px;
    			padding: 0 60px;
    			font-size: 20px;
    			margin-left: 10%;
			}
		</style>
</head> 
<body ng-app="app" ng-controller="myCtrl">
		
<div class="container-fluid" id="main-container">
<div class="type_div">
	<ul class="type">
			<li  class="{{typeId == type.templateTypeId?'on':''}}" ng-repeat="type in types" ng-click="selectType(type.templateTypeId)">{{type.typeName}}</li>
	</ul>
</div>

<div id="page-content" class="clearfix" style="margin-top: 50px">

	<div class="row-fluid">
			<div style="display: block;overflow-y: scroll; ">
				<ul>
						<li style="margin-left: 10px" ng-repeat="t in businessTemplates">
							<img alt="" ng-src="static/template/images/{{t.preview}}.png">
								<a ng-if="select != 1" href="javascript:void(0);" ng-click="edit(t.businessTemplateId)">编辑({{t.templateName}})</a>
								<a ng-if="select == 1" href="javascript:void(0);" ng-click="selection(t.businessTemplateId)">选择({{t.templateName}})</a>
						</li>
				</ul>
			</div>
			<div class="page-header position-relative">
				<form action="yp/admin/template/getSysTemplates.do" method="post" name="" id="">
						<table style="width: 100%;">
							<tr>
								<td style="vertical-align:top;">
									<!-- <a ng-if="select != 1" class="btn btn-small btn-success" onclick="add();">新增</a> -->
									<a ng-if="select != 1" class="btn btn-small btn-success" onclick="addSample();">添加新模版</a>
								</td>
								
								<td style="vertical-align: top;">
									<div class="pagination"
										style="float: right; padding-top: 0px; margin-top: 0px;">${page.pageStr}</div>
								</td>
							</tr>
						</table>
				</form>
			</div>
	</div>
 
 
 
 
	<!-- PAGE CONTENT ENDS HERE -->
	
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
		<script type="text/javascript">
		//$(top.hangge());
		var businessTemplates = '${businessTemplates}';
		var select = '${select}';
		var typeId = '${typeId}';
		var types = '${types}';
		
		var app =   angular.module("app",[]);
		
		app.controller("myCtrl",function($scope,$http){
			$scope.businessTemplates = JSON.parse(businessTemplates);
			$scope.select = select;
			$scope.typeId = typeId;
			$scope.types = JSON.parse(types);
			
			
			$scope.edit = function(businessTemplateId){
				edit(businessTemplateId);
			}
			$scope.selection = function(businessTemplateId){
				selection(businessTemplateId);
			}
			$scope.selectType = function(templateTypeId){
				$http({
	    		    method:'GET',
	    		    url:'<%=basePath%>yp/admin/template/getBusinessTemplateByType.do',
	    		    params:{
	    		    	'templateTypeId':templateTypeId
	    		    }
	    	    }).success(function(data){
	    	    	$scope.businessTemplates = data.businessTemplates;
	    			//$scope.select = select;
	    			$scope.typeId =templateTypeId;
	    			//$scope.types = data.types;
	    	    })
			}
			
		})
		//检索
		function search(){
			top.jzts();
			$("#userForm").submit();
		}
		
		//新增
		function add(){
			 top.jzts();
			 var diag = new top.Dialog();
			 diag.Drag=true;
			 diag.Title ="新增";
			 diag.URL = '<%=basePath%>yp/admin/template/toAddBusinessTemplate.do';
			 diag.Width = 700;
			 diag.Height = 600;
			 diag.CancelEvent = function(){ //关闭事件
				diag.close();
				setTimeout("self.location=self.location",100);
			 };
			 diag.show();
		}
		
		function addSample(){
			top.jzts();
			 var diag = new top.Dialog();
			 diag.Drag=true;
			 diag.Title ="新增样板";
			 diag.URL = '<%=basePath%>yp/admin/template/toAddSample.do';
			 diag.Width = 1200;
			 diag.Height = 600;
			 diag.CancelEvent = function(){ //关闭事件
				diag.close();
				setTimeout("self.location=self.location",100);
			 };
			 diag.show();
		}
		
		//编辑
		function edit(businessTemplateId){
			 top.mainFrame.tab.add( {
	  				id :businessTemplateId,
	  				title :"编辑模版",
	  				url :'<%=basePath%>yp/admin/template/toEditBusinessTemplate.do?businessTemplateId='+businessTemplateId,
	  				closeFn:function(data){
	  					history.go(0);
	  				},
	  				isClosed :true
	  			});
			 <%-- location.href = '<%=basePath%>yp/admin/template/toEditBusinessTemplate.do?businessTemplateId='+businessTemplateId; --%>
		}
		//选择
		function selection(businessTemplateId){
			 <%-- top.mainFrame.tab.add( {
	  				id :new Date().getTime(),
	  				title :"编辑模版",
	  				url :'<%=basePath%>yp/admin/template/toEditUserTemplate.do?userTemplateId='+userTemplateId,
	  				isClosed :true
	  			}); --%>
			 location.href = '<%=basePath%>yp/admin/template/selectBusinessTemplate.do?businessTemplateId='+businessTemplateId;
		}
		<%-- function select(templateId){
			top.mainFrame.tab.add( {
  				id :new Date().getTime(),
  				title :"选择模版",
  				url :'<%=basePath%>yp/admin/template/selectTemplate.do?templateId='+templateId+
  						"&parentUserModuleId="+parentUserModuleId+
  						"&parentUserTemplateId="+parentUserTemplateId+
  						"&rootUserTemplateId="+rootUserTemplateId,
  				isClosed :true
  			});
		} --%>
		
		$(function() {
			
			//日期框
			$('.date-picker').datepicker();
			
		});
		
		</script>
		
		
	</body>
</html>

