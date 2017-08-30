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
		if($("#attrName").val()==""){
			$("#attrName").tips({
				side:3,
	            msg:'输入属性名称',
	            bg:'#AE81FF',
	            time:2
	        });
			$("#attrName").focus();
			return false;
		}
		if($("#attrInputType").val()==""){
			$("#attrInputType").tips({
				side:3,
	            msg:'属性的添加类别',
	            bg:'#AE81FF',
	            time:2
	        });
			$("#attrInputType").focus();
			return false;
		}
		if($("#attrValues").val()==""){
			$("#attrValues").tips({
				side:3,
	            msg:'属性值',
	            bg:'#AE81FF',
	            time:2
	        });
			$("#attrValues").focus();
			return false;
		}
		
		$("#form").submit();
		$("#zhongxin").hide();
		$("#zhongxin2").show();
	}
	
</script>
</head>
<body>
  <form action="attribute/${msg }.do" name="form" id="form" method="post">
    <input type="hidden" name="attributeId" id="attributeId" value="${attribute.attributeId }" />
    <div id="zhongxin">
      <table id="table_report" class="table table-striped table-bordered table-hover">
        <tr>
          <th>属性名称:</th>
          <td>
             <input type="text" style="width:90%;" name="attrName" id="attrName" value="${attribute.attrName }" placeholder="这里输入属性名称" title="属性名称" />
          
          </td>
        </tr>
        <tr>
          <th>所属类型id:</th>
          <td>
             <input type="text" style="width:90%;" name="attrTypeId" id="attrTypeId" value="1" placeholder="这里输入属性所属类型id" title="所属类型id" />
          
          </td>
        </tr>
        <tr>
        <tr>
          
          <th>属性的添加类别:</th>
          <td>
             <input type="text" style="width:90%;" name="attrInputType" id="attrInputType" value="${attribute.attrInputType }" placeholder="这里输入属性的添加类别" title="添加类别" />
           
          </td>
        </tr>
        <tr>
          
          <th>属性选择类型:</th>
          <td>
             <input type="text" style="width:90%;" name="attrType" id="attrType" value="${attribute.attrType }" placeholder="这里输入属性选择类型" title="属性选择类型" />
           
          </td>
        </tr>
        <tr>
          
          <th>属性值:</th>
          <td>
             <input type="text" style="width:90%;" name="attrValues" id="attrValues" value="${attribute.attrValues }" placeholder="这里输入属性值" title="属性值" />
          
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