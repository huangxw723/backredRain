package com.aoshi.dao;

import com.aoshi.domain.AsDifferIndustry;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface AsDifferIndustryMapper {
    int deleteByPrimaryKey(Integer differIndustryId);

    int insert(AsDifferIndustry record);

    int insertSelective(AsDifferIndustry record);

    AsDifferIndustry selectByPrimaryKey(Integer differIndustryId);

    int updateByPrimaryKeySelective(AsDifferIndustry record);

    int updateByPrimaryKey(AsDifferIndustry record);

    List<AsDifferIndustry> getDifferIndustryListByShopId(String shopId);

    int deleteByShopIdAndCategoryId(@Param("shopId") int shopId, @Param("categoryId") int categoryId);

}