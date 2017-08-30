package com.aoshi.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import com.aoshi.domain.AsPopularTags;

public interface AsPopularTagsMapper extends AsBaseMapper {
    int deleteByPrimaryKey(Integer popularTagsId);

    int insert(AsPopularTags record);

    int insertSelective(AsPopularTags record);

    AsPopularTags selectByPrimaryKey(Integer popularTagsId);

    int updateByPrimaryKeySelective(AsPopularTags record);

    int updateByPrimaryKey(AsPopularTags record);
    
    @Select("select * from as_popular_tags where tags_type=#{tagsType}")
    List<AsPopularTags> selectAllByType(@Param(value="tagsType") Integer tagsType);
}