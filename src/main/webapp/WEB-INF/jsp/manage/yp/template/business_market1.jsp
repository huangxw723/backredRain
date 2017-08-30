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
	
	<script type="text/javascript" src="plugins/zTree/3.5/jquery.ztree.core.min.js"></script>
	<script type="text/javascript" src="plugins/zTree/3.5/jquery.ztree.excheck.min.js"></script>
	<script src="static/js/bootstrap.min.js"></script>
	<script type="text/javascript" src="static/js/bootbox.min.js"></script><!-- 确认窗口 -->
	<!-- <link type="text/css" rel="stylesheet" href="plugins/zTree/3.5/demo.css" /> -->
  	<link type="text/css" rel="stylesheet" href="plugins/zTree/3.5/zTreeStyle.css" />
  		<style type="text/css">
			.template1_left{
				width: 255px;
				height: 150px;
				border:1px solid gray;
				float: left;
				margin-top: 2px
			}
			.template1_middle1{
				width: 810px;
				/* height: 420px; */
				border:1px solid gray;
				float: left;margin-left: 2px;
				margin-right: 2px;
				margin-top: 2px
			}
			.template1_middle2{
				width: 810px;
				height: 88px;
				border:1px solid gray;
				float: left;margin-left: 2px;
				margin-right: 2px;
				margin-top: 2px
			}
			.template1_middle3{
				width: 402px;
				height: 188px;
				border:1px solid gray;
				float: left;margin-left: 2px;
				margin-right: 2px;
				margin-top: 2px
			}
			.template1_middle4{
				width: 403px;
				height: 188px;
				border:1px solid gray;
				float: left;margin-left: 2px;
				margin-right: 2px;
				margin-top: 2px
			}
			.template1_right{
				width: 260px;
				height: 150px;
				border:1px solid gray;
				float: left;
				margin-top: 2px
			}
			
			.on{
				border-color: red;
			}
			
			.left_content_div{
				    position: relative;
    				top: 100px;
    				padding-left: 70px
    				/* left: 7px; */
			}
			.left_content_div,.mid_content_div span{
				    color: #009688;
				    font-size: 25px;
			}
			
			.mid_content_div{
				    position: relative;
    				top: 137px;
    				padding-left: 140px;
			}
			.sub_div{
				width: 100%;float: left;text-align: center;margin-top: 20px
			}
			.template_list{
				width:100px
			}
			.ad{
				position: relative;
    			top: 60px;
			}
			.btn{
				display: inline-block;
			    padding: 0 12px 1px;
			    line-height: 32px;
			    color: #FFF!important;
			    text-shadow: 0 -1px 0 rgba(0,0,0,0.25)!important;
			    font-size: 14px;
			    background-image: none!important;
			    border: 5px solid #abbac3;
			    border-radius: 0!important;
			    box-shadow: none!important;
			    transition: all .1s ease-in-out;
			    cursor: pointer;
			    vertical-align: middle;
			    margin: 0;
			    position: relative;
			    color: red;
			    background-color: #8b9aa3!important;
			    border-color: #8b9aa3;
			}
		</style>
	</head>
	<script src="static/js/base64Compress.js"></script>
<body>
<div style="float: left;width: 8%;">
	<ul id="tree" class="ztree" style="width: 90%;height:auto; "></ul>
</div>

