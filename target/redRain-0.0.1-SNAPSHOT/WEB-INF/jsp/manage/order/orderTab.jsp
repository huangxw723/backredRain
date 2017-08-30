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
          <li <c:if test="${pd.tab != 'goods' }">class="active"</c:if>>
            <a data-toggle="tab" data-target="#orderEdit" href="javascrpipt:void(0);">
              <i class="green icon-list-alt bigger-150"></i>订单信息
            </a>
          </li>
          <li <c:if test="${pd.tab == 'goods' }">class="active"</c:if>>
            <a data-toggle="tab" data-target="#orderGoods" href="javascrpipt:void(0);">
              <i class="red icon-list-alt bigger-150"></i>订单商品
            </a>
          </li>
          <li>
            <a data-toggle="tab" data-target="#orderAction" href="javascrpipt:void(0);">
              <i class="blue icon-list-alt bigger-150"></i>订单操作记录
            </a>
          </li>
        </ul>
        <div class="tab-content">
          <div id="orderEdit" class='tab-pane fade <c:if test="${pd.tab != 'goods' }">in active</c:if>'>
            <iframe name="orderEditFrame" id="orderEditFrame" frameborder="0" src="<%=basePath%>order/goView.do?orderId=${pd.orderId }" style="margin:0 auto;width:100%;height:100%;"></iframe>
          </div>
          <div id="orderGoods" class='tab-pane fade <c:if test="${pd.tab == 'goods' }">in active</c:if>'>
            <iframe name="orderGoodsFrame" id="orderGoodsFrame" frameborder="0" src="<%=basePath%>order/listOrderGoods.do?orderId=${pd.orderId }" style="margin:0 auto;width:100%;height:100%;"></iframe>
          </div>
          <div id="orderAction" class="tab-pane fade">
            <iframe name="orderActionFrame" id="orderActionFrame" frameborder="0" src="<%=basePath%>order/listOrderAction.do?orderId=${pd.orderId }" style="margin:0 auto;width:100%;height:100%;"></iframe>
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
    var orderEditFrame = document.getElementById("orderEditFrame");
    var orderGoodsFrame = document.getElementById("orderGoodsFrame");
    var orderActionFrame = document.getElementById("orderActionFrame");
    var bheight = document.documentElement.clientHeight;
    orderEditFrame.style.height = (bheight - 110) + 'px';
    orderGoodsFrame.style.height = (bheight - 110) + 'px';
    orderActionFrame.style.height = (bheight - 110) + 'px';
  </script>
</body>
</html>

