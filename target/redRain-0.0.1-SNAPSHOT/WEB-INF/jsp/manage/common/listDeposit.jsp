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
			<form action="capital/listDeposit.do" method="post" name="usersForm" id="usersForm">
			<input type="hidden" id="currentPage" value="${pd.currentPage}"/>
			<input type="hidden" id="showCount" value="${pd.showCount}"/>
			<input type="hidden" name="checkFlag" id="checkFlag" style="width: 370px" value="${checkFlag}"/>
			
				<table>
							<tr>
								<td>
										状态：
										<select name="status" >
											<option value="">全部</option>
											<option value="0" <c:if test="${pd.status == '0'}">selected="selected"</c:if>>申请中</option>
											<option value="1" <c:if test="${pd.status == '1'}">selected="selected"</c:if>>提现中</option>
											<option value="2" <c:if test="${pd.status == '2'}">selected="selected"</c:if>>已提现</option>
											<option value="3" <c:if test="${pd.status == '3'}">selected="selected"</c:if>>被驳回</option>
											<option value="4" <c:if test="${pd.status == '4'}">selected="selected"</c:if>>提现失败</option>
										</select>
										
										<span class="input-icon"> 
											<input
											autocomplete="off" id="nav-search-input" type="text" style="width: 200px"
											name="keyWord" value="${pd.keyWord}" placeholder="申请编号/申请账号/交易流水号" />
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
						<th style="text-align:center;">申请编号</th>
						<th style="text-align:center;">申请帐号</th>
						<th style="text-align:center;">交易流水号</th>
						<th style="text-align:center;">申请金额</th>
						<th style="text-align:center;">手续费</th>
						<th style="text-align:center;">申请日期</th>
						<th style="text-align:center;">提现银行</th>
						<th style="text-align:center;">提现银行卡号</th>
						<th style="text-align:center;">持卡人姓名</th>
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
								<td class='center' style="text-align:center;">${var.capitalId}</td>
								<td class='center' style="text-align:center;">${var.account}</td>
								<td class='center' style="text-align:center;">${var.tradeSn}</td>
								<td class='center' style="text-align:center;">${var.money}</td>
								<td class='center' style="text-align:center;">${var.serviceCharge}</td>
								<td class='center' style="text-align:center;">${var.createTime}</td>
								<td class='center' style="text-align:center;">${var.bankBindName}</td>
								<td class='center' style="text-align:center;">${var.bankBindAccount}</td>
								<td class='center' style="text-align:center;">${var.bankBindCardholder}</td>
								<td class='center' style="text-align:center;">
								
								<c:choose>
									<c:when test="${var.status == 0}">
										申请中
									</c:when>
									<c:when test="${var.status == 1}">
										提现中
									</c:when>
									<c:when test="${var.status == 2}">
										已提现
									</c:when>
									<c:when test="${var.status == 3}">
										被驳回
									</c:when>
									<c:when test="${var.status == 4}">
										提现失败
									</c:when>
								</c:choose>
								
								
								
								</td>
								<td class='center' style="text-align:center;">
									<%--<c:if test="${var.status == 0}">--%>
										<a href="javascript:void(0);" onclick="accountDetail(${var.account})">申请人详情</a>
									<%--</c:if>--%>
									<c:if test="${var.status == 0 }">
										<a href="javascript:void(0);" onclick="accountStatus(${var.capitalId},2)">处理申请</a>
<%-- 											<a href="javascript:void(0);" onclick="goEditCapital(${var.capitalId},2);">处理申请</a>
 --%>									
									</c:if>
								</td>

								<%--<td class='center' style="text-align:center;">--%>

								<%--</td>--%>

							</tr>
						
						</c:forEach>
						
						
						
					</c:when>
					<c:otherwise>
						<tr class="main_info">
							<td colspan="100" style="text-align:center;">没有相关数据</td>
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
		</form>
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
			var form = $("#usersForm");
			form.find('#currentPage').attr('name','currentPage');
			form.find('#showCount').attr('name','showCount');
			$("#userForm").submit();
		}	
		
		
/* 		
		function sendEditCapital(id,status,checkFlag) {
			if("0"==checkFlag){
				accountStatus(id,status);				
			}else{
				goEditCapital(id,status);
			}
		}
		 */
		function goEditCapital(id,status){
			 top.jzts();
			 var diag = new top.Dialog();
			 diag.Drag=true;
			 diag.Title ="处理申请";
			 diag.URL = '<%=basePath%>user/capital/phone.do?capitalId='+id+'&status='+status;
			 diag.Width = 780;
			 diag.Height = 600;
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
		
		
		
		//送审
		function accountStatus(id,status){
			 top.jzts();
			 var diag = new top.Dialog();
			 diag.Drag=true;
			 diag.Title ="处理申请";
			 diag.URL = '<%=basePath%>capital/goEdit.do?capitalId='+id+'&status='+status;
			 diag.Width = 780;
			 diag.Height = 600;
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

		//申请人详情
		function accountDetail(account){
			top.jzts();
			var diag = new top.Dialog();
			diag.Drag=true;
			diag.Title ="申请人详情";
			diag.URL = '<%=basePath%>capital/goAccountDetail.do?account='+account;
			diag.Width = 500;
			diag.Height = 250;
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

