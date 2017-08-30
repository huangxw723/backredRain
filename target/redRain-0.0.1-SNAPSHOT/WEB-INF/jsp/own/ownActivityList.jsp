<%@ page import="com.aoshi.util.PropertyUtils" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
  String path = request.getContextPath();
  String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
  String httpUrl = PropertyUtils.getLOCALHOST_URL();
%>
<!DOCTYPE html>
<html lang="en">
<head>
  <base href="<%=basePath%>">
  <!-- jsp文件头和头部 -->
  <meta http-equiv="Content-Type" content="text/html; charset=utf-8">

  <meta name="description" content="overview & stats" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <!-- basic styles -->
  <link href="static/css/bootstrap.min.css" rel="stylesheet" />
  <link href="static/css/bootstrap-responsive.min.css" rel="stylesheet" />
  <link rel="stylesheet" href="static/css/font-awesome.min.css" />
  <!-- page specific plugin styles -->
  <!-- 下拉框-->
  <link rel="stylesheet" href="static/css/chosen.css" />
  <!-- ace styles -->
  <link rel="stylesheet" href="static/css/ace.min.css" />
  <link rel="stylesheet" href="static/css/ace-responsive.min.css" />
  <link rel="stylesheet" href="static/css/ace-skins.min.css" />
  <script type="text/javascript" src="static/js/jquery-1.7.2.js"></script>
  <!--<link rel="stylesheet" href="static/css/datepicker.css" />--><!-- 日期框 -->
  <link rel="stylesheet" href="static/css/bootstrap-datetimepicker.min.css" /><!-- 日期框 -->
  <!--引入弹窗组件start-->
  <script type="text/javascript" src="plugins/attention/zDialog/zDrag.js"></script>
  <script type="text/javascript" src="plugins/attention/zDialog/zDialog.js"></script>
  <!--引入弹窗组件end-->
  <script type="text/javascript" src="static/js/jquery.tips.js"></script>
</head>
<body>

<div class="container-fluid" id="main-container">


  <div id="page-content" class="clearfix">

    <div class="row-fluid">


      <div class="row-fluid">

        <!-- 查询  -->
        <form action="ownActivity/ownActivityList.do" method="post" name="usersForm" id="usersForm">
          <input type="hidden" name="currentPage" id="currentPage" value="${page.currentPage}"/>
          <input type="hidden" name="showCount" id="showCount" value="${page.showCount}"/>
          <table>
            <tr>
              <td>
                  <span class="input-icon">
                   <input autocomplete="off" id="nav-search-input" type="text" name="activityName" value="${asOwnActivity.activityName}" placeholder="活动名称<c:if test="${isShop == 0}">/商户名称</c:if>"  style="width:220px;"/>
                       <i class="icon-search"></i>
				 </span>
                <span class="input-icon">
								活动时间:&nbsp;<input id="startTime" type='text'  name="startTime"  value="${asOwnActivity.startTime}" class="date-picker" placeholder="开始时间" data-date-format="yyyy-mm-dd hh:ii:ss " >
								</span>

                <span class="input-icon">
								至&nbsp;<input id="endTime" type='text'  name="endTime" value="${asOwnActivity.endTime}" class="date-picker" placeholder="结束时间" data-date-format="yyyy-mm-dd hh:ii:ss" >
							  </span>
              </td>
              <td style="vertical-align: top;">
                &nbsp;
                <button class="btn btn-mini btn-light" onclick="search();"
                        title="查询">
                  <i id="nav-search-icon" class="icon-search"></i>
                </button>
              </td>
            </tr>
          </table>
        </form>


        <table id="table_report" class="table table-striped table-bordered table-hover">

          <thead>
          <tr>

            <th style="text-align:center;">活动名称</th>
            <th style="text-align:center;">商户名称</th>
            <th style="text-align:center;">开始时间</th>
            <th style="text-align:center;">结束时间</th>
            <th style="text-align:center;">活动链接</th>
            <th style="text-align:center;">操作</th>
          </tr>
          </thead>

          <tbody>

          <!-- 开始循环 -->
          <c:choose>
            <c:when test="${not empty list}">
              <c:forEach items="${list}" var="var" varStatus="vs">

                <tr>

                  <td class='center' style="text-align:center;">${var.activityName}</td>
                  <td class='center' style="text-align:center;">${var.shopName}</td>
                  <td class='center' style="text-align:center;">${var.startTime}</td>
                  <td class='center' style="text-align:center;">${var.endTime}</td>
                  <td class='center' style="text-align:center;"><%=httpUrl%>${var.activityLink}</td>
                  <td class='center'  style="text-align:center;">
                    <a href="javascript:void(0);" onclick="copyToClipboard('<%=httpUrl%>${var.activityLink}')">复制链接</a>
                  </td>
                </tr>

              </c:forEach>



            </c:when>
            <c:otherwise>
              <tr class="main_info">
                <td colspan="10" class="center">没有相关数据<a style="text-decoration: none;cursor:pointer" onclick="fresh()">刷新</a></td>
              </tr>
            </c:otherwise>
          </c:choose>


          </tbody>
        </table>

        <div class="page-header position-relative">
          <table style="width: 100%;">
            <tr>
              <td style="vertical-align: top;">
                <div class="pagination"
                     style="float: right; padding-top: 0px; margin-top: 0px;">${page.pageStr}</div>
              </td>
            </tr>
          </table>
        </div>

      </div>




      <!-- PAGE CONTENT ENDS HERE -->
    </div><!--/row-->

  </div><!--/#page-content-->
