package com.aoshi.dao;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import com.aoshi.domain.AsTypeRelation;

public interface AsTypeRelationMapper {
    int deleteByPrimaryKey(Integer typeRelationId);

    int insert(AsTypeRelation record);

    int insertSelective(AsTypeRelation record);

    AsTypeRelation selectByPrimaryKey(Integer typeRelationId);

    int updateByPrimaryKeySelective(AsTypeRelation record);

    int updateByPrimaryKey(AsTypeRelation record);
    
    @Select(value="select * from as_type_relation where goods_id = #{goodsId}")
	List<AsTypeRelation> getRelationsByGoodsId(@Param(value="goodsId")int goodsId);
    @Delete(value="delete from as_type_relation where goods_id = #{goodsId}")
	int deleteByGoodsId(@Param(value="goodsId")Integer goodsId);

	@Select(value = "select COUNT(*) from as_type_relation where goods_type_id = #{goodsTypeId}")
	int existTypeRelation(@Param(value = "goodsTypeId") Integer goodsTypeId);
}