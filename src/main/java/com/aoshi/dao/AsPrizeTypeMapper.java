package com.aoshi.dao;

import java.util.List;

import com.aoshi.domain.AsPrizeType;
import com.aoshi.util.Conditions;
import com.aoshi.util.PageData;

public interface AsPrizeTypeMapper extends AsBaseMapper {
	/**
	 * 获取所有活动类型数据
	 * 
	 * @author huangxuwen
	 * @date 2016年9月1日
	 * @return List
	 */
	List<Conditions> listAll(Object conditions);
	
	int fiandAll(Object pd);

	int isPrizeExists(Object pd);

	List<AsPrizeType> queryAll(Object object);
	
	int isPrizeTypeExists(Object pd);

	int isPrizeConfigExists(PageData pd);
	
	List<AsPrizeType> queryPrizeTypesLike(AsPrizeType asPrizeType);
}