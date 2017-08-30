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
					<form action="yp/admin/ypShop/getAccountList.do" method="post"
						name="domainForm" id="domainForm">
						<input type="hidden" id="currentPage" value="${pd.currentPage}" />
						<input type="hidden" id="showCount" value="${pd.showCount}" />
					</form>
					<table id="table_report"
						class="table table-striped table-bordered table-hover">

						<thead>
							<tr>

								<th class="center">类型</th>
								<th class="center">账号名</th>
								<th class="center">状态</th>
								<th class="center">创建时间</th>
								<th class="center">操作</th>

							</tr>
						</thead>

						<tbody>

							<!-- 开始循环 -->


							<c:choose>
								<c:when test="${not empty users}">
									<c:if test="${QX.cha == 1 }">
										<c:forEach items="${users}" var="var" varStatus="vs">

											<tr>
												<c:if test="${var.type == 1}">
													<td class='center' style="width: 80px;">商场管理员</td>
												</c:if>
												<c:if test="${var.type == 2}">
													<td class='center' style="width: 80px;">员工</td>
												</c:if>
												<c:if test="${var.type == 0}">
													<td class='center' style="width: 80px;">普通用户</td>
												</c:if>
												<c:if test="${var.type == 3}">
													<td class='center' style="width: 80px;">系统管理员</td>
												</c:if>
												<td
													style="text-align: center; overflow: hidden; white-space: nowrap; text-overflow: ellipsis;"
													title="${var.account}">${var.account}</td>
												<c:if test="${var.status == '0' }">
													<td class='center' style="width: 80px;"><span
														class="label label-success arrowed">正常</span></td>
												</c:if>
												<c:if test="${var.status == '1' }">
													<td class='center' style="width: 80px;"><span
														class="label label-important arrowed">停用</span></td>
												</c:if>
												<td class='center' style="width: 80px;">${var.create_time}</td>

												<td style="width: 80px;" class="center"><c:if
														test="${QX.edit != 1 && QX.del != 1 }">
														<span
															class="label label-large label-grey arrowed-in-right arrowed-in">
															<i class="icon-lock" title="无权限"></i>
														</span>
													</c:if>
													<div class="inline position-relative">
														<c:if test="${QX.edit == 1}">
															<c:if test="${var.status == 0}">
																<a href="javascript:void(0);"
																	onclick="updateUserStatus(${var.userId},1,${var.type})">停用</a>
															</c:if>
															<c:if test="${var.status == 1}">
																<a href="javascript:void(0);"
																	onclick="updateUserStatus(${var.userId},0,${var.type})">启用</a>
															</c:if>
														</c:if>
													</div></td>
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
	<!--提示框-->
	<script type="text/javascript">
		$(top.hangge());
		//更新状态
		function updateUserStatus(id,status,oty){
			
			var form = $("#shopForm");
			form.find('#currentPage').attr('name','currentPage');
			form.find('#showCount').attr('name','showCount');
			$.get("yp/admin/ypShop/updateUserStatus.do",{userId:id,status:status,type:oty},function(data){				
			if(data.status != 0){
				alert(data.msg);
				return;
			}
			alert("操作成功")
			window.location.reload();
			},'json');
		}
		</script>

</body>
</html>

