package com.aoshi.domain;

import java.util.List;

import com.aoshi.vo.AsAttributeVo;

public class AsAttrType {
    private Integer attrTypeId;

    private String typeName;

    private Integer isDelete;

    private Integer sortOrder;

    private String createTime;

	List<AsAttributeVo> attributes;

    public Integer getAttrTypeId() {
        return attrTypeId;
    }

    public void setAttrTypeId(Integer attrTypeId) {
        this.attrTypeId = attrTypeId;
    }

    public String getTypeName() {
        return typeName;
    }

    public void setTypeName(String typeName) {
        this.typeName = typeName == null ? null : typeName.trim();
    }

    public Integer getIsDelete() {
        return isDelete;
    }

    public void setIsDelete(Integer isDelete) {
        this.isDelete = isDelete;
    }

    public Integer getSortOrder() {
        return sortOrder;
    }

    public void setSortOrder(Integer sortOrder) {
        this.sortOrder = sortOrder;
    }

    public String getCreateTime() {
        return createTime;
    }

    public void setCreateTime(String createTime) {
        this.createTime = createTime == null ? null : createTime.trim();
    }
}