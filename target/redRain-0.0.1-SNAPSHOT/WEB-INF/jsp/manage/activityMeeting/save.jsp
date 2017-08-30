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
		<link rel="stylesheet" href="static/css/bootstrap-datetimepicker.min.css" /><!-- 时间框 -->
		<!--引入弹窗组件start-->
		<script type="text/javascript" src="plugins/attention/zDialog/zDrag.js"></script>
		<script type="text/javascript" src="plugins/attention/zDialog/zDialog.js"></script>
		<!--引入弹窗组件end-->
		<!--提示框-->
		<script type="text/javascript" src="static/js/jquery.tips.js"></script>
		<%--工具类--%>
		<script type="text/javascript" src="static/js/common/commonutils.js"></script>
		<!--时间格式化-->
		<script type="text/javascript" src="static/js/dateFormat.js"></script>
  		
<script type="text/javascript">
	$(top.hangge());
	
	var isExist = false;
	
	$(function() {
		
			//鼠标失焦后验证
			$("#name").blur(function(){
			var name = $('#name').val();
			var oldName =  '${pd.activityName}';
				if(!validateUtils.isEmpty(name)){
					/* if(name.length<2 || name.length>10){
						$("#name").tips({
							side:3,
				            msg:'2~10个字',
				            bg:'#AE81FF',
				            time:2
				        });
						return false;
					} */
					if(name != oldName){
					$.ajax({
						type: "POST",
						url: '<%=basePath%>activityMeeting/isExist.do',
				    	data: {activityName:name},
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
	            msg:'名称不能为空！',
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
		/* if(name.length<2 || name.length>10){
			$("#name").tips({
				side:3,
	            msg:'2~10个字',
	            bg:'#AE81FF',
	            time:2
	        });
			$("#name").focus();
			return false;
		} */


		//当前系统时间
		var nowDateTime = new Date();

		var endTime = $('#endTime').val();
		var startTime = $('#startTime').val();
		var  st= new Date(startTime);
		var  et= new Date(endTime);
		if('${activityStatus}' != 3) {
			if (validateUtils.isEmpty(startTime)) {
				$("#startTime").tips({
					side: 3,
					msg: '请填写开始时间',
					bg: '#AE81FF',
					time: 3
				});
				$("#startTime").focus();
				return false;
			}
			if (validateUtils.isEmpty(endTime)) {
				$("#endTime").tips({
					side: 3,
					msg: '请填写结束时间',
					bg: '#AE81FF',
					time: 3
				});
				$("#endTime").focus();
				return false;
			}

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
				var name = $('#provinceId').val();
				if(validateUtils.isEmpty(name)){
					$("#provinceId").tips({
						side:3,
			            msg:'省份不能为空！',
			            bg:'#AE81FF',
			            time:3
			        });
					$("#provinceId").focus();
					return false;
				}	
				
				var name = $('#cityId').val();
				if(validateUtils.isEmpty(name)){
					$("#cityId").tips({
						side:3,
			            msg:'城市不能为空！',
			            bg:'#AE81FF',
			            time:3
			        });
					$("#cityId").focus();
					return false;
				}	
				
				var name = $('#areaId').val();
				if(validateUtils.isEmpty(name)){
					$("#areaId").tips({
						side:3,
			            msg:'区县不能为空！',
			            bg:'#AE81FF',
			            time:3
			        });
					$("#areaId").focus();
					return false;
				}	
				
				var name = $('#address').val();
				if(validateUtils.isEmpty(name)){
					$("#address").tips({
						side:3,
			            msg:'详细地址不能为空！',
			            bg:'#AE81FF',
			            time:3
			        });
					$("#address").focus();
					return false;
				}

		 
		var fileData = $('#fileInput').val();
		 if('${action}' == 1){
			 if(fileData == ''){
			 $("#fileInput").tips({
				side:3,
	            msg:'请上传宣传图！',
	            bg:'#AE81FF',
	            time:2
	        });
			$("#fileInput").focus();
			return false; 
			 }
		} 
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
			
		//把商品描述序列化成字符串
		var oEditor = CKEDITOR.instances.descp; 
		var content = oEditor.getData();
		if(validateUtils.isEmpty(content)){
			$("#cke_1_top").tips({
				side : 3,
				msg : '请填写活动详情',
				bg : '#AE81FF',
				time : 6
			});
			$("#cke_1_top").focus();
			return
		} else{
			$('#descp').val(content);
		}
		if($("#descp").val().length<2 || $("#descp").val().length>10000){
			$("#cke_1_top").tips({
				side:3,
	            msg:'2~10000个字',
	            bg:'#AE81FF',
	            time:6
	        });
			$("#cke_1_top").focus();
			return false;
		}
		
		//把活動回顧序列化成字符串	
		if('${activityStatus}' != 1){
			var oEditor1 = CKEDITOR.instances.descp1; 
			var content1 = oEditor1.getData();
			$('#descp1').val(content1);
		}	 
		// 提交表单
		form.submit($('#usersForm'));
		if('${action}'==1){
			$("#zhongxin").hide();
			$("#zhongxin2").show();
		}

	}

</script>
	</head>
<body>

	<form action="activityMeeting/opera.do" name="usersForm" id="usersForm" method="post">
	<input type="hidden" name="action" id="action" value="${action}"/>
	<input type="hidden" name="activityStatus" id="activityStatus" value="${activityStatus}"/>
	<input type="hidden" name="activityId" id="activityId" value="${pd.activityId}"/>
		<c:if test="${activityStatus eq 3 }">
			<input type="hidden" name="startTime"   value="${pd.startTime}"/>
			<input type="hidden" name="endTime"   value="${pd.endTime}"/>
		</c:if>
	<div id="zhongxin" >
	<table id="table_report" class="table table-striped table-bordered table-hover" style="overflow:scroll;">
		<tr height="45px">
			<td>活动类型:</td>
			<td>
				  明星见面会
			</td>
			<td>活动名称:</td>
			<td><input  type="text" name="activityName" id="name" value='${pd.activityName}' style="width: 370px" onkeyup="validateUtils.replaceSpaceEmpty(this);"/></td>
				 
		</tr>
		<tr height="45px">
			<td>活动开始时间:</td>
			<td><div class="row-fluid input-append date">
									<input  name="startTime" type="text" <c:if test="${activityStatus eq 3 }">disabled="disabled"</c:if> data-date-format="yyyy-mm-dd hh:ii:ss" id="startTime" readonly="readonly" placeholder="开始时间" class="span10 date-picker" value="${pd.startTime}">
									<span class="add-on"><i class="icon-calendar"></i></span>
								</div></td>
			<td>活动结束时间:</td>
			<td><div class="row-fluid input-append date">
									<input  name="endTime" type="text" <c:if test="${activityStatus eq 3 }">disabled="disabled"</c:if> data-date-format="yyyy-mm-dd hh:ii:ss" id="endTime" readonly="readonly" placeholder="结束时间" class="span10 date-picker" value="${pd.endTime}" >
									<span class="add-on"><i class="icon-calendar"></i></span>
								</div></td>
		</tr>
		<tr height="45px">
			<td>活动地址:</td>
			<td >
				<select class="chzn-select" name="provinceId" id="provinceId" data-placeholder="请选择省份" style="vertical-align:top;width: 120px;"  >
					<option value=""></option>
					<c:forEach items="${provinceList}" var="var">
						<option value="${var.provinceId }" <c:if test="${var.provinceId == am.provinceId }">selected</c:if>>${var.provinceName }</option>
					</c:forEach>
				</select>
				<select class="chzn-select" name="cityId" id="cityId" data-placeholder="请选择城市" style="vertical-align:top;width: 140px;"  >
					<%--<c:if test="${action==2 }">
						<option value=""></option>
						<c:forEach items="${cityList}" var="vc">
							<option value="${vc.cityId}" <c:if test="${vc.cityId == am.cityId }">selected</c:if>>${vc.cityName }</option>
						</c:forEach>
					</c:if>--%>
				</select>
				<select class="chzn-select" name="areaId" id="areaId" data-placeholder="请选择区域" style="vertical-align:top; width: 140px;">

					<%--<c:if test="${action==2 }">
						<option value=""></option>
						<c:forEach items="${areaList}" var="var">
							<option value="${var.areaId }"
									<c:if test="${var.areaId == am.areaId }">selected</c:if>>${var.areaName }</option>
						</c:forEach>
					</c:if>--%>
				</select>
			</td>
      		<td>详细地址:</td>
      		<td>
      			<input  type="text" name="address" id="address" value='${am.address}' style="width: 370px" onkeyup="validateUtils.replaceSpaceEmpty(this);"/>
      		</td>

		</tr>
		<tr>
			<td>宣传图:</td>
			<td>
			<c:if test="${pd.propagandaUrl == '' || pd.propagandaUrl == null}">
				<c:if test="${action != 4}">

					<a id="imgBox" href="javascript:void(0)" style="display:none;">
		                <img src="" width="150" id="imgHref" />
		            </a>
	              <input type="file" id="fileInput" name="fileInput" />
				</c:if>
            </c:if>
            <c:if test="${pd != null && pd.propagandaUrl != '' && pd.propagandaUrl != null }">
	              <a id="imgBox" href="<%=httpUrl%>${pd.propagandaUrl}" >
	                <img src="<%=httpUrl%>${pd.propagandaUrl}"  width="150" id="imgHref" />
	              </a>

	              <input type="button" class="btn btn-mini btn-danger" value="更改" onclick="changeImg()" id="chImg" />
	              <input type="file" id="fileInput" name="fileInput" style="display:none;" <c:if test="${action == 2}">value="2"</c:if> />
	              <%--<c:if test="${activityStatus ne 3 }">
	              </c:if>--%>
            </c:if>
           <td colspan='2'><font color="red">注：(图片尺寸规格480px * 300px)</font></td>
            <input id="url" name="img" type="hidden" />
            </td>
		</tr>

		<tr>
			<td>活动详情:</td>
			<td colspan='3'>
				<span><font style="color: red;font-size: 18px">注:建议字体大小设置36PX</font></span>
				<textarea style="width:1000px;height:259px;" name="activityDetail" id="descp" placeholder="2~10000个字">
					${am.activityDetail}
				</textarea>
			</td>
		</tr>

		<c:if test="${activityStatus ne 1 }">
			<tr>
				<td>活动回顾:</td>
				<td colspan='3'>
					<span><font style="color: red;font-size: 18px">注:建议字体大小设置36PX</font></span>
					<textarea style="width:1000px;height:259px;" name="activityReview" id="descp1" placeholder="2~10000个字">
					<c:if test="${activityStatus ne 1 }">
						${am.activityReview}
					</c:if>
					</textarea>
				</td>
			</tr>
		</c:if>
		
		<tr id="operaArea">
			<td style="text-align: center;" colspan="4">
                <a class="btn btn-mini btn-primary" onclick="save();">保存</a>&nbsp;&nbsp;&nbsp;&nbsp;
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
	<script type="text/javascript" src="static/js/bootstrap-datetimepicker.js"></script><!-- 时间框 -->
	<script type="text/javascript" src="static/js/bootstrap-datetimepicker.zh-CN.js"></script><!-- 时间框 -->
	<script type="text/javascript" src="static/js/chosen.jquery.min.js"></script><!-- 下拉框 -->
	<script type="text/javascript" src="static/js/bootbox.min.js"></script><!-- 确认窗口 -->
	
	  <!--编辑器  -->
	<script src="plugins/ckeditor/ckeditor.js"></script>
  	<script src="plugins/ckeditor/config.js"></script>
		
	<!-- 压缩图片 -->
	<script type="text/javascript" src="static/js/base64.js"></script>

	<link rel="stylesheet" type="text/css" href="plugins/fancyBox/jquery.fancybox.css">
	<script type="text/javascript" src="plugins/fancyBox/jquery.fancybox.pack.js"></script>
	<!-- 查看图片 -->
	<script type="text/javascript">
	$(top.hangge());
	
	//初始化编辑器
	CKEDITOR.replace('descp',{
		width:800,
		//fontSize_defaultLabel:26,

	});
	
	if('${activityStatus}' != 1){
		
		CKEDITOR.replace('descp1',{
			width:800,
			
		});
	}
	
	$(function() {

		if($("#provinceId").val()) {
			var provinceId = $("#provinceId").val();
			var citySelect = $("#cityId");
			citySelect.empty().append("<option value=''></option>");
			var cityList = '${cityList}';
			var cityId = '${am.cityId}';
			$.each(JSON.parse(cityList), function(i, list){
				var parentId = list.provinceId;
				if(parentId == provinceId) {
					var value = list.cityId;
					var option = list.cityName;
					var label = $("<option value='"+value+"'>"+option+"</option>");
					if(cityId == list.cityId) {
						label.attr("selected", "selected");
					}
					citySelect.append(label);
				}
			});
		}
		if($("#cityId").val()) {
			var cityId = $("#cityId").val();
			var areaSelect = $("#areaId");
			areaSelect.empty().append("<option value=''></option>");
			var areaList = '${areaList}';
			var shopAreaId = '${am.areaId}';
			$.each(JSON.parse(areaList), function(i, list){
				var parentId = list.cityId;
				if(parentId == cityId) {
					var value = list.areaId;
					var option = list.areaName;
					var label = $("<option value='"+value+"'>"+option+"</option>");
					if(shopAreaId == list.areaId) {
						label.attr("selected", "selected");
					}
					areaSelect.append(label);
				}
			});
		}

		//单选框
		$(".chzn-select").chosen();
		$(".chzn-select-deselect").chosen({allow_single_deselect:true});

		//联动select事件
		$("#provinceId").change(function(){
		    var provinceId = $("#provinceId").val();
		    var citySelect = $("#cityId");
		    citySelect.empty().append("<option value=''></option>");
		    var areaSelect = $("#areaId");
		    areaSelect.empty().append("<option value=''></option>");
		    var cityList = '${cityList}';
		    $.each(JSON.parse(cityList), function(i, list){
		    	var parentId = list.provinceId;
				if(parentId == provinceId) {
					var value = list.cityId;
					var option = list.cityName;
					var label = $("<option value='"+value+"'>"+option+"</option>");
					citySelect.append(label);
				}
		 	});
		    citySelect.trigger("liszt:updated");
		    areaSelect.trigger("liszt:updated");
		});
		
		//联动select事件
		$("#cityId").change(function(){
		    var cityId = $("#cityId").val();
		    var areaSelect = $("#areaId");
		    areaSelect.empty().append("<option value=''></option>");
		    var areaList = '${areaList}';
		    $.each(JSON.parse(areaList), function(i, list){
		    	var parentId = list.cityId;
				if(parentId == cityId) {
					var value = list.areaId;
					var option = list.areaName;
					var label = $("<option value='"+value+"'>"+option+"</option>");
					areaSelect.append(label);
				}
		 	});
		    areaSelect.trigger("liszt:updated");
		});


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