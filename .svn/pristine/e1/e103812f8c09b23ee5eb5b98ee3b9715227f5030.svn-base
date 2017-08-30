package com.aoshi.dao;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Param;

import com.aoshi.domain.AsYpScreenDomain;
import com.aoshi.util.Conditions;

public interface AsYpScreenDomainMapper extends AsBaseMapper{
    int deleteByPrimaryKey(Integer screenDomainId);

    int insert(AsYpScreenDomain record);

    int insertSelective(AsYpScreenDomain record);

    AsYpScreenDomain selectByPrimaryKey(Integer screenDomainId);

    int updateByPrimaryKeySelective(AsYpScreenDomain record);

    int updateByPrimaryKey(AsYpScreenDomain record);

	List<Conditions> queryListAll(Object pd);
	
	int updateStatus(Object conditions);
	
	List<Conditions> listAllInfo(Object conditions);
	
	List<Conditions> listAllBShopId(Object conditions);
	
	List<Conditions> queryDomainAll(Object conditions);
	
	List<Conditions> getScreenPageById(Object conditions);
	
	int updateDomainStatus(Object conditions);
	
	List<Conditions> childDomainList(Object conditions);
	
	@Delete(value="delete from as_yp_screen_domain where user_template_id = #{userTemplateId}")
	int deleteByUserTemplateId(@Param(value="userTemplateId")int userTemplateId);
	
	List<AsYpScreenDomain> getDomains(Object pd);
}