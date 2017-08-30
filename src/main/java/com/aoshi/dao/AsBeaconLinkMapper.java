package com.aoshi.dao;

import com.aoshi.domain.AsBeaconLink;
import org.apache.ibatis.annotations.Select;

import java.util.List;

public interface AsBeaconLinkMapper {
    int deleteByPrimaryKey(Integer beaconLinkId);

    int insert(AsBeaconLink record);

    int insertSelective(AsBeaconLink record);

    AsBeaconLink selectByPrimaryKey(Integer beaconLinkId);

    int updateByPrimaryKeySelective(AsBeaconLink record);

    int updateByPrimaryKeyWithBLOBs(AsBeaconLink record);

    int updateByPrimaryKey(AsBeaconLink record);

    List<AsBeaconLink> queryList(AsBeaconLink record);

    int deleteByIds(String[] conditions);

    @Select("select * from as_beacon_link order by beacon_uid desc limit 0,1")
    AsBeaconLink selectOne();

}