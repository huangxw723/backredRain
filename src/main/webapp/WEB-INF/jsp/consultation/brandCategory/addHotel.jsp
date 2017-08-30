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

	<script type="text/javascript">
		$(top.hangge());

		$(function() {
			$(".chzn-select").chosen();
			$(".chzn-select-deselect").chosen({allow_single_deselect:true});
		});

		//保存
		function save(){
			if($("#name").val()==""||$.trim($("#name").val())=="" && otype==1){
				$("#name").tips({
					side:3,
					msg:'酒店品牌名称',
					bg:'#AE81FF',
					time:2
				});
				$("#name").focus();
				return false;
			}

			var checkInt = /^[0-9]*[1-9][0-9]*$/;
			if ($("#sortOrder").val() == "") {
				$("#sortOrder").tips({
					side : 3,
					msg : '输入排序',
					bg : '#AE81FF',
					time : 2
				});
				$("#sortOrder").focus();
				return false;
			}
			if (!checkInt.test($("#sortOrder").val())) {
				$("#sortOrder").tips({
					side : 3,
					msg : '排序输入有误',
					bg : '#AE81FF',
					time : 2
				});
				$("#sortOrder").focus();
				return false;
			}

			if($("#status").val()==""||$.trim($("#status").val())=="" && otype==1){
				$("#status").tips({
					side:3,
					msg:'是否显示',
					bg:'#AE81FF',
					time:2
				});
				$("#status").focus();
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

<form action="consultation/brandCategory/addBrandFoodCategory.do" name="usersForm" id="usersForm" method="post">
	<input type="hidden" id="close" value="0"/>
	<input type="hidden" name="type" value="${type}"/>
	<div id="zhongxin" >
		<table id="table_report" class="table table-striped table-bordered table-hover" style="overflow:scroll;">
			<tr height="45px">
				<td>酒店品牌分类名称:</td>
				<td>
					<input type="text" style="width:205px;" name="name" id="name"  placeholder="酒店品牌分类名称" title="酒店品牌分类名称" />
				</td>
			</tr>

			<tr height="45px">
				<td>排序:</td>
				<td>
					<input type="number" style="width:205px;" name="sortOrder" id="sortOrder"  placeholder="这里输入排序" title="排序" />
				</td>
			</tr>

			<tr height="45px">
				<td>是否显示：</td>
				<td>
				<select name="status" id="status">
					<option value="0">显示</option>
					<option value="1">不显示</option>
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
<script type="text/javascript" src="static/js/chosen.jquery.min.js"></script><!-- 下拉框 -->
<script type="text/javascript" src="static/js/bootbox.min.js"></script><!-- 确认窗口 -->

<link rel="stylesheet" type="text/css" href="plugins/fancyBox/jquery.fancybox.css">
<script type="text/javascript" src="plugins/fancyBox/jquery.fancybox.pack.js"></script>
</body>
</html>