<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="com.aoshi.util.PropertyUtils" %>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
	String httpUrl = PropertyUtils.getHTTP_URL();
%>
<!DOCTYPE html>
<html lang="en">
	<head>
	<base href="<%=basePath%>">
	<!-- jsp文件头和头部 -->
	<%@ include file="../../system/admin/top.jsp"%>
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
	<!--引入弹窗组件start-->
	<script type="text/javascript" src="plugins/attention/zDialog/zDrag.js"></script>
	<script type="text/javascript" src="plugins/attention/zDialog/zDialog.js"></script>
	<!--引入弹窗组件end-->
	<script type="text/javascript" src="static/js/jquery.tips.js"></script>
	</head> 
<body>
	<div id="page-content" class="clearfix">

		<div class="row-fluid">
			<!-- PAGE CONTENT BEGINS HERE -->
			<form class="form-horizontal" id="form" action="account/updateGoods.do">
				
				<table id="table_report" class="table table-striped table-bordered table-hover">

				<thead>
					<tr>
						<c:if test="${view != 4}">
							<th class="center">
								<label><input type="checkbox" id="zcheckbox" /><span class="lbl"></span></label>
							</th>
						</c:if>
						<th class="center">序号</th>
						<th class="center">商户背景图</th>
						<c:if test="${view != 4}">
							<th class="center">操作</th>
						</c:if>

					</tr>
				</thead>

				<tbody>