<form style="margin: 0 0" action="yp/admin/template/saveModuleContent.do" method="post" enctype="multipart/form-data">
<input type="hidden" name="businessTemplateId" value="${businessTemplate.businessTemplateId}">
<input type="hidden" name="path" value="${businessTemplate.path}">
<input type="hidden" name="moduleStr" id="moduleStr">
<div style="height: 772px;width: 1350px;border:1px solid gray;float: left">
	<div style="margin-left: 5px">
		<!-- left div begin-->
		<div style="height: 800px;width: 256px;float: left;">
			<div position="1" businessModuleId="" class="template1_left">
				<div>
					<a href="javascript:void(0)" style="float: left;" onclick="toSelectImg(1,'335*186')">编辑</a>
				</div>
				<div class="left_content_div">
					<span></span>
					<c:if test="${show }">
						<select class="template_list">
							<c:forEach items="${templates}" var="t">
								<option value="${t.businessTemplateId}">${t.templateName}</option>
							</c:forEach>
							
						</select>
					</c:if>
				</div>
				
			</div>
			<div  position="2" businessModuleId="" class="template1_left">
				<div>
					<a href="javascript:void(0)" style="float: left;" onclick="toSelectImg(2,'335*186')">编辑</a>
				</div>
				<div class="left_content_div">
					<span></span>
					<c:if test="${show }">
						<select class="template_list">
							<c:forEach items="${templates}" var="t">
								<option value="${t.businessTemplateId}">${t.templateName}</option>
							</c:forEach>
							
						</select>
					</c:if>
				</div>
			</div>
			<div  position="3" businessModuleId="" class="template1_left">
				<div>
					<a href="javascript:void(0)" style="float: left;" onclick="toSelectImg(3,'335*186')">编辑</a>
				</div>
				<div class="left_content_div">
					<span></span>
					<c:if test="${show }">
						<select class="template_list">
							<c:forEach items="${templates}" var="t">
								<option value="${t.businessTemplateId}">${t.templateName}</option>
							</c:forEach>
							
						</select>
					</c:if>
				</div>
				
			</div>
			<div  position="4" businessModuleId="" class="template1_left">
				<div>
					<a href="javascript:void(0)" style="float: left;" onclick="toSelectImg(4,'335*186')">编辑</a>
				</div>
				<div class="left_content_div">
					<span></span>
					<c:if test="${show }">
						<select class="template_list">
							<c:forEach items="${templates}" var="t">
								<option value="${t.businessTemplateId}">${t.templateName}</option>
							</c:forEach>
							
						</select>
					</c:if>
				</div>
				
			</div>
			<div  position="5" businessModuleId="" class="template1_left">
				<div>
					<a href="javascript:void(0)" style="float: left;" onclick="toSelectImg(5,'335*186')">编辑</a>
				</div>
				<div class="left_content_div">
					<span></span>
					<c:if test="${show }">
						<select class="template_list">
							<c:forEach items="${templates}" var="t">
								<option value="${t.businessTemplateId}">${t.templateName}</option>
							</c:forEach>
							
						</select>
					</c:if>
				</div>
				
			</div>
			
		</div>
		<!-- left div end-->
		
		<!-- middle div begin-->
		<div style="height: 800px;width: 820px;float: left;">
			
			<div position="6" businessModuleId="" class="template1_middle1">
				<a href="javascript:void(0)" style="float: left;" onclick="toSelectVideo(6)">浏览视频文件</a>
				<video id="media" width="100%" height="95%" controls loop >
                    <source src="" type="video/mp4" />
                    <source src="" type="video/ogg" />
                </video>
			</div>
			<div class="template1_middle2" position="7" businessModuleId="">
				<!-- <input class="ad" name="content" placeholder="请输入广告内容"/> -->
				<a href="javascript:void(0)" style="float: left;" onclick="toEditAd(7)">编辑</a>
				<span class="ad"></span>
				
			</div>
			<div class="template1_middle3"  position="8" businessModuleId="">
				<div>
					<a href="javascript:void(0)" style="float: left;" onclick="toSelectImg(8,'610*200')">编辑</a>
				</div>
				<div class="mid_content_div">
					<span></span>
					<c:if test="${show }">
						<select class="template_list">
							<c:forEach items="${templates}" var="t">
								<option value="${t.businessTemplateId}">${t.templateName}</option>
							</c:forEach>
							
						</select>
					</c:if>
				</div>
			</div>
			<div class="template1_middle4" onclick="setText(this)" position="9" businessModuleId="">
				<div>
					<a href="javascript:void(0)" style="float: left;" onclick="toSelectImg(9,'610*200')">编辑</a>
				</div>
				<div class="mid_content_div">
					<span></span>
					<c:if test="${show }">
						<select class="template_list">
							<c:forEach items="${templates}" var="t">
								<option value="${t.businessTemplateId}">${t.templateName}</option>
							</c:forEach>
							
						</select>
					</c:if>
				</div>
			</div>
		</div>
		<!-- middle div end-->
		
		<!-- right div begin-->
		<div style="height: 500px;width: 261px;float: left;">
			<c:if test="${not empty templateFixeds}">
				<c:forEach items="${templateFixeds}" var="f">
				<div class="template1_right" style='background: url("<%=httpUrl%>${f.backgroundImage }");
					background-size: cover;'>
					<c:if test="${show }">
						<a href="javascript:void(0)" style="float: left;" onclick="toSelectFixedImg(${f.templateFixedId})">编辑</a>
					</c:if>
				</div>
				</c:forEach>
			</c:if>
		</div>
		<!-- right div end-->
	</div>
</div>
</form>


<div class="sub_div" >
	<input class="btn" type="button" id="preview" value="预览模版">
	<c:if test="${show }">
		<input class="btn" type="button" id="delBtn" value="删除该模版">
	</c:if>
	<input class="btn" type="button" id="subBtn" value="保存">
