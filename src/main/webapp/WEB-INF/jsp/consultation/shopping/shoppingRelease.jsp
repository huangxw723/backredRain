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
	<!-- 引入 图片预览功能 -->
	<link rel="stylesheet" type="text/css" href="plugins/fancyBox/jquery.fancybox.css">
	<script type="text/javascript" src="plugins/fancyBox/jquery.fancybox.pack.js"></script>
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

<script type="text/javascript">

jQuery(document).ready(function(){
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
	
	$(function() {
		
		$(".chzn-select").chosen(); 
		$(".chzn-select-deselect").chosen({allow_single_deselect:true}); 
		
		CKEDITOR.replace('descp',{
			width:1100,
			
		});
		CKEDITOR.instances.illustration.on('blur', function() { 
	      var d = this.getData(); 
	      this.setData(d); 
	    }); 
	});
	

	//保存
	function save(){
		
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
	            msg:'请输入推荐理由',
	            bg:'#AE81FF',
	            time:2
	        });
			$("#desc").focus();
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
    
         
		if($("#fileInput").val()==""){
			$("#fileInput").tips({
				side:3,
	            msg:'请选择封面图片',
	            bg:'#AE81FF',
	            time:2
	        });
			$("#fileInput").focus();
			return false;
		}
		if($("#fileInputs").val()==""){
			$("#fileInputs").tips({
				side:3,
	            msg:'请选择宣传图片',
	            bg:'#AE81FF',
	            time:2
	        });
			$("#fileInputs").focus();
			return false;
		}

		
		
		$('#form').submit();
		  $("#zhongxin").hide();
		  $("#zhongxin2").show(); 
	}
	
	
	
	
	function changeImg() {
		$("#fileInput").trigger("click");
	}
	
	function _changeImg() {
		$("#_fileInput").trigger("click");
	}
	
	function draft() {
		
		$("#status").attr("value",1);
		save();
		
	}
		

	   function select1() {
	        $("#cityId").html("");
	        $.ajax(
	        {
	            type: "post",
	            url: "cate/city",
	            data: { "provinceId":$('#provinceId').val() },
	            success: function (msg) {            	
	                for (var i = 0; i < msg.length; i++) {
	                    $("#cityId").append("<option value=" + msg[i].cityId + ">" + msg[i].cityName + "</option>"); 
	                    $("#cityId").trigger("liszt:updated");
	                }           
	                select2();
	            }
	        });
	    };
	    
	    function select2() {
	        $("#areaId").html("");
	        $.ajax(
	        {
	            type: "post",
	            url: "cate/area",
	            data: { "cityId":$('#cityId').val() },
	            success: function (msg) {
	                for (var i = 0; i < msg.length; i++) {
	                    $("#areaId").append("<option value=" + msg[i].areaId + ">" + msg[i].areaName + "</option>");
	                    $("#areaId").trigger("liszt:updated");
	                }
	                select3();
	            }
	        });
	    };
	    
	    function select3() {
	        $("#businessId").html("");
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
	                    $("#businessId").trigger("liszt:updated");

	                    
	                	}
	            	}
	            }
	        });
	    };
	 
		
