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
		<meta charset="utf-8" />
		<title></title>
		<meta name="description" content="overview & stats" />
		<meta name="viewport" content="width=device-width, initial-scale=1.0" />
		<link href="static/css/bootstrap.min.css" rel="stylesheet" />
		<link href="static/css/bootstrap-responsive.min.css" rel="stylesheet" />
		<link rel="stylesheet" href="static/css/font-awesome.min.css" />
		<!-- 下拉框 -->
		<link rel="stylesheet" href="static/css/chosen.css" />
		<link rel="stylesheet" href="static/css/ace.min.css" />
		<link rel="stylesheet" href="static/css/ace-responsive.min.css" />
		<link rel="stylesheet" href="static/css/ace-skins.min.css" />
		<script type="text/javascript" src="static/js/jquery-1.7.2.js"></script>
		<link rel="stylesheet" href="static/css/datepicker.css" /><!-- 日期框 -->
		<!--引入弹窗组件start-->
		<script type="text/javascript" src="plugins/attention/zDialog/zDrag.js"></script>
		<script type="text/javascript" src="plugins/attention/zDialog/zDialog.js"></script>
		<!--引入弹窗组件end-->
		<!--提示框-->
		<script type="text/javascript" src="static/js/jquery.tips.js"></script>
		<script type="text/javascript" src="static/js/common/commonutils.js"></script>
</head>
<body>
  <div class="container-fluid" id="main-container">
    <div id="page-content" class="clearfix">
      <div class="row-fluid">
        <div class="row-fluid">
          <!-- 检索  -->
          <form action="order/getIntegrationOrderList.do" method="post" name="Form" id="Form">
			 <input name="shopId" id="shopId" type="hidden"  value="">
			 <input name="orderId" id="orderId" type="hidden" type="text"  value="">
			 <input type="hidden" id="currentPage" value="${pd.currentPage}"/>
			<input type="hidden" id="showCount" value="${pd.showCount}"/>
            <table>
              <tr>
              	<td>
									<span class="input-icon"> <input style="vertical-align:top;width: 200px;"
											autocomplete="off" id="nav-search-input" type="text"
											name="orderSn" value="${pd.orderSn}" placeholder="请输入订单号" />
											<i  class="icon-search"></i>
									</span>
				</td>
				
                <td><div class="row-fluid input-append date">
									<input name="timeStart" type="text" data-date-format="yyyy-mm-dd" id="id-date-picker-1" class="span10 date-picker" value="${pd.timeStart}">
									<span class="add-on"><i class="icon-calendar"></i></span>
								</div></td>
								<td><div class="row-fluid input-append date">
									<input name="timeEnd" type="text" data-date-format="yyyy-mm-dd" id="id-date-picker-1" class="span10 date-picker" value="${pd.timeEnd}">
									<span class="add-on"><i class="icon-calendar"></i></span>
								</div></td>
								
								
								
                <td style="vertical-align:top;"> 
                  <select class="chzn-select" name="orderStatus" id="orderStatus" data-placeholder="请选择状态" style="vertical-align:top;width: 150px;">
                    <option value="">全部</option>
                    <option value="2" <c:if test="${pd.orderStatus==2}">selected</c:if>>待发货</option>
                    <option value="3" <c:if test="${pd.orderStatus==3}">selected</c:if>>待收货</option>
                    <option value="4" <c:if test="${pd.orderStatus==4}">selected</c:if>>交易成功</option>
                  </select>
                </td>
                <td style="vertical-align:top;">
                  <button class="btn btn-mini btn-light" onclick="search();" title="检索">
                    <i id="nav-search-icon" class="icon-search"></i>
                  </button>
                </td>
              </tr>
            </table>
            <!-- 检索  -->
            <table id="table_report" class="table table-striped table-bordered table-hover">
              <thead>
                <tr>
                  <th class="center">序号</th>
                  <th class="center">店铺</th>
                  <th class="center">订单号</th>
                  <th class="center">状态</th>
                  <th class="center">收货人</th>
                  <th class="center">积分</th>
                  <th class="center">下单时间</th>
                  <th class="center">操作</th>
                </tr>
              </thead>

              <tbody>

                <!-- 开始循环 -->
                <c:choose>
                  <c:when test="${not empty list}">
                      <c:forEach items="${list}" var="var" varStatus="vs">
                        <tr>
                          <td class='center' style="width: 30px;">${vs.index+1}</td>
                          <td style="text-align:center;max-width: 200px;overflow: hidden;white-space: nowrap;text-overflow: ellipsis;" title="${var.shop.shopName}">${var.shop.shopName}</td>
                          <td style="text-align:center;max-width: 200px;overflow: hidden;white-space: nowrap;text-overflow: ellipsis;" title="${var.orderSn}">${var.orderSn}</td>
                          <td style="text-align:center;" title="${var.orderStatus}">
                            <c:if test="${var.orderStatus == '1' }"><span class="label label-warning arrowed">待付款</span></c:if>
                            <c:if test="${var.orderStatus == '2' }"><span class="label label-important arrowed">待发货</span></c:if>
                            <c:if test="${var.orderStatus == '3' }"><span class="label label-warning arrowed">待收货</span></c:if>
                            <c:if test="${var.orderStatus == '4' }"><span class="label label-success arrowed">交易成功</span></c:if>
