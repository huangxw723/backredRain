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
			<form class="form-horizontal" id="form" action="goods/updateGoods.do">
				
				<table id="table_report" class="table table-striped table-bordered table-hover">

				<thead>
					<tr>
						<th class="center">
						<label><input type="checkbox" id="zcheckbox" /><span class="lbl"></span></label>
						</th>
						<th class="center">序号</th>
						<th class="center">商品图片</th>
                        <th class="center">操作</th>

					</tr>
				</thead>

				<tbody>
<!-- 开始循环 -->
				<c:choose>
					<c:when test="${not empty goodsImgs}">
						<c:forEach items="${goodsImgs}" var="img" varStatus="i">
							<tr class="times">
								<td class='center' style="width: 30px;">
									<label><input type='checkbox' name='goodsImgsId' id="goodsImgsId" value="${img.goodsImgsId}" /><span class="lbl"></span></label>
								</td>
								<td class='center' style="width: 30px;">${i.index+1}</td>
							    <td class="center" width="300">
	                            <a class="fancybox" href="<%=httpUrl%>${img.imgUrl}">
	                              <img src="<%=httpUrl%>${img.imgUrl}" alt="" width="50px" height="50px" />
	                            </a>
	                           </td>
								<td class='center' style="width: 80px;"  >
									<a href="javascript:void(0)" onclick="edit('${img.goodsImgsId}');">修改</a>
								 	<a href="javascript:void(0)" onclick="del('${img.goodsImgsId}');">删除</a>
								</td>
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
		var goodsId = "${goodsId}";
		$(top.hangge());
		function add(){
			 top.jzts();
			 var times = $(".times");
			var len = times.length;
			if(len>=8){
				bootbox.alert("最多能添加8张商品图片");
				return;
			}
			 var diag = new top.Dialog();
			 diag.Drag=true;
			 diag.Title ="添加商品图片";
			 diag.URL = '<%=basePath%>goods/toAddGoodsImgs.do?goodsId='+goodsId+"&len="+len;
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
		 
		var len = document.getElementsByName('goodsImgsId').length;
		
		//删除
		function del(goodsImgsId){
			if(len>1){
				bootbox.confirm("确定要删除吗?", function(result) {
					if(result) {
						$.ajax({
							type: "POST",
							url: '<%=basePath%>goods/deleteImgsByGoodsImgsId.do',
					    	data: {goodsImgsId:goodsImgsId},
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
				bootbox.dialog("必须保留一张商品图片", 
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
		function edit(goodsImgsId){
			top.jzts();
			var diag = new top.Dialog();
			diag.Drag=true;
			diag.Title ="修改图片";
			diag.URL = '<%=basePath%>goods/toEditGoodsImgs.do?goodsId='+goodsId+"&goodsImgsId="+goodsImgsId;
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
							  if(document.getElementsByName('goodsImgsId')[i].checked){
							  	if(str=='') str += document.getElementsByName('goodsImgsId')[i].value;
							  	else str += ',' + document.getElementsByName('goodsImgsId')[i].value;
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
									url: '<%=basePath%>goods/deleteGoodsImgAlls',
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
				bootbox.dialog("必须保留一张商品图片", 
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