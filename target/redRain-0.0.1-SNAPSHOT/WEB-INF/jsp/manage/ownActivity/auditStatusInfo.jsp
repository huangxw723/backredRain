<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.aoshi.util.PropertyUtils"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%> 
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
	String httpUrl = PropertyUtils.getHTTP_URL();
%>
<!DOCTYPE html>
<html lang="en">
<head>
<base href="<%=basePath%>">
<%@ include file="../../system/admin/top.jsp"%>

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
	<link rel="stylesheet" href="static/css/datepicker.css" /><!-- 日期框 -->
	<!--引入弹窗组件start-->
	<script type="text/javascript" src="plugins/attention/zDialog/zDrag.js"></script>
	<script type="text/javascript" src="plugins/attention/zDialog/zDialog.js"></script>
	<!--引入弹窗组件end-->
	<!-- 引入 图片预览功能 -->
	<link rel="stylesheet" type="text/css" href="plugins/fancyBox/jquery.fancybox.css">
	<script type="text/javascript" src="plugins/fancyBox/jquery.fancybox.pack.js"></script>
	<!--工具類->
	<script type="text/javascript" src="static/js/common/commonutils.js"></script>
	<!--引入弹窗组件end-->
	<script type="text/javascript" src="static/js/jquery.tips.js"></script>
	
	
	<style type="text/css">
	#box{
		margin-left: 20px;
		}
	.delete{
		margin-left: 15px;
	}	
	</style>

	<script type="text/javascript">
		$(top.hangge());
		//下拉框
		$(function () {
			$(".chzn-select").chosen();
			$(".chzn-select-deselect").chosen({allow_single_deselect:true});
		})
		//时间控件
		$(document).ready(function(){
			$('.date-picker').datepicker('setStartDate', new Date());
		});
	</script>
		
