package com.aoshi.dao;

import com.aoshi.domain.AsConsultationShopping;

public interface AsConsultationShoppingMapper {
    int deleteByPrimaryKey(Integer consultationShoppingId);

    int insert(AsConsultationShopping record);

    int insertSelective(AsConsultationShopping record);

    AsConsultationShopping selectByPrimaryKey(Integer consultationShoppingId);

    int updateByPrimaryKeySelective(AsConsultationShopping record);

    int updateByPrimaryKey(AsConsultationShopping record);
}