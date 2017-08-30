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
</head> 
<body>
		
<div class="container-fluid" id="main-container">


<div id="page-content" class="clearfix">
						
  <div class="row-fluid">


	<div class="row-fluid">
	
			<!-- 检索  -->
			<form action="ownGift/listAll" method="post" name="usersForm" id="usersForm">
				<input type="hidden" id="currentPage" value="${currentPage}"/>
				<input type="hidden" id="showCount" value="${showCount}"/>
				<table>
					<tr>
								<td>
									<span>
									礼品类型:
									<select name="categoryId" id="categoryId" style="vertical-align:top;width: 90px">
										<option value="">全部</option>
										<c:forEach items="${type}" var="var" varStatus="index">
											<option value="${var.id}" <c:if test="${var.id eq categoryId}">selected</c:if>>${var.name}</option>
										</c:forEach>
									</select>
								</span>

								<span class="input-icon"> 
									<input autocomplete="off" id="nav-search-input" type="text" name="keyWord" value="${keyWord}" placeholder="礼品编号/礼品名称<c:if test="${isShop == 0}">/商户名称</c:if>"  style="width:220px;"/>
										<i class="icon-search"></i>
								</span>
								</td>
								<td style="vertical-align: top;">
									&nbsp;
										<button class="btn btn-mini btn-light" onclick="search();"
											title="查询">
											<i id="nav-search-icon" class="icon-search"></i>
										</button>
										 
								</td>
								<td style="vertical-align: top;">
									&nbsp;
									<a class="btn btn-small btn-success" onclick="toExcel();">导出excel</a>

								</td>
								<td style="vertical-align: top;">
										&nbsp;
										<%--<a class="btn btn-small btn-success" onclick="addPrize();" <c:if test="${isShop == 0}">style="display: none;"</c:if>>新增</a>--%>
										<a class="btn btn-small btn-success" onclick="addPrize();" >新增</a>

								</td>
							</tr>		
				</table>		
			</form>
			<!-- 检索  -->
		
		
			<table id="table_report" class="table table-striped table-bordered table-hover">
				
				<thead>
					<tr>
						<th style="text-align:center;">礼品编号</th>
						<th style="text-align:center;">礼品名称</th>
						<th style="text-align:center;">礼品类型</th>
						<c:if test="${isShop == 0}">
							<th style="text-align:center;">商户名称</th>
						</c:if>
						<th style="text-align:center;">实际兑换</th>
						<th style="text-align:center;">礼品数量(余/总)</th>
						<th style="text-align:center;">开始时间</th>
						<th style="text-align:center;">结束时间</th>
						<th style="text-align:center;">操作</th>
					</tr>
				</thead>
										
				<tbody>
					
				<!-- 开始循环 -->	
				<c:choose>
					<c:when test="${not empty list}">
						<c:forEach items="${list}" var="var" varStatus="vs">
							<tr>
								<td class='center' style="text-align:center;">${var.sn}</td>
								<td class='center' style="text-align:center;">${var.name}</td>
								<td class='center' style="text-align:center;">${var.asYpBaseCategory.name}</td>
								<c:if test="${isShop == 0}">
									<td class='center' style="text-align:center;">${var.shopName}</td>
								</c:if>
								<td class='center' style="text-align:center;">
									<c:forEach items="${exchangeCountList}" var="var1" >
										<c:if test="${var1.prizeConfigId == var.prizeConfigId}">${var1.exchangeCount}</c:if>
									</c:forEach>
								</td>
								<td class='center' style="text-align:center;">${var.surplusCounts}/${var.counts}</td>
								<td class='center' style="text-align:center;">${var.startTime}</td>
								<td class='center' style="text-align:center;">${var.endTime}</td>
								<td class='center' style="text-align:center;">
										<a href="javascript:void(0);" onclick="preview(${var.prizeConfigId})">详情</a>
										<c:if test="${var.status ne 4}">
											<a href="javascript:void(0);" onclick="edit(${var.prizeConfigId})">编辑</a>
										</c:if>
										<%--<a href="javascript:void(0);" onclick="edit(${var.prizeConfigId})">${isShop == 0 ? '详情' :'编辑'}</a>--%>
										<%-- <a href="javascript:void(0);" onclick="del(${var.prizeConfigId})"<c:if test="${var.status == 1}">style="display: none;"</c:if>>删除</a> --%>
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
		<link rel="stylesheet" type="text/css" href="plugins/fancyBox/jquery.fancybox.css">
		<script type="text/javascript" src="plugins/fancyBox/jquery.fancybox.pack.js"></script>

		<script type="text/javascript">
		
		$(top.hangge());
		
		//刷新
		   function ref(){
		 	window.location.reload(); 
		   }

		
		//检索
		function search(){
			top.jzts();
			var form = $("#usersForm");
			form.find('#currentPage').attr('name','currentPage');
			form.find('#showCount').attr('name','showCount');
			form.submit();
		}

		//导出excel
		function toExcel(){

			var categoryId = '${categoryId}';
			var keyWord = '${keyWord}';
			var currentPage = '${currentPage}';
			var showCount = '${showCount}';

			window.location.href='<%=basePath%>ownGift/ownGiftListAll.do?categoryId='+categoryId+'&keyWord='+keyWord+'&showCount='+showCount+'&currentPage='+currentPage;

		}
		 
		
		//添加
		function addPrize(){
			 top.jzts();
			 var diag = new top.Dialog();
			 diag.Drag=true;
			 diag.Title ="添加礼品";
			 diag.URL = '<%=basePath%>ownGift/down';
			 diag.Width = 1150;
			 diag.Height = 650;
			 diag.CancelEvent = function(){ //关闭事件
				diag.close();
				ref();
			 };
			 diag.show();
		}
		//查看详情
		function preview(prizeConfigId){
			 top.jzts();
			 var diag = new top.Dialog();
			 diag.Drag=true;
			 diag.Title ="资料";
			 diag.URL = '<%=basePath%>ownGift/toEdit?prizeConfigId='+prizeConfigId+"&action=4";
			 diag.Width = 1150;
			 diag.Height = 610;
			 diag.CancelEvent = function(){ //关闭事件
				diag.close();
				ref();
			 };
			 diag.show();
		}
		//修改
		function edit(prizeConfigId){
			 top.jzts();
			 var diag = new top.Dialog();
			 diag.Drag=true;
			 diag.Title ="资料";
			 diag.URL = '<%=basePath%>ownGift/toEdit?prizeConfigId='+prizeConfigId+"&action=2";
			 diag.Width = 1150;
			 diag.Height = 610;
			 diag.CancelEvent = function(){ //关闭事件
				diag.close();
				ref();
			 };
			 diag.show();
		}
	

		//删除
		function del(id){
			
			if(confirm("确定删除吗?")){
			
			$.get("ownGift/delete",{prizeConfigId:id},function(data){
				
				if(data.status != 0){
					alert(data.msg);
					setTimeout("self.location=self.location",100);
					return;
				}
				
				setTimeout("self.location=self.location",100);
			},'json');
			}
		}
	
		
		</script>
		
		<script type="text/javascript">
		
		$(function() {
			
			//日期框
			$('.date-picker').datepicker();
			
			//下拉框
			$(".chzn-select").chosen(); 
			$(".chzn-select-deselect").chosen({allow_single_deselect:true}); 
			
			//复选框
			$('table th input:checkbox').on('click' , function(){
				var that = this;
				$(this).closest('table').find('tr > td:first-child input:checkbox')
				.each(function(){
					this.checked = that.checked;
					$(this).closest('tr').toggleClass('selected');
				});
					
			});
			
		});
		
		</script>
		
	</body>
</html>

