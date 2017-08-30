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
            <a data-toggle="tab" data-target="#accountInfo" href="javascrpipt:void(0);">
              <i class="green icon-list-alt bigger-150"></i>个人信息
            </a>
          </li>
          <li >
            <a data-toggle="tab" data-target="#accountIntegration" href="javascrpipt:void(0);">
              <i class="red icon-list-alt bigger-150"></i>我的积分
            </a>
          </li>
          <li>
            <a data-toggle="tab" data-target="#accountCapital" href="javascrpipt:void(0);">
              <i class="yellow icon-list-alt bigger-150"></i>我的余额
            </a>
          </li>
            <li>
            <a data-toggle="tab" data-target="#accountBankCard" href="javascrpipt:void(0);">
              <i class="purple icon-list-alt bigger-150"></i>银行卡
            </a>
          </li>
            <li>
            <a data-toggle="tab" data-target="#accountAddress" href="javascrpipt:void(0);">
              <i class="blue icon-list-alt bigger-150"></i>收货地址
            </a>
          </li>
        </ul>
        <div class="tab-content">
          <div id="accountInfo" class='tab-pane fade in active'>
            <iframe name="accountInfoFrame" id="accountInfoFrame" frameborder="0" src="<%=basePath%>account/getAccountInfoList.do?userId=${userId}&view=${view}" style="margin:0 auto;width:100%;height:100%;"></iframe>
          </div>
          <div id="accountIntegration" class='tab-pane fade '>
            <iframe name="accountIntegrationFrame" id="accountIntegrationFrame" frameborder="0" src="<%=basePath%>account/accountIntegrationPage.do?userId=${userId}&view=${view}&action=2" style="margin:0 auto;width:100%;height:100%;"></iframe>
          </div>
          <div id="accountCapital" class="tab-pane fade">
            <iframe name="accountCapitalFrame" id="accountCapitalFrame" frameborder="0" src="<%=basePath%>account/getAccountCapitalList.do?userId=${userId}&view=${view}" style="margin:0 auto;width:100%;height:100%;"></iframe>
          </div>
          <div id="accountBankCard" class="tab-pane fade">
            <iframe name="accountBankCardFrame" id="accountBankCardFrame" frameborder="0" src="<%=basePath%>account/getAccountBankBindList.do?userId=${userId}&view=${view}" style="margin:0 auto;width:100%;height:100%;"></iframe>
          </div>
          <div id="accountAddress" class="tab-pane fade">
            <iframe name="accountAddressFrame" id="accountAddressFrame" frameborder="0" src="<%=basePath%>account/getAccountAddressList.do?userId=${userId}&view=${view}" style="margin:0 auto;width:100%;height:100%;"></iframe>
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
    var accountInfoFrame = document.getElementById("accountInfoFrame");
    var accountIntegrationFrame = document.getElementById("accountIntegrationFrame");
    var accountCapitalFrame = document.getElementById("accountCapitalFrame");
    var accountBankCardFrame = document.getElementById("accountBankCardFrame");
    var accountAddressFrame = document.getElementById("accountAddressFrame");
    var bheight = document.documentElement.clientHeight;
    accountInfoFrame.style.height = (bheight - 110) + 'px';
    accountIntegrationFrame.style.height = (bheight - 110) + 'px';
    accountCapitalFrame.style.height = (bheight - 110) + 'px';
    accountBankCardFrame.style.height = (bheight - 110) + 'px';
    accountAddressFrame.style.height = (bheight - 110) + 'px';
  </script>
</body>
</html>

