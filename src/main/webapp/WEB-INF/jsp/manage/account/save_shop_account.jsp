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
	
	
	var name = $('#name').val();
	if(validateUtils.isEmpty(name)){
		alert('请填写真实姓名')
		return
	}
	
	var email = $('#email').val();
	if(validateUtils.isEmpty(email)){
		alert('请填写联系邮箱')
		return
	}
	if(!validateUtils.isMail(email)){
		alert('请输入正确的邮箱地址')
		return
	}
	var tel = $('#tel').val();
	if(validateUtils.isEmpty(tel)){
		alert('请填写联系号码')
		return
	}
	if(new String(tel).length < 11){
		alert('联系号码请填写正确的手机号码')
		return;
	}
	
	var account = $('#account').val();
	if(validateUtils.isEmpty(account) && $("#action").val()==1 && $("#action").val()!='' ){
		alert('请填写登录帐号')
		return
	}
	
	var password = $('#password').val();
	if(validateUtils.isEmpty(password) && $("#action").val()==1 && $("#action").val()!='' ){
		alert('请填写密码')
		return
	}
	
	// 提交表单
    form.submit($('#usersForm'));
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
  <form action="<%=basePath%>account/saveShopAccount" name="usersForm" id="usersForm" method="post">
    <input type="hidden" name="action" id="action" value="${pd.action }" />
     <input type="hidden" name="userId" id="userId" value="${pd.userId}" />
     <input type="hidden" name="type" id="type" value="${pd.type}" />
     <input type="hidden" name="pwdFlag" id="pwdFlag"  />
    <div id="zhongxin">
      <table id="table_report" class="table table-striped table-bordered table-hover">
        <tr>
          <th>归属企业:</th>
          <td>
            <select name="shopId" style="width: 92%" onchange="listSubNodes(this.value)" id="shopId" <c:if test="${pd.action !=1}">disabled="disabled"</c:if>>
             <c:forEach items="${shops }" var="var">
                  <option value="${var.shopId}" <c:if test="${var.shopId == shop.shopId }">selected="selected"</c:if>> ${var.name }</option>
             </c:forEach>
            </select>
          </td>
        </tr>
         <c:if test="${pd.action==1 }">
        <tr>
          <th>站点权限:</th>
          <td>
            <select <c:if test="${pd.action != 1}">disabled="disabled"</c:if> style="width: 92%" name="screenDomainId" id="screenDomainId">
            </select>
          </td>
        </tr>
        </c:if>
        <tr>
          <th>账户类型:</th>
          <td>
            <select <c:if test="${pd.action == 4 ||pd.action == 2 }">disabled="disabled"</c:if> name="type">
              <option value="1" <c:if test="${pd.type == 1}">selected</c:if> >店铺管理员</option>
              <option value="2" <c:if test="${pd.type == 2}">selected</c:if>>员工</option>
            </select>
          </td> 
        </tr>
        <tr>          
          <th>真实姓名:</th>
          <td>
                          <input <c:if test="${pd.action == 4}">disabled="disabled"</c:if> type="text" style="width:90%;" name="name" id="name" value="${shop.name}" title="真实姓名" autocomplete="off"/>

          </td>
        </tr>
        <tr> 
<tr>          
          <th>邮箱地址:</th>
          <td>
                          <input <c:if test="${pd.action == 4}">disabled="disabled"</c:if> type="text" style="width:90%;" name="email" id="email" value="${shop.email}" title="邮箱地址" autocomplete="off"/>

          </td>
        </tr>
        <tr>          
          <th>手机号码 :</th>
          <td>
                          <input <c:if test="${pd.action == 4}">disabled="disabled"</c:if> type="text" style="width:90%;" name="tel" id="tel" value="${shop.tel}" title="手机号码" autocomplete="off"/>

          </td>
        </tr>
        <c:if test="${pd.action==1 }">
        <tr>          
          <th>账户名称:</th>
          <td>
                         <input type="text" style="width:90%;" name="account" id="account" value="" title="账户名称" autocomplete="off"/>

          </td>
        </tr>
        <tr>          
          <th>密码:</th>
          <td> 
		   <input name="password" id="password" type="password" value="" placeholder="输入密码" autocomplete="off">
		   
		   </td>
        </tr>
       </c:if>
       <c:if test="${pd.action != 4}">
         <tr>
          <td class="center" colspan="2">
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
 <script type="text/javascript" src="static/js/common/commonutils.js"></script>

  <script type="text/javascript">
    $(top.hangge());
    
    $(function(){
    	
    	var initShopId = $('#shopId').val();
    	listSubNodes(initShopId);
    	
    	if($("#shopId").val()) {
			var shopId = $("#shopId").val();
		    var domainSelect = $("#screenDomainId");
		    domainSelect.empty().append("<option value=''></option>");
		    var domainse = '${domains}';
		    var sId = '${shop.shopId}';

		    $.each(JSON.parse(domainse), function(i, list){
		    	var parentId = list.shopId;

				if(parentId == shopId) {
					var value = list.screenDomainId;
					var option = list.url;
					var label = $("<option value='"+value+"'>"+option+"</option>");
					if(sId == list.shopId) {
						label.attr("selected", "selected");
					}
					domainSelect.append(label);
				}
				 domainSelect.trigger("liszt:updated");
		 	});
		}
    })
    
    function listSubNodes(id){
    	
    	$.get('<%=basePath%>yp/admin/ypScreenDomain/getDomainByShopId',{shopId:id},function(data){
    		
    		$('#screenDomainId').empty();
    		
    		$.each(data, function(i,object){      
    			$('<option value="'+object.screenDomainId+'">'+object.url+'</option>').appendTo($('#screenDomainId'));
    		  }); 
    	},'json');
    }
    
  </script>
</body>
</html>