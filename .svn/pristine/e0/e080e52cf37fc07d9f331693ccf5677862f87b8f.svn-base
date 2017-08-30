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
	
			<!-- 查询  -->
			<form action="bussinessActivity/listAudit.do" method="post" name="usersForm" id="usersForm">
  			<input type="hidden" id="currentPage" value="${pd.currentPage}"/>
			<input type="hidden" id="showCount" value="${pd.showCount}"/>
				<table>
					<tr>
								<td>
									<span class="input-icon">
										<input autocomplete="off" id="nav-search-input" type="text" name="shopName" value="${pd.shopName}" placeholder="商户名称" style="width:150px;" />
										<i  class="icon-search"></i>
									</span>
								</td>
								<td>
									<span class="input-icon">
										<input autocomplete="off" id="nav-search-input" type="text" name="eventName" value="${pd.eventName}" placeholder="活动名称" style="width:150px;" />
										<i  class="icon-search"></i>
									</span>
								<td>
									<span class="input-icon">
										<input autocomplete="off" id="nav-search-input" type="text" name="eventTitle" value="${pd.eventTitle}" placeholder="活动主题" style="width:150px;" />
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
					</tr>
				</table>		
			</form>
			<!-- 检索  -->
			<table id="table_report" class="table table-striped table-bordered table-hover">
				
				<thead>
					<tr>
						<th class="center">
                    	<label>
                      	<input type="checkbox" id="zcheckbox" />
                      	<span class="lbl"></span>
                    		</label>
                  		</th>
					
					    <th style="text-align:center;">活动编号</th>
						<th style="text-align:center;">商户名称</th>
					    <th style="text-align:center;">活动名称</th>
					    <th style="text-align:center;">活动主题</th>
						<th style="text-align:center;">提交时间</th>
						<th style="text-align:center;">操作</th>
					</tr>
				</thead>
										
				<tbody>
					
				<!-- 开始循环 -->	
				<c:choose>
					<c:when test="${not empty list}">
						<c:forEach items="${list}" var="var" varStatus="vs">
									
							<tr>
							
						<td class='center' style="width: 30px;">
                            <label>
                              <input type='checkbox' name='ids' value="${var.asEventId}" />
                              <span class="lbl"></span>
                            </label>
                          </td>
								<td class='center' style="text-align:center;">${var.asEventId}</td>
								<td class='center' style="text-align:center;">${var.shopName}</td>
								<td class='center' style="text-align:center;">${var.eventName}</td>
								<td class='center' style="text-align:center;">${var.eventTitle}</td>
								<td class='center' style="text-align:center;">${var.createTime}</td>

								<td class='center'  style="text-align:center;">
										<a href="javascript:void(0);" onclick="prizStatus(${var.asEventId})">审批</a>
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
						 	<td style="vertical-align:top;">
								<a class="btn btn-mini btn-success" id="" onclick="allAuditStatus('确定要审批通过选中的数据吗?')" style="width: 55px; height: 27px; line-height:27px">批量通过</a>
							</td>
						
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
		<script type="text/javascript" src="static/js/bootstrap-datepicker.min.js"></script><!-- 日期框 -->
		<script type="text/javascript" src="static/js/bootbox.min.js"></script><!-- 确认窗口 -->
		<!-- 引入 -->
		
		
		<script type="text/javascript" src="static/js/jquery.tips.js"></script><!--提示框-->
		<script type="text/javascript">
		
		$(top.hangge());
		
		//检索
		function search(){
			top.jzts();
			var form = $("#usersForm");
			form.find('#currentPage').attr('name','currentPage');
			form.find('#showCount').attr('name','showCount');
			$("#userForm").submit();
		}
		
		//送审
		function prizStatus(id){
			 top.jzts();
			 var diag = new top.Dialog();
			 diag.Drag=true;
			 diag.Title ="审核处理";
			 diag.URL = '<%=basePath%>bussinessActivity/auditEdit.do?asEventId='+id;
			 diag.Width = 980;
			 diag.Height = 650;
			 diag.CancelEvent = function(){ //关闭事件
				 if(diag.innerFrame.contentWindow.document.getElementById('zhongxin').style.display == 'none'){
					 if(typeof(nextPage) == "function") {
						nextPage(${page.currentPage});
					}
				}
				diag.close();
			 };
			 diag.show();
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
		
		
		
		
		  function allAuditStatus(msg){
			  bootbox.confirm(msg, function(result) {
					if(result) {
					  var str = '';
				        for(var i=0;i < document.getElementsByName('ids').length;i++)
				        {
				          if(document.getElementsByName('ids')[i].checked){
				            if(str==''){
				            	str += document.getElementsByName('ids')[i].value;
				            	}
				            else
				           	 { 
				            	str += ',' + document.getElementsByName('ids')[i].value;
				            	}
				          }
				        }
		
		        if(str==''){
		        	bootbox.dialog("您没有选择任何内容!", 
							[
							  {
								"label" : "关闭",
								"class" : "btn-small btn-success",
								"callback": function() {
									//Example.show("great success");
									}
								}
							 ]
						);
						
						$("#zcheckbox").tips({
							side:3,
				            msg:'点这里全选',
				            bg:'#AE81FF',
				            time:8
				        });
						
						return;
		        }else{
		        	if(msg == '确定要审批通过选中的数据吗?'){
						top.jzts();
						  $.ajax({
				   			    type : "post",
				   		        url : "bussinessActivity/allAuditStatus",
				   		        dataType : "json",
				   				async: false,
				   				data : {
				   					ids: str
				   				},
				   		        success : function (data) {
				   		        	if("0"==data.status){
				   		        		var errIds = data.errIds;
				   		        		if(""==errIds){
					   		        		setTimeout(window.location.href="bussinessActivity/listAudit",100);
					   		        		return;
				   		        		}else{
				   		        			alert("审批完成！其中审批失败的审批编号有"+errIds);	
											setTimeout(window.location.href="bussinessActivity/listAudit",100);
					   		        		return;
				   		        		}
				   		    			}else{
				   		    				alert("审批失败")
				   		    			setTimeout(window.location.href="bussinessActivity/listAudit",100);
				   			    			return;
				   		    			}
				   		        }
				   		});
					}
		        }
			}
			});
		  }
		

		</script>
		
	</body>
</html>

