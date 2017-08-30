package com.aoshi.domain;

public class AsStore {
    private Integer storeId;

    private String name;

    private String address;

    private String logoUrl;

    private String qrCodeUrl;

    private Integer businessDistrictId;

    private Integer isCooperation;

    private String lng;

    private String lat;

    private String createTime;

    private Integer ypBaseCategoryId;

    private AsBusinessDistrict businessDistrict;

    private String site;

    public AsBusinessDistrict getBusinessDistrict() {
        return businessDistrict;
    }

    public void setBusinessDistrict(AsBusinessDistrict businessDistrict) {
        this.businessDistrict = businessDistrict;
    }

    public Integer getStoreId() {
        return storeId;
    }

    public void setStoreId(Integer storeId) {
        this.storeId = storeId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name == null ? null : name.trim();
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address == null ? null : address.trim();
    }

    public String getLogoUrl() {
        return logoUrl;
    }

    public void setLogoUrl(String logoUrl) {
        this.logoUrl = logoUrl == null ? null : logoUrl.trim();
    }

    public String getQrCodeUrl() {
        return qrCodeUrl;
    }

    public void setQrCodeUrl(String qrCodeUrl) {
        this.qrCodeUrl = qrCodeUrl == null ? null : qrCodeUrl.trim();
    }

    public Integer getBusinessDistrictId() {
        return businessDistrictId;
    }

    public void setBusinessDistrictId(Integer businessDistrictId) {
        this.businessDistrictId = businessDistrictId;
    }

    public Integer getIsCooperation() {
        return isCooperation;
    }

    public void setIsCooperation(Integer isCooperation) {
        this.isCooperation = isCooperation;
    }

    public String getLng() {
        return lng;
    }

    public void setLng(String lng) {
        this.lng = lng == null ? null : lng.trim();
    }

    public String getLat() {
        return lat;
    }

    public void setLat(String lat) {
        this.lat = lat == null ? null : lat.trim();
    }

    public String getCreateTime() {
        return createTime;
    }

    public void setCreateTime(String createTime) {
        this.createTime = createTime == null ? null : createTime.trim();
    }

    public Integer getYpBaseCategoryId() {
        return ypBaseCategoryId;
    }

    public void setYpBaseCategoryId(Integer ypBaseCategoryId) {
        this.ypBaseCategoryId = ypBaseCategoryId;
    }

    public String getSite() {
        return site;
    }

    public void setSite(String site) {
        this.site = site == null ? null : site.trim();
    }
}