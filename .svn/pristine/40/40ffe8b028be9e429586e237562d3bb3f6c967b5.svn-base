<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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
<link rel="stylesheet"
	href="static/css/bootstrap-datetimepicker.min.css" />
<!-- 时间框 -->
<link rel="stylesheet" href="static/css/datepicker.css" />
<!-- 日期框 -->
<!--引入弹窗组件start-->
<script type="text/javascript" src="plugins/attention/zDialog/zDrag.js"></script>
<script type="text/javascript"
	src="plugins/attention/zDialog/zDialog.js"></script>
<!--引入弹窗组件end-->
<!--提示框-->
<script type="text/javascript" src="static/js/jquery.tips.js"></script>
<script type="text/javascript" src="static/js/common/commonutils.js"></script>


<script type="text/javascript">

</script>
</head>
<body>
	<form action="account/updateShopMemberInfo.do"
		name="shopMemberInfoForm" id="shopMemberInfoForm" method="post">
		<input type="hidden" name="action" id="action" value="${action}" /> <input
			type="hidden" name="view" id="view" value="${pd.view}" /> <input
			type="hidden" name="userInfoId" id="userInfoId"
			value="${userInfo.userInfoId}" />
		<div id="zhongxin">
			<table id="table_report"
				class="table table-striped table-bordered table-hover"
				style="overflow: scroll;">
				<tr height="45px">
					<td>帐号:</td>
					<td>${userInfo.account}</td>
					<td>用户昵称:</td>
					<td><input placeholder="2~10个字" type="text" name="nickName" <c:if test="${pd.view==4}">disabled="disabled"</c:if>
						id="nickName" value='${userInfo.nickName}' style="width: 450px" /></td>

				</tr>
				<tr>
					<td>头像:</td>
					<td><c:if
							test="${userInfo.avata == '' || userInfo.avata == null}">
							<c:if test="${action != 4}">
								<a id="imgBox" href="javascript:void(0)"
									style="display: none; size: 50"> <img src="" width="50"
									id="imgHref" />
								</a>
								<input type="file" id="fileInput" name="fileInput" />
							</c:if>
						</c:if>
						<c:if test="${userInfo != null && userInfo.avata != '' && userInfo.avata != null }">
							<a id="imgBox" href="<%=httpUrl%>${userInfo.avata}"> <img
								src="<%=httpUrl%>${userInfo.avata}" width="50" id="imgHref" />
							</a>

							<input type="button" class="btn btn-mini btn-danger" value="更改"
								onclick="changeImg()" id="chImg" <c:if test="${pd.view==4}">disabled="disabled"</c:if> />

							<input type="file" id="fileInput" name="fileInput"
								style="display: none;"
								<c:if test="${action == 2}">value="2"</c:if> />
						</c:if>
					<td colspan='2'><font color="red">注：(图片尺寸规格120px *
							120px)</font></td>
					<input id="url" name="img4" type="hidden" />
					</td>
				</tr>
				<tr height="45px">
					<td>姓别:</td>
					<td>
						<div class="controls">
							<input type="radio" id="sex" name="sex" value="0" <c:if test="${pd.view==4}">disabled="disabled"</c:if>
								<c:if test="${userInfo.sex=='0'}">checked="checked" </c:if> /><span
								class="lbl"> 男</span> <input type="radio" id="sex" name="sex" <c:if test="${pd.view==4}">disabled="disabled"</c:if>
								value="1"
								<c:if test="${userInfo.sex=='1'}">checked="checked" </c:if> /><span
								class="lbl"> 女</span>
						</div>

					</td>

				</tr>

				<tr height="45px">
					<td>出生日期:</td>
					<td>
						<div class="row-fluid input-append date">
							<input name="birthday" onchange="ageStr(this);" type="text" <c:if test="${pd.view==4}">disabled="disabled"</c:if>
								data-date-format="yyyy-mm-dd" id="birthday" readonly="readonly"
								placeholder="出生日期" class="span10 date-picker"
								value="${userInfo.birthday}"> <span class="add-on"><i
								class="icon-calendar"></i></span>
						</div>
					</td>
					<td>年龄 :</td>
					<td id="age"></td>
				</tr>
				<tr height="45px">
					<td>用户来源:</td>
					<td><c:if test="${userInfo.source==3}">
							<input placeholder="2~10个字" type="text" name="source"
								idsource="age" value='${userInfo.source}' style="width: 450px" />
						</c:if> <c:if test="${userInfo.source==1}">(${userInfo.inviteRefId})分享 </c:if>
						<c:if test="${userInfo.source==2}"> 商家分享（我爱台妹）</c:if></td>
					<td>我的邀请码:</td>
					<td>${userInfo.myInvite}</td>

				</tr>


				<tr>
					<th>地址:</th>
					<td><select class="chzn-select" name="provinceId"
						id="provinceId" data-placeholder="请选择省份"
						style="vertical-align: top;"
						<c:if test="${action==4}">disabled="disabled"</c:if><c:if test="${pd.view==4}">disabled="disabled"</c:if>>
							<option value=""></option>
							<c:forEach items="${provinceList}" var="var">
								<option value="${var.provinceId }"
									<c:if test="${var.provinceId == userInfo.provinceId }">selected</c:if>>${var.provinceName }</option>
							</c:forEach>
					</select> <select class="chzn-select" name="cityId" id="cityId"
						data-placeholder="请选择城市" style="vertical-align: top;"
						<c:if test="${action==4}">disabled="disabled"</c:if> <c:if test="${pd.view==4}">disabled="disabled"</c:if>>

							<option value=""></option>
							<c:forEach items="${cityList}" var="vc">
								<option value="${vc.cityId}"
									<c:if test="${vc.cityId == userInfo.cityId }">selected</c:if>>${vc.cityName }</option>
							</c:forEach>

					</select> <select class="chzn-select" name="areaId" id="areaId"
						data-placeholder="请选择区域"
						style="vertical-align: top; width: 204px;"
						<c:if test="${action==4}">disabled="disabled"</c:if> <c:if test="${pd.view==4}">disabled="disabled"</c:if>>


							<option value=""></option>
							<c:forEach items="${areaList}" var="var">
								<option value="${var.areaId }"
									<c:if test="${var.areaId == userInfo.areaId }">selected</c:if>>${var.areaName }</option>
							</c:forEach>

					</select></td>
				</tr>

				</tr>
				<tr height="45px">
					<td>详细地址:</td>
					<td colspan="8"><input placeholder="详细地址" type="text" <c:if test="${pd.view==4}">disabled="disabled"</c:if>
						name="address" id="address" value='${userInfo.address}'
						style="width: 740px" /></td>
				</tr>
				<c:if test="${pd.view != 4}">
					<tr id="operaArea">
						<div style="margin-left: 500px;">
							<td style="text-align: center;" colspan="8"><a
								class="btn btn-mini btn-primary" onclick="save();"
								style="width: 100px; height: 30px;">保存</a>&nbsp;&nbsp;&nbsp;&nbsp;
								<a class="btn btn-mini btn-danger" onclick="DialogClose();"
								style="width: 100px; height: 30px;">取消</a></td>
						</div>
					</tr>
				</c:if>
			</table>
		</div>

		<div id="zhongxin2" class="center" style="display: none">
			<br /> <br /> <br /> <br /> <br /> <img
				src="static/images/jiazai.gif" /> <br />
			<h4 class="lighter block green">提交中...</h4>
		</div>
	</form>
	<!-- 引入 -->
	<script type="text/javascript">window.jQuery || document.write("<script src='static/js/jquery-1.9.1.min.js'>\x3C/script>");</script>
	<script src="static/js/bootstrap.min.js"></script>
	<script src="static/js/ace-elements.min.js"></script>
	<script src="static/js/ace.min.js"></script>
	<script type="text/javascript"
		src="static/js/bootstrap-datepicker.min.js"></script>
	<!-- 日期框 -->
	<script type="text/javascript"
		src="static/js/bootstrap-datetimepicker.zh-CN.js"></script>
	<!-- 日期框 -->
	<script type="text/javascript" src="static/js/chosen.jquery.min.js"></script>
	<!-- 下拉框 -->
	<script type="text/javascript" src="static/js/bootbox.min.js"></script>
	<!-- 确认窗口 -->

	<script type="text/javascript"
		src="static/js/bootstrap-datetimepicker.js"></script>
	<!-- 日期框 -->
	<script type="text/javascript"
		src="static/js/bootstrap-datetimepicker.zh-CN.js"></script>
	<!-- 日期框 -->
	<script type="text/javascript" src="static/js/chosen.jquery.min.js"></script>
	<!-- 下拉框 -->
	<script type="text/javascript" src="static/js/bootbox.min.js"></script>
	<!-- 确认窗口 -->

	<script type="text/javascript" src="static/js/base64.js"></script>
	<!-- 压缩图片 -->
	<link rel="stylesheet" type="text/css"
		href="plugins/fancyBox/jquery.fancybox.css">
	<script type="text/javascript"
		src="plugins/fancyBox/jquery.fancybox.pack.js"></script>
	<script type="text/javascript" src="static/js/common/commonutils.js"></script>

	<script type="text/javascript">
  $(top.hangge());
  function DialogClose(){
	  location.reload(document.referrer);
  }

  //保存
  function save(){
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

  		var formElement = $('#shopMemberInfoForm');
  		var operaArea = formElement.find('#operaArea');
  		operaArea.hide();
  		
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
  	        	operaArea.show();
  	        	
  	        },
  	        error:function(data){
  	        	alert('系统繁忙');
  	        	operaArea.show();
  	        }
  	    });
  		
  }
   
  
  
  //初始化参数
  $(function(){		
  	
  	if($("#provinceId").val()) {
  		var provinceId = $("#provinceId").val();
  	    var citySelect = $("#cityId");
  	    citySelect.empty().append("<option value=''></option>");
  	    var cityList = '${cityList}';
  	    var cityId = '${userInfo.cityId}';
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
  	    var shopAreaId = '${userInfo.areaId}';
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
  	} 
  
  	//单选框
  	$(".chzn-select").chosen(); 
  	$(".chzn-select-deselect").chosen({allow_single_deselect:true});
  	
  	//联动省份select事件
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
  	    initDataOpera(1);
  	});
  	//联动城市select事件
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
  	//联动县、区select事件	
  	$("#areaId").change(function(){
  	    var areaId = $("#areaId").val();
  	    var businessDistrictSelect = $("#businessDistrictId");
  	    businessDistrictSelect.empty().append("<option value=''></option>");
  	    var businessDistrictList = '${businessDistrictList}';
  		var countNum=0;
  	    $.each(JSON.parse(businessDistrictList), function(i, list){
  	    	var parentId = list.areaId;
  			if(parentId == areaId) {
  				var value = list.businessDistrictId;
  				var option = list.name;
  				var label = $("<option value='"+value+"'>"+option+"</option>");
  				businessDistrictSelect.append(label);
  				countNum++;
  					}
  				});
  	    businessDistrictSelect.trigger("liszt:updated");
  	
  		$("#vbusinessDistrictId").val(countNum);
  	});
  function initDataOpera (otype){ 
  switch (otype)		
  	{
  	case 1:
  		var areaSelect = $("#areaId");
  		areaSelect.empty().append("<option value=''></option>");
  	    areaSelect.trigger("liszt:updated");
	    
  	  break;
  	case 2:	
  	  break;
  	case 3:
  	  break;
  	}
   }
  	
  });
    $(top.hangge());
    
    new img2base64("fileInput", "url", "imgHref", "imgBox");
	//更改图片
    function changeImg(){
        $("#fileInput").trigger("click");
    }

	  $("#imgBox").fancybox({
		  helpers : {
			  title : {
				  type : 'inside'
			  }
		  }
	  });

	
   //头像图
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
    $(function(){
    
    	$('#birthday').datetimepicker({
			minuteStep :1,
	        language:  'zh-CN',
			autoclose: 1,
			format: "yyyy-mm-dd",
			startView: 2, //这里就设置了默认视图为年视图
            minView: 'month', //设置最小视图为年视图
			startDate: new Date("1918-01-01"),
	    }).on('changeDate',function(e){  
		    var startTime = e.date;  
		});
    	ageStr(null);
    })
     //年龄自动计算
    function ageStr(thise){
    	var str=thise;
    	if(str==null){
    	   str = $("#birthday").val();
    	}else{
    	   str=thise.value;
        }
        var r = str.match(/^(\d{1,4})(-|\/)(\d{1,2})\2(\d{1,2})$/);         
        var d= new   Date(r[1],   r[3]-1,   r[4]);     
        if   (d.getFullYear()==r[1]&&(d.getMonth()+1)==r[3]&&d.getDate()==r[4])   
        var   Y   =   new   Date().getFullYear();   
        $("#age").html(Y-r[1]); 
    }
  </script>
</body>
</html>