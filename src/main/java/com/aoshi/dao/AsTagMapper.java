package com.aoshi.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import com.aoshi.domain.AsTag;

public interface AsTagMapper {
    int deleteByPrimaryKey(Integer tagId);

    int insert(AsTag record);

    int insertSelective(AsTag record);

    AsTag selectByPrimaryKey(Integer tagId);

    int updateByPrimaryKeySelective(AsTag record);

    int updateByPrimaryKey(AsTag record);
    
    List<AsTag> queryList(AsTag asTag);
    
    @Select(value="select * from as_tag where name = #{name} and type=#{type} limit 1")
	AsTag findByName(@Param(value="name")String name,@Param(value="type")int type);

}