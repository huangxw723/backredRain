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
<%@ include file="../../../system/admin/top.jsp"%>
<script type="text/javascript" src="static/js/common/commonutils.js"></script>

<script type="text/javascript">
	//保存
</script>
</head>
<body>
	<form action="yp/admin/ypScreenInfo/${msg }.do" name="shopForm"
		id="shopForm" method="post">
		<input type="hidden" name="action" id="action" value="${pd.action }" />
		<input type="hidden" name="screenInfoId" id="screenInfoId"
			value="${sc.screenInfoId }" />
		<div id="zhongxin">
			<table id="table_report"
				class="table table-striped table-bordered table-hover">
				<tr>
					<th>终端标识:</th>
					<td><input placeholder="终端标识"
						<c:if test="${pd.action==2}">disabled="disabled"</c:if>
						type="text" style="width: 90%;" name="sn" id="sn"
						value="${sc.sn }" title="终端标识" /></td>
				</tr>
				<tr>
					<th>企业:</th>
					<td><select
						<c:if test="${pd.action==2}">disabled="disabled"</c:if> class="chzn-select" name="shopId" id="shopId"
						data-placeholder="企业" style="vertical-align: top; width: 447px;">
							<c:forEach items="${shops}" var="var">
								<option value="${var.shopId }"
									<c:if test="${var.shopId == sc.shopId }">selected</c:if>>${var.name }</option>
							</c:forEach>
					</select></td>
				</tr>
				<tr>
					<th>绑定域名:</th>
					<td><select class="chzn-select" name="screenDomainId"
						id="screenDomainId" data-placeholder="绑定域名"
						style="vertical-align: top; width: 447px;" >
