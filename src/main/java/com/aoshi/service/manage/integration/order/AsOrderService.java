package com.aoshi.service.manage.integration.order;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.aoshi.controller.base.BaseController;
import com.aoshi.dao.AsMessageRecordMapper;
import com.aoshi.dao.AsOrderActionMapper;
import com.aoshi.dao.AsOrderGoodsMapper;
import com.aoshi.dao.AsOrderMapper;
import com.aoshi.domain.AsOrder;
import com.aoshi.domain.AsOrderAction;
import com.aoshi.domain.AsOrderGoods;
import com.aoshi.resolver.ValidatorBreakException;
import com.aoshi.service.base.AsBaseService;
import com.aoshi.util.DateUtil;
import com.aoshi.util.PageData;
import com.aoshi.util.alipay.AlipayConfig;
import com.aoshi.util.alipay.AlipaySubmit;
import com.aoshi.util.alipay.UtilDate;

@Service
public class AsOrderService extends AsBaseService {

	@Autowired
	private AsOrderGoodsMapper asOrderGoodsMapperDao;

	@Autowired
	private AsOrderActionMapper actionMapper;

	@Autowired
	private AsOrderMapper asOrderMapper;
	
	@Autowired
	AsMessageRecordMapper asMessageRecordMapper;

	private static final String PAGE_PATH = "manage/order/";

	/*
	 * 修改
	 */
	public int edit(AsOrder record) {
		return asOrderMapper.updateByPrimaryKeySelective(record);
	}

	/*
	 * 通过id获取数据
	 */
	public AsOrder findById(AsOrder record) {
		return asOrderMapper.selectByPrimaryKeys(record.getOrderId());
	}

	/*
	 * 列表
	 */
	public List<AsOrder> list(PageData pd) {
		return asOrderMapper.selectByAttr(pd);
	}

	/**
	 * 获取订单列表
	 * 
	 * @author yangyanchao
	 * @date 2016年8月5日
	 * @param c
	 * @return
	 */
	public Object getOrderList(BaseController c) {

		initialized(c);

		List<Object> orderList = pageQueryModule(asOrderMapper,
				"selectByAttr", true);
		addViewData("orderList", orderList);

		return renderView(PAGE_PATH + "orderList");
	}

	/*
	 * 同意退款
	 */
	public int updateAgreeRefund(AsOrderGoods record, AsOrderAction action) {
		int flag = asOrderGoodsMapperDao.updateAgreeRefund(record);
		if (flag == 1) {
			action.setOrderId(record.getOrderId());
			actionMapper.insert(action);
		}
		return flag;
	}

	/*
	 * 拒绝退款
	 */
	public int updateRejectRefund(AsOrderGoods record, AsOrderAction action) {
		int flag = asOrderGoodsMapperDao.updateRejectRefund(record);
		if (flag == 1) {
			action.setOrderId(record.getOrderId());
			actionMapper.insert(action);
		}
		return flag;
	}

	/*
	 * 退款
	 */
	public int updateRefund(AsOrderGoods record, AsOrderAction action) {
		int flag = asOrderGoodsMapperDao.updateRefund(record);
		if (flag == 1) {
			action.setOrderId(record.getOrderId());
			actionMapper.insert(action);
		}
		return flag;
	}

	// public Map<String, Object> unionRefund(AsOrderGoods orderGoods) {
	// Map<String, Object> map = new HashMap<String, Object>();
	// boolean flag = false;
	// String tradeNo = orderGoods.getOrder().getTradeNo();
	// if (StringUtils.isBlank(tradeNo)) {
	// tradeNo = orderGoods.getOrderMerge().getTradeNo();
	// }
	// Map<String, String> payMap = new HashMap<String, String>();
	// String refundNo = "refund" + new Date().getTime();
	// String fenPrice = String.valueOf(orderGoods.getActualPrice()
	// .multiply(new BigDecimal(100)).intValue());
	// payMap.put("orderId", refundNo);
	// payMap.put("txnAmt", fenPrice);
	// payMap.put("origQryId", tradeNo);
	// payMap.put("reqReserved", String.valueOf(orderGoods.getOrderGoodsId()));
	// Map<String, String> result = UnionpayUtil.unionOrderRefund(payMap);
	// System.out.println("result: " + result);
	// String respCode = result.get("respCode");
	// if (("00").equals(respCode)) {
	// flag = true;
	// } else if (("03").equals(respCode) || ("04").equals(respCode)
	// || ("05").equals(respCode)) {
	// flag = true;
	// }
	// if (flag) {
	// map.put("msg", "ok");
	// } else {
	// map.put("msg", "no");
	// }
	// return map;
	// }
	//
	// public Map<String, Object> tenRefund(AsOrderGoods orderGoods, String
	// type) {
	// Map<String, Object> map = new HashMap<String, Object>();
	// String tradeNo = orderGoods.getOrder().getTradeNo();
	// if (StringUtils.isBlank(tradeNo)) {
	// tradeNo = orderGoods.getOrderMerge().getTradeNo();
	// }
	// Map<String, String> payMap = new HashMap<String, String>();
	// String refundNo = "refund" + new Date().getTime();
	// String fenPrice = String.valueOf(orderGoods.getActualPrice()
	// .multiply(new BigDecimal(100)).intValue());
	// payMap.put("transaction_id", tradeNo);
	// payMap.put("out_refund_no", refundNo);
	// payMap.put("total_fee", fenPrice);
	// payMap.put("refund_fee", fenPrice);
	// Map<String, String> result = null;
	// if (StringUtils.equals(type, "tenpay")) {
	// result = TenpayUtil.appRefund(payMap);
	// } else if (StringUtils.equals(type, "wechatpay")) {
	// result = TenpayUtil.wechatRefund(payMap);
	// }
	// System.out.println("result: " + result);
	// String returnCode = result.get("return_code");
	// String resultCode = result.get("result_code");
	// if (StringUtils.equals(returnCode, "SUCCESS")
	// && StringUtils.equals(resultCode, "SUCCESS")) {
	// PageData resultPd = new PageData();
	// resultPd.putAll(result);
	// resultPd.put("refund_type", type);
	// resultPd.put("order_goods_id", orderGoods.getOrderGoodsId());
	// resultPd.put("order_id", orderGoods.getOrder().getOrderId());
	// try {
	// boolean flag = notifyService.refundTenpayComplete(resultPd);
	// if (flag) {
	// System.out.println("退款成功!");
	// } else {
	// System.out.println("退款失败!");
	// }
	// } catch (Exception e) {
	// e.printStackTrace();
	// }
	// } else {
	// System.out.println("提交退款失败!");
	// System.out.println(result.get("return_msg"));
	// System.out.println(result.get("err_code"));
	// System.out.println(result.get("err_code_des"));
	// }
	// map.put("msg", "ok");
	// return map;
	// }

