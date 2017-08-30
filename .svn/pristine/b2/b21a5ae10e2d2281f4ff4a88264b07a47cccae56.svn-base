package com.aoshi.dao;

import java.util.List;

import com.aoshi.domain.AsCart;
import com.aoshi.util.PageData;

public interface AsCartMapper {
    int deleteByPrimaryKey(Integer cartId);

    int insert(AsCart record);

    int insertSelective(AsCart record);

    AsCart selectByPrimaryKey(Integer cartId);

    int updateByPrimaryKeySelective(AsCart record);

    int updateByPrimaryKey(AsCart record);
    
	List<AsCart> selectByAttr(PageData pd);

	List<AsCart> selectCartUser(PageData pd);

	List<AsCart> selectCartGoods(PageData pd);

	List<AsCart> selectCartShop(PageData pd);

	int deleteByPrimaryKeys(String[] cartIds);
	
}