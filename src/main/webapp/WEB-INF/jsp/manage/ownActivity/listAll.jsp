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
    <!--<link rel="stylesheet" href="static/css/datepicker.css" />--><!-- 日期框 -->
    <link rel="stylesheet" href="static/css/bootstrap-datetimepicker.min.css" /><!-- 日期框 -->
    <!--引入弹窗组件start-->
    <script type="text/javascript" src="plugins/attention/zDialog/zDrag.js"></script>
    <script type="text/javascript" src="plugins/attention/zDialog/zDialog.js"></script>
    <!--引入弹窗组件end-->
    <script type="text/javascript" src="static/js/jquery.tips.js"></script>
 
 <style type="text/css">
 	#cen{
 		text-align: center;
 	}
 </style>  
    
</head>

<body>

<div class="container-fluid" id="main-container">


    <div id="page-content" class="clearfix">

        <div class="row-fluid">


            <div class="row-fluid">

                <!-- 查询  -->
                <form action="ownActivity/listAll" method="post" name="usersForm" id="usersForm">   
                	<input type="hidden" id="currentPage" value="${currentPage}"/>
					<input type="hidden" id="showCount" value="${showCount}"/>
                    <table>
                        <tr>
                            <td>

                                <span class="input-icon">
									状态:
									<select name="status" id="status" style="width: 100px">
										<option value="">全部</option>
										<option value="0" <c:if test="${asOwnActivity.status == '0'}">selected="selected"</c:if>>未审核</option>
										<option value="1" <c:if test="${asOwnActivity.status == '1'}">selected="selected"</c:if>>未开始</option>
										<option value="2" <c:if test="${asOwnActivity.status == '2'}">selected="selected"</c:if>>进行中</option>
										<option value="3" <c:if test="${asOwnActivity.status == '3'}">selected="selected"</c:if>>已结束</option>
										<option value="4" <c:if test="${asOwnActivity.status == '4'}">selected="selected"</c:if>>驳回</option>
									</select>
								</span>

							  <span class="input-icon">
								 <input autocomplete="off" id="nav-search-input" type="text" name="activityName" value="${asOwnActivity.activityName}" placeholder="活动名称<c:if test="${isShop == 0}">/商户名称</c:if>" style="width:230px;"/>
								  <i class="icon-search"  ></i>
							  </span>
							  
								<span class="input-icon">
								活动时间:&nbsp;<input id="startTime" type='text'  name="startTime"  value="${asOwnActivity.startTime}" class="date-picker" placeholder="开始时间" data-date-format="yyyy-mm-dd hh:ii:ss " >
								</span>
								
							  <span class="input-icon">
								至&nbsp;<input id="endTime" type='text'  name="endTime" value="${asOwnActivity.endTime}" class="date-picker" placeholder="结束时间" data-date-format="yyyy-mm-dd hh:ii:ss" >
							  </span>
                            </td>
                            <td style="vertical-align: top;">
                                &nbsp;
                                <button class="btn btn-mini btn-light" onclick="search();" title="查询">
                                    <i id="nav-search-icon" class="icon-search"></i>
                                </button>
                            </td>
                            <td style="vertical-align:top;">
                              &nbsp; <a class="btn btn-small btn-success"   onclick="add()"<%--  <c:if test="${isShop != 1}">style="display: none;"</c:if> --%>  >新增</a>
                            </td>
                          	 
                        </tr>
                    </table>
                </form>
                
                
                <!-- 检索  -->
                <table id="table_report" class="table table-striped table-bordered table-hover">

                    <thead>
                    <tr>

                        <th style="text-align:center;">活动名称</th>
                        <c:if test="${isShop == 0}">
                            <th style="text-align:center;">商户名称</th>
                        </c:if>
                        <th style="text-align:center;">开始时间</th>
                        <th style="text-align:center;">结束时间</th>
                        <th style="text-align:center;">参与次数(人/天)</th>
                        <th style="text-align:center;">参与次数</th>
                        <th style="text-align:center;">参与人数</th>
                        <th style="text-align:center;">状态</th>
                        <th style="text-align:center;">操作</th>
                    </tr>
                    </thead>

                    <tbody>

                    <!-- 开始循环 -->
                    <c:choose>
                        <c:when test="${not empty list}">
                            <c:forEach items="${list}" var="var" varStatus="vs">

                                <tr>
                                    <td class='center' style="text-align:center;">${var.activityName}</td>
                                    <c:if test="${isShop == 0}">
                                        <td class='center' style="text-align:center;">${var.shopName}</td>
                                    </c:if>
                                    <td class='center' style="text-align:center;">${var.startTime}</td>
                                    <td class='center' style="text-align:center;">${var.endTime}</td>
                                    <td class='center' style="text-align:center;">${var.perCount }</td>
                                    <td class='center' style="text-align:center;">${var.countNum}</td>                                    
                                    <td class='center' style="text-align:center;">${var.peopleNum}</td>                                    
                                    <td class='center' style="text-align:center;">
                                    	<c:if test="${var.auditStatus ==0}">未审核</c:if>
                                        <c:if test="${var.auditStatus ==1}">
                                        	<c:if test="${var.status ==1}">进行中</c:if>
                                        	<c:if test="${var.status ==2}">未开始</c:if>
                                        	<c:if test="${var.status ==3}">已结束</c:if>
                                        </c:if>
                                        <c:if test="${var.auditStatus ==2}"><a href="javascript:void(0);" onclick="returnDesc(${var.ownActivityId})" >驳回</a></c:if>
                                    </td>                                    
                            	    <td class='center'  style="text-align:center;">
                            	    	<div id='cen'>
	                                        <a href="javascript:void(0);" onclick="preview(${var.ownActivityId},${var.status})" >详情</a>
	                                        <a href="javascript:void(0);" onclick="edit(${var.ownActivityId},${var.status})" <c:if test="${var.status==3 && var.auditStatus ==2||var.status==3 && var.auditStatus ==1|| var.auditStatus ==2}">style="display: none;"</c:if>>编辑</a>

	                                        <c:if test="${var.status==2||var.auditStatus !=1}">
                                                <%--<c:if test="${isShop != 0}">
                                                    <a href="javascript:void(0);" onclick="del(${var.ownActivityId},'${var.activityName}')" >删除</a>
                                                 </c:if>--%>
                                                    <a href="javascript:void(0);" onclick="del(${var.ownActivityId},'${var.activityName}')" >删除</a>
                                            </c:if>
	                                        <c:if test="${var.status ==1}">
	                                       		 <a href="javascript:void(0);" onclick="off(${var.ownActivityId},'${var.activityName}')">终止活动</a>
	                                        </c:if>
                                            <c:if test="${var.status ==1 &&var.auditStatus ==1}">
                                                <a href="javascript:void(0);" onclick="addCount(${var.ownActivityId},'${var.shopId}')">增加抽奖次数</a>
                                            </c:if>
                            	    	</div>
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
<!-- <script type="text/javascript" src="static/js/bootstrap-datepicker.min.js"></script> --><!-- 日期框 -->
<script type="text/javascript" src="static/js/bootstrap-datetimepicker.js"></script><!-- 日期框 -->
<script type="text/javascript" src="static/js/bootstrap-datetimepicker.zh-CN.js"></script><!-- 日期框 -->
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
   
   //检索
   function search(){
       top.jzts();
       var form = $("#usersForm");
       form.find('#currentPage').attr('name','currentPage');
       form.find('#showCount').attr('name','showCount');
       form.submit();
    } 

