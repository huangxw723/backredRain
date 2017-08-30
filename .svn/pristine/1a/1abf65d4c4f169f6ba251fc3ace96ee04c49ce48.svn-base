package com.aoshi.service.manage;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.aoshi.controller.base.BaseController;
import com.aoshi.dao.AsUnitMapper;
import com.aoshi.domain.AsUnit;
import com.aoshi.service.base.AsBaseService;
import com.aoshi.util.PageData;
/**
 * UnitService
 * 
 * @author hxw
 * @date 16/28/6
 */
@Service
public class UnitService extends AsBaseService {

	@Autowired
	private AsUnitMapper mapper;
	

	/**
	 * 查找所有单位列表 添加商品的时候用到
	 * 
	 * @author tgb 创建时间：2016年12月5日
	 * @version 1.0
	 * @return
	 */
	public List<AsUnit> findAll() {
		return mapper.findAll();
	}

	/*
	 * 新增
	 */
	public int save(AsUnit record) throws Exception {
		String id= String.valueOf(record.getUnitId());
		record.setIsDelete(0);
		if(id!="null"&&!id.equals(null)){
			return mapper.updateByPrimaryKeySelective(record);
		}
		return mapper.insert(record);
	}

	/*
	 * 修改
	 */
	public int edit(AsUnit record) throws Exception {
		record.setIsDelete(0);
		return mapper.updateByPrimaryKeySelective(record);
	}

	/*
	 * 删除 修改状态 0 未删，1已删
	 */
	public int delete(int unitId) throws Exception {
		AsUnit asUnit = mapper.selectByPrimaryKey(unitId);
		asUnit.setIsDelete(1);
		return mapper.updateByPrimaryKeySelective(asUnit);
	}
	

	/*
	 * 批量删除 修改状态 0 未删，1已删
	 */
	public int deleteAll(int[] IdArr) throws Exception {
		return mapper.updateByPrimaryKeys(IdArr);
	}

	

	/*
	 * 通过id获取数据
	 */
	public AsUnit findById(AsUnit record) throws Exception {
		return mapper.selectByPrimaryKey(record.getUnitId());
	}

	/**
	 * 单位列表
	 *@author tgb
	 *创建时间：2017年3月9日 
	 *@version 1.0
	 * @param c
	 * @return
	 */
	public Object unitList(BaseController c) {
		initialized(c);
		pageQueryModule(mapper, "listAll", true);
		return renderView("manage/unit/unitList");
	}

}
