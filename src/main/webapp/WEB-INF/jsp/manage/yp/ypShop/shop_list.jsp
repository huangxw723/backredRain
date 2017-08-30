<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.aoshi.util.PropertyUtils" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    String httpUrl = PropertyUtils.getHTTP_URL();
%>
<!DOCTYPE html>
<html lang="en">
	<head>
	<base href="<%=basePath%>"><!-- jsp文件头和头部 -->
	<%@ include file="../../../system/admin/top.jsp"%>
	</head>
<body>
		
<div class="container-fluid" id="main-container">


<div id="page-content" class="clearfix">
						
  <div class="row-fluid">

	<div class="row-fluid">

			<!-- 检索  -->
			<form action="yp/admin/YpShop/listAll.do" method="post" name="shopForm" id="shopForm">
			<input type="hidden" id="currentPage" value="${pd.currentPage}"/>
			<input type="hidden" id="showCount" value="${pd.showCount}"/>
			<table>

        <tr>          
          <th >账户状态:</th>
          <td colspan="2">
             <select name="status" id="status" style="width:70%;">
             <option value="">全部</option>
             <option value="0"<c:if test="${pd.status=='0' }">selected="selected" </c:if> >正常</option>
             <option value="1"<c:if test="${pd.status=='1' }">selected="selected"</c:if>>停用</option>
             </select>
          
          </td>
          
          <th style="text-align: right;">企业或账户名:</th>
          <td>
             <input type="text" style="width:90%;" name="keyWord" id="keyWord" value="${pd.keyword }" />
          </td>
        </tr>
        <tr>          
<!--           <th>账户类型:</th> -->
<!--           <td colspan="2"> -->
<%--              <input type="text" style="width:60%;" name="brandName" id="brandName" value="${rand.brandName }" placeholder="这里输入品牌名称" title="品牌名称" /> --%>
<!--           </td> -->
         <th style="text-align: right;">创建时间：</th> 
          <td>
             <input class="span10 date-picker" name="startTime" id="startTime" type="text" value="${pd.startTime}" data-date-format="yyyy-mm-dd" readonly="readonly" style="width:31%;" placeholder="07/14/2007"/>
             
                                  至:
             <input class="span10 date-picker" name="endTime" id="endTime" type="text" value="${pd.endTime}" data-date-format="yyyy-mm-dd" readonly="readonly" style="width:31%;" placeholder="07/14/2007"/>
          </td>
          <th style="text-align: right;"></th>
         <td style="vertical-align:top;">
					<a class="btn btn-small btn-success" onclick="searchInfo();">查询</a>
		</td>
		             
		  <td style="vertical-align:top;">
					<input type="button"  size="20" onclick="cle();" value="清除">
		</td>
        </tr>
     
			</table>
			</form>
			<!-- 检索  -->


			<table id="table_report" class="table table-striped table-bordered table-hover">

				<thead>
					<tr>
						
						<th class="center">企业名称</th>
						<th class="center">账号名称</th>
						<th class="center">创建时间</th>
						<th class="center">状态</th>
						<th class="center">最近登陆时间</th>
                        <th class="center">操作</th>

					</tr>
				</thead>

				<tbody>

				<!-- 开始循环 -->

				
				<c:choose>
					<c:when test="${not empty ypshops}">
						<c:if test="${QX.cha == 1 }">
						<c:forEach items="${ypshops}" var="var" varStatus="vs">
							<tr>
								
								<td style=" text-align: center; overflow: hidden;white-space: nowrap;text-overflow: ellipsis;" title="${var.name}">${var.name}</td>
								<td style=" text-align: center; overflow: hidden;white-space: nowrap;text-overflow: ellipsis;" title="${var.account}">${var.account}</td>
								<td class='center' style="width: 180px;">${var.create_time}</td>
								<td class="center" style="width: 50px;">
	                            <c:if test="${var.status == 0 }">
	                              <span class="label label-success arrowed">正常</span>
	                            </c:if>
	                            <c:if test="${var.status == 1 }">
	                              <span class="label label-important arrowed">停用</span>
	                            </c:if>
	                            </td>
	                            <td class='center' style="width: 180px;">${var.create_time}</td>
								<td style="width: 80px;" class="center">
     									<c:if test="${QX.edit != 1 && QX.del != 1 }">
                                            <span class="label label-large label-grey arrowed-in-right arrowed-in">
                                                <i class="icon-lock" title="无权限"></i>
                                            </span>
                                        </c:if>
                                        <div class="inline position-relative">
										<c:if test="${QX.edit == 1}">
									
										<c:if test="${var.status == 0}">
											<a href="javascript:void(0);" onclick="updateUserStatus(${var.user_id},1)">停用</a>
										</c:if>
										<c:if test="${var.status == 1}">
											<a href="javascript:void(0);" onclick="updateUserStatus(${var.user_id},0)">启用</a>
										</c:if>
								