<%-- 							<c:if test="${pd.action==2}"> --%>
<!-- 							<option value=""></option> -->
<%-- 							<c:forEach items="${domains}" var="var"> --%>
<%-- 								<option value="${var.screenDomainId }" --%>
<%-- 									<c:if test="${var.screenDomainId == sc.screenDomainId }">selected</c:if>>${var.url }</option> --%>
<%-- 							</c:forEach> --%>
<%-- 							</c:if> --%>
					</select></td>
				</tr>
				<tr>
					<th>地理位置:
					<td><select
						<c:if test="${pd.action==2}">disabled="disabled"</c:if>
						class="chzn-select" name="provinceId" id="provinceId"
						data-placeholder="请选择省份" style="vertical-align: top;">
							<option value=""></option>
							<c:forEach items="${provinceList}" var="province">
								<option value="${province.provinceId }"
									<c:if test="${province.provinceId == sc.provinceId }">selected</c:if>>${province.provinceName }</option>
							</c:forEach>
					</select> <select class="chzn-select" name="cityId" id="cityId" data-placeholder="请选择城市"
						style="vertical-align: top;"
						<c:if test="${pd.action==2}">disabled="disabled"</c:if>>
						<c:if test="${pd.action==2}">
						   <option value=""></option>
							<c:forEach items="${cityList}" var="city">
								<option value="${city.cityId }"
									<c:if test="${city.cityId == sc.cityId }">selected</c:if>>${city.cityName }</option>
							</c:forEach>
						</c:if>
							
					</select> <select data-placeholder="请选择区域" class="chzn-select" name="areaId" id="areaId"
						style="vertical-align: top;"
						<c:if test="${pd.action==2}">disabled="disabled"</c:if>>
						<c:if test="${pd.action==2}">
						   <option value=""></option>
							<c:forEach items="${areaList}" var="var">
								<option value="${var.areaId }"
									<c:if test="${var.areaId == sc.areaId }">selected</c:if>>${var.areaName }</option>
							</c:forEach>
						</c:if>
					</select></td>
				</tr>
				<tr>
					<th>详细地址:</th>
					<td><input type="text" style="width: 90%;" name="address"
						id="address" value="${sc.address }" placeholder="详细地址" /></td>
				<tr>
					<td class="center" colspan="2"><a
						class="btn btn-mini btn-primary" onclick="save();">保存</a> <a
						class="btn btn-mini btn-danger" onclick="top.Dialog.close();">取消</a>
					</td>
				</tr>
			</table>
		</div>
		<div id="" class="center">
			<h4 class="lighter block red">操作时间：${opearTime }</h4>
			<br /> <br />
		</div>
		<div id="zhongxin2" class="center" style="display: none">
			<br /> <br /> <br /> <br /> <br /> <img
				src="static/images/jiazai.gif" /> <br />
			<h4 class="lighter block green">提交中...</h4>
		</div>
	</form>
	<!-- 引入 -->
	<script type="text/javascript">
		window.jQuery
				|| document
						.write("<script src='static/js/jquery-1.9.1.min.js'>\x3C/script>");
	</script>
	<script src="static/js/bootstrap.min.js"></script>
	<script src="static/js/ace-elements.min.js"></script>
	<script src="static/js/ace.min.js"></script>
	<script type="text/javascript" src="static/js/chosen.jquery.min.js"></script>
	<!-- base64 -->
	<script src="static/js/base64.js"></script>
	<link rel="stylesheet" type="text/css"
		href="plugins/fancyBox/jquery.fancybox.css">
	<script type="text/javascript"
		src="plugins/fancyBox/jquery.fancybox.pack.js"></script>
	<!-- 单选框 -->

	<script type="text/javascript">
		$(top.hangge());
		$(function() {

			//单选框
			$(".chzn-select").chosen();
			$(".chzn-select-deselect").chosen({
				allow_single_deselect : true
			});
		})
		//保存
		function save() {
			if ($("#sn").val() == "") {

				$("#sn").tips({
					side : 3,
					msg : '输入标识编号',
					bg : '#AE81FF',
					time : 2
				});

				$("#sn").focus();
				$("#sn").val('');
				return false;
			} else {
				$("#sn").val(jQuery.trim($('#sn').val()));
			}
			if ($("#action").val() == 1) {
				if ($("#shopId").val() == "") {
					$("#shopId").tips({
						side : 3,
						msg : '请选择企业',
						bg : '#AE81FF',
						time : 2
					});

					$("#shopId").focus();
					$("#shopId").val('');
					return false;
				} else {
					$("#shopId").val(jQuery.trim($('shopId').val()));
				}
			}
			if ($("#screenDomainId").val() == "") {
				$("#screenDomainId").tips({
					side : 3,
					msg : '请选选择域名',
					bg : '#AE81FF',
					time : 2
				});

				$("#screenDomainId").focus();
				$("#screenDomainId").val('');
				return false;
			} else {
				$("#screenDomainId").val(
						jQuery.trim($('#screenDomainId').val()));
			}
			if ($("#action").val() == 1) {
				if ($("#action").val() == 1) {
					if ($("#provinceId").val() == "") {

						$("#provinceId").tips({
							side : 3,
							msg : '选择省份',
							bg : '#AE81FF',
							time : 2
						});

						$("#provinceId").focus();
						$("#provinceId").val('');
						$("#provinceId").css("background-color", "white");
						return false;
					} else {
						$("#provinceId").val(
								jQuery.trim($('#provinceId').val()));
					}
					if ($("#cityId").val() == "") {

						$("#cityId").tips({
							side : 3,
							msg : '选择城市',
							bg : '#AE81FF',
							time : 2
						});

						$("#cityId").focus();
						$("#cityId").val('');
						$("#cityId").css("background-color", "white");
						return false;
					} else {
						$("#cityId").val(jQuery.trim($('#cityId').val()));
					}

					if ($("#areaId").val() == "") {

						$("#areaId").tips({
							side : 3,
							msg : '选择区域',
							bg : '#AE81FF',
							time : 2
						});

						$("#areaId").focus();
						$("#areaId").val('');
						$("#areaId").css("background-color", "white");
						return false;
					} else {
						$("#areaId").val(jQuery.trim($('#areaId').val()));
					}
				}
			}
			if ($("#address").val() == "") {

				$("#address").tips({
					side : 3,
					msg : '输入详细地址',
					bg : '#AE81FF',
					time : 2
				});

				$("#address").focus();
				$("#address").val('');
				$("#address").css("background-color", "white");
				return false;
			} else {
				$("#address").val(jQuery.trim($('#address').val()));
			}
			form.submit($('#shopForm'));

		}
		$(function(){
			//单选框
			$(".chzn-select").chosen(); 
			$(".chzn-select-deselect").chosen({allow_single_deselect:true});
			
			
			
			
			//联动select事件
			$("#provinceId").change(function(){
			    var provinceId = $("#provinceId").val();
			    var citySelect = $("#cityId");
			    citySelect.empty().append("<option value=''></option>");
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
			
			//企业站点select事件
			$("#shopId").change(function(){
			    var shopId = $("#shopId").val();
			    var screenDomainIdSelect = $("#screenDomainId");
			    screenDomainIdSelect.empty().append("<option value=''></option>");
			    var domains = '${domains}';
			    $.each(JSON.parse(domains), function(i, list){
			    	var parentId = list.shopId;
					if(parentId == shopId) {
						var value = list.screenDomainId;
						var option = list.url;
						var label = $("<option value='"+value+"'>"+option+"</option>");
						screenDomainIdSelect.append(label);
							}
						});
			    screenDomainIdSelect.trigger("liszt:updated");
			});
			
			if($("#shopId").val()) {
				var shopId = $("#shopId").val();
			    var domainSelect = $("#screenDomainId");
			    domainSelect.empty().append("<option value=''></option>");
			    var domainse = '${domains}';
			    var screenDomainId = '${sc.screenDomainId}';
			    $.each(JSON.parse(domainse), function(i, list){
			    	var parentId = list.shopId;
					if(parentId == shopId) {
						var value = list.screenDomainId;
						var option = list.url;
						var label = $("<option value='"+value+"'>"+option+"</option>");
						if(screenDomainId == list.screenDomainId) {
							label.attr("selected", "selected");
						}
						domainSelect.append(label);
					}
					 domainSelect.trigger("liszt:updated");
			 	});
			}
			
		});
	</script>
</body>
</html>