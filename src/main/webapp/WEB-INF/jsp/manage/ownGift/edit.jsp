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
		<link rel="stylesheet" href="static/css/bootstrap-datetimepicker.min.css" /><!-- 日期框 -->
		<!--引入弹窗组件start-->
		<script type="text/javascript" src="plugins/attention/zDialog/zDrag.js"></script>
		<script type="text/javascript" src="plugins/attention/zDialog/zDialog.js"></script>
		<!--引入弹窗组件end-->
		<!--提示框-->
		<script type="text/javascript" src="static/js/jquery.tips.js"></script>
		<script type="text/javascript" src="static/js/common/commonutils.js"></script>
		<!--日期格式化-->
		<script type="text/javascript" src="static/js/dateFormat.js"></script>
		<script type="text/javascript" src="static/js/bootstrap-datetimepicker.js"></script><!-- 日期框 -->
		<script type="text/javascript" src="static/js/bootstrap-datetimepicker.zh-CN.js"></script><!-- 日期框 -->
<style type="text/css">
	#font{
		font-size: 16px;
		padding-top: 15px;
	
	}
</style>
		
<script type="text/javascript">
	
	
	$(function() {
		
		$(".chzn-select").chosen(); 
		$(".chzn-select-deselect").chosen({allow_single_deselect:true}); 
		
		
		//鼠标失焦后验证
		$("#name").blur(function(){
		var name = $('#name').val();
				if(name.length<2 || name.length>10){
					$("#name").tips({
						side:3,
			            msg:'2~10个字',
			            bg:'#AE81FF',
			            time:2
			        });
					return false;
				}
		});
		

		
		
		$("#surplusCounts").blur(function(){
			var surplusCounts = $('#surplusCounts').val();
			
				if(surplusCounts<0 || surplusCounts>9999){
					$("#surplusCounts").tips({
						side:3,
			            msg:'剩余数量:0~9999',
			            bg:'#AE81FF',
			            time:2
			        });
					$("#surplusCounts").focus();
					return false;
				}
				var pattern = new RegExp(/^[0-9][\d]{0,3}$/g);
				var b = pattern.test(surplusCounts);
				if(!b){
					$("#surplusCounts").tips({
						side:3,
			            msg:'请输入整数!',
			            bg:'#AE81FF',
			            time:2
			        });
					$("#surplusCounts").focus();
					return false;
				}
		});
		

		$("#price").blur(function(){
			var price = $('#price').val();
			var oldPrice = "${asPrizeConfig.price}";
			if(!validateUtils.isEmpty(price)){
				if(price != oldPrice){
					var pattern = /^(([1-9]+)|([1-9]+\.?[0-9]{0,1}))$/;
					var b = pattern.test(price);
					if(!b){
						$("#price").tips({
							side:3,
							msg:'请输入格式:1.0~9.9',
							bg:'#AE81FF',
							time:2
						});
						$("#price").focus();
						return false;
					}
				}
			}
		});
		//限制上传的图片
		$("#fileInput").change(function(){
			var butarr = [".bmp",".png",".gif",".jpeg",".jpg"];//数组存放 图片类型
			var value = $("#fileInput").val();
			var arr = value.substr(value.lastIndexOf(".")).toLowerCase();
			if($.inArray(arr, butarr)==-1){

					$("#chImg").tips({
						side : 3,
						msg : '请上传图片格式的文件',
						bg : '#AE81FF',
						time : 2
					});
				//$("#fileInput").val("");
				return false;
			}
		});
		
		$("#descp").blur(function(){
			var descp = $('#descp').val();
			if(descp.length>200){
				$("#descp").tips({
					side:3,
		            msg:'描述不能超过200个字！',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#descp").focus();
				return false;
			}
		});
		
		//礼品类型联动
		$("#categoryId").change(function(){
		     var value =  $("#categoryId").find("option:selected").text();
		     if(value == "折扣券"){
		    	 $("#td3").html("折扣力度:");
		    	 $("#td4").html("");
		    	 $("#td4").html('<input placeholder="1.0~9.9" type="number" min="1.0" max="9.9" step="0.1" name="price" id="price" value="${asPrizeConfig.price}" style="width: 370px" />折');
		     }else if(value == "代金券"){
		    	 $("#td3").html("优惠额度:");
		    	 $("#td4").html("");
		    	 $("#td4").html('<input placeholder="0.01~9999.99" type="number" min="0.01" max="9999.99" name="price" id="vouchers" value="${asPrizeConfig.price}" style="width: 370px" />元');
		     }else if(value == "礼品券"){
		    	 $("#td3").html("");
		    	 $("#td4").html("");
		    	 $("#td4").html('<input type="hidden"  name="price" value="0.00" />');
		     }    	 		
		});

		//初始化时间
		$('#startTime').datetimepicker({
			minuteStep :1,
			language:  'zh-CN',
			autoclose: 1,
			format: "yyyy-mm-dd hh:ii:00",

		}).on('changeDate',function(e){
			var startTime = e.date;
			$('#endTime').datetimepicker('setStartDate',startTime);
		});

		$('#endTime').datetimepicker({
			minuteStep :1,
			language:  'zh-CN',
			autoclose : 1,
			format: "yyyy-mm-dd hh:ii:00",
		}).on('changeDate',function(e){
			var endTime = e.date;
			$('#startTime').datetimepicker('setEndDate',endTime);
		});

		$('#activeTime').datetimepicker({
			minuteStep :1,
			language:  'zh-CN',
			autoclose: 1,
			format: "yyyy-mm-dd hh:ii:00",

		}).on('changeDate',function(e){
			var activeTime = e.date;
			$('#inactiveTime').datetimepicker('setStartDate',activeTime);
		});

		$('#inactiveTime').datetimepicker({
			minuteStep :1,
			language:  'zh-CN',
			autoclose : 1,
			format: "yyyy-mm-dd hh:ii:00",
		}).on('changeDate',function(e){
			var inactiveTime = e.date;
			$('#activeTime').datetimepicker('setEndDate',inactiveTime);
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
				minuteStep :1,
				language:  'zh-CN',
				autoclose: 1,
		    	startDate: nextTime,
				});
			d.datetimepicker("setStartDate",nextTime);
			d.datetimepicker("update",nextTime);
		 });*/
	
		 
		
	});
 
	 
	
	//更改图片
    function changeImg(){
        $("#fileInput").trigger("click");
    }
	
	
	//保存
	function save(){
	
		
		var name = $('#name').val();
		if(name == ""){
			$("#name").tips({
				side:3,
	            msg:'礼品名称不能为空！',
	            bg:'#AE81FF',
	            time:2
	        });
			$("#name").focus();
			return false;
		}
		
		if(name.length<2 || name.length>10){
			$("#name").tips({
				side:3,
	            msg:'2~10个字',
	            bg:'#AE81FF',
	            time:2
	        });
			$("#name").focus();
			return false;
		}

		var surplusCounts = $('#surplusCounts').val();
		
			if(surplusCounts<0 || surplusCounts>9999){
				$("#surplusCounts").tips({
					side:3,
		            msg:'剩余数量:0~9999',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#surplusCounts").focus();
				return false;
			}
			var pattern = new RegExp(/^[0-9][\d]{0,3}$/g);
			var b = pattern.test(surplusCounts);
			if(!b){
				$("#surplusCounts").tips({
					side:3,
		            msg:'请输入整数!',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#surplusCounts").focus();
				return false;
			}

			
			
	
		var categoryId = $('#categoryId').val();
		if(categoryId == ''){
			$("#categoryId").tips({
				side:3,
	            msg:'请选择礼品类型',
	            bg:'#AE81FF',
	            time:2
	        });
			$("#categoryId").focus();
			return false;
		};
		
		var price = $('#price').val();
		if(price == ''){
			$("#price").tips({
				side:3,
	            msg:'折扣额度1~9.9折',
	            bg:'#AE81FF',
	            time:2
	        });
			$("#price").focus();
			return false;
		}

		if(!validateUtils.isEmpty(price)){
			var oldPrice = "${asPrizeConfig.price}";
			if(price != oldPrice){
				var pattern = /^(([1-9]+)|([1-9]+\.?[0-9]{0,1}))$/;
				var b = pattern.test(price);
				if(!b){
					$("#price").tips({
						side:3,
						msg:'请输入格式:1.0~9.9',
						bg:'#AE81FF',
						time:2
					});
					$("#price").focus();
					return false;
				}
			}
		}

		var vouchers = $('#vouchers').val();
		if(vouchers == ''){
			$("#vouchers").tips({
				side:3,
	            msg:'优惠额度0.01~9999.99元',
	            bg:'#AE81FF',
	            time:2
	        });
			$("#vouchers").focus();
			return false;
		}

		if(!validateUtils.isEmpty(vouchers)){
			var pattern = /^(([1-9]+)|([0-9]+\.?[0-9]{0,2}))$/;
			var b = pattern.test(vouchers);
			if(!b){
				$("#vouchers").tips({
					side:3,
					msg:'优惠额度格式: 0.01~9999.99',
					bg:'#AE81FF',
					time:3
				});
				$("#vouchers").focus();
				return false;
			}
		}

		if(price < 1 | price > 10){
			$("#price").tips({
				side:3,
	            msg:'折扣额度1~9.9折',
	            bg:'#AE81FF',
	            time:2
	        });	
			$("#price").focus();
			return false;
		}
	
		if(vouchers < 0.01 | vouchers > 9999.99){
			$("#vouchers").tips({
				side:3,
	            msg:'优惠额度0.01~9999.99元',
	            bg:'#AE81FF',
	            time:2
	        });
			$("#vouchers").focus();
			return false;
		}

		//当前系统时间
		var nowDateTime = new Date();
		//开始结束时间
		var endTime = $('#endTime').val();
		var startTime = $('#startTime').val();
		var  st= new Date(startTime);
		var  et= new Date(endTime);
		//生效失效时间
		var inactiveTime = $('#inactiveTime').val();
		var activeTime = $('#activeTime').val();
		var  at= new Date(activeTime);
		var  it= new Date(inactiveTime);


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


		//生效失效时间判断
		if(validateUtils.isEmpty(activeTime)){
			$("#activeTime").tips({
				side:3,
				msg:'请填写生效时间',
				bg:'#AE81FF',
				time:2
			});
			$("#activeTime").focus();
			return false;
		}
		if(validateUtils.isEmpty(inactiveTime)){
			$("#inactiveTime").tips({
				side:3,
				msg:'请填写失效时间',
				bg:'#AE81FF',
				time:2
			});
			$("#inactiveTime").focus();
			return false;
		}

		/*if (new Date(at) < new Date(nowDateTime)) {
			$("#activeTime").tips({
				side: 3,
				msg: '生效时间必须大于或者等于当前时间',
				bg: '#AE81FF',
				time: 3
			});
			$("#activeTime").focus();
			return false;
		}*/

		if (new Date(it) < new Date(nowDateTime)) {
			$("#inactiveTime").tips({
				side: 3,
				msg: '失效时间必须大于当前时间',
				bg: '#AE81FF',
				time: 3
			});
			$("#inactiveTime").focus();
			return false;
		}
		if(it.getTime() <= at.getTime()){
			$("#inactiveTime").tips({
				side:3,
				msg:'失效时间必须大于生效时间',
				bg:'#AE81FF',
				time:3
			});
			$("#inactiveTime").focus();
			return false;
		}

		var descp = $('#descp').val();
		if(descp.length>200){
			$("#descp").tips({
				side:3,
	            msg:'描述不能超过200个字！',
	            bg:'#AE81FF',
	            time:2
	        });
			$("#descp").focus();
			return false;
		}
		
		var fileData = $('#fileInput').val();
		
			if(fileData != '' ){
				var butarr = [".bmp",".png",".gif",".jpeg",".jpg"];//数组存放 图片类型
				var arr = fileData.substr(fileData.lastIndexOf(".")).toLowerCase();
				if($.inArray(arr, butarr)==-1){
							$("#chImg").tips({
								side : 3,
								msg : '请上传图片格式的文件',
								bg : '#AE81FF',
								time : 2
							});
					return false;
				}
			}

		var categoryName =  $("#categoryId").find("option:selected").text();
		$('#categoryName').val(categoryName);
		var storeId =  $("#shopId").find("option:selected").attr("storeId");
		$("#storeId").val(storeId);
			
		// 提交表单
		  $('#usersForm').submit();

	}

</script>


</head>
<body>

	<form action="ownGift/edit" name="usersForm" id="usersForm" method="post" enctype="multipart/form-data">
	<div id="zhongxin" >
	<table id="table_report" class="table table-striped table-bordered table-hover" style="overflow:scroll;">
		<input type="hidden" name="prizeConfigId" value=${asPrizeConfig.prizeConfigId } >
		<input type="hidden" name="activityType" value=4 >
		<input type="hidden"  value=${status } id="status">
		<input type="hidden"  value=${isShop } id="isShop">
		<input type="hidden" name="auditStatus" value=1 >
		<input type="hidden" name="storeId" id="storeId" />
		<input type="hidden" name="categoryName" id="categoryName" />

		<tr height="20px">
			<td>所属商户:</td>
			<td>
				<c:choose>
					<c:when test="${ not empty shopAll}">
						<select class="chzn-select"  name="shopId" id="shopId" style="width: 383px; vertical-align:top;" >
							<c:forEach items="${shopAll}" var="var"  >
										<option value="${var.shopId}" storeId="${var.storeId}" <c:if test="${var.shopId == asPrizeConfig.shopId}">selected="selected"</c:if> disabled="disabled">${var.name}</option>
							</c:forEach>
						</select>
					</c:when>
					<c:otherwise>
						<select class="chzn-select"   name="shopId" id="shopId" style="width: 383px; vertical-align:top;">
									<option value="${asShop.shopId}" storeId="${asShop.storeId}" <c:if test="${asShop.shopId == asPrizeConfig.shopId}">selected="selected"</c:if>>${asShop.name}</option>
						</select>
					</c:otherwise>
				</c:choose>
			</td>
		</tr>
		<tr height="20px">
			<td>礼品名称:</td>
			<td><input placeholder="2~10个字" type="text" name="name" id="name" value="${asPrizeConfig.name }" style="width: 370px;" disabled="disabled" /></td>
			<td>礼品数量</td>
			<td>总发放数
						<input placeholder="1~9999" type="number" name="counts"  id="counts" value="${asPrizeConfig.counts }"  style="width: 370px" disabled="disabled"/>
				<br>剩余数量
						<input placeholder="0~9999" min="0" max="9999" type="number" name="surplusCounts" id="surplusCounts" value="${asPrizeConfig.surplusCounts }"  style="width: 370px" onkeyup="validateUtils.replaceNotNumEmpty(this);" />
			</td>
		</tr>
		<tr height="20px">
			<td>礼品类型:</td>
			<td>
				<select class="chzn-select" data-placeholder="请选择"   name="categoryId" id="categoryId" style="width: 383px; vertical-align:top;" disabled="disabled">
					<c:if test="${type != null && type != ''}" >
						<c:forEach items="${type}" var="var" >
							<option value="${var.id }"<c:if test="${asPrizeConfig.categoryId==var.id}">selected="selected"</c:if>>${var.name}</option>
						</c:forEach>
					</c:if>
				</select>
			</td>
			<c:if test="${'折扣券' eq asPrizeConfig.asYpBaseCategory.name}">
						<td id="td3">折扣力度:</td>
						<td id="td4"><input placeholder="1.0~9.9" type="number" min="1.0" max="9.9" step="0.1" name="price" id="price" value="${asPrizeConfig.price}" style="width: 370px" disabled="disabled" />折</td>
			</c:if>
			<c:if test="${'代金券' eq  asPrizeConfig.asYpBaseCategory.name}">
						<td id="td3">优惠额度:</td>
						<td id="td4"><input placeholder="0.01~9999.99" type="number" min="0.01" max="9999.99" name="price" id="vouchers" value="${asPrizeConfig.price}" style="width: 370px" disabled="disabled" />元</td>
			</c:if>
			<c:if test="${'礼品券' eq  asPrizeConfig.asYpBaseCategory.name}">
						<td id="td3"></td>
						<td id="td4"></td>
			</c:if>
		</tr>
		
		  <tr>
			<td>开始时间:</td>
			<td><div class="row-fluid input-append date">
					<input name="startTime" type="text" data-date-format="yyyy-mm-dd hh:ii:00" id="startTime" readonly="readonly" placeholder="开始时间" class="span10 date-picker" value="${asPrizeConfig.startTime}">
					<span class="add-on"><i class="icon-calendar"></i></span>
				</div></td>
			<td>结束时间:</td>
			<td><div class="row-fluid input-append date">
					<input  name="endTime" type="text" data-date-format="yyyy-mm-dd hh:ii:00" id="endTime" readonly="readonly" placeholder="结束时间" class="span10 date-picker" value="${asPrizeConfig.endTime}" >
					<span class="add-on"><i class="icon-calendar"></i></span>
				</div></td>
		</tr>
		<tr height="45px">
			<td>生效时间:</td>
			<td><div class="row-fluid input-append date">
				<input  name="activeTime" type="text" data-date-format="yyyy-mm-dd hh:ii:00" id="activeTime" readonly="readonly" placeholder="生效时间" class="span10 date-picker" value="${asPrizeConfig.activeTime}">
				<span class="add-on"><i class="icon-calendar"></i></span>
			</div></td>
			<td>失效时间:</td>
			<td><div class="row-fluid input-append date">
				<input name="inactiveTime" type="text" data-date-format="yyyy-mm-dd hh:ii:00" id="inactiveTime" readonly="readonly" placeholder="失效时间" class="span10 date-picker" value="${asPrizeConfig.inactiveTime}" >
				<span class="add-on"><i class="icon-calendar"></i></span>
			</div></td>
		</tr>
			
          
		<tr height="45px">
			<td>礼品logo:</td>
			<td>
				<c:if test="${asPrizeConfig != null && asPrizeConfig.logoUrl != '' && asPrizeConfig.logoUrl != null }">
						<a id="imgBox" class="has" href="<%=httpUrl%>${asPrizeConfig.logoUrl}" title="">
							<img src="<%=httpUrl%>${asPrizeConfig.logoUrl}" alt="${asPrizeConfig.logoUrl}" width="150" id="imgHref" />
						</a>
							<%--<input type="button" class="btn btn-mini btn-danger" value="更改" onclick="changeImg()" id="chImg" />--%>
							<input type="file" id="fileInput" name="file" style="display:none;" />
				</c:if>
	            <input id="url" name="img" type="hidden" />
	            <div id='font'><font style="color: #ff0000;">注：(图片尺寸规格340px * 340px)</font></div>
            </td>
			<td>描述:</td>
			<td><textarea  placeholder="0~200个字" name="descp" id="descp" style="width: 400px;resize:none;height:200px;" disabled="disabled" >${asPrizeConfig.descp }</textarea></td>
		</tr>
		<c:if test="${action != 4}">
			<tr id="operaArea">
				<td style="text-align: center;" colspan="4">
	                <a class="btn btn-mini btn-primary" onclick="save();">保存</a>&nbsp;&nbsp;&nbsp;&nbsp;
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
	
	jQuery(document).ready(function(){
		
		//根据状态来显示可被编辑的数据

		if('${action }' == 4){
			$("#surplusCounts").attr("disabled", true);
			$("#startTime").attr("disabled", true);
			$("#endTime").attr("disabled", true);
			$("#activeTime").attr("disabled", true);
			$("#inactiveTime").attr("disabled", true);
			//document.getElementById("operaArea").style.display = "none";
		}
	});
	
	
	</script>
	
	<script type="text/javascript">
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