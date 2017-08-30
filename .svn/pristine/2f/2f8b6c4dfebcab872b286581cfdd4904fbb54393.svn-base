package com.aoshi.dao;

import com.aoshi.domain.AsShopPic;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import java.util.List;

public interface AsShopPicMapper extends AsBaseMapper{
    int deleteByPrimaryKey(Integer shopPicId);

    int deleteByPrimaryKeyById (Integer shopId);

    int insert(AsShopPic record);

    AsShopPic selectByPrimaryKey(Integer shopPicId);

    int updateByPrimaryKeySelective(AsShopPic record);

    int updateByPrimaryKey(AsShopPic record);

    @Select(value = "select * from as_shop_pic where  shop_id = #{shopId}")
    List<AsShopPic> selectByShopId(@Param(value="shopId")int shopId);

    int deleteShopPicImgAlls(int[] ids);
    
    @Delete(value = "delete from as_shop_pic where shop_pic_id = #{shopPicId}")
    int delteShopPicById(@Param(value="shopPicId")Integer shopPicId);
}