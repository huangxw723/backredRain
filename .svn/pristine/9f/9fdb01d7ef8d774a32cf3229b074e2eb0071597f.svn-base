package com.aoshi.dao;

import java.util.List;

import org.apache.ibatis.annotations.Select;

import com.aoshi.domain.AsArea;
import com.aoshi.util.PageData;

public interface AsAreaMapper {
	int deleteByPrimaryKey(Integer areaId);

	int deleteByPrimaryKeys(String[] provinceIds);

	int insert(AsArea record);

	int insertSelective(AsArea record);

	AsArea selectByPrimaryKey(Integer areaId);

	List<AsArea> selectByAttr(PageData pd);

	int updateByPrimaryKeySelective(AsArea record);

	int updateByPrimaryKey(AsArea record);
	@Select(value="select * from as_area")
	List<AsArea> selectAll();

	@Select(value="select area_id, area_name from as_area where city_id = #{cityId}")
	List<AsArea> getAreaByCityId(String cityId);
}