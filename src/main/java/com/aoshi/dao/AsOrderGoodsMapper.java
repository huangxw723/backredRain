package com.aoshi.dao;

import java.util.List;

import com.aoshi.domain.AsOrderGoods;
import com.aoshi.util.PageData;

public interface AsOrderGoodsMapper extends AsBaseMapper {
	int deleteByPrimaryKey(Integer orderGoodsId);

	int insert(AsOrderGoods record);

	int insertSelective(AsOrderGoods record);

	AsOrderGoods selectByPrimaryKey(Object record);

	AsOrderGoods selectByRefundNo(String RefundNo);

	Object selectByRefundNoWithLock(Object conditions);

	List<AsOrderGoods> selectByAttr(PageData pd);

	int updateByPrimaryKeySelective(AsOrderGoods record);

	int updateByPrimaryKey(AsOrderGoods record);

	int updateAgreeRefund(AsOrderGoods record);

	int updateRejectRefund(AsOrderGoods record);

	int updateRefund(AsOrderGoods record);

	int selectNotRefundCounts(Object conditions);
}