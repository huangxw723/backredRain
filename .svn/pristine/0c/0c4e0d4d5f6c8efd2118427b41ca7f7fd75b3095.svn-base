<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.aoshi.util.PropertyUtils"%>
<%@ page import="java.util.*" %>
<%@ page import="java.text.*" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
	String httpUrl = PropertyUtils.getHTTP_URL();
	String datetime=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(Calendar.getInstance().getTime()); //获取系统时间 
	request.setAttribute("currentTime",datetime);
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
			$("#eventName").blur(function(){
			var name = $('#eventName').val();
			var oldName =  '${pd.eventName}';
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
						url: '<%=basePath%>bussinessActivity/isExist.do',
				    	data: {eventName:name},
						dataType:'json',
						cache: false,
						success: function(data){
							if(data){
								isExist = true;
								$("#eventName").tips({
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
			$("#eventName").tips({
				side:3,
	            msg:'该名称已经存在',
	            bg:'#AE81FF',
	            time:2
	        });
			$("#eventName").focus();
			return false;
		}	
		 var storeId =  $("#shopId").find("option:selected").attr("storeId");
			$("#storeId").val(storeId);
		var name = $('#eventName').val();
		if(validateUtils.isEmpty(name)){
			$("#eventName").tips({
				side:3,
	            msg:'名称不能为空！',
	            bg:'#AE81FF',
	            time:2
	        });
			$("#eventName").focus();
			return false;
		}
			var pattern = new RegExp(/^\"|\"|\'|\'$/g);
			var b = pattern.test(name);
			if(b){
				$("#eventName").tips({
					side:3,
					msg:'名称中不能包含英语的双引号或单引号',
					bg:'#AE81FF',
					time:2
				});
				$("#eventName").focus();
				return false;
			}
		 if(name.length<2 || name.length>10){
			$("#eventName").tips({
				side:3,
	            msg:'2~10个字',
	            bg:'#AE81FF',
	            time:2
	        });
			$("#eventName").focus();
			return false;
		 } 
		
	 
		var nowDateTime = new Date().toLocaleDateString();
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
			/*	if (new Date(st) < new Date(nowDateTime)) {
                    $("#startTime").tips({
                        side: 3,
                        msg: '开始时间必须大于或者等于当前时间',
                        bg: '#AE81FF',
                        time: 3
                    });
                    $("#startTime").focus();
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
                }*/


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
		
		// 提交表单
		form.submit($('#usersForm'));
		if('${action}'==1){
			$("#zhongxin").show();
			//$("#zhongxin2").show();
		}

	}

</script>
	</head>
<body>

	<form action="bussinessActivity/opera.do" name="usersForm" id="usersForm" method="post">
	<input type="hidden" name="action" id="action" value="${action}"/>
	<input type="hidden" name="asEventId" id="asEventId" value="${pd.asEventId}"/>	
	<input type="hidden" name="storeId" id="storeId" />
	<div id="zhongxin" >
	<table id="table_report" class="table table-striped table-bordered table-hover" style="overflow:scroll;">
	<tr height="45px">
			<td>所属商户:</td>
			<td>
			<c:choose>
				<c:when test="${ not empty shopAll}">
					<select class="chzn-select" <c:if test="${action == 4 or pd.status==1 or pd.status==2 }">disabled="disabled"</c:if> name="shopId" id="shopId" style="width: 383px; vertical-align:top;" >
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
					<select class="chzn-select" <c:if test="${action == 4 or pd.status==1 or pd.status==2}">disabled="disabled"</c:if> name="shopId" id="shopId" style="width: 383px; vertical-align:top;">
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
	    <tr height="45px">
		   <td>活动名称:</td>
			<td><input  type="text" name="eventName" id="eventName" <c:if test="${action == 4 or pd.status==1 or pd.status==2}">disabled="disabled"</c:if> value='${pd.eventName}' style="width: 370px" placeholder="0-20个字"/></td>
		</tr>
		<tr height="45px">
			<td>活动主题:</td>
			<td>
				<input  type="text" name="eventTitle" id="eventTitle" <c:if test="${action == 4 or pd.status==1 or pd.status==2}">disabled="disabled"</c:if> value='${pd.eventTitle}' style="width: 370px" placeholder="1-15个字"/></td>						 
		</tr>		
		<tr height="45px">
			<td>活动Logo:</td>
			<td>
			<c:if test="${pd.eventLogo == '' || pd.eventLogo == null}">			
					<a id="imgBox" href="javascript:void(0)" style="display:none;">
		                <img src="" width="150" id="imgHref" />
		            </a>
		           <c:if test="${action == 1 or pd.status == 0 }"> 
	              <input type="file" id="fileInput" name="fileInput" />	
	              </c:if>	            		
            </c:if>
            <c:if test="${pd != null && pd.eventLogo != '' && pd.eventLogo != null }">
	              <a id="imgBox" href="<%=httpUrl%>${pd.eventLogo}" >
	                <img src="<%=httpUrl%>${pd.eventLogo}"  width="150" id="imgHref" />
	              </a> 
	              <c:if test="${action == 1 or pd.status == 0 }">   
	              <input type="button" class="btn btn-mini btn-danger" value="更改" onclick="changeImg()" id="chImg" />
	               </c:if> 
	              <input type="file" id="fileInput" name="fileInput" style="display:none;" <c:if test="${action == 2}">value="2"</c:if> />  	                    
            </c:if>  
           <c:if test="${action != 4 }">  
            <td colspan='2'><font color="red">注：(图片尺寸规格480px * 300px)</font>
            <input id="url" name="img" type="hidden" />
            </td>
            </c:if>
		</tr>
		<tr height="45px">
			<td>活动开始时间:</td>
			<td><div class="row-fluid input-append date">
									<input  name="startTime" type="text"  data-date-format="yyyy-mm-dd hh:ii:ss" id="startTime" readonly="readonly" placeholder="开始时间" class="span10 date-picker" <c:if test="${action == 4 or currentTime gt pd.endTime and pd.status != 0 }">disabled="disabled"</c:if> value="${pd.startTime}">
									<span class="add-on"><i class="icon-calendar"></i></span>
								</div></td>
			<td>活动结束时间:</td>
			<td><div class="row-fluid input-append date">
									<input  name="endTime" type="text"  data-date-format="yyyy-mm-dd hh:ii:ss" id="endTime" readonly="readonly" placeholder="结束时间" class="span10 date-picker" <c:if test="${action == 4 or currentTime gt pd.endTime and pd.status != 0 }">disabled="disabled"</c:if> value="${pd.endTime}" >
									<span class="add-on"><i class="icon-calendar"></i></span>
								</div></td>
		</tr>		
		
		<tr height="45px">
			<td>活动详情:</td>
			<td colspan='3'>
			    <c:if test="${action != 4 }"> 
				<span><font style="color: red;font-size: 18px">注:建议字体大小设置'16px'</font></span>
				</c:if>
				<textarea style="width:1000px;height:259px;" <c:if test="${action == 4 or pd.status==1 or pd.status==2}">disabled="disabled"</c:if> name="eventDetail" id="descp" placeholder="2~10000个字">
					${pd.eventDetail}
				</textarea>
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
		
		//单选框
		$(".chzn-select").chosen();
		$(".chzn-select-deselect").chosen({allow_single_deselect:true});
	
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
		  /*   startDate: new Date(), */
		}).on('changeDate',function(e){
		    var endTime = e.date;
		    $('#startTime').datetimepicker('setEndDate',endTime);
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