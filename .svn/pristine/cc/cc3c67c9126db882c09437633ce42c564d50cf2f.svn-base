package com.aoshi.dao;

import com.aoshi.domain.AsCooperation;
import com.aoshi.util.PageData;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import java.util.List;
import java.util.Map;

public interface AsCooperationMapper extends AsBaseMapper {
    int deleteByPrimaryKey(Integer cooperationId);

    int insert(AsCooperation record);

    int insertSelective(AsCooperation record);

    AsCooperation selectByPrimaryKey(Integer cooperationId);

    int updateByPrimaryKeySelective(AsCooperation record);

    int updateByPrimaryKey(AsCooperation record);

    @Select("select * from as_cooperation c left join as_store s on c.active_id =s.store_id where c.active_id = #{storeId}")
    List<Map<String, Object>> selectByStoreId(@Param(value = "storeId") Integer storeId);


    int deleteByPrimaryKeys(String[] businessDistrictIds);

    List<AsCooperation> selectByCooperation(PageData pd);
    
    /**
     * 获取已经合作的战略伙伴列表
     *@author tgb
     *创建时间：2017年3月8日 
     *@version 1.0
     * @param obj
     * @return
     */
    List<AsCooperation> selectShopByCooperation(Object obj);

    /**
     * 查找所有未合作商户
     *@author tgb
     *创建时间：2017年3月8日
     *@version 1.0
     * @param obj
     * @return
     */
    List<AsCooperation> selectByNoAddCooperation(Object obj);


}