<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
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
                <form action="consultation/shop/shopList.do" method="post" name="usersForm" id="usersForm">
                    <%--<input type="hidden" id="c" value="${pd.cityId}">--%>
                    <%--<input type="hidden" id="a" value="${pd.areaId}">--%>
                    <%--<input type="hidden" id="d" value="${pd.district}">--%>
                    <table>
                        <tr>
                            <td>
							<span>
								省份:
								<select class="chzn-select" name="provinceId" id="provinceId" data-placeholder="请选择省份" style="vertical-align:top;width: 115px">
								  <option value=""></option>
                                  <option value="">全部</option>
								  <c:forEach items="${provinceList}" var="province">
                                      <option value="${province.provinceId }" <c:if test="${province.provinceId == pd.provinceId}">selected</c:if>>${province.provinceName }</option>
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
                                <span>
								品类:
								<select class="chzn-select" name="ypBaseCategoryId" id="ypBaseCategory" style="vertical-align:top;width: 115px">
									<option value="">全部</option>
									<c:forEach items="${ypBaseCategoryList}" var="ypBaseCategory">
                                        <option value="${ypBaseCategory.id}" <c:if test="${pd.ypBaseCategoryId==ypBaseCategory.id}">selected</c:if>>${ypBaseCategory.name}</option>
                                    </c:forEach>
								</select>
							</span>
                                <span>
								发布状态:
								<select class="chzn-select" name="status" id="status" style="vertical-align:top;width: 115px">
									<option value="">全部</option>
									<option value="1" <c:if test="${pd.status==1}">selected</c:if>>草稿</option>
									<option value="2" <c:if test="${pd.status==2}">selected</c:if>>发布</option>
									<option value="3" <c:if test="${pd.status==3}">selected</c:if>>下架</option>
								</select>
							</span>
                                <span class="input-icon">
								店铺名称:&nbsp;<input autocomplete="off" id="nav-search-input" type="text" name="keyWord" value="${keyWord}" placeholder="请输入关键词搜索" style="width:230px;"/>
								<i id="nav-search-icon" class="icon-search" style="margin-left: 70px"></i>
							</span>
                            </td>
                            <td style="vertical-align: top;">
                                <button class="btn btn-mini btn-light" onclick="search();" title="查询">
                                    <i id="nav-search-icon" class="icon-search"></i>
                                </button>
                            </td>
                            <td style="vertical-align:top;">
                                <a class="btn btn-small btn-success" style="line-height: 20px;margin-left: 5px" onclick="add();">发布</a>
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
                        <th style="text-align:center;">区域</th>
                        <th style="text-align:center;">商圈</th>
                        <th style="text-align:center;">品类</th>
                        <th style="text-align:center;">店铺</th>
                        <th style="text-align:center;">状态</th>
                        <th style="text-align:center;">发布时间</th>
                        <th style="text-align:center;">流量统计</th>
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
                                            <input type='checkbox' name='ids' value="${var.consultationShopId}" />
                                            <span class="lbl"></span>
                                        </label>
                                    </td>
                                    <td class='center' style="text-align:center;">${var.areaName}</td>
                                    <td class='center' style="text-align:center;">${var.districtName}</td>
                                    <td class='center' style="text-align:center;">${var.name}</td>
                                    <td class='center' style="text-align:center;">${var.shopName}</td>
                                    <td class='center' style="text-align:center;">
                                        <c:if test="${var.status ==1}">草稿</c:if>
                                        <c:if test="${var.status ==2}">发布</c:if>
                                        <c:if test="${var.status ==3}">已下架</c:if>
                                    </td>
                                    <td class='center' style="text-align:center;">${var.createTime}</td>
                                    <td class='center' style="text-align:center;">${var.visitCount}</td>
                                    <td class='center'  style="text-align:center;">
                                        <a href="javascript:void(0);" onclick="edit(${var.consultationShopId})">编辑</a>
                                        <c:choose>
                                            <c:when test="${var.status ==3 || var.status ==1}">
                                                <a href="javascript:void(0);" onclick="onSale(${var.consultationShopId})">发布</a>
                                            </c:when>
                                            <c:otherwise>
                                                <a href="javascript:void(0);" onclick="offSale(${var.consultationShopId})">下架</a>
                                            </c:otherwise>
                                        </c:choose>
                                        <a href="javascript:void(0);" onclick="del(${var.consultationShopId})">删除</a>
                                        <a href="javascript:void(0);" onclick="editFoodMeal(${var.consultationShopId})">编辑菜式</a>
                                        <a href="javascript:void(0);" onclick="preview(${var.consultationShopId})">预览</a>
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
                                <a class="btn btn-small btn-success" onclick="delAll('确定要删除选中的数据吗?');">批量删除</a>
                                <a class="btn btn-small btn-danger" onclick="offSelect('确定要下架选中的数据吗?');">批量下架</a>
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

    //检索
    function search(){
        top.jzts();
        $("#usersForm").submit();
    }

