package com.aoshi.dao;

import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import com.aoshi.domain.AsModuleInvestment;

public interface AsModuleInvestmentMapper {
    int deleteByPrimaryKey(Integer moduleInvestmentId);

    int insert(AsModuleInvestment record);

    int insertSelective(AsModuleInvestment record);

    AsModuleInvestment selectByPrimaryKey(Integer moduleInvestmentId);

    int updateByPrimaryKeySelective(AsModuleInvestment record);

    int updateByPrimaryKey(AsModuleInvestment record);
    
    @Select(value="select * from as_module_investment where business_module_id = #{businessModuleId}")
	AsModuleInvestment findByBusinessModuleId(@Param(value="businessModuleId")int businessModuleId);
}