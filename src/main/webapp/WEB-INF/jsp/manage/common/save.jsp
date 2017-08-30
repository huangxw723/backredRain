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
		<link rel="stylesheet" href="static/css/datepicker.css" /><!-- 日期框 -->
		<!--引入弹窗组件start-->
		<script type="text/javascript" src="plugins/attention/zDialog/zDrag.js"></script>
		<script type="text/javascript" src="plugins/attention/zDialog/zDialog.js"></script>
		<!--引入弹窗组件end-->
		<!--提示框-->
		<script type="text/javascript" src="static/js/jquery.tips.js"></script>
		<script type="text/javascript" src="static/js/common/commonutils.js"></script>
		
  		
<script type="text/javascript">
	$(top.hangge());
	$(function() {
		$(".chzn-select").chosen(); 
		$(".chzn-select-deselect").chosen({allow_single_deselect:true}); 
	});
	
	//保存
	function accountStatus(id,status){
		if(status == 3){
			if($("#descp").val()==""||$.trim($("#descp").val())==""){
				$("#descp").tips({
					side:3,
		            msg:'处理理由不能为空',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#descp").focus();
				return false;
				}
		}
		$("#capitalId").val(parseInt(id));
		$("#status").val(parseInt(status))
		form.submit($('#capitalForm'));
		$("#zhongxin").hide();
		$("#zhongxin2").show();
	}

</script>
	</head>
<body>

	<form action="capital/depositStatus.do" name="capitalForm" id="capitalForm" method="post">
	<input type="hidden" name="capitalId" id="capitalId" value=""/>
	<input type="hidden" name="status" id="status" value=""/>
	<input type="hidden" name="action" id="action" value="${action }">
	<div id="zhongxin" >
	<table id="table_report" class="table table-striped table-hover" style="overflow:scroll;">
	     <div></br>申请编号: ${pd.capitalId}</br></br>申请账号: ${pd.account}</br></br> 交易流水号:${pd.tradeSn}</div>
	     </br>
		<tr>
		 <tr height="45px">
			<td>申请人:</td>
			<td><input  style="background:;border:0" disabled="disabled"  type="text" name="bankCardholder" id="bankCardholder" value="${pd.bankBindCardholder}" style="width: 370px" />
			</td>
			<td>提现银行：</td>
			<td><input  style="background:;border:0" disabled="disabled"  type="text" name="bankName" id="bankName" value="${pd.bankBindName}" style="width: 370px" /></td>
		</tr>
	
		<tr height="45px">
			<td>提现额度：</td>
			<td><input  style="background:;border:0" type="text" disabled="disabled" name="money" id="money" value="${pd.money}" style="width: 370px" /></td>
			<td>银行卡号：</td>
			<td><input  style="background:;border:0"  type="text" disabled="disabled" name="bankAccount" id="bankAccount" value="${pd.bankBindAccount}" style="width: 370px" /></td>
		</tr>
		
		<tr height="45px">
		    <td>手续费：</td>
			<td><input  style="background:;border:0" type="text" disabled="disabled" name="serviceCharge" id="serviceCharge" value="${pd.serviceCharge}" style="width: 370px" /></td>
			<td>银行卡类型：</td>
			<td><input  style="background:;border:0" type="text" disabled="disabled" name="cardType" id="cardType" value="${pd.card_type}" style="width: 370px" /></td>
		</tr>
		<tr height="100px">
			<td>处理理由:</td>
			<td colspan="3">
				 <textarea style="width:90%;height:160px" name="descp" id="descp">${pd.descp}</textarea>
			</td>
		</tr>

		<tr>
          <td colspan="8" style="height: 50px;">
			  <div style="text-align: center;">
				  <c:if test="${pd.status == 1}" >
				  <a class="btn btn-mini btn-primary" onclick="accountStatus(${pd.capitalId},2);" style="width: 90px; height: 34px; line-height:34px">已提现</a>
				  </c:if>
				  <c:if test="${pd.status == 0}" >
					  <a class="btn btn-mini btn-primary" onclick="accountStatus(${pd.capitalId},1);" style="width: 90px; height: 34px; line-height:34px">通过</a>
				  </c:if>
                 <a class="btn btn-mini btn-primary" onclick="accountStatus(${pd.capitalId},3);" style="width: 90px; height: 34px; line-height:34px">拒绝</a>
				<a class="btn btn-mini btn-danger" onclick="top.Dialog.close();" style="width: 90px; height: 34px; line-height:34px">取消</a>
				</div>
			</td>
			
		</tr>
	
	</table>
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
	<!-- 压缩图片 -->

	<link rel="stylesheet" type="text/css" href="plugins/fancyBox/jquery.fancybox.css">
	<script type="text/javascript" src="plugins/fancyBox/jquery.fancybox.pack.js"></script>
	<!-- 查看图片 -->
	<script type="text/javascript" src="static/js/chosen.jquery.min.js"></script><!-- 下拉框 -->
	<script type="text/javascript">
  </script>
</body>
</html>