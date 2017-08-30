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
		<!-- 下拉框 -->
		<link rel="stylesheet" href="static/css/chosen.css" />
		<link rel="stylesheet" href="static/css/ace.min.css" />
		<link rel="stylesheet" href="static/css/ace-responsive.min.css" />
		<link rel="stylesheet" href="static/css/ace-skins.min.css" />
		<script type="text/javascript" src="static/js/jquery-1.7.2.js"></script>
		<script type="text/javascript" src="static/js/common/commonutils.js"></script>
	</head>
<body>
	<div class="row-fluid">
	<div class="span12">
		<form action="goods/saveStore.do" id="form" method="post" enctype="multipart/form-data">
		<input id="goodsId" type="hidden"  name="goodsId" value="${goodsId}"/>
		<input id="storeStr" type="hidden" name="storeStr">
		<c:choose>
			<c:when test="${not empty products}">
			<table id="table_bug_report" class="table table-striped table-bordered table-hover">
				<thead>
					<tr>
						
						<th>序号</th>
						<c:forEach items="${products[0].goodsAttrNames}" var="attr">
							<td>${attr}</td>
						</c:forEach>
						<th>库存</th>
					</tr>
				</thead>
										
				<tbody>
					<c:forEach items="${products}" var="p" varStatus="i">
					<tr>
						<td>${i.index+1}</td>
						<c:forEach items="${p.goodsAttrValues}" var="v">
							<td>${v}</td>
						</c:forEach>
						<td><input data-id="${p.productId}" name="productStore" onkeyup="validateUtils.replaceNotNumEmpty(this);" type="number" min="0" max="10000" value="${p.productStore}"/></td>
					</tr>
					</c:forEach>
					
				</tbody>
			</table>
			</c:when>
			<c:otherwise>
				<div style="height:200px;"></div>
				<div align="center" style="height:100px;font-size:25px">
						请先编辑属性！
				</div>
			</c:otherwise>
		</c:choose>
		
		<div align="center" style="height:40px;">
				<c:if test="${not empty products}">
           			 <a class="btn btn-mini btn-primary" id="save">保存</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
           			 <a class="btn btn-mini btn-danger" onclick="top.Dialog.close();">取消</a>
           		</c:if>
		</div>
		</form>
	</div><!--/span-->
</div>
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
		
	<script type="text/javascript">
	
		$("#save").click(function(){
			 
			var inputs = $("input[name=productStore]");
			var stores = [];
			$.each(inputs,function(index,val){
				stores.push({
					productId:$(val).data("id"),
					productStore:$(val).val()
				});
			});
			console.log(JSON.stringify(stores));
			$("#storeStr").val(JSON.stringify(stores));
			
			$("#form")[0].submit();
	 	})
	</script>
</body>
</html>