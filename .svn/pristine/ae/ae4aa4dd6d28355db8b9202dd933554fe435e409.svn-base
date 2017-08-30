package com.aoshi.dao;

import com.aoshi.domain.AsBrand;
import org.apache.ibatis.annotations.Select;

import java.util.List;

public interface AsBrandMapper {
    int deleteByPrimaryKey(Integer brandId);

    int insert(AsBrand record);

    int insertSelective(AsBrand record);

    AsBrand selectByPrimaryKey(Integer brandId);

    int updateByPrimaryKeySelective(AsBrand record);

    int updateByPrimaryKey(AsBrand record);

    List<AsBrand> queryList(AsBrand record);

    int deleteByBrandIds(String[] conditions);

    @Select(value = "select * from as_brand where is_show ='Y'")
    List<AsBrand> queryAll();
}