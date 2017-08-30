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
		<meta charset="utf-8" />
		<title></title>
		<meta name="description" content="overview & stats" />
		<meta name="viewport" content="width=device-width, initial-scale=1.0" />
		<link href="static/css/bootstrap.min.css" rel="stylesheet" />
		<link href="static/css/bootstrap-responsive.min.css" rel="stylesheet" />
		<link rel="stylesheet" href="static/css/font-awesome.min.css" />
		<script type="text/javascript" src="static/js/jquery-1.7.2.js"></script>
		<!--提示框-->
		<script type="text/javascript" src="static/js/jquery.tips.js"></script>
<script type="text/javascript">
	$(top.hangge());
	$(document).ready(function(){
		
	});
	
	
	
</script>
	</head>
<body>
	<div id="page-content" class="clearfix">

		<div class="row-fluid">
			<form class="form-horizontal" id="form" action="goods/saveAttr.do">
				<input id="attrStr" type="hidden" name="attrStr">
				<input type="hidden" name="goodsId" value="${goodsId}" readonly>
				<!-- 选择框 -->
				<!-- <div class="control-group" ng-if="attributes.length>0" ng-repeat="attribute in attributes">
					<label class="control-label">{{attribute.attrName}}</label>
					<div class="controls">
						<select style="" name="sku" data-key="{{attribute.attrName}}" data-tp="{{attribute.attrType}}" data-id="{{attribute.attributeId}}">
							<option value="">--选择--</option>
							<option value="{{attr}}"  ng-repeat="attr in getAttrValues(attribute.attrValues)">{{attr}}</option>
							<input value="{{attr}}" type="checkbox"/>
						</select><a href="javascript:void(0)" onclick="javascript:add(this)">添加</a>
					</div>
				</div> -->
				
		<c:choose>
			<c:when test="${not empty attrs}">
			 <c:forEach items="${attrs}" var="attr" varStatus="i">
					<div class="control-group">
						<label class="control-label">${attrs[i.index][0].attribute.attrName}</label>
						<div class="controls">
							<c:forEach items="${attr}" var="a" varStatus="j">
								<label>
									<input checked="checked" disabled="disabled" type="checkbox" />
									<span class="lbl"> ${a.attrValue}</span>
								</label>
							</c:forEach>
						</div>
					</div>
				</c:forEach>
			</c:when>
			<c:otherwise>
				<div style="height:200px;"></div>
				<div align="center" style="height:100px;font-size:25px">
						请先编辑属性！
				</div>
			</c:otherwise>
		</c:choose>
		
				
			</form>

		</div>
	</div>

</body>
<script>
</script>
</html>