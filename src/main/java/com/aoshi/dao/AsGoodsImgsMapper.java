package com.aoshi.dao;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.aoshi.domain.AsGoodsImgs;

public interface AsGoodsImgsMapper {
	int deleteByPrimaryKey(Integer goodsImgsId);

    int insert(AsGoodsImgs record);

    int insertSelective(AsGoodsImgs record);

	AsGoodsImgs selectByPrimaryKey(Integer goodsImgsId);

    int updateByPrimaryKeySelective(AsGoodsImgs record);

    int updateByPrimaryKey(AsGoodsImgs record);
    
	@Select(value = "select * from as_goods_imgs where goods_attr_id IS  NULL AND goods_id = #{goodsId}")
    List<AsGoodsImgs> selectByGoodsId(@Param(value="goodsId")Integer goodsId);
	
	List<AsGoodsImgs> selectThumbByGoodsId(@Param(value = "goodsId") Integer goodsId);

	int deleteGoodsImgAlls(int[] ids);

	@Delete("DELETE FROM as_goods_imgs WHERE goods_attr_id IS NOT NULL AND  goods_id = #{goodsId}")
	int deleteByGoodsId(@Param(value = "goodsId") Integer goodsId);
	
	@Update("UPDATE as_goods_imgs SET thumb_url = NULL WHERE goods_imgs_id = #{goodsImgsId}")
	int deleteAttrImgsByGoodsImgsId(@Param(value = "goodsImgsId")Integer goodsImgsId);
}