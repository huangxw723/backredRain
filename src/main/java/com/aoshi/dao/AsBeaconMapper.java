package com.aoshi.dao;

import java.util.List;

import com.aoshi.util.Conditions;
import org.apache.ibatis.annotations.Select;

import com.aoshi.controller.manage.consultation.streetFood.streetFoodController;
import com.aoshi.domain.AsBeacon;
import com.aoshi.util.PageData;

public interface AsBeaconMapper extends AsBaseMapper{
    int deleteByPrimaryKey(Integer beaconId);

    int insert(AsBeacon record);

    int insertSelective(AsBeacon record);

    AsBeacon selectByPrimaryKey(Integer beaconId);

    int updateByPrimaryKeySelective(AsBeacon record);

    int updateByPrimaryKey(AsBeacon record);
    List<Conditions> queryList(AsBeacon record);

    Conditions queryById(Integer beaconId);

    int deleteByIds(String[] conditions);

    @Select("select * from as_beacon order by beacon_id desc limit 0,1 ")
    AsBeacon selectLastOne();
    
    @Select("select * from as_beacon")
    List<AsBeacon> selectAll();
    
    List<AsBeacon> findByIds(String[] conStrings);
    
    int saveInfo(PageData pd);
    
    @Select("select * from as_beacon where beacon_name=#{beaconName}")
    AsBeacon selectBybeaconName(String beaconName);
}