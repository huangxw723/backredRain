<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.aoshi.util.PropertyUtils"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
	String httpUrl = PropertyUtils.getHTTP_URL();
%>
<html lang="en">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>招商</title>
<base href="<%=basePath%>">
<meta name="description" content="overview & stats" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<!-- 
<link href="static/template/css/style.css" rel="stylesheet" type="text/css" />
    <link href="static/template/css/sub.css" rel="stylesheet" type="text/css" />
<link href="static/template/css/pgwslider.min.css" rel="stylesheet"> -->
<link href="static/template/css/sub.css" rel="stylesheet" type="text/css" />
<style>
     *{margin: 0;padding: 0;}
     .sub_div{width: 100%;float: left;text-align: center;margin-top: 20px}
     .clearfix:before, .clearfix:after {content: " ";display: table;}
     .clearfix:after {clear: both;}
     .investment{}
     .detailed{width: 625px;height: 300px;border: 1px solid #ccc;padding: 5px;float: left;margin: 0 10px 10px 0;}
     .detailed:nth-child(2n+0){margin-right: 0}
     .detailed_left{float: left;width: 75%;height: 100%;position: relative;}
     .detailed_left img{width: 99%;height: 100%;display: block;}
     .input_box{position: absolute;width: 99%;bottom: 0;left: 0;background: #66FFFF;}
     .input_type{font-size: 12px;width: 50%;float: left;}
     .input_type input,.input_type select{width: 50%;}
     .detailed_right{float: right;width: 25%;height: 100%;}
     .edit{height: 33%;position: relative;margin-bottom: 1px;}
     .edit input{width: 45px;height: 20px;border-radius: 5px;position: absolute;top: 0;background: #FFFF99;border: 1px solid #ccc;}
     .detailed_right img{width: 100%;height: 100%;display: block;}
</style>
<script type="text/javascript" src="static/js/jquery-1.7.2.js"></script>
<script src="static/js/bootstrap.min.js"></script>
<script src="static/js/angular.min.js"></script>
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

   <div class="investment clearfix">
     	<div class="detailed" position="{{$index+1}}" ng-repeat=" data in datas">
			<div class="detailed_left" businessModuleId="{{data.businessModuleId}}">
				<img name="show" ng-src="{{getDefaultImg(data.children)}}" alt="">
				<div class="input_box">
					<div class="input_type">
						商铺地址<input name="address" type="text" value="{{data.investMent.address}}">
					</div>
					<div class="input_type">
						商铺大小 <input name="size" type="text" value="{{data.investMent.size}}"> M
					</div>
					<div class="input_type">
						商铺类型 
						<select name="shopType">
								<option ng-selected="'办公' == data.investMent.shopType" value="办公">办公</option>
								<option ng-selected="'铺位' == data.investMent.shopType" value="铺位">铺位</option>
						</select>
					</div>
					<div class="input_type">
						商铺租金 <input name="rent" type="text" value="{{data.investMent.rent}}">/月
					</div>
				</div>
			</div>
			<div class="detailed_right">
				<div class="edit" position="1" ng-click="showImg(data.children,$event)">
					<img ng-src="{{getImg(data.children,1)}}" alt=""> <input ng-click="editImg(data.businessModuleId,1,$event)" type="button" value="编辑">
				</div>
				<div class="edit" position="2" ng-click="showImg(data.children,$event)">
					<img ng-src="{{getImg(data.children,2)}}" alt=""> <input ng-click="editImg(data.businessModuleId,2,$event)" type="button" value="编辑">
				</div>
				<div class="edit" position="3" ng-click="showImg(data.children,$event)">
					<img ng-src="{{getImg(data.children,3)}}" alt=""> <input ng-click="editImg(data.businessModuleId,3,$event)" type="button" value="编辑">
				</div>
			</div>
		</div>
	</div>
	<div class="sub_div" >
		<c:if test="${show }">
			<input class="btn" type="button" id="delBtn" value="删除该模版">
		</c:if>
		<input class="btn" type="button" id="subBtn" value="保存">
	</div>
	
</body>
	
<script type="text/javascript">
function zTreeOnClick(event,treeId,treeNode){
	console.log(treeNode.businessTemplateId);
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
  
  var data = '${businessModules}';
  //console.log(data);
  var imgHost = "<%=httpUrl%>";
  angular.module("app",[]).controller("myCtrl",function($scope){
	  $scope.datas = JSON.parse(data);
	  //$scope.imgHost = imgHost;
	  
	  $scope.showImg = function(children,evt){
		  var target = evt.target;
		  var img = target.src;
		  if(img != "" && img != null && img != undefined){
			  $(target).parents(".detailed_right").parents(".detailed").find("img[name=show]").attr("src",img);
		  }
	  }
	  
	  $scope.getImg = function(data,position){
		  var img = "";
		  angular.forEach(data,function(value,index){
			  if(angular.equals(value.position,position)&&value.backgroundImage!=null){
				  img = imgHost+value.backgroundImage;
			  }
		  })
		  if(img!=""){
			  return img;
		  }
		 
	  }
	  
	  $scope.getDefaultImg = function(data){
		  var img = "";
		  var flag = false ;
		  angular.forEach(data,function(value,index){
			  if(!flag){
				  if(value.backgroundImage!=null){
					  img = imgHost+value.backgroundImage;
					  flag = true;
				  }
			  }
			  
		  })
		  return img;
	  }
	  
	  $scope.editImg = function(businessModuleId,position,evt){
		  	 var target = evt.target;
		  	 top.jzts();
			 var diag = new top.Dialog();
			 diag.Drag=true;
			 diag.Title ="选择图片";
			 diag.URL = '<%=basePath%>yp/admin/template/toSelectInvestImg.do?businessModuleId='+businessModuleId+"&position="+position;
			 diag.Width = 800;
			 diag.Height = 400;
			 diag.CancelEvent = function(refresh,data){ //关闭事件
				/* if(diag.innerFrame.contentWindow.document.getElementById('zhongxin').style.display == 'none'){
					nextPage(${page.currentPage});
				} */
				if(data){
					$(target).siblings().attr("src","<%=httpUrl%>"+data);
				}
				if(refresh){
					history.go(0);
				}
				diag.close();
			 };
			 diag.show();
	  }
  })
  
  
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
		});
	  
	  $("#subBtn").on("click",function(){
			var div = $(".detailed_left");
			var moduleStr = [];
			
			$.each(div,function(index,value){
				
				var businessModuleId =  $(value).attr("businessModuleId");
				var address = $(value).find("input[name=address]").val();
				var size = $(value).find("input[name=size]").val();
				var shopType = $(value).find("select[name=shopType]").val();
				var rent = $(value).find("input[name=rent]").val();
				
				moduleStr.push({
					businessModuleId:businessModuleId,
					address:address,
					size:size,
					shopType:shopType,
					rent:rent
				});
				
			})
			//console.log(JSON.stringify(moduleStr));
			$.ajax({
				type: "POST",
				url: '<%=basePath%>yp/admin/template/saveInvestment.do',
		    	data: {str:JSON.stringify(moduleStr)},
				dataType:'json',
				//beforeSend: validateData,
				cache: false,
				success: function(data){
					if(data){
						alert("保存成功");
					}
				}
			});
		})
  })
</script>
</html>