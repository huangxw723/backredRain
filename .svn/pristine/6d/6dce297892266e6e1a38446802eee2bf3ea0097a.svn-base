package com.aoshi.dao;

import java.util.List;

import com.aoshi.domain.AsGoodsType;
import com.aoshi.util.PageData;

public interface AsGoodsTypeMapper {

    int deleteByPrimaryKey(Integer goodsTypeId);

	int insert(AsGoodsType record);

	int insertSelective(AsGoodsType record);

	AsGoodsType selectByPrimaryKey(Integer goodsTypeId);

	List<AsGoodsType> selectAll();

	List<AsGoodsType> selectByParent(PageData pd);

	List<AsGoodsType> selectByPrimaryKeys(List<String> goodsTypeIds);

	int updateByPrimaryKeySelective(AsGoodsType record);

	int updateByPrimaryKey(AsGoodsType record);

	List<AsGoodsType> getChildren(int goodsTypeId);
	
	List<AsGoodsType> selectByLevel(int typeLevel);

	List<AsGoodsType> selectAlls(AsGoodsType asGoodsType);

	int getgoodsTypeLevel(Integer goodsTypeId);
}