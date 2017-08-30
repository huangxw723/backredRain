<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.aoshi.util.PropertyUtils" %>
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
			<form action="yp/business/recordVisit/listAll.do" method="post" name="recordForm" id="recordForm">
				<table>
				
				<tr>
					 站点:
					<span><select name="domainId" id="domainId"
						style="width: 290px;">
							<option value="">全部</option>
							<c:forEach items="${domains}" var="var">
								<option value="${var.screenDomainId}"
									<c:if test="${var.screenDomainId ==pd.domainId }">selected="selected"</c:if>>
									${var.url }</option>
							</c:forEach>
					</select></span>
					
					开始月：
					<span><input class="span10 date-picker" name="startTime"
						id="startTime" type="text" value="${pd.startTime}"
						data-date-format="yyyy-mm-dd" readonly="readonly"
						style="width: 15%;"/> 结束月: <input
						class="span10 date-picker" name="endTime" id="endTime"
						type="text" value="${pd.endTime}" data-date-format="yyyy-mm-dd"
						readonly="readonly" style="width: 15%;"/></span>
						<button class="btn btn-mini btn-light" onclick="searchInfo();"
							title="检索">
							<i id="nav-search-icon" class="icon-search"></i>
						 </button>
					</tr>
					<br/>
					<tr>
					（注：站点在线访问时长统计，支持最多查询连续12个月的记录）
					</tr>		
				</table>		
			</form>
			<!-- 检索  -->
		
		
			<table id="table_report" class="table table-striped table-bordered table-hover">
				
			<img src="<%=basePath%>upload/bloodSugarChart.jpg" alt="ascmMall/activity/76d651d5b33047bd8eb4c371e02ee67d.jpg" width="800px" height="600px">
			</table>
			
			<div class="page-header position-relative">
							<table style="width: 100%;">
								<tr>
									
									<td style="vertical-align: top;">
										<div class="pagination"
											style="float: right; padding-top: 0px; margin-top: 0px;">${page.pageStr}</div>
									</td>
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
		<!-- 引入 图片预览功能 -->
		
		<script type="text/javascript" src="static/js/jquery.tips.js"></script><!--提示框-->
		<script type="text/javascript">
		
		$(top.hangge());
		//检索
		//检索
	    function searchInfo(){
		top.jzts();
		var sdate =$("#startTime").val();
		var edate = $("#endTime").val();
		if(sdate!==''&& edate!=''){
		if(computeDateDiff($("#startTime").val(),$("#endTime").val()))
		alert("只提供连续12个月的记录查询");
		}
		$("#recordForm").submit();
	    }
		</script>
		
		<script type="text/javascript">
		
		$(function() {
			//日期框
			$('.date-picker').datepicker();
			//下拉框
			$(".chzn-select").chosen(); 
			$(".chzn-select-deselect").chosen({allow_single_deselect:true});
			$('#startTime').datepicker({  
			    todayBtn : "linked",  
			    autoclose : true,  
			    todayHighlight : true,  
			    endDate : new Date()  
			}).on('changeDate',function(e){  
			    var startTime = e.date;  
			    $('#endTime').datepicker('setStartDate',startTime);  
			});  
			//结束时间：  
			$('#endTime').datepicker({  
			    todayBtn : "linked",  
			    autoclose : true,  
			    todayHighlight : true,   
			}).on('changeDate',function(e){  
			    var endTime = e.date;  
			    $('#startTime').datepicker('setEndDate',endTime);  
			});
		});
		function  computeDateDiff(sDate1,  sDate2){    //sDate1和sDate2是2006-12-18格式  
	       var  aDate,  oDate1,  oDate2,  iDays  
	       aDate  =  sDate1.split("-")  
	       oDate1  =  new  Date(aDate[0]  +  '-'  +  aDate[1]  +  '-'  +  aDate[2])    //转换为2016-10-10格式  
	       aDate  =  sDate2.split("-")  
	       oDate2  =  new  Date(aDate[0]  +  '-'  +  aDate[1]  +  '-'  +  aDate[2])  
	       iDays  =  parseInt(Math.abs(oDate1  -  oDate2)  /  1000  /  60  /  60  /24)    //把相差的毫秒数转换为天数  
	       var flag =true;
	       if(computeYearType()){
	    	   flag = 366-iDays >= 0?false:true;
	       }
	       if(computeYearType()){
	    	   flag = 365-iDays >= 0?false:true;
	       }
	       return  flag;  
		   } 
	    function computeYearType(){
		   var date=new Date;
		   var year=date.getFullYear(); 
		   return (year%4==0 && year%100!=0)||(year%100==0 && year%400==0);
		 }
		</script>
		
	</body>
</html>

