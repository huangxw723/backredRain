package com.aoshi.domain;

public class AsBeaconUid {
    private Integer beaconUidId;

    private String beaconUidUuid;

    private String createTime;

    public Integer getBeaconUidId() {
        return beaconUidId;
    }

    public void setBeaconUidId(Integer beaconUidId) {
        this.beaconUidId = beaconUidId;
    }

    public String getBeaconUidUuid() {
        return beaconUidUuid;
    }

    public void setBeaconUidUuid(String beaconUidUuid) {
        this.beaconUidUuid = beaconUidUuid == null ? null : beaconUidUuid.trim();
    }

    public String getCreateTime() {
        return createTime;
    }

    public void setCreateTime(String createTime) {
        this.createTime = createTime == null ? null : createTime.trim();
    }
}