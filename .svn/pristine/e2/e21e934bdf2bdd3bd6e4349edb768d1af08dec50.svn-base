package com.aoshi.dao;

import com.aoshi.domain.AsEvent;
import com.aoshi.util.Conditions;

import java.util.List;

import org.apache.ibatis.annotations.Param;

public interface AsEventMapper extends AsBaseMapper {

    int deleteByPrimaryKey(Integer asEventId);

    int insert(AsEvent record);

    int insertSelective(AsEvent record);

    AsEvent selectByPrimaryKey(Integer asEventId);

    int updateByPrimaryKeySelective(AsEvent record);

    int updateByPrimaryKeyWithBLOBs(AsEvent record);

    int updateByPrimaryKey(AsEvent record);

    /**
     * 商户活动审核列表
     *
     * @param conditions
     * @return
     * @author tgb
     * @date 2017年05月25日
     */
    List<Conditions> listAudit(Object conditions);

    /**
     * 商户活动审核历史列表
     *
     * @param conditions
     * @return
     * @author tgb
     * @date 2017年05月25日
     */
    List<Conditions> listAuditHistory(Object conditions);

    /**
     * 商户活动详情
     *
     * @param asEventId
     * @return
     * @author tgb
     * @date 2017年05月25日
     */
    Conditions auditHistoryById(int asEventId);
    

	/**
	 * 商户活动列表 
	 * @author chenwz 
	 * 创建时间：2017年5月25日
	 * @version 1.0
	 * @param conditions
	 * @return
	 */
	List<Conditions> listAll(Object conditions);
	
	/**
     * 修改活动状态
     * @author chenwz
     * 创建时间：2017年5月25日
     * @param asEventId 
     * @param status 
     * @return
     */
	int updateEventStatus(@Param(value="asEventId")int asEventId, @Param(value="status")int status);
	
	/**
     * 检验活动是否重名
     * @author chenwz
     * 创建时间：2017年5月25日
     * @param asEventId 
     * @param status 
     * @return
     */
	Integer findByName(@Param(value="eventName") String eventName);

}