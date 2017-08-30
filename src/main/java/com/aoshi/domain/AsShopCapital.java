package com.aoshi.domain;

import java.math.BigDecimal;

public class AsShopCapital {
	private Integer shopCapitalId;

	private Integer shopId;

	private Integer orderId;

	private BigDecimal capitalAmount;

	private Integer status;

	private Integer shopBankId;

	private String createTime;

	private String updateTime;

	private String shopName;

	public String getShopName() {
		return shopName;
	}

	public void setShopName(String shopName) {
		this.shopName = shopName;
	}

	public Integer getShopCapitalId() {
		return shopCapitalId;
	}

	public void setShopCapitalId(Integer shopCapitalId) {
		this.shopCapitalId = shopCapitalId;
	}

	public Integer getShopId() {
		return shopId;
	}

	public void setShopId(Integer shopId) {
		this.shopId = shopId;
	}

	public Integer getOrderId() {
		return orderId;
	}

	public void setOrderId(Integer orderId) {
		this.orderId = orderId;
	}

	public BigDecimal getCapitalAmount() {
		return capitalAmount;
	}

	public void setCapitalAmount(BigDecimal capitalAmount) {
		this.capitalAmount = capitalAmount;
	}

	public Integer getStatus() {
		return status;
	}

	public void setStatus(Integer status) {
		this.status = status;
	}

	public Integer getShopBankId() {
		return shopBankId;
	}

	public void setShopBankId(Integer shopBankId) {
		this.shopBankId = shopBankId;
	}

	public String getCreateTime() {
		return createTime;
	}

	public void setCreateTime(String createTime) {
		this.createTime = createTime == null ? null : createTime.trim();
	}

	public String getUpdateTime() {
		return updateTime;
	}

	public void setUpdateTime(String updateTime) {
		this.updateTime = updateTime == null ? null : updateTime.trim();
	}
}