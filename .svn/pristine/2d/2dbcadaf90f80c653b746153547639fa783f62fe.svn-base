package com.aoshi.service.manage.integration.order;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.aoshi.dao.AsOrderActionMapper;
import com.aoshi.dao.AsOrderGoodsMapper;
import com.aoshi.domain.AsOrderAction;
import com.aoshi.domain.AsOrderGoods;

@Service
public class AsOrderGoodsService {

	@Autowired
	private AsOrderGoodsMapper mapper;

	@Autowired
	private AsOrderActionMapper actionMapper;

	/*
	 * 通过id获取数据
	 */
	public AsOrderGoods findById(AsOrderGoods record) {
		return mapper.selectByPrimaryKey(record.getOrderGoodsId());
	}

	/*
	 * 同意退款
	 */
	public int updateAgreeRefund(AsOrderGoods record, AsOrderAction action) {
		int flag = mapper.updateAgreeRefund(record);
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
		int flag = mapper.updateRejectRefund(record);
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
		int flag = mapper.updateRefund(record);
		if (flag == 1) {
			action.setOrderId(record.getOrderId());
			actionMapper.insert(action);
		}
		return flag;
	}

}
