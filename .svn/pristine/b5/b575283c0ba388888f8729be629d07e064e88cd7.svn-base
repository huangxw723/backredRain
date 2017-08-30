package com.aoshi.dao;

import com.aoshi.domain.AsActivityMeeting;

public interface AsActivityMeetingMapper {
    int deleteByPrimaryKey(Integer activityMeetingId);
    
    int deleteByActivityId(Integer activityId);

    int insert(AsActivityMeeting record);

    int insertSelective(AsActivityMeeting record);

    AsActivityMeeting selectByPrimaryKey(Integer activityMeetingId);

    int updateByPrimaryKeySelective(AsActivityMeeting record);

    int updateByPrimaryKeyWithBLOBs(AsActivityMeeting record);

    int updateByPrimaryKey(AsActivityMeeting record);
    
	AsActivityMeeting selectByActivityId(int activityId);
}