package com.aoshi.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import com.aoshi.domain.AsConsultationType;
import com.aoshi.domain.AsYpBaseCategory;

public interface AsConsultationTypeMapper {
    int deleteByPrimaryKey(Integer consultationTypeId);

    int insert(AsConsultationType record);

    int insertSelective(AsConsultationType record);

    AsConsultationType selectByPrimaryKey(Integer consultationTypeId);

    int updateByPrimaryKeySelective(AsConsultationType record);

    int updateByPrimaryKey(AsConsultationType record);

	/**
	 * 查询全部状态下的资讯类型
	 * @param id
	 * @return
     */
	AsYpBaseCategory selectById(Integer id);
	@Select(value = "select * from as_consultation_type where consultationTypeId = #{consultationTypeId}")
	List<AsYpBaseCategory> selectCaterory(@Param(value="consultationTypeId")int consultationTypeId);

	@Select(value = "select * from as_consultation_type where type_level = #{typeLevel}")
	List<AsConsultationType> selectByLevel(@Param(value="typeLevel")int typeLevel);

	
	List<AsConsultationType> selectAll(AsConsultationType asConsultationType);

	/**
	 * 根据便民名称查询出对应consultation_type_id
	 * @param asConsultationType
	 * @return
	 */
	@Select("select * from as_consultation_type where parent_id in(select consultation_type_id from as_consultation_type where type_name=#{typeName})")
	List<AsConsultationType> selectByName(@Param(value="typeName")String typeName);
	
	
	@Select("select * from as_consultation_type where type_name=#{typeName}")
	List<AsConsultationType> findByName(@Param(value="typeName")String typeName);
  }