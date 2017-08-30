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

var isExist = false;

$(function() {
	
	$(".chzn-select").chosen(); 
	$(".chzn-select-deselect").chosen({allow_single_deselect:true});

    //鼠标失焦后验证
    $("#account").blur(function(){
        var account = $('#account').val();
        if(!validateUtils.isEmpty(account)){
            $.ajax({
                type: "POST",
                url: '<%=basePath%>account/isShopAccountExist.do',
                data: {account:account},
                dataType:'json',
                cache: false,
                success: function(data){
                    if(data){
                        isExist = true;
                        $("#account").tips({
                            side:3,
                            msg:'该用户名已被注册',
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

    //判断是否后台管理员
    if('${isAdmin eq true}'){
        var shopId = $('#shopId').val();
        if(shopId == ''){
            $("#shopId").tips({
                side:3,
                msg:'请选择商户',
                bg:'#AE81FF',
                time:2
            });
            $("#shopId").focus();
            return false;
        };
    }

    if(isExist){
        $("#account").tips({
            side:3,
            msg:'该用户名已经存在',
            bg:'#AE81FF',
            time:2
        });
        $("#account").focus();
        return false;
    }
	
	var name = $('#name').val();
	if(validateUtils.isEmpty(name)){
        $("#name").tips({
            side:3,
            msg:'请填写真实姓名',
            bg:'#AE81FF',
            time:3
        });
        $("#name").focus();
		return
	}
	
	var email = $('#email').val();
	if(validateUtils.isEmpty(email)){
        $("#email").tips({
            side:3,
            msg:'请填写联系邮箱',
            bg:'#AE81FF',
            time:3
        });
        $("#email").focus();
		return
	}
    if(!validateUtils.isMail(email)){
        $("#email").tips({
            side:3,
            msg:'请填写正确邮箱格式',
            bg:'#AE81FF',
            time:3
        });
        $("#email").focus();
        return
    }
	
	var tel = $('#tel').val();
	if(validateUtils.isEmpty(tel)){
        $("#tel").tips({
            side:3,
            msg:'请填写手机号码',
            bg:'#AE81FF',
            time:3
        });
        $("#tel").focus();
		return
	}
	if(!validateUtils.isMobilePhone(tel)){
        $("#tel").tips({
            side:3,
            msg:'请填写正确的手机号码',
            bg:'#AE81FF',
            time:3
        });
        $("#tel").focus();
		return;
	}
	
	var account = $('#account').val();
	if(validateUtils.isEmpty(account)){
        $("#account").tips({
            side:3,
            msg:'请填写用户名',
            bg:'#AE81FF',
            time:3
        });
        $("#account").focus();
		return
	}

    var password = $('#password').val();
    if(validateUtils.isEmpty(password)){
        $("#password").tips({
            side : 3,
            msg : '请设置密码',
            bg : '#AE81FF',
            time : 2
        });
        $("#password").focus();
        return
    }

    if (password.length >20 ||password.length < 6) {
        $("#password").tips({
            side : 3,
            msg : '密码长度6到20位',
            bg : '#AE81FF',
            time : 2
        });
        $("#password").focus();
        return false;
    }

    var confirmPassword = $('#confirm_password').val();
    if(validateUtils.isEmpty(confirmPassword)){
        $("#confirm_password").tips({
            side : 3,
            msg : '请输入确认密码',
            bg : '#AE81FF',
            time : 2
        });
        $("#confirm_password").focus();
        return
    }
    if (confirmPassword.length >20 ||confirmPassword.length < 6) {
        $("#confirm_password").tips({
            side : 3,
            msg : '密码长度6到20位',
            bg : '#AE81FF',
            time : 2
        });
        $("#confirm_password").focus();
        return false;
    }

    if(password != confirmPassword){
        $("#confirm_password").tips({
            side : 3,
            msg : '两次密码输入不一样',
            bg : '#AE81FF',
            time : 2
        });
        $("#confirm_password").focus();
        return
    }

	// 提交表单
    form.submit($('#usersForm'));
}

//判断用户名是否存在
/*function hasU(){
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
}*/

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
  <form action="<%=basePath%>account/saveShopAccount" name="usersForm" id="usersForm" method="post">
    <input type="hidden" name="action" id="action" value="${pd.action }" />
      <c:if test="${isAdmin != true}">
        <input type="hidden" name="shopId"   value="${shopId }" />
      </c:if>
     <input type="hidden" name="pwdFlag" id="pwdFlag"  />
    <div id="zhongxin">
      <table id="table_report" class="table table-striped table-bordered table-hover">
        
<!--         <select id="shopId" style="display:none;"> -->
<%--         	<option value="${shopId }" selected="selected"> --%>
<!--         </select> -->
        <!-- <tr>
          <th>站点权限:</th>
          <td>
            <select name="screenDomainId" id="screenDomainId">
            </select>
          </td>
        </tr> -->
         <c:if test="${isAdmin == true}"> 
          <tr>
          <th>商户:</th>
          <td>
           
            <select class="chzn-select" name="shopId" style="width: 80%" id="shopId" >
             <c:forEach items="${shopList }" var="va">
             			<option value="${va.shopId}" >${va.name }</option>
             </c:forEach>
            </select>
           
          </td>
        </tr>
        </c:if>
       
        <tr>
          <th>账户类型:</th>
          <td>
            <select name="type" id="type" style="width:90%;" autocomplete="off">
<!--               <option value="1" >店铺管理员</option> -->
              <option value="2" selected="selected" >员工管理员</option>
            </select>
          </td> 
        </tr>
        <tr>          
          <th>真实姓名:</th>
          <td>
              <input type="text" style="width:90%;" name="name" id="name" value="" title="真实姓名" autocomplete="off"/>
          </td>
        </tr>
        <tr> 
<tr>          
          <th>邮箱地址:</th>
          <td>
            <input type="text" style="width:90%;" name="email" id="email" value="" title="邮箱地址" autocomplete="off" />
          </td>
        </tr>
        <tr>          
          <th>手机号码 :</th>
          <td>
             <input type="number" style="width:90%;" name="tel" id="tel" value="" title="手机号码" autocomplete="off" onkeyup="validateUtils.replaceNotNumEmpty(this);"/>
          </td>
        </tr>
        <tr>          
          <th>用户名:</th>
          <td>
              <input type="text" style="width:90%;" name="account" id="account" value="" title="用户名" autocomplete="off"/>
          </td>
        </tr>
        <tr>          
          <th>设置密码:</th>
          <td> 
		     <input name="password" id="password" type="password" value="" placeholder="6到20位"  style="width:90%;" autocomplete="off" >
		   </td>
        </tr>
          <tr>
              <th>确认密码:</th>
              <td>
                  <input  id="confirm_password" type="password" value="" placeholder="6到20位"  style="width:90%;" autocomplete="off" >
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
 <%--    
    $(function(){
    	
    	var initShopId = $('#shopId').val();
    	listSubNodes(initShopId);
    })
    
    function listSubNodes(id){
    	
    	$.get('<%=basePath%>yp/admin/ypScreenDomain/getDomainByShopId',{shopId:id},function(data){
    		
    		$('#screenDomainId').empty();
    		
    		$.each(data, function(i,object){      
    			$('<option value="'+object.screenDomainId+'">'+object.url+'</option>').appendTo($('#screenDomainId'));
    		  }); 
    	},'json');
    } --%>
  </script>
</body>
</html>