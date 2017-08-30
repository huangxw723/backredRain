package com.aoshi.domain;

public class AsConsultationSpecialty {
    private Integer consultationSpecialtyId;

    private Integer typeId;

    private Integer provinceId;

    private Integer cityId;

    private Integer areaId;

    private String consultationDesc;

    private String name;

    private String coverImg;

    private Integer visitCount;

    private String publicTime;

    private Integer status;
    
    private AsProvince province;
    
    private AsCity city;

    private AsArea area;

    private AsConsultationType asConsultationType;

    
    
    public AsProvince getProvince() {
		return province;
	}

	public void setProvince(AsProvince province) {
		this.province = province;
	}

	public AsCity getCity() {
		return city;
	}

	public void setCity(AsCity city) {
		this.city = city;
	}

	public AsArea getArea() {
		return area;
	}

	public void setArea(AsArea area) {
		this.area = area;
	}


	public AsConsultationType getAsConsultationType() {
		return asConsultationType;
	}

	public void setAsConsultationType(AsConsultationType asConsultationType) {
		this.asConsultationType = asConsultationType;
	}

	public Integer getConsultationSpecialtyId() {
        return consultationSpecialtyId;
    }

    public void setConsultationSpecialtyId(Integer consultationSpecialtyId) {
        this.consultationSpecialtyId = consultationSpecialtyId;
    }

    public Integer getTypeId() {
        return typeId;
    }

    public void setTypeId(Integer typeId) {
        this.typeId = typeId;
    }

    public Integer getProvinceId() {
        return provinceId;
    }

    public void setProvinceId(Integer provinceId) {
        this.provinceId = provinceId;
    }

    public Integer getCityId() {
        return cityId;
    }

    public void setCityId(Integer cityId) {
        this.cityId = cityId;
    }

    public Integer getAreaId() {
        return areaId;
    }

    public void setAreaId(Integer areaId) {
        this.areaId = areaId;
    }

    public String getConsultationDesc() {
        return consultationDesc;
    }

    public void setConsultationDesc(String consultationDesc) {
        this.consultationDesc = consultationDesc == null ? null : consultationDesc.trim();
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name == null ? null : name.trim();
    }

    public String getCoverImg() {
        return coverImg;
    }

    public void setCoverImg(String coverImg) {
        this.coverImg = coverImg == null ? null : coverImg.trim();
    }

    public Integer getVisitCount() {
        return visitCount;
    }

    public void setVisitCount(Integer visitCount) {
        this.visitCount = visitCount;
    }

    public String getPublicTime() {
        return publicTime;
    }

    public void setPublicTime(String publicTime) {
        this.publicTime = publicTime == null ? null : publicTime.trim();
    }

    public Integer getStatus() {
        return status;
    }

    public void setStatus(Integer status) {
        this.status = status;
    }
}