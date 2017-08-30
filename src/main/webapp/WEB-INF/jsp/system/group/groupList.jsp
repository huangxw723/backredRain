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
	<%@ include file="../../system/admin/top.jsp"%>
	<!-- ztree -->
	<!-- ztree -->
	<script src="static/js/bootstrap.min.js"></script>
	<script type="text/javascript" src="plugins/zTree/3.5/jquery.ztree.core.min.js"></script>
	<!-- <script type="text/javascript" src="plugins/zTree/3.5/jquery.ztree.excheck.min.js"></script> -->
	<script type="text/javascript" src="static/js/bootbox.min.js"></script><!-- 确认窗口 -->
	<link type="text/css" rel="stylesheet" href="plugins/zTree/3.5/demo.css" />
  	<link type="text/css" rel="stylesheet" href="plugins/zTree/3.5/zTreeStyle.css" />
	
	<!--引入弹窗组件end-->
</head> 
<body>

		
<div class="container-fluid" id="main-container">


<div id="page-content" class="clearfix">
	<div style="float: left;width: 10%">
		<input class="btn btn-small btn-success" type="button" onclick="addGroup()" value="新增">
		<input class="btn btn-small btn-success" type="button" onclick="editGroup()" value="编辑">
		<ul id="tree" class="ztree" style="width: 90%;height:auto; "></ul>
	</div>
	
	<div class="row-fluid" style="width: 75%;float: left;">
			<!-- 检索  -->
		<form action="<%=basePath%>group/groupList" method="post" name="usersForm" id="usersForm">
			<input type="hidden" name="currentPage" value="${currentPage}"/>
			<input type="hidden" name="showCount" value="${showCount}"/>
	<table>

       <tr>
             账户状态:<span>

             <select name="status" id="status" style="vertical-align:top;width: 90px">
             <option value="">全部</option>
             <option value="0"<c:if test="${status==0 }">selected="selected" </c:if> >启用</option>
             <option value="1"<c:if test="${status==1 }">selected="selected"</c:if>>停用</option>
             </select>
          </span>
          
		创建时间:<span>

             <input class="span10 date-picker" name="startTime" id="startTime" type="text" value="${startTime}" data-date-format="yyyy-mm-dd" style="width:15%;" placeholder=""/>
                          至 <input class="span10 date-picker" name="endTime" id="endTime" type="text" value="${endTime}" data-date-format="yyyy-mm-dd" style="width:15%;" placeholder=""/>
            </span>
        <span class="input-icon">
             	<input autocomplete="off" id="nav-search-input" type="text" name="keyWord" value="${keyWord}" style="width:250px;" placeholder="账号名称">
				<i   class="icon-search"></i>
				&nbsp;
				<%-- <a class="btn btn-small btn-success" style="vertical-align:top;" onclick="add(${type});">新增</a> --%>
			  </span>
 		<span>
 				<input type="text" name="groupName" value="${groupName}" onblur="hideTree()" onclick="showTree()" style="width:150px;" placeholder="部门">
 				<!-- <a id="menuBtn" href="#" onclick="showMenu(); return false;">选择</a> -->
 				&nbsp;
 			</span>
 			<button class="btn btn-mini btn-light" onclick="searchInfo();" style="vertical-align:top;" title="检索">
				<i id="nav-search-icon" class="icon-search"></i>
			</button>
        </tr>
     
			</table>
		</form>
			<!-- 检索  -->
		
		
			<table id="table_report" class="table table-striped table-bordered table-hover">

				<thead>
					<tr>
						<th class="center">帐号类型</th>
						<th class="center">账号名称</th>
						<th class="center">部门名称</th>
						<th class="center">创建时间</th>
                        <th class="center">操作</th>

					</tr>
				</thead>

				<tbody>

				<!-- 开始循环 -->

				
				<c:choose>
					<c:when test="${not empty list}">
						<c:forEach items="${list}" var="var" varStatus="vs">
							<tr>
								<td class="center">
							       <c:if test="${var.type == 3}">
										后台管理员
									</c:if>
									<c:if test="${var.type == 4}">
										运营管理员
									</c:if>
								</td>
								<td class="center">${var.account}</td>
								<td class="center">${var.groupName}</td>
								<td class="center">${var.createTime}</td>
								
								<td class="center">
                                        <div class="inline position-relative">
										<a href="javascript:void(0);" onclick="editAdmin(${var.userId})">编辑</a>
										<c:if test="${var.status == 0}">
											<a href="javascript:void(0);" onclick="updateUserStatus(${var.userId},1)">停用</a>
										</c:if>
										<c:if test="${var.status == 1}">
											<a href="javascript:void(0);" onclick="updateUserStatus(${var.userId},0)">启用</a>
										</c:if>
										<a href="javascript:void(0);" onclick="idelete(${var.userId})">删除</a>
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
							<table style="width: 100%;">
								<tr>
									<td style="vertical-align:top;">
										<a class="btn btn-small btn-success" onclick="addAdmin();">新增</a>
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
  <!--/row-->
	
</div><!--/#page-content-->
</div><!--/.fluid-container#main-container-->
		
		<!-- 返回顶部  -->
		<a href="#" id="btn-scroll-up" class="btn btn-small btn-inverse">
			<i class="icon-double-angle-up icon-only"></i>
		</a>
	<div id="treeDiv" style="width: 11%;position: absolute;top: 2.8%;left: 62%;display: none;">
		<ul id="searchTree" class="ztree" style="width: 90%;height:auto; "></ul>
	</div>
