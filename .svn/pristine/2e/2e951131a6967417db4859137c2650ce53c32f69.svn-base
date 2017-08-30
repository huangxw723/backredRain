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
<script type="text/javascript" src="http://api.map.baidu.com/api?v=2.0&ak=jGRH9RCPqXgfsrr2jyMLzhk1jKactdvj"></script>
<style type="text/css">
    #l-map{height:500px;width:90%;}
    #r-result{width:100%;}
</style>

<script type="text/javascript">
	//保存
	function save(){
		if($("#businessDistrictId").val()==""){
			$("#businessDistrictId").tips({
				side:3,
	            msg:'请选择商圈',
	            bg:'#AE81FF',
	            time:2
	        });
			$("#businessDistrictId").focus();
			return false;
		}
      if($("#ypBaseCategoryId").val()==""){
        $("#ypBaseCategoryId").tips({
          side:3,
          msg:'请选择商场分类',
          bg:'#AE81FF',
          time:2
        });
        $("#ypBaseCategoryId").focus();
        return false;
      }
		if($("#name").val()==""){
			$("#name").tips({
				side:3,
	            msg:'输入商场',
	            bg:'#AE81FF',
	            time:2
	        });
			$("#name").focus();
			return false;
		}

//      if($("#site").val()==""||$.trim($("#site").val())=="" ){
//        $("#site").tips({
//          side:3,
//          msg:'官网网址',
//          bg:'#AE81FF',
//          time:2
//        });
//        $("#site").focus();
//        return false;
//      }
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

		var fileType = document.getElementById("fileInput").value.substr(document.getElementById("fileInput").value.lastIndexOf(".")).toLowerCase();//获得文件后缀名
		var url = $("#url").val();
		var img = $("#imgHref").attr("src");
		if (!img || url) {
			if (fileType != '.gif' && fileType != '.png' && fileType != '.jpg' && fileType != '.jpeg') {
				$("#fileInput").tips({
					side : 3,
					msg : '请上传图片格式的文件',
					bg : '#AE81FF',
					time : 3
				});
				$("#fileInput").val('');
				document.getElementById("fileInput").files[0] = '请选择图片';
				return;
			}
		}
		var _fileType = document.getElementById("_fileInput").value.substr(document.getElementById("_fileInput").value.lastIndexOf(".")).toLowerCase();//获得文件后缀名
		var _url = $("#_url").val();
		var _img = $("#_imgHref").attr("src");
		if (!_img || _url) {
			if (_fileType != '.gif' && _fileType != '.png' && _fileType != '.jpg' && _fileType != '.jpeg') {
				$("#_fileInput").tips({
					side : 3,
					msg : '请上传图片格式的文件',
					bg : '#AE81FF',
					time : 3
				});
				$("#_fileInput").val('');
				document.getElementById("_fileInput").files[0] = '请选择图片';
				return;
			}
		}
		if($("#address").val()==""){
			$("#address").tips({
				side:3,
	            msg:'输入地址',
	            bg:'#AE81FF',
	            time:2
	        });
			$("#address").focus();
			return false;
		}
		$("#form").submit();
		$("#zhongxin").hide();
		$("#zhongxin2").show();
	}
	
	function changeImg() {
		$("#fileInput").trigger("click");
	}
	
	function _changeImg() {
		$("#_fileInput").trigger("click");
	}
	
	function closeTab() {
		var storeId = '${store.storeId }';
		if(storeId) {
			top.mainFrame.tab.close('updateStore'+storeId);
		} else {
			top.mainFrame.tab.close('createStore');
		}
	}
	
