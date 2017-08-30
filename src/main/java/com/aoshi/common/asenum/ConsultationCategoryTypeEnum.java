package com.aoshi.common.asenum;

/**
 * 咨询模块品类枚举
 * 
 * @author xjl
 * @date 2016年11月28日
 */
public enum ConsultationCategoryTypeEnum {

	DELICIOUS_FOOD_TYPE(6, "美食品类-品类管理"), SHOPPING_CLASSIFICATION_TYPE(7, "逛街分类-品类管理")
	,Marketing_CLASSIFICATION_TYPE(8, "商场分类-品类管理"),SHOP_CLASSIFICATION_TYPE(9, "店铺分类-品类管理")
	,DISHES_TYPE(10, "菜式分类-品类管理"),HOTEL_TYPE(11, "酒店品牌分类名称-品类管理");
	private int id;
	private String remark;

	private ConsultationCategoryTypeEnum(int id, String remark) {
		this.id = id;
		this.remark = remark;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}
}
