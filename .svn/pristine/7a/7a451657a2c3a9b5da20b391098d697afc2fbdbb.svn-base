package com.aoshi.dao;

import java.util.List;

import org.apache.ibatis.annotations.Select;

import com.aoshi.domain.AsCity;
import com.aoshi.util.PageData;

public interface AsCityMapper {
	int deleteByPrimaryKey(Integer cityId);

	int deleteByPrimaryKeys(String[] provinceIds);

	int insert(AsCity record);

	int insertSelective(AsCity record);

	AsCity selectByPrimaryKey(Integer cityId);

	List<AsCity> selectByAttr(PageData pd);

	int updateByPrimaryKeySelective(AsCity record);

	int updateByPrimaryKey(AsCity record);
	
	@Select(value="select * from as_city")
	List<AsCity> selectAll();
	
	@Select(value="select city_id, city_name from as_city where province_id = #{provinceId}")
	List<AsCity> getCitByProvinceId(Integer provinceId);

}