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
		<!-- <link rel="stylesheet" href="static/css/datepicker.css" /> --><!-- 时间框 -->
		<!--引入弹窗组件start-->
		<script type="text/javascript" src="plugins/attention/zDialog/zDrag.js"></script>
		<script type="text/javascript" src="plugins/attention/zDialog/zDialog.js"></script>
		<!--引入弹窗组件end-->
		<!--提示框-->
		<script type="text/javascript" src="static/js/jquery.tips.js"></script>
		<script type="text/javascript" src="static/js/common/commonutils.js"></script>
		<!--时间格式化-->
		<script type="text/javascript" src="static/js/dateFormat.js"></script>
		  		
<script type="text/javascript">
	$(top.hangge());
	
	var isExist = false;
	
	$(function() {
		
			$(".chzn-select").chosen(); 
			$(".chzn-select-deselect").chosen({allow_single_deselect:true}); 			
			var operaResult = '${operaResult}';						 
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
						return false;
					}
				});
				//限制上传的图片
				$("#fileInput0").change(function(){
					var butarr = [".bmp",".png",".gif",".jpeg",".jpg"];//数组存放 图片类型
					var value = $("#fileInput0").val();
					var arr = value.substr(value.lastIndexOf(".")).toLowerCase();
					if($.inArray(arr, butarr)==-1){
						if("${action}" == 1){
							$("#fileInput0").tips({
								side : 3,
								msg : '请上传图片格式的文件',
								bg : '#AE81FF',
								time : 2
							});
						}
						if("${action}" == 2){
							$("#chImg0").tips({
								side : 3,
								msg : '请上传图片格式的文件',
								bg : '#AE81FF',
								time : 2
							});
						}
						return false;
					}
				});
		});
	 
	
	//更改图片
    function changeImg(){
        $("#fileInput").trigger("click");
    }
	
  //更改图片
    function changeImg0(){
        $("#fileInput0").trigger("click");
    }
	
	//保存
	debugger;
	function save(){
		var userNameArr = "";
		var prizeInfoArr = "";
		var winTimeArr = "";
		 var ids="";
		$("input[name='userName']").each(function(){
            userNameArr=userNameArr+$(this).val()+',';
		});
		
		$("input[name='prizeInfo']").each(function(){
			prizeInfoArr=prizeInfoArr+$(this).val()+',';
		});
		$("input[name='winTime']").each(function(){
			winTimeArr=winTimeArr+$(this).val()+',';
		});
		$("input[name='activityRedrainWinnerId']").each(function(){
			ids=ids+$(this).val()+',';
		});
		$("#userNameList").val(userNameArr.substring(0,userNameArr.length-1));
		$("#prizeInfoList").val(prizeInfoArr.substring(0,prizeInfoArr.length-1));
		$("#winTimeList").val(winTimeArr.substring(0,winTimeArr.length-1));
		$("#ids").val(ids.substring(0,ids.length-1));
		
		 var name = $('#activityName').val();
		if(validateUtils.isEmpty(name)){
			$("#activityName").tips({
				side:3,
	            msg:'活动名称不能为空！',
	            bg:'#AE81FF',
	            time:2
	        });
			$("#activityName").focus();
			return false;
		}
		var nowDateTime = new Date().toLocaleDateString();
		var endTime = $('#endTime').val();
	    var startTime = $('#startTime').val();
		var  st= new Date(startTime);
		var  et= new Date(endTime);
		var nowTime =new Date();
			 if(validateUtils.isEmpty(startTime)){
				$("#startTime").tips({
					side:3,
		            msg:'请填写开始时间',
		            bg:'#AE81FF',
		            time:3
		        });
				$("#startTime").focus();
				return false;
			}
			 if(validateUtils.isEmpty(endTime)){
				$("#endTime").tips({
					side:3,
		            msg:'请填写结束时间',
		            bg:'#AE81FF',
		            time:3
		        });
				$("#endTime").focus();
				return false;
			}  
			 	if(st.getTime() < new Date(nowDateTime).getTime()&&'${activityStatus}'==1){
						$("#startTime").tips({
						side:3,
			            msg:'开始时间必须大于或者等于当前时间',
			            bg:'#AE81FF',
			            time:3
			        });
					$("#startTime").focus();
					return false;
				}
				
				if(et.getTime() < st.getTime()&&'${activityStatus}'==1){
					$("#endTime").tips({
						side:3,
			            msg:'结束时间必须大于开始时间',
			            bg:'#AE81FF',
			            time:3
			        });
					$("#endTime").focus();
					return false;
				} 
				var fileData = $('#fileInput').val();
				 if('${action}' == 1){
					 if(fileData == ''){
					 $("#fileInput").tips({
						side:3,
			            msg:'请上传背景图！',
			            bg:'#AE81FF',
			            time:2
			        });
					$("#fileInput").focus();
					return false; 
					 }
				} 
				 var bgfileData = $('#fileInput0').val();
				 if('${action}' == 1){
					 if(bgfileData == ''){
					 $("#fileInput0").tips({
						side:3,
			            msg:'请上传宣传图！',
			            bg:'#AE81FF',
			            time:2
			        });
					$("#fileInput0").focus();
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
		//把商品描述序列化成字符串	
		if('${activityStatus}' != 1){
				var oEditor1 = CKEDITOR.instances.descp1; 
				var content1 = oEditor1.getData();
				if(validateUtils.isEmpty(content1)){
					$("#cke_2_top").tips({
						side : 3,
						msg : '请填写活动回顾',
						bg : '#AE81FF',
						time : 6
					});
					$("#cke_2_top").focus();
					return
				} else{
					$('#descp1').val(content1);
				}
				if($("#descp1").val().length<2 || $("#descp1").val().length>10000){
					$("#cke_2_top").tips({
						side:3,
			            msg:'2~10000个字',
			            bg:'#AE81FF',
			            time:6
			        });
					$("#cke_2_top").focus();
					return ;
				}
			}
		
		
		
		 var uName = $('#userName').val();
		 var prizeInfo = $('#prizeInfo').val();
		 var winTime = $('#winTime').val();
		 if('${action}' == 1){
			if(validateUtils.isEmpty(uName)||validateUtils.isEmpty(prizeInfo)||validateUtils.isEmpty(winTime)){
				alert("请至少填写一条中奖单记录！");
				return false;
			}
		 }
		  if("${action}"==2&& "${ not empty activityRedrainWinner}"){
			  var names=$("input[name='userName']");
			  var prizeInfos=$("input[name='prizeInfo']");
			  var winTimes=$("input[name='winTime']");
			 for(var i=0;i<names.length;i++){
				 if(names[i].value==''){
	               alert("第"+i+"行用户名称不能为空");
				 return false;
			     } 
			 }
			 for(var i=0;i<prizeInfos.length;i++){
				 if(prizeInfos[i].value==''){
	               alert("第"+i+"行奖品不能为空");
				 return false;
			     } 
			 }
			 for(var i=0;i<winTimes.length;i++){
				 if(winTimes[i].value==''){
	               alert("第"+i+"行时间不能为空");
				 return false;
			     } 
			 }
		 } 

		// 提交表单
		 form.submit($('#activityRedrainForm'));
	}

</script>
	</head>
<body>

	<form action="activityRedrain/opera.do" name="activityRedrainForm" id="activityRedrainForm" method="post">
	<input type="hidden" name="action" id="action" value="${action}"/>
	<input type="hidden" name="activityId" id="activityId" value="${pd.activityId}"/>
	<input type="hidden" name="activityRedrainId" id="activityRedrainId" value="${activityRedrain.activityRedrainId}"/>
	<input type="hidden" name="activityStatus" id="activityStatus" value="${activityStatus}"/>
	<input type="hidden" name="userNameList" id="userNameList" value=""/>
	<input type="hidden" name="prizeInfoList" id="prizeInfoList" value=""/>
	<input type="hidden" name="winTimeList" id="winTimeList" value=""/>
	<input type="hidden" name="ids" id="ids" value=""/>
	<div id="zhongxin" >
	<table id="table_report" class="table table-striped table-bordered table-hover" style="overflow:scroll;">
		<tr height="45px">
			<td>活动类型:</td>
			<td>
				  红包雨
			</td>
			<td>活动名称:</td>
			<td><input placeholder="2~10个字" type="text" name="activityName" id="activityName" value='${asActivity.activityName}' style="width: 450px" onkeyup="validateUtils.replaceSpaceEmpty(this);"/></td>
				 
		</tr>
		<tr height="45px">
			<td>活动开始时间:</td>
			<td>
			<div class="row-fluid input-append date">
			 <input name="startTime"  <c:if test="${activityStatus==3}">disabled="disabled"</c:if> type="text" data-date-format="yyyy-mm-dd hh:ii:ss" id="startTime" readonly="readonly" placeholder="开始时间" class="span10 date-picker" value="${asActivity.startTime}">
			 <span class="add-on"><i class="icon-calendar"></i></span>
		    </div>
			</td>
			<td>活动结束时间:</td>
			<td><div class="row-fluid input-append date">
									<input name="endTime"  <c:if test="${activityStatus==3}">disabled="disabled"</c:if> type="text" data-date-format="yyyy-mm-dd hh:ii:ss" id="endTime" readonly="readonly" placeholder="结束时间" class="span8 date-picker" value="${asActivity.endTime}" >
									<span class="add-on"><i class="icon-calendar"></i></span>
								</div></td>
		</tr>
		<tr>
			<td>背景图:</td>
			<td>
			<c:if test="${activityRedrain.pageUrl == '' || activityRedrain.pageUrl == null}">
				<c:if test="${action != 4}">
					<a id="imgBox" href="javascript:void(0)" style="display:none;">
		                <img src="" width="150" id="imgHref" />
		            </a>
	              <input type="file" id="fileInput" name="fileInput" />
				</c:if>         
            </c:if>
            <c:if test="${activityRedrain != null && activityRedrain.pageUrl != '' && activityRedrain.pageUrl != null }">
	              <a id="imgBox" href="<%=httpUrl%>${activityRedrain.pageUrl}" >
	                <img src="<%=httpUrl%>${activityRedrain.pageUrl}"  width="150" id="imgHref" />
	              </a>	            
	              <c:if test="${action==2}">
	              <input type="button" class="btn btn-mini btn-danger" value="更改" onclick="changeImg()" id="chImg" />
	               </c:if>
	              <input type="file" id="fileInput" name="fileInput" style="display:none;" <c:if test="${action == 2}">value="2"</c:if> />
            </c:if>
            <td colspan='2'><font color="red">注：(图片尺寸规格710px * 1084px)</font></td>
            <input id="url" name="img" type="hidden" />
            </td>
		</tr>
		 <tr>
			<td>宣传图:</td>
			<td>
			<c:if test="${asActivity.propagandaUrl == '' || asActivity.propagandaUrl == null}">
				<c:if test="${action != 4}">
					<a id="imgBox0" href="javascript:void(0)" style="display:none;">
		                <img src="" width="150" id="imgHref0" />
		            </a>
	              <input type="file" id="fileInput0" name="fileInput0" />
				</c:if>         
            </c:if>
            <c:if test="${asActivity != null && asActivity.propagandaUrl != '' && asActivity.propagandaUrl != null }">
              <a id="imgBox0" href="<%=httpUrl%>${asActivity.propagandaUrl}" >
                <img src="<%=httpUrl%>${asActivity.propagandaUrl}"  width="150" id="imgHref0" />
              </a> 
               <c:if test="${action==2}">
              <input type="button" class="btn btn-mini btn-danger" value="更改" onclick="changeImg0()" id="chImg0" />
               </c:if>
              <input type="file" id="fileInput0" name="fileInput0" style="display:none;" <c:if test="${action == 2}">value="2"</c:if> />
            </c:if>
            <td colspan='2'><font color="red">注：(图片尺寸规格480px * 300px)</font></td>
           
            <input id="url0" name="img0" type="hidden" />
           
            </td>
		</tr>
<tr>
			<td>中奖名单:</td>
			<td colspan='3'>
            </td>
		</tr>
</tr>
<!-- 获奖名单start -->       
		<table id="myTable" class="table table-striped table-bordered table-hover">
				
				<thead>
					<tr>
						<th style="text-align:center;">用户</th>
						<th style="text-align:center;">奖品</th>
						<th style="text-align:center;">中奖时间</th>
						<th style="text-align:center;">操作</th>
					</tr>
				</thead>
										
				<tbody>
					
				<!-- 开始循环 -->
				<c:if test="${ not empty activityRedrainWinner}">
				<c:choose>
					<c:when test="${not empty activityRedrainWinner}">
						<c:forEach items="${activityRedrainWinner}" var="var" varStatus="vs">
							<input name="activityRedrainWinnerId" type="hidden" id="activityRedrainWinnerId" value="${var.activityRedrainWinnerId}" >		
							<tr>
								<td class='center' style="text-align:center;">
								<input type="text" name="userName" id="userName" value="${var.userName}" onkeyup="validateUtils.replaceSpaceEmpty(this);"/>
								</td>
								<td class='center' style="text-align:center;">
								<input type="text" name="prizeInfo" id="prizeInfo" value="${var.prizeInfo}" onkeyup="validateUtils.replaceSpaceEmpty(this);"/>
								</td>
								<td class='center' style="text-align:center;">
								<input type="text" name="winTime" id="winTime" value="${var.winTime}" readonly="readonly" onkeyup="validateUtils.replaceSpaceEmpty(this);"/>
								</td>
							    <td class='center' style="text-align:center;"> </td>
							</tr>
						
						</c:forEach>
						
					</c:when>
					<c:otherwise>
						<tr class="main_info">
							<td colspan="10" class="center">没有相关数据</td>
						</tr>
					</c:otherwise>
				</c:choose>	
				</c:if>			
				<c:if test="${empty activityRedrainWinner &&action==1}">
				<tr>
								<td class='center' style="text-align:center;">
								<input type="text" name="userName" id="userName" value="${pd.userName}" onkeyup="validateUtils.replaceSpaceEmpty(this);"/>
								</td>
								<td class='center' style="text-align:center;">
								<input type="text" name="prizeInfo" id="prizeInfo" value="${pd.prizeInfo}" onkeyup="validateUtils.replaceSpaceEmpty(this);"/>
								</td>
								<td class='center' style="text-align:center;">
								<input   name="winTime" type="text"  readonly="readonly" data-date-format="yyyy-mm-dd hh:ii" id="winTime" placeholder="中奖时间" class="span date-picker" value="${pd.winTime}">
								
								</td>
								<td class='center' style="text-align:center;"> <a class="btn btn-mini btn-primary" onclick="newBtn();">新增一行</a></td>
							</tr>
							<tr>
								<td class='center' style="text-align:center;">
								<input type="text" name="userName" id="userName" value="${pd.userName}" onkeyup="validateUtils.replaceSpaceEmpty(this);"/>
								</td>
								<td class='center' style="text-align:center;">
								<input type="text" name="prizeInfo" id="prizeInfo" value="${pd.prizeInfo}" onkeyup="validateUtils.replaceSpaceEmpty(this);"/>
								</td>
								<td class='center' style="text-align:center;">
                                <input   name="winTime" type="text" data-date-format="yyyy-mm-dd hh:ii" id="winTime" readonly="readonly" placeholder="中奖时间" class="span date-picker" value="${pd.winTime}">
								</td>
								<td class='center' style="text-align:center;"><a class="btn btn-mini btn-primary" onclick="removeline(this);">删除</a>
								 <a class="btn btn-mini btn-primary" onclick="newBtn();">新增一行</a></td>
							</tr>
				</c:if>	
				</tbody>
			</table>
			
<!-- 获奖名单end-->
		<tr>
			<td>活动详情:</td>
			
			<td colspan='4'>
			<div style="margin-left: 70px;">
				<span><font style="color: red;font-size: 18px">注:建议字体大小设置36PX</font></span>
				<textarea style="padding-left:10px; font-size="26px;" width:1300px;height:259px;" name="activityDetail" id="descp" placeholder="2~10000个字">${activityRedrain.activityDetail }</textarea></div>
			</div>
			</td>
		</tr>
		<c:if test="${action == 2&&activityStatus==2||activityStatus==3}">
			<tr>
				<td>活动回顾:</td>
				<td colspan='4'>
					<div style="margin-left: 70px;">
					<span><font style="color: red;font-size: 18px">注:建议字体大小设置36PX</font></span>
					<textarea style="width:1000px;height:259px;" name="activityReview" id="descp1" placeholder="2~10000个字">
					<c:if test="${activityStatus ne 1 }">
						${activityRedrain.activityReview}
					</c:if>
					</textarea>
					</div>
				</div>
				</td>
			</tr>
		</c:if>
		<c:if test="${action != 4}">
		<tr id="operaArea">
		<div style="margin-left: 500px;">
			<td style="text-align: center;" colspan="8">
                <a class="btn btn-mini btn-primary" onclick="save();" style="width:100px; height:30px;">保存</a>&nbsp;&nbsp;&nbsp;&nbsp;
				<a class="btn btn-mini btn-danger" onclick="top.Dialog.close();" style="width:100px; height:30px;">取消</a>
			</td>
			</div>
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
	
	  <!--编辑器  -->
	<script src="plugins/ckeditor/ckeditor.js"></script>
  	<script src="plugins/ckeditor/config.js"></script>
		
	<script type="text/javascript" src="static/js/base64.js"></script>
	<!-- 压缩图片 -->
	<link rel="stylesheet" type="text/css" href="plugins/fancyBox/jquery.fancybox.css">
	<script type="text/javascript" src="plugins/fancyBox/jquery.fancybox.pack.js"></script>
	<!-- 查看图片 -->
	<script type="text/javascript">
	$(top.hangge());
	  
	function newBtn(){
		var tr=$("<tr><td class=\"center\" style=\"text-align:center;\">"
				+"<input type=\"text\" size=\"4px;\" name=\"userName\" id=\"userName\" value=\"${pd.activityName}\" onclick=\"validateUtils.replaceSpaceEmpty(this);\"/>"
				+"</td>"
				+"<td class=\"center\" style=\"text-align:center;\">"
				+"<input type=\"text\" name=\"prizeInfo\" id=\"prizeInfo\" value=\"${pd.activityName}\" onkeyup=\"validateUtils.replaceSpaceEmpty(this);\"/>"
				+"</td>")
		var trinp=$("<td class=\"center\" style=\"text-align:center;\"><input type=\"text\" name=\"winTime\" placeholder=\"中奖时间\" id=\"winTime\" value=\"${pd.winTime}\" readonly=\"readonly\" class=\"span2.6 date-picker\" onkeyup=\"validateUtils.replaceSpaceEmpty(this);\"/></td>");
		var trend=$("<td class=\"center\" style=\"text-align:center;\"><a class=\"btn btn-mini btn-primary\" onclick=\"removeline(this)\">删除</a>&nbsp"
				+"<a class=\"btn btn-mini btn-primary\" onclick=\"newBtn();\">新增一行</a></td></tr>");
		 tr.append(trinp);
		 tr.append(trend);
		 tr.appendTo("#myTable");
		 $("input[name='winTime']").datetimepicker({  
			    minuteStep :1,
		        language:  'zh-CN',
			    autoclose : 1,  
			    format: "yyyy-mm-dd hh:ii:ss",
			    startDate: new Date(),
			}).on('changeDate',function(e){  
			    var endTime = e.date;  
			    $('#startTime').datetimepicker('setEndDate',endTime);  
			});

	}
	 function removeline(ojb){
		 var tr = ojb.parentNode.parentNode;
		 var tbody= tr.parentNode;
		 tbody.removeChild(tr);
	} 
	//初始化编辑器
	CKEDITOR.replace('descp',{
		width:1000,
		
	});
    if('${activityStatus}' != 1){
		
		CKEDITOR.replace('descp1',{
			width:1000,
			
		});
	}
    
	/* if('${activityStatus}' != 1){
		
		CKEDITOR.replace('descp1',{
			width:800,
			
		}); 
	}*/
	//动态加载初始化日期控件
	/* $.initDataPlugin= function(){
		
		$('.prizeTime').datetimepicker({
			minuteStep :1,
	        language:  'zh-CN',
			autoclose: 1,
			format: "yyyy-mm-dd hh:ii:ss",
	    }).on('changeDate',function(e){  
		    var startTime = e.date;  
// 		    $('#endTime').datetimepicker('setStartDate',startTime);  
		});
	}
	$.initDataPlugin(); */
	
	$(function() {
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
		
		$("input=[name='winTime']").datetimepicker({  
		    minuteStep :1,
	        language:  'zh-CN',
		    autoclose : 1,  
		    format: "yyyy-mm-dd hh:ii:ss",
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
	//上传
	$('#fileInput0:visible').ace_file_input({
		no_file : '请选择图片 ...',
		btn_choose : '选择',
		btn_change : '更改',
		droppable : false,
		onchange : null,
		thumbnail : false,
		before_remove : function() {
			$("#url0").val("");
			$("#imgBox0").attr("href", "").hide();
			$("#imgHref0").attr("src", "");
			return true;
		}
	});
	
	new img2base64("fileInput0", "url0", "imgHref0", "imgBox0");

	$("#imgBox0").fancybox({
		helpers : {
			title : {
				type : 'inside'
			}
		}
	});
	
	 $(document).ready(function(){
		$("#myTable").delegate("input[name='winTime']", "click", function(){
			   $(this).datetimepicker({  
				    minuteStep :1,
			        language:  'zh-CN',
				    autoclose : 1,  
				    format: "yyyy-mm-dd hh:ii:ss",
				    startDate: new Date(),
				}).on('changeDate',function(e){  
				    var endTime = e.date;  
				    $('#startTime').datetimepicker('setEndDate',endTime);  
				});
		  });
		}); 
  </script>
</body>
</html>