<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <base href="<%=basePath%>">
    <!-- jsp文件头和头部 -->
    <%@ include file="../../system/admin/top.jsp" %>
</head>
<body>
<div class="container-fluid" id="main-container">
    <div id="page-content" class="clearfix">
        <div class="row-fluid">
            <div class="row-fluid">
                <!-- 检索  -->
                <form action="differIndustry/getDifferIndustryList.do" method="post" name="Form" id="Form">
                    <input type="hidden" name="shopId" value="${shopId}">
					<input type="hidden" id="currentPage" value="${pd.currentPage}"/>
					<input type="hidden" id="showCount" value="${pd.showCount}"/>
                    <table id="table_report" class="table table-striped table-bordered table-hover">
                        <thead>
                        <tr>
                            <th class="center">
                                <label>
                                    <input type="checkbox" id="zcheckbox"/>
                                    <span class="lbl"></span>
                                </label>
                            </th>
                            <th class="center">序号</th>
                            <th class="center">行业名称</th>

                        </tr>
                        </thead>

                        <tbody>

                        <!-- 开始循环 -->
                        <c:choose>
                            <c:when test="${not empty categoryList}">
                                    <c:forEach items="${categoryList}" var="var" varStatus="vs">
                                        <tr>
                                            <td class='center' style="width: 30px;">
                                                <label>
                                                    <input type='checkbox' name='ids' value="${var.id}" onclick="checkboxOnclick(this)"
	                                                    	<c:if test="${var.check eq false}">checked="checked"</c:if>
                                                    />
                                                    <span class="lbl"></span>
                                                </label>
                                            </td>
                                            <td class='center' style="width: 30px;">${vs.index+1}</td>
                                            <td class='center' style="text-align:center;">${var.name}</td>

                                        </tr>

                                    </c:forEach>
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
                        <table style="width: 100%;">
                            <tr>
                                <td style="vertical-align:top;">
                                    <a class="btn btn-small btn-success" onclick="commit('确定要保存选中的数据吗?')">保存</a>
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

<script type="text/javascript" src="static/js/chosen.jquery.min.js"></script>
<!-- 下拉框 -->
<script type="text/javascript" src="static/js/bootbox.min.js"></script>
<!-- 确认窗口 -->
<script type="text/javascript" src="static/js/jquery.tips.js"></script>
<!--提示框-->
<script type="text/javascript">

	$(top.hangge());
    $(function () {
         
        //单选框
        $(".chzn-select").chosen();
        $(".chzn-select-deselect").chosen({allow_single_deselect: true});

    });

    //检索
    function search() {
        top.jzts();
        $("#Form").submit();
    }


</script>

<script type="text/javascript">
    $(function () {
        //复选框
        $('table th input:checkbox').on('click', function () {
            var that = this;
            $(this).closest('table').find('tr > td:first-child input:checkbox')
                    .each(function () {
                        this.checked = that.checked;
                        $(this).closest('tr').toggleClass('selected');
                    });

        });

    });


    for (var i = 0; i < document.getElementsByName('ids').length; i++) {
        var checkAll =  document.getElementsByName('ids')[i].checked;
        if (checkAll == false){
            $("#zcheckbox").attr("checked",false);
            break;
        }else {
            $("#zcheckbox").attr("checked",true);
        }

    };

    //联动复选框的选择
    function  checkboxOnclick(checkbox) {
        if(checkbox.checked == false){
            $("#zcheckbox").attr("checked",false);
        };
        for (var i = 0; i < document.getElementsByName('ids').length; i++) {
            var checkAll =  document.getElementsByName('ids')[i].checked;
            if (checkAll == false){
                $("#zcheckbox").attr("checked",false);
                break;
            }else {
                $("#zcheckbox").attr("checked",true);
            }

        };
    }

    function commit(msg) {
        bootbox.confirm(msg, function (result) {
            if (result) {
                var str = '';
                for (var i = 0; i < document.getElementsByName('ids').length; i++) {
                    if (!document.getElementsByName('ids')[i].checked) {
                        if (str == '') str += document.getElementsByName('ids')[i].value;
                        else str += ',' + document.getElementsByName('ids')[i].value;
                    }
                };
                var strChecked = '';
                for (var i = 0; i < document.getElementsByName('ids').length; i++) {

                        if (strChecked == '') strChecked += document.getElementsByName('ids')[i].value;
                        else strChecked += ',' + document.getElementsByName('ids')[i].value;

                }
                        $.ajax({
                            type: "POST",
                            url: '<%=basePath%>differIndustry/saveDifferIndustryIds.do',
                            data: {ids: str, idsChecked: strChecked,shopId: ${shopId}},
                            dataType: 'json',
                            //beforeSend: validateData,
                            cache: false,
                            success: function (data) {
                                if (data.msg == 'ok') {
                                    alert("保存成功！");
                                    history.go(0);
                                }
                            },
                            error:function () {
                                if (data.msg == 'no') {
                                    alert("系统繁忙！");
                                    history.go(0);
                                }
                            }
                        });
            }
        });

    }
</script>

</body>
</html>

