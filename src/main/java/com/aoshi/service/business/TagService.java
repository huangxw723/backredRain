package com.aoshi.service.business;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.aoshi.dao.AsPrizeTypeMapper;
import com.aoshi.dao.AsTagMapper;
import com.aoshi.domain.AsPrizeType;
import com.aoshi.domain.AsTag;
import com.aoshi.util.DateUtil;

@Service
@Transactional
public class TagService {
	@Autowired
	AsTagMapper asTagMapper;
	
	public List<AsTag> queryList(AsTag asTag){
		return asTagMapper.queryList(asTag);
	}


	public int save(AsTag tag) {
		tag.setCreateTime(DateUtil.getTime());
		return asTagMapper.insertSelective(tag);
	}
	
	public int delete(int tagId){
		return asTagMapper.deleteByPrimaryKey(tagId);
	}
	
	public int update(AsTag tag){
		return asTagMapper.updateByPrimaryKeySelective(tag);
	}
	
	public AsTag findByTagId(int tagId){
		return asTagMapper.selectByPrimaryKey(tagId);
	}


	public boolean isExist(String name,int type) {
		AsTag tag = asTagMapper.findByName(name,type);
		if(tag != null){
			return true;
		}
		return false;
	}
	

}
