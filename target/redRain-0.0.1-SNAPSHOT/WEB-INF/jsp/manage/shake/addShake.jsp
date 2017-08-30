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
			<form class="form-horizontal" id="form" action="prizeRule/goShake.do" method="post" enctype="multipart/form-data">
				<div class="form-actions">
					<label class="control-label">奖品类型名称:</label>
					<div class="controls">
						<input type="text" id="name" name="name" placeholder="奖品类型名称" required />
					</div>
					<div class="form-actions" >
					 <a class="btn btn-mini btn-primary" onclick="save()">确定</a>&nbsp;
                     <a class="btn btn-mini btn-danger" onclick="top.Dialog.close();">取消</a>
				    </div>
				</div>
				<%--<div class="control-group">--%>
					<%--<label class="control-label">奖品类型概率:</label>--%>
					<%--<div class="controls">--%>
						<%--<input id="probability" class="shake" type="number" name="probability" value="${s.probability}" placeholder="${s.probability}" required/>--%>
					<%--</div>--%>
				<%--</div>--%>
			
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
		$(top.hangge());
			function save(){
				var name = $("#name").val();
				//var probability = $("#probability").val();
				if(name.trim()=="" || undefined==name){
					alert("名称不能为空");
					return ;
				}
              $.ajax({
					type: "POST",
					url: '<%=basePath%>prizeRule/saveShake.do',
			    	data: {name:name},
					dataType:'json',					
					cache: false,
					async: true,				
					success: function(data){						
						 if(data == 1){
						    alert("操作成功");
						    top.Dialog.close();
						 }else if(data == 0){
							 alert("已超出10个奖级设置，请删除后重新设置");	
							 top.Dialog.close();
						 }
					}
				});
	          
				
				//top.Dialog.close();
			}	
						
			
			
		
		</script>
	</body>
</html>