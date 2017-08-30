package com.aoshi.controller.notify;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.aoshi.controller.base.BaseController;
import com.aoshi.service.pay.notify.AsAlipayNotifyService;

/**
 * 支付回调统一入口
 * 
 * @author yangyanchao
 * @date 2016年7月27日
 */
@Controller
@RequestMapping("notify")
public class NotifyController extends BaseController {

	@Autowired
	private AsAlipayNotifyService asAlipayNotifyService;

	/**
	 * 支付宝回调
	 * 
	 * @author yangyanchao
	 * @date 2016年7月27日
	 * @return
	 */
	@RequestMapping(value = "alipayRefundNotify")
	@ResponseBody
	public Object alipayRefundNotify() {
		return asAlipayNotifyService.refundAlipayComplete(this);
	}

	// /**
	// * 订单银联退款回调接口
	// *
	// * @return
	// */
	// @SuppressWarnings("unchecked")
	// @RequestMapping(value = "unionpayOrderNotifyUrl", method =
	// RequestMethod.POST)
	// @ResponseBody
	// public Object unionpayOrderNotifyUrl() {
	// logBefore(logger, "订单银联退款回调接口");
	// PageData pd = this.getPageData();
	// if (!SDKUtil.validate(pd, pd.getString(SDKConstants.param_encoding))) {
	// logger.info("验证签名结果[失败].");
	// return "error";
	// } else {
	// logger.info("订单银联回调参数: " + pd);
	// pd.put("refund_type", "unionpay");
	// boolean flag = false;
	// try {
	// flag = notifyService.refundUnionpayComplete(pd);
	// } catch (Exception e) {
	// e.printStackTrace();
	// }
	// if (flag) {
	// logger.info("退款成功!");
	// } else {
	// logger.info("退款失败!");
	// }
	// return "200";
	// }
	// }

}
