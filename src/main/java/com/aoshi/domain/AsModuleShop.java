package com.aoshi.domain;

public class AsModuleShop {
    private Integer moduleShopId;

    private String shopImage;

    private String imgUrl;

    private String shopLogo;

    private String shopName;

    private String location;

    private String navigationId;

    private Integer businessModuleId;

    private String major;

    public Integer getModuleShopId() {
        return moduleShopId;
    }

    public void setModuleShopId(Integer moduleShopId) {
        this.moduleShopId = moduleShopId;
    }

    public String getShopImage() {
        return shopImage;
    }

    public void setShopImage(String shopImage) {
        this.shopImage = shopImage == null ? null : shopImage.trim();
    }

    public String getImgUrl() {
        return imgUrl;
    }

    public void setImgUrl(String imgUrl) {
        this.imgUrl = imgUrl == null ? null : imgUrl.trim();
    }

    public String getShopLogo() {
        return shopLogo;
    }

    public void setShopLogo(String shopLogo) {
        this.shopLogo = shopLogo == null ? null : shopLogo.trim();
    }

    public String getShopName() {
        return shopName;
    }

    public void setShopName(String shopName) {
        this.shopName = shopName == null ? null : shopName.trim();
    }

    public String getLocation() {
        return location;
    }

    public void setLocation(String location) {
        this.location = location == null ? null : location.trim();
    }

    public String getNavigationId() {
        return navigationId;
    }

    public void setNavigationId(String navigationId) {
        this.navigationId = navigationId == null ? null : navigationId.trim();
    }

    public Integer getBusinessModuleId() {
        return businessModuleId;
    }

    public void setBusinessModuleId(Integer businessModuleId) {
        this.businessModuleId = businessModuleId;
    }

    public String getMajor() {
        return major;
    }

    public void setMajor(String major) {
        this.major = major == null ? null : major.trim();
    }
}