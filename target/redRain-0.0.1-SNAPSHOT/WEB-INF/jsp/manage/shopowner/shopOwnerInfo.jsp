
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.aoshi.util.PropertyUtils"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
	String httpUrl = PropertyUtils.getHTTP_URL();
%>
<!DOCTYPE html>
<html lang="en">
<head>
<base href="<%=basePath%>">
<%@ include file="../../system/admin/top.jsp"%>
<script type="text/javascript" src="http://api.map.baidu.com/api?v=2.0&ak=jGRH9RCPqXgfsrr2jyMLzhk1jKactdvj"></script>
<script type="text/javascript" src="static/js/common/commonutils.js"></script>

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
		<link rel="stylesheet" href="static/css/datepicker.css" /><!-- 日期框 -->
		<!--引入弹窗组件start-->
		<script type="text/javascript" src="plugins/attention/zDialog/zDrag.js"></script>
		<script type="text/javascript" src="plugins/attention/zDialog/zDialog.js"></script>
		<!--引入弹窗组件end-->
		<!--提示框-->
		<script type="text/javascript" src="static/js/jquery.tips.js"></script>

        <style type="text/css">
        #l-map{height:500px;width:90%;  margin-left: 20px;}
        #r-result{width:100%;}
        </style>

    <script type="text/javascript" >
        $(top.hangge());
           
        function shopStatus(id,auditStatus,status){
    		bootbox.confirm("确认通过？", function(result) {
    			if(result){			
    				if($("#reason").val()=="0-50个字"||$.trim($("#reason").val())==""){					
    					$("#reason").val('');			
    				}
    				if($("#reason").val().length>50){
    					$("#reason").tips({
    						side:3,
    			            msg:'字数不能超过50',
    			            bg:'#AE81FF',
    			            time:2
    			        });
    					$("#reason").focus();
    					return false;
    				}
    				
    				$("#shopOwnerInfoId").val(parseInt(id));
    				$("#auditStatus").val(parseInt(auditStatus))
    				$("#status").val(parseInt(status))
    				$("#shopForm").submit();
    				$("#zhongxin").hide();  
    				$("#zhongxin2").show();
    				
    			}
    			
    		});
    		
    	   }

    	
    	function shopStatus2(id,auditStatus,status){
    		bootbox.confirm("确认拒绝？", function(result) {
    			if(result){
    				if($("#reason").val()=="0-50个字"||$.trim($("#reason").val())==""){
    					$("#reason").tips({
    						side:3,
    			            msg:'请填写拒绝理由',
    			            bg:'#AE81FF',
    			            time:2
    			        });
    					$("#reason").focus();
    					return false;
    				}
    				if($("#reason").val().length>50){
    					$("#reason").tips({
    						side:3,
    			            msg:'字数不能超过50',
    			            bg:'#AE81FF',
    			            time:2
    			        });
    					$("#reason").focus();
    					return false;
    				}
    				$("#shopOwnerInfoId").val(parseInt(id));
    				$("#auditStatus").val(parseInt(auditStatus))
    				$("#status").val(parseInt(status))
    				$("#shopForm").submit();    			
    				$("#zhongxin").hide();
    				$("#zhongxin2").show();
    				
    			}
    			
    		});
    		
    	}
    	
    	

        //核审理由文本域显示
        
        $(function(){  
                    var t = $('#reason'); //获取到文本域对象  
                    t.css("color","#A9A9A9"); //设置文本域的样式  
                    t.val("0-50个字"); //设置默认显示文字  
                    var default_value = t.val(); //把默认显示的文字赋给一个变量  
                      
                    t.focus(function() {  //当鼠标点击文本域时修改文本域的样式，判断文本域内的文字是否等于默认值，如果等于就把文本域内设空  
                        t.css("color","black");  
                        if (t.val() == default_value) {  
                            t.val('');  
                        }  
                    });  
      
                    t.blur(function() { //当文本域失去鼠标焦点时判断文本域中的值是否为空，如果为空就把文本域的值设置为默认显示的文字并修改样式  
                        t.css("color","black");  
                        if (t.val() == '') {  
                            t.val(default_value);  
                            t.css("color","#A9A9A9");  
                        }  
                    });  
      
                });  
     
    </script>

