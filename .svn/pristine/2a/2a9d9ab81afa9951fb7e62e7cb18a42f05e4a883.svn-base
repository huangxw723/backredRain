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
	<link rel="stylesheet" href="static/css/datepicker.css" /><!-- 日期框 -->
	<!--引入弹窗组件start-->
	<script type="text/javascript" src="plugins/attention/zDialog/zDrag.js"></script>
	<script type="text/javascript" src="plugins/attention/zDialog/zDialog.js"></script>
	<!--引入弹窗组件end-->
	<script type="text/javascript" src="static/js/jquery.tips.js"></script>
</head>
<body>
  <div class="container-fluid" id="main-container">
    <div id="page-content" class="clearfix">
      <div class="tabbable">
        <ul class="nav nav-tabs" id="myTab">
          <li class="active">
            <a data-toggle="tab" data-target="#tab1" myTag="#tab1" href="javascrpipt:void(0);" class="clickEvent">
              <i class="green icon-list-alt bigger-150"></i>活动记录
            </a>
          </li>
          <li>
            <a data-toggle="tab" data-target="#tab2" myTag="#tab2" href="javascrpipt:void(0);" class="clickEvent" url="acitity/receivedHistory">
              <i class="blue icon-list-alt bigger-150"></i>兑换记录
            </a>
          </li>
        </ul>
        
        
        <div class="tab-content">
          <div id="tabWrapper" class="tab-pane fade in active">
            <iframe myFrame name="tab1" id="tab1" frameborder="0" src="acitity/listHistory.do" style="margin:0 auto;width:100%;height:100%;"></iframe>
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
    
    bheight = document.documentElement.clientHeight;
    
    $('#tab1')[0].style.height = (bheight - 110) + 'px';
    $(function(){
    	$(".clickEvent").click(function(){
    		
    		var item = $(this);
    		var itemTargetId = item.attr("data-target");
    		var frameId = itemTargetId.substring(1,itemTargetId.length);
    		if($('#'+frameId).length == 0){
    			
    			var frameSrc = item.attr("url");
        		var height = (bheight - 110);
        		var frameEle = '<iframe myFrame name="'+frameId+'" id="'+frameId+'" frameborder="0" '+
        		'src="'+frameSrc+'" style="margin:0 auto;width:100%;height=100%" height="'+height.toString()+'px"></iframe>';
        		$(frameEle).appendTo($('#tabWrapper'));
    		}
    		
    		$.each($('iframe[myFrame]'),function(i,item){
    			if($(item).attr('id') != frameId){
    				$(item).hide();
    			}else{
    				$(item).show();
    			}
    		})
    	})
    })
  </script>
</body>
</html>

