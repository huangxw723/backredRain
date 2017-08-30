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
	
	<script src="plugins/ckeditor/ckeditor.js"></script>
	<script src="plugins/ckeditor/config.js"></script>
	
<script type="text/javascript">
//保存 做验证的
function save(status){
	if(status==1){
		$("#status").val("1")//草稿
	}else if(status==2){
		$("#status").val("2")//发布
	}
	
 	if($("#typeId").val()==""){
		$("#typeId").tips({
			side:3,
            msg:'请选择资讯类型',
            bg:'#AE81FF',
            time:2
        });
		$("#typeId").focus();
		return false;
	} 
 	
 	var pro = $("#provinceId").val();
	if(pro==""){
		$("#provinceId").tips({
			side:3,
			msg:'请选择省份',
			bg:'#AE81FF',
			time:2
		});
		$("#provinceId").focus();
		return false;
	}
	
	var city = $("#cityId").val();
	if(city==""){
		$("#cityId").tips({
			side:3,
			msg:'请选择城市',
			bg:'#AE81FF',
			time:2
		});
		$("#cityId").focus();
		return false;
	}
	
	var area = $("#areaId").val();
	if(area==""){
		$("#areaId").tips({
			side:3,
			msg:'请选择区域',
			bg:'#AE81FF',
			time:2
		});
		$("#areaId").focus();
		return false;
	}

	if($("#name").val()=="" ||$.trim($("#name").val())=="" ){
		$("#name").tips({
			side:3,
            msg:'酒店名称不能为空',
            bg:'#AE81FF',
            time:2
        });
		$("#name").focus();
		return false;
	}
    
	 if($("#phone").val()==""||$.trim($("#phone").val())=="" ){
         $("#phone").tips({
             side:3,
             msg:'请输入电话',
             bg:'#AE81FF',
             time:2
         });
         $("#phone").focus();
         return false;
     }
    
	 if (isNaN(Number($('#phone').val()))||$('#phone').val().indexOf(".")>-1) {
			$("#phone").tips({
				side : 3,
				msg : '只能输入数字！',
				bg : '#AE81FF',
				time : 2
			});
			$("#phone").focus();
			return false;
		}
	/*   if(!(/^1[34578]\d{9}$/.test($("#phone").val()))&&!(/^0\d{2,3}-?\d{7,8}$/.test($("#phone").val()))){
         $("#phone").tips({
             side:3,
             msg:'联系号码格式有误，请重填',
             bg:'#AE81FF',
             time:2
         });
         $("#phone").focus();
         return false;
     }   */

    if($("#brandId").val()=="" ||$.trim($("#brandId").val())==""){
		$("#brandId").tips({
			side:3,
            msg:'品牌不能为空',
            bg:'#AE81FF',
            time:2
        });
		$("#brandId").focus();
		return false;
	}

 	if($("#suggestPrice").val()=="" ||$.trim($("#suggestPrice").val())==""){
		$("#suggestPrice").tips({
			side:3,
            msg:'价格不能为空',
            bg:'#AE81FF',
            time:2
        });
		$("#suggestPrice").focus();
		return false;
	}
	if($("#starLevel").val()=="" ||$.trim($("#starLevel").val())==""){
		$("#starLevel").tips({
			side:3,
            msg:'酒店星级不能为空',
            bg:'#AE81FF',
            time:2
        });
		$("#starLevel").focus();
		return false;
	}
	
	
	if($("#address").val()==""||$.trim($("#address").val())=="" ){
        $("#address").tips({
            side:3,
            msg:'输入地址',
            bg:'#AE81FF',
            time:2
        });
        $("#address").focus();
        return false;
    }
   
    //图片
    var has = $(".has").size();
	var array4 = new Array();
	for(var i = 0;i<has;i++){
		array4[i] = $(".has")[i].title;
	}
	$("#oldIamge").val(array4);
	
    //提交
	$("#form").submit();
	$("#zhongxin").hide();
	$("#zhongxin2").show(); 
}
</script>
</head>
<body>  
    <form class="form-horizontal" id="form" name="form" action="consultationHotel/saveEdit.do" method="post"enctype="multipart/form-data">
    <input type="hidden" name="consultationTrafficId" id="consultationTrafficId" value="${obj.consultationTrafficId }" />
    <input type="hidden" name="visitCount" id="visitCount" value="${obj.visitCount }" />
    <input type="hidden" name="publicTime" id="publicTime" value="${obj.publicTime }" />
    <input type="hidden" name="createTime" id="createTime" value="${obj.createTime }" />
    <input type="hidden" name="status" id="status" value="${obj.status }" />
    <input type="hidden" name="latlng"id="latlng" > 
    <input type="hidden" name="oldIamge" id="oldIamge" value="" />
    <div id="zhongxin">
      <table id="table_report" class="table table-striped table-bordered table-hover">
        <tr>
	      <th>资讯类型:</th>
          <td>
             <select class="chzn-select" name="typeId" id="typeId" style="vertical-align:top;">
              <c:forEach items="${typeListOne}" var="d">
                    <option value="${d.consultationTypeId}" <c:if test="${d.consultationTypeId == obj.typeId }">selected</c:if>>${d.typeName}</option>
               </c:forEach>                  
            </select>
          </td>
        </tr>       
		
		<tr height="45px">
				<td>区域:</td>
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
					<span style="float: left;margin-left: 5px;margin-top: 5px">
								商圈:<select name="businessDistrictId" id="district" data-placeholder="请选择商圈" style="vertical-align:top;width: 115px">
            					</select>
					</span>
				</td>
			</tr>	
			
        <tr>
          <th>名称:</th>
          <td>
            <input type="text" style="width:90%;" name="name" id="name" value="${obj.name}" placeholder="请输入酒店名称" title="酒店名称" />
          </td>
        </tr>
        
        <tr>
          <th>电话:</th>
          <td>
            <input type="text" style="width:90%;" name="phone" id="phone" value="${obj.phone}" placeholder="请输入联系电话" title="电话" />
          </td>
        </tr>

          <tr>
              <th>酒店品牌:</th>
              <td>
                  <select class="chzn-select" name=brandId id="brandId" data-placeholder="酒店品牌" style="vertical-align:top;">
                      <c:forEach items="${brandList}" var="district">
                          <option value="${district.id}"<c:if test="${obj.brandId ==district.id}">selected="selected"</c:if> >${district.name}</option>
                      </c:forEach>
                  </select>
              </td>
          </tr>
        
        <tr>
          <th>酒店价格:</th>
          <td>
            <input type="text" style="width:90%;" name="suggestPrice" id="suggestPrice" value="${obj.suggestPrice}" placeholder="请输入酒店价格" title="酒店价格" />
          </td>
        </tr>
        
        <tr>
          <th>酒店星级:</th>
          <td>
            <input onkeyup="this.value=this.value.replace(/\D/g,'')" onafterpaste="this.value=this.value.replace(/\D/g,'')" type="text" style="width:90%;" name="starLevel" id="starLevel" value="${obj.starLevel}" placeholder="请输入酒店星级" title="酒店星级" />  
          </td>
        </tr>
         <tr>
          <th>封面图:</th>
          <td>
           <c:if test="${obj == null || obj.coverImg == '' || obj.coverImg == null }">
              <a id="imgBox" href="javascript:void(0)" style="display:none;">
                <img src="" width="750" height="666" id="imgHref" />
              </a>
            </c:if>
            <c:if test="${obj != null && obj.coverImg != '' && obj.coverImg != null }">
              <a id="imgBox" class="has" href="<%=httpUrl%>${obj.coverImg}" title="${obj.coverImg}">
				 <img src="<%=httpUrl%>${obj.coverImg}" alt="${obj.coverImg}" width="750" height="666" id="imgHref" />
			  </a>
              <input type="button" class="btn btn-mini btn-danger" value="更改" onclick="changeImg()" />
              <input type="file" id="fileInput" name="file" style="display:none;" />
              <font color="red">注:图片尺寸 宽:750 PX,高:666 PX</font>	
            </c:if>
         
          </td>
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

			if($("#areaId").val()) {
				var areaId = $("#areaId").val();
				var districtSelect = $("#district");
				districtSelect.empty().append("<option value=''>全部</option>");
				var districtList = '${districtList}';
				var district = '${obj.businessDistrictId}';
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
	});
	
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
	$("#areaId").change(function(){
		var areaId = $("#areaId").val();
		var districtSelect = $("#district");
		districtSelect.empty().append("<option value=''>全部</option>");
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
	
	
	//酒店名称验证
	$("#name").blur(function(){	
		var title = $('#name').val();
		if(title.length>20){
			$("#name").tips({
				side:3,
	            msg:'酒店不能超过20个字！',
	            bg:'#AE81FF',
	            time:2
	        });
			$("#name").focus();
			return false;
		}
	});
	
	//价格
	$("#suggestPrice").blur(function(){
		var val = $('#suggestPrice').val();
		 //判断酒店价格
      var reg = /(^[-+]?[1-9]\d*(\.\d{1,2})?$)|(^[-+]?[0]{1}(\.\d{1,2})?$)/;
      if (val== "") {
          $("#suggestPrice").tips({
				side:3,
	            msg:'酒店价格不能为空！',
	            bg:'#AE81FF',
	            time:2
	        });
			$("#suggestPrice").focus();
          return false;
      } else {
          if (!reg.test(val)) {
              $("#suggestPrice").tips({
  				side:3,
  	            msg:'价格必须为合法数字(正数，最多两位小数)格式为xx.xx元!',
  	            bg:'#AE81FF',
  	            time:2
  	        });
  			$("#suggestPrice").focus();
              return false;
          } else {
              return true;
          }
      }
	});

	//星级
	$("#starLevel").blur(function(){	
		var val = $('#starLevel').val();
		if(isNaN(Number(val))){
			$("#starLevel").tips({
				side:3,
	            msg:'只能输入数字！',
	            bg:'#AE81FF',
	            time:2
	        });
			$("#starLevel").focus();
			return false;
		}
		if(val<1 || val>5){
			$("#starLevel").tips({
				side:3,
	            msg:'只能设置1~5星！数字',
	            bg:'#AE81FF',
	            time:2
	        });
			$("#starLevel").focus();
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