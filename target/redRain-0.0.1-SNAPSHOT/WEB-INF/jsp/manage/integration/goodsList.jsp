<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.aoshi.util.PropertyUtils"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
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
			<!-- 检索  -->
			<form action="<%=basePath%>goods/getGoodsList.do" method="post" name="" id="">
				<input type="hidden" name="currentPage" id="currentPage" value="${page.currentPage}"/>
				<input type="hidden" name="showCount" id="showCount" value="${page.showCount}"/>
				<table>
							<tr>
								<td>
									商品名称:
									<span class="input-icon"> <input
											autocomplete="off" id="nav-search-input" type="text"
											name="keyword" value="${keyword }" placeholder="这里输入关键词" style="width:200px;"/>
											<i class="icon-search"></i>
									</span>
									<span class="input-icon">&nbsp;&nbsp;&nbsp;积分: <input
											autocomplete="off" id="nav-search-input" type="number" min="0"
											name="sSalesPrice" value="${sSalesPrice }"   style="width:100px;"/>
									</span>
									<span class="input-icon">至<input
											autocomplete="off" id="nav-search-input" type="number" min="0"
											name="eSalesPrice" value="${eSalesPrice }"   style="width:100px;"/>
									</span>
								</td>
								<td style="vertical-align: top;">
									<button class="btn btn-mini btn-light" onclick="search();"
										title="检索">
										<i id="nav-search-icon" class="icon-search"></i>
									</button>
								</td>
								<td style="vertical-align: top;">
										&nbsp;
									 <a class="btn btn-small btn-success" onclick="add();">新增</a>
								</td>
							</tr>
						</table>		
			</form>
			<!-- 检索  -->
			<table id="table_report" class="table table-striped table-bordered table-hover">
				<thead>
					<tr>
						<th class="center">
						<label><input type="checkbox" id="zcheckbox" /><span class="lbl"></span></label>
						</th>
						<th class="center">序号</th>
						<th style="text-align:center;">商品名称</th>
						<th style="text-align:center;">主图</th>
						<th style="text-align:center;">积分</th>
						<th style="text-align:center;">市场价</th>
						<th style="text-align:center;">总库存</th>
						<th style="text-align:center;">操作</th>
					</tr>
				</thead>
				<tbody>
				<!-- 开始循环 -->	
				<c:choose>
					<c:when test="${not empty list}">
						<c:forEach items="${list}" var="goods" varStatus="vs">
							<tr>
								<td class='center' style="width: 30px;">
									<label><input type='checkbox' name='goodsId' id="goodsId" value="${goods.goodsId}" /><span class="lbl"></span></label>
								</td>
								<td class='center' style="width: 30px;">${vs.index+1}</td>
								<td class='center' style="text-align:center;">${goods.goodsName}</td>
								<td class='center' style="text-align:center;">
								<a class="fancybox" href="<%=httpUrl%>${goods.goodsImg}">
										<img src="<%=httpUrl%>${goods.goodsImg}" width="30px" height="30px" >
									</a>
								</td>
								<td class='center' style="text-align:center;">${goods.salesPrice}</td>
								<td class='center' style="text-align:center;">${goods.marketPrice}</td>
								<td class='center' style="text-align:center;">${goods.goodsStore}</td>
								<td class='center'   style="text-align:center;">
									<a href="javascript:void(0);" onclick="reviewAttr(${goods.goodsId})">查看属性</a>
									<a href="javascript:void(0);" onclick="editAttr(${goods.goodsId})">编辑属性</a>
									<a href="javascript:void(0);" onclick="editStore(${goods.goodsId})">库存管理</a>
									<a href="javascript:void(0);" onclick="editImgs(${goods.goodsId})">编辑商品图</a>
									<a href="javascript:void(0);" onclick="editThumbs(${goods.goodsId})">编辑主图(属性图)</a>
									<a href="javascript:void(0);" onclick="edit(${goods.goodsId})">编辑</a>
									<a href="javascript:void(0);" onclick="deleteGoods(${goods.goodsId},'${goods.goodsName}')">删除</a>
								</td>
							</tr>
						</c:forEach>
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
									<td style="vertical-align:top;">
										<a class="btn btn-small btn-danger" onclick="makeAll('确定要删除选中的数据吗?');" title="批量删除" ><i class='icon-trash'></i></a>
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
		<script type="text/javascript" src="static/js/bootbox.min.js"></script><!-- 确认窗口 -->
		<!-- 引入 -->
		<script type="text/javascript" src="static/js/jquery.tips.js"></script><!--提示框-->
		
		<link rel="stylesheet" type="text/css" href="plugins/fancyBox/jquery.fancybox.css">
		<script type="text/javascript" src="plugins/fancyBox/jquery.fancybox.pack.js"></script>
		<script type="text/javascript">
		
				$(top.hangge());
				//检索
				function search(){
					top.jzts();
					$("form")[0].submit();
				}
				
				function add(){
		  			top.jzts();
					 var diag = new top.Dialog();
					 diag.Drag=true;
					 diag.Title ="新增商品";
					 diag.URL = '<%=basePath%>goods/toAdd.do';
					 diag.Width = 1024;
					 diag.Height = 800;
					 diag.CancelEvent = function(){ //关闭事件
						 /* if(diag.innerFrame.contentWindow.document.getElementById('zhongxin').style.display == 'none'){
							nextPage(${page.currentPage});
						} */
						history.go(0);
						diag.close();
					 };
					 diag.show();
				}
				function edit(goodsId){
					top.jzts();
					 var diag = new top.Dialog();
					 diag.Drag=true;
					 diag.Title ="编辑商品";
					 diag.URL = '<%=basePath%>goods/toEditGoods.do?goodsId='+goodsId;
					 diag.Width = 1024;
					 diag.Height = 800;
					 diag.CancelEvent = function(){ //关闭事件
						 /* if(diag.innerFrame.contentWindow.document.getElementById('zhongxin').style.display == 'none'){
							nextPage(${page.currentPage});toEditAttrImage
						} */
						history.go(0);
						diag.close();
					 };
					 diag.show();
				}
				function editImgs(goodsId){
					top.mainFrame.tab.add( {
		  				id :goodsId,
		  				title :"编辑商品图片",
		  				url :'<%=basePath%>goods/toEditImage.do?goodsId='+goodsId,
		  				isClosed :true
		  			});
				}
				function editThumbs(goodsId){
					top.mainFrame.tab.add( {
		  				id :goodsId+100000,
		  				title :"主图(属性图)",
		  				url :'<%=basePath%>goods/toEditAttrImage.do?goodsId='+goodsId,
		  				isClosed :true
		  			});
				}
				function editAttr(goodsId){
					<%-- top.mainFrame.tab.add( {
		  				id :'editGoodsAttr',
		  				title :"编辑商品属性",
		  				url :'<%=basePath%>goods/editGoodsAttr.do?goodsId='+goodsId,
		  				isClosed :true
		  			}); --%>
					top.jzts();
					 var diag = new top.Dialog();
					 diag.Drag=true;
					 diag.Title ="编辑商品属性";
					 diag.URL = '<%=basePath%>goods/editGoodsAttr.do?goodsId='+goodsId;
					 diag.Width = 1024;
					 diag.Height = 800;
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
				
				function editStore(goodsId){
					top.jzts();
					 var diag = new top.Dialog();
					 diag.Drag=true;
					 diag.Title ="库存管理";
					 diag.URL = '<%=basePath%>goods/editGoodsStore.do?goodsId='+goodsId;
					 diag.Width = 1024;
					 diag.Height = 800;
					 diag.closeAndRefresh = function(){
						 diag.close();
						 history.go(0);
					 }
					 diag.CancelEvent = function(){ //关闭事件
						history.go(0);
						diag.close();
					 };
					 diag.show();
				}
				
				function reviewAttr(goodsId){
					top.jzts();
					 var diag = new top.Dialog();
					 diag.Drag=true;
					 diag.Title ="查看商品属性";
					 diag.URL = '<%=basePath%>goods/reviewGoodsAttr.do?goodsId='+goodsId;
					 diag.Width = 600;
					 diag.Height = 400;
					 diag.closeAndRefresh = function(){
						 diag.close();
						 history.go(0);
					 }
					 diag.CancelEvent = function(){ //关闭事件
						 /* if(diag.innerFrame.contentWindow.document.getElementById('zhongxin').style.display == 'none'){
							nextPage(${page.currentPage});
						} */
						//history.go(0);
						diag.close();
					 };
					 diag.show();
				}
				
				
				//删除
				function deleteGoods(goodsId,goodsName){
					bootbox.confirm("确定要删除商品【"+goodsName+"】吗?", function(result) {
						if(result) {
							$.ajax({
								type: "POST",
								url: '<%=basePath%>goods/deleteGoods.do',
						    	data: {goodsId:goodsId},
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
				}
				
				//批量删除操作
				function makeAll(msg){
					bootbox.confirm(msg, function(result) {
						if(result) {
							var str = '';
							for(var i=0;i < document.getElementsByName('goodsId').length;i++)
							{
								  if(document.getElementsByName('goodsId')[i].checked){
								  	if(str=='') str += document.getElementsByName('goodsId')[i].value;
								  	else str += ',' + document.getElementsByName('goodsId')[i].value;
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
										url: '<%=basePath%>goods/deleteGoodsAlls',
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

