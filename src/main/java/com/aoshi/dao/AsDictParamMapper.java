package com.aoshi.dao;

import com.aoshi.domain.AsDictParam;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import java.util.List;

public interface AsDictParamMapper {

	/**
	 * 查询指定配置
	 * 
	 * @author yangyanchao
	 * @date 2016年9月1日
	 * @param conditions
	 * @return
	 */
	String findByKeyCode(Object conditions);
	
	AsDictParam findAllByKeyCode(@Param("dictCode") String dictCode);
	
	int	updateByPrimaryKeySelective(AsDictParam asDictParam);
	
	/**-----------------------------------------------------------------------------------------------*/
	
	//编辑时候查询出id 
	 AsDictParam selectByPrimaryKey(Integer id);
	 
	 //列表显示
	 List<AsDictParam> queryList(AsDictParam obj);
	 
	 
	 //保存新增
	 int insertSelective(AsDictParam obj);
	
	
	//保存编辑
    int updateByPrimaryKey(AsDictParam obj);
    
	//查询
    //AsDictParam selectById(Integer id);
    AsDictParam  findAllByKeyCode(Integer id);
    
    /**
	 * 根据dictValue
	 * @param 
	 * @return
	 */
	@Select("SELECT * FROM as_dict_param WHERE dict_value=#{dictValue}")
	List<AsDictParam> selectByName(@Param(value="dictValue")AsDictParam obj);

	/**
	 * 修改兑换金额比后，更新积分商品的积分值
	 * @param moneyPointValue 积分金额比
	 * @return
     */
	int updateSalesPrice(@Param(value="moneyPointValue")Integer moneyPointValue);
	
	
}