<!-- 开始循环 -->
				<c:choose>
					<c:when test="${not empty shopPics}">
						<c:forEach items="${shopPics}" var="img" varStatus="i">
							<tr class="times">
								<c:if test="${view != 4}">
									<td class='center' style="width: 30px;">
										<label><input type='checkbox' name='shopPicId' id="shopPicId" value="${img.shopPicId}" /><span class="lbl"></span></label>
									</td>
								</c:if>
								<td class='center' style="width: 30px;">${i.index+1}</td>
							    <td class="center" width="300">
	                            <a class="fancybox" href="<%=httpUrl%>${img.picUrl}">
	                              <img src="<%=httpUrl%>${img.picUrl}" alt="" width="50px" height="50px" />
	                            </a>
	                           </td>
								<c:if test="${view != 4}">
									<td class='center' style="width: 80px;"  >
										<a href="javascript:void(0)" onclick="edit('${img.shopPicId}');">修改</a>
										<a href="javascript:void(0)" onclick="del('${img.shopPicId}');">删除</a>
									</td>
								</c:if>
							</tr>

						</c:forEach>
						<%-- <c:if test="${QX.cha == 0 }">
							<tr>
								<td colspan="100" class="center">您无权查看</td>
							</tr>
						</c:if> --%>
					</c:when>
					<c:otherwise>
						<tr class="main_info">
							<td colspan="100" class="center" >没有相关数据</td>
						</tr>
					</c:otherwise>
				</c:choose><!-- 开始循环 -->
				</tbody>
				</table>
					<c:if test="${view != 4}">
						<div class="page-header position-relative">
							<table style="width:100%;">
								<tr>
									<td style="vertical-align:top;">
										<a class="btn btn-small btn-success" onclick="add();">新增</a>
										<a title="批量删除" class="btn btn-small btn-danger" onclick="makeAll('确定要删除选中的数据吗?');" ><i class='icon-trash'></i></a>
									</td>
								</tr>
							</table>
						</div>
					</c:if>
			</form>

		</div>
		<!-- PAGE CONTENT ENDS HERE -->
	</div><!--/row-->
	
		<!-- 引入 -->
		<script type="text/javascript">window.jQuery || document.write("<script src='static/js/jquery-1.9.1.min.js'>\x3C/script>");</script>
		<script src="static/js/bootstrap.min.js"></script>
		<script src="static/js/ace-elements.min.js"></script>
		<script src="static/js/ace.min.js"></script>
		
		<script type="text/javascript" src="static/js/chosen.jquery.min.js"></script><!-- 下拉框 -->
		<script type="text/javascript" src="static/js/bootbox.min.js"></script><!-- 确认窗口 -->
		<!-- 引入 -->
		<script type="text/javascript" src="static/js/jquery.tips.js"></script><!--提示框-->
		
		<link rel="stylesheet" type="text/css" href="plugins/fancyBox/jquery.fancybox.css">
		<script type="text/javascript" src="plugins/fancyBox/jquery.fancybox.pack.js"></script>
		<script type="text/javascript">
		var shopId = "${shopId}";
		$(top.hangge());
		function add(){
			 top.jzts();
			 var times = $(".times");
			var len = times.length;
			if(len>=3){
				bootbox.alert("最多能添加3张背景图片");
				return;
			}
			 var diag = new top.Dialog();
			 diag.Drag=true;
			 diag.Title ="添加背景图";
			 diag.URL = '<%=basePath%>account/toAddshopPics.do?shopId='+shopId+"&len="+len;
			 diag.Width = 1024;
			 diag.Height =450;
			 diag.closeAndRefresh = function(){
				 diag.close();
				 history.go(0);
			 }
			 diag.CancelEvent = function(){ //关闭事件
				 /* if(diag.innerFrame.contentWindow.document.getElementById('zhongxin').style.display == 'none'){
					nextPage(${page.currentPage});
				} */
				history.go(0);
				diag.close();
			 };
			 diag.show();
		}
		 
		var len = document.getElementsByName('shopPicId').length;
		
		//删除
		function del(shopPicId){
			if(len>1){
				bootbox.confirm("确定要删除吗?", function(result) {
					if(result) {
						$.ajax({
							type: "POST",
							url: '<%=basePath%>account/deleteShopPicImg.do',
					    	data: {shopPicId:shopPicId},
							dataType:'json',
							//beforeSend: validateData,
							cache: false,
							success: function(data){
								if(data){
									history.go(0);
								}
							}
						});
					}
				});
			}else{
				bootbox.dialog("必须保留一张背景图",
						[
						  {
							"label" : "关闭",
							"class" : "btn-small btn-success",
							"callback": function() {
								}
							}
						 ]
					);
			}
		}

		//编辑图片
		function edit(shopPicId){
			top.jzts();
			var diag = new top.Dialog();
			diag.Drag=true;
			diag.Title ="修改图片";
			diag.URL = '<%=basePath%>account/toEditShopPicImgs.do?shopId='+shopId+"&shopPicId="+shopPicId;
			diag.Width = 1024;
			diag.Height =450;
			diag.closeAndRefresh = function(){
				diag.close();
				history.go(0);
			}
			diag.CancelEvent = function(){ //关闭事件
				/* if(diag.innerFrame.contentWindow.document.getElementById('zhongxin').style.display == 'none'){
				 nextPage(${page.currentPage});
				 } */
				history.go(0);
				diag.close();
			};
			diag.show();
		}
	 
		//批量操作
		function makeAll(msg){
			var checked =  $("input[type='checkbox']:checked").length;
			var zcheckbox =  $("#zcheckbox").prop("checked");
			if(zcheckbox){
				var checked = checked - 1 ;
			}
			if(len>1 && checked != len){
				bootbox.confirm(msg, function(result) {
					if(result) {
						var str = '';
						for(var i=0;i < len;i++)
						{
							  if(document.getElementsByName('shopPicId')[i].checked){
							  	if(str=='') str += document.getElementsByName('shopPicId')[i].value;
							  	else str += ',' + document.getElementsByName('shopPicId')[i].value;
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
									url: '<%=basePath%>account/deleteShopPicImgAlls.do',
									dataType:'json',
									//beforeSend: validateData,
	                                data: {ids:str},
									cache: false,
									success: function(data){
										if(data.msg=='ok'){
											history.go(0);
	                                    }else{
											alert("删除失败！");		
	                                    }
									}
								});
							}
						}
					}
				});
			}else{
				bootbox.dialog("必须保留一张背景图",
						[
						  {
							"label" : "关闭",
							"class" : "btn-small btn-success",
							"callback": function() {
								}
							}
						 ]
					);
			}
		}
		
		$(function () {
	        $(".fancybox").fancybox({
	            helpers: {
	                title: {
	                    type: 'inside'
	                }
	            }
	        });
	    });
		</script>
		<script type="text/javascript">
		
				$(function() {
					$(".fancybox").fancybox({
			            helpers: {
			                title: {
			                    type: 'inside'
			                }
			            }
			        });
					
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
		</script>
	</body>
</html>