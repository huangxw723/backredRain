package com.aoshi.dao;

import java.util.List;

import com.aoshi.domain.AsProvince;
import com.aoshi.util.PageData;

public interface AsProvinceMapper {
	int deleteByPrimaryKey(Integer provinceId);

	int deleteByPrimaryKeys(String[] provinceIds);

	int insert(AsProvince record);

	int insertSelective(AsProvince record);

	AsProvince selectByPrimaryKey(Integer provinceId);

	List<AsProvince> selectByAttr(PageData pd);

	int updateByPrimaryKeySelective(AsProvince record);

	int updateByPrimaryKey(AsProvince record);
	
	List<AsProvince> getProvinceAll();

}