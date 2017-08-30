package com.aoshi.domain;

public class AsOwnActivityHistory {
    private Integer ownActivityHistoryId;

    private Integer userId;

    private Integer count;

    private Integer source;

    private String createTime;

    private String operator;

    private Integer operatorId;

    private Integer shopId;

    private Integer ownActivityId;

    public Integer getOwnActivityHistoryId() {
        return ownActivityHistoryId;
    }

    public void setOwnActivityHistoryId(Integer ownActivityHistoryId) {
        this.ownActivityHistoryId = ownActivityHistoryId;
    }

    public Integer getUserId() {
        return userId;
    }

    public void setUserId(Integer userId) {
        this.userId = userId;
    }

    public Integer getCount() {
        return count;
    }

    public void setCount(Integer count) {
        this.count = count;
    }

    public Integer getSource() {
        return source;
    }

    public void setSource(Integer source) {
        this.source = source;
    }

    public String getCreateTime() {
        return createTime;
    }

    public void setCreateTime(String createTime) {
        this.createTime = createTime == null ? null : createTime.trim();
    }

    public String getOperator() {
        return operator;
    }

    public void setOperator(String operator) {
        this.operator = operator == null ? null : operator.trim();
    }

    public Integer getOperatorId() {
        return operatorId;
    }

    public void setOperatorId(Integer operatorId) {
        this.operatorId = operatorId;
    }

    public Integer getShopId() {
        return shopId;
    }

    public void setShopId(Integer shopId) {
        this.shopId = shopId;
    }

    public Integer getOwnActivityId() {
        return ownActivityId;
    }

    public void setOwnActivityId(Integer ownActivityId) {
        this.ownActivityId = ownActivityId;
    }
}