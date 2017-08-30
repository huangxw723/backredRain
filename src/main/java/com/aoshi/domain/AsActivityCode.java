package com.aoshi.domain;

public class AsActivityCode {
    private Integer activityCodeId;

    private String code;

    private Integer status;

    private String createTime;

    private Integer userId;

    private Integer prizeId;

    private Integer interval;

    public Integer getActivityCodeId() {
        return activityCodeId;
    }

    public void setActivityCodeId(Integer activityCodeId) {
        this.activityCodeId = activityCodeId;
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code == null ? null : code.trim();
    }

    public Integer getStatus() {
        return status;
    }

    public void setStatus(Integer status) {
        this.status = status;
    }

    public String getCreateTime() {
        return createTime;
    }

    public void setCreateTime(String createTime) {
        this.createTime = createTime == null ? null : createTime.trim();
    }

    public Integer getUserId() {
        return userId;
    }

    public void setUserId(Integer userId) {
        this.userId = userId;
    }

    public Integer getPrizeId() {
        return prizeId;
    }

    public void setPrizeId(Integer prizeId) {
        this.prizeId = prizeId;
    }

    public Integer getInterval() {
        return interval;
    }

    public void setInterval(Integer interval) {
        this.interval = interval;
    }
}