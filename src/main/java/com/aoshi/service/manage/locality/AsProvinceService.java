package com.aoshi.service.manage.locality;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.aoshi.dao.AsProvinceMapper;
import com.aoshi.domain.AsProvince;
import com.aoshi.util.PageData;

@Service
public class AsProvinceService {

	@Autowired
	private AsProvinceMapper mapper;

	public List<AsProvince> list(PageData pd) {
		return mapper.selectByAttr(pd);
	}

	/*
	 * 新增
	 */
	public int save(AsProvince record) {
		return mapper.insert(record);
	}

	/*
	 * 修改
	 */
	public int edit(AsProvince record) {
		return mapper.updateByPrimaryKey(record);
	}

	/*
	 * 删除
	 */
	public int delete(int provinceId) {
		return mapper.deleteByPrimaryKey(provinceId);
	}

	/*
	 * 批量删除
	 */
	public int deleteAll(String[] provinceIds) {
		return mapper.deleteByPrimaryKeys(provinceIds);
	}

	/*
	 * 通过id获取数据
	 */
	public AsProvince findById(AsProvince record) {
		return mapper.selectByPrimaryKey(record.getProvinceId());
	}

}
