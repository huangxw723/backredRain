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
	<script src="static/js/base64Compress.js"></script>
	<!--引入弹窗组件start-->
	<script type="text/javascript" src="plugins/attention/zDialog/zDrag.js"></script>
	<script type="text/javascript" src="plugins/attention/zDialog/zDialog.js"></script>
	<!--引入弹窗组件end-->
	<!--提示框-->
	<script type="text/javascript" src="static/js/jquery.tips.js"></script>
	<style type="text/css">
		.ace-file-input label {
			display: block;
			position: absolute;
			top: 0;
			left: 0;
			right: 500px;
			height: 28px;
			background-color: #FFF;
			border: 1px solid #e3e3e3;
			cursor: pointer;
			box-shadow: 0 0 0 4px rgba(0, 0, 0, 0.06);
		}
	</style>

	<script type="text/javascript">
		$(top.hangge());

		$(function() {
			$(".chzn-select").chosen();
			$(".chzn-select-deselect").chosen({allow_single_deselect:true});
		});

		//保存
		function save(){
			var itemId;
			if($("#linkName").val()==""||$.trim($("#linkName").val())==""){
				$("#linkName").tips({
					side:3,
					msg:'链接名称',
					bg:'#AE81FF',
					time:2
				});
				$("#linkName").focus();
				return false;
			}
			
			//校验和限制参与次数输入0~100
			var re =/^\d*$/;
			var nubmer = $("#perCount").val();			
			if (!re.test(nubmer))
			{
			  alert("请输入正确的数值,只允许输入整数!");			
			  return false;
			} if(nubmer > 100 || nubmer < 1){
		        alert('输入的数不能小于1且不能大于100');		       
		        return false;
		    }
			
			if($('#rangeType option:selected').val()==1){
				itemId=$("#cityId1").val()
				if($("#provinceId1").val()==""||$.trim($("#provinceId1").val())=="" ){
					$("#provinceId1").tips({
						side:3,
						msg:'选择省份',
						bg:'#AE81FF',
						time:2
					});
					$("#provinceId1").focus();
					return false;
				}
				if($("#cityId1").val()==""||$.trim($("#cityId1").val())=="" ){
					$("#cityId1").tips({
						side:3,
						msg:'选择城市',
						bg:'#AE81FF',
						time:2
					});
					$("#cityId1").focus();
					return false;
				}
			}else if($('#rangeType option:selected').val()==2){
				itemId=$("#areaId2").val()
				if($("#provinceId2").val()==""||$.trim($("#provinceId2").val())=="" ){
					$("#provinceId2").tips({
						side:3,
						msg:'选择省份',
						bg:'#AE81FF',
						time:2
					});
					$("#provinceId2").focus();
					return false;
				}
				if($("#cityId2").val()==""||$.trim($("#cityId2").val())=="" ){
					$("#cityId2").tips({
						side:3,
						msg:'选择城市',
						bg:'#AE81FF',
						time:2
					});
					$("#cityId2").focus();
					return false;
				}
				if($("#areaId2").val()==""||$.trim($("#areaId2").val())=="" ){
					$("#areaId2").tips({
						side:3,
						msg:'选择区域',
						bg:'#AE81FF',
						time:2
					});
					$("#areaId2").focus();
					return false;
				}
			}else if($('#rangeType option:selected').val()==3){
				itemId=$("#district").val()
				if($("#provinceId").val()==""||$.trim($("#provinceId").val())=="" ){
					$("#provinceId").tips({
						side:3,
						msg:'选择省份',
						bg:'#AE81FF',
						time:2
					});
					$("#provinceId").focus();
					return false;
				}
				if($("#cityId").val()==""||$.trim($("#cityId").val())=="" ){
					$("#cityId").tips({
						side:3,
						msg:'选择城市',
						bg:'#AE81FF',
						time:2
					});
					$("#cityId").focus();
					return false;
				}
				if($("#areaId").val()==""||$.trim($("#areaId").val())=="" ){
					$("#areaId").tips({
						side:3,
						msg:'选择区域',
						bg:'#AE81FF',
						time:2
					});
					$("#areaId").focus();
					return false;
				}
				if($("#district").val()==""||$.trim($("#district").val())=="" ){
					$("#district").tips({
						side:3,
						msg:'选择商圈',
						bg:'#AE81FF',
						time:2
					});
					$("#district").focus();
					return false;
				}
			}else if($('#rangeType option:selected').val()==4){
				itemId=$("#store3").val()
				if($("#provinceId3").val()==""||$.trim($("#provinceId3").val())=="" ){
					$("#provinceId3").tips({
						side:3,
						msg:'选择省份',
						bg:'#AE81FF',
						time:2
					});
					$("#provinceId3").focus();
					return false;
				}
				if($("#cityId3").val()==""||$.trim($("#cityId3").val())=="" ){
					$("#cityId3").tips({
						side:3,
						msg:'选择城市',
						bg:'#AE81FF',
						time:2
					});
					$("#cityId3").focus();
					return false;
				}
				if($("#areaId3").val()==""||$.trim($("#areaId3").val())=="" ){
					$("#areaId3").tips({
						side:3,
						msg:'选择区域',
						bg:'#AE81FF',
						time:2
					});
					$("#areaId3").focus();
					return false;
				}
				if($("#district3").val()==""||$.trim($("#district3").val())=="" ){
					$("#district3").tips({
						side:3,
						msg:'选择商圈',
						bg:'#AE81FF',
						time:2
					});
					$("#district").focus();
					return false;
				}
				if($("#store3").val()==""||$.trim($("#store3").val())=="" ){
					$("#store3").tips({
						side:3,
						msg:'选择商场',
						bg:'#AE81FF',
						time:2
					});
					$("#store3").focus();
					return false;
				}
			}
			$("#itemId").val(itemId);

			// 提交表单
			form.submit($('#usersForm'));
		}

		form = {

			submit:function(formElement){


				var iUrl = formElement.attr('action');
				var data = new Object();
				$.each(formElement.serializeArray(),function(index,item){

					var key = item.name;
					var value = item.value;
					data[key] = value;
				});

				$.ajax({
					type: "POST",
					url: iUrl,
					data: data,
					dataType: "json",
					success: function(data){

						alert(data.msg)

						if(data.status == 0){

							formElement[0].reset()

							var element = document.getElementById('zhongxin');
							element.style.display = 'none';
							top.Dialog.close();

						}

					},
					error:function(data){
						alert('系统繁忙')
					}
				});
			}
		}

	</script>
