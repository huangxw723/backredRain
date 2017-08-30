<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.aoshi.util.PropertyUtils"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
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
<%@ include file="../../system/admin/top.jsp"%>
<script type="text/javascript" src="static/js/bootbox.min.js"></script>
<script type="text/javascript">
$(function(){
	//日期框
	$('#startTime').datepicker().on('changeDate',function(ev){
		  var startTime = ev.date.valueOf();
		  $("#sTime").val(startTime);
		   });
	$('#endTime').datepicker().on('changeDate',function(ev){
		  var entt = ev.date.valueOf();
		  $("#eTime").val(entt);
	});
});

function getNowFormatDate() {
    var date = new Date();
    var seperator1 = "-";
    var seperator2 = ":";
    var year = date.getFullYear();
    var month = date.getMonth() + 1;
    var strDate = date.getDate();
    if (month >= 1 && month <= 9) {
        month = "0" + month;
    }
    if (strDate >= 0 && strDate <= 9) {
        strDate = "0" + strDate;
    }
    var currentdate = year + seperator1 + month + seperator1 + strDate;
    return currentdate;
}
function CheckImgExists(img,url,fileType){
	if (!img || url) {
		if (fileType != '.gif' && fileType != '.png' && fileType != '.jpg'
				&& fileType != '.jpeg') {
	    return false;
		}
		return true;
	} 
}
//保存
function save() {
     var names =$(".prizeTypeName");
	 for(var i=0;i<6;i++){
		var fileType = document.getElementById("fileInput"+i).value.substr(document.getElementById("fileInput"+i).value.lastIndexOf(".")).toLowerCase();//获得文件后缀名
		var url = $("#url"+i).val();
		var img = $("#imgHref"+i).attr("src");
		if(!CheckImgExists(url,img,fileType)){
			$("#fileInput"+i).tips({
				side : 3,
				msg : '请上传图片格式的文件',
				bg : '#AE81FF',
				time : 3
			});
			$("#fileInput"+i).val('');
			return;
		} ;
		if(names[i].value==""){
			$("#prizeTypeName"+i).tips({
				side : 3,
				msg : '请填写奖品名称',
				bg : '#AE81FF',
				time : 3
			});
			$("#prizeTypeName"+i).val('');
			return;
		} ;
		
    } 
	var cdate = getNowFormatDate();
	var nowdate= cdate.replace(/-/g,'/');//2013-02-12替换成 2013/02/12
	var nowDateTime =new Date(nowdate);
	var etime = $("#eTime").val();
	var stime = $("#sTime").val();
	if(etime<nowDateTime.getTime()){
		alert("结束时间必须大于当前时间！");
			return false;
	} 
	if(etime==""||$.trim(etime)=="" || stime==""||$.trim(stime)==""){
		alert('开始时间或结束时间不能为空！');
		return false;
	}
	
	if(etime<stime){
		alert("开始日期不能大于结束时间！");
		return false;
	}
	if($("#activityName").val()==""||$.trim($("#activityName").val())==""){
		$("#activityName").tips({
			side:3,
            msg:'活动名称',
            bg:'#AE81FF',
            time:2
        });
		$("#activityName").focus();
		return false;
	}

	var nubmertimes = parseInt($("#times").val());
    if(isNaN(nubmertimes)||nubmertimes<=0||!(/^\d+$/.test(nubmertimes)))
   {
       alert("每日参与次数请输入正确的数值,只允许输入整数!");
       $("#times").val();
       $("#times").focus();
       return false;

    }
	if($("#times").val()=="" ||$.trim($("#times").val())==""){
		$("#times").tips({
			side:3,
            msg:'活动次数',
            bg:'#AE81FF',
            time:2
        });
		$("#times").focus();
		return false;
	}
	bootbox.confirm("                活动开始就不能修改！确认开始吗?", function(result) {
		if(result) {
			$("#form").submit();
			$("#zhongxin").hide();
			$("#zhongxin2").show();
		}
	}); 
    
}
//停止活动
function shopSave(activityId) {

	bootbox.confirm("                活动结束将无法开启！确认结束吗?", function(result) {
		if(result) {
			$.ajax({
				type: "POST",
				url: '<%=basePath%>acitity/shopActivity.do',
		    	data: {activityId:activityId},
				dataType:'json',
				cache: false,
				success: function(data){
					console.log("data:"+data.status)
					if(data.status== "0"){
			        $('#form').attr("action","acitity/editPage.do");
					}else{alert(data.msg);}
					search();
				}
			});
		}
	});
	
}
//检索
function search(){
	top.jzts();
	$("#form").submit();
}
	
