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

			<form action="shake/receiveHistory.do" method="post" name="usersForm" id="usersForm">
				<input type="hidden" id="currentPage" value="${pd.currentPage}"/>
				<input type="hidden" id="showCount" value="${pd.showCount}"/>
			<table>
					<tr>
								<td>
									<span class="input-icon"> 
										<input autocomplete="off" id="nav-search-input" style="width: 240px;" type="text" name="keyWord" value="${pd.keyWord}" placeholder="兑换编号/礼品名称" />
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
			<table id="table_report" class="table table-striped table-bordered table-hover">
				<thead>
					<tr>
						<th style="text-align:center;">兑换编号</th>
						<th style="text-align:center;">礼品名称</th>
						<th style="text-align:center;">领取人</th>
						<th style="text-align:center;">领取时间</th>
						<th style="text-align:center;">使用时间</th>
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
								<td class='center' style="text-align:center;">${var.prize_name}</td>
								<td class='center' style="text-align:center;">${var.account}</td>
								<td class='center' style="text-align:center;">${var.createTime}</td>								
								<td class='center' style="text-align:center;">${var.start_time}/${var.end_time}</td>
								<td class='center' style="text-align:center;">
									<a href="javascript:void(0);" onclick="receive('${var.prize_name}','${var.sn}')">兑换</a>
									&nbsp;&nbsp;&nbsp;
									<a href="javascript:void(0);" onclick="queryDetail(${var.prizeId})">礼品详情</a>
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
									<a class="btn btn-small btn-success" onclick="ReceivePrize();">兑换</a>
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
			$("#usersForm").submit();
		}
		//兑换礼品
		function ReceivePrize(){
					var form = $("#usersForm");
					form.find('#currentPage').attr('name','currentPage');
					form.find('#showCount').attr('name','showCount');
					 top.jzts();
					 var diag = new top.Dialog();
					 diag.Drag=true;
					 diag.Title ="兑换中心";
					 diag.URL = '<%=basePath%>shake/toReceive.do';
					 diag.Width = 470;
					 diag.Height = 260;
					 diag.CancelEvent = function(){ //关闭事件
						diag.close();
						form.submit();
					 };
					 diag.show();
				}
		//兑换
		function receive(name,sn) {
			bootbox.confirm("确定要兑换【"+name+" - ("+sn+")】吗?",function(result){
				if(result) {
					$.ajax({
						type: "POST",
						url: '<%=basePath%>shake/editReceive.do',
						data: {sn:sn},
						dataType:'json',
						cache: false,
						success: function(data){
							if(data == 100){
								bootbox.alert("优惠券使用时间有问题");
							}else if(data == 200){
								bootbox.alert("无效的优惠券");
							}else if(data == 50){
								bootbox.alert("优惠券未到使用时间");
							}else if(data == 300){
								bootbox.alert("优惠券已过期");
							}else if(data == 400){
								bootbox.alert("不是本店铺的优惠券");
							}else if(data == 500){
								bootbox.alert("优惠券已经被使用");
							}else if(data == 600){
								bootbox.alert("尚未领取");
							}else if(data == 700){
								alert("兑换成功");
								history.go(0);
							}else if(data == 800){
								bootbox.alert("没有该权限");
							}
						}
					});
				}
			});
		}

		//查看礼品详情
        function queryDetail(Id){	
            var form = $("#usersForm");         
			form.find('#currentPage').attr('name','currentPage');
			form.find('#showCount').attr('name','showCount');
			$("#usersForm").submit();
			 top.jzts();
			 var diag = new top.Dialog();
			 diag.Drag=true;
			 diag.Title ="礼品详情";
			 diag.URL = "<%=basePath%>shake/toPrizeDetail.do?id="+Id;
			 diag.Width = 750;
			 diag.Height = 630;
			 diag.CancelEvent = function(){ //关闭事件
				diag.close();
				form.submit();
			 };
			 diag.show();
		}
		</script>
		
	</body>
</html>

