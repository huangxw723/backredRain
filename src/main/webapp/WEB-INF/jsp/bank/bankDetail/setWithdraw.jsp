<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="com.aoshi.util.PropertyUtils"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
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
<link rel="stylesheet" href="static/css/datepicker.css" />
<!-- 日期框 -->
<!--引入弹窗组件start-->
<script type="text/javascript" src="plugins/attention/zDialog/zDrag.js"></script>
<script type="text/javascript"
	src="plugins/attention/zDialog/zDialog.js"></script>
<!--引入弹窗组件end-->
<!--提示框-->
<script type="text/javascript" src="static/js/jquery.tips.js"></script>
<script type="text/javascript" src="static/js/common/commonutils.js"></script>
<script src="static/js/base64Compress.js"></script>
<script src="static/js/layer/layer.js"></script>
<style type="text/css">
.ace-file-input label {
	display: block;
	position: absolute;
	top: 0;
	left: 0;
	right: 1110px;
	height: 28px;
	background-color: #FFF;
	border: 1px solid #e3e3e3;
	cursor: pointer;
	box-shadow: 0 0 0 4px rgba(0, 0, 0, 0.06); .
	a_style {font-size: 10pt;
	color: #0000cc;
	font-family: 宋体;
	text-align: left;
	text-decoration: underline;
	TEXT-DECORATION: none;
}

</style>

<script type="text/javascript">

	var checkFlag = true;

	//保存
	function save(){
		
		if($("#capMinWithdrawValue").val()=="" || $.trim($("#capMinWithdrawValue").val())==""){
			$("#capMinWithdrawValue").tips({
				side:3,
	            msg:'不能为空',
	            bg:'#AE81FF',
	            time:2
	        });
			$("#capMinWithdrawValue").focus();
			return false;
		}
		if($("#capMaxWithdrawValue").val()=="" || $.trim($("#capMaxWithdrawValue").val())==""){
			$("#capMaxWithdrawValue").tips({
				side:3,
	            msg:'不能为空',
	            bg:'#AE81FF',
	            time:2
	        });
			$("#capMaxWithdrawValue").focus();
			return false;
		}
		
		
		var capMax =$("#capMaxWithdrawValue").val() - 0;
		var	capMin =$("#capMinWithdrawValue").val() - 0;
		if(capMax < capMin){
			$("#capMaxWithdrawValue").tips({
				side:3,
	            msg:'提现金额上限不能小于下限',
	            bg:'#AE81FF',
	            time:2
	        });
			$("#capMaxWithdrawValue").focus();
			return false;
		}
		if($("#capMoneySerWithdrawValue").val()=="" || $.trim($("#capMoneySerWithdrawValue").val())==""){
			$("#capMoneySerWithdrawValue").tips({
				side:3,
	            msg:'不能为空',
	            bg:'#AE81FF',
	            time:2
	        });
			$("#capMoneySerWithdrawValue").focus();
			return false;
		}
		if($("#capNumWithdrawValue").val()=="" || $.trim($("#capNumWithdrawValue").val())==""){
			$("#capNumWithdrawValue").tips({
				side:3,
	            msg:'不能为空',
	            bg:'#AE81FF',
	            time:2
	        });
			$("#capNumWithdrawValue").focus();
			return false;
		}
		

		   if(!checkFlag){
		  		bootbox.alert("请输入正确的内容");
		  		return;
		   }
			var withdrawId = $("#capMinWithdrawId").val()+","+$("#capMaxWithdrawId").val()+","+$("#capNeedSerWithdrawId").val()+","+$("#capMoneySerWithdrawId").val()+","+$("#capNumWithdrawId").val();	
			var withdrawValue = $("#capMinWithdrawValue").val()+","+$("#capMaxWithdrawValue").val()+","+$("#capNeedSerWithdrawValue").val()+","+$("#capMoneySerWithdrawValue").val()+","+$("#capNumWithdrawValue").val();		
			$("#withdrawId").val(withdrawId);
			$("#withdrawValue").val(withdrawValue);
			// 提交表单
				//form.submit($('#pointForm'));
			$("#withdrawForm").submit();
			alert("操作完成")
			
		 		//window.location.href="point/setpoint";
	}
	 function chenckNum(num,obj){
		    var numNew;
		   // var re = /([0-9]+.[0-9]{2})[0-9]*/;
		   // numNew = num.replace(re,"$1");
			 numNew = (num.match(/\d+(\.\d{0,2})?/)||[''])[0]
		   //numNew =  parseFloat(num);
		    //alert(aNew);
		   obj.val(numNew);
		   var minCheckNum =$("#capMinWithdrawValue").val();
		   if(2>parseInt(minCheckNum)){
			   bootbox.alert("提现金额不能低于2.00元")
				$("#capMinWithdrawValue").val("2.00");

		   }
	 }
	
	
	function setSpan(flag) {
	 
		if("1"==flag){
		    var minNum =$("#capMinWithdrawValue").val();
			checkFlag = true;
		    if(""==minNum){
				checkFlag = false;
				$("#capMinWithdrawValue").val("3.00");
			}
		    chenckNum(minNum,$("#capMinWithdrawValue"));
			//var capMinWithdrawValues ="提现金额下限"+$("#capMinWithdrawValue").val()+"元";
			//$("#capMinWithdrawValues").text(capMinWithdrawValues);
		}
		if("2"==flag){
			 var maxNum =$("#capMaxWithdrawValue").val();
			checkFlag = true;
			 if(""==maxNum){
					checkFlag = false;
				}	
			chenckNum(maxNum,$("#capMaxWithdrawValue"));
			//var capMaxWithdrawValues = "提现金额上限"+$("#capMaxWithdrawValue").val()+"元";
			//$("#capMaxWithdrawValues").text(capMaxWithdrawValues);
		}if("3"==flag){
			var capMoneyCheckSerWithdrawValue =$("#capMoneySerWithdrawValue").val();
			checkFlag = true;
			if(""==capMoneyCheckSerWithdrawValue){
				checkFlag = false;
			}
			chenckNum(capMoneyCheckSerWithdrawValue,$("#capMoneySerWithdrawValue"));
			//var capMoneySerWithdrawValues = "提现手续费"+$("#capMoneySerWithdrawValue").val()+"元";
			//$("#capMoneySerWithdrawValues").text(capMoneySerWithdrawValues);
		}if("4"==flag){
			var capNumCheckWithdrawValue =$("#capNumWithdrawValue").val();
			checkFlag = true;
			if("" == capNumCheckWithdrawValue || 0 == capNumCheckWithdrawValue){
				checkFlag = false;
			}	
			//var capNumWithdrawValues = "每天提现最大次数"+$("#capNumWithdrawValue").val()+"次";
			//$("#capNumWithdrawValues").text(capNumWithdrawValues);
		}if("5"==flag){
		    var capNeedSerWithdrawValue =$("#capNeedSerWithdrawValue").val();
			if("0"==capNeedSerWithdrawValue){
			  $("#capMoneySerWithdrawValue").val("0.00");
				//var capMoneySerWithdrawValuess = "提现手续费"+$("#capMoneySerWithdrawValue").val()+"元";
			 	 //$("#capMoneySerWithdrawValues").text(capMoneySerWithdrawValuess);
			}
		}
		
		
	}
</script>
</head>
<body>
	<form action="withdraw/updatewithdraw.do" name="withdrawForm" id="withdrawForm"
		method="post" enctype="multipart/form-data">
		<div id="">
			<table id="table_report"
				class="table table-striped table-bordered table-hover"
				style="overflow: scroll;">

				<tr height="45px">
					<td>提现金额下限(元)</td>
					<td><input placeholder="输入有效金额" onchange="setSpan('1');" type="number" name="capMinWithdrawValue"
						id="capMinWithdrawValue" style="width: 370px" min = "0"
						value="${withdrawMap.capMinWithdrawValue}" /> <input type="hidden"
						name="capMinWithdrawId" id="capMinWithdrawId" style="width: 370px"
						value="${withdrawMap.capMinWithdrawId}" /></td>
<%-- 					<td><span id="capMinWithdrawValues">提现金额下限${withdrawMap.capMinWithdrawValue}元</span></td>	
 --%>				</tr> 

				<tr height="45px">
					<td>提现金额上限(元)</td>
					<td><input placeholder="输入有效金额"  onchange="setSpan('2');" type="number" name="capMaxWithdrawValue"
						id="capMaxWithdrawValue" style="width: 370px" min = '0'
						value="${withdrawMap.capMaxWithdrawValue}" /> <input type="hidden"
						name="capMaxWithdrawId" id="capMaxWithdrawId" style="width: 370px"
						value="${withdrawMap.capMaxWithdrawId}" /></td>
<%-- 					<td><span id="capMaxWithdrawValues">提现金额上限${withdrawMap.capMaxWithdrawValue}元</span></td>	
 --%>				</tr>
				<tr height="45px">
					<td>是否需要手续费</td>
					<td>
					<input type="hidden"
						name="capNeedSerWithdrawId" id="capNeedSerWithdrawId" style="width: 370px"
						value="${withdrawMap.capNeedSerWithdrawId}" "/> 
					<select onchange="setSpan('5');" name="capNeedSerWithdrawValue" id="capNeedSerWithdrawValue" style="width: 380px">
						<c:if test="${withdrawMap.capNeedSerWithdrawValue==1}">
						<option value="0">平台承担</option>
						<option value="1" selected>用户承担</option>
						</c:if>
						<c:if test="${withdrawMap.capNeedSerWithdrawValue==0}">
						<option value="0" selected>平台承担</option>
						<option value="1">用户承担</option>
						</c:if>
					</select>
					</td>
				
				</tr>
				<tr height="45px">
					<td>提现手续费(元)</td>
					<td><input placeholder="输入有效金额" onchange="setSpan('3');" type="number" name="capMoneySerWithdrawValue"
						id="capMoneySerWithdrawValue" style="width: 370px" min = '0'
						value="${withdrawMap.capMoneySerWithdrawValue}" /> <input type="hidden"
						name="capMoneySerWithdrawId" id="capMoneySerWithdrawId" style="width: 370px"
						value="${withdrawMap.capMoneySerWithdrawId}" /></td>
<%-- 					<td><span id="capMoneySerWithdrawValues">提现手续费${withdrawMap.capMoneySerWithdrawValue}元</span> </td>	
 --%>						
				</tr>
				<tr height="45px">
					<td>每天提现最大次数</td>
					<td><input placeholder="输入有效正整数"  onchange="setSpan('4');" type="number" name="capNumWithdrawValue"
						id="capNumWithdrawValue" style="width: 370px" min="1"
						value="${withdrawMap.capNumWithdrawValue}" onkeyup="validateUtils.replaceNotNumEmpty(this);" /> <input type="hidden"
						name="capNumWithdrawId" id="capNumWithdrawId" style="width: 370px"
						value="${withdrawMap.capNumWithdrawId}" /></td>
<%-- 					<td><span id="capNumWithdrawValues">每天提现最多${withdrawMap.capNumWithdrawValue}次</span></td>
 --%>				</tr>
			
				<tr id="operaArea">
					<td style="text-align: center;" colspan="2"><a
						class="btn btn-mini btn-primary" onclick="save();">保存</a> <a
						class="btn btn-mini btn-danger" href="withdraw/setwithdraw">取消</a></td>
				</tr>
				<!-- 积分信息 -->
				<input type="hidden" name="withdrawId" id="withdrawId" value=" " />
				<input type="hidden" name="withdrawValue" id="withdrawValue" value=" " />
			</table>
		</div>
	</form>

	<!-- 引入 -->
	<script type="text/javascript">window.jQuery || document.write("<script src='static/js/jquery-1.9.1.min.js'>\x3C/script>");</script>
	<script src="static/js/bootstrap.min.js"></script>
	<script src="static/js/ace-elements.min.js"></script>
	<script src="static/js/ace.min.js"></script>
	<script type="text/javascript"
		src="static/js/bootstrap-datepicker.min.js"></script>
	<!-- 日期框 -->
	<script type="text/javascript" src="static/js/chosen.jquery.min.js"></script>
	<!-- 下拉框 -->
	<script type="text/javascript" src="static/js/bootbox.min.js"></script>
	<!-- 确认窗口 -->

	<script type="text/javascript" src="static/js/base64.js"></script>
	<!-- 压缩图片 -->

	<link rel="stylesheet" type="text/css"
		href="plugins/fancyBox/jquery.fancybox.css">
	<script type="text/javascript"
		src="plugins/fancyBox/jquery.fancybox.pack.js"></script>
	<!-- 查看图片 -->

	<script type="text/javascript">
	$(top.hangge());
	$("#imgBox").fancybox({
		helpers : {
			title : {
				type : 'inside'
			}
		}
	});
  </script>
</body>
</html>