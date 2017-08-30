package com.aoshi.dao;

import java.util.List;

import com.aoshi.domain.AsYpSysMessage;

public interface AsYpSysMessageMapper extends AsBaseMapper {

    int deleteByPrimaryKey(Integer sysMessageId);

    int insert(AsYpSysMessage record);

    int insertSelective(AsYpSysMessage record);

    AsYpSysMessage selectByPrimaryKey(Integer sysMessageId);

    int updateByPrimaryKeySelective(AsYpSysMessage record);

    int updateByPrimaryKeyWithBLOBs(AsYpSysMessage record);

    int updateByPrimaryKey(AsYpSysMessage record);

	// 未读系统消息
	int countUnreadSystemMessage(Object conditions);

	// 未读个人消息
	int countUnreadPersonalMessage(Object conditions);

	/**
	 * 获取所有未读消息
	 * 
	 * @author yangyanchao
	 * @date 2016年11月2日
	 * @param conditions
	 * @return
	 */
	List<Object> getAllUnreadMessageList(Object conditions);

	/**
	 * 获取所有消息
	 * 
	 * @author yangyanchao
	 * @date 2016年11月2日
	 * @param conditions
	 * @return
	 */
	List<Object> getAllMessageList(Object conditions);
}