package com.aoshi.dao;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Param;

import com.aoshi.domain.AsYpUserModule;
import com.aoshi.domain.AsYpUserTemplate;

public interface AsYpUserModuleMapper {
    int deleteByPrimaryKey(Integer userModuleId);

    int insert(AsYpUserModule record);

    int insertSelective(AsYpUserModule record);

    AsYpUserModule selectByPrimaryKey(Integer userModuleId);

    int updateByPrimaryKeySelective(AsYpUserModule record);

    int updateByPrimaryKey(AsYpUserModule record);
    

	List<AsYpUserModule> selectByAttr(AsYpUserTemplate asYpUserTemplate);
	
	@Delete(value="delete from as_yp_user_module where user_template_id = #{userTemplateId}")
	int deleteByUserTemplateId(@Param(value="userTemplateId")int userTemplateId);
}