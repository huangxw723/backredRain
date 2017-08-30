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

<form action="link/beacon/saveBeaconClassIfy.do" name="form" id="form" method="post">
  <div id="zhongxin">
    <table id="table_report" class="table table-striped table-bordered table-hover">
      <tr>
        <th>分类名称:</th>
        <td>
              <span>
				<input type="text"   name="name" id="name">
				</span>
        </td>
      </tr>
      <tr id="operaArea">
        <td class="center" colspan="2">
          <a class="btn btn-mini btn-primary" onclick="save();">保存</a>
          <a class="btn btn-mini btn-danger" onclick="top.Dialog.close();">取消</a>
        </td>
      </tr>
    </table>
  </div>
</form>
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
    function save(){

        if($("#name").val()==""||$.trim($("#name").val())==""){
            $("#name").tips({
                side:3,
                msg:'请填写分类名称',
                bg:'#AE81FF',
                time:2
            });
            $("#name").focus();
            return false;
        }
        form.submit($('#form'));
    }
    form = {

        submit:function(formElement){


            var iUrl = formElement.attr('action');
            var data = new Object();
            $.each(formElement.serializeArray(),function(index,item){

                var key = item.name;
                var value = item.value;
                data[key] = value;
            });

            $.ajax({
                type: "POST",
                url: iUrl,
                data: data,
                dataType: "json",
                success: function(data){

                    alert(data.msg)

                    if(data.status == 0){

                        formElement[0].reset()

                        var element = document.getElementById('zhongxin');
                        element.style.display = 'none';
                        top.Dialog.close();

                    }else if(data.status == 1){
                      /* formElement[0].reset()

                       var element = document.getElementById('zhongxin');
                       element.style.display = 'none';
                       top.Dialog.close(); */
                    }

                },
                error:function(data){
                    alert('系统繁忙')
                }
            });
        }
    }
</script>

</body>
</html>

