<%@ page import="com.aoshi.util.PropertyUtils" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%> 
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
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">

	<meta name="description" content="overview & stats" />
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	<!-- basic styles -->
	<link href="static/css/bootstrap.min.css" rel="stylesheet" />
	<link href="static/css/bootstrap-responsive.min.css" rel="stylesheet" />
	<link rel="stylesheet" href="static/css/font-awesome.min.css" />
	<!-- page specific plugin styles -->
	<!-- 下拉框-->
	<link rel="stylesheet" href="static/css/chosen.css" />
	<!-- ace styles -->
	<link rel="stylesheet" href="static/css/ace.min.css" />
	<link rel="stylesheet" href="static/css/ace-responsive.min.css" />
	<link rel="stylesheet" href="static/css/ace-skins.min.css" />
	<script type="text/javascript" src="static/js/jquery-1.7.2.js"></script>
	<link rel="stylesheet" href="static/css/datepicker.css" /><!-- 日期框 -->
	<!-- 引入 图片预览功能 -->
	<link rel="stylesheet" type="text/css" href="plugins/fancyBox/jquery.fancybox.css">
	<script type="text/javascript" src="plugins/fancyBox/jquery.fancybox.pack.js"></script>
	<!--引入弹窗组件start-->
	<script type="text/javascript" src="plugins/attention/zDialog/zDrag.js"></script>
	<script type="text/javascript" src="plugins/attention/zDialog/zDialog.js"></script>
	<!--引入弹窗组件end-->
	<script type="text/javascript" src="static/js/jquery.tips.js"></script>
</head>
<body>

<div class="container-fluid" id="main-container">


	<div id="page-content" class="clearfix">

		<div class="row-fluid">


			<div class="row-fluid">

				<table id="table_report" class="table table-striped table-bordered table-hover">

					<thead>
					<tr>
						<th style="text-align:center;">序号</th>
						<th style="text-align:center;">宣传图</th>
						<th style="text-align:center;">操作</th>
					</tr>
					</thead>

					<tbody>

					<!-- 开始循环 -->
					<c:choose>
						<c:when test="${not empty imgs}">
							<c:forEach items="${imgs}" var="var" varStatus="vs">

								<tr>
									<td class='center' style="text-align:center;">${vs.count}</td>
									<td class="center" width="300">
										<a class="fancybox" href="<%=httpUrl%>${var.imgUrl}">
											<img src="<%=httpUrl%>${var.imgUrl}" alt="${var.imgUrl}" width="50px" height="50px" />
										</a>
									</td>

									<td class='center'  style="text-align:center;">
									<a href="javascript:void(0);" onclick="del(${var.consultationImgsId},${fn:length(imgs)})">删除</a>
									<a href="javascript:void(0);" onclick="edit(${var.consultationImgsId})">编辑</a>
									</td>

								</tr>

							</c:forEach>



						</c:when>
						<c:otherwise>
							<tr class="main_info">
								<td colspan="10" class="center">没有相关数据</td>
							</tr>
						</c:otherwise>
					</c:choose>


					</tbody>
				</table>

				<div class="page-header position-relative">
					<table style="width: 100%;">
						<tr>
							<td style="vertical-align:top;">
								<c:forEach items="${imgs}" var="var" varStatus="vs" end="0">
									<a class="btn btn-small btn-success" onclick="add(${var.consultationImgsId},${fn:length(imgs)});">新增</a>
								</c:forEach>
								<a class="btn btn-small btn-success" onclick="flash();">刷新</a>
							</td>

							<td style="vertical-align: top;">
								<div class="pagination"
									 style="float: right; padding-top: 0px; margin-top: 0px;">${page.pageStr}</div>
							</td>
						</tr>
					</table>
				</div>
			</div>




			<!-- PAGE CONTENT ENDS HERE -->
		</div><!--/row-->

	</div><!--/#page-content-->
</div><!--/.fluid-container#main-container-->

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
<script type="text/javascript" src="static/js/bootstrap-datepicker.min.js"></script><!-- 日期框 -->
<script type="text/javascript" src="static/js/bootbox.min.js"></script><!-- 确认窗口 -->
<!-- 引入 -->


<script type="text/javascript" src="static/js/jquery.tips.js"></script><!--提示框-->
<script type="text/javascript">

	//$(top.hangge());

	//刷新
	function flash(){
		location.reload()
	}

	//新增
	function add(id,imgs){
		if(imgs>=5){
			alert("最多只能5张图片")
			return ;
		}
		//top.jzts();
		var diag = new top.Dialog();
		diag.Drag=true;
		diag.Title ="新增";
		diag.URL = '<%=basePath%>shopping/toAddImg.do?id='+id;
		diag.Width = 900;
		diag.Height = 700;
		diag.CancelEvent = function(){ //关闭事件
			if(diag.innerFrame.contentWindow.document.getElementById('zhongxin').style.display == 'none'){
				if('${page.currentPage}' == '0'){
					top.jzts();
					setTimeout("self.location=self.location",100);
				}else{
					if(typeof(nextPage) == "function") {
						//nextPage(${page.currentPage});
					}
				}
			}
			diag.close();
			flash();
		};
		diag.show();
	}


	//编辑
	function edit(id){
		//top.jzts();
		var diag = new top.Dialog();
		diag.Drag=true;
		diag.Title ="编辑";
		diag.URL = '<%=basePath%>shopping/toEditImg.do?id='+id;
		diag.Width = 900;
		diag.Height = 750;
		diag.CancelEvent = function(){ //关闭事件
			diag.close();
			setTimeout("self.location=self.location",100);
		};
		diag.show();
	}

	//删除
	function del(id,imgs){
		if(imgs<=1){
			alert("图片最小保留一张");
			return ;
		}
		if(confirm("确定删除吗?")){
			
			$.ajax({
				type: "POST",
				url: '<%=basePath%>shopping/deleteImg.do',
				data: {id:id},
				dataType:'json',
				//beforeSend: validateData,
				cache: false,
				success: function(data){
					if(data){						
						history.go(0);
					}
				}
			});
		}
	}

	

</script>

<script type="text/javascript">

	$(function() {

		//日期框
		$('.date-picker').datepicker();
		$(".fancybox").fancybox({
			helpers: {
				title: {
					type: 'inside'
				}
			}
		});

	});



</script>

</body>
</html>

