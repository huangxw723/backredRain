package com.aoshi.dao;

import com.aoshi.domain.AsActivityLink;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import java.util.List;

public interface AsActivityLinkMapper {
    int deleteByPrimaryKey(Integer activityLinkId);

    int insert(AsActivityLink record);

    int insertSelective(AsActivityLink record);

    AsActivityLink selectByPrimaryKey(Integer activityLinkId);

    int updateByPrimaryKeySelective(AsActivityLink record);

    int updateByPrimaryKey(AsActivityLink record);

    //大转盘
    List<AsActivityLink> queryList(AsActivityLink record);

    //优惠券
    List<AsActivityLink> couponList(AsActivityLink record);

    int deleteByIds(String[] conditions);

    int queryByTypeAnditemId(@Param(value = "linkType") Integer linkType,@Param(value = "typeId") Integer typeId, @Param(value = "itemId")Integer itemId);
}