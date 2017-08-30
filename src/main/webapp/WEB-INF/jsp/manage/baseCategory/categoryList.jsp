<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.aoshi.util.PropertyUtils"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
	String httpUrl = PropertyUtils.getHTTP_URL();
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
	<link rel="stylesheet" href="static/css/font-awesome.min.css" />
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
			<form action="category/${msg}.do" method="post" name="userForm" id="userForm">
				<input type="hidden" id="currentPage" value="${pd.currentPage}"/>
				<input type="hidden" id="showCount" value="${pd.showCount}"/>
				<table >
							<tr>
								
							<%-- 	<td width="300">
									<span>
										标签类型
										<select name="type" id="type">
	 										<option value="" >全部</option>
											<option value="1"<c:if test="${pd.type eq 1}">selected="selected"</c:if>>行业标签</option>
	 										<option value="2"<c:if test="${pd.type eq 2}">selected="selected"</c:if>>模块标签</option>
	 										<option value="3"<c:if test="${pd.type eq 3}">selected="selected"</c:if>>礼品类型</option>
	 										<option value="4"<c:if test="${pd.type eq 4}">selected="selected"</c:if>>优惠券标签</option>
	 										<option value="5"<c:if test="${pd.type eq 5}">selected="selected"</c:if>>商家类型</option>
											<option value="6"<c:if test="${pd.type eq 6}">selected="selected"</c:if>>美食品类</option>
											<option value="7"<c:if test="${pd.type eq 7}">selected="selected"</c:if>>逛街分类</option>
										</select>
									</span>
								</td> --%>
								 
								<td>
									分类名称:<span class="input-icon" > <input
											autocomplete="off" id="nav-search-input" type="text"
											name="name" value="${pd.name}" placeholder="输入关键字查询" style="width:200px;"/>
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
								<td style="vertical-align: top;">
										&nbsp;
									<a class="btn btn-small btn-success" onclick="add();">新增</a>
								</td>
							</tr>
				</table> 		
			</form>
			
			<!-- 列表  -->	
			<table id="table_report" class="table table-striped table-bordered table-hover">		
				<thead>
					<tr>
						<th style="text-align:center;">标签类型</th>
						<th style="text-align:center;">分类名称</th>
						<th style="text-align:center;">新增时间</th>
						<th style="text-align:center;">操作</th>
					</tr>
				</thead>									
				<tbody>
					
				<!-- 开始循环 -->	
				<c:choose>
					<c:when test="${not empty list}">
						<c:forEach items="${list}" var="cate" varStatus="vs">						
							<tr>
								<td class='center' style="text-align:center;">
									<c:if test="${cate.type == 1}">行业标签</c:if>
									<c:if test="${cate.type == 2}">模块标签</c:if>
									<c:if test="${cate.type == 3}">礼品类型</c:if>
									<c:if test="${cate.type == 4}">优惠券标签</c:if>
									<c:if test="${cate.type == 5}">商场类型</c:if>
								</td>
								<td class='center' style="text-align:center;">${cate.name}</td>
														
								<td class='center' style="text-align:center;">${cate.createTime}</td>
								<td class='center' style="text-align:center;">
									<a href="javascript:void(0);" onclick="find(${cate.id})">编辑</a>
									<a href="javascript:void(0);" onclick="idelete(${cate.id},'${cate.name}')">删除</a>							
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
		<script type="text/javascript" src="static/js/bootbox.min.js"></script><!-- 确认窗口 -->
		<script type="text/javascript" src="static/js/jquery.tips.js"></script><!--提示框-->
		<link rel="stylesheet" type="text/css" href="plugins/fancyBox/jquery.fancybox.css">
		<script type="text/javascript" src="plugins/fancyBox/jquery.fancybox.pack.js"></script>
		<script type="text/javascript">
 
		 
		$(top.hangge());	
		//查询
		function search(){
			top.jzts();
			var form = $("#usersForm");
			form.find('#currentPage').attr('name','currentPage');
			form.find('#showCount').attr('name','showCount');
			form.submit();
		}
		//查找需要修改的分类
		function find(id){
			
			var form = $("#userForm");
			form.find('#currentPage').attr('name','currentPage');
			form.find('#showCount').attr('name','showCount');
			 top.jzts();
			 var diag = new top.Dialog();
			 diag.Drag=true;
			 diag.Title ="修改分类";
			 diag.URL = '<%=basePath%>category/page.do?action=2&categoryId='+id+'&type='+'${type}';
			 diag.Width = 400;
			 diag.Height = 200;
			 diag.CancelEvent = function(){ //关闭事件
				diag.close();
				//form.submit()
				history.go(0);
			 };
			 diag.show();
		}

		//添加
		function add(id){
			
			var form = $("#userForm");
			form.find('#currentPage').attr('name','currentPage');
			form.find('#showCount').attr('name','showCount');
			 top.jzts();
			 var diag = new top.Dialog();
			 diag.Drag=true;
			 diag.Title ="新增分类";
			 diag.URL = '<%=basePath%>category/page.do?action=1&categoryId='+id+'&type='+'${type}';
			 diag.Width = 400;
			 diag.Height = 200;
			 diag.CancelEvent = function(){ //关闭事件
				diag.close();
				form.submit()
				history.go(0);
			 };
			 diag.show();
		}
 
		</script>	
	</body>
	<script type="text/javascript">
		//删除
		function idelete(id,name){
			bootbox.confirm("确定删除分类【"+name+"】吗?",function(result){
				if(result) {
					$.ajax({
						type: "POST",
						url: "<%=basePath%>category/opera.do?action=3",
				    	data: {categoryId:id},
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
		};
		 
	</script>
</html>