</script>
</head>
<body>																				
  <form action="shopping/shoppingSave" name="form" id="form" method="post" enctype="multipart/form-data">
  	<input type="hidden" name="status" value=2 id="status">
  	<input type="hidden" id="latlng" name="latlng" value="">
    <div id="zhongxin">
      <table id="table_report" class="table table-striped table-bordered table-hover">
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
            <select  name="provinceId" id="provinceId" onchange="select1()"  class="chzn-select" style="vertical-align:top;width: 115px">
              		<option value="">省份</option> 
              <c:forEach items="${provinceList}" var="district">
                <option value="${district.provinceId}" >${district.provinceName}</option>
              </c:forEach>
            </select>
            <select  name="cityId" id="cityId"  onchange="select2()" class="chzn-select" style="vertical-align:top;width: 115px">
              <option value="">城市</option>
                           
            </select>
            <select  name="areaId" id="areaId"  onchange="select3()" class="chzn-select" style="vertical-align:top;width: 115px">
              <option value="">区域</option>           
            </select>
            <select  name="businessDistrictId" id="businessId"   class="chzn-select" style="vertical-align:top;width: 115px">
              <option value="">商圈</option>           
            </select>
          </td>
        </tr>
        <tr>
          <th>名称:</th>
          <td>
            <input type="text" style="width: 400px" name="name" id="title"  placeholder="这里输入名称"  />
          </td>
        </tr>
        <tr>
          <th>品类:</th>
          <td>
				<select name="ypBaseCategoryId" class="chzn-select" style="vertical-align:top;width: 115px" id="ypBaseCategoryId">
					 <c:choose>
                        	<c:when test="${not empty foodList}">
									<c:forEach items="${foodList}" var="list">
										<option value="${list.id}">${list.name }</option>
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
       	<tr>
	      <th>推荐指数:</th>
				<td><select name="recommendLevel" id="star" class="chzn-select"
						style="vertical-align: top; width: 115px">
						<option value="1">1</option>
						<option value="2">2</option>
						<option value="3">3</option>
						<option value="4">4</option>
						<option value="5">5</option>
					</select>
					</td>
		</tr>
         <tr>
          <th>推荐理由:</th>
          <td><textarea name="recommendResult" id="desc" placeholder="这里输入推荐理由,最多可输入100个字" style="width: 400px;height: 80px"></textarea></td>
        </tr>
        <tr>
          <th>地铁路线:</th>
          <td><textarea  name="metro" id="metro" placeholder="这里输入地铁路线,请不要包含分号" style="width: 400px;height: 100px"></textarea></td>
        </tr>
         <tr>
          <th>公交路线:</th>
          <td><textarea  name="bus" id="bus" placeholder="这里输入公交路线,请不要包含分号" style="width: 400px;height: 100px"></textarea></td>
        </tr>
        <tr>
          <th>简介:</th>
          <td><textarea name="shoppingDesc" id="shoppingDesc" placeholder="这里输入简介,最多可输入100个字" style="width: 400px;height: 150px"></textarea></td>
        </tr>
        <tr>
    	
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
          
          <th>封面图:</th>
          <td>
          
           <a id="imgBox" href="javascript:void(0)" style="display:none;">
                <img src="" width="150" id="imgHref" />
              </a>
              <input type="file" id="fileInput" name="file" />
            
            <c:if test="${store != null && store.coverImg != '' && store.coverImg != null }">
              <a id="imgBox" href="<%=httpUrl%>${store.coverImg}">
                <img src="<%=httpUrl%>${store.coverImg}" width="150" id="imgHref" />
              </a>                        
              <input type="button" class="btn btn-mini btn-danger" value="更改" onclick="changeImg()" />
              <input type="file" id="fileInput" name="file" style="display:none;" />
            </c:if>
            <input id="url" name="coverImg" type="hidden" />
            <span style="color: red;font-size:15px;" >注:图片尺寸 宽:220 PX,高:220 PX</span>
          </td>       
        </tr>
      	<tr>
      		<th>宣传图片</th>
      		<td>
      			<input style="width: 75px;" type='file' id="fileInputs" onchange="selectImg(this)" name="imgs">
					<span class="help-inline">								
						<a id="imgClean" style="display: none" href="javscript:void(0);" onclick="cleanImg()">清除图片</a>
					</span>
						<div id="images" style="float: left;border: 1px solid #ccc;"></div>							
			</td>					
      </tr>
      <tr>
		<td colspan="2"><span style="color: red;font-size:15px; margin-left: 110px;" >注:图片尺寸 宽:750 PX,高:320 PX</span></td>
	 </tr>     
        <tr>
          <td class="center" colspan="2">
            <a class="btn btn-mini btn-primary" onclick="save();">立即发布</a>
            <a class="btn btn-mini btn-danger" onclick="draft();">保存到草稿</a>
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
	//$(top.hangge());

	
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
	
	//上传
	$('#_fileInput:visible').ace_file_input({
		no_file : '请选择图片 ...',
		btn_choose : '选择',
		btn_change : '更改',
		droppable : false,
		onchange : null,
		thumbnail : false,
		before_remove : function() {
			$("#_url").val("");
			$("#_imgBox").attr("href", "").hide();
			$("#_imgHref").attr("src", "");
			return true;
		}
	});
	//限制上传的图片
	$("#fileInput").change(function(){
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
	});
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
	
	new img2base64("fileInput", "url", "imgHref", "imgBox");
	
	new img2base64("_fileInput", "_url", "_imgHref", "_imgBox");

	$("#imgBox").fancybox({
		helpers : {
			title : {
				type : 'inside'
			}
		}
	});
	
	//多图片上传
	function selectImg($this){	
		$this.style.display = "none";
		$($this).after('<input style="width: 75px;" type="file" onchange="selectImg(this)" name="imgs">');
		
		var count = $(".imgs").length;
		if(count>=5){
				 $($this).remove();
				 alert("一次只能添加5张图片");
				  return ;
			  } 
		
		var files = $this.files;
		   if (files) {			   
			  for(var i=0;i<files.length;i++){
				  var FR= new FileReader();
				    FR.onload = function(e) {				    
				     var result = e.target.result;
				      console.log(e.target.result);
				      $("#images").append('<img class="imgs" style="max-height:100px;max-width:100px;margin-left: 5px;margin-top: 5px" id="img" src="'+result+'">');
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