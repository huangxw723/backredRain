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
	<%@ include file="../../system/admin/top.jsp"%>
	<!-- ztree -->
	<link type="text/css" rel="stylesheet" href="plugins/zTree/3.5/demo.css" />
  	<link type="text/css" rel="stylesheet" href="plugins/zTree/3.5/zTreeStyle.css" />
	</head> 
<body>
	<div id="page-content" class="clearfix">

		<div class="row-fluid">
			<!-- PAGE CONTENT BEGINS HERE -->
			<form class="form-horizontal" id="form" action="coupon/editTag.do" method="post" enctype="multipart/form-data">
				<input type="hidden" name="tagId" value="${tag.tagId}">
				<div class="control-group">
					<label class="control-label">标签名称</label>
					<div class="controls">
						<input type="text" id="name" value="${tag.name}" name="name" placeholder="标签名称" required />
					</div>
				</div>
				<div class="control-group">
					<label class="control-label">标签类型</label>
					<div class="controls">
						<select name="type">
							<option ${tag.type == 1?'selected':''} value="1">商圈标签</option>
							<option ${tag.type == 2?'selected':''} value="2">优惠券标签</option>
						</select>
					</div>
				</div>
				
				<div class="form-actions">
					<button class="btn btn-info" type="button" id="save">
						<i class="icon-ok"></i> Submit
					</button>
					&nbsp; &nbsp; &nbsp;
					<button class="btn" type="reset">
						<i class="icon-undo"></i> Reset
					</button>
				</div>
			</form>

		</div>
		<!-- PAGE CONTENT ENDS HERE -->
						 </div><!--/row-->
	
		<!-- basic scripts -->
		<script src="static/1.9.1/jquery.min.js"></script>
		<script type="text/javascript">
		window.jQuery || document.write("<script src='js/jquery-1.9.1.min.js'>\x3C/script>");
		</script>
		
		<script src="static/js/bootstrap.min.js"></script>
		
		
		
		<!-- ace scripts -->
		<script src="static/js/ace-elements.min.js"></script>
		<script src="static/js/ace.min.js"></script>
		<!-- inline scripts related to this page -->
		<!-- ztree -->
		<script type="text/javascript" src="plugins/zTree/3.5/jquery.ztree.core.min.js"></script>
		<script type="text/javascript" src="plugins/zTree/3.5/jquery.ztree.excheck.min.js"></script>
		<script src="static/js/base64Compress.js"></script>
		
		<!-- 编辑框-->
		<script type="text/javascript" charset="utf-8">window.UEDITOR_HOME_URL = "<%=path%>/plugins/ueditor/";</script>
		<script type="text/javascript" charset="utf-8" src="plugins/ueditor/ueditor.config.js"></script>
		<script type="text/javascript" charset="utf-8" src="plugins/ueditor/ueditor.all.js"></script>
		<!-- 编辑框-->
		<script type="text/javascript" src="static/js/bootstrap-datepicker.min.js"></script>
  		<!-- 日期框 -->
		<script type="text/javascript">
		$(document).ready(function(){
			$(top.hangge());
			
			$('.date-picker').datepicker()
			
			$("#save").on("click",function(){
				var name = $("#name").val();
				if(name.trim()=="" || undefined==name){
					alert("名称不能为空");
					return ;
				}
				var inps = $(".tagId:checked");
				var tagIds = "";
				$.each(inps,function(index,val){
					tagIds = tagIds+$(val).val()+",";
				})
				tagIds = tagIds.substring(0,tagIds.length-1);
				$("#tagIds").val(tagIds);
				$("#form").submit();
					
			})
			
		})
			
		</script>
	</body>
</html>