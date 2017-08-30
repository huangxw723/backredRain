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
<title>餐饮</title>
<base href="<%=basePath%>">
<meta name="description" content="overview & stats" />
<link href="static/template/css/sub.css" rel="stylesheet" type="text/css" />
<style>
    *{margin: 0;padding: 0;}
    .sub_div{width: 100%;float: left;text-align: center;margin-top: 20px}
    .clearfix:before, .clearfix:after {content: " ";display: table;}
    .clearfix:after {clear: both;}
    .cate{width: 1300px;padding: 10px;border: 0px solid #ccc;float: left;}
    .cate_detailed{width: 300px;height: 300px;float: left;position: relative;margin: 0 5px 5px 0;}
    .cate_detailed:nth-child(4n+0){margin-right: 0}
    .cate_detailed img{width: 100%;height: 100%;}
    .cate_detailed > input{position: absolute;top: 0;left: 0;background: #FFFF99;border: 1px solid #ccc;width: 45px;height: 20px;border-radius: 5px;}
    .seat{width: 100%;height: 50px;background: rgba(0,0,0,.3);position: absolute;bottom: 0;color:#FFF;}
    .head_portrait{float: left;margin: 2px 5px;}
    .head_portrait img{width: 40px;height: 40px;display: block;}
    .introduce{margin-top: 2px;float: left;}
    .introduce h3{font-size: 14px}
    .introduce p{font-size: 12px;}
    .seat_nav{float: left;padding-top: 13px;}
    .seat_nav input{width: 60px;height: 20px;background: #FFFF99;border: 1px solid #ccc;border-radius: 15px;}
    
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
<div style="float: left;width: 15%;">
	<ul id="tree" class="ztree" style="width: 90%;height:auto; "></ul>
</div>
	<div class="swiper-container" style="width: 1300px;float: left">
		<div class="swiper-wrapper">
			<div ng-repeat="page in pages track by $index" class="cate clearfix swiper-slide" style="width: 930px">
				<div class="cate_detailed" ng-repeat="data in setData($index)" repeat-finish>
					<img ng-src="{{imgHost+data.shop.shopImage}}" alt=""> 
					<input ng-click="toEditShop(data.businessModuleId)" type="button" name="" value="编辑">
					<div class="seat">
						<div class="head_portrait">
							<img ng-src="{{imgHost+data.shop.shopLogo}}" alt="">
						</div>
						<div class="introduce">
							<h3>{{data.shop.shopName == null?'- - - -':data.shop.shopName}}</h3>
							<p>
								{{key}}:<span>{{data.shop.major}}</span>
							</p>
							<p>
								店铺位置:<span>{{data.shop.location}}</span>
							</p>
						</div>
						<!-- <div class="seat_nav">
							<input type="button" name="" value="位置导航">
						</div> -->
					</div>
				</div>
				
			</div>
			<!-- <div class="cate clearfix swiper-slide" style="width: 900px;">
				<div class="cate_detailed" ng-repeat="data in datas">
					<img ng-src="{{imgHost+data.shop.shopImage}}" alt=""> 
					<input ng-click="toEditShop(data.businessModuleId)" type="button" name="" value="编辑">
					<div class="seat">
						<div class="head_portrait">
							<img ng-src="{{imgHost+data.shop.shopLogo}}" alt="">
						</div>
						<div class="introduce">
							<h3>{{data.shop.shopName == null?'- - - -':data.shop.shopName}}</h3>
							<p>
								{{key}}:<span>{{data.shop.major}}</span>
							</p>
							<p>
								店铺位置:<span>{{data.shop.location}}</span>
							</p>
						</div>
						<div class="seat_nav">
							<input type="button" name="" value="位置导航">
						</div>
					</div>
				</div>
				
			</div> -->
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
  var pageSize = 8;
  
  var data = '${businessModules}';
  //console.log(data);
  
  //angularJs
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
	  $scope.key="经营类目";
	  
	  $scope.datas = JSON.parse(data);
	  //分页逻辑
	  var total = JSON.parse(data).length/pageSize ;
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
	  
	  $scope.imgHost = imgHost;
	  $scope.toSelectImg = function(businessModuleId){
		  toSelectImg(businessModuleId);
	  }
	  $scope.toEditShop = function(businessModuleId){
		  toEditShop(businessModuleId,$scope.key);
	  }
  })
  
  function toEditShop(businessModuleId,key){
	  
		 top.jzts();
		 var diag = new top.Dialog();
		 diag.Drag=true;
		 diag.Title ="编辑店铺信息";
		 diag.URL = '<%=basePath%>yp/admin/template/toEditShop.do?businessModuleId='+businessModuleId+"&type=4&key="+key;
		 diag.Width = 1000;
		 diag.Height = 800;
		 diag.delCallback = function(){
			 history.go(0);
			 //$(div).css("background-size","cover");
		 }
		 diag.CancelEvent = function(refresh,data){ //关闭事件
			/* if(diag.innerFrame.contentWindow.document.getElementById('zhongxin').style.display == 'none'){
				nextPage(${page.currentPage});
			} */
			if(refresh){
				history.go(0);
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
  });
  
	  var swiper = new Swiper('.swiper-container', {
	      pagination: '.pagination',
	      paginationClickable: '.swiper-pagination',
	      nextButton: '.swiper-button-next',
	      prevButton: '.swiper-button-prev',
	      spaceBetween: 30
	  }); 
</script>
</html>