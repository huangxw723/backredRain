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

		//更改图片
		function changeImg(){
			$("#fileInput").trigger("click");
		}

		//更改图片
		function changeImg2(){
			$("#fileInput2").trigger("click");
		}

		function selectImg($this){
			$this.style.display = "none";
			$($this).after('<input style="width: 75px;" type="file" onchange="selectImg(this)" name="files">');


			var files = $this.files;
			var fileSize =$(files)[0].size/1024;
			//alert(fileSize);
			if(parseInt(fileSize)>10240){
				$($this).remove();
				alert("图片大小不能大于10M");
				return;
			}

			var thisvalue = $($this).val();
			var fileType = thisvalue.substr(thisvalue.lastIndexOf(".")).toLowerCase();//获得文件后缀名
			if (null!=fileType) {
				if (fileType != '.gif' && fileType != '.png' && fileType != '.jpg' && fileType != '.jpeg') {
					$($this).remove();
					alert("请上传图片格式的文件");
					return;
				}
			}

			var imgNumber = $(".imgss").length + $(".imgs").length+files.length;
			//alert(imgNumber);
			if(parseInt(imgNumber) >5){
				$($this).remove();
				alert("一共只能存在6张广告图片");
				return ;
			}
			if (files) {
				if(files.length >5){
					bootbox.alert("一次性只能添加5张图片");
					return ;
				}
				for(var i=0;i<files.length;i++){
					var FR= new FileReader();
					FR.onload = function(e) {
						var result = base64Shorter(e.target.result);
						$("#images").append('<br><input class="shopFoodName" type="text" name="shopFoodName" id="shopFoodName" value="" placeholder="这里输入菜名" maxlength="10"/> '+'<img class="imgs" style="max-height:100px;max-width:100px;margin-left: 5px;margin-top: 5px" id="img" src="'+result+'">');
						$("#imgClean").show();
					};
					FR.readAsDataURL( files[i] );
				}
			}
		}
		function cleanImg(){
			var imgs = $(".imgs");
			var len = imgs.length;
			$(".imgs")[len-1].remove();
			if(len == 1){
				$("#images").empty();
				$("#imgClean").hide();
			}

			$("[type=file]")[len-1].remove();
			$(".shopFoodName")[len-1].remove();
		}

		//保存
		function save(id){
			if(id==1){
				$("#type").val("1")
			}else if(id==2){
				$("#type").val("2")
			}
            if($("#ypBaseCategoryId").val()==""||$.trim($("#ypBaseCategoryId").val())=="" ){
                $("#ypBaseCategoryId").tips({
                    side:3,
                    msg:'选择品类',
                    bg:'#AE81FF',
                    time:2
                });
                $("#ypBaseCategoryId").focus();
                return false;
            }
//            if($("#shopTypeYpBaseCategoryId").val()==""||$.trim($("#shopTypeYpBaseCategoryId").val())=="" ){
//                $("#shopTypeYpBaseCategoryId").tips({
//                    side:3,
//                    msg:'选择店铺分类',
//                    bg:'#AE81FF',
//                    time:2
//                });
//                $("#shopTypeYpBaseCategoryId").focus();
//                return false;
//            }
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
            if($("#shopName").val()==""||$.trim($("#shopName").val())=="" ){
                $("#shopName").tips({
                    side:3,
                    msg:'店铺名称',
                    bg:'#AE81FF',
                    time:2
                });
                $("#shopName").focus();
                return false;
            }
//            if($("#site").val()==""||$.trim($("#site").val())=="" ){
//                $("#site").tips({
//                    side:3,
//                    msg:'官网网址',
//                    bg:'#AE81FF',
//                    time:2
//                });
//                $("#site").focus();
//                return false;
//            }

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
            if($("#phone").val()==""||$.trim($("#phone").val())=="" ){
                $("#phone").tips({
                    side:3,
                    msg:'输入电话',
                    bg:'#AE81FF',
                    time:2
                });
                $("#phone").focus();
                return false;
            }
			if(!(/^[0-9]*$/).test($("#phone").val())){
				$("#phone").tips({
					side:3,
					msg:'输入数字',
					bg:'#AE81FF',
					time:2
				});
				$("#phone").focus();
				return false;
			}
            if($("#businessTime").val()==""||$.trim($("#businessTime").val())=="" ){
                $("#businessTime").tips({
                    side:3,
                    msg:'营业时间',
                    bg:'#AE81FF',
                    time:2
                });
                $("#businessTime").focus();
                return false;
            }
            if($("#starLevel").val()==""||$.trim($("#starLevel").val())=="" ){
                $("#starLevel").tips({
                    side:3,
                    msg:'推荐指数',
                    bg:'#AE81FF',
                    time:2
                });
                $("#starLevel").focus();
                return false;
            }
            if(!(/^[+]?[1-4]+(\.[0-9]+)?|5+(\.[0-0]+)?$/.test($("#starLevel").val()))){
                $("#starLevel").tips({
                    side:3,
                    msg:'输入1到5的数字',
                    bg:'#AE81FF',
                    time:2
                });
                $("#starLevel").focus();
                return false;
            }

            if($("#suggestPrice").val()==""||$.trim($("#suggestPrice").val())=="" ){
                $("#suggestPrice").tips({
                    side:3,
                    msg:'参考价',
                    bg:'#AE81FF',
                    time:2
                });
                $("#suggestPrice").focus();
                return false;
            }

            if(!(/^[+]?\d+(\.\d*)?$/.test($("#suggestPrice").val()))){
                $("#suggestPrice").tips({
                    side:3,
                    msg:'输入数字',
                    bg:'#AE81FF',
                    time:2
                });
                $("#suggestPrice").focus();
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
			if(document.getElementById("fileInput2")!=null){
				var fileType2 = document.getElementById("fileInput2").value.substr(document.getElementById("fileInput2").value.lastIndexOf(".")).toLowerCase();//获得文件后缀名
				var url = $("#url2").val();
				var img = $("#imgHref2").attr("src");
				if (!img || url) {
					if (fileType2 != '.gif' && fileType2 != '.png' && fileType2 != '.jpg' && fileType2 != '.jpeg') {
						$("#fileInput2").tips({
							side : 3,
							msg : '请上传图片格式的文件',
							bg : '#AE81FF',
							time : 2
						});
						$("#fileInput2").val('');
						document.getElementById("fileInput2").files[0] = '请选择图片';
						return;
					}
				}
			}


			var numNew = $(".imgs").size();
			var array = new Array();


			for(var i = 0;i<numNew;i++){
				array[i] = $(".imgs")[i].src;
			}
			$("#imgNewAdurls").val(array);

			var shopFoodNames = new Array();

			for(var i = 0;i<$(".shopFoodName").size();i++){
				shopFoodNames[i] = $(".shopFoodName")[i].value;
			}
			$("#shopFoodNameAll").val(shopFoodNames);

			$("#latlng").val($("#lonlat").val());

			// 提交表单
			form.submit($('#usersForm'));
            $("#public").unbind("click")
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

<form action="consultation/shop/addFood.do" name="usersForm" id="usersForm" method="post" enctype="multipart/form-data">
	<input type="hidden" name="shopFoodNameAll" id="shopFoodNameAll" value=" " />
	<input type="hidden" name="imgNewAdurls" id="imgNewAdurls" value=" " />
	<input type="hidden" id="type" name="type" value=""/>
	<input type="hidden" id="close" value="0"/>
	<input type="hidden" id="latlng" name="latlng" value="">
    <input type="hidden" >
	<div id="zhongxin" >
		<table id="table_report" class="table table-striped table-bordered table-hover" style="overflow:scroll;">
			<tr height="45px">
				<td>品类:</td>
				<td>
					<select class="chzn-select" name="ypBaseCategoryId" id="ypBaseCategoryId">
						<c:forEach items="${ypBaseCategoryList}" var="ypBaseCategory">
							<option value="${ypBaseCategory.id}">${ypBaseCategory.name}</option>
						</c:forEach>
					</select>
				</td>
			</tr>
            <%--<tr height="45px">--%>
                <%--<td>店铺分类:</td>--%>
                <%--<td>--%>
                    <%--<select class="chzn-select" name="shopTypeYpBaseCategoryId" id="shopTypeYpBaseCategoryId">--%>
                        <%--<c:forEach items="${shopYpBaseCategoryList}" var="shoppBaseCategory">--%>
                            <%--<option value="${shoppBaseCategory.id}">${shoppBaseCategory.name}</option>--%>
                        <%--</c:forEach>--%>
                    <%--</select>--%>
                <%--</td>--%>
            <%--</tr>--%>
			<tr height="45px">
				<td>区域:</td>
				<td>
					<span>
						省份:
						<select class="chzn-select" name="provinceId" id="provinceId" data-placeholder="请选择省份" style="vertical-align:top;width: 115px">
							<option value=""></option>
							<option value="">全部</option>
							<c:forEach items="${provinceList}" var="province">
								<option value="${province.provinceId }" <c:if test="${province.provinceId == pd.provinceId}">selected</c:if>>${province.provinceName }</option>
							</c:forEach>
						</select>
					</span>
					<span>
					    城市:
					<select class="chzn-select" name="cityId" id="cityId" data-placeholder="请选择城市" style="vertical-align:top;width: 115px">
					</select>
					</span>
					<span>
						区域:
						<select class="chzn-select" name="areaId" id="areaId" data-placeholder="请选择县区" style="vertical-align:top;width: 115px">
						</select>
					</span>
					<span>
						商圈:
						<select class="chzn-select" name="businessDistrictId" id="businessDistrictId" data-placeholder="请选择商圈" style="vertical-align:top;width: 115px">
						</select>
					</span>
				</td>
			</tr>
			<tr height="45px">
				<td>店铺名称:</td>
				<td>
					<input type="text" style="width:370px;" name="shopName" id="shopName"  placeholder="这里输入店铺名称" title="店铺名称" />
				</td>
			</tr>

            <tr height="45px">
                <td>官网网址:</td>
                <td>
                    <input type="text" style="width:370px;" name="site" id="site"  placeholder="这里输入官网网址" title="官网网址" />
					<span style="color: red">(如：https://www.baidu.com)</span>
                </td>
            </tr>

			<tr height="45px">
				<td>地址:</td>
				<td>
					<div id="l-map"></div>
					<input type="text" style="width:90%;" name="address" id="address"  placeholder="这里输入地址" title="地址" />
					<input type="hidden" name="lng" id="lng" />
					<input type="hidden" name="lat" id="lat" />
					<div id="searchResultPanel" style="border:1px solid #C0C0C0;width:150px;height:auto; display:none;"></div>
				</td>
			</tr>

			<tr height="45px">
				<td>电话:</td>
				<td>
					<input type="text" style="width:370px;" name="phone" id="phone"  placeholder="这里输入电话" title="电话" />
				</td>
			</tr>
			<tr height="45px">
				<td>营业时间:</td>
				<td>
					<input type="text" style="width:370px;" name="businessTime" id="businessTime"  placeholder="这里输入营业时间,多个时间段输入以英文符号;分割" title="营业时间" />
                    <span style="color: red">例：10:00--12:00;15:00--20:00</span>
				</td>
			</tr>
			<tr height="45px">
				<td>推荐指数:</td>
				<td>
					<input type="text" style="width:370px;" name="starLevel" id="starLevel"  placeholder="这里输入推荐指数" title="推荐指数" />
				</td>
			</tr>
			<tr height="45px">
				<td>参考价:</td>
				<td>
					<input type="text" style="width:338px;" name="suggestPrice" id="suggestPrice"  placeholder="这里输入参考价" title="参考价" /><span style="font-weight: bold">元/人</span>
				</td>
			</tr>
			<tr>
				<td>封面图:</td>
				<td>
					<c:if test="${asBrand == null || asBrand.brandLogo== '' || asBrand.brandLogo == null }">
						<a id="imgBox" href="javascript:void(0)" style="display:none;">
							<img src="" width="150" id="imgHref" />
						</a>
						<input type="file" id="fileInput" name="fileInput" />
						<span style="color: red; width: 50px;" id="msgDiv" >注：（图片尺寸规格180px * 180px）</span>
						<span style="color: red; width: 50px;" id="msgDivScreen" ></span>
					</c:if>
					<c:if test="${asBrand != null && asBrand.brandLogo != '' && asBrand.brandLogo != null }">
						<a id="imgBox" href="<%=httpUrl%>${asBrand.brandLogo}" title="${asBrand.brandLogo}">
							<img src="<%=httpUrl%>${asBrand.brandLogo}" alt="${asBrand.brandLogo}" width="150" id="imgHref" />
						</a>
						<input type="button" class="btn btn-mini btn-danger" value="更改" onclick="changeImg()" id="chImg" />
						<input type="file" id="fileInput" name="fileInput" style="display:none;" />
					</c:if>
					<input id="url" name="img" type="hidden" />
				</td>
			</tr>

			<tr>
				<td>banner图:</td>
				<td>
					<c:if test="${asBrand == null || asBrand.brandLogo== '' || asBrand.brandLogo == null }">
						<a id="imgBox2" href="javascript:void(0)" style="display:none;">
							<img src="" width="150" id="imgHref2" />
						</a>
						<input type="file" id="fileInput2" name="fileInput2" />
						<span style="color: red; width: 50px;" id="msgDiv2" >注：（图片尺寸规格750px * 380px）</span>
						<span style="color: red; width: 50px;" id="msgDivScreen2" ></span>
					</c:if>
					<c:if test="${asBrand != null && asBrand.brandLogo != '' && asBrand.brandLogo != null }">
						<a id="imgBox2" href="<%=httpUrl%>${asBrand.brandLogo}" title="${asBrand.brandLogo}">
							<img src="<%=httpUrl%>${asBrand.brandLogo}" alt="${asBrand.brandLogo}" width="150" id="imgHref2" />
						</a>
						<input type="button" class="btn btn-mini btn-danger" value="更改" onclick="changeImg2()" id="chImg2" />
						<input type="file" id="fileInput2" name="fileInput2" style="display:none;" />
					</c:if>
					<input id="url2" name="img2" type="hidden" />
				</td>
			</tr>

			<tr height="45px">
				<td colspan="2">推荐菜:<span style="color: red">(注:图片尺寸规格340px * 280px)</span></td>
			</tr>

			<tr height="45px">
				<td><input style="width: 75px;" type='file' onchange="selectImg(this)" name="files"></td>
				<td><a id="imgClean" style="display: none" href="javscript:void(0);" onclick="cleanImg()">清除图片</a>
				<div id="images" style="float: left;border: 1px solid #ccc;"></div></td>
			</tr>
		</table>
		<div height="45px">
				<%--<a class="btn btn-mini btn-primary" onclick="save();">预览</a>--%>
				<a class="btn btn-mini btn-primary" onclick="save(2);" id="public">立即发布</a>
				<a class="btn btn-mini btn-primary" onclick="save(1);">保存为草稿</a>
		</div>
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

	//banner图上传
	$('#fileInput2:visible').ace_file_input({
		no_file : '请选择图片 ...',
		btn_choose : '选择',
		btn_change : '更改',
		droppable : false,
		onchange : null,
		thumbnail : false,
		before_remove : function() {
			$("#url2").val("");
			$("#imgBox2").attr("href", "").hide();
			$("#imgHref2").attr("src", "");
			return true;
		}
	});

	new img2base64("fileInput2", "url2", "imgHref2", "imgBox2");

	$("#imgBox2").fancybox({
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

	});
</script>
</body>
</html>