package com.aoshi.dao;

import java.util.List;

import com.aoshi.domain.AsShopSpell;

public interface AsShopSpellMapper {
    int deleteByPrimaryKey(Integer spellId);

    int insert(AsShopSpell record);

    int insertSelective(AsShopSpell record);

    AsShopSpell selectByPrimaryKey(Integer spellId);

    int updateByPrimaryKeySelective(AsShopSpell record);

    int updateByPrimaryKey(AsShopSpell record);
    
    List<AsShopSpell> selectByShopId(Integer spellId);
    
    int deleteByPrimaryKeyByshopId(Integer shopId);
    
}