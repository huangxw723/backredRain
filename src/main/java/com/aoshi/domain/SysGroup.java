package com.aoshi.domain;

import java.util.List;

public class SysGroup {

	private String groupId;

    private String groupName;

    private String parentId;
    
    private boolean open = true;
    private List<SysGroup> children;
    
    public String getGroupId() {
        return groupId;
    }

    public void setGroupId(String groupId) {
        this.groupId = groupId == null ? null : groupId.trim();
    }

    public String getGroupName() {
        return groupName;
    }

    public void setGroupName(String groupName) {
        this.groupName = groupName == null ? null : groupName.trim();
    }

    public String getParentId() {
        return parentId;
    }

    public void setParentId(String parentId) {
        this.parentId = parentId == null ? null : parentId.trim();
    }

	public List<SysGroup> getChildren() {
		return children;
	}

	public void setChildren(List<SysGroup> children) {
		this.children = children;
	}

	public boolean isOpen() {
		return open;
	}

	public void setOpen(boolean open) {
		this.open = open;
	}

    
}