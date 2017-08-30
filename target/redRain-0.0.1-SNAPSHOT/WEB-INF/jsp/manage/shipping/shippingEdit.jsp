<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.aoshi.util.PropertyUtils"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<!DOCTYPE html>
<html lang="en">
<head>
	<base href="<%=basePath%>">
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	
	<meta name="description" content="overview & stats" />
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
		<!-- basic styles -->
	<link href="static/css/bootstrap.min.css" rel="stylesheet" />
	<link href="static/css/bootstrap-responsive.min.css" rel="stylesheet" />
	<link rel="stylesheet" href="static/css/font-awesome.min.css" />
	<!-- page specific plugin styles -->
	<!-- 下拉框-->
	<link rel="stylesheet" href="static/css/chosen.css" />
	<!-- ace styles -->
	<link rel="stylesheet" href="static/css/ace.min.css" />
	<link rel="stylesheet" href="static/css/ace-responsive.min.css" />
	<link rel="stylesheet" href="static/css/ace-skins.min.css" />
	<script type="text/javascript" src="static/js/jquery-1.7.2.js"></script>
	<link rel="stylesheet" href="static/css/datepicker.css" /><!-- 日期框 -->
	<!--引入弹窗组件start-->
	<script type="text/javascript" src="plugins/attention/zDialog/zDrag.js"></script>
	<script type="text/javascript" src="plugins/attention/zDialog/zDialog.js"></script>
	<!--引入弹窗组件end-->
	<script type="text/javascript" src="static/js/jquery.tips.js"></script>
</head>

<body>
  <form action="shipping/operaShipping.do" name="form" id="form" method="post">
    <input type="hidden" name="shippingId" id="shippingId" value="${pd.shippingId }" />
    <input type="hidden" name="doAction" id="shippingId" value="${doAction }" />
    <div id="zhongxin">
      <table id="table_report" class="table table-striped table-bordered table-hover">
        <tr>
          <th>配送方式代号:</th>
          <td>
             <input type="text" style="width:90%;" name="shippingCode" id="shippingCode" value="${pd.shippingCode }" placeholder="这里输入配送方式代号" title="配送方式代号" onkeyup="validateUtils.replaceSpaceEmpty(this);"/>
          
          </td>
        </tr>
        <tr>
          
          <th>配送商名称:</th>
          <td>
             <input type="text" style="width:90%;" name="shippingName" id="shippingName" value="${pd.shippingName }" placeholder="这里输入配送方式名称" title="配送方式名称" onkeyup="validateUtils.replaceSpaceEmpty(this);" />
           
          </td>
        </tr>
        <tr>
          
          <th>描述:</th>
          <td>
             <input type="text" style="width:90%;" name="shippingDesc" id="shippingDesc" value="${pd.shippingDesc }" placeholder="这里输入配送方式描述" title="配送方式描述" />
           
          </td>
        </tr>
        
        <tr>
          <th>是否禁用:</th>
          <td>
            <select name="enabled" title="是否显示">
              <option value="1" <c:if test="${pd.enabled == 1 }">selected</c:if>>否</option>
              <option value="0" <c:if test="${pd.enabled == 0 }">selected</c:if>>是</option>
            </select>
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
  <script type="text/javascript" src="static/js/chosen.jquery.min.js"></script>
  <script type="text/javascript" src="static/js/common/commonutils.js"></script>
  <!-- 单选框 -->

  <script type="text/javascript">
    $(top.hangge());
  </script>
  <script type="text/javascript">
	//保存
	function save(){
		
		var shippingCode = $('#shippingCode').val();
		if(validateUtils.isEmpty(shippingCode)){
			alert("请输入配送商代号")
			return
		}
		
		var shippingName = $('#shippingName').val();
		if(validateUtils.isEmpty(shippingName)){
			alert("请输入配送商名称")
			return
		}
		
		$("#form").submit();
		$("#zhongxin").hide();
		$("#zhongxin2").show();
	}
	
</script>
</body>
</html>