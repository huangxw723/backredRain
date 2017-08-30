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
		if($("#provinceId").val()==""){
			$("#provinceId").tips({
				side:3,
	            msg:'请选择省份',
	            bg:'#AE81FF',
	            time:2
	        });
			$("#provinceId").focus();
			return false;
		}
		if($("#cityName").val()==""){
			$("#cityName").tips({
				side:3,
	            msg:'输入城市',
	            bg:'#AE81FF',
	            time:2
	        });
			$("#cityName").focus();
			return false;
		}
		if($("#cityName").val().length > 20){
			$("#cityName").tips({
				side:3,
	            msg:'城市不能大于20个字',
	            bg:'#AE81FF',
	            time:2
	        });
			$("#cityName").focus();
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
    <input type="hidden" name="cityId" id="cityId" value="${city.cityId }" />
    <div id="zhongxin">
      <table id="table_report" class="table table-striped table-bordered table-hover">
        <tr>
	      <td>省份:</td>
          <td>
            <select class="chzn-select" name="provinceId" id="provinceId" data-placeholder="请选择省份" style="vertical-align:top;">
              <option value=""></option>
              <c:forEach items="${provinceList}" var="province">
                <option value="${province.provinceId }" <c:if test="${province.provinceId == city.province.provinceId }">selected</c:if>>${province.provinceName }</option>
              </c:forEach>
            </select>
          </td>
        </tr>
        <tr>
          <td>城市:</td>
          <td>
            <input type="text" style="width:90%;" name="cityName" id="cityName" value="${city.cityName }" placeholder="这里输入城市" title="城市" />
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
	$(function() {
		//单选框
		$(".chzn-select").chosen(); 
		$(".chzn-select-deselect").chosen({allow_single_deselect:true}); 
	});
  </script>
</body>
</html>