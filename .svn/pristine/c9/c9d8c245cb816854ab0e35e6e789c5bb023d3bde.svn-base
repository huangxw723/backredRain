<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
<%@ include file="../../system/admin/top.jsp"%>

<script type="text/javascript">
	//保存
	function save(){
		if($("#provinceName").val()==""){
			$("#provinceName").tips({
				side:3,
	            msg:'输入省份',
	            bg:'#AE81FF',
	            time:2
	        });
			$("#provinceName").focus();
			return false;
		}
		if($("#provinceName").val().length > 10){
			$("#provinceName").tips({
				side:3,
	            msg:'省份不能大于10个字',
	            bg:'#AE81FF',
	            time:2
	        });
			$("#provinceName").focus();
			return false;
		}
		$("#form").submit();
		$("#zhongxin").hide();
		$("#zhongxin2").show();
	}
	
</script>
</head>
<body>
  <form action="locality/${msg }.do" name="form" id="form" method="post">
    <input type="hidden" name="provinceId" id="provinceId" value="${province.provinceId }" />
    <div id="zhongxin">
      <table id="table_report" class="table table-striped table-bordered table-hover">
        <tr></tr></br>
        <tr></tr></br>
        <tr>
          <td>省份:</td>
          <td>
            <input type="text" style="width:90%;" name="provinceName" id="provinceName" value="${province.provinceName }" placeholder="这里输入省份" title="省份" />
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
  <!-- 单选框 -->

  <script type="text/javascript">
    $(top.hangge());
  </script>
</body>
</html>