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
                <form action="specialty/cateList" method="post" name="usersForm" id="usersForm"> 
                    <input type="hidden" id="currentPage" value="${pd.currentPage}"/>
					<input type="hidden" id="showCount" value="${pd.showCount}"/>       
                    <table>
                        <tr>
                            <td>
                          		  城市:						
								<select  name="provinceId" id="provinceId" onchange="select()" class="chzn-select" style="vertical-align:top;width: 115px" >
								  <option value="">省份</option>
								  <c:forEach items="${provinceList}" var="pro">
                                      <option value="${pro.provinceId }" <c:if test="${food.provinceId==pro.provinceId}">selected="selected"</c:if>>${pro.provinceName }</option>
                                  </c:forEach>
            					</select>							                            			
								<select name="cityId" id="cityId" class="chzn-select" style="vertical-align:top;width: 115px" > 
									 	<option value="" >城市</option>
									 	<c:if test="${not empty cityList }">
									 		<c:forEach items="${cityList}" var="list">
									 			<option value="${list.cityId }" <c:if test="${city ==list.cityId}">selected="selected"</c:if>>${list.cityName }</option>
									 		</c:forEach>
									 	</c:if>
            					</select>           
								资讯类型:
								<select  name="typeId" id="typeId"  class="chzn-select" style="vertical-align:top;width: 115px" disabled="disabled">
            						<option value="44">特产</option> 
            					</select>							
								发布状态:
								<select  name="status" id="status" class="chzn-select" style="vertical-align:top;width: 115px">
									<option value="0" <c:if test="${food.status==0}">selected="selected"</c:if>>全部</option>									
									<option value="1" <c:if test="${food.status==1}">selected="selected"</c:if>>草稿</option>
									<option value="2" <c:if test="${food.status==2}">selected="selected"</c:if>>发布</option>
									<option value="3" <c:if test="${food.status==3}">selected="selected"</c:if>>下架</option>
								</select>							                             
								<span class="input-icon">
								标题名称:&nbsp;<input autocomplete="off" id="nav-search-input" type="text" name="name" value="${food.name}" placeholder="请输入关键词搜索" style="width:230px;"/>
								<i id="nav-search-icon" class="icon-search" style="margin-left: 70px"></i>
							</span>
                            </td>
                            <td style="vertical-align: top;">
                                <button class="btn btn-mini btn-light" onclick="search();" title="查询">
                                    <i id="nav-search-icon" class="icon-search"></i>
                                </button>
                            </td>
                            <td style="vertical-align:top;">
                                <a class="btn btn-small btn-success"   onclick="add()"  style="line-height: 20px;margin-left: 5px" >发布</a>
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
                                <input type="checkbox" id="zcheckbox"  />
                                <span class="lbl"></span>
                            </label>
                        </th>
                        <th style="text-align:center;">省份</th>
                        <th style="text-align:center;">城市</th>
                        <th style="text-align:center;">类型</th>
                        <th style="text-align:center;">二级分类</th>
                        <th style="text-align:center;">标题</th>
                        <th style="text-align:center;">状态</th>
                        <th style="text-align:center;">发布时间</th>
                        <th style="text-align:center;">浏览量统计</th>
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
                                            <input type='checkbox' name='ids' value="${var.consultationSpecialtyId}"/>                                           
                                            <span class="lbl"></span>
                                        </label>
                                    </td>
                                    <td class='center' style="text-align:center;">${var.province.provinceName}</td>
                                    <td class='center' style="text-align:center;">${var.city.cityName}</td>
                                    
                                    <td class='center' style="text-align:center;">${var.asConsultationType.typeName}</td>
                                    <td class='center' style="text-align:center;">/</td>
                                    <td class='center' style="text-align:center;">${var.name}</td>                                    
                                    <td class='center' style="text-align:center;">
                                        <c:if test="${var.status ==1}">草稿</c:if>
                                        <c:if test="${var.status ==2}">发布</c:if>
                                        <c:if test="${var.status ==3}">已下架</c:if>
                                    </td>                                  
                                    <td class='center' style="text-align:center;">${var.publicTime}</td>
                                    <td class='center' style="text-align:center;">${var.visitCount}</td>
                            	    <td class='center'  style="text-align:center;">
                            	    	<a href="javascript:void(0);" onclick="preview(${var.consultationSpecialtyId})">预览</a>
                                        <a href="javascript:void(0);" onclick="edit(${var.consultationSpecialtyId})">编辑</a>
                                        <c:choose>
                                            <c:when test="${var.status ==1 || var.status ==3}">
                                                <a href="javascript:void(0);" onclick="status(${var.consultationSpecialtyId},2)">发布</a>
                                            </c:when>
                                            <c:otherwise>
                                                <a href="javascript:void(0);" onclick="status(${var.consultationSpecialtyId},3)">下架</a>
                                            </c:otherwise>
                                        </c:choose>
                                        <a href="javascript:void(0);" onclick="del(${var.consultationSpecialtyId})">删除</a>
                                    </td>
                                </tr> 

                            </c:forEach>



                        </c:when>
                        <c:otherwise>
                            <tr class="main_info">
                                <td colspan="10" class="center">没有相关数据</td>
                            </tr>
                        </c:otherwise>
                    </c:choose>


                    </tbody>
                </table>

                <div class="page-header position-relative">
                    <table style="width: 100%;">
                        <tr>
                            <td style="vertical-align:top;">
                                <a class="btn btn-small btn-danger" onclick="delAll('确定要删除选中的数据吗?');"><i class='icon-trash'></i>批量删除</a>
                                <a class="btn btn-small btn-success" onclick="offSelect('确定要下架选中的数据吗?');">批量下架</a>
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

  	//刷新
	   function ref(){
	 	window.location.reload(); 
	   }

