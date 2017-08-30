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
	<link type="text/css" rel="stylesheet" href="plugins/zTree/3.5/demo.css" />
  	<link type="text/css" rel="stylesheet" href="plugins/zTree/3.5/zTreeStyle.css" />
	</head> 
<body>
	<div id="page-content" class="clearfix">

		<div class="row-fluid">
			<!-- PAGE CONTENT BEGINS HERE -->
			<form class="form-horizontal" id="form" action="yp/admin/template/addThirdLv.do" method="post">

				<div class="control-group">
					<label class="control-label">模版名称</label>
					<div class="controls">
						<input type="text" name="templateName" placeholder="模版名称" required />
					</div>
				</div>
				<div class="control-group">
					<label class="control-label">模版类型</label>
					<div class="controls">
						<select name="templateTypeId">
							<c:forEach items="${templateTypes}" var="t">
								<option value="${t.templateTypeId}">${t.typeName}</option>
							</c:forEach>
						</select>
					</div>
				</div>
				
				<div class="control-group">
					<label class="control-label">父级模版</label>
					<div class="controls">
						<select name="parentBusinessTemplateId">
							<c:forEach items="${templates}" var="p">
								<option value="${p.businessTemplateId}">${p.templateName}</option>
							</c:forEach>
						</select>
					</div>
				</div>
				
				<div class="control-group">
					<label class="control-label">模板路径</label>
					<div class="controls">
						<input type="text" name="path" placeholder="如:template1" required />
					</div>
				</div>
				<div class="control-group">
					<label class="control-label">预览图</label>
					<div class="controls">
						<input type="text" name="preview" placeholder="如:template1" required />
					</div>
				</div>
				<div class="control-group">
					<label class="control-label">模块数量</label>
					<div class="controls">
						<input type="text" name="moduleNumber" placeholder="模块数量" required />
					</div>
				</div>
				<div class="control-group">
					<label class="control-label">模版级数</label>
					<div class="controls">
						<input type="text" name="level" value="3" placeholder="模版级数" required />
					</div>
				</div>
				<div class="control-group">
					<label class="control-label">是否是首页</label>
					<div class="controls">
						<input value="1" name="isHome" type="radio"><span class="lbl"> 是</span>
						<input value="0" name="isHome" type="radio" checked="checked"><span class="lbl"> 否</span>
					</div>
				</div>
				
				<!-- <div class="control-group">
					<label class="control-label">选择模块</label>
					<div class="controls">
						<select id="type" name="type">
							<option value="">--选择模块数--</option>
							<option value="3">3</option>
							<option value="4">4</option>
							<option value="5">5</option>
						</select>
					</div>
				</div> -->
				
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
				var name = $("[name=templateName]").val();
				var path = $("[name=path]").val();
				if(undefined==name || name.trim()==""){
					alert("名称不能为空");
					return ;
				}
				if(undefined==path || path.trim()==""){
					alert("页面路径不能为空");
					return ;
				}
				
				$("#form").submit();
			})
			
		})
			
		</script>
	</body>
</html>