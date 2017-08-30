package com.aoshi.dao;

import com.aoshi.domain.AsBusinessDistrict;
import com.aoshi.domain.AsConsultationHotel;
import com.aoshi.domain.AsConsultationImgs;

import java.util.List;

/**
 * 接口层
 * @author：wendy
 * @date：
 */
public interface AsConsultationHotelMapper {
    
	//查询-TODO
	AsConsultationHotel selectByPrimaryKey(Integer id);
    //列表显示   
	List<AsConsultationHotel> queryList(AsConsultationHotel obj);
	
	//保存新增
	int insertSelective(AsConsultationHotel obj);
	//删除
    int deleteByPrimaryKey(Integer id);
    //批量删除
    int deleteByIds(String[] ids);
    //保存编辑
    int updateByPrimaryKey(AsConsultationHotel obj);
    
    //发布||下架
    int updateByPrimaryKeySelective(AsConsultationHotel obj);
    //批量下架
    int offSaleAll(String[] ids);

    //上传多张图片
    public int insertImgs(AsConsultationImgs asImgs);
    //商圈
    List<AsBusinessDistrict> selectAl2();
    
    public AsConsultationImgs selectByPrimaryKeyImg(Integer id);
    
    public int insertSelectiveImg(AsConsultationImgs asConsultationImgs);
    
	public AsConsultationImgs selectByPrimaryKeyImgs(Integer id);

	public int updateByPrimaryKeySelectiveImg(AsConsultationImgs asConsultationImgs);
    
	public int deleteByPrimaryKeyImgs(Integer id);
	
 
}