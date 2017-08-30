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
	<!-- jsp文件头和头部 -->
	<%@ include file="../../../system/admin/top.jsp"%>
	<!-- ztree -->
	<!-- ztree -->
	<script src="static/js/bootstrap.min.js"></script>
	<script type="text/javascript" src="plugins/zTree/3.5/jquery.ztree.core.min.js"></script>
	<script type="text/javascript" src="plugins/zTree/3.5/jquery.ztree.excheck.min.js"></script>
	<script type="text/javascript" src="static/js/bootbox.min.js"></script><!-- 确认窗口 -->
	<link type="text/css" rel="stylesheet" href="plugins/zTree/3.5/demo.css" />
  	<link type="text/css" rel="stylesheet" href="plugins/zTree/3.5/zTreeStyle.css" />
  		<style type="text/css">
			.template1_left{
				width: 165px;
				height: 242px;
				border:1px solid gray;
				float: left;
				margin-top: 2px
			}
			.template1_middle1{
				width: 340px;
				height: 320px;
				border:1px solid gray;
				float: left;margin-left: 2px;
				margin-right: 2px;
				margin-top: 2px
			}
			.template1_middle2{
				width: 340px;
				height: 50px;
				border:1px solid gray;
				float: left;margin-left: 2px;
				margin-right: 2px;
				margin-top: 2px
			}
			.template1_middle3{
				width: 168px;
				height: 110px;
				border:1px solid gray;
				float: left;margin-left: 2px;
				margin-right: 2px;
				margin-top: 2px
			}
			.template1_middle4{
				width: 168px;
				height: 110px;
				border:1px solid gray;
				float: left;margin-left: 2px;
				margin-right: 2px;
				margin-top: 2px
			}
			.template1_right{
				width: 165px;
				height: 160px;
				border:1px solid gray;
				float: left;
				margin-top: 2px
			}
			
			.on{
				border-color: red;
			}
			
			.left_content_div{
				    position: relative;
    				top: 200px;
    				left: 20px;
			}
			.left_content_div,.mid_content_div span{
				    color: #e86c45;
			}
			
			.mid_content_div{
				    position: relative;
    				top: 79px;
    				left: 15px;
			}
			.sub_div{
				width: 100%;float: left;text-align: center;margin-top: 20px
			}
		</style>
	</head>
	<script src="static/js/base64Compress.js"></script>
<body>
<div style="float: left;width: 15%;">
<ul id="tree" class="ztree" style="width: 90%;height:auto; "></ul>
</div>

<form action="yp/admin/template/saveModuleContent.do" method="post" enctype="multipart/form-data">
<input type="hidden" name="rootUserTemplateId" value="${rootUserTemplateId}">
<input type="hidden" name="userTemplateId" value="${userTemplate.userTemplateId}">
<input type="hidden" name="userId" value="${userTemplate.userId}">
<input type="hidden" name="path" value="${userTemplate.path}">
<input type="hidden" name="moduleStr" id="moduleStr">
<div style="height: 500px;width: 700px;border:1px solid gray;float: left">
	<div style="margin-left: 5px">
		<!-- left div begin-->
		<div style="height: 500px;width: 170px;float: left;">
			<div onclick="setText1(this)" position="1" userModuleId="" class="template1_left">
				<input type="file" name="file" style="display: none" onchange="showPic(this)">
				<div>
					<a href="javascript:void(0)" style="float: left;" onclick="selectFile(this,event)">编辑</a>
					<a temp_select href="javascript:void(0)" style="float: right;display: none" onclick="selectTemplate(this)">选择模版</a>
					<a temp_edit href="javascript:void(0)" data-str="" style="float: right;display: none" onclick="editTemplate(this)">编辑模版</a>
				</div>
				<div class="left_content_div">
					<span name="content"></span>
				</div>
				
			</div>
			<div onclick="setText1(this)" position="2" userModuleId="" class="template1_left">
				<input type="file" name="file" style="display: none" onchange="showPic(this)">
				<div>
					<a href="javascript:void(0)" style="float: left;" onclick="selectFile(this)">编辑</a>
					<a temp_select href="javascript:void(0)" style="float: right;display: none" onclick="selectTemplate(this)">选择模版</a>
					<a temp_edit href="javascript:void(0)" data-str="" style="float: right;display: none" onclick="editTemplate(this)">编辑模版</a>
				</div>
				<div class="left_content_div">
					<span name="content"></span>
				</div>
			</div>
			<!-- <div onclick="setText1(this)" position="3" userModuleId="" class="template1_left">
				<input type="file" name="file" style="display: none" onchange="showPic(this)">
				<div>
					<a href="javascript:void(0)" style="float: left;" onclick="selectFile(this)">编辑</a>
					<a temp_select href="javascript:void(0)" style="float: right;display: none" onclick="selectTemplate(this)">选择模版</a>
					<a temp_edit href="javascript:void(0)" data-str="" style="float: right;display: none" onclick="editTemplate(this)">编辑模版</a>
				</div>
				<div class="left_content_div">
					<span name="content"></span>
				</div>
			</div> -->
		</div>
		<!-- left div end-->
		
		<!-- middle div begin-->
		<div style="height: 500px;width: 350px;float: left;">
			
			<div class="template1_middle1"></div>
			<div class="template1_middle2"></div>
			<div class="template1_middle3" onclick="setText1(this)" position="3" userModuleId="">
				<input type="file" name="file" style="display: none" onchange="showPic(this)">
				<div>
					<a href="javascript:void(0)" style="float: left;" onclick="selectFile(this)">编辑</a>
					<a temp_select href="javascript:void(0)" style="float: right;display: none" onclick="selectTemplate(this)">选择模版</a>
					<a temp_edit href="javascript:void(0)" data-str="" style="float: right;display: none" onclick="editTemplate(this)">编辑模版</a>
				</div>
				<div class="mid_content_div">
					<span name="content"></span>
				</div>
			</div>
			<div class="template1_middle4" onclick="setText1(this)" position="4">
				<input type="file" name="file" style="display: none" onchange="showPic(this)">
				<div>
					<a href="javascript:void(0)" style="float: left;" onclick="selectFile(this)">编辑</a>
					<a temp_select href="javascript:void(0)" style="float: right;display: none" onclick="selectTemplate(this)">选择模版</a>
					<a temp_edit href="javascript:void(0)" data-str="" style="float: right;display: none" onclick="editTemplate(this)">编辑模版</a>
				</div>
				<div class="mid_content_div">
					<span name="content"></span>
				</div>
			</div>
		</div>
		<!-- middle div end-->
		
		<!-- right div begin-->
		<div style="height: 500px;width: 170px;float: left;">
			<div class="template1_right"></div>
			<div class="template1_right"></div>
			<div class="template1_right"></div>
		</div>
		<!-- right div end-->
	</div>
