<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.aoshi.util.PropertyUtils"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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

		//保存
		function save(){
			if($("#beaconName").val()==""||$.trim($("#beaconName").val())==""){
				$("#beaconName").tips({
					side:3,
					msg:'名称范围',
					bg:'#AE81FF',
					time:2
				});
				$("#beaconName").focus();
				return false;
			}

			if($("#beaconMac").val()==""||$.trim($("#beaconMac").val())==""){
				$("#beaconMac").tips({
					side:3,
					msg:'mac地址',
					bg:'#AE81FF',
					time:2
				});
				$("#beaconMac").focus();
				return false;
			}

		 	if($("#beaconUid").val()==""||$.trim($("#beaconUid").val())==""){
				$("#beaconUid").tips({
					side:3,
					msg:'UUID',
					bg:'#AE81FF',
					time:2
				});
				$("#beaconUid").focus();
				return false;
			} 

			if($("#major").val()==""||$.trim($("#major").val())==""){
				$("#major").tips({
					side:3,
					msg:'major值',
					bg:'#AE81FF',
					time:2
				});
				$("#major").focus();
				return false;
			}
			
			if($("#minor").val()==""||$.trim($("#minor").val())==""){
				$("#minor").tips({
					side:3,
					msg:'minor值',
					bg:'#AE81FF',
					time:2
				});
				$("#minor").focus();
				return false;
			}
			
			if($("#screenSystem").val()==""||$.trim($("#screenSystem").val())==""){
				$("#screenSystem").tips({
					side:3,
					msg:'上下屏系统',
					bg:'#AE81FF',
					time:2
				});
				$("#screenSystem").focus();
				return false;
			}
			
			if($("#screenModel").val()==""||$.trim($("#screenModel").val())==""){
				$("#screenModel").tips({
					side:3,
					msg:'上下屏型号',
					bg:'#AE81FF',
					time:2
				});
				$("#screenModel").focus();
				return false;
			}

			// 提交表单
			form.submit($('#usersForm'));
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

						}else if(data.status == 1){
							
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
</head>
<body>

<form action="link/beacon/update.do" name="usersForm" id="usersForm" method="post" enctype="multipart/form-data">
	<input type="hidden" name="beaconId" id="beaconId" value="${asBeacon.beaconId}">
	<div id="zhongxin" >
		<table id="table_report" class="table table-striped table-bordered table-hover" style="overflow:scroll;">
			<tr height="45px">
				<td width="100px">所属分类:</td>
				<td>
					<select name="categoryId" >
						<c:forEach items="${categoryList }" var="var">
							<option value="${var.id }" <c:if test="${var.id == asBeacon.categoryId}">selected="selected"</c:if>>${var.name}</option>
						</c:forEach>
					</select>
				</td>
			</tr>
			<tr height="45px">
				<td width="100px">名称范围:</td>
				<td>
					<input type="text" style="width:370px;" name="beaconName" id="beaconName"  value="${asBeacon.beaconName}" />
				</td>
			</tr>
			<tr height="45px">
				<td width="100px">mac地址:</td>
				<td>
					<input type="text" style="width:370px;" name="beaconMac" id="beaconMac" value="${asBeacon.beaconMac}" />
				</td>
			</tr>
			<tr height="45px">
				<td width="100px">UUID:</td>
				<td>
				     <input type="text" style="width:370px;" name="beaconUid" id="beaconUid" value="${asBeacon.beaconUid}"/>       
				</td>
			</tr>
			<tr height="45px">
				<td width="100px">蓝牙名称:</td>
				<td>
				     <input type="text" style="width:370px;" name="beaconBlue" id="beaconBlue" value="${asBeacon.beaconBlue}" />       
				</td>
			</tr>
			<tr height="45px">
				<td width="100px">major:</td>
				<td>
				     <input type="text" style="width:370px;" name="major" id="major" value="${asBeacon.major}"/>       
				</td>
			</tr>
			<tr height="45px">
				<td width="100px">minor:</td>
				<td>
				     <input type="text" style="width:370px;" name="minor" id="minor"  value="${asBeacon.minor}"/>       
				</td>
			</tr>
			<tr height="45px">
				<td width="100px">终端名称:</td>
				<td>
				     <input type="text" style="width:370px;" name="screenName" id="screenName" value="${asBeacon.screenName}" />       
				</td>
			</tr>
			<tr height="45px">
				<td width="100px">上屏编码:</td>
				<td>
				     <input type="text" style="width:370px;" name="upScreenCode" id="upScreenCode" value="${asBeacon.upScreenCode}"/>       
				</td>
			</tr>
			<tr height="45px">
				<td width="100px">下屏编码:</td>
				<td>
				     <input type="text" style="width:370px;" name="downScreenCode" id="downScreenCode" value="${asBeacon.downScreenCode}"/>       
				</td>
			</tr>
			<tr height="45px">
				<td width="100px">上下屏系统:</td>
				<td>
				     <input type="text" style="width:370px;" name="screenSystem" id="screenSystem" value="${asBeacon.screenSystem}" />       
				</td>
			</tr>
			<tr height="45px">
				<td width="100px">上下屏型号:</td>
				<td>
				     <input type="text" style="width:370px;" name="screenModel" id="screenModel" value="${asBeacon.screenModel}" />       
				</td>
			</tr>
			<tr height="45px">
				<td width="100px">开机时间:</td>
				<td>
				     <input type="text" style="width:370px;" name="startupTime" id="startupTime" value="${fn:escapeXml(asBeacon.startupTime)}"/>       
				</td>
			</tr>
			<tr height="45px">
				<td width="100px">关机时间:</td>
				<td>
				     <input type="text" style="width:370px;" name="shutdownTime" id="shutdownTime" value="${fn:escapeXml(asBeacon.shutdownTime)}"/>       
				</td>
			</tr>
			<tr height="45px">
				<td width="100px">终端地址:</td>
				<td>
				     <input type="text" style="width:370px;" name="screenAddress" id="screenAddress" value="${asBeacon.screenAddress}" />       
				</td>
			</tr>
			<tr height="45px">
				<td width="100px">屏幕类型:</td>
				<td>
				     <input type="text" style="width:370px;" name="screenType" id="screenType" value="${asBeacon.screenType}" />       
				</td>
			</tr>
			<tr height="45px">
				<td width="100px">备注:</td>
				<td>		
				     <textarea style="width:80%;height:150px"  name="beaconRemark" id="beaconRemark">${asBeacon.beaconRemark}</textarea>				    
				</td>
			</tr>
			<tr height="45px">
				<td class="center" colspan="2">
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

	$(function() {
		//单选框
		$(".chzn-select").chosen();
		$(".chzn-select-deselect").chosen({allow_single_deselect:true});
	});
</script>
</body>
</html>