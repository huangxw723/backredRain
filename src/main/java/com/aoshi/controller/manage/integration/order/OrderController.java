package com.aoshi.controller.manage.integration.order;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.aoshi.controller.base.BaseController;
import com.aoshi.domain.AsOrder;
import com.aoshi.domain.AsOrderAction;
import com.aoshi.domain.AsOrderGoods;
import com.aoshi.service.manage.integration.order.AsAgreeRefundService;
import com.aoshi.service.manage.integration.order.AsGenRefundOrderService;
import com.aoshi.service.manage.integration.order.AsOrderGoodsService;
import com.aoshi.service.manage.integration.order.AsOrderService;
import com.aoshi.service.manage.integration.order.AsRejectRefundService;
import com.aoshi.service.manage.integration.order.IntegrationOrderService;
import com.aoshi.util.Const;
import com.aoshi.util.Jurisdiction;
import com.aoshi.util.PageData;

/**
 * 类名称：OrderController 创建人：star 创建时间：2016-07-08
 */
@Controller
@RequestMapping(value = "/order")
public class OrderController extends BaseController {

	String menuUrl = "order/list.do"; // 菜单地址(权限用)

	@Autowired
	private AsGenRefundOrderService asGenRefundOrderService;

	@Autowired
	private AsOrderService orderService;

	@Autowired
	private AsOrderGoodsService orderGoodsService;

	@Autowired
	private AsAgreeRefundService asAgreeRefundService;

	@Autowired
	private AsRejectRefundService asRejectRefundService;

	@Autowired
	private IntegrationOrderService integrationOrderService;

	/**
	 * 去管理总页面
	 */
	@RequestMapping(value = "/goTab")
	public ModelAndView goTab() {
		logBefore(logger, "去查看订单");
		ModelAndView mv = this.getModelAndView();
		PageData pd = this.getPageData();
		if (!Jurisdiction.buttonJurisdiction(menuUrl, "cha")) {
			return mv;
		} // 校验权限
		mv.addObject("pd", pd);
		mv.setViewName("manage/order/orderTab");
		return mv;
	}

	/**
	 * 去修改订单页面
	 */
	@RequestMapping(value = "/goEdit")
	public ModelAndView goEdit(AsOrder order) {
		logBefore(logger, "去修改asOrder页面");
		ModelAndView mv = this.getModelAndView();
		try {
			order = orderService.findById(order);
			mv.setViewName("manage/order/orderEdit");
			mv.addObject("order", order);
		} catch (Exception e) {
			logger.error(e.toString(), e);
		}
		return mv;
	}

	/**
	 * 修改订单
	 */
	@RequestMapping(value = "/edit")
	public ModelAndView edit(AsOrder order) {
		logBefore(logger, "修改asOrder");
		if (!Jurisdiction.buttonJurisdiction(menuUrl, "edit")) {
			return null;
		}
		ModelAndView mv = this.getModelAndView();
		try {
			orderService.edit(order);
		} catch (Exception e) {
			e.printStackTrace();
		}
		mv.addObject("id", "shopOrderEdit" + order.getOrderId());
		mv.addObject("msg", "success");
		mv.setViewName("save_result");
		return mv;
	}

	/**
	 * 去查看订单页面
	 */
	@RequestMapping(value = "/goView")
	public ModelAndView goView(AsOrder order) {
		logBefore(logger, "去查看asOrder页面");
		ModelAndView mv = this.getModelAndView();
		try {
			order = orderService.findById(order); // 根据ID读取
			mv.addObject("shippingList",integrationOrderService.getShippingList());
			mv.setViewName("manage/order/orderView");
			mv.addObject("msg", "view");
			mv.addObject("order", order);
		} catch (Exception e) {
			logger.error(e.toString(), e);
		}
		return mv;
	}

	/**
	 * 查询订单列表
	 * 
	 * @author yangyanchao
	 * @date 2016年8月5日
	 * @param page
	 * @return
	 */
	@RequestMapping(value = "/list")
	public Object getOrderList() {
		return orderService.getOrderList(this);
	}

	/**
	 * 查询积分商城订单列表
	 * 
	 * @author yangyanchao
	 * @date 2016年12月7日
	 * @return
	 */
	@RequestMapping("/getIntegrationOrderList")
	public Object getIntegrationOrderList() {
		return integrationOrderService.getIntegrationOrderList(this);
	}

	/**
	 * 订单商品列表页面
	 */
	@RequestMapping(value = "/listOrderGoods")
	public ModelAndView listOrderGoods() {
		logBefore(logger, "列表asOrderGoods");
		ModelAndView mv = this.getModelAndView();
		mv.setViewName("manage/order/orderGoodsList");
		PageData pd = this.getPageData();
		try {
			List<AsOrderGoods> orderGoodsList = orderService.listGoods(pd);
			mv.addObject("orderGoodsList", orderGoodsList);
			mv.addObject("pd", pd);
			mv.addObject(Const.SESSION_QX, this.getHC()); // 按钮权限
		} catch (Exception e) {
			logger.error(e.toString(), e);
		}
		return mv;
	}

	/**
	 * 订单操作列表页面
	 */
	@RequestMapping(value = "/listOrderAction")
	public ModelAndView listOrderAction() {
		logBefore(logger, "列表asOrderAction");
		ModelAndView mv = this.getModelAndView();
		mv.setViewName("manage/order/orderActionList");
		PageData pd = this.getPageData();
		try {
			List<AsOrderAction> orderActionList = orderService.listAction(pd);
			mv.addObject("orderActionList", orderActionList);
			mv.addObject("pd", pd);
			mv.addObject(Const.SESSION_QX, this.getHC()); // 按钮权限
		} catch (Exception e) {
			logger.error(e.toString(), e);
		}
		return mv;
	}

	/* ===============================订单操作================================== */

	/**
	 * 发货
	 * 
	 * @author huangxw
	 * @date 2016年12月7日
	 * @param shippingSn
	 * @return
	 */
	@RequestMapping(value = "/goDelivery")
	@ResponseBody
	public Object goDelivery(AsOrderGoods orderGoods) {
		return orderService.goDelivery_Tx(this);
	}

	
	/**
	 * 同意 退货/退款
	 * 
	 * @author yangyanchao
	 * @date 2016年8月18日
	 * @return
	 */
	/*@RequestMapping(value = "/agreeRefund")
	@ResponseBody
	public Object agreeRefund() {
		return asAgreeRefundService.agreeRefund_Tx(this);
	}*/

	/**
	 * 驳回 退货/退款
	 * 
	 * @author yangyanchao
	 * @date 2016年8月18日
	 * @param orderGoods
	 * @return
	 */
	/*@RequestMapping(value = "/rejectRefund")
	@ResponseBody
	public Object rejectRefund(AsOrderGoods orderGoods) {
		return asRejectRefundService.rejectRefund_Tx(this);
	}*/

	/**
	 * 生成退款单
	 * 
	 * @author yangyanchao
	 * @date 2016年7月27日
	 * @return
	 */
	/*@RequestMapping(value = "/refund")
	@ResponseBody
	public Object genRefundOrder() {
		return asGenRefundOrderService.genRefundOrder_Tx(this);
	}
*/
	/**
	 * 打开退款页面
	 * 
	 * @author yangyanchao
	 * @date 2016年7月28日
	 * @return
	 */
	/*@RequestMapping(value = "/alipayapi")
	public Object goPayPage() {
		return orderService.goPayPage(this);
	}*/
}
