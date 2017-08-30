package com.aoshi.dao;

import com.aoshi.domain.AsPrizeConfig;
import com.aoshi.domain.AsShop;
import com.aoshi.domain.AsYpBaseCategory;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import java.util.List;

public interface AsOwnGiftMapper {

	public List<AsPrizeConfig> queryAll(@Param("categoryId")String categoryId,@Param("keyWord")String keyWord, @Param("shopId") int shopId) ;

	public List<AsYpBaseCategory> queryType(Integer type);

	public void save(AsPrizeConfig asPrizeConfig);

	public List<AsShop> queryShop();

	public AsPrizeConfig toEdit(Integer id);

	public int edit(AsPrizeConfig asPrizeConfig);

	public int delete(Integer prizeConfigId);
	
	@Select("SELECT NAME FROM as_shop WHERE shop_id = #{shopId}")
	public String queryShopName(Integer shopId);

	public List<AsPrizeConfig> queryToGift(@Param("keyWord")String keyWord, @Param("shopId") Integer shopId);



}
