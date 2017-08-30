package com.aoshi.dao;

import java.util.List;
import java.util.Map;

import com.aoshi.domain.AsStore;
import com.aoshi.util.PageData;

import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

public interface AsStoreMapper extends AsBaseMapper {
    int deleteByPrimaryKey(Integer storeId);

	int deleteByPrimaryKeys(String[] item);

    int insert(AsStore record);

    int insertSelective(AsStore record);

    AsStore selectByPrimaryKey(Integer storeId);

    int updateByPrimaryKeySelective(AsStore record);

    int updateByPrimaryKey(AsStore record);

	List<AsStore> selectByAttr(PageData pd);

	List<AsStore> queryList();

    @Select("select * from as_store ")
    List<AsStore> selectAll();

    List<AsStore> selectByNoAddCooperation(PageData pd);

    List<AsStore> getStorList(PageData pd);

	Object getAddress(Integer storeId);
	
	@Select(value="select * from as_store where business_district_id = #{businessDistrictId}")
	List<AsStore> getStore(String businessDistrictId);
	
	@Select(value="select * from as_store")
	List<AsStore> getStoreAll();


}