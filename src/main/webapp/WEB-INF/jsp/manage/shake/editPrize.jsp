<%@ page import="com.aoshi.util.PropertyUtils" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="d" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
    String httpUrl = PropertyUtils.getHTTP_URL();
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <base href="<%=basePath%>">
    <!-- jsp文件头和头部 -->
    <%@ include file="../../system/admin/top.jsp" %>
    <!-- ztree -->
    <base href="<%=basePath%>">
    <meta charset="utf-8"/>
    <title></title>
    <meta name="description" content="overview & stats"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <link href="static/css/bootstrap.min.css" rel="stylesheet"/>
    <link href="static/css/bootstrap-responsive.min.css" rel="stylesheet"/>
    <link rel="stylesheet" href="static/css/font-awesome.min.css"/>
    <!-- 下拉框 -->
    <link rel="stylesheet" href="static/css/chosen.css"/>
    <link rel="stylesheet" href="static/css/ace.min.css"/>
    <link rel="stylesheet" href="static/css/ace-responsive.min.css"/>
    <link rel="stylesheet" href="static/css/ace-skins.min.css"/>
    <script type="text/javascript" src="static/js/jquery-1.7.2.js"></script>
    <link rel="stylesheet" href="static/css/datepicker.css"/><!-- 日期框 -->
    <!--引入弹窗组件start-->
    <script type="text/javascript" src="plugins/attention/zDialog/zDrag.js"></script>
    <script type="text/javascript" src="plugins/attention/zDialog/zDialog.js"></script>
    <!--引入弹窗组件end-->
    <!--提示框-->
    <script type="text/javascript" src="static/js/jquery.tips.js"></script>
    <script type="text/javascript" src="static/js/common/commonutils.js"></script>
