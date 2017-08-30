package com.aoshi.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import com.aoshi.domain.AsArea;
import com.aoshi.domain.AsCity;
import com.aoshi.domain.AsConsultationConvenience;
import com.aoshi.domain.AsConsultationImgs;
import com.aoshi.domain.AsConsultationType;
/**
 * 接口层
 * @author：wendy
 * @date：
 */
public interface AsConsultationConvenienceMapper {
	
    //查询-TODO
	AsConsultationConvenience selectByPrimaryKey(Integer id);
	//查询
    AsConsultationConvenience selectById(Integer id);
    //列表显示   
	List<AsConsultationConvenience> queryList(AsConsultationConvenience obj);
	
	//保存新增
	int insertSelective(AsConsultationConvenience obj);
	//删除
    int deleteByPrimaryKey(Integer id);
    //批量删除
    int deleteByIds(String[] ids);
    //保存编辑
    int updateByPrimaryKey(AsConsultationConvenience obj);
    
    //发布||下架
    int updateByPrimaryKeySelective(AsConsultationConvenience obj);
    //批量下架
    int offSaleAll(String[] ids);
    
    //上传多张图片
    public int insertImgs(AsConsultationImgs asImgs);
    
    //--------------------other多图片上传 ------------------------------------
    //多图片2
    public List<AsConsultationImgs> queryImgsById(Integer id);
    
    public AsConsultationImgs selectByPrimaryKeyImg(Integer id);
    
    public int insertSelectiveImg(AsConsultationImgs asConsultationImgs);
    
	public AsConsultationImgs selectByPrimaryKeyImgs(Integer id);

	public int updateByPrimaryKeySelectiveImg(AsConsultationImgs asConsultationImgs);
    
	public int deleteByPrimaryKeyImgs(Integer id);  
	
	/** 
	 * 根据城市百科名称查询出对应consultation_type_id
	 * @param asConsultationType
	 * @return
	 */
	@Select("select * from as_consultation_type where parent_id in(select consultation_type_id from as_consultation_type where type_name=#{typeName})")
	List<AsConsultationType> selectByName(@Param(value="typeName")String typeName);
	
	//查询城市
	public List<AsCity> queryCity(@Param("id") Integer id);

	public List<AsArea> queryArea(@Param("id") Integer id);

    
}