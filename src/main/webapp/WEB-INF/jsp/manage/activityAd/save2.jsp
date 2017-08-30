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
	
	//更改图片
    function changeImg(){
        $("#fileInput").trigger("click");
    }
	
	//保存
	function save(){
		var adPosType = $("#adPosType").val;
		if($("#adName").val()==""||$.trim($("#adName").val())=="" && ${action}==1){
			$("#adName").tips({
				side:3,
	            msg:'广告名称',
	            bg:'#AE81FF',
	            time:2
	        });
			$("#adName").focus();
			return false;
		}
		
		var atime = $("#adStartTime").val();
		var stime = $("#adEndTime").val();
		var  st= new Date(atime);
		var  et= new Date(stime);
		if($("#adStartTime").val()==""||$.trim($("#adStartTime").val())=="" && ${action}==1){
			$("#adStartTime").tips({
				side:3,
	            msg:'开始日期不能为空',
	            bg:'#AE81FF',
	            time:2
	        });
			$("#adStartTime").focus();
			return false;
		}
		if($("#adEndTime").val()==""||$.trim($("#adEndTime").val())=="" && ${action}==1){
			$("#adEndTime").tips({
				side:3,
	            msg:'结束日期不能为空',
	            bg:'#AE81FF',
	            time:2
	        });
			$("#adEndTime").focus();
			return false;
		}
		if(et.getTime() <= st.getTime()){
			$("#adEndTime").tips({
				side:3,
	            msg:'结束日期不能小于开始日期',
	            bg:'#AE81FF',
	            time:2
	        });
			return false;
		};
		
		var fileType = document.getElementById("fileInput").value.substr(document.getElementById("fileInput").value.lastIndexOf(".")).toLowerCase();//获得文件后缀名
		var url = $("#url").val();
		var img = $("#imgHref").attr("src");
		if (!img || url) {
			if (fileType != '.gif' && fileType != '.png' && fileType != '.jpg' && fileType != '.jpeg') {
				$("#fileInput").tips({
					side : 3,
					msg : '请上传图片格式的文件',
					bg : '#AE81FF',
					time : 2
				});
				$("#fileInput").val('');
				document.getElementById("fileInput").files[0] = '请选择图片';
				return;
			}
		}

		// 提交表单
		form.submit($('#usersForm'));
		
	}

function CheckPointActivityCount() {
	var adPosType =$("#adPosType").val();
	if(3==adPosType){
	$.ajax({
		    type : "post",
	        url : "activityAd/CheckPointActivityCount",
	        dataType : "json",
			async: false,
	        success : function(data) {
	        	if(data.status!=0){
	        		alert(data.msg);
					setTimeout("self.location=self.location",100);
	        		return ;
	        	}
	        }
	});	  }
} 	
</script>
	</head>