</head>
<body>																				
  <form action="ownActivity/updateStatus" name="form" id="form" method="post" >
  	<input type="hidden" name="ownActivityId" id="ownActivityId" value="${ownActivityId}"/>
  	<input type="hidden" name="auditStatus" id="auditStatus" value=""/>
    <div id="zhongxin">
      <table id="table_report" class="table table-striped table-bordered table-hover">

		  <tr>
			  <td  width="150px">所属商户</td>
			  <td>
				  <c:choose>
					  <c:when test="${ not empty shopAll}">
						  <select class="chzn-select"  id="shopId" disabled="disabled" style="width: 383px; vertical-align:top;" >
							  <c:forEach items="${shopAll}" var="var"  >
								  <option value="${var.shopId}" <c:if test="${var.shopId == asOwnActivity.shopId}">selected="selected"</c:if> >${var.name}</option>
							  </c:forEach>
						  </select>
					  </c:when>
					  <c:otherwise>
						  <select class="chzn-select"   id="shopId" disabled="disabled" style="width: 383px; vertical-align:top;">
							  <option value="${asShop.shopId}" <c:if test="${asShop.shopId == asOwnActivity.shopId}">selected="selected"</c:if> >${asShop.name}</option>
						  </select>
					  </c:otherwise>
				  </c:choose>
			  </td>
		  </tr>

        <tr>
        	<td>活动名称</td>
        	<td><input type="text"  id="activityName" value="${asOwnActivity.activityName}"  style="width: 370px; vertical-align:top;" disabled="disabled"></td>
        </tr>
		  <tr>
			  <td >
				  每天/每人参与次数
			  </td>
			  <td>
				  <input type="number"  id="perCount" value="${asOwnActivity.perCount}"  style="width: 370px; vertical-align:top;" disabled="disabled" style="width: 210px;">
				  <%--实际参与人数:&nbsp;<input type="number"  id="peopleNum" value="${asOwnActivity.peopleNum}" disabled="disabled" style="width: 130px;">&nbsp;&nbsp;
				  实际参与次数:&nbsp;<input type="number"   id="countNum" value="${asOwnActivity.countNum}" disabled="disabled" style="width: 130px;">--%>
			  </td>
		  </tr>
        <tr>
        	<td >活动时间</td>
    	<td>	
				开始时间:&nbsp;<input id="startTime" type='text'     id="startTime" value="${asOwnActivity.startTime}"  style="width: 160px;" class="date-picker" data-date-format="yyyy-mm-dd " readonly="readonly" disabled="disabled" >
				结束时间:&nbsp;<input id="endTime" type='text'    id="endTime" value="${asOwnActivity.endTime}"  style="width: 160px;" class="date-picker" data-date-format="yyyy-mm-dd" readonly="readonly" disabled="disabled">
		    </td>
        </tr>

      </table>
      
      <div id="box" >
        	<span style="font-size: 18px">选择礼品</span>
		  <div class="gift">
			  <c:forEach items="${asOwnActivityDiscs}" var="disc">
				  <div class="body">
					  <font style="font-size: 18px">中奖几率(%)：</font><input type="number"   class="probability " value="${disc.probability}"  placeholder="请输入中奖几率" disabled="disabled" >
					  <input type="text" class="prizeConfigId" value="${disc.prizeConfigId == 0 ?'谢谢参与' :disc.asPrizeConfig.name}" disabled="disabled">
					  &nbsp;
					  <c:if test="${disc.prizeConfigId != 0}" >
						  <a href="javascript:void(0);" onclick="preview(${disc.prizeConfigId})" >查看礼品</a>
					  </c:if>
				  </div>
			  </c:forEach>
		  </div>
      		 <div>
      		 	<tr height="100px">
					<td><font style="font-size: 18px">审批理由:</font></td>
					<td colspan="3">
					 <textarea style="width:60%;height:140px"  name="reason" id="reason" disabled="disabled">${activity.reason}</textarea>
					</td>
					<c:if test="${activity.auditStatus == 1}">
							<img alt="" src="static/img/prizeConfigyes.png">
					</c:if>
					<c:if test="${activity.auditStatus == 2}">
							<img alt="" src="static/img/prizeConfigpas.png">
					</c:if>
				</tr>
			</div>
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
<script type="text/javascript" src="static/js/bootstrap-datepicker.min.js"></script><!-- 日期框 -->
<script type="text/javascript" src="static/js/chosen.jquery.min.js"></script><!-- 下拉框 -->
<script type="text/javascript" src="static/js/bootbox.min.js"></script><!-- 确认窗口 -->

<script type="text/javascript" src="static/js/base64.js"></script>
<script type="text/javascript" src="static/js/base64Compress.js"></script>
<!-- 压缩图片 -->
<!-- 编辑框-->
<script type="text/javascript" charset="utf-8">window.UEDITOR_HOME_URL = "<%=path%>/plugins/ueditor/";</script>
<script type="text/javascript" charset="utf-8" src="plugins/ueditor/ueditor.config.js"></script>
<script type="text/javascript" charset="utf-8" src="plugins/ueditor/ueditor.all.js"></script>
<!-- 编辑框-->
<link rel="stylesheet" type="text/css" href="plugins/fancyBox/jquery.fancybox.css">
<script type="text/javascript" src="plugins/fancyBox/jquery.fancybox.pack.js"></script>
<!-- 查看图片 -->
<script type="text/javascript" src="static/js/chosen.jquery.min.js"></script><!-- 下拉框 -->

  <script type="text/javascript">

	  //查看
	  function preview(id){
		  top.jzts();
		  var diag = new top.Dialog();
		  diag.Drag=true;
		  diag.Title ="礼品详情";
		  diag.URL='<%=basePath%>ownGift/toEdit?prizeConfigId='+id+"&action=4";
		  diag.Width = 1150;
		  diag.Height = 610;
		  diag.CancelEvent = function(){ //关闭事件
			  diag.close();
		  };
		  diag.show();
	  }
  </script>

</body>
</html>