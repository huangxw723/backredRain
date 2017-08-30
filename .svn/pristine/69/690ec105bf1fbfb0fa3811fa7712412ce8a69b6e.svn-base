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
                <form action="ownActivity/addCountHistoryList" method="post" name="usersForm" id="usersForm">
                	<input type="hidden" id="currentPage" value="${pd.currentPage}"/>
					<input type="hidden" id="showCount" value="${pd.showCount}"/>
                    <table>
                        <tr>
                            <td>


							  <span class="input-icon">
								 <input autocomplete="off" id="nav-search-input" type="text" name="keyWord" value="${pd.keyWord}" placeholder="账号/用户昵称/操作人"style="width:230px;"/>
								  <i class="icon-search"  ></i>
							  </span>
                                &nbsp;&nbsp;&nbsp;
								<span class="input-icon">
								时间:&nbsp;<input id="startTime" type='text'  name="startTime"  value="${pd.startTime}" class="date-picker" placeholder="" data-date-format="yyyy-mm-dd hh:ii:ss " >
								</span>
								
							  <span class="input-icon">
								至&nbsp;<input id="endTime" type='text'  name="endTime" value="${pd.endTime}" class="date-picker" placeholder="" data-date-format="yyyy-mm-dd hh:ii:ss" >
							  </span>
                            </td>
                            <td style="vertical-align: top;">
                                &nbsp;
                                <button class="btn btn-mini btn-light" onclick="search();" title="查询">
                                    <i id="nav-search-icon" class="icon-search"></i>
                                </button>
                            </td>

                          	 
                        </tr>
                    </table>
                </form>
                
                
                <!-- 检索  -->
                <table id="table_report" class="table table-striped table-bordered table-hover">

                    <thead>
                    <tr>
                        <th style="text-align:center;">所属活动</th>
                        <th style="text-align:center;">账号</th>
                        <th style="text-align:center;">用户昵称</th>
                        <th style="text-align:center;">增加次数</th>
                        <th style="text-align:center;">方式</th>
                        <th style="text-align:center;">时间</th>
                        <th style="text-align:center;width: 150px">操作人</th>
                    </tr>
                    </thead>

                    <tbody>

                    <!-- 开始循环 -->
                    <c:choose>
                        <c:when test="${not empty list}">
                            <c:forEach items="${list}" var="var" varStatus="vs">

                                <tr>
                                    <td class='center' style="text-align:center;">${var.activityName}</td>
                                    <td class='center' style="text-align:center;">${var.account}</td>
                                    <td class='center' style="text-align:center;">${var.nickName}</td>
                                    <td class='center' style="text-align:center;">${var.count}</td>
                                    <td class='center' style="text-align:center;">
                                        <c:if test="${var.source ==1}">后台增加</c:if>
                                        <c:if test="${var.source ==2}">兑换优惠券增加</c:if>
                                    </td>
                                    <td class='center' style="text-align:center;">${var.createTime}</td>
                                    <td class='center' style="text-align:center;">${var.operator}</td>
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


</script>

</body>
</html>