</div>
</form>
<div>
	<div style="width: 120px;float: left;margin-left: 10px">
		<div style="margin-top: 5px">
			<label>
				<input type="radio" name="type" data-val="企业简介">
				<span class="lbl">企业简介</span>
			</label>
			<label>
				<input type="radio" name="type" data-val="招商活动">
				<span class="lbl">招商活动</span>
			</label>
			<label>
				<input type="radio" name="type" data-val="品牌活动">
				<span class="lbl">品牌活动</span>
			</label>
			<label>
				<input type="radio" name="type" data-val="场内促销">
				<span class="lbl">场内促销</span>
			</label>
			<label>
				<input type="radio" name="type" data-val="美食推荐">
				<span class="lbl">美食推荐</span>
			</label>
			<label>
				<input type="radio" name="type" data-val="便民服务">
				<span class="lbl">便民服务</span>
			</label>
			<label>
				<input type="radio" name="type" data-val="交通信息">
				<span class="lbl">交通信息</span>
			</label>
			<label>
				<input type="radio" name="type" data-val="商场指南">
				<span class="lbl">商场指南</span>
			</label>
		</div>
		
		<div style="margin-top: 15px;padding-left: 30px">
			<input type="button" onclick="selectType()" value="确定">
		</div>
		
	</div>
		
</div>
<div class="sub_div" >
	<input type="button" id="delBtn" value="删除该模版">
	<input type="button" id="subBtn" value="保存">
