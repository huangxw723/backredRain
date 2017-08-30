<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.aoshi.util.PropertyUtils"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
	String httpUrl = PropertyUtils.getHTTP_URL();
%>
<!DOCTYPE html>
<html lang="en">
<head>
<base href="<%=basePath%>">
<%@ include file="../../system/admin/top.jsp"%>
<style>
  .table th, .table td { 
    text-align: center;
    vertical-align:middle;
  }
</style>

</head>
<body>
    <input type="hidden" name="orderId" id="orderId" value="${order.orderId }" />
    <div id="zhongxin">
      <table id="table_report" class="table table-striped table-bordered" style="text-align: center;">
        <tr>
          <th>店铺名</th>
          <td>
            ${order.shop.shopName }
          </td>
          <th>店铺:</th>
          <td colspan="3" style="text-align: left; background: url(<%=httpUrl%>${order.shop.shopLogo});background-size:cover;">
            <c:choose>
              <c:when test="${not empty order.shop.shopLogo}">
                <a rel="group" class="imgBox" href="<%=httpUrl%>${order.shop.shopLogo}">
                  <img src="<%=httpUrl%>${order.shop.shopLogo}" width="100" height="100" />
                </a>
              </c:when>
              <c:otherwise>
                <span>暂无图片</span>
              </c:otherwise>
            </c:choose>
          </td>
        </tr>
        <tr>
          <th>订单号:</th>
          <td>
            ${order.orderSn }
          </td>
          <th>订单状态:</th>
          <td>
            <c:if test="${order.orderStatus == '1' }"><span class="label label-warning arrowed">待付款</span></c:if>
            <c:if test="${order.orderStatus == '2' }"><span class="label label-important arrowed">待发货</span></c:if>
            <c:if test="${order.orderStatus == '3' }"><span class="label label-warning arrowed">待收货</span></c:if>
            <c:if test="${order.orderStatus == '4' }"><span class="label label-success arrowed">交易成功</span></c:if>
            <c:if test="${order.orderStatus == '5' }"><span class="label label-important arrowed">申请退款/退货</span></c:if>
            <c:if test="${order.orderStatus == '6' }"><span class="label label-warning arrowed">退款中/退货中</span></c:if>
            <c:if test="${order.orderStatus == '7' }"><span class="label label-important arrowed">退款成功</span></c:if>
            <c:if test="${order.orderStatus == '8' }"><span class="label label-important arrowed">交易关闭</span></c:if>
          </td>
          <th>下单时间:</th>
          <td>
            ${order.createTime }
          </td>
        </tr>
        <tr>
          <th>下单人:</th>
          <td>
            ${order.user.nickName }
          </td>
          <th>订单来源:</th>
          <td>
            ${order.orderSource }
          </td>
          <th>支付类型:</th>
          <td>
            <c:if test="${order.payType=='alipay'}">支付宝支付</c:if>
            <c:if test="${order.payType=='unionpay'}">银联支付</c:if>
            <c:if test="${order.payType=='tenpay'}">微信APP支付</c:if>
            <c:if test="${order.payType=='wechatpay'}">微信公众号支付</c:if>
          </td>
        </tr>
        <tr>
          <th>收货人:</th>
          <td>
            ${order.receiver }
          </td>
          <th>收货电话:</th>
          <td>
            ${order.receiverPhone }
          </td>
          <th>邮编:</th>
          <td>
            ${order.postcode }
          </td>
        </tr>
        <tr>
          <th>收货地址:</th>
          <td colspan="5">
            <textarea readonly="true" name="address" id="address" title="收货人" class="autosize-transition span12" style="width:96%;overflow: hidden; word-wrap: break-word; resize: none; height: 50px;">${order.address }</textarea>
          </td>
        </tr>
        <tr>
          <th>用户留言:</th>
          <td colspan="5">
            <textarea readonly="true" name="remark" id="remark" title="用户留言" class="autosize-transition span12" style="width:96%;overflow: hidden; word-wrap: break-word; resize: none; height: 50px;">${order.remark }</textarea>
          </td>
        </tr>
        <tr>
          <th>配送方式:</th>
          <td>
            <c:forEach items="${shippingList}" var="shipping">
              <c:if test="${shipping.shippingId == order.shippingId }">${shipping.shippingName }</c:if>
            </c:forEach>
          </td>
          <th>物流单号:</th>
          <td>
            ${order.shippingSn }
          </td>
          <th>配送费用:</th>
          <td>
            ${order.shippingPrice }
          </td>
        </tr>
        <tr>
          <th>商品总额:</th>
          <td colspan="2">
            ${order.goodsPrice }
          </td>
          <th>减免金额:</th>
          <td colspan="2">
            ${order.orderGoods.deratePrice }
          </td>
        </tr>
        <tr>
          <th>使用积分:</th>
          <td colspan="2">
            ${order.pointPay }
          </td>
          <th>积分抵现:</th>
          <td colspan="2">
            ${order.pointPrice }
          </td>
        </tr>
       <%--  <tr>
          <th>优惠劵:</th>
          <td colspan="2">
            ${order.userCoupon.coupon.couponName }
          </td>
          <th>优惠金额:</th>
          <td colspan="2">
            ${order.couponPrice }
          </td>
        </tr> --%>
        <tr>
          <th>平台优惠:</th>
          <td colspan="2">
            ${order.platformPrice }
          </td>
          <th>订单总价:</th>
          <td colspan="2">
            ${order.orderPrice }
          </td>
        </tr>
        <tr>
          <th>实际付款:</th>
          <td colspan="2">
            ${order.actualPrice }
          </td>
          <th>收入总价:</th>
          <td colspan="2">
            ${order.incomePrice }
          </td>
        </tr>
      </table>
    </div>

  <!-- 引入 -->
  <script type="text/javascript">window.jQuery || document.write("<script src='static/js/jquery-1.9.1.min.js'>\x3C/script>");</script>
  <script src="static/js/bootstrap.min.js"></script>
  <script src="static/js/ace-elements.min.js"></script>
  <script src="static/js/ace.min.js"></script>
  <script type="text/javascript" src="static/js/jquery.autosize-min.js"></script>
  <link rel="stylesheet" type="text/css" href="plugins/fancyBox/jquery.fancybox.css">
  <script type="text/javascript" src="plugins/fancyBox/jquery.fancybox.pack.js"></script>
  <!-- 查看图片 -->

  <script type="text/javascript">
    $(top.hangge());
    
    $(function(){
    	$('textarea[class*=autosize]').autosize({append: "\n"});
    	$(".imgBox").fancybox({
            helpers: {
                title : {
                    type : 'inside'
                }
            }
        });
    });
  </script>
</body>
</html>