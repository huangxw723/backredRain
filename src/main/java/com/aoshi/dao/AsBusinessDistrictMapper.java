package com.aoshi.dao;

import java.util.List;

import org.apache.ibatis.annotations.Select;

import com.aoshi.domain.AsBusinessDistrict;
import com.aoshi.util.PageData;

public interface AsBusinessDistrictMapper {
	int deleteByPrimaryKey(Integer businessDistrictId);

	int deleteByPrimaryKeys(String[] businessDistrictIds);

	int insert(AsBusinessDistrict record);

	int insertSelective(AsBusinessDistrict record);

	AsBusinessDistrict selectByPrimaryKey(Integer businessDistrictId);

	List<AsBusinessDistrict> selectByAttr(PageData pd);

	int updateByPrimaryKeySelective(AsBusinessDistrict record);

	int updateByPrimaryKey(AsBusinessDistrict record);
	
	@Select(value="select * from as_business_district order by business_district_id desc")
	List<AsBusinessDistrict> queryList();

	@Select(value="select * from as_business_district where area_id = #{areaId}")
	List<AsBusinessDistrict> getBusinessDistrict(String areaId);
}