<%--                             <c:if test="${var.orderStatus == '5' }"><span class="label label-important arrowed">申请退款/退货</span></c:if> --%>
<%--                             <c:if test="${var.orderStatus == '6' }"><span class="label label-important arrowed">退款中/退货中</span></c:if> --%>
<%--                             <c:if test="${var.orderStatus == '7' }"><span class="label label-info arrowed">退款成功</span></c:if> --%>
                            <c:if test="${var.orderStatus == '8' }"><span class="label label-inverse arrowed">交易关闭</span></c:if>
                            <c:if test="${var.orderStatus != '1'&& var.orderStatus != '2'&& var.orderStatus != '3'&& var.orderStatus != '4'&& var.orderStatus != '7'&& var.orderStatus != '8'}"><span class="label label-inverse arrowed"></span></c:if>
                          </td>
                          <td style="text-align:center;max-width: 60px;overflow: hidden;white-space: nowrap;text-overflow: ellipsis;" title="${var.receiver}">${var.receiver}</td>
                          <td style="text-align:center;" title="${var.orderPrice}">${var.actualPrice}</td>
                          
                          <td style="text-align:center;width:130px;" title="${var.createTime}">${var.createTime}</td>
                         
                          <td style="width: 200px;" class="center">
                            
                            <%--<a class='btn btn-mini btn-success' title="查看订单" onclick="viewOrder('${var.orderId}','${var.orderSn}');">
                              <i class='icon-eye-open'></i>
                            </a>--%>
                                <a  href="javascript:void(0);"  onclick="viewOrder('${var.orderId}','${var.orderSn}');">
                                    查看订单
                                </a>

                            <c:if test="${QX.edit == 1}"> 
                              <c:if test="${var.orderStatus == '2'}">
                                <%--<a class='btn btn-mini btn-danger' title="发货" onclick="showDelivery('${var.orderId}','${var.shopId}');">
                                  <i class='icon-circle-blank'>&nbsp;发货</i>
                                </a>--%>
                                  <a  href="javascript:void(0);"  onclick="showDelivery('${var.orderId}','${var.shopId}');">
                                   发货
                                </a>
                              </c:if>
                            </c:if> 
                          </td>
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
<!-- 选择物流（Modal） -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="position:fixed;top:36%; overflow-x:hidden"> 
	<div class="modal-dialog">
		<div class="modal-content" style="width:800px; height:360px;">
			
<!-- 			<div class="modal-body" style="overflow-y:hidden" style="width:800px; height:500px;"> -->

     <div id="selectShipping" style="padding-top: 20px;padding-bottom: 40px;display:block; background-color:#fff;">
            选择物流:&nbsp;<select size="420px" class="chzn-select" name="shippingId" id="shippingId" data-placeholder="请选择物流" style="vertical-align:top;width:290px;">
            <option></option>
            <c:forEach items="${shippingList}" var="shipping">
            <option value="${shipping.shippingId }">${shipping.shippingName }</option>
            </c:forEach>
      </select><br/>
      <br/>
            物流运单号:<input type="text" style="width:48%;margin-top: 20px;" name="shippingSn" value="" id="shippingSn" placeholder="请填写物流单号" title="物流单号" />
      
      </div>

