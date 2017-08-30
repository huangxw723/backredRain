package com.aoshi.dao;

import com.aoshi.domain.AsAttachment;

import java.util.List;

public interface AsAttachmentMapper {
    int deleteByPrimaryKey(Integer sysAttachmentId);

    int insert(AsAttachment record);

    int insertSelective(AsAttachment record);

    AsAttachment selectByPrimaryKey(Integer sysAttachmentId);

    int updateByPrimaryKeySelective(AsAttachment record);

    int updateByPrimaryKey(AsAttachment record);

    List<AsAttachment> queryAsAttachmentBysysMessageId(Integer ItemId);
}