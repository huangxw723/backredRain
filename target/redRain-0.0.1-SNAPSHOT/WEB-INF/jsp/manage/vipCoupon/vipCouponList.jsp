<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="java.text.*" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
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
	<!-- <link rel="stylesheet" href="static/css/datepicker.css" />日期框 -->
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
			<form action="vipCoupon/couponListAll.do" method="post" name="usersForm" id="usersForm">
			<input type="hidden" id="currentPage" value="${pd.currentPage}"/>
			<input type="hidden" id="showCount" value="${pd.showCount}"/>
			<input type="hidden" id="prizeId" value="${prizeId} }">
				<table>
					<tr>
								<td>	

								<%-- <span class="input-icon"> 
								          账号：
									<input autocomplete="off" id="nav-search-input" type="text" name="account" value="${pd.account}" placeholder="账号" style="width:200px;"/>
								</span> --%>
								<%-- <span class="input-icon"> 
								   用户昵称：
									<input autocomplete="off" id="nav-search-input" type="text" name="keyWord" value="${pd.keyWord}" placeholder="用户昵称" style="width:220px;"/>									
								</span>
								<span class="input-icon"> 
								    礼品名称：
									<input autocomplete="off" id="nav-search-input" type="text" name="keyWord" value="${pd.keyWord}" placeholder="礼品名称" style="width:220px;"/>									
								</span>
								<span class="input-icon"> 
								    礼品编号：
									<input autocomplete="off" id="nav-search-input" type="text" name="keyWord" value="${pd.keyWord}" placeholder="礼品编号" style="width:220px;"/>									
								</span>	 --%>			
								<span>
									类型:
									<select name="categoryId" id="categoryId" style="vertical-align:top;width: 120px">
										<option value="">全部</option>
										<c:forEach items="${prizeTypeList}" var="var" varStatus="index">
												<option value="${var.id}" <c:if test="${var.id eq pd.categoryId}">selected</c:if>>${var.name}</option>
										</c:forEach>
									</select>
								</span>	&nbsp;&nbsp;					
								<span>
									状态:
									<select name="status" id="status" style="vertical-align:top;width: 100px">
										<option value="4" <c:if test="${pd.status eq '4'}">selected="selected"</c:if>>全部</option>
										<option value="0" <c:if test="${pd.status eq '0'}">selected="selected"</c:if> >未使用</option>
										<option value="1" <c:if test="${pd.status eq '1'}">selected="selected"</c:if> >已使用</option>
										<option value="3" <c:if test="${pd.status eq '3'}">selected="selected"</c:if> >已删除</option>	
										<option value="2" <c:if test="${pd.status eq '2'}">selected="selected"</c:if> >已过期</option>		
									</select>
								</span>	&nbsp;&nbsp;
									<span class="input-icon">
								          有效期：
									<input class="span10 date-picker" id="endTime" name="endTime" type="text" name="endTime" value="${pd.endTime}" data-date-format="yyyy-mm-dd hh:ii:ss" style="width:220px;" placeholder="这里输入有效时间"/>									
								</span>&nbsp;&nbsp;
									<span class="input-icon">
									<input autocomplete="off" id="nav-search-input" type="text" name="keyWord" value="${pd.keyWord}" placeholder="账号/用户昵称/礼品名称/礼品编号/商户" style="width:260px;"/>
										<i   class="icon-search"></i>
								</span>
								</td>
								<td style="vertical-align: top;">
										&nbsp;&nbsp;
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
						<th style="text-align:center;">账号</th>
						<th style="text-align:center;">用户昵称</th>
						<th style="text-align:center;">礼品名称</th>
						<th style="text-align:center;">商户</th>
						<th style="text-align:center;">礼品编号</th>
						<th style="text-align:center;">类型</th>
						<th style="text-align:center;">标签</th>
						<th style="text-align:center;">状态</th>
						<th style="text-align:center;">礼品描述</th>
						<th style="text-align:center;">有效期</th>
						<th style="text-align:center;">操作</th>
					</tr>
				</thead>
										
				<tbody>
					
				<!-- 开始循环 -->	
				<c:choose>
					<c:when test="${not empty list}">
						<c:forEach items="${list}" var="var" varStatus="vs">
									
							<tr>
							    <td class='center' style="text-align:center;">${var.account}</td>
							    <td class='center' style="text-align:center;">${var.nickName}</td>
							    <td class='center' style="text-align:center;">${var.prizeName}</td>
							    <td class='center' style="text-align:center;">${var.shopName}</td>
								<td class='center' style="text-align:center;">${var.sn}</td>							
								<td class='center' style="text-align:center;">${var.prizeTypeName }</td>
								<td class='center' style="text-align:center;">
									<c:forEach items="${tagTypeList}" var="tag" >
										<c:if test="${tag.id == var.prizeCategoryId}">${tag.name}</c:if>
									</c:forEach>
								</td>																									
								<td class='center' style="text-align:center;">							
                               <c:choose>
                                  <c:when test="${currentTime gt var.endTime}">
									  <c:choose>
										  <c:when test="${pd.status eq '2'}">
											  <span>已过期</span>
										  </c:when>
										  <c:otherwise>
											  <c:if test="${pd.status eq '0' or var.status == 0}"><span>未使用</span></c:if>
											  <c:if test="${pd.status eq '1' or var.status == 1}"><span>已使用</span></c:if>
											  <c:if test="${pd.status eq '3' or var.status == 3}"><span>已删除</span></c:if>
										  </c:otherwise>
									  </c:choose>

								  </c:when>
                                <c:otherwise>
                                    <c:if test="${var.status == 0}">
										<span>未使用</span>
									</c:if>
									<c:if test="${var.status == 1}">
										<span>已使用</span>
									</c:if>
									<c:if test="${var.status == 3}">
										<span>已删除</span>
									</c:if>	
                                </c:otherwise>
                                </c:choose>

								</td>
								<td class='center' style="text-align:center;" title="${var.prizeDescp}">${var.prizeDescp}</td>	
								<td class='center' style="text-align:center;">${var.endTime}</td>
								<td class='center'  style="text-align:center;">	
								<c:if test="${var.status == 0  }">
										<a href="javascript:void(0);" onclick="del(${var.prizeId})" <c:if test="${pd.status eq '2'}">style="display: none;"</c:if>>删除</a>
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
		<!-- <script type="text/javascript" src="static/js/bootstrap-datepicker.min.js"></script> --><!-- 日期框 -->
	    <script type="text/javascript" src="static/js/bootstrap-datetimepicker.js"></script><!-- 日期框 -->
		<script type="text/javascript" src="static/js/bootstrap-datetimepicker.zh-CN.js"></script><!-- 日期框 -->	
		<script type="text/javascript" src="static/js/bootbox.min.js"></script><!-- 确认窗口 -->
		<!-- 引入 -->
		<script type="text/javascript" src="static/js/jquery.tips.js"></script><!--提示框-->				
		<script type="text/javascript" src="plugins/fancyBox/jquery.fancybox.pack.js"></script>

		<script type="text/javascript">
		
		$(top.hangge());

		$(function() {
			
		//检索
		function search(){
			top.jzts();
			var form = $("#usersForm");
			form.find('#currentPage').attr('name','currentPage');
			form.find('#showCount').attr('name','showCount');
			$("#usersForm").submit();
		}
		});
		
		//删除操作
		function del(id){		   
			var form = $('#usersForm')
			form.find('#currentPage').attr('name','currentPage');
			form.find('#showCount').attr('name','showCount'); 			
			bootbox.confirm("确定要删除该优惠券吗?",function(result){
				if(result) {
					$.ajax({
						type: "POST",
						url: "<%=basePath%>vipCoupon/del.do",
				    	data: {prizeId:id},
						dataType:'json',
						success: function(data){
							if(data.status == 0){
								alert(data.msg);
								history.go(0);
								return;								
							}else if(data.status == 1){
								alert(data.msg);
								history.go(0);	
								return;															
							}
								
						}
					});
				}
			});	
		}
		</script>
		
		<script type="text/javascript">
		
		$(function() {
			
			//日期框
			/* $('.date-picker').datepicker(); */
			
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
			
			$('#endTime').datetimepicker({  
			    minuteStep :1,
		        language:  'zh-CN',
			    autoclose : 1,  
			    format: "yyyy-mm-dd hh:ii:00",
			});
									
		});
		
		</script>
		
	</body>
</html>