</script>

<script type="text/javascript">


    $(function() {

        //单选框
        $(".chzn-select").chosen();
        $(".chzn-select-deselect").chosen({allow_single_deselect:true});
        //日期框
        //$('.date-picker').datepicker();
        $('#startTime').datetimepicker({
            minuteStep :1,
            language:  'zh-CN',
            autoclose: 1,
            format: "yyyy-mm-dd hh:ii:00",
        }).on('changeDate',function(e){
            var startTime = e.date;
            $('#endTime').datetimepicker('setStartDate',startTime);
        });

        $('#endTime').datetimepicker({
            minuteStep :1,
            language:  'zh-CN',
            autoclose : 1,
            format: "yyyy-mm-dd hh:ii:00",
        }).on('changeDate',function(e){
            var endTime = e.date;
            $('#startTime').datetimepicker('setEndDate',endTime);
        });

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
    
	
	
    //查看
	function preview(id,status){
		
		top.jzts();
		var diag = new top.Dialog();
		diag.Drag=true;
		diag.Title ="查看详情";
		diag.URL='<%=basePath%>ownActivity/preview?ownActivityId='+id+'&status='+status; 
		diag.Width = 900;
        diag.Height = 700;
		diag.CancelEvent = function(){ //关闭事件
			diag.close();
			
		 };
		
		diag.show();
	}
    
    //驳回
    function returnDesc(id){
    	top.jzts();
		var diag = new top.Dialog();
		diag.Drag=true;
		diag.Title ="驳回理由";
		diag.URL='<%=basePath%>ownActivity/returnDesc?ownActivityId='+id; 
		diag.Width = 600;
        diag.Height = 350;
		diag.CancelEvent = function(){ //关闭事件
			diag.close();
			
		 };
		
		diag.show();
    }
    
    //添加
	function add(){
/*
        $.ajax({
            type: "POST",
            url: '<%=basePath%>ownActivity/isProceed.do',
            dataType:'json',
            cache: false,
            success: function(data){
                if(data){
                    alert("同一时间内只能进行一个活动！");
                    window.location.reload();
                    return ;
                }else {

                }
            }
        });*/
        top.jzts();
        var diag = new top.Dialog();
        diag.Drag=true;
        diag.Title ="新增";
        diag.URL = '<%=basePath%>ownActivity/down';
        diag.Width = 900;
        diag.Height = 700;
        diag.CancelEvent = function(){ //关闭事件
            diag.close();
            ref();
        };
        diag.show();

	}

 
    //修改
    function edit(id,status){
        var diag = new top.Dialog();
        diag.Drag=true;
        diag.Title ="编辑";
        diag.URL = '<%=basePath%>ownActivity/toEdit?action=2&ownActivityId='+id+'&status='+status;
        diag.Width = 900;
        diag.Height = 700;
        diag.CancelEvent = function(){ //关闭事件
            diag.close(); 
            ref();
        };
        diag.show();
    }

    
	//删除
	function del(id,name){
        bootbox.confirm("确定要删除该活动【"+name+"】吗?",function(result){
            if(result) {
                $.ajax({
                    type: "POST",
                    url: "<%=basePath%>ownActivity/delete.do",
                    data: {ownActivityId:id},
                    dataType:'json',
                    success: function(data){
                        if(data.status == 0){
                            alert("操作失败");
                            return;
                        }
                       // setTimeout("self.location=self.location",100);
                       window.location.reload();
                    }
                });
            }
        });

	}
	   
	//立即终止
	function off(id,name){
        bootbox.confirm("确定要立即终止该活动【"+name+"】吗?",function(result){
            if(result) {
                $.ajax({
                    type: "POST",
                    url: "<%=basePath%>ownActivity/off.do",
                    data: {ownActivityId:id},
                    dataType:'json',
                    success: function(data){
                        if(data.status == 0){
                            alert("操作失败");
                            return;
                        }
                        //setTimeout("self.location=self.location",100);
                        window.location.reload();
                    }
                });
            }else{
                window.location.reload();
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
                        var url = "<%=basePath%>cate/offSaleAll.do?ids="+str;
                        $.get(url,function(data){
                            if(typeof(nextPage) == "function") {
                                //nextPage(${page.currentPage});
                            	location.reload()

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
                        
                        var url = "<%=basePath%>cate/deleteAll.do?ids="+str;
                        $.get(url,function(data){
                            if(typeof(nextPage) == "function") {
                              //  nextPage(${page.currentPage});
                            	location.reload()

                            }
                        });

                    }
                }
            }
        });
    }

    //增加抽奖次数
    function addCount(id,shopId){

        top.jzts();
        var diag = new top.Dialog();
        diag.Drag=true;
        diag.Title ="增加抽奖次数";
        diag.URL='<%=basePath%>ownActivity/toAddCount?ownActivityId='+id+"&shopId="+shopId;
        diag.Width = 900;
        diag.Height = 500;
        diag.CancelEvent = function(){ //关闭事件
            diag.close();

        };

        diag.show();
    }



</script>

</body>
</html>

