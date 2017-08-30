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
            <a data-toggle="tab" data-target="#shopOwnerInfo" href="javascrpipt:void(0);">
              <i class="green icon-list-alt bigger-150"></i>商家个人信息
            </a>
          </li>
          <li >
            <a data-toggle="tab" data-target="#shopAccountInfo" href="javascrpipt:void(0);">
              <i class="red icon-list-alt bigger-150"></i>商户信息
            </a>
          </li>
           
        </ul>
        <div class="tab-content">
          <div id="shopOwnerInfo" class='tab-pane fade in active'>
            <iframe name="shopOwnerInfoFrame" id="shopOwnerInfoFrame" frameborder="0" src="<%=basePath%>account/getShopOwnerInfoPage.do?shopId=${shopId}&type=${type}&action=4" style="margin:0 auto;width:100%;height:100%;"></iframe>
          </div>
          <div id="shopAccountInfo" class='tab-pane fade '>
            <iframe name="shopAccountInfoFrame" id="shopAccountInfoFrame" frameborder="0" src="<%=basePath%>account/getShopAccountInfoPage.do?shopId=${shopId}&type=${type}&action=4" style="margin:0 auto;width:100%;height:100%;"></iframe>
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
    $(top.hangge());
    var shopOwnerInfoFrame = document.getElementById("shopOwnerInfoFrame");
    var shopAccountInfoFrame = document.getElementById("shopAccountInfoFrame");
    var bheight = document.documentElement.clientHeight;
    shopOwnerInfoFrame.style.height = (bheight - 110) + 'px';
    shopAccountInfoFrame.style.height = (bheight - 110) + 'px';
     
  </script>
</body>
</html>

