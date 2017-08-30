package com.aoshi.dao;

import com.alibaba.druid.stat.TableStat.Condition;
import com.aoshi.domain.AsYpShopArea;
import com.aoshi.util.PageData;

public interface AsYpShopAreaMapper extends AsBaseMapper{
    int deleteByPrimaryKey(Integer shopAreaId);

    int insert(AsYpShopArea record);

    int insertSelective(Object conditions);

    AsYpShopArea selectByPrimaryKey(Integer shopAreaId);

    int updateByPrimaryKeySelective(AsYpShopArea record);

    int updateByPrimaryKey(AsYpShopArea record);

	AsYpShopArea selectByShopId(PageData pd);
}