package com.aoshi.dao;

import com.aoshi.domain.AsUserAccount;

public interface AsUserAccountMapper {
    int deleteByPrimaryKey(Integer userAccountId);

    int insert(AsUserAccount record);

    int insertSelective(AsUserAccount record);

    AsUserAccount selectByPrimaryKey(Integer userAccountId);

    int updateByPrimaryKeySelective(AsUserAccount record);

    int updateByPrimaryKey(AsUserAccount record);
}