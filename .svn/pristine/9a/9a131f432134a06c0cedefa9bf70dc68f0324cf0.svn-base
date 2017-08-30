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


	<script type="text/javascript">
		$(top.hangge());

		$(function() {
			$(".chzn-select").chosen();
			$(".chzn-select-deselect").chosen({allow_single_deselect:true});
		});

		//更改图片
		function changeImg(){
			$("#fileInput").trigger("click");
		}

		//保存
		function save(){
			if($("#name").val()==""||$.trim($("#name").val())==""){
				$("#name").tips({
					side:3,
					msg:'店铺名称',
					bg:'#AE81FF',
					time:2
				});
				$("#name").focus();
				return false;
			}

			var fileType = document.getElementById("fileInput").value.substr(document.getElementById("fileInput").value.lastIndexOf(".")).toLowerCase();//获得文件后缀名
			var url = $("#url").val();
			var img = $("#imgHref").attr("src");
			if (!img || url) {
				if (fileType != '.gif' && fileType != '.png' && fileType != '.jpg' && fileType != '.jpeg') {
					$("#fileInput").tips({
						side : 3,
						msg : '请上传图片格式的文件',
						bg : '#AE81FF',
						time : 2
					});
					$("#fileInput").val('');
					document.getElementById("fileInput").files[0] = '请选择图片';
					return;
				}
			}

			var reg=/^((https|http|ftp|rtsp|mms)?:\/\/)[^\s]+/;
			if($("#site").val()!=null && $("#site").val()!=""){
				if(!reg.test($("#site").val())){
					$("#site").tips({
						side:3,
						msg:'格式有误!(如：https://www.baidu.com)',
						bg:'#AE81FF',
						time:2
					});
					$("#site").focus();
					return false;
				}
			}

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
			if($("#businessDistrictId").val()==""||$.trim($("#businessDistrictId").val())=="" ){
				$("#businessDistrictId").tips({
					side:3,
					msg:'选择商圈',
					bg:'#AE81FF',
					time:2
				});
				$("#businessDistrictId").focus();
				return false;
			}
			if($("#address").val()==""||$.trim($("#address").val())==""){
				$("#address").tips({
					side:3,
					msg:'地址',
					bg:'#AE81FF',
					time:2
				});
				$("#address").focus();
				return false;
			}


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
	<script type="text/javascript" src="http://api.map.baidu.com/api?v=2.0&ak=jGRH9RCPqXgfsrr2jyMLzhk1jKactdvj"></script>
	<style type="text/css">
		#l-map{height:500px;width:100%;}
		#r-result{width:100%;}
	</style>
</head>
<body>

<form action="consultation/navigation/updateStore.do" name="usersForm" id="usersForm" method="post">
	<input type="hidden" id="asConsultationNavigationId" name="asConsultationNavigationId" value="${asConsultationNavigation.asConsultationNavigationId}"/>
	<input type="hidden" id="type" name="type" value="${asConsultationNavigation.type}">
	<input type="hidden" id="latlng" name="latlng" value="">
	<div id="zhongxin" >
		<table id="table_report" class="table table-striped table-bordered table-hover" style="overflow:scroll;">
			<tr height="45px">
				<td>店铺名称:</td>
				<td>
					<input type="text" style="width:370px;" name="name" id="name"
						   placeholder="这里输入店铺名称" title="店铺名称" value="${asConsultationNavigation.name}"/>
				</td>
			</tr>

			<tr height="45px">
				<td>店铺分类:</td>
				<td>
					<select class="chzn-select" name="categoryId" id="categoryId">
						<c:forEach items="${ypBaseCategoryList}" var="ypBaseCategory">
							<option value="${ypBaseCategory.id}" <c:if test="${ypBaseCategory.id == asConsultationNavigation.categoryId}">selected</c:if>>${ypBaseCategory.name}</option>
						</c:forEach>
					</select>
				</td>
			</tr>

			<tr>
				<td>店铺logo:</td>
				<td>
					<c:if test="${asConsultationNavigation == null || asConsultationNavigation.logo== '' || asConsultationNavigation.logo == null }">
						<a id="imgBox" href="javascript:void(0)" style="display:none;">
							<img src="" width="150" id="imgHref" />
						</a>
						<input type="file" id="fileInput" name="fileInput" />
						<span style="color: red; width: 50px;" id="msgDiv" >注： 图片格式支持 : gif/png/jpg/jpeg    尺寸规格180 * 180</span>
						<span style="color: red; width: 50px;" id="msgDivScreen" >注： 图片格式支持 : gif/png/jpg/jpeg </span>
					</c:if>
					<c:if test="${asConsultationNavigation != null && asConsultationNavigation.logo != '' && asConsultationNavigation.logo != null }">
						<a id="imgBox" href="<%=httpUrl%>${asConsultationNavigation.logo}" title="${asConsultationNavigation.logo}">
							<img src="<%=httpUrl%>${asConsultationNavigation.logo}" alt="${asConsultationNavigation.logo}" width="150" id="imgHref" />
						</a>
							<input type="button" class="btn btn-mini btn-danger" value="更改" onclick="changeImg()" id="chImg" />
							<input type="file" id="fileInput" name="fileInput" style="display:none;" />
					</c:if>
					<input id="url" name="img" type="hidden" />
				</td>
			</tr>
			<tr height="45px">
				<td>官网链接：</td>
				<td>
					<input  type="text" name="site" id="site"  style="width: 370px" placeholder="这里输入官网链接" title="官网链接" value="${asConsultationNavigation.site}"/>
					<span style="color: red">(如：https://www.baidu.com)</span>
				</td>
			</tr>
			<tr height="45px">
				<td>区域:</td>
				<td style="line-height: 32px">
					<span style="float: left;margin-top: 5px">
						省份:<select name="provinceId" id="provinceId" data-placeholder="请选择省份" style="vertical-align:top;width: 115px">
                                  <option value="">全部</option>
								  <c:forEach items="${provinceList}" var="province">
									  <option value="${province.provinceId }" <c:if test="${province.provinceId == asConsultationNavigation.provinceId}">selected</c:if>>${province.provinceName }</option>
								  </c:forEach>
					        </select>
					</span>
					<span style="float: left;margin-left: 5px;margin-top: 5px">
								城市:<select  name="cityId" id="cityId" data-placeholder="请选择城市" style="vertical-align:top;width: 115px;">
            					</select>
					</span>
					<span style="float: left;margin-left: 5px;margin-top: 5px">
								区域:<select name="areaId" id="areaId" data-placeholder="请选择县区" style="vertical-align:top;width: 115px">
            					</select>
					</span>
					<span style="float: left;margin-left: 5px;margin-top: 5px">
								商圈:<select name="businessDistrictId" id="businessDistrictId" data-placeholder="请选择商圈" style="vertical-align:top;width: 115px">
            					</select>
					</span>
				</td>
			</tr>
			<tr height="45px">
				<td>店铺地址:</td>
				<td>
					<div id="l-map"></div>
					<input type="text" style="width:90%;" name="address" id="address" value="${asConsultationNavigation.address}"  placeholder="这里输入地址" title="地址" />
					<input type="hidden" name="lng" id="lng" value="${asConsultationNavigation.lng}"/>
					<input type="hidden" name="lat" id="lat" value="${asConsultationNavigation.lat}"/>
					<div id="searchResultPanel" style="border:1px solid #C0C0C0;width:150px;height:auto; display:none;"></div>
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
<!-- 压缩图片 -->

<link rel="stylesheet" type="text/css" href="plugins/fancyBox/jquery.fancybox.css">
<script type="text/javascript" src="plugins/fancyBox/jquery.fancybox.pack.js"></script>
<!-- 查看图片 -->
<script type="text/javascript" src="static/js/chosen.jquery.min.js"></script><!-- 下拉框 -->
<script type="text/javascript">
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
	//上传
	$('#fileInput:visible').ace_file_input({
		no_file : '请选择图片 ...',
		btn_choose : '选择',
		btn_change : '更改',
		droppable : false,
		onchange : null,
		thumbnail : false,
		before_remove : function() {
			$("#url").val("");
			$("#imgBox").attr("href", "").hide();
			$("#imgHref").attr("src", "");
			return true;
		}
	});

	new img2base64("fileInput", "url", "imgHref", "imgBox");

	$("#imgBox").fancybox({
		helpers : {
			title : {
				type : 'inside'
			}
		}
	});

	// 百度地图API功能
	function G(id) {
		return document.getElementById(id);
	}

	var map = new BMap.Map("l-map");
	map.centerAndZoom("广州",12);                   // 初始化地图,设置城市和地图级别。

	var ac = new BMap.Autocomplete(    //建立一个自动完成的对象
			{"input" : "address"
				,"location" : map
			});

	ac.addEventListener("onhighlight", function(e) {  //鼠标放在下拉列表上的事件
		var str = "";
		var _value = e.fromitem.value;
		var value = "";
		if (e.fromitem.index > -1) {
			value = _value.province +  _value.city +  _value.district +  _value.street +  _value.business;
		}
		str = "FromItem<br />index = " + e.fromitem.index + "<br />value = " + value;

		value = "";
		if (e.toitem.index > -1) {
			_value = e.toitem.value;
			value = _value.province +  _value.city +  _value.district +  _value.street +  _value.business;
		}
		str += "<br />ToItem<br />index = " + e.toitem.index + "<br />value = " + value;
		G("searchResultPanel").innerHTML = str;
	});

	var myValue;
	ac.addEventListener("onconfirm", function(e) {    //鼠标点击下拉列表后的事件
		var _value = e.item.value;
		myValue = _value.province +  _value.city +  _value.district +  _value.street +  _value.business;
		G("searchResultPanel").innerHTML ="onconfirm<br />index = " + e.item.index + "<br />myValue = " + myValue;
		setPlace();
	});

	function setPlace(){
		map.clearOverlays();    //清除地图上所有覆盖物
		function myFun(){
			var pp = local.getResults().getPoi(0).point;    //获取第一个智能搜索的结果
			map.centerAndZoom(pp, 18);
			map.addOverlay(new BMap.Marker(pp));    //添加标注
		}
		var local = new BMap.LocalSearch(map, { //智能搜索
			onSearchComplete: myFun
		});
		var myGeo = new BMap.Geocoder();
		// 将地址解析结果显示在地图上，并调整地图视野
		myGeo.getPoint(myValue, function(point){
			if (point) {
				$("#lng").val(point.lng);
				$("#lat").val(point.lat);
				local.search(myValue);
			}
		});
	}

	if($("#address").val() && $("#lng").val() && $("#lat").val()) {
		myValue = $("#address").val();
		ac.setInputValue($("#address").val());
		setPlace();
	}

	$(function() {
		if($("#provinceId").val()) {
			var provinceId = $("#provinceId").val();//19
			//var citySelect = $("#cityId");
			$("#cityId").empty().append("<option value=''>全部</option>");
			var cityList = '${cityList}';
			var cityId = '${asConsultationNavigation.cityId}';
			$.each(JSON.parse(cityList), function(i, list){
				var parentId = list.provinceId;
				if(parentId == provinceId) {
					var value = list.cityId;
					var option = list.cityName;
					var label = $("<option value='"+value+"'>"+option+"</option>");
					if(cityId == list.cityId) {
						$(label).attr("selected", "selected");
					}
					$("#cityId").append(label);
				}
			});
		}

		if($("#cityId").val()) {
			var cityId = $("#cityId").val();
			var areaSelect = $("#areaId");
			areaSelect.empty().append("<option value=''>全部</option>");
			var areaList = '${areaList}';
			var areaId = '${asConsultationNavigation.areaId}';
			$.each(JSON.parse(areaList), function(i, list){
				var parentId = list.cityId;
				if(parentId == cityId) {
					var value = list.areaId;
					var option = list.areaName;
					var label = $("<option value='"+value+"'>"+option+"</option>");
					if(areaId == list.areaId) {
						label.attr("selected", "selected");
					}
					areaSelect.append(label);
				}
			});
		}

		if($("#areaId").val()) {
			var areaId = $("#areaId").val();
			var districtSelect = $("#businessDistrictId");
			districtSelect.empty().append("<option value=''>全部</option>");
			var districtList = '${districtList}';
			var district = '${asConsultationNavigation.businessDistrictId}';
			$.each(JSON.parse(districtList), function(i, list){
				var parentId = list.areaId;
				if(parentId == areaId) {
					var value = list.businessDistrictId;
					var option = list.name;
					var label = $("<option value='"+value+"'>"+option+"</option>");
					if(district == list.businessDistrictId) {
						label.attr("selected", "selected");
					}
					districtSelect.append(label);
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
			var districtSelect =$("#businessDistrictId");
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
			var districtSelect =$("#businessDistrictId");
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
			var districtSelect = $("#businessDistrictId");
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

	});
</script>
</body>
</html>