<!-- 			</div> -->
			
			
		</div><!-- /.modal-content -->
		<div class="modal-footer" >
				
				<button type="button" onclick="goDelivery();" class="btn btn-danger">
				确认发货
				</button>
				<button type="button"  onclick="closeDelivery();" class="btn btn-primary">
				取消
				</button>
			</div>
	</div><!-- /.modal -->
</div>
  <!-- 返回顶部  -->
  <a href="#" id="btn-scroll-up" class="btn btn-small btn-inverse">
    <i class="icon-double-angle-up icon-only"></i>
  </a>

  <!-- 引入 -->
  <script type="text/javascript">window.jQuery || document.write("<script src='static/js/jquery-1.9.1.min.js'>\x3C/script>");</script>
  <script src="static/js/bootstrap.min.js"></script>
  <script src="static/js/ace-elements.min.js"></script>
  <script src="static/js/ace.min.js"></script>

  <script type="text/javascript" src="static/js/bootstrap-datepicker.min.js"></script>
  <!-- 日期框 -->
  <script type="text/javascript" src="static/js/chosen.jquery.min.js"></script>
  <!-- 下拉框 -->
  <script type="text/javascript" src="static/js/jquery.tips.js"></script>
  <!--提示框-->
  <script type="text/javascript">
		
		$(top.hangge());
		
		$(function(){
			
			//日期框
			$('.date-picker').datepicker();
			//单选框
			$(".chzn-select").chosen(); 
			$(".chzn-select-deselect").chosen({allow_single_deselect:true}); 
			
		});
	
		function showDelivery(id,shopId){
			var orderId =$("#orderId").val(id);
			var shopId = $("#shopId").val(shopId);
			 $("#myModal").modal('show'); 
		}
		//关闭发货窗口
		function closeDelivery(){
			 $("#myModal").modal('hide'); 
		}
		//发货
		function goDelivery(){
			var orderId =$("#orderId").val();
			var shopId = $("#shopId").val();
			var shippingId = $("#shippingId").val();
			var shippingSn = $("#shippingSn").val();
			
			if(validateUtils.isEmpty(shippingId)){
				alert('请选择物流')
				return
			}
			if(validateUtils.isEmpty(shippingSn)){
				alert('请填物流运单号')
				return
			}
			$.ajax({
				type: "POST",
				url: '<%=basePath%>order/goDelivery.do',
		    	data: {orderId:orderId,shopId:shopId,shippingId:shippingId,shippingSn:shippingSn},
				dataType:'json',
				cache: false,
				success: function(data){
					if(data){
						alert(data.msg)
						history.go(0);
					}
				}
			});
		}
		
		//检索
		function search(){
			top.jzts();
			var form = $("#Form");
			form.find('#currentPage').attr('name','currentPage');
			form.find('#showCount').attr('name','showCount');
			$("#Form").submit();
		}
		
		//删除
		function del(Id){
			bootbox.confirm("确定要删除吗?", function(result) {
				if(result) {
					top.jzts();
					var url = "<%=basePath%>order/delete.do?orderId="+Id;
					$.get(url,function(data){
						if(typeof(nextPage) == "function") {
							nextPage(${page.currentPage});
						}
					});
				}
			});
		}
		
		//修改
		function edit(Id,sn){
  			top.mainFrame.tab.add( {
  				id :'orderEdit' + Id,
  				title :"编辑订单_"+sn,
  				url :'<%=basePath%>order/goEdit.do?orderId='+Id,
  				isClosed :true,
  				closeFn : function(iframe){
  					if(iframe.contents().find("#zhongxin").css('display') == 'none'){
  						if(typeof(nextPage) == "function") {
							nextPage(${page.currentPage});
						}
  					}
  				}
  			});
		}
		
		//查看退款商品
		function goRefund(Id,sn){
  			top.mainFrame.tab.add( {
  				id :'orderTab' + Id,
  				title :"订单详情_"+sn,
  				url :'<%=basePath%>order/goTab.do?orderId='+Id + "&tab=goods",
  				isClosed :true
  			});
		}
		
		//查看订单详情
		function viewOrder(Id,sn){
  			top.mainFrame.tab.add( {
  				id :'orderTab' + Id,
  				title :"订单详情_"+sn,
  				url :'<%=basePath%>order/goTab.do?orderId='+Id,
  				isClosed :true
  			});
		}
  </script>
</body>
</html>

