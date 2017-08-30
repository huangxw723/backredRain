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
        <form action="consultation/brand/brandList.do" method="post" name="usersForm" id="usersForm">
          <table>
            <tr>
              <td>
                  <span class="input-icon">
                    <input autocomplete="off" id="nav-search-input" type="text" name="keyWord" value="${keyWord}" placeholder="这里输入关键词" />
                    <i id="nav-search-icon" class="icon-search"></i>
                  </span>
              </td>
              <td style="vertical-align:top;">
                <button class="btn btn-mini btn-light" onclick="search();" title="检索">
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
                  <th class="center">
                    <label>
                      <input type="checkbox" id="zcheckbox" />
                      <span class="lbl"></span>
                    </label>
                  </th>
                  <th class="center">序号</th>
                  <th class="center">品牌名称</th>
                  <th class="center">品牌logo</th>
                  <th class="center">品牌分类</th>
                  <th class="center">品牌官网地址</th>
                  <th class="center">是否显示</th>
                  <th class="center">操作</th>
                </tr>
              </thead>

          <tbody>

                <!-- 开始循环 -->
                <c:choose>
                  <c:when test="${not empty list}">
                    <c:if test="${QX.cha == 1 }">
                      <c:forEach items="${list}" var="var" varStatus="vs">
                        <tr>
                          <td class='center' style="width: 30px;">
                            <label>
                              <input type='checkbox' name='ids' value="${var.brandId}" />
                              <span class="lbl"></span>
                            </label>
                          </td>
                          <td class='center' style="width: 30px;">${vs.index+1}</td>
                          <td class='center' style="max-width: 100px;overflow: hidden;white-space: nowrap;text-overflow: ellipsis;" title="${var.brandName}">${var.brandName}</td>
                          <td class="center" width="300">
                            <a class="fancybox" href="<%=httpUrl%>${var.brandLogo}">
                              <img src="<%=httpUrl%>${var.brandLogo}" alt="${var.brandLogo}" width="20px" height="20px" />
                            </a>
                          </td>
                          <td class='center' style="max-width: 100px;overflow: hidden;white-space: nowrap;text-overflow: ellipsis;" title="${var.ypBaseCategoryId}">
                            ${var.name}
                          </td>
                          <td class='center' style="max-width: 100px;overflow: hidden;white-space: nowrap;text-overflow: ellipsis;" title="${var.siteUrl}">${var.siteUrl}</td>
                          <td class='center' style="max-width: 100px;overflow: hidden;white-space: nowrap;text-overflow: ellipsis;" title="${var.isShow}">
                            <c:if test="${var.isShow == 'Y'}">
                              <span>显示</span>
                            </c:if>
                            <c:if test="${var.isShow == 'N'}">
                              <span>不显示</span>
                            </c:if>
                          </td>
                          <td style="width: 180px;" class="center">
                            <c:if test="${QX.edit != 1 && QX.del != 1 }">
                              <span class="label label-large label-grey arrowed-in-right arrowed-in">
                                <i class="icon-lock" title="无权限"></i>
                              </span>
                            </c:if>
                            <div class="inline position-relative">
                              <c:if test="${QX.edit == 1 || QX.del == 1 }">
                                <button class="btn btn-mini btn-info" data-toggle="dropdown">
                                  <i class="icon-cog icon-only"></i>
                                </button>
                                <ul class="dropdown-menu dropdown-icon-only dropdown-light pull-right dropdown-caret dropdown-close">
                                  <c:if test="${QX.edit == 1 }">
                                    <li>
                                      <a style="cursor:pointer;" title="编辑" onclick="edit('${var.brandId}');" class="tooltip-success" data-rel="tooltip" title=""
                                        data-placement="left">
                                        <span class="green">
                                          <i class="icon-edit"></i>
                                        </span>
                                      </a>
                                    </li>
                                  </c:if>
                                  <c:if test="${QX.del == 1 }">
                                    <li>
                                      <a style="cursor:pointer;" title="删除" onclick="del('${var.brandId}');" class="tooltip-error"
                                        data-rel="tooltip" title="" data-placement="left">
                                        <span class="red">
                                          <i class="icon-trash"></i>
                                        </span>
                                      </a>
                                    </li>
                                  </c:if>
                                </ul>
                              </c:if>
                            </div>
                          </td>
                        </tr>

                      </c:forEach>
                    </c:if>
                    <c:if test="${QX.cha == 0 }">
                      <tr>
                        <td colspan="100" class="center">您无权查看</td>
                      </tr>
                    </c:if>
                  </c:when>
                  <c:otherwise>
                    <tr class="main_info">
                      <td colspan="100" class="center">没有相关数据</td>
                    </tr>
                  </c:otherwise>
                </c:choose>


              </tbody>
            </table>

            <div class="page-header position-relative">
              <table style="width:100%;">
                <tr>
                  <td style="vertical-align:top;">
                    <c:if test="${QX.add == 1 }">
                      <a class="btn btn-small btn-success" onclick="add();">新增</a>
                    </c:if>
                    <c:if test="${QX.del == 1 }">
                      <a class="btn btn-small btn-danger" onclick="makeAll('确定要删除选中的数据吗?');" title="批量删除">
                        <i class='icon-trash'></i>
                      </a>
                    </c:if>
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
    top.jzts();
    var diag = new top.Dialog();
    diag.Drag=true;
    diag.Title ="新增";
    diag.URL = '<%=basePath%>consultation/brand/toAddBrand.do';
    diag.Width = 850;
    diag.Height = 560;
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
    };
    diag.show();
  }

  //批量操作
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
            var url = "<%=basePath%>consultation/brand/deleteAllBrand.do?ids="+str;
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
        var url = "<%=basePath%>consultation/brand/deleteBrandById.do?brandId="+Id;
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
    diag.URL = '<%=basePath%>consultation/brand/toEditBrand.do?action=2&brandId='+id+'&otype='+1;
    diag.Width = 730;
    diag.Height = 520;
    diag.CancelEvent = function(){ //关闭事件
      diag.close();
      search();
    };
    diag.show();
  }


  //更新状态
  function accountStatus(id,status){
    $.get("activityAd/accountStatus",{adId:id,status:status},function(data){

      if(data.status != 0){
        alert(data.msg);
        return;
      }

      alert("操作成功")
      setTimeout("self.location=self.location",100);
    },'json');
  }

  //删除
  function idelete(id){

    $.get("activityAd/delete",{adId:id},function(data){

      if(data.status != 0){
        alert(data.msg);
        setTimeout("self.location=self.location",100);
        return;
      }

      alert("操作成功")
      setTimeout("self.location=self.location",100);
    },'json');
  }



</script>

<script type="text/javascript">

  $(function() {

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

