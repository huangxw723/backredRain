package com.aoshi.dao;

import com.aoshi.domain.AsConsultationSpots;

public interface AsConsultationSpotsMapper {
    int deleteByPrimaryKey(Integer consultationSpotsId);

    int insert(AsConsultationSpots record);

    int insertSelective(AsConsultationSpots record);

    AsConsultationSpots selectByPrimaryKey(Integer consultationSpotsId);

    int updateByPrimaryKeySelective(AsConsultationSpots record);

    int updateByPrimaryKey(AsConsultationSpots record);
}