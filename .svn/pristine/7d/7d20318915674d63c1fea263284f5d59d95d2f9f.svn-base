package com.aoshi.dao;

import java.util.List;

import org.apache.ibatis.annotations.Select;

import com.aoshi.domain.AsTemplateFixed;

public interface AsTemplateFixedMapper {
    int deleteByPrimaryKey(Integer templateFixedId);

    int insert(AsTemplateFixed record);

    int insertSelective(AsTemplateFixed record);

    AsTemplateFixed selectByPrimaryKey(Integer templateFixedId);

    int updateByPrimaryKeySelective(AsTemplateFixed record);

    int updateByPrimaryKey(AsTemplateFixed record);
    
    @Select(value="select * from as_template_fixed order by sort asc")
	List<AsTemplateFixed> selectAll();
}