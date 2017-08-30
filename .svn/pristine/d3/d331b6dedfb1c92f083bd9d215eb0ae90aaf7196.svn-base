package com.aoshi.service.manage.locality;

import com.aoshi.dao.AsBusinessDistrictMapper;
import com.aoshi.domain.AsBusinessDistrict;
import com.aoshi.util.PageData;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class AsBusinessDistrictService {

	@Autowired
	private AsBusinessDistrictMapper mapper;

	public List<AsBusinessDistrict> list(PageData pd) {
		return mapper.selectByAttr(pd);
	}

	/*
	 * 新增
	 */
	public int save(AsBusinessDistrict record) {
		return mapper.insert(record);
	}

	/*
	 * 修改
	 */
	public int edit(AsBusinessDistrict record) {
		return mapper.updateByPrimaryKeySelective(record);
	}

	/*
	 * 删除
	 */
	public int delete(int businessDistrictId) {
		return mapper.deleteByPrimaryKey(businessDistrictId);
	}

	/*
	 * 批量删除
	 */
	public int deleteAll(String[] businessDistrictIds) {
		return mapper.deleteByPrimaryKeys(businessDistrictIds);
	}

	/*
	 * 通过id获取数据
	 */
	public AsBusinessDistrict findById(AsBusinessDistrict record) {
		return mapper.selectByPrimaryKey(record.getBusinessDistrictId());
	}

}
