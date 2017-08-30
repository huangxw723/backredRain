package com.aoshi.domain;

import java.math.BigDecimal;

public class AsActivityShake {
    private Integer activityShakeId;

    private Integer storeId;

    private String name;

    private BigDecimal probability;

    private String createTime;
    
    private String count;
    
    public String getCount() {
		return count;
	}

	public void setCount(String count) {
		this.count = count;
	}

	public Integer getActivityShakeId() {
        return activityShakeId;
    }

    public void setActivityShakeId(Integer activityShakeId) {
        this.activityShakeId = activityShakeId;
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

    public BigDecimal getProbability() {
        return probability;
    }

    public void setProbability(BigDecimal probability) {
        this.probability = probability;
    }

    public String getCreateTime() {
        return createTime;
    }

    public void setCreateTime(String createTime) {
        this.createTime = createTime == null ? null : createTime.trim();
    }
}