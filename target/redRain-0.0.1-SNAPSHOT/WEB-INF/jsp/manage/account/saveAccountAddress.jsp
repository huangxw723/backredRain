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
		<%--工具类--%>
		<script type="text/javascript" src="static/js/common/commonutils.js"></script>
		<!--时间格式化-->
		<script type="text/javascript" src="static/js/dateFormat.js"></script>
  		
<script type="text/javascript">
	$(top.hangge());

	//保存
	function save(){

		var receiver = $('#receiver').val();
		if(validateUtils.isEmpty(receiver)){
			$("#receiver").tips({
				side:3,
	            msg:'收货人不能为空！',
	            bg:'#AE81FF',
	            time:2
	        });
			$("#receiver").focus();
			return false;
		}
			var pattern = new RegExp(/^\"|\"|\'|\'$/g);
			var b = pattern.test(receiver);
			if(b){
				$("#receiver").tips({
					side:3,
					msg:'收货人中不能包含英语的双引号或单引号',
					bg:'#AE81FF',
					time:2
				});
				$("#receiver").focus();
				return false;
			}
		if(receiver.length<2 || receiver.length>10){
			$("#receiver").tips({
				side:3,
	            msg:'2~10个字',
	            bg:'#AE81FF',
	            time:2
	        });
			$("#receiver").focus();
			return false;
		}

		var phone = $('#phone').val();
		if(validateUtils.isEmpty(phone)){
			$("#phone").tips({
				side:3,
				msg:'联系电话不能为空！',
				bg:'#AE81FF',
				time:2
			});
			$("#phone").focus();
			return false;
		}

		if(!validateUtils.isMobilePhone(phone)){
			$("#phone").tips({
				side:3,
				msg:'请填写正确的手机号码！',
				bg:'#AE81FF',
				time:2
			});
			$("#phone").focus();
			return false;
		}

				var name = $('#provinceId').val();
				if(validateUtils.isEmpty(name)){
					$("#provinceId").tips({
						side:3,
			            msg:'省份不能为空！',
			            bg:'#AE81FF',
			            time:3
			        });
					$("#provinceId").focus();
					return false;
				}	
				
				var name = $('#cityId').val();
				if(validateUtils.isEmpty(name)){
					$("#cityId").tips({
						side:3,
			            msg:'城市不能为空！',
			            bg:'#AE81FF',
			            time:3
			        });
					$("#cityId").focus();
					return false;
				}	
				
				var name = $('#areaId').val();
				if(validateUtils.isEmpty(name)){
					$("#areaId").tips({
						side:3,
			            msg:'区域不能为空！',
			            bg:'#AE81FF',
			            time:3
			        });
					$("#areaId").focus();
					return false;
				}	
				
				var name = $('#address').val();
				if(validateUtils.isEmpty(name)){
					$("#address").tips({
						side:3,
			            msg:'详细地址不能为空！',
			            bg:'#AE81FF',
			            time:3
			        });
					$("#address").focus();
					return false;
				}

		// 提交表单
		form.submit($('#usersForm'));
		if('${action}'==1){
			$("#zhongxin").hide();
			$("#zhongxin2").show();
		}

	}

</script>
	</head>
<body>

	<form action="account/accountAddressOpera.do" name="usersForm" id="usersForm" method="post">
	<input type="hidden" name="action" id="action" value="${action}"/>
	<input type="hidden" name="userId" id="userId" value="${userId}"/>
	<input type="hidden" name="userAddressId"   value="${address.userAddressId}"/>

	<div id="zhongxin" >
	<table id="table_report" class="table table-striped table-bordered table-hover" style="overflow:scroll;">
		<tr height="45px">

			<td>收货人:</td>
			<td><input  type="text" name="receiver" id="receiver" value='${address.receiver}' style="width: 390px" onkeyup="validateUtils.replaceSpaceEmpty(this);"/></td>
		</tr>
		<tr height="45px">

			<td>联系电话:</td>
			<td><input  type="text" name="phone" id="phone" value='${address.phone}' style="width: 390px" onkeyup="validateUtils.replaceSpaceEmpty(this);"/></td>
		</tr>

		<tr height="45px">
			<td>所在地区:</td>
			<td >
				<select class="chzn-select" name="provinceId" id="provinceId" data-placeholder="请选择省份" style="vertical-align:top;width: 120px;"  >
					<option value=""></option>
					<c:forEach items="${provinceList}" var="var">
						<option value="${var.provinceId }" <c:if test="${var.provinceId == address.provinceId }">selected</c:if>>${var.provinceName }</option>
					</c:forEach>
				</select>
				<select class="chzn-select" name="cityId" id="cityId" data-placeholder="请选择城市" style="vertical-align:top;width: 140px;"  >
					<%--<c:if test="${action==2 }">
						<option value=""></option>
						<c:forEach items="${cityList}" var="vc">
							<option value="${vc.cityId}" <c:if test="${vc.cityId == am.cityId }">selected</c:if>>${vc.cityName }</option>
						</c:forEach>
					</c:if>--%>
				</select>
				<select class="chzn-select" name="areaId" id="areaId" data-placeholder="请选择区域" style="vertical-align:top; width: 140px;">

					<%--<c:if test="${action==2 }">
						<option value=""></option>
						<c:forEach items="${areaList}" var="var">
							<option value="${var.areaId }"
									<c:if test="${var.areaId == am.areaId }">selected</c:if>>${var.areaName }</option>
						</c:forEach>
					</c:if>--%>
				</select>
			</td>
		</tr>
		<tr height="45px">
			<td>详细地址:</td>
			<td>
				<input  type="text" name="address" id="address" title="${address.address}" value='${address.address}' style="width: 390px; " onkeyup="validateUtils.replaceSpaceEmpty(this);"/>
			</td>
		</tr>

		<tr id="operaArea">
			<td style="text-align: center;" colspan="4">
                <a class="btn btn-mini btn-primary" onclick="save();">保存</a>&nbsp;&nbsp;&nbsp;&nbsp;
				<a class="btn btn-mini btn-danger" onclick="top.Dialog.close();">取消</a>
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
	<script type="text/javascript" src="static/js/chosen.jquery.min.js"></script><!-- 下拉框 -->
	<script type="text/javascript" src="static/js/bootbox.min.js"></script><!-- 确认窗口 -->


	<link rel="stylesheet" type="text/css" href="plugins/fancyBox/jquery.fancybox.css">
	<script type="text/javascript" src="plugins/fancyBox/jquery.fancybox.pack.js"></script>
	<!-- 查看图片 -->
	<script type="text/javascript">
	$(top.hangge());

	
	$(function() {

		if($("#provinceId").val()) {
			var provinceId = $("#provinceId").val();
			var citySelect = $("#cityId");
			citySelect.empty().append("<option value=''></option>");
			var cityList = '${cityList}';
			var cityId = '${address.cityId}';
			$.each(JSON.parse(cityList), function(i, list){
				var parentId = list.provinceId;
				if(parentId == provinceId) {
					var value = list.cityId;
					var option = list.cityName;
					var label = $("<option value='"+value+"'>"+option+"</option>");
					if(cityId == list.cityId) {
						label.attr("selected", "selected");
					}
					citySelect.append(label);
				}
			});
		}
		if($("#cityId").val()) {
			var cityId = $("#cityId").val();
			var areaSelect = $("#areaId");
			areaSelect.empty().append("<option value=''></option>");
			var areaList = '${areaList}';
			var shopAreaId = '${address.areaId}';
			$.each(JSON.parse(areaList), function(i, list){
				var parentId = list.cityId;
				if(parentId == cityId) {
					var value = list.areaId;
					var option = list.areaName;
					var label = $("<option value='"+value+"'>"+option+"</option>");
					if(shopAreaId == list.areaId) {
						label.attr("selected", "selected");
					}
					areaSelect.append(label);
				}
			});
		}

		//单选框
		$(".chzn-select").chosen();
		$(".chzn-select-deselect").chosen({allow_single_deselect:true});

		//联动select事件
		$("#provinceId").change(function(){
		    var provinceId = $("#provinceId").val();
		    var citySelect = $("#cityId");
		    citySelect.empty().append("<option value=''></option>");
		    var areaSelect = $("#areaId");
		    areaSelect.empty().append("<option value=''></option>");
		    var cityList = '${cityList}';
		    $.each(JSON.parse(cityList), function(i, list){
		    	var parentId = list.provinceId;
				if(parentId == provinceId) {
					var value = list.cityId;
					var option = list.cityName;
					var label = $("<option value='"+value+"'>"+option+"</option>");
					citySelect.append(label);
				}
		 	});
		    citySelect.trigger("liszt:updated");
		    areaSelect.trigger("liszt:updated");
		});
		
		//联动select事件
		$("#cityId").change(function(){
		    var cityId = $("#cityId").val();
		    var areaSelect = $("#areaId");
		    areaSelect.empty().append("<option value=''></option>");
		    var areaList = '${areaList}';
		    $.each(JSON.parse(areaList), function(i, list){
		    	var parentId = list.cityId;
				if(parentId == cityId) {
					var value = list.areaId;
					var option = list.areaName;
					var label = $("<option value='"+value+"'>"+option+"</option>");
					areaSelect.append(label);
				}
		 	});
		    areaSelect.trigger("liszt:updated");
		});

	});

  </script>
</body>
</html>