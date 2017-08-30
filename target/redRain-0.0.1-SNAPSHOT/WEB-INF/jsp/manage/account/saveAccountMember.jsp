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

		<!--引入弹窗组件start-->
		<script type="text/javascript" src="plugins/attention/zDialog/zDrag.js"></script>
		<script type="text/javascript" src="plugins/attention/zDialog/zDialog.js"></script>
		<!--引入弹窗组件end-->
		<!--提示框-->
		<script type="text/javascript" src="static/js/jquery.tips.js"></script>
		<%--工具类--%>
		<script type="text/javascript" src="static/js/common/commonutils.js"></script>

  		
<script type="text/javascript">
	$(top.hangge());
	
	var isExist = false;
	
	$(function() {
		
			//鼠标失焦后验证
			$("#account").blur(function(){
			var account = $('#account').val();
				if(!validateUtils.isEmpty(account)){
					$.ajax({
						type: "POST",
						url: '<%=basePath%>account/accountMemberIsExist.do',
				    	data: {account:account},
						dataType:'json',
						cache: false,
						success: function(data){
							if(data){
								isExist = true;
								$("#account").tips({
									side:3,
						            msg:'该用户账号已经存在',
						            bg:'#AE81FF',
						            time:2
						        });
								$("#account").focus();
								return false;
							}else{
								isExist = false;
							}
						}
					});
				}
			});
			 
				 
				//限制上传的图片
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
						//$("#fileInput").val("");
						return false;
					}
				});
		});
	 
	
	//更改图片
    function changeImg(){
        $("#fileInput").trigger("click");
    }
	
	
	//保存
	function save(){
		

		 if(isExist){
			$("#account").tips({
				side:3,
	            msg:'该用户账号已经存在',
	            bg:'#AE81FF',
	            time:2
	        });
			$("#account").focus();
			return false;
		}
		
		var account = $('#account').val();
		if(validateUtils.isEmpty(account)){
			$("#account").tips({
				side:3,
	            msg:'用户账号不能为空！',
	            bg:'#AE81FF',
	            time:2
	        });
			$("#account").focus();
			return false;
		}

		if(!validateUtils.isMobilePhone(account)){
			$("#account").tips({
				side:3,
				msg:'请填写正确的手机号码！',
				bg:'#AE81FF',
				time:2
			});
			$("#account").focus();
			return false;
		}

		var nickName = $('#nickName').val();
		if(validateUtils.isEmpty(nickName)){
			$("#nickName").tips({
				side:3,
				msg:'用户昵称不能为空！',
				bg:'#AE81FF',
				time:2
			});
			$("#nickName").focus();
			return false;
		}

			var pattern = new RegExp(/^\"|\"|\'|\'$/g);
			var b = pattern.test(name);
			if(b){
				$("#name").tips({
					side:3,
					msg:'用户昵称中不能包含英语的双引号或单引号',
					bg:'#AE81FF',
					time:2
				});
				$("#name").focus();
				return false;
			}
		/* if(name.length<2 || name.length>10){
			$("#name").tips({
				side:3,
	            msg:'2~10个字',
	            bg:'#AE81FF',
	            time:2
	        });
			$("#name").focus();
			return false;
		} */

		var fileData = $('#fileInput').val();

			if(fileData != '' ){
				var butarr = [".bmp",".png",".gif",".jpeg",".jpg"];//数组存放 图片类型
				var arr = fileData.substr(fileData.lastIndexOf(".")).toLowerCase();
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
			}

		// 提交表单
		form.submit($('#usersForm'));
	}

</script>
	</head>
<body>

	<form action="account/saveAccountMember0pera.do" name="usersForm" id="usersForm" method="post">
	<input type="hidden" name="action" id="action" value="${action}"/>

	<div id="zhongxin" >
	<table id="table_report" class="table table-striped table-bordered table-hover" style="overflow:scroll;">
		<tr height="45px">

			<td>用户账号:</td>
			<td>
				<input  type="number" name="account" id="account" placeholder="请输入11位手机号码"  style="width: 390px" onkeyup="validateUtils.replaceNotNumEmpty(this);"/>
				<font color="red">*</font>
			</td>
			<td>用户昵称:</td>
			<td>
				<input  type="text" name="nickName" id="nickName"  style="width: 370px" onkeyup="validateUtils.replaceSpaceEmpty(this);"/>
				<font color="red">*</font>
			</td>
				 
		</tr>
		<tr height="45px">

			<td>设置密码:</td>
			<td><input  type="text" name="password" id="password" placeholder="默认密码123456"   style="width: 390px" onkeyup="validateUtils.replaceSpaceEmpty(this);"/></td>
			<td>性别:</td>
			<td>
				<select name="sex" style="width: 383px">
					<option value="0" >男</option>
					<option value="1" >女</option>
				</select>
			</td>

		</tr>

		<tr height="45px">
			<td>地区:</td>
			<td >
				<select class="chzn-select" name="provinceId" id="provinceId" data-placeholder="请选择省份" style="vertical-align:top;width: 120px;"  >
					<option value=""></option>
					<c:forEach items="${provinceList}" var="var">
						<option value="${var.provinceId }" >${var.provinceName }</option>
					</c:forEach>
				</select>
				<select class="chzn-select" name="cityId" id="cityId" data-placeholder="请选择城市" style="vertical-align:top;width: 140px;"  >
					<option value=""></option>
					<%--<c:if test="${action==2 }">
						<option value=""></option>
						<c:forEach items="${cityList}" var="vc">
							<option value="${vc.cityId}" <c:if test="${vc.cityId == am.cityId }">selected</c:if>>${vc.cityName }</option>
						</c:forEach>
					</c:if>--%>
				</select>
				<select class="chzn-select" name="areaId" id="areaId" data-placeholder="请选择区域" style="vertical-align:top; width: 140px;">
					<option value=""></option>
					<%--<c:if test="${action==2 }">
						<option value=""></option>
						<c:forEach items="${areaList}" var="var">
							<option value="${var.areaId }"
									<c:if test="${var.areaId == am.areaId }">selected</c:if>>${var.areaName }</option>
						</c:forEach>
					</c:if>--%>
				</select>
			</td>
      		<td>详细地址:</td>
      		<td>
      			<input  type="text" name="address" id="address"  style="width: 370px" onkeyup="validateUtils.replaceSpaceEmpty(this);"/>
      		</td>

		</tr>
		<tr>
			<td>头像:</td>
			<td>

				<c:if test="${action != 4}">

					<a id="imgBox" href="javascript:void(0)" style="display:none;">
		                <img src="" width="120" id="imgHref" />
		            </a>
	              <input type="file" id="fileInput" name="fileInput" />
				</c:if>


           <td colspan='2'><font color="red">注：(图片尺寸规格120px * 120px)</font></td>
            <input id="url" name="img" type="hidden" />
            </td>
		</tr>

		<tr id="operaArea">
			<td style="text-align: center;" colspan="4">
                <a class="btn btn-mini btn-primary" onclick="save();">保存</a>&nbsp;&nbsp;&nbsp;&nbsp;
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
	<script type="text/javascript" src="static/js/bootstrap-datetimepicker.js"></script><!-- 时间框 -->
	<script type="text/javascript" src="static/js/bootstrap-datetimepicker.zh-CN.js"></script><!-- 时间框 -->
	<script type="text/javascript" src="static/js/chosen.jquery.min.js"></script><!-- 下拉框 -->
	<script type="text/javascript" src="static/js/bootbox.min.js"></script><!-- 确认窗口 -->

		
	<!-- 压缩图片 -->
	<script type="text/javascript" src="static/js/base64.js"></script>

	<link rel="stylesheet" type="text/css" href="plugins/fancyBox/jquery.fancybox.css">
	<script type="text/javascript" src="plugins/fancyBox/jquery.fancybox.pack.js"></script>
	<!-- 查看图片 -->
	<script type="text/javascript">
	$(top.hangge());

	$(function() {

		/*if($("#provinceId").val()) {
			var provinceId = $("#provinceId").val();
			var citySelect = $("#cityId");
			citySelect.empty().append("<option value=''></option>");
			var cityList = '${cityList}';
			var cityId = '${am.cityId}';
			$.each(JSON.parse(cityList), function(i, list){
				var parentId = list.provinceId;
				if(parentId == provinceId) {
					var value = list.cityId;
					var option = list.cityName;
					var label = $("<option value='"+value+"'>"+option+"</option>");
					if(cityId == list.cityId) {
						label.attr("selected", "selected");
					}
					citySelect.append(label);
				}
			});
		}
		if($("#cityId").val()) {
			var cityId = $("#cityId").val();
			var areaSelect = $("#areaId");
			areaSelect.empty().append("<option value=''></option>");
			var areaList = '${areaList}';
			var shopAreaId = '${am.areaId}';
			$.each(JSON.parse(areaList), function(i, list){
				var parentId = list.cityId;
				if(parentId == cityId) {
					var value = list.areaId;
					var option = list.areaName;
					var label = $("<option value='"+value+"'>"+option+"</option>");
					if(shopAreaId == list.areaId) {
						label.attr("selected", "selected");
					}
					areaSelect.append(label);
				}
			});
		}*/

		//单选框
		$(".chzn-select").chosen();
		$(".chzn-select-deselect").chosen({allow_single_deselect:true});

		//联动select事件
		$("#provinceId").change(function(){
		    var provinceId = $("#provinceId").val();
		    var citySelect = $("#cityId");
		    citySelect.empty().append("<option value=''></option>");
		    var areaSelect = $("#areaId");
		    areaSelect.empty().append("<option value=''></option>");
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
		});
		
		//联动select事件
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
	
	new img2base64("fileInput", "url", "imgHref", "imgBox");

	$("#imgBox").fancybox({
		helpers : {
			title : {
				type : 'inside'
			}
		}
	});
  </script>
</body>
</html>