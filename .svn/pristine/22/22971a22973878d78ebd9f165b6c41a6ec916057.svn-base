<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<!DOCTYPE html>
<html lang="en">
<head>
<base href="<%=basePath%>">
<!-- jsp文件头和头部 -->
<%@ include file="../../system/admin/top.jsp"%>
</head>
<body>
  <div class="container-fluid" id="main-container">
    <div id="page-content" class="clearfix">
      <div class="row-fluid">
        <div class="row-fluid">
          <!-- 检索  -->
          <form action="shopOrder/listOrderAction.do" method="post" name="Form" id="Form">
            <input type="hidden" name="orderId" value="${pd.orderId}">
            <table id="table_report" class="table table-striped table-bordered table-hover">
              <thead>
                <tr>
                  <th class="center">序号</th>
                  <th class="center">下单用户</th>
                  <th class="center">订单操作人</th>
                  <th class="center">操作记录</th>
                  <th class="center">操作后状态</th>
                  <th class="center">操作原因</th>
                  <th class="center">操作说明</th>
                  <th class="center">操作时间</th>
                </tr>
              </thead>
              <tbody>
                <!-- 开始循环 -->
                <c:choose>
                  <c:when test="${not empty orderActionList}">
                    <c:if test="${QX.cha == 1 }">
                      <c:forEach items="${orderActionList}" var="var" varStatus="vs">
                        <tr>
                          <td class='center' style="width: 30px;">${vs.index+1}</td>
                          <td style="text-align:center;" title="${var.user.nickName}">${var.user.nickName}</td>
                          <c:if test="${var.actionAdmin == '超时取消' }">
                            <td style="text-align:center;" title="超时取消">超时取消</td>
                          </c:if>
                          <c:if test="${var.actionAdmin != '超时取消' }">
                            <td style="text-align:center;" title="${var.sysUser.USERNAME}">${var.sysUser.USERNAME}</td>
                          </c:if>
                          <td style="text-align:center;" title="${var.actionNote}">
                            <c:if test="${var.actionNote == '1' }"><span class="label label-info arrowed">提交订单</span></c:if>
                            <c:if test="${var.actionNote == '2' }"><span class="label label-info arrowed">付款</span></c:if>
                            <c:if test="${var.actionNote == '3' }"><span class="label label-info arrowed">发货</span></c:if>
                            <c:if test="${var.actionNote == '4' }"><span class="label label-info arrowed">收货</span></c:if>
                            <%-- <c:if test="${var.actionNote == '5' }"><span class="label label-info arrowed">申请退款/退货</span></c:if>
                            <c:if test="${var.actionNote == '6' }"><span class="label label-info arrowed">同意退款/退货</span></c:if>
                            <c:if test="${var.actionNote == '7' }"><span class="label label-info arrowed">拒绝退款/退货</span></c:if>
                            <c:if test="${var.actionNote == '8' }"><span class="label label-info arrowed">退款</span></c:if> --%>
                            <c:if test="${var.actionNote == '9' }"><span class="label label-info arrowed">取消订单</span></c:if>
                            <c:if test="${var.actionNote == '10' }"><span class="label label-info arrowed">删除订单</span></c:if>
                          </td>
                          <td style="text-align:center;" title="${var.orderStatus}">
                            <c:if test="${var.orderStatus == '1' }"><span class="label label-purple arrowed">待付款</span></c:if>
                            <c:if test="${var.orderStatus == '2' }"><span class="label label-purple arrowed">待发货</span></c:if>
                            <c:if test="${var.orderStatus == '3' }"><span class="label label-purple arrowed">待收货</span></c:if>
                            <c:if test="${var.orderStatus == '4' }"><span class="label label-purple arrowed">交易成功</span></c:if>
                            <%-- <c:if test="${var.orderStatus == '5' }"><span class="label label-purple arrowed">申请退款/退货</span></c:if>
                            <c:if test="${var.orderStatus == '6' }"><span class="label label-purple arrowed">退款中/退货中</span></c:if>
                            <c:if test="${var.orderStatus == '7' }"><span class="label label-purple arrowed">退款成功</span></c:if> --%>
                            <c:if test="${var.orderStatus == '8' }"><span class="label label-purple arrowed">交易关闭</span></c:if>
                          </td>
                          <td style="text-align:center;" title="${var.actionReason}">${var.actionReason}</td>
                          <td style="text-align:center;" title="${var.actionRemark}">${var.actionRemark}</td>
                          <td style="text-align:center;" title="${var.actionTime}">${var.actionTime}</td>
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
  <script type="text/javascript">
		$(top.hangge());
  </script>

</body>
</html>