</script>
</head>
<body>
<form action="acitity/${msg }.do" name="form" id="form" method="post">
	<input name="type" id="type" type="hidden" value="${pd.type}" />
	<input type="hidden" name="sTime" id="sTime" value="">
	<input type="hidden" name="eTime" id="eTime" value="">
		<div id="zhongxin">
			<!--    停止活动显示活动信息table -->
			<c:if test="${not empty aListing}">
			<div style="width：90%;height:165px;margin:0px auto;border:1px solid #A9A9A9; margin-top:0px">
			    <h3 style="font-family: serif; font-weight: bold;">活动信息</h3>
				<div >
				<input name="activityId" id=""activityId"" type="hidden" value="${AsActivityData.activityId}" />
					<table id="table_report"
						class="table table-striped table-bordered table-hover">

						<thead>
							<tr>
								<th class="center">活动编号</th>
								<th class="center">活动名称</th>
								<th class="center">参与商家</th>
								<th class="center">参与人数</th>
								<th class="center">发放奖品</th>
								<th class="center">活动时间</th>
							</tr>
						</thead>
						<tbody>
					    <c:choose>
						<c:when test="${not empty acList}">
							<tr>
								<td class='center' style="width: 30px;">${acList.sn }</td>
								<td style="max-width: 100px; text-align: center; overflow: hidden; white-space: nowrap; text-overflow: ellipsis;"
									title="">${acList.name }</td>
								<td class="center" width="300">${acList.shopCounts }</td>
								<td class='center' style="width: 30px;">${acList.personCounts }</td>
								<td class='center' style="width: 30px;">${acList.prizeCounts }/${acList.prizeSurplusCounts }</td>
								<td class="center">${activity.startTime } 至 ${activity.endTime }</td>
							</tr>
					</c:when>
					</c:choose>
						</tbody>
					</table>
				</div>
			</div>
			</c:if>
			<!-- 有活动并且   停止活动显示活动信息table -->


			<!-- 没有有活动table 开始 -->
		
    <c:if test="${empty aListing}">
    <div style="margin-left: 120px; margin-top: 20px;" id="pag">
    <table id="table_report" class="table table-striped table-bordered table-hover">
        <tr>
        <td>活动名称:</td>
          <td>
            <input type="text" style="width:90%;" name="activityName" id="activityName" value="" title="活动名称" />
          </td>
          <td>每日参与 :</td>
          <td>
            <input type="number" style="width:25%;" name="times" id="times" value=""  />&nbsp  次(1-10)
          </td> 
       </tr>
        <tr>
        <td>开始时间:</td>
          <td>
              <input class="span10 date-picker" name="startTime" id="startTime" type="text" value="" data-date-format="yyyy-mm-dd" readonly="readonly" style="width:90%;" placeholder="开始日期"/>
          </td>
         <td>结束时间 :</td>
          <td>
              <input class="span10 date-picker" name="endTime" id="endTime" type="text" value="" data-date-format="yyyy-mm-dd" readonly="readonly" style="width:90%;" placeholder="结束日期"/>
          </td> 
       </tr>
       <c:if test="${pd.type == 2}">
        <tr>
        <td>间隔时间(秒)</td>
          <td>
              <select name="intervalTime" id="intervalTime">
                <c:forEach items="${intervals }" var="interval">
                  <option value="${interval }">${interval }</option>
                </c:forEach>
              </select>
            </td> 
       </tr>
       </c:if>
      </table>
      </div>   </c:if> 
     <!-- 没有有活动table 结束 -->


			<!--      有活动并且   停止活动显示活动信息table 开始-->
			<c:if test="${not empty aListing}">
			   <div style="width：90%;height:440px;margin:0px auto;border:1px solid 	#A9A9A9;margin-top:120px"> 
			   <c:if test="${pd.type == 1}"><h3 style="font-family: serif; font-weight: bold;">转盘设置</h3></c:if> 
			    <c:if test="${pd.type == 2}"> <h3 style="font-family: serif; font-weight: bold;">摇奖设置</h3></c:if>
				<div style="margin-left: 20px; margin-top: 10px;" id="pa1" >
					<table id="table_report"
						class="table table-striped table-bordered table-hover">
						<tr>
							<td class="center" width="60px;">奖品类型:</td>

							<c:forEach var="it" items="${aListing}">
								<td class="center" width="150px">${it.asPrizeType.prizeTypeName }</td>
							</c:forEach>

						</tr>
						<tr>
							<td class="center" width="150px">奖品 图片</td>
							<c:forEach var="it" items="${aListing}">
								<td class="center" width="300"><a class="fancybox"
									href="<%=httpUrl%>${it.icon}"> <img
										src="<%=httpUrl%>${it.icon}" alt="${it.icon}" width="90%"
										height="20px" />
								</a></td>
							</c:forEach>
						</tr>
						<tr>

							<td class="center">奖品名称:</td>
							<c:forEach var="it" items="${aListing}">
								<td class="center" width="300">${it.name}</td>
							</c:forEach>
						</tr>
					</table>
				</div>
				</div>
			</c:if>
			<!--      有活动并且   停止活动显示活动信息table  结束-->


