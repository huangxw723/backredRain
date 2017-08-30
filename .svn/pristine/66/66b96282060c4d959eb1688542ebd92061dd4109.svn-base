package com.aoshi.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.aoshi.domain.AsBank;
import com.aoshi.util.Conditions;

public interface AsBankMapper extends AsBaseMapper{
    int deleteByPrimaryKey(Integer bankId);

    int insert(AsBank record);

    int insertSelective(AsBank record);

    AsBank selectByPrimaryKey(Integer bankId);

    int updateByPrimaryKeySelective(AsBank record);

    int updateByPrimaryKey(AsBank record);
    
    List<Conditions> selectAllBank(Object conditions);
    
    List<Conditions> bankInfoByPram(Object conditions);
    
    Conditions selectByCodeOrName(@Param("bankCode") String bankCode,@Param("bankName") String bankName);

}