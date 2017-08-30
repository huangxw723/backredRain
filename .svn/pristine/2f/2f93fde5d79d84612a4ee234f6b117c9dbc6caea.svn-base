package com.aoshi.domain;

public class AsCity {
	private Integer cityId;

	private String cityName;

	private Integer provinceId;

	private AsProvince province = new AsProvince();

	public AsProvince getProvince() {
		return province;
	}

	public void setProvince(AsProvince province) {
		this.province = province;
	}

	public Integer getCityId() {
		return cityId;
	}

	public void setCityId(Integer cityId) {
		this.cityId = cityId;
	}

	public String getCityName() {
		return cityName;
	}

	public void setCityName(String cityName) {
		this.cityName = cityName == null ? null : cityName.trim();
	}

	public Integer getProvinceId() {
		return provinceId;
	}

	public void setProvinceId(Integer provinceId) {
		this.provinceId = provinceId;
	}

	@Override
	public String toString() {
		return "AsCity [cityId=" + cityId + ", cityName=" + cityName
				+ ", provinceId=" + provinceId + ", province=" + province + "]";
	}
	
}