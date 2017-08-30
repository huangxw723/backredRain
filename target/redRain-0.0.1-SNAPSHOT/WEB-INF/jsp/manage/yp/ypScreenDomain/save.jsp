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
    <div id="zhongxin">
      <table id="table_report" class="table table-striped table-bordered table-hover">
        <tr>
          <th>终端标识:</th>
          <td>
           <input <c:if test="${pd.action==2}">disabled="disabled"</c:if>  type="text" style="width:90%;" name="sn" id="sn" value="${sc.sn }" title="终端标识" />
          </td>
        </tr>
        
        <tr>
          <th>绑定域名:</th>
          <td>
            <select class="chzn-select" name="screenDomainId" id="screenDomainId" data-placeholder="绑定域名" style="vertical-align:top;">
             <option value=""></option> 
            <c:forEach items="${domains}" var="var">
                 <option value="${var.screenDomainId }" <c:if test="${var.screenDomainId == sc.screenDomainId }">selected</c:if>>${var.url }</option> 
             </c:forEach> 
            </select>          
            </td>
        </tr>
        <tr>
          <th>地理位置:
          <td>
            <select <c:if test="${pd.action==2}">disabled="disabled"</c:if>  class="chzn-select" name="provinceId" id="provinceId" data-placeholder="请选择省份" style="vertical-align:top;">
              <option value=""></option>
              <c:forEach items="${provinceList}" var="province">
                <option value="${province.provinceId }" <c:if test="${province.provinceId == sc.provinceId }">selected</c:if>>${province.provinceName }</option>
              </c:forEach>
            </select>
            <select class="chzn-select" name="cityId" id="cityId"  style="vertical-align:top;" <c:if test="${pd.action==2}">disabled="disabled"</c:if> >
              <option value=""></option>
              <c:forEach items="${cityList}" var="city">
                <option value="${city.cityId }" <c:if test="${city.cityId == sc.cityId }">selected</c:if>>${city.cityName }</option>
              </c:forEach>
            </select>
            <select <c:if test="${pd.action==2}">disabled="disabled"</c:if>  class="chzn-select" name="areaId" id="areaId"  style="vertical-align:top;">
            <option value=""></option>
              <c:forEach items="${areaList}" var="area">
                <option value="${area.areaId }" <c:if test="${area.areaId == sc.areaId }">selected</c:if>>${area.areaName }</option>
              </c:forEach>
            </select>
          </td>
        </tr>
        <tr>
        <th>详细地址:</th>
         <td>
            <input type="text" style="width:90%;" name="address" id="address" value="${sc.address }" title="详细地址" />
            
          </td>
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