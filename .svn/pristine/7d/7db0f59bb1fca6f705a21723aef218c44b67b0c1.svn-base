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
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>保存结果</title>
<base href="<%=basePath%>">
<meta name="description" content="overview & stats" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />

<script type="text/javascript" src="static/js/jquery-1.7.2.js"></script>

</head>
<body>
	<div id="page-content" class="clearfix">

		<div class="row-fluid">
			<!-- PAGE CONTENT BEGINS HERE -->
			<form class="form-horizontal" id="form" action="yp/admin/template/saveVedio.do" method="post" enctype="multipart/form-data">
				<input type="hidden" name="userModuleId" value="${userModuleId}">
				<div class="control-group">
					<label class="control-label">选择视频文件</label>
					<div class="controls">
						<input id="vedioFile" type="file" name="file">
					</div>
				</div>
				
				<div class="control-group">
					<label class="control-label"></label>
					<div class="controls">
						<video width="" style="width: 100%" height="200" controls="controls"  autoplay="autoplay">
						<source src="images/video.mov" type="video/mp4" >
						<source src="http://www.runoob.com/try/demo_source/movie.ogg" type="video/ogg">
				</video>
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
	</div>
	<script type="text/javascript">
		$(top.hangge());
	</script>
</body>
</html>