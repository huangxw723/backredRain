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
	
			<!-- 查询  -->
			<form action="bussinessActivity/listAuditHistory.do" method="post" name="usersForm" id="usersForm">
			<input type="hidden" id="currentPage" value="${pd.currentPage}"/>
			<input type="hidden" id="showCount" value="${pd.showCount}"/>
				<table>
					<tr>
								<td>
									<span>
										处理结果:
										<select name="auditStatus" id="auditStatus">
											<option value="">全部</option>									
											<option value="1" <c:if test="${pd.auditStatus eq 1}">selected="selected"</c:if>>已完成</option>
											<option value="2" <c:if test="${pd.auditStatus eq 2}">selected="selected"</c:if>>已驳回</option>						
										</select>
									</span>								
								</td>
								<td>
									<span class="input-icon">
										<input autocomplete="off" id="nav-search-input" type="text" name="shopName" value="${pd.shopName}" placeholder="商户名称" style="width:150px;" />
										<i  class="icon-search"></i>
									</span>
								</td>
								<td>
									<span class="input-icon">
										<input autocomplete="off" id="nav-search-input" type="text" name="eventName" value="${pd.eventName}" placeholder="活动名称" style="width:150px;" />
										<i  class="icon-search"></i>
									</span>
								<td>
									<span class="input-icon">
										<input autocomplete="off" id="nav-search-input" type="text" name="eventTitle" value="${pd.eventTitle}" placeholder="活动主题" style="width:150px;" />
										<i  class="icon-search"></i>
									</span>
								</td>
								<td style="vertical-align: top;">
										&nbsp;
										<button class="btn btn-mini btn-light" onclick="search();"
											title="查询">
											<i id="nav-search-icon" class="icon-search"></i>
										</button>
								</td>
							</tr>		
				</table>		
			</form>
			<!-- 检索  -->
		
		
			<table id="table_report" class="table table-striped table-bordered table-hover">
				
				<thead>
					<tr>
						<th style="text-align:center;">活动编号</th>
						<th style="text-align:center;">商户名称</th>
						<th style="text-align:center;">活动名称</th>
						<th style="text-align:center;">活动主题</th>
						<th style="text-align:center;">提交时间</th>
						<th style="text-align:center;">审批时间</th>
						<th style="text-align:center;">处理结果</th>
						<th style="text-align:center;">操作</th>						
					</tr>
				</thead>
										
				<tbody>
					
				<!-- 开始循环 -->	
				<c:choose>
					<c:when test="${not empty list}">
						<c:forEach items="${list}" var="var" varStatus="vs">
									
							<tr>
								<td class='center' style="text-align:center;">${var.asEventId}</td>
								<td class='center' style="text-align:center;">${var.shopName}</td>
								<td class='center' style="text-align:center;">${var.eventName}</td>
								<td class='center' style="text-align:center;">${var.eventTitle}</td>
								<td class='center' style="text-align:center;">${var.createTime}</td>
								<td class='center' style="text-align:center;">${var.auditTime}</td>
								<td class='center' style="text-align:center;">
									<c:if test="${var.auditStatus == 1}">
										<span>已完成</span>
									</c:if>
									<c:if test="${var.auditStatus == 2}">
										<span>已驳回</span>
									</c:if>
									
								</td>
								<form action="prizeconfig/listAuditHistoryByCfgId.do" method="post" name="listAuditHistoryByCfgIdFrom" id="listAuditHistoryByCfgIdFrom">
								
								<td class='center' style="text-align:center;">
								<input type="hidden" name="prizeConfigById" id="prizeConfigById" value=""/>
									
									<a class="" onclick="sendHistory(${var.asEventId})">详情</a>
								</td>	
								</form>
																								
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
		
		//检索
		function search(){
			top.jzts();
			var form = $("#usersForm");
			form.find('#currentPage').attr('name','currentPage');
			form.find('#showCount').attr('name','showCount');
			$("#usersForm").submit();
		}
		//历史页面跳转
		/*function sendHistory(asEventId){
		 $("#prizeConfigById").val(asEventId);
		 $("#listAuditHistoryByCfgIdFrom").submit();
		 }*/
		function sendHistory(id){

			top.jzts();
			var diag = new top.Dialog();
			diag.Drag=true;
			diag.Title ="查看详情";
			diag.URL='<%=basePath%>bussinessActivity/auditHistoryById?asEventId='+id;
			diag.Width = 900;
			diag.Height = 700;
			diag.CancelEvent = function(){ //关闭事件
				if(diag.innerFrame.contentWindow.document.getElementById('zhongxin').style.display == 'none'){
					if(typeof(nextPage) == "function") {
						nextPage(${page.currentPage});
					}
				}
				diag.close();
			};
			diag.show();
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

