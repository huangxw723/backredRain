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
	<!--引入弹窗组件start-->
	<script type="text/javascript" src="plugins/attention/zDialog/zDrag.js"></script>
	<script type="text/javascript" src="plugins/attention/zDialog/zDialog.js"></script>
	<!--引入弹窗组件end-->
	<!--提示框-->
	<script type="text/javascript" src="static/js/jquery.tips.js"></script>


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

		//保存
		function save(){
			if($("#brandName").val()==""||$.trim($("#brandName").val())=="" && otype==1){
				$("#brandName").tips({
					side:3,
					msg:'品牌名称',
					bg:'#AE81FF',
					time:2
				});
				$("#brandName").focus();
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

			if($("#ypBaseCategoryId").val()==""||$.trim($("#ypBaseCategoryId").val())=="" && otype==1){
				$("#ypBaseCategoryId").tips({
					side:3,
					msg:'品牌分类',
					bg:'#AE81FF',
					time:2
				});
				$("#ypBaseCategoryId").focus();
				return false;
			}

			if($("#brandDesc").val()==""||$.trim($("#brandDesc").val())=="" && otype==1){
				$("#brandDesc").tips({
					side:3,
					msg:'品牌描述',
					bg:'#AE81FF',
					time:2
				});
				$("#brandDesc").focus();
				return false;
			}

			if($("#siteUrl").val()==""||$.trim($("#siteUrl").val())=="" && otype==1){
				$("#siteUrl").tips({
					side:3,
					msg:'品牌官网地址',
					bg:'#AE81FF',
					time:2
				});
				$("#siteUrl").focus();
				return false;
			}

			if($("#isShow").val()==""||$.trim($("#isShow").val())=="" && otype==1){
				$("#isShow").tips({
					side:3,
					msg:'是否显示',
					bg:'#AE81FF',
					time:2
				});
				$("#isShow").focus();
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

<form action="consultation/brand/addBrand.do" name="usersForm" id="usersForm" method="post">
	<%--<input type="hidden" name="brandId" value="${asBrand.brandId}"/>--%>
	<%--<input type="hidden" name="action" id="action" value="${action }">--%>
	<%--<input type="hidden" name="otype" id="otype" value="${otype}">--%>
	<input type="hidden" id="close" value="0"/>
	<div id="zhongxin" >
		<table id="table_report" class="table table-striped table-bordered table-hover" style="overflow:scroll;">
			<tr height="45px">
				<td>品牌名称:</td>
				<td>
					<input type="text" style="width:370px;" name="brandName" id="brandName"  placeholder="这里输入品牌名称" title="品牌名称" />
				</td>
			</tr>
			<tr>
				<td>品牌logo:</td>
				<td>
					<c:if test="${asBrand == null || asBrand.brandLogo== '' || asBrand.brandLogo == null }">
						<a id="imgBox" href="javascript:void(0)" style="display:none;">
							<img src="" width="150" id="imgHref" />
						</a>
						<input type="file" id="fileInput" name="fileInput" />
						<span style="color: red; width: 50px;" id="msgDiv" >注： 图片格式支持 : gif/png/jpg/jpeg    尺寸规格710 * 140</span>
						<span style="color: red; width: 50px;" id="msgDivScreen" >注： 图片格式支持 : gif/png/jpg/jpeg </span>
					</c:if>
					<c:if test="${asBrand != null && asBrand.brandLogo != '' && asBrand.brandLogo != null }">
						<a id="imgBox" href="<%=httpUrl%>${asBrand.brandLogo}" title="${asBrand.brandLogo}">
							<img src="<%=httpUrl%>${asBrand.brandLogo}" alt="${asBrand.brandLogo}" width="150" id="imgHref" />
						</a>
						<c:if test="${action !=null && action != '' && action!=4}">
							<input type="button" class="btn btn-mini btn-danger" value="更改" onclick="changeImg()" id="chImg" />
							<input type="file" id="fileInput" name="fileInput" style="display:none;" />
						</c:if>
					</c:if>
					<input id="url" name="img" type="hidden" />
				</td>
			</tr>
			<tr height="45px">
				<td>品牌分类:</td>
				<td>
					<select class="chzn-select" name="ypBaseCategoryId" id="ypBaseCategoryId">
						<c:forEach items="${ypBaseCategoryList}" var="ypBaseCategory">
							<option value="${ypBaseCategory.id}">${ypBaseCategory.name}</option>
						</c:forEach>
					</select>
				</td>
			</tr>
			<tr height="45px">
				<td>品牌描述：</td>
				<td><input  type="text" name="brandDesc" id="brandDesc"  style="width: 370px" placeholder="这里输入品牌描述" title="品牌描述"/></td>
			</tr>

			<tr height="45px">
				<td>品牌官网地址：</td>
				<td><input  type="text" name="siteUrl" id="siteUrl"  style="width: 370px" placeholder="这里输入品牌官网地址" title="品牌官网地址"/></td>
			</tr>

			<tr height="45px">
				<td>是否显示：</td>
				<td>
				<select name="isShow" id="isShow">
					<option value="Y">显示</option>
					<option value="N">不显示</option>
				</select>
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
<!-- 压缩图片 -->

<link rel="stylesheet" type="text/css" href="plugins/fancyBox/jquery.fancybox.css">
<script type="text/javascript" src="plugins/fancyBox/jquery.fancybox.pack.js"></script>
<!-- 查看图片 -->
<script type="text/javascript" src="static/js/chosen.jquery.min.js"></script><!-- 下拉框 -->
<script type="text/javascript">
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

	$(function() {

		//单选框
		$(".chzn-select").chosen();
		$(".chzn-select-deselect").chosen({allow_single_deselect:true});

	});
</script>
</body>
</html>