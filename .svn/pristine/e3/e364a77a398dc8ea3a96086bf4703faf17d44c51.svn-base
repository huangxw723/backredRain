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
    <form class="form-horizontal" id="form" action="prize/save" method="post" enctype="multipart/form-data">
        <input type="hidden" name="discs" value="" id="discs">
        <input type="hidden" value="" name="shakes" id="shakes">
        <input type="hidden" value="${storeId}" name="storeId" id="shakes">
        <div class="row-fluid">
            <h1 class="page-header position-relative">大转盘概率设置 </h1>
        </div>

        <div class="row-fluid">
            <div class="span12">
                <table id="table_disc" class="table table-striped table-bordered table-hover">

                    <thead>
                    <tr>
                        <th class="center">奖品名称</th>
                        <th class="center">类型概率</th>
                        <th class="center">转盘商品图标</th>
                    </tr>
                    </thead>
                    <c:forEach items="${prizeData.disc}" var="d">
                        <input type="hidden" name="activityDiscId" value="${d.activityDiscId}">

                        <tr>


                                <td class="center">
                                    <label>
                                        <select name="categoryId">
                                            <c:forEach items="${prizeData.categories}" var="c">
                                                <option ${c.id==d.categoryId?'selected':''}
                                                        value="${c.id}">${c.name}</option>
                                            </c:forEach>
                                        </select>
                                    </label>
                                </td>
                                <td class="center"><input type="number" name="probability" min="1" max="100" value="${d.probability}" maxlength="3" onkeyup="check(this)"
                                                          placeholder="${d.probability}"
                                                          required/>
                                </td>

                                <td>

                                    <c:if test="${d == null || d.icon== '' || d.icon == null }">
                                        <%--<a class="imgBox" href="javascript:void(0)" style="display:none;">--%>
                                            <%--<img src="" width="150" class="imgHref"/>--%>
                                        <%--</a>--%>
                                        <input type="file" class="fileInput" name="fileInput"/>
                                        <span style="color: red; width: 50px;" id="msgDiv">注： 图片格式支持 : gif/png/jpg/jpeg    尺寸规格712 * 140</span>
                                    </c:if>
                                    <c:if test="${d != null && d.icon != '' && d.icon != null }">
                                        <a class="fancybox" href="<%=httpUrl%>${d.icon}">
                                            <img src="<%=httpUrl%>${d.icon}" width="20px" height="20px" >
                                        </a>
                                        <%--<input type="button" value="更改" onclick="changeImg()" id="chImg" />--%>
                                        <input type="file" name="fileInput" />
                                    </c:if>
                                    <%--<input class="url" name="img" type="hidden"/>--%>
                                </td>
                        </tr>
                    </c:forEach>
                </table>
            </div>

        </div>

        <div class="row-fluid">
            <!-- PAGE CONTENT BEGINS HERE -->
            <h1>摇奖分类概率设置 </h1>

        </div>

        <div class="row-fluid">

            <div class="span12">
                <table id="table_shake" class="table table-striped table-bordered table-hover">
                    <tr>
                        <th class="center">奖品名称</th>
                        <th class="center">类型概率</th>
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
                            <td>
                                <button class="btn btn-mini btn-danger" type="button"
                                        onclick="idelete(${s.activityShakeId})"><i class="icon-trash"></i></button>
                            </td>
                        </tr>
                        <%--</c:forEach>--%>
                    </c:forEach>
                    <tr>
                        <td class="" colspan="2">
                            <label><input type="checkbox" ${store.isCooperation == '1'? "checked" : ""}
                                          name="isCooperation"
                            ><span

                                    class="lbl">是否能摇到战略合作伙伴的商品</span></label>
                        </td>
                    </tr>
                    <tr id="operaArea">
                        <td style="text-align: center;" colspan="2">
                            <a class="btn btn-mini btn-primary" id="save" onclick="save()">保存</a>&nbsp;&nbsp;&nbsp;&nbsp;
                            <a class="btn btn-mini btn-danger" onclick="add()">添加摇奖奖项</a>
                        </td>
                    </tr>
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

    <link rel="stylesheet" type="text/css" href="plugins/fancyBox/jquery.fancybox.css">
    <script type="text/javascript" src="plugins/fancyBox/jquery.fancybox.pack.js"></script>
    <!-- 查看图片 -->
    <script type="text/javascript" src="static/js/chosen.jquery.min.js"></script><!-- 下拉框 -->
    <script type="text/javascript">
        //        //更改图片
        //        function changeImg(){
        //            $("#fileInput").trigger("click");
        //        }

        $(document).ready(function () {
            $(".fancybox").fancybox({
                helpers: {
                    title: {
                        type: 'inside'
                    }
                }
            });


        });
        // 设置值
        function check(_this){
            var num = parseInt( _this.value);
            if ( !(0 <=num && num <= 100) ){
                _this.value = '';
            }
        }
        function save() {
            var discTab = $("#table_disc").find("input[type=number]");
            var sum = 0;
            $.each(discTab, function (index, val) {
                sum = sum + Number($(val).val());
            });
            if (sum != 100) {
                alert("转盘概率相加不等于100");
                return;
            }
            console.log(sum);

            var shakeTab = $("#table_shake").find("input[type=number]");
            var shakeSum = 0;
            $.each(shakeTab, function (index, val) {
                shakeSum = shakeSum + Number($(val).val());
            });
            if (shakeSum > 100) {
                alert("摇奖概率相加不能大于100");
                return;
            }
            if (shakeSum < 100 && shakeSum != 0) {
                alert("摇奖概率，剩下的" + Number(100 - shakeSum) + "% 将设置为真遗憾,你没有中奖.");
            }
            console.log(shakeSum);


//                组装数据
            var discss = [];
            var shakess = [];
            var discData = $("#table_disc").find("input[type=hidden]");
            var shakeData = $("#table_shake").find("input[type=hidden]");
            $.each(discData, function (index, val) {
                discss.push({
                    activityDiscId: $(val).val(),
                    probability: $($("#table_disc").find("input[type=number]")[index]).val(),
                    categoryId: $($("#table_disc").find("td").find("select")[index]).val()
                })
            });
            console.log("discss ---->" + discss);
            $.each(shakeData, function (index, val) {
                shakess.push({
                    activityShakeId: $(val).val(),
                    probability: $($("#table_shake").find("input[type=number]")[index]).val(),
                    name: $($("#table_shake").find("td").find("input[type=text]")[index]).val()
                })
            });
            console.log("shakess ---->" + shakess);
            $("#discs").val(JSON.stringify(discss));
            $("#shakes").val(JSON.stringify(shakess));
            <%--$.ajax({--%>
            <%--type: "POST",--%>
            <%--url: '<%=basePath%>prize/save',--%>
            <%--data: {"discs": JSON.stringify(discss), "shakes": JSON.stringify(shakess), "storeId": "${storeId}", ""},--%>
            <%--dataType: 'json',--%>
            <%--//beforeSend: validateData,--%>
            <%--cache: false,--%>
            <%--success: function (data) {--%>
            <%--if (data.msg == 'ok') {--%>
            <%--alert("保存成功");--%>
            <%--}--%>
            <%--},--%>
            <%--error: function () {--%>
            <%--alert("网络连接异常,请检查网络");--%>
            <%--}--%>
            <%--});--%>
            $("#form").submit();
        }
        //上传

        //删除
        function idelete(ids) {
            if (confirm("确定删除?,如若有奖品使用该概率，该奖品无法被抽中。")) {
                $.get("<%=basePath%>prize/delete", {id: ids}, function (data) {
                    if (data.status == 200) {
                        alert(data.msg);
//                    setTimeout("self.location=self.location",100);
                        history.go(0);
                        return;
                    } else {
                        alert("操作失败,请稍后再试");
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
            diag.URL = '<%=basePath%>prize/goAddShake.do?storeId=${storeId}';
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