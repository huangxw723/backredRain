package com.aoshi.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import com.aoshi.domain.AsAttribute;
import com.aoshi.util.PageData;

public interface AsAttributeMapper {
    int deleteByPrimaryKey(Integer attributeId);

    int insert(AsAttribute record);

    int insertSelective(AsAttribute record);

    AsAttribute selectByPrimaryKey(Integer attributeId);

    int updateByPrimaryKeySelective(AsAttribute record);

    int updateByPrimaryKeyWithBLOBs(AsAttribute record);

    int updateByPrimaryKey(AsAttribute record);
    
	List<AsAttribute> selectByAttr(PageData pd);

	int updateByPrimaryKeys(int[] idArr);

	AsAttribute findByTypeId(PageData pd);

	@Select(value = "select * from as_attribute where is_delete = 0 and attr_type_id = #{attrTypeId}")
	List<AsAttribute> findByAttrTypeId(@Param(value="attrTypeId")int attrTypeId);

	List<AsAttribute> getAttributes(AsAttribute attribute);
}