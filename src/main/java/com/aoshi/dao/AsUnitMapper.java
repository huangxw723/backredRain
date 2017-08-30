package com.aoshi.dao;

import java.util.List;

import com.aoshi.domain.AsUnit;
import com.aoshi.util.PageData;

public interface AsUnitMapper extends AsBaseMapper {
	int deleteByPrimaryKey(Integer unitId);

	int insert(AsUnit record);

	int insertSelective(AsUnit record);

	AsUnit selectByPrimaryKey(Integer unitId);

	int updateByPrimaryKeySelective(AsUnit record);

	int updateByPrimaryKey(AsUnit record);

	int updateByPrimaryKeys(int[] idArr);

	List<AsUnit> findAll();
}