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

	
	//审核操作
		
		function prizeStatus(id,auditStatus){

		bootbox.confirm("确认通过？", function(result) {
			if(result){			
				if($("#reason").val()=="0-50个字"||$.trim($("#reason").val())==""){					
					$("#reason").val('');			
				}
				if($("#reason").val().length>50){
					$("#reason").tips({
						side:3,
			            msg:'字数不能超过50',
			            bg:'#AE81FF',
			            time:2
			        });
					$("#reason").focus();
					return false;
				}
				
				$("#prizeConfigId").val(parseInt(id));
				$("#auditStatus").val(parseInt(auditStatus))
				$("#auditEditForm").submit();
				$("#zhongxin").hide();
				$("#zhongxin2").show();
				
			}
			
		});
		
	   }

	
	function prizeStatus2(id,auditStatus){

		bootbox.confirm("确认拒绝？", function(result) {
			if(result){
				if($("#reason").val()=="0-50个字"||$.trim($("#reason").val())==""){
					$("#reason").tips({
						side:3,
			            msg:'请填写拒绝理由',
			            bg:'#AE81FF',
			            time:2
			        });
					$("#reason").focus();
					return false;
				}
				if($("#reason").val().length>50){
					$("#reason").tips({
						side:3,
			            msg:'字数不能超过50',
			            bg:'#AE81FF',
			            time:2
			        });
					$("#reason").focus();
					return false;
				}
				$("#prizeConfigId").val(parseInt(id));
				$("#auditStatus").val(parseInt(auditStatus))
				$("#auditEditForm").submit();
				$("#zhongxin").hide();
				$("#zhongxin2").show();
			}
			
		});
		
	}
	
	

    //核审理由文本域显示
    
    $(function(){  
                var t = $('#reason'); //获取到文本域对象  
                t.css("color","#A9A9A9"); //设置文本域的样式  
                t.val("0-50个字"); //设置默认显示文字  
                var default_value = t.val(); //把默认显示的文字赋给一个变量  
                  
                t.focus(function() {  //当鼠标点击文本域时修改文本域的样式，判断文本域内的文字是否等于默认值，如果等于就把文本域内设空  
                    t.css("color","black");  
                    if (t.val() == default_value) {  
                        t.val('');  
                    }  
                });  
  
                t.blur(function() { //当文本域失去鼠标焦点时判断文本域中的值是否为空，如果为空就把文本域的值设置为默认显示的文字并修改样式  
                    t.css("color","black");  
                    if (t.val() == '') {  
                        t.val(default_value);  
                        t.css("color","#A9A9A9");  
                    }  
                });  
  
            });  
</script>
	</head>
