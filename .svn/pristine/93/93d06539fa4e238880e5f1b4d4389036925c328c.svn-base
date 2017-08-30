<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: zf
  Date: 10/27/16
  Time: 11:35 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<html>
<head>
    <title>Title</title>
    <script type="text/javascript" src="/redRain/static/js/jquery-1.7.2.js"></script>
</head>
<body>
    <form action="/redRain/app/numSave"　id="form" name="form"  method="post">
        <c:forEach  items="${data}" var="var" varStatus="vs" >
            <c:if test="${vs.index == 0}">
                设置人数抽奖最大值: <input type="number" id="maxNum${vs.index}" name="maxNum${vs.index}" value="${var.maxNum}" />
                设置人数抽奖最小值: <input type="number" id="minNum${vs.index}" name="minNum${vs.index}" value="${var.minNum}" />
        </c:if>
        <c:if test="${vs.index == 1}">
            </br>
            设置围台抽奖最大值: <input type="number" id="maxNum${vs.index}" name="maxNum${vs.index}" value="${var.maxNum}" />
            设置围台抽奖最小值: <input type="number" id="minNum${vs.index}" name="minNum${vs.index}" value="${var.minNum}" />
        </c:if>
        </c:forEach>
    </br>
        <button type="button" onclick="submitData()">提交</button>
        <button type="button" onclick="resetData()">重置</button>
</form>
    <script type="text/javascript">
        $(function() {
            eval("${alert1}");
        });
       function submitData() {
           if (Number($("#maxNum0").val()) <= Number($("#minNum0").val())) {
               alert("人数最小值不能大於最大值");
                return ;
           }
           if (Number($("#maxNum1").val()) <= Number($("#minNum1").val())) {
               alert("围台最小值不能大於最大值");
               return ;
           }
           $("[name=form]").submit();
       }
       function resetData(){
           $.ajax({
               type: "POST",
               url: "<%=basePath%>app/resetData",
               dataType:'json',
               success: function(data){
                   alert("清空数据成功")
               }
           });
       }
    </script>
</body>
</html>
