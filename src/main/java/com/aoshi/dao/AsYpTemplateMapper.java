package com.aoshi.dao;

import java.util.List;

import org.apache.ibatis.annotations.Select;

import com.aoshi.domain.AsYpTemplate;

public interface AsYpTemplateMapper extends AsBaseMapper {
    int deleteByPrimaryKey(Integer templateId);

    int insert(AsYpTemplate record);

    int insertSelective(AsYpTemplate record);

    AsYpTemplate selectByPrimaryKey(Integer templateId);

    int updateByPrimaryKeySelective(AsYpTemplate record);

    int updateByPrimaryKey(AsYpTemplate record);
    
    @Select(value="select * from as_yp_template where status = 0 order by template_id desc")
	List<AsYpTemplate> getTemplats();

	/**
	 * 根据模板名查询
	 * 
	 * @author yangyanchao
	 * @date 2016年11月11日
	 * @param Conditions
	 * @return
	 */
	Object findByName(Object Conditions);
}