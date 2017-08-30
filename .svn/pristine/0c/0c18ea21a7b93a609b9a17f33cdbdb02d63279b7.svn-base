<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html lang="en" ng-app="app">
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
		<!--提示框-->
		<script type="text/javascript" src="static/js/angular.min.js"></script>
		<script type="text/javascript">

		</script>
	</head>
<body ng-controller="attrCtrl">
	<div id="page-content" class="clearfix">

		<div class="row-fluid">
			<form class="form-horizontal" id="form" action="goods/saveAttr.do">
				<input id="attrStr" type="hidden" name="attrStr">
				<input type="hidden" name="goodsId" value="${goodsId}" readonly>
				<div class="center">如果重设，会覆盖之前的商品库存、商品类型属性、关联品牌、参数等类型相关数据，请谨慎操作！</div></br>
				<div class="control-group" id="type">
					<label class="control-label">选择商品类型</label>
					<div class="controls">
						<select name="attrTypeId" onchange="getAttr(this.value)">
							<option value="" selected>-请选择-</option>
							<c:forEach items="${attrTypes}" var="type">
								<option value="${type.attrTypeId}">${type.typeName}</option>
							</c:forEach>
						</select>
					</div>
				</div>
				
				<div class="control-group" ng-if="attributes.length>0" ng-repeat="attribute in attributes">
					<label class="control-label">{{attribute.attrName}}</label>
					<div class="controls">
						<label ng-repeat="attr in attribute.attrVals">
							<input attr type="checkbox" data-key="{{attribute.attrName}}" data-id="{{attribute.attributeId}}" value="{{attr}}" />
							<span class="lbl"> {{attr}}</span>
						</label>
					</div>
				</div>
				
				<div align="center" style="height:40px;">
           			 <a class="btn btn-mini btn-primary" id="save">保存</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
           			 <a class="btn btn-mini btn-danger" onclick="top.Dialog.close();">取消</a>
				</div>
			</form>

		</div>
	</div>
</body>


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
		<script type="text/javascript" src="static/js/bootbox.min.js"></script><!-- 确认窗口 -->
		<!-- 引入 -->
		<script type="text/javascript" src="static/js/jquery.tips.js"></script><!--提示框-->
		
		<link rel="stylesheet" type="text/css" href="plugins/fancyBox/jquery.fancybox.css">
		<script type="text/javascript" src="plugins/fancyBox/jquery.fancybox.pack.js"></script>

<script>
	
	var module = angular.module("app",[]);
	module.controller("attrCtrl",function($scope){
		//$scope.attrTypes = attrTypes;
		$scope.attributes = [];
		$scope.getAttribute = function(attrTypeId){
			if(attrTypeId == ""){
				$scope.attributes = [];
				$scope.$apply();
				return ;
			}else{
				$.ajax({
					type: "POST",
					url: '<%=basePath%>goods/getAttribute.do',
			    	data: {attrTypeId:attrTypeId},
					dataType:'json',
					//beforeSend: validateData,
					cache: false,
					success: function(data){
						console.log(JSON.stringify(data));
						$scope.attributes = data;
						$scope.$apply();
					}
				});
			}
			
		}
		
	})
	
function getAttr(attrTypeId){
	var appElement = document.querySelector('[ng-controller=attrCtrl]');
	var $scope = angular.element(appElement).scope();
	$scope.getAttribute(attrTypeId);
}
$(document).ready(function(){
	$("#save").on("click",function(){
				var chs = $("[attr]:checked");
				var attrs = [];
				$.each(chs,function(index,val){
					attrs.push({
						attributeId:$(val).data("id"),
						attrName:$(val).data("key"),
						attrValue:$(val).val()
					});
				})
				if(attrs.length == 0){
					bootbox.alert("商品属性不能为空");
					return ;
				}
		bootbox.confirm("如果重设，会覆盖之前的商品库存、商品类型属性、关联品牌、参数等类型相关数据，请谨慎操作！", function(result) {
			if(result) {
				$("#attrStr").val(JSON.stringify(attrs));
				$("#form").submit();
			}
		});
	})
})
</script>
</html>