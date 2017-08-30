<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="com.aoshi.util.PropertyUtils"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
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
<script src="static/js/base64Compress.js"></script>
<script src="static/js/layer/layer.js"></script>
<style type="text/css">
.ace-file-input label {
	display: block;
	position: absolute;
	top: 0;
	left: 0;
	right: 1110px;
	height: 28px;
	background-color: #FFF;
	border: 1px solid #e3e3e3;
	cursor: pointer;
	box-shadow: 0 0 0 4px rgba(0, 0, 0, 0.06); .
	a_style {font-size: 10pt;
	color: #0000cc;
	font-family: 宋体;
	text-align: left;
	text-decoration: underline;
	TEXT-DECORATION: none;
}
.adUrl_class{
}
.oldImgUrl{
}
.oldImgId{

}
.input_class{}
.input_old_class{}
.oldNewImgUrl{}
.oldNewImgId{}
.adUrlText_class{}
.addDiv{}
</style>

<script type="text/javascript">

function addFlieImgs($this){
	$($this).after(
			'<div class="addDiv">'
			+'<input style="width: 75px;" type="file" class="input_class" onchange="selectImg(this)" name="files">' 	
			+'<span class="help-inline"><a id="imgClean" class="a_style" style="display: none" href="javscript:void(0);" onclick="cleanAddImg(this)">清除图片<br></a></span>'
			+'<br> <img class="imgsss" style="max-height:100px;max-width:100px;margin-left: 5px;margin-top: 5px" id="imgAdd" src="">'
		    +'<br><span style="display: none" class="adUrlText_class" id="adUrlsText">广告Url</span><input class="adUrl_class" style="display: none;width: 300px;"  type="text" name="adUrls" id="adUrls" value="" /> '
			+'</div>'		
	);
	
	var imgNumber = $(".input_old_class").length +$(".input_class").length;
	//alert(imgNumber);
	 if(parseInt(imgNumber) >6){
/* 		 if("0"==type){
				$($this).remove();	
			}else{
			$($this).val("");		
			}
		cleanAddImg($this); */
		$(".addDiv").eq(0).remove();	
		alert("一共只能存在6张广告图片");
	return ; 
	 }
	
	
}
var imgNewOldAdUrls = new Array();
var imgNewOldImgIds = new Array();
function selectOldImg($this){
	checkImgNuber($this,"1");
	var files = $this.files;
	//alert(files)
	if (files) {
		  for(var i=0;i<files.length;i++){
			  var FR= new FileReader();
			    FR.onload = function(e) {
			    var result = base64Shorter(e.target.result);
				var div = $($this).parents("div")[0];
				//alert(div);
				   $(div).find("input[id='adUrl']").removeClass('oldImgUrl');
				   $(div).find("input[id='adId']").removeClass('oldImgId');
			   $(div).find("input[id='adUrl']").addClass('oldNewImgUrl');
			   $(div).find("input[id='adId']").addClass('oldNewImgId');
			   $(div).find("input[name='oldFiles']").attr('name','oldNewFiles');
			   $(div).find("img").attr("src",result);
			 var oldImgId = $(div).find("input[id='adId']").val();
			if(imgNewOldAdUrls.length>0){
				 for (var a = 0; a < imgNewOldAdUrls.length; a++) {
						if(imgNewOldImgIds[a]==oldImgId){
							imgNewOldAdUrls[a] = $(div).find("input[id='adUrl']").val()
						}else{
							  imgNewOldAdUrls.push($(div).find("input[id='adUrl']").val());
							  imgNewOldImgIds.push( $(div).find("input[id='adId']").val());
						}
					}
			}else{
				  imgNewOldAdUrls.push($(div).find("input[id='adUrl']").val());
				  imgNewOldImgIds.push( $(div).find("input[id='adId']").val());
			}
			  //alert(imgNewOldImgIds)
			 // alert(imgNewOldAdUrls)
			$("#imgNewOldAdUrls").val(imgNewOldAdUrls.join(","));
			$("#imgNewOldImgIds").val(imgNewOldImgIds.join(","));
			   };
			  FR.readAsDataURL( files[i] );
		  }
	}  
}



function selectImg($this){
	  checkImgNuber($this,"0");
	  var files = $this.files;  
	if (files) {
		  for(var i=0;i<files.length;i++){
			  var FR= new FileReader();
			    FR.onload = function(e) {
			    var result = base64Shorter(e.target.result);
				var div = $($this).parents("div")[0];
				$(div).find("img").attr("src",result);
			   $(div).find("input[id='adUrls']").show();
			   $(div).find("span[id='adUrlsText']").show();
			   $(div).find("a[id='imgClean']").show();
			    };
			  FR.readAsDataURL( files[i] );
		  }
	}  
}

	function cleanAddImg(obj){
		var div = $(obj).parents("div")[0];
		$(div).remove();

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
	//alert($(".adUrl_class")[len-1]);
	$(".adUrl_class")[len-1].remove();
}
	
function cleanImgs(obj){
	var div = $(obj).parents("div")[0];
	$(div).remove()
//	$(this).parents("div").remove()
	//alert();
	//obj.parent().remove();
}
	
function checkImgNuber($this,type){
 	var files = $this.files;
 	var fileSize =$(files)[0].size/1024;
	//alert(fileSize);
	if(parseInt(fileSize)>10240){
		if("0"==type){
			//$($this).remove();	
			$($this).val("");
		var div = $($this).parents("div")[0];
		$(div).find("img").attr("src","");
		}else{
			$($this).val("");		
		}
		  alert("图片大小不能大于10M");
			return;
	}
	 var thisvalue = $($this).val();
	  var pattern = /(\.*.jpg$)|(\.*.png$)|(\.*.jpeg$)|(\.*.gif$)|(\.*.bmp$)/i;     
	  if(!pattern.test(thisvalue)){
		  alert("系统仅支持jpg/jpeg/png/gif/bmp格式的照片");
		  if("0"==type){
				//$($this).remove();	
				$($this).val("");
		var div = $($this).parents("div")[0];
		$(div).find("img").attr("src","");
		  }else{
				$($this).val("");		
			}
		 return;
	  }
}
/* 	var files = $this.files;
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
	var imgNumber = $(".imgss").length +$(".input_class").length;
	//alert(imgNumber);
	 if(parseInt(imgNumber) >6){
		//  $($this).remove();
		cleanAddImg($this);
		  alert("一共只能存在6张广告图片");
		  return ; */
//}
	
//删除
function deletImg(id){
	bootbox.confirm("确认删除？", function(result) {
		if(result){
			$.get("activityAd/delete",{adId:id},function(data){
				if(data.status != 0){
					alert(data.msg);
					setTimeout(window.location.href="point/setpoint",100);
					return;
				}else{
					window.location.href="point/setpoint";
					return;
				}
				//alert("操作成功")
				setTimeout("self.location=self.location",100);
			},'json');
		}else{
			self.location=self.location;
			return;
		}
		
});
}
	
	//保存
	function save(){
			
		if($("#invitePointValue").val()=="" || $.trim($("#invitePointValue").val())==""){
			$("#invitePointValue").tips({
				side:3,
	            msg:'不能为空',
	            bg:'#AE81FF',
	            time:2
	        });
			$("#invitePointValue").focus();
			return false;
		}
		if($("#exchangePointValue").val()=="" || $.trim($("#exchangePointValue").val())==""){
			$("#exchangePointValue").tips({
				side:3,
	            msg:'不能为空',
	            bg:'#AE81FF',
	            time:2
	        });
			$("#exchangePointValue").focus();
			return false;
		}
		if($("#moneyPointValue").val()=="" || $.trim($("#moneyPointValue").val())==""){
			$("#moneyPointValue").tips({
				side:3,
	            msg:'不能为空',
	            bg:'#AE81FF',
	            time:2
	        });
			$("#moneyPointValue").focus();
			return false;
		}
		if($("#reginPointValue").val()=="" || $.trim($("#reginPointValue").val())==""){
			$("#reginPointValue").tips({
				side:3,
	            msg:'不能为空',
	            bg:'#AE81FF',
	            time:2
	        });
			$("#reginPointValue").focus();
			return false;
		}
		if($("#loginPointValue").val()=="" || $.trim($("#loginPointValue").val())==""){
			$("#loginPointValue").tips({
				side:3,
	            msg:'不能为空',
	            bg:'#AE81FF',
	            time:2
	        });
			$("#loginPointValue").focus();
			return false;
		}
		if($("#sharePointValue").val()=="" || $.trim($("#sharePointValue").val())==""){
			$("#sharePointValue").tips({
				side:3,
	            msg:'不能为空',
	            bg:'#AE81FF',
	            time:2
	        });
			$("#sharePointValue").focus();
			return false;
		}
		
		
			layer.load(2);	
	/* 		var imgOldIds = new Array();
			var imgOldAdUrls = new Array();
			var num = $(".oldImgUrl").size();
			for(var i = 0;i<num;i++){
			//alert($(".oldImgId")[i]);
				
				imgOldIds[i] = $(".oldImgId")[i].value;
				imgOldAdUrls[i] = $(".oldImgUrl")[i].value;
			}
			
			$("#imgOldIds").val(imgOldIds);
			$("#imgOldAdUrls").val(imgOldAdUrls);
			
			var numNew = $(".adUrl_class").size();
			var imgNewAdUrls = new Array();
		
			for(var i = 0;i<numNew;i++){
				imgNewAdUrls[i] = $(".adUrl_class")[i].value;
			}
			//alert(imgNewAdUrls)
			$("#imgNewAdurls").val(imgNewAdUrls); */
			
			var pointId = $("#invitePointId").val()+","+$("#exchangePointId").val()+","+$("#moneyPointId").val()+","+$("#reginPointId").val()+","+$("#loginPointId").val()+","+$("#sharePointId").val();	
			var pointValue = $("#invitePointValue").val()+","+$("#exchangePointValue").val()+","+$("#moneyPointValue").val()+","+$("#reginPointValue").val()+","+$("#loginPointValue").val()+","+$("#sharePointValue").val();		
			$("#pointId").val(pointId);
			$("#pointValue").val(pointValue);
			// 提交表单
			//form.submit($('#pointForm'));
		   
			$("#pointForm").submit()
			alert("操作完成");
		 		//window.location.href="point/setpoint";
 		
	}
	function setSpan(flag) {
		if("1"==flag){
			var invitePointValues ="用户分享链接产生新用户，分享者所得 "+$("#invitePointValue").val()+"积分";
			$("#invitePointValues").text(invitePointValues);
		}
		if("2"==flag){
			var exchangePointValues = "消费1.00元获取"+$("#exchangePointValue").val()+"积分";
			$("#exchangePointValues").text(exchangePointValues);
		}if("3"==flag){
			var moneyPointValues = "每"+$("#moneyPointValue").val()+"积分兑换1.00 元";
			$("#moneyPointValues").text(moneyPointValues);
		}if("4"==flag){
			var reginPointValues = "注册送"+$("#reginPointValue").val()+"积分";
			$("#reginPointValues").text(reginPointValues);
		}if("5"==flag){
			var loginPointValues = "登录送"+$("#loginPointValue").val()+"积分";
			$("#loginPointValues").text(loginPointValues);
		}if("6"==flag){
			var sharePointValues ="分享注册送"+$("#sharePointValue").val()+"积分";
			$("#sharePointValues").text(sharePointValues);
		}
	}
</script>
</head>
<body>
	<form action="point/updatepoint.do" name="pointForm" id="pointForm"
		method="post" enctype="multipart/form-data">
		<div id="">
			<table id="table_report"
				class="table table-striped table-bordered table-hover"
				style="overflow: scroll;">

				<tr height="45px">
					<td>邀请积分</td>
					<td><input onchange="setSpan('1');" type="number" min="0" name="invitePointValue"
						id="invitePointValue" style="width: 370px" onkeyup="validateUtils.replaceNotNumEmpty(this);"
						value="${asdictParm.invitePointValue}" /> <input type="hidden"
						name="invitePointId" id="invitePointId" style="width: 370px"
						value="${asdictParm.invitePointId}" /></td>
					<td><span id="invitePointValues">用户分享链接产生新用户，分享者所得${asdictParm.invitePointValue}积分</span></td>	
				</tr> 

				<tr height="45px">
					<td>积分兑换比</td>
					<td><input  onchange="setSpan('2');" type="number" min="0" name="exchangePointValue"
						id="exchangePointValue" style="width: 370px" onkeyup="validateUtils.replaceNotNumEmpty(this);"
						value="${asdictParm.exchangePointValue}" /> <input type="hidden"
						name="exchangePointId" id="exchangePointId" style="width: 370px"
						value="${asdictParm.exchangePointId}" /></td>
					<td><span id="exchangePointValues">消费1.00元获取${asdictParm.exchangePointValue}积分</span></td>	
				</tr>
				<tr height="45px">
					<td>兑换金额比</td>
					<td><input  onchange="setSpan('3');" type="number" min="0" name="moneyPointValue"
						id="moneyPointValue" style="width: 370px" onkeyup="validateUtils.replaceNotNumEmpty(this);"
						value="${asdictParm.moneyPointValue}" /> <input type="hidden"
						name="moneyPointId" id="moneyPointId" style="width: 370px"
						value="${asdictParm.moneyPointId}"/></td>
				<td><span id="moneyPointValues">每${asdictParm.moneyPointValue}积分兑换1.00 元</span></td>	
				
				</tr>

				<tr height="45px">
					<td>手机APP注册</td>
					<td><input  onchange="setSpan('4');" type="number" min="0" name="reginPointValue"
						id="reginPointValue" style="width: 370px" onkeyup="validateUtils.replaceNotNumEmpty(this);"
						value="${asdictParm.reginPointValue}" /> <input type="hidden"
						name="reginPointId" id="reginPointId" style="width: 370px"
						value="${asdictParm.reginPointId}" /></td>
					<td><span id="reginPointValues">注册送${asdictParm.reginPointValue}积分</span> </td>	
						
				</tr>
				<tr height="45px">
					<td>手机APP首登</td>
					<td><input  onchange="setSpan('5');" type="number" min="0" name="loginPointValue"
						id="loginPointValue" style="width: 370px" onkeyup="validateUtils.replaceNotNumEmpty(this);"
						value="${asdictParm.loginPointValue}" /> <input type="hidden"
						name="loginPointId" id="loginPointId" style="width: 370px"
						value="${asdictParm.loginPointId}" /></td>
					<td><span id="loginPointValues">首登送${asdictParm.loginPointValue}积分</span></td>
				</tr>

				<tr height="45px">
					<td>分享注册积分</td>
					<td><input  onchange="setSpan('6');" type="number" min="0" name="sharePointValue"
						id="sharePointValue" style="width: 370px" onkeyup="validateUtils.replaceNotNumEmpty(this);"
						value="${asdictParm.sharePointValue}" /> <input type="hidden"
						name="sharePointId" id="sharePointId" style="width: 370px" value="${asdictParm.sharePointId}">
			</td>
			<td><span id="sharePointValues">分享注册送${asdictParm.sharePointValue}积分</span></td>
			</tr>
				<%-- <tr>
					<td>积分商城广告图:<br>
					注：图片大小不能超过10M
					<br> 图片格式支持 :<br> gif/png/jpg/jpeg</td>
					<td colspan="2"><c:forEach items="${listasActiv}" var="var" varStatus="vs">
							<div id="imgsDIv">
								<img class="imgss"
									style="max-height: 100px; max-width: 100px; margin-left: 5px; margin-top: 5px"
									id="img" src="<%=httpUrl%>${var.adImg}" /> <a id="imgCleans"
									class="a_style" href="javscript:void(0);"
									onclick="deletImg(${var.adId});">删除图片</a>
									<br>
								<input style="width: 75px;" type="file" class="input_old_class" onchange="selectOldImg(this)" name="oldFiles">	
								<br>
									<span>广告Url</span>
									<input style="width: 300px;"
									name="adUrl" id="adUrl"  class="oldImgUrl" value="${var.adUrl}" /> 
									 <input type="hidden"
									name="adImg" id="adImg"  value="${var.adImg}" /> <input
									type="hidden" class="oldImgId" name="adId" id="adId"  value="${var.adId}" />
							</div>
						</c:forEach>
						<div class="control-group">
							<a class="btn btn-mini btn-primary" onclick="addFlieImgs(this);">新增</a>
						</div>
						</td>
				</tr> --%>

				<tr id="operaArea">
					<td style="text-align: center;" colspan="3"><a
						class="btn btn-mini btn-primary" onclick="save();">保存</a> <a
						class="btn btn-mini btn-danger" href="point/setpoint">取消</a></td>
				</tr>
				<!-- 积分信息 -->
				<input type="hidden" name="pointId" id="pointId" value=" " />
				<input type="hidden" name="pointValue" id="pointValue" value=" " />
				<!--旧图片信息  -->				
				<input type="hidden" name="imgOldIds" id="imgOldIds" value=" " />
				<input type="hidden" name="imgOldAdUrls" id="imgOldAdUrls" value=" " />
				<!-- 新图片信息 -->
				<input type="hidden" name="imgNewAdurls" id="imgNewAdurls" value=" " />
				<!-- 修改图片信息 -->
			    <input type="hidden" name="imgNewOldAdUrls" id="imgNewOldAdUrls" value=" " />
				<input type="hidden" name="imgNewOldImgIds" id="imgNewOldImgIds" value=" " />
			</table>
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
	<!-- 查看图片 -->

	<script type="text/javascript">
	$(top.hangge());
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