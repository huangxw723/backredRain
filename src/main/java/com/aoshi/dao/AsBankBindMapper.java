package com.aoshi.dao;

import com.aoshi.domain.AsBankBind;
import org.apache.ibatis.annotations.Update;

import java.util.List;

public interface AsBankBindMapper extends AsBaseMapper{
    int deleteByPrimaryKey(Integer bankBindId);

    int insert(AsBankBind record);

    int insertSelective(AsBankBind record);

    AsBankBind selectByPrimaryKey(Integer bankBindId);

    int updateByPrimaryKeySelective(AsBankBind record);

    int updateByPrimaryKey(AsBankBind record);

    int isBankBind(int userId);

    List<AsBankBind> selectAllByUserId(int userId);

    /**
     * E街E铺-3期 绑卡信息有变,所有已绑的银行卡作废
     * @author yangyanchao
     * @date 2017-03-10
     * @return
     */
    @Update("update as_bank_bind set status = 1")
    int updateByScriptV3();
}