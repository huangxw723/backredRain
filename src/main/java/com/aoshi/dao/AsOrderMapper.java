package com.aoshi.dao;

import java.util.List;

import com.aoshi.domain.AsOrder;
import com.aoshi.util.PageData;

public interface AsOrderMapper extends AsBaseMapper{
    int deleteByPrimaryKey(Integer orderId);

    int insert(AsOrder record);

    int insertSelective(AsOrder record);

    AsOrder selectByPrimaryKey(Integer orderId);

    int updateByPrimaryKeySelective(AsOrder record);

    int updateByPrimaryKey(AsOrder record);
    
    AsOrder selectByPrimaryKeys(Integer orderId);
    
    List<AsOrder> selectByAttr(PageData pd);

	int updateDelivery(AsOrder record);
    
	/**
	 * 查询积分商城订单
	 * 
	 * @author yangyanchao
	 * @date 2016年12月7日
	 * @param conditions
	 * @return
	 */
	List<Object> getIntegrationOrderList(Object conditions);

	/**
	 * 积分商城订单发货
	 * 
	 * @author huangxw
	 * @date 2016年12月8日
	 * @param AsOrder
	 * @return
	 */
	int pointOrderDelivery(AsOrder record);

	AsOrder getShopOrderInfo(AsOrder order);
}