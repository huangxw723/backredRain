package com.aoshi.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.One;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import com.aoshi.domain.AsBusinessModule;

public interface AsBusinessModuleMapper {
    int deleteByPrimaryKey(Integer businessModuleId);

    int insert(AsBusinessModule record);

    int insertSelective(AsBusinessModule record);

    AsBusinessModule selectByPrimaryKey(Integer businessModuleId);

    int updateByPrimaryKeySelective(AsBusinessModule record);

    int updateByPrimaryKeyWithBLOBs(AsBusinessModule record);

    int updateByPrimaryKey(AsBusinessModule record);
    
    //@Select(value = "select * from as_business_module where business_template_id = #{businessTemplateId}")
	List<AsBusinessModule> selectByBusinessTemplateIdWithTemplate(@Param(value="businessTemplateId")Integer businessTemplateId);
	
	@Delete(value="delete from as_business_module where business_template_id = #{businessTemplateId}")
	int deleteByBusinessTemplateId(@Param(value="businessTemplateId") int businessTemplateId);
	
	List<AsBusinessModule> selectBusinessModuleByTemplateId(Map<String,Object> map);
	
	@Select(value="select * from as_business_module where parent_module_id = #{parentModuleId} and position = #{position}")
	AsBusinessModule selectBusinessModuleByParent(AsBusinessModule param);

	int deleteByIds(List<Integer> ids);
	
	@Select(value="select count(*) amount from as_business_module where business_template_id = #{businessTemplateId}")
	Map<String,Long> countByTemplateId(@Param(value="businessTemplateId") Integer businessTemplateId);
	
	@Select(value = "select * from as_business_module where business_template_id = #{businessTemplateId}")
	List<AsBusinessModule> selectByBusinessTemplateId(@Param(value="businessTemplateId") int businessTemplateId);
}