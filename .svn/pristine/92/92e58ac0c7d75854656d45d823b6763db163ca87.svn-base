<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
		if($("#name").val()==""){
			$("#name").tips({
				side:3,
	            msg:'输入商圈',
	            bg:'#AE81FF',
	            time:2
	        });
			$("#name").focus();
			return false;
		}
		$("#form").submit();
		$("#zhongxin").hide();
		$("#zhongxin2").show();
	}
	
</script>
</head>
<body>
  <form action="business/${msg }.do" name="form" id="form" method="post">
    <input type="hidden" name="businessDistrictId" id="businessDistrictId" value="${businessDistrict.businessDistrictId }" />
    <div id="zhongxin">
      <table id="table_report" class="table table-striped table-bordered table-hover">
        <tr>
	      <td>省份:</td>
          <td>
            <select class="chzn-select" name="provinceId" id="provinceId" data-placeholder="请选择省份" style="vertical-align:top;">
              <option value=""></option>
              <c:forEach items="${provinceList}" var="province">
                <option value="${province.provinceId }" <c:if test="${province.provinceId == businessDistrict.province.provinceId }">selected</c:if>>${province.provinceName }</option>
              </c:forEach>
            </select>
          </td>
        </tr>
        <tr>
        <td>城市:</td>
          <td>
            <select class="chzn-select" name="cityId" id="cityId" data-placeholder="请选择城市" style="vertical-align:top;">
            </select>
          </td>
        </tr>
        <tr>
        <td>县区:</td>
          <td>
            <select class="chzn-select" name="areaId" id="areaId" data-placeholder="请选择县区" style="vertical-align:top;">
            </select>
          </td>
        </tr>
        <tr>
          <td>商圈:</td>
          <td>
            <input type="text" style="width:90%;" name="name" id="name" value="${businessDistrict.name }" placeholder="这里输入商圈" title="商圈" />
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
		if($("#provinceId").val()) {
			var provinceId = $("#provinceId").val();
		    var citySelect = $("#cityId");
		    citySelect.empty().append("<option value=''></option>");
		    var cityList = '${cityList}';
		    var cityId = '${businessDistrict.city.cityId}';
		    $.each(JSON.parse(cityList), function(i, list){
		    	var parentId = list.provinceId;
				if(parentId == provinceId) {
					var value = list.cityId;
					var option = list.cityName;
					var label = $("<option value='"+value+"'>"+option+"</option>");
					if(cityId == list.cityId) {
						label.attr("selected", "selected");
					}
					citySelect.append(label);
				}
		 	});
		}
		if($("#cityId").val()) {
			var cityId = $("#cityId").val();
		    var areaSelect = $("#areaId");
		    areaSelect.empty().append("<option value=''></option>");
		    var areaList = '${areaList}';
		    var areaId = '${businessDistrict.area.areaId}';
		    $.each(JSON.parse(areaList), function(i, list){
		    	var parentId = list.cityId;
				if(parentId == cityId) {
					var value = list.areaId;
					var option = list.areaName;
					var label = $("<option value='"+value+"'>"+option+"</option>");
					if(areaId == list.areaId) {
						label.attr("selected", "selected");
					}
					areaSelect.append(label);
				}
		 	});
		}
		
		//单选框
		$(".chzn-select").chosen(); 
		$(".chzn-select-deselect").chosen({allow_single_deselect:true});
		
		//联动select事件
		$("#provinceId").change(function(){
		    var provinceId = $("#provinceId").val();
		    var citySelect = $("#cityId");
		    citySelect.empty().append("<option value=''></option>");
		    var cityList = '${cityList}';
		    $.each(JSON.parse(cityList), function(i, list){
		    	var parentId = list.provinceId;
				if(parentId == provinceId) {
					var value = list.cityId;
					var option = list.cityName;
					var label = $("<option value='"+value+"'>"+option+"</option>");
					citySelect.append(label);
				}
		 	});
		    citySelect.trigger("liszt:updated");
		});
		$("#cityId").change(function(){
		    var cityId = $("#cityId").val();
		    var areaSelect = $("#areaId");
		    areaSelect.empty().append("<option value=''></option>");
		    var areaList = '${areaList}';
		    $.each(JSON.parse(areaList), function(i, list){
		    	var parentId = list.cityId;
				if(parentId == cityId) {
					var value = list.areaId;
					var option = list.areaName;
					var label = $("<option value='"+value+"'>"+option+"</option>");
					areaSelect.append(label);
				}
		 	});
		    areaSelect.trigger("liszt:updated");
		});
	});
  </script>
</body>
</html>