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
			<form action="account/getAccountCapitalList.do" method="post" name="usersForm" id="usersForm">
			<input type="hidden" id="currentPage" value="${pd.currentPage}"/>
			<input type="hidden" id="showCount" value="${pd.showCount}"/>
			<input type="hidden" name="userId" value="${pd.userId}"/>
			<input type="hidden" name="view" value="${pd.view}"/>

				<table>
							<tr>
								<td>
									<c:choose>
										<c:when test="${not empty list}">
											账号余额：${list[0].remainingMoney}元
										</c:when>
										<c:otherwise>
											账号余额：${wallet.money}元
										</c:otherwise>
									</c:choose>
								</td>
								<%--<td>
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
											name="keyWord" value="${pd.keyWord}" placeholder="提现编号/提现账号/交易流水号" />
											<i id="nav-search-icon" class="icon-search"></i>
										</span>
								
								</td>
									<td style="vertical-align: top;">
										&nbsp;
										<button class="btn btn-mini btn-light" onclick="search();"
											title="查询">
											<i id="nav-search-icon" class="icon-search"></i>
										</button>
									</td>--%>
								<c:if test="${pd.view != 4}">
									<td style="vertical-align: top;">
										&nbsp;
										<a class="btn btn-small btn-success" onclick="add();">申请提现</a>
									</td>
								</c:if>
							</tr>
						</table>		
			</form>
			<!-- 检索  -->
		
		
			<table id="table_report" class="table table-striped table-bordered table-hover">
				
				<thead>
					<tr>
						<th style="text-align:center;">提现编号</th>
						<th style="text-align:center;">提现帐号</th>
						<th style="text-align:center;">交易流水号</th>
						<th style="text-align:center;">提现金额</th>
						<th style="text-align:center;">手续费</th>
						<th style="text-align:center;">提现日期</th>
						<th style="text-align:center;">提现银行</th>
						<th style="text-align:center;">银行卡类型</th>
						<th style="text-align:center;">提现银行卡号</th>
						<th style="text-align:center;">持卡人姓名</th>
						<th style="text-align:center;">状态</th>

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
								<td class='center' style="text-align:center;">${var.cardType}</td>
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
                                        <a href="javascript:void(0);" title="查看处理描述" onclick="reason(${var.capitalId})">被驳回</a>
									</c:when>
									<c:when test="${var.status == 4}">
										提现失败
									</c:when>
								</c:choose>

								</td>


							</tr>
						
						</c:forEach>
						
						
						
					</c:when>
					<c:otherwise>
						<tr class="main_info">
							<td colspan="100" style="text-align:center;">没有相关数据<a href="javascript:void(0);" onclick="fresh();">刷新</a></td>
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

		//刷新
		function fresh() {
			//setTimeout("self.location=self.location",100);
			history.go(0);
		}

        //查看处理描述
        function reason(id){
            var form = $("#usersForm");
            form.find('#currentPage').attr('name','currentPage');
            form.find('#showCount').attr('name','showCount');
            top.jzts();
            var diag = new top.Dialog();
            diag.Drag=true;
            diag.Title ="处理描述";
            diag.URL = '<%=basePath%>account/reason.do?action=4&capitalId='+id;
            diag.Width = 600;
            diag.Height = 450;
            diag.CancelEvent = function(){ //关闭事件
                diag.close();
            };
            diag.show();

        }

		//申请提现
		function add(){
            $.ajax({
                type: "POST",
                url: '<%=basePath%>account/isBankBind.do?userId='+"${pd.userId}",
                dataType:'json',
                cache: false,
                success: function(data){
                    if(!data){
                        alert("该账号尚未绑定银行卡，请先绑定至少一张银行卡！");
                        return ;
                    }else{
						var form = $("#usersForm");
						form.find('#currentPage').attr('name','currentPage');
						form.find('#showCount').attr('name','showCount');
						top.jzts();
						var diag = new top.Dialog();
						diag.Drag=true;
						diag.Title ="申请提现";
						diag.URL = '<%=basePath%>account/accountDepositPage?action=1&userId='+"${pd.userId}";
						diag.Width = 840;
						diag.Height = 650;
						diag.CancelEvent = function () { //关闭事件
							diag.close();
							form.submit()
						};
						diag.show();
					}
                },
                error:function () {
                    alert("系统繁忙！");
                }
            });
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

