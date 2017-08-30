package com.aoshi.domain;

public class AsConsultationShop {
    private Integer consultationShopId;

    private Integer ypBaseCategoryId;

    private Integer provinceId;

    private Integer cityId;

    private Integer areaId;

    private String shopName;

    private String coverImg;

    private Integer visitCount;

    private Float suggestPrice;

    private String starLevel;

    private String createTime;

    private String motifyTime;

    private Integer status;

    private Integer businessDistrictId;

    private String address;

    private String phone;

    private String businessTime;

    private String bannerImg;

    private String lng;

    private String lat;

    private String site;

    private String name;

    private String areaName;

    private String districtName;

    private Integer shopTypeYpBaseCategoryId;

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getAreaName() {
        return areaName;
    }

    public void setAreaName(String areaName) {
        this.areaName = areaName;
    }

    public String getDistrictName() {
        return districtName;
    }

    public void setDistrictName(String districtName) {
        this.districtName = districtName;
    }
    public Integer getConsultationShopId() {
        return consultationShopId;
    }

    public void setConsultationShopId(Integer consultationShopId) {
        this.consultationShopId = consultationShopId;
    }

    public Integer getYpBaseCategoryId() {
        return ypBaseCategoryId;
    }

    public void setYpBaseCategoryId(Integer ypBaseCategoryId) {
        this.ypBaseCategoryId = ypBaseCategoryId;
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

    public String getShopName() {
        return shopName;
    }

    public void setShopName(String shopName) {
        this.shopName = shopName == null ? null : shopName.trim();
    }

    public String getCoverImg() {
        return coverImg;
    }

    public void setCoverImg(String coverImg) {
        this.coverImg = coverImg == null ? null : coverImg.trim();
    }

    public Integer getVisitCount() {
        return visitCount;
    }

    public void setVisitCount(Integer visitCount) {
        this.visitCount = visitCount;
    }

    public Float getSuggestPrice() {
        return suggestPrice;
    }

    public void setSuggestPrice(Float suggestPrice) {
        this.suggestPrice = suggestPrice;
    }

    public String getStarLevel() {
        return starLevel;
    }

    public void setStarLevel(String starLevel) {
        this.starLevel = starLevel;
    }

    public String getCreateTime() {
        return createTime;
    }

    public void setCreateTime(String createTime) {
        this.createTime = createTime == null ? null : createTime.trim();
    }

    public String getMotifyTime() {
        return motifyTime;
    }

    public void setMotifyTime(String motifyTime) {
        this.motifyTime = motifyTime == null ? null : motifyTime.trim();
    }

    public Integer getStatus() {
        return status;
    }

    public void setStatus(Integer status) {
        this.status = status;
    }

    public Integer getBusinessDistrictId() {
        return businessDistrictId;
    }

    public void setBusinessDistrictId(Integer businessDistrictId) {
        this.businessDistrictId = businessDistrictId;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address == null ? null : address.trim();
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone == null ? null : phone.trim();
    }

    public String getBusinessTime() {
        return businessTime;
    }

    public void setBusinessTime(String businessTime) {
        this.businessTime = businessTime == null ? null : businessTime.trim();
    }

    public String getBannerImg() {
        return bannerImg;
    }

    public void setBannerImg(String bannerImg) {
        this.bannerImg = bannerImg == null ? null : bannerImg.trim();
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

    public String getSite() {
        return site;
    }

    public void setSite(String site) {
        this.site = site == null ? null : site.trim();
    }

    public Integer getShopTypeYpBaseCategoryId() {
        return shopTypeYpBaseCategoryId;
    }

    public void setShopTypeYpBaseCategoryId(Integer shopTypeYpBaseCategoryId) {
        this.shopTypeYpBaseCategoryId = shopTypeYpBaseCategoryId;
    }
}