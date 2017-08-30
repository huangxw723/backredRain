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
					<form action="yp/admin/ypScreenDomain/listAll.do" method="post"
						name="shopForm" id="shopForm">
						<input type="hidden" id="currentPage" value="${pd.currentPage}" />
						<input type="hidden" id="showCount" value="${pd.showCount}" />
						<input type="hidden" id="screenDomainId"  />
						<table>

							<tr>
							审核状态:<span><select name="status" id="status"
									style="width: 145px;">
										<option value="">全部</option>
											<option value="0" <c:if test="${pd.status =='0'}">selected="selected"</c:if>>停用</option>
											<option value="1" <c:if test="${pd.status =='1' }">selected="selected"</c:if>>启用</option>
											<option value="2" <c:if test="${pd.status =='2' }">selected="selected"</c:if>>待审核</option>
											<option value="3" <c:if test="${pd.status =='3' }">selected="selected"</c:if>>审核通过</option>
											<option value="4" <c:if test="${pd.status =='4' }">selected="selected"</c:if>>审核不通过</option>
								</select></span>
								创建时间：
								<span><input class="span10 date-picker" name="startTime"
									id="startTime" type="text" value="${pd.startTime}"
									data-date-format="yyyy-mm-dd" 
									 placeholder="" style="width:100px;" /> 至: <input
									class="span10 date-picker" name="endTime" id="endTime"
									type="text" value="${pd.endTime}" data-date-format="yyyy-mm-dd"
									 
									placeholder="" style="width:100px;"/></span>
									
							    <span class="input-icon"> 
									<input autocomplete="off" id="nav-search-input" type="text" id="keyWord" name="keyWord" value="${pd.keyWord}"  style="width:258px;" placeholder="企业/账号" />
										<i id="nav-search-icon" class="icon-search"></i>
										<button class="btn btn-mini btn-light" onclick="searchInfo();"
											title="检索">
											<i id="nav-search-icon" class="icon-search"></i>
										</button>
								</span>
								</td>
							
							</tr>


						</table>
					</form>
					<!-- 检索  -->


					<table id="table_report"
						class="table table-striped table-bordered table-hover">

						<thead>
							<tr>

								<th class="center">序号</th>
							    <th class="center">企业</th>
							    <th class="center">操作账号</th>
								<th class="center">站点地址</th>
								<th class="center">发布屏</th>
								<th class="center">状态</th>
								<th class="center">创建时间</th>
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

												<td class='center' style="width: 150px;">${vs.index+1}</td>
												<td class='center' style="width: 150px;">${var.shopName}</td>
											    <td class='center' style="width: 60px;">${var.account}</td>
												<td class='center' style="width: 150px;">
												<a href="javascript:void(0);" 
												 onclick="" >${var.url}</a>
												</td>
												<td class='center' style="width: 50px;">
												${var.num}
												</td>
												<c:if test="${var.status == 0}">
												<td class='center' style="width: 70px;">停用</td>
												</c:if>
												<c:if test="${var.status == 1}">
												<td class='center' style="width: 70px;">启用</td>
												</c:if>
												<c:if test="${var.status == 2}">
												<td class='center' style="width: 70px;"><span style="font-size: 10px;color: red;">待审核</span></td>
												</c:if>
												<c:if test="${var.status == 3}">
												<td class='center' style="width: 70px;">审核通过</td>
												</c:if>
												<c:if test="${var.status == 4}">
												<td class='center' style="width: 70px;">审核不通过</td>
												</c:if>
												<td class='center' style="width: 80px;">${var.createTime}</td>
												<td style="width: 60px;" class="center">
													<div class="inline position-relative">
														<c:if test="${QX.edit == 1}">
																<a href="javascript:void(0);"  onclick="operaSubmmitPage(${var.shopId},${var.screenDomainId});" >审核</a>
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
<!-- 审核模态框（Modal） -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="position:fixed;top:36%"> 
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">
					&times;
				</button>
				<h4 class="modal-title" id="myModalLabel">
					审核	</h4>
					</div>
			<div class="modal-body">

您正在审核云屏终端，请确定该终端信息已注册到系统中并编码正确无误，

请严格检查确认后提交审核结果！
			</div>
			
			<div class="modal-footer" >
				
				<button type="button"  onclick="operaSubmmit('3');" class="btn btn-primary">
				 通过
				</button>
				<button type="button" onclick="operaSubmmit('4');" class="btn btn-warning">
				不通过
				</button>
			</div>
		</div><!-- /.modal-content -->
	</div><!-- /.modal -->
</div>
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
			$("#shopForm").submit();
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
		//送审
		function operaSubmmitPage(id,screenId){
			 $("#screenDomainId").val(screenId); 
			 $("#myModal").modal('show'); 
		}
		   //送审
		function operaSubmmit(oty){
			var form = $("#shopForm");
			form.find('#currentPage').attr('name','currentPage');
			form.find('#showCount').attr('name','showCount');
			var screenDomainId = $("#screenDomainId").val(); 
			$.get("yp/admin/ypScreenDomain/operaSumbmit",{screenDomainId:screenDomainId,status:oty},function(data){
				
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
		$("#sn").val('');	
		$("#status").val('');
        $("#url").val('');
        searchInfo();
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

