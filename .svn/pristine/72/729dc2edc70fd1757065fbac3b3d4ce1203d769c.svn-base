package com.aoshi.dao;

import com.aoshi.domain.AsGoods;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import java.util.List;
import java.util.Map;

public interface AsGoodsMapper<T> {
    int deleteByPrimaryKey(Integer goodsId);

    int insert(T record);

    int insertSelective(T record);

    AsGoods selectByPrimaryKey(Integer goodsId);

    int updateByPrimaryKeySelective(T record);

    int updateByPrimaryKeyWithBLOBs(T record);

    int updateByPrimaryKey(T record);

	/**
	 * 根据条件获取商品列表
	 *
	 * @author tgb 创建时间：2016年12月7日
	 * @version 1.0
	 * @param params
	 * @return
	 */
	List<T> getGoodsList(Map<String, Object> params);

	/**
	 * 批量修改商品的状态为1 (删除为1，未删 0)
	 *
	 * @author tgb 创建时间：2016年12月7日
	 * @version 1.0
	 * @param ids
	 * @return
	 */
	int deleteGoodsAlls(int[] ids);

	/**
	 * 检查商品名称是否重复
	 *
	 * @author tgb 创建时间：2016年12月7日
	 * @version 1.0
	 * @param goodsName
	 * @return
	 */
	@Select("SELECT COUNT(*) FROM as_goods WHERE  goods_type= 2 AND is_delete = 0  AND   goods_name = #{goodsName}")
	int findByGoodsName(@Param(value = "goodsName") String goodsName);

	/**
	 * 检查商品货号sn是否重复
	 *
	 * @author tgb 创建时间：2016年12月7日
	 * @version 1.0
	 * @param goodsSn
	 * @return
	 */
	@Select("SELECT COUNT(*) FROM as_goods WHERE  goods_type= 2 AND is_delete = 0 AND  goods_sn = #{goodsSn}")
	int findByGoodsSn(String goodsSn);

	/**
	 * 重新设置商品属性时，把商品库存设置为0
	 *
	 * @author tgb 创建时间：2016年12月7日
	 * @version 1.0
	 * @param goodsId
	 */
	@Update("UPDATE as_goods SET goods_store = 0 WHERE goods_id = #{goodsId}")
	void updateGoodsStore(@Param(value = "goodsId") int goodsId);

	/**
	 * 修改商品数据时，添加修改时间和修改用户
	 *
	 * @author tgb 创建时间：2016年12月7日
	 * @version 1.0
	 * @param time
	 * @param name
	 * @param goodsId
	 * @return
	 */
	@Update("UPDATE as_goods SET update_time = #{time},update_user=#{name} WHERE goods_id = #{goodsId}")
	int updateGoodsWithTimeAndUser(@Param(value = "time") String time,
			@Param(value = "name") String name,
			@Param(value = "goodsId") int goodsId);

}