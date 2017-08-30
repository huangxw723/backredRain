package com.aoshi.dao;

import java.util.List;

import org.apache.ibatis.annotations.Select;

import com.aoshi.domain.AsTemplateType;

public interface AsTemplateTypeMapper {
    int deleteByPrimaryKey(Integer templateTypeId);

    int insert(AsTemplateType record);

    int insertSelective(AsTemplateType record);

    AsTemplateType selectByPrimaryKey(Integer templateTypeId);

    int updateByPrimaryKeySelective(AsTemplateType record);

    int updateByPrimaryKey(AsTemplateType record);
    @Select(value="select * from as_template_type order by template_type_id asc")
	List<AsTemplateType> selectAll();
}