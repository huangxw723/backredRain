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
		<meta charset="utf-8" />
		<title></title>
		<meta name="description" content="overview & stats" />
		<meta name="viewport" content="width=device-width, initial-scale=1.0" />
		<link href="static/css/bootstrap.min.css" rel="stylesheet" />
		<link href="static/css/bootstrap-responsive.min.css" rel="stylesheet" />
		<link rel="stylesheet" href="static/css/font-awesome.min.css" />
		<!-- 下拉框 -->
		<link rel="stylesheet" href="static/css/chosen.css" />
		<link rel="stylesheet" href="static/css/ace.min.css" />
		<link rel="stylesheet" href="static/css/ace-responsive.min.css" />
		<link rel="stylesheet" href="static/css/ace-skins.min.css" />
		<script type="text/javascript" src="static/js/jquery-1.7.2.js"></script>
		<!--引入弹窗组件start-->
		<script type="text/javascript" src="plugins/attention/zDialog/zDrag.js"></script>
		<script type="text/javascript" src="plugins/attention/zDialog/zDialog.js"></script>
		<!--引入弹窗组件end-->
		<!--提示框-->
		<script type="text/javascript" src="static/js/jquery.tips.js"></script>
		<script type="text/javascript" src="static/js/common/commonutils.js"></script>
		
  		
<script type="text/javascript">

</script>
	</head>
<body>

