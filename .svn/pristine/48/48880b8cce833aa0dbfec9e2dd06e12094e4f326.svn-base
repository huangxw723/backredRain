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
          <form action="shopOrder/listOrderGoods.do" method="post" name="Form" id="Form">
            <input type="hidden" name="orderId" value="${pd.orderId}">
            <table id="table_report" class="table table-striped table-bordered table-hover">
              <thead>
                <tr>
                  <th class="center">序号</th>
                  <th class="center">商品名</th>
                  <th class="center">商品属性</th>
                  <th class="center">商品数量</th>
                  <th class="center">销售价</th>
                  <th class="center">属性价</th>
                  <th class="center">支付价</th>
                  <th class="center">总价</th>
                  <th class="center">减免金额</th>
                  <th class="center">状态</th>
<!--                   <th class="center">操作</th> -->
                </tr>
              </thead>
              <tbody>
                <!-- 开始循环 -->
                <c:choose>
                  <c:when test="${not empty orderGoodsList}">
                    <c:if test="${QX.cha == 1 }">
                      <c:forEach items="${orderGoodsList}" var="var" varStatus="vs">
                        <tr>
                          <td class='center' style="width: 30px;">${vs.index+1}</td>
                          <td style="text-align:center;max-width: 100px;overflow: hidden;white-space: nowrap;text-overflow: ellipsis;" title="${var.goodsName}">${var.goodsName}</td>
                          <td style="text-align:center;max-width: 100px;overflow: hidden;white-space: nowrap;text-overflow: ellipsis;" title="${var.productId}">${var.attrName}</td>
                          <td class="center" title="${var.goodsAmount}">${var.goodsAmount}</td>
                          <td class="center" title="${var.salesPrice}">${var.salesPrice}</td>
                          <td class="center" title="${var.extraPrice}">${var.extraPrice}</td>
                          <td class="center" title="${var.actualPrice}">${var.actualPrice}</td>
                          <td class="center" title="${var.totalPrice}">${var.totalPrice}</td>
                          <td class="center" title="${var.deratePrice}">${var.deratePrice}</td>
                          <td class="center">
                            <c:if test="${var.status == '1' }"><span class="label label-success arrowed">正常</span></c:if>
                            <c:if test="${var.status != '1' }"><span class="label label-success arrowed"></span></c:if>
                            <%-- <c:if test="${var.status == '2' }"><span class="label label-important arrowed">申请退款/退货</span></c:if>
                            <c:if test="${var.status == '3' }"><span class="label label-warning arrowed">退款中/退货中</span></c:if>
                            <c:if test="${var.status == '4' }"><span class="label label-info arrowed">退款成功</span></c:if> --%>
                          </td>
                           <%--<td style="width: 260px;" class="center">
                            <c:if test="${QX.edit == 1}">
                              <c:if test="${var.status == '2'}">
                                <a class='btn btn-mini btn-danger' title="同意退款/退货" onclick="agreeRefund('${var.orderGoodsId}');">
                                  <i class='icon-circle-blank'>&nbsp;同意</i>
                                </a>
                                <a class='btn btn-mini btn-danger' title="拒绝退款/退货" onclick="rejectRefund('${var.orderGoodsId}');">
                                  <i class='icon-circle-blank'>&nbsp;拒绝</i>
                                </a>
                              </c:if>
                              <c:if test="${var.status == '3'}">
                                <a class='btn btn-mini btn-danger' title="退款/退货" onclick="refund('${var.orderGoodsId}');">
                                  <i class='icon-circle-blank'>&nbsp;退款/退货</i>
                                </a>
                              </c:if>
                            </c:if> 
                            <a class='btn btn-mini btn-success' title="查看商品" onclick="viewGoods('${var.goodsId}','${var.goodsName}');">
                              <i class='icon-eye-open'></i>
                            </a>
                          </td>--%>
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
  
  <div id="formWrapper">
  </div>

  <!-- 引入 -->
  <script type="text/javascript">window.jQuery || document.write("<script src='static/js/jquery-1.9.1.min.js'>\x3C/script>");</script>
  <script src="static/js/bootstrap.min.js"></script>
  <script src="static/js/ace-elements.min.js"></script>
  <script src="static/js/ace.min.js"></script>
  <script type="text/javascript" src="static/js/bootbox.min.js"></script>
  <!-- 确认窗口 -->
  <script type="text/javascript">
		$(top.hangge());
		
		//查看商品详情
	    function viewGoods(Id, name) {
	        top.mainFrame.tab.add({
	            id: 'goodsInfo' + Id,
	            title: "商品信息_" + name,
	            url: '<%=basePath%>goods/goodsTab.do?goodsId=' + Id,
	            isClosed: true
	        });
	    }
		
	  //同意退款
		function agreeRefund(id){
			var content = "同意退款吗?"
			bootbox.confirm(content, function(result) {
				if(result) {
					if(content == "同意退款吗?"){
						top.jzts();
						$.ajax({
							type: "POST",
							url: '<%=basePath%>order/agreeRefund.do',
					    	data: {orderGoodsId:id},
							dataType:'json',
							cache: false,
							success: function(data){
								
								console.log(data)
								top.hangge();
								if(data.status == 0) {
									bootbox.alert('操作成功');
								 } else {
									 bootbox.alert(data.msg);
									 
								 }
								
								setTimeout(function(){
									 window.location.reload;
								 }, 1000);
							}
						});
					}
				}
			});
		}
		
		//拒绝退款
		function rejectRefund(id){
			var content = "拒绝退款吗?"
			bootbox.confirm(content, function(result) {
				if(result) {
					if(content == "拒绝退款吗?"){
						top.jzts();
						$.ajax({
							type: "POST",
							url: '<%=basePath%>order/rejectRefund.do',
					    	data: {orderGoodsId:id},
							dataType:'json',
							cache: false,
							success: function(data){
								 if(data.status == 0) {
									 top.hangge();
									 setTimeout(function(){
										 window.location.reload;
									}, 1000);
								 } else {
									 bootbox.alert(data.msg);
									 top.hangge();
								 }
							}
						});
					}
				}
			});
		}
		
		//退款
		function refund(id){
			var content = "确认退款吗?"
			bootbox.confirm(content, function(result) {
				if(result) {
					if(content == "确认退款吗?"){
						top.jzts();						$.ajax({
							type: "POST",
							url: '<%=basePath%>order/refund.do',
					    	data: {orderGoodsId:id},
							dataType:'json',
							cache: false,
							success: function(data){
								 if(data.status == 0) {
									if(data.msg.payType == 'alipay') {
										var form = $("<form>").attr('action','order/alipayapi.do').attr('method','post').attr('target','_blank').attr('style','display:none;');
    									var input1 = $("<input type='hidden' name='batch_num' />").attr('value',data.msg.batch_num);
    									var input2 = $("<input type='hidden' name='detail_data' />").attr('value',data.msg.detail_data);
    									var input3 = $("<input type='hidden' name='batch_no' />").attr('value',data.msg.batch_no);
    									form.append(input1).append(input2).append(input3);
    									console.log(data)
    									
    									form.appendTo($('#formWrapper'));
    									form.submit();
    									//setTimeout("self.location=self.location",100);
    									
									}
								 } else {
									 bootbox.alert("操作失败!");
								 }
								 top.hangge();
							}
						});
					}
				}
			});
		}
  </script>
</body>
</html>

