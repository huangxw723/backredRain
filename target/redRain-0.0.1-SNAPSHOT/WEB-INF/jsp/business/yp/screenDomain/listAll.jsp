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
					<form action="yp/business/screenDomain/listAll.do" method="post"
						name="domainForm" id="domainForm">
						<input type="hidden" id="currentPage" value="${pd.currentPage}" />
						<input type="hidden" id="showCount" value="${pd.showCount}" />
						<table>

			
							
							<tr>
								状态:<span>
								<select name="status" id="status"
									style="width: 180px;">
										<option value="">全部</option>
											<option value="0" <c:if test="${pd.status =='0'}">selected="selected"</c:if>>停用</option>
											<option value="1" <c:if test="${pd.status =='1' }">selected="selected"</c:if>>启用</option>
											<option value="2" <c:if test="${pd.status =='2' }">selected="selected"</c:if>>待审核</option>
											<option value="3" <c:if test="${pd.status =='3' }">selected="selected"</c:if>>审核通过</option>
											<option value="4" <c:if test="${pd.status =='4' }">selected="selected"</c:if>>审核不通过</option>
								</select></span>
										
										<button class="btn btn-mini btn-light" onclick="searchInfo();"
											title="检索">
											<i id="nav-search-icon" class="icon-search"></i>
										</button>
							</tr>


						</table>
					</form>
					<!-- 检索  -->


					<table id="table_report"
						class="table table-striped table-bordered table-hover">

						<thead>
							<tr>

								<th class="center">序号</th>
								<th class="center">域名</th>
								<th class="center">发布屏目数</th>
								<th class="center">创建人</th>
								<th class="center">创建时间</th>
								<th class="center">状态</th>
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
													title="${vs}">${vs.index+1}</td>
												<td
													style="text-align: center; overflow: hidden; white-space: nowrap; text-overflow: ellipsis;"
													title="${var.sn}">${var.url}</td>
												<td class='center' style="text-align: center; width: 90px;"
													>${var.num}
												</td>
												<td class='center' style="width: 80px;">${var.account }</td>
												<td class='center' style="text-align: center; width: 150px"
													title="${var.createTime}">${var.createTime}
												</td>
												<c:if test="${var.status == 0}">		
												<td class='center' style="width: 150px;">停用</td>
												</c:if>
												<c:if test="${var.status == 1}">		
												<td class='center' style="width: 150px;">启用</td>
												</c:if>
												<c:if test="${var.status == 2}">		
												<td class='center' style="width: 150px;"><span style="size: 10px; color: red;">待审核</span></td>
												</c:if>
												<c:if test="${var.status == 3}">		
												<td class='center' style="width: 150px;">审核通过</td>
												</c:if>
												<c:if test="${var.status == 4}">		
												<td class='center' style="width: 150px;">审核不通过</td>
												</c:if>
												<td style="width: 120px;" class="center">
													<div class="inline position-relative">
														<c:if test="${QX.edit == 1}">
															
																<a href="javascript:void(0);"
																onclick="screenView(${var.screenDomainId})">查看</a>
																<a href="javascript:http:www.baidu.com"
																onclick="toUtl(${var.screenInfoId},2)">编辑</a>
										<c:if test="${var.status == 0}">				
										<a href="javascript:void(0);" onclick="edit(${var.screenDomainId},1)">启用</a>
										</c:if>
										<c:if test="${var.status == 1}">
											<a href="javascript:void(0);" onclick="edit(${var.screenDomainId},0)">停用</a>
										</c:if>
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
	<script type="text/javascript" src="static/js/common/commonutils.js"></script>
	<!--提示框-->
	<script type="text/javascript">
		
		

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
	  //查看
	   function screenView(id){
			
			var form = $("#domainForm");
			form.find('#currentPage').attr('name','currentPage');
			form.find('#showCount').attr('name','showCount');
			 top.jzts();
			 var diag = new top.Dialog();
			 diag.Drag=true;
			 diag.Title ="资料";
			 diag.URL = '<%=basePath%>yp/business/screenDomain/listScreenPage.do?screenDomainId='+id;
			 diag.Width = 900;
			 diag.Height = 600;
			 diag.CancelEvent = function(){ //关闭事件
				diag.close();
				form.submit();
			 };
			 diag.show();
		}
   
		//停用或启用
		function edit(id,oty){
			var form = $("#domainForm");
			form.find('#currentPage').attr('name','currentPage');
			form.find('#showCount').attr('name','showCount');
			$.get("yp/business/screenDomain/updataDomain",{screenDomainId:id,status:oty},function(data){
				
				if(data.status != 0){
					alert(data.msg);
					return;
				}
				
				alert("操作成功")
				form.submit();
			},'json');
		}
		
		//新增
		function cle(){
		$("#status").val('');
        searchInfo();
		}
		

		</script>

	<script type="text/javascript">
	$(top.hangge());
	
	//检索
	function searchInfo(){
		top.jzts();
		$("#domainForm").submit();
	}
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

