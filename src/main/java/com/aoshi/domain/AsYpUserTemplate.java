package com.aoshi.domain;

import java.util.List;

public class AsYpUserTemplate {
    private Integer userTemplateId;

    private String name;

    private Integer templateId;

    private Integer userId;

    private Integer status;

    private Integer isHome;

    private Integer parentUserModuleId;

    private Integer parentUserTemplateId;

    private Integer rootUserTemplateId;

    private Integer isBusiness;

    private String createTime;
    
    private String path;
    
    private String preview;
    public String getPreview() {
		return preview;
	}

	public void setPreview(String preview) {
		this.preview = preview;
	}

	//ztree属性
    List<AsYpUserTemplate> children;
    private boolean checked;
    private boolean open = true;
    private boolean chkDisabled = true;

    public Integer getUserTemplateId() {
        return userTemplateId;
    }

    public void setUserTemplateId(Integer userTemplateId) {
        this.userTemplateId = userTemplateId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name == null ? null : name.trim();
    }

    public Integer getTemplateId() {
        return templateId;
    }

    public void setTemplateId(Integer templateId) {
        this.templateId = templateId;
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

    public Integer getIsHome() {
        return isHome;
    }

    public void setIsHome(Integer isHome) {
        this.isHome = isHome;
    }

    public Integer getParentUserModuleId() {
        return parentUserModuleId;
    }

    public void setParentUserModuleId(Integer parentUserModuleId) {
        this.parentUserModuleId = parentUserModuleId;
    }

    public Integer getParentUserTemplateId() {
        return parentUserTemplateId;
    }

    public void setParentUserTemplateId(Integer parentUserTemplateId) {
        this.parentUserTemplateId = parentUserTemplateId;
    }

    public Integer getRootUserTemplateId() {
        return rootUserTemplateId;
    }

    public void setRootUserTemplateId(Integer rootUserTemplateId) {
        this.rootUserTemplateId = rootUserTemplateId;
    }

    public Integer getIsBusiness() {
        return isBusiness;
    }

    public void setIsBusiness(Integer isBusiness) {
        this.isBusiness = isBusiness;
    }

    public String getCreateTime() {
        return createTime;
    }

    public void setCreateTime(String createTime) {
        this.createTime = createTime == null ? null : createTime.trim();
    }

    public String getPath() {
        return path;
    }

    public void setPath(String path) {
        this.path = path == null ? null : path.trim();
    }

	public List<AsYpUserTemplate> getChildren() {
		return children;
	}

	public void setChildren(List<AsYpUserTemplate> children) {
		this.children = children;
	}

	public boolean isChecked() {
		return checked;
	}

	public void setChecked(boolean checked) {
		this.checked = checked;
	}

	public boolean isOpen() {
		return open;
	}

	public void setOpen(boolean open) {
		this.open = open;
	}

	public boolean isChkDisabled() {
		return chkDisabled;
	}

	public void setChkDisabled(boolean chkDisabled) {
		this.chkDisabled = chkDisabled;
	}
	
    
    
}