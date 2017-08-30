package com.aoshi.dao;

import com.aoshi.domain.AsActivityAd;
import com.aoshi.util.Conditions;
import com.aoshi.util.PageData;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

public interface AsActivityAdMapper extends AsBaseMapper {
    int deleteByPrimaryKey(Integer adId);

    int insert(AsActivityAd record);

    int insertSelective(AsActivityAd record);

    AsActivityAd selectByPrimaryKey(Integer adId);

    int updateByPrimaryKeySelective(AsActivityAd record);

    int updateByPrimaryKey(AsActivityAd record);

    int updateStatus(Object conditions);

    AsActivityAd getActivity(PageData pd);

    /**
     * 根据id获取广告详情
     *
     * @author haungxw
     * @date 2016年9月2日
     */
    AsActivityAd getActivityAdDataInfo(PageData pd);

    List<Conditions> listAll(Object conditions);

    int getPointActivityCount(@Param("adPosType") Integer adPosType);

    /**
     * 获取指定类型中最大结束时间
     * adPosType 广告板块类型 4弹窗 5悬浮
     *
     * @return
     */
    String getMaxEndTime(@Param("adPosType") Integer adPosType);

    /**
     * 判断悬浮弹窗广告是否已经存在
     *
     * @param adPosType
     * @param refId
     * @return
     */
    int getAdPosTypeRefId(@Param("adPosType") Integer adPosType, @Param("refId") Integer refId);

    /**
     * 更新广告时间
     *
     * @param map
     * @return
     */
    int updateTimeByRefId(Map<String, Object> map);

    /**
     * @param adPosType 6 或 7  广告板块类型
     * @return
     * @description: 通过广告板块类型 判断大转盘-logo和大转盘-首页广告只能有一条
     * @author: tgb
     * @date: 2017-08-07 17:19
     */
    int getAdPosType(@Param("adPosType") Integer adPosType);

}