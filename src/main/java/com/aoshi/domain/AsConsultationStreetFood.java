package com.aoshi.domain;

public class AsConsultationStreetFood {
    private Integer consultationStreetFoodId;

    private Integer consultationShopId;

    private String foodImg;

    private String foodName;

    private String foodContent;

    public Integer getConsultationStreetFoodId() {
        return consultationStreetFoodId;
    }

    public void setConsultationStreetFoodId(Integer consultationStreetFoodId) {
        this.consultationStreetFoodId = consultationStreetFoodId;
    }

    public Integer getConsultationShopId() {
        return consultationShopId;
    }

    public void setConsultationShopId(Integer consultationShopId) {
        this.consultationShopId = consultationShopId;
    }

    public String getFoodImg() {
        return foodImg;
    }

    public void setFoodImg(String foodImg) {
        this.foodImg = foodImg == null ? null : foodImg.trim();
    }

    public String getFoodName() {
        return foodName;
    }

    public void setFoodName(String foodName) {
        this.foodName = foodName == null ? null : foodName.trim();
    }

    public String getFoodContent() {
        return foodContent;
    }

    public void setFoodContent(String foodContent) {
        this.foodContent = foodContent == null ? null : foodContent.trim();
    }
}