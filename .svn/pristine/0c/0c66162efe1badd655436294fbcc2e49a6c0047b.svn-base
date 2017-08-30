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
				height: 800px;
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
				margin-top: 15px;
				padding-left: 63px;
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

	<form action="" name="usersForm" id="usersForm" method="post" enctype="application/x-www-form-urlencoded">
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
                              <img src="<%=httpUrl%>${shopOwner.identityFront}" alt="证件照正面" style="width: 180px;height: 115px"/>
                              </a>
                              </c:if> 
							</div>
							<span>证件照正面</span>
						</div>
						
						<div class="photograph_box">
							<div class="photograph">
							  <c:if test="${shopOwner != null && shopOwner.identityBack != '' && shopOwner.identityBack != null }">
                              <a id="imgBoxEw" href="<%=httpUrl%>${shopOwner.identityBack}" title="证件照反面">
                              <img src="<%=httpUrl%>${shopOwner.identityBack}" alt="证件照反面" style="width: 180px;height: 115px"/>
                              </a>
                              </c:if> 
							</div>
							<span>证件照反面</span>
						</div>
					</div>
					<!-- 营业执照 -->
					<div class="credentials">
						<span>营业执照:</span>
						<div class="photograph_box">
							<div class="photograph">
							  <c:if test="${shopOwner != null && shopOwner.businessLicence != '' && shopOwner.businessLicence != null }">
                              <a id="imgBoxBg"  href="<%=httpUrl%>${shopOwner.businessLicence}" title="营业执照">
                              <img src="<%=httpUrl%>${shopOwner.businessLicence}" alt="营业执照" style="width: 180px;height: 115px" />
                              </a>
                              </c:if> 
							</div>
						</div>
					</div>
					<!-- 经营许可证 -->
					<div class="credentials">
						<span>经营许可证:</span>
						<div class="photograph_box">
							<div class="photograph">
							  <c:if test="${shopOwner != null && shopOwner.businessCertificate != '' && shopOwner.businessCertificate != null }">
                              <a id="imgBoxB"  href="<%=httpUrl%>${shopOwner.businessCertificate}" title="经营许可证">
                              <img src="<%=httpUrl%>${shopOwner.businessCertificate}" alt="经营许可证" style="width: 180px;height: 115px" />
                              </a>
                              </c:if> 
							</div>
						</div>
					</div>
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

	//图片放大
	$("#imgBox").fancybox({
		helpers : {
			title : {
				type : 'inside'
			}
		}
	});
	$("#imgBoxBg").fancybox({
		helpers : {
			title : {
				type : 'inside'
			}
		}
	});

	$("#imgBoxEw").fancybox({
		helpers : {
			title : {
				type : 'inside'
			}
		}
	});
	$("#imgBoxB").fancybox({
		helpers : {
			title : {
				type : 'inside'
			}
		}
	});

	</script>
</body>
</html>