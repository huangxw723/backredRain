package com.aoshi.dao;

import java.util.List;

import org.apache.ibatis.annotations.Select;

import com.aoshi.domain.AsAttrType;
import com.aoshi.util.PageData;

public interface AsAttrTypeMapper {
    int deleteByPrimaryKey(Integer attrTypeId);

    int insert(AsAttrType record);

    int insertSelective(AsAttrType record);

    AsAttrType selectByPrimaryKey(Integer attrTypeId);

    int updateByPrimaryKeySelective(AsAttrType record);

    int updateByPrimaryKey(AsAttrType record);
    
	List<AsAttrType> selectByAttr(PageData pd);

	int updateByPrimaryKeys(int[] idArr);

	List<AsAttrType> findAll();

	List<AsAttrType> findAttrValue();

	@Select(value = "select * from as_attr_type where is_delete = 0")
	List<AsAttrType> selectAll();
}