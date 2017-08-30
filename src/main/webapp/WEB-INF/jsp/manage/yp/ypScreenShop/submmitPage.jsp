<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.aoshi.util.PropertyUtils"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
	String httpUrl = PropertyUtils.getHTTP_URL();
%>
<!DOCTYPE html>
<html lang="en">
<head>
<base href="<%=basePath%>">
<%@ include file="../../../system/admin/top.jsp"%>
 <script type="text/javascript" src="static/js/common/commonutils.js"></script>

<script type="text/javascript">
	//保存
</script>
</head>
<body>
  <form action="yp/business/screenInfo/${msg }.do" name="shopForm" id="shopForm" method="post">
    <input type="hidden" name="action" id="action" value="${pd.action }" />
    <input type="hidden" name="screenInfoId" id="screenInfoId" value="${sc.screenInfoId }" />
    <div id="zhongxin" >
      <br />
      <br />
      <br />
      <br />
      <h4>您正在审核云屏终端，请确定该终端信息已注册到系统中并编码正确无误，</h4><br/>

             <h4>请严格检查确认后提交审核结果！</h4>
      <br />
         <table  >
          <tr>
          <td class="center" colspan="2">
         
          </td>
        </tr>
        </table>
      <br />
    </div>  
       通过<input type="radio" value="">
            不通过<input type="radio" value="">
    <div id="zhongxin2" class="center" >
      <br />
      <br />
      <br />
      <br />
      <br />
      <br />
      <h4 class="lighter block green">提交中...</h4>
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
<input type="radio" value="苹果 " />
  </form>
  <!-- 引入 -->
  <script type="text/javascript">window.jQuery || document.write("<script src='static/js/jquery-1.9.1.min.js'>\x3C/script>");</script>
  <script src="static/js/bootstrap.min.js"></script>
  <script src="static/js/ace-elements.min.js"></script>
  <script src="static/js/ace.min.js"></script>
  <script type="text/javascript" src="static/js/chosen.jquery.min.js"></script>
    <!-- base64 -->
  <script src="static/js/base64.js"></script>
  <link rel="stylesheet" type="text/css" href="plugins/fancyBox/jquery.fancybox.css">
  <script type="text/javascript" src="plugins/fancyBox/jquery.fancybox.pack.js"></script>
  <!-- 单选框 -->

  <script type="text/javascript">
    $(top.hangge());
$(function(){
    	
		//单选框
		$(".chzn-select").chosen(); 
		$(".chzn-select-deselect").chosen({allow_single_deselect:true});
    })
	//保存
	function save(){
	if($("#sn").val()==""){
		
		$("#sn").tips({
			side:3,
            msg:'输入标识编号',
            bg:'#AE81FF',
            time:2
        });
		
		$("#sn").focus();
		$("#sn").val('');
		return false;
	}else{
		$("#sn").val(jQuery.trim($('#sn').val()));
	}
	if($("#screenDomainId").val()=="" || $("#screenDomainId").val()=="此用户名已存在!"){
		
		$("#screenDomainId").tips({
			side:3,
            msg:'请选选择域名',
            bg:'#AE81FF',
            time:2
        });
		
		$("#screenDomainId").focus();
		$("#screenDomainId").val('');
		return false;
	}else{
		$("#screenDomainId").val(jQuery.trim($('#screenDomainId').val()));
	}
		form.submit($('#shopForm'));

	}
	$(function(){	
		//联动select事件
		
		
	});
  </script>
</body>
</html>