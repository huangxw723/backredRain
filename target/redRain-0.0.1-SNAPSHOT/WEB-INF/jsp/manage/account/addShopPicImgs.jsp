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
			<form class="form-horizontal" id="form" action="account/saveShopPicImgs.do" method="post" enctype="multipart/form-data">
				<input type="hidden" name="shopId" value="${shopId}">				
				<div class="control-group" >
					<label class="control-label"></label>
					<div class="controls">
						
					</div>
				</div>
				<div class="control-group" >
					<label class="control-label"></label>
					<div class="controls">
						可添加多张图片，一次性最多2张图片     <font color="red">注：(图片尺寸规格750px * 476px)</font>
					</div>
					<div class="controls">
							<input  class="times" style="width: 180px;"  type='file' onchange="selectImg(this)"  name="files">
							<span class="help-inline">
								<!-- <a href="javascript:void(0);" onclick="addImg('inp')">选择图片</a> -->
								<a id="imgClean" style="display: none" href="javscript:void(0);" onclick="cleanImg()">清除图片</a>
							</span>
							<div id="images" style="float: left;border: 1px solid #ccc;"></div>
							<!-- <input id="imgStr" name="imgStr" type="hidden"> -->
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
		<script type="text/javascript" src="static/js/bootbox.min.js"></script><!-- 确认窗口 -->
		<!-- 编辑框-->
		<script type="text/javascript" charset="utf-8">window.UEDITOR_HOME_URL = "<%=path%>/plugins/ueditor/";</script>
		<script type="text/javascript" charset="utf-8" src="plugins/ueditor/ueditor.config.js"></script>
		<script type="text/javascript" charset="utf-8" src="plugins/ueditor/ueditor.all.js"></script>
		<script type="text/javascript">
		$(top.hangge());
		
		function EL(id) { return document.getElementById(id); } // Get el by ID helper function
		function zTreeOnClick(event,treeId,treeNode){
			//console.log(treeNode.goodsTypeId+","+treeNode.goodsTypeId);
		}
		
			//EL("inp").addEventListener("change", readFile, false);
			function addImg(inp){
				$("#"+inp).click();
			};
			
			function selectImg($this){
				$this.style.display = "none";
				$($this).after('<input class="times" style="width: 180px;" type="file" onchange="selectImg(this)" name="files">');
				var files = $this.files;
			 	var fileSize =$(files)[0].size/1024;
				if(parseInt(fileSize)>2048){
						$($this).remove();	
						$($this).val("");		
						bootbox.alert("图片不能大于2M");
						return;
				}
				 var thisvalue = $($this).val();
				  var pattern = /(\.*.jpg$)|(\.*.png$)|(\.*.jpeg$)|(\.*.gif$)|(\.*.bmp$)/i;     
				  if(!pattern.test(thisvalue)){
					 $($this).remove();	
					 $($this).val("");		
					  bootbox.alert("系统仅支持jpg/jpeg/png/gif/bmp格式的图片");
					 return;
				  }
				  var imgs = $(".times");
				  var len = imgs.length - 1;
				  var times = "${len}";
				  var value = 3 - times;
					if(len>value){
						bootbox.alert("最多能添加2张背景图片,您现在只能添加"+value+"张");
						$($this).remove();	
						$($this).val("");
						$("#imgClean").show();
						return ;
					}
				  if (files) {
					  if(len >2){
						  bootbox.alert("一次性只能添加2张图片");
						  	$($this).remove();	
							$($this).val("");
							$("#imgClean").show();
						  return ;
					  }
					  for(var i=0;i<files.length;i++){
						  var FR= new FileReader();
						    FR.onload = function(e) {
						      //EL("img").src       = e.target.result;
						     // console.log(e.target.result);
						     //压缩base64 
						      var result = base64Shorter(e.target.result);
						      $("#images").append('<img class="imgs" style="max-height:100px;max-width:100px;margin-left: 5px;margin-top: 5px" id="img" src="'+result+'">');
						      $("#imgClean").show();
						    };
						  FR.readAsDataURL( files[i] );
					  }
				  }  
			}
			
			
			function cleanFile(){
				var imgs = $(".times");
				var len = imgs.length;
				$("[type=file]")[len-1].remove();
			};
			
			function cleanImg(){
				var imgs = $(".imgs");
				var len = imgs.length;
				$(".imgs")[len-1].remove();
				if(len == 1){
					$("#images").empty();
					$("#imgClean").hide();
				}
				
				$("[type=file]")[len-1].remove();
				/* var imgs = $(".imgs");
				var length = imgs.length;
				
				if(length<=1){
					$("#imgClean").hide();
					$("#images").empty();
				}else{
					$(".imgs")[length-1].remove();
				} */
				
			}
			
			
		$(document).ready(function(){
			$(top.hangge());
			$("#save").click(function(){
				var times = "${len}";
				var imgs = $(".imgs");
				var len = imgs.length;
				var value = 3 - times;
				if(len>value){
					bootbox.alert("最多能添加2张背景图片,您现在只能添加"+value+"张");
					return ;
				}
				if(len == 0){
					bootbox.alert("请选择背景图片");
					return ;
				}
				$("#form").submit();
				$("#zhongxin").hide();
				$("#zhongxin2").show();
				
		 	})
			
		})
			
		</script>
	</body>
</html>