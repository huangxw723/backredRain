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
					<form action="yp/admin/ypScreenInfo/listAll.do" method="post"
						name="shopForm" id="shopForm">
						<input type="hidden" id="currentPage" value="${pd.currentPage}" />
						<input type="hidden" id="showCount" value="${pd.showCount}" />
						<input type="hidden" id="screenInfoId" name="screenInfoId" value="${pd.showCount}" />
						<input type="hidden" id="passShopId" name="passShopId" value="${pd.showCount}" />
						<table >

			                
							<tr>
							域名：<span>
								  <input name="url" id="url" type="text" value="${pd.url}"
								style="width: 20%;"  placeholder="域名"/></span>
                                
							状态:<span>
								<select name="status" id="status"
									style="width: 120px;">
										<option value="">全部</option>
											<option value="0" <c:if test="${pd.status =='0'}">selected="selected"</c:if>>待审核</option>
											<option value="1" <c:if test="${pd.status =='1' }">selected="selected"</c:if>>审核通过</option>
											<option value="2" <c:if test="${pd.status =='2' }">selected="selected"</c:if>>审核不通过</option>
								</select></span>
							
						         终端编号:<span>
								<input name="sn" id="sn" type="text" value="${pd.sn}"style="width: 20%;" placeholder="终端编号" />								</td>
								</span>
						          企业：<span class="input-icon"> 
									<input  type="text" class="shopName" id="shopName" name="shopName" value="${pd.shopName}" placeholder="企业" style="width:260px;"/>
									
						        </span>	
							<button class="btn btn-mini btn-light" onclick="searchInfo();"
									title="检索">
									<i id="nav-search-icon" class="icon-search"></i>
							</button>	
							<span>&nbsp;</span>	
								<span><a class="btn btn-small btn-success" onclick="toExcel();">导出数据</a></span>
								

								
								
								
							</tr>
								
						</table>
					</form>
					<!-- 检索  -->

 <p>总安装屏数：${screenNum}个</p>
					<table id="table_report"
						class="table table-striped table-bordered table-hover">

						<thead>
							<tr>

								<th class="center">序号</th>
								<th class="center">终端编号</th>
								<th class="center">企业</th>
								<th class="center">省份</th>
								<th class="center">市区</th>
								<th class="center">行政区</th>
								<th class="center">详细地址</th>
								<th class="center">绑定域名</th>
								<th class="center">操作时间</th>
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
													title="${var.sn}">${var.sn}</td>
												<td style="width: 170px;" class='center' title="${var.sn}">${var.name}</td>
												<td class='center' >${var.province_name}</td>
												<td
													style="text-align: center; overflow: hidden; white-space: nowrap; text-overflow: ellipsis;"
													title="${var.cityName}">${var.city_name}</td>
												<td
													style="text-align: center; overflow: hidden; white-space: nowrap; text-overflow: ellipsis;"
													title="${var.areaName}">${var.area_name}</td>
												<td
													style="text-align: center; overflow: hidden; white-space: nowrap; text-overflow: ellipsis;"
													title="${var.address}">${var.address}</td>
												
												<td
													style="text-align: center; overflow: hidden; white-space: nowrap; text-overflow: ellipsis;"
													title="">${var.url}</td>
													<td
													style="text-align: center;"
													title="">${var.createTime}</td>
												<c:if test="${var.status == 0}">
												<td class='center' style="width: 70px;"><font size="2" color="red">待审核</font></td>
												</c:if>
												<c:if test="${var.status == 1}">
												<td class='center' style="width: 70px;">审核通过</td>
												</c:if>
												<c:if test="${var.status == 2}">
												<td class='center' style="width: 70px;">审核不通过</td>
												</c:if>
												
												<td style="width: 120px;" class="center">
													<div class="inline position-relative">
														<c:if test="${QX.edit == 1}">
															<a href="javascript:void(0);"
																onclick="edit(${var.screenInfoId},2)">编辑</a>
																<a href="javascript:void(0);"
																onclick="operaSubmmitPage(${var.shopId},${var.screenInfoId})">审核</a>
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
			
			<div class="modal-footer">
				
				<button type="button"  onclick="operaSubmmit(1);" class="btn btn-primary">
				 通过
				</button>
				<button type="button" onclick="operaSubmmit('2');" class="btn btn-warning">
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
			 $("#screenInfoId").val(screenId); 
			 $("#passShopId").val(id); 
			 $("#myModal").modal('show'); 
		}
		   //送审
		function operaSubmmit(oty){
			var form = $("#shopForm");
			form.find('#currentPage').attr('name','currentPage');
			form.find('#showCount').attr('name','showCount');
			var screenInfoId = $("#screenInfoId").val(); 
			var shopId = $("#passShopId").val(); 
			$.get("yp/admin/ypScreenInfo/operaSumbmit",{screenInfoId:screenInfoId,shopId:shopId,status:oty},function(data){
				
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
			 diag.URL = '<%=basePath%>yp/admin/ypScreenInfo/page.do?action='+otype;
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
		//修改
		function edit(id,oty){
			 top.jzts();
			 var diag = new top.Dialog();
			 diag.Drag=true;
			 diag.Title ="新增";
			 diag.URL = '<%=basePath%>yp/admin/ypScreenInfo/page.do?action='+oty+'&screenInfoId='+id;
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
		
		
		//导出excel
		function toExcel(){
			var sn = $("#sn").val();
			var shopName = $("#shopName").val();
			var url = $("#url").val();
			var status = $("#status").val();
			window.location.href='<%=basePath%>yp/admin/ypScreenInfo/excel.do?sn='+sn+'&shopName='+shopName+'&url='+url+'&status='+status;
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

