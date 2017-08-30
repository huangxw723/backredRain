package com.aoshi.domain;

import java.util.List;
import java.util.Map;

public class AsBusinessModule {
    private Integer businessModuleId;

    private Integer businessTemplateId;

    private String backgroundImage;

    private Integer position;

    private String userId;

    private Integer status;

    private String createTime;

    private Integer type;


    private Integer parentModuleId;

    private String content;
    private Map<String,Object> template;
    List<AsBusinessModule> children;
	private AsModuleInvestment investMent;
	private AsModuleShop shop;
	
    public Integer getBusinessModuleId() {
        return businessModuleId;
    }

    public void setBusinessModuleId(Integer businessModuleId) {
        this.businessModuleId = businessModuleId;
    }

    public Integer getBusinessTemplateId() {
        return businessTemplateId;
    }

    public void setBusinessTemplateId(Integer businessTemplateId) {
        this.businessTemplateId = businessTemplateId;
    }

    public String getBackgroundImage() {
        return backgroundImage;
    }

    public void setBackgroundImage(String backgroundImage) {
        this.backgroundImage = backgroundImage == null ? null : backgroundImage.trim();
    }

    public Integer getPosition() {
        return position;
    }

    public void setPosition(Integer position) {
        this.position = position;
    }

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId == null ? null : userId.trim();
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

    public Integer getType() {
        return type;
    }

    public void setType(Integer type) {
        this.type = type;
    }


    public Integer getParentModuleId() {
        return parentModuleId;
    }

    public void setParentModuleId(Integer parentModuleId) {
        this.parentModuleId = parentModuleId;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content == null ? null : content.trim();
    }

	public Map<String, Object> getTemplate() {
		return template;
	}

	public void setTemplate(Map<String, Object> template) {
		this.template = template;
	}

	public List<AsBusinessModule> getChildren() {
		return children;
	}

	public void setChildren(List<AsBusinessModule> children) {
		this.children = children;
	}

	public AsModuleInvestment getInvestMent() {
		return investMent;
	}

	public void setInvestMent(AsModuleInvestment investMent) {
		this.investMent = investMent;
	}

	public AsModuleShop getShop() {
		return shop;
	}

	public void setShop(AsModuleShop shop) {
		this.shop = shop;
	}
    
}