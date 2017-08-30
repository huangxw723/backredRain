package com.aoshi.dao;

import com.aoshi.domain.AsConsultationBanner;

public interface AsConsultationBannerMapper {
    int deleteByPrimaryKey(Integer consultationBannerId);

    int insert(AsConsultationBanner record);

    int insertSelective(AsConsultationBanner record);

    AsConsultationBanner selectByPrimaryKey(Integer consultationBannerId);

    int updateByPrimaryKeySelective(AsConsultationBanner record);

    int updateByPrimaryKey(AsConsultationBanner record);
}