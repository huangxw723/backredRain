package com.aoshi.service.manage;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.aoshi.dao.AsAttrTypeMapper;
import com.aoshi.dao.AsAttributeMapper;
import com.aoshi.domain.AsAttrType;
import com.aoshi.domain.AsAttribute;
import com.aoshi.util.DateUtil;
import com.aoshi.util.PageData;
/**
 * AsAttrTypeService
 * 
 * @author hxw
 * @date 16/28/6
 */
@Service
public class AsAttrTypeService {

	@Autowired
	private AsAttrTypeMapper mapper;
	
	@Autowired
	private AsAttributeMapper butemapper;
	
	public List<AsAttrType> list(PageData pd) {
		return mapper.selectByAttr(pd);
	}

	/*
	 * 新增
	 */
	public int save(AsAttrType record) throws Exception {
		String id= String.valueOf(record.getAttrTypeId());
		record.setIsDelete(0);
		record.setCreateTime(DateUtil.getTime());
		if(id!="null"&&!id.equals(null)){
			return mapper.updateByPrimaryKeySelective(record);
		}
		return mapper.insert(record);
	}

	
	/*
	 * 新增
	 */
	public int insert(AsAttrType record,PageData pd) throws Exception {
		record.setIsDelete(0);
		record.setCreateTime(DateUtil.getTime());
	    return  mapper.insert(record);
	}
	/*
	 * 修改
	 */
	public int edit(AsAttrType record) throws Exception {
		return mapper.updateByPrimaryKeySelective(record);
	}

	/*
	 * 删除 修改状态 0 未删，1已删 连同改商品类型下的属性也一同删除
	 */
	public int delete(int attrTypeId) throws Exception {
		AsAttrType asAttrType = mapper.selectByPrimaryKey(attrTypeId);
		asAttrType.setIsDelete(1);
		int data = mapper.updateByPrimaryKeySelective(asAttrType);
		if (data > 0) {
			List<AsAttribute> asAttributes = butemapper
					.findByAttrTypeId(attrTypeId);
			for (AsAttribute asAttribute : asAttributes) {
				asAttribute.setIsDelete(1);
				data = butemapper.updateByPrimaryKeySelective(asAttribute);
			}
		}
		return data;
	}
	

	/*
	 * 批量删除 修改状态 0 未删，1已删 连同改商品类型下的属性也一同删除
	 */
	public int deleteAll(int[] idArr) throws Exception {
		int data = 0;
		data = mapper.updateByPrimaryKeys(idArr);
		for (int i = 0; i < idArr.length; i++) {
			if (data > 0) {
				List<AsAttribute> asAttributes = butemapper
						.findByAttrTypeId(idArr[i]);
				for (AsAttribute asAttribute : asAttributes) {
					asAttribute.setIsDelete(1);
					data = butemapper.updateByPrimaryKeySelective(asAttribute);
				}
			}
		}
		return data;
	}

	

	/*
	 * 通过id获取数据
	 */
	public AsAttrType findById(AsAttrType record) throws Exception {
		return mapper.selectByPrimaryKey(record.getAttrTypeId());
	}
	
	/**
	 * @author luhuajiang
	 * @return
	 */
	public List<AsAttrType> findAll(){
		return mapper.findAll();
	}

	public List<AsAttrType> findAttrValue() {
		return mapper.findAttrValue();
	}
}
