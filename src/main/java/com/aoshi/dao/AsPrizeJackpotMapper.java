package com.aoshi.dao;

import com.aoshi.domain.AsPrizeJackpot;

public interface AsPrizeJackpotMapper {
    int deleteByPrimaryKey(Integer prizeJackpotId);

    int insert(AsPrizeJackpot record);

    int insertSelective(AsPrizeJackpot record);

    AsPrizeJackpot selectByPrimaryKey(Integer prizeJackpotId);

    AsPrizeJackpot selectByConfigId(Integer prizeConfigId);

    int updateByPrimaryKeySelective(AsPrizeJackpot record);

    int updateByPrimaryKey(AsPrizeJackpot record);
}