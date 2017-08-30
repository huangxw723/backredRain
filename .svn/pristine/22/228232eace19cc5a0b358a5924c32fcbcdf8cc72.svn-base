package com.aoshi.dao;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import com.aoshi.domain.SysGrRelation;

public interface SysGrRelationMapper {
    int deleteByPrimaryKey(String gmId);

    int insert(SysGrRelation record);

    int insertSelective(SysGrRelation record);

    SysGrRelation selectByPrimaryKey(String gmId);

    int updateByPrimaryKeySelective(SysGrRelation record);

    int updateByPrimaryKey(SysGrRelation record);
    
    @Delete(value="delete from sys_gr_relation where GROUP_ID = #{groupId}")
	int deleteByGroupId(@Param(value="groupId")String groupId);
    
    @Select(value="select * from sys_gr_relation where GROUP_ID = #{groupId}")
	List<SysGrRelation> getGrRelationByGroupId(@Param(value="groupId")String groupId);
}