package com.aoshi.dao;

import com.aoshi.domain.AsConsultationStreetFood;

import java.util.List;

public interface AsConsultationStreetFoodMapper {
    int deleteByPrimaryKey(Integer consultationStreetFoodId);

    int insert(AsConsultationStreetFood record);

    int insertSelective(AsConsultationStreetFood record);

    AsConsultationStreetFood selectByPrimaryKey(Integer consultationStreetFoodId);

    int updateByPrimaryKeySelective(AsConsultationStreetFood record);

    int updateByPrimaryKeyWithBLOBs(AsConsultationStreetFood record);

    int updateByPrimaryKey(AsConsultationStreetFood record);

    List<AsConsultationStreetFood> findByShopId(Integer consultationShopId);

    List<AsConsultationStreetFood> selectInId(String[] FoodId);

    int deleteByConsultationShopId(Integer consultationShopId);

    int deleteByIds(String[] conditions);
}