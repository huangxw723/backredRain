package com.aoshi.domain;

public class AsUserActivityRecord {
    private Integer userActivityRecord;

    private Integer userId;

    private Integer storeId;

    private Integer shopId;

    private Integer ownActivityId;

    private Integer beaconLinkId;

    private Integer activityLinkId;

    private Integer activityType;

    private Integer prizeConfigId;

    private String createTime;

    public Integer getUserActivityRecord() {
        return userActivityRecord;
    }

    public void setUserActivityRecord(Integer userActivityRecord) {
        this.userActivityRecord = userActivityRecord;
    }

    public Integer getUserId() {
        return userId;
    }

    public void setUserId(Integer userId) {
        this.userId = userId;
    }

    public Integer getStoreId() {
        return storeId;
    }

    public void setStoreId(Integer storeId) {
        this.storeId = storeId;
    }

    public Integer getShopId() {
        return shopId;
    }

    public void setShopId(Integer shopId) {
        this.shopId = shopId;
    }

    public Integer getOwnActivityId() {
        return ownActivityId;
    }

    public void setOwnActivityId(Integer ownActivityId) {
        this.ownActivityId = ownActivityId;
    }

    public Integer getBeaconLinkId() {
        return beaconLinkId;
    }

    public void setBeaconLinkId(Integer beaconLinkId) {
        this.beaconLinkId = beaconLinkId;
    }

    public Integer getActivityLinkId() {
        return activityLinkId;
    }

    public void setActivityLinkId(Integer activityLinkId) {
        this.activityLinkId = activityLinkId;
    }

    public Integer getActivityType() {
        return activityType;
    }

    public void setActivityType(Integer activityType) {
        this.activityType = activityType;
    }

    public Integer getPrizeConfigId() {
        return prizeConfigId;
    }

    public void setPrizeConfigId(Integer prizeConfigId) {
        this.prizeConfigId = prizeConfigId;
    }

    public String getCreateTime() {
        return createTime;
    }

    public void setCreateTime(String createTime) {
        this.createTime = createTime == null ? null : createTime.trim();
    }
}