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
	<script src="plugins/ckeditor/ckeditor.js"></script>
	<script src="plugins/ckeditor/config.js"></script>

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
	//保存 做验证的
	function save(status){
	
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
		
		if($("#fileInput").val()==""){
			$("#fileInput").tips({
				side:3,
	            msg:'请选择图片',
	            bg:'#AE81FF',
	            time:2
	        });
			$("#fileInput").focus();
			return false;
		}
		
		if($("#fileInputs").val()==""){
			$("#fileInputs").tips({
				side:3,
	            msg:'酒店实拍图片',
	            bg:'#AE81FF',
	            time:2
	        });
			$("#fileInputs").focus();
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
       
        //提交
		$("#form").submit();
		$("#zhongxin").hide();
		$("#zhongxin2").show(); 
	}
</script>
</head>
<body>  
    <form action="consultationHotel/saveAdd.do" enctype="multipart/form-data" name="form" id="form" method="post">
    <input type="hidden" name="status"id="status" value=1 >
    <!-- <input type="hidden" name="latlng"id="latlng" > -->
    <div id="zhongxin">
      <table id="table_report" class="table table-striped table-bordered table-hover">
        <tr>
	      <th>资讯类型:</th>
            <td>
             <select class="chzn-select" name="typeId" id="typeId" data-placeholder="请选择" style="vertical-align:top;">
                        <option value=""></option>
                        <c:forEach items="${typeListOne}" var="d">
                        	<option value="${d.consultationTypeId}">${d.typeName}</option>
                        </c:forEach>                  
            </select>
          </td>
        </tr>
       
         <tr>
	      <th>城市:</th>
          <td>
            <select class="chzn-select" name="provinceId" id="provinceId" data-placeholder="省份" style="vertical-align:top;width: 110px;">
              <c:forEach items="${provinceList}" var="district">
                <option value="${district.provinceId}" >${district.provinceName}</option>
              </c:forEach>
            </select>
            <select class="chzn-select" name="cityId" id="cityId" data-placeholder="城市" style="vertical-align:top;width: 110px;">
              <option value="">城市</option>
              <c:forEach items="${cityList}" var="district">
                <option value="${district.cityId}" >${district.cityName }</option>
              </c:forEach>
            </select>
            <select class="chzn-select" name="areaId" id="areaId" data-placeholder="区域" style="vertical-align:top;width: 110px;">
              <option value="">区域</option>
              <c:forEach items="${areaList}" var="district"> 
                <option value="${district.areaId}">${district.areaName }</option>
              </c:forEach>
            </select>
            
            <select class="chzn-select" name=businessDistrictId id="businessDistrictId" data-placeholder="商圈" style="vertical-align:top;width: 110px;">
              <option value="">商圈</option>
              <c:forEach items="${businessDistrictList}" var="district"> 
                <option value="${district.businessDistrictId}">${district.name}</option>
              </c:forEach>
            </select>      
          </td>
        </tr>
       

        <tr>
          <th>名称:</th>
          <td>
            <input type="text" style="width:90%;" name="name" id="name" placeholder="请输入酒店名称" title="酒店名称" />
          </td>
        </tr>
        
        <tr>
          <th>电话:</th>
          <td>
            <input type="text" style="width:90%;" name="phone" id="phone" placeholder="请输入联系电话" title="电话" />
          </td>
        </tr>
        
        <tr>
          <th>酒店品牌:</th>
          <td>
            <select class="chzn-select" name=brandId id="brandId" data-placeholder="酒店品牌" style="vertical-align:top;">
              <c:forEach items="${brandList}" var="district"> 
                <option value="${district.id}">${district.name}</option>
              </c:forEach>
            </select>
          </td>
        </tr>
        
        <tr>
          <th>酒店价格:</th>
          <td>
            <input type="text" style="width:90%;" name="suggestPrice" id="suggestPrice" placeholder="请输入酒店价格" title="酒店价格" />
          </td>
        </tr>
        
        <tr>
          <th>推荐星级:</th>
          <td>
            <input onkeyup="this.value=this.value.replace(/\D/g,'')" onafterpaste="this.value=this.value.replace(/\D/g,'')" type="text" style="width:90%;" name="starLevel" id="starLevel" placeholder="请输入酒店星级" title="酒店星级" />
          </td>
        </tr>
        
        <tr>
          <th>封面图:</th>
          <td>
			<a id="imgBox" href="javascript:void(0)" style="display:none;">
			  <img src="" width="750" height="666" id="imgHref" />
			 </a>
			<input type="file" id="fileInput" name="file" />
			<input id="url" name="img" type="hidden" />
			<font color="red">注:图片尺寸 宽:750 PX,高:666 PX</font>	
		 </td>
        </tr>

		<tr>
			<th>酒店实拍图片</th>
			<td><input style="width: 75px;" type='file' id="fileInputs" onchange="selectImg(this)" name="imgs"> 
				<span class="help-inline"> <a id="imgClean" style="display: none" href="javscript:void(0);" onclick="cleanImg()">清除图片</a>
			</span>
				<div id="images" style="float: left; border: 1px solid #ccc;"></div>
				 <font color="red">注:图片尺寸 宽:220 PX,高:220 PX</font>	
			</td>
		</tr>
		
		  <tr>
		          <th>地址:</th>
		          <td>
		            <div id="l-map"></div>
		            <input type="text" style="width:90%;" name="address" id="address"  placeholder="这里输入地址" title="地址" />
		            <input type="hidden" name="lng" id="lng"  />
		            <input type="hidden" name="lat" id="lat" />
		            <div id="searchResultPanel" style="border:1px solid #C0C0C0;width:150px;height:auto; display:none;"></div>
		          </td>
         		 </tr>
        
        <tr>
          <td class="center" colspan="2">
            <a class="btn btn-mini btn-primary" onclick="save(2);">立即发布</a>
            <a class="btn btn-mini btn-primary" onclick="save(1);">保存为草稿</a>
            <!-- <a class="btn btn-mini btn-danger" onclick="top.Dialog.close();">取消</a> -->
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
	<script type="text/javascript" src="static/js/bootbox.min.js"></script><!-- 确认窗口 -->
	<script type="text/javascript" src="static/js/base64.js"></script>
	<!-- 压缩图片 -->
	<link rel="stylesheet" type="text/css" href="plugins/fancyBox/jquery.fancybox.css">
	<script type="text/javascript" src="plugins/fancyBox/jquery.fancybox.pack.js"></script>
	<!-- 查看图片 -->

  <script type="text/javascript">
	$(top.hangge());
	
	$(function() {
		//单选框
		$(".chzn-select").chosen(); 
		$(".chzn-select-deselect").chosen({allow_single_deselect:true}); 
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
	
	/***************************/
	$("#fileInputs").change(function(){
		var butarr = ["bmp","png","gif","jpeg","jpg"];//数组存放 图片类型
		var value = $("#fileInputs").val();
		var arr = value.split('.')[1];
		if($.inArray(arr, butarr)==-1){
			$("#fileInputs").val("");
			$("#fileInputs").tips({
				side : 3,
				msg : '请上传图片格式的文件',
				bg : '#AE81FF',
				time : 2
			});
			return false;
		}
	});
	
	//多图片上传
	var count =0;
	function selectImg($this){	
		$this.style.display = "none";
		$($this).after('<input style="width: 75px;" type="file" onchange="selectImg(this)" name="imgs">');
			count++;
		var files = $this.files;
		   if (files) {			   
			  if(count>5){
					  				 
				 alert("一次性只能添加5张图片");
				  return ;
			  } 			  
			  for(var i=0;i<files.length;i++){
				  var FR= new FileReader();
				    FR.onload = function(e) {				    
				     var result = e.target.result;
				      console.log(e.target.result);
				      $("#images").append('<img class="imgs" style="max-height:220px;max-width:220px;margin-left: 5px;margin-top: 5px" id="img" src="'+result+'">');
				      $("#imgClean").show();
				    };
				  FR.readAsDataURL( files[i] );
			  }
		  }  
	}
	//清除图片
	function cleanImg(){
		var imgs = $(".imgs");
		var len = imgs.length;
		$(".imgs")[len-1].remove();
		if(len == 1){
			$("#images").empty();
			$("#imgClean").hide();
		}
		
		$("[type=file]")[len-1].remove();
	
	}	
	//--------------------------------------------------------------------------------
	 //选择省份联动 城市
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
	
    //选择城市联动 区域
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
    
    //选择城市联动商圈
    $("#areaId").change(function(){
			var areaId = $("#areaId").val();
			var areaSelect = $("#businessDistrictId");
			areaSelect.empty().append("<option value=''></option>");
			var areaList = '${districtList}';
			$.each(JSON.parse(areaList), function(i, list){
				var parentId = list.areaId;
				if(parentId == areaId) {
					var value = list.businessDistrictId;
					var option = list.name;
					var label = $("<option value='"+value+"'>"+option+"</option>");
					areaSelect.append(label);
				}
			});
			areaSelect.trigger("liszt:updated");
		});
     
   //----------------------------------------------------------------------------	
		
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