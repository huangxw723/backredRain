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
<%@ include file="../../../system/admin/top.jsp"%>
 <script type="text/javascript" src="static/js/common/commonutils.js"></script>

<script type="text/javascript">
	//保存
</script>
</head>
<body>
  <form action="yp/admin/ypShop/${msg }.do" name="shopForm" id="shopForm" method="post">
    <input type="hidden" name="action" id="action" value="${pd.action }" />
     <input type="hidden" name="shopId" id=shopId value="${shopOwner.shopId }" />
    <div id="zhongxin">
      <table id="table_report" class="table table-striped table-bordered table-hover">
        <tr>
          <th>企业名称:</th>
          <td>
           <input placeholder="企业名称" type="text" style="width:90%;" name="name" id="name" value="${shopOwner.name }" title="企业名称" <c:if test="${action == 4}">disabled="disabled"</c:if> />
          </td>
        </tr>
        <tr>
			<th>企业logo:</th>
			<td>
			<c:if test="${shopOwner == null || shopOwner.logoUrl == '' || shopOwner.logoUrl == null }">
              <c:if test="${action != 4}">
				<a id="imgBox" href="javascript:void(0)" style="display:none;">
	                <img src="" width="150" id="imgHref" name="_preview"/>
	            </a>
              <input type="file" id="fileInput" name="fileInput" />
			</c:if>
            </c:if>
            
            
            <c:if test="${shopOwner != null && shopOwner.logoUrl != '' && shopOwner.logoUrl != null }">
	              <a id="imgBox" href="<%=httpUrl%>${shopOwner.logoUrl}" title="${shopOwner.logoUrl}" name="_previewLink" >
	                <img src="<%=httpUrl%>${shopOwner.logoUrl}" alt="${shopOwner.logoUrl}" width="150" id="imgHref" name="_preview"/>
	              </a>
	               <c:if test="${action != 4}">
	              <input type="button" class="btn btn-mini btn-danger" value="更改" onclick="changeImg()" id="chImg" />
	              </c:if>
	              
	              <input type="file" id="fileInput" name="fileInput" style="display:none;" name="_previewButton"/>
	            </c:if> 	
             
            
            <input id="url" name="img" type="hidden" />
            </td>
		</tr>
        <tr>
          <th>企业类型:</th>
          <td>
             <select class="chzn-select" data-placeholder="企业类型" name="tradeCategoryId" id="tradeCategoryId" title="企业类型" <c:if test="${action == 4}">disabled="disabled"</c:if>>
             <c:forEach items="${baseTypes}" var="va">
                  <option value="${va.id}" <c:if test="${va.id ==shopOwner.tradeCategoryId }">selected="selected"</c:if>> ${va.name }</option>
             </c:forEach>
            </select>
          </td>
        </tr>
        <tr height="45px">
		<th>所在楼层:</th>
			<td>
				<select class="chzn-select" data-placeholder="选择楼层" name="floor" <c:if test="${action == 4}">disabled="disabled"</c:if>>
					<c:forEach items="${floorList }" var="var">
						<option value="${var }" <c:if test="${var == shopOwner.floor}">selected="selected"</c:if>>${var}</option>
					</c:forEach>
				</select>
				楼
			</td>
		</tr>
        <tr>
          <th>企业地址:</th>
          <td>
            <select placeholder="企业名称" class="chzn-select" name="provinceId" id="provinceId" data-placeholder="请选择省份" style="vertical-align:top;" <c:if test="${action == 4}">disabled="disabled"</c:if>>
              <option value=""></option>
              <c:forEach items="${provinceList}" var="var">
                <option value="${var.provinceId }" <c:if test="${var.provinceId == provinceId }">selected</c:if>>${var.provinceName }</option>
              </c:forEach>
            </select>
            <select class="chzn-select" name="cityId" id="cityId" data-placeholder="请选择城市" style="vertical-align:top;" <c:if test="${action == 4}">disabled="disabled"</c:if>>
             <c:if test="${action==4}">disabled="disabled"</c:if>
            	<c:if test="${action==2||action==4}">
						   <option value=""></option>
							<c:forEach items="${cityList}" var="vc">
								<option value="${vc.cityId}" <c:if test="${vc.cityId == cityId }">selected</c:if>>${vc.cityName }</option>
							</c:forEach>
						</c:if>
            </select>
            <select class="chzn-select" name="areaId" id="areaId" data-placeholder="请选择区域" style="vertical-align:top;" <c:if test="${action == 4}">disabled="disabled"</c:if>>
            <c:if test="${action==4}">disabled="disabled"</c:if>
						<c:if test="${action==2||action==4}">
						   <option value=""></option>
							<c:forEach items="${areaList}" var="var">
								<option value="${var.areaId }"
									<c:if test="${var.areaId == areaId }">selected</c:if>>${var.areaName }</option>
							</c:forEach>
						</c:if>
            </select>
          </td>
        </tr>
        <tr>
        <th>商场:</th>
         <td>
          <select class="chzn-select" name="storId" id="storId" data-placeholder="商场"  style="width: 675px;" <c:if test="${action == 4}">disabled="disabled"</c:if>>
          </select>
          </td>
        </tr>
        <tr>
        <th>详细地址:</th>
         <td>
            <input type="text" style="width:90%;" placeholder="详细地址" name="address" id="address" value="${shopOwner.address }" title="详细地址" <c:if test="${action == 4}">disabled="disabled"</c:if>/>
            
          </td>
        </tr>
        
          <th>联系人:</th>
          <td>
           <input type="text" style="width:90%;" placeholder="联系人" name="contact" id="contact" value="${shopOwner.contact }" title="联系人" <c:if test="${action == 4}">disabled="disabled"</c:if> />
          </td> 
        </tr>
		<tr>          
          <th>联系电话 :</th>
          <td>
                          <input type="text" style="width:90%;" placeholder="联系电话" name="tel" id="tel" value="${shopOwner.tel }" title="联系电话" <c:if test="${action == 4}">disabled="disabled"</c:if> />

          </td>
        </tr>
		<tr>          
          <th>联系邮箱:</th>
          <td>
                          <input type="text" style="width:90%;" placeholder="联系邮箱" name="contactMail" id="contactMail" value="${shopOwner.contactMail }" title="邮箱地址" <c:if test="${action == 4}">disabled="disabled"</c:if> />

          </td>
        </tr>
        <c:if test="${action != 4}">
         <tr>
          <td class="center" colspan="2">
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
<input type="radio" value="苹果 " />
  </form>
  <!-- 引入 -->
  <script type="text/javascript">window.jQuery || document.write("<script src='static/js/jquery-1.9.1.min.js'>\x3C/script>");</script>
  <script src="static/js/bootstrap.min.js"></script>
  <script src="static/js/ace-elements.min.js"></script>
  <script src="static/js/ace.min.js"></script>
  <script type="text/javascript" src="static/js/chosen.jquery.min.js"></script>
    <!-- base64 -->
  <script src="static/js/base64.js"></script>
  <link rel="stylesheet" type="text/css" href="plugins/fancyBox/jquery.fancybox.css">
  <script type="text/javascript" src="plugins/fancyBox/jquery.fancybox.pack.js"></script>
  <!-- 单选框 -->

  <script type="text/javascript">
    $(top.hangge());
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
	//更改图片
    function changeImg(){
        $("#fileInput").trigger("click");
    }
	
    $("#imgBox").fancybox({
		helpers : {
			title : {
				type : 'inside'
			}
		}
	});
	new img2base64("fileInput", "url", "imgHref", "imgBox");
	//保存
	function save(){
	if($("#name").val()=="" || $("#name").val()=="此企业名称已存在!"){
			
			$("#name").tips({
				side:3,
	            msg:'输入企业名称',
	            bg:'#AE81FF',
	            time:2
	        });
			
			$("#name").focus();
			$("#name").val('');
			$("#name").css("background-color","white");
			return false;
		}else{
			$("#name").val(jQuery.trim($('#name').val()));
		}
	if($("#tradeCategoryId").val()==""||$.trim($("#tradeCategoryId").val())==""){
		
		$("#tradeCategoryId").tips({
			side:3,
            msg:'选择行业类别',
            bg:'#AE81FF',
            time:2
        });
		
		$("#tradeCategoryId").focus();
		$("#tradeCategoryId").val('');
		$("#tradeCategoryId").css("background-color","white");
		return false;
	}else{
		$("#tradeCategoryId").val(jQuery.trim($('#tradeCategoryId').val()));
	}
	if($("#action").val()==1){
	if($("#provinceId").val()==""){
			
			$("#provinceId").tips({
				side:3,
	            msg:'选择省份',
	            bg:'#AE81FF',
	            time:2
	        });
			
			$("#provinceId").focus();
			$("#provinceId").val('');
			$("#provinceId").css("background-color","white");
			return false;
		}else{
			$("#provinceId").val(jQuery.trim($('#provinceId').val()));
		}
	if($("#cityId").val()==""){
		
		$("#cityId").tips({
			side:3,
            msg:'选择城市',
            bg:'#AE81FF',
            time:2
        });
		
		$("#cityId").focus();
		$("#cityId").val('');
		$("#cityId").css("background-color","white");
		return false;
	}else{
		$("#cityId").val(jQuery.trim($('#cityId').val()));
	}
	if($("#areaId").val()==""){
		
		$("#areaId").tips({
			side:3,
            msg:'选择区域',
            bg:'#AE81FF',
            time:2
        });
		
		$("#areaId").focus();
		$("#areaId").val('');
		$("#areaId").css("background-color","white");
		return false;
	}else{
		$("#areaId").val(jQuery.trim($('#areaId').val()));
	}
	}
     if($("#address").val()==""){
			
			$("#address").tips({
				side:3,
	            msg:'输入详细地址',
	            bg:'#AE81FF',
	            time:2
	        });
			
			$("#address").focus();
			$("#address").val('');
			$("#address").css("background-color","white");
			return false;
		}else{
			$("#address").val(jQuery.trim($('#address').val()));
		}
		if($("#contact").val()==""){
			
			$("#contact").tips({
				side:3,
	            msg:'输入联系人名称',
	            bg:'#AE81FF',
	            time:2
	        });
			
			$("#contact").focus();
			$("#contact").val('');
			$("#contact").css("background-color","white");
			return false;
		}else{
			$("#contact").val(jQuery.trim($('#contact').val()));
		}
		 var myreg = /^(((13[0-9]{1})|159)+\d{8})$/;
			if($("#tel").val()==""){
				
				$("#tel").tips({
					side:3,
		            msg:'输入联系电话',
		            bg:'#AE81FF',
		            time:3
		        });
				$("#tel").focus();
				return false;
			}else if($("#tel").val().length != 11 && !myreg.test($("#tel").val())){
				$("#tel").tips({
					side:3,
		            msg:'电话号码格式不正确',
		            bg:'#AE81FF',
		            time:3
		        });
				$("#tel").focus();
				return false;
			}
			
			if($("#contactMail").val()==""){
				
				$("#contactMail").tips({
					side:3,
		            msg:'输入邮箱',
		            bg:'#AE81FF',
		            time:3
		        });
				$("#contactMail").focus();
				return false;
			}else if(!ismail($("#contactMail").val())){
				$("#contactMail").tips({
					side:3,
		            msg:'邮箱格式不正确',
		            bg:'#AE81FF',
		            time:3
		        });
				$("#contactMail").focus();
				return false;
			}
		form.submit($('#shopForm'));

	}
	
	function ismail(mail){
		return(new RegExp(/^(?:[a-zA-Z0-9]+[_\-\+\.]?)*[a-zA-Z0-9]+@(?:([a-zA-Z0-9]+[_\-]?)*[a-zA-Z0-9]+\.)+([a-zA-Z]{2,})+$/).test(mail));
		}
	
	
	//判断邮箱是否存在
	function hasE(USERNAME){
		var EMAIL = $.trim($("#email").val());
		$.ajax({
			type: "POST",
			url: '<%=basePath%>user/hasE.do',
	    	data: {EMAIL:EMAIL,USERNAME:USERNAME,tm:new Date().getTime()},
			dataType:'json',
			cache: false,
			success: function(data){
				 if("success" != data.result){
					 $("#email").tips({
							side:3,
				            msg:'邮箱已存在',
				            bg:'#AE81FF',
				            time:3
				        });
					setTimeout("$('#email').val('')",2000);
				 }
			}
		});
	}
	$(function(){
		
		
		if($("#areaId").val()) {
			var areaId = $("#areaId").val();
		    var areaSelect = $("#storId");
		    areaSelect.empty().append("<option value=''></option>");
		    var areaList = '${storList}';
		    var shopAreaId = '${shopOwner.storeId}';
		    $.each(JSON.parse(areaList), function(i, list){
		    	var parentId = list.areaId;
				if(parentId == areaId) {
					var value = list.storeId;
					var option = list.name;
					var label = $("<option value='"+value+"'>"+option+"</option>");
					console.log(shopAreaId+ "=="+ list.storeId);
					if(shopAreaId == list.storeId) {
						label.attr("selected", "selected");
					}
					areaSelect.append(label);
				}
		 	});
		}
		
		//单选框
		$(".chzn-select").chosen(); 
		$(".chzn-select-deselect").chosen({allow_single_deselect:true});
		
		//联动select事件
		$("#provinceId").change(function(){
		    var provinceId = $("#provinceId").val();
		    var citySelect = $("#cityId");
		    citySelect.empty().append("<option value=''></option>");
		    var cityList = '${cityList}';
		    $.each(JSON.parse(cityList), function(i, list){
		    	var parentId = list.provinceId;
				if(parentId == provinceId) {
					var value = list.cityId;
					var option = list.cityName;
					var label = $("<option value='"+value+"'>"+option+"</option>");
					citySelect.append(label);
				}
		 	});
		    citySelect.trigger("liszt:updated");
		});
		
		//联动select事件
		$("#cityId").change(function(){
		    var cityId = $("#cityId").val();
		    var areaSelect = $("#areaId");
		    areaSelect.empty().append("<option value=''></option>");
		    var areaList = '${areaList}';
		    $.each(JSON.parse(areaList), function(i, list){
		    	var parentId = list.cityId;
				if(parentId == cityId) {
					var value = list.areaId;
					var option = list.areaName;
					var label = $("<option value='"+value+"'>"+option+"</option>");
					areaSelect.append(label);
						}
					});
		    areaSelect.trigger("liszt:updated");
		});
		//联动select事件
		$("#areaId").change(function(){
		    var areaId = $("#areaId").val();
		    var storSelect = $("#storId");
		    storSelect.empty().append("<option value=''></option>");
		    var storList = '${storList}';
		    $.each(JSON.parse(storList), function(i, list){
		    	var parentId = list.areaId;
				if(parentId == areaId) {
					var value = list.storeId;
					var option = list.name;
					var label = $("<option value='"+value+"'>"+option+"</option>");
					storSelect.append(label);
						}
					});
		    storSelect.trigger("liszt:updated");
		});
		
	});
  </script>
</body>
</html>