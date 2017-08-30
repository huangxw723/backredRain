package com.aoshi.domain;

import java.math.BigDecimal;

public class AsPrizeConfig {
    private Integer prizeConfigId;

    private Integer categoryId;

    private Integer activityShakeId;

    private String name;

    private Integer isJackpot;

    private String logoUrl;

    private String backUrl;

    private Integer counts;

    private Integer surplusCounts;

    private String startTime;

    private String endTime;

    private String createTime;

    private Integer shopId;

    private Integer storeId;

    private String sn;

    private BigDecimal price;

    private Integer activityType;

    private Integer status;

    private Integer couponTagId;

    private Integer auditStatus;

    private String descp;

    private String reason;

    private String auditTime;

    private AsYpBaseCategory asYpBaseCategory;

    private String shopName;

    private String categoryName;

    private String probability;

    private String shakeName;
    private String activeTime;

    private String inactiveTime;

    public String getProbability() {
        return probability;
    }

    public void setProbability(String probability) {
        this.probability = probability;
    }

    public String getShakeName() {
        return shakeName;
    }

    public void setShakeName(String shakeName) {
        this.shakeName = shakeName;
    }

    public String getCategoryName() {
        return categoryName;
    }

    public void setCategoryName(String categoryName) {
        this.categoryName = categoryName;
    }


    public AsYpBaseCategory getAsYpBaseCategory() {
        return asYpBaseCategory;
    }

    public void setAsYpBaseCategory(AsYpBaseCategory asYpBaseCategory) {
        this.asYpBaseCategory = asYpBaseCategory;
    }

    public String getAuditTime() {
        return auditTime;
    }

    public void setAuditTime(String auditTime) {
        this.auditTime = auditTime;
    }

    public Integer getPrizeConfigId() {
        return prizeConfigId;
    }

    public void setPrizeConfigId(Integer prizeConfigId) {
        this.prizeConfigId = prizeConfigId;
    }

    public Integer getCategoryId() {
        return categoryId;
    }

    public void setCategoryId(Integer categoryId) {
        this.categoryId = categoryId;
    }

    public Integer getActivityShakeId() {
        return activityShakeId;
    }

    public void setActivityShakeId(Integer activityShakeId) {
        this.activityShakeId = activityShakeId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name == null ? null : name.trim();
    }

    public Integer getIsJackpot() {
        return isJackpot;
    }

    public void setIsJackpot(Integer isJackpot) {
        this.isJackpot = isJackpot;
    }

    public String getLogoUrl() {
        return logoUrl;
    }

    public void setLogoUrl(String logoUrl) {
        this.logoUrl = logoUrl == null ? null : logoUrl.trim();
    }

    public String getBackUrl() {
        return backUrl;
    }

    public void setBackUrl(String backUrl) {
        this.backUrl = backUrl == null ? null : backUrl.trim();
    }

    public Integer getCounts() {
        return counts;
    }

    public void setCounts(Integer counts) {
        this.counts = counts;
    }

    public Integer getSurplusCounts() {
        return surplusCounts;
    }

    public void setSurplusCounts(Integer surplusCounts) {
        this.surplusCounts = surplusCounts;
    }

    public String getStartTime() {
        return startTime;
    }

    public void setStartTime(String startTime) {
        this.startTime = startTime == null ? null : startTime.trim();
    }

    public String getEndTime() {
        return endTime;
    }

    public void setEndTime(String endTime) {
        this.endTime = endTime == null ? null : endTime.trim();
    }

    public Integer getShopId() {
        return shopId;
    }

    public void setShopId(Integer shopId) {
        this.shopId = shopId;
    }

    public Integer getStoreId() {
        return storeId;
    }

    public void setStoreId(Integer storeId) {
        this.storeId = storeId;
    }

    public String getSn() {
        return sn;
    }

    public void setSn(String sn) {
        this.sn = sn == null ? null : sn.trim();
    }

    public BigDecimal getPrice() {
        return price;
    }

    public void setPrice(BigDecimal price) {
        this.price = price;
    }

    public Integer getActivityType() {
        return activityType;
    }

    public void setActivityType(Integer activityType) {
        this.activityType = activityType;
    }

    public Integer getStatus() {
        return status;
    }

    public void setStatus(Integer status) {
        this.status = status;
    }


    public Integer getCouponTagId() {
        return couponTagId;
    }

    public void setCouponTagId(Integer couponTagId) {
        this.couponTagId = couponTagId;
    }

    public Integer getAuditStatus() {
        return auditStatus;
    }

    public void setAuditStatus(Integer auditStatus) {
        this.auditStatus = auditStatus;
    }

    public String getDescp() {
        return descp;
    }

    public void setDescp(String descp) {
        this.descp = descp == null ? null : descp.trim();
    }

    public String getCreateTime() {
        return createTime;
    }

    public void setCreateTime(String createTime) {
        this.createTime = createTime == null ? null : createTime.trim();
    }

    public String getReason() {
        return reason;
    }

    public void setReason(String reason) {
        this.reason = reason == null ? null : reason.trim();
    }

    public String getShopName() {
        return shopName;
    }

    public void setShopName(String shopName) {
        this.shopName = shopName;
    }

	public String getActiveTime() {
		return activeTime;
	}

	public void setActiveTime(String activeTime) {
		this.activeTime = activeTime;
	}

	public String getInactiveTime() {
		return inactiveTime;
	}

	public void setInactiveTime(String inactiveTime) {
		this.inactiveTime = inactiveTime;
	}
    
}