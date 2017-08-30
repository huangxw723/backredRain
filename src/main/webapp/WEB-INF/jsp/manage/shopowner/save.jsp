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
		
		var name = $('#name').val();
		if(validateUtils.isEmpty(name)){
			alert("请填写商家名称")
			return
		}
		
		var action = $('#action').val();
		if(action == 1){
			
			var account = $('#account').val();
			if(validateUtils.isEmpty(account)){
				alert("请填写商家帐号")
				return
			}
			
			var password = $('#password').val();
			if(validateUtils.isEmpty(password)){
				alert("请填写登录密码")
				return
			}
			var confirm_password = $('#confirm_password').val();
			if(validateUtils.isEmpty(confirm_password)){
				alert("请填写密码确认")
				return
			}
			
			if(password != confirm_password){
				alert("两次密码不一致")
				return
			}
		}
		
		var contact = $('#contact').val();
		if(validateUtils.isEmpty(contact)){
			alert("请填写商家联系人")
			return
		}
		var tel = $('#tel').val();
		if(validateUtils.isEmpty(tel)){
			alert("请填写联系电话")
			return
		}
		
		// 提交表单
        form.submit($('#usersForm'));
	}

</script>
	</head>
<body>

	<form action="shopowner/opera.do" name="usersForm" id="usersForm" method="post" enctype="application/x-www-form-urlencoded">
	<input type="hidden" name="userId" id="user_id" value="${pd.userId }"/>
	<input type="hidden" name="logoUrl" id="user_head" value="${pd.logoUrl}"/>
	<input type="hidden" name="action" id="action" value="${action}"/>
	<div id="zhongxin" >
	<table id="table_report" class="table table-striped table-bordered table-hover" style="overflow:scroll;">
	
		<c:if test="${action == 1}">
		<tr height="45px">
			<td>商家帐号:</td>
			<td><input type="text" name="account" id="account" value="${pd.account}" placeholder="请输入商家帐号" style="width: 370px" onkeyup="validateUtils.replaceSpaceEmpty(this);"/></td>
		</tr>
		</c:if>
		
		<tr height="45px">
			<td>商家名称:</td>
			<td><input <c:if test="${action == 4}">disabled="disabled"</c:if> type="text" name="name" id="name" value="${pd.name}" placeholder="请输入商家名称" style="width: 370px" onkeyup="validateUtils.replaceSpaceEmpty(this);"/></td>
		</tr>
		
		
			<td>所属商场:</td>
			<td>
				<select name="storeId" <c:if test="${action == 4}">disabled="disabled"</c:if>>
					<c:forEach items="${storeList }" var="var">
						<option value="${var.storeId }" <c:if test="${var.storeId == pd.storeId}">selected="selected"</c:if>>${var.name}</option>
					</c:forEach>
				</select>
			</td>
		</tr>
		
		<tr height="45px">
		<td>所在楼层:</td>
			<td>
				<select name="floor" <c:if test="${action == 4}">disabled="disabled"</c:if>>
					<c:forEach items="${floorList }" var="var">
						<option value="${var }" <c:if test="${var == pd.floor}">selected="selected"</c:if>>${var}</option>
					</c:forEach>
				</select>
				楼
			</td>
		</tr>
		
		<c:if test="${action == 1}">
		<tr height="45px">
			<td>登录密码:</td>
			<td><input type="password" name="password" id="password"  placeholder="请输入登录密码" style="width: 370px" onkeyup="validateUtils.replaceSpaceEmpty(this);"/></td>
		</tr>
		<tr height="45px">
			<td>密码确认:</td>
			<td><input type="password" name="confirm_password" id="confirm_password"  placeholder="请确认用户密码" style="width: 370px" onkeyup="validateUtils.replaceSpaceEmpty(this);"/></td>
		</tr>
		</c:if>
		
		<tr height="45px">
			<td>联系人:</td>
			<td><input <c:if test="${action == 4}">disabled="disabled"</c:if> type="text" name="contact" id="contact" value="${pd.contact}" placeholder="这里输入联系人" style="width: 370px" onkeyup="validateUtils.replaceSpaceEmpty(this);"/></td>
		</tr>
		<tr height="45px">
			<td>联系电话:</td>
			<td><input <c:if test="${action == 4}">disabled="disabled"</c:if> type="tel" name="tel" id="tel" value="${pd.tel}" placeholder="请输入联系电话" style="width: 370px" onkeyup="validateUtils.replaceSpaceEmpty(this);validateUtils.replaceNotNumEmpty(this)"/></td>
		</tr>
		
		<tr height="45px">
			<td>描述:</td>
			<td><textarea <c:if test="${action == 4}">disabled="disabled"</c:if> name="descp" id="descp" placeholder="这里输入描述" style="width: 400px;resize:none;height:200px;" onkeyup="validateUtils.replaceSpaceEmpty(this);">${pd.descp}</textarea></td>
		</tr>
		<tr>
			<td>商家logo:</td>
			<td>
			<c:if test="${pd == null || pd.logoUrl == '' || pd.logoUrl == null }">
              <c:if test="${action != 4}">
				<a id="imgBox" href="javascript:void(0)" style="display:none;">
	                <img src="" width="150" id="imgHref" name="_preview"/>
	            </a>
              <input type="file" id="fileInput" name="fileInput" />
			</c:if>
            </c:if>
            
            
            <c:if test="${pd != null && pd.logoUrl != '' && pd.logoUrl != null }">
	              <a id="imgBox" href="<%=httpUrl%>${pd.logoUrl}" title="${pd.logoUrl}" name="_previewLink">
	                <img src="<%=httpUrl%>${pd.logoUrl}" alt="${pd.logoUrl}" width="150" id="imgHref" name="_preview"/>
	              </a>
	               <c:if test="${action != 4}">
	              <input type="button" class="btn btn-mini btn-danger" value="更改" onclick="changeImg()" id="chImg" />
	              </c:if>
	              
	              <input type="file" id="fileInput" name="fileInput" style="display:none;" name="_previewButton"/>
	            </c:if> 	
             
            
            <input id="url" name="img" type="hidden" />
            </td>
		</tr>
		
		<c:if test="${action != 4}">
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