package com.aoshi.dao;

import com.aoshi.domain.AsBeaconRelation;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface AsBeaconRelationMapper {
    int deleteByPrimaryKey(Integer beaconRelationId);

    int insert(AsBeaconRelation record);

    int insertSelective(AsBeaconRelation record);

    AsBeaconRelation selectByPrimaryKey(Integer beaconRelationId);

    int updateByPrimaryKeySelective(AsBeaconRelation record);

    int updateByPrimaryKey(AsBeaconRelation record);

    List<AsBeaconRelation> listByBeaconLinkId(@Param("beaconLinkId") Integer beaconLinkId);

    int deleteByBeaconLinkId(Integer beaconLinkId);

    int deleteByIds(String[] conditions);

    List<AsBeaconRelation> selectByBeaconId(@Param("beaconId") Integer beaconId);

    int deleteByBeaconId(Integer beaconId);

    int deleteByBeaconIds(String[] conditions);

    List<AsBeaconRelation> selectByBeaconIds(String[] conditions);
}