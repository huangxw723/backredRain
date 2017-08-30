package com.aoshi.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import com.aoshi.domain.AsShopStaffInfo;
import com.aoshi.util.Conditions;

public interface AsShopStaffInfoMapper extends AsBaseMapper {
    int deleteByPrimaryKey(Integer shopStaffInfoId);

    int insert(AsShopStaffInfo record);

    int insertSelective(AsShopStaffInfo record);

    AsShopStaffInfo selectByPrimaryKey(Integer shopStaffInfoId);

    int updateByPrimaryKeySelective(AsShopStaffInfo record);

    int updateByPrimaryKeyWithBLOBs(AsShopStaffInfo record);

    int updateByPrimaryKey(AsShopStaffInfo record);
    
    @Select(value="select * from as_shop_staff_info where user_id = #{userId}")
	AsShopStaffInfo FindByUserId(@Param(value="userId")Integer userId);

	/**
	 * 根据userId查询记录
	 * 
	 * @author huangxw
	 * @date 2016年9月2日
	 * @param conditions
	 * @return
	 */
	Object findByUserId(Object conditions);

	/**
	 * 更新账号状态
	 * 
	 * @author huangxuwen
	 * @date 2016年9月2日
	 * @param conditions
	 * @return
	 */
	int updateStatus(Object conditions);
	
	/**
	 * 根据userId删除员工
	 * 
	 * @author huangxuwen
	 * @date 2016年9月2日
	 * @param conditions
	 * @return
	 */
	int deleteByUserId(Object conditions);

	/**
	 * 批量删除
	 * 
	 * @author yangyanchao
	 * @date 2016年9月22日
	 * @param conditions
	 * @return
	 */
	int deleteByUserIds(Object conditions);

	/**
	 * 查询店铺下所有员工
	 * 
	 * @author yangyanchao
	 * @date 2016年9月22日
	 * @param conditions
	 * @return
	 */
	List<Conditions> findByShopId(Object conditions);
	
	/**
	 * 查询所属商场管理员的所有员工包括本身账号
	 * 
	 * @author yangyanchao
	 * @date 2016年9月22日
	 * @param conditions
	 * @return
	 */
	List<Conditions> getAccountList(Object conditions);
	
	/**
	 * 根据shopId获取所属商家员工账号
	 * 
	 * @author huangxw
	 * @date 2016年9月9日
	 * @param conditions
	 * @return
	 */
	List<String> findData(Object pd);

	/**
	 * 批量删除
	 * 
	 * @author yangyanchao
	 * @date 2016年9月22日
	 * @param conditions
	 * @return
	 */
	int deleteAlls(Object conditions);
	
	/**
	 * 查询指定userId员工管理员帐号信息
	 * 
	 * @author yangyanchao
	 * @date 2016年10月28日
	 * @param conditions
	 * @return
	 */
	List<Object> getShopStaffInfoByUserIds(Object conditions);
	/**
	 * 查询指定userId员工管理员帐号信息
	 * 
	 * @author huangxw
	 * @date 2016年11月10日
	 * @param conditions
	 * @return
	 */
	Conditions findStaffInfo(Object conditions);
	/**
	 * 查询指定userId员工管理员信息
	 * 
	 * @author huangxw
	 * @date 2016年11月10日
	 * @param conditions
	 * @return
	 */
	Object getStaffInfo(Object conditions);
	
	
	/**
	 * 批量更新状态
	 * 
	 * @author huangxw
	 * @date 2017年03月03日
	 * @param conditions
	 * @return
	 */
	int updateByUserIds(Object conditions);

	List<AsShopStaffInfo> getStaffInfoByShopId(Object conditions);
	
	int updateStatusByShopId(Object conditions);
	
}