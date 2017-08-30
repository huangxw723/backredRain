package com.aoshi.dao;

import java.util.List;

import com.aoshi.domain.AsUserInfo;
import com.aoshi.util.PageData;

public interface AsUserInfoMapper {
    int deleteByPrimaryKey(Integer userInfoId);

    int insert(AsUserInfo record);

    int insertSelective(AsUserInfo record);

    AsUserInfo selectByPrimaryKey(Integer userInfoId);

    int updateByPrimaryKeySelective(Object record);

    int updateByPrimaryKey(AsUserInfo record);

	/**
	* @Title: getUserInfoList
	* @Description: TODO
	* @param @param pd
	* @param @return   
	* @return List<SysUser>
	* @throws
	*/
    AsUserInfo getUserInfoList(PageData pd);
    
   /**
	 * @Title: queryUserInfo
	 * @Description: 获取会员信息列表
	 * @param    
	 * @return void
	 * @throws
	 */
    List<AsUserInfo> queryUserInfo(AsUserInfo record);
}