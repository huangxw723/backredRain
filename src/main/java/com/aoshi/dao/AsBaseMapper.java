package com.aoshi.dao;

import java.util.List;

import com.aoshi.util.Conditions;

public interface AsBaseMapper {

	int deleteByPrimaryKey(Object conditions);

	int deleteByPrimaryKeys(Object conditions);

	int insert(Object conditions);

	int insertSelective(Object conditions);

	Object selectByPrimaryKey(Object conditions);

	int updateByPrimaryKeySelective(Object conditions);

	int updateByPrimaryKey(Object conditions);

	/**
	 * 字典查询
	 * 
	 * @author yangyanchao
	 * @date 2016年7月8日
	 * @param conditions
	 * @return 字典值
	 */
	Object findByKeyCode(Object conditions);

	/**
	 * 通用查询
	 * 
	 * @author yangyanchao
	 * @date 2016年6月27日
	 * @param conditions
	 *            兼容需要条件查询
	 * @return
	 */
	List<Object> selectAll(Object conditions);

	/**
	 * 查询当前表记录列表
	 * 
	 * @author yangyanchao
	 * @date 2016年9月2日
	 * @param conditions
	 * @return
	 */
	List<Conditions> listAll(Object conditions);

	/**
	 * 某某搜索
	 * 
	 * @author yangyanchao
	 * @date 2016年8月5日
	 * @param conditions
	 * @return
	 */
	List<Object> selectByAttr(Object conditions);

	/**
	 * 通用ID查询
	 * 
	 * @author yangyanchao
	 * @date 2016年6月28日
	 * @param conditions
	 * @return
	 */
	Object findById(Object conditions);

	/**
	 * 根据userId查询
	 * 
	 * @author yangyanchao
	 * @date 2016年6月30日
	 * @param conditions
	 * @return
	 */
	Object findByUserId(Object conditions);

	/**
	 * 锁查询
	 * 
	 * @author yangyanchao
	 * @date 2016年7月27日
	 * @param conditions
	 * @return
	 */
	Object selectByPrimaryKeyWithLock(Object conditions);

	int deleteByIds(Object conditions);

	List<Conditions> selectByPosType(Integer adPosType);
	

}
