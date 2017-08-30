package com.aoshi.dao;

import com.aoshi.domain.AsAdvertiser;

public interface AsAdvertiserMapper extends  AsBaseMapper{
    int deleteByPrimaryKey(Integer advertiserId);

    int insert(AsAdvertiser record);

    int insertSelective(AsAdvertiser record);

    AsAdvertiser selectByPrimaryKey(Integer advertiserId);

    int updateByPrimaryKeySelective(AsAdvertiser record);

    int updateByPrimaryKey(AsAdvertiser record);
}