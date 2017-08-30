package com.aoshi.dao;

import com.aoshi.domain.AsPrizeCategory;

public interface AsPrizeCategoryMapper {
    int deleteByPrimaryKey(Integer prizeCategoryId);

    int insert(AsPrizeCategory record);

    int insertSelective(AsPrizeCategory record);

    AsPrizeCategory selectByPrimaryKey(Integer prizeCategoryId);

    int updateByPrimaryKeySelective(AsPrizeCategory record);

    int updateByPrimaryKey(AsPrizeCategory record);

	AsPrizeCategory selectByConfigId(Integer prizeConfigId);

	/**
	 * 删除分类时，检查是否有关联的优惠券！
	 * 
	 * @author tgb 创建时间：2016年11月16日
	 * @version 1.0
	 * @param categoryId
	 * @return
	 */
	int findByCategoryId(int categoryId);

}