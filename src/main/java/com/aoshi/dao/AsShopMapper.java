package com.aoshi.dao;

import com.aoshi.domain.AsShop;
import com.aoshi.domain.AsStore;
import com.aoshi.util.Conditions;
import com.aoshi.util.PageData;

import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import java.util.List;
import java.util.Map;

public interface AsShopMapper extends AsBaseMapper {
	
	/**
	 * 查找商户
	 *
	 * @author tgb 创建时间：2016年11月5日
	 * @version 1.0
	 * @param shopId
	 * @return
	 */
	AsShop findByShopId(String shopId);

	/**
	 * 查找澳视商户ascmMallManager
	 *
	 * @author tgb 创建时间：2017年4月5日
	 * @version 1.0
	 * @return
	 */
	AsShop findByShopName();

	/**
	 * 获取商铺的所有信息
	 *
	 * @author tgb 创建时间：2016年11月7日
	 * @version 1.0
	 * @param shopId
	 * @return
	 */
	AsShop selectByPrimaryKey(String shopId);

	/**
	 * 正常商家列表(未删除,未禁用)
	 * 
	 * @author yangyanchao
	 * @date 2016年9月26日
	 * @param conditions
	 * @return
	 */
	List<Object> listAllForOption(Object conditions);
	
	/**
	 * 查询企业列表(云屏)
	 * 
	 * @author huangxw
	 * @date 2016年9月26日
	 * @param conditions
	 * @return
	 */
	List<Object> queryShopList(Object conditions);

	int isAccountExists(Object conditions);
	
	int isMerchantAccountExists(Object conditions);
	
	List<Conditions> listAllYp(Object conditions);
	/**
	 * 
	 * 统计企业当前账号数量
	 * @author huangxw
	 * @date 2016年9月26日
	 * @param conditions
	 * @return
	 */
	int countShopNum(Object conditions);

	/**
	 * 
	 * 查询企业云屏站点
	 * @author huangxw
	 * @date 2016年9月26日
	 * @param conditions
	 * @return
	 */
	Object getShopSiteUrl(int parseInt);
	
	/**
	 * 
	 * 查询可增加商场管理员企业列表
	 * @author huangxw
	 * @date 2016年9月26日
	 * @param conditions
	 * @return
	 */
	List<Conditions> listShopAll(Object conditions);
	
	
	
	List<Conditions> getShopALL(Object conditions);
	
	/**
	 * 
	 * 查询云屏总安装数
	 * @author huangxw
	 * @date 2016年9月26日
	 * @param conditions
	 * @return
	 */
	int getScreenNum(Object conditions);
	

	/**
	 * 获取所有商铺 只获取字段shopId name storeId
	 *
	 * @author tgb 创建时间：2016年11月7日
	 * @version 1.0
	 * @return
	 */
	List<Conditions> findByShopAll();
	
	
	/**
	 * 获取所有商铺信息根据shopId
	 *
	 * @author hxw 创建时间：2016年11月7日
	 * @version 1.0
	 * @return
	 */
	Object getShop(Object conditions);
	
	/**
	 * 删除分类时，检查是否有关联的行业！
	 * 
	 * @author tgb 创建时间：2016年11月16日
	 * @version 1.0
	 * @param pd
	 * @return
	 */
	int findByCategoryId(int categoryId);
	
	/**
	 * 删除商家时，检查该商家是否有优惠券
	 * 
	 * @author huangxw 创建时间：2016年11月28日
	 * @version 1.0
	 * @param categoryId
	 * @return
	 */
	int isCouponExists(Object pd);
	
	
	/**
	 * 删除商家时，检查该商家是否有礼品券
	 * 
	 * @author huangxw 创建时间：2016年11月28日
	 * @version 1.0
	 * @param categoryId
	 * @return
	 */
	int isPrizeExists(Object pd);
	
	List<AsShop> selectAll(PageData pd);
	
	List<AsShop> findShops(PageData pd);
	
	AsShop getShopInfo(Integer shopId);

	/*
	   获取商户
	* 用于beacon管理*/
	@Select("SELECT * FROM as_shop WHERE type=2 ")
	List<AsShop> queryList();
	
	/**
	 * 查找所有未合作商户
	 *@author tgb
	 *创建时间：2017年3月8日
	 *@version 1.0
	 * @param obj
	 * @return
	 */
	List<AsShop> selectByNoAddCooperation(Object obj);

    /**
     * E街E铺-3期 , 更新旧数据type为1
     * @author yangyanchao
     * @date 2017-03-10
     * @return
     */
    @Update("update as_shop set type = 2 where type is null")
	int updateShopByScriptV3();
    
    /**
	 * 
	 * 查询可增加商户
	 * @author huangxw
	 * @date 2017年4月18日
	 * @param conditions
	 * @return
	 */
	List<AsShop> listShopAllInfo(Object conditions);
	
	Object findShopInfoByShopId(Integer shopId);

	/**
	 * 修改商场后更新商户是商场的信息
	 * @param data
	 * @return
     */
	int updateShopByStoreId(Map<String, Object> data);

	/**
	 *修改商场后更新商家管理员信息的账号名称
	 * @param data
	 * @return
	 */
	int updateShopOwnerInfoByStoreId(Map<String, Object> data);

	 /**
     * E街E铺-3期 , 更新旧数据type为1
     * @author yangyanchao
     * @date 2017-03-10
     * @return
     */
    AsShop shopIdByuserId(@Param(value="userId")Integer userId);
}
