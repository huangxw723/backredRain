package com.aoshi.dao;

import com.aoshi.domain.AsCapital;
import com.aoshi.util.Conditions;

import java.util.List;

public interface AsCapitalMapper extends AsBaseMapper {
    /**
     * 根据id查询当前记录
     *
     * @param conditions
     * @return
     * @author huangxuwen
     * @date 2016年9月20日
     */
    Conditions getCapital(Object conditions);

    /**
     * 查会员提现记录列表
     *
     * @param conditions
     * @return
     */
    List<Conditions> listAllMemberCapitals(Object conditions);

    /**
     * 获取用户指定状态提现记录
     *
     * @param conditions
     * @return
     * @author yangyanchao
     * @date 2017-02-28
     */
    List<AsCapital> getCapitalByStatusWithScheduler(Object conditions);

    /**
     * 在定时任务中更新申请
     *
     * @param conditions
     * @return
     * @author yangyanchao
     * @date 2017-02-28
     */
    int updateStatusWithScheduler(Object conditions);

    /**
     * 统计用户当天提现次数
     * @author yangyanchao
     * @date 2017-02-23
     * @param conditions where条件
     * @return
     */
    int countCapitalByDay(Object conditions);
}