package com.aoshi.dao;

import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import com.aoshi.domain.AsModuleShop;

public interface AsModuleShopMapper {
    int deleteByPrimaryKey(Integer moduleShopId);

    int insert(AsModuleShop record);

    int insertSelective(AsModuleShop record);

    AsModuleShop selectByPrimaryKey(Integer moduleShopId);

    int updateByPrimaryKeySelective(AsModuleShop record);

    int updateByPrimaryKey(AsModuleShop record);
    @Select(value="select * from as_module_shop where business_module_id = #{businessModuleId}")
	AsModuleShop findByModuleId(@Param(value="businessModuleId")Integer businessModuleId);
}