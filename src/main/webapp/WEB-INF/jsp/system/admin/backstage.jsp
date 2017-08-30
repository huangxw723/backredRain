<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>后台</title>
<!-- Bootstrap -->
<link href="static/backstage/css/bootstrap.min.css" rel="stylesheet">
<link href="static/backstage/css/main.css" rel="stylesheet">
<link href="static/backstage/css/base.css" rel="stylesheet">
<link rel="stylesheet" href="static/backstage/font-awesome/css/font-awesome.min.css">
<script src="static/backstage/js/jquery.min.js"></script>
<script src="static/backstage/js/bootstrap.min.js"></script>
<script src="static/backstage/js/jquery.bootstrap-dropdown-hover.min.js"></script>
<script src="static/backstage/js/lib.js"></script>
<script src="static/js/myjs/head.js"></script>
<script src="static/js/ace-elements.min.js"></script>
</head>
<body>

    <c:choose>
      <c:when test="${isRoomAdmin eq true}">
      <div id="main1">
          <div class="bt">
          <div class="bt-1">
            <a href="javascript:void(0)" onclick="openMenu('lm${a.MENU_ID }')">
              <img src="static/static/images/bt/iconfont-01.png" alt="">
              <h3>大转盘</h3>
            </a>
          </div>
          <div class="bt-2">
            <ul>
              <li>
                <a href="javascript:void(0)" onclick="openMenu('lm${b.MENU_ID }')">
                  <img src="static/images/bt/iconfont-08.png" alt="">
                  <h3>摇一摇</h3>
                </a>
              </li>
              <li>
                <a href="javascript:void(0)" onclick="openMenu('lm${c.MENU_ID }')">
                  <img src="static/images/bt/iconfont-02.png" alt="">
                  <h3>积分商城</h3>
                </a>
              </li>
              <li>
                <a href="javascript:void(0)" onclick="openMenu('lm${d.MENU_ID }')">
                  <img src="static/images/bt/iconfont-04.png" alt="">
                  <h3>资讯管理</h3>
                </a>
              </li>
            </ul>
          </div>
          <div class="bt-3">
            <ul>
              <li>
                <a href="javascript:void(0)" onclick="openMenu('lm${e.MENU_ID }')">
                  <img src="static/images/bt/iconfont-05.png" alt="">
                  <h3>优惠券</h3>
                </a>
              </li>
              <li>
                <a href="javascript:void(0)" onclick="openMenu('lm${f.MENU_ID }')">
                  <img src="static/images/bt/iconfont-06.png" alt="">
                  <h3>平台活动</h3>
                </a>
              </li>
              <li>
                <a href="javascript:void(0)" onclick="openMenu('lm${g.MENU_ID }')">
                  <img src="static/images/bt/iconfont-07.png" alt="">
                  <h3>会员管理</h3>
                </a>
              </li>
            </ul>
          </div>
          <div class="bt-4">
            <ul>
              <li>
                <a href="javascript:void(0)" onclick="openMenu('lm${h.MENU_ID }')">
                  <img src="static/images/bt/iconfont-03.png" alt="">
                  <h3>链接管理</h3>
                </a>
              </li>
              <li>
                <a href="javascript:void(0)" onclick="openMenu('lm${i.MENU_ID }')">
                  <img src="static/images/bt/iconfont-09.png" alt="">
                  <h3>系统管理</h3>
                </a>
              </li>
              <li>
                <a href="javascript:void(0)" onclick="openMenu('lm${j.MENU_ID }')">
                  <img src="static/images/bt/iconfont-10.png" alt="">
                  <h3>导航管理</h3>
                </a>
              </li>
              <li>
                <a href="javascript:void(0)" onclick="openMenu('lm${k.MENU_ID }')">
                  <img src="static/images/bt/iconfont-11.png" alt="">
                  <h3>基础管理</h3>
                </a>
              </li>
              <li>
                <a href="javascript:void(0)" onclick="openMenu('lm${l.MENU_ID }')">
                  <img src="static/images/bt/iconfont-12.png" alt="">
                  <h3>资料审核</h3>
                </a>
              </li>
            </ul>
          </div>
        </div>
      </div>
      </c:when>
      <c:otherwise>
        <div id="main2">
          <div class="bt2">
          <div class="bt-22">
            <ul>
              <li>
                <a href="javascript:void(0)" onclick="openMenu('lm${a.MENU_ID }')">
                  <img src="static/images/bt/iconfont-08.png" alt="">
                  <c:if test="${shake eq true}">
                    <h3>摇一摇</h3>
                  </c:if>
                  <c:if test="${shake eq false}">
                   <h3>商户管理</h3>
                  </c:if>
                </a>
              </li>
              <li>
                <a href="javascript:void(0)" onclick="openMenu('lm${b.MENU_ID }')">
                  <img src="static/images/bt/iconfont-01.png" alt="">
                  <h3>大转盘</h3>
                </a>
              </li>
              <li>
                <a href="javascript:void(0)" onclick="openMenu('lm${c.MENU_ID }')">
                  <img src="static/images/bt/iconfont-05.png" alt="">
                  <h3>优惠券</h3>
                </a>
              </li>
            </ul>
          </div>
          <div class="bt-33">
            <ul>
              <li>
                <a href="javascript:void(0)" onclick="openMenu('lm${d.MENU_ID }')">
                  <img src="static/images/bt/iconfont-07.png" alt="">
                  <h3>员工管理</h3>
                </a>
              </li>
              <li>
                <a href="javascript:void(0)" onclick="openMenu('lm${e.MENU_ID }')">
                  <img src="static/images/bt/iconfont-03.png" alt="">
                  <h3>链接管理</h3>
                </a>
              </li>
              <li>
                <a href="javascript:void(0)" onclick="openMenu('lm${f.MENU_ID }')">
                  <img src="static/images/bt/iconfont-06.png" alt="">
                  <h3>商户活动</h3>
                </a>
              </li>
            </ul>
          </div>
        </div>
        </div>
      </c:otherwise>
    </c:choose>

  <script type="text/javascript">
  	$(top.hangge());
  </script>
</body>
</html>