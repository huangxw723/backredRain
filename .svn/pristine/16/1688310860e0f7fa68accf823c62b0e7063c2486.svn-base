<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.aoshi.util.PropertyUtils"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
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
	<!--提示框-->
	<script type="text/javascript" src="static/js/jquery.tips.js"></script>
	<script type="text/javascript" src="static/js/common/commonutils.js"></script>
	<!--地图插件  -->
	<!-- <script type="text/javascript" src="http://api.map.baidu.com/api?v=1.4"></script> -->
	<script src="plugins/ckeditor/ckeditor.js"></script>
	<script src="plugins/ckeditor/config.js"></script>

<script type="text/javascript">

	//初始化content编辑器
	$(function() {
		$(".chzn-select").chosen();
		$(".chzn-select-deselect").chosen({
			allow_single_deselect : true
		});
		CKEDITOR.replace('content', {
			width : 750,
			height : 300,
		});	
	});

	//保存 做验证的
	function save(status) {
		var pro = $("#provinceId").val();
		if (pro == "") {
			$("#provinceId").tips({
				side : 3,
				msg : '请选择省份',
				bg : '#AE81FF',
				time : 2
			});
			$("#provinceId").focus();
			return false;
		}
		var city = $("#cityId").val();
		if (city == "") {
			$("#cityId").tips({
				side : 3,
				msg : '请选择城市',
				bg : '#AE81FF',
				time : 2
			});
			$("#cityId").focus();
			return false;
		}
		var area = $("#areaId").val();
		if (area == "") {
			$("#areaId").tips({
				side : 3,
				msg : '请选择区域',
				bg : '#AE81FF',
				time : 2
			});
			$("#areaId").focus();
			return false;
		}
		if (status == 1) {
			$("#status").val("1")//草稿
		} else if (status == 2) {
			$("#status").val("2")//发布
		}
		if ($("#typeId").val() == "") {
			$("#typeId").tips({
				side : 3,
				msg : '请选择资讯类型',
				bg : '#AE81FF',
				time : 2
			});
			$("#typeId").focus();
			return false;
		}
		if ($("#title").val() == "") {
			$("#title").tips({
				side : 3,
				msg : '输入标题',
				bg : '#AE81FF',
				time : 2
			});
			$("#title").focus();
			return false;
		}
		
		if ($("#consultationDesc").val() == "") {
			$("#consultationDesc").tips({
				side : 3,
				msg : '输入简介',
				bg : '#AE81FF',
				time : 2
			});
			$("#consultationDesc").focus();
			return false;
		}
		
		var oEditor = CKEDITOR.instances.content;
     	var contentData = oEditor.getData();
     	if(contentData.length == 0|| contentData.trim()==""){
     		$("#content").tips({
 				side:3,
 	            msg:'内容不能为空',
 	            bg:'#AE81FF',
 	            time:2
 	        });
 			$("#content").focus();
 			return false;
     	}
     	
		
		if ($("#address").val() == "" || $.trim($("#address").val()) == "") {
			$("#address").tips({
				side : 3,
				msg : '输入地址',
				bg : '#AE81FF',
				time : 2
			});
			$("#address").focus();
			return false;
		}
		
		/* if ($("#lonlat").val() == "" || $.trim($("#lonlat").val()) == "") {
			$("#lonlat").tips({
				side : 3,
				msg : '请在地图上点击选择经纬度！',
				bg : '#AE81FF',
				time : 2
			});
			$("#lonlat").focus();
			return false;
		} */
		
		//图片
		var has = $(".has").size();
		var array4 = new Array();
		for (var i = 0; i < has; i++) {
			array4[i] = $(".has")[i].title;
		}
		$("#oldIamge").val(array4);
		//经纬度
		//$("#latlng").val($("#lonlat").val());

		$("#form").submit();
		$("#zhongxin").hide();
		$("#zhongxin2").show();
	}
