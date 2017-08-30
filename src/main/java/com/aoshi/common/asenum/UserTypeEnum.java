package com.aoshi.common.asenum;

/**
 * 帐号类型
 * 
 * @author yangyanchao
 * @date 2016年9月3日
 */
public enum UserTypeEnum {

	USER(0, "普通用户"), SELLER(1, "商家"), STAFF(2, "店员"), ADMIN(3, "后台管理员"), OPERATIONMANAGER(4, "运营管理员"),CURRENCY(5,"管理员");

	private int id;
	private String descp;

	private UserTypeEnum(int type, String descp) {
		this.id = type;
		this.descp = descp;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getDescp() {
		return descp;
	}

	public void setDescp(String descp) {
		this.descp = descp;
	}

	public static UserTypeEnum GET(int userType) {

		UserTypeEnum targetEnum = null;
		UserTypeEnum[] enums = UserTypeEnum.values();
		for (UserTypeEnum curEnum : enums) {

			if (curEnum.getId() == userType) {
				targetEnum = curEnum;
				break;
			}
		}

		return targetEnum;
	}
}
