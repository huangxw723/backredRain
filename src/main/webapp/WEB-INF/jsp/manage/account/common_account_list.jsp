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
		<%--<link rel="stylesheet" href="static/css/datepicker.css" />--%><!-- 日期框 -->
		<link rel="stylesheet" href="static/css/bootstrap-datetimepicker.min.css" /><!-- 日期框 -->
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
		<form action="<%=basePath%>account/getCommonUserList" method="post" name="usersForm" id="usersForm">
			<input type="hidden" id="currentPage" value="${pd.currentPage}"/>
			<input type="hidden" id="showCount" value="${pd.showCount}"/>
			<table>

				<tr>
					<td style="vertical-align: top;">
						<span>
							客户端类型:
							<select name="clientType"  style="width: 100px">
								<option value="">全部</option>
								<option value="1" <c:if test="${pd.clientType eq 1}">selected="selected"</c:if>>IOS</option>
								<option value="2" <c:if test="${pd.clientType eq 2}">selected="selected"</c:if>>Android</option>
								<option value="3" <c:if test="${pd.clientType eq 3}">selected="selected"</c:if>>H5</option>
							</select>
						</span>

					</td>
					<td>
						注册时间:
						<span class="input-icon">
								<input class="span10 date-picker" name="startTime" id="startTime" type="text" value="${pd.startTime}" data-date-format="yyyy-mm-dd hh:ii:ss" style="width:220px;" placeholder=""/>至
								<input class="span10 date-picker" name="endTime" id="endTime" type="text" value="${pd.endTime}" data-date-format="yyyy-mm-dd hh:ii:ss" style="width:220px;" placeholder=""/>
						</span>
						<span class="input-icon">
							<input autocomplete="off" id="nav-search-input" type="text"
								   name="account" value="${pd.account}" style="width:150px;" placeholder="账号名称"/>
							<i  class="icon-search"></i>
						</span>
						<span class="input-icon">
							<input autocomplete="off"type="text"
								   name="nickName" value="${pd.nickName}" style="width:150px;" placeholder="用户昵称"/>
							<i  class="icon-search"></i>
						</span>
						<span class="input-icon">
							<input autocomplete="off"type="text"
								   name="inviteRefId" value="${pd.inviteRefId}" style="width:150px;" placeholder="用户来源"/>
							<i  class="icon-search"></i>
						</span>
						<span class="input-icon">
							<input autocomplete="off"  type="text"
								   name="address" value="${pd.address}" style="width:150px;" placeholder="详细地址"/>
							<i  class="icon-search"></i>
						</span>
					</td>
					<td style="vertical-align: top;">
						&nbsp;
						<button class="btn btn-mini btn-light" onclick="searchInfo();" style="vertical-align:top;"  title="检索">
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
						<th style="text-align:center;">账户类型</th>
						<th style="text-align:center;">账号名称</th>
						<th style="text-align:center;">用户昵称</th>
						<th style="text-align:center;">用户来源</th>
						<th style="text-align:center;">积分</th>
						<th style="text-align:center;">余额</th>
						<th style="text-align:center;">客户端类型</th>
						<th style="text-align:center;">默认收货地址</th>
						<th style="text-align:center;">注册时间</th>
						<th style="text-align:center;">操作</th>

					</tr>
				</thead>

				<tbody>

				<!-- 开始循环 -->

				<c:choose>
					<c:when test="${not empty list}">
						<c:forEach items="${list}" var="var" varStatus="vs">
							<tr>
								<td style="text-align:center;">
									普通用户
								</td>
								<td class='center' style="text-align:center;">${var.account}</td>
								<td class='center' style="text-align:center;">${var.nickName}</td>
								<td class='center' style="text-align:center;">
									<c:if test="${var.inviteRefId !=null }">
										${var.inviteRefId}分享
									</c:if>

								</td>
								<td class='center' style="text-align:center;">${var.integration}</td>
								<td class='center' style="text-align:center;">${var.money}</td>
								<td class='center' style="text-align:center;">
									<c:if test="${var.clientType ==1}">
										IOS
									</c:if>
									<c:if test="${var.clientType ==2}">
										Android
									</c:if>
									<c:if test="${var.clientType ==3}">
										H5
									</c:if>
								</td>
								<td class='center' style="text-align:center;">
									<c:forEach items="${provinceList}" var="p">
										<c:if test="${p.provinceId == var.provinceId }">${p.provinceName }</c:if>
									</c:forEach>
									<c:forEach items="${cityList}" var="c">
										<c:if test="${c.cityId == var.cityId }">${c.cityName }</c:if>
									</c:forEach>
									<c:forEach items="${areaList}" var="a">
										<c:if test="${a.areaId == var.areaId }">${a.areaName }</c:if>
									</c:forEach>
										${var.address}
								</td>
								<td class='center' style="text-align:center;">${var.createTime}</td>
								<td class='center' style="text-align:center;">
										<a href="javascript:void(0);" onclick="view(${var.userId},'${var.account}')">查看</a>
										<a href="javascript:void(0);" onclick="edit(${var.userId},'${var.account}')">编辑</a>
										<a href="javascript:void(0);" onclick="updateUserStatus(${var.userId},'${var.account}')">删除</a>
								</td>
							</tr>
						</c:forEach>
					</c:when>
					<c:otherwise>
						<tr class="main_info">
							<td colspan="100" style="text-align:center;" >没有相关数据</td>
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
		<%--<script type="text/javascript" src="static/js/bootstrap-datepicker.min.js"></script>--%><!-- 日期框 -->
		<script type="text/javascript" src="static/js/bootstrap-datetimepicker.js"></script><!-- 日期框 -->
		<script type="text/javascript" src="static/js/bootstrap-datetimepicker.zh-CN.js"></script><!-- 日期框 -->
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
		function searchInfo(){
			top.jzts();
			var form = $("#usersForm");
			form.find('#currentPage').attr('name','currentPage');
			form.find('#showCount').attr('name','showCount');
			$("#usersForm").submit();
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
	    
	  //更新状态
		function updateUserStatus(id,name){
			
			var form = $("#usersForm");
			form.find('#currentPage').attr('name','currentPage');
			form.find('#showCount').attr('name','showCount');
			bootbox.confirm("确定要删除该账号【" + name + "】吗?", function (result) {
				if (result) {
					$.ajax({
						type: "POST",
						url: "<%=basePath%>account/updateStatus.do",
						data: {userId:id,status:1},
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
	
		//新增
		function add(){
			var form = $("#usersForm");
			form.find('#currentPage').attr('name','currentPage');
			form.find('#showCount').attr('name','showCount');
			 top.jzts();
			 var diag = new top.Dialog();
			 diag.Drag=true;
			 diag.Title ="新增";
			 diag.URL = '<%=basePath%>account/saveAccountMemberPage.do?action='+1;
			 diag.Width = 1150;
			 diag.Height = 650;
			 diag.CancelEvent = function () { //关闭事件
		            diag.close();
		            form.submit()
		        };
			 diag.show();
		}
		
		//查看
		function view(id,account){
			top.mainFrame.tab.add( {
				id :'accountId' + account,
				title :"会员详情"+account,
				url :'<%=basePath%>account/goTab.do?view=4&userId='+id,
				isClosed :true
			});
		}
		//修改
		function edit(id,account){

			top.mainFrame.tab.add( {
				id :'userId' + id,
				title :"会员详情"+account,
				url :'<%=basePath%>account/goTab.do?view=2&userId='+id,
				isClosed :true
			});
		}
		
		function idelete(id){
			var form = $("#usersForm");
			form.find('#currentPage').attr('name','currentPage');
			form.find('#showCount').attr('name','showCount');
			$.get("<%=basePath%>account/delete",{userId:id},function(data){
				if(data.status != 0){
					alert(data.msg);
					return;
				}
				alert("操作成功")
				form.submit();
			},'json');
		}
		
		</script>
		
		<script type="text/javascript">
		
		$(function() {
			
			//下拉框
			$(".chzn-select").chosen(); 
			$(".chzn-select-deselect").chosen({allow_single_deselect:true}); 
			//$('.date-picker').datepicker();
			//复选框
			$('table th input:checkbox').on('click' , function(){
				var that = this;
				$(this).closest('table').find('tr > td:first-child input:checkbox')
				.each(function(){
					this.checked = that.checked;
					$(this).closest('tr').toggleClass('selected');
				});
					
			});
			
			/*$('#startTime').datepicker({
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
			 });*/
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
		
		</script>
		
	</body>
</html>

