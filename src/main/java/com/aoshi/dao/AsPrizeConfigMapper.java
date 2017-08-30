package com.aoshi.dao;

import com.aoshi.domain.AsPrizeConfig;
import com.aoshi.util.Conditions;

import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.ResultMap;
import org.apache.ibatis.annotations.Select;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.List;
import java.util.Map;

public interface AsPrizeConfigMapper extends AsBaseMapper {
    int deleteByPrimaryKey(Integer prizeConfigId);

    int insert(AsPrizeConfig record);

    int insertSelective(AsPrizeConfig record);

    AsPrizeConfig selectByPrimaryKey(Integer prizeConfigId);

    int updateByPrimaryKeySelective(AsPrizeConfig record);

    int updateByPrimaryKeyWithBLOBs(AsPrizeConfig record);

    int updateByPrimaryKey(AsPrizeConfig record);

	int updateStatus(Object conditions);

	/**
	 * 获取优惠券的信息
	 *
	 * @author tgb 创建时间：2016年11月7日
	 * @version 1.0
	 * @param prizeConfigId
	 * @return
	 */
	Object findByIdWithCoupons(Integer prizeConfigId);

    /**
     * 修改礼品状态
     *@author tgb
     *创建时间：2016年11月7日 
     *@version 1.0
     * @param prizeConfigId 礼品id
     * @param status 修改状态
     * @return
     */
	int updatePrizeStatus(@Param(value="prizeConfigId")int prizeConfigId, @Param(value="status")int status);

	/**
	 * 转盘礼品列表
	 *
	 * @author tgb 创建时间：2016年11月7日
	 * @version 1.0
	 * @param conditions
	 * @return
	 */
	List<Conditions> listAll(Object conditions);

	/**
	 * 礼品历史记录列表
	 *
	 * @author tgb 创建时间：2016年11月7日
	 * @version 1.0
	 * @param conditions
	 * @return
	 */
	List<Conditions> listHistory(Object conditions);

	/**
	 * 摇奖礼品列表
	 *
	 * @author tgb 创建时间：2017年2月23日
	 * @version 1.0
	 * @param conditions
	 * @return
	 */
	List<Conditions> shakeListAll(Object conditions);

	/**
	 * 摇奖礼品历史记录
	 *
	 * @author tgb 创建时间：2017年2月23日
	 * @version 1.0
	 * @param conditions
	 * @return
	 */
	List<Conditions> shakeListHistory(Object conditions);

	/**
	 * 优惠券列表
	 *
	 * @author tgb 创建时间：2016年11月7日
	 * @version 1.0
	 * @param conditions
	 * @return
	 */
	List<Conditions> couponsListAll(Object conditions);

	/**
	 * 优惠券历史记录表
	 *
	 * @author tgb 创建时间：2016年11月7日
	 * @version 1.0
	 * @param conditions
	 * @return
	 */
	List<Conditions> couponsListHistory(Object conditions);



	/**
	 * 统计该商铺商品数量
	 * 
	 * @author yangyanchao
	 * @date 2016年9月9日
	 * @param conditions
	 * @return
	 */
	int countShopPrize(Object conditions);

	/**
	 * 审核列表
	 * 
	 * @author chenwenzhu
	 * @date 2016年10月25日
	 * @param conditions
	 * @return
	 */
	List<Conditions> listAudit(Object conditions);
	
	/**
	 * 根据id获取信息
	 * 
	 * @author chenwenzhu
	 * @date 2016年10月25日
	 * @param conditions
	 * @return
	 */
	 Conditions getPrize(Object conditions);
	
		
	/**
	 * 审核历史信息
	 * 
	 * @author chenwenzhu
	 * @date 2016年10月25日
	 * @param conditions
	 * @return
	 */
	  List<Conditions> listAuditHistory(Object conditions);

	/**
	 * 统计活动信息
	 *
	 * @author tgb 创建时间：2016年11月7日
	 * @version 1.0
	 * @param shopId 商铺id
	 * @param month 当前月份
	 * @return
	 */
	List<Map<String, Object>> info(@Param(value = "shopId") String shopId,
			@Param(value = "month") int month);
	/**
	 * 检查是否重名
	 *@author tgb
	 *创建时间：2016年11月7日 
	 *@version 1.0
	 * @param name 需要检查
	 * @param shopId 商铺id
	 * @param type	活动类型
	 * @return
	 */
	Integer findByName(@Param(value = "name") String name,
			@Param(value = "shopId") Integer shopId,
			@Param(value = "type") Integer type);

	/**
	 * 删除分类时，检查是否有关联的礼品！
	 * 
	 * @author tgb 创建时间：2016年11月16日
	 * @version 1.0
	 * @param categoryId
	 * @return
	 */
	int findByCategoryId(int categoryId);
	
	
	/**
	 * 查看历史详情
	 * 
	 * @author wangjs
	 * @date 2017年07月21日
	 * @return
	 */
	
	Conditions listAuditHistoryByCfgId(Integer prizeConfigId);


	/**
	 * 获取摇一摇礼品（用于beacon管理）
	 *
	 * @return
	 * @author xjl
	 * @date 2017年2月20日
	 */
	List<AsPrizeConfig> queryList(AsPrizeConfig asPrizeConfig);
	
	/**
	 * beacon组列表查看已选择的礼品
	 * @param prizeConfigId
	 * @return
	 */	
	AsPrizeConfig queryById(Integer prizeConfigId);
	
	/**
	 * 删除检查概率是否存在的礼品
	 * @param shakeId
	 * @return
	 */
	@Select("select count(*) from as_prize_config where activity_type=2 and status in(1,2) and activity_shake_id=#{shakeId}")
	int fingByShakeId(@Param("shakeId")Integer shakeId);
}