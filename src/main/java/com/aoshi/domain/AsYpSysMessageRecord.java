package com.aoshi.domain;

public class AsYpSysMessageRecord {
    private Integer sysMessageRecordId;

    private Integer sysMessageId;

    private Integer status;

    private Integer userId;

    private String createTime;

    public Integer getSysMessageRecordId() {
        return sysMessageRecordId;
    }

    public void setSysMessageRecordId(Integer sysMessageRecordId) {
        this.sysMessageRecordId = sysMessageRecordId;
    }

    public Integer getSysMessageId() {
        return sysMessageId;
    }

    public void setSysMessageId(Integer sysMessageId) {
        this.sysMessageId = sysMessageId;
    }

    public Integer getStatus() {
        return status;
    }

    public void setStatus(Integer status) {
        this.status = status;
    }

    public Integer getUserId() {
        return userId;
    }

    public void setUserId(Integer userId) {
        this.userId = userId;
    }

    public String getCreateTime() {
        return createTime;
    }

    public void setCreateTime(String createTime) {
        this.createTime = createTime == null ? null : createTime.trim();
    }
}