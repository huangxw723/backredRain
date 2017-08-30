package com.aoshi.dao;

import com.aoshi.domain.AsUserPoint;
import com.aoshi.util.Conditions;

import java.util.List;

public interface AsUserPointMapper extends AsBaseMapper {
    int deleteByPrimaryKey(Integer userPointId);

    int insert(AsUserPoint record);

    int insertSelective(AsUserPoint record);

    AsUserPoint selectByPrimaryKey(Integer userPointId);

    int updateByPrimaryKeySelective(AsUserPoint record);

    int updateByPrimaryKey(AsUserPoint record);

    /**
     * 积分兑换记录
     * @param conditions
     * @return
     */
    List<Conditions> getExchangeRecordList(Object conditions);


}