<body>

	<form action="activityAd/opera.do" name="usersForm" id="usersForm" method="post">
	<input type="hidden" name="adId" value="${pd.adId}"/>
	<input type="hidden" name="action" id="action" value="${action }">
	<input type="hidden" name="otype" id="otype" value="${otype}">
	<input type="hidden" name="adUrlType" id="adUrlType" value="${adUrlType}">
		<c:if test="${adUrlType == 0}">
			<input type="hidden" name="adPosType" value="${adPosType}"/>
		</c:if>
		<c:if test="${action==2}">
			<input type="hidden" name="adPosType"  value="${pd.adPosType}">
		</c:if>
	<input type="hidden" name="adSn" id="adSn" value="${pd.adSn}">
	<div id="zhongxin" >
	<table id="table_report" class="table table-striped table-bordered table-hover" style="overflow:scroll;">
	<%-- <c:if test="${action != null && action !=1 }">
	     <tr height="45px">
			<td>广告编号:</td>
			<td><input  type="text" name="adSn" id="adSn" value="${pd.adSn}" style="width: 370px" <c:if test="${action !=null && action != '' && action==4}">disabled="disabled"</c:if>></td>
		</tr>
    </c:if> --%>
		<tr height="45px">
			<td>广告名称:</td>
			<td><input  type="text" name="adName" id="adName" value="${pd.adName}" style="width: 370px"  <c:if test="${action !=null && action != '' && action==4}">disabled="disabled"</c:if>/></td>
		</tr>
		
			<tr height="45px">
			<td>广告板块类型:</td>
			<c:if test="${adUrlType == 1}">
			<td>
				<select style="width: 383px" name="adPosType" id="adPosType"  <c:if test="${action !=null && action != '' && action==4||action==2}">disabled="disabled"</c:if>>
					<c:if test="${action==4||action == 2}">
						<option value="2" <c:if test="${pd.adPosType==2}">selected="selected"</c:if>>大转盘-领取页</option>
						<option value="6" <c:if test="${pd.adPosType==6}">selected="selected"</c:if>>大转盘-logo</option>
						<option value="7" <c:if test="${pd.adPosType==7}">selected="selected"</c:if>>大转盘-首页</option>
					</c:if>
					<c:if test="${action == 1}">
						<option value="2" >大转盘-领取页</option>
						<option value="6" >大转盘-logo</option>
						<option value="7">大转盘-首页</option>
					</c:if>
				</select>
			</td>
			</c:if>
			<c:if test="${adUrlType == 0}">
				<td>
					<select style="width: 383px" name="adPosType" <c:if test="${action !=null && action != '' && action==4||action==2}">disabled="disabled"</c:if>>
						<option value="2" <c:if test="${pd.adPosType==2}">selected="selected"</c:if>>红包雨扫码</option>
					</select>
				</td>
			</c:if>
		</tr>



	<tr height="45px">
			<td>广告url类型:</td>
			<td>
              <select  style="width: 370px" <c:if test="${adUrlType !=null || adUrlType != ''}">disabled="disabled"</c:if> <c:if test="${action !=null && action != '' && action==4}">disabled="disabled"</c:if>>
                  <option value="0" <c:if test="${pd.adUrlType==0}">selected="selected"</c:if> >app端</option>
                   <option value="1" <c:if test="${pd.adUrlType==1}">selected="selected"</c:if>>云屏端</option>
              </select>
          </td>
		</tr>
		<tr height="45px">
			<td>广告url：</td>
			<td><input  type="text" name="adUrl" id="adUrl" value="${pd.adUrl}" style="width: 370px" <c:if test="${action !=null && action != '' && action==4}">disabled="disabled"</c:if>/></td>
		</tr>
		
		<tr>
        <td>发布时间:</td>
          <td>
              <input class="span10 date-picker"  name="adStartTime" id="adStartTime" type="text" value="${pd.adStartTime }" data-date-format="yyyy-mm-dd hh:ii:00" readonly="readonly" style="width:370px;" placeholder="开始日期" <c:if test="${action !=null && action != '' && action==4}">disabled="disabled"</c:if>/>
            </td>
       </tr>
		 <td>结束时间:</td>
            <td>
              <input class="span10 date-picker" name="adEndTime" id="adEndTime" type="text" value="${pd.adEndTime }" data-date-format="yyyy-mm-dd hh:ii:00" readonly="readonly" style="width:370px;" placeholder="结束日期" <c:if test="${action !=null && action != '' && action==4}">disabled="disabled"</c:if>/>
            </td>
		<tr>
			<td>发布图片:</td>
             <td>
            <c:if test="${pd == null || pd.adImg== '' || pd.adImg == null }">
              <a id="imgBox" href="javascript:void(0)" style="display:none;">
                <img src="" width="150" id="imgHref" />
              </a>
              <input type="file" id="fileInput" name="fileInput" />
				<c:if test="${adUrlType ==0}">
              		<span style="color: red; width: 50px;" id="msgDiv" >注： 图片格式支持 : gif/png/jpg/jpeg    尺寸规格750px * 350px</span>
				</c:if>
				<c:if test="${adUrlType ==1}">
             		 <span style="color: red; width: 50px;" id="msgDivScreen" >注： 图片格式支持 : gif/png/jpg/jpeg  尺寸规格 1188px * 1022px</span>
						<span style="color: red; width: 50px;" id="msgDivScreen6" >注： 图片格式支持 : gif/png/jpg/jpeg  尺寸规格 200px * 100px</span>
						<span style="color: red; width: 50px;" id="msgDivScreen7" >注： 图片格式支持 : gif/png/jpg/jpeg  尺寸规格 550px * 500px</span>
				</c:if>
            </c:if>
            <c:if test="${pd != null && pd.adImg != '' && pd.adImg != null }">
              <a id="imgBox" href="<%=httpUrl%>${pd.adImg}" title="${pd.adImg}">
                <img src="<%=httpUrl%>${pd.adImg}" alt="${pd.adImg}" width="150" id="imgHref" />
              </a>
              <c:if test="${action !=null && action != '' && action!=4}">
              <input type="button" class="btn btn-mini btn-danger" value="更改" onclick="changeImg()" id="chImg" />
				  <span style="color: red; width: 50px;" id="msgDiv" >注：(尺寸规格750px * 350px)</span>
				  <span style="color: red; width: 50px;" id="msgDivScreen" >注：(尺寸规格 1188px * 1022px)</span>
				  <span style="color: red; width: 50px;" id="msgDivScreen6" >注：(尺寸规格 200px * 100px)</span>
				  <span style="color: red; width: 50px;" id="msgDivScreen7" >注：(尺寸规格 550px * 500px)</span>

               <input type="file" id="fileInput" name="fileInput" style="display:none;" />
              </c:if>
            </c:if>
            <input id="url" name="img" type="hidden" />
          </td> 
		</tr>
		
		<tr height="45px">
			<td>描述:</td>
			<td>
				 <textarea style="width:90%;height:50px" name="adDesc" id="adDesc" <c:if test="${action !=null && action != '' && action==4}">disabled="disabled"</c:if>>${pd.adDesc}</textarea>
			</td>
		</tr>
    <c:if test="${action != null && action != 4 }">
		<tr id="operaArea">
			<td style="text-align: center;" colspan="2">
                <a class="btn btn-mini btn-primary" onclick="save();">保存</a>
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
	<script type="text/javascript" src="static/js/bootstrap-datetimepicker.js"></script><!-- 日期框 -->
    <script type="text/javascript" src="static/js/bootstrap-datetimepicker.zh-CN.js"></script><!-- 日期框 -->
	<script type="text/javascript" src="static/js/chosen.jquery.min.js"></script><!-- 下拉框 -->
	<script type="text/javascript" src="static/js/bootbox.min.js"></script><!-- 确认窗口 -->
		
	<script type="text/javascript" src="static/js/base64.js"></script>
	<!-- 压缩图片 -->

	<link rel="stylesheet" type="text/css" href="plugins/fancyBox/jquery.fancybox.css">
	<script type="text/javascript" src="plugins/fancyBox/jquery.fancybox.pack.js"></script>
	<!-- 查看图片 -->
	<script type="text/javascript" src="static/js/chosen.jquery.min.js"></script><!-- 下拉框 -->
	<script type="text/javascript">
	$(top.hangge());


    $(document).ready(function(){
        if($("#action").val()==1){
            if('${pd.adUrlType}' == 0){
                $("#msgDiv").show();
                $("#msgDivScreen").hide();
                $("#msgDivScreen6").hide();
                $("#msgDivScreen7").hide();
            }
            if('${pd.adUrlType}' == 1){
                $("#msgDiv").hide();
                $("#msgDivScreen").show();
                $("#msgDivScreen6").hide();
                $("#msgDivScreen7").hide();
            }
        }
        if($("#action").val()==2){
            if('${pd.adUrlType}' == 0){
                $("#msgDiv").show();
                $("#msgDivScreen").hide();
                $("#msgDivScreen6").hide();
                $("#msgDivScreen7").hide();
            }

            if('${pd.adUrlType}' == 1){
                $("#msgDiv").hide();
                if('${pd.adPosType}' == 2){
                    $("#msgDivScreen").show();
                    $("#msgDivScreen6").hide();
                    $("#msgDivScreen7").hide();
                }
                if('${pd.adPosType}' ==6){
                    $("#msgDivScreen").hide();
                    $("#msgDivScreen6").show();
                    $("#msgDivScreen7").hide();
                }
                if('${pd.adPosType}' ==7){
                    $("#msgDivScreen").hide();
                    $("#msgDivScreen6").hide();
                    $("#msgDivScreen7").show();
                }
            }

        }
        $("#adPosType").change(function(){
            if($(this).val()&&$(this).val()==2){
                $("#msgDiv").hide();
                $("#msgDivScreen").show();
                $("#msgDivScreen6").hide();
                $("#msgDivScreen7").hide();
            }else if($(this).val()&&$(this).val()==6){
                $("#msgDiv").hide();
                $("#msgDivScreen").hide();
                $("#msgDivScreen6").show();
                $("#msgDivScreen7").hide();
            }else if($(this).val()&&$(this).val()==7){
                $("#msgDiv").hide();
                $("#msgDivScreen").hide();
                $("#msgDivScreen6").hide();
                $("#msgDivScreen7").show();
            }
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

	$(function() {

		//单选框
		$(".chzn-select").chosen();
		$(".chzn-select-deselect").chosen({allow_single_deselect:true});

		$('#adStartTime').datetimepicker({
			minuteStep :1,
			language:  'zh-CN',
			autoclose: 1,
			format: "yyyy-mm-dd hh:ii:00",
			startDate: new Date(),
		}).on('changeDate',function(e){
			var startTime = e.date;
			$('#adEndTime').datetimepicker('setStartDate',startTime);
		});

		$('#adEndTime').datetimepicker({
			minuteStep :1,
			language:  'zh-CN',
			autoclose : 1,
			format: "yyyy-mm-dd hh:ii:00",
			startDate: new Date(),
		}).on('changeDate',function(e){
			var endTime = e.date;
			$('#adStartTime').datetimepicker('setEndDate',endTime);
		});
	});


  </script>


</body>
</html>