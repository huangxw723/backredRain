package com.aoshi.domain;

public class AsConsultationImgs {
    private Integer consultationImgsId;

    private Integer typeId;

    private Integer consultationId;

    private String imgUrl;

    public Integer getConsultationImgsId() {
        return consultationImgsId;
    }

    public void setConsultationImgsId(Integer consultationImgsId) {
        this.consultationImgsId = consultationImgsId;
    }

    public Integer getTypeId() {
        return typeId;
    }

    public void setTypeId(Integer typeId) {
        this.typeId = typeId;
    }

    public Integer getConsultationId() {
        return consultationId;
    }

    public void setConsultationId(Integer consultationId) {
        this.consultationId = consultationId;
    }

    public String getImgUrl() {
        return imgUrl;
    }

    public void setImgUrl(String imgUrl) {
        this.imgUrl = imgUrl == null ? null : imgUrl.trim();
    }
}