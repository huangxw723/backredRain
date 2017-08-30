package com.aoshi.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import com.aoshi.domain.AsBusinessTemplate;

public interface AsBusinessTemplateMapper {
    int deleteByPrimaryKey(Integer businessTemplateId);

    int insert(AsBusinessTemplate record);

    int insertSelective(AsBusinessTemplate record);

    AsBusinessTemplate selectByPrimaryKey(Integer businessTemplateId);

    int updateByPrimaryKeySelective(AsBusinessTemplate record);

    int updateByPrimaryKey(AsBusinessTemplate record);
    
    @Select(value="select * from as_business_template where level=1 and status=0 and user_id is null and template_type_id = #{templateTypeId}")
	List<AsBusinessTemplate> getBusinessTemplates(@Param(value="templateTypeId")Integer templateTypeId);
    
    @Select(value="select * from as_business_template where parent_business_template_id = #{businessTemplateId}")
	List<AsBusinessTemplate> selectByParentBusinessTemplateId(@Param(value="businessTemplateId")Integer businessTemplateId);
    
    @Select(value="select * from as_business_template where level=1 and status=0 and user_id = #{userId}")
	List<AsBusinessTemplate> getMyBusinessTemplates(@Param(value="userId")String userId);
    
    @Select(value="select * from as_business_template where level=#{level} and status=0 and parent_business_module_id = 0 and user_id is null")
	List<AsBusinessTemplate> getBusinessTemplateByLevel(@Param(value="level")int level);

	List<AsBusinessTemplate> selectTemplateByAttr(AsBusinessTemplate template);
	
	@Select(value="select * from as_business_template where parent_business_module_id = #{businessModuleId}")
	AsBusinessTemplate findByParentModuleId(@Param(value="businessModuleId") int businessModuleId);
	
	@Select(value="select t.*,m.position from as_business_template t "
			+ "LEFT JOIN as_business_module m on t.parent_business_module_id = m.business_module_id"
			+ " where parent_business_template_id = #{businessTemplateId} "
			+ "ORDER BY m.position")
	List<AsBusinessTemplate> selectByParentBusinessTemplateIdOrderByPosition(Integer businessTemplateId);
}