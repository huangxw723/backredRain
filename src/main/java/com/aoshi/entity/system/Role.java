package com.aoshi.entity.system;

/**
 * 
 * 类名称：Role.java 类描述：
 * 
 * @author FH 作者单位： 联系方式： 创建时间：2014年3月10日
 * @version 1.0
 */
public class Role {
	private String ROLE_ID;
	private String ROLE_NAME;
	private String RIGHTS;
	private String PARENT_ID;
	private String ADD_QX;
	private String DEL_QX;
	private String EDIT_QX;
	private String CHA_QX;
	private String QX_ID;
	// 创建该角色的用户
	private String create_by;
	// 是否超级管理员
	private int is_admin;
	
	//页面回显属性，不持久化
	private boolean checked;
	
	public String getQX_ID() {
		return QX_ID;
	}

	public void setQX_ID(String qX_ID) {
		QX_ID = qX_ID;
	}

	public String getROLE_ID() {
		return ROLE_ID;
	}

	public void setROLE_ID(String rOLE_ID) {
		ROLE_ID = rOLE_ID;
	}

	public String getROLE_NAME() {
		return ROLE_NAME;
	}

	public void setROLE_NAME(String rOLE_NAME) {
		ROLE_NAME = rOLE_NAME;
	}

	public String getRIGHTS() {
		return RIGHTS;
	}

	public void setRIGHTS(String rIGHTS) {
		RIGHTS = rIGHTS;
	}

	public String getPARENT_ID() {
		return PARENT_ID;
	}

	public void setPARENT_ID(String pARENT_ID) {
		PARENT_ID = pARENT_ID;
	}

	public String getADD_QX() {
		return ADD_QX;
	}

	public void setADD_QX(String aDD_QX) {
		ADD_QX = aDD_QX;
	}

	public String getDEL_QX() {
		return DEL_QX;
	}

	public void setDEL_QX(String dEL_QX) {
		DEL_QX = dEL_QX;
	}

	public String getEDIT_QX() {
		return EDIT_QX;
	}

	public void setEDIT_QX(String eDIT_QX) {
		EDIT_QX = eDIT_QX;
	}

	public String getCHA_QX() {
		return CHA_QX;
	}

	public void setCHA_QX(String cHA_QX) {
		CHA_QX = cHA_QX;
	}

	public String getCreate_by() {
		return create_by;
	}

	public void setCreate_by(String create_by) {
		this.create_by = create_by;
	}

	public int getIs_admin() {
		return is_admin;
	}

	public void setIs_admin(int is_admin) {
		this.is_admin = is_admin;
	}

	public boolean isChecked() {
		return checked;
	}

	public void setChecked(boolean checked) {
		this.checked = checked;
	}

	
}
