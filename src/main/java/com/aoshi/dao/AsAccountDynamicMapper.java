package com.aoshi.dao;

import com.aoshi.domain.AsAccountDynamic;

public interface AsAccountDynamicMapper {
    int deleteByPrimaryKey(Integer accountDynamicId);

    int insert(AsAccountDynamic record);

    int insertSelective(AsAccountDynamic record);

    AsAccountDynamic selectByPrimaryKey(Integer accountDynamicId);

    int updateByPrimaryKeySelective(AsAccountDynamic record);

    int updateByPrimaryKeyWithBLOBs(AsAccountDynamic record);

    int updateByPrimaryKey(AsAccountDynamic record);
}