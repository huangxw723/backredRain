package com.aoshi.dao;

import com.aoshi.domain.AsShopOwnerInfo;
import com.aoshi.util.Conditions;

import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import java.util.List;

public interface AsShopOwnerInfoMapper extends AsBaseMapper {

	/**
	 * 查询商家列表
	 * 
	 * @author yangyanchao
	 * @date 2016年9月1日
	 * @param conditions
	 * @return
	 */
	List<Conditions> listAll(Object conditions);

	/**
	 * 更新账号状态
	 * 
	 * @author yangyanchao
	 * @date 2016年9月2日
	 * @param conditions
	 * @return
	 */
	int updateStatus(Object conditions);

	/**
	 * 根据userId删除商家
	 * 
	 * @author yangyanchao
	 * @date 2016年9月2日
	 * @param conditions
	 * @return
	 */
	int deleteByUserId(Object conditions);

	/**
	 * 根据userId查询记录
	 * 
	 * @author yangyanchao
	 * @date 2016年9月2日
	 * @param conditions
	 * @return
	 */
	Conditions findByUserId(Object conditions);

	Conditions findBySysUserId(Object conditions);

	/**
	 * 用戶是否被禁用
	 * @param conditions
	 * @return
     */
	Conditions getStatusBySysUserId(Object conditions);

	/**
	 * 判断商家是否参与活动中
	 * 
	 * @author yangyanchao
	 * @date 2016年9月9日
	 * @param conditions
	 * @return
	 */
	int isJoinActivity(Object conditions);

	List<AsShopOwnerInfo>  selectByShopId(Object conditions);

	/**
	 * 根据shopId获取所属商家管理员账号
	 * 
	 * @author huangxw
	 * @date 2016年9月9日
	 * @param conditions
	 * @return
	 */
	List<String> findData(Object conditions);
	
	/**
	 * 删除所有商家管理员
	 * 
	 * @author huangxw
	 * @date 2016年9月9日
	 * @param conditions
	 * @return
	 */
	int deleteAlls(Object conditions);

	/**
	 * 查询指定userId店铺管理员帐号信息
	 * 
	 * @author yangyanchao
	 * @date 2016年10月28日
	 * @param conditions
	 * @return
	 */
	List<Object> getShopOwnerInfoByUserIds(Object conditions);
	
	/**
	 * 根据userId获取商家管理员信息 站点信息 
	 * 
	 * @author 黄旭文
	 * @date 2016年11月10日
	 * @param conditions
	 * @return
	 */
	Conditions findOwnerInfo(Object conditions);
	/**
	 * 根据userId获取商家管理员信息 
	 * 
	 * @author 黄旭文
	 * @date 2016年11月10日	
	 * @param conditions
	 * @return
	 */
	Object getOwnerInfo(Object conditions);

	/**
	 * 获取状态为启用的商家信息
	 *
	 * @author xjl
	 * @date 2017年2月23日
	 * @return
	 */
	@Select("SELECT * FROM  as_shop_owner_info a WHERE a.status=0")
	List<AsShopOwnerInfo> queryList();

	Object getShopOwnerByUserId(@Param(value = "userId") String userId);
	
	List<Conditions> getShopOwnerListAudit(Object conditions);
	
	List<Conditions> getShopOperatListAudit(Object conditions);
	
	@Select("select * from as_shop_owner_info where shop_owner_info_id=#{shopOwnerInfoId}")
	AsShopOwnerInfo findByShopOwnerId(Integer shopOwnerInfoId);

	/**
	 * 通过shopId获取商家管理员信息
	 * @param shopId
	 * @return
     */
	@Select("SELECT * FROM  as_shop_owner_info  WHERE  shop_id = #{shopId}")
	AsShopOwnerInfo getOwnerInfoByShopId(@Param(value = "shopId") int shopId);



}