<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.aoshi.util.PropertyUtils" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    String httpUrl = PropertyUtils.getHTTP_URL();
%>
<!DOCTYPE html>
<html lang="en">
			<base href="<%=basePath%>">
		<meta charset="utf-8" />
		<title></title>
		<meta name="description" content="overview & stats" />
		<meta name="viewport" content="width=device-width, initial-scale=1.0" />
		<link href="static/css/bootstrap.min.css" rel="stylesheet" />
		<link href="static/css/bootstrap-responsive.min.css" rel="stylesheet" />
		<link rel="stylesheet" href="static/css/font-awesome.min.css" />
		<!-- 下拉框 -->
		<link rel="stylesheet" href="static/css/chosen.css" />
		<link rel="stylesheet" href="static/css/ace.min.css" />
		<link rel="stylesheet" href="static/css/ace-responsive.min.css" />
		<link rel="stylesheet" href="static/css/ace-skins.min.css" />
		<script type="text/javascript" src="static/js/jquery-1.7.2.js"></script>
		<link rel="stylesheet" href="static/css/datepicker.css" /><!-- 日期框 -->
		<!--引入弹窗组件start-->
		<script type="text/javascript" src="plugins/attention/zDialog/zDrag.js"></script>
		<script type="text/javascript" src="plugins/attention/zDialog/zDialog.js"></script>
		<!--引入弹窗组件end-->
		<!--提示框-->
		<script type="text/javascript" src="static/js/jquery.tips.js"></script>
		<script type="text/javascript" src="static/js/common/commonutils.js"></script>
<body>
		
<div class="container-fluid" id="main-container">


<div id="page-content" class="clearfix">
						
  <div class="row-fluid">

	<div class="row-fluid">
		<!-- 检索  -->
		<form action="<%=basePath%>account/getAccountBankBindList" method="post" name="usersForm" id="usersForm">
			<input type="hidden" id="currentPage" value="${pd.currentPage}"/>
			<input type="hidden" id="showCount" value="${pd.showCount}"/>
			<input type="hidden" name="userId" value="${pd.userId}"/>
			<input type="hidden" name="view" value="${pd.view}"/>
		</form>
		<!-- 检索  -->

			<table id="table_report" class="table table-striped table-bordered table-hover">

				<thead>
					<tr>
						<th style="text-align:center;">账号名称</th>
						<th style="text-align:center;">持卡人</th>
						<th style="text-align:center;">银行卡号</th>
						<th style="text-align:center;">所属银行</th>
						<th style="text-align:center;">卡种</th>
						<th style="text-align:center;">身份证</th>
						<c:if test="${pd.view != 4}">
						<th style="text-align:center;">操作</th>
						</c:if>
					</tr>
				</thead>

				<tbody>

				<!-- 开始循环 -->

				<c:choose>
					<c:when test="${not empty list}">
						<c:forEach items="${list}" var="var" varStatus="vs">
							<tr>

								<td class='center' style="text-align:center;">${var.account}</td>
								<td class='center' style="text-align:center;">${var.bankCardholder}</td>
								<td class='center' style="text-align:center;">${var.bankAccount}</td>
								<td class='center' style="text-align:center;">${var.bankName}</td>
								<td class='center' style="text-align:center;">${var.cardType}</td>
								<td class='center' style="text-align:center;">${var.identityCard}</td>
								<c:if test="${pd.view != 4}">
								<td class='center' style="text-align:center;">
										<a href="javascript:void(0);" onclick="del(${var.bankBindId},'${var.bankAccount}')">删除</a>
								</td>
								</c:if>
							</tr>
						</c:forEach>
					</c:when>
					<c:otherwise>
						<tr class="main_info">
							<td colspan="100" style="text-align:center;" >没有相关数据<a style="text-decoration: none;cursor:pointer" onclick="fresh()">刷新</a></td>
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
		<!-- 确认窗口 -->
		<script type="text/javascript" src="static/js/jquery.tips.js"></script>
		<link rel="stylesheet" type="text/css" href="plugins/fancyBox/jquery.fancybox.css">
		<script type="text/javascript" src="plugins/fancyBox/jquery.fancybox.pack.js"></script>
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
			$("#usersForm").submit();
		}

		function fresh() {
			//setTimeout("self.location=self.location",100);
			history.go(0);
		}

	    $(function () {
	        //单选框
	        $(".chzn-select").chosen();
	        $(".chzn-select-deselect").chosen({allow_single_deselect: true});
	        $(".fancybox").fancybox({
	            helpers: {
	                title: {
	                    type: 'inside'
	                }
	            }
	        });
	    });


	    
	  //删除
		function del(id,name){
			
			var form = $("#usersForm");
			form.find('#currentPage').attr('name','currentPage');
			form.find('#showCount').attr('name','showCount');
			bootbox.confirm("确定要删除该银行卡【" + name + "】吗?", function (result) {
				if (result) {
					$.ajax({
						type: "POST",
						url: "<%=basePath%>account/unAccountBankBind.do",
						data: {bankBindId:id},
						dataType: 'json',
						success: function (data) {
							if (data.status != 0) {
								alert(data.msg);
								return;
							}
							form.submit();
						},
						error:function () {
							alert("系统繁忙！");
						}
					});
				}
			});
		}

		</script>
		
		<script type="text/javascript">
		
		$(function() {
			
			//下拉框
			$(".chzn-select").chosen(); 
			$(".chzn-select-deselect").chosen({allow_single_deselect:true}); 
			$('.date-picker').datepicker();
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

