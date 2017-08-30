package com.aoshi.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import com.aoshi.domain.AsConsultationInfo;
import com.aoshi.domain.AsConsultationType;

/**
 * 接口层
 * @author：wendy
 * @date：
 */
public interface AsConsultationInfoMapper {
	
	//查询-TODO
	AsConsultationInfo selectByPrimaryKey(Integer id);
	//查询
    AsConsultationInfo selectById(Integer id);
    //列表显示   
	List<AsConsultationInfo> queryList(AsConsultationInfo obj);
	
	//保存新增
	int insertSelective(AsConsultationInfo obj);
	//删除
    int deleteByPrimaryKey(Integer id);
    //批量删除
    int deleteByIds(String[] ids);
    //保存编辑
    int updateByPrimaryKey(AsConsultationInfo obj);
    
    //发布||下架
    int updateByPrimaryKeySelective(AsConsultationInfo obj);
    //批量下架
    int offSaleAll(String[] ids);
    
   

}