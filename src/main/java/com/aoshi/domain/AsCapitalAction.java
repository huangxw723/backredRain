package com.aoshi.domain;

public class AsCapitalAction {
    private Integer capitalActionId;

    private Integer capitalId;

    private Integer status;

    private String errorCode;

    private String errorMsg;

    private String createTime;

    public Integer getCapitalActionId() {
        return capitalActionId;
    }

    public void setCapitalActionId(Integer capitalActionId) {
        this.capitalActionId = capitalActionId;
    }

    public Integer getCapitalId() {
        return capitalId;
    }

    public void setCapitalId(Integer capitalId) {
        this.capitalId = capitalId;
    }

    public Integer getStatus() {
        return status;
    }

    public void setStatus(Integer status) {
        this.status = status;
    }

    public String getErrorCode() {
        return errorCode;
    }

    public void setErrorCode(String errorCode) {
        this.errorCode = errorCode == null ? null : errorCode.trim();
    }

    public String getErrorMsg() {
        return errorMsg;
    }

    public void setErrorMsg(String errorMsg) {
        this.errorMsg = errorMsg == null ? null : errorMsg.trim();
    }

    public String getCreateTime() {
        return createTime;
    }

    public void setCreateTime(String createTime) {
        this.createTime = createTime == null ? null : createTime.trim();
    }
}