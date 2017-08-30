<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.aoshi.util.PropertyUtils" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
  String path = request.getContextPath();
  String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
  String httpUrl = PropertyUtils.getHTTP_URL();
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

        <!-- 检索  -->
        <form action="link/beaconGroup/beaconList.do" method="post" name="usersForm" id="usersForm" style="margin: 10px">
          <input type="hidden" name="currentPage" id="currentPage" value="${page.currentPage}"/>
          <input type="hidden" name="showCount" id="showCount" value="${page.showCount}"/>
          <input type="hidden" id="prizeIds" name="prizeIds" value="${prizeIds}"/>
          <input type="hidden" id="beaconIds" name="beaconIds" value="${beaconIds}"/>
          <table>
            <tr style="vertical-align: top;">
              <td>
                  <span class="input-icon">
                    <span>beacon组名:</span>
                    <input autocomplete="off" id="nav-search-input" type="text" name="keyWord" value="${keyWord}" placeholder="这里输入beacon组名" style="margin-bottom: 0px"/>
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
                  <th class="center">序号</th>
                  <th class="center">beacon组名</th>
                 <%-- <th class="center">beacon所属商户</th>--%>
                  <th class="center">是否选择礼品</th>
                  <th class="center">是否选择beacon</th>
                  <th class="center">操作</th>
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
                              <input type='checkbox' name='ids' value="${var.beaconLinkId}" />
                              <span class="lbl"></span>
                            </label>
                          </td>
                          <td class='center' style="width: 30px;">${vs.index+1}</td>
                          <td class='center' style="max-width: 100px;overflow: hidden;white-space: nowrap;text-overflow: ellipsis;" title="${var.beaconName}">${var.beaconName}</td>
                         <%-- <td class='center' style="max-width: 100px;overflow: hidden;white-space: nowrap;text-overflow: ellipsis;" title="${var.beaconDesc}">
                            <c:choose>
                              <c:when test="${not empty var.beaconDesc}">
                                ${var.beaconDesc}
                              </c:when>
                              <c:otherwise>
                                无
                              </c:otherwise>
                            </c:choose>
                          </td>--%>
                          <td class='center' style="max-width: 100px;overflow: hidden;white-space: nowrap;text-overflow: ellipsis;" >
                            <c:choose>
                              <c:when test="${var.prizeChoosed==true}">
                               是                                          <a href="javascript:void(0);" onclick="queryPrize(${var.beaconLinkId},4)">查看详情</a>
                              </c:when>
                              <c:otherwise>
                                否
                              </c:otherwise>
                            </c:choose>
                          </td>
                          <td class='center' style="max-width: 100px;overflow: hidden;white-space: nowrap;text-overflow: ellipsis;" >
                            <c:choose>
                              <c:when test="${var.beaconChoosed==true}">
                                是                                            <a href="javascript:void(0);" onclick="queryBeacon(${var.beaconLinkId},4)">查看详情</a>
                              </c:when>
                              <c:otherwise>
                                否
                              </c:otherwise>
                            </c:choose>
                          </td>
                          </td>
                          <td class='center'  style="text-align:center;">
                            <c:choose>
                              <c:when test="${var.status==0}">
                                <a href="javascript:void(0);" onclick="onUse('确定要启用吗?',${var.beaconLinkId},${var.beaconChoosed})">启用</a>
                              </c:when>
                              <c:otherwise>
                                <a href="javascript:void(0);" onclick="offUse('确定要禁用吗?',${var.beaconLinkId},${var.beaconChoosed})">禁用</a>
                              </c:otherwise>
                            </c:choose>
                            <a href="javascript:void(0);" onclick="edit(${var.beaconLinkId})">编辑</a>
                            <a href="javascript:void(0);" onclick="del(${var.beaconLinkId})">删除</a>
                          </td>
                        </tr>

                      </c:forEach> 
                  </c:when>
                  <c:otherwise>
                    <tr class="main_info">
                      <td colspan="100" class="center">没有相关数据<a style="text-decoration: none;cursor:pointer" onclick="fresh()">刷新</a></td>
                    </tr>
                  </c:otherwise>
                </c:choose>


              </tbody>
            </table>

            <div class="page-header position-relative">
              <table style="width:100%;">
                <tr>
                  <td style="vertical-align:top;">
                    <a class="btn btn-small btn-danger" onclick="makeAll('确定要删除选中的数据吗?');"title="批量删除" ><i class='icon-trash'></i></a>
                  </td>
                  <td style="vertical-align:top;">
                    <div class="pagination" style="float: right;padding-top: 0px;margin-top: 0px;">${page.pageStr}</div>
                  </td>
                </tr>
              </table>
            </div>
          </form>
        </div>
        <!-- PAGE CONTENT ENDS HERE -->
      </div>
      <!--/row-->
    </div>
    <!--/#page-content-->
  </div>
  <!--/.fluid-container#main-container-->

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
<!-- 引入 图片预览功能 -->
<link rel="stylesheet" type="text/css" href="plugins/fancyBox/jquery.fancybox.css">
<script type="text/javascript" src="plugins/fancyBox/jquery.fancybox.pack.js"></script>

