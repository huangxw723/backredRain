package com.aoshi.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import com.aoshi.domain.AsYpUserTemplate;

public interface AsYpUserTemplateMapper {
    int deleteByPrimaryKey(Integer userTemplateId);

    int insert(AsYpUserTemplate record);

    int insertSelective(AsYpUserTemplate record);

    AsYpUserTemplate selectByPrimaryKey(Integer userTemplateId);

    int updateByPrimaryKeySelective(AsYpUserTemplate record);

    int updateByPrimaryKey(AsYpUserTemplate record);
    
    @Select(value="select * from as_yp_user_template where user_id = #{userId} and parent_user_template_id = 0")
	List<AsYpUserTemplate> getUserTemplateByUserId(@Param(value="userId")String userId);

	AsYpUserTemplate getUserTemplateByPrimaryKey(AsYpUserTemplate asYpUserTemplate);

	//AsYpUserTemplate findByUserTemplateId(int rootUserTemplateId);
	
	List<AsYpUserTemplate> selectByParentUserTemplateId(@Param(value="ParentUserTemplateId")int ParentUserTemplateId);
	
	@Select("select count(*) number from as_yp_user_template where user_id = #{userId} and parent_user_template_id = 0")
	Map<String,Integer> countUserTemplate(@Param(value="userId")int userId);
	
	/*@Select(value="select * from as_yp_user_template where is_business = 1")
	List<AsYpUserTemplate> getBusinessTemplates();*/
}