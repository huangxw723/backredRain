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
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>餐饮</title>
<base href="<%=basePath%>">
<meta name="description" content="overview & stats" />


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

<style>
    *{margin: 0;padding: 0;}
    .sub_div{width: 100%;float: left;text-align: center;margin-top: 20px}
    .clearfix:before, .clearfix:after {content: " ";display: table;}
    .clearfix:after {clear: both;}
    .cate{width: 1600px;padding: 10px;border: 0px solid #ccc;float: left;}
    .cate_detailed{
    	width: 300px;height: 265px;float: left;position: relative;margin: 0 5px 5px 0;
    	border: 1px solid rgba(239, 221, 112, 0.69);
    	padding-left: 5px;
    	padding-top: 5px;
    	padding-right: 5px;
    	background-color: rgba(226, 234, 241, 0.63);
    }
    .cate_detailed:nth-child(4n+0){margin-right: 0}
    .cate_detailed img{width: 100%;height: 100%;}
    .cate_detailed > input{position: absolute;background: #FFFF99;border: 1px solid #ccc;width: 45px;height: 20px;border-radius: 5px;}
    .seat{height: 35px;background: rgba(27, 22, 22, 0.61);position: relative;bottom: 35px;color:#FFF;}
    .seat p{text-align: center;}
    .head_portrait{float: left;margin: 2px 5px;}
    .head_portrait img{width: 40px;height: 40px;display: block;}
    .introduce{padding-top: 5px;}
    .introduce h3{font-size: 14px}
    .introduce p{font-size: 20px;}
    .seat_nav{float: left;padding-top: 13px;}
    .seat_nav input{width: 60px;height: 20px;background: #FFFF99;border: 1px solid #ccc;border-radius: 15px;}
    
    .pagination span{
    	width: 18px;
    	height: 18px
    }
    .page_div{width: 100%;float: left;text-align: center;margin-top: 20px}
    .img_detail{
    	margin-top: 5px;
    }
    .img_detail span,p{
    	font-family: "微软雅黑";
    }
  </style>
<script type="text/javascript" src="static/js/jquery-1.7.2.js"></script>
<script src="static/js/bootstrap.min.js"></script>
<script src="static/js/angular.min.js"></script>
<script src="static/template/js/swiper.js"></script>
<script type="text/javascript" src="plugins/zTree/3.5/jquery.ztree.core.min.js"></script>
<script type="text/javascript" src="plugins/zTree/3.5/jquery.ztree.excheck.min.js"></script>
<script type="text/javascript" src="static/js/bootbox.min.js"></script><!-- 确认窗口 -->
<!-- <link type="text/css" rel="stylesheet" href="plugins/zTree/3.5/demo.css" /> -->
<link type="text/css" rel="stylesheet" href="plugins/zTree/3.5/zTreeStyle.css" />

</head>
<body>
	<div class="widget-main">
		<form id="searchForm" class="form-inline" action="yp/admin/template/getImageSources">
				<input type="hidden" name="currentPage" value="${currentPage}">
				<select name="templateTypeId">
					<option value="">全部</option>
					<c:forEach items="${templateTypes}" var="type">
						<option ${templateTypeId==type.templateTypeId?'selected':'' } value="${type.templateTypeId }">${type.typeName}</option>
					</c:forEach>
				</select>
				<input type="text" name="imageName" value="${imageName}" class="input-small" placeholder="请输素材名称">
				<button onclick="search();" class="btn btn-info btn-small">查询</button>
		</form>
	</div>
	<div class="cate clearfix">
		<c:forEach items="${images}" var="img">
			<div class="cate_detailed">
				<input type="button" onclick="edit(${img.imageSourceId})" value="编辑">
				<div style="height: 200px">
					<img alt="" src="<%=httpUrl%>${img.imageUrl}">
					<div class="seat">
						
						<div class="introduce">
							<p>
								分辨率:<span>${img.width }*${img.height }</span>
							</p>
						</div>
					</div>
				</div>
				<div class="img_detail" style="margin-top: 5px">
					<p>${img.imageName }</p>
					<span>时间：${img.createTime }</span>
				</div>
			</div>
		</c:forEach>
	</div>
	<table style="width: 100%;margin-left: 8px">
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
	
</body>
<script type="text/javascript">
	var basePath = "<%=basePath%>yp/admin/template/";
	function add(){
		createDialog(basePath+"toAddImageSource","添加图片",800,500);
	}
	
	function edit(imageSourceId){
		createDialog(basePath+"toEditImageSource?imageSourceId="+imageSourceId,"编辑图片",800,500);
	}
	
	function createDialog(url,title,width,height){
		 top.jzts();
		 var diag = new top.Dialog();
		 diag.Drag=true;
		 diag.Title =title;
		 diag.URL = url;
		 diag.Width = width;
		 diag.Height = height;
		 diag.CancelEvent = function(flag){ //关闭事件
			if(flag){
				history.go(0);
			}
			diag.close();
		 };
		 diag.show();
	}
	function search(){
		$("#searchForm").submit();
	} 
</script>
</html>