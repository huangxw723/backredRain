<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="java.util.*" %>
<%@ page import="java.text.*" %>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
	String datetime=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(Calendar.getInstance().getTime()); //获取系统时间 
	request.setAttribute("currentTime",datetime);
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
			<form action="bussinessActivity/listAll.do" method="post" name="usersForm" id="usersForm">
			<input type="hidden" id="currentPage" value="${pd.currentPage}"/>
			<input type="hidden" id="showCount" value="${pd.showCount}"/>		
				<table>
					<tr>	
					<td>
					<span class="input-icon"> 
					<input autocomplete="off" id="nav-search-input" type="text" name="keyWord" value="${pd.keyWord}" placeholder="活动名称/活动主题/商户名称" style="width:220px;"/>
					<i  class="icon-search"></i>
					</span>&nbsp;&nbsp;			
					<span>
					 状态:
					<select name="status" id="status" style="vertical-align:top;width: 70px">
						<option value="">全部</option>
						<option value="1" <c:if test="${pd.status eq 1}">selected="selected"</c:if>>启用</option>
						<option value="2" <c:if test="${pd.status eq 2}">selected="selected"</c:if>>禁用</option>
						<option value="3" <c:if test="${pd.status eq 3}">selected="selected"</c:if>>待审</option>
						<option value="4" <c:if test="${pd.status eq 4}">selected="selected"</c:if>>驳回</option>
						</select>
					</span>					
					</td>
					<td style="vertical-align: top;">&nbsp;&nbsp;
						<button class="btn btn-mini btn-light" onclick="search();"
							title="查询">
						<i id="nav-search-icon" class="icon-search"></i>
						</button>
										 
					</td>								
					<td style="vertical-align: top;">&nbsp;									
					<a class="btn btn-small btn-success" onclick="addEvent();">新增</a>
					</td>
					</tr>		
				</table>		
			</form>
			<!-- 检索  -->
		
		
			<table id="table_report" class="table table-striped table-bordered table-hover">
				
				<thead>
					<tr>
						<th style="text-align:center;">活动名称</th>
						<th style="text-align:center;">活动主题</th>						
						<th style="text-align:center;">商户名称</th>						
						<th style="text-align:center;">开始时间</th>
						<th style="text-align:center;">结束时间</th>
						<th style="text-align:center;">状态</th>
						<th style="text-align:center;">操作</th>					
					</tr>
				</thead>
										
				<tbody>
					
				<!-- 开始循环 -->	
				<c:choose>
					<c:when test="${not empty list}">
						<c:forEach items="${list}" var="var" varStatus="vs">
									
							<tr>
								<td class='center' style="text-align:center;">${var.eventName}</td>
								<td class='center' style="text-align:center;">${var.eventTitle}</td>
								<td class='center' style="text-align:center;">${var.shopName}</td>				
								<td class='center' style="text-align:center;">${var.startTime}</td>
								<td class='center' style="text-align:center;">${var.endTime}</td>
								<td class='center' style="text-align:center;">
									<c:if test="${var.status == 1}">
										<a href="javascript:void(0);" onclick="updateEventStatus(${var.asEventId},2)">禁用</a>
									</c:if>
									<c:if test="${var.status == 2}">
										<a href="javascript:void(0);" onclick="updateEventStatus(${var.asEventId},1)">启用</a>
									</c:if>
									<c:if test="${var.auditStatus == 0}">
										<span>待审</span>
									</c:if>
									<c:if test="${var.auditStatus == 2}">
										<a href="javascript:void(0);" title="查看驳回理由" onclick="reason(${var.asEventId})">驳回</a>
									</c:if>
								</td>
								<td class='center' style="text-align:center;">
										<a href="javascript:void(0);" onclick="query(${var.asEventId})">详情</a>	
										<c:if test="${var.endTime gt currentTime  or var.status == 0 }">
										<a href="javascript:void(0);" onclick="edit(${var.asEventId})">编辑</a>
										</c:if>													
										<c:if test="${var.auditStatus == 2 }">								
										<a href="javascript:void(0);" onclick="updateEventStatus(${var.asEventId},0)">重发</a>
										</c:if>
										<c:if test="${var.auditStatus == 0 or var.auditStatus == 2}">										
										<a href="javascript:void(0);" onclick="updateEventStatus(${var.asEventId},5)">删除</a>					
										</c:if>								
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
				
		//检索
		function search(){
			top.jzts();
			var form = $("#usersForm");
			form.find('#currentPage').attr('name','currentPage');
			form.find('#showCount').attr('name','showCount');
			$("#usersForm").submit();
		}
		
		//新增活动
		function addEvent(){
					var form = $("#usersForm");
					form.find('#currentPage').attr('name','currentPage');
					form.find('#showCount').attr('name','showCount');
					 top.jzts();
					 var diag = new top.Dialog();
					 diag.Drag=true;
					 diag.Title ="新增活动";
					 diag.URL = '<%=basePath%>bussinessActivity/page?action=1';
					 diag.Width = 1150;
					 diag.Height = 760;
					 diag.CancelEvent = function(){ //关闭事件
						diag.close();
						form.submit();
					 };
					 diag.show();
				}
		//修改
		function edit(id){
			
			var form = $("#usersForm");
			var parems = 'action=2'+ '&asEventId='+id;
			form.find('#currentPage').attr('name','currentPage');
			form.find('#showCount').attr('name','showCount');
			 top.jzts();
			 var diag = new top.Dialog();
			 diag.Drag=true;
			 diag.Title ="编辑活动";
			 diag.URL = '<%=basePath%>bussinessActivity/page.do?'+parems;
			 diag.Width = 1150;
			 diag.Height = 760;
			 diag.CancelEvent = function(){ //关闭事件
				diag.close();
				form.submit();
			 };
			 diag.show();
		}
		//查看
		function query(id){
			
			var form = $("#usersForm");
			var parems = 'action=4'+ '&asEventId='+id;
			form.find('#currentPage').attr('name','currentPage');
			form.find('#showCount').attr('name','showCount');
			 top.jzts();
			 var diag = new top.Dialog();
			 diag.Drag=true;
			 diag.Title ="查看活动";
			 diag.URL = '<%=basePath%>bussinessActivity/page.do?'+parems;
			 diag.Width = 1150;
			 diag.Height = 760;
			 diag.CancelEvent = function(){ //关闭事件
				diag.close();
			 };
			 diag.show();
		}
		
		//查看驳回理由
		function reason(id){
			var form = $("#usersForm");
			form.find('#currentPage').attr('name','currentPage');
			form.find('#showCount').attr('name','showCount');
			 top.jzts();
			 var diag = new top.Dialog();
			 diag.Drag=true;
			 diag.Title ="理由";
			 diag.URL = '<%=basePath%>bussinessActivity/reason.do?action=4&asEventId='+id;
			 diag.Width = 600;
			 diag.Height = 450;
			 diag.CancelEvent = function(){ //关闭事件
				diag.close();
			 };
			 diag.show();
			
		}
			
		//删除
		function updateEventStatus(id,status){
			var form = $('#usersForm')
			form.find('#currentPage').attr('name','currentPage');
			form.find('#showCount').attr('name','showCount');
			if(status==5){
			bootbox.confirm("确定要删除该活动吗?",function(result){
				if(result) {
					$.ajax({
						type: "POST",
						url: "<%=basePath%>bussinessActivity/deletEvent.do",
				    	data: {asEventId:id},
						dataType:'json',
						success: function(data){
							if(data.status != 0){
								alert(data.msg);
								return;
							}
								history.go(0);
						}
					});
				}
			});	
			}else if(status==2){//禁用
				bootbox.confirm("确定要禁用该活动吗?",function(result){
					if(result) {
						$.ajax({
							type: "POST",
							url: "<%=basePath%>bussinessActivity/updateEventStatus.do",
					    	data: {"asEventId":id,"status":status},
							dataType:'json',
							success: function(data){
								if(data.status != 0){
									alert(data.msg);
									return;
								}
									history.go(0);
							}
						});
					}
				});
			}else if(status==1){//启用
				bootbox.confirm("确定要启用该活动吗?",function(result){
					if(result) {
						$.ajax({
							type: "POST",
							url: "<%=basePath%>bussinessActivity/updateEventStatus.do",
					    	data: {"asEventId":id,"status":status},
							dataType:'json',
							success: function(data){
								if(data.status != 0){
									alert(data.msg);
									return;
								}
									history.go(0);
							}
						});
					}
				});
			}else if(status==0){//重发
				bootbox.confirm("确定要重发该活动吗?",function(result){
					if(result) {
						$.ajax({
							type: "POST",
							url: "<%=basePath%>bussinessActivity/updateEventStatus.do",
					    	data: {"asEventId":id,"status":status},
							dataType:'json',
							success: function(data){
								if(data.status != 0){
									alert(data.msg);
									return;
								}
									history.go(0);
							}
						});
					}
				});
			}
			
		};
		
		
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