</script>

<script type="text/javascript">

    $(function() {

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
            var district = '${pd.district}';
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

        //单选框
        $(".chzn-select").chosen();
        $(".chzn-select-deselect").chosen({allow_single_deselect:true});

        //联动select事件
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

    });

    //发布
    function add(){
        var form = $("#usersForm");
        top.jzts();
        var diag = new top.Dialog();
        diag.Drag=true;
        diag.Title ="发布";
        diag.URL = '<%=basePath%>consultation/shop/toAdd.do';
        diag.Width = 900;
        diag.Height = 700;
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
        diag.URL = '<%=basePath%>consultation/shop/toEdit.do?action=2&id='+id;
        diag.Width = 850;
        diag.Height = 700;
        diag.CancelEvent = function(){ //关闭事件
            diag.close();
            search();
        };
        diag.show();
    }

    function preview(id){
    top.mainFrame.tab.add( {
    id :'preview',
    title :"预览",
    url :'<%=basePath%>consultation/shop/toPreview.do?id='+id,
    isClosed :true
    });
    }

    //修改菜式
    function editFoodMeal(id){
        top.jzts();
        var diag = new top.Dialog();
        diag.Drag=true;
        diag.Title ="编辑";
        diag.URL = '<%=basePath%>consultation/shop/toEditMeal.do?action=2&id='+id;
        diag.Width = 850;
        diag.Height = 500;
        diag.CancelEvent = function(){ //关闭事件
            diag.close();
            search();
        };
        diag.show();
    }

    //下架
    function offSale(id){
        if(confirm("确定下架吗?")){
            $.ajax({
                type: "POST",
                url: '<%=basePath%>consultation/shop/offSale.do',
                data: {id:id},
                dataType:'json',
                //beforeSend: validateData,
                cache: false,
                success: function(data){
                    if(data){
                        setTimeout("self.location=self.location",100);
                    }
                }
            });
        }
    }
    //发布
    function onSale(id){
        if(confirm("确定发布吗?")){
            $.ajax({
                type: "POST",
                url: '<%=basePath%>consultation/shop/onSale.do',
                data: {id:id},
                dataType:'json',
                //beforeSend: validateData,
                cache: false,
                success: function(data){
                    if(data){
                        setTimeout("self.location=self.location",100);
                    }
                }
            });
        }
    }
    //删除
    function del(Id){
        bootbox.confirm("确定要删除吗?", function(result) {
            if(result) {
                top.jzts();
                var url = "<%=basePath%>consultation/shop/deleteFoodById.do?brandId="+Id;
                $.get(url,function(data){
                    if(typeof(nextPage) == "function") {
                        nextPage(${page.currentPage});
                    }
                });
            }
        });
    }
    //批量下架
    function offSelect(msg){
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
                    if(msg == '确定要下架选中的数据吗?'){
                        top.jzts();
                        var url = "<%=basePath%>consultation/shop/offSaleAll.do?ids="+str;
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
                        var url = "<%=basePath%>consultation/shop/deleteAll.do?ids="+str;
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
</script>

</body>
</html>

