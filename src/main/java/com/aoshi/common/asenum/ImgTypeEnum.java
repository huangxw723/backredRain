package com.aoshi.common.asenum;



/**
 * 常用操作枚举
 * 
 * @author yangyanchao
 * @date 2016年7月8日
 */
public enum ImgTypeEnum {

	USERS("USERS", "用户"), 
	SHOP("SHOP", "店铺"),
	ACTIVITY("ACTIVITY", "优惠券"),
	BRAND("BRAND","品牌logo"),
	SHOPQRCODEURL("SHOPQRCODEURL", "商户二维码图"),
	SHOPMAINPICURL("SHOPMAINPICURL", "商户背景主图"),
	ACTIVITYMEETING("ACTIVITYMEETING", "明星见面会宣传图"),
	ACTIVITYREDRAIN("ACTIVITYMEETING", "红包雨宣传图"),
	ACTIVITYREDIMG("ACTIVITYREDIMG", "明星见面会宣传图"),
	EVENTIMG("EVENTIMG","商户活动Logo"),
	SHOP_IDENTITY_FRONT("SHOP_IDENTITY_FRONT","证件照正面"),
	SHOP_IDENTITY_BACK("SHOP_IDENTITY_BACK","证件照反面"),
	SHOP_BUSINESS_LICENCE("SHOP_BUSINESS_LICENCE","营业执照");
  
	private String typeName;

	ImgTypeEnum(String typeName, String desc) {
		this.typeName = typeName;
	}

	/**
	 * 根据类型的名称，返回类型的枚举实例。
	 * 
	 * @param typeName
	 *            类型名称
	 */
	public static ImgTypeEnum fromTypeName(String typeName) {
		for (ImgTypeEnum type : ImgTypeEnum.values()) {
			if (type.getTypeName().equals(typeName)) {
				return type;
			}
		}
		return null;
	}

	public String getTypeName() {
		return this.typeName;
	}

	
}
