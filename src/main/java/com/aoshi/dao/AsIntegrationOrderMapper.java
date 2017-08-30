package com.aoshi.dao;

import com.aoshi.domain.AsIntegrationOrder;

public interface AsIntegrationOrderMapper {
    int deleteByPrimaryKey(Integer integrationOrderId);

    int insert(AsIntegrationOrder record);

    int insertSelective(AsIntegrationOrder record);

    AsIntegrationOrder selectByPrimaryKey(Integer integrationOrderId);

    int updateByPrimaryKeySelective(AsIntegrationOrder record);

    int updateByPrimaryKey(AsIntegrationOrder record);
}