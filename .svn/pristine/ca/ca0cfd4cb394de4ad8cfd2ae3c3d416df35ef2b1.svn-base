package com.aoshi.dao;

import com.aoshi.domain.AsBeaconPrize;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface AsBeaconPrizeMapper {
    int deleteByPrimaryKey(Integer beaconPrizeId);

    int insert(AsBeaconPrize record);

    int insertSelective(AsBeaconPrize record);

    AsBeaconPrize selectByPrimaryKey(Integer beaconPrizeId);

    int updateByPrimaryKeySelective(AsBeaconPrize record);

    int updateByPrimaryKey(AsBeaconPrize record);

    int deleteByBeaconLinkId(Integer beaconLinkId);

    int deleteByIds(String[] conditions);

    List<AsBeaconPrize> listByBeaconLinkId(@Param("beaconLinkId") Integer beaconLinkId);
}