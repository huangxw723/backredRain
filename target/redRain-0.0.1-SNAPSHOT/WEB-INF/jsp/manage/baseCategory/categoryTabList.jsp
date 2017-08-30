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
            <a data-toggle="tab" data-target="#district" href="javascrpipt:void(0);">
              <i class="red icon-list-alt bigger-150"></i> 行业标签
            </a>
          </li>
          <li>
            <a data-toggle="tab" data-target="#store" href="javascrpipt:void(0);">
              <i class="red icon-list-alt bigger-150"></i> 模块标签
            </a>
          </li>
          <li>
            <a data-toggle="tab" data-target="#market" href="javascrpipt:void(0);">
              <i class="red icon-list-alt bigger-150"></i> 礼品标签
            </a>
          </li>
          <li>
            <a data-toggle="tab" data-target="#shop" href="javascrpipt:void(0);">
              <i class="red icon-list-alt bigger-150"></i> 优惠券标签
            </a>
          </li>
          <li>
            <a data-toggle="tab" data-target="#shop2" href="javascrpipt:void(0);">
              <i class="red icon-list-alt bigger-150"></i> 商家类型
            </a>
          </li>
          <li>
            <a data-toggle="tab" data-target="#shop3" href="javascrpipt:void(0);">
              <i class="red icon-list-alt bigger-150"></i> 美食类型
            </a>
          </li>
          <li>
            <a data-toggle="tab" data-target="#shop4" href="javascrpipt:void(0);">
              <i class="red icon-list-alt bigger-150"></i> 逛街分类
            </a>
          </li>
        </ul>
        <div class="tab-content">
          <div id="district" class="tab-pane fade in active">                 
            <iframe name="districtFrame" id="districtFrame" src="<%=basePath%>category/categoryList?type=1" frameborder="0"  style="margin:0 auto;width:100%;height:100%;"></iframe>
          </div>
          <div id="store" class="tab-pane fade">
            <iframe name="storeFrame" id="storeFrame" frameborder="0" src="<%=basePath%>category/categoryList?type=2" style="margin:0 auto;width:100%;height:100%;"></iframe>
          </div>
          <div id="market" class="tab-pane fade">
            <iframe name="marketFrame" id="marketFrame" frameborder="0" src="<%=basePath%>category/categoryList?type=3" style="margin:0 auto;width:100%;height:100%;"></iframe>
          </div>
          <div id="shop" class="tab-pane fade">
            <iframe name="shopFrame" id="shopFrame" frameborder="0" src="<%=basePath%>category/categoryList?type=4" style="margin:0 auto;width:100%;height:100%;"></iframe>
          </div>
          <div id="shop2" class="tab-pane fade">
            <iframe name="shop2Frame" id="shop2Frame" frameborder="0" src="<%=basePath%>category/categoryList?type=5" style="margin:0 auto;width:100%;height:100%;"></iframe>
          </div>
          <div id="shop3" class="tab-pane fade">
            <iframe name="shop3Frame" id="shop3Frame" frameborder="0" src="<%=basePath%>category/categoryList?type=6" style="margin:0 auto;width:100%;height:100%;"></iframe>
          </div>
          <div id="shop4" class="tab-pane fade">
            <iframe name="shop4Frame" id="shop4Frame" frameborder="0" src="<%=basePath%>category/categoryList?type=7" style="margin:0 auto;width:100%;height:100%;"></iframe>
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
  	function showStore() {
		$('#myTab a[data-target="#store"]').tab('show');
	}
    $(top.hangge());
    var districtFrame = document.getElementById("districtFrame");
    var storeFrame = document.getElementById("storeFrame");
    var marketFrame = document.getElementById("marketFrame");
    var shopFrame = document.getElementById("shopFrame");
    var shop2Frame = document.getElementById("shop2Frame");
    var shop3Frame = document.getElementById("shop3Frame");
    var shop4Frame = document.getElementById("shop4Frame");

    var bheight = document.documentElement.clientHeight;
    districtFrame.style.height = (bheight - 110) + 'px';
    storeFrame.style.height = (bheight - 110) + 'px';
    marketFrame.style.height = (bheight - 110) + 'px';
    shopFrame.style.height = (bheight - 110) + 'px';
    shop2Frame.style.height = (bheight - 110) + 'px';
    shop3Frame.style.height = (bheight - 110) + 'px';
    shop4Frame.style.height = (bheight - 110) + 'px';
  </script>
</body>
</html>

