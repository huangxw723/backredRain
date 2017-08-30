package com.aoshi.common.asenum;

/**
 * 常用操作枚举
 * 
 * @author yangyanchao
 * @date 2016年7月8日
 */
public enum OperaEnum {

	ADD(1, "添加"), EDIT(2, "修改"), DELETE(3, "删除"), QUERY(4, "查看");

	private int id;
	private String remark;

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

	private OperaEnum(int id, String remark) {
		this.id = id;
		this.remark = remark;
	}

	public static OperaEnum get(int id) {

		OperaEnum targetEnum = null;
		OperaEnum[] enums = OperaEnum.values();
		for (OperaEnum theEnum : enums) {

			if (id == theEnum.getId()) {
				targetEnum = theEnum;
				break;
			}
		}

		return targetEnum;
	}
}
