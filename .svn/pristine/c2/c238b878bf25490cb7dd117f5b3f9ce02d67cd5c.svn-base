package com.aoshi.dao;

import com.aoshi.domain.AsWallet;

public interface AsWalletMapper extends AsBaseMapper {
    int deleteByPrimaryKey(Integer walletId);

    int insert(AsWallet record);

    int insertSelective(AsWallet record);

    AsWallet selectByPrimaryKey(Integer walletId);

    AsWallet findByUserId(Integer userId);

    int updateByPrimaryKeySelective(AsWallet record);

    int updateByPrimaryKey(AsWallet record);

    Object findByUserIdWithLock(Object conditions);

    Integer getIntegration(Integer userId);
}