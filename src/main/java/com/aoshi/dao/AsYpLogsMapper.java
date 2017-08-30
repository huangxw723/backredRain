package com.aoshi.dao;

import com.aoshi.domain.AsYpLogs;

public interface AsYpLogsMapper {
    int deleteByPrimaryKey(Integer logsId);

    int insert(AsYpLogs record);

    int insertSelective(AsYpLogs record);

    AsYpLogs selectByPrimaryKey(Integer logsId);

    int updateByPrimaryKeySelective(AsYpLogs record);

    int updateByPrimaryKey(AsYpLogs record);
}