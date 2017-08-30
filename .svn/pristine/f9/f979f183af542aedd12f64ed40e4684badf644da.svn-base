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
<html lang="en" ng-app="app">
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
	<script src="static/js/angular.min.js"></script>
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
		.aaa {
			display: inline-block;
			margin-top: 6px;
		}
		.ng-cloak{
			display: none
		}
	</style>

	<script type="text/javascript">
		/**$(top.hangge());**/

		$(function() {
			$(".chzn-select").chosen();
			$(".chzn-select-deselect").chosen({allow_single_deselect:true});
		});


	</script>
</head>
<body ng-controller="myCtrl">

<form action="link/activityLink/updateCouponLink.do" name="usersForm" id="usersForm" method="post" enctype="multipart/form-data">
	<input type="hidden" name="itemId" id="itemId" value="">
	<input type="hidden" name="activityLinkId" value="{{asActivityLink.activityLinkId}}"/>
	<%--<input type="hidden" name="link" value="${asActivityLink.link}"/>--%>
	<%--<input type="hidden" name="linkType" value="${asActivityLink.linkType}"/>--%>
	<div id="zhongxin" >
		<table id="table_report" class="table table-striped table-bordered table-hover" style="overflow:scroll;">
			<tr height="45px">
				<td width="60px">链接名称:</td>
				<td>
					<input type="text" style="width:370px;" name="linkName" id="linkName" value="{{asActivityLink.linkName}}" placeholder="这里输入链接名称" title="链接名称" />
				</td>
			</tr>
			<tr height="45px">
				<td width="60px">范围类型:</td>
				<td>
					<select ng-change="selectType(type)" ng-model="type" ng-init="type = initType()"  data-placeholder="请选择范围" style="vertical-align:top;width: 90px">
						<option value="1" ng-selected="asActivityLink.rangeType == 1">市</option>
						<option value="2" ng-selected="asActivityLink.rangeType == 2" >区</option>
						<option value="3" ng-selected="asActivityLink.rangeType == 3" >商圈</option>
						<option value="4" ng-selected="asActivityLink.rangeType == 4" >商场</option>
						<option value="5" ng-selected="asActivityLink.rangeType == 5" >商户</option>
					</select>
				</td>
			</tr>
			<tr height="45px">
				<td width="60px">区域:</td>
				<td>
					<!-- 市 -->
					<span class="store" ng-if="rangeType == 1">
						<span class="aaa">省份:</span>
						<span>
							<select ng-init="p = initProvince()" ng-model="p" ng-change="selectProvince(p)"  name="province" id="province" data-placeholder="请选择省份" style="vertical-align:top;width: 90px">
								<!--  -->
								<option ng-repeat="province in provinceList track by $index" value="{{province.provinceId }}"  ng-cloak class="ng-cloak">{{province.provinceName }}</option>
            				</select>
						</span>

						<span>城市:</span>
						<span>
							<select ng-init="c = initCity()" ng-model="c" ng-change="selectCity(c)" name="city" id="city" data-placeholder="请选择城市" style="vertical-align:top;width: 90px">
								<option ng-repeat="city in cityList track by $index" value="{{city.cityId }}" ng-cloak class="ng-cloak">{{city.cityName }}</option>
							</select>
						</span>

					</span>
				
					<!-- 区 -->
					<span class="store" ng-if="rangeType == 2">
						<span class="aaa">省份:</span>
						<span>
							<select ng-init="p = initProvince()" ng-model="p" ng-change="selectProvince(p)" name="province" id="province" data-placeholder="请选择省份" style="vertical-align:top;width: 90px">
								
								<option ng-repeat="province in provinceList track by $index" value="{{province.provinceId }}" ng-cloak class="ng-cloak" >{{province.provinceName }}</option>
            				</select>
						</span>

						<span>城市:</span>
						<span>
							<select ng-init="c = initCity()" ng-model="c" ng-change="selectCity(c)" name="city" id="city" data-placeholder="请选择城市" style="vertical-align:top;width: 90px">
								<option ng-repeat="city in cityList track by $index" value="{{city.cityId }}" ng-cloak class="ng-cloak" >{{city.cityName }}</option>
							</select>
						</span>

						<span>区域:</span>
						<span>
							<select ng-init="a = initArea()" ng-model="a"  name="area" id="area" data-placeholder="请选择县区" style="vertical-align:top;width: 90px">
								<option ng-repeat="area in areaList track by $index" value="{{area.areaId }}" ng-cloak class="ng-cloak" >{{area.areaName }}</option>
							</select>
						</span>
					</span>
					<!-- 商圈 -->
					<span class="store" ng-if="rangeType == 3">
						<span class="aaa">省份:</span>
						<span>
							<select ng-init="p = initProvince()" ng-model="p" ng-change="selectProvince(p)" name="province" id="province" data-placeholder="请选择省份" style="vertical-align:top;width: 90px">
								
								<option ng-repeat="province in provinceList track by $index" value="{{province.provinceId }}" ng-cloak class="ng-cloak" >{{province.provinceName }}</option>
            				</select>
						</span>

						<span>城市:</span>
						<span>
							<select ng-init="c = initCity()" ng-model="c" ng-change="selectCity(c)" name="city" id="city" data-placeholder="请选择城市" style="vertical-align:top;width: 90px">
								<option ng-repeat="city in cityList track by $index" value="{{city.cityId }}" ng-cloak class="ng-cloak" >{{city.cityName }}</option>
							</select>
						</span>

						<span>区域:</span>
						<span>
							<select ng-init="a = initArea()" ng-model="a" ng-change="selectArea(a)" name="area" id="area" data-placeholder="请选择县区" style="vertical-align:top;width: 90px">
								<option ng-repeat="area in areaList track by $index" value="{{area.areaId }}"  ng-cloak class="ng-cloak">{{area.areaName }}</option>
							</select>
						</span>

						<span>商圈:</span>
						<span>
							<select name="district" id="district" data-placeholder="请选择商圈" style="vertical-align:top;width: 90px">
								<option ng-repeat="district in districtList track by $index" value="{{district.businessDistrictId }}" ng-selected="district.businessDistrictId == districtId" ng-cloak class="ng-cloak">{{district.name }}</option>
							</select>
						</span>
					</span>
				
				
					<!-- 商场 -->
					<span class="store" ng-if="rangeType == 4">
						<span class="aaa">省份:</span>
						<span>
							<select ng-init="p = initProvince()" ng-model="p" ng-change="selectProvince(p)" name="province" id="province" data-placeholder="请选择省份" style="vertical-align:top;width: 90px">
								
								<option ng-repeat="province in provinceList track by $index" value="{{province.provinceId }}"  ng-cloak class="ng-cloak">{{province.provinceName }}</option>
            				</select>
						</span>

						<span>城市:</span>
						<span>
							<select ng-init="c = initCity()" ng-model="c" ng-change="selectCity(c)" name="city" id="city" data-placeholder="请选择城市" style="vertical-align:top;width: 90px">
								<option ng-repeat="city in cityList track by $index" value="{{city.cityId }}"  ng-cloak class="ng-cloak">{{city.cityName }}</option>
							</select>
						</span>

						<span>区域:</span>
						<span>
							<select ng-init="a = initArea()" ng-model="a" ng-change="selectArea(a)" name="area" id="area" data-placeholder="请选择县区" style="vertical-align:top;width: 90px">
								<option ng-repeat="area in areaList track by $index" value="{{area.areaId }}" ng-cloak class="ng-cloak" >{{area.areaName }}</option>
							</select>
						</span>

						<span>商圈:</span>
						<span>
							<select ng-init="d = initDistrict()" ng-model="d" ng-change="selectDistrict(d)" name="district" id="district" data-placeholder="请选择商圈" style="vertical-align:top;width: 90px">
								<option ng-repeat="district in districtList track by $index" value="{{district.businessDistrictId }}" ng-selected="district.businessDistrictId == districtId" ng-cloak class="ng-cloak">{{district.name }}</option>
							</select>
						</span>

						<span>商场:</span>
						<span>
							<select name="store" id="store" data-placeholder="请选择商场" style="vertical-align:top;width: 90px">
								<option ng-repeat="store in storeList track by $index" value="{{store.storeId }}" ng-selected="store.storeId == storeId" ng-cloak class="ng-cloak">{{store.name }}</option>
							</select>
						</span>
					</span>
					<span class="shop" ng-if="rangeType == 5">
						<span>
							<span style="float: left;margin-top: 8px">商户:</span>
							<select name="shop" id="shop" data-placeholder="请选择商户" style="vertical-align:top;width: 90px">
								
									<option ng-cloak class="ng-cloak" ng-repeat="shopOwnerInfo in shopOwnerInfosList track by $index" value="{{shopOwnerInfo.shopId}}" ng-selected="shopOwnerInfo.shopId ==asActivityLink.itemId">{{shopOwnerInfo.shopName}}</option>
							</select>
						</span>
					</span>
				</td>
			</tr>
			
			<tr height="45px">
				<td class="center" colspan="2">
					<a class="btn btn-mini btn-primary" ng-click="save();">保存</a>
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
</body>
<!-- 引入 -->
<script type="text/javascript">window.jQuery || document.write("<script src='static/js/jquery-1.9.1.min.js'>\x3C/script>");</script>
<script src="static/js/bootstrap.min.js"></script>
<script src="static/js/ace-elements.min.js"></script>
<script src="static/js/ace.min.js"></script>
<script type="text/javascript" src="static/js/bootstrap-datepicker.min.js"></script><!-- 日期框 -->
<script type="text/javascript" src="static/js/chosen.jquery.min.js"></script><!-- 下拉框 -->
<script type="text/javascript" src="static/js/bootbox.min.js"></script><!-- 确认窗口 -->

