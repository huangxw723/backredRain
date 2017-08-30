<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.aoshi.util.PropertyUtils"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
	String httpUrl = PropertyUtils.getHTTP_URL();
%>
<html lang="en">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>盛大招商</title>
<base href="<%=basePath%>">
<meta name="description" content="overview & stats" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<!-- 
<link href="static/template/css/style.css" rel="stylesheet" type="text/css" />
    <link href="static/template/css/sub.css" rel="stylesheet" type="text/css" />
<link href="static/template/css/pgwslider.min.css" rel="stylesheet"> -->
<link href="static/template/css/sub.css" rel="stylesheet" type="text/css" />
<style>
     *{margin: 0;padding: 0;}
     .sub_div{width: 100%;float: left;text-align: center;margin-top: 20px}
     .clearfix:before, .clearfix:after {content: " ";display: table;}
     .clearfix:after {clear: both;}
     .investment{}
     .detailed{width: 625px;height: 300px;border: 1px solid #ccc;padding: 5px;float: left;margin: 0 10px 10px 0;}
     .detailed:nth-child(2n+0){margin-right: 0}
     .detailed_left{float: left;width: 75%;height: 100%;position: relative;}
     .detailed_left img{width: 99%;height: 100%;display: block;}
     .input_box{position: absolute;width: 99%;bottom: 0;left: 0;background: #66FFFF;}
     .input_type{font-size: 12px;width: 50%;float: left;}
     .input_type input,.input_type select{width: 50%;}
     .detailed_right{float: right;width: 25%;height: 100%;}
     .edit{height: 33%;position: relative;margin-bottom: 1px;}
     .edit input{width: 45px;height: 20px;border-radius: 5px;position: absolute;top: 0;background: #FFFF99;border: 1px solid #ccc;}
     .detailed_right img{width: 100%;height: 100%;display: block;}
</style>
<script type="text/javascript" src="static/js/jquery-1.7.2.js"></script>
<script src="static/js/bootstrap.min.js"></script>
<script src="static/js/angular.min.js"></script>
	<script type="text/javascript" src="plugins/zTree/3.5/jquery.ztree.core.min.js"></script>
	<script type="text/javascript" src="plugins/zTree/3.5/jquery.ztree.excheck.min.js"></script>
	<script type="text/javascript" src="static/js/bootbox.min.js"></script><!-- 确认窗口 -->
	<!-- <link type="text/css" rel="stylesheet" href="plugins/zTree/3.5/demo.css" /> -->
  	<link type="text/css" rel="stylesheet" href="plugins/zTree/3.5/zTreeStyle.css" />
  		
</head>
<body>
	<span><%=basePath%>yp/admin/template/toEditBusinessTemplate.do?businessTemplateId=${defaultId}</span>
	<iframe name="template" src=""></iframe>
	
	<div>
		<ul>
		<c:if test="${not empty templates}">
			<c:forEach items="${templates}" var="t">
				<li style="float: right;">
					<a target="template" href="yp/admin/template/toEditBusinessTemplate.do?businessTemplateId=${t.businessTemplateId }">${t.templateName }</a>
				</li>
			</c:forEach>
		</c:if>
		</ul>
	</div>
</body>
	
<script type="text/javascript">

</script>
</html>