</head>
<body>
  <form action="shopowner/updateStatus.do" name="shopForm" id="shopForm" method="post">    
      <input type="hidden" name="action" id="action" value="${action}" />
      <input type="hidden" name="status" id="status" value="${status}" />
      <input type="hidden" name="shopId" id="shopId" value="${shopDate.shopId}" />
      <input type="hidden" name="shopOwnerInfoId" id="shopOwnerInfoId"value="${shopOwnerInfoId}" />
      <input type="hidden" name="auditStatus" id="auditStatus"/>
      <input type="hidden" name="vbusinessDistrictId" id="vbusinessDistrictId" value=""/>
      <div id="zhongxin">
      <table id="table_report" class="table table-striped table-bordered table-hover">
       <tr>
          <th>商户类型:</th>
          <td>
             <select class="chzn-select"  name="shopType" id="shopType" disabled="disabled">       
                <option value="1" <c:if test="${shopDate.type == 1}">selected="selected"</c:if>>商场</option>
                <option value="2" <c:if test="${shopDate.type == 2 }">selected="selected"</c:if>>店铺</option>            
            </select>
          </td>
        </tr>
        <tr>
            <th>商户名称:</th>
            <td>                     
             <input name="name" id="name" type="text" value="${shopDate.name}" disabled="disabled">       
            </td>
        </tr>
        <c:if test="${shopDate.type == '1'}">
        <tr>
           <th>类型:</th>
             <td>
               <select class="chzn-select"  disabled="disabled">
                  <c:forEach items="${baseTypes }" var="va">
                   <option value="${va.id}" <c:if test="${va.id ==shopDate.tradeCategoryId }">selected="selected"</c:if>> ${va.name }</option>
                  </c:forEach>
               </select>
            </td>
          </tr>
          </c:if>
        <c:if test="${shopDate.type == '2'}">
		      <tr>
				<th>行业类型:</th>
				<td><select class="chzn-select" 
				name="tradeCategoryId" id="tradeCategoryId"
				disabled="disabled">
				<c:forEach items="${baseTypes }" var="va">
				<option value="${va.id}"
					<c:if test="${va.id ==shopDate.tradeCategoryId }">selected="selected"</c:if>>${va.name }</option>
				</c:forEach>
				</select></td>
				</tr>
		</c:if>
      
        <tr>
			<th>商户logo:</th>
			<td>
			<c:if test="${shopDate == null || shopDate.logoUrl== '' || shopDate.logoUrl == null }">
                <a id="imgBox" href="javascript:void(0)">
                <img src="" width="150" id="imgHref" />
                </a>
               
            </c:if>
            <c:if test="${shopDate != null && shopDate.logoUrl != '' && shopDate.logoUrl != null }">
	        <a id="imgBox" href="<%=httpUrl%>${shopDate.logoUrl}" title="商户logo" name="_previewLink" >
	            <img src="<%=httpUrl%>${shopDate.logoUrl}" alt="商户logo" width="150" id="imgHref" name="_preview"/>
	        </a>		    	              
	        </c:if>               
            </td>
		</tr>      
            <tr>
                <th>商户背景图:</th>
                <td>
                <c:if test="${shopDate == null || shopDate.logoUrl== '' || shopDate.logoUrl == null }">
                    <a id="imgBoxBg" href="javascript:void(0)">
                    <img src="" width="150" id="imgHrefBg" />
                    </a>
                   
                </c:if>
                 <c:if test="${not empty shopPics }">
                          <c:forEach items="${shopPics}" var="var">
                              <a id="imgBoxBg" href="<%=httpUrl%>${var.picUrl}"  name="_previewLink" >
                                  <img src="<%=httpUrl%>${var.picUrl}" alt="商户背景图" width="150" id="imgHrefBg" name="_preview"/>
                              </a>
                          </c:forEach>
                </c:if>             
                </td>
            </tr>
          
		<tr>
			<th>商户二维码:</th>
			<td>
			<c:if test="${shopDate == null || shopDate.qrCodeUrl== '' || shopDate.qrCodeUrl == null }">
                <a id="imgBoxEw" href="javascript:void(0)">
                <img src="" width="150" id="imgHrefEw" />
                </a>               
            </c:if>
            <c:if test="${shopDate != null && shopDate.qrCodeUrl != '' && shopDate.qrCodeUrl != null }">
	        <a id="imgBoxEw" href="<%=httpUrl%>${shopDate.qrCodeUrl}" title="商户二维码" name="_previewLink" >
	            <img src="<%=httpUrl%>${shopDate.qrCodeUrl}" alt="商户二维码" width="150" id="imgHrefEw" name="_preview"/>
	        </a>		    	             
	        </c:if>                            
            </td>
		</tr>
         
        <tr>
          <th>联系人:</th>
          <td>
              <input type="text" style="width:90%;"  name="contact" id="contact" value="${shopDate.contact }" disabled="disabled" />
          </td> 
        </tr>
		<tr>          
          <th>联系电话 :</th>
          <td>
              <input type="text" style="width:90%;"  name="tel" id="tel" value="${shopDate.tel }" disabled="disabled"/>
          </td>
        </tr>
		<tr>          
          <th>联系邮箱:</th>
          <td>
              <input type="text" style="width:90%;" name="contactMail" id="contactMail" value="${shopDate.contactMail }" disabled="disabled" />
          </td>
        </tr> 
        <c:if test="${shopDate.type == 2 }">           
       <tr >
          <th>商户地址:</th>
          <td>
            <select class="chzn-select" name="provinceId" id="provinceId"  style="vertical-align:top;" disabled="disabled">               
                <c:forEach items="${provinceList}" var="var">
                <option value="${var.provinceId }" <c:if test="${var.provinceId == shopDate.provinceId }">selected</c:if>>${var.provinceName }</option>
              </c:forEach>
            </select>
            <select class="chzn-select" name="cityId" id="cityId"  style="vertical-align:top;" disabled="disabled">                           			       
					    <c:forEach items="${cityList}" var="vc">
						    <option value="${vc.cityId}" <c:if test="${vc.cityId == shopDate.cityId }">selected</c:if>>${vc.cityName }</option>
						</c:forEach>				
            </select>
            <select class="chzn-select" name="areaId" id="areaId"  style="vertical-align:top; width: 204px;" disabled="disabled">            		   			    
				    <c:forEach items="${areaList}" var="var">
					    <option value="${var.areaId }"
					<c:if test="${var.areaId == shopDate.areaId }">selected</c:if>>${var.areaName }</option>
					</c:forEach>
				   
            </select>
            <select class="chzn-select" name="businessDistrictId" id="businessDistrictId"  style="vertical-align:top;" disabled="disabled" >      						
						    <c:forEach items="${businessDistrictList}" var="vr">
								<option value="${vr.businessDistrictId }"
						<c:if test="${vr.businessDistrictId == shopDate.businessDistrictId }">selected</c:if>>${vr.name }</option>
							</c:forEach>
				       
            </select>
          </td>
        </tr>     
        <tr>
        <th>商场:</th>
         <td>
          <select class="chzn-select" name="storId" id="storId" style="vertical-align:top;" disabled="disabled">
            <c:if test="${shopDate.storeId != 0}">
            <c:forEach items="${storList}" var="va">
               <option value="${va.name}_${va.storeId}" <c:if test="${va.storeId ==shopDate.storeId }">selected="selected"</c:if>> ${va.name }</option>               
            </c:forEach>
            </c:if>
            <c:if test="${shopDate.storeId == 0}">
               <option value="">无</option>
            </c:if>
          </select>
          </td>
        </tr>       
         <tr >
		<th>所在楼层:</th>
	        <td>
		    <select class="chzn-select"  name="floor" id="floor" disabled="disabled">
			    <c:forEach items="${floorList }" var="var">
				    <option value="${var}" <c:if test="${var == shopDate.floor}">selected="selected"</c:if>>${var}</option>
				</c:forEach>
			</select>
			楼			
		</tr>		
		<tr>
             <th>店铺编号:</th>
              <td>
                  <input name="region" id="region" type="text" value="${shopDate.region}" disabled="disabled">
              </td>
        </tr>
		
       <tr>
          <th>店铺地址:</th>
          <td>
            <div id="l-map"></div>
            <input disabled="disabled" type="text" style="width:90%;" name="address" id="address" value="${shopDate.address }" placeholder="这里输入地址" title="地址" />
            <input type="hidden" name="lng" id="lng" value="${shopDate.lng}" />
            <input type="hidden" name="lat" id="lat" value="${shopDate.lat}" />
            <div id="searchResultPanel" style="border:1px solid #C0C0C0;width:150px;height:auto; display:none;"></div>
          </td>
        </tr>
       </c:if> 
       <c:if test="${shopDate.type == 1 }">
          <tr>
          <th>商场地址:</th>
          <td>
            <div id="l-map"></div>
            <input disabled="disabled" type="text" style="width:90%;" name="address" id="address" value="${shopDate.address }"/>
            <input type="hidden" name="lng" id="lng" value="${shopDate.lng}" />
            <input type="hidden" name="lat" id="lat" value="${shopDate.lat}" />
            <div id="searchResultPanel" style="border:1px solid #C0C0C0;width:150px;height:auto; display:none;"></div>
          </td>
        </tr>
       </c:if>
        <c:if test="${action != 4}">
        <tr height="100px">
			<th>审批理由:</th>
			<td colspan="3">
				 <textarea style="width:80%;height:200px"  name="reason" id="reason"></textarea>
			</td>
		</tr>
        
		<tr>
          <td colspan="8" style="height: 30px;"> 
               <div style="text-align: center;">
                <a class="btn btn-mini btn-primary" id="a1" onclick="shopStatus(${shopOwnerInfoId},1,${status});" style="width: 90px; height: 34px; line-height:34px">审批通过</a>
                 <a class="btn btn-mini btn-primary" onclick="shopStatus2(${shopOwnerInfoId},3,${status});" style="width: 90px; height: 34px; line-height:34px">审批不通过</a>
				<a class="btn btn-mini btn-danger" onclick="top.Dialog.close();" style="width: 90px; height: 34px; line-height:34px">关闭</a>
				</div>
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

