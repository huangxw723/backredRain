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
<!-- jsp文件头和头部 -->
<%@ include file="../../system/admin/top.jsp"%>
</head>
<body>
  <div class="container-fluid" id="main-container">
    <div id="page-content" class="clearfix">
      <div class="tabbable">
        <ul class="nav nav-tabs" id="myTab">
          <li class="active">
            <a data-toggle="tab" data-target="#province" href="javascrpipt:void(0);">
              <i class="green icon-list-alt bigger-150"></i>商品类型
            </a>
          </li>
          <li>
            <a data-toggle="tab" data-target="#city" href="javascrpipt:void(0);">
              <i class="red icon-list-alt bigger-150"></i>商品属性
            </a>
          </li>
        </ul>
        <div class="tab-content">
          <div id="province" class="tab-pane fade in active">
            <iframe name="provinceFrame" id="provinceFrame" frameborder="0" src="<%=basePath%>attrType/attrTypeList.do" style="margin:0 auto;width:100%;height:100%;"></iframe>
          </div>
          <div id="city" class="tab-pane fade">
            <iframe name="cityFrame" id="cityFrame" frameborder="0" src="<%=basePath%>attrType/attrButeList.do" style="margin:0 auto;width:100%;height:100%;"></iframe>
          </div>
        </div>
      </div>

    </div>
    <!--/#page-content-->
  </div>
  <script type="text/javascript">
    window.jQuery || document.write("<script src='static/js/jquery-1.9.1.min.js'>\x3C/script>");
  </script>
  <script src="static/js/bootstrap.min.js"></script>
  <script type="text/javascript">
  	function showCity() {
		$('#myTab a[data-target="#city"]').tab('show');
	}
    $(top.hangge());
    var provinceFrame = document.getElementById("provinceFrame");
    var cityFrame = document.getElementById("cityFrame");
    var bheight = document.documentElement.clientHeight;
    provinceFrame.style.height = (bheight - 110) + 'px';
    cityFrame.style.height = (bheight - 110) + 'px';
  </script>
</body>
</html>

