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
	});
	
	$(function(){
		//日期框
		$('#adStartTime').datepicker().on('changeDate',function(ev){
			  var startTime = ev.date.valueOf();
			  $("#sTime").val(startTime);
			   });
		$('#adEndTime').datepicker().on('changeDate',function(ev){
			  var entt = ev.date.valueOf();
			  $("#eTime").val(entt);
		});
	});
	
	
	
	//更改图片
    function changeImg(){
        $("#fileInput").trigger("click");
    }
	
	//保存
	function save(){
		if($("#versionCode").val()==""||$.trim($("#versionCode").val())==""){
			$("#versionCode").tips({
				side:3,
	            msg:'版本代号',
	            bg:'#AE81FF',
	            time:2
	        });
			$("#versionCode").focus();
			return false;
		}
		if($("#downloadUrl").val()==""||$.trim($("#downloadUrl").val())==""){
			$("#downloadUrl").tips({
				side:3,
	            msg:'下载url',
	            bg:'#AE81FF',
	            time:2
	        });
			$("#downloadUrl").focus();
			return false;
		}
	
		 /* var downloadUrl=$("#downloadUrl").val();
		 var reg=/^([hH][tT]{2}[pP]:\/\/|[hH][tT]{2}[pP][sS]:\/\/)(([A-Za-z0-9-~]+)\.)+([A-Za-z0-9-~\/])+$/;
		 if(!reg.test(downloadUrl)){
		 $("#downloadUrl").tips({
			side:3,
            msg:'格式有误!(如：https://www.baidu.com)',
            bg:'#AE81FF',
            time:2
	        });
			$("#downloadUrl").focus();
			return false;
		 } */
		if($("#remark").val()==""||$.trim($("#remark").val())==""){
			$("#remark").tips({
				side:3,
	            msg:'版本描述',
	            bg:'#AE81FF',
	            time:2
	        });
			$("#remark").focus();
			return false;
		}
		form.submit($('#versionForm'));
	}

</script>
	</head>
<body>

	<form action="version/opera.do" name="versionForm" id="versionForm" method="post">
	<input type="hidden" name="versionId" id="versionId" value="${pd.versionId}"/>
	<input type="hidden" name="action" id="action" value="${action }">
	<div id="zhongxin" >
	<table id="table_report" class="table table-striped table-bordered table-hover" style="overflow:scroll;">
	     <tr height="45px">
			<th>版本号:</th>
			<td><input <c:if test="${action == 4}">disabled="disabled"</c:if> type="text" name="versionCode" id="versionCode" value="${pd.versionCode}" style="width: 370px"/></td>
		</tr>
		<tr>
          <th>平台类型:</th>
          <td>
            <select name="platform" title="是否显示" <c:if test="${action == 4}">disabled="disabled"</c:if>>
              <option value="1" <c:if test="${pd.platform == 1}">selected</c:if>>ios</option>
              <option value="2" <c:if test="${pd.platform == 2 }">selected</c:if>>android</option>
            </select>
          </td>
        </tr>
		<tr>
          <th>是否显示:</th>
          <td>
            <select name="isShow" title="是否显示" <c:if test="${action == 4}">disabled="disabled"</c:if>>
              <option value="1" <c:if test="${pd.isShow == 1 }">selected</c:if>>显示</option>
              <option value="0" <c:if test="${pd.isShow == 0 }">selected</c:if>>不显示</option>
            </select>
          </td>
        </tr>
	   
		<tr height="45px">
			<th>下载url：</th>
			<td><input <c:if test="${action == 4}">disabled="disabled"</c:if> placeholder="如：https://www.baidu.com" type="text" name="downloadUrl" id="downloadUrl" value="${pd.downloadUrl}" style="width: 370px" /></td>
		</tr>
		<tr>
          <th>是否需要更新:</th>
          <td>
            <select name="isUpdate" title="是否显示" <c:if test="${action == 4}">disabled="disabled"</c:if>>
              <option value="0" <c:if test="${pd.isUpdate == 0 }">selected</c:if>>不需要</option>
              <option value="1" <c:if test="${pd.isUpdate == 1 }">selected</c:if>>需要</option>
            </select>
          </td>
        </tr>
        <tr>
          <th>app类型:</th>
          <td>
            <select name="appType" title="是否显示" <c:if test="${action == 4}">disabled="disabled"</c:if>>
              <option value="0" <c:if test="${pd.appType == 0 }">selected</c:if>>一般客户端</option>
              <option value="1" <c:if test="${pd.appType == 1 }">selected</c:if>>员工端</option>
            </select>
          </td>
        </tr>
		
		<tr height="45px">
			<th>备注:</th>
			<td>
				 <textarea <c:if test="${action == 4}">disabled="disabled"</c:if> style="width:90%;height:50px" name="remark" id="remark">${pd.remark}</textarea>
			</td>
		</tr>
         <c:if test="${action != null && action != 4 }">
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
	<script type="text/javascript" src="static/js/chosen.jquery.min.js"></script><!-- 下拉框 -->
	<script type="text/javascript">
	$(top.hangge());

	$(function() {
		
		//单选框
		$(".chzn-select").chosen(); 
		$(".chzn-select-deselect").chosen({allow_single_deselect:true}); 
	});
  </script>
</body>
</html>