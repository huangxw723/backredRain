<%@ page import="com.aoshi.util.PropertyUtils" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    String httpUrl = PropertyUtils.getLOCALHOST_URL();
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <base href="<%=basePath%>">
    <!-- jsp文件头和头部 -->
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">

    <meta name="description" content="overview & stats" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <!-- basic styles -->
    <link href="static/css/bootstrap.min.css" rel="stylesheet" />
    <link href="static/css/bootstrap-responsive.min.css" rel="stylesheet" />
    <link rel="stylesheet" href="static/css/font-awesome.min.css" />
    <!-- page specific plugin styles -->
    <!-- 下拉框-->
    <link rel="stylesheet" href="static/css/chosen.css" />
    <!-- ace styles -->
    <link rel="stylesheet" href="static/css/ace.min.css" />
    <link rel="stylesheet" href="static/css/ace-responsive.min.css" />
    <link rel="stylesheet" href="static/css/ace-skins.min.css" />
    <script type="text/javascript" src="static/js/jquery-1.7.2.js"></script>
    <link rel="stylesheet" href="static/css/datepicker.css" /><!-- 日期框 -->
    <!--引入弹窗组件start-->
    <script type="text/javascript" src="plugins/attention/zDialog/zDrag.js"></script>
    <script type="text/javascript" src="plugins/attention/zDialog/zDialog.js"></script>
    <!--引入弹窗组件end-->
    <script type="text/javascript" src="static/js/jquery.tips.js"></script>
</head>
<body>

