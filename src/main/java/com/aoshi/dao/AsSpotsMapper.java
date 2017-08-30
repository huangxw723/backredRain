package com.aoshi.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.aoshi.domain.AsArea;
import com.aoshi.domain.AsCity;
import com.aoshi.domain.AsConsultationSpots;
import com.aoshi.domain.AsConsultationImgs;
import com.aoshi.domain.AsConsultationType;
import com.aoshi.domain.AsProvince;
import com.aoshi.domain.AsYpBaseCategory;

public interface AsSpotsMapper extends AsBaseMapper {

	List<AsProvince> queryPro();

	public List<AsCity> queryCity(@Param("id") Integer id);

	public List<AsArea> queryArea(@Param("id") Integer id);

	AsConsultationType queryType(String name);

	void insertImgs(AsConsultationImgs imgs);
	
	public List<AsYpBaseCategory> queryFood();

	public List<AsConsultationSpots> queryAllCate(AsConsultationSpots food);

	public int insertFood(AsConsultationSpots food);

	public void deleteByPrimaryKeyforImgs(@Param("consultationSpotsId")Integer consultationSpotsId,@Param("typeId")Integer typeId);

	public List<AsConsultationImgs> queryImgsById(@Param("id")Integer id,@Param("typeId")Integer typeId);

	public int deleteCateByIds(String[] ids);

	public int offSaleAll(String[] ids);

	public AsConsultationImgs selectByPrimaryKeyImg(Integer id);

	public int updateByPrimaryKeySelectiveImg(AsConsultationImgs asConsultationImgs);

	public int deleteByPrimaryKeyImg(Integer id);

	public AsConsultationImgs queryImgById(Integer id);

	public int insertSelectiveImg(AsConsultationImgs asConsultationImgs);

	public int updateCate(AsConsultationSpots AsConsultationSpots);

	List<AsCity> queryCityList(Integer provinceId);

	public void deleteImgsByIds(Map<String,Object> map);

	public Integer queryTypeId(String id);


}
