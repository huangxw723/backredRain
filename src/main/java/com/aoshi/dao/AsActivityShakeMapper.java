package com.aoshi.dao;


import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import com.aoshi.domain.AsActivityShake;

public interface AsActivityShakeMapper {
    int deleteByPrimaryKey(Integer activityShakeId);

    int insert(AsActivityShake record);

    int insertSelective(AsActivityShake record);

    AsActivityShake selectByPrimaryKey(Integer activityShakeId);

    int updateByPrimaryKeySelective(AsActivityShake record);

    int updateByPrimaryKey(AsActivityShake record);

	List<AsActivityShake> fingByStoreId(Integer storeId);

    List<AsActivityShake> selectAll();
    @Select("select * from as_activity_shake where store_id = #{storeId}")
    List<AsActivityShake> selectByStoreId(@Param(value = "storeId") Integer storeId);
}