package com.aoshi.domain;

import java.util.Map;

public class AsYpUserModule {
    private Integer userModuleId;

    private Integer userTemplateId;

    private Integer moduleId;

    private String icon;

    private Integer serviceTypeId;

    private Integer type;

    private Integer position;

    private Integer isSysDefault;

    private Integer userId;

    private Integer status;

    private String createTime;
    
    private String content;

    private String dynamicValue;
    
    private Map<String,Object> template;
    
    public Integer getUserModuleId() {
        return userModuleId;
    }

    public void setUserModuleId(Integer userModuleId) {
        this.userModuleId = userModuleId;
    }

    public Integer getUserTemplateId() {
        return userTemplateId;
    }

    public void setUserTemplateId(Integer userTemplateId) {
        this.userTemplateId = userTemplateId;
    }

    public Integer getModuleId() {
        return moduleId;
    }

    public void setModuleId(Integer moduleId) {
        this.moduleId = moduleId;
    }

    public String getIcon() {
        return icon;
    }

    public void setIcon(String icon) {
        this.icon = icon == null ? null : icon.trim();
    }

    public Integer getServiceTypeId() {
        return serviceTypeId;
    }

    public void setServiceTypeId(Integer serviceTypeId) {
        this.serviceTypeId = serviceTypeId;
    }

    public Integer getType() {
        return type;
    }

    public void setType(Integer type) {
        this.type = type;
    }

    public Integer getPosition() {
        return position;
    }

    public void setPosition(Integer position) {
        this.position = position;
    }

    public Integer getIsSysDefault() {
        return isSysDefault;
    }

    public void setIsSysDefault(Integer isSysDefault) {
        this.isSysDefault = isSysDefault;
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

    public String getCreateTime() {
        return createTime;
    }

    public void setCreateTime(String createTime) {
        this.createTime = createTime == null ? null : createTime.trim();
    }

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getDynamicValue() {
		return dynamicValue;
	}

	public void setDynamicValue(String dynamicValue) {
		this.dynamicValue = dynamicValue;
	}

	public Map<String, Object> getTemplate() {
		return template;
	}

	public void setTemplate(Map<String, Object> template) {
		this.template = template;
	}

	
    
    
}