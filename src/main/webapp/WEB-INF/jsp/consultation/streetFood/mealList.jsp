<%@ page import="com.aoshi.util.PropertyUtils" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
						<th style="text-align:center;">菜名</th>
						<th style="text-align:center;">菜图</th>

						<th style="text-align:center;">操作</th>
					</tr>
					</thead>

					<tbody>

					<!-- 开始循环 -->
					<c:choose>
						<c:when test="${not empty list}">
							<c:forEach items="${list}" var="asConsultationStreetFood" varStatus="vs">

								<tr>
									<td class='center' style="text-align:center;">${asConsultationStreetFood.foodName}</td>
									<td class="center" width="300">
										<a class="fancybox" href="<%=httpUrl%>${asConsultationStreetFood.foodImg}">
											<img src="<%=httpUrl%>${asConsultationStreetFood.foodImg}" alt="${asConsultationStreetFood.foodImg}" width="20px" height="20px" />
										</a>
									</td>

									<td class='center'  style="text-align:center;">
									<a href="javascript:void(0);" onclick="del(${asConsultationStreetFood.consultationStreetFoodId},'${asConsultationStreetFood.foodName}')">删除</a>
									<a href="javascript:void(0);" onclick="edit(${asConsultationStreetFood.consultationStreetFoodId})">编辑</a>
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
								<a class="btn btn-small btn-success" onclick="add(${consultationShopId});">新增</a>
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

	$(top.hangge());

	//刷新
	function flash(){
		location.reload()
	}

	//新增
	function add(id){
		top.jzts();
		var diag = new top.Dialog();
		diag.Drag=true;
		diag.Title ="新增";
		diag.URL = '<%=basePath%>consultation/streetFood/toAdd.do?id='+id;
		diag.Width = 1000;
		diag.Height = 750;
		diag.CancelEvent = function(){ //关闭事件
			if(diag.innerFrame.contentWindow.document.getElementById('zhongxin').style.display == 'none'){
				if('${page.currentPage}' == '0'){
					top.jzts();
					setTimeout("self.location=self.location",100);
				}else{
					if(typeof(nextPage) == "function") {
						nextPage(${page.currentPage});
					}
				}
			}
			diag.close();
		};
		diag.show();
	}


	//编辑
	function edit(id){
		top.jzts();
		var diag = new top.Dialog();
		diag.Drag=true;
		diag.Title ="编辑";
		diag.URL = '<%=basePath%>consultation/streetFood/toEdit.do?id='+id;
		diag.Width = 1000;
		diag.Height = 750;
		diag.CancelEvent = function(){ //关闭事件
			diag.close();
			setTimeout("self.location=self.location",100);
		};
		diag.show();
	}

	//删除
	function del(id,name){
		if(confirm("确定删除"+name+"吗?")){
			$.ajax({
				type: "POST",
				url: '<%=basePath%>consultation/streetFood/del.do',
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

	//禁用
	function disable(tagId,name){
		if(confirm("确定禁用标签"+name+"吗?")){
			$.ajax({
				type: "POST",
				url: '<%=basePath%>coupon/disable.do',
				data: {tagId:tagId},
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

