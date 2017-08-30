package com.aoshi.dao;

import com.aoshi.domain.AsPrize;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.ResultMap;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import java.util.List;
import java.util.Map;

public interface AsPrizeMapper extends AsBaseMapper {
    int deleteByPrimaryKey(Integer prizeId);

    int insert(AsPrize record);

    int insertSelective(AsPrize record);

    AsPrize selectByPrimaryKey(Integer prizeId);

    int updateByPrimaryKeySelective(AsPrize record);

    int updateByPrimaryKeyWithBLOBs(AsPrize record);

    int updateByPrimaryKey(AsPrize record);

    AsPrize findBySn(@Param(value = "sn") String sn, @Param(value = "activityType") Integer activityType);

    @Select(value = "select * from as_prize where activity_type=1 and status=0 and shop_id=#{shopId}")
    List<AsPrize> selectByPrimaryshopId(@Param(value = "shopId") Integer shopId);

    @Select(value = "select * from as_prize where sn=#{no}")
    AsPrize selectBySn(@Param(value = "no") String no);

    AsPrize getPrizeInfo(Integer prizeId);

    @Update("update as_prize set status = 1 where prize_id = #{prizeId} and status = 0")
    int updateUsePrize(@Param(value = "prizeId") Integer prizeId);


    /**
     * 删除分类时，检查是否有关联的物品！
     *
     * @param categoryId
     * @return
     * @author tgb 创建时间：2016年11月16日
     * @version 1.0
     */
    int findByCategoryId(int categoryId);

    /**
     * @param activityType 抽奖类型： 1 抽奖  2 摇奖 3 优惠劵 4 自主活动抽奖
     * @return
     * @author tgb 创建时间：2017年2月23日
     * @version 1.0
     */
    List<AsPrize> getExchangeCountList(int activityType);

    @Select("select p.prize_name,p.start_time,p.end_time,p.prize_descp,p.logo,p.price,config.sn,config.start_time,config.end_time,config.counts,config.surplus_counts,category.name from as_prize p left join as_prize_config config on p.prize_config_id=config.prize_config_id  left join as_yp_base_category category on p.category_id=category.id where  p.prize_id=#{prizeId}")
    @ResultMap("BaseRowMap")
    Object getPrizeDetailById(@Param(value = "prizeId") Integer prizeId);

    /**
     * 修改礼品后更新物品表时间
     *
     * @param map
     * @return
     */
    int updateTimeByConfigId(Map<String, Object> map);


}