</body>		
		<!-- 引入 -->
		<script type="text/javascript">window.jQuery || document.write("<script src='static/js/jquery-1.9.1.min.js'>\x3C/script>");</script>
		<script src="static/js/bootstrap.min.js"></script>
		<script src="static/js/ace-elements.min.js"></script>
		<script src="static/js/ace.min.js"></script>
		
		<script type="text/javascript" src="static/js/chosen.jquery.min.js"></script><!-- 下拉框 -->
		<script type="text/javascript" src="static/js/bootstrap-datepicker.min.js"></script><!-- 日期框 -->
		<script type="text/javascript" src="static/js/bootbox.min.js"></script><!-- 确认窗口 -->
		<!-- 引入 -->
		<script type="text/javascript" src="plugins/zTree/3.5/jquery.ztree.core.min.js"></script>
	<!-- <script type="text/javascript" src="plugins/zTree/3.5/jquery.ztree.excheck.min.js"></script> -->
		
		
		<script type="text/javascript" src="static/js/jquery.tips.js"></script><!--提示框-->
		<script type="text/javascript">
		
		var editGroupId = "";
		function zTreeOnClick(event,treeId,treeNode){
			editGroupId = treeNode.groupId;
					
		}
		 /**
		  * 树的设置
		  */
		  
		  var nodeStr = '${groupList}';
		  var zTreeObj,
			setting = {
				view: {
					selectedMulti: false
				},
				callback:{
					onClick:zTreeOnClick
				},
				check:{
					enable:false,
					chkStyle:"radio",
					chkboxType:{"Y":"","N":""}
					
				},
				data:{
					key:{
						name:'groupName'
					}
				}
		  };
		
		  var searchSetting = {
					view: {
						selectedMulti: false
					},
					callback:{
						onClick:onClick
					},
					check:{
						enable:false,
						chkStyle:"radio",
						chkboxType:{"Y":"","N":""}
						
					},
					data:{
						key:{
							name:'groupName'
						}
					}
			  };
		
		//检索
		function search(){
			top.jzts();
			$("#userForm").submit();
		}
		
		//新增角色
		function addAdmin(){
			top.jzts();
			 var diag = new top.Dialog();
			 diag.Drag=true;
			 diag.Title ="新增角色";
			 diag.URL = '<%=basePath%>group/toAddAdmin.do';
			 diag.Width = 800;
			 diag.Height = 700;
			 diag.CancelEvent = function(refresh){ //关闭事件
					diag.close();
					if(refresh){
						 setTimeout("self.location=self.location",100);
					 }
				 };
			 diag.show();
		}
		
		
		//更新状态
		function updateUserStatus(id,status){
			var str = status == 0?'启用':'停用';
			if(confirm("确定"+str+"吗?")){
				$.ajax({
					type: "GET",
					url: 'account/updateStatus',
			    	data: {userId:id,status:status},
					dataType:'json',
					//beforeSend: validateData,
					cache: false,
					success: function(data){
						if(data.status != 0){
							alert(data.msg);
							return;
						}
						
						history.go(0);
					}
				});
			}
			
			
		}
		
		//删除
		function idelete(id){
			if(confirm("确定删除吗?")){
				$.ajax({
					type: "GET",
					url: 'account/delete',
			    	data: {userId:id},
					dataType:'json',
					//beforeSend: validateData,
					cache: false,
					success: function(data){
						if(data.status != 0){
							alert(data.msg);
							return;
						}
						
						history.go(0);
					}
				});
			}
			
		}
		
		function addGroup(){
			top.jzts();
			 var diag = new top.Dialog();
			 diag.Drag=true;
			 diag.Title ="新增部门";
			 diag.URL = '<%=basePath%>group/toAddGroup.do';
			 diag.Width = 700;
			 diag.Height = 500;
			 diag.CancelEvent = function(refresh){ //关闭事件
					diag.close();
					if(refresh){
						 setTimeout("self.location=self.location",100);
					 }
				};
			 diag.show();
		}
		function editGroup(){
			if(editGroupId == ""){
				alert("请选择部门");
				return ;
			}
			top.jzts();
			 var diag = new top.Dialog();
			 diag.Drag=true;
			 diag.Title ="编辑部门";
			 diag.URL = '<%=basePath%>group/toEditGroup.do?groupId='+editGroupId;
			 diag.Width = 700;
			 diag.Height = 500;
			 diag.CancelEvent = function(refresh){ //关闭事件
				diag.close();
				if(refresh){
					 setTimeout("self.location=self.location",100);
				 }
			 };
			 diag.show();
		}
		
		function editAdmin(userId){
			top.jzts();
			 var diag = new top.Dialog();
			 diag.Drag=true;
			 diag.Title ="编辑角色";
			 diag.URL = '<%=basePath%>group/toEditAdmin.do?userId='+userId;
			 diag.Width = 800;
			 diag.Height = 700;
			 diag.CancelEvent = function(refresh){ //关闭事件
					diag.close();
					if(refresh){
						 setTimeout("self.location=self.location",100);
					 }
				 };
			 diag.show();
		}
		
		function showTree(){
			$("#treeDiv").show();
		}
		function hideTree(){
			setTimeout(function(){
				$("#treeDiv").hide();
			},200)
		}
		function onClick(e, treeId, treeNode){
			console.log(treeNode.groupName);
			$("[name=groupName]").val(treeNode.groupName);
		}
		
		</script>
		
		<script type="text/javascript">
		
		$(function() {
			zTreeObj = $.fn.zTree.init($("#tree"), setting, JSON.parse(nodeStr));
			$.fn.zTree.init($("#searchTree"), searchSetting, JSON.parse(nodeStr));
			//日期框
			$('.date-picker').datepicker();
			
		});
		
		
		
		</script>
	
</html>

