package com.aoshi.domain;

public class AsShopOwnerInfo {
    private Integer shopOwnerInfoId;

    private Integer userId;

    private Integer status;

    private Integer shopId;

    private String name;

    private Integer screenDomainId;

    private String createTime;

    private String tel;

    private String email;

    private String applicant;

    private Integer applicantCertificateType;

    private String applicantCertificateNum;

    private String corporation;

    private Integer corporationCertificateType;

    private String corporationCertificateNum;

    private String identityFront;

    private String identityBack;

    private String businessLicence;

    private String businessCertificate;

    private Integer auditStatus;

    private String auditTime;

    private String reason;

    public Integer getShopOwnerInfoId() {
        return shopOwnerInfoId;
    }

    public void setShopOwnerInfoId(Integer shopOwnerInfoId) {
        this.shopOwnerInfoId = shopOwnerInfoId;
    }

    public Integer getUserId() {
        return userId;
    }

    public void setUserId(Integer userId) {
        this.userId = userId;
    }

    public Integer getStatus() {
        return status;
    }

    public void setStatus(Integer status) {
        this.status = status;
    }

    public Integer getShopId() {
        return shopId;
    }

    public void setShopId(Integer shopId) {
        this.shopId = shopId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name == null ? null : name.trim();
    }

    public Integer getScreenDomainId() {
        return screenDomainId;
    }

    public void setScreenDomainId(Integer screenDomainId) {
        this.screenDomainId = screenDomainId;
    }

    public String getCreateTime() {
        return createTime;
    }

    public void setCreateTime(String createTime) {
        this.createTime = createTime == null ? null : createTime.trim();
    }

    public String getTel() {
        return tel;
    }

    public void setTel(String tel) {
        this.tel = tel == null ? null : tel.trim();
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email == null ? null : email.trim();
    }

    public String getApplicant() {
        return applicant;
    }

    public void setApplicant(String applicant) {
        this.applicant = applicant == null ? null : applicant.trim();
    }

    public Integer getApplicantCertificateType() {
        return applicantCertificateType;
    }

    public void setApplicantCertificateType(Integer applicantCertificateType) {
        this.applicantCertificateType = applicantCertificateType;
    }

    public String getApplicantCertificateNum() {
        return applicantCertificateNum;
    }

    public void setApplicantCertificateNum(String applicantCertificateNum) {
        this.applicantCertificateNum = applicantCertificateNum == null ? null : applicantCertificateNum.trim();
    }

    public String getCorporation() {
        return corporation;
    }

    public void setCorporation(String corporation) {
        this.corporation = corporation == null ? null : corporation.trim();
    }

    public Integer getCorporationCertificateType() {
        return corporationCertificateType;
    }

    public void setCorporationCertificateType(Integer corporationCertificateType) {
        this.corporationCertificateType = corporationCertificateType;
    }

    public String getCorporationCertificateNum() {
        return corporationCertificateNum;
    }

    public void setCorporationCertificateNum(String corporationCertificateNum) {
        this.corporationCertificateNum = corporationCertificateNum == null ? null : corporationCertificateNum.trim();
    }

    public String getIdentityFront() {
        return identityFront;
    }

    public void setIdentityFront(String identityFront) {
        this.identityFront = identityFront == null ? null : identityFront.trim();
    }

    public String getIdentityBack() {
        return identityBack;
    }

    public void setIdentityBack(String identityBack) {
        this.identityBack = identityBack == null ? null : identityBack.trim();
    }

    public String getBusinessLicence() {
        return businessLicence;
    }

    public void setBusinessLicence(String businessLicence) {
        this.businessLicence = businessLicence == null ? null : businessLicence.trim();
    }

    public String getBusinessCertificate() {
        return businessCertificate;
    }

    public void setBusinessCertificate(String businessCertificate) {
        this.businessCertificate = businessCertificate == null ? null : businessCertificate.trim();
    }

    public Integer getAuditStatus() {
        return auditStatus;
    }

    public void setAuditStatus(Integer auditStatus) {
        this.auditStatus = auditStatus;
    }

    public String getAuditTime() {
        return auditTime;
    }

    public void setAuditTime(String auditTime) {
        this.auditTime = auditTime == null ? null : auditTime.trim();
    }

    public String getReason() {
        return reason;
    }

    public void setReason(String reason) {
        this.reason = reason == null ? null : reason.trim();
    }
}