package com.aoshi.domain;

public class AsActivityRedrainWinner {
    private Integer activityRedrainWinnerId;

    private Integer activityRedrainId;

    private String userName;

    private String prizeInfo;

    private String winTime;

    public Integer getActivityRedrainWinnerId() {
        return activityRedrainWinnerId;
    }

    public void setActivityRedrainWinnerId(Integer activityRedrainWinnerId) {
        this.activityRedrainWinnerId = activityRedrainWinnerId;
    }

    public Integer getActivityRedrainId() {
        return activityRedrainId;
    }

    public void setActivityRedrainId(Integer activityRedrainId) {
        this.activityRedrainId = activityRedrainId;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName == null ? null : userName.trim();
    }

    public String getPrizeInfo() {
        return prizeInfo;
    }

    public void setPrizeInfo(String prizeInfo) {
        this.prizeInfo = prizeInfo == null ? null : prizeInfo.trim();
    }

    public String getWinTime() {
        return winTime;
    }

    public void setWinTime(String winTime) {
        this.winTime = winTime == null ? null : winTime.trim();
    }
}