package com.aoshi.dao;

import com.aoshi.domain.AsConsultationShop;

import java.util.List;

public interface AsConsultationShopMapper {
    int deleteByPrimaryKey(Integer consultationShopId);

    int insert(AsConsultationShop record);

    int insertSelective(AsConsultationShop record);

    AsConsultationShop selectByPrimaryKey(Integer consultationShopId);

    int updateByPrimaryKeySelective(AsConsultationShop record);

    int updateByPrimaryKey(AsConsultationShop record);

    List<AsConsultationShop> queryList(AsConsultationShop record);

    int deleteByIds(String[] conditions);

    int offSaleAll(String[] conditions);

    AsConsultationShop selectById(Integer consultationShopId);

}