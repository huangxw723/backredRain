package com.aoshi.domain;

public class AsPrizeCategory {
    private Integer prizeCategoryId;

    private Integer prizeConfigId;

    private Integer categoryId;

    private String createTime;

    public Integer getPrizeCategoryId() {
        return prizeCategoryId;
    }

    public void setPrizeCategoryId(Integer prizeCategoryId) {
        this.prizeCategoryId = prizeCategoryId;
    }

    public Integer getPrizeConfigId() {
        return prizeConfigId;
    }

    public void setPrizeConfigId(Integer prizeConfigId) {
        this.prizeConfigId = prizeConfigId;
    }

    public Integer getCategoryId() {
        return categoryId;
    }

    public void setCategoryId(Integer categoryId) {
        this.categoryId = categoryId;
    }

    public String getCreateTime() {
        return createTime;
    }

    public void setCreateTime(String createTime) {
        this.createTime = createTime == null ? null : createTime.trim();
    }
}