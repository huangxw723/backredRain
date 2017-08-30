package com.aoshi.domain;

import java.math.BigDecimal;

public class AsAccountDynamic {
    private Integer accountDynamicId;

	private BigDecimal money;

    private Integer type;

    private String createTime;

    private Integer userId;

    private String descp;

    public Integer getAccountDynamicId() {
        return accountDynamicId;
    }

    public void setAccountDynamicId(Integer accountDynamicId) {
        this.accountDynamicId = accountDynamicId;
    }

	public BigDecimal getMoney() {
        return money;
    }

	public void setMoney(BigDecimal money) {
        this.money = money;
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

    public String getDescp() {
        return descp;
    }

    public void setDescp(String descp) {
        this.descp = descp == null ? null : descp.trim();
    }
}