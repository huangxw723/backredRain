package com.aoshi.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import com.aoshi.domain.SysGroup;

public interface SysGroupMapper {
    int deleteByPrimaryKey(String groupId);

    int insert(SysGroup record);

    int insertSelective(SysGroup record);

    SysGroup selectByPrimaryKey(String groupId);

    int updateByPrimaryKeySelective(SysGroup record);

    int updateByPrimaryKey(SysGroup record);
    
    @Select(value="select * from sys_group")
	List<SysGroup> selectAll();
    
    List<SysGroup> selectByParentId(@Param(value="parentId")String parentId);

	List<SysGroup> getGroupTree(Map<String, Object> map);

	List<SysGroup> selectByAttr(SysGroup group);
}