</script>

<script type="text/javascript">

    $(function() {

        //单选框
        $(".chzn-select").chosen();
        $(".chzn-select-deselect").chosen({allow_single_deselect:true});
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
    
  
	
	 //预览
	function preview(id){
		
		top.jzts();
		var diag = new top.Dialog();
		diag.Drag=true;
		diag.Title ="特产资讯";
		diag.URL='<%=basePath%>specialty/preview?id='+id; 
		diag.Width = 700;
		diag.Height = 800;
		diag.CancelEvent = function(){ //关闭事件
			diag.close();
			
		 };
		
		diag.show();
	}
    
    //发布资讯
	function add(){
		var form = $("#usersForm");
		
		top.jzts();
		var diag = new top.Dialog();
		diag.Drag=true;
		diag.Title ="新增";
		diag.URL = '<%=basePath%>specialty/specialtyRelease';
		diag.Width = 900;
		diag.Height = 700;
		 diag.CancelEvent = function(){ //关闭事件
				diag.close();
		 		ref();
			 };
		diag.show();
	}

	 //级联查询城市
    function select() {
    	if($("#provinceId").val()==""){
    		$("#cityId").empty().append("<option value=''>城市</option>");
    		$("#cityId").trigger("liszt:updated");
    		return;
    	}
		 
 	$("#cityId").empty().append("<option value=''>城市</option>");
     $.ajax(
     {
         type: "post",
         url: "cate/city",
         data: { "provinceId":$('#provinceId').val() },
         success: function (msg) {            	
             for (var i = 0; i < msg.length; i++) {
               $("#cityId").append("<option value=" + msg[i].cityId +">" + msg[i].cityName + "</option>");                    
            	 $("#cityId").trigger("liszt:updated");
             }                         
         }
     });
 };
    
 
    //修改
    function edit(id){
       // top.jzts();
        var diag = new top.Dialog();
        diag.Drag=true;
        diag.Title ="编辑";
        diag.URL = '<%=basePath%>specialty/toEdit.do?id='+id;
        diag.Width = 900;
        diag.Height = 700;
        diag.CancelEvent = function(){ //关闭事件
            diag.close(); 
        	ref();
        };
        diag.show();
    }
    
    //修改菜式
    function editFoodMeal(id){
        top.jzts();
        var diag = new top.Dialog();
        diag.Drag=true;
        diag.Title ="编辑";
        diag.URL = '<%=basePath%>specialty/toEditMeal.do?action=2&id='+id;
        diag.Width = 1000;
        diag.Height = 600;
        diag.CancelEvent = function(){ //关闭事件
            diag.close();
            search();
        };
        diag.show();
    }
    
	//更新状态
	function status(id,status){
		$.get("specialty/editStatus",{consultationSpecialtyId:id,status:status},function(data){
			
			if(data.status != 0){
				alert(data.msg);
				return;
			}
			
			alert("操作成功")
			setTimeout("self.location=self.location",100);
		},'json');
	}
    
	//删除
	function del(id){
		if(confirm("确定删除吗?")){
		$.get("specialty/delete",{consultationSpecialtyId:id},function(data){
			
			if(data.status != 0){
				alert(data.msg);
				setTimeout("self.location=self.location",100);
				return;
			}
			
			setTimeout("self.location=self.location",100);
		},'json');
	}
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
                       // top.jzts();                   
                        var url = "<%=basePath%>specialty/offSaleAll.do?ids="+str;
                        $.get(url,function(data){
                           ref();
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
                       // top.jzts();
                        
                        var url = "<%=basePath%>specialty/deleteAll.do?ids="+str;
                        $.get(url,function(data){
                           ref();
                        });

                    }
                }
            }
        });
    }

   

</script>

</body>
</html>

