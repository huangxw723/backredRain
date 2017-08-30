<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
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
	
	//保存
	function save(){
	
		if($("#name").val()==""||$.trim($("#name").val())==""){
			$("#name").tips({
				side:3,
	            msg:'请填写类型名称',
	            bg:'#AE81FF',
	            time:2
	        });
			$("#name").focus();
			return false;
		}
		form.submit($('#form'));
	}

</script>
	</head>
<body>
	 <form action="category/opera.do" name="form" id="form" method="post">
    <input type="hidden" name="categoryId" id="categoryId" value="${pd.id}" />
    <input type="hidden" name="type" id="type" value="${type}" />
    <input type="hidden" name="action" id="action" value="${action}" />
		<div id="zhongxin">
		<table id="table_report" class="table table-striped table-bordered table-hover">
        <tr>          
          <th>标签类型:</th>
          <td>
              <span>						
				<select  disabled="disabled">
					<option value="1"<c:if test="${type eq 1}">selected="selected"</c:if>>行业标签</option>
					<option value="2"<c:if test="${type eq 2}">selected="selected"</c:if>>模块标签</option>
					<option value="3"<c:if test="${type eq 3}">selected="selected"</c:if>>礼品类型</option>
					<option value="4"<c:if test="${type eq 4}">selected="selected"</c:if>>优惠券标签</option>
					<option value="5"<c:if test="${type eq 5}">selected="selected"</c:if>>商场类型</option>
				</select>
				</span>
          </td>
          </tr>
          <tr>
          	<th>分类名称:</th>
          	<td>
              <span>						
				<input type="text" value="${pd.name}" name="name" id="name">
				</span>
          	</td>
        </tr>
         <tr id="operaArea">
          <td class="center" colspan="2">
            <a class="btn btn-mini btn-primary" onclick="save();">保存</a>
            <a class="btn btn-mini btn-danger" onclick="top.Dialog.close();">取消</a>
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
		<!-- 引入 -->
	<script type="text/javascript">window.jQuery || document.write("<script src='static/js/jquery-1.9.1.min.js'>\x3C/script>");</script>
	<script src="static/js/bootstrap.min.js"></script>
	<script src="static/js/ace-elements.min.js"></script>
	<script src="static/js/ace.min.js"></script>
	<script type="text/javascript" src="static/js/bootstrap-datepicker.min.js"></script><!-- 日期框 -->
	<script type="text/javascript" src="static/js/chosen.jquery.min.js"></script><!-- 下拉框 -->
	<script type="text/javascript" src="static/js/bootbox.min.js"></script><!-- 确认窗口 -->
		
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