</script>
</head>
<body>
  <form action="business/${msg }.do" name="form" id="form" method="post">
    <input type="hidden" name="storeId" id="storeId" value="${store.storeId }" />
    <input type="hidden" name="logoUrl" id="logoUrl" value="${store.logoUrl}" />
    <input type="hidden" name="qrCodeUrl" id="qrCodeUrl" value="${store.qrCodeUrl}" />
    <div id="zhongxin">
      <table id="table_report" class="table table-striped table-bordered table-hover">
        <tr>
	      <th>商圈:</th>
          <td>
            <select class="chzn-select" name="businessDistrictId" id="businessDistrictId" data-placeholder="请选择商圈" style="vertical-align:top;">
              <option value=""></option>
              <c:forEach items="${districtList}" var="district">
                <option value="${district.businessDistrictId }" <c:if test="${district.businessDistrictId == store.businessDistrictId }">selected</c:if>>${district.name }</option>
              </c:forEach>
            </select>
          </td>
        </tr>
        <tr>
          <th>商场分类:</th>
          <td>
            <select class="chzn-select" name="ypBaseCategoryId" id="ypBaseCategoryId" data-placeholder="请选择商场分类" style="vertical-align:top;">
              <option value=""></option>c
              <c:forEach items="${ypBaseCategoryList}" var="category">
                <option value="${category.id}" <c:if test="${category.id == store.ypBaseCategoryId }">selected</c:if>>${category.name }</option>
              </c:forEach>
            </select>
          </td>
        </tr>
        <tr>
          <th>商场:</th>
          <td>
            <input type="text" style="width:90%;" name="name" id="name" value="${store.name }" placeholder="这里输入商场" title="商场" />
          </td>
        </tr>
        <tr>
          <td>官网网址:</td>
          <td>
            <input type="text" style="width:70%;" name="site" id="site" value="${store.site }" placeholder="这里输入官网网址" title="官网网址" />
            <span style="color: red">(如：https://www.baidu.com)</span>
          </td>
        </tr>
        <tr>
          <th>logo:</th>
          <td>
            <c:if test="${store == null || store.logoUrl == '' || store.logoUrl == null }">
              <a id="imgBox" href="javascript:void(0)" style="display:none;">
                <img src="" width="150" id="imgHref" />
              </a>
              <input type="file" id="fileInput" name="fileInput" />
              <span style="color: red; width: 50px;" id="msgDiv" >注：（图片尺寸规格180px * 180px）</span>
            </c:if>
            <c:if test="${store != null && store.logoUrl != '' && store.logoUrl != null }">
              <a id="imgBox" href="<%=httpUrl%>${store.logoUrl}">
                <img src="<%=httpUrl%>${store.logoUrl}" width="150" id="imgHref" />
              </a>
              <input type="button" class="btn btn-mini btn-danger" value="更改" onclick="changeImg()" />&nbsp;<span style="color: red">注:图片尺寸规格180px * 180px</span>
              <input type="file" id="fileInput" name="fileInput" style="display:none;" />
            </c:if>
            <input id="url" name="img" type="hidden" />
          </td>
        </tr>
        <tr>
          <th>二维码:</th>
          <td>
            <c:if test="${store == null || store.qrCodeUrl == '' || store.qrCodeUrl == null }">
              <a id="_imgBox" href="javascript:void(0)" style="display:none;">
                <img src="" width="150" id="_imgHref" />
              </a>
              <input type="file" id="_fileInput" name="_fileInput" />
              <span style="color: red; width: 50px;" id="msgDiv" >注：（图片尺寸规格180px * 180px）</span>
            </c:if>
            <c:if test="${store != null && store.qrCodeUrl != '' && store.qrCodeUrl != null }">
              <a id="_imgBox" href="<%=httpUrl%>${store.qrCodeUrl}">
                <img src="<%=httpUrl%>${store.qrCodeUrl}" width="150" id="_imgHref" />
              </a>
              <input type="button" class="btn btn-mini btn-danger" value="更改" onclick="_changeImg()" />&nbsp;<span style="color: red">注:图片尺寸规格180px * 180px</span>
              <input type="file" id="_fileInput" name="_fileInput" style="display:none;" />
            </c:if>
            <input id="_url" name="_img" type="hidden" />
          </td>
        </tr>
        <tr>
          <th>地址:</th>
          <td>
            <div id="l-map"></div>
            <input type="text" style="width:90%;" name="address" id="address" value="${store.address }" placeholder="这里输入地址" title="地址" />
            <input type="hidden" name="lng" id="lng" value="${store.lng}" />
            <input type="hidden" name="lat" id="lat" value="${store.lat}" />
            <div id="searchResultPanel" style="border:1px solid #C0C0C0;width:150px;height:auto; display:none;"></div>
          </td>
        </tr>
        <tr>
          <td class="center" colspan="2">
            <a class="btn btn-mini btn-primary" onclick="save();">保存</a>
            <a class="btn btn-mini btn-danger" onclick="closeTab();">取消</a>
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
  <script type="text/javascript" src="static/js/chosen.jquery.min.js"></script>
  <!-- 单选框 -->
  
  <script src="static/js/base64.js"></script>
  <!-- base64 -->
  <link rel="stylesheet" type="text/css" href="plugins/fancyBox/jquery.fancybox.css">
  <script type="text/javascript" src="plugins/fancyBox/jquery.fancybox.pack.js"></script>

  <script type="text/javascript">
	$(top.hangge());
	$(function() {
		//单选框
		$(".chzn-select").chosen(); 
		$(".chzn-select-deselect").chosen({allow_single_deselect:true}); 
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
	
	new img2base64("fileInput", "url", "imgHref", "imgBox");
	
	new img2base64("_fileInput", "_url", "_imgHref", "_imgBox");

	$("#imgBox").fancybox({
		helpers : {
			title : {
				type : 'inside'
			}
		}
	});
	
	$("#_imgBox").fancybox({
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
  </script>
</body>
</html>