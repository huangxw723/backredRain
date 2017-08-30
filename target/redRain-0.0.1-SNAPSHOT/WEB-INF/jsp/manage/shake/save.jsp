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
		<link rel="stylesheet" href="static/css/bootstrap-datetimepicker.min.css" /><!-- 日期框 -->
		<!-- <link rel="stylesheet" href="static/css/datepicker.css" /> --><!-- 日期框 -->
		<!--引入弹窗组件start-->
		<script type="text/javascript" src="plugins/attention/zDialog/zDrag.js"></script>
		<script type="text/javascript" src="plugins/attention/zDialog/zDialog.js"></script>
		<!--引入弹窗组件end-->
		<!--提示框-->
		<script type="text/javascript" src="static/js/jquery.tips.js"></script>
		<script type="text/javascript" src="static/js/common/commonutils.js"></script>
		<!--日期格式化-->
		<script type="text/javascript" src="static/js/dateFormat.js"></script>
  		
<script type="text/javascript">
	$(top.hangge());
	
	var isExist = false;
	
	$(function() {
		
			$(".chzn-select").chosen(); 
			$(".chzn-select-deselect").chosen({allow_single_deselect:true}); 
			
			var operaResult = '${operaResult}';
			if(operaResult){
				alert(operaResult)
			}
			
			//鼠标失焦后验证
			$("#name").blur(function(){
			var shopId = $("#shopId").val();
			var name = $('#name').val();
			var oldName = "${pd.name}";
			var activityType = '${pd.activityType}';
				if(!validateUtils.isEmpty(name)){
					 
					if(name.length<2 || name.length>10){
						$("#name").tips({
							side:3,
				            msg:'2~10个字',
				            bg:'#AE81FF',
				            time:2
				        });
						return false;
					}
					if(name != oldName){
					$.ajax({
						type: "POST",
						url: '<%=basePath%>prizeconfig/isExist.do',
				    	data: {name:name,shopId:shopId,type:activityType},
						dataType:'json',
						cache: false,
						success: function(data){
							if(data){
								isExist = true;
								$("#name").tips({
									side:3,
						            msg:'该名称已经存在',
						            bg:'#AE81FF',
						            time:2
						        });
								$("#name").focus();
								return false;
							}else{
								isExist = false;
							}
						}
					});
					}
				}
			});
			$("#counts").blur(function(){
				var counts = $('#counts').val();
				if(!validateUtils.isEmpty(counts)){
				
					if(counts<1 || counts>9999){
						$("#counts").tips({
							side:3,
				            msg:'发放数量:1~9999',
				            bg:'#AE81FF',
				            time:2
				        });
						$("#counts").focus();
						return false;
					}
					var pattern = new RegExp(/^[1-9][\d]{0,3}$/g);
					var b = pattern.test(counts);
					if(!b){
						$("#counts").tips({
							side:3,
				            msg:'请输入正整数!',
				            bg:'#AE81FF',
				            time:2
				        });
						$("#counts").focus();
						return false;
					}
				}
			});
			
			
			$("#surplusCounts").blur(function(){
				var surplusCounts = $('#surplusCounts').val();
				if(!validateUtils.isEmpty(surplusCounts)){
					 
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
				            msg:'请输入正整数!',
				            bg:'#AE81FF',
				            time:2
				        });
						$("#surplusCounts").focus();
						return false;
					}
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
			//var curDate = new Date();往后推一天
			//var st = new Date(curDate.getTime() + 24*60*60*1000).toLocaleDateString().replace(new RegExp("/","gm"),"-");
			//日期格式化
			//var st = new Date().toLocaleDateString().replace(new RegExp("/","gm"),"-");
			//$('#startTime').datepicker({
	    	//format: "yyyy-mm-dd",
	    	//startDate: st,
	   		//endDate: "2016-10-23"
			//});
			/*$('#startTime').datetimepicker({
				minuteStep :1,
		        language:  'zh-CN',
				autoclose: 1,
				format: "yyyy-mm-dd hh:ii:00",
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
					format: "yyyy-mm-dd hh:ii:00",
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
			 
			/* if('${pd.activityType}' == 2){
				 var shopId = $("#shopId").val();
				 var shakeId = "${pd.activityShakeId}";
				//异步加载商场中奖级别
				$.post("<%=basePath%>prizeconfig/shake.do?shopId="+shopId,
										function(data,status){
											if(status=="success"){
												$("<option/>").val("")
															.text("请选择")
															.appendTo("#shake");
												$.each(data,function(){
												  $("<option/>").val(this.activityShakeId)
																.text(this.name+" ("+this.probability+"%)")
																.attr("selected",this.activityShakeId ==shakeId)
																.appendTo("#shake");	
												});	
											}else{
												alert("数据加载失败！");
												}
										},"json");
				
	 				$("#shopId").change(function(){
	 					var shopId = $("#shopId").val();
	 					$.post("<%=basePath%>prizeconfig/shake.do?shopId="+shopId,
								function(data,status){
									if(status=="success"){
										$("#shake").html("");
	 									$("<option/>").val("")
												.text("请选择")
												.appendTo("#shake");
										$.each(data,function(){
										  $("<option/>").val(this.activityShakeId)
														.text(this.name+" ("+this.probability+"%)")
														.attr("selected",this.activityShakeId ==shakeId)
														.appendTo("#shake");	
										});	
									}else{
										alert("数据加载失败！");
										}
								},"json");
	 				});
			 	};*/


			 	//选择商户后，异步验证名称
			 	$("#shopId").change(function(){
					var activityType = '${pd.activityType}';
					var shopId = $("#shopId").val();
					var oldShopId = "${pd.shopId}";
					var name = $('#name').val();
					if(shopId != oldShopId){
	 						$.ajax({
	 							type: "POST",
	 							url: '<%=basePath%>prizeconfig/isExist.do',
	 					    	data: {name:name,shopId:shopId,type:activityType},
	 							dataType:'json',
	 							cache: false,
	 							success: function(data){
	 								if(data){
	 									isExist = true;
	 									$("#name").tips({
	 										side:3,
	 							            msg:'该名称已经存在',
	 							            bg:'#AE81FF',
	 							            time:2
	 							        });
	 									$("#name").focus();
	 									return false;
	 								}else{
	 									isExist = false;
	 								}
	 							}
	 						});
			 		}
 				});
				//礼品类型联动
				$("#categoryId").change(function(){
				     var value =  $("#categoryId").find("option:selected").text();
				     if(value == "积分"){
				    	 $("#startTime").attr("disabled",true);
				    	 $("#endTime").attr("disabled",true);
				    	 $("#td3").html("发放积分:");
				    	 $("#td4").html("");
				    	 $("#td4").html('<input <c:if test="${action == 4 || pd.status == 1 || pd.status == 2}">disabled="disabled"</c:if> placeholder="1~9999" type="number" min="1" max="9999" name="price" id="price" value="${pd.price}" style="width: 370px" onkeyup="validateUtils.replaceNotNumEmpty(this);" />点');
				     }else if(value == "实物礼品"){
				    	 $("#startTime").attr("disabled",false);
				    	 $("#endTime").attr("disabled",false);
				    	 $("#td3").html("");
				    	 $("#td4").html("");
				     }else if(value == "现金红包"){
				    	 $("#startTime").val("");
				    	 $("#endTime").val("");
				    	 $("#startTime").attr("disabled",true);
				    	 $("#endTime").attr("disabled",true);
				    	 $("#td3").html("现金额度:");
				    	 $("#td4").html("");
				    	 $("#td4").html('<input <c:if test="${action == 4 || pd.status == 1 || pd.status == 2}">disabled="disabled"</c:if> placeholder="0.01~9999.99" type="number" min="0.01" max="9999.99" name="price" id="price" value="${pd.price}" style="width: 370px" />元');
				     } 		    	 		
				});
				//限制上传的图片
				$("#fileInput").change(function(){
					var butarr = [".bmp",".png",".gif",".jpeg",".jpg"];//数组存放 图片类型
					var value = $("#fileInput").val();
					var arr = value.substr(value.lastIndexOf(".")).toLowerCase();
					if($.inArray(arr, butarr)==-1){
						if("${action}" == 1){
							$("#fileInput").tips({
								side : 3,
								msg : '请上传图片格式的文件',
								bg : '#AE81FF',
								time : 2
							});
						}
						if("${action}" == 2){
							$("#chImg").tips({
								side : 3,
								msg : '请上传图片格式的文件',
								bg : '#AE81FF',
								time : 2
							});
						}
						//$("#fileInput").val("");
						return false;
					}
				});
		});
	 
	
	//更改图片
    function changeImg(){
        $("#fileInput").trigger("click");
    }
	
	
	//保存
	function save(){
		
		if(isExist){
			$("#name").tips({
				side:3,
	            msg:'该名称已经存在',
	            bg:'#AE81FF',
	            time:2
	        });
			$("#name").focus();
			return false;
		}
		
		var name = $('#name').val();
		if(validateUtils.isEmpty(name)){
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
		var pattern = new RegExp(/^\"|\"|\'|\'$/g);
		var b = pattern.test(name);
		if(b){
			$("#name").tips({
				side:3,
				msg:'名称中不能包含英语的双引号或单引号',
				bg:'#AE81FF',
				time:2
			});
			$("#name").focus();
			return false;
		}
		
		var counts = $('#counts').val();
		if(validateUtils.isEmpty(counts)){
			$("#counts").tips({
				side:3,
	            msg:'发放数量1~9999',
	            bg:'#AE81FF',
	            time:2
	        });
			$("#counts").focus();
			return false;
		}
		if('${action}' == 1){
			if(counts<1 || counts>9999){
				$("#counts").tips({
					side:3,
		            msg:'发放数量1~9999',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#counts").focus();
				return false;
			}
		}
		
		if('${action}' == 2 && "${pd.status}" == 1 || '${action}' == 2 && "${pd.status}" == 2 ){
			var surplusCounts = $('#surplusCounts').val();
			if(validateUtils.isEmpty(surplusCounts)){
				$("#surplusCounts").tips({
					side:3,
		            msg:'剩余数量0~9999',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#surplusCounts").focus();
				return false;
			}
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
		}
		
		var shake = $('#shake').val();
		var activityType = '${pd.activityType}';
		if(activityType == 2 && shake == ''){
			$("#shake").tips({
				side:3,
	            msg:'请选择奖品等级',
	            bg:'#AE81FF',
	            time:2
	        });
			$("#shake").focus();
			return false;
		}
		var categoryId = $('#categoryId').val();
		var categoryName =  $("#categoryId").find("option:selected").text();
		var storeId =  $("#shopId").find("option:selected").attr("storeId");
		$("#storeId").val(storeId);
		$('#categoryName').val(categoryName);
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
		if(categoryName != "实物礼品"  ){
			if( "${pd.auditStatus}" == 0 ||  "${pd.auditStatus}" == 2 ){
			var oldPrice = "${pd.price}";
			var price = $('#price').val();
			if(validateUtils.isEmpty(price)){
				$("#price").tips({
					side:3,
		            msg:'请填写额度或积分',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#price").focus();
				return false;
			}
		 
			if(price > 9999 && categoryName == "积分" || price < 1 && categoryName == "积分" ){
				$("#price").tips({
					side:3,
		            msg:'发放积分: 1~9999',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#price").focus();
				return false;
			}
			if(price < 9999 && categoryName == "积分" || price > 1 && categoryName == "积分" ){
				var value = price.split('.')[0];
				$('#price').val(value);
			}
			if(price > 9999.99 && categoryName == "现金红包" || price < 0.01 && categoryName == "现金红包" ){
				$("#price").tips({
					side:3,
		            msg:'现金额度: 0.01~9999.99',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#price").focus();
				return false;
			}
			
			if(price < 9999.99 && categoryName == "现金红包" || price > 0.01 && categoryName == "现金红包" ){
				var pattern = /^(([1-9]+)|([0-9]+\.?[0-9]{0,2}))$/;
				var b = pattern.test(price);
				if(!b){
					$("#price").tips({
						side:3,
			            msg:'现金额度格式: 0.01~9999.99',
			            bg:'#AE81FF',
			            time:3
			        });
					$("#price").focus();
					return false;
				}
			}
			
			}
		}

		//判断是否是大奖
		var isJackpot = '${pd.isJackpot}';
		if(isJackpot ==1){
			var intervalTime = $("#intervalTime").val();
			if(validateUtils.isEmpty(intervalTime)){
				$("#intervalTime").tips({
					side:3,
					msg:'请填写间隔时间',
					bg:'#AE81FF',
					time:2
				});
				$("#intervalTime").focus();
				return false;
			}
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
		
		
		if(categoryName == "实物礼品" && "${action}" == 1 || categoryName == "实物礼品" && "${action}" == 2  ){
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
		}
		if(categoryName == "实物礼品"){
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
		 if('${action}' == 1){
			 if(fileData == ''){
			 $("#fileInput").tips({
				side:3,
	            msg:'请上传礼品logo！',
	            bg:'#AE81FF',
	            time:2
	        });
			$("#fileInput").focus();
			return false; 
			 }
		} 
		if('${action}' == 1 || "${pd.auditStatus}" == 0 && "${action}" == 2 || "${pd.auditStatus}" == 2 && "${action}" == 2 ){
			if(fileData != '' ){
				var butarr = [".bmp",".png",".gif",".jpeg",".jpg"];//数组存放 图片类型
				var arr = fileData.substr(fileData.lastIndexOf(".")).toLowerCase();
				if($.inArray(arr, butarr)==-1){
						if("${action}" == 1){
							$("#fileInput").tips({
								side : 3,
								msg : '请上传图片格式的文件',
								bg : '#AE81FF',
								time : 2
							});
						}
						if("${action}" == 2){
							$("#chImg").tips({
								side : 3,
								msg : '请上传图片格式的文件',
								bg : '#AE81FF',
								time : 2
							});
						}
					return false;
				}
			}
		}
		// 提交表单
		form.submit($('#usersForm'));
		if("${action}"==1){
			$("#zhongxin").hide();
			$("#zhongxin2").show();
		}
	}

</script>
	</head>
<body>

	<form action="prizeconfig/shakeOpera.do" name="usersForm" id="usersForm" method="post">
	<input type="hidden" name="action" id="action" value="${action}"/>
	<input type="hidden" name="prizeConfigId" id="action" value="${pd.prizeConfigId}"/>
	<input type="hidden" name="activityType" id="action" value="${pd.activityType}"/>
	<input type="hidden" name="storeId" id="storeId" />
	<input type="hidden" name="categoryName" id="categoryName" />
		<input type="hidden" name="isJackpot" value="${pd.isJackpot}" />
	<%-- <input type="hidden" name="otype" id="otype" value="${otype}"> --%>
	<div id="zhongxin" >
	<table id="table_report" class="table table-striped table-bordered table-hover" style="overflow:scroll;">
		<tr height="45px">
			<td>礼品名称:</td>
			<td><input <c:if test="${action == 4 || pd.status == 1 || pd.status == 2}">disabled="disabled"</c:if>placeholder="2~10个字" type="text" name="name" id="name" value="${pd.name}" style="width: 370px" onkeyup="validateUtils.replaceSpaceEmpty(this);"/></td>
			<td>总发放数:</td>
			<td><input <c:if test="${action == 4 || pd.status == 1 || pd.status == 2}">disabled="disabled"</c:if>placeholder="1~9999" type="number" min="1" max="9999" name="counts" id="counts" value="${pd.counts}" style="width: 370px"  /></td>
		</tr>
		<tr height="45px">
			<td>所属商户:</td>
			<td>
			<c:choose>
				<c:when test="${ not empty shopAll}">
					<select class="chzn-select" <c:if test="${action == 4 || pd.status == 1 || pd.status == 2}">disabled="disabled"</c:if> name="shopId" id="shopId" style="width: 383px; vertical-align:top;" >
						<c:forEach items="${shopAll}" var="var"  >
						<c:choose>
							<c:when test="${action == 1 and index.index == '0'}">
								<option value="${var.shopId}" selected="selected" storeId="${var.storeId}">${var.name}</option>
							</c:when>
							<c:otherwise>
									<option value="${var.shopId}" storeId="${var.storeId}" <c:if test="${var.shopId == pd.shopId}">selected="selected"</c:if>>${var.name}</option>
							</c:otherwise>
						</c:choose>
						</c:forEach>
				</select>
				</c:when>
				<c:otherwise>
					<select class="chzn-select" <c:if test="${action == 4 || pd.status == 1 || pd.status == 2}">disabled="disabled"</c:if> name="shopId" id="shopId" style="width: 383px; vertical-align:top;">
							<c:choose>
								<c:when test="${action == 1 and index.index == '0'}">
									<option value="${asShop.shopId}" storeId="${asShop.storeId}" selected="selected">${asShop.name}</option>
								</c:when>
								<c:otherwise>
										<option value="${asShop.shopId}" storeId="${asShop.storeId}" <c:if test="${asShop.shopId == pd.shopId}">selected="selected"</c:if>>${asShop.name}</option>
								</c:otherwise>
							</c:choose>
					</select>
				</c:otherwise>
			</c:choose>	
			</td>
			<c:choose>
				<c:when test="${action != 1 &&pd.status == 1 &&pd.status == 2}">
					<td>剩余数量:</td>
					<td><input <c:if test="${action == 4}">disabled="disabled"</c:if>placeholder="0~9999" type="number" min="0" max="9999" name="surplusCounts" id="surplusCounts" value="${pd.surplusCounts}" style="width: 370px" /></td>
				</c:when>
				<c:when test="${pd.status == 1}">
					<td>剩余数量:</td>
					<td><input <c:if test="${action == 4}">disabled="disabled"</c:if>placeholder="0~9999" type="number" min="0" max="9999" name="surplusCounts" id="surplusCounts" value="${pd.surplusCounts}" style="width: 370px" /></td>
				</c:when>
				<c:when test="${pd.status == 2}">
					<td>剩余数量:</td>
					<td><input <c:if test="${action == 4}">disabled="disabled"</c:if>placeholder="0~9999" type="number" min="0" max="9999" name="surplusCounts" id="surplusCounts" value="${pd.surplusCounts}" style="width: 370px" /></td>
				</c:when>			
				<c:when test="${action == 4}">
					<td>剩余数量:</td>
					<td><input <c:if test="${action == 4}">disabled="disabled"</c:if>placeholder="0~9999" type="number" min="0" max="9999" name="surplusCounts" id="surplusCounts" value="${pd.surplusCounts}" style="width: 370px" /></td>
				</c:when>			
			</c:choose>
		</tr>
		<tr height="45px">
			<td>活动类型:</td>
			<td>
				摇一摇
			</td>
			<c:if test="${action == 4}">
				<td id="td1">大奖礼品:</td>
				<td id="td2">
					<select <c:if test="${action == 4}">disabled="disabled"</c:if>  style="width: 383px">
						<option value="0" >否</option>
						<option value="1" <c:if test="${pd.isJackpot == 1}">selected="selected"</c:if>>是</option>
					</select>
				</td>
			</c:if>
			<c:if test="${action != 4}">
				<td id="td1"></td>
				<td id="td2"></td>
			</c:if>
		</tr>
		<tr height="45px">
			<td>礼品类型:</td>
			<td>
				<select class="chzn-select" <c:if test="${action == 4 || pd.status == 1 || pd.status == 2}">disabled="disabled"</c:if> data-placeholder="请选择" id="categoryId" name="categoryId" style="width: 383px; vertical-align:top;">
					
					<c:forEach items="${prizeTypeList}" var="var" varStatus="index">
						<option value="${var.id}" <c:if test="${var.id eq pd.categoryId}">selected</c:if>>${var.name}</option>
					</c:forEach>
				</select>
			</td>
					<c:if test="${'积分' eq pd.prizeTypeName }">
						<td id="td3">发放积分:</td>
						<td id="td4"><input <c:if test="${action == 4 || pd.status == 1 || pd.status == 2}">disabled="disabled"</c:if> placeholder="1~9999" type="number" min="1" max="9999" name="price" id="price" value="${pd.price}" style="width: 370px" onkeyup="validateUtils.replaceNotNumEmpty(this);" />点</td>
					</c:if>
					<c:if test="${'实物礼品' eq pd.prizeTypeName || action == 1}">
						<td id="td3"></td>
						<td id="td4"></td>
					</c:if>
					<c:if test="${'现金红包' eq pd.prizeTypeName}">
						<td id="td3">现金额度:</td>
						<td id="td4"><input <c:if test="${action == 4 || pd.status == 1 || pd.status == 2}">disabled="disabled"</c:if> type="text" name="price" id="price" value="${pd.price}" style="width: 370px" />元</td>
					</c:if>
		</tr>
		<c:if test="${pd.isJackpot == 1}">
			<tr height="45px">
				<td>是否必中:</td>
				<td>
					<select <c:if test="${action == 4}">disabled="disabled"</c:if> name="isDefinite" style="width: 383px">
						<option value="0" >否</option>
						<option value="1" <c:if test="${jackpot.isDefinite == 1}">selected="selected"</c:if>>是</option>
					</select>
				</td>
				<td >间隔时间:</td>
				<td ><input <c:if test="${action == 4 }">disabled="disabled"</c:if> type="number" min="1" name="intervalTime" id="intervalTime" value="${jackpot.intervalTime}" style="width: 370px" onkeyup="validateUtils.replaceNotNumEmpty(this);" />秒</td>

			</tr>
		</c:if>
		<tr height="45px">
			<td>开始时间:</td>
			<td><div class="row-fluid input-append date">
									<input <c:if test="${action == 4  || '现金红包' eq pd.prizeTypeName || '积分' eq pd.prizeTypeName}">disabled="disabled"</c:if> name="startTime" type="text" data-date-format="yyyy-mm-dd hh:ii:00" id="startTime" readonly="readonly" placeholder="开始时间" class="span10 date-picker" value="${pd.startTime}">
									<span class="add-on"><i class="icon-calendar"></i></span>
								</div></td>
			<td>结束时间:</td>
			<td><div class="row-fluid input-append date">
									<input <c:if test="${action == 4  || '现金红包' eq pd.prizeTypeName || '积分' eq pd.prizeTypeName}">disabled="disabled"</c:if> name="endTime" type="text" data-date-format="yyyy-mm-dd hh:ii:00" id="endTime" readonly="readonly" placeholder="结束时间" class="span10 date-picker" value="${pd.endTime}" >
									<span class="add-on"><i class="icon-calendar"></i></span>
								</div></td>
		</tr>
		<tr height="45px">
			<td>生效时间:</td>
			<td><div class="row-fluid input-append date">
				<input <c:if test="${action == 4 }">disabled="disabled"</c:if> name="activeTime" type="text" data-date-format="yyyy-mm-dd hh:ii:00" id="activeTime" readonly="readonly" placeholder="生效时间" class="span10 date-picker" value="${pd.activeTime}">
				<span class="add-on"><i class="icon-calendar"></i></span>
			</div></td>
			<td>失效时间:</td>
			<td><div class="row-fluid input-append date">
				<input <c:if test="${action == 4 }">disabled="disabled"</c:if> name="inactiveTime" type="text" data-date-format="yyyy-mm-dd hh:ii:00" id="inactiveTime" readonly="readonly" placeholder="失效时间" class="span10 date-picker" value="${pd.inactiveTime}" >
				<span class="add-on"><i class="icon-calendar"></i></span>
			</div></td>
		</tr>
		<tr height="45px">
			<td>描述:</td>
			<td><textarea <c:if test="${action == 4 || pd.status == 1 || pd.status == 2}">disabled="disabled"</c:if> placeholder="0~200个字" name="descp" id="descp" style="width: 400px;resize:none;height:200px;" onkeyup="validateUtils.replaceSpaceEmpty(this);">${pd.descp}</textarea></td>
		</tr>
		<tr>
			<td>礼品logo:</td>
			<td>
			<c:if test="${pd.logoUrl == '' || pd.logoUrl == null}">
				<c:if test="${action != 4}">
					<a id="imgBox" href="javascript:void(0)" style="display:none;">
		                <img src="" width="150" id="imgHref" />
		            </a>
	              <input type="file" id="fileInput" name="fileInput" />
				</c:if>         
            </c:if>
            <c:if test="${pd != null && pd.logoUrl != '' && pd.logoUrl != null }">
	              <a id="imgBox" href="<%=httpUrl%>${pd.logoUrl}" >
	                <img src="<%=httpUrl%>${pd.logoUrl}"  width="150" id="imgHref" />
	              </a>
	              
	              <c:if test="${action != 4 && pd.status != 1 && pd.status != 2}">
	              <input type="button" class="btn btn-mini btn-danger" value="更改" onclick="changeImg()" id="chImg" />
	              <input type="file" id="fileInput" name="fileInput" style="display:none;" <c:if test="${action == 2}">value="2"</c:if> />
	              </c:if>      
            </c:if>
            <font color="red">注：(图片尺寸规格340px * 340px)</font>
            <input id="url" name="img" type="hidden" />
            </td>
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
	<!-- <script type="text/javascript" src="static/js/bootstrap-datepicker.min.js"></script> --><!-- 日期框 -->
	<script type="text/javascript" src="static/js/bootstrap-datetimepicker.js"></script><!-- 日期框 -->
	<script type="text/javascript" src="static/js/bootstrap-datetimepicker.zh-CN.js"></script><!-- 日期框 -->
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