<div class="container-fluid" id="main-container">


    <div id="page-content" class="clearfix">

        <div class="row-fluid">


            <div class="row-fluid">

                <!-- 查询  -->
                <form action="link/activityLink/linkList.do" method="post" name="usersForm" id="usersForm" style="margin: 10px">
                    <input type="hidden" id="type" value="${pd.rangeType}">
                    <input type="hidden" name="itemId" id="itemId" value="">
                    <input type="hidden" name="currentPage" id="currentPage" value="${page.currentPage}"/>
                    <input type="hidden" name="showCount" id="showCount" value="${page.showCount}"/>
                    <table>
                        <tr>
                            <td>
                            <span>
								<input  id="nav-search-input" type="text" name="keyWord" value="${keyWord}" placeholder="链接名称" style="width:130px;;margin-bottom: 0px"/>
							</span>
                            <span>
								范围:
								<select class="chzn-select" name="rangeType" id="rangeType" data-placeholder="请选择范围" style="vertical-align:top;width: 115px">
                                  <option value=""  <c:if test="${pd.rangeType == ''}">selected</c:if>>全部</option>
								  <option value="1" <c:if test="${pd.rangeType == 1}">selected</c:if>>市</option>
                                  <option value="2" <c:if test="${pd.rangeType == 2}">selected</c:if>>区</option>
                                  <option value="3" <c:if test="${pd.rangeType == 3}">selected</c:if>>商圈</option>
                                  <option value="4" <c:if test="${pd.rangeType == 4}">selected</c:if>>商场</option>
            					</select>
							</span>
                            <span class="city" style="display: inline-block">
                                <span>
								省份:
								<select class="chzn-select" name="provinceId1" id="provinceId1" data-placeholder="请选择省份" style="vertical-align:top;width: 115px">
								  <option value=""></option>
                                  <option value="">全部</option>
								  <c:forEach items="${provinceList}" var="province">
                                      <option value="${province.provinceId }" <c:if test="${province.provinceId ==pd.provinceId1}">selected="selected"</c:if> >${province.provinceName }</option>
                                  </c:forEach>
            					</select>
							    </span>
                                <span>
								城市:
								<select class="chzn-select" name="cityId1" id="cityId1" data-placeholder="请选择城市" style="vertical-align:top;width: 115px">
            					</select>
							</span>
                            </span>
                            <span class="area" style="display: none">
                                <span>
								省份:
								<select class="chzn-select" name="provinceId2" id="provinceId2" data-placeholder="请选择省份" style="vertical-align:top;width: 115px">
								  <option value=""></option>
                                  <option value="">全部</option>
								  <c:forEach items="${provinceList}" var="province">
                                      <option value="${province.provinceId }" <c:if test="${province.provinceId ==pd.provinceId2}">selected="selected"</c:if>>${province.provinceName }</option>
                                  </c:forEach>
            					</select>
							</span>
                                <span>
								城市:
								<select class="chzn-select" name="cityId2" id="cityId2" data-placeholder="请选择城市" style="vertical-align:top;width: 115px">
            					</select>
							</span>
                                <span>
								区域:
								<select class="chzn-select" name="areaId2" id="areaId2" data-placeholder="请选择县区" style="vertical-align:top;width: 115px">
            					</select>
							</span>
                            </span>
                            <span class="dis" style="display: none">
                                <span>
								省份:
								<select class="chzn-select" name="provinceId" id="provinceId" data-placeholder="请选择省份" style="vertical-align:top;width: 115px">
								  <option value=""></option>
                                  <option value="">全部</option>
								  <c:forEach items="${provinceList}" var="province">
                                      <option value="${province.provinceId }" <c:if test="${province.provinceId ==pd.provinceId}">selected="selected"</c:if>>${province.provinceName }</option>
                                  </c:forEach>
            					</select>
							</span>
                                <span>
								城市:
								<select class="chzn-select" name="cityId" id="cityId" data-placeholder="请选择城市" style="vertical-align:top;width: 115px">
            					</select>
							</span>
                                <span>
								区域:
								<select class="chzn-select" name="areaId" id="areaId" data-placeholder="请选择县区" style="vertical-align:top;width: 115px">
            					</select>
							</span>
                                <span>
								商圈:
								<select class="chzn-select" name="district" id="district" data-placeholder="请选择商圈" style="vertical-align:top;width: 115px">
            					</select>
							</span>
                            </span>
                            <span class="store" style="display: none">
                                <span>
								省份:
								<select class="chzn-select" name="provinceId3" id="provinceId3" data-placeholder="请选择省份" style="vertical-align:top;width: 115px">
								  <option value=""></option>
                                  <option value="">全部</option>
								  <c:forEach items="${provinceList}" var="province">
                                      <option value="${province.provinceId }" <c:if test="${province.provinceId ==pd.provinceId3}">selected="selected"</c:if>>${province.provinceName }</option>
                                  </c:forEach>
            					</select>
							</span>
                                <span>
								城市:
								<select class="chzn-select" name="cityId3" id="cityId3" data-placeholder="请选择城市" style="vertical-align:top;width: 115px">
            					</select>
							</span>
                                <span>
								区域:
								<select class="chzn-select" name="areaId3" id="areaId3" data-placeholder="请选择县区" style="vertical-align:top;width: 115px">
            					</select>
							</span>
                                <span>
								商圈:
								<select class="chzn-select" name="district3" id="district3" data-placeholder="请选择商圈" style="vertical-align:top;width: 115px">
            					</select>
							</span>
                            <span>
								商场:
								<select class="chzn-select" name="store3" id="store3" data-placeholder="请选择商场" style="vertical-align:top;width: 115px">
            					</select>
							</span>
                            </span>
                            </td>

                            <td style="vertical-align: top;">
                                &nbsp;
                                <a class="btn btn-small btn-success"  id="sear">查询</a>
                            </td>

                            <td style="vertical-align: top;">
                                &nbsp;
                                <a class="btn btn-small btn-success" onclick="add();">新增</a>
                            </td>

                        </tr>
                    </table>
                </form>
                <!-- 检索  -->


                <table id="table_report" class="table table-striped table-bordered table-hover">

                    <thead>
                    <tr>
                        <th class="center">
                            <label>
                                <input type="checkbox" id="zcheckbox" />
                                <span class="lbl"></span>
                            </label>
                        </th>
                        <th style="text-align:center;">链接名称</th>
                        <th style="text-align:center;">范围</th>
                        <th style="text-align:center;">城市</th>
                        <th style="text-align:center;">区</th>
                        <th style="text-align:center;">商圈</th>
                        <th style="text-align:center;">商场</th>
                        <th style="text-align:center;">链接</th>
                        <th style="text-align:center;">操作</th>
                    </tr>
                    </thead>

                    <tbody>

                    <!-- 开始循环 -->
                    <c:choose>
                        <c:when test="${not empty list}">
                            <c:forEach items="${list}" var="var" varStatus="vs">

                                <tr>
                                    <td class='center' style="width: 30px;">
                                        <label>
                                            <input type='checkbox' name='ids' value="${var.activityLinkId}" />
                                            <span class="lbl"></span>
                                        </label>
                                    </td>
                                    <td class='center' style="text-align:center;">${var.linkName}</td>
                                    <td class='center' style="text-align:center;">
                                        <c:if test="${var.rangeType ==1}">市</c:if>
                                        <c:if test="${var.rangeType ==2}">区</c:if>
                                        <c:if test="${var.rangeType ==3}">商圈</c:if>
                                        <c:if test="${var.rangeType ==4}">商场</c:if>
                                    </td>
                                    <td class='center' style="text-align:center;">
                                        <c:choose>
                                            <c:when test="${empty var.cityName}">
                                                --
                                            </c:when>
                                            <c:otherwise>
                                                ${var.cityName}
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td class='center' style="text-align:center;">
                                        <c:choose>
                                            <c:when test="${empty var.areaName}">
                                                --
                                            </c:when>
                                            <c:otherwise>
                                                ${var.areaName}
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td class='center' style="text-align:center;">
                                        <c:choose>
                                            <c:when test="${empty var.disName}">
                                                --
                                            </c:when>
                                            <c:otherwise>
                                                ${var.disName}
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td class='center' style="text-align:center;">
                                        <c:choose>
                                            <c:when test="${empty var.storeName}">
                                                --
                                            </c:when>
                                            <c:otherwise>
                                                ${var.storeName}
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td class='center' style="text-align:center;"><%=httpUrl%>${var.link}</td>
                                    <td class='center'  style="text-align:center;">
                                        <%--<a href="javascript:void(0);" onclick="editName(${var.activityLinkId})">编辑名称</a>--%>
                                        <a href="javascript:void(0);" onclick="copyToClipboard('<%=httpUrl%>${var.link}')">复制链接</a>
                                        <a href="javascript:void(0);" onclick="edit(${var.activityLinkId})">编辑</a>
                                        <a href="javascript:void(0);" onclick="del(${var.activityLinkId})">删除</a>
                                    </td>
                                </tr>

                            </c:forEach>



                        </c:when>
                        <c:otherwise>
                            <tr class="main_info">
                                <td colspan="10" class="center">没有相关数据<a style="text-decoration: none;cursor:pointer" onclick="fresh()">刷新</a></td>
                            </tr>
                        </c:otherwise>
                    </c:choose>


                    </tbody>
                </table>

                <div class="page-header position-relative">
                    <table style="width: 100%;">
                        <tr>
                            <td style="vertical-align:top;">
                                <a class="btn btn-small btn-danger" onclick="delAll('确定要删除选中的数据吗?');" title="批量删除" ><i class='icon-trash'></i></a>
                            </td>
                            <td style="vertical-align: top;">
                                <div class="pagination"
                                     style="float: right; padding-top: 0px; margin-top: 0px;">${page.pageStr}</div>
                            </td>
                        </tr>
                    </table>
                </div>

            </div>




            <!-- PAGE CONTENT ENDS HERE -->
        </div><!--/row-->

    </div><!--/#page-content-->
