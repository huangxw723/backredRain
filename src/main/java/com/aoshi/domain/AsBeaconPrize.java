package com.aoshi.domain;

public class AsBeaconPrize {
    private Integer beaconPrizeId;

    private Integer prizeConfigId;

    private Integer beaconLinkId;

    private String createTime;

    public Integer getBeaconPrizeId() {
        return beaconPrizeId;
    }

    public void setBeaconPrizeId(Integer beaconPrizeId) {
        this.beaconPrizeId = beaconPrizeId;
    }

    public Integer getPrizeConfigId() {
        return prizeConfigId;
    }

    public void setPrizeConfigId(Integer prizeConfigId) {
        this.prizeConfigId = prizeConfigId;
    }

    public Integer getBeaconLinkId() {
        return beaconLinkId;
    }

    public void setBeaconLinkId(Integer beaconLinkId) {
        this.beaconLinkId = beaconLinkId;
    }

    public String getCreateTime() {
        return createTime;
    }

    public void setCreateTime(String createTime) {
        this.createTime = createTime == null ? null : createTime.trim();
    }
}