package com.aoshi.dao;

import java.util.List;

import com.aoshi.domain.AsOrderAction;
import com.aoshi.util.PageData;

public interface AsOrderActionMapper {
    int deleteByPrimaryKey(Integer orderActionId);

    int insert(AsOrderAction record);

    int insertSelective(AsOrderAction record);

    AsOrderAction selectByPrimaryKey(Integer orderActionId);

    int updateByPrimaryKeySelective(AsOrderAction record);

    int updateByPrimaryKey(AsOrderAction record);
    
    List<AsOrderAction> selectByAttr(PageData pd);
}