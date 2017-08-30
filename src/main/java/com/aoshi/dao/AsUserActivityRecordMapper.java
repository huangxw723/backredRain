package com.aoshi.dao;

import com.aoshi.domain.AsUserActivityRecord;

public interface AsUserActivityRecordMapper {
    int deleteByPrimaryKey(Integer userActivityRecord);

    int insert(AsUserActivityRecord record);

    int insertSelective(AsUserActivityRecord record);

    AsUserActivityRecord selectByPrimaryKey(Integer userActivityRecord);

    int updateByPrimaryKeySelective(AsUserActivityRecord record);

    int updateByPrimaryKey(AsUserActivityRecord record);
}