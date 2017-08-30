<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="com.aoshi.util.PropertyUtils"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	String httpUrl = PropertyUtils.getHTTP_URL();
%>
<!DOCTYPE html>
<html lang="en">
<head>
<base href="<%=basePath%>">
<meta charset="utf-8" />
<title></title>
	<%@ include file="../../system/admin/top.jsp" %>
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

<script type="text/javascript" src="static/js/common/commonutils.js"></script>

<script type="text/javascript">

	//保存
	function save(){
		
		var integration = $("#integration").val();
		if(validateUtils.isEmpty(integration)){
			$("#integration").tips({
				side:3,
	            msg:'不能为空',
	            bg:'#AE81FF',
	            time:2
	        });
			$("#integration").focus();
			return false;
		}
		$("#usersForm").submit()
		alert("操作完成");
	}

</script>
</head>
<body>
	<form action="account/accountIntegrationOpera.do" name="usersForm" id="usersForm" method="post">
		<input type="hidden" name="action" id="action" value="${action}"/>
		<input type="hidden" name="userId" id="userId" value="${user.userId}"/>
		<input type="hidden" name="view" id="view" value="${pd.view}"/>
		<div id="">
			<table id="table_report"
				class="table table-striped table-bordered table-hover"
				style="overflow: scroll;">

				<tr height="45px">
					<td style="text-align: center;">我的积分</td>
					<td style="text-align: center;"><input  type="number" min="0" name="integration" <c:if test="${pd.view==4}">disabled="disabled"</c:if>
						id="integration" onkeyup="validateUtils.replaceNotNumEmpty(this);"
						value="${integration}" style="width: 370px;"/>
					</td>
					<td style="text-align: center;">
						<a href="javascript:void(0);" onclick="pointDetail('${user.userId}','${user.account}');">积分明细</a>
						<a href="javascript:void(0);" onclick="exchangeRecord('${user.userId}','${user.account}');">积分兑换记录</a>
					</td>
				</tr>
				<c:if test="${pd.view != 4}">
				<tr id="operaArea">
					<td style="text-align: center;" colspan="3">
						<a class="btn btn-mini btn-primary" onclick="save();">保存</a>
						<a class="btn btn-mini btn-danger" onclick="fresh();">取消</a>
					</td>
				</tr>
				</c:if>
			</table>
		</div>
	</form>

	<!-- 引入 -->
	<script type="text/javascript">window.jQuery || document.write("<script src='static/js/jquery-1.9.1.min.js'>\x3C/script>");</script>
	<script src="static/js/bootstrap.min.js"></script>
	<script src="static/js/ace-elements.min.js"></script>
	<script src="static/js/ace.min.js"></script>
	<script type="text/javascript" src="static/js/chosen.jquery.min.js"></script>
	<!-- 下拉框 -->
	<script type="text/javascript" src="static/js/bootbox.min.js"></script>
	<!-- 确认窗口 -->
	<script type="text/javascript" src="static/js/jquery.tips.js"></script>

	<script type="text/javascript">
	$(top.hangge());

	//刷新
	function fresh() {
		history.go(0);
	}

	//查看积分明细
	function pointDetail(userId,account){
		top.mainFrame.tab.add( {
			id :'accountUserId'+account+userId,
			title :"积分明细-"+account,
			url :'<%=basePath%>account/getPointDetailList.do?userId='+userId+'&account='+account,
			isClosed :true,
			closeFn : function(iframe){
				if(iframe.contents().find("#zhongxin").css('display') == 'none'){
					if(typeof(nextPage) == "function") {
						nextPage(${page.currentPage});
					} else {
						location.reload();
					}
				}
			}
		});
	}

	//查看积分兑换记录
	function exchangeRecord(userId,account){
		top.mainFrame.tab.add( {
			id :'exchangeRecord'+account+userId,
			title :"积分兑换记录-"+account,
			url :'<%=basePath%>account/getExchangeRecordList.do?userId='+userId+'&account='+account,
			isClosed :true,
			closeFn : function(iframe){
				if(iframe.contents().find("#zhongxin").css('display') == 'none'){
					if(typeof(nextPage) == "function") {
						nextPage(${page.currentPage});
					} else {
						location.reload();
					}
				}
			}
		});
	}

  </script>
</body>
</html>