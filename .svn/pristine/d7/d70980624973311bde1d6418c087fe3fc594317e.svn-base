package com.aoshi.dao;

import com.aoshi.domain.AsConsultationImgs;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import java.util.List;

public interface AsConsultationImgsMapper {
    int deleteByPrimaryKey(Integer consultationImgsId);

    int insert(AsConsultationImgs record);

    int insertSelective(AsConsultationImgs record);

    AsConsultationImgs selectByPrimaryKey(Integer consultationImgsId);

    int updateByPrimaryKeySelective(AsConsultationImgs record);

    int updateByPrimaryKey(AsConsultationImgs record);

    int deleteByConsultationId(@Param("consultationId")Integer consultationId,@Param("typeId")Integer typeId);

    int deleteByIds(@Param("conditions")String[] conditions,@Param("typeId")Integer typeId);

    //多图片2
    @Select("SELECT * FROM as_consultation_imgs WHERE consultation_id =#{id} AND type_id =#{typeId} ")
    public List<AsConsultationImgs> queryImgsById(@Param("id")Integer id, @Param("typeId")Integer typeId);

    public List<Integer> queryTypeId(String id);
}