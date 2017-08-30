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
		<link rel="stylesheet" href="static/css/bootstrap-datetimepicker.min.css" /><!-- 时间框 -->
		<!--引入弹窗组件start-->
		<script type="text/javascript" src="plugins/attention/zDialog/zDrag.js"></script>
		<script type="text/javascript" src="plugins/attention/zDialog/zDialog.js"></script>
		<!--引入弹窗组件end-->
		<!--提示框-->
		<script type="text/javascript" src="static/js/jquery.tips.js"></script>
		<%--工具类--%>
		<script type="text/javascript" src="static/js/common/commonutils.js"></script>
		<!--时间格式化-->
		<script type="text/javascript" src="static/js/dateFormat.js"></script>
  		
<script type="text/javascript">
	$(top.hangge());

	//更改图片
    function changeImg(){
        $("#fileInput").trigger("click");
    }
	
	
	//保存
	function save(){

		var money = $('#money').val();
		if(validateUtils.isEmpty(money)){
			$("#money").tips({
				side:3,
	            msg:'提现金额不能为空！',
	            bg:'#AE81FF',
	            time:2
	        });
			$("#money").focus();
			return false;
		}
		var moneytemp = parseFloat(money);
		 var m = '${wallet.money}';
		 var mtemp = parseFloat(m);
		 var min = '${min}';
		var mintemp = parseFloat(min);
		 var max = '${max}';
		var maxtemp = parseFloat(max);
		var serviceCharge = '${serviceCharge}';
		var serviceChargetemp = parseFloat(serviceCharge);
		if(moneytemp > mtemp){
			$("#money").tips({
				side:3,
	            msg:'账号余额不足！',
	            bg:'#AE81FF',
	            time:2
	        });
			$("#money").focus();
			return false;
		}
		if(moneytemp > maxtemp || moneytemp < mintemp){
			$("#money").tips({
				side:3,
				msg:'提现金额不在单笔限额内！',
				bg:'#AE81FF',
				time:2
			});
			$("#money").focus();
			return false;
		}
		if( moneytemp <= serviceChargetemp){
			$("#money").tips({
				side:3,
				msg:'提现金额不能小于手续费！',
				bg:'#AE81FF',
				time:2
			});
			$("#money").focus();
			return false;
		}

		// 提交表单
		form.submit($('#usersForm'));

	}

</script>
	</head>
<body>

	<form action="account/accountDepositOpera.do" name="usersForm" id="usersForm" method="post">
	<input type="hidden" name="action" id="action" value="${action}"/>
	<input type="hidden" name="userId" id="userId" value="${pd.userId}"/>


	<div id="zhongxin" >
	<table id="table_report" class="table table-striped table-bordered table-hover" style="overflow:scroll;">

		<tr height="45px">
			<td>提现银行:</td>
			<td >
				<select class="chzn-select" name="bankBindId" id="bankBindId"  style="vertical-align:top;width: 390px;"  >
					<c:forEach items="${list}" var="var">
						<option value="${var.bankBindId }" selected="selected" > ${var.bankName }</option>
					</c:forEach>
				</select>

			</td>
		</tr>

		<tr height="45px">

			<td>银行卡号:</td>
			<td><input  type="text" name="bankAccount" id="bankAccount" value='${bankAccount}' disabled="disabled" style="width: 390px"/></td>
		</tr>
		<tr height="45px">
			<td>提现金额:</td>
			<td><input  type="number" name="money" min="0" id="money" value=""   style="width: 390px" placeholder="本次最多可提现&#165;${wallet.money}" onkeyup="validateUtils.replaceSpaceEmpty(this);"/></td>
		</tr>

		<tr height="45px">
			<td>手续费:</td>
			<td>
				<input  type="text" disabled="disabled" value='${serviceCharge}' style="width: 390px;" />
			</td>
		</tr>
		<tr height="45px">
			<td>备注:</td>
			<td>
				 本次提现手续费&#165;${serviceCharge}，单笔限额&#165;${min}&nbsp;—&nbsp;&#165;${max}，今日还可以提现${surplusTimes}次。
			</td>
		</tr>
		<c:if test="${surplusTimes != 0}">
			<tr id="operaArea">
				<td style="text-align: center;" colspan="4">
					<a class="btn btn-mini btn-primary" onclick="save();">保存</a>&nbsp;&nbsp;&nbsp;&nbsp;
					<a class="btn btn-mini btn-danger" onclick="top.Dialog.close();">取消</a>
				</td>
			</tr>
		</c:if>

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
	<script type="text/javascript" src="static/js/bootstrap-datetimepicker.js"></script><!-- 时间框 -->
	<script type="text/javascript" src="static/js/bootstrap-datetimepicker.zh-CN.js"></script><!-- 时间框 -->
	<script type="text/javascript" src="static/js/chosen.jquery.min.js"></script><!-- 下拉框 -->
	<script type="text/javascript" src="static/js/bootbox.min.js"></script><!-- 确认窗口 -->


	<link rel="stylesheet" type="text/css" href="plugins/fancyBox/jquery.fancybox.css">
	<script type="text/javascript" src="plugins/fancyBox/jquery.fancybox.pack.js"></script>
	<!-- 查看图片 -->
	<script type="text/javascript">
	$(top.hangge());

	
	$(function() {

		//单选框
		$(".chzn-select").chosen();
		$(".chzn-select-deselect").chosen({allow_single_deselect:true});

		//联动select事件
		$("#bankBindId").change(function(){
		    var bankBindId = $("#bankBindId").val();
		    var bankAccount = $("#bankAccount");
			bankAccount.val("");
		    var listJson = '${listJson}';
			$.each(JSON.parse(listJson), function(i, list){
		    	var bankId = list.bankBindId;
		    	var account = list.bankAccount;
				if(bankBindId == bankId) {
					bankAccount.val(account);
					return;
				}
		 	});
		});


	});
	

  </script>
</body>
</html>