</div><!--/.fluid-container#main-container-->

<!-- 返回顶部  -->
<a href="#" id="btn-scroll-up" class="btn btn-small btn-inverse">
    <i class="icon-double-angle-up icon-only"></i>
</a>

<!-- 引入 -->
<script type="text/javascript">window.jQuery || document.write("<script src='static/js/jquery-1.9.1.min.js'>\x3C/script>");</script>
<script src="static/js/bootstrap.min.js"></script>
<script src="static/js/ace-elements.min.js"></script>
<script src="static/js/ace.min.js"></script>

<script type="text/javascript" src="static/js/chosen.jquery.min.js"></script><!-- 下拉框 -->
<script type="text/javascript" src="static/js/bootstrap-datepicker.min.js"></script><!-- 日期框 -->
<script type="text/javascript" src="static/js/bootbox.min.js"></script><!-- 确认窗口 -->
<!-- 引入 -->
<script type="text/javascript" src="static/js/jquery.tips.js"></script><!--提示框-->
<link rel="stylesheet" type="text/css" href="plugins/fancyBox/jquery.fancybox.css">
<script type="text/javascript" src="plugins/fancyBox/jquery.fancybox.pack.js"></script>

<script type="text/javascript">

    $(top.hangge());

//    //检索
    function search(){
        var rvl =$("#rangeType").val();
        if(rvl==1){
            if($("#provinceId1").val()==""||$.trim($("#provinceId1").val())=="" ){
                $("#provinceId1").tips({
                    side:3,
                    msg:'选择省份',
                    bg:'#AE81FF',
                    time:2
                });
                $("#provinceId1").focus();
                return false;
            }
            if($("#cityId1").val()==""||$.trim($("#cityId1").val())=="" ){
                $("#cityId1").tips({
                    side:3,
                    msg:'选择城市',
                    bg:'#AE81FF',
                    time:2
                });
                $("#cityId1").focus();
                return false;
            }
            $("#itemId").val($("#cityId1").val())
        }else if(rvl==2){
            itemId=$("#areaId2").val()
            if($("#provinceId2").val()==""||$.trim($("#provinceId2").val())=="" ){
                $("#provinceId2").tips({
                    side:3,
                    msg:'选择省份',
                    bg:'#AE81FF',
                    time:2
                });
                $("#provinceId2").focus();
                return false;
            }
            if($("#cityId2").val()==""||$.trim($("#cityId2").val())=="" ){
                $("#cityId2").tips({
                    side:3,
                    msg:'选择城市',
                    bg:'#AE81FF',
                    time:2
                });
                $("#cityId2").focus();
                return false;
            }
            if($("#areaId2").val()==""||$.trim($("#areaId2").val())=="" ){
                $("#areaId2").tips({
                    side:3,
                    msg:'选择区域',
                    bg:'#AE81FF',
                    time:2
                });
                $("#areaId2").focus();
                return false;
            }
            $("#itemId").val($("#areaId2").val())
        }else if(rvl==3){
            itemId=$("#district").val()
            if($("#provinceId").val()==""||$.trim($("#provinceId").val())=="" ){
                $("#provinceId").tips({
                    side:3,
                    msg:'选择省份',
                    bg:'#AE81FF',
                    time:2
                });
                $("#provinceId").focus();
                return false;
            }
            if($("#cityId").val()==""||$.trim($("#cityId").val())=="" ){
                $("#cityId").tips({
                    side:3,
                    msg:'选择城市',
                    bg:'#AE81FF',
                    time:2
                });
                $("#cityId").focus();
                return false;
            }
            if($("#areaId").val()==""||$.trim($("#areaId").val())=="" ){
                $("#areaId").tips({
                    side:3,
                    msg:'选择区域',
                    bg:'#AE81FF',
                    time:2
                });
                $("#areaId").focus();
                return false;
            }
            if($("#district").val()==""||$.trim($("#district").val())=="" ){
                $("#district").tips({
                    side:3,
                    msg:'选择商圈',
                    bg:'#AE81FF',
                    time:2
                });
                $("#district").focus();
                return false;
            }
            $("#itemId").val($("#district").val())
        }else if(rvl==4){
            itemId=$("#store3").val()
            if($("#provinceId3").val()==""||$.trim($("#provinceId3").val())=="" ){
                $("#provinceId3").tips({
                    side:3,
                    msg:'选择省份',
                    bg:'#AE81FF',
                    time:2
                });
                $("#provinceId3").focus();
                return false;
            }
            if($("#cityId3").val()==""||$.trim($("#cityId3").val())=="" ){
                $("#cityId3").tips({
                    side:3,
                    msg:'选择城市',
                    bg:'#AE81FF',
                    time:2
                });
                $("#cityId3").focus();
                return false;
            }
            if($("#areaId3").val()==""||$.trim($("#areaId3").val())=="" ){
                $("#areaId3").tips({
                    side:3,
                    msg:'选择区域',
                    bg:'#AE81FF',
                    time:2
                });
                $("#areaId3").focus();
                return false;
            }
            if($("#district3").val()==""||$.trim($("#district3").val())=="" ){
                $("#district3").tips({
                    side:3,
                    msg:'选择商圈',
                    bg:'#AE81FF',
                    time:2
                });
                $("#district").focus();
                return false;
            }
            if($("#store3").val()==""||$.trim($("#store3").val())=="" ){
                $("#store3").tips({
                    side:3,
                    msg:'选择商场',
                    bg:'#AE81FF',
                    time:2
                });
                $("#store3").focus();
                return false;
            }
            $("#itemId").val($("#store3").val())
        }
        top.jzts();
        $("#usersForm").submit();
    }

