package com.aoshi.dao;

import java.util.List;

import com.aoshi.domain.AsYpScreenInfo;
import com.aoshi.util.Conditions;

public interface AsYpScreenInfoMapper extends AsBaseMapper{
    int deleteByPrimaryKey(Integer screenInfoId);

    int insert(AsYpScreenInfo record);

    int insertSelective(AsYpScreenInfo record);

    AsYpScreenInfo selectByPrimaryKey(Integer screenInfoId);

    int updateByPrimaryKeySelective(Object record);

    int updateByPrimaryKey(AsYpScreenInfo record);
    
    
    int SrceenNumCount(Object conditions);
    /**
	 * 查询所属商场管理员的所有员工包括本身的云屏信息
	 * 
	 * @author yangyanchao
	 * @date 2016年9月22日
	 * @param conditions
	 * @return
	 */
	List<Conditions> getScreenList(Object conditions);

	int operaSubmit(Object conditions);
	
	List<Conditions> listScreenAll(Object conditions);
	 /**
		 * 系统管理员审核企业云屏信息
		 * 
		 * @author huangxw
		 * @date 2016年9月22日
		 * @param conditions
		 * @return
		 */
	int updateScreenStatus(Object conditions);
	
	List<Conditions> queryScreenList(Object conditions);
	/**
	 * 统计云屏数量
	 * 
	 * @author huangxw
	 * @date 2016年11月20日
	 * @param conditions
	 * @return
	 */
	int getCountNum(Object conditions);
	/**
	 * 统计云屏数量
	 * 
	 * @author huangxw
	 * @date 2016年11月20日
	 * @param conditions
	 * @return
	 */
	int queryScreenNum(Object conditions);
}