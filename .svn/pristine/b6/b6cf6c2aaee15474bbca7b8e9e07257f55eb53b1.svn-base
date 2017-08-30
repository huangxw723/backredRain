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
<%@ include file="../../system/admin/top.jsp"%>

<script type="text/javascript">
	//保存
	function save(){
		if($("#shippingPrice").val()==""){
			$("#shippingPrice").tips({
				side:3,
	            msg:'输入配送费用',
	            bg:'#AE81FF',
	            time:2
	        });
			$("#shippingPrice").focus();
			return false;
		}
		$("#form").submit();
		$("#zhongxin").hide();
		$("#zhongxin2").show();
	}
	
</script>
</head>
<body>
  <form action="shopOrder/edit.do" name="form" id="form" method="post">
    <input type="hidden" name="orderId" id="orderId" value="${order.orderId }" />
    <div id="zhongxin">
      <table id="table_report" class="table">
        <tr>
          <td>订单号:</td>
          <td>
            <input type="text" readonly="true" style="width:90%;" value="${order.orderSn }" title="订单号" />
          </td>
          <td>订单状态:</td>
          <td>
            <c:if test="${order.orderStatus == '1' }"><input type="text" readonly="true" style="width:90%;" value="待付款" title="订单状态" /></c:if>
            <c:if test="${order.orderStatus == '2' }"><input type="text" readonly="true" style="width:90%;" value="待发货" title="订单状态" /></c:if>
            <c:if test="${order.orderStatus == '3' }"><input type="text" readonly="true" style="width:90%;" value="待收货" title="订单状态" /></c:if>
            <c:if test="${order.orderStatus == '4' }"><input type="text" readonly="true" style="width:90%;" value="交易成功" title="订单状态" /></c:if>
            <c:if test="${order.orderStatus == '5' }"><input type="text" readonly="true" style="width:90%;" value="申请退款/退货" title="订单状态" /></c:if>
            <c:if test="${order.orderStatus == '6' }"><input type="text" readonly="true" style="width:90%;" value="退款中/退货中" title="订单状态" /></c:if>
            <c:if test="${order.orderStatus == '7' }"><input type="text" readonly="true" style="width:90%;" value="退款成功" title="订单状态" /></c:if>
            <c:if test="${order.orderStatus == '8' }"><input type="text" readonly="true" style="width:90%;" value="交易关闭" title="订单状态" /></c:if>
          </td>
          <td>下单时间:</td>
          <td>
            <input type="text" readonly="true" style="width:90%;" value="${order.createTime }" title="下单时间" />
          </td>
        </tr>
        <tr>
          <td>下单人:</td>
          <td>
            <input type="text" readonly="true" style="width:90%;" value="${order.user.nickName }" title="下单人" />
          </td>
          <td>订单来源:</td>
          <td>
            <input readonly="true" type="text" style="width:90%;" value="${order.orderSource }" title="订单来源" />
          </td>
          <td>支付类型:</td>
          <td>
            <input readonly="true" type="text" style="width:90%;" value="${order.orderType }" title="支付类型" />
          </td>
        </tr>
        <tr>
          <td>收货人:</td>
          <td>
            <input type="text" style="width:90%;" name="receiver" id="receiver" value="${order.receiver }" title="收货人" />
          </td>
          <td>收货电话:</td>
          <td>
            <input type="text" class="input-medium input-mask-phone" style="width:90%;" name="receiverPhone" id="receiverPhone" value="${order.receiverPhone }" title="收货电话" />
          </td>
          <td>邮编:</td>
          <td>
            <input type="text" class="input-medium input-mask-code" style="width:90%;" name="postcode" id="postcode" value="${order.postcode }" title="邮编" />
          </td>
        </tr>
        <tr>
          <td>收货地址:</td>
          <td colspan="5">
            <textarea name="address" id="address" title="收货人" class="autosize-transition span12" style="width:96%;overflow: hidden; word-wrap: break-word; resize: none; height: 50px;">${order.address }</textarea>
          </td>
        </tr>
        <tr>
          <td>用户留言:</td>
          <td colspan="5">
            <textarea readonly="true" title="用户留言" class="autosize-transition span12" style="width:96%;overflow: hidden; word-wrap: break-word; resize: none; height: 50px;">${order.remark }</textarea>
          </td>
        </tr>
        <tr>
          <td>配送方式:</td>
          <td>
            <select <c:if test="${order.orderStatus == '1'}">disabled="true"</c:if> class="chzn-select" name="shippingId" id="shippingId" style="vertical-align:top;">
              <option value=""></option>
              <c:forEach items="${shippingList}" var="shipping">
                <option value="${shipping.shippingId }" <c:if test="${shipping.shippingId == order.shippingId }">selected</c:if>>${shipping.shippingName }</option>
              </c:forEach>
            </select>
          </td>
          <td>物流单号:</td>
          <td>
            <input <c:if test="${order.orderStatus == '1'}">readonly="true" disabled="true"</c:if> type="text" style="width:90%;" name="shippingSn" id="shippingSn" value="${order.shippingSn }" title="物流单号" />
          </td>
          <td>配送费用:</td>
          <td>
            <input <c:if test="${order.orderStatus == '2'}">readonly="true" disabled="true"</c:if> type="number" style="width:90%;" name="shippingPrice" id="shippingPrice" value="${order.shippingPrice }" title="配送费用" />
          </td>
        </tr>
        <tr>
          <td>商品总额:</td>
          <td colspan="2">
            <input readonly="true" type="text" style="width:90%;" value="${order.goodsPrice }" title="商品总额" />
          </td>
          <td>减免金额:</td>
          <td colspan="2">
            <input <c:if test="${order.orderStatus == '2'}">readonly="true" disabled="true"</c:if> type="number" style="width:90%;" name="subtractPrice" value="${order.subtractPrice }" title="减免金额" />
          </td>
        </tr>
        <tr>
          <td>使用积分:</td>
          <td colspan="2">
            <input readonly="true" type="text" style="width:90%;" value="${order.pointPay }" title="使用积分" />
          </td>
          <td>积分抵现:</td>
          <td colspan="2">
            <input readonly="true" type="text" style="width:90%;" value="${order.pointPrice }" title="积分费用" />
          </td>
        </tr>
        <tr>
          <tr>
          <td>优惠劵:</td>
          <td colspan="2">
            <input readonly="true" type="text" style="width:90%;" value="${order.userCoupon.coupon.couponName }" title="优惠劵" />
          </td>
          <td>优惠金额:</td>
          <td colspan="2">
            <input readonly="true" type="text" style="width:90%;" value="${order.couponPrice }" title="优惠金额" />
          </td>
        </tr>
        </tr>
        <tr>
          <td>平台优惠:</td>
          <td colspan="2">
            <input readonly="true" type="text" style="width:90%;" value="${order.platformPrice }" title="平台优惠" />
          </td>
          <td>订单总价:</td>
          <td colspan="2">
            <input readonly="true" type="text" style="width:90%;" value="${order.orderPrice }" title="订单总价" />
          </td>
        </tr>
        <tr>
          <td>实际付款:</td>
          <td colspan="2">
            <input readonly="true" type="text" style="width:90%;" value="${order.actualPrice }" title="实际付款" />
          </td>
          <td>收入总价:</td>
          <td colspan="2">
            <input readonly="true" type="text" style="width:90%;" value="${order.incomePrice }" title="收入总价" />
          </td>
        </tr>
        <tr>
          <td class="center" colspan="6">
            <a class="btn btn-mini btn-primary" onclick="save();">保存</a>
            <a class="btn btn-mini btn-danger" onclick="top.mainFrame.tab.close('shopOrderEdit${order.orderId }');">取消</a>
          </td>
        </tr>
      </table>
    </div>

    <div id="zhongxin2" class="center" style="display:none">
      <br />
      <br />
      <br />
      <br />
      <br />
      <img src="static/images/jiazai.gif" />
      <br />
      <h4 class="lighter block green">提交中...</h4>
    </div>

  </form>
  <!-- 引入 -->
  <script type="text/javascript">window.jQuery || document.write("<script src='static/js/jquery-1.9.1.min.js'>\x3C/script>");</script>
  <script src="static/js/bootstrap.min.js"></script>
  <script src="static/js/ace-elements.min.js"></script>
  <script src="static/js/ace.min.js"></script>
  <script type="text/javascript" src="static/js/jquery.autosize-min.js"></script>
  <script type="text/javascript" src="static/js/jquery.maskedinput.min.js"></script>
  <script type="text/javascript" src="static/js/chosen.jquery.min.js"></script>
  <!-- 单选框 -->

  <script type="text/javascript">
    $(top.hangge());
    $(function(){
    	$(".chzn-select").chosen(); 
		$(".chzn-select-deselect").chosen({allow_single_deselect:true}); 
    	$('textarea[class*=autosize]').autosize({append: "\n"});
    	$('.input-mask-phone').mask('999-9999-9999');
    	$('.input-mask-code').mask('999999');
    	$('input[type*=number]').change(function(){
    		var total = 0;
    		$('input[type*=number]').each(function(i, num){
    			total += Number($(num).val());
    		});
    		$("#orderPrice").val(total);
    	});
    });
  </script>
</body>
</html>