</div>
</body>
<script>
//console.log('${treeData}');
function zTreeOnClick(event,treeId,treeNode){
	//console.log(treeNode.businessTemplateId);
	
	if(!treeNode.checked){
		location.href="<%=basePath%>yp/admin/template/toEditBusinessTemplate.do?businessTemplateId="+treeNode.businessTemplateId;
	}else{
		if(treeNode.level == 0){
			top.jzts();
			 var diag = new top.Dialog();
			 diag.Drag=true;
			 diag.Title ="编辑";
			 diag.URL = '<%=basePath%>yp/admin/template/toEditTempName.do?businessTemplateId='+businessTemplateId;
			 diag.Width = 600;
			 diag.Height = 150;
			 diag.CancelEvent = function(flag){ //关闭事件
				diag.close();
			 	if(flag){
			 		setTimeout("self.location=self.location",100);
			 	}
				
			 };
			 diag.show();
		}
	}
			
}
 /**
  * 树的设置
  */
  
  var nodeStr = '${treeData}';
  //console.log(nodeStr);
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
				name:'templateName'
			}
		}
  };
	
  	var isAdmin = '${show}';
  
  	var businessTemplateId = "${businessTemplate.businessTemplateId}";
	var rootBusinessTemplateId = "${businessTemplate.rootBusinessTemplateId}";
	if(rootBusinessTemplateId==0 || rootBusinessTemplateId==""||rootBusinessTemplateId==null){
		rootBusinessTemplateId = businessTemplateId;
	}
	var data = '${businessModules}';
	//console.log(data);
	if(data != undefined && data != "" && data !="[]"){
		var userModules = JSON.parse(data);
		$.each(userModules,function(index,value){
			var businessModuleId = value.businessModuleId;//模块Id
			var position = value.position;//模块位置
			var type = value.type;//模块类型
			var backgroundImage = value.backgroundImage;//模块背景
			var content = value.content;//模块内容
			
			var div = $("div[position="+position+"]");
			$(div).attr("businessModuleId",businessModuleId);
			if(type==1){
				if(backgroundImage != undefined && backgroundImage !=""){
					$(div).css("background","url(<%=httpUrl%>"+backgroundImage+")");
					$(div).css("background-size","cover");
				}
				/* if(value.template != null && value.template.templateName != null){
					$(div).find("select").remove();
					$(div).find("span").text(value.template.templateName);
				} */
				if(value.template != null && value.template.templateName != null){
					//如果是商家，则不显示下拉框
					if(isAdmin){
						var opts = $(div).find("select option");
						$.each(opts,function(i,val){
							var text = $(val).text();
							if(value.template.templateName == text){
								$(val).attr("selected","selected");
								$(val).attr("current",1);
							}
						})
						
					}else{
						$(div).find("span").text(value.template.templateName);
					}
					
				}
				
			}else if(type==2){
				$(div).find(".ad").text(content);
			}else if(type==3 && content!=null && content != undefined && content != ""){
				$("source").attr("src","<%=httpUrl%>"+content);
				document.getElementById("media").load();
			}
			
		})
		$("div[businessModuleId='']").find("select").remove();
	}
	
	
	/* function setText1(_this){
		$("[position]").removeClass("on");
		$(_this).addClass("on");
	} */
	
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
	function toSelectImg(position,area){
		 var div = $("div[position="+position+"]");
		 var businessModuleId = $(div).attr("businessModuleId");
		 top.jzts();
		 var diag = new top.Dialog();
		 diag.Drag=true;
		 diag.Title ="选择图片";
		 diag.URL = '<%=basePath%>yp/admin/template/toSelectImg.do?businessModuleId='+businessModuleId+"&type=1&area="+area;
		 diag.Width = 800;
		 diag.Height = 400;
		 diag.delCallback = function(){
			 $(div).css("background","url('')");
			 //$(div).css("background-size","cover");
		 }
		 diag.CancelEvent = function(refresh,data){ //关闭事件
			/* if(diag.innerFrame.contentWindow.document.getElementById('zhongxin').style.display == 'none'){
				nextPage(${page.currentPage});
			} */
			if(data){
				$(div).css("background","url(<%=httpUrl%>"+data+")");
				$(div).css("background-size","cover");
			}
			if(refresh){
				history.go(0);
			}
			diag.close();
		 };
		 diag.show();
	}
	function toEditAd(position){
		var div = $("div[position="+position+"]");
		var businessModuleId = $(div).attr("businessModuleId");
		//var content = $(div).find(".ad").text();
		 top.jzts();
		 var diag = new top.Dialog();
		 diag.Drag=true;
		 diag.Title ="编辑广告";
		 diag.URL = '<%=basePath%>yp/admin/template/toEditAd.do?businessModuleId='+businessModuleId;
		 diag.Width = 800;
		 diag.Height = 400;
		 diag.CancelEvent = function(refresh,data){ //关闭事件
			/* if(diag.innerFrame.contentWindow.document.getElementById('zhongxin').style.display == 'none'){
				nextPage(${page.currentPage});
			} */
			if(data){
				$(div).find(".ad").text(data);
			}
			if(refresh){
				history.go(0);
			}
			diag.close();
		 };
		 diag.show();
	}
	//浏览本地视频
	function toSelectVideo(position){
		var div = $("div[position="+position+"]");
		var businessModuleId = $(div).attr("businessModuleId");
		
		top.jzts();
		 var diag = new top.Dialog();
		 diag.Drag=true;
		 diag.Title ="浏览";
		 diag.URL = '<%=basePath%>yp/admin/template/toSelectVideo.do?businessModuleId='+businessModuleId+"&type=3";
		 diag.Width = 800;
		 diag.Height = 400;
		 diag.CancelEvent = function(refresh,data){ //关闭事件
			/* if(diag.innerFrame.contentWindow.document.getElementById('zhongxin').style.display == 'none'){
				nextPage(${page.currentPage});
			} */
			if(data){
				$("source").attr("src","<%=httpUrl%>"+data);
				document.getElementById("media").load();
			}
			/* if(refresh){
				history.go(0);
			} */
			diag.close();
		 };
		 diag.show();
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
	
	function toSelectFixedImg(templateFixedId){
		top.jzts();
		 var diag = new top.Dialog();
		 diag.Drag=true;
		 diag.Title ="编辑图片";
		 diag.URL = '<%=basePath%>yp/admin/template/toSelectFixedImg.do?templateFixedId='+templateFixedId;
		 diag.Width = 800;
		 diag.Height = 500;
		 diag.CancelEvent = function(refresh,data){ //关闭事件
			if(refresh){
				history.go(0);
			}
			diag.close();
		 };
		 diag.show();
	}
	
	/* //预览模版
	function preview(){
		var businessTemplateId = "${businessTemplate.businessTemplateId}";
		var path = "${businessTemplate.path}";
		location.href=location.host+"/redRain/static/template/business/html/"+path+".html?businessTemplateId="+businessTemplateId;
	}  */
	
	//var submitFlag = false;
	$(document).ready(function(){
		zTreeObj = $.fn.zTree.init($("#tree"), setting, JSON.parse(nodeStr));
		
		$("#subBtn").on("click",function(){
			var div = $("div[position]");
			var moduleStr = [];
			$.each(div,function(index,value){
				var businessModuleId = $(value).attr("businessModuleId");
				var businessTemplateId = $(value).find("select").val();
				var isCurrent = $(value).find("select option[value="+businessTemplateId+"]").attr("current");
				var text = $(value).find("select option[value="+businessTemplateId+"]").text();
				if(businessTemplateId !="" && businessTemplateId != undefined){
					if(isCurrent != 1){
						moduleStr.push({
							businessModuleId:businessModuleId,
							rootBusinessTemplateId:rootBusinessTemplateId,
							businessTemplateId:businessTemplateId
							
						});
					}
					
				}
				
			})
			console.log(JSON.stringify(moduleStr));
			if(moduleStr.length == 0){
				return ;
			}
			$.ajax({
				type: "POST",
				url: '<%=basePath%>yp/admin/template/saveMyBusinessTemplate.do',
		    	data: {moduleStr:JSON.stringify(moduleStr)},
				dataType:'json',
				//beforeSend: validateData,
				cache: false,
				success: function(data){
					if(data){
						bootbox.alert("保存成功",function(result){
                			history.go(0);
                		});
					}else{
						alert("系统繁忙");
					}
				}
			});
		})
		
		$("#delBtn").on("click",function(){
			
			if(confirm("确认删除该模版吗?")){
				$.ajax({
					type: "POST",
					url: '<%=basePath%>yp/admin/template/delBusinessTemplate.do',
			    	data: {businessTemplateId:businessTemplateId},
					dataType:'json',
					//beforeSend: validateData,
					cache: false,
					success: function(data){
						if(data.msg){
							bootbox.alert(data.msg,function(result){
	                			
	                		});
						}else if(data.rootBusinessTemplateId){
							bootbox.alert("删除成功",function(result){
								location.href="<%=basePath%>yp/admin/template/getSysTemplates.do";
	                		});
						}else{
							//top.mainFrame.tab.close(businessTemplateId);
							$("#" + businessTemplateId).find(".tab_close").trigger("click");
							bootbox.alert("删除成功",function(result){
								top.mainFrame.tab.close(businessTemplateId);
	                		});
							<%-- location.href="<%=basePath%>yp/admin/template/getSysTemplates.do"; --%>
						}
					}
				});
			}
		})
		$("#preview").on("click",function(){
			var businessTemplateId = "${businessTemplate.businessTemplateId}";
			//var path = "${businessTemplate.path}";
			var path = "${businessTemplate.path}";
			var url = "<%=basePath%>yp/admin/template/preview?path="+path+"&businessTemplateId="+businessTemplateId;
			//var url = "http://"+location.host+"/redRain/template/html/"+path+".html?businessTemplateId="+businessTemplateId;
			//location.href=url;
			window.open(url);
		})
	})
</script>
</html>