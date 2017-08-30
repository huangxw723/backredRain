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
	<link rel="stylesheet" href="static/css/bootstrap-datetimepicker.min.css" /><!-- 日期框 -->
	<!--引入弹窗组件start-->
	<script type="text/javascript" src="plugins/attention/zDialog/zDrag.js"></script>
	<script type="text/javascript" src="plugins/attention/zDialog/zDialog.js"></script>
	<!--引入弹窗组件end-->
	<!--提示框-->
	<script type="text/javascript" src="static/js/jquery.tips.js"></script>
	<script type="text/javascript" src="static/js/common/commonutils.js"></script>
	<!-- 引入 图片预览功能 -->
	<link rel="stylesheet" type="text/css" href="plugins/fancyBox/jquery.fancybox.css">
	<script type="text/javascript" src="plugins/fancyBox/jquery.fancybox.pack.js"></script>
	<!--提示框-->
	<script type="text/javascript" src="static/js/common/commonutils.js"></script>
	<script type="text/javascript" src="static/js/dateFormat.js"></script><!--日期格式化 -->
	<script type="text/javascript" src="static/js/bootstrap-datetimepicker.js"></script><!-- 日期框 -->
	<script type="text/javascript" src="static/js/bootstrap-datetimepicker.zh-CN.js"></script><!-- 日期框 -->
	
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
	//保存
	function save(){

			//验证
		var activityName = $('#activityName').val();
		if(activityName == ""){
			$("#activityName").tips({
				side:3,
	            msg:'活动名称不能为空！',
	            bg:'#AE81FF',
	            time:2
	        });
			$("#activityName").focus();
			return false;
		}
		
		if(activityName.length<2 || activityName.length>10){
			$("#activityName").tips({
				side:3,
	            msg:'2~10个字',
	            bg:'#AE81FF',
	            time:2
	        });

			$("#activityName").focus();
			return false;
		}
		var pattern = new RegExp(/^\"|\"|\'|\'$/g);
		var b = pattern.test(activityName);
		if(b){
			$("#activityName").tips({
				side:3,
				msg:'名称中不能包含英语的双引号或单引号',
				bg:'#AE81FF',
				time:2
			});
			$("#activityName").focus();
			return false;
		}

		var perCount = $('#perCount').val();
		if(perCount == ""){
			$("#perCount").tips({
				side:3,
	            msg:'参与人数不能为空',
	            bg:'#AE81FF',
	            time:2
	        });
			$("#perCount").focus();
			return false;
		}
		
		if(perCount < 1){
			$("#perCount").tips({
				side:3,
	            msg:'不能小于1次',
	            bg:'#AE81FF',
	            time:2
	        });
			$("#perCount").focus();
			return false;
		}

		//当前系统时间
		var nowDateTime = new Date();
		//开始结束时间
		var endTime = $('#endTime').val();
		var startTime = $('#startTime').val();
		var  st= new Date(startTime);
		var  et= new Date(endTime);

		if(validateUtils.isEmpty(startTime)){
			$("#startTime").tips({
				side:3,
				msg:'请填写开始时间',
				bg:'#AE81FF',
				time:2
			});
			$("#startTime").focus();
			return false;
		}
		if(validateUtils.isEmpty(endTime)){
			$("#endTime").tips({
				side:3,
				msg:'请填写结束时间',
				bg:'#AE81FF',
				time:2
			});
			$("#endTime").focus();
			return false;
		}

		if('${status}' != 1){
			/*if (new Date(st) < new Date(nowDateTime)) {
				$("#startTime").tips({
					side: 3,
					msg: '开始时间必须大于或者等于当前时间',
					bg: '#AE81FF',
					time: 3
				});
				$("#startTime").focus();
				return false;
			}*/

			if (new Date(et) < new Date(nowDateTime)) {
				$("#endTime").tips({
					side: 3,
					msg: '结束时间必须大于当前时间',
					bg: '#AE81FF',
					time: 3
				});
				$("#endTime").focus();
				return false;
			}
			if(et.getTime() <= st.getTime()){
				$("#endTime").tips({
					side:3,
					msg:'结束时间必须大于开始时间',
					bg:'#AE81FF',
					time:3
				});
				$("#endTime").focus();
				return false;
			}
		}

		var flag = true;
		
		//中奖概率
		 $(".probability").each(function(){
			if ($(this).val() == '') {
				$(this).tips({
				side:3,
	            msg:'中奖概率不能为空',
	            bg:'#AE81FF',
	            time:2
	        });
			$(this).focus();
			flag = false;
			return false;
			}
		}); 
		
		
		//礼品池
		$(".prizeConfigId").each(function(){

			if ($(this).attr("giftId") == '') {
				$(this).tips({
				side:3,
	            msg:'礼品不能为空',
	            bg:'#AE81FF',
	            time:2
	        });
			$(this).focus();
			flag = false;
			return false;
			}
		});
		
		 if(flag == false ){
				return ;
			}
		 
		$(".probability").each(function(){
			
			if($(this).val() < 0.01 || $(this).val() > 100){
				$(this).tips({
					side:3,
		            msg:'输入的概率不在限定的范围',
		            bg:'#AE81FF',
		            time:2
		        });
				$(this).focus();
				flag = false;
				return false;
				
				}
			});
		
		if(flag == false ){
			return ;
		}

		/*=================验证=================  */
		
		
		//判断奖品的份数
	 	if($(".probability").length % 2 != 0){
			alert("设置的奖品份数必须为偶数！");
			return;
		}else if($(".probability").length < 6){
			alert("设置的奖品份数不能小于6！");
			return;
		} 
		
		
		//判断奖品的概率
	 	var probability = 0;
		$(".probability").each(function(){
			probability += ($(this).val()*100)/100;
		});
		
		if(probability < 100){
			if(confirm("当前奖品总概率不足100，最后一份奖品将会补全到100")){
				
				 var v = 100 - probability;
				 var lastV = $('.probability:last');
				 
				 $('.probability:last').val((lastV.val()*100)/100 + v) ;
			}
			
		}else if(probability > 100){
			alert("奖品总概率超出100%！");
			return ;
		} 
		
		var pro  = "";
		var pcf  = "";
		var discId = "";
		var count = $('#count').val();
		
		$(".probability").each(function(){
			pro += $(this).val()+",";
		});
		
	
		$(".prizeConfigId").each(function(){
			pcf += $(this).attr("giftId")+",";
		});
		
		$(".delete").each(function(){
			discId += $(this).attr("discId")+",";
		});
		
		
		$('#pro').attr("value",pro);
		$('#pcf').attr("value",pcf);
		$('#discId').attr("value",discId);
		
		form.submit($('#form'));
		 // $('#form').submit();
		 // $("#zhongxin").hide();
		  //$("#zhongxin2").show();
	}
	
	
</script>

	<script type="text/javascript">
	$(function() {
		//失去焦点验证
		$("#activityName").blur(function(){
			var activityName = $('#activityName').val();
					if(activityName.length<2 || activityName.length>10){
						$("#activityName").tips({
							side:3,
				            msg:'2~10个字',
				            bg:'#AE81FF',
				            time:2
				        });
						return false;
					}
			});
			
			$("#perCount").blur(function(){
				var perCount = $('#perCount').val();
				
					if(perCount < 1){
						$("#perCount").tips({
							side:3,
				            msg:'不能小于1次',
				            bg:'#AE81FF',
				            time:2
				        });
						$("#perCount").focus();
						return false;
					}
			});

				$(".probability").blur(function(){
				
					$(".probability").each(function(){
						
					if($(this).val() < 0.01 || $(this).val() > 100){
						$(this).tips({
							side:3,
				            msg:'输入的概率不在限定的范围',
				            bg:'#AE81FF',
				            time:2
				        });
						$(this).focus();
						return false;
						}
					});
				
			});
		
		//日期加上天数得到新的日期  
		//dateTemp 需要参加计算的日期，days要添加的天数，返回新的日期，日期格式：YYYY-MM-DD  
		/*function getNewDay(dateTemp, days) {
		    var dateTemp = dateTemp.split("-");  
		    var nDate = new Date(dateTemp[1] + '-' + dateTemp[2] + '-' + dateTemp[0]); //转换为MM-DD-YYYY格式    
		    var millSeconds = Math.abs(nDate) + (days * 24 * 60 * 60 * 1000);  
		    var rDate = new Date(millSeconds);  
		    var year = rDate.getFullYear();  
		    var month = rDate.getMonth() + 1;  
		    if (month < 10) month = "0" + month;  
		    var date = rDate.getDate();  
		    if (date < 10) date = "0" + date;  
		    return (year + "-" + month + "-" + date);  
		} */
		
		//日期框
		//var st = new Date().toLocaleDateString().replace(new RegExp("/","gm"),"-");
		/*$('#startTime').datetimepicker({
			minuteStep :1,
	        language:  'zh-CN',
			autoclose: 1,
			startDate: new Date(),
	    });
		var d;
		 $('#startTime').datetimepicker().on('changeDate',function(ev){
			 var entt = ev.date.valueOf();
			 var unixTimestamp = new Date(entt);
			var temp = unixTimestamp.format("yyyy-MM-dd");
			var nextTime = getNewDay(temp,4);
			d = $('#endTime').datetimepicker({
				language:  'zh-CN',
				autoclose: 1,
		    	startDate: nextTime,
				});
			d.datetimepicker("setStartDate",nextTime);
			d.datetimepicker("update",nextTime);
		 });*/

		$('#startTime').datetimepicker({
			minuteStep :1,
			language:  'zh-CN',
			autoclose: 1,
			format: "yyyy-mm-dd hh:ii:00",
			startDate: new Date(),
		}).on('changeDate',function(e){
			var startTime = e.date;
			$('#endTime').datetimepicker('setStartDate',startTime);
		});

		$('#endTime').datetimepicker({
			minuteStep :1,
			language:  'zh-CN',
			autoclose : 1,
			format: "yyyy-mm-dd hh:ii:00",
			startDate: new Date(),
		}).on('changeDate',function(e){
			var endTime = e.date;
			$('#startTime').datetimepicker('setEndDate',endTime);
		});
	
		
	});
	 
	</script>
		
</head>
<body>																				
  <form action="ownActivity/edit" name="form" id="form" method="post" enctype="multipart/form-data">
  		<input type="hidden" name="ownActivityId" value="${asOwnActivity.ownActivityId}" > 
  		<input type="hidden" name="shopId" value="${asOwnActivity.shopId}" >
  		<input type="hidden" name="pro" value="" id="pro">
  		<input type="hidden" name="pcf" value="" id="pcf"> 
  		<input type="hidden" name="discId" value="" id="discId"> 
  		<input type="hidden" name="status" value="${status}" id="status"> 
  		<input type="hidden" name="count" value="${fn:length(asOwnActivityDiscs)}" id="count">
  		<input type="hidden" name="delete" value="" id="delete"> 
  		
    <div id="zhongxin">
     	 <table id="table_report" class="table table-striped table-bordered table-hover">

			 <tr>
				 <td  width="150px">所属商户</td>
				 <td>
					 <c:choose>
						 <c:when test="${ not empty shopAll}">
							 <select class="chzn-select"  id="shopId" disabled="disabled" style="width: 383px; vertical-align:top;" >
								 <c:forEach items="${shopAll}" var="var"  >
									 <option value="${var.shopId}" <c:if test="${var.shopId == asOwnActivity.shopId}">selected="selected"</c:if> >${var.name}</option>
								 </c:forEach>
							 </select>
						 </c:when>
						 <c:otherwise>
							 <select class="chzn-select"   id="shopId" disabled="disabled" style="width: 383px; vertical-align:top;">
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
        	<td><input type="number" name="perCount"  value="${asOwnActivity.perCount}" placeholder="每天/每人参与次数" style="width: 370px; vertical-align:top;" id="perCount" onkeyup="validateUtils.replaceNotNumEmpty(this);"></td>
        </tr>
        <tr>
        	<td width="160px">活动时间</td>
    	    <td>	
				 <input name="startTime" type="text" data-date-format="yyyy-mm-dd hh:ii:00"  style="width: 206px" id="startTime" value="${asOwnActivity.startTime }" readonly="readonly" placeholder="开始时间" class="span10 date-picker" >
				<!-- <span class="add-on"><i class="icon-calendar"></i></span> -->
				<span><font style="font-size: 18px;">至</font></span>
				<input  name="endTime" type="text" data-date-format="yyyy-mm-dd hh:ii:00" style="width: 206px" id="endTime" value="${asOwnActivity.endTime }" readonly="readonly" placeholder="结束时间" class="span10 date-picker"  >
				<!-- <span class="add-on"><i class="icon-calendar"></i></span> -->
		    </td>
        </tr>
      </table>
      
      	<div id="box" >
        	<span style="font-size: 18px">选择礼品</span>
	        <div class="gift">
	        	<c:forEach items="${asOwnActivityDiscs}" var="disc">
	        		<div class="body">
		        		<font style="font-size: 18px">中奖几率(%)：</font><input type="number" name="probability" class="probability " value="${disc.probability}"  placeholder="请输入中奖几率" >
		        			<input type="text" name="prizeConfigId" class="prizeConfigId" value="${disc.prizeConfigId == 0 ?'谢谢参与' :disc.asPrizeConfig.name}" giftId='${disc.prizeConfigId}'>
		        		<a href="javascript:;" class="delete" discId="${disc.ownActivityDiscId }">删除</a>
	        		</div>
	        	</c:forEach>
        	</div>	
        	
        	<div class="end">
        		<a href="javascript:;" class="add" >添加奖品</a>&nbsp;&nbsp;
        		<a href="javascript:;" class="onAdd" >批量添加奖品</a>&nbsp;&nbsp;
        		<a href="javascript:;" class="xiexie">谢谢参与</a>
        	</div>
    </div>
    
    	 <div class="center" id="do" colspan="2" style="margin-top: 50px">
            <a class="btn btn-mini btn-primary" onclick="save();">修改</a>&nbsp;&nbsp;&nbsp;&nbsp;
            <a class="btn btn-mini btn-danger" onclick="top.Dialog.close();">取消</a>
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
//判断用户是否选择了谢谢参与
jQuery(document).ready(function(){
	
	//根据status状态来显示可被编辑的数据 1，已开始；2，未开始；3，已结束
	var status = document.getElementById("status").getAttribute("value");

	if(status == 1 ){
		$("#activityName").attr("disabled", true);
		$("#startTime").attr("disabled", true);
		$("#endTime").attr("disabled", true);
		$(".probability").attr("disabled", true);
		$(".prizeConfigId").attr("disabled", true);
		$('.xiexie').css("display","none");
		$('.add').css("display","none");
		$('.delete').css("display","none");
		$('.onAdd').css("display","none");
		

	}

	
});
</script>

<script type="text/javascript">
	
	//礼品池方法
	window.onload= function () {
			
	    var list = document.getElementById('box');
	    var lis = list.children;
	    var el;
	    var count = document.getElementById('count').getAttribute('value');
	    var del = [];
	    
	    
	    //添加节点
	    function addNode(boxNode){
	    	if(count >= 20){
	    		bootbox.alert("添加礼品不能超过20个！");
	    		return ;
	    	}
	    	var div =  document.createElement('div');
	    	var gift = boxNode.getElementsByClassName('gift')[0];
		    var body = boxNode.getElementsByClassName('body')[0];
		    div.innerHTML = body.innerHTML;
		    div.className = "body";
	    	div.getElementsByClassName('probability')[0].value = '';
	    	div.getElementsByClassName('prizeConfigId')[0].setAttribute("giftId","");
	    	div.getElementsByClassName('prizeConfigId')[0].value = '请选择礼品';
	    	div.getElementsByClassName('delete')[0].setAttribute('discId',0);
	    	gift.appendChild(div);
	    	count++;
		
	    }
	    
	    //删除节点
	    function delNode(boxNode){
	    	if(count <= 6){
	    		bootbox.alert("礼品不能小于6个！");
	    		return ;
	    	}
	    	
	    	var gift = boxNode.parentNode.parentNode.getElementsByClassName('gift')[0];
	    	
		    	var discId = el.getAttribute("discId");
		    	
		    	if (parseInt(discId) > 0) {
		    		del.push(discId);
		    		$('#delete').val(del);
		    		$('#count').val($('#count').val()-1);
		    	}
		    	
	    		count--;
	    		boxNode.parentNode.removeChild(boxNode);
	    }
	    
	    //谢谢参与
	    function xiexieNode(boxNode){
	    	if(count >= 20){
	    		bootbox.alert("添加礼品不能超过20个！");
	    		return ;
	    	}
	    	var div =  document.createElement('div');
	    	var gift = boxNode.getElementsByClassName('gift')[0];
		    var body = boxNode.getElementsByClassName('body')[0];
		    div.innerHTML = body.innerHTML;
		    div.className = "body";
	    	div.getElementsByClassName('probability')[0].value = '';
	    	div.getElementsByClassName('prizeConfigId')[0].value = '谢谢参与';
	    	div.getElementsByClassName('prizeConfigId')[0].setAttribute("giftId","0");
	    	div.getElementsByClassName('delete')[0].setAttribute('discId',0);	
	    	gift.appendChild(div);
	     	count++;
	    	
	    }
	    
	    //选择礼品
	    function choo(boxNode){
	    	if($('#status').val() == 1  ){
	    		return ;
	    	}
			var shopId = $("#shopId").val();
	    	var diag = new top.Dialog();
			diag.Drag=true;
			diag.Title ="选择礼品";
			diag.URL = '<%=basePath%>ownActivity/toGift?status=1&shopId='+shopId;
			diag.Width = 1200;
			diag.Height = 700;
			diag.CancelEvent = function(){ //关闭事件
				diag.close();
			 };
			
			//回调用户选择的礼品参数
			top.Dialog.showPrize = function(prizeConfigId,name) {
				boxNode.getElementsByClassName('prizeConfigId')[0].value = name;
				el.setAttribute("giftId",prizeConfigId);
			}
				diag.show();
	 }
	    
	    //批量添加礼品
	    function onAdd(boxNode){
	    	var diag = new top.Dialog();
			var shopId = $("#shopId").val();
			diag.Drag=true;
			diag.Title ="选择礼品";
			diag.URL = '<%=basePath%>ownActivity/toGift?status=2&shopId='+shopId;
			diag.Width = 1200;
			diag.Height = 700;
			diag.CancelEvent = function(){ //关闭事件
				diag.close();
			 };
			
			
			//批量回调用户选择的礼品参数
			top.Dialog.showPrizes = function(ids,names){
				var id = ids.split(',');
				var name = names.split(',');

				for (var i = 0; i < id.length; i++) {
			    	if(count >= 20){
			    		bootbox.alert("添加礼品不能超过20个！");
			    		return ;
			    	}
			    	var div =  document.createElement('div');
			    	var gift = boxNode.getElementsByClassName('gift')[0];
				    var body = boxNode.getElementsByClassName('body')[0];
				    div.innerHTML = body.innerHTML;
				    div.className = "body";
			    	div.getElementsByClassName('probability')[0].value = '';
			    	div.getElementsByClassName('prizeConfigId')[0].value = name[i];
					div.getElementsByClassName('prizeConfigId')[0].setAttribute("giftId",id[i]);
					div.getElementsByClassName('delete')[0].setAttribute('discId',0);	
			    	gift.appendChild(div);
					count++;
					}
	
			}
				diag.show();
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
                     case 'prizeConfigId':
                    	 choo(el.parentNode);
                     break;
                     case 'onAdd':
                    	 onAdd(el.parentNode.parentNode);
                     break;

                 }

             }
            
        }

      
	}

</script>

<script type="text/javascript">
	
</script>
</body>
</html>