<body>

	<form action="prizeconfig/prizeStatus.do" name="auditEditForm" id="auditEditForm" method="post">
	<input type="hidden" name="prizeConfigId" id="prizeConfigId" value=""/>	
	<input type="hidden" name="auditStatus" id="auditStatus" value=""/>
	<input type="hidden" name="shopId"  value="${pd.shopId}"/>
	<div id="zhongxin" >
	<table id="table_report" class="table table-striped table-hover" style="overflow:scroll;">
	     <div><h4>处理审批</h4> 审批编号: ${pd.prizeConfigId}</div>
	     </br>
		<tr>
		 <tr height="45px">
			<td>商户编号:</td>
			<td><input  style=" border:0;width:370px" disabled="disabled"  type="text"  value="${pd.shopId}" style="width: 370px" />
		 </td>
		<tr height="45px">
			<td>商户名称：</td>
			<td><input  style=" border:0;width:370px" disabled="disabled"  type="text"   value="${pd.shopName}" style="width: 370px" /></td>
			 
		</tr>
		
		<tr height="45px">
			<td>商户地址：</td>
			<td><input  style=" border:0;width:370px" disabled="disabled"  type="text"  value="${pd.address}" style="width: 370px" /></td>
		</tr>

	
		<tr height="45px">
		    <td>所属活动：</td>
			<td>
			<c:if test="${pd.activityType eq 1}"><input  style=" border:0;width:370px" type="text" disabled="disabled" name="TypeName" id="TypeName" value="大转盘" style="width: 370px" /></c:if>
			<c:if test="${pd.activityType eq 2}"><input  style=" border:0;width:370px" type="text" disabled="disabled" name="TypeName" id="TypeName" value="摇一摇" style="width: 370px" /></c:if>
			<c:if test="${pd.activityType eq 3}"><input  style=" border:0;width:370px" type="text" disabled="disabled" name="TypeName" id="TypeName" value="优惠劵" style="width: 370px" /></c:if>
			</td>
		</tr>
		
			<tr height="45px">
		    <td>礼品类型：</td>
	<td><input  style=" border:0;width:370px" disabled="disabled"  type="text" name="prizeTypeName" id="prizeTypeName" value="${pd.typeName}" style="width: 370px" /></td>
		</tr>
		
		<tr height="45px">
		    
			<td>礼品编号：</td>
			<td><input  style=" border:0;width:370px"  type="text" disabled="disabled" name="sn" id="sn" value="${pd.sn}" style="width: 370px" /></td>
			
		</tr><tr height="45px">

			<td>礼品名称：</td>
			<td><input  style=" border:0;width:370px"  type="text" disabled="disabled" name="name" id="name" value="${pd.name}" style="width: 370px" /></td>

		</tr>
		<tr height="45px">
			<td>发放的数量：</td>
			<td>
			<input  style=" border:0;width:370px" disabled="disabled"  type="text" name="surplusCounts" id="surplusCounts" value="${pd.surplusCounts}" style="width: 370px" />
		</tr>	
		
		<tr height="45px">
			<c:if test="${'折扣券' eq pd.typeName}">
			<td id="td3">折扣力度:</td>
			<td id="td4"><input disabled="disabled"type="text"  value="${pd.price}" style="width: 370px" />折</td>
			</c:if>
			<c:if test="${'代金券' eq pd.typeName}">
				<td id="td3">优惠额度:</td>
				<td id="td4"><input disabled="disabled" type="text"  value="${pd.price}" style="width: 370px" />元</td>
			</c:if>
			<c:if test="${'礼品券' eq pd.typeName}">
				<td id="td3">礼品:</td>
				<td id="td4"><input disabled="disabled" type="text"  value="${pd.price}" style="width: 370px" /></td>
			</c:if>
			<c:if test="${'现金红包' eq pd.typeName}">
				<td id="td3">现金额度:</td>
				<td id="td4"><input disabled="disabled" type="text"value="${pd.price}" style="width: 370px" />元</td>
			</c:if>
			<c:if test="${'积分' eq pd.typeName}">
				<td id="td3">积分值:</td>
				<td id="td4"><input disabled="disabled" type="text"value="${pd.price}" style="width: 370px" />点</td>
			</c:if>
			<c:if test="${'实物礼品' eq pd.typeName}">
				<td id="td3">实物礼品:</td>
				<td id="td4"><input disabled="disabled" type="text"value="${pd.price}" style="width: 370px" /></td>
			</c:if>
		</tr>
		<c:if test="${pd.categoryId != 4}">
			<tr height="45px">
			    <td>使用时间：</td>
				<td ><input  style=" border:0;width:370px"  type="text" disabled="disabled" name="startAndEndTime" id="startAndEndTime" value="${pd.startTime}~${pd.endTime}"  /></td>
			</tr>
		</c:if>
		<tr height="45px">
			<td>有效时间：</td>
			<td ><input  style=" border:0;width:370px"  type="text" disabled="disabled"  value="${pd.activeTime}~${pd.inactiveTime}"  /></td>
		</tr>
		<c:if test="${pd.activityType ne 3}">
			<tr height="45px">
				<td>礼品logo：</td>
				<td >
					<a class="fancybox" href="<%=httpUrl%>${pd.logoUrl}">
						<img src="<%=httpUrl%>${pd.logoUrl}" alt="${pd.logoUrl}" width="80px" height="45px" />
					</a>
				<c:if test="${pd.activityType eq 3}">
						<c:if test="${not empty pd.backUrl}" >
						 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						背景图片：
						<a class="fancybox" href="<%=httpUrl%>${pd.backUrl}">
							<img src="<%=httpUrl%>${pd.backUrl}" alt="${pd.backUrl}" width="80px" height="45px"  />
						</a>
					</c:if>
				</c:if>
				</td>
			</tr>
		 </c:if>
		<tr height="45px">		   
			<td>简介描述：</td>
			<td>
			 <textarea style="width:80%;height:100%" disabled="disabled" name="descp" id="descp">${pd.descp}</textarea>
			</td>
			
		</tr>
			
		<tr height="100px">
			<td>审批理由:</td>
			<td colspan="3">
				 <textarea style="width:80%;height:200px"  name="reason" id="reason">${pd.reason}</textarea>
			</td>
		</tr>
        
		<tr>
          <td colspan="8" style="height: 30px;"> 
               <div style="text-align: center;">
                <a class="btn btn-mini btn-primary" id="a1" onclick="prizeStatus(${pd.prizeConfigId},1);" style="width: 90px; height: 34px; line-height:34px">通过</a>
                 <a class="btn btn-mini btn-primary" onclick="prizeStatus2(${pd.prizeConfigId},2);" style="width: 90px; height: 34px; line-height:34px">拒绝</a>
				<a class="btn btn-mini btn-danger" onclick="top.Dialog.close();" style="width: 90px; height: 34px; line-height:34px">取消</a>
				</div>
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
	<script type="text/javascript" src="static/js/chosen.jquery.min.js"></script><!-- 下拉框 -->
	<script type="text/javascript" src="static/js/bootbox.min.js"></script><!-- 确认窗口 -->
		
	<script type="text/javascript" src="static/js/base64.js"></script>
	<!-- 压缩图片 -->

	<link rel="stylesheet" type="text/css" href="plugins/fancyBox/jquery.fancybox.css">
	<script type="text/javascript" src="plugins/fancyBox/jquery.fancybox.pack.js"></script>
	<!-- 查看图片 -->
	<script type="text/javascript" src="static/js/chosen.jquery.min.js"></script><!-- 下拉框 -->
	<script type="text/javascript">
	$(function() {

		$(".fancybox").fancybox({
            helpers: {
                title: {
                    type: 'inside'
                }
            }
        });
		
	});
	
  </script>
</body>
</html>