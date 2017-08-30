package com.aoshi.dao;

import com.aoshi.domain.AsOwnActivityHistory;


public interface AsOwnActivityHistoryMapper extends AsBaseMapper {
    int deleteByPrimaryKey(Integer ownActivityHistoryId);

    int insert(AsOwnActivityHistory record);

    int insertSelective(AsOwnActivityHistory record);

    AsOwnActivityHistory selectByPrimaryKey(Integer ownActivityHistoryId);

    int updateByPrimaryKeySelective(AsOwnActivityHistory record);

    int updateByPrimaryKey(AsOwnActivityHistory record);

}