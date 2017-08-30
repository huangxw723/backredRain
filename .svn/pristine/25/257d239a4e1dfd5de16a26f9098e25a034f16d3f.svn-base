<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.aoshi.util.PropertyUtils"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%> 
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
	<!-- 引入 图片预览功能 -->
	<link rel="stylesheet" type="text/css" href="plugins/fancyBox/jquery.fancybox.css">
	<script type="text/javascript" src="plugins/fancyBox/jquery.fancybox.pack.js"></script>
	<!--提示框-->
	<script type="text/javascript" src="static/js/common/commonutils.js"></script>
	
	
	<style type="text/css">
	#box{
		margin-left: 20px;
		}
	.delete{
		margin-left: 15px;
	}	
	</style>
	

<script type="text/javascript">

	$(top.hangge());

	//下拉框
	$(function () {
		$(".chzn-select").chosen();
		$(".chzn-select-deselect").chosen({allow_single_deselect:true});
	})
	//时间控件
	$(document).ready(function(){
		$('.date-picker').datepicker('setStartDate', new Date());
	});

	//保存
	/*function save(){
		
		var pro  = "";
		var pcf  = "";
		$(".probability").each(function(){
			pro += $(this).val()+",";
		});
		$(".prizeConfigId").each(function(){
			pcf += $(this).val()+",";
		});
		
		$('#pro').attr("value",pro);
		$('#pcf').attr("value",pcf);
		
		var gift = document.getElementsByClassName('gift3')[0];
		var num = gift.getAttribute("num");
		
		if(num == 0){
			$('#xie').attr("value",num);
		}*/
		//判断奖品的份数
	/* 	if($(".probability").length % 2 != 0){
			alert("设置的奖品份数必须为偶数！");
			return;
		}else if($(".probability").length < 6){
			alert("设置的奖品份数不能小于6！");
			return;
		} */
		
		//判断奖品的概率
	/* 	var pro = 0;
		$(".probability").each(function(){
			pro += ($(this).val()*100)/100;
		});
		
		if(pro < 100){
			if(confirm("当前奖品总概率不足100，最后一份奖品将会补全到100")){
				
				 var v = 100 - pro;
				 var lastV = $('.probability:last');
				 $('.probability:last').val((lastV.val()*100)/100 + v) ;
			}else{
				return ;
			}
			
		}else if(pro > 100){
			alert("奖品总概率超出100%！");
			return ;
		} */
		
		
		/*$('#form').submit();
		  $("#zhongxin").hide();
		  $("#zhongxin2").show(); 
	}*/
	
	
</script>

