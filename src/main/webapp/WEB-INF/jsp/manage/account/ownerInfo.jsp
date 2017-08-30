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

		<link rel="stylesheet" type="text/css" href="TenantManage/css/base.css">

		<style type="text/css">

			/* 以下为下半区域 */
			.fill_in_info {
				background: #f5f5f5;
				padding-top: 20px;
				position: relative;
			}

			.fill_in {
				margin: 0 auto;
				width: 1200px;
				height: 840px;
				background: #fff;
				padding-top: 20px;
			}

			.info_box {
				text-align: center;
				font-size: 14px;
			}

			.info_box > h2 {
				font-size: 20px;
				font-weight: 500;
				color: #4d4d4d;
				margin-bottom: 40px;
			}

			.proposer_info {
				display: -webkit-flex;
				display: -moz-flex;
				display: -ms-flex;
				display: -o-flex;
				display: flex;
			}

			.proposer_info > div, .faren_info > div {
				display: inline-block;
				-webkit-flex: 1;
				flex: 1;
			}

			.info_faren_name > p {
				text-align: right;
				display: inline-block;
				width: 100px;
				font-size: 14px;
				color: #4d4d4d;
				position: relative;
				margin-right: 10px;
			}

			.proposer_info input, .seller_box input, .proposer_info select {
				width: 200px;
				height: 30px;
				border: 1px solid #000;
				padding-left: 10px;
			}

			.credentials_flex {
				display: -webkit-flex;
				display: -moz-flex;
				display: -ms-flex;
				display: -o-flex;
				display: flex;
				flex-direction: column;
				font-size: 14px;
			}

			.credentials {
				/*line-height: 140px;*/
				margin-top: -5px;
				padding-left: 50px;
				flex-wrap: wrap;
			}

			.photograph_box {
				display: inline-block;
				width: 180px;
				text-align: center;
				margin-left: 15px;
			}

			.credentials > span {
				/*flex: 1;*/
				text-align: right;
				height: 140px;
				line-height: 150px;
				vertical-align: text-bottom;
				position: relative;
				margin-left: -15px;
				display: inline-block;
				width: 88px;
				margin-right: 0;
			}

			.photograph {
				width: 181px;
				height: 120px;
				border: 2px dashed #b2b2b2;
				display: inline-block;
				text-align: center;
				margin-bottom: 10px;
			}
			/*商户信息 Start*/
			.seller_box > span {
				flex: 1;
			}
			.seller_box > input {
				flex: 9;
			}
			.seller_box > h2 {
				flex: 1;
			}
			.seller_box > span::after {
				top: 25%;
			}
		</style>

	</head>