<form action="" name="" id="" method="post">
	<input type="hidden" name="prizeConfigId" id="prizeConfigId" value=""/>	
	<input type="hidden" name="auditStatus" id="auditStatus" value=""/>
	<div id="zhongxin">
	<table id="table_report" class="table table-striped table-hover" style="overflow:scroll;">
	     <div><h4>审批详情</h4> 审批编号: ${asPrizeConfig.prizeConfigId}</div>
	     </br>
		 <tr height="45px" >
			<td  >商户编号:</td>
			<td  ><input  style=" border:0;width:370px" disabled="disabled"  type="text" name="shopId" id="shopId" value="${asPrizeConfig.shopId}" style="width: 370px" />
		 </td>
		 		 
		</tr>
		<tr height="45px">
			<td>商户名称：</td>
			<td><input  style=" border:0;width:370px" disabled="disabled"  type="text" name="shopName" id="shopName" value="${asPrizeConfig.shopName}" style="width: 370px" /></td>
			 
		</tr>
		<tr height="45px">
			<td>商户地址：</td>
			<td><input  style=" border:0;width:370px" disabled="disabled"  type="text" name="address" id="address" value="${asPrizeConfig.address}" style="width: 370px" /></td>
			 
		</tr>
	
		<tr height="45px">
		    <td>所属活动：</td>
			<td>
			<c:if test="${asPrizeConfig.activityType eq 1}"><input  style="border:0;width:370px" type="text" disabled="disabled" name="TypeName" id="TypeName" value="大转盘" style="width: 370px" /></c:if>
			<c:if test="${asPrizeConfig.activityType eq 2}"><input  style="border:0;width:370px" type="text" disabled="disabled" name="TypeName" id="TypeName" value="摇一摇" style="width: 370px" /></c:if>
			<c:if test="${asPrizeConfig.activityType eq 3}"><input  style="border:0;width:370px" type="text" disabled="disabled" name="TypeName" id="TypeName" value="优惠劵" style="width: 370px" /></c:if>
			</td>
		</tr>
		
			<tr height="45px">
		    <td>礼品类型：</td>
	<td><input  style=" border:0;width:370px" disabled="disabled"  type="text" name="prizeTypeName" id="prizeTypeName" value="${asPrizeConfig.prizeTypeName}" style="width: 370px" /></td>
		</tr>
		
		<tr height="45px">
		    
			<td>礼品编号：</td>
			<td><input  style=" border:0;width:370px"  type="text" disabled="disabled" name="sn" id="sn" value="${asPrizeConfig.sn}" style="width: 370px" /></td>
			
		</tr><tr height="45px">

			<td>礼品名称：</td>
			<td><input  style=" border:0;width:370px"  type="text" disabled="disabled" name="name" id="name" value="${asPrizeConfig.name}" style="width: 370px" /></td>

		</tr>
		<tr height="45px">
			<td>发放的数量：</td>
			<td>
			<input  style=" border:0;width:370px" disabled="disabled"  type="text" name="surplusCounts" id="surplusCounts" value="${asPrizeConfig.surplusCounts}" style="width: 370px" />
		</tr>	
		
		<tr height="45px">
			<c:if test="${'折扣券' eq asPrizeConfig.prizeTypeName}">
				<td id="td3">折扣力度:</td>
				<td id="td4"><input disabled="disabled"type="text"  value="${asPrizeConfig.price}" style="width: 370px" />折</td>
			</c:if>
			<c:if test="${'代金券' eq asPrizeConfig.prizeTypeName}">
				<td id="td3">优惠额度:</td>
				<td id="td4"><input disabled="disabled" type="text"  value="${asPrizeConfig.price}" style="width: 370px" />元</td>
			</c:if>
			<c:if test="${'礼品券' eq asPrizeConfig.prizeTypeName}">
				<td id="td3">礼品:</td>
				<td id="td4"><input disabled="disabled" type="text"  value="${asPrizeConfig.price}" style="width: 370px" /></td>
			</c:if>
			<c:if test="${'现金红包' eq asPrizeConfig.prizeTypeName}">
				<td id="td3">现金额度:</td>
				<td id="td4"><input disabled="disabled" type="text"value="${asPrizeConfig.price}" style="width: 370px" />元</td>
			</c:if>
			<c:if test="${'积分' eq asPrizeConfig.prizeTypeName}">
				<td id="td3">积分值:</td>
				<td id="td4"><input disabled="disabled" type="text"value="${asPrizeConfig.price}" style="width: 370px" />点</td>
			</c:if>
			<c:if test="${'实物礼品' eq asPrizeConfig.prizeTypeName}">
				<td id="td3">实物礼品:</td>
				<td id="td4"><input disabled="disabled" type="text"value="${asPrizeConfig.price}" style="width: 370px" /></td>
			</c:if>

		</tr>
		<c:if test="${pd.categoryId != 4}">
			<tr height="45px">
			    <td>使用时间：</td>
				<td ><input  style=" border:0;width:370px"  type="text" disabled="disabled" name="startAndEndTime" id="startAndEndTime" value="${asPrizeConfig.startTime}~${asPrizeConfig.endTime}"  /></td>
				 
			</tr>
		</c:if>
		<tr height="45px">
			<td>有效时间：</td>
			<td ><input  style=" border:0;width:370px"  type="text" disabled="disabled"  value="${asPrizeConfig.activeTime}~${asPrizeConfig.inactiveTime}"  /></td>
		</tr>
		<c:if test="${asPrizeConfig.activityType ne 3}">
		<tr height="45px">
		    <td>礼品logo：</td>
			<td> 
				<a class="fancybox" href="<%=httpUrl%>${asPrizeConfig.logoUrl}">
	                <img src="<%=httpUrl%>${asPrizeConfig.logoUrl}" alt="${asPrizeConfig.logoUrl}" width="80px" height="45px" />
	            </a>
			<c:if test="${asPrizeConfig.activityType eq 3}">
					<c:if test="${not empty asPrizeConfig.backUrl}" >
					 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				 	背景图片：
					<a class="fancybox" href="<%=httpUrl%>${asPrizeConfig.backUrl}">
		                <img src="<%=httpUrl%>${asPrizeConfig.backUrl}" alt="${asPrizeConfig.backUrl}" width="80px" height="45px"  />
		            </a>
	            </c:if>
			</c:if>
			</td>
		</tr>
		 </c:if>
		<tr height="45px">		   
			<td>简介描述：</td>
			<td>
			 <textarea style="height:90px;width:370px" disabled="disabled" name="descp" id="descp">${asPrizeConfig.descp}</textarea>
			</td>
			
		</tr>
			
	<%-- 	<tr height="100px">
			<td>审批理由:</td>
			<td colspan="3">
				 <textarea style="width:80%;height:200px"  name="reason" id="reason">${pd.reason}</textarea>
			
			</td>
		</tr> --%>
        
		<tr>
          <td colspan="8" style="height: 30px;"> 
               <div style="text-align: center;">
				<a class="btn btn-mini btn-danger"  href="prizeconfig/listAuditHistory" style="width: 90px; height: 34px; line-height:34px">返回</a>
				</div>
			</td>
			
		</tr>
	
	</table>
	
	
	
	
	</div>
	
	<div style="position: absolute; left: 715px; top: 100px; width: 200px; height: 317px;">
	审批理由：
	 <textarea style="width:220%;height:200px"  disabled="disabled" name="reason" id="reason">${asPrizeConfig.reason}</textarea>
  </div>
		
	<div style="position: absolute; left: 800px; top: 437px; width: 710px; height: 154px;">
			<c:if test="${asPrizeConfig.auditStatus == 1}">
					<img alt="" src="static/img/prizeConfigyes.png">
			</c:if>
			<c:if test="${asPrizeConfig.auditStatus == 2}">
					<img alt="" src="static/img/prizeConfigpas.png">
			</c:if>
	
	</div>
	
	
	<div id="zhongxin2" class="center" style="display:none">
      <br />
      <br />
      <br />
      <br />
      <br />
      <img src="static/images/jiazai.gif" />
      <br />
      <h4 class="lighter block green">提交中...</h4>
  </div>
    
</form>

	<!-- 引入 -->
	<script type="text/javascript">window.jQuery || document.write("<script src='static/js/jquery-1.9.1.min.js'>\x3C/script>");</script>
	<script src="static/js/bootstrap.min.js"></script>
	<script src="static/js/ace-elements.min.js"></script>
	<script src="static/js/ace.min.js"></script>
	<script type="text/javascript" src="static/js/chosen.jquery.min.js"></script><!-- 下拉框 -->
	<script type="text/javascript" src="static/js/bootbox.min.js"></script><!-- 确认窗口 -->
		
	<script type="text/javascript" src="static/js/base64.js"></script>
	<!-- 压缩图片 -->

	<link rel="stylesheet" type="text/css" href="plugins/fancyBox/jquery.fancybox.css">
	<script type="text/javascript" src="plugins/fancyBox/jquery.fancybox.pack.js"></script>
	<!-- 查看图片 -->
	<script type="text/javascript" src="static/js/chosen.jquery.min.js"></script><!-- 下拉框 -->
	<script type="text/javascript">
	$(function() {

		$(".fancybox").fancybox({
            helpers: {
                title: {
                    type: 'inside'
                }
            }
        });
		
	});
	
  </script>



</body>
</html>