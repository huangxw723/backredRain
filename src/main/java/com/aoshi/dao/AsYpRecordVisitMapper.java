package com.aoshi.dao;

import java.util.List;

import com.aoshi.domain.AsYpRecordVisit;

public interface AsYpRecordVisitMapper extends AsBaseMapper{
    int deleteByPrimaryKey(Integer recordVisitId);

    int insert(AsYpRecordVisit record);

    int insertSelective(AsYpRecordVisit record);

    AsYpRecordVisit selectByPrimaryKey(Integer recordVisitId);

    int updateByPrimaryKeySelective(AsYpRecordVisit record);

    int updateByPrimaryKey(AsYpRecordVisit record);
    
    List<String> listRecordy(Object conditions);
    
    List<String> listRecordx(Object conditions);
    
}