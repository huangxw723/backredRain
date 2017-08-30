package com.aoshi.domain;

public class AsActivityReceivedRecord {
    private Integer activityReceivedRecordId;

    private Integer prizeId;

    private Integer type;

    private String createTime;

    private Integer userId;

	private Integer storeId;

	private Integer shopId;
	
	private Integer staffId;

    public Integer getStaffId() {
		return staffId;
	}

	public void setStaffId(Integer staffId) {
		this.staffId = staffId;
	}

	public Integer getActivityReceivedRecordId() {
        return activityReceivedRecordId;
    }

    public void setActivityReceivedRecordId(Integer activityReceivedRecordId) {
        this.activityReceivedRecordId = activityReceivedRecordId;
    }

    public Integer getPrizeId() {
        return prizeId;
    }

    public void setPrizeId(Integer prizeId) {
        this.prizeId = prizeId;
    }

    public Integer getType() {
        return type;
    }

    public void setType(Integer type) {
        this.type = type;
    }

    public String getCreateTime() {
        return createTime;
    }

    public void setCreateTime(String createTime) {
        this.createTime = createTime == null ? null : createTime.trim();
    }

    public Integer getUserId() {
        return userId;
    }

    public void setUserId(Integer userId) {
        this.userId = userId;
    }

	public Integer getStoreId() {
		return storeId;
	}

	public void setStoreId(Integer storeId) {
		this.storeId = storeId;
	}

	public Integer getShopId() {
		return shopId;
	}

	public void setShopId(Integer shopId) {
		this.shopId = shopId;
	}

}