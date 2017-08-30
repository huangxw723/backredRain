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
					<form action="yp/admin/ypScreenDomain/listScreenPage.do" method="post"
						name="shopForm" id="shopForm">
						<input type="hidden" id="currentPage" value="${pd.currentPage}" />
						<input type="hidden" id="showCount" value="${pd.showCount}" />
						<input type="hidden" id="passShopId"  />
						<input type="hidden" id="passId"  />
						<input type="hidden" id="screenInfoId"  />
						<table>

			
							<tr>
							<td>
							<span>
									企业:
								<select class="chzn-select" name="shopName" id="shopName"placeholder="企业名称">
								<option value="">全部</option>
								<c:forEach items="${shops}" var="sp">
									<option value="${sp.name}" <c:if test="${sp.name ==pd.shopName}">selected="selected"</c:if>>${sp.name}</option>
								</c:forEach>
								</select>
								</span>
								<span>
									状态:
									<select name="status" id="status">
										<option value="">全部</option>
										<option value="0" <c:if test="${pd.status == '0'}">selected="selected"</c:if>>停用</option>
										<option value="1" <c:if test="${pd.status == '1'}">selected="selected"</c:if>>正常</option>
										<option value="2" <c:if test="${pd.status == '2'}">selected="selected"</c:if>>待审核</option>
										<option value="3" <c:if test="${pd.status == '3'}">selected="selected"</c:if>>审核通过</option>
										<option value="4" <c:if test="${pd.status == '4'}">selected="selected"</c:if>>审核不通过</option>
									</select>
								</span>
								<span class="input-icon"> 
									<input id="nav-search-input" type="text" id="url" name="url" value="${pd.url}" placeholder="云屏主站点地址" style="width:230px;"/>
										<i id="nav-search-icon" class="icon-search"></i>
										<button class="btn btn-mini btn-light" onclick="search();"
											title="检索">
											<i id="nav-search-icon" class="icon-search"></i>
										</button>
								</span>
								
								</td>
								<!-- <td style="vertical-align: top;"><a
									class="btn btn-small btn-success" onclick="add('1');">新增</a></td> -->
							</tr>


						</table>
					</form>
					<!-- 检索-->


					<table id="table_report"
						class="table table-striped table-bordered table-hover">

						<thead>
							<tr>

								<th class="center">序号</th>
							    <th class="center">企业</th>
								<th class="center">云屏主站点地址</th>
								<th class="center">状态</th>
								<th class="center">子站点数</th>
								<th class="center">最近编辑时间</th>
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
												<td class='center' style="width: 150px;">${var.shopName}</td>
												<td
													style="text-align: center;"
													title="">${var.url}</td>
												<c:if test="${var.status == 0}">
												<td class='center' style="width: 100px;">停用</td>
												</c:if>
												<c:if test="${var.status == 1}">
												<td class='center' style="width: 100px;">启用</td>
												</c:if>
												<c:if test="${var.status == 2}">
												<td class='center' style="width: 100px;"><span style="font-size: 10px;color: red;">待审核</span></td>
												</c:if>
												<c:if test="${var.status == 3}">
												<td class='center' style="width: 100px;">审核通过</td>
												</c:if>
												<c:if test="${var.status == 4}">
												<td class='center' style="width: 100px;">审核不通过</td>
												</c:if>
												<td class='center' style="width: 80px;">${var.num}</td>
												<td class='center' style="width: 140px;">${var.createTime}</td>
												<td style="width: 120px;" class="center">
													<div class="inline position-relative">
														<c:if test="${QX.edit == 1}">
													        <a href="javascript:void(0);" onclick="childDomainView(${var.shopId});"">查看子站点</a>
															<c:if test="${var.status == 0}">					
															<a href="javascript:void(0);" onclick="operaStatus(${var.shopId},1)">启用</a>
															</c:if>
															<c:if test="${var.status == 1}">
																<a href="javascript:void(0);" onclick="operaStatus(${var.shopId},0)">停用</a>
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
	    
		//编辑
		function childDomainView(id){
			 top.jzts();
			 console.log("shpid:"+id);
			 top.mainFrame.tabAddHandler('z'+id,'站点信息','yp/admin/ypScreenDomain/listShopAll.do?shopId='+id);
		}
	
		//编辑
		function edit(id,otype){
			 top.jzts();
			 var diag = new top.Dialog();
			 diag.Drag=true;
			 diag.Title ="新增";
			 diag.URL = '<%=basePath%>yp/business/ypScreenInfo/page.do?action='+otype+'&screenInfoId='+id;
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
		//停用或启用主域名
		function operaStatus(id,oty){
			var form = $("#shopForm");
			form.find('#currentPage').attr('name','currentPage');
			form.find('#showCount').attr('name','showCount');
			$.get("yp/admin/ypScreenDomain/updateDomainStatus",{shopId:id,status:oty},function(data){	
				if(data.status != 0){
					alert(data.msg);
					return;
				}
				
				 alert("操作成功")
				 window.location.reload(); 
			},'json');
		}
		//清除
		
		function cle(){
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

