package com.aoshi.dao;

import org.apache.ibatis.annotations.Param;

import com.aoshi.domain.AsArea;
import com.aoshi.domain.AsBusinessDistrict;
import com.aoshi.domain.AsCity;
import com.aoshi.domain.AsConsultationType;
import com.aoshi.domain.AsProvince;
import com.aoshi.domain.AsYpBaseCategory;

public interface  ExcelMapper extends AsBaseMapper {

	AsConsultationType queryTypeId(@Param("type")String type);

	AsProvince queryProvinceId(@Param("province")String province);

	AsCity queryCityId(@Param("city")String city);

	AsArea queryAreaId(@Param("area")String area);

	AsBusinessDistrict queryBusId(@Param("bus")String bus,@Param("id")Integer id);

	AsYpBaseCategory queryYpId(@Param("yp")String yp);

}