</head>
<body>																				
  <form action="ownActivity/save" name="form" id="form" method="post" enctype="multipart/form-data">
  		<input type="hidden" name="pro" value="" id="pro"> 
  		<input type="hidden" name="pcf" value="" id="pcf"> 
  		<input type="hidden" name="xie" value="" id="xie"> 
  		<input type="hidden" name="v" value="${thanks}" id="v"> 
  		<input type="hidden" name="status" value="${status}" id="status"> 
  		<input type="hidden" name="count" value="${fn:length(asOwnActivityDiscs)}" id="count"> 
    <div id="zhongxin">
      <table id="table_report" class="table table-striped table-bordered table-hover">

		  <tr>
			  <td  width="150px">所属商户</td>
			  <td>
				  <c:choose>
					  <c:when test="${ not empty shopAll}">
						  <select class="chzn-select"  name="shopId" id="shopId" style="width: 383px; vertical-align:top;" >
							  <c:forEach items="${shopAll}" var="var"  >
								  <option value="${var.shopId}" <c:if test="${var.shopId == asOwnActivity.shopId}">selected="selected"</c:if> >${var.name}</option>
							  </c:forEach>
						  </select>
					  </c:when>
					  <c:otherwise>
						  <select class="chzn-select"   name="shopId" id="shopId" style="width: 383px; vertical-align:top;">
							  <option value="${asShop.shopId}" <c:if test="${asShop.shopId == asOwnActivity.shopId}">selected="selected"</c:if> >${asShop.name}</option>
						  </select>
					  </c:otherwise>
				  </c:choose>
			  </td>
		  </tr>

       <tr>
        	<td width="160px">活动名称</td>
        	<td><input type="text" name="activityName" id="activityName" placeholder="请输入活动名称" style="width: 370px; vertical-align:top;" value="${asOwnActivity.activityName}"></td>
        </tr> 
        <tr>
        	<td width="160px">每天/每人参与次数</td>
        	<td><input type="number" name="perCount"  value="${asOwnActivity.perCount}" placeholder="每天/每人参与次数" style="width: 370px; vertical-align:top;" id="perCount" disabled="disabled"></td>
        </tr>
        <tr>
        	<td width="160px">活动时间</td>
    	    <td>	
				 <input name="startTime" type="text" data-date-format="yyyy-mm-dd hh:ii:00"  style="width: 206px" id="startTime" value="${asOwnActivity.startTime }" readonly="readonly" placeholder="开始日期" class="span10 date-picker" >
				<!-- <span class="add-on"><i class="icon-calendar"></i></span> -->
				<span><font style="font-size: 18px;">至</font></span>
				<input  name="endTime" type="text" data-date-format="yyyy-mm-dd hh:ii:00" style="width: 206px" id="endTime" value="${asOwnActivity.endTime }" readonly="readonly" placeholder="结束日期" class="span10 date-picker"  >
				<!-- <span class="add-on"><i class="icon-calendar"></i></span> -->
		    </td>
        </tr>
      </table>
      
       <div id="box" >
        	<span style="font-size: 18px">选择礼品</span>
        	<c:forEach items="${asOwnActivityDiscs}" var="disc">
	        	<div class="gift">
        		<div class="body">
	        		<font style="font-size: 18px">中奖几率(%)：</font><input type="number" name="probability" class="probability " value="${disc.probability}"  placeholder="请输入中奖几率" >
	        			<input type="text" name="prizeConfigId" class="prizeConfigId" value="${disc.prizeConfigId == 0 ?'谢谢参与' :disc.asPrizeConfig.name}" giftId='${disc.prizeConfigId}'>
					&nbsp;
					<a href="javascript:;" class="delete" discId="${disc.ownActivityDiscId }">删除</a>
					&nbsp;
					<c:if test="${disc.prizeConfigId != 0}" >
						<a href="javascript:void(0);" onclick="preview(${disc.prizeConfigId})" >查看礼品</a>
					</c:if>
        		</div>
        	</div>	
        	</c:forEach>
	        	<%--<div class ="gift2"></div>--%>
        	<%--<div class="end">
        		<a href="javascript:;" class="add" >添加奖品</a>
        		<a href="javascript:;" class="onAdd" >批量添加奖品</a>
        		<a href="javascript:;" class="xiexie">谢谢参与</a>
        	</div>--%>
      		 </div>
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
<script type="text/javascript" src="static/js/base64Compress.js"></script>
<!-- 压缩图片 -->
<!-- 编辑框-->
<script type="text/javascript" charset="utf-8">window.UEDITOR_HOME_URL = "<%=path%>/plugins/ueditor/";</script>
<script type="text/javascript" charset="utf-8" src="plugins/ueditor/ueditor.config.js"></script>
<script type="text/javascript" charset="utf-8" src="plugins/ueditor/ueditor.all.js"></script>
<!-- 编辑框-->
<link rel="stylesheet" type="text/css" href="plugins/fancyBox/jquery.fancybox.css">
<script type="text/javascript" src="plugins/fancyBox/jquery.fancybox.pack.js"></script>
<!-- 查看图片 -->
<script type="text/javascript" src="static/js/chosen.jquery.min.js"></script><!-- 下拉框 -->

<script type="text/javascript">


	//查看
	function preview(id){
		top.jzts();
		var diag = new top.Dialog();
		diag.Drag=true;
		diag.Title ="礼品详情";
		diag.URL='<%=basePath%>ownGift/toEdit?prizeConfigId='+id+"&action=4";
		diag.Width = 1150;
		diag.Height = 610;
		diag.CancelEvent = function(){ //关闭事件
			diag.close();
		};
		diag.show();
	}