<!-- 			没活动 开始 -->

			<c:if test="${empty aListing}">
			<div style="width：90%;height:440px;margin:0px auto;border:1px solid #A9A9A9;margin-top:120px"> 
				<c:if test="${pd.type == 1}"><h3 style="font-family: serif; font-weight: bold;">转盘设置</h3></c:if> 
			    <c:if test="${pd.type == 2}"> <h3 style="font-family: serif; font-weight: bold;">摇奖设置</h3></c:if>
				<div style="margin-left: 20px; margin-top: 10px;" id="pa1" >
					<table id="table_report"
						class="table table-striped table-bordered table-hover">
						<tr>
							<td class="center" width="25px;">奖品类型:</td>
							<td style="vertical-align: top;"><select
								name="prizeTypeId" data-placeholder="请选择奖品类型"
								style="vertical-align: top; width: 200px;">
									<c:forEach var="it" items="${prizeTypes}">
										<option id=prizeTypeId value="${it.prizeTypeId}">${it.prizeTypeName }</option>
									</c:forEach>
							</select></td>
							<td style="vertical-align: top;"><select 
								name="prizeTypeId" data-placeholder="请选择奖品类型"
								style="vertical-align: top; width: 200px;">
									<c:forEach var="it" items="${prizeTypes}">
										<option id=prizeTypeId value="${it.prizeTypeId}">${it.prizeTypeName }</option>
									</c:forEach>
							</select></td>
							<td style="vertical-align: top;"><select 
								name="prizeTypeId" data-placeholder="请选择奖品类型"
								style="vertical-align: top; width: 200px;">
									<c:forEach var="it" items="${prizeTypes}">
										<option id=prizeTypeId value="${it.prizeTypeId}">${it.prizeTypeName }</option>
									</c:forEach>
							</select></td>
							<td style="vertical-align: top;"><select 
								name="prizeTypeId" data-placeholder="请选择奖品类型"
								style="vertical-align: top; width: 200px;">
									<c:forEach var="it" items="${prizeTypes}">
										<option id=prizeTypeId value="${it.prizeTypeId}">${it.prizeTypeName }</option>
									</c:forEach>
							</select></td>
							<td style="vertical-align: top;"><select 
								name="prizeTypeId" data-placeholder="请选择奖品类型"
								style="vertical-align: top; width: 200px;">
									<c:forEach var="it" items="${prizeTypes}">
										<option id=prizeTypeId value="${it.prizeTypeId}">${it.prizeTypeName }</option>
									</c:forEach>
							</select></td>
							<td style="vertical-align: top;"><select 
								name="prizeTypeId" data-placeholder="请选择奖品类型"
								style="vertical-align: top; width: 200px;">
									<c:forEach var="it" items="${prizeTypes}">
										<option id=prizeTypeId value="${it.prizeTypeId}">${it.prizeTypeName }</option>
									</c:forEach>
							</select></td>

						</tr>
						<tr>
							<td class="center" width="150px">奖品 图片</td>
							<td><a id="imgBox0" href="javascript:void(0)"
								style="display: none;"> <img src="" width="150"
									id="imgHref0" />
							</a> <input type="file" id="fileInput0" name="fileInput0" /> <input
								id="url0" name="img0" type="hidden" /></td>
							<td><a id="imgBox1" href="javascript:void(0)"
								style="display: none;"> <img src="" width="150"
									id="imgHref1" />
							</a> <input type="file" id="fileInput1" name="fileInput1" /> <input
								id="url1" name="img1" type="hidden" /></td>
							 <td>
              <a id="imgBox2" href="javascript:void(0)" style="display:none;">
                <img src="" width="150" id="imgHref2" />
              </a>
              <input type="file" id="fileInput2" name="fileInput2" />
              <input id="url2" name="img2" type="hidden" />
          </td>
          <td>
              <a id="imgBox3" href="javascript:void(0)" style="display:none;">
                <img src="" width="150" id="imgHref3" />
              </a>
              <input type="file" id="fileInput3" name="fileInput3" />
              <input id="url3" name="img3" type="hidden" />
          </td>
          <td>
              <a id="imgBox4" href="javascript:void(0)" style="display:none;">
                <img src="" width="150" id="imgHref4" />
              </a>
              <input type="file" id="fileInput4" name="fileInput4" />
              <input id="url4" name="img4" type="hidden" />
          </td>
          <td>
              <a id="imgBox5" href="javascript:void(0)" style="display:none;">
                <img src="" width="150" id="imgHref5" />
              </a>
              <input type="file" id="fileInput5" name="fileInput5" />
              <input id="url5" name="img5" type="hidden" />
          </td> 
						</tr>
						<tr>

							<td class="center" width="125px;">奖品名称:</td>
							<td><input type="text" style="width: 90%;"name="prizeTypeName" id="prizeTypeName0" class="prizeTypeName" value="" required="required"/></td>
							<td><input type="text" style="width: 90%;"name="prizeTypeName" id="prizeTypeName1" class="prizeTypeName" value="" required="required"/></td>
						    <td>
					             <input type="text" style="width:90%;" name="prizeTypeName" id="prizeTypeName2" class="prizeTypeName" value="" required="required"/>
					          </td>
					          <td>
					             <input type="text" style="width:90%;" name="prizeTypeName" id="prizeTypeName3" class="prizeTypeName" value="" required="required" />
					          </td>
					          <td>
					             <input type="text" style="width:90%;" name="prizeTypeName" id="prizeTypeName4" class="prizeTypeName" value=""  required="required"/>
					          </td>
					          <td>
					             <input type="text" style="width:90%;" name="prizeTypeName" id="prizeTypeName5" class="prizeTypeName" value=""  required="required"/>
					          </td> 
						</tr>
						<tr>

						</tr>
					</table>
				</div>
				</div>
			</c:if> 
			<%--       没活动 开始 结束 --%>

		</div>
	
		</br>
		<c:if test="${empty aListing}">
		<input type="button" onclick="save();" value="活动开始" style="position:relative; width:150px;height:30px; margin-left:90px; width:80%; height:100%;" >
		</c:if>
		<c:if test="${not empty aListing}">
		<input type="button" onclick="shopSave(${acList.activityId});" value="停止活动" style="position:relative; width:150px;height:30px; margin-left:90px; width:80%; height:100%;">
		</c:if>
	</form>
  <!-- 引入 -->

  <!-- 单选框 -->
  <script type="text/javascript" src="static/js/bootstrap-datepicker.min.js"></script>

  <script type="text/javascript" src="static/js/bootstrap-timepicker.min.js"></script>
  <link rel="stylesheet" href="static/css/bootstrap-timepicker.css" />
  <!-- 时间选择器 -->
    <script src="static/js/bootstrap.min.js"></script>
	<script src="static/js/ace-elements.min.js"></script>
	<script src="static/js/ace.min.js"></script>
	<script type="text/javascript" src="static/js/chosen.jquery.min.js"></script>
	<!-- base64 -->
	<script src="static/js/base64.js"></script>
	<link rel="stylesheet" type="text/css"href="plugins/fancyBox/jquery.fancybox.css">
	<script type="text/javascript" src="plugins/fancyBox/jquery.fancybox.pack.js"></script>
    <script type="text/javascript" src="static/js/bootstrap-timepicker.min.js"></script>
    <link rel="stylesheet" href="static/css/bootstrap-timepicker.css" />
	<!-- 单选框 -->
    <script type="text/javascript">window.jQuery || document.write("<script src='static/js/jquery-1.9.1.min.js'>\x3C/script>");</script>

  <script type="text/javascript">
    $(top.hangge());
    /**
	 * base 64 加密
	 */
	$(function() {
		$('.date-picker').datepicker();
		$(".chzn-select").chosen();
		$(".chzn-select-deselect").chosen({
			allow_single_deselect : true
		});
		
		$(".fancybox").fancybox({
            helpers: {
                title: {
                    type: 'inside'
                }
            }
        });
		
		
	})
	function changeImg() {
		$("#fileInput0").trigger("click");
	}
	function changeImg() {
		$("#fileInput1").trigger("click");
	}
	function changeImg() {
		$("#fileInput2").trigger("click");
	}

	function changeImg() {
		$("#fileInput3").trigger("click");
	}

	function changeImg() {
		$("#fileInput4").trigger("click");
	}

	function changeImg() {
		$("#fileInput5").trigger("click");
	}
	$(top.hangge());
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
	$('#fileInput1:visible').ace_file_input({
		no_file : '请选择图片 ...',
		btn_choose : '选择',
		btn_change : '更改',
		droppable : false,
		onchange : null,
		thumbnail : false,
		before_remove : function() {
			$("#url1").val("");
			$("#imgBox1").attr("href", "").hide();
			$("#imgHref1").attr("src", "");
			return true;
		}
	});
	$('#fileInput2:visible').ace_file_input({
		no_file : '请选择图片 ...',
		btn_choose : '选择',
		btn_change : '更改',
		droppable : false,
		onchange : null,
		thumbnail : false,
		before_remove : function() {
			$("#url2").val("");
			$("#imgBox2").attr("href", "").hide();
			$("#imgHref2").attr("src", "");
			return true;
		}
	});

	$('#fileInput3:visible').ace_file_input({
		no_file : '请选择图片 ...',
		btn_choose : '选择',
		btn_change : '更改',
		droppable : false,
		onchange : null,
		thumbnail : false,
		before_remove : function() {
			$("#url3").val("");
			$("#imgBox3").attr("href", "").hide();
			$("#imgHref3").attr("src", "");
			return true;
		}
	});

	$('#fileInput4:visible').ace_file_input({
		no_file : '请选择图片 ...',
		btn_choose : '选择',
		btn_change : '更改',
		droppable : false,
		onchange : null,
		thumbnail : false,
		before_remove : function() {
			$("#url4").val("");
			$("#imgBox4").attr("href", "").hide();
			$("#imgHref4").attr("src", "");
			return true;
		}
	});

	$('#fileInput5:visible').ace_file_input({
		no_file : '请选择图片 ...',
		btn_choose : '选择',
		btn_change : '更改',
		droppable : false,
		onchange : null,
		thumbnail : false,
		before_remove : function() {
			$("#url5").val("");
			$("#imgBox5").attr("href", "").hide();
			$("#imgHref5").attr("src", "");
			return true;
		}
	});

	new img2base64("fileInput0", "url0", "imgHref0", "imgBox0");
	new img2base64("fileInput1", "url1", "imgHref1", "imgBox1");
	new img2base64("fileInput2", "url2", "imgHref2", "imgBox2");
	new img2base64("fileInput3", "url3", "imgHref3", "imgBox3");
	new img2base64("fileInput4", "url4", "imgHref4", "imgBox4");
	new img2base64("fileInput5", "url5", "imgHref5", "imgBox5");
	$("#imgBox0").fancybox({
		helpers : {
			title : {
				type : 'inside'
			}
		}
	});
	$("#imgBox1").fancybox({
		helpers : {
			title : {
				type : 'inside'
			}
		}
	});
	$("#imgBox2").fancybox({
		helpers : {
			title : {
				type : 'inside'
			}
		}
	});
	$("#imgBox3").fancybox({
		helpers : {
			title : {
				type : 'inside'
			}
		}
	});
	$("#imgBox4").fancybox({
		helpers : {
			title : {
				type : 'inside'
			}
		}
	});
	$("#imgBox5").fancybox({
		helpers : {
			title : {
				type : 'inside'
			}
		}
	});
  </script>
</body>
</html>