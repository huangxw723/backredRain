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
	<%--数字输入框小数点控制--%>
	<script type="text/javascript" src="static/js/common/commonutils.js"></script>

	<style type="text/css">
		#cen{
			text-align: center;
		}
	</style>

</head>

<body>

<div class="container-fluid" id="main-container">


	<div id="page-content" class="clearfix">

		<div class="row-fluid">


			<div class="row-fluid">

				<!-- 查询  -->
				<form action="ownActivity/toAddCount" method="post" name="usersForm" id="usersForm">
					<input type="hidden" id="ownActivityId" name="ownActivityId" value="${ownActivityId}">
					<input type="hidden" id="userId" name="userId" value="${userId}">
					<input type="hidden"  name="shopId" value="${shopId}">
					<table>
						<tr>
							<td>
								<span class="input-icon">
								用户账号:&nbsp;<input id="account" type='text'  name="account"  value="${account}" class="date-picker" placeholder="输入手机号"  >
								</span>

							</td>
							<td style="vertical-align: top;">
								&nbsp;
								<button class="btn btn-mini btn-light" onclick="search();" title="查询">
									<i id="nav-search-icon" class="icon-search"></i>
								</button>
							</td>
							<td style="vertical-align:top;">
								&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
								<span class="input-icon">
								增加抽奖次数:&nbsp;<input id="count" type='number' min="1" onkeyup="validateUtils.replaceNotNumEmpty(this);"  name="count"  value="" class="date-picker" >
								</span>
							</td>

						</tr>
					</table>
				</form>


				<!-- 检索  -->
				<table id="table_report" class="table table-striped table-bordered table-hover" >

					<thead>
					<tr>

						<th style="text-align:center;">账号</th>
						<th style="text-align:center;">用户昵称</th>
						<th style="text-align:center;">抽奖次数</th>
						<th style="text-align:center;">注册时间</th>
					</tr>
					</thead>

					<tbody>

					<!-- 开始循环 -->
					<c:choose>
						<c:when test="${not empty shopUser}">
							<c:forEach items="${shopUser}" var="var" varStatus="vs">

								<tr>
									<td class='center' style="text-align:center;">${var.account}</td>
									<td class='center' style="text-align:center;">${var.nickName}</td>
									<td class='center' style="text-align:center;">${var.count}</td>
									<td class='center' style="text-align:center;">${var.createTime}</td>
								</tr>

							</c:forEach>

						</c:when>
						<c:otherwise>

							<tr class="main_info">
								<td colspan="10" class="center">没有相关数据</td>
							</tr>
						</c:otherwise>
					</c:choose>


					</tbody>
				</table>
				<div class="center" id="do" colspan="2" style="margin-top: 50px">
					<a class="btn btn-mini btn-primary" <c:if test="${userId != null}">onclick="save();"</c:if>>保存</a>&nbsp;&nbsp;&nbsp;&nbsp;
					<a class="btn btn-mini btn-danger" onclick="top.Dialog.close();">取消</a>
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

    //刷新
    function ref(){
        window.location.reload();
    }

    //检索
    function search(){
        top.jzts();
        var account = $("#account").val();
        if(account == ""){
            $("#account").tips({
                side:3,
                msg:'请输入手机号码',
                bg:'#AE81FF',
                time:2
            });
            $("#account").focus();
            return false;
        }
        var form = $("#usersForm");
        form.submit();

    }

    function save(){
        var count = $("#count").val();
        //var ownActivityId = $("#ownActivityId").val();
        if(count == ""){
            $("#count").tips({
                side:3,
                msg:'请输入增加抽奖次数',
                bg:'#AE81FF',
                time:2
            });
            $("#count").focus();
            return false;
        }

        $.ajax({
            type: "POST",
            url: '<%=basePath%>ownActivity/editCount.do',
            data: {count:count,ownActivityId:"${ownActivityId}",userId:"${userId}"},
            dataType:'json',
            cache: false,
            success: function(data){
                if(data == 1){
                    alert("操作成功！");
                    top.Dialog.close();
                }else{
                    alert("操作失败！");
                    top.Dialog.close();
                }
            }
        });

    }

</script>

<script type="text/javascript">


    $(function() {

        //单选框
        $(".chzn-select").chosen();
        $(".chzn-select-deselect").chosen({allow_single_deselect:true});
        //日期框
        //$('.date-picker').datepicker();
        //下拉框
        $(".chzn-select").chosen();
        $(".chzn-select-deselect").chosen({allow_single_deselect:true});

        //复选框
        $('table th input:checkbox').on('click' , function(){
            var that = this;
            $(this).closest('table').find('tr > td:first-child input:checkbox')
                .each(function(){
                    this.checked = that.checked;
                    $(this).closest('tr').toggleClass('selected');
                });

        });

    });
</script>
</body>
</html>

