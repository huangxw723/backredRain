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

			<!-- 检索  -->
			<form action="shipping/shippingList" method="post" name="Form" id="Form">
			<input type="hidden" id="currentPage" value="${pd.currentPage}"/>
            <input type="hidden" id="showCount" value="${pd.showCount}"/>
			<table>
				<tr>
					<td>
						<span class="input-icon">
							<input autocomplete="off" id="nav-search-input" type="text" name="keyWords" id="keyWords"  value="${pd.keyWords}" placeholder="代号/名称" />
							<i id="nav-search-icon" class="icon-search"></i>
						</span>
					</td>

					<td style="vertical-align:top;"> &nbsp;<button class="btn btn-mini btn-light" onclick="search();"  title="检索"><i id="nav-search-icon" class="icon-search"></i></button></td>

					<td style="vertical-align:top;">
						&nbsp;
						<a class="btn btn-small btn-success" onclick="add();">新增</a>
					</td>
			</tr>
			</table>
			<!-- 检索  -->


			<table id="table_report" class="table table-striped table-bordered table-hover">

				<thead>
					<tr>
						<th class="center">
						<label><input type="checkbox" id="zcheckbox" /><span class="lbl"></span></label>
						</th>
						<th class="center">序号</th>
						<th class="center">配送方式代号</th>
						<th class="center">配送方式名称</th>
						<th class="center">配送方式描述</th>
						<th class="center">是否禁用</th>
                        <th class="center">操作</th>

					</tr>
				</thead>

				<tbody>

				<!-- 开始循环 -->
				<c:choose>
					<c:when test="${not empty list}">

						<c:forEach items="${list}" var="var" varStatus="vs">
							<tr>
								<td class='center'>
									<label><input type='checkbox' name='ids' value="${var.shippingId}" /><span class="lbl"></span></label>
								</td>
								<td class='center'>${vs.index+1}</td>
								<td class="center" title="${var.shippingCode}">${var.shippingCode}</td>
								<td class='center'>${var.shippingName}</td>
								<td class='center'>${var.shippingDesc}</td>
                                <td class="center">
	                            <c:if test="${var.enabled == 1 }">
	                              <span class="label label-success arrowed">不禁用</span>
	                            </c:if>
	                            <c:if test="${var.enabled == 0 }">
	                              <span class="label label-important arrowed">禁用</span>
	                            </c:if>
	                            </td>
								<%--<td style="width: 180px;" class="center">

                                        <div class="inline position-relative">
										<button class="btn btn-mini btn-info" data-toggle="dropdown"><i class="icon-cog icon-only"></i></button>
										<ul class="dropdown-menu dropdown-icon-only dropdown-light pull-right dropdown-caret dropdown-close">

											<li><a style="cursor:pointer;" title="编辑" onclick="edit('${var.shippingId}');" class="tooltip-success" data-rel="tooltip" title="" data-placement="left"><span class="green"><i class="icon-edit"></i></span></a></li>


											<li><a style="cursor:pointer;" title="删除" onclick="del('${var.shippingId}');" class="tooltip-error" data-rel="tooltip" title="" data-placement="left"><span class="red"><i class="icon-trash"></i></span> </a></li>

										</ul>

										</div>
								</td>--%>
								<td class='center'  style="text-align:center;">
									<a href="javascript:void(0);" onclick="edit(${var.shippingId})">编辑</a>
									<a href="javascript:void(0);" onclick="del(${var.shippingId})">删除</a>
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
<%-- 					<c:if test="${QX.adds == 1 }"> --%>
<%-- 					</c:if> --%>
<%-- 					<c:if test="${QX.dels == 1 }"> --%>
					<a class="btn btn-small btn-danger" onclick="makeAll('确定要删除选中的数据吗?');" title="批量删除" ><i class='icon-trash'></i></a>
<%-- 					</c:if> --%>
				</td>
				<td style="vertical-align:top;"><div class="pagination" style="float: right;padding-top: 0px;margin-top: 0px;">${page.pageStr}</div></td>
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
		<!-- 引入 -->
		<script type="text/javascript" src="static/js/jquery.tips.js"></script><!--提示框-->
		<script type="text/javascript">
		
		$(top.hangge());
		
		//检索
		function search(){
			top.jzts();
			var form = $("#Form");
			form.find('#currentPage').attr('name','currentPage');
            form.find('#showCount').attr('name','showCount');
			$("#Form").submit();
		}
		//新增
		function add(){
			 top.jzts();
			 var diag = new top.Dialog();
			 diag.Drag=true;
			 diag.Title ="新增";
			 diag.URL = '<%=basePath%>shipping/goShippingCfgPage.do?doAction=1';
			 diag.Width = 400;
			 diag.Height = 280;
			 diag.CancelEvent = function(){ //关闭事件
				 
				 if(diag.innerFrame.contentWindow.document.getElementById('zhongxin').style.display == 'none'){
					 
					 setTimeout("self.location=self.location",100);
				}
				diag.close();
			 };
			 
			 diag.show();
		}
		
		//删除
		function del(Id){
			bootbox.confirm("确定要删除吗?", function(result) {
				if(result) {
					top.jzts();
					var url = "<%=basePath%>shipping/operaShipping.do?doAction=3&ids="+Id;
					$.get(url,function(data){
						setTimeout("self.location=self.location",100);
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
			 diag.URL = '<%=basePath%>shipping/goShippingCfgPage.do?doAction=2&shippingId='+ad_id;
			 diag.Width = 800;
			 diag.Height = 650;
			 diag.CancelEvent = function(){ //关闭事件
				 if(diag.innerFrame.contentWindow.document.getElementById('zhongxin').style.display == 'none'){
					 top.jzts();
					 setTimeout("self.location=self.location",100);
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
		debuuger;
		function makeAll(msg){
			bootbox.confirm(msg, function(result) {
				if(result) {
					
					// ids str
					var str = '';
					var idsSrcArr = document.getElementsByName("ids");
					var idsArr = new Array();
					var idx = 0;
					for(var i=0;i < idsSrcArr.length;i++){
						  if(idsSrcArr[i].checked){
							  idsArr[idx++] = idsSrcArr[i];
						  }
					}
					
					// 判断是否选中元素
					if(idsArr.length == 0){
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
					}
					
					for(var i=0;i < idsArr.length;i++){
						  if(idsArr[i].checked){
						  	if(str=='') str += idsArr[i].value;
						  	else str += ',' + idsArr[i].value;
						  }
					}
					
					
					
					if(msg == '确定要删除选中的数据吗?'){
						top.jzts();
						$.ajax({
							type: "POST",
							url: '<%=basePath%>shipping/operaShipping',
							//beforeSend: validateData,
                            data: {ids:str,doAction:3},
							cache: false,
							success: function(){
								setTimeout("self.location=self.location",100);
							}
						});
					}
				}
			});
		}
		</script>
		
	</body>
</html>