</script>

<script type="text/javascript">

    $(function() {
        if($("#type").val()==""){
            //样式
            $(".city").css("display","none");
            $(".area").css("display","none");
            $(".dis").css("display","none");
            $(".store").css("display","none");
        }
        if($("#type").val()==1){//市
            $(".city").css("display","inline-block");
            $(".area").css("display","none");
            $(".dis").css("display","none");
            $(".store").css("display","none");
            // 查询条件为市
            if($("#provinceId1").val()) {
                var provinceId = $("#provinceId1").val();
                var citySelect = $("#cityId1");
                citySelect.empty().append("<option value=''></option>").append("<option value=''>全部</option>");
                var cityList = '${cityList}';
                var cityId = '${itemId}';
                $.each(JSON.parse(cityList), function(i, list){
                    var parentId = list.provinceId;
                    if(parentId == provinceId) {
                        var value = list.cityId;
                        var option = list.cityName;
                        var label = $("<option value='"+value+"'>"+option+"</option>");
                        if(cityId == list.cityId) {
                            label.attr("selected", "selected");
                        }
                        citySelect.append(label);
                    }
                });
            }
        }
        if($("#type").val()==2){//区
            $(".city").css("display","none");
            $(".area").css("display","inline-block");
            $(".dis").css("display","none");
            $(".store").css("display","none");
            // 查询条件为区
            if($("#provinceId2").val()) {
                var provinceId = $("#provinceId2").val();
                var citySelect = $("#cityId2");
                citySelect.empty().append("<option value=''></option>").append("<option value=''>全部</option>");
                var cityList = '${cityList}';
                var cityId = '${pd.cityId2}';
                $.each(JSON.parse(cityList), function(i, list){
                    var parentId = list.provinceId;
                    if(parentId == provinceId) {
                        var value = list.cityId;
                        var option = list.cityName;
                        var label = $("<option value='"+value+"'>"+option+"</option>");
                        if(cityId == list.cityId) {
                            label.attr("selected", "selected");
                        }
                        citySelect.append(label);
                    }
                });
            }

            if($("#cityId2").val()) {
                var cityId = $("#cityId2").val();
                var areaSelect = $("#areaId2");
                areaSelect.empty().append("<option value=''></option>").append("<option value=''>全部</option>");
                var areaList = '${areaList}';
                var areaId = '${itemId}';
                $.each(JSON.parse(areaList), function(i, list){
                    var parentId = list.cityId;
                    if(parentId == cityId) {
                        var value = list.areaId;
                        var option = list.areaName;
                        var label = $("<option value='"+value+"'>"+option+"</option>");
                        if(areaId == list.areaId) {
                            label.attr("selected", "selected");
                        }
                        areaSelect.append(label);
                    }
                });
            }
        }
        if($("#type").val()==3){//商圈
            $(".city").css("display","none");
            $(".area").css("display","none");
            $(".dis").css("display","inline-block");
            $(".store").css("display","none");
            if($("#provinceId").val()) {
                var provinceId = $("#provinceId").val();
                var citySelect = $("#cityId");
                citySelect.empty().append("<option value=''></option>").append("<option value=''>全部</option>");
                var cityList = '${cityList}';
                var cityId = '${pd.cityId}';
                $.each(JSON.parse(cityList), function(i, list){
                    var parentId = list.provinceId;
                    if(parentId == provinceId) {
                        var value = list.cityId;
                        var option = list.cityName;
                        var label = $("<option value='"+value+"'>"+option+"</option>");
                        if(cityId == list.cityId) {
                            label.attr("selected", "selected");
                        }
                        citySelect.append(label);
                    }
                });
            }
            if($("#cityId").val()) {
                var cityId = $("#cityId").val();
                var areaSelect = $("#areaId");
                areaSelect.empty().append("<option value=''></option>").append("<option value=''>全部</option>");
                var areaList = '${areaList}';
                var areaId = '${pd.areaId}';
                $.each(JSON.parse(areaList), function(i, list){
                    var parentId = list.cityId;
                    if(parentId == cityId) {
                        var value = list.areaId;
                        var option = list.areaName;
                        var label = $("<option value='"+value+"'>"+option+"</option>");
                        if(areaId == list.areaId) {
                            label.attr("selected", "selected");
                        }
                        areaSelect.append(label);
                    }
                });
            }
            if($("#areaId").val()) {
                var areaId = $("#areaId").val();
                var districtSelect = $("#district");
                districtSelect.empty().append("<option value=''></option>").append("<option value=''>全部</option>");
                var districtList = '${districtList}';
                var district = '${itemId}';
                $.each(JSON.parse(districtList), function(i, list){
                    var parentId = list.areaId;
                    if(parentId == areaId) {
                        var value = list.businessDistrictId;
                        var option = list.name;
                        var label = $("<option value='"+value+"'>"+option+"</option>");
                        if(district == list.businessDistrictId) {
                            label.attr("selected", "selected");
                        }
                        districtSelect.append(label);
                    }
                });
            }
        }
        if($("#type").val()==4){//商场
            $(".city").css("display","none");
            $(".area").css("display","none");
            $(".dis").css("display","none");
            $(".store").css("display","inline-block");

            if($("#provinceId3").val()) {
                var provinceId = $("#provinceId3").val();
                var citySelect = $("#cityId3");
                citySelect.empty().append("<option value=''></option>").append("<option value=''>全部</option>");
                var cityList = '${cityList}';
                var cityId = '${pd.cityId3}';
                $.each(JSON.parse(cityList), function(i, list){
                    var parentId = list.provinceId;
                    if(parentId == provinceId) {
                        var value = list.cityId;
                        var option = list.cityName;
                        var label = $("<option value='"+value+"'>"+option+"</option>");
                        if(cityId == list.cityId) {
                            label.attr("selected", "selected");
                        }
                        citySelect.append(label);
                    }
                });
            }
            if($("#cityId3").val()) {
                var cityId = $("#cityId3").val();
                var areaSelect = $("#areaId3");
                areaSelect.empty().append("<option value=''></option>").append("<option value=''>全部</option>");
                var areaList = '${areaList}';
                var areaId = '${pd.areaId3}';
                $.each(JSON.parse(areaList), function(i, list){
                    var parentId = list.cityId;
                    if(parentId == cityId) {
                        var value = list.areaId;
                        var option = list.areaName;
                        var label = $("<option value='"+value+"'>"+option+"</option>");
                        if(areaId == list.areaId) {
                            label.attr("selected", "selected");
                        }
                        areaSelect.append(label);
                    }
                });
            }
            if($("#areaId3").val()) {
                var areaId = $("#areaId3").val();
                var districtSelect = $("#district3");
                districtSelect.empty().append("<option value=''></option>").append("<option value=''>全部</option>");
                var districtList = '${districtList}';
                var district = '${pd.district3}';
                $.each(JSON.parse(districtList), function(i, list){
                    var parentId = list.areaId;
                    if(parentId == areaId) {
                        var value = list.businessDistrictId;
                        var option = list.name;
                        var label = $("<option value='"+value+"'>"+option+"</option>");
                        if(district == list.businessDistrictId) {
                            label.attr("selected", "selected");
                        }
                        districtSelect.append(label);
                    }
                });
            }

            if($("#district3").val()) {
                var areaId = $("#district3").val();
                var districtSelect = $("#store3");
                districtSelect.empty().append("<option value=''></option>").append("<option value=''>全部</option>");
                var districtList = '${storeList}';
                var district = '${itemId}';
                $.each(JSON.parse(districtList), function(i, list){
                    var parentId = list.businessDistrictId;
                    if(parentId == areaId) {
                        var value = list.storeId;
                        var option = list.name;
                        var label = $("<option value='"+value+"'>"+option+"</option>");
                        if(district == list.storeId) {
                            label.attr("selected", "selected");
                        }
                        districtSelect.append(label);
                    }
                });
            }

        }




        $("#sear").click(function () {
            search()
        })

        //单选框
        $(".chzn-select").chosen();
        $(".chzn-select-deselect").chosen({allow_single_deselect:true});

        //联动select事件（点击选择商圈）
        $("#provinceId").change(function(){
            var provinceId = $("#provinceId").val();
            var citySelect = $("#cityId");
            var districtSelect =$("#district");
            citySelect.empty().append("<option value=''></option>").append("<option value=''>全部</option>");
            var areaSelect = $("#areaId");
            areaSelect.empty().append("<option value=''></option>").append("<option value=''>全部</option>");
            districtSelect.empty().append("<option value=''></option>").append("<option value=''>全部</option>");
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
            areaSelect.trigger("liszt:updated");
            districtSelect.trigger("liszt:updated");
        });
        $("#cityId").change(function(){
            var cityId = $("#cityId").val();
            var areaSelect = $("#areaId");
            var districtSelect =$("#district");
            areaSelect.empty().append("<option value=''></option>").append("<option value=''>全部</option>");
            districtSelect.empty().append("<option value=''></option>").append("<option value=''>全部</option>");
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
            districtSelect.trigger("liszt:updated");
        });

        $("#areaId").change(function(){
            var areaId = $("#areaId").val();
            var districtSelect = $("#district");
            districtSelect.empty().append("<option value=''></option>").append("<option value=''>全部</option>");
            var areaList = '${districtList}';
            $.each(JSON.parse(areaList), function(i, list){
                var parentId = list.areaId;
                if(parentId == areaId) {
                    var value = list.businessDistrictId;
                    var option = list.name;
                    var label = $("<option value='"+value+"'>"+option+"</option>");
                    districtSelect.append(label);
                }
            });
            districtSelect.trigger("liszt:updated");
        });


        //联动select事件(点击选择市)
        $("#provinceId1").change(function(){
            var provinceId = $("#provinceId1").val();
            var citySelect = $("#cityId1");
            var districtSelect =$("#district");
            citySelect.empty().append("<option value=''></option>").append("<option value=''>全部</option>");
            var areaSelect = $("#areaId");
            areaSelect.empty().append("<option value=''></option>").append("<option value=''>全部</option>");
            districtSelect.empty().append("<option value=''></option>").append("<option value=''>全部</option>");
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
            areaSelect.trigger("liszt:updated");
            districtSelect.trigger("liszt:updated");
        });

        //联动select事件（点击选择区）
        $("#provinceId2").change(function(){
            var provinceId = $("#provinceId2").val();
            var citySelect = $("#cityId2");
            var districtSelect =$("#district2");
            citySelect.empty().append("<option value=''></option>").append("<option value=''>全部</option>");
            var areaSelect = $("#areaId2");
            areaSelect.empty().append("<option value=''></option>").append("<option value=''>全部</option>");
            districtSelect.empty().append("<option value=''></option>").append("<option value=''>全部</option>");
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
            areaSelect.trigger("liszt:updated");
            districtSelect.trigger("liszt:updated");
        });
        $("#cityId2").change(function(){
            var cityId = $("#cityId2").val();
            var areaSelect = $("#areaId2");
            var districtSelect =$("#district2");
            areaSelect.empty().append("<option value=''></option>").append("<option value=''>全部</option>");
            districtSelect.empty().append("<option value=''></option>").append("<option value=''>全部</option>");
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
            districtSelect.trigger("liszt:updated");
        });
        //联动select事件（点击选择商场）
        $("#provinceId3").change(function(){
            var provinceId = $("#provinceId3").val();
            var citySelect = $("#cityId3");
            var districtSelect =$("#district3");
            var storeSelect =$("#store3");
            citySelect.empty().append("<option value=''></option>").append("<option value=''>全部</option>");
            var areaSelect = $("#areaId3");
            areaSelect.empty().append("<option value=''></option>").append("<option value=''>全部</option>");
            districtSelect.empty().append("<option value=''></option>").append("<option value=''>全部</option>");
            storeSelect.empty().append("<option value=''></option>").append("<option value=''>全部</option>");
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
            areaSelect.trigger("liszt:updated");
            districtSelect.trigger("liszt:updated");
            storeSelect.trigger("liszt:updated");
        });
        $("#cityId3").change(function(){
            var cityId = $("#cityId3").val();
            var areaSelect = $("#areaId3");
            var districtSelect =$("#district3");
            var storeSelect =$("#store3");
            areaSelect.empty().append("<option value=''></option>").append("<option value=''>全部</option>");
            districtSelect.empty().append("<option value=''></option>").append("<option value=''>全部</option>");
            storeSelect.empty().append("<option value=''></option>").append("<option value=''>全部</option>");
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
            districtSelect.trigger("liszt:updated");
            storeSelect.trigger("liszt:updated");
        });
        $("#areaId3").change(function(){
            var areaId = $("#areaId3").val();
            var districtSelect = $("#district3");
            var storeSelect =$("#store3");
            districtSelect.empty().append("<option value=''></option>").append("<option value=''>全部</option>");
            storeSelect.empty().append("<option value=''></option>").append("<option value=''>全部</option>");
            var areaList = '${districtList}';
            $.each(JSON.parse(areaList), function(i, list){
                var parentId = list.areaId;
                if(parentId == areaId) {
                    var value = list.businessDistrictId;
                    var option = list.name;
                    var label = $("<option value='"+value+"'>"+option+"</option>");
                    districtSelect.append(label);
                }
            });
            districtSelect.trigger("liszt:updated");
            storeSelect.trigger("liszt:updated");
        });
        $("#district3").change(function(){
            var districtId = $("#district3").val();
            var storeSelect = $("#store3");
            storeSelect.empty().append("<option value=''></option>").append("<option value=''>全部</option>");
            var storeList = '${storeList}';
            $.each(JSON.parse(storeList), function(i, list){
                var parentId = list.businessDistrictId;
                if(parentId == districtId) {
                    var value = list.storeId;
                    var option = list.name;
                    var label = $("<option value='"+value+"'>"+option+"</option>");
                    storeSelect.append(label);
                }
            });
            storeSelect.trigger("liszt:updated");
        });

        //日期框
        $('.date-picker').datepicker();

        //下拉框
        $(".chzn-select").chosen();
        $(".chzn-select-deselect").chosen({allow_single_deselect:true});

        //复选框
        $('table th input:checkbox').on('click' , function(){
            var that = this;
            $(this).closest('table').find('tr > td:first-child input:checkbox')
                    .each(function(){
                        this.checked = that.checked;
                        $(this).closest('tr').toggleClass('selected');
                    });

        });
        
        $('#rangeType').change(function () {
            $("#provinceId").val("");
            $("#provinceId1").val("");
            $("#provinceId2").val("");
            $("#provinceId3").val("");

//            $("#cityId1").val("");
//            $("#areaId2").val("");
//            $("#district").val("");
//            $("#store3").val("");

            if($(this).val()==""){
                //样式
                $(".city").css("display","none");
                $(".area").css("display","none");
                $(".dis").css("display","none");
                $(".store").css("display","none");
            }
            if($(this).val()==1){//市
                $(".city").css("display","inline-block");
                $(".area").css("display","none");
                $(".dis").css("display","none");
                $(".store").css("display","none");
            }
            if($(this).val()==2){//区
                $(".city").css("display","none");
                $(".area").css("display","inline-block");
                $(".dis").css("display","none");
                $(".store").css("display","none");
            }
            if($(this).val()==3){//商圈
                $(".city").css("display","none");
                $(".area").css("display","none");
                $(".dis").css("display","inline-block");
                $(".store").css("display","none");
            }
            if($(this).val()==4){//商场
                $(".city").css("display","none");
                $(".area").css("display","none");
                $(".dis").css("display","none");
                $(".store").css("display","inline-block");
            }
        })

    });

    //发布
    function add(){
        var form = $("#usersForm");
        top.jzts();
        var diag = new top.Dialog();
        diag.Drag=true;
        diag.Title ="新增";
        diag.URL = '<%=basePath%>link/activityLink/toAdd.do';
        diag.Width = 900;
        diag.Height = 450;
        diag.CancelEvent = function(){ //关闭事件
            if(diag.innerFrame.contentWindow.document.getElementById('zhongxin').style.display == 'none'){
                if('${page.currentPage}' == '0'){
                    top.jzts();
                    setTimeout("self.location=self.location",100);
                }else{
                    if(typeof(nextPage) == "function") {
                        nextPage(${page.currentPage});
                    }
                }
            }
            diag.close();
            form.submit();
        };
        diag.show();
    }

    //修改
    function edit(id){
        top.jzts();
        var diag = new top.Dialog();
        diag.Drag=true;
        diag.Title ="编辑";
        diag.URL = '<%=basePath%>link/activityLink/toEdit.do?id='+id;
        diag.Width = 850;
        diag.Height = 700;
        diag.CancelEvent = function(){ //关闭事件
            diag.close();
            search();
        };
        diag.show();
    }

    //修改
    function editName(id){
        top.jzts();
        var diag = new top.Dialog();
        diag.Drag=true;
        diag.Title ="编辑名称";
        diag.URL = '<%=basePath%>link/activityLink/toEditName.do?id='+id;
        diag.Width = 500;
        diag.Height = 300;
        diag.CancelEvent = function(){ //关闭事件
            diag.close();
            search();
        };
        diag.show();
    }

    //删除
    function del(Id){
        bootbox.confirm("确定要删除吗?", function(result) {
            if(result) {
                top.jzts();
                var url = "<%=basePath%>link/activityLink/delById.do?activityLinkId="+Id;
                $.get(url,function(data){
                    if(typeof(nextPage) == "function") {
                        nextPage(${page.currentPage});
                    }
                });
            }
        });
    }
    //批量删除
    function delAll(msg){
        bootbox.confirm(msg, function(result) {
            if(result) {
                var str = '';
                for(var i=0;i < document.getElementsByName('ids').length;i++)
                {
                    if(document.getElementsByName('ids')[i].checked){
                        if(str=='') str += document.getElementsByName('ids')[i].value;
                        else str += ',' + document.getElementsByName('ids')[i].value;
                    }
                }
                if(str==''){
                    bootbox.dialog("您没有选择任何内容!",
                            [
                                {
                                    "label" : "关闭",
                                    "class" : "btn-small btn-success",
                                    "callback": function() {
                                        //Example.show("great success");
                                    }
                                }
                            ]
                    );

                    $("#zcheckbox").tips({
                        side:3,
                        msg:'点这里全选',
                        bg:'#AE81FF',
                        time:8
                    });

                    return;
                }else{
                    if(msg == '确定要删除选中的数据吗?'){
                        top.jzts();
                        var url = "<%=basePath%>link/activityLink/deleteAll.do?ids="+str;
                        $.get(url,function(data){
                            if(typeof(nextPage) == "function") {
                                nextPage(${page.currentPage});
                            }
                        });

                    }
                }
            }
        });
    }
    function fresh() {
        setTimeout("self.location=self.location",100);
    }
    function copyToClipboard(link){
        var zhuanpan=link;
        var zhuanpanA = $("<a href='javascript:void(0)'>").text("复制").css("float","right").click(function(){
            var obj = $(this).prev()[0];
            obj.select();
            document.execCommand("copy");
        });
        var link = $("<div>")
                .append($("<div>").append($("<span>").text("大转盘：").after($("<input type='text'>").css("width","80%").attr("value", zhuanpan)).after(zhuanpanA)));
        bootbox.dialog(link,
                [{
                    "label" : "关闭",
                    "class" : "btn-small btn-success",
                    "callback": function() {
                    }
                }]
        );
    }
</script>

</body>
</html>

