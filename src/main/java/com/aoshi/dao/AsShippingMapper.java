package com.aoshi.dao;

import java.util.List;

import com.aoshi.domain.AsShipping;
import com.aoshi.util.PageData;

/**
 * 配送管理DAO
 * 
 * @author yangyanchao
 * @date 2016年7月7日
 */
public interface AsShippingMapper extends AsBaseMapper {
	int deleteByPrimaryKey(Integer shippingId);

	int insert(AsShipping record);

	int insertSelective(AsShipping record);

	List<AsShipping> selectByAttr(PageData pd);

	int deleteByPrimaryKeys(int[] idArr);

	List<AsShipping> selectAllForAvailable(PageData pd);
	
	List<AsShipping> listAll();
}

