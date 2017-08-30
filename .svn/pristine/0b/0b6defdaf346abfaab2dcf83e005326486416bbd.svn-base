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
	<%@ include file="../../../system/admin/top.jsp"%>
	<!-- ztree -->
	</head> 
<body>
	<div id="page-content" class="clearfix">

		<div class="row-fluid">
			<!-- PAGE CONTENT BEGINS HERE -->
			<form class="form-horizontal" id="form" action="yp/admin/template/saveVideo.do" method="post" enctype="multipart/form-data">
				<input type="hidden" name="businessModuleId" value="${businessModuleId}"/>
				<input type="hidden" name="type" value="${type}"/>				
				<div class="control-group" >
					 <!-- <label class="control-label">请选择背景图片</label> -->
					<div class="controls">
							<input id="video" type='file' name="file">
							
					</div>
				</div>
				
				<div class="form-actions">
					
					<button class="btn btn-info" style="float: right;margin-right: 50%" type="button" id="save">
						<i class="icon-ok"></i> 保存
					</button>
					<!-- <button class="btn" type="reset">
						<i class="icon-undo"></i> Reset
					</button> -->
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
		<script src="static/js/base64Compress.js"></script>
		
  		<!-- 日期框 -->
  		<!-- 颜色 -->
		<script type="text/javascript">
		var isClick = false ;
		$(document).ready(function(){
			
			$("#save").on("click",function(){
				
				var fileName = $("#video").val();
				if(fileName == ""){
					alert("请选择文件");
					return ;
				}
				//console.log(fileName);
				var suffix = fileName.substring(fileName.indexOf(".")+1,fileName.length);
				console.log(suffix);
				if(suffix == "mp4" || suffix == "MP4" || suffix == "ogg"||suffix == "OGG" ){
					if(isClick){
						alert("正在上传文件……");
						return ;
					}
					isClick = true ;
					$("#form").submit();
					
				}else{
					alert("请选择mp4或者ogg文件");
					return ;
				}
				
			})
		})
		</script>
	</body>
</html>