<body>

	<form action="<%=basePath%>account/${msg }.do" name="usersForm" id="usersForm" method="post" >
		<input type="hidden" name="action" id="action" value="${pd.action }" />
		<input type="hidden" name="shopOwnerInfoId" value="${shopOwner.shopOwnerInfoId}" />
		<input type="hidden" name="shopId" id=shopId value="${shopOwner.shopId }" />
	<div id="zhongxin" >
	<!-- 商家个人信息 -->
		<div id="individual_info" class="fill_in_info">
			<div class="fill_in">
				<div class="info_box">
					<div class="proposer_info">
						<div class="info_name">
							<span >申请人姓名:</span>
							<input type="text" name="applicant" id="applicant" <c:if test="${action ==4}">disabled="disabled"</c:if> value="${shopOwner.applicant}" onkeyup="validateUtils.replaceSpaceEmpty(this);"/>
						</div>
						<div class="info_type">
							<span >证件类型:</span>
							<select <c:if test="${action ==4}">disabled="disabled"</c:if> name="applicantCertificateType" id="applicantCertificateType">
							   <option value="1" <c:if test="${shopOwner.applicantCertificateType eq 1}">selected="selected"</c:if>>居民身份证</option>
							   <option value="2" <c:if test="${shopOwner.applicantCertificateType eq 2}">selected="selected"</c:if>>港澳通行证</option>
							   <option value="3" <c:if test="${shopOwner.applicantCertificateType eq 3}">selected="selected"</c:if>>驾驶证</option>  
							</select>
						</div>
						<div class="info_number">
							<span>证件号:</span>
							<input type="text" name="applicantCertificateNum" id="applicantCertificateNum" <c:if test="${action ==4}">disabled="disabled"</c:if> onkeyup="validateUtils.replaceSpaceEmpty(this);" value="${shopOwner.applicantCertificateNum}"/>
						</div>
					</div>

					<div class="mt20 proposer_info">
						<div class="info_faren_name">
							<span>法人姓名:</span>
							<input type="text" name="corporation" id="corporation" <c:if test="${action ==4}">disabled="disabled"</c:if> value="${shopOwner.corporation}" onkeyup="validateUtils.replaceSpaceEmpty(this);"/>
						</div>
						<div class="info_faren_type">
							<span>法人证件类型:</span>
							<select <c:if test="${action ==4}">disabled="disabled"</c:if> name="corporationCertificateType" id="corporationCertificateType" >
							  	<option value="1" <c:if test="${shopOwner.corporationCertificateType eq 1}">selected="selected"</c:if>>居民身份证</option>
								<option value="2" <c:if test="${shopOwner.corporationCertificateType eq 2}">selected="selected"</c:if>>港澳通行证</option>
								<option value="3" <c:if test="${shopOwner.corporationCertificateType eq 3}">selected="selected"</c:if>>驾驶证</option>
							</select>	
						</div>
						<div class="info_faren_number">
							<span>法人证件号:</span>
							<input type="text" name="corporationCertificateNum" id="corporationCertificateNum" <c:if test="${action ==4}">disabled="disabled"</c:if> onkeyup="validateUtils.replaceSpaceEmpty(this);" value="${shopOwner.corporationCertificateNum}"/>
						</div>
					</div>
				</div>
				<div class="credentials_flex">
					<!-- 申请人证件照 -->
					<div class="credentials">
						<span >申请人证件照:</span>
						<div class="photograph_box">
							<div class="photograph">
							 <c:if test="${shopOwner != null && shopOwner.identityFront != '' && shopOwner.identityFront != null }">
                              <a id="imgBox" href="<%=httpUrl%>${shopOwner.identityFront}" title="证件照正面">
                              <img src="<%=httpUrl%>${shopOwner.identityFront}" alt="证件照正面" style="width: 180px;height: 115px" id="imgHref"/>
                              </a>
                              </c:if> 
							</div>
							<span>证件照正面</span>
						</div>
						<input type="button" class="btn btn-mini btn-danger" value="更改" onclick="changeImg()" id="chImg" />
						<input type="file" id="fileInput" name="fileInput" style="display:none;" value="2"  />
						<input id="url" name="img1" type="hidden" />
						
						<div class="photograph_box">
							<div class="photograph">
							  <c:if test="${shopOwner != null && shopOwner.identityBack != '' && shopOwner.identityBack != null }">
                              <a id="imgBoxEw" href="<%=httpUrl%>${shopOwner.identityBack}" title="证件照反面">
                              <img src="<%=httpUrl%>${shopOwner.identityBack}" alt="证件照反面" style="width: 180px;height: 115px" id="imgHrefEw"/>
                              </a>
                              </c:if> 
							</div>
							<span>证件照反面</span>
						</div>
						<input type="button" class="btn btn-mini btn-danger" value="更改" onclick="changeImgEw()" id="chImgEw" />
						<input type="file" id="fileInputEw" name="fileInputEw" style="display:none;" value="2"  />
						<%--<font color="red">注：(图片尺寸规格340px * 340px)</font>--%>
						<input id="urlEw" name="img2" type="hidden" />
					</div>
					<!-- 营业执照 -->
					<div class="credentials">
						<span>营业执照:</span>
						<div class="photograph_box">
							<div class="photograph">
							  <c:if test="${shopOwner != null && shopOwner.businessLicence != '' && shopOwner.businessLicence != null }">
                              <a id="imgBoxBg"  href="<%=httpUrl%>${shopOwner.businessLicence}" title="营业执照">
                              <img src="<%=httpUrl%>${shopOwner.businessLicence}" alt="营业执照" style="width: 180px;height: 115px" id="imgHrefBg" />
                              </a>
                              </c:if> 
							</div>
						</div>
						<input type="button" class="btn btn-mini btn-danger" value="更改" onclick="changeImgBg()" id="chImgBg" />
						<input type="file" id="fileInputBg" name="fileInputBg" style="display:none;" value="2"  />
						<%--<font color="red">注：(图片尺寸规格340px * 340px)</font>--%>
						<input id="urlBg" name="img3" type="hidden" />
					</div>
					<!-- 经营许可证 -->
					<div class="credentials">
						<span>经营许可证:</span>
						<div class="photograph_box">
							<div class="photograph">
							  <c:if test="${shopOwner != null && shopOwner.businessCertificate != '' && shopOwner.businessCertificate != null }">
                              <a id="imgBoxB"  href="<%=httpUrl%>${shopOwner.businessCertificate}" title="经营许可证" >
                              <img src="<%=httpUrl%>${shopOwner.businessCertificate}" alt="经营许可证" style="width: 180px;height: 115px" id="imgHrefB"/>
                              </a>
                              </c:if>
							</div>
						</div>
						<input type="button" class="btn btn-mini btn-danger" value="更改" onclick="changeImgB()" id="chImgB" />
						<input type="file" id="fileInputB" name="fileInputB" style="display:none;" value="2"  />
						<%--<font color="red">注：(图片尺寸规格340px * 340px)</font>--%>
						<input id="urlB" name="img4" type="hidden" />

					</div>
				</div>
				<div class="center">
					<a class="btn btn-mini btn-primary" onclick="save();">保存</a>
				</div>

	    </div>
	  </div>
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
	<%--<script type="text/javascript" src="static/js/jquery-1.7.2.js"></script>--%>
	<%--<script src="TenantManage/js/jquery-1.11.1.min.js"></script>--%>
	<!--引入弹窗组件start-->
	<script type="text/javascript" src="plugins/attention/zDialog/zDrag.js"></script>
	<script type="text/javascript" src="plugins/attention/zDialog/zDialog.js"></script>
	<!--引入弹窗组件end-->
	<!--提示框-->
	<script type="text/javascript" src="static/js/jquery.tips.js"></script>
		
	<script type="text/javascript" src="static/js/base64.js"></script>
	<!-- 压缩图片 -->
	<link rel="stylesheet" type="text/css" href="plugins/fancyBox/jquery.fancybox.css">
	<script type="text/javascript" src="plugins/fancyBox/jquery.fancybox.pack.js"></script>
	<!-- 查看图片 -->
	<script type="text/javascript" src="static/js/chosen.jquery.min.js"></script><!-- 下拉框 -->
	<script type="text/javascript" src="static/js/common/commonutils.js"></script><%--工具方法--%>
	<script type="text/javascript">
	$(top.hangge());

	$(function () {

		$("#fileInput").change(function(){
			var butarr = [".bmp",".png",".gif",".jpeg",".jpg"];//数组存放 图片类型
			var value = $("#fileInput").val();
			var arr = value.substr(value.lastIndexOf(".")).toLowerCase();
			if($.inArray(arr, butarr)==-1){
				if("${action}" == 1){
					$("#fileInput").tips({
						side : 3,
						msg : '请上传图片格式的文件',
						bg : '#AE81FF',
						time : 2
					});
				}
				if("${action}" == 2){
					$("#chImg").tips({
						side : 3,
						msg : '请上传图片格式的文件',
						bg : '#AE81FF',
						time : 2
					});
				}
				return false;
			}
		});

		$("#fileInputEw").change(function(){
			var butarr = [".bmp",".png",".gif",".jpeg",".jpg"];//数组存放 图片类型
			var value = $("#fileInputEw").val();
			var arr = value.substr(value.lastIndexOf(".")).toLowerCase();
			if($.inArray(arr, butarr)==-1){
				if("${action}" == 1){
					$("#fileInputEw").tips({
						side : 3,
						msg : '请上传图片格式的文件',
						bg : '#AE81FF',
						time : 2
					});
				}
				if("${action}" == 2){
					$("#chImgEw").tips({
						side : 3,
						msg : '请上传图片格式的文件',
						bg : '#AE81FF',
						time : 2
					});
				}
				return false;
			}
		});

		$("#fileInputBg").change(function(){
			var butarr = [".bmp",".png",".gif",".jpeg",".jpg"];//数组存放 图片类型
			var value = $("#fileInputBg").val();
			var arr = value.substr(value.lastIndexOf(".")).toLowerCase();
			if($.inArray(arr, butarr)==-1){
				if("${action}" == 1){
					$("#fileInputBg").tips({
						side : 3,
						msg : '请上传图片格式的文件',
						bg : '#AE81FF',
						time : 2
					});
				}
				if("${action}" == 2){
					$("#chImgBg").tips({
						side : 3,
						msg : '请上传图片格式的文件',
						bg : '#AE81FF',
						time : 2
					});
				}
				return false;
			}
		});

		$("#fileInputB").change(function(){
			var butarr = [".bmp",".png",".gif",".jpeg",".jpg"];//数组存放 图片类型
			var value = $("#fileInputB").val();
			var arr = value.substr(value.lastIndexOf(".")).toLowerCase();
			if($.inArray(arr, butarr)==-1){
				if("${action}" == 1){
					$("#fileInputB").tips({
						side : 3,
						msg : '请上传图片格式的文件',
						bg : '#AE81FF',
						time : 2
					});
				}
				if("${action}" == 2){
					$("#chImgB").tips({
						side : 3,
						msg : '请上传图片格式的文件',
						bg : '#AE81FF',
						time : 2
					});
				}
				return false;
			}
		});

	})


	//申请人证件照正面
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
	//放大图片
	$("#imgBox").fancybox({
		helpers : {
			title : {
				type : 'inside'
			}
		}
	});
	//更改图片
	function changeImg(){
		$("#fileInput").trigger("click");
	}
	new img2base64("fileInput", "url", "imgHref", "imgBox");

	//申请人证件照反面:
	$('#fileInputEw:visible').ace_file_input({
		no_file : '请选择图片 ...',
		btn_choose : '选择',
		btn_change : '更改',
		droppable : false,
		onchange : null,
		thumbnail : false,
		before_remove : function() {
			$("#urlEw").val("");
			$("#imgBoxEw").attr("href", "").hide();
			$("#imgHrefEw").attr("src", "");
			return true;
		}
	});
	//放大图片
	$("#imgBoxEw").fancybox({
		helpers : {
			title : {
				type : 'inside'
			}
		}
	});
	//更改图片
	function changeImgEw(){
		$("#fileInputEw").trigger("click");
	}
	new img2base64("fileInputEw", "urlEw", "imgHrefEw", "imgBoxEw");

	//营业执照
	$('#fileInputBg:visible').ace_file_input({
		no_file : '请选择图片 ...',
		btn_choose : '选择',
		btn_change : '更改',
		droppable : false,
		onchange : null,
		thumbnail : false,
		before_remove : function() {
			$("#urlBg").val("");
			$("#imgBoxBg").attr("href", "").hide();
			$("#imgHrefBg").attr("src", "");
			return true;
		}
	});
	//放大图片
	$("#imgBoxBg").fancybox({
		helpers : {
			title : {
				type : 'inside'
			}
		}
	});
	//更改图片
	function changeImgBg(){
		$("#fileInputBg").trigger("click");
	}
	new img2base64("fileInputBg", "urlBg", "imgHrefBg", "imgBoxBg");

	//经营许可证
	$('#fileInputB:visible').ace_file_input({
		no_file : '请选择图片 ...',
		btn_choose : '选择',
		btn_change : '更改',
		droppable : false,
		onchange : null,
		thumbnail : false,
		before_remove : function() {
			$("#urlB").val("");
			$("#imgBoxB").attr("href", "").hide();
			$("#imgHrefB").attr("src", "");
			return true;
		}
	});
	//放大图片
	$("#imgBoxB").fancybox({
		helpers : {
			title : {
				type : 'inside'
			}
		}
	});
	//更改图片
	function changeImgB(){
		$("#fileInputB").trigger("click");
	}
	new img2base64("fileInputB", "urlB", "imgHrefB", "imgBoxB");



	// 身份证
	function certifi ( str ) {
		var reg = /(^\d{15}$)|(^\d{18}$)|(^\d{17}(\d|X|x)$)/;
		if(!reg.test(str)) {
			return true;
		} else {
			return false;
		}
	}

	// 港澳通行证验证
	$.extend({"isHKMacao": function(value, type) {
		var reg = /^[HMhm]{1}([0-9]{10}|[0-9]{8})$/;
		console.log(value)
		if (!reg.test(value)) {
			return false;
		} else {
			return true;
		}
	}});

	function save(){

			var otype= $("#otype").val();
			var nameStoreId =  $("#nameStoreId").find("option:selected").attr("nameStoreId");
			$("#shopName").val(nameStoreId);

			var applicant = $('#applicant').val();
			if(validateUtils.isEmpty(applicant)){
				$("#applicant").tips({
					side:3,
					msg:'申请人姓名不能为空！',
					bg:'#AE81FF',
					time:2
				});
				$("#applicant").focus();
				return false;
			}
		var applicantCertificateNum = $('#applicantCertificateNum').val();

		if(validateUtils.isEmpty(applicantCertificateNum)){
			$("#applicantCertificateNum").tips({
				side:3,
				msg:'证件号不能为空！',
				bg:'#AE81FF',
				time:2
			});
			$("#applicantCertificateNum").focus();
			return false;
		}
		// 证件号类型
		var applicantCertificateType = $('#applicantCertificateType').val();
		if ( applicantCertificateType == 1 ||applicantCertificateType == 3 ) {// 身份证
			if(certifi(applicantCertificateNum)){
				$("#applicantCertificateNum").tips({
					side:3,
					msg:'证件号格式不正确！',
					bg:'#AE81FF',
					time:2
				});
				$("#applicantCertificateNum").focus();
				return false;
			}

		} else if ( applicantCertificateType == 2 ) { // 港澳通行证
			if ( !$.isHKMacao(applicantCertificateNum) ) {
				$("#applicantCertificateNum").tips({
					side:3,
					msg:'港澳通行证格式不正确！',
					bg:'#AE81FF',
					time:2
				});
				$("#applicantCertificateNum").focus();
				return false;
			}
		}

		var corporation = $('#corporation').val();
		if(validateUtils.isEmpty(corporation)){
			$("#corporation").tips({
				side:3,
				msg:'法人姓名不能为空！',
				bg:'#AE81FF',
				time:2
			});
			$("#corporation").focus();
			return false;
		}
		var corporationCertificateNum = $('#corporationCertificateNum').val();
		if(validateUtils.isEmpty(corporationCertificateNum)){
			$("#corporationCertificateNum").tips({
				side:3,
				msg:'法人证件号不能为空！',
				bg:'#AE81FF',
				time:2
			});
			$("#corporationCertificateNum").focus();
			return false;
		}
		// 法人证件号类型
		var corporationCertificateType = $('#corporationCertificateType').val();
		if ( corporationCertificateType == 1 ||corporationCertificateType == 3 ) {// 身份证
			if(certifi(corporationCertificateNum)){
				$("#corporationCertificateNum").tips({
					side:3,
					msg:'证件号格式不正确！',
					bg:'#AE81FF',
					time:2
				});
				$("#corporationCertificateNum").focus();
				return false;
			}

		} else if ( corporationCertificateType == 2 ) { // 港澳通行证
			if ( !$.isHKMacao(applicantCertificateNum) ) {
				$("#applicantCertificateNum").tips({
					side:3,
					msg:'港澳通行证格式不正确！',
					bg:'#AE81FF',
					time:2
				});
				$("#applicantCertificateNum").focus();
				return false;
			}
		}
		var fileData = $('#fileInput').val();
		if(fileData != '' ){
			var butarr = [".bmp",".png",".gif",".jpeg",".jpg"];//数组存放 图片类型
			var arr = fileData.substr(fileData.lastIndexOf(".")).toLowerCase();
			if($.inArray(arr, butarr)==-1){
				if("${action}" == 2){
					$("#chImg").tips({
						side : 3,
						msg : '请上传图片格式的文件',
						bg : '#AE81FF',
						time : 2
					});
				}
				return false;
			}
		}
		var fileData = $('#fileInputEw').val();
		if(fileData != '' ){
			var butarr = [".bmp",".png",".gif",".jpeg",".jpg"];//数组存放 图片类型
			var arr = fileData.substr(fileData.lastIndexOf(".")).toLowerCase();
			if($.inArray(arr, butarr)==-1){
				if("${action}" == 2){
					$("#chImgEw").tips({
						side : 3,
						msg : '请上传图片格式的文件',
						bg : '#AE81FF',
						time : 2
					});
				}
				return false;
			}
		}
		var fileData = $('#fileInputBg').val();
		if(fileData != '' ){
			var butarr = [".bmp",".png",".gif",".jpeg",".jpg"];//数组存放 图片类型
			var arr = fileData.substr(fileData.lastIndexOf(".")).toLowerCase();
			if($.inArray(arr, butarr)==-1){
				if("${action}" == 2){
					$("#chImgBg").tips({
						side : 3,
						msg : '请上传图片格式的文件',
						bg : '#AE81FF',
						time : 2
					});
				}
				return false;
			}
		}
		var fileData = $('#fileInputB').val();
		if(fileData != '' ){
			var butarr = [".bmp",".png",".gif",".jpeg",".jpg"];//数组存放 图片类型
			var arr = fileData.substr(fileData.lastIndexOf(".")).toLowerCase();
			if($.inArray(arr, butarr)==-1){
				if("${action}" == 2){
					$("#chImgB").tips({
						side : 3,
						msg : '请上传图片格式的文件',
						bg : '#AE81FF',
						time : 2
					});
				}
				return false;
			}
		}

		$("#usersForm").submit()
		alert("操作完成");

	};

	</script>
</body>
</html>