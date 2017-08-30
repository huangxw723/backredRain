package com.aoshi.common.asenum;

/**
 * 分类表枚举
 * 
 * @author yangyanchao
 * @date 2016年10月26日
 */
public enum BaseCategoryTypeEnum {
	
	YP_SHOP_TYPE(1, "云屏-行业分类"), YP_SERVICE_TYPE(2, "云屏-服务内容分类"), REDRAIN_PRIZE_TYPE(
			3, "红包雨-礼品类型"), REDRAIN_COUPON_TYPE(4, "红包雨-优惠卷类型")
	;

	private int id;
	private String remark;

	private BaseCategoryTypeEnum(int id, String remark) {
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
