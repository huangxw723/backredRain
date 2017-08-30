package com.aoshi.dao;

import java.util.List;

import com.aoshi.domain.AsActivityData;
import com.aoshi.util.PageData;

public interface AsActivityDataMapper extends AsBaseMapper{
    int deleteByPrimaryKey(Integer activityDataId);

    int insert(AsActivityData record);

    int insertSelective(AsActivityData record);

    AsActivityData selectByPrimaryKey(Integer activityDataId);

    int updateByPrimaryKeySelective(AsActivityData record);

    int updateByPrimaryKey(AsActivityData record);

	AsActivityData getActivityData(PageData pd);

	/**
	 * 根据活动id获取活动记录数据
	 * 
	 * @author yangyanchao
	 * @date 2016年9月6日
	 * @param conditions
	 * @return AsActivityData
	 */
	AsActivityData getActivityDataInfo(PageData pd);

	/**
	 * 活动历史数据
	 * 
	 * @author yangyanchao
	 * @date 2016年9月6日
	 * @param conditions
	 * @return
	 */
	List<Object> listHistory(Object conditions);

}