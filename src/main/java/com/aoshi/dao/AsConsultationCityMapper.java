package com.aoshi.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import com.aoshi.domain.AsConsultationCity;
import com.aoshi.domain.AsConsultationType;

/**
 * 接口层
 * @author：wendy
 * @date：
 */
public interface AsConsultationCityMapper {
	
	//查询-TODO
	AsConsultationCity selectByPrimaryKey(Integer id);
	//查询
    AsConsultationCity selectById(Integer id);
    //列表显示   
	List<AsConsultationCity> queryList(AsConsultationCity obj);
	
	//保存新增
	int insertSelective(AsConsultationCity obj);
	//删除
    int deleteByPrimaryKey(Integer id);
    //批量删除
    int deleteByIds(String[] ids);
    //保存编辑
    int updateByPrimaryKey(AsConsultationCity obj);
    
    //发布||下架
    int updateByPrimaryKeySelective(AsConsultationCity obj);
    //批量下架
    int offSaleAll(String[] ids);
    
    /** 
	 * 根据同城活动名称查询出对应consultation_type_id
	 * @param asConsultationType
	 * @return
	 */
	@Select("select * from as_consultation_type where parent_id in(select consultation_type_id from as_consultation_type where type_name=#{typeName})")
	List<AsConsultationType> selectByName(@Param(value="typeName")String typeName);
	    
}