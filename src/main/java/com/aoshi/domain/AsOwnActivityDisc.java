package com.aoshi.domain;

import java.math.BigDecimal;

public class AsOwnActivityDisc {
    private Integer ownActivityDiscId;

    private Integer ownActivityId;

    private BigDecimal probability;

    private Integer prizeConfigId;

    private String createTime;
    
    private AsPrizeConfig asPrizeConfig;
    
    

	public AsPrizeConfig getAsPrizeConfig() {
		return asPrizeConfig;
	}

	public void setAsPrizeConfig(AsPrizeConfig asPrizeConfig) {
		this.asPrizeConfig = asPrizeConfig;
	}

	public Integer getOwnActivityDiscId() {
        return ownActivityDiscId;
    }

    public void setOwnActivityDiscId(Integer ownActivityDiscId) {
        this.ownActivityDiscId = ownActivityDiscId;
    }

    public Integer getOwnActivityId() {
        return ownActivityId;
    }

    public void setOwnActivityId(Integer ownActivityId) {
        this.ownActivityId = ownActivityId;
    }

    public BigDecimal getProbability() {
        return probability;
    }

    public void setProbability(BigDecimal probability) {
        this.probability = probability;
    }

    public Integer getPrizeConfigId() {
        return prizeConfigId;
    }

    public void setPrizeConfigId(Integer prizeConfigId) {
        this.prizeConfigId = prizeConfigId;
    }

    public String getCreateTime() {
        return createTime;
    }

    public void setCreateTime(String createTime) {
        this.createTime = createTime == null ? null : createTime.trim();
    }
}