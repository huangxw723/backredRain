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
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>场内</title>
<base href="<%=basePath%>">
<meta name="description" content="overview & stats" />
<link href="static/template/css/sub.css" rel="stylesheet" type="text/css" />
<style>
    *{margin: 0;padding: 0;}
    .sub_div{width: 100%;float: left;text-align: center;margin-top: 20px}
    .clearfix:before, .clearfix:after {content: " ";display: table;}
    .clearfix:after {clear: both;}
    .nominate{border: 0px solid #ccc;width: 840px;padding: 10px 20px;float: left;}
    .nominate_classify{width: 300px;height: 600px;position: relative;float: left;margin-right: 10px;}
    .nominate_classify:nth-child(4n+0){margin: 0}
    .classify_box{height: 100%;}
    .classify_box img{width: 100%;height: 100%;display: block;}
    .type_back{width: 100%;height: 80px;background: url('static/template/images/demo.png') no-repeat;opacity: .8;position: absolute;bottom: 0;}
    .edit{position: absolute;top: 0;left: 0;}
    .edit input{width: 45px;height: 20px;border-radius: 5px;background: #FFFF99;border: 1px solid #ccc;}
  
  	.pagination span{
    	width: 18px;
    	height: 18px
    }
    .page_div{width: 100%;float: left;text-align: center;margin-top: 20px}
  </style>
<script type="text/javascript" src="static/js/jquery-1.7.2.js"></script>
<script src="static/js/bootstrap.min.js"></script>
<script src="static/js/angular.min.js"></script>
<script src="static/template/js/swiper.js"></script>
<script type="text/javascript" src="plugins/zTree/3.5/jquery.ztree.core.min.js"></script>
<script type="text/javascript" src="plugins/zTree/3.5/jquery.ztree.excheck.min.js"></script>
<script type="text/javascript" src="static/js/bootbox.min.js"></script><!-- 确认窗口 -->
<!-- <link type="text/css" rel="stylesheet" href="plugins/zTree/3.5/demo.css" /> -->
 <link type="text/css" rel="stylesheet" href="plugins/zTree/3.5/zTreeStyle.css" />
 
</head>
<body ng-app="app" ng-controller="myCtrl">
<div style="float: left;width: 15%;height: 50%">
	<ul id="tree" class="ztree" style="width: 90%;height:auto; "></ul>
</div>
<div class="swiper-container" style="width: 1350px;float: left">
   <div class="swiper-wrapper">
	   <div ng-repeat="page in pages track by $index" class="nominate clearfix swiper-slide">
		     <div ng-repeat="data in setData($index)" repeat-finish>
			     <div class="nominate_classify">
			       <div class="classify_box" businessModuleId="{{data.businessModuleId}}">
			         <img ng-src="{{imgHost+data.backgroundImage}}" alt="">
			       </div>
			       <!-- <div class="type_back"></div> -->
			       <div class="edit">
			         <input ng-click="toSelectImg(data.businessModuleId)" type="button" name="" value="编辑">
			       </div>
			     </div>
	     	</div>
	   </div>
	   
   </div>
</div>
   <div class="page_div" >
		<div class="pagination" style="text-align: center;"></div>
		<!-- <input type="button" id="delBtn" value="删除该模版"> -->
	</div>
	<div class="sub_div">
		<c:if test="${show }">
			<input class="btn" type="button" id="delBtn" value="删除该模版">
		</c:if>
		<input class="btn" type="button" id="addBtn" onclick="addNextPage()" value="添加下一页数据">
		<input class="btn" type="button" onclick="delModule()" value="删除该页数据">
	</div>
</body>
<script type="text/javascript">
function zTreeOnClick(event,treeId,treeNode){
	if(!treeNode.checked){
		location.href="<%=basePath%>yp/admin/template/toEditBusinessTemplate.do?businessTemplateId="+treeNode.businessTemplateId;
	}
			
}
 /**
  * 树的设置
  */
  var businessTemplateId = "${businessTemplate.businessTemplateId}";
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
  var pageNum = 1;
  var pageSize = 4;
  var data = '${businessModules}';
  //console.log(data);
  var imgHost = "<%=httpUrl%>";
  var app =   angular.module("app",[]);
  app.directive('repeatFinish',function(){
	    return {
	        link: function(scope,element,attr){
	        	swiper.updateSlidesSize();
				swiper.updatePagination();
				swiper.updateClasses();
	        }
	    }
  })
  app.controller("myCtrl",function($scope){
	  $scope.datas = JSON.parse(data);
	  $scope.imgHost = imgHost;
	  //分页逻辑
	  var total = $scope.datas.length/pageSize ;
	  var pages = new Array(total);
	  for(var i=0;i<pages.length;i++){
		  pages[i] = 1;
	  }
	  $scope.pages = pages;
	  
	  $scope.setData = function(index){
		  var no = index + 1;
		  var begin = (no-1) * pageSize;
		  var end = no*pageSize;
		  /* setTimeout(function(){
			  
		  },1000); */
		  //console.log(JSON.stringify($scope.datas.slice(begin,end)));
		  return $scope.datas.slice(begin,end);
		 
	  }
	  $scope.toSelectImg = function(businessModuleId){
		  toSelectImg(businessModuleId);
	  }
  })
  function toSelectImg(businessModuleId){
	  
		 top.jzts();
		 var diag = new top.Dialog();
		 diag.Drag=true;
		 diag.Title ="选择图片";
		 diag.URL = '<%=basePath%>yp/admin/template/toSelectImg.do?businessModuleId='+businessModuleId+"&type=6&area=383*747";
		 diag.Width = 800;
		 diag.Height = 400;
		 diag.delCallback = function(){
			 $("div[businessModuleId="+businessModuleId+"]").find("img").attr("src","");
			 //$(div).css("background-size","cover");
		 }
		 diag.CancelEvent = function(refresh,data){ //关闭事件
			/* if(diag.innerFrame.contentWindow.document.getElementById('zhongxin').style.display == 'none'){
				nextPage(${page.currentPage});
			} */
			if(data){
				$("div[businessModuleId="+businessModuleId+"]").find("img").attr("src","<%=httpUrl%>"+data);
				//$(div).css("background-size","cover");
			}
			
			diag.close();
		 };
		 diag.show();
	  
  }
  
  function addNextPage(){
	  if(confirm("确认添加数据吗?")){
		  $.ajax({
				type: "POST",
				url: '<%=basePath%>yp/admin/template/addNextPage.do',
		    	data: {businessTemplateId:businessTemplateId},
				dataType:'json',
				//beforeSend: validateData,
				cache: false,
				success: function(data){
					if(data){
						history.go(0);
					}
				}
			});
	  }
  }
  
  function delModule(){
	  var spans = $(".swiper-pagination-bullet");
	  var pageNum = 0;
	  $.each(spans,function(index,value){
		  var className = $(value).attr("class");
		  if(className.indexOf("active")>0){
			  pageNum = index + 1;
		  }
	  })
	  if(pageNum == 0){
		  return ;
	  }
	  if(confirm("确认删除吗?")){
		  $.ajax({
				type: "POST",
				url: '<%=basePath%>yp/admin/template/delModule.do',
		    	data: {businessTemplateId:businessTemplateId,pageNum:pageNum,pageSize:pageSize},
				dataType:'json',
				//beforeSend: validateData,
				cache: false,
				success: function(data){
					if(data.status){
						alert("删除成功");
						history.go(0);
					}else{
						alert(data.msg);
					}
				}
			});
	  }
	  
		
  }
  
  $(document).ready(function(){
	  zTreeObj = $.fn.zTree.init($("#tree"), setting, JSON.parse(nodeStr));
	  
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
							alert(data.msg);
						}else if(data.rootBusinessTemplateId){
							alert("删除成功");
							location.href="<%=basePath%>yp/admin/template/toEditBusinessTemplate.do?businessTemplateId="
										+data.rootBusinessTemplateId;
						}else{
							alert("系统繁忙");
						}
					}
				});
			}
		})
  })
  var swiper = new Swiper('.swiper-container', {
	      pagination: '.pagination',
	      paginationClickable: '.swiper-pagination',
	      nextButton: '.swiper-button-next',
	      prevButton: '.swiper-button-prev',
	      spaceBetween: 30
	  });
</script>
</html>