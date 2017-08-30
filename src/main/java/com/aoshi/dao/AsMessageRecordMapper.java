package com.aoshi.dao;

import com.aoshi.domain.AsMessageRecord;

public interface AsMessageRecordMapper extends AsBaseMapper {
	int deleteByPrimaryKey(Integer messageRecordId);

	int insert(AsMessageRecord record);

	int insertSelective(AsMessageRecord record);

	AsMessageRecord selectByPrimaryKey(Integer messageRecordId);

	int updateByPrimaryKeySelective(AsMessageRecord record);

	int updateByPrimaryKeyWithBLOBs(AsMessageRecord record);

	int updateByPrimaryKey(AsMessageRecord record);
}