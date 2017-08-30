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
	
});

function change(r){
	if(r==1)
		
	$("#mima").css("display","block");
	$("#pwdFlag").val(r);
	if(r==0)
	$("#mima").css("display","none");
	$("#pwdFlag").val(r);
}
//保存
function save(){
	
	
	if($("#name").val()=="" || $("#name").val()=="此用户名已存在!"){
		
		$("#name").tips({
			side:3,
            msg:'输入用户名',
            bg:'#AE81FF',
            time:2
        });
		
		$("#name").focus();
		$("#name").val('');
		$("#name").css("background-color","white");
		return false;
	}else{
		$("#name").val(jQuery.trim($('#name').val()));
	}
	if($("#pwdFlag").val()=='1' && $("#password").val()==""){
		
		$("#password").tips({
			side:3,
            msg:'输入密码',
            bg:'#AE81FF',
            time:2
        });
		
		$("#password").focus();
		return false;
	}

	if($("#pwdFlag").val()=='1' && $("#password").val()!=$("#password1").val()){
		
		$("#password1").tips({
			side:3,
            msg:'两次密码不相同',
            bg:'#AE81FF',
            time:3
        });
		
		$("#password1").focus();
		return false;
	}

    var myreg = /^(((13[0-9]{1})|159)+\d{8})$/;
	if($("#phone").val()==""){
		
		$("#phone").tips({
			side:3,
            msg:'输入手机号',
            bg:'#AE81FF',
            time:3
        });
		$("#phone").focus();
		return false;
	}else if($("#phone").val().length != 11 && !myreg.test($("#phone").val())){
		$("#phone").tips({
			side:3,
            msg:'手机号格式不正确',
            bg:'#AE81FF',
            time:3
        });
		$("#phone").focus();
		return false;
	}
	
	if($("#email").val()==""){
		
		$("#email").tips({
			side:3,
            msg:'输入邮箱',
            bg:'#AE81FF',
            time:3
        });
		$("#email").focus();
		return false;
	}else if(!ismail($("#email").val())){
		$("#email").tips({
			side:3,
            msg:'邮箱格式不正确',
            bg:'#AE81FF',
            time:3
        });
		$("#email").focus();
		return false;
	}
	hasU();
	 form.submit($('#shopForm'));

}

function ismail(mail){
	return(new RegExp(/^(?:[a-zA-Z0-9]+[_\-\+\.]?)*[a-zA-Z0-9]+@(?:([a-zA-Z0-9]+[_\-]?)*[a-zA-Z0-9]+\.)+([a-zA-Z]{2,})+$/).test(mail));
	}

//判断用户名是否存在
function hasU(){
	var USERNAME = $.trim($("#name").val());
	$.ajax({
		type: "POST",
		url: '<%=basePath%>user/hasU.do',
    	data: {USERNAME:USERNAME,tm:new Date().getTime()},
		dataType:'json',
		cache: false,
		success: function(data){
		 if("success" == data.result){
			$("#userForm").submit();
			$("#zhongxin").hide();
			$("#zhongxin2").show();
		 }else{
			$("#name").css("background-color","#D16E6C");
			setTimeout("$('#name').val('此用户名已存在!')",500);
		 }
		}
	});
}

//判断邮箱是否存在
function hasE(USERNAME){
	var EMAIL = $.trim($("#email").val());
	$.ajax({
		type: "POST",
		url: '<%=basePath%>user/hasE.do',
    	data: {EMAIL:EMAIL,USERNAME:USERNAME,tm:new Date().getTime()},
		dataType:'json',
		cache: false,
		success: function(data){
		 if("success" != data.result){
			 $("#email").tips({
					side:3,
		            msg:'邮箱已存在',
		            bg:'#AE81FF',
		            time:3
		        });
			setTimeout("$('#email').val('')",2000);
		 }
		}
	});
}
</script>
</head>
<body>
  <form action="yp/admin/YpShop/${msg }.do" name="shopForm" id="shopForm" method="post">
    <input type="hidden" name="action" id="action" value="${pd.action }" />
     <input type="hidden" name="pwdFlag" id="pwdFlag"  />
    <div id="zhongxin">
      <table id="table_report" class="table table-striped table-bordered table-hover">
        <tr>
          <th>归属企业:</th>
          <td>
            <select name="shopId" title="归属企业">
             <c:forEach items="${shops }" var="sp">
                  <option value="${sp.shopId}" <c:if test="${sp.name ==shop.name }">selected="selected"</c:if>> ${sp.name }</option>
             </c:forEach>
            </select>
          </td>
        </tr>
        <tr>
          <th>站点权限:</th>
          <td>
            <select name="siteurls" title="站点权限">
             <c:forEach items="${screenDomains}" var="va">
                  <option value="${va.screenDomainId}" <c:if test="${va.screenDomainId ==shop.screenDomainId }">selected="selected"</c:if>> ${va.url }</option>
             </c:forEach>
            </select>
          </td>
        </tr>
        <tr>
          <th>账户类型:</th>
          <td>
            <select title="账户类型默认为商场管理员" disabled="disabled">
              <option value="1" >商场管理员</option>
<%--               <option value="0" <c:if test="${rand.isShow == 0 }">selected</c:if>>不显示</option> --%>
            </select>
          </td> 
        </tr>
<!--         树形菜单 start -->

<!--         树形菜单 end   -->
<tr>          
          <th>邮箱地址:</th>
          <td>
                          <input type="text" style="width:90%;" name="email" id="email" value="" title="邮箱地址" />

          </td>
        </tr>
        <tr>          
          <th>手机号码 :</th>
          <td>
                          <input type="text" style="width:90%;" name="phone" id="phone" value="" title="手机号码" />

          </td>
        </tr>
        <tr>          
          <th>账户名称:</th>
          <td>
                         <input type="text" style="width:90%;" name="name" id="name" value="" title="账户名称" />

          </td>
        </tr>
        <tr>          
          <th>密码:</th>
          <td> <label>
			<input name="pwd" type="radio" value="0" onchange="change(0);"><span class="lbl" > 使用默认密码</span>
			<input name="pwd" type="radio" value="1" onchange="change(1);"><span class="lbl"> 自定义</span>
		   </label>
		   </br>
		   <div id= "mima" style="display: none">
		   <input name="password" id="password" type="text" value="" placeholder="输入密码"></br>
		   <input name="password1" id="password1" type="text" value="" placeholder="确认输入密码">
		   </div>
		   </td>
        </tr>
  
         <tr>
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
 <script type="text/javascript" src="static/js/common/commonutils.js"></script>

  <script type="text/javascript">
    $(top.hangge());
  </script>
</body>
</html>