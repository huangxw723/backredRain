package com.aoshi.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.aoshi.domain.AsArea;
import com.aoshi.domain.AsBusinessDistrict;
import com.aoshi.domain.AsCity;
import com.aoshi.domain.AsConsultationFood;
import com.aoshi.domain.AsConsultationImgs;
import com.aoshi.domain.AsConsultationType;
import com.aoshi.domain.AsProvince;
import com.aoshi.domain.AsYpBaseCategory;
import com.aoshi.util.PageData;

/**
 * 美食发布
 * @author strong
 * @version 1.0
 * 2016年11月29日上午10:04:52
 */
public interface AsCateMapper extends AsBaseMapper{

	public List<AsConsultationFood> queryList();

	public List<AsProvince> queryPro();

	public List<AsCity> queryCity(@Param("id") Integer id);

	public List<AsArea> queryArea(@Param("id") Integer id);
	
	public List<AsBusinessDistrict> queryBusiness(@Param("id") Integer id);

	public AsConsultationType queryType(String name);

	public int insertImgs(AsConsultationImgs asImgs);

	public List<AsYpBaseCategory> queryFood(Integer id);

	public List<AsConsultationFood> queryAllCate(AsConsultationFood food);

	public int insertFood(AsConsultationFood food);

	public void deleteByPrimaryKeyforImgs(@Param("consultationFoodId")Integer consultationFoodId,@Param("typeId")Integer typeId);

	public List<AsConsultationImgs> queryImgsById(@Param("id")Integer id,@Param("typeId")Integer typeId);

	public int deleteCateByIds(String[] ids);

	public int offSaleAll(String[] ids);

	public AsConsultationImgs selectByPrimaryKeyImg(Integer id);

	public int updateByPrimaryKeySelectiveImg(AsConsultationImgs asConsultationImgs);

	public int deleteByPrimaryKeyImg(Integer id);

	public AsConsultationImgs queryImgById(Integer id);

	public int insertSelectiveImg(AsConsultationImgs asConsultationImgs);

	public int updateCate(AsConsultationFood asConsultationFood);

	public List<AsCity> queryCityList(Integer provinceId);

	public void deleteImgsByIds(Map<String,Object> map);

	public Integer queryTypeId(String id);

	

	
	
	

}
