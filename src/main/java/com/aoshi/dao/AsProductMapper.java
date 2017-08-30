package com.aoshi.dao;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import com.aoshi.domain.AsProduct;

public interface AsProductMapper {
    int deleteByPrimaryKey(Integer productId);

    int insert(AsProduct record);

    int insertSelective(AsProduct record);

    AsProduct selectByPrimaryKey(Integer productId);

    int updateByPrimaryKeySelective(AsProduct record);

    int updateByPrimaryKeyWithBLOBs(AsProduct record);

    int updateByPrimaryKey(AsProduct record);
    
    @Delete(value="delete from as_product where goods_id = #{goodsId}")
	int deleteByGoodsId(@Param(value="goodsId")int goodsId);
    
    @Select(value="select * from as_product where goods_id = #{goodsId}")
	List<AsProduct> selectGoodsProduct(@Param(value = "goodsId")int goodsId);

}