package com.aoshi.dao;

import org.apache.ibatis.annotations.Select;

import com.aoshi.domain.AsBeaconUid;

public interface AsBeaconUidMapper extends AsBaseMapper{
    int deleteByPrimaryKey(Integer beaconUidId);

    int insert(AsBeaconUid record);

    int insertSelective(AsBeaconUid record);

    AsBeaconUid selectByPrimaryKey(Integer beaconUidId);

    int updateByPrimaryKeySelective(AsBeaconUid record);

    int updateByPrimaryKey(AsBeaconUid record);
    
    @Select(value="select * from as_beacon_uid")
    AsBeaconUid listAll();
    
    int deleteByIds(String[] conditions);
    
}