<%-- 										<a style="cursor:pointer;" title="编辑" onclick="edit('${var.shopId}');" class="tooltip-success" data-rel="tooltip" title="" data-placement="left"><span class="green"><i class="icon-edit"></i></span></a></li> --%>
										
<!-- 										<button class="btn btn-mini btn-info" data-toggle="dropdown"><i class="icon-cog icon-only"></i></button> -->
<!-- 										<ul class="dropdown-menu dropdown-icon-only dropdown-light pull-right dropdown-caret dropdown-close"> -->
<%-- 											<c:if test="${QX.edit == 1 }"> --%>
<%-- 											<li><a style="cursor:pointer;" title="编辑" onclick="edit('${var.brandId}');" class="tooltip-success" data-rel="tooltip" title="" data-placement="left"><span class="green"><i class="icon-edit"></i></span></a></li> --%>
<%-- 											</c:if> --%>
<%-- 											<c:if test="${QX.del == 1 }"> --%>
<%-- 											<li><a style="cursor:pointer;" title="删除" onclick="del('${var.brandId}');" class="tooltip-error" data-rel="tooltip" title="" data-placement="left"><span class="red"><i class="icon-trash"></i></span> </a></li> --%>
<%-- 											</c:if> --%>
<!-- 										</ul> -->
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
							<td colspan="100" class="center" >没有相关数据</td>
						</tr>
					</c:otherwise>
				</c:choose>


				</tbody>
			</table>
                   <div class="page-header position-relative">
							<table style="width: 100%;">
								<tr>
									
									<td style="vertical-align: top;">
									<a class="btn btn-small btn-success" onclick="add('1');">新增</a>
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
		<!-- 确认窗口 -->
		<script type="text/javascript" src="static/js/jquery.tips.js"></script>
		<link rel="stylesheet" type="text/css" href="plugins/fancyBox/jquery.fancybox.css">
		<script type="text/javascript" src="plugins/fancyBox/jquery.fancybox.pack.js"></script>
		<!-- 引入 -->
		<script type="text/javascript" src="static/js/jquery.tips.js"></script><!--提示框-->
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
	    
	  //更新状态
		function updateUserStatus(id,status){
			
			var form = $("#shopForm");
			form.find('#currentPage').attr('name','currentPage');
			form.find('#showCount').attr('name','showCount');
			$.get("yp/admin/YpShop/updateUserStatus",{userId:id,status:status},function(data){
				
				if(data.status != 0){
					alert(data.msg);
					return;
				}
				
				alert("操作成功")
				form.submit()
			},'json');
		}
	
		//新增
		function add(otype){
			 top.jzts();
			 var diag = new top.Dialog();
			 diag.Drag=true;
			 diag.Title ="新增";
			 diag.URL = '<%=basePath%>yp/admin/YpShop/page.do?action='+otype;
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
		function edit(shopId){
			
			var form = $("#shopForm");
			form.find('#currentPage').attr('name','currentPage');
			form.find('#showCount').attr('name','showCount');
			 top.jzts();
			 var diag = new top.Dialog();
			 diag.Drag=true;
			 diag.Title ="资料";
			 diag.URL = '<%=basePath%>yp/admin/YpShop/opera.do?action=2&shopId='+shopId;
			 diag.Width = 700;
			 diag.Height = 600;
			 diag.CancelEvent = function(){ //关闭事件
				diag.close();
				form.submit()
			 };
			 diag.show();
		}
		
		//新增
		function cle(){
		$("#status").val('');	
	    $("#keyWord").val('');	
        $("#startTime").val('');
        $("#endTime").val('');
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

