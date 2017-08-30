package com.aoshi.service.manage;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.aoshi.dao.AsAttrTypeMapper;
import com.aoshi.dao.AsAttributeMapper;
import com.aoshi.domain.AsAttrType;
import com.aoshi.domain.AsAttribute;
import com.aoshi.util.PageData;

/**
 * 积分商品商品属性
 * 
 * @author tgb 创建时间：2016年12月7日
 * @version 1.0
 */
@Service
public class AsAttributeService {

	@Autowired
	AsAttrTypeMapper asAttrTypeMapper;

	@Autowired
	private AsAttributeMapper mapper;
	
	public List<AsAttribute> list(PageData pd) {
		return mapper.selectByAttr(pd);
	}

	/*
	 * 新增
	 */
	public int save(AsAttribute record) throws Exception {
		record.setIsDelete(0);
		return mapper.insert(record);
	}

	/*
	 * 修改
	 */
	public int edit(AsAttribute record) throws Exception {
		return mapper.updateByPrimaryKeySelective(record);
	}

	/*
	 * 删除
	 */
	public int delete(int attributeId) throws Exception {
		AsAttribute asAttribute = mapper.selectByPrimaryKey(attributeId);
		asAttribute.setIsDelete(1);
		return mapper.updateByPrimaryKeySelective(asAttribute);
	}
	

	/*
	 * 批量删除
	 */
	public int deleteAll(int[] IdArr) throws Exception {
		return mapper.updateByPrimaryKeys(IdArr);
	}

	

	/*
	 * 通过id获取数据
	 */
	public AsAttribute findById(AsAttribute record) throws Exception {
		return mapper.selectByPrimaryKey(record.getAttributeId());
	}

	/**
	 * 通过商品类型typeId 获取属性
	 *
	 * @author tgb 创建时间：2016年12月15日
	 * @version 1.0
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	public AsAttribute findAsAttribute(PageData pd) throws Exception {
		return mapper.findByTypeId(pd);
	}
	
	/**
	 * 获取商品类型列表
	 *
	 * @author tgb 创建时间：2016年12月15日
	 * @version 1.0
	 * @return
	 */
	public List<AsAttrType> selectAll() {
		return asAttrTypeMapper.selectAll();
	}

	/**
	 * 根据选择的属性类型，获取对应的属性值 并对属性值进行分组切割 设置商品属性 用到
	 * 
	 * @author tgb 创建时间：2016年12月14日
	 * @version 1.0
	 * @param attrTypeId
	 * @return
	 */
	public List<AsAttribute> getAttributeByAttrTypeId(int attrTypeId) {
		List<AsAttribute> attributes = mapper.findByAttrTypeId(attrTypeId);
		for (AsAttribute attribute : attributes) {
			if (attribute.getAttrValues() != null
					&& attribute.getAttrValues().indexOf(";") > -1) {
				attribute.setAttrVals(attribute.getAttrValues().split(";"));
			} else if (attribute.getAttrValues() != null
					&& attribute.getAttrValues().indexOf("；") > -1) {
				attribute.setAttrVals(attribute.getAttrValues().split("；"));
			} else if (attribute.getAttrValues() != null
					&& attribute.getAttrValues().indexOf(";") == -1) {
				attribute
						.setAttrVals(new String[] { attribute.getAttrValues() });
			} else if (attribute.getAttrValues() != null
					&& attribute.getAttrValues().indexOf("；") == -1) {
				attribute
						.setAttrVals(new String[] { attribute.getAttrValues() });
			}

		}
		return attributes;
	}

}
