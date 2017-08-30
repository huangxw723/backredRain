package com.aoshi.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.aoshi.domain.AsArea;
import com.aoshi.domain.AsCity;
import com.aoshi.domain.AsConsultationSpecialty;
import com.aoshi.domain.AsConsultationType;
import com.aoshi.domain.AsProvince;
import com.aoshi.util.PageData;

public interface AsSpecialtyMapper extends AsBaseMapper {
	public List<AsProvince> queryPro();

	public List<AsCity> queryCity(@Param("id") Integer id);

	public List<AsArea> queryArea(@Param("id") Integer id);
	
	public AsConsultationType queryType(String name);

	public List<AsConsultationSpecialty> queryAllCate(AsConsultationSpecialty food);

	public int insertFood(AsConsultationSpecialty food);

	public int deleteCateByIds(String[] ids);

	public int offSaleAll(String[] ids);
	
	public int updateCate(AsConsultationSpecialty asConsultationFood);

	public List<AsCity> queryCityList(Integer provinceId);
}
