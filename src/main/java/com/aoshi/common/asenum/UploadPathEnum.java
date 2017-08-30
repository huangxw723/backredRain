package com.aoshi.common.asenum;

import com.aoshi.util.Const;

public enum UploadPathEnum {

	USERS(1, Const.FILEPATHIMGDIR, Const.USERFILEPATHIMG, "用户"), SHOP(2,
			Const.FILEPATHIMGDIR, Const.SHOPFILEPATHIMG, "店铺"),ACTIVITY(3,
					Const.FILEPATHIMGDIR, Const.ACTIVITYFILEPATHIMG, "优惠券"),BRAND(4,Const.FILEPATHIMGDIR,Const.LOGOFILEPATHIMG,"品牌logo"),
					SHOPQRCODEURL(5,Const.FILEPATHIMGDIR, Const.SHOPQRCODEFILEPATHIMG, "商户二维码图"),SHOPMAINPICURL(6,Const.FILEPATHIMGDIR, Const.SHOPMAINPICFILEPATHIMG, "商户背景主图"),
					ACTIVITYMEETING(7,Const.FILEPATHIMGDIR, Const.ACTIVITYFILEPATHIMG, "明星见面会宣传图"),ACTIVITYREDRAIN(8,Const.FILEPATHIMGDIR, Const.ACTIVITYFILEPATHIMG, "红包雨宣传图"),
					ACTIVITYREDIMG(9,Const.FILEPATHIMGDIR, Const.ACTIVITYFILEPATHIMG, "明星见面会宣传图"),EVENTIMG(10,Const.FILEPATHIMGDIR,Const.EVENTFILEPATHIMG,"商户活动Logo");
	

	private int id;
	private String rootPath;
	private String path;
	private String remark;

	private UploadPathEnum(int id, String rootPath, String path, String remark) {
		this.id = id;
		this.path = path;
		this.rootPath = rootPath;
		this.remark = remark;
	}

	public String getRootPath() {
		return rootPath;
	}

	public void setRootPath(String rootPath) {
		this.rootPath = rootPath;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getPath() {
		return path;
	}

	public void setPath(String path) {
		this.path = path;
	}

	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

	public static UploadPathEnum get(int id) {

		UploadPathEnum targetEnum = null;
		UploadPathEnum[] enums = UploadPathEnum.values();
		for (UploadPathEnum theEnum : enums) {

			if (id == theEnum.getId()) {
				targetEnum = theEnum;
				break;
			}
		}

		return targetEnum;
	}
}
