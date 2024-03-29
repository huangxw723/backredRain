package com.aoshi.entity.system;

import com.aoshi.entity.Page;

/**
 * 
 * 类名称：User.java 类描述：
 * 
 * @author FH 作者单位： 联系方式： 创建时间：2014年6月28日
 * @version 1.0
 */
public class User {
	private String USER_ID; // 用户id
	private String USERNAME; // 用户名
	private String PASSWORD; // 密码
	private String NAME; // 姓名
	private String RIGHTS; // 权限
	private String ROLE_ID; // 角色id
	private String LAST_LOGIN; // 最后登录时间
	private String IP; // 用户登录ip地址
	private String STATUS; // 状态
	private Role role; // 角色对象
	private Page page; // 分页对象
	private String newUserId; // 红包雨as_user表ID
	
	public String getNewUserId() {
		return newUserId;
	}

	public void setNewUserId(String newUserId) {
		this.newUserId = newUserId;
	}

	private String create_by;// 创建人id
	
	public String getShopId() {
		return as_shop_id;
	}

	public void setShopId(String shopId) {
		this.as_shop_id = shopId;
	}

	public String getUserId() {
		return as_user_id;
	}

	public void setUserId(String userId) {
		this.as_user_id = userId;
	}

	private String SKIN; // 皮肤
	private String as_user_id; // 用户id
	private String as_shop_id; // 商场店铺id
	private String shopId;
	private String userId;

	public String getSKIN() {
		return SKIN;
	}

	public void setSKIN(String sKIN) {
		SKIN = sKIN;
	}

	public String getUSER_ID() {
		return USER_ID;
	}

	public void setUSER_ID(String uSER_ID) {
		USER_ID = uSER_ID;
	}

	public String getUSERNAME() {
		return USERNAME;
	}

	public void setUSERNAME(String uSERNAME) {
		USERNAME = uSERNAME;
	}

	public String getPASSWORD() {
		return PASSWORD;
	}

	public void setPASSWORD(String pASSWORD) {
		PASSWORD = pASSWORD;
	}

	public String getNAME() {
		return NAME;
	}

	public void setNAME(String nAME) {
		NAME = nAME;
	}

	public String getRIGHTS() {
		return RIGHTS;
	}

	public void setRIGHTS(String rIGHTS) {
		RIGHTS = rIGHTS;
	}

	public String getROLE_ID() {
		return ROLE_ID;
	}

	public void setROLE_ID(String rOLE_ID) {
		ROLE_ID = rOLE_ID;
	}

	public String getLAST_LOGIN() {
		return LAST_LOGIN;
	}

	public void setLAST_LOGIN(String lAST_LOGIN) {
		LAST_LOGIN = lAST_LOGIN;
	}

	public String getIP() {
		return IP;
	}

	public void setIP(String iP) {
		IP = iP;
	}

	public String getSTATUS() {
		return STATUS;
	}

	public void setSTATUS(String sTATUS) {
		STATUS = sTATUS;
	}

	public Role getRole() {
		return role;
	}

	public void setRole(Role role) {
		this.role = role;
	}

	public Page getPage() {
		if (page == null)
			page = new Page();
		return page;
	}

	public void setPage(Page page) {
		this.page = page;
	}

	public String getAs_user_id() {
		return as_user_id;
	}

	public void setAs_user_id(String as_user_id) {
		this.as_user_id = as_user_id;
	}

	public String getAs_shop_id() {
		return as_shop_id;
	}

	public void setAs_shop_id(String as_shop_id) {
		this.as_shop_id = as_shop_id;
	}

	public String getCreate_by() {
		return create_by;
	}

	public void setCreate_by(String create_by) {
		this.create_by = create_by;
	}
	
}
