package com.aoshi.service.manage.integration.order;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.aoshi.controller.base.BaseController;
import com.aoshi.dao.AsOrderActionMapper;
import com.aoshi.dao.AsOrderGoodsMapper;
import com.aoshi.dao.AsOrderMapper;
import com.aoshi.domain.AsOrder;
import com.aoshi.domain.AsOrderAction;
import com.aoshi.domain.AsOrderGoods;
import com.aoshi.resolver.ValidatorBreakException;
import com.aoshi.service.base.AsBaseService;
import com.aoshi.util.DateUtil;

/**
 * 拒绝退款模块Service
 * 
 * @author yangyanchao
 * @date 2016年8月3日
 */
@Service
public class AsRejectRefundService extends AsBaseService {

	@Autowired
	private AsOrderGoodsMapper asOrderGoodsMapperDao;

	@Autowired
	private AsOrderMapper asOrderMapperDao;

	@Autowired
	private AsOrderActionMapper asOrderActionMapperDao;

	private AsOrder asOrder;

	private AsOrderGoods orderGoods;

	/**
	 * 驳回 退货/退款
	 * 
	 * @author yangyanchao
	 * @date 2016年8月1日
	 * @param c
	 * @return
	 */
	public Object rejectRefund_Tx(BaseController c) {

		initialized(c);

		// 恢复订单商品退款状态
		resumeRefundStatus();

		// 添加订单操作动态
		addOrderAction();

		return renderSuccess();
	}

	/**
	 * 添加订单操作动态
	 * 
	 * @author yangyanchao
	 * @date 2016年8月18日
	 */
	private void addOrderAction() {

		asOrder = asOrderMapperDao.selectByPrimaryKey(orderGoods.getOrderId());
		ValidatorBreakException.NOT_NULL(asOrder);
		AsOrderAction action = new AsOrderAction();
		action.setActionAdmin(getUser().getUSER_ID());
		action.setActionNote(7);
		action.setOrderId(orderGoods.getOrderId());
		action.setOrderGoodsId(orderGoods.getOrderGoodsId());
		action.setStatus(1);
		action.setActionReason("拒绝退款/退货");
		action.setActionRemark("拒绝退款/退货");
		action.setActionTime(DateUtil.getTime());
		action.setActionUser(asOrder.getUserId());
		operaFlag = asOrderActionMapperDao.insertSelective(action) == 1;
		ValidatorBreakException.NOT_TRUE(operaFlag);
	}

	/**
	 * 恢复订单商品退款状态
	 * 
	 * @author yangyanchao
	 * @date 2016年8月18日
	 */
	private void resumeRefundStatus() {
		orderGoods = asOrderGoodsMapperDao.selectByPrimaryKey(pd
				.getInt("orderGoodsId"));
		ValidatorBreakException.NOT_NULL(orderGoods);
		ValidatorBreakException.NOT_TRUE(orderGoods.getStatus() == 2);
		orderGoods.setStatus(1);
		operaFlag = asOrderGoodsMapperDao.updateByPrimaryKey(orderGoods) == 1;
		ValidatorBreakException.NOT_TRUE(operaFlag);
	}

}
