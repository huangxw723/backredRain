package com.aoshi.dao;

import java.util.List;

import org.apache.ibatis.annotations.Select;

import com.aoshi.domain.AsImageSource;

public interface AsImageSourceMapper {
    int deleteByPrimaryKey(Integer imageSourceId);

    int insert(AsImageSource record);

    int insertSelective(AsImageSource record);

    AsImageSource selectByPrimaryKey(Integer imageSourceId);

    int updateByPrimaryKeySelective(AsImageSource record);

    int updateByPrimaryKey(AsImageSource record);
    
    @Select(value="select * from as_image_source")
	List<AsImageSource> selectAll();

	List<AsImageSource> selectByAttr(AsImageSource asImageSource);
}