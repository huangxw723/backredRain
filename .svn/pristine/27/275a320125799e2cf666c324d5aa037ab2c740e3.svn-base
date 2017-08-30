package com.aoshi.dao;

import com.aoshi.domain.AsConsultationNavigation;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import java.util.List;

public interface AsConsultationNavigationMapper {
    int deleteByPrimaryKey(Integer asConsultationNavigationId);

    int insert(AsConsultationNavigation record);

    int insertSelective(AsConsultationNavigation record);

    AsConsultationNavigation selectByPrimaryKey(Integer asConsultationNavigationId);

    int updateByPrimaryKeySelective(AsConsultationNavigation record);

    int updateByPrimaryKey(AsConsultationNavigation record);

    List<AsConsultationNavigation> selectAllStore();

    List<AsConsultationNavigation> selectAllShop();

    @Select("select * from as_consultation_navigation where as_consultation_navigation_id =#{id}")
    AsConsultationNavigation selectById(@Param("id") Integer id);
}