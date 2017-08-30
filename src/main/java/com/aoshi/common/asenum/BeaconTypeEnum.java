package com.aoshi.common.asenum;

/**
 * beacon组枚举
 * Created by xjl on 2017/3/9.
 */
public enum BeaconTypeEnum {

	OFF_USE(0, "禁用"), ON_USE(1, "启用");

	private int id;
	private String remark;

	private BeaconTypeEnum(int id, String remark) {
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
