package com.aoshi.dao;

import com.aoshi.domain.AsOwnActivityRelate;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

public interface AsOwnActivityRelateMapper extends AsBaseMapper{
    int deleteByPrimaryKey(Integer ownActivityRelateId);

    int insert(AsOwnActivityRelate record);

    int insertSelective(AsOwnActivityRelate record);

    AsOwnActivityRelate selectByPrimaryKey(Integer ownActivityRelateId);

    int updateByPrimaryKeySelective(AsOwnActivityRelate record);

    int updateByPrimaryKey(AsOwnActivityRelate record);

    @Select("select * from as_own_activity_relate where own_activity_id = #{ownActivityId} and user_id=#{userId}")
    AsOwnActivityRelate selectByOwnActivityId(@Param(value = "ownActivityId") Integer ownActivityId, @Param(value = "userId")Integer userId);

}