</script>
</head>
<body>  
    <form class="form-horizontal" id="form" name="form" action="consultationCity/saveEdit.do" method="post">
    <input type="hidden" name="consultationCityId" id="consultationCityId" value="${obj.consultationCityId }" />
    <input type="hidden" name="visitCount" id="visitCount" value="${obj.visitCount }" />
    <input type="hidden" name="publicTime" id="publicTime" value="${obj.publicTime }" />
    <input type="hidden" name="status" id="status" value="${obj.status }" />
   <!--  <input type="hidden" name="latlng"id="latlng" > -->
    <input type="hidden" name="oldIamge" id="oldIamge" value="" />
    <div id="zhongxin">
      <table id="table_report" class="table table-striped table-bordered table-hover">
        <tr>
	      <th>资讯类型:</th>
          <td>      
            <select class="chzn-select" style="vertical-align:top;">                                      	
             	<option value="38">同城活动</option>
            </select>
            <select class="chzn-select" name="typeId" id="typeId" data-placeholder="请选择二级分类" style="vertical-align:top;">
              <option value=""></option>      
              <c:forEach items="${typeListTwo}" var="district">
                 <option value="${district.consultationTypeId}" <c:if test="${district.consultationTypeId == obj.typeId }">selected</c:if> >${district.typeName}</option>
              </c:forEach>
            </select>
            </td>
           </tr>
           
        	<tr>
					<th>城市:</th>
				<td style="line-height: 32px">
					<span style="float: left;margin-top: 5px">
						省份:<select name="provinceId" id="provinceId" data-placeholder="请选择省份" style="vertical-align:top;width: 115px">
                                  <option value="">全部</option>
								  <c:forEach items="${provinceList}" var="province">
									  <option value="${province.provinceId }" <c:if test="${province.provinceId == obj.provinceId}">selected</c:if>>${province.provinceName }</option>
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
				</td>
				</tr>
     
        <tr>
          <th>标题名称:</th>
          <td>
            <input type="text" style="width:90%;" name="title" id="title" value="${obj.title}" placeholder="这里输入标题" title="标题" />
          </td>
        </tr>
        
        <tr>
          <th>封面图:</th>
          <td>
           <c:if test="${obj == null || obj.coverImg == '' || obj.coverImg == null }">
              <a id="imgBox" href="javascript:void(0)" style="display:none;">
                <img src="" width="750" height="666" id="imgHref" />
              </a>
              <input type="file" id="fileInput" name="file" />
            </c:if>
            <c:if test="${obj != null && obj.coverImg != '' && obj.coverImg != null }">
              <a id="imgBox" class="has" href="<%=httpUrl%>${obj.coverImg}" title="${obj.coverImg}">
				 <img src="<%=httpUrl%>${obj.coverImg}" alt="${obj.coverImg}" width="750" height="666" id="imgHref"/>
			  </a>
              <input type="button" class="btn btn-mini btn-danger" value="更改" onclick="changeImg()" />
              <input type="file" id="fileInput" name="file" style="display:none;" />
            </c:if>
            <input id="url" name="img" type="hidden" />
            <font color="red">注:图片尺寸 宽:750 PX,高:666 PX</font>      
          </td>
        </tr>
        
         <tr>
          <th>简介:</th>
          <td><textarea placeholder="请输入简介，最多可输入100个字" name="consultationDesc" id="consultationDesc" style="width: 750px;resize:none;height:100px;" >${obj.consultationDesc}</textarea></td>
       	</tr>
       	
		 	<tr>
	          <th>地址:</th>
	          <td>
	            <div id="l-map"></div>
	            <input type="text" style="width:90%;" name="address" id="address" value="${obj.address }" placeholder="这里输入地址" title="地址" />
	            <input type="hidden" name="lng" id="lng" value="${obj.lng}" />
	            <input type="hidden" name="lat" id="lat" value="${obj.lat}" />
	            <div id="searchResultPanel" style="border:1px solid #C0C0C0;width:150px;height:auto; display:none;"></div>
	          </td>
          </tr>
		
			<tr>
          <th>正文内容:</th>
          <td>
	           <span><font style="color: red;font-size: 18px">注:建议字体大小设置26PX</font></span>
	           <textarea name="content" id="content">${obj.content}</textarea>
          </td>
        </tr>
        
        <tr>
          <td class="center" colspan="2">
            <a class="btn btn-mini btn-primary" onclick="save(2);">立即发布</a>
            <a class="btn btn-mini btn-primary" onclick="save(1);">保存为草稿</a>
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
  
	<script type="text/javascript">window.jQuery || document.write("<script src='static/js/jquery-1.9.1.min.js'>\x3C/script>");</script>
	<script src="static/js/bootstrap.min.js"></script>
	<script src="static/js/ace-elements.min.js"></script>
	<script src="static/js/ace.min.js"></script>
	
	<script type="text/javascript" src="static/js/bootstrap-datepicker.min.js"></script><!-- 日期框 -->
	<script type="text/javascript" src="static/js/chosen.jquery.min.js"></script><!-- 下拉框 -->
	<!-- <script type="text/javascript" src="static/js/bootbox.min.js"></script> --><!-- 确认窗口 -->
	<script type="text/javascript" src="static/js/base64.js"></script>
	<!-- 压缩图片 -->
	<link rel="stylesheet" type="text/css" href="plugins/fancyBox/jquery.fancybox.css">
	<script type="text/javascript" src="plugins/fancyBox/jquery.fancybox.pack.js"></script>
	<!-- 查看图片 -->

  <script type="text/javascript">
	$(top.hangge());
	
	$(function() {
		if($("#provinceId").val()) {
			var provinceId = $("#provinceId").val();//19
			//var citySelect = $("#cityId");
			$("#cityId").empty().append("<option value=''>全部</option>");
			var cityList = '${cityList}';
			var cityId = '${obj.cityId}';
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
			var areaId = '${obj.areaId}';
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

		//单选框
		$(".chzn-select").chosen(); 
		$(".chzn-select-deselect").chosen({allow_single_deselect:true}); 
  
	
	//联动select事件
	$("#provinceId").change(function(){
		var provinceId = $("#provinceId").val();
		var citySelect = $("#cityId");
		var districtSelect =$("#district");
		citySelect.empty().append("<option value=''>全部</option>");
		var areaSelect = $("#areaId");
		areaSelect.empty().append("<option value=''>全部</option>");
		districtSelect.empty().append("<option value=''>全部</option>");
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
		areaSelect.empty().append("<option value=''>全部</option>");
		districtSelect.empty().append("<option value=''>全部</option>");
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
});
	
	
	//标题验证
	$("#title").blur(function(){	
		var title = $('#title').val();
		if(title.length>20){
			$("#title").tips({
				side:3,
	            msg:'标题不能超过20个字！',
	            bg:'#AE81FF',
	            time:2
	        });
			$("#title").focus();
			return false;
		}
	});
	
	//内容验证
	$("#content").blur(function(){	
		var title = $('#content').val();
		if(title.length>1000){
			$("#content").tips({
				side:3,
	            msg:'内容不能超过1000个字！',
	            bg:'#AE81FF',
	            time:2
	        });
			$("#content").focus();
			return false;
		}
	});
	
	//简介
	$("#consultationDesc").blur(function(){
		var consultationDesc = $('#consultationDesc').val();
		if(consultationDesc.length>2000){
			$("#consultationDesc").tips({
				side:3,
	            msg:'描述不能超过2000个字！',
	            bg:'#AE81FF',
	            time:2
	        });
			$("#consultationDesc").focus();
			return false;
		}
	}); 

	//更改图片
	function changeImg(){
		$("#fileInput").trigger("click");
	}
	
	new img2base64("fileInput", "url", "imgHref", "imgBox");
	
	$("#imgBox").fancybox({
		helpers : {
			title : {
				type : 'inside'
			}
		}
	});
	
	//上传
	$('#fileInput:visible').ace_file_input({
		no_file : '请选择图片 ...（图片≤100M）',
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
	
	//上传的图片验证
	$("#fileInput").change(function(){
		//验证图片类型
		var butarr = ["bmp","png","gif","jpeg","jpg"];//数组存放 图片类型
		var value = $("#fileInput").val();
		var arr = value.split('.')[1];
		if($.inArray(arr, butarr)==-1){
			$("#fileInput").val("");
			$("#fileInput").tips({
				side : 3,
				msg : '请上传图片格式的文件',
				bg : '#AE81FF',
				time : 2
			});
			return false;
		}
		//验证大小
		var dom = document.getElementById("fileInput");  
		var fileSize =  dom.files[0].size;//文件的大小，单位为字节B
		if(parseInt(fileSize)>(100*1024*1024)){
			$("#fileInput").val("");
			$("#fileInput").tips({
				side : 3,
				msg : '图片大小不能大于100M',
				bg : '#AE81FF',
				time : 2
			});
			return false;
		}
	});
	
    //资讯类型-联动二级资讯
    $("#typeId").change(function(){
        var typeId = $("#typeId").val();
        var typeTwoSelect = $("#typeTwoId");
        //ssssalert(typeId);
        typeTwoSelect.empty().append("<option value=''></option>");
        var typeListTwo = '${typeListTwo}';
        //alert(typeListTwo);
        $.each(JSON.parse(typeListTwo), function(i, list){
            var parentId = list.parentId;
            if(parentId == typeId) {
                var value = list.consultationTypeId;
                var option = list.typeName;
                var label = $("<option value='"+value+"'>"+option+"</option>");
                typeTwoSelect.append(label);
      		}
        });
        typeTwoSelect.trigger("liszt:updated");
    });
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