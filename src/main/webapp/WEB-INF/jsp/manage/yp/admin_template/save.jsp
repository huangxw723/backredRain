<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.aoshi.util.PropertyUtils"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
	String httpUrl = PropertyUtils.getHTTP_URL();
%>
<!DOCTYPE html>
<html lang="en">
	<head>
		<base href="<%=basePath%>">
		<meta charset="utf-8" />
		<title></title>
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
	$(top.hangge());
	
	$(function() {
		$(".chzn-select").chosen(); 
		$(".chzn-select-deselect").chosen({allow_single_deselect:true}); 
		
		var operaResult = '${operaResult}';
		if(operaResult){
			alert(operaResult)
		}
	});
	
	$(function(){
		//日期框
		$('.date-picker').datepicker();
	});
	
	
	
	//更改图片
    function changeImg(){
        $("#fileInput").trigger("click");
    }
	
	//保存
	function save(){
		
		

		
		form.submit($('#usersForm'));
	
		/* $("#usersForm").submit();
		$("#zhongxin").hide();
		$("#zhongxin2").show(); */
	}

</script>
	</head>
<body>

	<form action="yp/admin/template/uploadTemplatePackage" name="usersForm" id="usersForm" method="post">
	<input type="hidden" name="action" id="action" value="${action}"/>
	<input type="hidden" name="close" id="close" value="${pd.userId}"/>
	<div id="zhongxin" >
	<table id="table_report" class="table table-striped table-bordered table-hover" style="overflow:scroll;">
		
		
		
		
		<tr>
			<td>上传模板包:</td>
             <td>
            <c:if test="${pd == null || pd.userHead== '' || pd.userHead == null }">
              <a id="imgBox" href="javascript:void(0)" style="display:none;">
                <img src="" width="150" id="imgHref" style="display:none;"/>
              </a>
              <input type="file" id="fileInput" name="fileInput" />
            </c:if>
            
            <input id="url" name="img" type="hidden" />
          </td> 
		</tr>
		
		<c:if test="${action < 4}">
		<tr id="operaArea">
			<td style="text-align: center;" colspan="2">
                <a class="btn btn-mini btn-primary" onclick="save();">保存</a>
				<a class="btn btn-mini btn-danger" onclick="top.Dialog.close();">取消</a>
			</td>
		</tr>
		</c:if>
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
	<script type="text/javascript" src="static/js/bootstrap-datepicker.min.js"></script><!-- 日期框 -->
	<script type="text/javascript" src="static/js/chosen.jquery.min.js"></script><!-- 下拉框 -->
	<script type="text/javascript" src="static/js/bootbox.min.js"></script><!-- 确认窗口 -->
		
	<script type="text/javascript" src="static/js/base64.js"></script>
	<!-- 压缩图片 -->

	<link rel="stylesheet" type="text/css" href="plugins/fancyBox/jquery.fancybox.css">
	<script type="text/javascript" src="plugins/fancyBox/jquery.fancybox.pack.js"></script>
	<!-- 查看图片 -->
	
	<script type="text/javascript">
	$(top.hangge());
	//上传
	$('#fileInput:visible').ace_file_input({
		no_file : '请选择图片 ...',
		btn_choose : '选择',
		btn_change : '更改',
		droppable : false,
		onchange : null,
		thumbnail : false,
		before_remove : function() {
			$("#url").val("");
			$("#imgBox").attr("href", "").hide();
			$("#imgHref").attr("src", "");
			return true;
		}
	});
	
	new img2base64("fileInput", "url", "imgHref", "imgBox");

	$("#imgBox").fancybox({
		helpers : {
			title : {
				type : 'inside'
			}
		}
	});
  </script>
</body>
</html>