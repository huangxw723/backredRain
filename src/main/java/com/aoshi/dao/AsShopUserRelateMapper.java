package com.aoshi.dao;

import com.aoshi.domain.AsShopUserRelate;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import java.util.List;
import java.util.Map;

public interface AsShopUserRelateMapper {
    int deleteByPrimaryKey(Integer shopUserRelateId);

    int insert(AsShopUserRelate record);

    int insertSelective(AsShopUserRelate record);

    AsShopUserRelate selectByPrimaryKey(Integer shopUserRelateId);

    int updateByPrimaryKeySelective(AsShopUserRelate record);

    int updateByPrimaryKey(AsShopUserRelate record);

    /**
     * @description:
     * 通过商户id 查找到该商户下面的会员列表
     * @author: tgb
     * @date: 2017-08-16 15:28
     */
    @Select("select * from as_shop_user_relate where shop_id = #{shopId}")
    List<AsShopUserRelate> selectListRelateByShopId(@Param(value = "shopId") Integer shopId);

    /**
     * 账号查找
     * @param map
     * @return
     * @author chenwz
     */
    Object  queryAcoount(Map<String,Object> map);
}