package com.aoshi.domain;

public class AsDictParam {
    private Integer dictParamId;

    private String dictCode;

    private String remark;

    private String createTime;

    private String dictValue;

    public Integer getDictParamId() {
        return dictParamId;
    }

    public void setDictParamId(Integer dictParamId) {
        this.dictParamId = dictParamId;
    }

    public String getDictCode() {
        return dictCode;
    }

    public void setDictCode(String dictCode) {
        this.dictCode = dictCode == null ? null : dictCode.trim();
    }

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark == null ? null : remark.trim();
    }

    public String getCreateTime() {
        return createTime;
    }

    public void setCreateTime(String createTime) {
        this.createTime = createTime == null ? null : createTime.trim();
    }

    public String getDictValue() {
        return dictValue;
    }

    public void setDictValue(String dictValue) {
        this.dictValue = dictValue == null ? null : dictValue.trim();
    }
}