</div><!--/.fluid-container#main-container-->

<!-- 返回顶部  -->
<a href="#" id="btn-scroll-up" class="btn btn-small btn-inverse">
  <i class="icon-double-angle-up icon-only"></i>
</a>

<!-- 引入 -->
<script type="text/javascript">window.jQuery || document.write("<script src='static/js/jquery-1.9.1.min.js'>\x3C/script>");</script>
<script src="static/js/bootstrap.min.js"></script>
<script src="static/js/ace-elements.min.js"></script>
<script src="static/js/ace.min.js"></script>

<script type="text/javascript" src="static/js/chosen.jquery.min.js"></script><!-- 下拉框 -->
<!-- <script type="text/javascript" src="static/js/bootstrap-datepicker.min.js"></script> --><!-- 日期框 -->
<script type="text/javascript" src="static/js/bootstrap-datetimepicker.js"></script><!-- 日期框 -->
<script type="text/javascript" src="static/js/bootstrap-datetimepicker.zh-CN.js"></script><!-- 日期框 -->
<script type="text/javascript" src="static/js/bootbox.min.js"></script><!-- 确认窗口 -->
<!-- 引入 -->
<script type="text/javascript" src="static/js/jquery.tips.js"></script><!--提示框-->
<link rel="stylesheet" type="text/css" href="plugins/fancyBox/jquery.fancybox.css">
<script type="text/javascript" src="plugins/fancyBox/jquery.fancybox.pack.js"></script>

<script type="text/javascript">

  $(top.hangge());

  //检索
  function search(){
    top.jzts();
    $("#usersForm").submit();
  }


</script>

<script type="text/javascript">

  $(function () {
    //日期框
    //$('.date-picker').datepicker();
    $('#startTime').datetimepicker({
      minuteStep :1,
      language:  'zh-CN',
      autoclose: 1,
      format: "yyyy-mm-dd hh:ii:00",
    }).on('changeDate',function(e){
      var startTime = e.date;
      $('#endTime').datetimepicker('setStartDate',startTime);
    });

    $('#endTime').datetimepicker({
      minuteStep :1,
      language:  'zh-CN',
      autoclose : 1,
      format: "yyyy-mm-dd hh:ii:00",
    }).on('changeDate',function(e){
      var endTime = e.date;
      $('#startTime').datetimepicker('setEndDate',endTime);
    });
  })

  function fresh() {
    setTimeout("self.location=self.location",100);
  }
  function copyToClipboard(link){
    var zhuanpan=link;
    var zhuanpanA = $("<a href='javascript:void(0)'>").text("复制").css("float","right").click(function(){
      var obj = $(this).prev()[0];
      obj.select();
      document.execCommand("copy");
    });
    var link = $("<div>")
            .append($("<div>").append($("<span>").text("自主活动：").after($("<input type='text'>").css("width","80%").attr("value", zhuanpan)).after(zhuanpanA)));
    bootbox.dialog(link,
            [{
              "label" : "关闭",
              "class" : "btn-small btn-success",
              "callback": function() {
              }
            }]
    );
  }
</script>

</body>
</html>

