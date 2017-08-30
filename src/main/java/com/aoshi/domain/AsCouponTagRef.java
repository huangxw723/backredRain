package com.aoshi.domain;

public class AsCouponTagRef {
    private Integer couponTagRefId;

    private Integer couponId;

    private Integer tagId;

    private String createTime;

    public Integer getCouponTagRefId() {
        return couponTagRefId;
    }

    public void setCouponTagRefId(Integer couponTagRefId) {
        this.couponTagRefId = couponTagRefId;
    }

    public Integer getCouponId() {
        return couponId;
    }

    public void setCouponId(Integer couponId) {
        this.couponId = couponId;
    }

    public Integer getTagId() {
        return tagId;
    }

    public void setTagId(Integer tagId) {
        this.tagId = tagId;
    }

    public String getCreateTime() {
        return createTime;
    }

    public void setCreateTime(String createTime) {
        this.createTime = createTime == null ? null : createTime.trim();
    }
}