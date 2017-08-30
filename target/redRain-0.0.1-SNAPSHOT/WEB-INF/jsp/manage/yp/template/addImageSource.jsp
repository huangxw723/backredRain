<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.aoshi.util.PropertyUtils"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
	<%@ include file="../../../system/admin/top.jsp"%>
	<!-- ztree -->
	</head> 
<body>
	<div id="page-content" class="clearfix">

		<div class="row-fluid">
			<!-- PAGE CONTENT BEGINS HERE -->
			<form class="form-horizontal" id="form" action="yp/admin/template/saveImageSource.do" method="post" enctype="multipart/form-data">
				<div class="control-group" >
					<label class="control-label">图片</label>
					<div class="controls">
							<input id="inp1" type='file' name="file" style="display: none">
							<span class="help-inline">
								<a href="javscript:void(0);" onclick="addImg('inp1')">选择本地图片</a>
							</span>
							<div style="float: left;">
								<img id="image1" alt="" src="" style="max-width:350px;"/>
							</div>
							<!-- <input id="goodsImg" type="hidden" name="goodsImg"> -->
					</div>
				</div>
				<div class="control-group">
					<label class="control-label">图片类型</label>
					<div class="controls">
						<select name="templateTypeId">
							<option value="">--全部--</option>
							<c:forEach items="${templateTypes}" var="type">
								<option value="${type.templateTypeId }">${type.typeName}</option>
							</c:forEach>
						</select>
					</div>
				</div>
				<div class="control-group">
					<label class="control-label">图片名称</label>
					<div class="controls">
						<input type="text" name="imageName" placeholder="图片名称" />
					</div>
				</div>
				
				<div class="control-group">
					<label class="control-label">宽度</label>
					<div class="controls">
						<input id="width" type="text" value="" name="width" readonly />
					</div>
				</div>
				
				<div class="control-group">
					<label class="control-label">高度</label>
					<div class="controls">
						<input id="height" type="text" value="" name="height" readonly />
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
		$(top.hangge());
		function EL(id) { return document.getElementById(id); } // Get el by ID helper function
		function readFile1() {
			  if (this.files && this.files[0]) {
			    var FR= new FileReader();
			    FR.onload = function(e) {
			      //EL("img").src       = e.target.result;
			     // console.log(e.target.result);
			     //压缩base64
			      var result = base64Shorter(e.target.result);
			     //var result = e.target.result;
			      $("#image1").prop("src",result);
			      //console.log(result);
			      var image = new Image();
			      image.src = e.target.result;
			      $("#width").val(image.width);
			      $("#height").val(image.height);
			    };       
			    FR.readAsDataURL( this.files[0] );
			  }
		}
		

		//EL("inp").addEventListener("change", readFile, false);
		EL("inp1").addEventListener("change", readFile1, false);
		function addImg(inp){
			$("#"+inp).click();
		};
		var hasClick = false;
		$(document).ready(function(){
			
			$("#save").on("click",function(){
				if(hasClick){
					return ;
				}
				/* var fileName = $("#inp1").val();
				if(fileName == ""){
					alert("请选择文件");
					return ;
				}
				if(fileName.indexOf(".")<0){
					alert("请选择图片文件");
					return ;
				}
				var suffix = fileName.substring(fileName.indexOf(".")+1,fileName.length);
				if(suffix != "jpg" && suffix != "png" && suffix != "jpeg" ){
					alert("请选择图片文件");
					return ;
				} */
				hasClick = true ;
				$("#form").submit();
			})
		})
		</script>
	</body>
</html>