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
<%@ include file="../../system/admin/top.jsp"%>

	<meta name="description" content="overview & stats" />
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	<link href="static/css/bootstrap.min.css" rel="stylesheet" />
	<link href="static/css/bootstrap-responsive.min.css" rel="stylesheet" />
	<link rel="stylesheet" href="static/css/font-awesome.min.css" />
	<!-- 下拉框 -->
	<link rel="stylesheet" href="static/css/chosen.css" />
	<link rel="stylesheet" href="static/css/ace.min.css" />
	<link rel="stylesheet" href="static/css/ace-responsive.min.css" />
	<link rel="stylesheet" href="static/css/ace-skins.min.css" />
	<script type="text/javascript" src="static/js/jquery-1.7.2.js"></script>
	<link rel="stylesheet" href="static/css/datepicker.css" /><!-- 日期框 -->
	<!--引入弹窗组件start-->
	<script type="text/javascript" src="plugins/attention/zDialog/zDrag.js"></script>
	<script type="text/javascript" src="plugins/attention/zDialog/zDialog.js"></script>
	<!--引入弹窗组件end-->
	<!--提示框-->
	<script type="text/javascript" src="static/js/jquery.tips.js"></script>
	<script type="text/javascript" src="static/js/common/commonutils.js"></script>

<script type="text/javascript">

	//保存 做验证的
	function save(status) {
		if ($("#dictCode").val() == "") {
			$("#dictCode").tips({
				side : 3,
				msg : '输入字典码',
				bg : '#AE81FF',
				time : 2
			});
			$("#dictCode").focus();
			return false;
		}
		if ($("#dictValue").val() == "") {
			$("#dictValue").tips({
				side : 3,
				msg : '输入字典值',
				bg : '#AE81FF',
				time : 2
			});
			$("#dictValue").focus();
			return false;
		}
		
		if ($("#remark").val() == "") {
			$("#remark").tips({
				side : 3,
				msg : '输入备注',
				bg : '#AE81FF',
				time : 2
			});
			$("#remark").focus();
			return false;
		}

		$("#form").submit();
		$("#zhongxin").hide();
		$("#zhongxin2").show();
	}
</script>
</head>
<body>  
    <form class="form-horizontal" id="form" name="form" action="couponDistance/saveEdit.do" method="post">
    <input type="hidden" name="dictParamId" id="dictParamId" value="${obj.dictParamId}" />
    <input type="hidden" name="createTime" id="createTime" value="${obj.createTime}" />
    
    <div id="zhongxin">
      <table id="table_report" class="table table-striped table-bordered table-hover">
     <%--  <tr>
          <th>字典码:</th>
          <td>
            <input type="text" style="width:90%;" name="dictCode" id="dictCode" value="${obj.dictCode}" placeholder="字典代码" title="字典代码" />
          </td>
        </tr> --%>

         <tr>
          <th>距离(公里):</th>
          <td>
            <input type="text" style="width:90%;" name="dictValue" id="dictValue"  value="${obj.dictValue}"  placeholder="字典值" title="字典值" />
          </td>
        </tr>

        <tr>
          <th>备注:</th>
          <td><textarea placeholder="请输入备注，最多可输入200个字" name="remark" id="remark" value="${obj.remark}" style="width: 750px;resize:none;height:100px;">${obj.remark}</textarea></td>
       	</tr>
 
        
        <tr>
          <td class="center" colspan="2">
            <a class="btn btn-mini btn-primary" onclick="save(2);">立即发布</a>
            <a class="btn btn-mini btn-primary" onclick="save(1);">保存为草稿</a>
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
  
	<script type="text/javascript">window.jQuery || document.write("<script src='static/js/jquery-1.9.1.min.js'>\x3C/script>");</script>
	<script src="static/js/bootstrap.min.js"></script>
	<script src="static/js/ace-elements.min.js"></script>
	<script src="static/js/ace.min.js"></script>
	
	<script type="text/javascript" src="static/js/bootstrap-datepicker.min.js"></script><!-- 日期框 -->
	<script type="text/javascript" src="static/js/chosen.jquery.min.js"></script><!-- 下拉框 -->
	<!-- <script type="text/javascript" src="static/js/bootbox.min.js"></script> --><!-- 确认窗口 -->
	<script type="text/javascript" src="static/js/base64.js"></script>
	<!-- 压缩图片 -->
	<link rel="stylesheet" type="text/css" href="plugins/fancyBox/jquery.fancybox.css">
	<script type="text/javascript" src="plugins/fancyBox/jquery.fancybox.pack.js"></script>
	<!-- 查看图片 -->

  <script type="text/javascript">
	$(function() {
		//单选框
		$(".chzn-select").chosen(); 
		$(".chzn-select-deselect").chosen({allow_single_deselect:true}); 
	});
	
	//验证
	$("#dictCode").blur(function(){	
		var title = $('#dictCode').val();
		if(title.length>100){
			$("#dictCode").tips({
				side:3,
	            msg:'不能超过100！',
	            bg:'#AE81FF',
	            time:2
	        });
			$("#dictCode").focus();
			return false;
		}
	});
	
	$("#dictValue").blur(function(){	
		var title = $('#dictValue').val();
		if(title.length>100){
			$("#dictValue").tips({
				side:3,
	            msg:'不能超过100！',
	            bg:'#AE81FF',
	            time:2
	        });
			$("#dictValue").focus();
			return false;
		}
	});
	
	  $("#remark").blur(function(){
	        var content = $('#remark').val();
	        if(remark.length>200){
	            $("#remark").tips({
	                side:3,
	                msg:'备注不能超过200个字！',
	                bg:'#AE81FF',
	                time:2
	            });
	            $("#remark").focus();
	            return false;
	        }
	    });
    </script>
    
  <script type="text/javascript" src="http://api.map.baidu.com/api?v=2.0&ak=jGRH9RCPqXgfsrr2jyMLzhk1jKactdvj"></script>
  <style type="text/css">
    #l-map{height:200px;width:90%;}
    #r-result{width:100%;}
  </style>


</body>
</html>