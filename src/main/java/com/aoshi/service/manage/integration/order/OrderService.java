package com.aoshi.service.manage.integration.order;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.aoshi.dao.AsOrderActionMapper;
import com.aoshi.dao.AsOrderGoodsMapper;
import com.aoshi.dao.AsOrderMapper;
import com.aoshi.domain.AsOrder;
import com.aoshi.domain.AsOrderAction;
import com.aoshi.domain.AsOrderGoods;
import com.aoshi.service.base.AsBaseService;
import com.aoshi.util.PageData;

@Service
public class OrderService extends AsBaseService {

	@Autowired
	private AsOrderMapper mapper;

	@Autowired
	private AsOrderGoodsMapper goodsMapper;

	@Autowired
	private AsOrderActionMapper actionMapper;

	/*
	 * 修改
	 */
	public int edit(AsOrder record) {
		AsOrder order = mapper.selectByPrimaryKey(record.getOrderId());
		if (order.getOrderStatus() == 1) {
			record.setOrderPrice(order.getGoodsPrice().add(
					record.getShippingPrice()));
			record.setActualPrice(order.getGoodsPrice()
					.subtract(order.getCouponPrice())
					.subtract(order.getPointPrice())
					.add(record.getShippingPrice()));
			record.setIncomePrice(record.getActualPrice()
					.add(order.getPointPrice()).add(order.getPlatformPrice()));
		}
		return mapper.updateByPrimaryKeySelective(record);
	}

	/*
	 * 通过id获取数据
	 */
	public AsOrder findById(AsOrder record) {
		return mapper.selectByPrimaryKey(record.getOrderId());
	}

	/*
	 * 列表
	 */
	public List<AsOrder> list(PageData pd) {
		return mapper.selectByAttr(pd);
	}

	/*
	 * 发货
	 */
	public int updateDelivery(AsOrder record, AsOrderAction action) {
		int flag = mapper.updateDelivery(record);
		if (flag == 1) {
			action.setOrderId(record.getOrderId());
			actionMapper.insert(action);
		}
		return flag;
	}

	/*
	 * 列表
	 */
	public List<AsOrderGoods> listGoods(PageData pd) {
		return goodsMapper.selectByAttr(pd);
	}

	/*
	 * 列表
	 */
	public List<AsOrderAction> listAction(PageData pd) {
		return actionMapper.selectByAttr(pd);
	}
	
	
	/*
	 * 积分订单发货
	 */
	public int delivery(AsOrder record, AsOrderAction action) {
		int flag = mapper.pointOrderDelivery(record);
		if (flag == 1) {
			action.setOrderId(record.getOrderId());
			actionMapper.insert(action);
		}
		return flag;
	}


}
