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
		<link rel="stylesheet" href="static/css/bootstrap-datetimepicker.min.css" /><!-- 日期框 -->
		<!-- <link rel="stylesheet" href="static/css/datepicker.css" /> --><!-- 日期框 -->
		<!--引入弹窗组件start-->
		<script type="text/javascript" src="plugins/attention/zDialog/zDrag.js"></script>
		<script type="text/javascript" src="plugins/attention/zDialog/zDialog.js"></script>
		<!--引入弹窗组件end-->
		<!--提示框-->
		<script type="text/javascript" src="static/js/jquery.tips.js"></script>
		<script type="text/javascript" src="static/js/common/commonutils.js"></script>
		<!--日期格式化-->
		<script type="text/javascript" src="static/js/dateFormat.js"></script>
  		
<script type="text/javascript">
	$(top.hangge());



</script>
	</head>
<body>

	<form action="prizeconfig/opera.do" name="usersForm" id="usersForm" method="post">
	<input type="hidden" name="action" id="action" value="${action}"/>
	<div id="zhongxin" >
	<table id="table_report" class="table table-striped table-bordered table-hover" style="overflow:scroll;">
		<tr height="45px">
			<td>领养人:</td>
			<td><input <c:if test="${action == 4 }">disabled="disabled"</c:if> type="text"  value="${pd.contactName}" style="width: 370px"  /></td>
			<td>联系电话:</td>
			<td><input <c:if test="${action == 4 }">disabled="disabled"</c:if>type="text" value="${pd.contactPhone}" style="width: 370px"  /></td>
		</tr>
		<tr height="45px">
			<td>性别:</td>
			<td>
				<c:if test="${pd.contactSex ==1}">
					<input <c:if test="${action == 4 }">disabled="disabled"</c:if> type="text"  value="男" style="width: 370px"  />
				</c:if>
				<c:if test="${pd.contactSex ==2}">
					<input <c:if test="${action == 4 }">disabled="disabled"</c:if> type="text"  value="女" style="width: 370px"  />
				</c:if>
			</td>
			<td>年龄:</td>
			<td><input <c:if test="${action == 4 }">disabled="disabled"</c:if>type="text" value="${pd.contactAge}" style="width: 370px"  />岁</td>
		</tr>
		<tr height="45px">
			<td>使用性质:</td>
			<td>
				<c:if test="${pd.useType ==1}">
					<input <c:if test="${action == 4 }">disabled="disabled"</c:if> type="text"  value="个人" style="width: 370px"  />
				</c:if>
				<c:if test="${pd.useType ==2}">
					<input <c:if test="${action == 4 }">disabled="disabled"</c:if> type="text"  value="商户" style="width: 370px"  />
				</c:if>
				<c:if test="${pd.useType ==3}">
					<input <c:if test="${action == 4 }">disabled="disabled"</c:if> type="text"  value="代理商" style="width: 370px"  />
				</c:if>
			</td>
			<td>领养期限:</td>
			<td>
				<c:if test="${pd.adoptionPeriod ==1}">
					<input <c:if test="${action == 4 }">disabled="disabled"</c:if> type="text"  value="一天" style="width: 370px"  />
				</c:if>
				<c:if test="${pd.adoptionPeriod ==2}">
					<input <c:if test="${action == 4 }">disabled="disabled"</c:if> type="text"  value="一周" style="width: 370px"  />
				</c:if>
				<c:if test="${pd.adoptionPeriod ==3}">
					<input <c:if test="${action == 4 }">disabled="disabled"</c:if> type="text"  value="一个月" style="width: 370px"  />
				</c:if>
				<c:if test="${pd.adoptionPeriod ==4}">
					<input <c:if test="${action == 4 }">disabled="disabled"</c:if> type="text"  value="三个月" style="width: 370px"  />
				</c:if>
			</td>
		</tr>
		<tr height="45px">
			<td>公司名称:</td>
			<td><input <c:if test="${action == 4 }">disabled="disabled"</c:if> type="text"value="${pd.companyName}" style="width: 370px"  /></td>
			<td>常住地址:</td>
			<td><input <c:if test="${action == 4 }">disabled="disabled"</c:if>type="text"  value="${pd.companyAddress}" title="${pd.companyAddress}" style="width: 370px"  /></td>
		</tr>
		<tr height="45px">
			<td>微信昵称:</td>
			<td><input <c:if test="${action == 4 }">disabled="disabled"</c:if> type="text"value="${pd.wecharNickname}"  style="width: 370px" /></td>
			<td>来源:</td>
			<td><input <c:if test="${action == 4 }">disabled="disabled"</c:if> type="text"  value='<c:if test="${pd.source ==1}">扫码</c:if>' style="width: 370px"  /></td>
		</tr>
		<tr height="45px">
			<td>提交时间:</td>
			<td><input <c:if test="${action == 4 }">disabled="disabled"</c:if>type="text" value="${pd.createTime}" style="width: 370px"  /></td>
			<td>领养咨询:</td>
			<td><textarea <c:if test="${action == 4 }">disabled="disabled"</c:if>style="width: 370px;resize:none;height:200px;" onkeyup="validateUtils.replaceSpaceEmpty(this);">${pd.requirement}</textarea></td>
		</tr>

		<c:if test="${action != 4}">
		<tr id="operaArea">
			<td style="text-align: center;" colspan="4">
                <a class="btn btn-mini btn-primary" onclick="save();">保存</a>&nbsp;&nbsp;&nbsp;&nbsp;
				<a class="btn btn-mini btn-danger" onclick="top.Dialog.close();">取消</a>
			</td>
		</tr>
		</c:if>
		<c:if test="${action == 4}">
		<tr id="operaArea">
			<td style="text-align: center;" colspan="4">
				<a class="btn btn-mini btn-danger" onclick="top.Dialog.close();">返回</a>
			</td>
		</tr>
		</c:if>

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
	<!-- <script type="text/javascript" src="static/js/bootstrap-datepicker.min.js"></script> --><!-- 日期框 -->
	<script type="text/javascript" src="static/js/bootstrap-datetimepicker.js"></script><!-- 日期框 -->
	<script type="text/javascript" src="static/js/bootstrap-datetimepicker.zh-CN.js"></script><!-- 日期框 -->
	<script type="text/javascript" src="static/js/chosen.jquery.min.js"></script><!-- 下拉框 -->
	<script type="text/javascript" src="static/js/bootbox.min.js"></script><!-- 确认窗口 -->
		
	<script type="text/javascript" src="static/js/base64.js"></script>
	<!-- 压缩图片 -->
	<link rel="stylesheet" type="text/css" href="plugins/fancyBox/jquery.fancybox.css">
	<script type="text/javascript" src="plugins/fancyBox/jquery.fancybox.pack.js"></script>
	<!-- 查看图片 -->
	<script type="text/javascript">
	$(top.hangge());
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