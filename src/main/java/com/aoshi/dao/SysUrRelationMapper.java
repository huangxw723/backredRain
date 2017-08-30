package com.aoshi.dao;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import com.aoshi.domain.SysUrRelation;

public interface SysUrRelationMapper {
    int deleteByPrimaryKey(String umId);

    int insert(SysUrRelation record);

    int insertSelective(SysUrRelation record);

    SysUrRelation selectByPrimaryKey(String umId);

    int updateByPrimaryKeySelective(SysUrRelation record);

    int updateByPrimaryKey(SysUrRelation record);
    @Select(value="select * from sys_ur_relation where USER_ID = #{userId}")
	List<SysUrRelation> selectByUserId(@Param(value="userId")String userId);
    
    @Delete(value="delete from sys_ur_relation where USER_ID = #{userId}")
	int deleteByUserId(String userId);
}