<script type="text/javascript" src="static/js/chosen.jquery.min.js"></script><!-- 下拉框 -->
<script type="text/javascript">
	var module = angular.module("app",[]);
	module.controller("myCtrl",function($scope){
		//回显效果
		$scope.initType = function(){
			return $scope.asActivityLink.rangeType+"";
		}
		$scope.initProvince = function(){
			return $scope.provinceId+"";
		}
		$scope.initCity = function(){
			return $scope.cityId+"";
		}
		$scope.initArea = function(){
			return $scope.areaId+"";
		}
		$scope.initDistrict = function(){
			return $scope.districtId+"";
		}
		$scope.initStore = function(){
			return $scope.storeId+"";
		}
		
		
		
		//选择范围
		$scope.selectType = function(type){
			console.log(type);
			$scope.rangeType = type;
		}
		
		//选择省份联动
		$scope.selectProvince = function(pid){
			$scope.getCitys(pid);
		}
		//选择市联动
		$scope.selectCity = function(cid){
			$scope.getAreas(cid);
		}
		//选择区联动
		$scope.selectArea = function(aid){
			$scope.getDistricts(aid);
		}
		$scope.selectDistrict = function(did){
			$scope.getStores(did);
		}
		
		//获取省份
		$scope.getProvinces = function(){
			$scope.provinceList = JSON.parse('${provinceList}');
			$scope.getCitys($scope.provinceId);
		}
		//根据默认省份id获取市
		$scope.getCitys = function(pid){
			var citys = [];
			angular.forEach(JSON.parse('${cityList}'),function(value,index){
				if(pid == value.provinceId){
					citys.push(value);
				}
				
			})
			$scope.cityList = citys;
			$scope.getAreas($scope.cityId)
		}
		//根据默认市id获取区
		$scope.getAreas = function(cid){
			var areas = [];
			angular.forEach(JSON.parse('${areaList}'),function(value,index){
				if(cid == value.cityId){
					areas.push(value);
				}
				
			})
			$scope.areaList = areas;
			$scope.getDistricts($scope.areaId);
		}
		//根据默认区id获取商圈
		$scope.getDistricts = function(aid){
			var districts = [];
			angular.forEach(JSON.parse('${districtList}'),function(value,index){
				if(aid == value.areaId){
					districts.push(value);
				}
				
			})
			$scope.districtList = districts;
			$scope.getStores($scope.districtId);
		}
		//根据默认商圈id获取商场
		$scope.getStores = function(did){
			var stores = [];
			angular.forEach(JSON.parse('${storeList}'),function(value,index){
				if(did == value.businessDistrictId){
					stores.push(value);
				}
				
			})
			$scope.storeList = stores;
		}
		
		$scope.asActivityLink = JSON.parse('${asActivityLink}');
		
		
		//console.log('${shopOwnerInfosList}');
		$scope.shopOwnerInfosList = JSON.parse('${shopOwnerInfosList}');
		
		$scope.provinceId = '${provinceId}'==''?'':JSON.parse('${provinceId}');
		$scope.cityId = '${cityId}'==''?'':JSON.parse('${cityId}');
		$scope.areaId = '${areaId}'==''?'':JSON.parse('${areaId}');
		$scope.districtId = '${districtId}'==''?'':JSON.parse('${districtId}');
		$scope.storeId = '${storeId}'==''?'':JSON.parse('${storeId}');
		
		$scope.rangeType = $scope.asActivityLink.rangeType;
		//调用获取省份方法
		$scope.getProvinces();
		
		$scope.save = function(){
			var reg = /^\+?[1-9][0-9]*$/;
			
			var city = $("#city").val();
			var area = $("#area").val();
			var district = $("#district").val();
			var store = $("#store").val();
			
			if( city != undefined && !reg.test(city)){
				$("#city").tips({
					side:3,
					msg:'选择城市',
					bg:'#AE81FF',
					time:2
				});
				return ;
			}
			if( area != undefined && !reg.test(area)){
				$("#area").tips({
					side:3,
					msg:'选择区域',
					bg:'#AE81FF',
					time:2
				});
				return ;
			}
			if( district != undefined && !reg.test(district)){
				$("#district").tips({
					side:3,
					msg:'选择商圈',
					bg:'#AE81FF',
					time:2
				});
				return ;
			}
			if( store != undefined && !reg.test(store)){
				$("#store").tips({
					side:3,
					msg:'选择商场',
					bg:'#AE81FF',
					time:2
				});
				return ;
			}
			
			
			
			console.log(area);
			var activityLinkId = $scope.asActivityLink.activityLinkId;	
			var linkName = $("#linkName").val();
			
			var type = $scope.type ;
			var itemId = 0;
			if(type == 1){
				itemId = city;
			}else if(type == 2){
				itemId = area;
			}else if(type == 3){
				itemId = district;
			}else if(type == 4){
				itemId = store;
			}else if(type == 5){
				itemId = $("#shop").val();
			}
			var data = {};
			data.activityLinkId = activityLinkId;	
			data.linkName = linkName;
			
			data.rangeType = type;
			data.itemId = itemId;
			console.log(data);
			$.ajax({
				type: "POST",
				url: 'link/activityLink/updateCouponLink.do',
				data: data,
				dataType: "json",
				success: function(data){

					alert(data.msg)

					if(data.status == 0){
						top.Dialog.close();
					}

				},
				error:function(data){
					alert('系统繁忙')
				}
			});
		}
	})

	/* var ue = UE.getEditor('editor'); */
	/**$(top.hangge());**/
	$(function() {
		/* //单选框
		$(".chzn-select").chosen();
		$(".chzn-select-deselect").chosen({allow_single_deselect:true});

		

		//下拉框
		$(".chzn-select").chosen();
		$(".chzn-select-deselect").chosen({allow_single_deselect:true}); */

		//复选框
		$('table th input:checkbox').on('click' , function(){
			var that = this;
			$(this).closest('table').find('tr > td:first-child input:checkbox')
					.each(function(){
						this.checked = that.checked;
						$(this).closest('tr').toggleClass('selected');
					});

		});

	});
</script>
</html>