	/*
	 * 列表
	 */
	public List<AsOrderGoods> listGoods(PageData pd) {
		return asOrderGoodsMapperDao.selectByAttr(pd);
	}

	/*
	 * 列表
	 */
	public List<AsOrderAction> listAction(PageData pd) {
		return actionMapper.selectByAttr(pd);
	}

	/**
	 * 生成退款页面
	 * 
	 * @author yangyanchao
	 * @date 2016年7月28日
	 * @return
	 */
	public Object goPayPage(BaseController c) {

		initialized(c);
		// 把请求参数打包成数组
		Map<String, String> sParaTemp = new HashMap<String, String>();
		sParaTemp.put("service", "refund_fastpay_by_platform_pwd");
		sParaTemp.put("partner", AlipayConfig.partner);
		sParaTemp.put("_input_charset", AlipayConfig.input_charset);
		sParaTemp.put("notify_url", AlipayConfig.order_notify_url);
		sParaTemp.put("seller_email", AlipayConfig.seller_email);
		sParaTemp.put("refund_date", UtilDate.getDateFormatter());
		sParaTemp.put("batch_no", pd.getStringRequired("batch_no"));
		sParaTemp.put("batch_num", pd.getStringRequired("batch_num"));
		sParaTemp.put("detail_data", pd.getStringRequired("detail_data"));
		// 建立请求
		String sHtmlText = AlipaySubmit.buildRequest(sParaTemp, "get", "确认");
		addViewData("sHtmlText", sHtmlText);
		return renderView("manage/order/alipayRefundOrder");
	}

	/**
	 * 发货
	 * 
	 * @author huangxw
	 * @date 2016年12月7日
	 * @return 
	 */
	public Object goDelivery_Tx(BaseController c) {
		
		initialized(c);
		String shippingSn= pd.getString("shippingSn")==null||pd.getString("shippingSn").equals("")?null:pd.getString("shippingSn");
		 ValidatorBreakException.NOT_NULL(shippingSn, "运单号不能为空");
		 int shippingId = pd.getIntegerRequired("shippingId");
		    ValidatorBreakException.NOT_NULL(shippingId, "物流不能为空");
		int orderId = pd.getIntegerRequired("orderId");
		 ValidatorBreakException.NOT_NULL(orderId, "订单号不能为空");
	    int shopId = pd.getIntegerRequired("shopId");
	    ValidatorBreakException.NOT_NULL(shopId, "商家不能为空");
	    AsOrder order= new AsOrder();
	    order= asOrderMapper.selectByPrimaryKey(orderId);
	    order.setShippingId(shippingId);
	    order.setShippingSn(shippingSn);
		if (asOrderMapper.pointOrderDelivery(order) == 1) {
			AsOrderAction action = new AsOrderAction();
			action.setOrderId(order.getOrderId());
			
			action.setActionUser(Integer.parseInt(getUser().getUSER_ID()));
			action.setActionAdmin(getUser().getUSER_ID());
		    action.setOrderStatus(3);
		    action.setActionNote(3);
		    action.setActionTime(DateUtil.getTime());
		    operaFlag=actionMapper.insertSelective(action)>0;
			/*order = asOrderMapper.getShopOrderInfo(order);
			AsMessageRecord msgRecord = new AsMessageRecord();
			msgRecord.setCreateTime(DateUtil.getTime());
			msgRecord.setMessageType(OrderActionEnum.APPLY_DELIVERY_BUYER.getMsgType());
			msgRecord.setOrderId(order.getOrderId());
			msgRecord.setUserId(order.getUserId());
			AsMessageBean asMessageBean = new AsMessageBean();
			asMessageBean.setMsgContent(String.format(OrderActionEnum.APPLY_DELIVERY_BUYER.getMsgContent(), order.getOrderSn()));
			asMessageBean.setMsgTime(CommonUtils.getCurDate());
			asMessageBean.setMsgTitle(String.format(OrderActionEnum.APPLY_DELIVERY_BUYER.getMsgTitle(), order.getOrderSn()));
			asMessageBean.setMsgType(OrderActionEnum.APPLY_DELIVERY_BUYER.getMsgType());
			asMessageBean.setRefId(order.getOrderId());
			asMessageBean.setMsgImg(order.getOrderGoods().getGoodsImg());
			msgRecord.setMessage(JSON.toJSONString(asMessageBean));
			operaFlag = asMessageRecordMapper.insertSelective(msgRecord)>0;*/
			 ValidatorBreakException.NOT_TRUE(operaFlag, "发货失败！");
		}
		    return renderSuccess();
		}
}
