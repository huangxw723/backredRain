package com.aoshi.dao;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import com.aoshi.domain.AsCouponTagRef;

public interface AsCouponTagRefMapper {
    int deleteByPrimaryKey(Integer couponTagRefId);

    int insert(AsCouponTagRef record);

    int insertSelective(AsCouponTagRef record);

    AsCouponTagRef selectByPrimaryKey(Integer couponTagRefId);

    int updateByPrimaryKeySelective(AsCouponTagRef record);

    int updateByPrimaryKey(AsCouponTagRef record);
    
    @Delete(value="delete from as_coupon_tag_ref where coupon_id = #{couponId}")
	int deleteByCoupId(@Param(value="couponId")Integer couponId);
    
    @Select(value="select * from as_coupon_tag_ref where coupon_id = #{couponId}")
    List<AsCouponTagRef> selectByCouponId(int couponId);
}