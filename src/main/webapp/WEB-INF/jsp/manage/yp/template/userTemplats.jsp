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
	<style type="text/css">
			li{
				float: left;
				list-style: none;
				display: block;
				text-align: center;
			}
			a{
				display: block;
			}
		</style>
</head> 
<body>
		
<div class="container-fluid" id="main-container">


<div id="page-content" class="clearfix">
						
  <div class="row-fluid">


	<div class="row-fluid">
			<div style="display: block;height: 600px">
				<ul>
					<c:forEach items="${userTemplates}" var="t">
						<li>
							<img alt="" src="static/template/images/${t.preview}.png">
							<a href="javascript:void(0);" onclick="edit(${t.userTemplateId})">编辑(${t.name})</a>
						</li>
					</c:forEach>
				</ul>
			</div>
		
			
			<div class="page-header position-relative">
							<table style="width: 100%;">
								<tr>
									<td style="vertical-align:top;">
										<a class="btn btn-small btn-success" onclick="add();">新增</a>
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
			$("#userForm").submit();
		}
		
		//新增
		function add(){
			 location.href='<%=basePath%>yp/admin/template/templateSelect.do';
		}
		//编辑
		function edit(userTemplateId){
			 <%-- top.mainFrame.tab.add( {
	  				id :new Date().getTime(),
	  				title :"编辑模版",
	  				url :'<%=basePath%>yp/admin/template/toEditUserTemplate.do?userTemplateId='+userTemplateId,
	  				isClosed :true
	  			}); --%>
			 location.href='<%=basePath%>yp/admin/template/toEditUserTemplate.do?userTemplateId='+userTemplateId;
		}
		
		//删除
		function deleteTag(tagId,name){
			if(confirm("确定删除标签"+name+"吗?")){
				$.ajax({
					type: "POST",
					url: '<%=basePath%>coupon/deleteTag.do',
			    	data: {tagId:tagId},
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
		}
		function select(userTemplateId){
			top.mainFrame.tab.add( {
  				id :'selectTemplate',
  				title :"选择模版",
  				url :'<%=basePath%>yp/admin/template/selectTemplate.do?userTemplateId='+userTemplateId,
  				isClosed :true
  			});
		}
		
		</script>
		
		<script type="text/javascript">
		
		$(function() {
			
			//日期框
			$('.date-picker').datepicker();
			
		});
		
		
		
		</script>
		
	</body>
</html>