</head>
<body>

<form action="link/activityLink/addLink.do" name="usersForm" id="usersForm" method="post" enctype="multipart/form-data">
	<input type="hidden" name="itemId" id="itemId" value="">
	<div id="zhongxin" >
		<table id="table_report" class="table table-striped table-bordered table-hover" style="overflow:scroll;">
			<tr height="45px">
				<td width="60px">链接名称:</td>
				<td>
					<input type="text" style="width:370px;" name="linkName" id="linkName"  placeholder="这里输入链接名称" title="链接名称" />
				</td>
			</tr>
			<tr height="45px">
				<td width="60px">范围类型:</td>
				<td>
					<select class="chzn-select" name="rangeType" id="rangeType" data-placeholder="请选择范围" style="vertical-align:top;width: 90px">
						<option value="1" selected="selected">市</option>
						<option value="2">区</option>
						<option value="3">商圈</option>
						<option value="4">商场</option>
					</select>
				</td>
			</tr>
			<tr height="45px">
				<td width="60px">区域:</td>
				<td>
					<span class="city" style="display: inline-block">
                                <span>
								省份:
								<select class="chzn-select" name="provinceId1" id="provinceId1" data-placeholder="请选择省份" style="vertical-align:top;width: 104px">
								  <option value=""></option>
                                  <option value="">全部</option>
								  <c:forEach items="${provinceList}" var="province">
									  <option value="${province.provinceId }" >${province.provinceName }</option>
								  </c:forEach>
            					</select>
							    </span>
                                <span>
								城市:
								<select class="chzn-select" name="cityId1" id="cityId1" data-placeholder="请选择城市" style="vertical-align:top;width: 104px">
            					</select>
							</span>
                            </span>
					<span class="area" style="display: none">
                                <span>
								省份:
								<select class="chzn-select" name="provinceId2" id="provinceId2" data-placeholder="请选择省份" style="vertical-align:top;width: 90px">
								  <option value=""></option>
                                  <option value="">全部</option>
								  <c:forEach items="${provinceList}" var="province">
									  <option value="${province.provinceId }" >${province.provinceName }</option>
								  </c:forEach>
            					</select>
							</span>
                                <span>
								城市:
								<select class="chzn-select" name="cityId2" id="cityId2" data-placeholder="请选择城市" style="vertical-align:top;width: 90px">
            					</select>
							</span>
                                <span>
								区域:
								<select class="chzn-select" name="areaId2" id="areaId2" data-placeholder="请选择县区" style="vertical-align:top;width: 90px">
            					</select>
							</span>
                            </span>
					<span class="dis" style="display: none">
                                <span>
								省份:
								<select class="chzn-select" name="provinceId" id="provinceId" data-placeholder="请选择省份" style="vertical-align:top;width: 90px">
								  <option value=""></option>
                                  <option value="">全部</option>
								  <c:forEach items="${provinceList}" var="province">
									  <option value="${province.provinceId }" >${province.provinceName }</option>
								  </c:forEach>
            					</select>
							</span>
                                <span>
								城市:
								<select class="chzn-select" name="cityId" id="cityId" data-placeholder="请选择城市" style="vertical-align:top;width: 90px">
            					</select>
							</span>
                                <span>
								区域:
								<select class="chzn-select" name="areaId" id="areaId" data-placeholder="请选择县区" style="vertical-align:top;width: 90px">
            					</select>
							</span>
                                <span>
								商圈:
								<select class="chzn-select" name="district" id="district" data-placeholder="请选择商圈" style="vertical-align:top;width: 90px">
            					</select>
							</span>
                            </span>
					<span class="store" style="display: none">
                                <span>
								省份:
								<select class="chzn-select" name="provinceId3" id="provinceId3" data-placeholder="请选择省份" style="vertical-align:top;width: 90px">
								  <option value=""></option>
                                  <option value="">全部</option>
								  <c:forEach items="${provinceList}" var="province">
									  <option value="${province.provinceId }" >${province.provinceName }</option>
								  </c:forEach>
            					</select>
							</span>
                                <span>
								城市:
								<select class="chzn-select" name="cityId3" id="cityId3" data-placeholder="请选择城市" style="vertical-align:top;width: 90px">
            					</select>
							</span>
                                <span>
								区域:
								<select class="chzn-select" name="areaId3" id="areaId3" data-placeholder="请选择县区" style="vertical-align:top;width: 90px">
            					</select>
							</span>
                                <span>
								商圈:
								<select class="chzn-select" name="district3" id="district3" data-placeholder="请选择商圈" style="vertical-align:top;width: 90px">
            					</select>
							</span>
                            <span>
								商场:
								<select class="chzn-select" name="store3" id="store3" data-placeholder="请选择商场" style="vertical-align:top;width: 90px">
            					</select>
							</span>
                            </span>
				</td>
			</tr>
			<tr height="45px">
                <td style="width: 100px">每人每天可参与次数:</td>
                <td>
                    <input type="text" style="width:100px;" name="perCount" id="perCount"  placeholder="参与次数" title="每人每天参与次数" />
                </td>
            </tr>
			<tr height="45px">
				<td class="center" colspan="2">
					<a class="btn btn-mini btn-primary" onclick="save();">保存</a>
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
	var ue = UE.getEditor('editor');
	$(top.hangge());

	$(document).ready(function(){
		$("#adUrlType").change(function(){
			if($(this).val()&&$(this).val()==1){
				$("#msgDiv").hide();
				$("#msgDivScreen").show();
			}else{
				$("#msgDiv").show();
				$("#msgDivScreen").hide();
			}
		});

	});

	$(function() {
		//单选框
		$(".chzn-select").chosen();
		$(".chzn-select-deselect").chosen({allow_single_deselect:true});

		//联动select事件（点击选择商圈）
		$("#provinceId").change(function(){
			var provinceId = $("#provinceId").val();
			var citySelect = $("#cityId");
			var districtSelect =$("#district");
			citySelect.empty().append("<option value=''></option>").append("<option value=''>全部</option>");
			var areaSelect = $("#areaId");
			areaSelect.empty().append("<option value=''></option>").append("<option value=''>全部</option>");
			districtSelect.empty().append("<option value=''></option>").append("<option value=''>全部</option>");
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
			districtSelect.trigger("liszt:updated");
		});
		$("#cityId").change(function(){
			var cityId = $("#cityId").val();
			var areaSelect = $("#areaId");
			var districtSelect =$("#district");
			areaSelect.empty().append("<option value=''></option>").append("<option value=''>全部</option>");
			districtSelect.empty().append("<option value=''></option>").append("<option value=''>全部</option>");
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
			districtSelect.trigger("liszt:updated");
		});

		$("#areaId").change(function(){
			var areaId = $("#areaId").val();
			var districtSelect = $("#district");
			districtSelect.empty().append("<option value=''></option>").append("<option value=''>全部</option>");
			var areaList = '${districtList}';
			$.each(JSON.parse(areaList), function(i, list){
				var parentId = list.areaId;
				if(parentId == areaId) {
					var value = list.businessDistrictId;
					var option = list.name;
					var label = $("<option value='"+value+"'>"+option+"</option>");
					districtSelect.append(label);
				}
			});
			districtSelect.trigger("liszt:updated");
		});


		//联动select事件(点击选择市)
		$("#provinceId1").change(function(){
			var provinceId = $("#provinceId1").val();
			var citySelect = $("#cityId1");
			var districtSelect =$("#district");
			citySelect.empty().append("<option value=''></option>").append("<option value=''>全部</option>");
			var areaSelect = $("#areaId");
			areaSelect.empty().append("<option value=''></option>").append("<option value=''>全部</option>");
			districtSelect.empty().append("<option value=''></option>").append("<option value=''>全部</option>");
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
			districtSelect.trigger("liszt:updated");
		});

		//联动select事件（点击选择区）
		$("#provinceId2").change(function(){
			var provinceId = $("#provinceId2").val();
			var citySelect = $("#cityId2");
			var districtSelect =$("#district2");
			citySelect.empty().append("<option value=''></option>").append("<option value=''>全部</option>");
			var areaSelect = $("#areaId2");
			areaSelect.empty().append("<option value=''></option>").append("<option value=''>全部</option>");
			districtSelect.empty().append("<option value=''></option>").append("<option value=''>全部</option>");
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
			districtSelect.trigger("liszt:updated");
		});
		$("#cityId2").change(function(){
			var cityId = $("#cityId2").val();
			var areaSelect = $("#areaId2");
			var districtSelect =$("#district2");
			areaSelect.empty().append("<option value=''></option>").append("<option value=''>全部</option>");
			districtSelect.empty().append("<option value=''></option>").append("<option value=''>全部</option>");
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
			districtSelect.trigger("liszt:updated");
		});
		//联动select事件（点击选择商场）
		$("#provinceId3").change(function(){
			var provinceId = $("#provinceId3").val();
			var citySelect = $("#cityId3");
			var districtSelect =$("#district3");
			var storeSelect =$("#store3");
			citySelect.empty().append("<option value=''></option>").append("<option value=''>全部</option>");
			var areaSelect = $("#areaId3");
			areaSelect.empty().append("<option value=''></option>").append("<option value=''>全部</option>");
			districtSelect.empty().append("<option value=''></option>").append("<option value=''>全部</option>");
			storeSelect.empty().append("<option value=''></option>").append("<option value=''>全部</option>");
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
			districtSelect.trigger("liszt:updated");
			storeSelect.trigger("liszt:updated");
		});
		$("#cityId3").change(function(){
			var cityId = $("#cityId3").val();
			var areaSelect = $("#areaId3");
			var districtSelect =$("#district3");
			var storeSelect =$("#store3");
			areaSelect.empty().append("<option value=''></option>").append("<option value=''>全部</option>");
			districtSelect.empty().append("<option value=''></option>").append("<option value=''>全部</option>");
			storeSelect.empty().append("<option value=''></option>").append("<option value=''>全部</option>");
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
			districtSelect.trigger("liszt:updated");
			storeSelect.trigger("liszt:updated");
		});
		$("#areaId3").change(function(){
			var areaId = $("#areaId3").val();
			var districtSelect = $("#district3");
			var storeSelect =$("#store3");
			districtSelect.empty().append("<option value=''></option>").append("<option value=''>全部</option>");
			storeSelect.empty().append("<option value=''></option>").append("<option value=''>全部</option>");
			var areaList = '${districtList}';
			$.each(JSON.parse(areaList), function(i, list){
				var parentId = list.areaId;
				if(parentId == areaId) {
					var value = list.businessDistrictId;
					var option = list.name;
					var label = $("<option value='"+value+"'>"+option+"</option>");
					districtSelect.append(label);
				}
			});
			districtSelect.trigger("liszt:updated");
			storeSelect.trigger("liszt:updated");
		});
		$("#district3").change(function(){
			var districtId = $("#district3").val();
			var storeSelect = $("#store3");
			storeSelect.empty().append("<option value=''></option>").append("<option value=''>全部</option>");
			var storeList = '${storeList}';
			$.each(JSON.parse(storeList), function(i, list){
				var parentId = list.businessDistrictId;
				if(parentId == districtId) {
					var value = list.storeId;
					var option = list.name;
					var label = $("<option value='"+value+"'>"+option+"</option>");
					storeSelect.append(label);
				}
			});
			storeSelect.trigger("liszt:updated");
		});


		//日期框
		$('.date-picker').datepicker();

		//下拉框
		$(".chzn-select").chosen();
		$(".chzn-select-deselect").chosen({allow_single_deselect:true});

		//复选框
		$('table th input:checkbox').on('click' , function(){
			var that = this;
			$(this).closest('table').find('tr > td:first-child input:checkbox')
					.each(function(){
						this.checked = that.checked;
						$(this).closest('tr').toggleClass('selected');
					});

		});

		$('#rangeType').change(function () {
			$("#provinceId").val("");
			$("#provinceId1").val("");
			$("#provinceId2").val("");
			$("#provinceId3").val("");

			if($(this).val()==""){
				//样式
				$(".city").css("display","none");
				$(".area").css("display","none");
				$(".dis").css("display","none");
				$(".store").css("display","none");
			}
			if($(this).val()==1){//市
				$(".city").css("display","inline-block");
				$(".area").css("display","none");
				$(".dis").css("display","none");
				$(".store").css("display","none");
			}
			if($(this).val()==2){//区
				$(".city").css("display","none");
				$(".area").css("display","inline-block");
				$(".dis").css("display","none");
				$(".store").css("display","none");
			}
			if($(this).val()==3){//商圈
				$(".city").css("display","none");
				$(".area").css("display","none");
				$(".dis").css("display","inline-block");
				$(".store").css("display","none");
			}
			if($(this).val()==4){//商场
				$(".city").css("display","none");
				$(".area").css("display","none");
				$(".dis").css("display","none");
				$(".store").css("display","inline-block");
			}
		})

	});
</script>
</body>
</html>