</div>
</body>
<script>
//console.log('${treeData}');
function zTreeOnClick(event,treeId,treeNode){
	if(!treeNode.checked){
		location.href="<%=basePath%>yp/admin/template/toEditUserTemplate.do?userTemplateId="+treeNode.userTemplateId
				+"&path="+treeNode.path+"&rootUserTemplateId="+treeNode.rootUserTemplateId
	}
			
}
 /**
  * 树的设置
  */
  
  var nodeStr = '${treeData}';
  
  var zTreeObj,
	setting = {
		view: {
			selectedMulti: false
		},
		callback:{
			onClick:zTreeOnClick
		},
		check:{
			enable:true,
			chkStyle:"checkbox",
			chkboxType:{"Y":"","N":""}
			
		},
		data:{
			key:{
				name:'name'
			}
		}
  };

	var userTemplateId = "${userTemplate.userTemplateId}";
	var rootUserTemplateId = "${rootUserTemplateId}";
	if(undefined==rootUserTemplateId || rootUserTemplateId==""||rootUserTemplateId==null){
		rootUserTemplateId = userTemplateId;
	}
	var userId = "${userTemplate.userId}";
	var data = '${userModules}';
	//console.log(data);
	if(data != undefined && data != "" && data !="[]"){
		var userModules = JSON.parse(data);
		$.each(userModules,function(index,value){
			var position = value.position;
			var icon = value.icon;
			var div = $("div[position="+position+"]");
			if(icon != undefined && icon !=""){
				$(div).css("background","url(<%=httpUrl%>"+icon+")");
				$(div).css("background-size","cover");
			}
			$(div).find("span[name=content]").text(value.content);
			$(div).attr("userModuleId",value.userModuleId);
			if(undefined != value.userModuleId && value.userModuleId !=null&&value.userModuleId!=""){
				if(value.template ==null){
					$(div).find("a[temp_select]").show();
				}else{
					$(div).find("a[temp_edit]").show();
					$(div).find("a[temp_edit]").data("str",JSON.stringify(value.template));
				}
				
				
			}
		})
	}
	
	
	function setText1(_this){
		$("[position]").removeClass("on");
		$(_this).addClass("on");
	}
	
	function selectType(){
		var value = $("[name=type]:checked").data("val");
		if(undefined == value){
			alert("请选择服务类型");
			return ;
		}
		var selected = $(".on");
		if(selected.length == 0){
			alert("请选择模块");
			return ;
		}
		$(".on").find("span[name=content]").text(value);
	}
	function selectFile(_this,evt){
		if(evt){
			evt.stopPropagation();
		}
		$(_this).parents("div[position]").find("input[type=file]").click();
	}
	
	function showPic(_this){
		var files = _this.files;
		//console.log(files);
		var FR= new FileReader();
	    FR.onload = function(e) {
	     // console.log(e.target.result);
	     //压缩base64
	      var result = base64Shorter(e.target.result);
	      var _div = $(_this).parents("div[position]")[0];
	      $(_div).css("background","url("+result+")");
	      $(_div).css("background-size","cover");
	    };       
	    FR.readAsDataURL( files[0] );
		
		//$(_this).parents("div[position]").css
	}
	
	function selectTemplate(_this){
		var zTreeObj = $.fn.zTree.getZTreeObj("tree");
		var level = zTreeObj.getSelectedNodes()[0].level;
		if(level>1){
			bootbox.alert("无法继续添加模版",function(result){
    		});
			return ;
		}
		var parentUserModuleId = $(_this).parents("div[position]").attr("userModuleId");
		var parentUserTemplateId = userTemplateId;
		if(undefined==parentUserModuleId||parentUserModuleId==""||parentUserModuleId==null){
			return ;
		}
		
		location.href='<%=basePath%>yp/admin/template/getTemplates.do?parentUserModuleId='+parentUserModuleId+
				"&parentUserTemplateId="+parentUserTemplateId
				+"&rootUserTemplateId="+rootUserTemplateId
		<%-- top.mainFrame.tab.add( {
				id :new Date().getTime(),
				title :"选择模版",
				url :'<%=basePath%>yp/admin/template/getTemplates.do?parentUserModuleId='
						+parentUserModuleId+"&parentUserTemplateId="+parentUserTemplateId+"&rootUserTemplateId="+rootUserTemplateId,
				isClosed :true
		}); --%>
	}
	
	function editTemplate(_this){
		var template = JSON.parse($(_this).data("str"));
		var userTemplateId = template.id;
		var rootUserTemplateId = template.rootUserTemplateId;
		var path = template.path;
		var userId = template.userId;
		location.href='<%=basePath%>yp/admin/template/toEditUserTemplate.do?userTemplateId='+userTemplateId+
				"&rootUserTemplateId="+rootUserTemplateId+"&path="+path+"&userId="+userId;
	}
	
	var submitFlag = false;
	$(document).ready(function(){
		zTreeObj = $.fn.zTree.init($("#tree"), setting, JSON.parse(nodeStr));
		
		$("#subBtn").on("click",function(){
			if(submitFlag){
				 alert("正在保存中，请勿重复提交!");
				 return ;
			}
			submitFlag = true;
			var modules = $("div[position]");
			var moduleStr = [];
			
			$.each(modules,function(index,value){
				moduleStr.push({
					userModuleId:$(value).attr("userModuleId"),
					userTemplateId:userTemplateId,
					userId:userId,
					content:$(value).find("span[name=content]").text(),
					position:$(value).attr("position")
				})
			})
			//console.log(JSON.stringify(moduleStr));
			$("#moduleStr").val(JSON.stringify(moduleStr));
			
			$("form")[0].submit();
		})
		
		$("#delBtn").on("click",function(){
			if(confirm("确认删除该模版吗?")){
				$.ajax({
					type: "POST",
					url: '<%=basePath%>yp/admin/template/delTemplate.do',
			    	data: {userTemplateId:userTemplateId},
					dataType:'json',
					//beforeSend: validateData,
					cache: false,
					success: function(data){
						if(data.msg){
							bootbox.alert(data.msg,function(result){
	                			
	                		});
						}else if(data.template){
							var template = data.template;
							bootbox.alert("删除成功",function(result){
								location.href="<%=basePath%>yp/admin/template/toEditUserTemplate.do?userTemplateId="+template.userTemplateId
								+"&path="+template.path+"&rootUserTemplateId="+template.rootUserTemplateId;
	                		});
						}else{
							bootbox.alert("删除成功",function(result){
								location.href="<%=basePath%>yp/admin/template/getUserTemplates.do";
							})
							
						}
					}
				});
			}
		})
	})
</script>
</html>