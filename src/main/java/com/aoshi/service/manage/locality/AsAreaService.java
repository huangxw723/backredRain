package com.aoshi.service.manage.locality;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.aoshi.dao.AsAreaMapper;
import com.aoshi.domain.AsArea;
import com.aoshi.util.PageData;

@Service
public class AsAreaService {

	@Autowired
	private AsAreaMapper mapper;

	public List<AsArea> list(PageData pd) {
		return mapper.selectByAttr(pd);
	}

	/*
	 * 新增
	 */
	public int save(AsArea record) {
		return mapper.insert(record);
	}

	/*
	 * 修改
	 */
	public int edit(AsArea record) {
		return mapper.updateByPrimaryKey(record);
	}

	/*
	 * 删除
	 */
	public int delete(int areaId) {
		return mapper.deleteByPrimaryKey(areaId);
	}

	/*
	 * 批量删除
	 */
	public int deleteAll(String[] areaIds) {
		return mapper.deleteByPrimaryKeys(areaIds);
	}

	/*
	 * 通过id获取数据
	 */
	public AsArea findById(AsArea record) {
		return mapper.selectByPrimaryKey(record.getAreaId());
	}

	public List<AsArea> selectAll() {
		// TODO Auto-generated method stub
		return mapper.selectAll();
	}

}
