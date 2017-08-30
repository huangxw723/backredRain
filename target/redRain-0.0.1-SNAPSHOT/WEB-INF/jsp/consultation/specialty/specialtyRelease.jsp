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
	
	<!--地图插件  -->
	 <script type="text/javascript" src="http://api.map.baidu.com/api?v=1.4"></script>
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

	$("#imgBox").fancybox({
		helpers : {
			title : {
				type : 'inside'
			}
		}
	});
</script>
<style type="text/css">
    #l-map{height:500px;width:90%;}
    #r-result{width:100%;}
</style>
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
		if(pro==""||city==""){
			$("#provinceId").tips({
				side:3,
				msg:'请选择地址',
				bg:'#AE81FF',
				time:2
			});
			$("#provinceId").focus();
			return false;
		}
		
		if($("#title").val()==""){
			$("#title").tips({
				side:3,
	            msg:'输入名称',
	            bg:'#AE81FF',
	            time:2
	        });
			$("#title").focus();
			return false;
		}
		if($("#desc").val()==""){
			$("#desc").tips({
				side:3,
	            msg:'输入简介',
	            bg:'#AE81FF',
	            time:2
	        });
			$("#desc").focus();
			return false;
		}
		//简介
			var desc = $('#desc').val();
			if(desc.length>100){
				$("#desc").tips({
					side:3,
		            msg:'简介不能超过100个字！',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#desc").focus();
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

		$('#form').submit();
		  $("#zhongxin").hide();
		  $("#zhongxin2").show(); 
	}
	

	
	function changeImg() {
		$("#fileInput").trigger("click");
	}
	
	
	function draft() {
		
		$("#status").attr("value",1);
		save();
		
	}
		
	
	//地区级联查询
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
	    	$("#areaId").empty().append("<option value='0'>区域</option>");
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
	            }
	        });
	    };
	 	
	   
    
</script>
</head>
<body>																				
  <form action="specialty/specialtySave" name="form" id="form" method="post" enctype="multipart/form-data">
  	<input type="hidden" name="status" value=2 id="status">
  	
    <div id="zhongxin">
      <table id="table_report" class="table table-striped table-bordered table-hover">
        <tr>
	      <th>资讯类型:</th>
          <td>
            <select class="chzn-select" name="typeId" id="typeId"   class="chzn-select" style="vertical-align:top;width: 115px">             
               <option value="${info.consultationTypeId}">${info.typeName }</option>
            </select>
          </td>
        </tr>
         <tr>
	      <th>城市:</th>
          <td>
            <select  name="provinceId" id="provinceId" onchange="select1()"   class="chzn-select" style="vertical-align:top;width: 115px">
              		<option value="">省份</option> 
              <c:forEach items="${provinceList}" var="district">
                <option value="${district.provinceId}" >${district.provinceName}</option>
              </c:forEach>
            </select>
            <select  name="cityId" id="cityId"  onchange="select2()"  class="chzn-select" style="vertical-align:top;width: 115px">
              <option value="">城市</option>                          
            </select>
            <select  name="areaId" id="areaId"    class="chzn-select" style="vertical-align:top;width: 115px">
              <option value="0">区域</option>           
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
          <th>简介:</th>
          <td>
            <textarea  style="width: 400px;height: 150px" name="consultationDesc" id="desc"  placeholder="这里输入简介,最多可输入100个字" ></textarea>
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
            <span style="color: red;font-size:15px;" >注:图片尺寸 宽:750 PX,高:300 PX</span>
          </td>       
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
	
	//简介
	$("#desc").blur(function(){	
		var desc = $('#desc').val();
		if(desc.length>100){
			$("#desc").tips({
				side:3,
	            msg:'简介不能超过100个字！',
	            bg:'#AE81FF',
	            time:2
	        });
			$("#desc").focus();
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
	
	new img2base64("fileInput", "url", "imgHref", "imgBox");
	
	
  </script>
  <script type="text/javascript">
    var map = new BMap.Map("container");//在指定的容器内创建地图实例
    map.setDefaultCursor("crosshair");//设置地图默认的鼠标指针样式
    map.enableScrollWheelZoom();//启用滚轮放大缩小，默认禁用。
    map.centerAndZoom(new BMap.Point(116.124878, 24.309178), 13);
    map.addControl(new BMap.NavigationControl());
    map.addEventListener("click", function(e){//地图单击事件
        document.getElementById("lonlat").value = e.point.lng + ", " + e.point.lat;
    });
    function iploac(result){//根据IP设置地图中心
        var cityName = result.name;
        map.setCenter(cityName);
    }
    var myCity = new BMap.LocalCity();
    myCity.get(iploac);
    function sear(result){//地图搜索
        var local = new BMap.LocalSearch(map, {
            renderOptions:{map: map}
        });
        local.search(result);
    }
</script>
<script type="text/javascript">
    var _gaq = _gaq || [];
    _gaq.push(['_setAccount', 'UA-12599330-14']);
    _gaq.push(['_trackPageview']);
    (function() {
        var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
        ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
        var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
    })();
</script>
</body>
</html>