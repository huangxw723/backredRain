package com.aoshi.service.manage.integration.order;

import java.util.HashMap;
import java.util.Map;

import net.sf.json.JSONObject;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.aoshi.common.asenum.OrderPayType;
import com.aoshi.controller.base.BaseController;
import com.aoshi.dao.AsOrderGoodsMapper;
import com.aoshi.dao.AsOrderMapper;
import com.aoshi.domain.AsOrder;
import com.aoshi.domain.AsOrderGoods;
import com.aoshi.entity.R;
import com.aoshi.resolver.ValidatorBreakException;
import com.aoshi.service.base.AsBaseService;
import com.aoshi.util.CommonUtils;
import com.aoshi.util.Conditions;
import com.aoshi.util.alipay.UtilDate;

/**
 * 生成退款单Service
 * 
 * @author yangyanchao
 * @date 2016年7月27日
 */
@Service
public class AsGenRefundOrderService extends AsBaseService {

	@Autowired
	private AsOrderGoodsMapper asOrderGoodsMapperDao;

	@Autowired
	private AsOrderMapper asOrderMapperDao;

	private AsOrderGoods orderGoods;

	private AsOrder asOrder;

	private Map<String, Object> map = new HashMap<String, Object>();

	/**
	 * 生成多类型退款单分配器
	 * 
	 * @author yangyanchao
	 * @date 2016年7月27日
	 * @param c
	 * @return
	 */
	public Object genRefundOrder_Tx(BaseController c) {

		initialized(c);

		orderGoods = (AsOrderGoods) asOrderGoodsMapperDao
				.selectByPrimaryKeyWithLock(pd.getIntRequired("orderGoodsId"));
		ValidatorBreakException.NOT_NULL(orderGoods);
		ValidatorBreakException.NOT_TRUE(orderGoods.getStatus() != 4, "该商品已退款");

		asOrder = asOrderMapperDao.selectByPrimaryKey(orderGoods.getOrderId());
		ValidatorBreakException.NOT_NULL(asOrder);
		OrderPayType orderPayType = OrderPayType.get(asOrder.getPayType());
		switch (orderPayType) {

		case ALIPAY:

			genAlipayRefundOrder_Tx();
			break;
		/*
		 * case UNIONPAY:
		 * 
		 * map = orderService.unionRefund(orderGoods); break; case TENPAY:
		 * 
		 * map = orderService.tenRefund(orderGoods, orderPayType.getId());
		 * break; case WECHATPAY:
		 * 
		 * map = orderService.tenRefund(orderGoods, orderPayType.getId());
		 * break;
		 */
		default:

			ValidatorBreakException.NOT_TRUE(false);
		}

		return renderSuccess(new R(0, JSONObject.fromObject(map)));
	}

	/**
	 * 生成退款单信息
	 * 
	 * @author yangyanchao
	 * @date 2016年7月27日
	 * @return
	 */
	private void genAlipayRefundOrder_Tx() {

		// 获取合并订单,实际退款单号
		/*
		 * AsOrderMerge asOrderMerge = asOrderMergeMapperDao
		 * .selectByPrimaryKey(asOrder.getOrderMergeId());
		 * ValidatorBreakException.NOT_NULL(asOrderMerge);
		 */
		String tradeNo = asOrder.getTradeNo();
		ValidatorBreakException.NOT_TRUE(!StringUtils.isBlank(tradeNo));

		// 生成退款批次号
		String refundNo = orderGoods.getRefundNo();
		if (StringUtils.isBlank(refundNo)) {
			refundNo = UtilDate.getOrderNum();

			Conditions condition = CommonUtils.getConditions();
			condition.putData("orderGoodsId", orderGoods.getOrderGoodsId())
					.putData("refundNo", refundNo);
			operaFlag = asOrderGoodsMapperDao
					.updateByPrimaryKeySelective(condition) == 1;
			ValidatorBreakException.NOT_TRUE(operaFlag);
		}

		String detailData = tradeNo + "^"
 + "0.01" + "^退款";
		map.put("detail_data", detailData);
		map.put("batch_num", 1);
		map.put("batch_no", refundNo);
		map.put("payType", OrderPayType.ALIPAY.getId());
	}
	
}
