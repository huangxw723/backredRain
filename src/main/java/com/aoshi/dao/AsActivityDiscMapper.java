package com.aoshi.dao;

import java.util.List;

import com.aoshi.domain.AsActivityDisc;
import com.aoshi.util.Conditions;
import com.aoshi.util.PageData;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

public interface AsActivityDiscMapper extends AsBaseMapper {
    int deleteByPrimaryKey(Integer activityDiscId);

    int insert(AsActivityDisc record);

    int insertSelective(AsActivityDisc record);

    AsActivityDisc selectByPrimaryKey(Integer activityDiscId);

    int updateByPrimaryKeySelective(AsActivityDisc record);

    int updateByPrimaryKey(AsActivityDisc record);
    
    @Select("select * from as_activity_disc where store_id = #{storeId}")
    List<AsActivityDisc> selectByStoreId(@Param(value = "storeId") Integer storeId);
     
    List<AsActivityDisc> selectAll();
}