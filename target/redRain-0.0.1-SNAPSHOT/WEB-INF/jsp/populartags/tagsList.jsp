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
			<form action="popularTags/list.do" method="post" name="usersForm" id="usersForm">
			<input type="hidden" id="currentPage" value="${pd.currentPage}"/>
			<input type="hidden" id="showCount" value="${pd.showCount}"/>
			<input type="hidden" id="popularTagsId" name="popularTagsId" value="${popularTagsId}">		
				<table>
					<tr>							
								<td>
								<span class="input-icon"> 
								          标签名称：
									<input autocomplete="off" id="nav-search-input" type="text" name="keyWord" value="${pd.keyWord}" placeholder="标签名称" style="width:220px;"/>
								</span>
								&nbsp;&nbsp;
								<span>
									标签分类:
									<select name="tagsType" id="tagsType" style="vertical-align:top;width: 90px">
										<option value="">全部</option>
										<option value="1" <c:if test="${pd.tagsType eq 1}">selected="selected"</c:if>>商品</option>
										<option value="2" <c:if test="${pd.tagsType eq 2}">selected="selected"</c:if>>店铺</option>
										<option value="3" <c:if test="${pd.tagsType eq 3}">selected="selected"</c:if>>活动</option>
										<option value="4" <c:if test="${pd.tagsType eq 4}">selected="selected"</c:if>>活力广州</option>
										<option value="5" <c:if test="${pd.tagsType eq 5}">selected="selected"</c:if>>逛街go</option>
									</select>
								</span>
								&nbsp;&nbsp;
								<span>
									生效:
									<select name="status" id="status" style="vertical-align:top;width: 70px">
										<option value="">全部</option>
										<option value="0" <c:if test="${pd.status eq '0'}">selected="selected"</c:if>>是</option>
										<option value="1" <c:if test="${pd.status eq '1'}">selected="selected"</c:if>>否</option>									
									</select>
								</span>					
								</td>
								<td style="vertical-align: top;">
										&nbsp;
										<button class="btn btn-mini btn-light"  onclick="search()">
											<i id="nav-search-icon" class="icon-search"></i>
										</button>
										<!-- <a class="btn btn-small btn-success" onclick="search()">查询</a> -->
										 
								</td>
								<td style="vertical-align: top;">
										&nbsp;					
										<a class="btn btn-small btn-success" onclick="add()">新增</a>

								</td>
							</tr>		
				</table>		
			</form>
			<!-- 检索  -->
		
		
			<table id="table_report" class="table table-striped table-bordered table-hover">
				
				<thead>
					<tr>
						<th style="text-align:center;">标签名称</th>
						<th style="text-align:center;">分类</th>
						<th style="text-align:center;">是否生效</th>											
						<th style="text-align:center;">创建时间</th>										
						<th style="text-align:center;">操作</th>						
					</tr>
				</thead>
										
				<tbody>
					
				<!-- 开始循环 -->	
				<c:choose>
					<c:when test="${not empty list}">
						<c:forEach items="${list}" var="var" varStatus="vs">
									
							<tr>
								<td class='center' style="text-align:center;">${var.tagsName}</td>	
								<td class='center' style="text-align:center;">
									<c:if test="${var.tagsType == 1}">
										商品
									</c:if>
									<c:if test="${var.tagsType == 2}">
										店铺
									</c:if>	
									<c:if test="${var.tagsType == 3}">
										活动
									</c:if>
									<c:if test="${var.tagsType == 4}">
										活力广州
									</c:if>	
									<c:if test="${var.tagsType == 5}">
										逛街go
									</c:if>									
								</td>	
								<td class='center' style="text-align:center;">
									<c:if test="${var.status == 0}">是
									</c:if>
									<c:if test="${var.status == 1}">否
									</c:if>									
								</td>											
								<td class='center' style="text-align:center;">${var.createTime}</td>						
								<td class='center'  style="text-align:center;">
									<a href="javascript:void(0);" onclick="edit(${var.popularTagsId})">编辑</a>				
									<a href="javascript:void(0);" onclick="del(${var.popularTagsId})">删除</a>			
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
		<script type="text/javascript" src="plugins/fancyBox/jquery.fancybox.pack.js"></script>

		<script type="text/javascript">
		
		 $(top.hangge());
		  //检索
		  function search(){
		    top.jzts();
		    var form = $("#usersForm");
			form.find('#currentPage').attr('name','currentPage');
			form.find('#showCount').attr('name','showCount');
		    form.submit();
		  }

		  //新增
		  function add(){
		    var form = $("#usersForm");
		    top.jzts();
		    var diag = new top.Dialog();
		    diag.Drag=true;
		    diag.Title ="新增标签";
		    diag.URL = '<%=basePath%>popularTags/toAddTagsPage.do';
		    diag.Width = 650;
		    diag.Height = 500;
		    diag.CancelEvent = function(){ //关闭事件
		      if(diag.innerFrame.contentWindow.document.getElementById('zhongxin').style.display == 'none'){
		        if('${page.currentPage}' == '0'){
		          top.jzts();
		          setTimeout("self.location=self.location",100);
		        }else{
		          if(typeof(nextPage) == "function") {
		            nextPage(${page.currentPage});
		          }
		        }
		      }
		      diag.close();
		      form.submit();
		    };
		    diag.show();
		  }

		  
		  //删除
		  function del(Id){
		    bootbox.confirm("确定要删除吗?", function(result) {
		      if(result) {
		        top.jzts();
		        var url = "<%=basePath%>popularTags/delTags.do?id="+Id;
		        $.get(url,function(data){
		          if(typeof(nextPage) == "function") {
		            nextPage(${page.currentPage});
		          }
		        });
		      }
		    });
		  }

		  //修改
		  function edit(id){
		    top.jzts();
		    var diag = new top.Dialog();
		    diag.Drag=true;
		    diag.Title ="编辑标签";
		    diag.URL = '<%=basePath%>popularTags/toEditTagsPage.do?id='+id;
		    diag.Width = 650;
		    diag.Height = 500;
		    diag.CancelEvent = function(){ //关闭事件
		      diag.close();
		      search();
		    };
		    diag.show();
		  }
		  function fresh() {
		    setTimeout("self.location=self.location",100);
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

