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
	<%@ include file="../../system/admin/top.jsp"%>
	</head>
<body>
		
<div class="container-fluid" id="main-container">


<div id="page-content" class="clearfix">
						
  <div class="row-fluid">

	<div class="row-fluid">


                         
			<table id="table_report" class="table table-striped table-bordered table-hover">

				<thead>
					<tr>
						<th class="center">
						<label><input type="checkbox" id="zcheckbox" /><span class="lbl"></span></label>
						</th>
						<th class="center">序号</th>
						<th class="center">类型名称</th>
                        <th class="center">操作</th>
					</tr>
				</thead>

				<tbody>

				<!-- 开始循环 -->

				
				<c:choose>
					<c:when test="${not empty list}">
<%-- 						<c:if test="${QX.cha == 1 }"> --%>
						<c:forEach items="${list}" var="var" varStatus="vs">
							<tr>
								<td class='center' style="width: 30px;">
									<label><input type='checkbox' name='shippingId' value="${var.prizeTypeId}" /><span class="lbl"></span></label>
								</td>
								<td class='center' style="width: 30px;">${vs.index+1}</td>
								<td style="max-width: 100px; text-align: center; overflow: hidden;white-space: nowrap;text-overflow: ellipsis;" title="${var.prizeTypeName}">${var.prizeTypeName}</td>
								
								<td style="width: 180px;" class="center">
     									<%-- <c:if test="${QX.edit != 1 && QX.del != 1 }">
                                            <span class="label label-large label-grey arrowed-in-right arrowed-in">
                                                <i class="icon-lock" title="无权限"></i>
                                            </span>
                                        </c:if> --%>
                                        <div class="inline position-relative">
										<c:if test="${QX.edit == 1 || QX.del == 1 }">
										<button class="btn btn-mini btn-info" data-toggle="dropdown"><i class="icon-cog icon-only"></i></button>
										<ul class="dropdown-menu dropdown-icon-only dropdown-light pull-right dropdown-caret dropdown-close">
											<c:if test="${QX.edit == 1 }">
											<li><a style="cursor:pointer;" title="编辑" onclick="edit('${var.prizeTypeId}');" class="tooltip-success" data-rel="tooltip" title="" data-placement="left"><span class="green"><i class="icon-edit"></i></span></a></li>
											</c:if>
											<c:if test="${QX.del == 1 }">
											<li><a style="cursor:pointer;" title="删除" onclick="del('${var.prizeTypeId}');" class="tooltip-error" data-rel="tooltip" title="" data-placement="left"><span class="red"><i class="icon-trash"></i></span> </a></li>
											</c:if>
										</ul>
										</c:if>
										</div>
								</td>
							</tr>

						</c:forEach>
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
		<table style="width:100%;">
			<tr>
				<td style="vertical-align:top;">
					<c:if test="${QX.add == 1 }">
					<a class="btn btn-small btn-success" onclick="add();">新增</a>
					</c:if>
				</td>
				<td style="vertical-align:top;"><div class="pagination" style="float: right;padding-top: 0px;margin-top: 0px;">${page.pageStr}</div></td>
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
		function search(){
			top.jzts();
			$("#Form").submit();
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
		//新增
		function add(){
			 top.jzts();
			 var diag = new top.Dialog();
			 diag.Drag=true;
			 diag.Title ="新增";
			 diag.URL = '<%=basePath%>prizeType/goAdd.do';
			 diag.Width = 640;
			 diag.Height = 450;
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
		

		//删除
		function del(Id) {

			bootbox.confirm("                确定要删除吗?", function(result) {
				if(result) {
					$.ajax({
						type: "POST",
						url: '<%=basePath%>prizeType/delete.do',
				    	data: {prizeTypeId:Id},
						dataType:'json',
						cache: false,
						success: function(data){
							if(data.status== "1001"){
								alert(data.msg);
							}
								history.go(0);
									
						}
					});
				}
			});
			
		}
	
		
		//修改
		function edit(ad_id){
			 top.jzts();
			 var diag = new top.Dialog();
			 diag.Drag=true;
			 diag.Title ="编辑";
			 diag.URL = '<%=basePath%>prizeType/goEdit.do?prizeTypeId='+ad_id;
			 diag.Width = 640;
			 diag.Height = 450;
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
		
		//批量操作
		function makeAll(msg){
			bootbox.confirm(msg, function(result) {
				if(result) {
					var str = '';
					for(var i=0;i < document.getElementsByName('shippingId').length;i++)
					{
						  if(document.getElementsByName('shippingId')[i].checked){
						  	if(str=='') str += document.getElementsByName('shippingId')[i].value;
						  	else str += ',' + document.getElementsByName('shippingId')[i].value;
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
						if(msg == '确定要删除选中的数据吗?'){
							top.jzts();
							$.ajax({
								type: "POST",
								url: '<%=basePath%>brand/deleteAll',
								dataType:'json',
								//beforeSend: validateData,
                                data: {ids:str},
								cache: false,
								success: function(data){
									if(data.msg=='ok'){
										if(typeof(nextPage) == "function") {
											nextPage(${page.currentPage});
										}
                                    }else{

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

