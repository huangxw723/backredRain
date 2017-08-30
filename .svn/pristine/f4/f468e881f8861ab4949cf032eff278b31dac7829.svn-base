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
		<script type="text/javascript" src="static/js/common/commonutils.js"></script>
		
  		
<script type="text/javascript">
	$(top.hangge());
	
	$(function() {
		$(".chzn-select").chosen(); 
		$(".chzn-select-deselect").chosen({allow_single_deselect:true}); 
		
		var operaResult = '${operaResult}';
		if(operaResult){
			alert(operaResult)
		}
	});
	
	$(function(){
		//日期框
		$('.date-picker').datepicker();
	});
	
	
	
	//更改图片
    function changeImg(){
        $("#fileInput").trigger("click");
    }
	
	//保存
	function save(){
		var fileType = document.getElementById("fileInput").value.substr(document.getElementById("fileInput").value.lastIndexOf(".")).toLowerCase();//获得文件后缀名
		var url = $("#url").val();
		var img = $("#imgHref").attr("src");
		if (!img || url) {
			if (fileType != '.gif' && fileType != '.png' && fileType != '.jpg'
					&& fileType != '.jpeg' ) {
				$("#fileInput").tips({
					side : 3,
					msg : '请上传图片格式的文件',
					bg : '#AE81FF',
					time : 3
				});
				$("#fileInput").val('');
				document.getElementById("fileInput").files[0] = '请选择图片';
				return;
			}
		}
		var name = $('#name').val();
		if(validateUtils.isEmpty(name)){
			alert("请输入员工名称")
			return
		}
		
		var action = $('#action').val();
		if(action == 1){
			
			var account = $('#account').val();
			if(validateUtils.isEmpty(account)){
				alert("请输入登录帐号")
				return
			}
			
			var password = $('#password').val();
			if(validateUtils.isEmpty(password)){
				alert("请输入密码")
				return
			}
			var confirm_password = $('#confirm_password').val();
			if(validateUtils.isEmpty(confirm_password)){
				alert("请输入确认密码")
				return
			}
			
			if(password != confirm_password){
				alert("两次密码不一致")
				return
			}
		}
		
		form.submit($('#usersForm'));
	
		/* $("#usersForm").submit();
		$("#zhongxin").hide();
		$("#zhongxin2").show(); */
	}

</script>
	</head>
<body>

	<form action="staff/opera.do" name="usersForm" id="usersForm" method="post">
	<input type="hidden" name="action" id="action" value="${action}"/>
	<input type="hidden" name="userId" id="userId" value="${pd.userId}"/>
	<div id="zhongxin" >
	<table id="table_report" class="table table-striped table-bordered table-hover" style="overflow:scroll;">
		<tr height="45px">
			<td>账号:</td>
			<td><input type="text" name="account" id="account" value="${pd.account}" style="width: 370px" onkeyup="validateUtils.replaceSpaceEmpty(this);" <c:if test="${action == 4}">disabled="disabled"</c:if>/></td>
		</tr>
		<tr height="45px">
			<td>员工名称:</td>
			<td><input type="text" name="name" id="name" value="${pd.name}" style="width: 370px" onkeyup="validateUtils.replaceSpaceEmpty(this);" <c:if test="${action == 4}">disabled="disabled"</c:if> /></td>
		</tr>
		
		<c:if test="${action == 1}">
			<tr height="45px">
				<td>登录密码:</td>
				<td><input type="password" name="password" id="password" style="width: 370px" onkeyup="validateUtils.replaceSpaceEmpty(this);"/></td>
			</tr>
			<tr height="45px">
				<td>密码确认:</td>
				<td><input type="password" name="confirm_password" id="confirm_password" style="width: 370px" onkeyup="validateUtils.replaceSpaceEmpty(this);"/></td>
			</tr>
		</c:if>
		
		
		<tr height="45px">
			<td>员工状态:</td>
			<td>
				<select name="status" <c:if test="${action == 4}">disabled="disabled"</c:if> >
					<option value="0" <c:if test="${pd.status ==0}">selected="selected"</c:if>>启用</option>
					<option value="1" <c:if test="${pd.status ==1}">selected="selected"</c:if>>禁用</option>
				</select>
			</td>
		</tr>
		<tr>
			<td>员工头像:</td>
             <td>
            <c:if test="${pd == null || pd.userHead== '' || pd.userHead == null }">
              <a id="imgBox" href="javascript:void(0)" style="display:none;">
                <img src="" width="150" id="imgHref" />
              </a>
              <input type="file" id="fileInput" name="fileInput" />
            </c:if>
            <c:if test="${pd != null && pd.userHead != '' && pd.userHead != null }">
              <a id="imgBox" href="<%=httpUrl%>${pd.userHead}" title="${pd.userHead}">
                <img src="<%=httpUrl%>${pd.userHead}" alt="${pd.userHead}" width="150" id="imgHref" />
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
			<td>描述:</td>
			<td><textarea name="descp" id="descp" style="width: 400px;resize:none;height:200px;" onkeyup="validateUtils.replaceSpaceEmpty(this);" <c:if test="${action == 4}">disabled="disabled"</c:if>>${pd.descp}</textarea></td>
		</tr>
		<c:if test="${action < 4}">
		<tr id="operaArea">
			<td style="text-align: center;" colspan="2">
                <a class="btn btn-mini btn-primary" onclick="save();">保存</a>
				<a class="btn btn-mini btn-danger" onclick="top.Dialog.close();">取消</a>
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
	<script type="text/javascript" src="static/js/bootstrap-datepicker.min.js"></script><!-- 日期框 -->
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