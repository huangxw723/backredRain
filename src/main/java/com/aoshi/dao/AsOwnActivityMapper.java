package com.aoshi.dao;

import com.aoshi.domain.AsOwnActivity;
import com.aoshi.domain.AsPrizeConfig;
import com.aoshi.util.Conditions;

import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import java.util.List;
import java.util.Map;

public interface AsOwnActivityMapper extends AsBaseMapper {
    int insert(AsOwnActivity record);

    int insertSelective(AsOwnActivity record);

    AsOwnActivity selectByPrimaryKey(Integer ownActivityId);

    int updateByPrimaryKeySelective(AsOwnActivity record);

    int updateByPrimaryKey(AsOwnActivity record);

    AsPrizeConfig queryGift(Integer activityId);

    void save(AsOwnActivity asOwnActivity);

    List<AsOwnActivity> queryAll(Map<String, Object> map);

    int delete(Integer ownActivityId);

    AsOwnActivity queryById(Integer ownActivityId);

    List<AsOwnActivity> queryOwnActivityLinkList(Map<String, Object> map);

    List<AsOwnActivity> queryStatus(Integer prizeConfigId);

    @Select("SELECT ROLE_NAME FROM sys_role WHERE ROLE_ID = #{role_ID}")
    String queryRole(String role_ID);

    /**
     * 获取活动中最大结束时间
     *
     * @return
     */
    String isAccountExists(@Param("ownActivityId") Integer ownActivityId,@Param("shopId") int shopId);


    /**
     * 判断是否有活动正在进行中
     *
     * @return
     */
    Integer isProceed(@Param("shopId") int shopId);

    /**
     * 自主活动审核列表
     *
     * @param conditions
     * @return
     * @author tgb
     * 创建时间：2017年3月7日
     * @version 1.0
     */
    List<Conditions> listAudit(Object conditions);

    /**
     * 自主活动审核历史列表
     *
     * @param conditions
     * @return
     * @author tgb
     * 创建时间：2017年3月7日
     * @version 1.0
     */
    List<Conditions> listAuditHistory(Object conditions);

}