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
	
			<!-- 检索  -->
			<form action="ownActivity/toGift" method="post" name="usersForm" id="usersForm">
			<input type="hidden" name="status" value="${status}" id="status">
			<input type="hidden" name="totalResult" value="2" >
				<table>
					<tr>
								<td>
								<span class="input-icon"> 
									<input autocomplete="off" id="nav-search-input" type="text" name="keyWord" value="${keyWord}" placeholder="礼品编号/礼品名称" style="width:220px;"/>
										<i  class="icon-search"></i>
								</span>
								</td>
								<td style="vertical-align: top;">
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
						<th class="cBox" style="width: 30px;text-align:center;">
                            <label>
                                <input type="checkbox" id="zcheckbox"  />
                                <span class="lbl"></span>
                            </label>
                        </th>
						<th style="text-align:center;">礼品编号</th>
						<th style="text-align:center;">礼品名称</th>
						<th style="text-align:center;">礼品类型</th>
						<th style="text-align:center;">商户名称</th>
						<th style="text-align:center;">额度</th>
						<th style="text-align:center;">礼品数量(余/总)</th>
						<th style="text-align:center;">使用时间</th>
						<th style="text-align:center;">有效时间</th>
						<th style="text-align:center;">操作</th>
					</tr>
				</thead>
										
				<tbody>
				<!-- 开始循环 -->	
				<c:choose>
					<c:when test="${not empty list}">
						<c:forEach items="${list}" var="var" varStatus="vs">
							<tr>
								<td class='cBox' style="width: 30px;text-align:center;">
                                        <label>
                                            <input type='checkbox' name='ids' value="${var.prizeConfigId}" names="${var.name }" />                                           
                                            <span class="lbl"></span>
                                        </label>
                                </td>
								<td class='center' style="text-align:center;">${var.sn}</td>
								<td class='center' style="text-align:center;">${var.name}</td>
								<td class='center' style="text-align:center;">${var.asYpBaseCategory.name}</td>
								<td class='center' style="text-align:center;">${var.shopName}</td>
								<td class='center' style="text-align:center;">${var.price}</td>
								<td class='center' style="text-align:center;">${var.surplusCounts}/${var.counts}</td>
								<td class='center' style="text-align:center;">${var.startTime}/${var.endTime}</td>
								<td class='center' style="text-align:center;">${var.activeTime}/${var.inactiveTime}</td>
								
								<td class='center' style="text-align:center;">
										<a href="javascript:void(0);" class="btn btn-mini btn-primary" onclick="add(${var.prizeConfigId},'${var.name}',${status})">添加</a>
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
		                                <a class="btn btn-small btn-success " onclick="onAdd()"<c:if test="${status == 1}">style="display: none;"</c:if>>批量添加</a>
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
		<link rel="stylesheet" type="text/css" href="plugins/fancyBox/jquery.fancybox.css">
		<script type="text/javascript" src="plugins/fancyBox/jquery.fancybox.pack.js"></script>

		<script type="text/javascript">
		
		jQuery(document).ready(function(){
			
			//判断用户是否是批量添加
			var status = document.getElementById("status").getAttribute("value");
			if(status == 1){
				$('.cBox').css("display","none");
			}

			
		});
		
		</script>

		<script type="text/javascript">
		
		//检索
		function search(){
			top.jzts();
			
			$("#usersForm").submit();
		}
		

		//添加	
		function add(prizeConfigId,name,status){
			if (status == 1) {
				top.Dialog.showPrize(prizeConfigId,name);
			}else{
				var id = prizeConfigId+'';
				top.Dialog.showPrizes(id,name);
			}
			top.Dialog.close();
		}
		
		
		//批量添加
		function onAdd(){
		   var ids = '';
           var names = '';
		   
              for(var i=0;i < document.getElementsByName('ids').length;i++)
              {
             
                  if(document.getElementsByName('ids')[i].checked){
                      if(ids=='') ids += document.getElementsByName('ids')[i].value;
                      else ids += ',' + document.getElementsByName('ids')[i].value;
                      
                      if(names=='') names += document.getElementsByName('ids')[i].getAttribute('names');
                      else names += ',' + document.getElementsByName('ids')[i].getAttribute('names');
                  }
              }
              
              if(ids==''){
                 /*  bootbox.dialog("您没有选择任何内容!",
                          [
                              {
                                  "label" : "关闭",
                                  "class" : "btn-small btn-success",
                                  "callback": function() {
                                      //Example.show("great success");
                                  }
                              }
                          ]
                  ); */

                  $("#zcheckbox").tips({
                      side:3,
                      msg:'点这里全选',
                      bg:'#AE81FF',
                      time:8
                  });

                  return;
              }
			
            top.Dialog.showPrizes(ids,names);
  			top.Dialog.close();
              
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
		
		</script>
		
	</body>
</html>

