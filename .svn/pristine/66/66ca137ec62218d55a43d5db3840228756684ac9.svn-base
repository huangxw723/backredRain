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
			<form class="form-horizontal" id="form" action="goods/editGoodsImgs.do" method="post" enctype="multipart/form-data">
				<input type="hidden" name="goodsId" value="${goodsId}">				
				<input type="hidden" name="goodsImgsId" value="${goodsImgsId}">				
				<div class="control-group" >
					<label class="control-label">上传商品图</label>
					<div class="controls" style="width: 300px">
				              <a id="imgBox" href="javascript:void(0)" style="display:none;">
				                <img src="" width="220" id="imgHref" />
				              </a>
				              <input type="file" id="files" name="files"  />
				              <font color="red">注：(图片尺寸规格750px * 638px)</font>
				            <input id="url" name="img" type="hidden" />
					</div>
				</div>
				<div id="zhongxin" align="center" >
					 <a class="btn btn-mini btn-primary" id="save">保存</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
           			 <a class="btn btn-mini btn-danger" onclick="top.Dialog.close();">取消</a>
				</div>
				<div id="zhongxin2" class="center" style="display:none">
     				 <br />
     				 <img src="static/images/jiazai.gif" />
     				 <br />
     				 <h4 class="lighter block green">提交中...</h4>
   				 </div>
			</form>

		</div>
		<!-- PAGE CONTENT ENDS HERE -->
  		</div><!--/row-->
	
			 <!-- 引入 -->
	  <script type="text/javascript">window.jQuery || document.write("<script src='static/js/jquery-1.9.1.min.js'>\x3C/script>");</script>
	  <script src="static/js/bootstrap.min.js"></script>
	  <script src="static/js/ace-elements.min.js"></script>
	  <script src="static/js/ace.min.js"></script>
	  <script type="text/javascript" src="static/js/chosen.jquery.min.js"></script>
		<script type="text/javascript" src="static/js/bootbox.min.js"></script><!-- 确认窗口 -->
		<!-- ztree -->
	 <link type="text/css" rel="stylesheet" href="plugins/zTree/3.5/demo.css" />
  	 <link type="text/css" rel="stylesheet" href="plugins/zTree/3.5/zTreeStyle.css" />
	 <script type="text/javascript" src="plugins/zTree/3.5/jquery.ztree.core.min.js"></script>
	 <script type="text/javascript" src="plugins/zTree/3.5/jquery.ztree.excheck.min.js"></script>
		 <!-- base64 -->
	  <script src="static/js/base64.js"></script>
	  <link rel="stylesheet" type="text/css" href="plugins/fancyBox/jquery.fancybox.css">
	  <script type="text/javascript" src="plugins/fancyBox/jquery.fancybox.pack.js"></script>
	  <!-- js工具类 -->
	 <script type="text/javascript" src="static/js/common/commonutils.js"></script>
		<script type="text/javascript">
		$(top.hangge());
		
		//上传图片
		$('#files:visible').ace_file_input({
			no_file : '请选择图片 ...',
			btn_choose : '选择',
			btn_change : '更改',
			droppable : false,
			onchange : null,
			thumbnail : false,
			before_remove : function() {
				$("#url").val("");
				$("#imgBox").attr("href", "").hide();
				$("#imgHref").attr("src", "");
				return true;
			}
		});
		
		new img2base64("files", "url", "imgHref", "imgBox");

		$("#imgBox").fancybox({
			helpers : {
				title : {
					type : 'inside'
				}
			}
		});
			
		$(document).ready(function(){
			
			$("#save").click(function(){
				
				var fileType = document.getElementById("files").value.substr(document.getElementById("files").value.lastIndexOf(".")).toLowerCase();//获得文件后缀名
				var url = $("#url").val();
				var img = $("#imgHref").attr("src");
				if (!img || url) {
					if (fileType != '.gif' && fileType != '.png' && fileType != '.jpg'&& fileType != '.bmp'
							&& fileType != '.jpeg') {
						$("#files").tips({
							side : 3,
							msg : '请上传图片格式的文件',
							bg : '#AE81FF',
							time : 5
						});
						$("#files").val('');
						return;
					}
				}
				var img = document.getElementById("files").files;
				var imgSize = img[0].size/1024;
				if(imgSize>2048){
					bootbox.alert("图片不能大于2M");
					return;
				}
				
				$("#form").submit();
				$("#zhongxin").hide();
				$("#zhongxin2").show();
				
		 	})
			
		})
			
		</script>
	</body>
</html>