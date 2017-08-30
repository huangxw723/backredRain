package com.aoshi.domain;

public class AsMessageConfig {
    private Integer messageConfigId;

    private Integer tradeMessageOpen;

    private Integer shopMessageOpen;

    private Integer expressMessageOpen;

    private String disturbStartTime;

    private String disturbEndTime;

    private Integer userId;

    private String createTime;

    private String updateTime;

    public Integer getMessageConfigId() {
        return messageConfigId;
    }

    public void setMessageConfigId(Integer messageConfigId) {
        this.messageConfigId = messageConfigId;
    }

    public Integer getTradeMessageOpen() {
        return tradeMessageOpen;
    }

    public void setTradeMessageOpen(Integer tradeMessageOpen) {
        this.tradeMessageOpen = tradeMessageOpen;
    }

    public Integer getShopMessageOpen() {
        return shopMessageOpen;
    }

    public void setShopMessageOpen(Integer shopMessageOpen) {
        this.shopMessageOpen = shopMessageOpen;
    }

    public Integer getExpressMessageOpen() {
        return expressMessageOpen;
    }

    public void setExpressMessageOpen(Integer expressMessageOpen) {
        this.expressMessageOpen = expressMessageOpen;
    }

    public String getDisturbStartTime() {
        return disturbStartTime;
    }

    public void setDisturbStartTime(String disturbStartTime) {
        this.disturbStartTime = disturbStartTime == null ? null : disturbStartTime.trim();
    }

    public String getDisturbEndTime() {
        return disturbEndTime;
    }

    public void setDisturbEndTime(String disturbEndTime) {
        this.disturbEndTime = disturbEndTime == null ? null : disturbEndTime.trim();
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

    public String getUpdateTime() {
        return updateTime;
    }

    public void setUpdateTime(String updateTime) {
        this.updateTime = updateTime == null ? null : updateTime.trim();
    }
}