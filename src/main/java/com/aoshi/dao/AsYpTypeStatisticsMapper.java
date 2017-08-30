package com.aoshi.dao;

import java.util.List;

public interface AsYpTypeStatisticsMapper extends AsBaseMapper {

	/**
	 * 云屏管理服务分类列表
	 * 
	 * @author yangyanchao
	 * @date 2016年10月25日
	 * @param conditions
	 * @return
	 */
	public List<Object> getYpServiceTypeList(Object conditions);

	/**
	 * 删除分类时，检查是否有关联的服务内容
	 * 
	 * @author tgb 创建时间：2016年11月16日
	 * @version 1.0
	 * @param categoryId
	 * @return
	 */
	public int findByCategoryId(int categoryId);
}