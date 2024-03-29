﻿<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.aoshi.util.PropertyUtils" %>
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
			<form action="activityAd/listAll.do" method="post" name="usersForm" id="usersForm">
			<input type="hidden" id="currentPage" value="${pd.currentPage}"/>
			<input type="hidden" id="showCount" value="${pd.showCount}"/>
			<input type="hidden" name="activityType" value="${activityType}"/>
			<input type="hidden" name="oType" id="${otype}" value="${activityType}"/>
				<table>
					<tr>
								<td>
								<span>
									广告板块类型:
									<select name="adPosType" style="vertical-align:top;width: 160px">
										<option value="9">全部</option>
                 						 <option value="4" <c:if test="${pd.adPosType==4}">selected="selected"</c:if>>E街E铺-活动-弹窗</option>
                 						 <option value="5" <c:if test="${pd.adPosType==5}">selected="selected"</c:if>>E街E铺-活动-悬浮</option>
              						</select>
								</span>
								<span>
									状态:
									<select name="status"  style="vertical-align:top;width: 70px">
										<option value="3">全部</option>
										<option value="1" <c:if test="${pd.status eq 1}">selected="selected"</c:if>>启用</option>
										<option value="0" <c:if test="${pd.status eq 0}">selected="selected"</c:if>>禁用</option>
									</select>
								</span>
								<span class="input-icon"> 
									<input autocomplete="off" id="nav-search-input" type="text" name="keyWord" value="${pd.keyWord}" placeholder="广告名称" />
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
										<a class="btn btn-small btn-success" onclick="add('1');">新增</a>
								</td>
							</tr>		
				</table>		
			</form>
			<!-- 检索  -->
		
		
			<table id="table_report" class="table table-striped table-bordered table-hover">
				
				<thead>
					<tr>
						<th style="text-align:center;">广告平台</th>
						<th style="text-align:center;">广告板块类型</th>
						<th style="text-align:center;">广告名称</th>
						<th style="text-align:center;">广告图片</th>
						<th style="text-align:center;">发布时间</th>
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
							    <c:if test="${var.adUrlType==0}">
									<td class='center' style="text-align:center;">app</td>
								</c:if>
								<c:if test="${var.adUrlType==1}">
									<td class='center' style="text-align:center;">云屏</td>
								</c:if>
								 <c:if test="${var.adPosType==1}">
									<td class='center' style="text-align:center;">E街E铺</td>
								</c:if>
								<c:if test="${var.adPosType==2}">
									<td class='center' style="text-align:center;">红包雨</td>
								</c:if>
								<c:if test="${var.adPosType==3}">
									<td class='center' style="text-align:center;">积分商城</td>
								</c:if>
								<c:if test="${var.adPosType==4}">
                                	<td class='center' style="text-align:center;">E街E铺-活动-弹窗</td>
                                </c:if>
                                <c:if test="${var.adPosType==5}">
                                    <td class='center' style="text-align:center;">E街E铺-活动-悬浮</td>
                                 </c:if>
								<td class='center' style="text-align:center;">${var.adName}</td>
							    <td class="center" width="300">
									<a class="fancybox" href="<%=httpUrl%>${var.adImg}">
									  <img src="<%=httpUrl%>${var.adImg}" alt="${var.adImg}" width="20px" height="20px" />
									</a>
	                            </td>
								<td class='center' style="text-align:center;">${var.adStartTime}/${var.adEndTime}</td>
								<td class='center' style="text-align:center;">
								<c:if test="${var.status == 0}">
									<a href="javascript:void(0);" onclick="updatePrizeStatus(${var.adId},'${var.adName}',1)">启用</a>
								</c:if>
								<c:if test="${var.status == 1}">
									<a href="javascript:void(0);"   onclick="updatePrizeStatus(${var.adId},'${var.adName}',0)">禁用</a>
								</c:if>
							
								</td>
								<td class='center'  style="text-align:center;">
									<a href="javascript:void(0);" onclick="query(${var.adId})">详情</a>
									<a href="javascript:void(0);" onclick="edit(${var.adId})">编辑</a>
									<a href="javascript:void(0);" onclick="updatePrizeStatus(${var.adId},'${var.adName}',5)">删除</a>
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
		<!-- 引入 图片预览功能 -->
		<link rel="stylesheet" type="text/css" href="plugins/fancyBox/jquery.fancybox.css">
		<script type="text/javascript" src="plugins/fancyBox/jquery.fancybox.pack.js"></script>
		
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
		//新增
		function add(otype){
			var form = $("#usersForm");
			form.find('#currentPage').attr('name','currentPage');
			form.find('#showCount').attr('name','showCount');
			 top.jzts();
			 var diag = new top.Dialog();
			 diag.Drag=true;
			 diag.Title ="新增";
			 diag.URL = '<%=basePath%>activityAd/page.do?action='+otype+'&adPosType='+'${adPosType}';
			 diag.Width = 950;
			 diag.Height = 650;
			 diag.CancelEvent = function(){ //关闭事件
				diag.close();
				form.submit();
			 };
			 diag.show();
		}
		//修改
		function edit(id){
			
			var activityType = '${activityType}';
			var form = $("#usersForm");
			form.find('#currentPage').attr('name','currentPage');
			form.find('#showCount').attr('name','showCount');
			 top.jzts();
			 var diag = new top.Dialog();
			 diag.Drag=true;
			 diag.Title ="资料";
			 diag.URL = '<%=basePath%>activityAd/page.do?action=2&adId='+id+'&otype='+1+'&adPosType='+'${adPosType}';
			 diag.Width = 950;
			 diag.Height = 650;
			 diag.CancelEvent = function(){ //关闭事件
				diag.close();
				form.submit();
			 };
			 diag.show();
		}
		
		function query(id){
			 top.jzts();
			 var diag = new top.Dialog();
			 diag.Drag=true;
			 diag.Title ="资料";
			 diag.URL = '<%=basePath%>activityAd/page.do?action=4&adId='+id+'&adPosType='+'${adPosType}';
			 diag.Width = 950;
			 diag.Height = 650;
			 diag.CancelEvent = function(){ //关闭事件
				diag.close();
			 };
			 diag.show();
		}
		
		
		function updatePrizeStatus(id,name,status){
			var form = $('#usersForm')
			form.find('#currentPage').attr('name','currentPage');
			form.find('#showCount').attr('name','showCount');
			if(status==5){
			bootbox.confirm("确定要删除该广告【"+name+"】吗?",function(result){
				if(result) {
					$.ajax({
						type: "POST",
						url: "<%=basePath%>activityAd/delete.do",
				    	data: {adId:id},
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
			}else if(status==0){//禁用
				bootbox.confirm("确定要禁用该广告【"+name+"】吗?",function(result){
					if(result) {
						$.ajax({
							type: "POST",
							url: "<%=basePath%>activityAd/accountStatus.do",
					    	data: {"adId":id,"status":status},
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
				bootbox.confirm("确定要启用该广告【"+name+"】吗?",function(result){
					if(result) {
						$.ajax({
							type: "POST",
							url: "<%=basePath%>activityAd/accountStatus.do",
					    	data: {"adId":id,"status":status},
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

			$(".fancybox").fancybox({
	            helpers: {
	                title: {
	                    type: 'inside'
	                }
	            }
	        });
			
		});
		
		
		
		</script>
		
	</body>
</html>