<input type="radio" value="苹果 " />
  </form>
  <!-- 引入 -->
  <!-- base64 -->
  <script src="static/js/base64.js"></script>
  <script type="text/javascript">window.jQuery || document.write("<script src='static/js/jquery-1.9.1.min.js'>\x3C/script>");</script>
	<script src="static/js/bootstrap.min.js"></script>
	<script src="static/js/ace-elements.min.js"></script>
	<script src="static/js/ace.min.js"></script>
	<script type="text/javascript" src="static/js/bootstrap-datepicker.min.js"></script><!-- 日期框 -->
	<script type="text/javascript" src="static/js/bootbox.min.js"></script><!-- 确认窗口 -->		
	<!-- 压缩图片 -->
	<link rel="stylesheet" type="text/css" href="plugins/fancyBox/jquery.fancybox.css">
	<script type="text/javascript" src="plugins/fancyBox/jquery.fancybox.pack.js"></script>
	<!-- 查看图片 -->
	<script type="text/javascript" src="static/js/chosen.jquery.min.js"></script><!-- 下拉框 -->
    <!-- 单选框 -->
  <script type="text/javascript">
    $(top.hangge());
      
    //单选框
	$(".chzn-select").chosen(); 
	$(".chzn-select-deselect").chosen({allow_single_deselect:true});
		      
    $("#imgBox").fancybox({
		helpers : {
			title : {
				type : 'inside'
			}
		}
	});
    $("#imgBoxBg").fancybox({
		helpers : {
			title : {
				type : 'inside'
			}
		}
	});
    
    $("#imgBoxEw").fancybox({
		helpers : {
		title : {
			type : 'inside'
		}
	   }
	});
          									  	
	// 百度地图API功能
	function G(id) {
		return document.getElementById(id);
	}
	var map = new BMap.Map("l-map");
	map.centerAndZoom("广州",12); // 初始化地图,设置城市和地图级别。
    //map.enableScrollWheelZoom();//启动鼠标滚轮缩放地图

	var ac = new BMap.Autocomplete(    //建立一个自动完成的对象
		{"input" : "address"
		,"location" : map
	});

	ac.addEventListener("onhighlight", function(e) {  //鼠标放在下拉列表上的事件
		var str = "";
		var _value = e.fromitem.value;
		var value = "";
		if (e.fromitem.index > -1) {
			value = _value.province +  _value.city +  _value.district +  _value.street +  _value.business;
		}    
		str = "FromItem<br />index = " + e.fromitem.index + "<br />value = " + value;
		
		value = "";
		if (e.toitem.index > -1) {
			_value = e.toitem.value;
			value = _value.province +  _value.city +  _value.district +  _value.street +  _value.business;
		}    
		str += "<br />ToItem<br />index = " + e.toitem.index + "<br />value = " + value;
		G("searchResultPanel").innerHTML = str;
	});

	var myValue;
	ac.addEventListener("onconfirm", function(e) {    //鼠标点击下拉列表后的事件
	var _value = e.item.value;
		myValue = _value.province +  _value.city +  _value.district +  _value.street +  _value.business;
		G("searchResultPanel").innerHTML ="onconfirm<br />index = " + e.item.index + "<br />myValue = " + myValue;
		setPlace();
	});

	function setPlace(){
		map.clearOverlays();    //清除地图上所有覆盖物
		function myFun(){
			var pp = local.getResults().getPoi(0).point;    //获取第一个智能搜索的结果
			map.centerAndZoom(pp, 18);
			map.addOverlay(new BMap.Marker(pp));    //添加标注
		}
		var local = new BMap.LocalSearch(map, { //智能搜索
		  onSearchComplete: myFun
		});
		var myGeo = new BMap.Geocoder();
		// 将地址解析结果显示在地图上，并调整地图视野    
		myGeo.getPoint(myValue, function(point){
        	if (point) {
        		$("#lng").val(point.lng);
        		$("#lat").val(point.lat);
        		local.search(myValue);
          	}
      	});
	}
	
	if($("#address").val() && $("#lng").val() && $("#lat").val()) {
		myValue = $("#address").val();
		ac.setInputValue($("#address").val());
		setPlace();
	}
	
	
  </script>
</body>
</html>