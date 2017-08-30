package com.aoshi.domain;

public class AsActivityRedrain {
    private Integer activityRedrainId;

    private Integer activityId;

    private Integer activityCode;

    private String pageUrl;
    
    private String activityDetail;

    private String activityReview;
    
    private Integer activityStatus;

    public Integer getActivityRedrainId() {
        return activityRedrainId;
    }

    public void setActivityRedrainId(Integer activityRedrainId) {
        this.activityRedrainId = activityRedrainId;
    }

    public Integer getActivityId() {
        return activityId;
    }

    public void setActivityId(Integer activityId) {
        this.activityId = activityId;
    }

    public Integer getActivityCode() {
        return activityCode;
    }

    public void setActivityCode(Integer activityCode) {
        this.activityCode = activityCode;
    }

    public String getPageUrl() {
        return pageUrl;
    }

    public void setPageUrl(String pageUrl) {
        this.pageUrl = pageUrl == null ? null : pageUrl.trim();
    }

	public String getActivityDetail() {
		return activityDetail;
	}

	public void setActivityDetail(String activityDetail) {
		this.activityDetail = activityDetail;
	}

	public String getActivityReview() {
		return activityReview;
	}

	public void setActivityReview(String activityReview) {
		this.activityReview = activityReview;
	}

	public Integer getActivityStatus() {
		return activityStatus;
	}

	public void setActivityStatus(Integer activityStatus) {
		this.activityStatus = activityStatus;
	}
    
	
	
}