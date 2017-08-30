<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="com.aoshi.util.PropertyUtils"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	String httpUrl = PropertyUtils.getHTTP_URL();
%>
<!DOCTYPE html>
<html lang="en">
<head>
<base href="<%=basePath%>">
<!-- jsp文件头和头部 -->
<%@ include file="../../../system/admin/top.jsp"%>
</head>
<body>

	<div class="container-fluid" id="main-container">


		<div id="page-content" class="clearfix">

			<div class="row-fluid">

				<div class="row-fluid">

					<!-- 检索  -->
					<form action="yp/admin/ypShop/listAll.do" method="post"
						name="domainForm" id="domainForm">
						<input type="hidden" id="currentPage" value="${pd.currentPage}" />
						<input type="hidden" id="showCount" value="${pd.showCount}" />
						<table>

							<tr>
								行业归属:<span>
								<select name="categoryId" id="categoryId"
									style="width: 180px;">
										<option value="">全部</option>
										<c:forEach items="${types}" var="var">
											<option value="${var.id}"
												<c:if test="${var.id ==pd.categoryId }">selected="selected"</c:if>>
												${var.name }</option>
										</c:forEach>
								</select></span>
								
								创建时间：<span>
								<input class="span10 date-picker" name="startTime"
									id="startTime" type="text" value="${pd.startTime}"
									data-date-format="yyyy-mm-dd"
									style="width: 8%;" placeholder="" /> 至: <input
									class="span10 date-picker" name="endTime" id="endTime"
									type="text" value="${pd.endTime}" data-date-format="yyyy-mm-dd"
								    style="width: 8%;"
									placeholder="" /></span>

							
							所属省份:<span><select name="provinceId" id="provinceId"
									style="width: 90px;">
										<option value="">全部</option>
										<c:forEach items="${provinces }" var="var">
											<option value="${var.provinceId}"
												<c:if test="${var.provinceId ==pd.provinceId }">selected="selected"</c:if>>
												${var.provinceName }</option>
										</c:forEach>
								</select></span>
								企业：<span class="input-icon"> 
									<input id="nav-search-input" type="text" class="keyword" name="keyword" value="${pd.keyword}" placeholder="企业" style="width:260px;"/>
									
								</span>
								<button class="btn btn-mini btn-light" onclick="searchInfo();"
									title="检索">
									<i id="nav-search-icon" class="icon-search"></i>
								</button>&nbsp;  &nbsp;  
								
							</tr>


						</table>
					</form>
					<!-- 检索  -->

					<p>总安装屏数：${screenNum}个</p>
					<table id="table_report"
						class="table table-striped table-bordered table-hover">

						<thead>
							<tr>

								<th class="center">行业归属</th>
								<th class="center">企业名称</th>
								<th class="center">所属省</th>
								<th class="center">企业联系地址</th>
								<th class="center">联系人</th>
								<th class="center">联系电话</th>
								<th class="center">屏统计</th>
								<th class="center">总点击率</th>
								<th class="center">上线时间</th>
								<th class="center">操作</th>

							</tr>
						</thead>

						<tbody>

							<!-- 开始循环 -->


							<c:choose>
								<c:when test="${not empty list}">
									<c:if test="${QX.cha == 1 }">
										<c:forEach items="${list}" var="var" varStatus="vs">
											<tr>

												<td
													style="text-align: center; overflow: hidden; white-space: nowrap; text-overflow: ellipsis;"
													title="${var.categoryName}">${var.categoryName}</td>
												<td
													style="text-align: center; overflow: hidden; white-space: nowrap; text-overflow: ellipsis;"
													title="${var.name}">${var.name}</td>
												<td class='center' style="width: 80px;">${var.province_name}</td>
												<td
													style="text-align: center; overflow: hidden; white-space: nowrap; text-overflow: ellipsis;"
													title="${var.address}">${var.address}</td>
												<td
													style="text-align: center; overflow: hidden; white-space: nowrap; text-overflow: ellipsis;"
													title="${var.contact}">${var.contact}</td>
												<td style="text-align: center;" title="${var.tel}">${var.tel}</td>
												<td style="text-align: center;" title="">${var.screenNum}</td>
												<td
													style="text-align: center; overflow: hidden; white-space: nowrap; text-overflow: ellipsis;"
													title="">100</td>
												<td class='center' style="width: 150px;">${var.create_time}</td>
												<td style="width: 120px;" class="center">
													<div class="inline position-relative">
														<c:if test="${QX.edit == 1}">
                                                            <a href="javascript:void(0);"
                                                                onclick="copyToClipboard(${var.storeId},${var.shopId});">活动地址</a>
															<a href="javascript:void(0);"
																onclick="accountView(${var.shopId})">查看账号</a>
															<a href="javascript:void(0);"
																onclick="screenView(${var.shopId})">云屏终端</a>
															<a  href="javascript:void(0);"
															   onclick="view(${var.shopId},4)">查看</a>
															<a  href="javascript:void(0);"
															   onclick="edit(${var.shopId},2)">编辑</a>
															<a href="javascript:void(0);"
																onclick="deletetShop(${var.shopId},3)">删除</a>
														</c:if>
													</div>
												</td>
											</tr>

										</c:forEach>
									</c:if>
									<c:if test="${QX.cha == 0 }">
										<tr>
											<td colspan="100" class="center">您无权查看</td>
										</tr>
									</c:if>
								</c:when>
								<c:otherwise>
									<tr class="main_info">
										<td colspan="100" class="center">没有相关数据</td>
									</tr>
								</c:otherwise>
							</c:choose>


						</tbody>
					</table>
					<div class="page-header position-relative">
						<table style="width: 100%;">
							<tr>

								<td style="vertical-align: top;">
								<a
									class="btn btn-small btn-success" onclick="add('1');">新增</a>
									<div class="pagination"
										style="float: right; padding-top: 0px; margin-top: 0px;">${page.pageStr}</div>
								</td>
							</tr>
						</table>
					</div>
				</div>
				<!-- PAGE CONTENT ENDS HERE -->
			</div>
			<!--/row-->

		</div>
		<!--/#page-content-->
	</div>
	<!--/.fluid-container#main-container-->

	<!-- 返回顶部  -->
	<a href="#" id="btn-scroll-up" class="btn btn-small btn-inverse"> <i
		class="icon-double-angle-up icon-only"></i>
	</a>

	<!-- 引入 -->
	<script type="text/javascript">window.jQuery || document.write("<script src='static/js/jquery-1.9.1.min.js'>\x3C/script>");</script>
	<script src="static/js/bootstrap.min.js"></script>
	<script src="static/js/ace-elements.min.js"></script>
	<script src="static/js/ace.min.js"></script>

	<script type="text/javascript" src="static/js/chosen.jquery.min.js"></script>
	<!-- 下拉框 -->
	<script type="text/javascript"
		src="static/js/bootstrap-datepicker.min.js"></script>
	<!-- 日期框 -->
	<script type="text/javascript" src="static/js/bootbox.min.js"></script>
	<!-- 确认窗口 -->
	<!-- 确认窗口 -->
	<script type="text/javascript" src="static/js/jquery.tips.js"></script>
	<link rel="stylesheet" type="text/css"
		href="plugins/fancyBox/jquery.fancybox.css">
	<script type="text/javascript"
		src="plugins/fancyBox/jquery.fancybox.pack.js"></script>
	<!-- 引入 -->
	<script type="text/javascript" src="static/js/jquery.tips.js"></script>
	<!--提示框-->
	<script type="text/javascript">
		
		$(top.hangge());
		
		//检索
		function searchInfo(){
			top.jzts();
			$("#domainForm").submit();
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
	    
     function accountView(id){
			
			var form = $("#domainForm");
			form.find('#currentPage').attr('name','currentPage');
			form.find('#showCount').attr('name','showCount');
			 top.jzts();
			 var diag = new top.Dialog();
			 diag.Drag=true;
			 diag.Title ="资料";
			 diag.URL = '<%=basePath%>yp/admin/ypShop/getAccountList.do?shopId='+id;
			 diag.Width = 700;
			 diag.Height = 600;
			 diag.CancelEvent = function(){ //关闭事件
				diag.close();
				form.submit();
			 };
			 diag.show();
		}
     
     //查看
	   function screenView(shopId){
			
			var form = $("#domainForm");
			form.find('#currentPage').attr('name','currentPage');
			form.find('#showCount').attr('name','showCount');
			 top.jzts();
			 var diag = new top.Dialog();
			 diag.Drag=true;
			 diag.Title ="资料";
			 diag.URL = '<%=basePath%>yp/admin/ypShop/listScreenPage.do?shopId='+shopId;
			 diag.Width = 700;
			 diag.Height = 600;
			 diag.CancelEvent = function(){ //关闭事件
				diag.close();
				form.submit();
			 };
			 diag.show();
		}
       //删除商家
		function deletetShop(id,obj){
			
			var form = $("#domainForm");
			form.find('#currentPage').attr('name','currentPage');
			form.find('#showCount').attr('name','showCount');
			$.get("yp/admin/ypShop/opera",{shopId:id,action:obj},function(data){
				
				if(data.status != 0){
					alert(data.msg);
					return;
				}
				
				alert("操作成功")
				form.submit();
			},'json');
		}
		//新增
		function add(otype){
			 top.jzts();
			 var diag = new top.Dialog();
			 diag.Drag=true;
			 diag.Title ="新增";
			 diag.URL = '<%=basePath%>yp/admin/ypShop/page.do?action='+otype;
			 diag.Width = 840;
			 diag.Height = 650;
			 diag.CancelEvent = function () { //关闭事件
		            if (diag.innerFrame.contentWindow.document.getElementById('zhongxin').style.display == 'none') {
		                if ('${page.currentPage}' == '0') {
		                    top.jzts();
		                    setTimeout("self.location=self.location", 100);
		                } else {
		                	location.reload();
		                }
		            }
		            diag.close();
		        };
			 
			 diag.show();
		}
		
		//编辑
		function edit(shopId,oty){
			 top.jzts();
			 var diag = new top.Dialog();
			 diag.Drag=true;
			 diag.Title ="编辑";
			 diag.URL = '<%=basePath%>yp/admin/ypShop/page.do?action='+oty+'&shopId='+shopId;
			 diag.Width = 840;
			 diag.Height = 650;
			 diag.CancelEvent = function () { //关闭事件
		            if (diag.innerFrame.contentWindow.document.getElementById('zhongxin').style.display == 'none') {
		                if ('${page.currentPage}' == '0') {
		                    top.jzts();
		                    setTimeout("self.location=self.location", 100);
		                } else {
		                	location.reload();
		                }
		            }
		            diag.close();
		        };
			 
			 diag.show();
		}
		//编辑
		function view(shopId,oty){
			 top.jzts();
			 var diag = new top.Dialog();
			 diag.Drag=true;
			 diag.Title ="编辑";
			 diag.URL = '<%=basePath%>yp/admin/ypShop/page.do?action='+oty+'&shopId='+shopId;
			 diag.Width = 840;
			 diag.Height = 650;
			 diag.CancelEvent = function () { //关闭事件
		            if (diag.innerFrame.contentWindow.document.getElementById('zhongxin').style.display == 'none') {
		                if ('${page.currentPage}' == '0') {
		                    top.jzts();
		                    setTimeout("self.location=self.location", 100);
		                } else {
		                	location.reload();
		                }
		            }
		            diag.close();
		        };
			 
			 diag.show();
		}
		
		function copyToClipboard(storeId, shopId){
        	var basePath = "<%= request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() %>";
        	var zhuanpan;
        	var youhui;
        	if(basePath) {
        		zhuanpan = basePath + "/redRainInterface/redRain_start.html#/attr?storeId="+storeId+"&shopId="+shopId;
        		youhui = basePath + "/redRainInterface/coupon02.html?storeId="+storeId+"&shopId="+shopId;
        	}
        	var zhuanpanA = $("<a href='javascript:void(0)'>").text("复制").css("float","right").click(function(){
        		var obj = $(this).prev()[0];
        		obj.select();
        		document.execCommand("copy");
        	});
        	var youhuiA = $("<a href='javascript:void(0)'>").text("复制").css("float","right").click(function(){
        		var obj = $(this).prev()[0];
        		obj.select();
        		document.execCommand("copy");
        	});
        	var link = $("<div>")
        			.append($("<div>").append($("<span>").text("大转盘：").after($("<input type='text'>").css("width","80%").attr("value", zhuanpan)).after(zhuanpanA)))
        			.append($("<div>").append($("<span>").text("优惠劵：").after($("<input type='text'>").css("width","80%").attr("value", youhui)).after(youhuiA)));
        	bootbox.dialog(link,
				[{
					"label" : "关闭",
					"class" : "btn-small btn-success",
					"callback": function() {
					}
				}]
			);
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
			
			
			$('#startTime').datepicker({  
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
			});
			
		});
		
		</script>

</body>
</html>

