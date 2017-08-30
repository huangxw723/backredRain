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

		//保存
		function save(){
			if($("#tagsName").val()==""||$.trim($("#tagsName").val())==""){
				$("#tagsName").tips({
					side:10,
					msg:'标签名称不为空',
					bg:'#AE81FF',
					time:2
				});
				$("#tagsName").focus();
				return false;
			}
			
			if($("#tagsName").val().length > 15 ){
				$("#tagsName").tips({
					side:15,
					msg:'字符超15',
					bg:'#AE81FF',
					time:2
				});
				$("#tagsName").focus();
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

						/* 	formElement[0].reset()
							var element = document.getElementById('zhongxin');
							element.style.display = 'none';
							top.Dialog.close(); */

						}else if(data.status == 1){
							formElement[0].reset()
							var element = document.getElementById('zhongxin');
							element.style.display = 'none';
							top.Dialog.close();
						}else if(data.status == 2){
							/* formElement[0].reset()
							var element = document.getElementById('zhongxin');
							element.style.display = 'none';
							top.Dialog.close(); */
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

<form action="popularTags/updateTags.do" name="usersForm" id="usersForm" method="post" enctype="multipart/form-data">
<input type="hidden" name="popularTagsId" id="popularTagsId" value="${tags.popularTagsId}">
	<div id="zhongxin" >
		<table id="table_report" class="table table-striped table-bordered table-hover" style="overflow:scroll;">			
			<tr height="45px">
				<td width="100px">标签名称:</td>
				<td>
					<input type="text" style="width:370px;" name="tagsName" id="tagsName" value="${tags.tagsName}" placeholder="15个字符以内" />
				</td>
			</tr>		
			<tr height="45px">
				<td width="100px">标签分类:</td>
				<td>
				<select class="chzn-select" name="tagsType" id="tagsType"  style="width:382px;" >
	            <option value="1" <c:if test="${tags.tagsType eq 1}">selected="selected"</c:if>>商品</option>
				<option value="2" <c:if test="${tags.tagsType eq 2}">selected="selected"</c:if>>店铺</option>
				<option value="3" <c:if test="${tags.tagsType eq 3}">selected="selected"</c:if>>活动</option>
				<option value="4" <c:if test="${tags.tagsType eq 4}">selected="selected"</c:if>>活力广州</option>
				<option value="5" <c:if test="${tags.tagsType eq 5}">selected="selected"</c:if>>逛街go</option>
                </select>
				</td>
			</tr>
			<tr height="45px">
				<td width="100px">是否生效:</td>
				<td>
				<select class="chzn-select"  name="status" id="status"  style="width:382px;">
	            <option value="0" <c:if test="${tags.status eq '0'}">selected="selected"</c:if>>是</option>
		    	<option value="1" <c:if test="${tags.status eq '1'}">selected="selected"</c:if>>否</option>			
                </select>
				</td>
			</tr>
			<tr height="45px">
				<td width="100px">序号:</td>
				<td>
					<input type="text" style="width:370px;" name="sortOrder" id="sortOrder"  value="${tags.sortOrder}"  />
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