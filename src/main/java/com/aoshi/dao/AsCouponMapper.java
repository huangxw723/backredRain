package com.aoshi.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.aoshi.domain.AsCoupon;

public interface AsCouponMapper {
    int deleteByPrimaryKey(Integer couponId);

    int insert(AsCoupon record);

    int insertSelective(AsCoupon record);

    AsCoupon selectByPrimaryKey(Integer couponId);

    int updateByPrimaryKeySelective(AsCoupon record);

    int updateByPrimaryKey(AsCoupon record);
    
	List<AsCoupon> queryList(AsCoupon record);
    
    @Select(value="select * from as_coupon where coupon_id = #{couponId}")
	AsCoupon findById(@Param(value="couponId")int couponId);
    
    @Update(value="update as_coupon set status = 2 where coupon_id = #{couponId} and shop_id = #{shopId}")
	int disableByIdAndShopId(@Param(value="couponId")int couponId,@Param(value="shopId") int shopId);
    
    @Update(value="update as_coupon set status = 1 where coupon_id = #{couponId} and shop_id = #{shopId}")
	int enableByIdAndShopId(@Param(value="couponId")int couponId,@Param(value="shopId") int shopId);
    
    @Update(value="update as_coupon set store_id = #{storeId} where shop_id = #{shopId}")
	int modifyStoreIdByShopId(Object conditions);
    
}