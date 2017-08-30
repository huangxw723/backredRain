package com.aoshi.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import com.aoshi.domain.AsActivityReceivedRecord;
import com.aoshi.util.Conditions;

public interface AsActivityReceivedRecordMapper extends AsBaseMapper {
    int deleteByPrimaryKey(Integer activityReceivedRecordId);

    int insert(AsActivityReceivedRecord record);

    int insertSelective(AsActivityReceivedRecord record);

    AsActivityReceivedRecord selectByPrimaryKey(Integer activityReceivedRecordId);

    int updateByPrimaryKeySelective(AsActivityReceivedRecord record);

    int updateByPrimaryKey(AsActivityReceivedRecord record);
       
    List<AsActivityReceivedRecord> listAllExchage(Object conditions);   
     
    @Select(value="select * from as_activity_received_record where type=1 and shop_id=#{shopId}")
    List<AsActivityReceivedRecord> selectByshopId(@Param(value="shopId")Integer shopId);
    
    int updateByPrimaryshopIdAndPrizeId(AsActivityReceivedRecord record);
    
    AsActivityReceivedRecord findByAttr(AsActivityReceivedRecord record);
    
   

}