<script type="text/javascript" src="static/js/jquery.tips.js"></script><!--提示框-->
<script type="text/javascript">

  $(top.hangge());
  //检索
  function search(){
    top.jzts();
    $("#usersForm").submit();
  }

  //新增
  function add(){
    var form = $("#usersForm");
    top.jzts();
    var diag = new top.Dialog();
    diag.Drag=true;
    diag.Title ="新增";
    diag.URL = '<%=basePath%>link/beaconGroup/toAddBeacon.do';
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

  //查看已选的beacon
  function 	queryBeacon(id,action){	
		var beaconIds = 0;
    	if($("#beaconIds").val()==""||$.trim($("#beaconIds").val())==""){
    		 beaconIds = 0;
    	}
		var diag = new top.Dialog();
		diag.Drag=true;
		diag.Title ="查看已选择的beacon";
		diag.URL = '<%=basePath%>link/beaconGroup/editBeacon.do?id='+id+'&action='+action+'&idse='+beaconIds;
		diag.Width = 1300;
		diag.Height = 700;
		diag.CancelEvent = function(){ //关闭事件
			diag.close();
		};
		top.Dialog.getCheckBoxBeaconId = function(str) {
			$("#beaconchoosed").val(str);	
			console.info(str);
			$("#choose2 a").empty().html("已选择");
		}
		diag.show();

	}
  
    //查看已选择的礼品
	function queryPrize(id,action){
		var  prizeIds = 0;
  	if($("#prizeIds").val()==""||$.trim($("#prizeIds").val())==""){
  		 prizeIds = 0;
  	}
		var diag = new top.Dialog();
		diag.Drag=true;
		diag.Title ="查看已选择的礼品";
		diag.URL = '<%=basePath%>link/beaconGroup/editPrize.do?id='+id+'&action='+action+'&idse='+prizeIds;
		diag.Width = 1200;
		diag.Height = 700;
		diag.CancelEvent = function(){ //关闭事件
			diag.close();
		};
		top.Dialog.getCheckboxPrizeId = function(str) {
			$("#prizechoosed").val(str);
			console.info(str);
			$("#choose a").empty().html("已选择");
		};
		diag.show();

	}
  
  //批量选择
  function makeAll(msg){
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
            var url = "<%=basePath%>link/beaconGroup/deleteAll.do?ids="+str;
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

  //删除
  function del(Id){
    bootbox.confirm("确定要删除吗?", function(result) {
      if(result) {
        top.jzts();
        var url = "<%=basePath%>link/beaconGroup/delById.do?id="+Id;
        $.get(url,function(data){
          if(typeof(nextPage) == "function") {
            nextPage(${page.currentPage});
          }
        });
      }
    });
  }

  //修改
  function edit(id){
    top.jzts();
    var diag = new top.Dialog();
    diag.Drag=true;
    diag.Title ="编辑";
    diag.URL = '<%=basePath%>link/beaconGroup/toEdit.do?beaconLinkId='+id;
    diag.Width = 850;
    diag.Height = 700;
    diag.CancelEvent = function(){ //关闭事件
      diag.close();
      search();
    };
    diag.show();
  }
  function fresh() {
    setTimeout("self.location=self.location",100);
  }
  //启用
  function onUse(msg,id,isBeaconChoose){
    bootbox.confirm(msg, function(result) {
      if(result) {
        if(isBeaconChoose==false){
          bootbox.dialog("您没有选择beacon终端!",
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
        }else{
          if(msg == '确定要启用吗?'){
            top.jzts();
            var url = "<%=basePath%>link/beaconGroup/onUse.do?id="+id;
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

  //禁用
  function offUse(msg,id,isBeaconChoose){
    bootbox.confirm(msg, function(result) {
      if(result) {
        if(isBeaconChoose==false){
          bootbox.dialog("您没有选择beacon终端!",
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
        }else{
          if(msg == '确定要禁用吗?'){
            top.jzts();
            var url = "<%=basePath%>link/beaconGroup/offUse.do?id="+id;
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
</script>

<script type="text/javascript">

  $(function() {

    //日期框
    $('.date-picker').datepicker();
    $("#sear").click(function () {
      search()
    })
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

    $(".fancybox").fancybox({
      helpers: {
        title: {
          type: 'inside'
        }
      }
    });

  });



</script>

</body>
</html>