//判断用户是否选择了谢谢参与
jQuery(document).ready(function(){
	
	//根据状态来显示可被编辑的数据
	var status = document.getElementById("status").getAttribute("value");
	
		$("#activityName").attr("disabled", true);
		$("#startTime").attr("disabled", true);
		$("#endTime").attr("disabled", true);
		$("#peopleNum").attr("disabled", true);
		$("#countNum").attr("disabled", true);
		$("#shopId").attr("disabled", true);
		$("#shopId").trigger("liszt:updated");
		$(".probability").attr("disabled", true);
		$(".prizeConfigId").attr("disabled", true);
		$('.xiexie').css("display","none");
		$('.add').css("display","none");
		$('.delete').css("display","none");
		$('.onAdd').css("display","none");
	

/* 	var v = document.getElementById('v').getAttribute('value');
	
		if(v == 0){
		   $('.prizeConfigId:last').prepend("<option value='0' selected='selected'>谢谢参与</option>");
		   
		   var gift3 = document.getElementsByClassName('gift3')[0];
		   	   gift3.setAttribute("num","0");

		   $('.prizeConfigId:last').on("change",function(){

		   		if($('.prizeConfigId:last').val() != 0 ){
			    gift3.setAttribute("num","1");
		   	    
		   	    }else if($('.prizeConfigId:last').val() == 0){
				   	 var num = gift3.getAttribute("num");
			    	
			    	if(num == 0){
			    		alert("已经设置了谢谢参与!");

			    		$('.prizeConfigId:last').val($('.prizeConfigId').val());
			    		return ;
			    	}
			   	    	 gift3.setAttribute("num","0");
		   	}

		 });
	}
	 */
});
</script>

<!-- <script type="text/javascript">
	
	//礼品池方法
	window.onload= function () {
	    var list = document.getElementById('box');
	    var lis = list.children;
	    var el;
	    var count = document.getElementById('count').getAttribute('value');
	    
	    //添加节点
	    function addNode(boxNode){
	    	count++;
	    	if(count >= 20){
	    		alert("添加礼品不能超过20个！");
	    		return ;
	    	}
	    	var div =  document.createElement('div');
	    	var gift = boxNode.getElementsByClassName('gift')[0];
	    	var gift2 = boxNode.getElementsByClassName('gift2')[0];
				div.innerHTML = gift.innerHTML;
				gift2.appendChild(div);
		
	    }
	    
	    //删除节点
	    function delNode(boxNode){
	    	if(count <= 1){
	    		alert("再删就没有了！");
	    		return ;
	    	}
	    	//判断删除的是否是谢谢参与
	    	var thanks = boxNode.parentNode.getElementsByClassName('thanks')[0];
	    	if(typeof(thanks)!="undefined"){
	    		boxNode.parentNode.parentNode.getElementsByClassName('gift3')[0].setAttribute("num","1");
	    	}
	    	boxNode.parentNode.removeChild(boxNode);
	    	count--;
	    }
	    
	    //谢谢参与
	    function xiexieNode(boxNode){
	     		count++;
		    	if(count >= 20){
		    		alert("添加礼品不能超过20个！");
		    		return ;
		    	}
	    	var div =  document.createElement('div');
	    	var gift = boxNode.getElementsByClassName('gift3')[0];
	    	div.className = "body";
	    	var num = gift.getAttribute("num");
	    	if(num == 0){
	    		alert("已经设置了谢谢参与！");
	    		return ;
	    	}
	    	gift.setAttribute("num","0");
	    	div.innerHTML = "<font style='font-size: 18px'>中奖几率：</font><input type='text' name='xiexie' class='probability' />"+
				    		"<font style = 'font-size:18px;margin-left: 20px' class='thanks'>谢谢参与</font>"+
						 "<a href='javascript:;' class='delete'>删除</a>";
						 
			gift.appendChild(div);	
	    }
	    
	    
	    // 遍历每个分享li，绑定事件
        for (var i = 0; i < lis.length; i++) {
             
             lis[i].onclick = function(){

                 el = window.event.srcElement||window.event.target;

                 switch(el.className){
                 
                     case 'add':
                    	 addNode(el.parentNode.parentNode)
                     break;
                     case 'delete':
                    	 delNode(el.parentNode)
                     break;
                     case 'xiexie':
                    	 xiexieNode(el.parentNode.parentNode)
                     break;

                 }

             }
            
        }
	}

</script> -->

<script type="text/javascript">
	
</script>
</body>
</html>