package com.aoshi.dao;

import java.util.List;
import java.util.Map;

import com.aoshi.domain.AsActivity;
import com.aoshi.util.Conditions;

import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

public interface AsActivityMapper extends AsBaseMapper {
	int deleteByPrimaryKey(Integer activityId);

	int insert(AsActivity record);

	int insertSelective(AsActivity record);

	AsActivity selectByPrimaryKey(Integer activityId);

	int updateByPrimaryKeySelective(AsActivity record);

	int updateByPrimaryKey(AsActivity record);

	String isAccountExists(Object putData);

	int getMaxActivityCode();
	
	/**
	 * 获取明星见面会活动列表
	 *
	 * @author tgb 创建时间：2017年3月5日
	 * @version 1.0
	 * @param conditions
	 * @return
	 */
	List<Conditions> meetingListAll(Object conditions);


	/**
	 * 获取当前进行中的红包雨活动
	 * 
	 * @author yangyanchao
	 * @date 2017-03-06
	 * @param conditions
	 * @return
	 */
	@Select("select * from as_activity where activity_type = 1  and now() <= end_time")
	List<AsActivity> getCurrentActivity(Object conditions);

	/**
	 * 获取广告选择的红包雨活动
	 *
	 * @author tgb
	 * @date 2017-03-06
	 * @param
	 * @return
	 */
	@Select("select * from as_activity where activity_id = #{activityId}")
	List<AsActivity> getAsActivity(Integer activityId);

	/**
	 * 异步检查是否重名
	 *
	 * @author tgb 创建时间：2017年3月6日
	 * @version 1.0
	 * @param name
	 *            活动名称
	 * @param type
	 *            活动类型 1 红包雨，2明星见面会
	 * @return
	 */
	Integer findByName(@Param(value = "activityName") String activityName,
			@Param(value = "activityType") int activityType);

	/**
	* @Title: deleteByActivityId
	* @Description: TODO
	* @param @param activity
	* @param @return   
	* @return int
	* @throws
	*/
	int deleteByActivityId(AsActivity activity);
}