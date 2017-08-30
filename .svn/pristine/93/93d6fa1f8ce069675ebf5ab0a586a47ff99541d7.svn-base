package com.aoshi.service.manage.locality;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.aoshi.dao.AsCityMapper;
import com.aoshi.domain.AsCity;
import com.aoshi.util.PageData;

@Service
public class AsCityService {

	@Autowired
	private AsCityMapper mapper;

	public List<AsCity> list(PageData pd) {
		return mapper.selectByAttr(pd);
	}

	/*
	 * 新增
	 */
	public int save(AsCity record) {
		return mapper.insert(record);
	}

	/*
	 * 修改
	 */
	public int edit(AsCity record) {
		return mapper.updateByPrimaryKey(record);
	}

	/*
	 * 删除
	 */
	public int delete(int cityId) {
		return mapper.deleteByPrimaryKey(cityId);
	}

	/*
	 * 批量删除
	 */
	public int deleteAll(String[] cityIds) {
		return mapper.deleteByPrimaryKeys(cityIds);
	}

	/*
	 * 通过id获取数据
	 */
	public AsCity findById(AsCity record) {
		return mapper.selectByPrimaryKey(record.getCityId());
	}

	public List<AsCity> selectAll() {
		return mapper.selectAll();
	}

}
