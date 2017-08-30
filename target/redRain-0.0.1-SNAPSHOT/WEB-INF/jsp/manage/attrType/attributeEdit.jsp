<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.aoshi.util.PropertyUtils"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<!DOCTYPE html>
<html lang="en">
<head>
<base href="<%=basePath%>">
<%@ include file="../../system/admin/top.jsp"%>

<script type="text/javascript">
	//保存
	function save(){
		if($("#attrTypeId").val()==""){
			$("#attrTypeId").tips({
				side:3,
	            msg:'请选择类别',
	            bg:'#AE81FF',
	            time:2
	        });
			$("#attrTypeId").focus();
			return false;
		}
		if($("#attrName").val()=="" || $.trim($("#attrName").val())==""){
			$("#attrName").tips({
				side:3,
	            msg:'输入属性名称',
	            bg:'#AE81FF',
	            time:2
	        });
			$("#attrName").focus();
			return false;
		}
		// var selectVal=$("input[name='attrInputType']:checked").val(); //暂时用不到商品属性的添加类别设置默认为1  选择输入
		var selectVal= 1;
		if(selectVal!=2){
		if($("#attrValues").val()=="" || $.trim($("#attrValues").val())==""){
			$("#attrValues").tips({
				side:3,
	            msg:'输入属性值',
	            bg:'#AE81FF',
	            time:2
	        });
			$("#attrValues").focus();
			return false;attrValues
		}else{
			var str = $("#attrValues").val().split(";");
			if(str.length>0){
			var pstr="";
			for(var i= 0;i<str.length;i++){
			if(i==str.length-1){
			pstr=pstr+$.trim(str[i]);
			}
			else if(i<str.length){
            pstr=pstr+$.trim(str[i])+";"
			}
			}
			$("#attrValues").val(pstr);
			
		}
		}
		
		$("#form").submit();
		$("#zhongxin").hide();
		$("#zhongxin2").show();
	}
	}	
</script>
</head>
<body>
  <form action="attrType/${msg }.do" name="form" id="form" method="post">
    <input type="hidden" name="attributeId" id="attributeId" value="${attribute.attributeId }" />
    <input type="hidden" name="tempAttrValues" id="tempAttrValues" value="${attribute.attrValues }" />
    <!-- 暂时用不到商品属性的添加类别设置默认为1  选择输入 -->
    <input type="hidden" name="attrInputType" id="attrInputType" value="1" />
    <!--暂时只支持单选属性  -->
    <input type="hidden" name="attrType" id="attrType"  value="2"/>
    <div id="zhongxin">
      <table id="table_report" class="table table-striped table-bordered table-hover">
       <tr>
      <th>商品类型:</th>
         <td>
           <select class="chzn-select" style="width:60%;" name="attrTypeId" id="attrTypeId" data-placeholder="请选择类型" style="vertical-align:top;">
             <option value=""></option>
             <c:forEach items="${attrTypeList}" var="attrType">
               <option value="${attrType.attrTypeId }" <c:if test="${attrType.attrTypeId == attribute.attrTypeId }">selected</c:if>>${attrType.typeName }</option>
             </c:forEach>
           </select>
         </td>
       </tr>
        <tr>
          <th>属性名称:</th>
          <td>
             <input type="text"  name="attrName" id="attrName" value="${attribute.attrName }" placeholder='属性名称,如:颜色' title="属性名称" />
          
          </td>
        </tr>
        <tr>
       <tr>
          <th>属性添加类别:</th>
          <td>
          	选择输入
           <%-- &nbsp;选择输入<input name="attrInputType" onclick="attrInputTypeDb();" id="attrInputType" type="radio" checked="checked" value="1" <c:if test="${attribute.attrInputType == 1 }">checked="checked"</c:if>><span class="lbl"></span>&nbsp;
           &nbsp;手动输入 <input name="attrInputType" onclick="attrInputTypeDb();" id="attrInputType" type="radio"  value="2" <c:if test="${attribute.attrInputType == 2 }">checked="checked"</c:if>><span class="lbl"></span>&nbsp; --%>
          </td>
        </tr>
        
        
        <tr>
          <th>属性选择类型:</th>
          <td>
          	单选属性 
           <%-- &nbsp;唯一属性<input name="attrType" id="attrType" type="radio" checked="checked" value="1" <c:if test="${attribute.attrType == 1 }">checked</c:if>><span class="lbl"></span>&nbsp;
           &nbsp;单选属性 <input name="attrType" id="attrType" type="radio"  value="2" <c:if test="${attribute.attrType == 2 }">checked</c:if>><span class="lbl"></span>&nbsp; --%>
          </td>
        </tr>
        <tr>
          
          <th>属性值:</th>
          <td>
             <textarea type="text" style="width:90%;" rows="4" cols="6" name="attrValues" id="attrValues" title="属性值" placeholder='单个属性值请用分号结束,如: 红色; ,多个属性值请用分号隔开,如: 红色;黄色;白色' >${attribute.attrValues }</textarea>
             
          </td>
        </tr>
        <tr>
          <td class="center" colspan="2">
            <a class="btn btn-mini btn-primary" onclick="save();">保存</a>
            <a class="btn btn-mini btn-danger" onclick="top.Dialog.close();">取消</a>
          </td>
        </tr>
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
  <script type="text/javascript" src="static/js/chosen.jquery.min.js"></script>
  <!-- 单选框 -->

  <script type="text/javascript">
	$(top.hangge());
	//属性的添加类别暂时用不到
	/*   function attrInputTypeDb(){
		  
		  var selectVal=$("input[name='attrInputType']:checked").val();
		
		  if(selectVal == 2){
			  $("#attrValues").attr("readonly","readonly"); 
			  $("#attrValues").val(""); 
		  }else{
			  var sr =$("#tempAttrValues").val(); 
			  $("#attrValues").val(sr); 
			  $("#attrValues").removeAttr("readonly");  
		  }
	  } */
	 $(function() {
		//attrInputTypeDb();
		//单选框
		$(".chzn-select").chosen(); 
		$(".chzn-select-deselect").chosen({allow_single_deselect:true}); 
	}); 
  </script>
</body>
</html>