package com.aoshi.domain;

public class AsYpScreenInfo {
    private Integer screenInfoId;

    private String sn;

    private Integer provinceId;

    private Integer cityId;

    private Integer areaId;

    private Integer shopId;

    private String address;

    private Integer status;

    private Integer screenDomainId;

    private Integer clickCount;

    private String operaTime;

    private String createTime;

    public Integer getScreenInfoId() {
        return screenInfoId;
    }

    public void setScreenInfoId(Integer screenInfoId) {
        this.screenInfoId = screenInfoId;
    }

    public String getSn() {
        return sn;
    }

    public void setSn(String sn) {
        this.sn = sn == null ? null : sn.trim();
    }

    public Integer getProvinceId() {
        return provinceId;
    }

    public void setProvinceId(Integer provinceId) {
        this.provinceId = provinceId;
    }

    public Integer getCityId() {
        return cityId;
    }

    public void setCityId(Integer cityId) {
        this.cityId = cityId;
    }

    public Integer getAreaId() {
        return areaId;
    }

    public void setAreaId(Integer areaId) {
        this.areaId = areaId;
    }

    public Integer getShopId() {
        return shopId;
    }

    public void setShopId(Integer shopId) {
        this.shopId = shopId;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address == null ? null : address.trim();
    }

    public Integer getStatus() {
        return status;
    }

    public void setStatus(Integer status) {
        this.status = status;
    }

    public Integer getScreenDomainId() {
        return screenDomainId;
    }

    public void setScreenDomainId(Integer screenDomainId) {
        this.screenDomainId = screenDomainId;
    }

    public Integer getClickCount() {
        return clickCount;
    }

    public void setClickCount(Integer clickCount) {
        this.clickCount = clickCount;
    }

    public String getOperaTime() {
        return operaTime;
    }

    public void setOperaTime(String operaTime) {
        this.operaTime = operaTime == null ? null : operaTime.trim();
    }

    public String getCreateTime() {
        return createTime;
    }

    public void setCreateTime(String createTime) {
        this.createTime = createTime == null ? null : createTime.trim();
    }
}