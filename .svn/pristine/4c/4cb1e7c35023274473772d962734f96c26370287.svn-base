<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.aoshi.util.PropertyUtils"%>
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
	<base href="<%=basePath%>">
	<!-- jsp文件头和头部 -->
	<%@ include file="../../system/admin/top.jsp"%>
	<meta charset="utf-8" />
  		<script type="text/javascript">
  		//选择框
  		$(function() {
			$(".chzn-select").chosen(); 
			$(".chzn-select-deselect").chosen({allow_single_deselect:true}); 
  		});
  		
  		
			
	</script>
	</head> 
<body>
	 <div id="page-content" class="clearfix" >

		<div class="row-fluid">
			<!-- PAGE CONTENT BEGINS HERE -->
			<form class="form-horizontal" id="form" action="group/updateGroup.do" method="post">
				<input type="hidden" name="groupId" value="${group.groupId}" />
				<input type="hidden" name="parentId" id="parentId" value="${group.parentId}" />
				<div class="control-group">
					<label class="control-label" >部门名称</label>
					<div class="controls">
						<input type="text" value="${group.groupName}" name="groupName" placeholder="部门名称" required>
					</div>
				</div>
				 <%-- <div class="control-group">
					<label class="control-label">所属部门</label>
					<div class="controls">
                		<ul id="tree" class="ztree" style="width: 35% ;height:auto; "></ul>
				
					</div>
				</div> --%>
				 
				 <div class="control-group">
					<label class="control-label">选择角色</label>
					<div class="controls">
						<input name="roleIds" id="roleIds" type="hidden"  value="" />
						<c:forEach  items="${roleList}" var="role">
							<label style="float: left;margin-left: 10px">
								
								<input type="checkbox" ${role.checked?'checked':''}   value="${role.roleId}" />
								<span class="lbl"> ${role.roleName}</span>
							</label>
						</c:forEach>
					</div>
				</div> 
				<div align="center" style="height:40px;">
           			 <a class="btn btn-mini btn-primary" onclick="save();">保存</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
           			 <a class="btn btn-mini btn-danger" onclick="top.Dialog.close();">取消</a>
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
	  <script type="text/javascript" src="static/js/chosen.jquery.min.js"></script>
		<script type="text/javascript" src="static/js/bootbox.min.js"></script><!-- 确认窗口 -->
		<!-- ztree -->
	 <link type="text/css" rel="stylesheet" href="plugins/zTree/3.5/demo.css" />
  	 <link type="text/css" rel="stylesheet" href="plugins/zTree/3.5/zTreeStyle.css" />
	 <script type="text/javascript" src="plugins/zTree/3.5/jquery.ztree.core.min.js"></script>
	 <script type="text/javascript" src="plugins/zTree/3.5/jquery.ztree.excheck.min.js"></script>
	  <!-- js工具类 -->
	 <script type="text/javascript" src="static/js/common/commonutils.js"></script>
	  <!--编辑器  -->
	<script type="text/javascript">
		$(top.hangge());
		var level = 0;
		
		//树的设置
		function zTreeOnClick(event,treeId,treeNode){
			$("#parentId").val(treeNode.groupId);
			level = treeNode.level;
			/* console.log(treeNode.groupId+","+treeNode.level); */
		}
		
		/* var nodeStr = '${groupList}';
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
		  }; */
		
		function save(){
			if(level>1){
				alert("目前只支持三级部门");
				return ;
			}
			var checkboxs = $("input[type=checkbox]:checked");
			var ids = "";
			$.each(checkboxs,function(value,index){
				ids=ids+$(this).val()+";";
			})
			if(ids == ""){
				alert("请选择角色");
				return ;
			}
			var roleIds = ids.substring(0,ids.length-1);
			$("#roleIds").val(roleIds);
			console.log($("#roleIds").val());
			$("#form").submit();
		}
		
		$(document).ready(function(){
				//zTreeObj = $.fn.zTree.init($("#tree"), setting, JSON.parse(nodeStr));
				//$('.date-picker').datepicker()
		});
		
		
		
		</script>
	</body>
</html>