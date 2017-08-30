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
 <form class="form-horizontal" id="form" action="prizeRule/saveBigWheelPrize" method="post" enctype="multipart/form-data"> 
        <input type="hidden" name="discs" value="" id="discs">      
        <div class="row-fluid">
            <h1 class="page-header position-relative">大转盘图片设置 </h1>
        </div>

        <div class="row-fluid">
            <div class="span12">                                    
                <table id="table_disc" class="table table-striped table-bordered table-hover">
                   <c:forEach items="${prizeData.disc}" var="d">   
                     <input type="hidden" name="activityDiscId" value="${d.activityDiscId}">                                     
                        <tr>
                           <c:if test="${d.categoryType==3}">
                               <td class="center">
                                    <label>折扣券：</label>
                                </td>
                               <%--  <td class="left" >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="number" name="probability" min="1" max="100" value="${d.probability}" maxlength="3" onkeyup="check(this)"  placeholder="${d.probability}" required/>&nbsp;% 
                                <input type="hidden" value="${d.minPoint}" name="minPoint" /><input type="hidden" value="${d.maxPoint}" name="maxPoint" />                                                         
                                </td>  --%>
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
                                            <img src="<%=httpUrl%>${d.icon}" width="20px" height="20px" title="预览" >
                                        </a>
                                        <%--<input type="button" value="更改" onclick="changeImg()" id="chImg" />--%>
                                        <input type="file" name="fileInput" />
                                         <span style="color: red; width: 50px;" id="msgDiv">注： 图片格式支持 : gif/png/jpg/jpeg    尺寸规格712 * 140</span>
                                    </c:if>
                                    <%--<input class="url" name="img" type="hidden"/>--%>
                                </td>
                                </c:if>                           
                        </tr>
                        <tr>
                         <c:if test="${d.categoryType==4}">
                               <td class="center">
                                    <label>礼品券：</label>
                                </td>
                             <%--    <td class="left" >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="number" name="probability" min="1" max="100" value="${d.probability}" maxlength="3" onkeyup="check(this)"  placeholder="${d.probability}" required/>&nbsp;% 
                                <input type="hidden" value="${d.minPoint}" name="minPoint" /><input type="hidden" value="${d.maxPoint}" name="maxPoint" />                                                           
                                </td>  --%>
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
                                            <img src="<%=httpUrl%>${d.icon}" width="20px" height="20px" title="预览" >
                                        </a>
                                        <%--<input type="button" value="更改" onclick="changeImg()" id="chImg" />--%>
                                        <input type="file" name="fileInput" />
                                         <span style="color: red; width: 50px;" id="msgDiv">注： 图片格式支持 : gif/png/jpg/jpeg    尺寸规格712 * 140</span>
                                    </c:if>
                                    <%--<input class="url" name="img" type="hidden"/>--%>
                                </td>
                                </c:if>                           
                        </tr>
                        <tr>
                         <c:if test="${d.categoryType==5}">
                               <td class="center">
                                    <label>代金券：</label>
                                </td>
                               <%--  <td class="left" >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="number" name="probability" min="1" max="100" value="${d.probability}" maxlength="3" onkeyup="check(this)"  placeholder="${d.probability}" required/>&nbsp;% 
                                <input type="hidden" value="${d.minPoint}" name="minPoint" /><input type="hidden" value="${d.maxPoint}" name="maxPoint" />                                                           
                                </td>   --%>
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
                                            <img src="<%=httpUrl%>${d.icon}" width="20px" height="20px" title="预览" >
                                        </a>
                                        <%--<input type="button" value="更改" onclick="changeImg()" id="chImg" />--%>
                                        <input type="file" name="fileInput" />
                                         <span style="color: red; width: 50px;" id="msgDiv">注： 图片格式支持 : gif/png/jpg/jpeg    尺寸规格712 * 140</span>
                                    </c:if>
                                    <%--<input class="url" name="img" type="hidden"/>--%>
                                </td>
                                </c:if>                          
                        </tr>
                        <tr>
                         <c:if test="${d.categoryType==1}">
                               <td class="center">
                                    <label>大奖：</label>
                                </td>
                              <%--   <td class="left" >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="number" name="probability" min="1" max="100" value="${d.probability}" maxlength="3" onkeyup="check(this)"  placeholder="${d.probability}" required/>&nbsp;% 
                                <input type="hidden" value="${d.minPoint}" name="minPoint" /><input type="hidden" value="${d.maxPoint}" name="maxPoint" />                                                           
                                </td>  --%>
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
                                            <img src="<%=httpUrl%>${d.icon}" width="20px" height="20px" title="预览" >
                                        </a>
                                        <%--<input type="button" value="更改" onclick="changeImg()" id="chImg" />--%>
                                        <input type="file" name="fileInput" />
                                         <span style="color: red; width: 50px;" id="msgDiv">注： 图片格式支持 : gif/png/jpg/jpeg    尺寸规格712 * 140</span>
                                    </c:if>
                                    <%--<input class="url" name="img" type="hidden"/>--%>
                                </td>    
                                </c:if>                       
                        </tr>
                        <tr>
                         <c:if test="${d.categoryType==2}">
                               <td class="center">
                                    <label>积分：</label>
                                </td>
                                <%-- <td class="left" >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="number" name="probability" min="1" max="100" value="${d.probability}" maxlength="3" onkeyup="check(this)"  placeholder="${d.probability}" required/>&nbsp;%
                                &nbsp;(<input type="text" value="${d.minPoint}" name="minPoint" style="width:30px;"/>-<input type="text" value="${d.maxPoint}" name="maxPoint" style="width:30px;"/>)&nbsp;分                                                         
                                </td>  --%>
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
                                            <img src="<%=httpUrl%>${d.icon}" width="20px" height="20px" title="预览" >
                                        </a>
                                        <%--<input type="button" value="更改" onclick="changeImg()" id="chImg" />--%>
                                        <input type="file" name="fileInput" />
                                         <span style="color: red; width: 50px;" id="msgDiv">注： 图片格式支持 : gif/png/jpg/jpeg    尺寸规格712 * 140</span>
                                    </c:if>
                                    <%--<input class="url" name="img" type="hidden"/>--%>
                                </td>
                                </c:if>                           
                        </tr>
                       
                   </c:forEach>
                      
                    <tr id="operaArea">
                        <td style="text-align: center;" colspan="3">                                                                       
                            <a class="btn btn-mini btn-primary" id="save" onclick="save()" style="width: 90px; height: 34px; line-height:34px" >保存</a>  
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
       
        $(document).ready(function () {
            $(".fancybox").fancybox({
                helpers: {
                    title: {
                        type: 'inside'
                    }
                }
            });


        });
      /*   // 判断概率设置值
        function check(_this){
            var num = parseInt( _this.value);
            if ( !(0 <=num && num <= 100) ){
                _this.value = '';
            }
        } */
        function save() {        	
           /* var discTab = $("#table_disc").find("input[type=number]");
            var sum = 0;
            $.each(discTab, function (index, val) {
                sum = sum + Number($(val).val());
            });
            if (sum != 100) {
                alert("转盘概率相加不等于100");
                //history.go(0);
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
               //history.go(0);
               return;
            }   */     
            //拼装数据
            var discss = [];    
            var discData = $("#table_disc").find("input[name=activityDiscId]");
            $.each(discData, function (index, val) {
                discss.push({
                    activityDiscId: $(val).val(),
                    //probability: $($("#table_disc").find("input[type=number]")[index]).val(),                 
                    //count: $($("#table_disc").find("td").find("input[name=count]")[index]).val(),
                    //minPoint: $($("#table_disc").find("td").find("input[name=minPoint]")[index]).val(),
                    // maxPoint: $($("#table_disc").find("td").find("input[name=maxPoint]")[index]).val()
                })
            });
            $("#discs").val(JSON.stringify(discss));                    
            $("#form").submit();
        }
        
            
    </script>
</body>
</html>