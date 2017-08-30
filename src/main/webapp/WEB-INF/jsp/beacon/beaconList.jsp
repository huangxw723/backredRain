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
        <form action="link/beacon/beaconList.do" method="post" name="usersForm" id="usersForm" style="margin: 10px">
          <input type="hidden" name="currentPage" id="currentPage" value="${page.currentPage}"/>
          <input type="hidden" name="showCount" id="showCount" value="${page.showCount}"/>
          <table>
            <tr>
              <td style="vertical-align: top;">
                  <span class="input-icon">
                    <span>终端名称:</span>
                    <input autocomplete="off" id="nav-search-input" type="text" name="keyWord" value="${keyWord}" placeholder="这里输入终端名称" style="margin-bottom: 0px"/>
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
               <td style="vertical-align: top;">
                &nbsp;
                <a class="btn btn-small btn-success" onclick="toExcel();">导入Excel</a>                          
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
                  <th class="center">名称范围</th>
                  <th class="center">mac地址</th>
                  <th class="center">UUID</th>
                  <th class="center">蓝牙名称</th>
                  <th class="center">major</th>
                  <th class="center">minor</th>
                  <th class="center">终端名称</th>
                  <th class="center">上屏编码</th>
                  <th class="center">下屏编码</th>
                  <th class="center">上下屏系统</th>
                  <th class="center">上下屏型号</th>
                  <th class="center">开机时间</th>
                  <th class="center">关机时间</th>
                  <th class="center">终端地址</th>
                  <th class="center">屏幕类型</th>
                  <th class="center">所属分类</th>
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
                              <input type='checkbox' name='ids' value="${var.beaconId}" />
                              <span class="lbl"></span>
                            </label>
                          </td>
                          <td class='center' style="max-width: 100px;overflow: hidden;white-space: nowrap;text-overflow: ellipsis;" title="${var.beaconName}">${var.beaconName}</td>
                          <td class='center' style="max-width: 100px;overflow: hidden;white-space: nowrap;text-overflow: ellipsis;" title="${var.beaconMac}">${var.beaconMac}</td>
                          <td class='center' style="max-width: 100px;overflow: hidden;white-space: nowrap;text-overflow: ellipsis;" title="${var.beaconUid}">${var.beaconUid}</td>
                          <td class='center' style="max-width: 100px;overflow: hidden;white-space: nowrap;text-overflow: ellipsis;" title="${var.beaconBlue}">${var.beaconBlue}</td>
                          <td class='center' style="max-width: 100px;overflow: hidden;white-space: nowrap;text-overflow: ellipsis;" title="${var.major}">${var.major}</td>
                          <td class='center' style="max-width: 100px;overflow: hidden;white-space: nowrap;text-overflow: ellipsis;" title="${var.minor}">${var.minor}</td>
                          <td class='center' style="max-width: 100px;overflow: hidden;white-space: nowrap;text-overflow: ellipsis;" title="${var.screenName}">${var.screenName}</td>
                          <td class='center' style="max-width: 100px;overflow: hidden;white-space: nowrap;text-overflow: ellipsis;" title="${var.upScreenCode}">${var.upScreenCode}</td>
                          <td class='center' style="max-width: 100px;overflow: hidden;white-space: nowrap;text-overflow: ellipsis;" title="${var.downScreenCode}">${var.downScreenCode}</td>
                          <td class='center' style="max-width: 100px;overflow: hidden;white-space: nowrap;text-overflow: ellipsis;" title="${var.screenSystem}">${var.screenSystem}</td>
                          <td class='center' style="max-width: 100px;overflow: hidden;white-space: nowrap;text-overflow: ellipsis;" title="${var.screenModel}">${var.screenModel}</td>
                          <td class='center' style="max-width: 100px;overflow: hidden;white-space: nowrap;text-overflow: ellipsis;" title="${var.startupTime}">${var.startupTime}</td>
                          <td class='center' style="max-width: 100px;overflow: hidden;white-space: nowrap;text-overflow: ellipsis;" title="${var.shutdownTime}">${var.shutdownTime}</td>
                          <td class='center' style="max-width: 100px;overflow: hidden;white-space: nowrap;text-overflow: ellipsis;" title="${var.screenAddress}">${var.screenAddress}</td>
                          <td class='center' style="max-width: 100px;overflow: hidden;white-space: nowrap;text-overflow: ellipsis;" title="${var.screenType}">${var.screenType}</td>
                          <td class='center' style="max-width: 100px;overflow: hidden;white-space: nowrap;text-overflow: ellipsis;" title="${var.categoryName}">${var.categoryName}</td>
                          <td class='center'  style="text-align:center;">
                            <a href="javascript:void(0);" onclick="edit(${var.beaconId})">编辑</a><br>
                            <a href="javascript:void(0);" onclick="del(${var.beaconId})">删除</a>
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
  
  //Excel导入页面
  function toExcel(){
    var form = $("#usersForm");
    top.jzts();
    var diag = new top.Dialog();
    diag.Drag=true;
    diag.Title ="导入Excel";
    diag.URL = '<%=basePath%>link/beacon/goUploadExcel.do';
    diag.Width = 520;
    diag.Height = 250;
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
  
  //新增
  function add(){
    var form = $("#usersForm");
    top.jzts();
    var diag = new top.Dialog();
    diag.Drag=true;
    diag.Title ="新增";
    diag.URL = '<%=basePath%>link/beacon/toAddBeacon.do';
    diag.Width = 850;
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

  //批量选择
  function makeAll(msg){
    bootbox.confirm(msg, function(result) {
      if(result) {
        var str = '';
        for(var i=0;i < document.getElementsByName('ids').length;i++)
        {
          if(document.getElementsByName('ids')[i].checked){
            if(str==''){
              str += document.getElementsByName('ids')[i].value;
            }else{
            	str += ',' + document.getElementsByName('ids')[i].value;
            }
          }
        }
        if(str==''){
          bootbox.dialog("您没有选择任何内容!",
                  [
                    {
                      "label" : "关闭",
                      "class" : "btn-small btn-success",
                      "callback": function() {
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
            var url = "<%=basePath%>link/beacon/deleteAll.do?ids="+str;
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
        var url = "<%=basePath%>link/beacon/delById.do?id="+Id;
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
    diag.URL = '<%=basePath%>link/beacon/toEdit.do?beaconId='+id;
    diag.Width = 850;
    diag.Height = 700;
    diag.CancelEvent = function(){ //关闭事件
      diag.close();
      search();
    };
    diag.show();
  }
  
  function fresh(){
    setTimeout("self.location=self.location",100);
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

  });



</script>

</body>
</html>

