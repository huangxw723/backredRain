package com.aoshi.dao;

import com.aoshi.domain.AsUserAddress;

import java.util.List;

public interface AsUserAddressMapper extends AsBaseMapper {
    int deleteByPrimaryKey(Integer userAddressId);

    int insert(AsUserAddress record);

    int insertSelective(AsUserAddress record);

    AsUserAddress selectByPrimaryKey(Integer userAddressId);

    int updateByPrimaryKeySelective(AsUserAddress record);

    int updateByPrimaryKey(AsUserAddress record);

    List<AsUserAddress> getAddressListByUserId(int userId);
}