</head>
<body>
<div id="page-content" class="clearfix">
    <form class="form-horizontal" id="form" action="prizeRule/saveShakePrize" method="post" enctype="multipart/form-data">      
        <input type="hidden" value="" name="shakes" id="shakes">     
        <div class="row-fluid">
            <!-- PAGE CONTENT BEGINS HERE -->
            <h1>规则设置 </h1>

        </div>

        <div class="row-fluid">

            <div class="span12">
                <table id="table_shake" class="table table-striped table-bordered table-hover">
                    <tr>
                        <th class="center">奖品名称</th>
                        <th class="center" colspan="2">类型概率</th>
                    </tr>	

                    <c:forEach items="${prizeData.shake}" var="s">
                        <input type="hidden" name="activityShakeId" value="${s.activityShakeId}">
                        <%--<c:forEach items="${prizeData.categories}" var="c">--%>

                        <tr>
                            <td class="center">
                                <label>
                                    <input type="text" name="name" value="${s.name}" placeholder="${s.name}"
                                           required/>
                                </label>
                            </td>
                            <td class="center"><input class="shake" type="number" min="1" max="100" name="probability" onkeyup="check(this)"
                                                      value="${s.probability}"
                                                      placeholder="${s.probability}" required/></td>
                            <c:if test="${roleId ne 1 }">
	                            <td>
	                                <button class="btn btn-mini btn-danger" type="button"
	                                        onclick="idelete(${s.activityShakeId})"><i class="icon-trash"></i></button>
	                            </td>
                            </c:if>
                        </tr>
                        <%--</c:forEach>--%>
                    </c:forEach>
                    <c:if test="${roleId ne 1 }">
	                    <tr>
	                        <td class="center" style="text-align: left;" colspan="3">
	                                                                             每日可参与<input type="text" id="count" name="count" value="${asDictParam.dictValue}" style="width:30px;" />次
	                        </td>
	                    </tr>
	                    <tr id="operaArea">
	                        <td style="text-align: center;" colspan="3">
	                            <a class="btn btn-mini btn-primary" id="save" onclick="save()" style="width: 90px; height: 34px; line-height:34px">保存</a>&nbsp;&nbsp;&nbsp;&nbsp;
	                            <a class="btn btn-mini btn-danger" onclick="add()" style="width: 90px; height: 34px;  line-height:34px">添加摇奖奖项</a>
	                        </td>
	                    </tr>
                    </c:if>
                </table>
            </div>


        </div>

    </form>
    <!-- basic scripts -->
    <!-- 引入 -->
    <script type="text/javascript">window.jQuery || document.write("<script src='static/js/jquery-1.9.1.min.js'>\x3C/script>");</script>
    <script src="static/js/bootstrap.min.js"></script>
    <script src="static/js/ace-elements.min.js"></script>
    <script src="static/js/ace.min.js"></script>
    <script type="text/javascript" src="static/js/bootstrap-datepicker.min.js"></script><!-- 日期框 -->
    <script type="text/javascript" src="static/js/chosen.jquery.min.js"></script><!-- 下拉框 -->
    <script type="text/javascript" src="static/js/bootbox.min.js"></script><!-- 确认窗口 -->

    <script type="text/javascript" src="static/js/base64.js"></script>
    <!-- 压缩图片 -->
    <script type="text/javascript" src="static/js/chosen.jquery.min.js"></script><!-- 下拉框 -->
    <script type="text/javascript">     
        // 设置值       
        function check(_this){
            var num = parseInt( _this.value);
            if ( !(0 <=num && num <= 100) ){
                _this.value = '';
            }
        }
        function save() {         	
            var shakeTab = $("#table_shake").find("input[type=number]");
            var shakeSum = 0;
            $.each(shakeTab, function (index, val) {
                shakeSum = shakeSum + Number($(val).val());
            });
            if (shakeSum != 100) {
                alert("转盘概率相加不等于100");    
               // history.go(0);
                return;
            }    
            //限制参与次数输入
            var value = document.getElementById('count').value;
            if(value.length == 0){
           	 alert('每日参与次数，不能为空'); 
           	 return;
            }
            var patrn = /^([1-9]||10)$/ig;
            /* if(!patrn.test(value)) {
               alert('每日参与次数，请输入1-10的整数');    
              // history.go(0);
               return;
            } */
           //组装数据          
            var shakess = [];
            var shakeData = $("#table_shake").find("input[type=hidden]");          
            $.each(shakeData, function (index, val) {
                shakess.push({
                    activityShakeId: $(val).val(),
                    probability: $($("#table_shake").find("input[type=number]")[index]).val(),
                    name: $($("#table_shake").find("td").find("input[type=text]")[index]).val(),
                    count: $($("#table_shake").find("td").find("input[name=count]")[index]).val()
                })
            });
                   
            $("#shakes").val(JSON.stringify(shakess));          
            $("#form").submit();
        }
       
        //删除
        function idelete(ids) {
            if (confirm("确定删除?,如若有奖品使用该概率，该奖品无法被抽中。")) {
                $.get("<%=basePath%>prizeRule/delete", {id: ids}, function (data) {
                    if (data.status == 200) {
                        alert(data.msg);
                        history.go(0);
                        return;
                    } else if (data.status == 300){
                        alert(data.msg);
                    }else{
                    	 alert(data.msg);
                    }
                }, 'json');
            }
        }
        //新增
        function add() {
            top.jzts();
            var diag = new top.Dialog();
            diag.Drag = true;
            diag.Title = "新增";
            diag.URL = '<%=basePath%>prizeRule/goAddShake.do?';
            diag.Width = 400;
            diag.Height = 220;
            diag.CancelEvent = function () { //关闭事件
                <%--if(diag.innerFrame.contentWindow.document.getElementById('zhongxin').style.display == 'none'){--%>
                <%--if('${page.currentPage}' == '0'){--%>
                <%--top.jzts();--%>
                <%--setTimeout("self.location=self.location",100);--%>
                <%--}else{--%>
                <%--if(typeof(nextPage) == "function") {--%>
                <%--nextPage(${page.currentPage});--%>
                <%--}--%>
                <%--}--%>
                <%--}--%>
                history.go(0);
                diag.close();
            };
            diag.show();
        }

    </script>
</body>
</html>