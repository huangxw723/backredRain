package com.aoshi.dao;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Param;

import com.aoshi.domain.AsGoodsAttr;

public interface AsGoodsAttrMapper {
    int deleteByPrimaryKey(Integer goodsAttrId);

    int insert(AsGoodsAttr record);

    int insertSelective(AsGoodsAttr record);

    AsGoodsAttr selectByPrimaryKey(Integer goodsAttrId);

    int updateByPrimaryKeySelective(AsGoodsAttr record);

    int updateByPrimaryKeyWithBLOBs(AsGoodsAttr record);

    int updateByPrimaryKey(AsGoodsAttr record);

	List<AsGoodsAttr> selectByGoodsId(@Param(value="goodsId")Integer goodsId);
	
	@Delete(value="delete from as_goods_attr where goods_id = #{goodsId}")
	int deleteByGoodsId(@Param(value="goodsId")int goodsId);

	List<AsGoodsAttr> findByGoodsIdWithAttr(@Param(value="goodsId")Integer goodsId);
}