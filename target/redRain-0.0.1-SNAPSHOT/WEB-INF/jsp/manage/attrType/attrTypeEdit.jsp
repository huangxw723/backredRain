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
		if($("#typeName").val()=="" || $.trim($("#typeName").val())==""){
			$("#typeName").tips({
				side:3,
	            msg:'输入商品类型名称',
	            bg:'#AE81FF',
	            time:2
	        });
			$("#typeName").focus();
			return false;
		}
		$("#form").submit();
		$("#zhongxin").hide();
		$("#zhongxin2").show();
	}
	
</script>
</head>
<body>
  <form action="attrType/${msg }.do" name="form" id="form" method="post">
    <input type="hidden" name="attrTypeId" id="attrTypeId" value="${attrType.attrTypeId }" />
    <div id="zhongxin">
      <table id="table_report" class="table table-striped table-bordered table-hover">
        <tr>
          <td>商品类型名称:</td>
          <td>
            <input type="text" style="width:90%;" name="typeName" id="typeName" value="${attrType.typeName }" placeholder="这里输入商品类型名称" title="商品类型名称" />
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