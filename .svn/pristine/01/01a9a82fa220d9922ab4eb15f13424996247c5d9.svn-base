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
	<!-- <link rel="stylesheet" href="static/css/datepicker.css" /> --><!-- 日期框 -->
	<link rel="stylesheet" href="static/css/bootstrap-datetimepicker.min.css" /><!-- 日期框 -->
	<!--日期格式化-->
	<script type="text/javascript" src="static/js/dateFormat.js"></script>
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
			<form action="activityRedrain/getActivityRedraintList.do" method="post" name="activityRedrainForm" id="activityRedrainForm">
			<input type="hidden" id="currentPage" value="${pd.currentPage}"/>
			<input type="hidden" id="showCount" value="${pd.showCount}"/>
				<table>
					<tr>
					
								<td>
								 
								活动名称:
								<span class="input-icon"> 
									<input autocomplete="off" id="nav-search-input" type="text" name="keyWord" value="${pd.keyWord}" placeholder="这里输入关键词" style="width:220px;"/>
										<i id="nav-search-icon" class="icon-search"></i>
								</span>
								活动时间:
								<span>
             					<span class="input-icon"> 
             						<input class="span10 date-picker" name="startTime" id="startTime" type="text" value="${pd.startTime}" data-date-format="yyyy-mm-dd hh:ii:ss" style="width:220px;" placeholder="开始时间"/>至
             						<input class="span10 date-picker" name="endTime" id="endTime" type="text" value="${pd.endTime}" data-date-format="yyyy-mm-dd hh:ii:ss" style="width:220px;" placeholder="结束时间"/>
             	
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
										<a class="btn btn-small btn-success" onclick="add();">新增</a>
										 
								</td>
							</tr>		
				</table>		
			</form>
			<!-- 检索  -->
		
		
			<table id="table_report" class="table table-striped table-bordered table-hover">
				
				<thead>
					<tr>
						<th style="text-align:center;">活动名称</th>
						<th style="text-align:center;">活动开始时间</th>
						<th style="text-align:center;">活动结束时间</th>
						<th style="text-align:center;">活动期数</th>
						<th style="text-align:center;">活动状态</th>
						<th style="text-align:center;">操作</th>
					</tr>
				</thead>
										
				<tbody>
					
				<!-- 开始循环 -->	
				<c:choose>
					<c:when test="${not empty list}">
						<c:forEach items="${list}" var="var" varStatus="vs">
									
							<tr>
							<td class='center' style="text-align:center;">${var.activityName}</td>
								<td class='center' style="text-align:center;">${var.startTime}</td>
								<td class='center' style="text-align:center;">${var.endTime}</td>
								<c:if test="${var.activityStatus == 1}">
									<td class='center' style="text-align:center;"></td>
								</c:if>
								<c:if test="${var.activityStatus != 1}">
									<td class='center' style="text-align:center;">${var.activityCode}</td>
								</c:if>
								
							   <td class='center' style=" style="text-align:center;">
									<c:if test="${var.activityStatus == 1}">
										<span>未开始</span>
									</c:if>
									<c:if test="${var.activityStatus == 2}">
										<span>进行中</span>
									</c:if>
									<c:if test="${var.activityStatus == 3}">
										<span>已结束</span>
									</c:if>
								</td>
								<td class='center' style="textext-align:center;">
								    <c:if test="${var.activityStatus == 1}">
										<a href="javascript:void(0);" onclick="edit(${var.activityRedrainId},${var.activityId},1)">编辑</a>
										&nbsp;
									</c:if>
									
								    <c:if test="${var.activityStatus == 2}">
										<a href="javascript:void(0);" onclick="edit(${var.activityRedrainId},${var.activityId},2)">编辑</a>
										&nbsp;
										<a href="javascript:void(0);" onclick="edit(${var.activityRedrainId},${var.activityId},2)">活动回顾</a>
									</c:if>
									
									<c:if test="${var.activityStatus == 3}">
									    <a href="javascript:void(0);" onclick="edit(${var.activityRedrainId},${var.activityId},3)">编辑</a>
										<a href="javascript:void(0);" onclick="edit(${var.activityRedrainId},${var.activityId},3)">活动回顾</a>
									</c:if>
										&nbsp;
									<a href="javascript:void(0);" onclick="idelete(${var.activityRedrainId},${var.activityId})">删除</a>
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
		<!-- <script type="text/javascript" src="static/js/bootstrap-datepicker.min.js"></script> --><!-- 日期框 -->
		<script type="text/javascript" src="static/js/bootstrap-datetimepicker.js"></script><!-- 日期框 -->
		<script type="text/javascript" src="static/js/bootstrap-datetimepicker.zh-CN.js"></script><!-- 日期框 -->
		
		<script type="text/javascript" src="static/js/bootbox.min.js"></script><!-- 确认窗口 -->
		<!-- 引入 -->
		<script type="text/javascript" src="static/js/jquery.tips.js"></script><!--提示框-->
		<link rel="stylesheet" type="text/css" href="plugins/fancyBox/jquery.fancybox.css">
		<script type="text/javascript" src="plugins/fancyBox/jquery.fancybox.pack.js"></script>

		<script type="text/javascript">
		
		$(top.hangge());
		
		//修改
		function edit(activityRedrainId,activityId,activityStatus){
			
			var form = $("#activityRedrainForm");
			var parems = 'action=2'+ '&activityId='+activityId+'&activityStatus='+activityStatus+'&activityRedrainId='+activityRedrainId ;
			form.find('#currentPage').attr('name','currentPage');
			form.find('#showCount').attr('name','showCount');
			 top.jzts();
			 var diag = new top.Dialog();
			 diag.Drag=true;
			 diag.Title ="编辑红包雨活动";
			 diag.URL = '<%=basePath%>activityRedrain/addShopAccountInfoPage.do?'+parems;
			 diag.Width = 1150;
			 diag.Height = 650;
			 diag.CancelEvent = function(){ //关闭事件
				diag.close();
				form.submit();
			 };
			 diag.show();
		}
		
		//检索
		function search(){
			top.jzts();
			var form = $("#activityRedrainForm");
			form.find('#currentPage').attr('name','currentPage');
			form.find('#showCount').attr('name','showCount');
			$("#activityRedrainForm").submit();
		}
		
		 
		
		//添加
		function add(){
					var form = $("#activityRedrainForm");
					form.find('#currentPage').attr('name','currentPage');
					form.find('#showCount').attr('name','showCount');
					 top.jzts();
					 var diag = new top.Dialog();
					 diag.Drag=true;
					 diag.Title ="新增红包雨活动";
					 diag.URL = '<%=basePath%>activityRedrain/addShopAccountInfoPage?action=1';
					 diag.Width = 1300;
					 diag.Height = 950;
					 diag.CancelEvent = function(){ //关闭事件
						diag.close();
						form.submit();
					 };
					 diag.show();
				}
	
		//查看（回顾）& 活动结束
		function query(id){
			
			var form = $("#activityRedrainForm");
			var parems = 'action=4'+ '&prizeConfigId='+id+'&activityType='+"${activityType}" ;
			form.find('#currentPage').attr('name','currentPage');
			form.find('#showCount').attr('name','showCount');
			 top.jzts();
			 var diag = new top.Dialog();
			 diag.Drag=true;
			 diag.Title ="红包雨活动详情";
			 diag.URL = '<%=basePath%>prizeconfig/page.do?'+parems;
			 diag.Width = 1150;
			 diag.Height = 610;
			 diag.CancelEvent = function(){ //关闭事件
				diag.close();
			 };
			 diag.show();
		}
		
		 
		
		
		
		</script>
		
		<script type="text/javascript">
		
		$(function() {
			
			//日期框
			//$('.date-picker').datetimepicker();
			
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
			
			/* $('#startTime').datepicker({  
			    todayBtn : "linked",  
			    autoclose : true,  
			    todayHighlight : true,  
			    endDate : new Date()  
			}).on('changeDate',function(e){  
			    var startTime = e.date;  
			    $('#endTime').datepicker('setStartDate',startTime);  
			});  
			//结束时间：  
			$('#endTime').datepicker({  
			    todayBtn : "linked",  
			    autoclose : true,  
			    todayHighlight : true,   
			}).on('changeDate',function(e){  
			    var endTime = e.date;  
			    $('#startTime').datepicker('setEndDate',endTime);  
			}); */
			 
			
			$('#startTime').datetimepicker({
				minuteStep :1,
		        language:  'zh-CN',
				autoclose: 1,
				format: "yyyy-mm-dd hh:ii:00",
		    }).on('changeDate',function(e){  
			    var startTime = e.date;  
			    $('#endTime').datetimepicker('setStartDate',startTime);  
			});
			 
			$('#endTime').datetimepicker({  
			    minuteStep :1,
		        language:  'zh-CN',
			    autoclose : 1,  
			    format: "yyyy-mm-dd hh:ii:00",
			}).on('changeDate',function(e){  
			    var endTime = e.date;  
			    $('#startTime').datetimepicker('setEndDate',endTime);  
			});
			 
			
			
		});
		//删除活动（适用所有状态 ）
		 function idelete(activityRedrainId,id){
				
				var form = $("#activityRedrainForm");
				form.find('#currentPage').attr('name','currentPage');
				form.find('#showCount').attr('name','showCount');
// 				var parems = 'action=2'+ '&activityId='+activityId+'&activityStatus='+activityStatus+'&activityRedrainId='+activityRedrainId ;
				$.get("<%=basePath%>activityRedrain/delete",{activityRedrainId:activityRedrainId,activityId:id},function(data){
					
					if(data.status != 0){
						alert(data.msg);
						return;
					}
					
					alert("操作成功")
					form.submit();
				},'json');
			}	
		
		
		</script>
		
	</body>
</html>

