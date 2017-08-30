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
	<!-- 引入 图片预览功能 -->
	<link rel="stylesheet" type="text/css" href="plugins/fancyBox/jquery.fancybox.css">
	<script type="text/javascript" src="plugins/fancyBox/jquery.fancybox.pack.js"></script>
<script type="text/javascript">

	$(function() {

		//日期框
		$('.date-picker').datepicker();
		$(".fancybox").fancybox({
			helpers: {
				title: {
					type: 'inside'
				}
			}
		});

	});

</script>	

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

		//更改图片
		function changeImg(){
			$("#fileInput").trigger("click");
		}

		//更改图片
		function changeImg2(){
			$("#fileInput2").trigger("click");
		}


		//保存
		function save(){
			
			if($("#title").val()==""){
				$("#title").tips({
					side:3,
		            msg:'请输入名称',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#title").focus();
				return false;
			}
			
			var pro = $("#provinceId").val();
			var city = $("#cityId").val();
			var area = $("#areaId").val();
			if(pro==""||city==""||area==""){
				$("#provinceId").tips({
					side:3,
					msg:'请选择区域',
					bg:'#AE81FF',
					time:2
				});
				$("#provinceId").focus();
				return false;
			}
			
			//品类
			if($("#ypBaseCategoryId").val()==""){
				$("#ypBaseCategoryId").tips({
					side:3,
		            msg:'请先去品类管理模块添加品类',
		            bg:'#AE81FF',
		            time:2
		        });
				alert("请先去品类管理模块添加品类");
				return false;
			}
			
			if($("#star").val()==""){
				$("#star").tips({
					side:3,
		            msg:'请输入星级',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#star").focus();
				return false;
			}
			
			if($("#desc").val()==""){
				$("#desc").tips({
					side:3,
		            msg:'请输入星级',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#desc").focus();
				return false;
			}
			
			
			//乘车路线
			if($("#bus").val()=="" && $("#metro").val()==""){
				$("#metro").tips({
					side:3,
		            msg:'请在地铁或者公交中填写乘车路线',
		            bg:'#AE81FF',
		            time:3
		        });
				$("#metro").focus();
				return false;
			}
			if($("#metro").val().indexOf(";")>-1){
				$("#metro").tips({
					side:3,
		            msg:'请不要在地铁中输入分号',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#metro").focus();
				return false;
			}
			if($("#bus").val().indexOf(";")>-1){
				$("#bus").tips({
					side:3,
		            msg:'请不要在公交中输入分号',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#bus").focus();
				return false;
			}
			
			if($("#shoppingDesc").val()==""){
				$("#shoppingDesc").tips({
					side:3,
		            msg:'请输入简介',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#shoppingDesc").focus();
				return false;
			}
			
			
			 if($("#address").val()==""||$.trim($("#address").val())=="" ){
	             $("#address").tips({
	                 side:3,
	                 msg:'请输入地址',
	                 bg:'#AE81FF',
	                 time:2
	             });
	             $("#address").focus();
	             return false;
	         }
	       
	         
			var star = $('#star').val();
			if(isNaN(Number(star))){
				$("#star").tips({
					side:3,
		            msg:'请输入数字！',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#star").focus();
				return false;
			}
			//标题
				var title = $('#title').val();
				if(title.length>20){
					$("#title").tips({
						side:3,
			            msg:'名称不能超过20个字！',
			            bg:'#AE81FF',
			            time:2
			        });
					$("#title").focus();
					return false;
				}
			
			//推荐理由
				var desc = $('#desc').val();
				if(desc.length>100){
					$("#desc").tips({
						side:3,
			            msg:'推荐理由不能超过100个字！',
			            bg:'#AE81FF',
			            time:2
			        });
					$("#desc").focus();
					return false;
				}
			
			//简介
				var shoppingDesc = $('#shoppingDesc').val();
				if(shoppingDesc.length>100){
					$("#shoppingDesc").tips({
						side:3,
			            msg:'简介不能超过100个字！',
			            bg:'#AE81FF',
			            time:2
			        });
					$("#shoppingDesc").focus();
					return false;
				}
			
		
			
			$("#latlng").val($("#lonlat").val());

			// 提交表单
			$('#usersForm').submit();
			  $("#zhongxin").hide();
			  $("#zhongxin2").show(); 
		}
			
	
	</script>

</head>
<body>

<form action="shopping/cateEdit.do" name="usersForm" id="usersForm" method="post" enctype="multipart/form-data">	
	<input type="hidden" id="latlng" name="latlng" value="">
	<input type="hidden"  name="consultationShoppingId" value="${cate.consultationShoppingId }">
	<div id="zhongxin" >
		<table id="table_report" class="table table-striped table-bordered table-hover" style="overflow:scroll;">
			 <tr>
	      <th>资讯类型:</th>
          <td>
            <select class="chzn-select" name="typeId" id="typeId"  class="chzn-select" style="vertical-align:top;width: 115px">                                      	
             	<option value="${info.consultationTypeId}">${info.typeName }</option>
            </select>
          </td>
        </tr>
       <tr>
	      <th>城市:</th>
          <td>
            <select  name="provinceId" id="provinceId" onchange="select1()"  class="chzn-select" style="vertical-align:top;width: 115px" >             		
              <c:forEach items="${provinceList}" var="district">
                <option value="${district.provinceId}" <c:if test="${cate.province.provinceId==district.provinceId}">selected="selected"</c:if>>${district.provinceName}</option>
              </c:forEach> 
            </select>
            <select  name="cityId" id="cityId"  onchange="select2()" class="chzn-select" style="vertical-align:top;width: 115px">
              <option value="${cate.city.cityId }" selected="selected">${cate.city.cityName}</option> 
            </select>
            <select  name="areaId" id="areaId"  onchange="select3()" class="chzn-select" style="vertical-align:top;width: 115px">
              <option value="${cate.area.areaId }" selected="selected">${cate.area.areaName}</option>                          
            </select>
            <select  name="businessDistrictId" id="businessId"   class="chzn-select" style="vertical-align:top;width: 115px">
            	<c:choose>
            		<c:when test="${ not empty cate.businessDistrict.businessDistrictId}">
  	            		<option value="${cate.businessDistrict.businessDistrictId }" selected="selected">${cate.businessDistrict.name}</option>                          
            		</c:when>
            		<c:otherwise>
            			<option value=" ">暂无商圈</option>
            		</c:otherwise>
            	</c:choose>
            </select>
          </td>
        </tr>
        <tr>
          <th>名称:</th>
          <td>
            <input type="text" style="width: 400px" name="name" id="title" value="${cate.name }" placeholder="这里输入名称"  />
          </td>
        </tr>
        <tr>
          <th>品类:</th>
          <td>
				<select name="ypBaseCategoryId" class="chzn-select" style="vertical-align:top;width: 115px" id="ypBaseCategoryId">
				<c:choose>
					<c:when test="${not empty foodList}">
						<c:forEach items="${foodList}" var="list">
							<option value="${list.id}" <c:if test="${cate.asYpBaseCategory.id==list.id}">selected="selected"</c:if>>${list.name }</option>				
						</c:forEach>					
					</c:when>
					<c:otherwise>
						<option value="">没有品类分类</option>		
					</c:otherwise>
				</c:choose>					
				</select>
          </td>
        </tr>
        <tr>
          <th>推荐指数:</th>
        		<td><select name="recommendLevel" id="star" class="chzn-select"
						style="vertical-align: top; width: 115px">
						<option value="1" <c:if test="${cate.recommendLevel==1}">selected="selected"</c:if>>1</option>
						<option value="2" <c:if test="${cate.recommendLevel==2}">selected="selected"</c:if>>2</option>
						<option value="3" <c:if test="${cate.recommendLevel==3}">selected="selected"</c:if>>3</option>
						<option value="4" <c:if test="${cate.recommendLevel==4}">selected="selected"</c:if>>4</option>
						<option value="5" <c:if test="${cate.recommendLevel==5}">selected="selected"</c:if>>5</option>
					</select>
					</td>
        </tr>  
        <tr>
          <th>推荐理由:</th>
          <td><textarea  name="recommendResult" id="desc"  placeholder="这里输入推荐理由,最多可输入100个字" style="width: 400px;height: 80px">${cate.recommendResult}</textarea></td>
        </tr>
        <tr>
          <th>地铁路线:</th>
          <td><textarea  name="metro" id="metro" placeholder="这里输入地铁路线,请不要包含分号" style="width: 400px;height: 100px">${metro}</textarea>
        </tr>
         <tr>
          <th>公交路线:</th>
          <td><textarea  name="bus" id="bus" placeholder="这里输入公交路线,请不要包含分号" style="width: 400px;height: 100px">${bus}</textarea></td>
        </tr>     
        <tr>
          <th>简介:</th>
          <td><textarea name="shoppingDesc" id="shoppingDesc" placeholder="这里输入简介,最多可输入100个字" style="width: 400px;height: 150px">${cate.shoppingDesc}</textarea></td>
        </tr>
      	<tr>
	          <th>地址:</th>
	          <td>
	            <div id="l-map"></div>
	            <input type="text" style="width:90%;" name="address" id="address" value="${cate.address }" placeholder="这里输入地址" title="地址" />
	            <input type="hidden" name="lng" id="lng" value="${cate.lng}" />
	            <input type="hidden" name="lat" id="lat" value="${cate.lat}" />
	            <div id="searchResultPanel" style="border:1px solid #C0C0C0;width:150px;height:auto; display:none;"></div>
	          </td>
          </tr>
			<tr>
				<td>封面图:</td>
				<td>				
					<c:if test="${cate != null && cate.coverImg != '' && cate.coverImg != null }">
						<a id="imgBox" class="has" href="<%=httpUrl%>${cate.coverImg}" title="${cate.coverImg}">
							<img src="<%=httpUrl%>${cate.coverImg}" alt="${cate.coverImg}" width="150" id="imgHref" />
						</a>
						
							<input type="button" class="btn btn-mini btn-danger" value="更改" onclick="changeImg()" id="chImg" />
							<input type="file" id="fileInput" name="file" style="display:none;" />
						
					</c:if>
					<input id="url" name="coverImgg" type="hidden" />
				</td>
			</tr>
			<tr>
				<td colspan="2"><span style="color: red;font-size:15px; margin-left: 100px;" >注:图片尺寸 宽:220 PX,高:220 PX</span></td>
			</tr>
            <tr height="45px" id="operaArea">
                <td style="text-align: center;" colspan="2">
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
	
	

	
	
	
	//封面图上传
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


		//单选框
		$(".chzn-select").chosen();
		$(".chzn-select-deselect").chosen({allow_single_deselect:true});



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

		//标题
		$("#title").blur(function(){	
			var title = $('#title').val();
			if(title.length>20){
				$("#title").tips({
					side:3,
		            msg:'名称不能超过20个字！',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#title").focus();
				return false;
			}
		});
		
		//推荐理由
		$("#desc").blur(function(){	
			var desc = $('#desc').val();
			if(desc.length>100){
				$("#desc").tips({
					side:3,
		            msg:'推荐理由不能超过100个字！',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#desc").focus();
				return false;
			}
		});
		
		//简介
		$("#shoppingDesc").blur(function(){	
			var shoppingDesc = $('#shoppingDesc').val();
			if(shoppingDesc.length>100){
				$("#shoppingDesc").tips({
					side:3,
		            msg:'简介不能超过100个字！',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#shoppingDesc").focus();
				return false;
			}
		});
		
		
		//星级
		$("#star").blur(function(){	
			var star = $('#star').val();
			if(isNaN(Number(star))){
				$("#star").tips({
					side:3,
		            msg:'请输入数字！',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#star").focus();
				return false;
			}
		});
		
		//地铁
		$("#metro").blur(function(){
		if($("#metro").val().indexOf(";")>-1){
			$("#metro").tips({
				side:3,
	            msg:'请不要在地铁中输入分号',
	            bg:'#AE81FF',
	            time:2
	        });
			$("#metro").focus();
			return false;
			}
		});
		
		//公交
		$("#bus").blur(function(){
		if($("#bus").val().indexOf(";")>-1){
			$("#bus").tips({
				side:3,
	            msg:'请不要在公交中输入分号',
	            bg:'#AE81FF',
	            time:2
	        });
			$("#bus").focus();
			return false;
			}	
		});
		
		$("#star").blur(function(){	
			var star = $('#star').val();
			if(star>5||star<1){
				$("#star").tips({
					side:3,
		            msg:'请输入1到5之间',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#star").focus();
				return false;
			}
		});
		
		jQuery(document).ready(function(){
			select1();
			
			//品类
			if($("#ypBaseCategoryId").val()==""){
				$("#ypBaseCategoryId").tips({
					side:3,
		            msg:'请先去品类管理模块添加品类',
		            bg:'#AE81FF',
		            time:2
		        });
				alert("请先去品类管理模块添加品类");
				return false;
			}
			
		});
		
		 function select1() {
		       var cityId = $("#cityId").val();
		        $("#cityId").empty();
		        $.ajax(
		        {
		            type: "post",
		            url: "cate/city",
		            data: { "provinceId":$('#provinceId').val() },
		            success: function (msg) { 
		                for (var i = 0; i < msg.length; i++) {
		            		$("#cityId").append("<option value=" + msg[i].cityId + ">" + msg[i].cityName + "</option>");  
		            	   	if(cityId == msg[i].cityId) {
		            	   		var options = $("#cityId").find("option");
		            	   		options.eq(i).attr('selected','selected');
							}
		            	    $("#cityId").trigger("liszt:updated");
		                }           
		                select2();
		            }
		        });
		    };
		    
		    function select2() {
			    var areaId = $("#areaId").val();
		    	$("#areaId").empty();
		        $.ajax(
		        {
		            type: "post",
		            url: "cate/area",
		            data: { "cityId":$('#cityId').val() },
		            success: function (msg) {
		                for (var i = 0; i < msg.length; i++) {
		                        
		                    $("#areaId").append("<option value=" + msg[i].areaId + ">" + msg[i].areaName + "</option>");
		                  	if(areaId == msg[i].areaId) {
		                  		var options = $("#areaId").find("option");
		                  		options.eq(i).attr('selected','selected');
							} 
		                  	 $("#areaId").trigger("liszt:updated");
		                }
		                select3();
		            }
		        });
		    };
		    
		    function select3() {
			    var businessId = $("#businessId").val();
		        $("#businessId").empty();

		        $.ajax(
		        {
		            type: "post",
		            url: "cate/business",
		            data: { "areaId":$('#areaId').val() },
		            success: function (msg) {
		            	if(msg==""){
		            		 $("#businessId").append("<option value=" + " " + ">" + "暂无商圈 "+ "</option>");
		            		 $("#businessId").trigger("liszt:updated");
		            	}else{
		            		
		                for (var i = 0; i < msg.length; i++) {
		                    $("#businessId").append("<option value=" + msg[i].businessDistrictId + ">" + msg[i].name + "</option>");
		                    
		                  	if(businessId == msg[i].businessDistrictId) {
		                  		var options = $("#businessId").find("option");
		                  		options.eq(i).attr('selected','selected');
							} 
		                  	 $("#businessId").trigger("liszt:updated");
		                	}
		            	}
		            }
		        });
		    };
		 
			 
		
</script>
<script type="text/javascript" src="http://api.map.baidu.com/api?v=2.0&ak=jGRH9RCPqXgfsrr2jyMLzhk1jKactdvj"></script>
<style type="text/css">
    #l-map{height:500px;width:90%;}
    #r-result{width:100%;}
</style>

<script type="text/javascript">
//百度地图API功能
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

</script>

</body>
</html>