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
	<!--引入弹窗组件start-->
	<script type="text/javascript" src="plugins/attention/zDialog/zDrag.js"></script>
	<script type="text/javascript" src="plugins/attention/zDialog/zDialog.js"></script>
	<!--引入弹窗组件end-->
	<script type="text/javascript" src="static/js/jquery.tips.js"></script>
	<!-- 引入 图片预览功能 -->
	<link rel="stylesheet" type="text/css" href="plugins/fancyBox/jquery.fancybox.css">
	<script type="text/javascript" src="plugins/fancyBox/jquery.fancybox.pack.js"></script>
</head>
<body>

<div class="container-fluid" id="main-container">


	<div id="page-content" class="clearfix">

		<div class="row-fluid">


			<div class="row-fluid">
				<form action="consultation/navigation/shopList.do?type=0" method="post" name="Form" id="Form">
					<table id="table_report" class="table table-striped table-bordered table-hover">

						<thead>
						<tr>
							<%--<th class="center">--%>
							<%--<label>--%>
							<%--<input type="checkbox" id="zcheckbox" />--%>
							<%--<span class="lbl"></span>--%>
							<%--</label>--%>
							</th>
							<th style="text-align:center;">序号</th>
							<th style="text-align:center;">名称</th>
							<th style="text-align:center;">logo</th>
							<th style="text-align:center;">地址</th>
							<th style="text-align:center;">分类</th>
							<th style="text-align:center;">官网链接</th>
							<th style="text-align:center;">操作</th>
						</tr>
						</thead>

						<tbody>

						<!-- 开始循环 -->
						<c:choose>
							<c:when test="${not empty list}">
								<c:forEach items="${list}" var="brandCategory" varStatus="vs">

									<tr>
											<%--<td class='center' style="width: 30px;">--%>
											<%--<label>--%>
											<%--<input type='checkbox' name='ids' value="${brandCategory.id}" />--%>
											<%--<span class="lbl"></span>--%>
											<%--</label>--%>
											<%--</td>--%>
										<td class='center' style="text-align:center;">${vs.index+1}</td>
										<td class='center' style="text-align:center;">${brandCategory.name}</td>
										<td class="center" style="text-align:center;">
											<a class="fancybox" href="<%=httpUrl%>${brandCategory.logo}">
												<img src="<%=httpUrl%>${brandCategory.logo}" alt="${brandCategory.logo}" width="20px" height="20px" />
											</a>
										</td>
										<td class='center' style="text-align:center;">${brandCategory.address}</td>
										<td class='center' style="text-align:center;">${brandCategory.categoryName}</td>
										<c:choose>
											<c:when test="${empty brandCategory.site}">
												<td class='center' style="text-align:center;">无链接</td>
											</c:when>
											<c:otherwise>
												<td class='center' style="text-align:center;">${brandCategory.site}</td>
											</c:otherwise>
										</c:choose>
										<td class='center'  style="text-align:center;">
											<a href="javascript:void(0);" onclick="deleteCategory(${brandCategory.asConsultationNavigationId})">删除</a>
											<a href="javascript:void(0);" onclick="edit(${brandCategory.asConsultationNavigationId},${brandCategory.type})">编辑</a>
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
				</form>
				<div class="page-header position-relative">
					<table style="width: 100%;">
						<tr>
							<td style="vertical-align:top;">
								<a class="btn btn-small btn-success" onclick="add(${type});">新增</a>
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

	//检索
	function search(){
		top.jzts();
		$("#userForm").submit();
	}

	//新增
	function add(type){
		top.jzts();
		var diag = new top.Dialog();
		diag.Drag=true;
		diag.Title ="新增";
		diag.URL = '<%=basePath%>consultation/navigation/toAddStoreOrShop.do?type='+type;
		diag.Width = 1000;
		diag.Height = 800;
		diag.CancelEvent = function(){ //关闭事件
			diag.close();
			setTimeout("self.location=self.location",100);
		};
		diag.show();
	}
	//编辑
	function edit(id,type){
		top.jzts();
		var diag = new top.Dialog();
		diag.Drag=true;
		diag.Title ="编辑";
		diag.URL = '<%=basePath%>consultation/navigation/toEditStore.do?id='+id +"&type="+type;
		diag.Width = 1000;
		diag.Height = 800;
		diag.CancelEvent = function(){ //关闭事件
			diag.close();
			setTimeout("self.location=self.location",100);
		};
		diag.show();
	}

	//删除
	function deleteCategory(id){
		if(confirm("确定删除该店铺吗?")){
			$.ajax({
				type: "POST",
				url: '<%=basePath%>consultation/navigation/delNavigationStore.do',
				data: {id:id},
				dataType:'json',
				//beforeSend: validateData,
				cache: false,
				success: function(data){
					if(data){
						setTimeout("self.location=self.location",100);
					}
				}
			});
		}
	}
</script>
<script type="text/javascript">

	$(function() {

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

